-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over the equipment asset master. Tracks fleet composition, financial value, utilization lifecycle stage, and compliance posture across the owned and rented fleet. Used by CFO, Fleet Manager, and Project Directors to steer capital allocation, disposal decisions, and maintenance investment."
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (Active, Idle, Under Maintenance, Disposed). Primary filter for fleet availability analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (New, In-Service, End-of-Life, Disposed). Used to segment capital reinvestment decisions."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, rented, or leased. Drives make-vs-buy and fleet strategy decisions."
    - name: "asset_classification"
      expr: classification
      comment: "Asset classification grouping (e.g., Heavy Plant, Light Vehicle, Crane). Enables fleet composition analysis by category."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Emissions compliance tier (e.g., Tier 4, Euro VI). Used for environmental compliance reporting and fleet greening strategy."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired. Enables cohort analysis of fleet age and depreciation cycles."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (Sale, Scrap, Transfer). Informs disposal strategy and residual value recovery."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(1)
      comment: "Total number of assets in the fleet. Baseline measure for fleet size tracking and capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in fleet acquisition. Used by CFO to assess total fleet investment and depreciation base."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Sum of current net book values across all assets. Represents the balance sheet carrying value of the fleet."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds recovered from asset disposals. Measures residual value recovery effectiveness."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Benchmarks capital intensity per unit for procurement negotiations."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average net book value per asset. Indicates average remaining economic value in the fleet."
    - name: "avg_total_operating_hours"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average cumulative operating hours per asset. Proxy for fleet utilization intensity and remaining useful life."
    - name: "total_operating_hours"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Total operating hours logged across all assets. Measures overall fleet productivity output."
    - name: "book_value_to_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of original acquisition cost remaining as book value. Indicates fleet age and depreciation progress; low ratio signals need for fleet renewal."
    - name: "disposal_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disposal_proceeds AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Disposal proceeds as a percentage of original acquisition cost for disposed assets. Measures residual value recovery efficiency."
    - name: "assets_with_expired_insurance_count"
      expr: COUNT(CASE WHEN insurance_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets with expired insurance policies. Critical compliance risk indicator for fleet managers and risk officers."
    - name: "assets_overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets past their next scheduled inspection date. Regulatory compliance risk metric requiring immediate operational action."
    - name: "assets_overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_scheduled_maintenance_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets past their next scheduled maintenance date. Drives maintenance prioritization and downtime risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPI view over daily equipment hours records. Tracks utilization, downtime, idle time, fuel consumption, and cost per hour by project, shift, and asset. Core dashboard for Fleet Managers, Project Managers, and Operations Directors to optimize equipment deployment and reduce idle costs."
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the equipment shift record. Primary time dimension for daily operational trending."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift record. Enables monthly utilization and cost trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (Day, Night, Extended). Used to analyze productivity and cost variation by shift pattern."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of equipment downtime (Mechanical, Operator, Weather, Waiting). Drives root-cause analysis for availability improvement."
    - name: "downtime_root_cause_code"
      expr: downtime_root_cause_code
      comment: "Coded root cause of downtime event. Enables systematic failure pattern analysis to reduce recurring breakdowns."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Owned vs. rented equipment. Enables cost comparison between owned fleet and rental to inform make-vs-buy decisions."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the equipment hours are billable to a client. Separates billable from non-billable utilization for revenue recovery analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Whether the hours were recorded as overtime. Tracks premium-rate equipment usage for cost control."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the shift. Enables correlation analysis between weather and equipment productivity/downtime."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hours record. Filters for approved vs. pending records in financial reporting."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours logged. Primary measure of fleet output and deployment effectiveness."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total hours equipment was unavailable due to breakdowns or maintenance. Key availability risk indicator."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total hours equipment was available but not productively deployed. Measures deployment inefficiency and wasted capacity cost."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total hours equipment was on standby. Standby costs are often contractually billable; tracking prevents revenue leakage."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all equipment hours records. Drives fuel cost management and carbon emission calculations."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost charged across all hours records. Core cost control metric for project budget management."
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average equipment utilization rate (operating hours / available hours). Benchmark KPI for fleet efficiency; low rates trigger redeployment or disposal decisions."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average equipment availability rate (available hours / total hours). Measures maintenance effectiveness; low availability signals maintenance strategy failure."
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour. Benchmarks equipment cost efficiency and informs rental vs. ownership decisions."
    - name: "downtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(downtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE) + CAST(downtime_hours AS DOUBLE) + CAST(idle_hours AS DOUBLE) + CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Downtime hours as a percentage of total scheduled hours. Critical fleet reliability KPI; high rates indicate maintenance investment is needed."
    - name: "idle_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(idle_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE) + CAST(downtime_hours AS DOUBLE) + CAST(idle_hours AS DOUBLE) + CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Idle hours as a percentage of total scheduled hours. Measures deployment planning inefficiency; high idle rates indicate over-allocation or poor scheduling."
    - name: "fuel_consumption_per_operating_hour"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 3)
      comment: "Liters of fuel consumed per operating hour. Efficiency ratio for fuel management; deviations from benchmark indicate mechanical issues or operator behavior problems."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity (e.g., cubic meters excavated, tons hauled). Links equipment hours to physical project progress for productivity analysis."
    - name: "cost_per_production_unit"
      expr: ROUND(SUM(CAST(total_equipment_cost AS DOUBLE)) / NULLIF(SUM(CAST(production_quantity AS DOUBLE)), 0), 2)
      comment: "Equipment cost per unit of production output. Compound efficiency KPI linking cost to physical output; drives equipment selection and method optimization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance performance KPI view over work orders. Tracks maintenance cost, labor efficiency, downtime impact, and compliance across planned and corrective maintenance. Used by Maintenance Managers, Plant Controllers, and HSE teams to optimize maintenance strategy and control costs."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (Preventive, Corrective, Predictive, Statutory). Enables maintenance strategy mix analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (Open, In Progress, Completed, Cancelled). Tracks work order pipeline and backlog."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order (Critical, High, Medium, Low). Enables prioritization analysis and SLA compliance tracking."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the maintenance order was planned to start. Enables monthly maintenance workload and cost trend analysis."
    - name: "failure_code"
      expr: failure_code
      comment: "Coded failure type that triggered the maintenance order. Enables failure pattern analysis for predictive maintenance strategy."
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Whether the order is a statutory/compliance inspection. Separates regulatory maintenance from operational maintenance for compliance reporting."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was raised. Tracks warranty recovery opportunities to reduce net maintenance cost."
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center responsible for executing the maintenance. Enables workload balancing and capacity planning across maintenance teams."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders. Baseline measure for maintenance workload volume and backlog management."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total cost of all maintenance orders including labor, parts, and external services. Primary cost control KPI for fleet maintenance budget."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of maintenance orders. Enables labor vs. parts cost mix analysis for maintenance strategy optimization."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost for maintenance orders. Tracks spare parts spend for inventory and procurement optimization."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external contractor services for maintenance. Measures outsourced maintenance spend for make-vs-buy decisions."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance orders. Measures maintenance workforce capacity consumption."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance events. Quantifies the operational impact of maintenance on project productivity."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average cost per maintenance order. Benchmarks maintenance cost intensity and identifies outlier high-cost events."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance order. Measures maintenance labor efficiency and informs crew sizing decisions."
    - name: "avg_downtime_hours_per_order"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per maintenance event. Key reliability metric; high averages indicate systemic maintenance quality issues."
    - name: "labor_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of total maintenance cost. Indicates labor intensity of maintenance program; high ratios may justify automation or outsourcing."
    - name: "external_services_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(external_services_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "External services cost as a percentage of total maintenance cost. Measures outsourcing dependency in the maintenance program."
    - name: "warranty_claim_order_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of maintenance orders with active warranty claims. Tracks warranty recovery pipeline to reduce net maintenance expenditure."
    - name: "compliance_inspection_order_count"
      expr: COUNT(CASE WHEN compliance_inspection_flag = TRUE THEN 1 END)
      comment: "Number of statutory compliance inspection orders. Ensures regulatory maintenance obligations are being fulfilled and tracked."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet deployment and cost KPI view over fleet assignment records. Tracks equipment allocation efficiency, rental vs. owned cost, utilization against plan, and mobilization costs by project and site. Used by Project Managers and Fleet Controllers to optimize equipment deployment and control rental expenditure."
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (Active, Completed, Cancelled). Tracks active deployment pipeline."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of fleet assignment (Owned, Rental, Hire). Enables cost comparison between owned and rented equipment deployments."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority of the assignment (Critical, High, Normal). Enables prioritization of equipment allocation to high-value project activities."
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Business purpose of the assignment (Excavation, Lifting, Transport, etc.). Links equipment deployment to specific project activities."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Status of equipment mobilization for this assignment. Tracks readiness of equipment to commence productive work."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started. Enables monthly fleet deployment trend analysis."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the assignment rates. Enables multi-currency fleet cost analysis for international projects."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignments. Baseline measure for fleet deployment volume and scheduling activity."
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual hours equipment was productively utilized across all assignments. Measures realized fleet output."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilization hours across all assignments. Baseline for utilization achievement analysis."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across fleet assignments. Measures wasted capacity and deployment planning inefficiency."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total mobilization costs across all fleet assignments. Tracks logistics overhead for equipment deployment decisions."
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total demobilization costs across all fleet assignments. Combined with mobilization cost informs total logistics overhead per assignment."
    - name: "utilization_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_utilization_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_utilization_hours AS DOUBLE)), 0), 2)
      comment: "Actual utilization hours as a percentage of planned utilization hours. Measures deployment planning accuracy; low rates indicate over-allocation or scheduling failures."
    - name: "idle_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(idle_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_utilization_hours AS DOUBLE) + CAST(idle_hours AS DOUBLE)), 0), 2)
      comment: "Idle hours as a percentage of total available hours (actual + idle). High idle rates signal poor deployment planning or project delays impacting equipment productivity."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily hire rate across fleet assignments. Benchmarks rental market rates for procurement negotiation."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating cost rate per hour. Used to benchmark equipment cost efficiency and validate rental vs. ownership decisions."
    - name: "total_logistics_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE) + CAST(demobilization_cost AS DOUBLE))
      comment: "Total logistics cost (mobilization + demobilization) per assignment. Measures total deployment overhead to inform equipment sourcing strategy."
    - name: "distinct_assets_deployed"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets deployed across assignments. Measures active fleet utilization breadth and identifies underdeployed assets."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPI view over fuel transaction records. Tracks fuel spend, carbon emissions, consumption efficiency, and anomaly indicators by project, site, and asset. Used by Fleet Managers, Sustainability Officers, and Project Controllers to manage fuel costs and carbon footprint."
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Date of the fuel transaction. Primary time dimension for daily fuel consumption trending."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the fuel transaction. Enables monthly fuel cost and carbon emission trend analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (Approved, Pending, Rejected). Filters for approved transactions in financial reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the fuel transaction. Tracks unapproved transactions requiring management action."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (Liters, Gallons). Ensures consistent unit analysis across regions."
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Whether the transaction was an emergency refuel. Emergency refuels often carry premium costs and indicate maintenance or planning failures."
    - name: "is_theft_suspected"
      expr: is_theft_suspected
      comment: "Whether fuel theft is suspected for this transaction. Critical fraud and loss control indicator requiring immediate investigation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fuel transaction. Enables multi-currency fuel cost analysis for international projects."
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions. Baseline measure for fuel activity volume and refueling frequency."
    - name: "total_quantity_issued_liters"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel quantity issued across all transactions. Primary consumption metric for fuel budget management."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure across all transactions. Core cost control KPI for project fuel budget management."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions (kg CO2e) from fuel consumption. Sustainability KPI for carbon reporting and net-zero target tracking."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel cost per unit (liter/gallon). Benchmarks fuel procurement efficiency and detects price anomalies."
    - name: "avg_carbon_emission_per_liter"
      expr: ROUND(SUM(CAST(carbon_emission_kg AS DOUBLE)) / NULLIF(SUM(CAST(quantity_issued AS DOUBLE)), 0), 4)
      comment: "Average carbon emission per liter of fuel consumed. Measures fleet carbon intensity; deviations indicate fuel type changes or equipment efficiency issues."
    - name: "suspected_theft_transaction_count"
      expr: COUNT(CASE WHEN is_theft_suspected = TRUE THEN 1 END)
      comment: "Number of transactions flagged as suspected fuel theft. Critical fraud risk KPI requiring immediate investigation and loss quantification."
    - name: "suspected_theft_fuel_cost"
      expr: SUM(CASE WHEN is_theft_suspected = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of fuel transactions flagged as suspected theft. Quantifies financial exposure from fuel theft for risk management."
    - name: "emergency_refuel_count"
      expr: COUNT(CASE WHEN is_emergency_refuel = TRUE THEN 1 END)
      comment: "Number of emergency refueling events. High counts indicate maintenance failures or poor fuel planning, both of which carry premium costs."
    - name: "emergency_refuel_cost"
      expr: SUM(CASE WHEN is_emergency_refuel = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of emergency refueling events. Quantifies the premium cost of unplanned refueling for maintenance and planning improvement ROI."
    - name: "distinct_assets_refueled"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that received fuel. Measures active fleet fuel consumption breadth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation KPI view over asset valuation records. Tracks depreciation, impairment, fair market value, and residual value across the fleet. Used by CFO, Finance Controllers, and Asset Managers for balance sheet management, impairment testing, and capital planning."
  source: "`vibe_construction_v1`.`equipment`.`asset_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (Active, Superseded, Draft). Filters for current active valuations in financial reporting."
    - name: "valuation_source"
      expr: valuation_source
      comment: "Source of the valuation (Internal, External Appraiser, Market). Indicates valuation reliability and methodology."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance, Units of Production). Enables depreciation policy analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the asset being valued. Segments valuation analysis by owned vs. finance-leased assets."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for valuation grouping. Enables balance sheet analysis by asset class for financial reporting."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Whether the asset has been identified as impaired. Critical flag for balance sheet integrity and financial reporting compliance."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation. Enables point-in-time fleet value analysis and revaluation cycle tracking."
    - name: "valuation_currency_code"
      expr: valuation_currency_code
      comment: "Currency of the valuation. Enables multi-currency fleet value consolidation for group reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all valued assets. Represents gross asset value on the balance sheet."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total net book value of all assets. Represents the carrying value of the fleet on the balance sheet."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets. Measures total economic consumption of the fleet investment."
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of all assets. Enables comparison of book value vs. market value for impairment and disposal decisions."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized across the fleet. Measures write-down exposure for financial risk management."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value at end of useful life. Used in depreciation calculations and disposal planning."
    - name: "total_insurance_replacement_value"
      expr: SUM(CAST(insurance_replacement_value AS DOUBLE))
      comment: "Total insurance replacement value of the fleet. Ensures adequate insurance coverage relative to replacement cost."
    - name: "avg_depreciation_rate_pct"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate across all assets. Benchmarks depreciation policy consistency and identifies outlier rates."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across the fleet. Strategic KPI for fleet renewal planning and capital expenditure forecasting."
    - name: "book_value_to_market_value_ratio"
      expr: ROUND(SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(fair_market_value AS DOUBLE)), 0), 4)
      comment: "Ratio of net book value to fair market value. Values below 1.0 indicate potential impairment; values above 1.0 indicate undervalued assets with disposal upside."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets identified as impaired. Tracks balance sheet risk exposure requiring write-down recognition."
    - name: "depreciation_coverage_ratio"
      expr: ROUND(SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 4)
      comment: "Accumulated depreciation as a proportion of acquisition cost. Measures fleet age and remaining depreciable base; high ratios signal fleet renewal urgency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection compliance and quality KPI view. Tracks inspection outcomes, defect rates, overdue inspections, and compliance certificate status. Used by HSE Managers, Compliance Officers, and Fleet Managers to ensure regulatory compliance and prevent equipment-related incidents."
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Statutory, Preventive, Pre-Operational, Post-Incident). Enables compliance vs. operational inspection analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (Completed, Pending, Overdue, Failed). Tracks inspection pipeline and compliance gaps."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (Pass, Fail, Conditional Pass). Primary quality indicator for equipment safety compliance."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection. Enables monthly inspection volume and compliance trend analysis."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of compliance certificate issued (Lifting, Pressure Vessel, Electrical, etc.). Tracks statutory certification compliance by category."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a compliance certificate was issued following the inspection. Measures certification completion rate."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records. Baseline measure for inspection program activity volume."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of all equipment inspections. Tracks inspection program expenditure for budget management."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection. Benchmarks inspection cost efficiency and identifies high-cost inspection types."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that resulted in a pass outcome. Core equipment safety compliance KPI; low pass rates indicate systemic maintenance quality issues."
    - name: "inspection_fail_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Fail' THEN 1 END)
      comment: "Number of failed inspections. Tracks equipment safety non-compliance requiring immediate corrective action."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in certificate issuance. Measures statutory certification completion rate for regulatory compliance."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() AND inspection_status != 'Completed' THEN 1 END)
      comment: "Number of inspections past their due date and not yet completed. Critical compliance risk indicator; overdue statutory inspections create legal liability."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment operating hours at time of inspection. Validates that hour-based inspection intervals are being adhered to."
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that have been inspected. Measures inspection program coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rental cost and contract performance KPI view over equipment rental agreements. Tracks committed rental spend, rate benchmarks, mobilization costs, and rental status. Used by Procurement Managers, Project Controllers, and Fleet Managers to optimize rental expenditure and vendor negotiations."
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of the rental agreement (Active, Expired, Cancelled, Pending). Tracks active rental commitments and pipeline."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment being rented. Enables rental spend analysis by equipment category for procurement strategy."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the rental (Daily, Weekly, Monthly). Enables cash flow planning and billing cycle analysis."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Who is responsible for maintenance (Owner, Renter). Impacts total cost of ownership calculation for rental vs. owned decisions."
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Whether the operator is supplied by the rental vendor. Affects total labor cost and operator management overhead."
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Whether fuel is included in the rental rate. Impacts true cost comparison between rental options."
    - name: "rental_start_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month the rental agreement commenced. Enables monthly rental commitment trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rental agreement. Enables multi-currency rental cost consolidation."
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements. Baseline measure for rental fleet size and vendor relationship breadth."
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed cost across all rental agreements. Core financial commitment KPI for project budget management and cash flow forecasting."
    - name: "total_mobilization_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilization charges across all rental agreements. Tracks logistics overhead in rental procurement."
    - name: "total_demobilization_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilization charges across all rental agreements. Combined with mobilization charges measures total logistics cost of rental fleet."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across active rental agreements. Tracks working capital tied up in rental security deposits."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate across rental agreements. Benchmarks rental market rates for procurement negotiation and vendor comparison."
    - name: "avg_weekly_hire_rate"
      expr: AVG(CAST(weekly_hire_rate AS DOUBLE))
      comment: "Average weekly hire rate across rental agreements. Enables rate benchmarking for longer-duration rental negotiations."
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate across rental agreements. Benchmarks long-term rental rates for lease vs. buy analysis."
    - name: "total_damage_waiver_cost"
      expr: SUM(CAST(damage_waiver_amount AS DOUBLE))
      comment: "Total damage waiver charges across rental agreements. Tracks insurance/risk cost component of rental spend."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct rental vendors. Measures vendor concentration risk in the rental fleet supply chain."
    - name: "logistics_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(mobilization_charge AS DOUBLE) + CAST(demobilization_charge AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_cost AS DOUBLE)), 0), 2)
      comment: "Logistics costs (mobilization + demobilization) as a percentage of total committed rental cost. High ratios indicate that short-duration rentals are inefficient due to logistics overhead."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning KPI view. Tracks planned maintenance coverage, cost estimates, safety-critical plan compliance, and scheduling adherence. Used by Maintenance Managers and Plant Engineers to optimize preventive maintenance programs and reduce corrective maintenance costs."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of maintenance plan (Time-Based, Meter-Based, Condition-Based). Enables maintenance strategy mix analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the maintenance plan (Active, Inactive, Draft). Filters for active plans in compliance reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the maintenance plan (Critical, High, Medium, Low). Enables prioritization of maintenance resource allocation."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Whether the maintenance plan covers safety-critical equipment. Safety-critical plans require stricter compliance monitoring."
    - name: "scheduling_strategy"
      expr: scheduling_strategy
      comment: "Scheduling strategy for the plan (Fixed, Floating, Performance-Based). Enables maintenance scheduling optimization analysis."
    - name: "manufacturer_recommendation_flag"
      expr: manufacturer_recommendation_flag
      comment: "Whether the plan follows manufacturer recommendations. Tracks warranty compliance and best-practice maintenance adherence."
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of the maintenance interval (Days, Hours, Kilometers). Enables analysis of maintenance frequency by interval type."
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(1)
      comment: "Total number of maintenance plans. Baseline measure for preventive maintenance program coverage."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all maintenance plans. Enables preventive maintenance budget forecasting."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material/parts cost across all maintenance plans. Drives spare parts inventory planning and procurement."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned maintenance. Enables project scheduling to account for planned equipment unavailability."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per maintenance plan execution. Benchmarks maintenance task complexity and crew sizing requirements."
    - name: "avg_interval_value"
      expr: AVG(CAST(interval_value AS DOUBLE))
      comment: "Average maintenance interval value. Measures maintenance frequency intensity across the fleet maintenance program."
    - name: "safety_critical_plan_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Number of safety-critical maintenance plans. Tracks the volume of HSE-mandatory maintenance obligations requiring strict compliance."
    - name: "overdue_plan_count"
      expr: COUNT(CASE WHEN next_scheduled_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END)
      comment: "Number of active maintenance plans past their next scheduled execution date. Critical compliance risk indicator; overdue safety-critical plans create legal and safety liability."
    - name: "plans_requiring_certification_count"
      expr: COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END)
      comment: "Number of maintenance plans requiring certified technicians. Drives workforce certification planning and resource allocation."
    - name: "total_estimated_total_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE) + CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated cost (labor + materials) across all maintenance plans. Provides full preventive maintenance budget forecast for financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_telematics_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time equipment telematics KPI view over IoT sensor readings. Tracks engine performance, fuel efficiency, fault events, idle time, and geofence compliance. Used by Fleet Operations Centers, Maintenance Engineers, and Project Managers for real-time fleet monitoring and predictive maintenance."
  source: "`vibe_construction_v1`.`equipment`.`telematics_reading`"
  dimensions:
    - name: "reading_date"
      expr: DATE_TRUNC('DAY', reading_timestamp)
      comment: "Date of the telematics reading. Primary time dimension for daily fleet performance trending."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the telematics reading. Enables monthly fleet performance and fuel efficiency trend analysis."
    - name: "operational_state"
      expr: operational_state
      comment: "Operational state of the asset at time of reading (Operating, Idle, Off, Fault). Enables real-time fleet state distribution analysis."
    - name: "fault_severity"
      expr: fault_severity
      comment: "Severity of any fault detected (Critical, Major, Minor, None). Enables fault triage and maintenance prioritization."
    - name: "fault_code"
      expr: fault_code
      comment: "Diagnostic fault code from the telematics system. Enables pattern analysis of recurring faults for predictive maintenance."
    - name: "geofence_status"
      expr: geofence_status
      comment: "Whether the asset is inside or outside its assigned geofence. Tracks unauthorized equipment movement and site security compliance."
    - name: "reading_quality"
      expr: reading_quality
      comment: "Quality indicator of the telematics reading (Good, Degraded, Poor). Filters for reliable data in performance analysis."
    - name: "data_source"
      expr: data_source
      comment: "Source system of the telematics data (GPS, CAN Bus, OBD). Enables data quality analysis by source system."
  measures:
    - name: "total_telematics_readings"
      expr: COUNT(1)
      comment: "Total number of telematics readings. Baseline measure for telematics data coverage and device connectivity."
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours recorded via telematics. Authoritative source for equipment utilization and maintenance interval tracking."
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed as measured by telematics sensors. Enables real-time fuel consumption monitoring and theft detection."
    - name: "total_idle_time_minutes"
      expr: SUM(CAST(idle_time_minutes AS DOUBLE))
      comment: "Total idle time in minutes recorded by telematics. Measures wasted fuel and emissions from unnecessary idling."
    - name: "avg_fuel_level_pct"
      expr: AVG(CAST(fuel_level_percent AS DOUBLE))
      comment: "Average fuel tank level percentage across readings. Enables proactive refueling scheduling to prevent operational stoppages."
    - name: "avg_speed_kmh"
      expr: AVG(CAST(speed_kmh AS DOUBLE))
      comment: "Average equipment speed in km/h. Monitors operator behavior and site speed limit compliance."
    - name: "avg_payload_weight_kg"
      expr: AVG(CAST(payload_weight_kg AS DOUBLE))
      comment: "Average payload weight per telematics reading. Measures equipment loading efficiency and overloading risk."
    - name: "fault_event_count"
      expr: COUNT(CASE WHEN fault_code IS NOT NULL AND fault_code != '' THEN 1 END)
      comment: "Number of telematics readings with active fault codes. Measures fleet fault frequency for predictive maintenance prioritization."
    - name: "geofence_breach_count"
      expr: COUNT(CASE WHEN geofence_status = 'Outside' THEN 1 END)
      comment: "Number of readings where the asset was outside its assigned geofence. Tracks unauthorized equipment movement and site security violations."
    - name: "fuel_consumption_per_engine_hour"
      expr: ROUND(SUM(CAST(fuel_consumed_liters AS DOUBLE)) / NULLIF(SUM(CAST(engine_hours AS DOUBLE)), 0), 3)
      comment: "Liters of fuel consumed per engine hour from telematics data. Real-time efficiency KPI; deviations from baseline indicate mechanical issues or operator behavior problems requiring intervention."
    - name: "idle_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(idle_time_minutes AS DOUBLE)) / NULLIF(SUM(CAST(engine_hours AS DOUBLE) * 60.0), 0), 2)
      comment: "Idle time as a percentage of total engine-on time. High idle rates indicate poor operator discipline or project delays; directly impacts fuel cost and carbon emissions."
    - name: "distinct_assets_tracked"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with telematics readings. Measures telematics device coverage across the fleet for connectivity monitoring."
$$;