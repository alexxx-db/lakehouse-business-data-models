-- Metric views for domain: realestate | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic lease portfolio metrics covering financial obligations, rent economics, and lease term risk. Used by Real Estate VPs and CFOs to manage occupancy cost, renewal exposure, and liability on the balance sheet."
  source: "`vibe_restaurants_v1`.`realestate`.`lease`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (e.g. NNN, gross, modified gross) — drives cost structure and CAM exposure."
    - name: "lease_status"
      expr: lease_status
      comment: "Current lifecycle status of the lease (active, expired, terminated, in-negotiation)."
    - name: "accounting_classification"
      expr: accounting_classification
      comment: "IFRS 16 / ASC 842 classification (operating vs. finance lease) — affects balance sheet treatment."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Method of rent escalation (fixed %, CPI, stepped) — key for forecasting future rent obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease — used for multi-currency portfolio analysis."
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced — used for vintage cohort analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the lease expires — critical for renewal pipeline planning."
  measures:
    - name: "total_active_leases"
      expr: COUNT(1)
      comment: "Total number of lease records — baseline portfolio size metric for Real Estate leadership."
    - name: "total_base_rent_annual"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Sum of base rent amounts across all leases — primary occupancy cost driver for P&L and budget planning."
    - name: "avg_base_rent"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease — benchmarks rent levels across the portfolio."
    - name: "total_cam_charges_annual"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM charges across all leases — significant occupancy cost component beyond base rent."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total Right-of-Use asset value across the lease portfolio — key IFRS 16 / ASC 842 balance sheet figure reported to CFO and auditors."
    - name: "total_lease_liability"
      expr: SUM(CAST(liability_value AS DOUBLE))
      comment: "Total lease liability on the balance sheet — critical for debt covenant compliance and investor reporting."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate across leases — informs long-term occupancy cost forecasting."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held — represents locked capital that could be redeployed."
    - name: "total_termination_penalty"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total potential termination penalties across the portfolio — quantifies exit cost risk for strategic restructuring decisions."
    - name: "leases_with_termination_clause"
      expr: COUNT(CASE WHEN termination_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases with a termination clause — measures portfolio flexibility for strategic exits."
    - name: "leases_with_co_tenancy_clause"
      expr: COUNT(CASE WHEN co_tenancy_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases with co-tenancy clauses — exposure to anchor tenant departures that could trigger rent reductions or exits."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate — measures variable rent exposure tied to sales performance."
    - name: "total_property_tax_annual"
      expr: SUM(CAST(property_tax_annual AS DOUBLE))
      comment: "Total annual property tax obligations across leases — component of total occupancy cost."
    - name: "total_insurance_annual"
      expr: SUM(CAST(insurance_annual AS DOUBLE))
      comment: "Total annual insurance costs across leases — occupancy cost component for budget management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational rent payment metrics tracking payment performance, variance, and late fee exposure. Used by Real Estate Operations and Finance to monitor cash outflows, disputes, and payment compliance."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the rent payment (paid, pending, disputed, overdue) — primary operational filter."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (ACH, wire, check) — used for treasury and banking analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — for multi-currency portfolio reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the payment is under dispute — flags payments requiring landlord negotiation."
    - name: "late_fee_applied_flag"
      expr: late_fee_applied_flag
      comment: "Whether a late fee was applied — indicates payment compliance failures."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment — tracks accounting close completeness."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment — for annual trend and budget vs. actual analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment — for monthly cash flow and accrual reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment — aligns rent expense to financial reporting periods."
  measures:
    - name: "total_rent_payments"
      expr: COUNT(1)
      comment: "Total number of rent payment transactions — baseline volume metric."
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total rent paid across all payments — primary cash outflow metric for treasury and Real Estate Finance."
    - name: "total_base_rent_paid"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent component of payments — isolates core rent from CAM and other charges."
    - name: "total_cam_paid"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total CAM charges paid — tracks operating expense reimbursements to landlords."
    - name: "total_late_fees_paid"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees incurred — quantifies cost of payment process failures; should trend toward zero."
    - name: "total_payment_variance"
      expr: SUM(CAST(payment_variance_amount AS DOUBLE))
      comment: "Total variance between scheduled and actual payment amounts — flags systematic over/underpayment issues."
    - name: "avg_payment_variance"
      expr: AVG(CAST(payment_variance_amount AS DOUBLE))
      comment: "Average payment variance per transaction — benchmarks payment accuracy across the portfolio."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of payments under dispute — measures landlord relationship friction and financial risk."
    - name: "disputed_payment_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(total_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of disputed payments — quantifies financial exposure from landlord disputes."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_fee_applied_flag = TRUE THEN 1 END)
      comment: "Number of payments where late fees were applied — measures payment process compliance."
    - name: "total_property_tax_paid"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax payments — tracks tax obligation fulfillment across the portfolio."
    - name: "total_scheduled_payment_amount"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Total scheduled payment obligations — used as denominator for payment fulfillment rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forward-looking rent schedule metrics for occupancy cost forecasting, lease accounting, and portfolio-level rent economics. Used by Real Estate Finance and Accounting for IFRS 16 / ASC 842 reporting and budget planning."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the scheduled payment (paid, pending, overdue) — tracks payment fulfillment against schedule."
    - name: "lease_accounting_classification"
      expr: lease_accounting_classification
      comment: "IFRS 16 / ASC 842 classification — determines balance sheet treatment of the scheduled payment."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of rent escalation applied in this schedule period — for cost forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scheduled payment — for multi-currency portfolio reporting."
    - name: "cam_reconciliation_flag"
      expr: cam_reconciliation_flag
      comment: "Whether this schedule period requires CAM reconciliation — flags periods with additional cost exposure."
    - name: "sales_reporting_required_flag"
      expr: sales_reporting_required_flag
      comment: "Whether sales reporting is required for percentage rent calculation — identifies variable rent obligations."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period month — for monthly occupancy cost trend analysis."
    - name: "billing_period_year"
      expr: YEAR(billing_period_start_date)
      comment: "Billing period year — for annual budget vs. actual occupancy cost comparison."
  measures:
    - name: "total_scheduled_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total scheduled base rent across all periods — primary occupancy cost forecast figure for budget planning."
    - name: "total_scheduled_cam"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total scheduled CAM charges — operating expense forecast component."
    - name: "total_total_occupancy_cost"
      expr: SUM(CAST(total_occupancy_cost AS DOUBLE))
      comment: "Total occupancy cost across all scheduled periods — the all-in real estate cost figure used in P&L and site-level profitability analysis."
    - name: "avg_occupancy_cost_percentage"
      expr: AVG(CAST(occupancy_cost_percentage AS DOUBLE))
      comment: "Average occupancy cost as a percentage of sales — the key real estate efficiency ratio; industry benchmark is typically 8-12% for QSR."
    - name: "total_percentage_rent"
      expr: SUM(CAST(percentage_rent_amount AS DOUBLE))
      comment: "Total percentage rent obligations — variable rent tied to sales performance; high values indicate strong sales but also higher landlord participation."
    - name: "avg_rent_per_square_foot"
      expr: AVG(CAST(rent_per_square_foot AS DOUBLE))
      comment: "Average rent per square foot — the standard real estate efficiency benchmark for comparing site economics across the portfolio."
    - name: "total_rou_asset_depreciation"
      expr: SUM(CAST(right_of_use_asset_depreciation AS DOUBLE))
      comment: "Total ROU asset depreciation across scheduled periods — key IFRS 16 income statement line item."
    - name: "total_lease_liability_reduction"
      expr: SUM(CAST(lease_liability_reduction AS DOUBLE))
      comment: "Total lease liability reduction across periods — tracks balance sheet deleveraging from lease payments."
    - name: "total_real_estate_tax"
      expr: SUM(CAST(real_estate_tax_amount AS DOUBLE))
      comment: "Total real estate tax obligations in the schedule — occupancy cost component for tax planning."
    - name: "total_reported_sales"
      expr: SUM(CAST(reported_sales_amount AS DOUBLE))
      comment: "Total reported sales used for percentage rent calculation — validates sales reporting compliance and percentage rent triggers."
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate in the schedule — informs long-term occupancy cost growth forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_cam_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAM reconciliation metrics tracking billing accuracy, dispute exposure, and over/underpayment outcomes. Used by Real Estate Finance to manage landlord billing disputes and recover overpayments."
  source: "`vibe_restaurants_v1`.`realestate`.`cam_reconciliation`"
  dimensions:
    - name: "cam_reconciliation_status"
      expr: cam_reconciliation_status
      comment: "Status of the CAM reconciliation (pending, completed, disputed, approved) — primary workflow filter."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of CAM reconciliation (annual, interim, final) — determines scope and timing of the reconciliation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the reconciliation is under dispute — flags landlord billing disagreements requiring resolution."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of any dispute (open, resolved, escalated) — tracks dispute resolution pipeline."
    - name: "cam_itemization_flag"
      expr: cam_itemization_flag
      comment: "Whether the landlord provided itemized CAM charges — indicates audit quality and transparency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation — for multi-currency portfolio reporting."
    - name: "period_year"
      expr: YEAR(period_start_date)
      comment: "Year of the reconciliation period — for annual CAM cost trend analysis."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of CAM reconciliations — baseline volume for workload and portfolio coverage tracking."
    - name: "total_cam_billed"
      expr: SUM(CAST(cam_billed_amount AS DOUBLE))
      comment: "Total CAM amounts billed by landlords — gross CAM cost before reconciliation adjustments."
    - name: "total_cam_final"
      expr: SUM(CAST(cam_final_amount AS DOUBLE))
      comment: "Total final CAM amounts after reconciliation — the actual CAM cost recognized after audit and dispute resolution."
    - name: "total_cam_adjustments"
      expr: SUM(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Total CAM adjustments identified through reconciliation — measures the value recovered or owed through the reconciliation process."
    - name: "total_overpayment_credit"
      expr: SUM(CAST(overpayment_credit_amount AS DOUBLE))
      comment: "Total overpayment credits recovered from landlords — directly measures value recovered through the CAM audit process."
    - name: "total_underpayment_due"
      expr: SUM(CAST(underpayment_due_amount AS DOUBLE))
      comment: "Total underpayments owed to landlords — represents additional cash outflow obligations identified through reconciliation."
    - name: "total_cam_exclusions"
      expr: SUM(CAST(cam_exclusions_amount AS DOUBLE))
      comment: "Total CAM charges successfully excluded through lease enforcement — measures value of lease exclusion clause enforcement."
    - name: "disputed_reconciliation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of CAM reconciliations under dispute — measures landlord billing dispute volume and relationship friction."
    - name: "avg_cam_adjustment_per_reconciliation"
      expr: AVG(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Average CAM adjustment per reconciliation — benchmarks the typical billing error magnitude across the portfolio."
    - name: "total_cam_cap_amount"
      expr: SUM(CAST(cam_cap_amount AS DOUBLE))
      comment: "Total CAM cap amounts across reconciliations — measures the value of CAM cap protections negotiated in leases."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site portfolio metrics covering investment economics, rent levels, and site quality scores. Used by Real Estate and Development leadership to evaluate site performance, prioritize investment, and manage the development pipeline."
  source: "`vibe_restaurants_v1`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of site (freestanding, inline, end-cap, drive-thru only) — key segmentation for portfolio analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the site (prospecting, under construction, open, closed) — pipeline and portfolio health indicator."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Whether the site is owned or leased — drives capital structure and balance sheet treatment."
    - name: "market_classification"
      expr: market_classification
      comment: "Market tier classification (urban, suburban, rural) — used for portfolio mix and investment strategy analysis."
    - name: "drive_thru_capable"
      expr: drive_thru_capable
      comment: "Whether the site has drive-thru capability — significant driver of AUV and site economics."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the site — affects development options and permitted use."
    - name: "country_code"
      expr: country_code
      comment: "Country of the site — for geographic portfolio segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the site — for regional portfolio analysis."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the site opened — for vintage cohort analysis of site economics."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio — baseline portfolio size metric."
    - name: "total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital invested across all sites — primary investment portfolio metric for CFO and Real Estate leadership."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected Annual Unit Volume — the primary revenue forecast metric for site economics and investment return analysis."
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected AUV across all sites — portfolio-level revenue forecast for development pipeline planning."
    - name: "avg_monthly_base_rent"
      expr: AVG(CAST(monthly_base_rent AS DOUBLE))
      comment: "Average monthly base rent per site — benchmarks rent levels across the portfolio."
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Total monthly base rent obligations across all sites — portfolio-level occupancy cost run rate."
    - name: "avg_monthly_cam_charges"
      expr: AVG(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Average monthly CAM charges per site — benchmarks operating expense reimbursements."
    - name: "avg_accessibility_score"
      expr: AVG(CAST(accessibility_score AS DOUBLE))
      comment: "Average site accessibility score — measures portfolio-level site quality for customer convenience."
    - name: "avg_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average site visibility score — measures portfolio-level site quality for brand exposure and traffic capture."
    - name: "drive_thru_site_count"
      expr: COUNT(CASE WHEN drive_thru_capable = TRUE THEN 1 END)
      comment: "Number of drive-thru capable sites — drive-thru mix is a key strategic portfolio metric for QSR operators."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate across sites — measures variable rent exposure tied to sales performance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility condition, compliance, and cost metrics used by Facilities Management and Real Estate Operations to prioritize maintenance investment, manage compliance risk, and track asset condition across the portfolio."
  source: "`vibe_restaurants_v1`.`realestate`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (restaurant, drive-thru, kiosk, commissary) — primary segmentation for portfolio analysis."
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (active, closed, under renovation) — filters active portfolio."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the facility is owned or leased — drives capital vs. operating expense treatment."
    - name: "construction_status"
      expr: construction_status
      comment: "Construction or renovation status — tracks development pipeline progress."
    - name: "ada_compliance_status"
      expr: ada_compliance_status
      comment: "ADA compliance status — regulatory compliance risk indicator; non-compliant facilities represent legal exposure."
    - name: "fire_safety_compliance_status"
      expr: fire_safety_compliance_status
      comment: "Fire safety compliance status — critical safety and regulatory compliance indicator."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating — used for sustainability reporting and utility cost benchmarking."
    - name: "r_and_m_status"
      expr: r_and_m_status
      comment: "Repair and maintenance status — operational readiness indicator for facilities management."
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of most recent remodel — tracks brand image refresh cadence across the portfolio."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities — baseline portfolio size for facilities management."
    - name: "avg_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average facility condition score — the primary asset health metric; declining scores signal deferred maintenance risk and brand image degradation."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score across facilities — critical food safety and regulatory compliance metric; low scores trigger immediate operational intervention."
    - name: "total_capex_spent"
      expr: SUM(CAST(capex_spent AS DOUBLE))
      comment: "Total capital expenditure spent on facilities — tracks investment in asset maintenance and improvement."
    - name: "total_cam_charges"
      expr: SUM(CAST(cam_charges AS DOUBLE))
      comment: "Total CAM charges across facilities — operating expense component for portfolio cost management."
    - name: "avg_property_tax_rate"
      expr: AVG(CAST(property_tax_rate AS DOUBLE))
      comment: "Average property tax rate across facilities — benchmarks tax burden across the portfolio."
    - name: "avg_tax_assessment_value"
      expr: AVG(CAST(tax_assessment_value AS DOUBLE))
      comment: "Average tax assessment value — used for property tax appeal analysis and portfolio valuation."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all facilities — portfolio scale metric used for rent-per-sqft and cost-per-sqft benchmarking."
    - name: "avg_lease_rate"
      expr: AVG(CAST(lease_rate AS DOUBLE))
      comment: "Average lease rate across facilities — benchmarks occupancy cost efficiency across the portfolio."
    - name: "facilities_with_expired_insurance"
      expr: COUNT(CASE WHEN insurance_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of facilities with expired insurance — critical risk management metric; uninsured facilities represent significant financial and legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure budget metrics for real estate projects. Used by Real Estate Finance and Development leadership to track budget utilization, cost category mix, and project financial performance."
  source: "`vibe_restaurants_v1`.`realestate`.`capex_budget`"
  dimensions:
    - name: "capex_budget_status"
      expr: capex_budget_status
      comment: "Status of the CAPEX budget (approved, pending, revised, closed) — primary workflow filter."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of CAPEX budget (NRO, remodel, maintenance) — categorizes investment by strategic purpose."
    - name: "budget_phase"
      expr: budget_phase
      comment: "Phase of the budget (initial, revised, final) — tracks budget evolution through the approval process."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (corporate, franchise, debt) — critical for capital allocation and ROI attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget — for multi-currency capital planning."
    - name: "budget_year"
      expr: YEAR(start_date)
      comment: "Year the budget period starts — for annual capital planning cycle analysis."
  measures:
    - name: "total_capex_budgets"
      expr: COUNT(1)
      comment: "Total number of CAPEX budget records — baseline count for capital project pipeline."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget amount — primary capital commitment metric for CFO and Real Estate leadership."
    - name: "avg_budget_amount"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average CAPEX budget per project — benchmarks project investment levels for portfolio planning."
    - name: "total_building_shell_cost"
      expr: SUM(CAST(building_shell_cost AS DOUBLE))
      comment: "Total building shell construction cost — largest CAPEX component; tracks construction cost trends."
    - name: "total_ffe_cost"
      expr: SUM(CAST(ffe_cost AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment cost — key CAPEX component for new restaurant openings and remodels."
    - name: "total_leasehold_improvements_cost"
      expr: SUM(CAST(leasehold_improvements_cost AS DOUBLE))
      comment: "Total leasehold improvement costs — significant CAPEX component for leased sites; amortized over lease term."
    - name: "total_technology_cost"
      expr: SUM(CAST(technology_cost AS DOUBLE))
      comment: "Total technology investment in CAPEX budgets — tracks digital infrastructure investment across the portfolio."
    - name: "total_soft_costs"
      expr: SUM(CAST(soft_costs AS DOUBLE))
      comment: "Total soft costs (architecture, permits, legal) — overhead component of CAPEX; high ratios indicate process inefficiency."
    - name: "total_budget_revision_amount"
      expr: SUM(CAST(budget_revision_amount AS DOUBLE))
      comment: "Total budget revision amounts — measures scope creep and cost overrun exposure across the capital program."
    - name: "total_land_cost"
      expr: SUM(CAST(land_cost AS DOUBLE))
      comment: "Total land acquisition cost — tracks real estate investment in owned sites."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_nro_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New Restaurant Opening (NRO) project metrics tracking development pipeline, CAPEX performance, and opening timelines. Used by Development and Real Estate leadership to manage the growth pipeline and capital efficiency."
  source: "`vibe_restaurants_v1`.`realestate`.`nro_project`"
  dimensions:
    - name: "nro_project_status"
      expr: nro_project_status
      comment: "Current status of the NRO project (pipeline, permitting, construction, opened, cancelled) — primary pipeline filter."
    - name: "project_type"
      expr: project_type
      comment: "Type of project (new build, conversion, relocation) — categorizes development activity."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project (site selection, design, permitting, construction, pre-opening) — tracks pipeline stage distribution."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease for the NRO site — drives long-term occupancy cost structure."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the project — flags projects at risk of delay due to compliance issues."
    - name: "permitting_status"
      expr: permitting_status
      comment: "Status of permitting for the project — permitting delays are a primary cause of NRO timeline slippage."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the project (low, medium, high) — used to prioritize management attention and contingency planning."
    - name: "target_opening_year"
      expr: YEAR(target_opening_date)
      comment: "Target opening year — for annual development pipeline planning and commitment tracking."
  measures:
    - name: "total_nro_projects"
      expr: COUNT(1)
      comment: "Total number of NRO projects in the pipeline — primary development pipeline size metric."
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total CAPEX budgeted across all NRO projects — total capital commitment in the development pipeline."
    - name: "total_capex_actual"
      expr: SUM(CAST(capex_actual_amount AS DOUBLE))
      comment: "Total actual CAPEX spent on NRO projects — tracks capital deployment against budget."
    - name: "total_capex_committed"
      expr: SUM(CAST(capex_committed_amount AS DOUBLE))
      comment: "Total committed CAPEX (contracted but not yet spent) — measures near-term capital outflow obligations."
    - name: "avg_capex_budget_per_project"
      expr: AVG(CAST(capex_budget_amount AS DOUBLE))
      comment: "Average CAPEX budget per NRO project — benchmarks investment per new unit for portfolio planning."
    - name: "avg_capex_actual_per_project"
      expr: AVG(CAST(capex_actual_amount AS DOUBLE))
      comment: "Average actual CAPEX per NRO project — tracks actual investment per unit vs. budget benchmark."
    - name: "projects_opened"
      expr: COUNT(CASE WHEN actual_opening_date IS NOT NULL THEN 1 END)
      comment: "Number of NRO projects that have reached actual opening — measures development pipeline conversion to operating units."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'HIGH' THEN 1 END)
      comment: "Number of high-risk NRO projects — flags projects requiring executive attention to prevent timeline and cost overruns."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance work order metrics tracking repair costs, labor efficiency, and warranty recovery. Used by Facilities Management to control maintenance spend, prioritize repairs, and manage vendor performance."
  source: "`vibe_restaurants_v1`.`realestate`.`maintenance_work_order`"
  dimensions:
    - name: "maintenance_work_order_status"
      expr: maintenance_work_order_status
      comment: "Status of the work order (open, in-progress, completed, cancelled) — primary operational filter."
    - name: "issue_category"
      expr: issue_category
      comment: "Category of the maintenance issue (HVAC, plumbing, electrical, equipment) — used to identify systemic facility problems."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the work order (emergency, urgent, routine) — drives response time SLA compliance."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the work order is covered by warranty — tracks warranty recovery opportunities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the work order costs — for multi-currency portfolio reporting."
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the work was scheduled — for annual maintenance spend trend analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the work was scheduled — for monthly maintenance spend and workload analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders — baseline volume metric for facilities management workload."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost across all work orders — primary facilities operating expense metric for budget management."
    - name: "avg_maintenance_cost_per_work_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per work order — benchmarks maintenance efficiency and identifies cost outliers."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across work orders — labor component of maintenance spend for workforce planning."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost — procurement component of maintenance spend."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance — workforce utilization metric for facilities staffing."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order — efficiency benchmark for maintenance technician productivity."
    - name: "warranty_claim_work_order_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of work orders with warranty claims — measures warranty recovery activity and potential cost avoidance."
    - name: "emergency_work_order_count"
      expr: COUNT(CASE WHEN priority_level = 'EMERGENCY' THEN 1 END)
      comment: "Number of emergency priority work orders — high emergency rates indicate deferred maintenance or aging asset issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site selection evaluation metrics used by Real Estate Development to assess pipeline quality, projected returns, and site scoring. Informs go/no-go decisions on new restaurant locations."
  source: "`vibe_restaurants_v1`.`realestate`.`site_selection`"
  dimensions:
    - name: "site_selection_status"
      expr: site_selection_status
      comment: "Status of the site evaluation (in-review, approved, rejected, on-hold) — primary pipeline filter."
    - name: "evaluation_stage"
      expr: evaluation_stage
      comment: "Stage of the evaluation process (initial screening, detailed analysis, final approval) — tracks pipeline progression."
    - name: "lease_type"
      expr: lease_type
      comment: "Proposed lease type for the site — drives long-term occupancy cost structure."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the site evaluation — used to prioritize management review."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial projections — for multi-currency development pipeline analysis."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of the site decision — for annual pipeline conversion rate analysis."
  measures:
    - name: "total_site_evaluations"
      expr: COUNT(1)
      comment: "Total number of site evaluations — measures development pipeline activity volume."
    - name: "avg_overall_site_score"
      expr: AVG(CAST(overall_site_score AS DOUBLE))
      comment: "Average overall site score across evaluations — measures portfolio quality of the development pipeline."
    - name: "avg_projected_annual_sales"
      expr: AVG(CAST(projected_annual_sales AS DOUBLE))
      comment: "Average projected annual sales per evaluated site — primary revenue forecast metric for development pipeline quality assessment."
    - name: "total_projected_annual_sales"
      expr: SUM(CAST(projected_annual_sales AS DOUBLE))
      comment: "Total projected annual sales across all evaluated sites — portfolio-level revenue potential of the development pipeline."
    - name: "avg_projected_roi_percent"
      expr: AVG(CAST(projected_roi_percent AS DOUBLE))
      comment: "Average projected ROI across site evaluations — the primary investment return metric for development pipeline quality; drives go/no-go decisions."
    - name: "avg_projected_capex"
      expr: AVG(CAST(projected_capex_amount AS DOUBLE))
      comment: "Average projected CAPEX per site evaluation — benchmarks investment requirements across the pipeline."
    - name: "total_projected_capex"
      expr: SUM(CAST(projected_capex_amount AS DOUBLE))
      comment: "Total projected CAPEX across all evaluated sites — total capital requirement of the development pipeline."
    - name: "avg_auv_projection"
      expr: AVG(CAST(auv_projection AS DOUBLE))
      comment: "Average AUV projection across site evaluations — benchmarks revenue potential of pipeline sites against existing portfolio."
    - name: "avg_market_share_estimate"
      expr: AVG(CAST(market_share_estimate_percent AS DOUBLE))
      comment: "Average estimated market share for evaluated sites — measures competitive positioning of pipeline locations."
    - name: "approved_site_count"
      expr: COUNT(CASE WHEN site_selection_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved site evaluations — measures development pipeline conversion rate and growth commitment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_trade_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade area demographic and competitive metrics used by Real Estate and Marketing to evaluate market potential, cannibalization risk, and competitive positioning for existing and prospective sites."
  source: "`vibe_restaurants_v1`.`realestate`.`trade_area`"
  dimensions:
    - name: "trade_area_status"
      expr: trade_area_status
      comment: "Status of the trade area analysis (active, archived, under review) — filters current vs. historical analyses."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the trade area — for regional market analysis and portfolio planning."
    - name: "methodology"
      expr: methodology
      comment: "Methodology used to define the trade area (drive-time, radius, custom) — affects comparability of metrics."
    - name: "state"
      expr: state
      comment: "State of the trade area — for state-level market analysis."
    - name: "data_vintage_year"
      expr: YEAR(data_vintage_date)
      comment: "Year of the demographic data vintage — flags stale data that may not reflect current market conditions."
  measures:
    - name: "total_trade_areas"
      expr: COUNT(1)
      comment: "Total number of trade area analyses — baseline count for market coverage assessment."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected AUV across trade areas — measures revenue potential of markets in the portfolio."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across trade areas — key demographic indicator for menu pricing strategy and market positioning."
    - name: "avg_population_density"
      expr: AVG(CAST(population_density_per_sq_mile AS DOUBLE))
      comment: "Average population density across trade areas — measures market density and customer base size."
    - name: "avg_cannibalization_risk_score"
      expr: AVG(CAST(cannibalization_risk_score AS DOUBLE))
      comment: "Average cannibalization risk score — measures portfolio-level risk of new openings cannibalizing existing unit sales."
    - name: "avg_market_share_score"
      expr: AVG(CAST(market_share_score AS DOUBLE))
      comment: "Average market share score across trade areas — measures competitive positioning of the portfolio."
    - name: "avg_employment_rate"
      expr: AVG(CAST(employment_rate_percent AS DOUBLE))
      comment: "Average employment rate across trade areas — economic health indicator affecting consumer spending and labor availability."
    - name: "avg_income_per_capita"
      expr: AVG(CAST(average_income_per_capita AS DOUBLE))
      comment: "Average income per capita across trade areas — demographic quality indicator for market potential assessment."
    - name: "avg_primary_boundary_radius"
      expr: AVG(CAST(primary_boundary_radius_miles AS DOUBLE))
      comment: "Average primary trade area radius in miles — measures typical customer draw distance across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_property_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property acquisition metrics tracking investment size, financing structure, and acquisition pipeline. Used by Real Estate and Finance leadership to manage owned property portfolio growth and capital deployment."
  source: "`vibe_restaurants_v1`.`realestate`.`property_acquisition`"
  dimensions:
    - name: "property_acquisition_status"
      expr: property_acquisition_status
      comment: "Status of the acquisition (in-progress, closed, cancelled) — primary pipeline filter."
    - name: "property_type"
      expr: property_type
      comment: "Type of property being acquired (land, building, land+building) — drives CAPEX and depreciation treatment."
    - name: "financing_structure"
      expr: financing_structure
      comment: "Financing structure of the acquisition (cash, debt, sale-leaseback) — critical for capital structure analysis."
    - name: "environmental_assessment_status"
      expr: environmental_assessment_status
      comment: "Environmental assessment status — flags acquisitions with environmental risk that could affect closing or future costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition — for multi-currency portfolio reporting."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition — for vintage cohort analysis of owned property portfolio."
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of property acquisitions — baseline portfolio growth metric."
    - name: "total_acquisition_price"
      expr: SUM(CAST(acquisition_price AS DOUBLE))
      comment: "Total acquisition price across all properties — primary capital deployment metric for owned real estate portfolio."
    - name: "avg_acquisition_price"
      expr: AVG(CAST(acquisition_price AS DOUBLE))
      comment: "Average acquisition price per property — benchmarks investment per owned site."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(total_acquisition_cost AS DOUBLE))
      comment: "Total all-in acquisition cost (price + closing costs) — true capital deployed for owned property portfolio."
    - name: "total_closing_costs"
      expr: SUM(CAST(closing_costs AS DOUBLE))
      comment: "Total closing costs across acquisitions — transaction overhead; high ratios to acquisition price indicate process inefficiency."
    - name: "avg_capitalization_rate"
      expr: AVG(CAST(capitalization_rate AS DOUBLE))
      comment: "Average capitalization rate across acquisitions — the primary real estate investment return metric; used to benchmark acquisition quality."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total debt financing across acquisitions — measures leverage in the owned property portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_lease_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease amendment metrics tracking modification activity, financial impact, and IFRS 16 remeasurement exposure. Used by Real Estate and Finance to manage lease modification risk and accounting impacts."
  source: "`vibe_restaurants_v1`.`realestate`.`lease_amendment`"
  dimensions:
    - name: "lease_amendment_status"
      expr: lease_amendment_status
      comment: "Status of the amendment (pending, executed, rejected) — primary workflow filter."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (extension, expansion, reduction, termination) — categorizes modification activity."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the amendment — tracks compliance with legal approval requirements."
    - name: "ifrs16_impact_flag"
      expr: ifrs16_impact_flag
      comment: "Whether the amendment triggers IFRS 16 remeasurement — flags amendments requiring accounting restatement."
    - name: "space_change_type"
      expr: space_change_type
      comment: "Type of space change (expansion, reduction, no change) — tracks portfolio footprint evolution."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective — for annual amendment activity trend analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of lease amendments — measures lease modification activity volume."
    - name: "total_net_financial_impact"
      expr: SUM(CAST(net_impact_amount AS DOUBLE))
      comment: "Total net financial impact of all amendments — measures the aggregate P&L and balance sheet effect of lease modifications."
    - name: "avg_net_financial_impact"
      expr: AVG(CAST(net_impact_amount AS DOUBLE))
      comment: "Average net financial impact per amendment — benchmarks the typical financial significance of lease modifications."
    - name: "total_rent_change_amount"
      expr: SUM(CAST(rent_change_amount AS DOUBLE))
      comment: "Total rent change amount across all amendments — measures aggregate rent increase/decrease from lease modifications."
    - name: "total_ti_allowance"
      expr: SUM(CAST(ti_allowance_amount AS DOUBLE))
      comment: "Total tenant improvement allowances negotiated in amendments — measures landlord concessions secured through lease negotiations."
    - name: "total_space_change_sqft"
      expr: SUM(CAST(space_change_sqft AS DOUBLE))
      comment: "Total square footage change across amendments — measures portfolio footprint evolution from lease modifications."
    - name: "ifrs16_impacting_amendment_count"
      expr: COUNT(CASE WHEN ifrs16_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments triggering IFRS 16 remeasurement — measures accounting restatement workload for Finance."
$$;