-- Metric views for domain: asset | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and lifecycle metrics for fixed assets — tracks book value, depreciation, and asset health across the fleet of capitalized assets. Used by Finance and Asset Management to steer capital allocation, impairment reviews, and disposal decisions."
  source: "`waste_management_ecm`.`asset`.`fixed_asset`"
  dimensions:
    - name: "asset_class_id"
      expr: class_id
      comment: "Foreign key to asset class — enables grouping of KPIs by asset category (e.g., vehicles, containers, facilities)."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the fixed asset is located — supports geographic and operational segmentation of asset metrics."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Indicates whether the asset is owned, leased, or financed — critical for balance sheet classification and capital strategy."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation methodology applied (e.g., straight-line, declining balance) — affects book value trends and tax reporting."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Current physical condition grade of the asset — used to prioritize maintenance investment and retirement decisions."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired — enables cohort analysis of asset age and depreciation curves."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (e.g., sale, scrap, trade-in) — informs retirement strategy and residual value recovery."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the asset meets environmental compliance requirements — critical for regulatory risk management."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of fixed asset records — baseline count for portfolio sizing and capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all fixed assets — represents gross capital invested in the asset base."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all fixed assets — measures how much of the original investment has been expensed over time."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total net book value (NBV) of all fixed assets — key balance sheet figure representing remaining capitalized value of the asset portfolio."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset — benchmarks asset value density and guides replacement prioritization."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value at end of useful life — informs residual value recovery planning and disposal strategy."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total cash proceeds received from asset disposals — measures effectiveness of the asset retirement and divestiture program."
    - name: "avg_depreciation_per_asset"
      expr: AVG(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Average accumulated depreciation per fixed asset — indicates average age/wear of the asset portfolio and informs refresh cycles."
    - name: "assets_non_compliant_environmental"
      expr: COUNT(CASE WHEN environmental_compliance_flag = FALSE THEN 1 END)
      comment: "Count of fixed assets flagged as non-compliant with environmental regulations — a critical risk metric for regulatory exposure and remediation prioritization."
    - name: "assets_disposed"
      expr: COUNT(CASE WHEN disposal_date IS NOT NULL THEN 1 END)
      comment: "Count of fixed assets that have been disposed — tracks asset retirement activity and portfolio turnover rate."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital acquisition metrics tracking cost, volume, and composition of asset purchases. Used by Finance and Procurement to govern capital expenditure, monitor budget adherence, and evaluate acquisition efficiency."
  source: "`waste_management_ecm`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_method"
      expr: acquisition_method
      comment: "Method by which the asset was acquired (e.g., purchase, lease, donation, trade-in) — drives capital vs. operating expense classification."
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition record (e.g., pending, approved, capitalized) — used to track pipeline and completion rates."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the acquisition (e.g., operating budget, capital budget, grant) — critical for financial planning and budget accountability."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method assigned at acquisition — affects long-term P&L and tax strategy."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition — enables year-over-year capital spend trend analysis."
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year the asset was capitalized — used to reconcile acquisition timing with balance sheet recognition."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that approved the acquisition — supports governance and delegation-of-authority compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition transaction — required for multi-currency capital spend consolidation."
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of asset acquisitions — baseline volume metric for capital activity tracking."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total acquisition cost across all asset purchases — primary capital expenditure KPI for budget vs. actual analysis."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and delivery costs incurred during asset acquisitions — identifies logistics overhead in the capital procurement process."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation costs capitalized with asset acquisitions — measures the full cost-to-deploy for capital assets."
    - name: "total_capitalized_cost"
      expr: SUM(CAST(total_capitalized_cost AS DOUBLE))
      comment: "Total amount capitalized to the balance sheet across all acquisitions — the definitive capital investment figure for financial reporting."
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value credited against new asset acquisitions — measures the residual value recovery from asset replacement programs."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per asset acquisition — benchmarks unit capital cost and identifies outliers requiring procurement review."
    - name: "total_salvage_value_estimated"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value assigned at acquisition — informs long-term residual value planning and depreciation base calculations."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project performance metrics tracking budget adherence, schedule variance, and spend efficiency. Used by Finance, Engineering, and Executive leadership to govern the capital investment portfolio and ensure projects deliver on-time and on-budget."
  source: "`waste_management_ecm`.`asset`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the capital project (e.g., planning, in-progress, completed, cancelled) — primary filter for active portfolio management."
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (e.g., new construction, expansion, replacement, compliance) — enables spend analysis by investment category."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority level assigned to the project — used to align capital allocation with strategic objectives."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the capital project — supports risk-adjusted portfolio review and executive escalation."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding for the project — required for budget accountability and grant/bond compliance reporting."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the capital project — enables geographic and site-level capital spend analysis."
    - name: "environmental_permit_required"
      expr: environmental_permit_required
      comment: "Flag indicating whether an environmental permit is required — identifies projects with regulatory dependencies that may affect schedule."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Planned start year of the project — supports multi-year capital planning and cash flow forecasting."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects — baseline count for portfolio size and governance workload."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capital budget across all projects — the authorized capital envelope for financial planning and board reporting."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capital expenditure incurred across all projects — compared against approved budget to assess capital discipline."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) capital — critical for cash flow forecasting and remaining budget availability."
    - name: "total_budget_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. approved) across all projects — negative values indicate over-budget conditions requiring executive attention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across capital projects — a normalized efficiency KPI for comparing project execution quality across different project sizes."
    - name: "projects_over_budget"
      expr: COUNT(CASE WHEN variance_amount > 0 THEN 1 END)
      comment: "Count of capital projects exceeding their approved budget — a governance risk indicator for capital program health."
    - name: "avg_actual_spend"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per capital project — benchmarks project scale and informs future capital budgeting norms."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_capital_project_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular capital project expenditure metrics for cost element analysis, capitalization eligibility tracking, and payment status monitoring. Used by Finance and Project Controls to manage project cost flows and ensure accurate balance sheet capitalization."
  source: "`waste_management_ecm`.`asset`.`capital_project_expenditure`"
  dimensions:
    - name: "capital_project_id"
      expr: capital_project_id
      comment: "Parent capital project — enables drill-down from project-level to transaction-level cost analysis."
    - name: "cost_element"
      expr: cost_element
      comment: "Cost element code (e.g., labor, materials, equipment) — enables cost structure analysis within capital projects."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the expenditure — supports capital spend analysis by asset category."
    - name: "posting_status"
      expr: posting_status
      comment: "Accounting posting status of the expenditure (e.g., posted, reversed, pending) — used to reconcile project cost ledgers."
    - name: "capitalization_eligible_flag"
      expr: capitalization_eligible_flag
      comment: "Indicates whether the expenditure qualifies for capitalization to the balance sheet — critical for GAAP/IFRS compliance in capital accounting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags expenditures that have been reversed — used to identify corrected postings and ensure accurate project cost reporting."
    - name: "expenditure_year"
      expr: YEAR(expenditure_date)
      comment: "Year of the expenditure — supports annual capital spend trend analysis and budget period reconciliation."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — required for intercompany capital project cost allocation and consolidated reporting."
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital project expenditure amount — the primary cost flow metric for project financial control and budget consumption tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax incurred on capital project expenditures — required for tax reporting and recoverable VAT/GST analysis."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance at the expenditure line level — identifies cost elements driving project over/under-runs."
    - name: "capitalizable_expenditure_amount"
      expr: SUM(CASE WHEN capitalization_eligible_flag = TRUE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure amount eligible for balance sheet capitalization — the key figure for fixed asset addition accounting and capital vs. expense classification."
    - name: "non_capitalizable_expenditure_amount"
      expr: SUM(CASE WHEN capitalization_eligible_flag = FALSE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure amount that must be expensed (not capitalized) — informs P&L impact of capital project activity."
    - name: "total_expenditure_transactions"
      expr: COUNT(1)
      comment: "Total number of expenditure transactions — baseline volume metric for project cost activity and audit workload."
    - name: "avg_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average expenditure transaction amount — benchmarks transaction size and identifies anomalous high-value postings."
    - name: "reversed_expenditure_amount"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of reversed expenditure transactions — a data quality and financial control metric; high reversal rates indicate posting errors or project scope changes."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection quality, compliance, and corrective action metrics. Used by Operations, EHS, and Compliance teams to monitor asset condition, regulatory adherence, and maintenance prioritization across the waste management asset fleet."
  source: "`waste_management_ecm`.`asset`.`asset_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., routine, regulatory, safety, pre-service) — enables analysis of inspection program composition and compliance coverage."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., scheduled, completed, overdue) — used to track inspection program execution rates."
    - name: "overall_condition_grade"
      expr: overall_condition_grade
      comment: "Overall condition grade assigned during inspection — primary asset health indicator for maintenance and replacement decisions."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Pass/fail outcome of the inspection — the definitive compliance and safety determination for each inspected asset."
    - name: "corrective_action_priority"
      expr: corrective_action_priority
      comment: "Priority level of required corrective action — drives maintenance work order urgency and resource allocation."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used to conduct the inspection (e.g., visual, instrument, third-party) — supports quality assurance of the inspection program."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was conducted — enables year-over-year trend analysis of asset condition and compliance rates."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the inspection was conducted — supports site-level compliance and condition benchmarking."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of asset inspections conducted — baseline metric for inspection program activity and regulatory coverage."
    - name: "inspections_failed"
      expr: COUNT(CASE WHEN pass_fail_determination = 'Fail' THEN 1 END)
      comment: "Count of inspections resulting in a fail determination — a critical safety and compliance KPI; high failure rates signal systemic asset degradation."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of inspections that identified defects requiring corrective action — drives maintenance backlog and work order generation."
    - name: "assets_taken_out_of_service"
      expr: COUNT(CASE WHEN asset_out_of_service_flag = TRUE THEN 1 END)
      comment: "Count of inspections resulting in the asset being taken out of service — a high-severity operational impact metric affecting service capacity."
    - name: "inspections_with_safety_incidents"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of inspections where a safety incident was identified — a leading indicator for EHS risk and regulatory reporting obligations."
    - name: "inspections_regulatory_non_compliant"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Count of inspections where the asset failed to meet regulatory compliance requirements — directly tied to permit risk and potential enforcement actions."
    - name: "total_inspection_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost incurred for asset inspections — used to manage inspection program budget and benchmark cost per inspection."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per asset inspection — benchmarks inspection efficiency and identifies high-cost inspection types or facilities."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container asset portfolio metrics covering financial value, capacity, condition, and technology enablement. Used by Operations and Asset Management to optimize container deployment, track depreciation, and manage the physical container fleet."
  source: "`waste_management_ecm`.`asset`.`asset_container`"
  dimensions:
    - name: "container_type"
      expr: container_type
      comment: "Type of container (e.g., dumpster, roll-off, cart, compactor) — primary segmentation dimension for container fleet analysis."
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Waste stream the container is designated for (e.g., MSW, recycling, organics, hazmat) — critical for service line and regulatory compliance analysis."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership classification of the container (e.g., owned, leased, customer-owned) — affects asset accounting and maintenance responsibility."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the container — used to prioritize repair, refurbishment, or retirement decisions."
    - name: "is_gps_enabled"
      expr: is_gps_enabled
      comment: "Indicates whether the container has GPS tracking enabled — measures technology adoption rate across the container fleet."
    - name: "is_rfid_enabled"
      expr: is_rfid_enabled
      comment: "Indicates whether the container has RFID tracking enabled — measures smart asset technology penetration for operational visibility."
    - name: "service_frequency"
      expr: service_frequency
      comment: "Scheduled service frequency for the container (e.g., weekly, bi-weekly) — used to analyze service intensity and route optimization opportunities."
    - name: "deployment_year"
      expr: YEAR(deployment_date)
      comment: "Year the container was deployed to a customer location — enables cohort analysis of container age and condition trends."
  measures:
    - name: "total_containers"
      expr: COUNT(1)
      comment: "Total number of containers in the asset portfolio — baseline fleet size metric for capacity planning and service coverage analysis."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of the container fleet — key balance sheet figure representing remaining capitalized value of container assets."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all containers — represents gross capital invested in the container fleet."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation of the container fleet — measures how much of the original container investment has been expensed."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per container — benchmarks container value density and guides fleet refresh investment decisions."
    - name: "total_capacity_cubic_yards"
      expr: SUM(CAST(capacity_cubic_yards AS DOUBLE))
      comment: "Total volumetric capacity of the container fleet in cubic yards — measures total waste collection capacity available to serve customers."
    - name: "avg_capacity_cubic_yards"
      expr: AVG(CAST(capacity_cubic_yards AS DOUBLE))
      comment: "Average container capacity in cubic yards — used to analyze fleet composition and match container sizing to customer demand."
    - name: "gps_enabled_containers"
      expr: COUNT(CASE WHEN is_gps_enabled = TRUE THEN 1 END)
      comment: "Count of containers with GPS tracking enabled — measures smart fleet technology adoption for operational visibility and theft prevention."
    - name: "rfid_enabled_containers"
      expr: COUNT(CASE WHEN is_rfid_enabled = TRUE THEN 1 END)
      comment: "Count of containers with RFID tracking enabled — measures automated identification technology penetration for service verification and billing accuracy."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_retirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset retirement and disposal metrics tracking financial outcomes, disposal methods, and regulatory compliance of retired assets. Used by Finance and Asset Management to evaluate residual value recovery, gain/loss on disposal, and environmental disposal compliance."
  source: "`waste_management_ecm`.`asset`.`retirement`"
  dimensions:
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the retired asset (e.g., sale, scrap, donation, trade-in) — drives gain/loss accounting and environmental compliance requirements."
    - name: "retirement_status"
      expr: retirement_status
      comment: "Current status of the retirement record (e.g., pending, approved, completed) — tracks retirement pipeline and completion rates."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for asset retirement (e.g., end-of-life, damage, obsolescence, regulatory) — identifies root causes driving asset turnover."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the retired asset — enables retirement trend analysis by asset type to inform replacement planning."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Flags retirements involving hazardous materials — identifies assets requiring special disposal procedures and environmental certifications."
    - name: "retirement_year"
      expr: YEAR(retirement_date)
      comment: "Year of asset retirement — enables year-over-year analysis of asset turnover rates and capital replacement cycles."
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory of the retired asset — provides granular segmentation for replacement planning and fleet composition analysis."
  measures:
    - name: "total_retirements"
      expr: COUNT(1)
      comment: "Total number of asset retirements — baseline metric for asset turnover activity and replacement program scale."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_amount AS DOUBLE))
      comment: "Total gain or loss recognized on asset disposals — a key P&L metric; positive values indicate value recovery above book value, negative values indicate write-down losses."
    - name: "total_sale_proceeds"
      expr: SUM(CAST(sale_proceeds_amount AS DOUBLE))
      comment: "Total cash proceeds received from asset sales — measures the effectiveness of the asset divestiture program in recovering residual value."
    - name: "total_disposal_cost"
      expr: SUM(CAST(disposal_cost_amount AS DOUBLE))
      comment: "Total cost incurred to dispose of retired assets — includes decommissioning, transport, and environmental remediation costs."
    - name: "total_insurance_recovery"
      expr: SUM(CAST(insurance_recovery_amount AS DOUBLE))
      comment: "Total insurance recovery amounts received for retired assets — measures the effectiveness of asset insurance coverage in mitigating retirement losses."
    - name: "total_net_book_value_retired"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all retired assets at time of retirement — represents the balance sheet reduction from the retirement program."
    - name: "hazardous_material_retirements"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN 1 END)
      comment: "Count of retirements involving hazardous materials — a compliance risk metric requiring environmental disposal certification and regulatory reporting."
    - name: "avg_gain_loss_per_retirement"
      expr: AVG(CAST(gain_loss_amount AS DOUBLE))
      comment: "Average gain or loss per asset retirement — benchmarks disposal efficiency and informs optimal timing for asset replacement decisions."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset valuation metrics tracking appraised values, impairment indicators, and insurance coverage adequacy. Used by Finance, Risk Management, and Accounting to support impairment testing, insurance renewals, and fair value reporting under GAAP/IFRS."
  source: "`waste_management_ecm`.`asset`.`valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation performed (e.g., fair market value, insurance replacement, impairment test) — determines the applicable accounting and reporting framework."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation (e.g., draft, approved, superseded) — used to filter to authoritative valuation records for reporting."
    - name: "methodology"
      expr: methodology
      comment: "Valuation methodology applied (e.g., cost approach, market approach, income approach) — affects comparability of valuations across asset classes."
    - name: "purpose"
      expr: purpose
      comment: "Business purpose of the valuation (e.g., financial reporting, insurance, acquisition) — enables filtering of valuations by use case."
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Flags assets with indicators of impairment — a critical financial reporting trigger requiring impairment loss recognition under GAAP/IFRS."
    - name: "economic_obsolescence_flag"
      expr: economic_obsolescence_flag
      comment: "Indicates economic obsolescence has been identified — signals assets losing value due to external market or regulatory factors."
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year the valuation was performed — enables tracking of valuation currency and identification of stale valuations."
    - name: "depreciation_method_used"
      expr: depreciation_method_used
      comment: "Depreciation method applied in the valuation — affects carrying amount calculations and comparability across asset classes."
  measures:
    - name: "total_valuations"
      expr: COUNT(1)
      comment: "Total number of asset valuation records — baseline metric for valuation program coverage and activity."
    - name: "total_appraised_value"
      expr: SUM(CAST(appraised_value AS DOUBLE))
      comment: "Total appraised value of all valued assets — the authoritative fair value figure for financial reporting, insurance, and M&A due diligence."
    - name: "total_carrying_amount"
      expr: SUM(CAST(carrying_amount AS DOUBLE))
      comment: "Total carrying amount (book value) of all valued assets — used to compare book value against appraised value for impairment analysis."
    - name: "total_replacement_cost_new"
      expr: SUM(CAST(replacement_cost_new AS DOUBLE))
      comment: "Total replacement cost new of all valued assets — the gross insurance replacement value used to set coverage limits and premiums."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all valued assets — compared against replacement cost to identify under-insurance exposure."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized across all asset valuations — a critical P&L and balance sheet metric for financial reporting and investor disclosure."
    - name: "assets_with_impairment_indicators"
      expr: COUNT(CASE WHEN impairment_indicator_flag = TRUE THEN 1 END)
      comment: "Count of assets with active impairment indicators — identifies the scope of required impairment testing and potential write-down exposure."
    - name: "avg_useful_life_remaining_years"
      expr: AVG(CAST(useful_life_remaining_years AS DOUBLE))
      comment: "Average remaining useful life across all valued assets — a portfolio health metric indicating the average age of the asset base and timing of future replacement needs."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease portfolio metrics tracking financial obligations, right-of-use asset values, and lease composition. Used by Finance and Treasury to manage lease accounting compliance (ASC 842 / IFRS 16), monitor lease liabilities, and optimize the lease vs. buy decision."
  source: "`waste_management_ecm`.`asset`.`lease`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Classification of the lease (e.g., finance lease, operating lease) — determines balance sheet treatment under ASC 842 / IFRS 16."
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g., active, expired, terminated, renewed) — used to filter to the active lease obligation portfolio."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments (e.g., monthly, quarterly, annual) — required for cash flow forecasting and payment schedule management."
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Indicates whether the lease includes a purchase option — affects lease classification and long-term asset acquisition planning."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the lease includes a renewal option — affects lease term determination under ASC 842 / IFRS 16 and long-term liability measurement."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — required for consolidated lease liability reporting across business units."
    - name: "lease_start_year"
      expr: YEAR(start_date)
      comment: "Year the lease commenced — enables cohort analysis of lease portfolio age and upcoming renewal/expiration exposure."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of lease payments — required for multi-currency lease liability consolidation and FX exposure management."
  measures:
    - name: "total_leases"
      expr: COUNT(1)
      comment: "Total number of lease agreements — baseline metric for lease portfolio size and administrative workload."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use (ROU) asset value across all leases — the balance sheet asset figure required under ASC 842 / IFRS 16 lease accounting standards."
    - name: "total_liability_balance"
      expr: SUM(CAST(liability_balance AS DOUBLE))
      comment: "Total lease liability balance across all leases — the balance sheet obligation figure representing the present value of future lease payments."
    - name: "total_monthly_lease_payments"
      expr: SUM(CAST(monthly_lease_payment AS DOUBLE))
      comment: "Total monthly lease payment obligations across all active leases — a critical cash flow metric for treasury and liquidity management."
    - name: "total_termination_penalty_exposure"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total potential termination penalty exposure across all leases — quantifies the financial risk of early lease exits for portfolio restructuring decisions."
    - name: "total_purchase_option_value"
      expr: SUM(CAST(purchase_option_price AS DOUBLE))
      comment: "Total purchase option price across all leases with purchase options — informs the financial analysis of lease-to-own conversion opportunities."
    - name: "avg_implicit_interest_rate"
      expr: AVG(CAST(implicit_interest_rate AS DOUBLE))
      comment: "Average implicit interest rate across all leases — benchmarks the cost of lease financing and informs lease vs. buy financial analysis."
    - name: "avg_monthly_lease_payment"
      expr: AVG(CAST(monthly_lease_payment AS DOUBLE))
      comment: "Average monthly lease payment per lease agreement — benchmarks lease cost efficiency and identifies outlier high-cost leases for renegotiation."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset transfer metrics tracking inter-facility movement costs, frequency, and operational patterns. Used by Operations and Finance to optimize asset deployment across the network, manage transfer costs, and ensure accurate intercompany accounting."
  source: "`waste_management_ecm`.`asset`.`transfer`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of asset transfer (e.g., redeployment, maintenance, intercompany) — enables analysis of transfer drivers and associated cost patterns."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g., scheduled, in-transit, completed, cancelled) — used to track transfer pipeline and completion rates."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the asset transfer — identifies operational drivers (e.g., customer request, maintenance, rebalancing) for network optimization analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method used to transport the asset (e.g., company truck, third-party carrier) — enables cost benchmarking across logistics modes."
    - name: "sending_facility_id"
      expr: sending_facility_id
      comment: "Facility originating the transfer — identifies facilities with high outbound asset movement for network rebalancing analysis."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility receiving the transferred asset — identifies facilities with high inbound demand for capacity planning."
    - name: "requires_maintenance_flag"
      expr: requires_maintenance_flag
      comment: "Indicates whether the asset requires maintenance upon transfer — identifies transfers that will generate maintenance work orders and associated costs."
    - name: "transfer_year"
      expr: YEAR(transfer_date)
      comment: "Year the transfer was executed — enables year-over-year analysis of asset mobility and network rebalancing activity."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of asset transfers — baseline metric for inter-facility asset mobility and network rebalancing activity."
    - name: "total_transfer_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for asset transfers — a key operational efficiency metric; high transfer costs indicate suboptimal initial asset deployment or network imbalances."
    - name: "avg_transfer_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per asset transfer — benchmarks transfer efficiency and identifies high-cost shipping methods or routes for optimization."
    - name: "total_asset_book_value_transferred"
      expr: SUM(CAST(asset_book_value_at_transfer AS DOUBLE))
      comment: "Total net book value of assets transferred between facilities — measures the scale of capital redeployment activity across the network."
    - name: "transfers_requiring_maintenance"
      expr: COUNT(CASE WHEN requires_maintenance_flag = TRUE THEN 1 END)
      comment: "Count of transfers where the asset requires maintenance — identifies the volume of transfers generating downstream maintenance work orders and costs."
    - name: "distinct_assets_transferred"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of distinct fixed assets that have been transferred — measures the breadth of asset mobility across the network, distinguishing from total transfer volume."
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility portfolio metrics tracking capacity, geographic footprint, and regulatory certification status. Used by Operations, Real Estate, and Compliance to manage the facility network, monitor landfill capacity, and ensure environmental permit compliance."
  source: "`waste_management_ecm`.`asset`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., landfill, transfer station, MRF, hazmat facility) — primary segmentation for capacity and compliance analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the facility (e.g., owned, leased, operated) — affects capital investment decisions and balance sheet treatment."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the facility is located — enables geographic analysis of network coverage and regulatory jurisdiction."
    - name: "hazmat_facility_flag"
      expr: hazmat_facility_flag
      comment: "Indicates whether the facility handles hazardous materials — identifies facilities with heightened regulatory and environmental compliance requirements."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Indicates ISO 14001 environmental management certification status — a key sustainability and regulatory compliance indicator."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Indicates ISO 45001 occupational health and safety certification status — measures safety management system maturity across the facility network."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the facility was commissioned — enables age-based analysis of the facility portfolio for capital reinvestment planning."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities in the network — baseline metric for network scale and geographic coverage."
    - name: "total_permitted_capacity_tpd"
      expr: SUM(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Total permitted processing capacity in tons per day across all facilities — the definitive network capacity metric for service planning and regulatory compliance."
    - name: "total_landfill_remaining_capacity_tons"
      expr: SUM(CAST(landfill_remaining_capacity_tons AS DOUBLE))
      comment: "Total remaining landfill capacity in tons across all landfill facilities — a critical strategic metric for long-term capacity planning and new site development decisions."
    - name: "total_site_area_acres"
      expr: SUM(CAST(site_area_acres AS DOUBLE))
      comment: "Total land area of all facilities in acres — measures the physical footprint of the facility network for real estate and environmental impact analysis."
    - name: "avg_permitted_capacity_tpd"
      expr: AVG(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Average permitted daily processing capacity per facility — benchmarks facility scale and identifies capacity expansion opportunities."
    - name: "hazmat_facilities"
      expr: COUNT(CASE WHEN hazmat_facility_flag = TRUE THEN 1 END)
      comment: "Count of facilities designated for hazardous material handling — measures the network's hazmat service capability and associated regulatory compliance scope."
    - name: "iso_14001_certified_facilities"
      expr: COUNT(CASE WHEN iso_14001_certified = TRUE THEN 1 END)
      comment: "Count of facilities with ISO 14001 environmental management certification — tracks environmental management system adoption across the facility network."
$$;
