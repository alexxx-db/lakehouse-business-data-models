-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the equipment asset register. Tracks fleet value, composition, lifecycle health, and disposal performance to support capital planning, asset lifecycle decisions, and fleet investment strategy."
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (e.g. Active, Idle, Disposed) — primary filter for fleet health dashboards."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (e.g. New, Mid-life, End-of-life) — used to segment capital reinvestment decisions."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, leased, or rented — drives make-vs-buy and fleet financing analysis."
    - name: "classification"
      expr: classification
      comment: "Asset classification grouping (e.g. Heavy Equipment, Light Vehicle) — used for fleet composition reporting."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Emissions compliance tier of the asset — supports environmental compliance and ESG fleet reporting."
    - name: "make"
      expr: make
      comment: "Manufacturer of the asset — used for vendor performance and fleet standardisation analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (e.g. Sale, Scrap, Trade-in) — informs disposal strategy optimisation."
    - name: "regulatory_compliance_class"
      expr: regulatory_compliance_class
      comment: "Regulatory compliance classification — used for compliance reporting and risk segmentation."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of asset acquisition — enables trend analysis of fleet investment over time."
    - name: "disposal_date_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month of asset disposal — used to track disposal activity trends and fleet turnover."
  measures:
    - name: "total_fleet_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in the fleet at acquisition cost. Drives capital budgeting and fleet investment decisions at executive level."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current net book value of all assets. Used by finance and operations to assess remaining fleet value and depreciation exposure."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds recovered from asset disposals. Measures the effectiveness of the disposal programme and informs residual value assumptions."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Benchmarks fleet investment per unit and supports procurement negotiation strategy."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value per asset. Indicates average remaining value in the fleet and guides reinvestment timing."
    - name: "total_operating_hours_fleet"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Total cumulative operating hours across the fleet. A primary indicator of fleet utilisation intensity and remaining useful life."
    - name: "avg_operating_hours_per_asset"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average operating hours per asset. Identifies over- or under-utilised assets to guide redeployment or disposal decisions."
    - name: "total_operating_weight_kg"
      expr: SUM(CAST(operating_weight_kg AS DOUBLE))
      comment: "Total operating weight of the fleet in kilograms. Supports logistics, site capacity planning, and regulatory load compliance."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN asset_id END)
      comment: "Count of assets currently in active status. Core fleet availability KPI used in operational planning and resource allocation."
    - name: "disposed_asset_count"
      expr: COUNT(CASE WHEN disposal_date IS NOT NULL THEN asset_id END)
      comment: "Count of assets that have been disposed. Tracks fleet turnover rate and disposal programme execution."
    - name: "book_value_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disposal_proceeds AS DOUBLE)) / NULLIF(SUM(CAST(current_book_value AS DOUBLE)), 0), 2)
      comment: "Percentage of book value recovered through disposals. Measures disposal efficiency — a low rate signals poor residual value management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer over daily equipment hours records. Tracks utilisation, downtime, productivity, and cost efficiency at the shift level to drive fleet performance management and cost control."
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for daily operational reporting."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift — used for monthly trend analysis of utilisation and downtime."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Day, Night, Extended) — used to analyse performance variation by shift pattern."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g. Mechanical, Weather, Operator) — critical for root cause analysis and maintenance prioritisation."
    - name: "downtime_root_cause_code"
      expr: downtime_root_cause_code
      comment: "Root cause code for downtime — enables systematic failure pattern analysis to reduce recurring downtime."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the equipment (owned/rented) — used to compare cost efficiency across fleet ownership models."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the shift — used to assess weather-related productivity impact and schedule risk."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the equipment hours are billable to a client — used to track revenue-generating utilisation vs. overhead."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hours record — used to filter confirmed vs. pending records in financial reporting."
    - name: "production_unit_of_measure"
      expr: production_unit_of_measure
      comment: "Unit of measure for production output — used to normalise productivity metrics across equipment types."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours logged. Core fleet utilisation KPI — directly linked to project throughput and revenue generation."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total hours lost to downtime. A primary maintenance and reliability KPI — high downtime directly impacts project schedule and cost."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours where equipment was available but not productive. Drives fleet right-sizing and deployment efficiency decisions."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours. Identifies cost of equipment on standby — informs decisions to redeploy or return rental equipment."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost incurred across all hours records. Primary cost control KPI for equipment spend management."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in litres. Drives fuel cost management, carbon footprint tracking, and sustainability reporting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity. Measures equipment productivity and is used to calculate unit production costs."
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average equipment utilisation rate across records. A headline fleet performance KPI — low rates trigger redeployment or disposal reviews."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average equipment availability rate. Measures maintenance effectiveness — low availability signals maintenance backlog or reliability issues."
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour. Benchmarks equipment cost efficiency and informs make-vs-rent decisions."
    - name: "downtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(downtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE) + CAST(downtime_hours AS DOUBLE) + CAST(idle_hours AS DOUBLE) + CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Downtime as a percentage of total available hours. A critical reliability KPI — high rates indicate maintenance or operational failures requiring executive intervention."
    - name: "cost_per_production_unit"
      expr: ROUND(SUM(CAST(total_equipment_cost AS DOUBLE)) / NULLIF(SUM(CAST(production_quantity AS DOUBLE)), 0), 2)
      comment: "Equipment cost per unit of production output. Measures operational efficiency — rising cost per unit signals productivity deterioration or cost overrun."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance performance KPI layer over work orders. Tracks maintenance cost, labour efficiency, downtime impact, and compliance to drive proactive maintenance strategy and cost control."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (e.g. Preventive, Corrective, Emergency) — used to analyse maintenance strategy mix and cost by type."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (e.g. Open, In Progress, Closed) — used to track backlog and completion rates."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order — used to assess whether high-priority work is being completed on time."
    - name: "failure_code"
      expr: failure_code
      comment: "Failure code associated with the maintenance event — enables failure pattern analysis and root cause trending."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned maintenance start — used for maintenance schedule load analysis and resource planning."
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Whether the order is linked to a compliance inspection — used to track regulatory maintenance compliance rates."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was raised — used to track warranty recovery and vendor accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of maintenance cost amounts — used for multi-currency cost consolidation."
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total cost of all maintenance orders. Primary maintenance spend KPI — directly impacts project cost and asset lifecycle economics."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labour cost across maintenance orders. Drives workforce planning and labour efficiency analysis in maintenance operations."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost for maintenance. Informs spare parts inventory strategy and procurement spend management."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external maintenance services. Measures outsourced maintenance spend — used to evaluate insource vs. outsource decisions."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours consumed by maintenance orders. Used to assess maintenance workforce capacity and productivity."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance. Quantifies the operational impact of maintenance events on project delivery."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average cost per maintenance order. Benchmarks maintenance efficiency and identifies cost outliers requiring investigation."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labour hours per maintenance order. Measures maintenance task efficiency and supports workforce scheduling."
    - name: "labor_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "Labour cost as a percentage of total maintenance cost. Indicates labour intensity of the maintenance programme — high ratios may signal automation or skills opportunities."
    - name: "external_services_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(external_services_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "External services cost as a percentage of total maintenance cost. Measures outsourcing dependency — informs insource vs. outsource strategy."
    - name: "maintenance_order_count"
      expr: COUNT(1)
      comment: "Total number of maintenance orders. Used to track maintenance workload volume and backlog trends over time."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPI layer over fuel transaction records. Tracks fuel spend, consumption efficiency, carbon emissions, and anomalies to drive cost control and sustainability performance."
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the fuel transaction — primary time dimension for fuel cost trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the fuel transaction — used to filter confirmed vs. pending transactions in cost reporting."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the fuel transaction — used to identify exceptions and unprocessed records."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (e.g. Litres, Gallons) — used for normalisation in consumption analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fuel transaction — used for multi-currency cost consolidation."
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Whether the transaction was an emergency refuel — used to track unplanned fuel events and their cost premium."
    - name: "is_theft_suspected"
      expr: is_theft_suspected
      comment: "Whether fuel theft is suspected — critical risk flag for fuel loss investigation and security controls."
  measures:
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure across all transactions. Primary fuel cost KPI — directly impacts project operating cost and margin."
    - name: "total_fuel_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total volume of fuel issued. Measures fleet fuel consumption — used for efficiency benchmarking and carbon footprint calculation."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms from fuel consumption. Core ESG and sustainability KPI — reported to regulators and in corporate sustainability disclosures."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost per transaction. Tracks fuel price trends and procurement efficiency — significant movements trigger procurement review."
    - name: "avg_fuel_quantity_per_transaction"
      expr: AVG(CAST(quantity_issued AS DOUBLE))
      comment: "Average fuel quantity per transaction. Identifies abnormal fill patterns that may indicate waste, theft, or equipment inefficiency."
    - name: "suspected_theft_transaction_count"
      expr: COUNT(CASE WHEN is_theft_suspected = TRUE THEN fuel_transaction_id END)
      comment: "Count of transactions flagged for suspected fuel theft. A critical risk and loss control KPI — any non-zero value triggers investigation."
    - name: "emergency_refuel_cost"
      expr: SUM(CASE WHEN is_emergency_refuel = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of emergency refuels. Measures unplanned fuel cost premium — high values indicate poor fuel planning or equipment reliability issues."
    - name: "carbon_cost_per_liter"
      expr: ROUND(SUM(CAST(carbon_emission_kg AS DOUBLE)) / NULLIF(SUM(CAST(quantity_issued AS DOUBLE)), 0), 4)
      comment: "Carbon emissions per litre of fuel consumed. Tracks fleet emissions intensity — used to benchmark against industry standards and set reduction targets."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet deployment and cost KPI layer over fleet assignment records. Tracks assignment utilisation, mobilisation costs, and rate efficiency to optimise fleet deployment decisions and rental cost management."
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (e.g. Active, Completed, Cancelled) — used to track active deployments and completion rates."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of fleet assignment (e.g. Project, Standby, Transfer) — used to analyse deployment patterns and cost by assignment type."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority of the assignment — used to assess whether high-priority deployments are being fulfilled on time."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Status of equipment mobilisation — used to track mobilisation pipeline and identify delays."
    - name: "assignment_start_date_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month of assignment start — used for fleet deployment trend analysis and capacity planning."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the assignment rates — used for multi-currency cost consolidation."
  measures:
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual utilisation hours across all assignments. Primary fleet productivity KPI — measures how much assigned equipment is actually being used."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilisation hours across all assignments. Used as the denominator for utilisation achievement rate calculations."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across fleet assignments. Measures unproductive deployment time — high idle hours drive decisions to redeploy or return rental equipment."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total mobilisation costs incurred. Tracks fleet deployment overhead — high mobilisation costs relative to assignment value indicate poor deployment planning."
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total demobilisation costs incurred. Combined with mobilisation cost, measures total fleet movement overhead for cost-benefit analysis."
    - name: "utilization_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_utilization_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_utilization_hours AS DOUBLE)), 0), 2)
      comment: "Actual utilisation hours as a percentage of planned. Headline fleet deployment efficiency KPI — below-target rates trigger redeployment or fleet reduction decisions."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily hire rate across assignments. Benchmarks rental cost efficiency and supports rate negotiation with vendors."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating rate per hour. Used to benchmark equipment operating cost and compare owned vs. rented fleet economics."
    - name: "total_mobilization_demobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE) + CAST(demobilization_cost AS DOUBLE))
      comment: "Total combined mobilisation and demobilisation cost. Measures total fleet movement overhead — a key input to deployment cost-benefit analysis."
    - name: "fleet_assignment_count"
      expr: COUNT(1)
      comment: "Total number of fleet assignments. Tracks fleet deployment activity volume — used to assess fleet demand and scheduling capacity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rental cost and commitment KPI layer over rental agreements. Tracks rental spend, rate benchmarking, and agreement lifecycle to optimise the rental fleet strategy and vendor cost management."
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of the rental agreement (e.g. Active, Expired, Cancelled) — used to track active rental commitments and pipeline."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment under the rental agreement — used to analyse rental spend and rate benchmarks by equipment category."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the rental (e.g. Daily, Weekly, Monthly) — used to analyse rental cost structure and cash flow timing."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Who is responsible for maintenance under the agreement (Owner/Renter) — impacts total cost of ownership calculations."
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Whether the operator is supplied by the rental vendor — affects total labour cost and workforce planning."
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Whether fuel is included in the rental rate — used to ensure accurate total cost of rental comparisons."
    - name: "rental_start_date_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month of rental agreement start — used for rental commitment trend analysis and budget forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rental agreement — used for multi-currency rental cost consolidation."
  measures:
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed cost across all rental agreements. Primary rental spend KPI — used in budget management and make-vs-rent financial analysis."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across rental agreements. Tracks capital tied up in rental deposits — relevant for cash flow management."
    - name: "total_mobilization_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilisation charges across rental agreements. Measures rental fleet deployment overhead cost."
    - name: "total_demobilization_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilisation charges across rental agreements. Combined with mobilisation, measures total rental fleet movement cost."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate across rental agreements. Benchmarks rental procurement efficiency and supports vendor rate negotiation."
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate across rental agreements. Used for long-term rental cost forecasting and budget planning."
    - name: "total_damage_waiver_cost"
      expr: SUM(CAST(damage_waiver_amount AS DOUBLE))
      comment: "Total damage waiver amounts across rental agreements. Tracks risk transfer cost in rental contracts — informs insurance vs. waiver strategy."
    - name: "rental_agreement_count"
      expr: COUNT(1)
      comment: "Total number of rental agreements. Tracks rental fleet scale and vendor relationship breadth."
    - name: "active_rental_agreement_count"
      expr: COUNT(CASE WHEN rental_status = 'Active' THEN rental_agreement_id END)
      comment: "Count of currently active rental agreements. Measures live rental fleet size — used in fleet composition and cost exposure reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection compliance and quality KPI layer. Tracks inspection outcomes, defect rates, compliance certification, and corrective action performance to manage regulatory risk and asset safety."
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Statutory, Preventive, Pre-start) — used to analyse compliance rates by inspection category."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g. Completed, Overdue, Pending) — used to track inspection backlog and compliance gaps."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (e.g. Pass, Fail, Conditional) — primary quality and compliance KPI dimension."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of compliance certificate issued — used to track certification coverage by regulatory requirement."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a compliance certificate was issued — used to measure certification completion rates."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — used for inspection activity trend analysis and compliance calendar management."
    - name: "inspection_cost_currency"
      expr: inspection_cost_currency
      comment: "Currency of inspection cost — used for multi-currency cost consolidation."
  measures:
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of all inspections. Tracks inspection programme spend — used in maintenance budget management and compliance cost reporting."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection. Benchmarks inspection efficiency and identifies cost outliers by inspection type or vendor."
    - name: "total_equipment_hours_at_inspection"
      expr: SUM(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Total equipment hours logged at time of inspection. Used to validate inspection intervals against actual usage and optimise maintenance scheduling."
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspection records. Tracks inspection programme activity volume and compliance coverage."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Fail' THEN inspection_record_id END)
      comment: "Count of inspections with a failed outcome. A critical safety and compliance KPI — high failure counts trigger immediate asset grounding and corrective action."
    - name: "inspection_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_outcome = 'Fail' THEN inspection_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in failure. Headline equipment quality and safety KPI — rising failure rates signal systemic maintenance or asset condition deterioration."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_issued_flag = TRUE THEN inspection_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a compliance certificate being issued. Measures regulatory compliance programme effectiveness."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN inspection_status = 'Overdue' THEN inspection_record_id END)
      comment: "Count of overdue inspections. A critical regulatory risk KPI — overdue inspections expose the organisation to regulatory penalties and safety incidents."
$$;