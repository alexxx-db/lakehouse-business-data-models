-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset value, utilization, and lifecycle metrics for construction equipment inventory management and capital planning"
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (active, idle, maintenance, disposed)"
    - name: "classification"
      expr: classification
      comment: "Asset classification category for grouping similar equipment types"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (acquisition, operation, maintenance, disposal)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned, leased, rented)"
    - name: "make"
      expr: make
      comment: "Equipment manufacturer"
    - name: "model"
      expr: model
      comment: "Equipment model designation"
    - name: "year_of_manufacture"
      expr: year_of_manufacture
      comment: "Manufacturing year for age analysis"
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Environmental emissions compliance tier"
    - name: "home_yard_location"
      expr: home_yard_location
      comment: "Primary storage or assignment location"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year asset was acquired for cohort analysis"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month asset was acquired for trend analysis"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of assets in inventory"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in asset acquisition"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of asset portfolio"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset"
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value per asset"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from disposed assets"
    - name: "avg_total_operating_hours"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average total operating hours across assets"
    - name: "total_operating_hours"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Cumulative operating hours across all assets"
    - name: "avg_capacity_rating"
      expr: AVG(CAST(capacity_rating AS DOUBLE))
      comment: "Average capacity rating across assets"
    - name: "total_capacity_rating"
      expr: SUM(CAST(capacity_rating AS DOUBLE))
      comment: "Total capacity rating of asset fleet"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization, assignment efficiency, and project allocation metrics for fleet optimization and cost control"
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (active, completed, cancelled)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (project, rental, maintenance)"
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment"
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Business purpose of the assignment"
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Status of equipment mobilization to site"
    - name: "ownership_type"
      expr: assignment_type
      comment: "Assignment ownership type for cost allocation"
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month assignment started for trend analysis"
    - name: "assignment_end_month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
      comment: "Month assignment ended for trend analysis"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignments"
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned equipment utilization hours"
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual equipment utilization hours"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all assignments"
    - name: "avg_planned_utilization_hours"
      expr: AVG(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Average planned utilization hours per assignment"
    - name: "avg_actual_utilization_hours"
      expr: AVG(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Average actual utilization hours per assignment"
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total cost of mobilizing equipment to sites"
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total cost of demobilizing equipment from sites"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rental or assignment rate"
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating rate per hour"
    - name: "avg_ownership_rate_per_hour"
      expr: AVG(CAST(ownership_rate_per_hour AS DOUBLE))
      comment: "Average ownership rate per hour"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment operating hours, utilization rates, downtime, and productivity metrics for operational efficiency and cost management"
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of hours record"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership type (owned, rented, leased)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of work shift (day, night, weekend)"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event"
    - name: "downtime_root_cause_code"
      expr: downtime_root_cause_code
      comment: "Root cause code for downtime analysis"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during operation"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether hours are billable to client"
    - name: "is_overtime"
      expr: is_overtime
      comment: "Whether hours are overtime"
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for trend analysis"
    - name: "shift_date_week"
      expr: DATE_TRUNC('WEEK', shift_date)
      comment: "Week of shift for trend analysis"
  measures:
    - name: "total_hours_records"
      expr: COUNT(1)
      comment: "Total number of equipment hours records"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total equipment operating hours"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total equipment idle hours"
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total equipment standby hours"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours"
    - name: "avg_operating_hours"
      expr: AVG(CAST(operating_hours AS DOUBLE))
      comment: "Average operating hours per record"
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average equipment utilization rate percentage"
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average equipment availability rate percentage"
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment operating cost"
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in liters"
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved"
    - name: "avg_production_quantity"
      expr: AVG(CAST(production_quantity AS DOUBLE))
      comment: "Average production quantity per record"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance cost, downtime, labor efficiency, and compliance metrics for asset reliability and maintenance optimization"
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of maintenance order (open, in progress, completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance (preventive, corrective, breakdown, inspection)"
    - name: "priority"
      expr: priority
      comment: "Priority level of maintenance order"
    - name: "failure_code"
      expr: failure_code
      comment: "Failure code for root cause analysis"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center responsible for maintenance"
    - name: "site_location_code"
      expr: site_location_code
      comment: "Site location where maintenance performed"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether maintenance is covered under warranty"
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Whether maintenance includes compliance inspection"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month maintenance was planned to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_start_timestamp AS DATE))
      comment: "Month maintenance actually started"
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across all orders"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for maintenance"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost"
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total external contractor services cost"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average maintenance cost per order"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours spent on maintenance"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance order"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours due to maintenance"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per maintenance order"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption, cost, carbon emissions, and efficiency metrics for environmental compliance and cost optimization"
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of fuel transaction (pending, approved, rejected)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of transaction"
    - name: "fuel_point_name"
      expr: fuel_point_name
      comment: "Name of fueling location or station"
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Whether transaction was emergency refueling"
    - name: "is_theft_suspected"
      expr: is_theft_suspected
      comment: "Whether fuel theft is suspected"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (liters, gallons)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for transaction cost"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', CAST(transaction_timestamp AS DATE))
      comment: "Month of fuel transaction for trend analysis"
    - name: "transaction_week"
      expr: DATE_TRUNC('WEEK', CAST(transaction_timestamp AS DATE))
      comment: "Week of fuel transaction for trend analysis"
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions"
    - name: "total_fuel_quantity"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel quantity issued"
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel cost across all transactions"
    - name: "avg_fuel_quantity"
      expr: AVG(CAST(quantity_issued AS DOUBLE))
      comment: "Average fuel quantity per transaction"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost"
    - name: "avg_total_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per transaction"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms"
    - name: "avg_carbon_emission_kg"
      expr: AVG(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Average carbon emissions per transaction"
    - name: "avg_tank_capacity_percentage"
      expr: AVG(CAST(tank_capacity_percentage AS DOUBLE))
      comment: "Average tank capacity percentage at refueling"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rental cost, commitment, utilization, and vendor performance metrics for rental fleet optimization and cost control"
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of rental agreement (active, completed, cancelled)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of rented equipment"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (daily, weekly, monthly)"
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance (lessor, lessee)"
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Whether operator is supplied with equipment"
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Whether fuel is included in rental rate"
    - name: "site_location"
      expr: site_location
      comment: "Site location where equipment is deployed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for rental costs"
    - name: "rental_start_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month rental started for trend analysis"
    - name: "rental_end_month"
      expr: DATE_TRUNC('MONTH', rental_end_date)
      comment: "Month rental ended for trend analysis"
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements"
    - name: "total_committed_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed rental cost across all agreements"
    - name: "avg_committed_cost"
      expr: AVG(CAST(total_committed_cost AS DOUBLE))
      comment: "Average committed cost per rental agreement"
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate"
    - name: "avg_weekly_hire_rate"
      expr: AVG(CAST(weekly_hire_rate AS DOUBLE))
      comment: "Average weekly hire rate"
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate"
    - name: "total_mobilization_charges"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilization charges across all rentals"
    - name: "total_demobilization_charges"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilization charges across all rentals"
    - name: "total_security_deposits"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held"
    - name: "avg_security_deposit"
      expr: AVG(CAST(security_deposit_amount AS DOUBLE))
      comment: "Average security deposit per rental"
    - name: "total_damage_waiver_amount"
      expr: SUM(CAST(damage_waiver_amount AS DOUBLE))
      comment: "Total damage waiver amounts"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection compliance, defect rates, certification status, and regulatory adherence metrics for safety and compliance management"
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of inspection (scheduled, completed, failed)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, regulatory, pre-operation, annual)"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of inspection (pass, fail, conditional pass)"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether inspection certificate was issued"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate issued"
    - name: "certificate_issuing_authority"
      expr: certificate_issuing_authority
      comment: "Authority that issued the certificate"
    - name: "inspection_location"
      expr: inspection_location
      comment: "Location where inspection was performed"
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of inspection performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month inspection was performed"
    - name: "certificate_expiry_month"
      expr: DATE_TRUNC('MONTH', certificate_expiry_date)
      comment: "Month certificate expires for compliance tracking"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections performed"
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of inspections"
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection"
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment hours at time of inspection"
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified_count AS DOUBLE))
      comment: "Total number of defects identified across all inspections"
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defects_identified_count AS DOUBLE))
      comment: "Average number of defects identified per inspection"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment mobilization cost, transit efficiency, and logistics performance metrics for site deployment optimization"
  source: "`vibe_construction_v1`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of mobilization (planned, in transit, completed, cancelled)"
    - name: "event_type"
      expr: event_type
      comment: "Type of mobilization event (mobilization, demobilization, relocation)"
    - name: "transport_method"
      expr: transport_method
      comment: "Method of transport (truck, rail, barge, self-propelled)"
    - name: "origin_site_code"
      expr: origin_site_code
      comment: "Origin site code"
    - name: "destination_site_code"
      expr: destination_site_code
      comment: "Destination site code"
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether transport permit was required"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether insurance coverage was in place"
    - name: "dispatch_condition"
      expr: dispatch_condition
      comment: "Condition of equipment at dispatch"
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of equipment at receipt"
    - name: "planned_dispatch_month"
      expr: DATE_TRUNC('MONTH', planned_dispatch_date)
      comment: "Month mobilization was planned"
    - name: "actual_dispatch_month"
      expr: DATE_TRUNC('MONTH', actual_dispatch_date)
      comment: "Month mobilization actually occurred"
  measures:
    - name: "total_mobilizations"
      expr: COUNT(1)
      comment: "Total number of equipment mobilization events"
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total transport cost across all mobilizations"
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost AS DOUBLE))
      comment: "Average transport cost per mobilization"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance transported in kilometers"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average transport distance per mobilization"
    - name: "total_estimated_transit_hours"
      expr: SUM(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Total estimated transit hours"
    - name: "total_actual_transit_hours"
      expr: SUM(CAST(actual_transit_hours AS DOUBLE))
      comment: "Total actual transit hours"
    - name: "avg_estimated_transit_hours"
      expr: AVG(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Average estimated transit hours per mobilization"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit hours per mobilization"
$$;