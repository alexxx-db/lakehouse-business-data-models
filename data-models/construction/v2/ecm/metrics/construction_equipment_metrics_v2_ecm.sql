-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet-level KPIs over the master asset register — acquisition cost, book value, disposal proceeds, and fleet composition dimensions used by asset managers and CFOs to steer capital allocation and lifecycle decisions."
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Operational status of the asset (e.g. Active, Idle, Disposed) — primary filter for fleet availability analysis."
    - name: "asset_category_id"
      expr: asset_category_id
      comment: "Foreign key to asset category — enables grouping of KPIs by equipment class (crane, excavator, etc.)."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Owned vs. rented vs. leased — critical for make-vs-buy and capital vs. opex decisions."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (Commissioning, In-Service, End-of-Life) — drives replacement planning."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Emissions compliance tier of the asset — used for environmental reporting and fleet greening strategy."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired — enables vintage analysis and depreciation cohort tracking."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How the asset was disposed (Sale, Scrap, Transfer) — informs residual value recovery strategy."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the asset is currently assigned to — enables project-level fleet cost attribution."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(1)
      comment: "Total number of assets in the register — baseline fleet size metric for capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in the fleet — key input for balance sheet and capital expenditure reporting."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate net book value of all assets — reflects remaining economic value of the fleet on the balance sheet."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total cash recovered from asset disposals — measures residual value realisation effectiveness."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset — benchmark for procurement negotiations and budget forecasting."
    - name: "avg_total_operating_hours"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average lifetime operating hours per asset — proxy for asset utilisation intensity and remaining useful life."
    - name: "total_operating_hours_fleet"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Cumulative operating hours across the entire fleet — used to schedule fleet-wide maintenance windows."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN 1 END)
      comment: "Number of assets currently in active service — denominator for utilisation rate calculations."
    - name: "disposed_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'Disposed' THEN 1 END)
      comment: "Number of disposed assets — tracks fleet attrition rate and replacement pipeline demand."
    - name: "avg_book_value_per_asset"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average net book value per asset — used to assess fleet age and impairment risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset valuation and depreciation KPIs — used by finance, asset management, and CFOs to track fleet book value, depreciation, impairment, and fair market value for balance sheet management and capital planning."
  source: "`vibe_construction_v1`.`equipment`.`asset_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (Current, Superseded, Draft) — filters for active valuation data."
    - name: "valuation_source"
      expr: valuation_source
      comment: "Source of the valuation (Internal, External Appraiser, Market) — indicates valuation reliability."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance, Units of Production) — affects book value trajectory."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Owned vs. leased — separates capital assets from right-of-use assets for accounting purposes."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for financial reporting — enables balance sheet segmentation by asset type."
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation — enables year-over-year book value trend analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Whether the asset has been flagged for impairment — critical financial risk dimension."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being valued — enables per-machine financial performance tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of valued assets — gross asset value for balance sheet reporting."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total net book value of the fleet — primary balance sheet asset value metric."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures economic consumption of the fleet over time."
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of the fleet — used for insurance, disposal, and refinancing decisions."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised — P&L impact metric for asset write-downs."
    - name: "total_insurance_replacement_value"
      expr: SUM(CAST(insurance_replacement_value AS DOUBLE))
      comment: "Total insurance replacement value — ensures adequate insurance coverage for the fleet."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across the fleet — drives capital replacement planning and budget forecasting."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets flagged for impairment — financial risk KPI requiring executive attention."
    - name: "avg_depreciation_rate_percent"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate across the fleet — used to validate depreciation policy consistency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment mobilisation and logistics KPIs — used by project managers and logistics coordinators to track mobilisation cost, transit performance, and permit compliance for fleet movements between sites."
  source: "`vibe_construction_v1`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Status of the mobilisation event (Planned, In Transit, Arrived, Cancelled) — primary filter for live fleet movements."
    - name: "event_type"
      expr: event_type
      comment: "Type of mobilisation event (Mobilise, Demobilise, Transfer) — classifies fleet movement direction."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Destination project — enables project-level mobilisation cost attribution."
    - name: "transport_method"
      expr: transport_method
      comment: "Mode of transport (Road, Rail, Sea) — enables cost and transit time analysis by transport mode."
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether a transport permit is required — identifies high-risk oversized load movements."
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether insurance coverage is confirmed for the movement — risk management compliance dimension."
    - name: "planned_dispatch_month"
      expr: DATE_TRUNC('MONTH', planned_dispatch_date)
      comment: "Month of planned dispatch — supports monthly logistics planning and cost forecasting."
  measures:
    - name: "total_mobilizations"
      expr: COUNT(1)
      comment: "Total mobilisation events — baseline logistics activity metric."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total transport cost for equipment movements — key logistics cost KPI for project budget control."
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost AS DOUBLE))
      comment: "Average transport cost per mobilisation — benchmark for logistics procurement and budget rate-setting."
    - name: "total_actual_transit_hours"
      expr: SUM(CAST(actual_transit_hours AS DOUBLE))
      comment: "Total actual transit hours — measures logistics time consumption across all fleet movements."
    - name: "total_estimated_transit_hours"
      expr: SUM(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Total estimated transit hours — denominator for transit time accuracy analysis."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered by fleet movements — logistics scale metric and carbon footprint input."
    - name: "permit_required_count"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN 1 END)
      comment: "Number of movements requiring transport permits — compliance workload metric for logistics teams."
    - name: "distinct_assets_mobilized"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets mobilised — measures fleet movement breadth across the project portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_mobilization_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and efficiency of equipment mobilization activities"
  source: "`construction_ecm`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset being mobilized"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with mobilization"
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilization"
    - name: "transport_method"
      expr: transport_method
      comment: "Method used for transport (e.g., truck, rail)"
    - name: "planned_dispatch_month"
      expr: DATE_TRUNC('month', planned_dispatch_date)
      comment: "Planned month of dispatch"
  measures:
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total cost incurred for transporting equipment"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Aggregate distance covered during mobilizations"
    - name: "average_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet deployment and cost KPIs at the assignment level — used by project managers and plant controllers to track planned vs. actual utilisation, mobilisation costs, and idle time across projects and work fronts."
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (Active, Completed, Cancelled) — primary filter for live deployment view."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (Owned, Rented, Transferred) — enables cost-type segmentation."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the asset is assigned to — core dimension for project-level fleet cost reporting."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being assigned — enables per-machine utilisation and cost drill-down."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started — supports monthly fleet deployment trend analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation state of the assignment — tracks readiness of deployed fleet."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment — enables prioritisation of high-criticality equipment deployments."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the assignment is charged to — enables WBS-level equipment cost attribution."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignments — baseline deployment volume metric."
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual hours the asset was utilised during the assignment — primary productivity measure."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilisation hours — denominator for utilisation achievement rate."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across assignments — measures unproductive standby cost."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total mobilisation cost — significant upfront cost driver for project equipment budgets."
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total demobilisation cost — project closeout cost component for equipment."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily hire rate across assignments — benchmark for rental procurement negotiations."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating rate per hour — used to validate cost codes and budget rate assumptions."
    - name: "distinct_assets_deployed"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets deployed — measures fleet breadth across projects and work fronts."
    - name: "distinct_projects_served"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects receiving equipment — indicates fleet sharing and cross-project utilisation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_fuel_spending`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption cost and environmental impact"
  source: "`construction_ecm`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset linked to the fuel transaction"
    - name: "fuel_point_id"
      expr: fuel_point_id
      comment: "Fuel point (tank) identifier"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the fuel transaction"
    - name: "currency"
      expr: currency_code
      comment: "Currency used for the transaction"
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Flag indicating emergency refuel"
  measures:
    - name: "total_fuel_spent"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total monetary spend on fuel"
    - name: "total_quantity_issued_liters"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total volume of fuel issued (liters)"
    - name: "average_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per unit of fuel"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions associated with fuel transactions"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPIs — used by plant managers, sustainability leads, and project controllers to monitor fuel spend, carbon emissions, and consumption efficiency across the fleet."
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of the fuel transaction — enables daily and weekly fuel consumption trend analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the fuel transaction — supports monthly fuel budget reporting."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset refuelled — enables per-machine fuel consumption and cost analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the fuel is charged to — supports project-level fuel cost attribution."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (Approved, Pending, Rejected) — filters for validated cost records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the transaction — separates approved from pending fuel costs."
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Whether the refuel was an emergency — identifies unplanned fuel events that may indicate operational issues."
    - name: "fuel_point_id"
      expr: fuel_point_id
      comment: "Fuel point used — enables analysis of consumption by fuel station or site depot."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity — ensures consistent aggregation across fuel types."
  measures:
    - name: "total_fuel_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel volume dispensed — primary consumption metric for fuel budget and sustainability reporting."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure — key project operating cost component; monitored against budget."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions from fuel consumption — ESG and sustainability reporting KPI."
    - name: "avg_unit_cost_per_liter"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost — tracks price trends and validates supplier pricing against market benchmarks."
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions — baseline volume metric for fuel management activity."
    - name: "distinct_assets_refuelled"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets refuelled — measures fleet fuel coverage and identifies assets with no fuel records."
    - name: "emergency_refuel_count"
      expr: COUNT(CASE WHEN is_emergency_refuel = TRUE THEN 1 END)
      comment: "Number of emergency refuels — high values indicate poor fuel planning or operational disruptions."
    - name: "avg_fuel_quantity_per_transaction"
      expr: AVG(CAST(quantity_issued AS DOUBLE))
      comment: "Average fuel quantity per transaction — detects anomalous fill events that may indicate theft or meter errors."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_asset_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and usage of equipment"
  source: "`construction_ecm`.`equipment`.`hours`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Unique identifier of the equipment asset"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with the hours"
    - name: "shift_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., day, night)"
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Cumulative operating hours for assets"
    - name: "average_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average utilization rate across assets"
    - name: "average_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average availability rate across assets"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed (liters) by assets"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours recorded"
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Aggregate equipment cost for the period"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level equipment utilisation and cost KPIs — the primary operational dashboard for plant managers, project controls, and CFOs tracking equipment productivity, downtime, and cost per operating hour."
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — enables daily and weekly trend analysis of equipment utilisation."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift — supports monthly KPI roll-ups for project cost reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Day/Night/Weekend shift classification — identifies productivity differentials across shift patterns."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier — enables per-machine performance drill-down."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the hours are charged to — supports project-level equipment cost attribution."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Owned vs. rented — enables cost comparison between owned and hired plant."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Root-cause category of downtime (Mechanical, Operational, Weather) — drives targeted reliability improvement."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the hours record — filters for approved vs. pending records in cost reporting."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the hours are billable to the client — separates billable from non-billable equipment cost."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather during the shift — correlates downtime and productivity loss with adverse weather events."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours — primary measure of equipment output and fleet deployment intensity."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total hours lost to downtime — key reliability KPI; high values trigger maintenance or replacement decisions."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours — measures unproductive standby time; high idle hours indicate over-deployment or scheduling inefficiency."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours — distinguishes planned standby (e.g. awaiting work front) from unplanned idle time."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost charged in the period — primary cost KPI for project budget control."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed — drives fuel budget forecasting and carbon emission calculations."
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average utilisation rate across all hour records — headline fleet productivity KPI; below benchmark triggers redeployment."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average mechanical availability rate — measures maintenance effectiveness; low values indicate reliability risk."
    - name: "avg_cost_per_operating_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour — benchmark for rental vs. ownership decisions and budget rate-setting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output (e.g. m³ excavated, tonnes hauled) — links equipment hours to physical progress."
    - name: "downtime_record_count"
      expr: COUNT(CASE WHEN downtime_hours > 0 THEN 1 END)
      comment: "Number of shifts with recorded downtime — frequency metric for reliability trend analysis."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_inspection_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and cost of equipment inspections"
  source: "`construction_ecm`.`equipment`.`inspection_record`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset inspected"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type/category of inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month when the inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Number of inspection records captured"
    - name: "average_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection"
    - name: "failed_inspections"
      expr: SUM(CASE WHEN inspection_outcome = 'Failed' THEN 1 ELSE 0 END)
      comment: "Count of inspections that resulted in a failure outcome"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection compliance and cost KPIs — used by HSE managers, plant engineers, and compliance officers to track inspection frequency, outcomes, defect rates, and regulatory compliance."
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (Scheduled, Completed, Overdue, Failed) — primary compliance filter."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Statutory, Preventive, Pre-Mobilisation) — classifies regulatory vs. operational inspections."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (Pass, Fail, Conditional Pass) — key quality and compliance KPI dimension."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset inspected — enables per-machine compliance tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project where the inspection occurred — supports project-level compliance reporting."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection — supports monthly inspection programme adherence reporting."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a compliance certificate was issued — tracks certification coverage of the fleet."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspections conducted — baseline compliance activity metric."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of inspections — tracks compliance expenditure against budget."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Fail' THEN 1 END)
      comment: "Number of failed inspections — critical safety and compliance KPI; triggers corrective action."
    - name: "certificate_issued_count"
      expr: COUNT(CASE WHEN certificate_issued_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a compliance certificate — measures certification achievement rate."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection — benchmark for compliance budget planning."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average asset hours at time of inspection — validates inspection interval compliance against hour-based schedules."
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets inspected — measures inspection programme coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fault and breakdown notification KPIs — tracks fault frequency, breakdown duration, and safety-related events. Used by reliability engineers and maintenance planners to prioritise corrective actions and reduce unplanned downtime."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Status of the notification (Open, In Progress, Completed) — primary filter for open fault backlog."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of notification (Breakdown, Malfunction, Activity) — classifies fault severity and urgency."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the notification — enables triage of critical vs. routine faults."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset with the fault — enables per-machine reliability analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project where the fault occurred — supports project-level reliability reporting."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the fault was reported — supports monthly fault trend analysis."
    - name: "breakdown_indicator"
      expr: breakdown_indicator
      comment: "Whether the notification represents a full breakdown — separates breakdowns from minor faults."
    - name: "safety_related_flag"
      expr: safety_related_flag
      comment: "Whether the fault has a safety implication — critical filter for HSE reporting and risk management."
    - name: "fault_code"
      expr: fault_code
      comment: "Standardised fault code — enables Pareto analysis of recurring fault types."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total fault notifications raised — baseline reliability metric; high volumes indicate fleet reliability issues."
    - name: "total_actual_downtime_hours"
      expr: SUM(CAST(actual_downtime_hours AS DOUBLE))
      comment: "Total actual downtime hours from faults — primary reliability impact KPI for production loss assessment."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime at notification — used to assess planning accuracy vs. actual downtime."
    - name: "breakdown_count"
      expr: COUNT(CASE WHEN breakdown_indicator = TRUE THEN 1 END)
      comment: "Number of full breakdown events — headline fleet reliability KPI; drives maintenance strategy review."
    - name: "safety_related_notification_count"
      expr: COUNT(CASE WHEN safety_related_flag = TRUE THEN 1 END)
      comment: "Number of safety-related fault notifications — HSE KPI; any increase triggers immediate investigation."
    - name: "avg_actual_downtime_per_notification"
      expr: AVG(CAST(actual_downtime_hours AS DOUBLE))
      comment: "Average downtime per fault notification — measures severity of individual fault events."
    - name: "distinct_assets_with_faults"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with fault notifications — measures breadth of reliability issues across the fleet."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational impact of equipment maintenance"
  source: "`construction_ecm`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset under maintenance"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with the maintenance"
    - name: "maintenance_priority"
      expr: priority
      comment: "Priority level of the maintenance order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order"
  measures:
    - name: "total_maintenance_spend"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance orders"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Aggregate labor cost across maintenance orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Aggregate parts cost across maintenance orders"
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Cost of external services used in maintenance"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours due to maintenance"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution KPIs — tracks cost, labour, downtime, and compliance across all maintenance work orders. Used by maintenance managers and project controllers to control maintenance spend and asset reliability."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the maintenance order (Open, In Progress, Completed, Closed) — primary filter for backlog and completion analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance (Preventive, Corrective, Predictive, Statutory) — enables cost and frequency analysis by maintenance strategy."
    - name: "priority"
      expr: priority
      comment: "Priority of the maintenance order — identifies critical vs. routine work for resource scheduling."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being maintained — enables per-machine maintenance cost and reliability tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the maintenance is charged to — supports project-level maintenance cost attribution."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the maintenance was planned to start — supports monthly maintenance schedule adherence reporting."
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Whether the order is a statutory compliance inspection — separates regulatory from operational maintenance."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was raised — tracks warranty recovery value."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders — baseline volume metric for maintenance workload management."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance expenditure — primary cost KPI for maintenance budget control and variance analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labour cost component of maintenance — enables labour vs. parts cost split analysis."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost — tracks spare parts spend and informs inventory stocking decisions."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external contractor services — measures outsourced maintenance spend."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total asset downtime caused by maintenance — key reliability KPI; high values indicate maintenance backlog risk."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours expended on maintenance — resource consumption metric for workforce planning."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average cost per maintenance order — benchmark for maintenance efficiency and budget rate-setting."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of orders with warranty claims raised — tracks warranty recovery opportunities."
    - name: "compliance_inspection_count"
      expr: COUNT(CASE WHEN compliance_inspection_flag = TRUE THEN 1 END)
      comment: "Number of statutory compliance inspections completed — regulatory adherence KPI."
    - name: "distinct_assets_maintained"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets that received maintenance — measures maintenance programme coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_operator_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operator certification compliance KPIs — used by HSE managers and workforce planners to track certification coverage, expiry risk, and training investment across the equipment operator workforce."
  source: "`vibe_construction_v1`.`equipment`.`operator_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Status of the certification (Valid, Expired, Suspended, Pending) — primary compliance filter."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of operator certification (e.g. Crane, Forklift, Explosive Handling) — enables coverage analysis by equipment type."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification (Basic, Advanced, Master) — supports workforce capability assessment."
    - name: "asset_category_id"
      expr: asset_category_id
      comment: "Equipment category the certification covers — links operator qualifications to fleet deployment requirements."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Issuing authority for the certification — enables analysis by accreditation body."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires — enables forward-looking expiry risk analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the certification has been independently verified — compliance assurance dimension."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Whether medical clearance is required for this certification — identifies operators needing medical compliance tracking."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total operator certifications on record — baseline metric for certification programme scale."
    - name: "valid_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Valid' THEN 1 END)
      comment: "Number of currently valid certifications — compliance coverage KPI; low values indicate workforce readiness risk."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications — critical HSE and legal compliance risk indicator."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in operator certifications — training and compliance cost KPI."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification — benchmark for training budget planning."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours invested in operator certifications — workforce development investment metric."
    - name: "avg_theory_assessment_score"
      expr: AVG(CAST(theory_assessment_score AS DOUBLE))
      comment: "Average theory assessment score — measures training quality and operator knowledge levels."
    - name: "avg_practical_assessment_score"
      expr: AVG(CAST(practical_assessment_score AS DOUBLE))
      comment: "Average practical assessment score — measures hands-on competency of certified operators."
    - name: "distinct_certified_operators"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Number of unique certified operators — measures certified workforce size for deployment planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment rental cost and commitment KPIs — used by procurement, project controls, and CFOs to manage rental spend, track committed costs, and optimise the owned vs. rented fleet mix."
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Status of the rental agreement (Active, Expired, Cancelled) — primary filter for live rental commitments."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the rental is charged to — enables project-level rental cost attribution."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment rented — enables rental spend analysis by equipment category."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle (Daily, Weekly, Monthly) — impacts cash flow forecasting for rental commitments."
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Whether the vendor supplies the operator — distinguishes wet hire from dry hire for labour cost analysis."
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Whether fuel is included in the rental rate — affects total cost of ownership comparison."
    - name: "rental_start_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month the rental commenced — supports monthly rental commitment trend analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Rental vendor — enables vendor-level spend analysis and supplier performance tracking."
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements — baseline metric for rental programme scale."
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed rental cost across all agreements — key financial exposure metric for project cost-at-completion."
    - name: "total_mobilization_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilisation charges — upfront cost component of rental agreements."
    - name: "total_demobilization_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilisation charges — closeout cost component of rental agreements."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate — benchmark for rental procurement negotiations and market rate validation."
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate — used for long-term rental cost forecasting."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held — cash flow impact metric for rental programme management."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct rental vendors — measures supplier concentration risk in the rental portfolio."
    - name: "active_rental_count"
      expr: COUNT(CASE WHEN rental_status = 'Active' THEN 1 END)
      comment: "Number of currently active rental agreements — live rental fleet size metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_telematics_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time telematics and IoT KPIs — used by plant managers and operations teams to monitor live fleet health, fuel consumption, idle time, and fault events from connected equipment sensors."
  source: "`vibe_construction_v1`.`equipment`.`telematics_reading`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset generating the telematics data — primary dimension for per-machine performance monitoring."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the asset is operating on — enables project-level telematics aggregation."
    - name: "operational_state"
      expr: operational_state
      comment: "Current operational state of the asset (Working, Idle, Off) — primary utilisation classification."
    - name: "reading_date"
      expr: DATE(reading_timestamp)
      comment: "Date of the telematics reading — enables daily operational trend analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the reading — supports monthly fleet health reporting."
    - name: "fault_severity"
      expr: fault_severity
      comment: "Severity of any fault detected (Critical, Warning, Info) — enables prioritisation of maintenance response."
    - name: "geofence_status"
      expr: geofence_status
      comment: "Whether the asset is inside or outside its designated geofence — security and compliance dimension."
    - name: "reading_quality"
      expr: reading_quality
      comment: "Quality of the telematics reading (Good, Degraded, Poor) — filters for reliable data in analytics."
  measures:
    - name: "total_telematics_readings"
      expr: COUNT(1)
      comment: "Total telematics readings received — measures IoT data coverage and device connectivity health."
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed as measured by telematics — real-time fuel consumption KPI for sustainability and cost control."
    - name: "total_idle_time_minutes"
      expr: SUM(CAST(idle_time_minutes AS DOUBLE))
      comment: "Total idle time recorded by telematics — measures unproductive engine-on time; high values drive operator behaviour interventions."
    - name: "avg_fuel_level_percent"
      expr: AVG(CAST(fuel_level_percent AS DOUBLE))
      comment: "Average fuel level across readings — operational readiness metric; low averages trigger refuelling logistics."
    - name: "avg_engine_hours"
      expr: AVG(CAST(engine_hours AS DOUBLE))
      comment: "Average engine hours at time of reading — proxy for asset utilisation intensity."
    - name: "avg_speed_kmh"
      expr: AVG(CAST(speed_kmh AS DOUBLE))
      comment: "Average operating speed — safety compliance metric; high averages may indicate speeding violations."
    - name: "fault_reading_count"
      expr: COUNT(CASE WHEN fault_code IS NOT NULL THEN 1 END)
      comment: "Number of readings with active fault codes — real-time fleet health KPI; spikes trigger immediate maintenance dispatch."
    - name: "distinct_assets_tracked"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with telematics data — measures IoT fleet coverage and device deployment completeness."
    - name: "avg_payload_weight_kg"
      expr: AVG(CAST(payload_weight_kg AS DOUBLE))
      comment: "Average payload weight from telematics — measures asset loading efficiency and overload risk."
$$;
