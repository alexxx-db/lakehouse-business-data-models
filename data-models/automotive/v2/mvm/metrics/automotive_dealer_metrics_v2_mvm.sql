-- Metric views for domain: dealer | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory performance metrics tracking stock levels, days on lot, pricing dynamics, and inventory turnover for dealer vehicle inventory management"
  source: "`vibe_automotive_v1`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory item (available, sold, in-transit, etc.)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (new, used, certified pre-owned, demo)"
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style (sedan, SUV, truck, etc.)"
    - name: "certified_pre_owned"
      expr: certified_pre_owned
      comment: "Whether vehicle is certified pre-owned"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Vehicle drivetrain type (AWD, FWD, RWD, 4WD)"
    - name: "exterior_color_name"
      expr: exterior_color_name
      comment: "Exterior color of the vehicle"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (automatic, manual, CVT)"
    - name: "transport_status"
      expr: transport_status
      comment: "Current transport/logistics status of the vehicle"
    - name: "recall_hold"
      expr: recall_hold
      comment: "Whether vehicle is on hold due to recall"
    - name: "pdi_completed"
      expr: pdi_completed
      comment: "Whether pre-delivery inspection has been completed"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when vehicle was received at dealer"
    - name: "floor_plan_month"
      expr: DATE_TRUNC('MONTH', floor_plan_date)
      comment: "Month when vehicle was floor planned"
  measures:
    - name: "total_inventory_units"
      expr: COUNT(1)
      comment: "Total count of inventory units"
    - name: "total_inventory_value_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total inventory value at MSRP pricing"
    - name: "total_inventory_value_invoice"
      expr: SUM(CAST(invoice_price AS DOUBLE))
      comment: "Total inventory value at dealer invoice cost"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of inventory"
    - name: "avg_msrp_per_unit"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per inventory unit"
    - name: "avg_invoice_price_per_unit"
      expr: AVG(CAST(invoice_price AS DOUBLE))
      comment: "Average invoice price per inventory unit"
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price across inventory"
    - name: "inventory_margin_potential"
      expr: SUM(CAST(msrp AS DOUBLE) - CAST(invoice_price AS DOUBLE))
      comment: "Total potential gross margin (MSRP minus invoice) across inventory"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy across inventory fleet"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy across inventory fleet"
    - name: "units_on_recall_hold"
      expr: SUM(CAST(CASE WHEN recall_hold = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of units currently on recall hold"
    - name: "units_pdi_completed"
      expr: SUM(CAST(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of units with completed pre-delivery inspection"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory units with completed PDI"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail sales performance metrics tracking revenue, profitability, financing penetration, and deal structure for dealer retail transactions"
  source: "`vibe_automotive_v1`.`dealer`.`retail_sale`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the retail deal"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing (lease, loan, cash)"
    - name: "vehicle_condition"
      expr: vehicle_condition
      comment: "Condition of vehicle sold (new, used, certified)"
    - name: "fleet_sale"
      expr: fleet_sale
      comment: "Whether this is a fleet sale"
    - name: "lender_name"
      expr: lender_name
      comment: "Name of financing lender"
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle sold"
    - name: "pdi_completed"
      expr: pdi_completed
      comment: "Whether PDI was completed before sale"
    - name: "sale_month"
      expr: DATE_TRUNC('MONTH', sale_date)
      comment: "Month of sale transaction"
    - name: "sale_quarter"
      expr: DATE_TRUNC('QUARTER', sale_date)
      comment: "Quarter of sale transaction"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of vehicle delivery"
  measures:
    - name: "total_retail_sales_count"
      expr: COUNT(1)
      comment: "Total count of retail sale transactions"
    - name: "total_sales_revenue"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total revenue from vehicle sale prices"
    - name: "total_front_end_gross"
      expr: SUM(CAST(front_end_gross AS DOUBLE))
      comment: "Total front-end gross profit (vehicle margin)"
    - name: "total_back_end_gross"
      expr: SUM(CAST(back_end_gross AS DOUBLE))
      comment: "Total back-end gross profit (F&I products)"
    - name: "total_fi_product_revenue"
      expr: SUM(CAST(fi_product_revenue AS DOUBLE))
      comment: "Total revenue from finance and insurance products"
    - name: "total_oem_incentives"
      expr: SUM(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Total OEM incentive amounts applied"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amounts given to customers"
    - name: "total_finance_amount"
      expr: SUM(CAST(finance_amount AS DOUBLE))
      comment: "Total amount financed across all deals"
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment AS DOUBLE))
      comment: "Total down payment amounts collected"
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance values given"
    - name: "total_trade_in_payoff"
      expr: SUM(CAST(trade_in_payoff_amount AS DOUBLE))
      comment: "Total trade-in payoff amounts"
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average vehicle sale price"
    - name: "avg_front_end_gross_per_unit"
      expr: AVG(CAST(front_end_gross AS DOUBLE))
      comment: "Average front-end gross profit per unit sold"
    - name: "avg_back_end_gross_per_unit"
      expr: AVG(CAST(back_end_gross AS DOUBLE))
      comment: "Average back-end gross profit per unit sold"
    - name: "avg_fi_product_revenue_per_unit"
      expr: AVG(CAST(fi_product_revenue AS DOUBLE))
      comment: "Average F&I product revenue per unit sold"
    - name: "avg_apr"
      expr: AVG(CAST(apr AS DOUBLE))
      comment: "Average annual percentage rate on financed deals"
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment AS DOUBLE))
      comment: "Average monthly payment amount"
    - name: "finance_penetration_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN financing_type IS NOT NULL AND financing_type != 'cash' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales with financing (non-cash)"
    - name: "trade_in_penetration_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN trade_in_allowance > 0 THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales involving a trade-in"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_dealership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealership facility and capability metrics tracking certifications, capacity, operational readiness, and franchise status for dealer network management"
  source: "`vibe_automotive_v1`.`dealer`.`dealership`"
  dimensions:
    - name: "dealer_status"
      expr: dealer_status
      comment: "Current operational status of the dealership"
    - name: "dealer_tier"
      expr: dealer_tier
      comment: "Tier classification of the dealership"
    - name: "franchise_type"
      expr: franchise_type
      comment: "Type of franchise agreement"
    - name: "channel_classification"
      expr: channel_classification
      comment: "Sales channel classification"
    - name: "country_code"
      expr: country_code
      comment: "Country where dealership is located"
    - name: "state_province_code"
      expr: state_province_code
      comment: "State or province code"
    - name: "market_region_code"
      expr: market_region_code
      comment: "Market region code"
    - name: "sales_district_code"
      expr: sales_district_code
      comment: "Sales district code"
    - name: "ev_certified"
      expr: ev_certified
      comment: "Whether dealership is certified for EV sales and service"
    - name: "adas_certified"
      expr: adas_certified
      comment: "Whether dealership is certified for ADAS service"
    - name: "pdi_certified"
      expr: pdi_certified
      comment: "Whether dealership is certified for pre-delivery inspection"
    - name: "warranty_authorized"
      expr: warranty_authorized
      comment: "Whether dealership is authorized for warranty service"
    - name: "dms_integration_status"
      expr: dms_integration_status
      comment: "Status of dealer management system integration"
    - name: "ownership_group_name"
      expr: ownership_group_name
      comment: "Name of dealership ownership group"
  measures:
    - name: "total_dealerships"
      expr: COUNT(1)
      comment: "Total count of dealership locations"
    - name: "active_dealerships"
      expr: SUM(CAST(CASE WHEN dealer_status = 'active' THEN 1 ELSE 0 END AS INT))
      comment: "Count of active dealership locations"
    - name: "ev_certified_dealerships"
      expr: SUM(CAST(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of EV-certified dealerships"
    - name: "adas_certified_dealerships"
      expr: SUM(CAST(CASE WHEN adas_certified = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of ADAS-certified dealerships"
    - name: "warranty_authorized_dealerships"
      expr: SUM(CAST(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty-authorized dealerships"
    - name: "total_service_bay_capacity"
      expr: SUM(CAST(service_bay_count AS DOUBLE))
      comment: "Total service bay capacity across dealerships"
    - name: "total_lot_capacity"
      expr: SUM(CAST(lot_capacity AS DOUBLE))
      comment: "Total vehicle lot capacity across dealerships"
    - name: "total_showroom_capacity"
      expr: SUM(CAST(showroom_display_capacity AS DOUBLE))
      comment: "Total showroom display capacity across dealerships"
    - name: "total_ev_charger_count"
      expr: SUM(CAST(ev_charger_count AS DOUBLE))
      comment: "Total EV charger count across dealerships"
    - name: "total_parts_warehouse_area"
      expr: SUM(CAST(parts_warehouse_area_sqm AS DOUBLE))
      comment: "Total parts warehouse area in square meters"
    - name: "avg_service_bay_count"
      expr: AVG(CAST(service_bay_count AS DOUBLE))
      comment: "Average service bay count per dealership"
    - name: "avg_lot_capacity"
      expr: AVG(CAST(lot_capacity AS DOUBLE))
      comment: "Average lot capacity per dealership"
    - name: "ev_certification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dealerships that are EV-certified"
    - name: "adas_certification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN adas_certified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dealerships that are ADAS-certified"
    - name: "warranty_authorization_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dealerships that are warranty-authorized"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_parts_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts inventory performance metrics tracking stock levels, turnover, fill rates, and inventory health for dealer parts operations"
  source: "`vibe_automotive_v1`.`dealer`.`parts_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of parts inventory"
    - name: "parts_classification"
      expr: parts_classification
      comment: "Classification of parts (fast-moving, slow-moving, obsolete)"
    - name: "parts_group_code"
      expr: parts_group_code
      comment: "Parts group code for categorization"
    - name: "is_core_part"
      expr: is_core_part
      comment: "Whether part is a core part requiring exchange"
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Whether part is classified as hazardous material"
    - name: "warranty_eligible"
      expr: warranty_eligible
      comment: "Whether part is eligible for warranty claims"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether part is subject to recall"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the part"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the part"
    - name: "inventory_snapshot_month"
      expr: DATE_TRUNC('MONTH', inventory_snapshot_date)
      comment: "Month of inventory snapshot"
  measures:
    - name: "total_parts_sku_count"
      expr: COUNT(1)
      comment: "Total count of unique parts SKUs in inventory"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of parts on hand"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity of parts available for sale"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of parts reserved for orders"
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total quantity of parts on order from suppliers"
    - name: "total_inventory_value_cost"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(dealer_cost_price AS DOUBLE))
      comment: "Total inventory value at dealer cost"
    - name: "total_inventory_value_retail"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(retail_price AS DOUBLE))
      comment: "Total inventory value at retail price"
    - name: "total_lost_sales_quantity"
      expr: SUM(CAST(lost_sales_quantity AS DOUBLE))
      comment: "Total quantity of lost sales due to stockouts"
    - name: "avg_months_supply"
      expr: AVG(CAST(months_supply AS DOUBLE))
      comment: "Average months of supply on hand"
    - name: "avg_dealer_cost_price"
      expr: AVG(CAST(dealer_cost_price AS DOUBLE))
      comment: "Average dealer cost price per part"
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price per part"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per part"
    - name: "parts_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_available AS DOUBLE) + CAST(lost_sales_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of demand filled from available inventory"
    - name: "inventory_turnover_rate"
      expr: ROUND(12.0 / NULLIF(AVG(CAST(months_supply AS DOUBLE)), 0), 2)
      comment: "Annualized inventory turnover rate based on months supply"
    - name: "warranty_eligible_parts_count"
      expr: SUM(CAST(CASE WHEN warranty_eligible = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of warranty-eligible parts SKUs"
    - name: "recall_parts_count"
      expr: SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of parts SKUs subject to recall"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_vehicle_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle allocation performance metrics tracking allocation acceptance, fulfillment timing, and dealer order management for supply chain optimization"
  source: "`vibe_automotive_v1`.`dealer`.`vehicle_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of vehicle allocation"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (stock, customer order, demo)"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier for allocation fulfillment"
    - name: "is_customer_order"
      expr: is_customer_order
      comment: "Whether allocation is for a customer order"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for vehicle delivery"
    - name: "pdi_required"
      expr: pdi_required
      comment: "Whether PDI is required for this allocation"
    - name: "pdi_completed"
      expr: pdi_completed
      comment: "Whether PDI has been completed"
    - name: "region_code"
      expr: region_code
      comment: "Region code for allocation"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation"
    - name: "scheduled_production_month"
      expr: DATE_TRUNC('MONTH', scheduled_production_date)
      comment: "Month of scheduled production"
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total count of vehicle allocations"
    - name: "customer_order_allocations"
      expr: SUM(CAST(CASE WHEN is_customer_order = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of allocations for customer orders"
    - name: "stock_allocations"
      expr: SUM(CAST(CASE WHEN is_customer_order = FALSE THEN 1 ELSE 0 END AS INT))
      comment: "Count of allocations for dealer stock"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of allocated vehicles"
    - name: "total_dealer_invoice_value"
      expr: SUM(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Total dealer invoice value of allocated vehicles"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts on allocations"
    - name: "avg_msrp_per_allocation"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per allocated vehicle"
    - name: "avg_dealer_invoice_per_allocation"
      expr: AVG(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Average dealer invoice price per allocated vehicle"
    - name: "customer_order_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_customer_order = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that are customer orders"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(SUM(CAST(CASE WHEN pdi_required = TRUE THEN 1 ELSE 0 END AS INT)), 0), 2)
      comment: "Percentage of required PDIs that have been completed"
    - name: "accepted_allocations"
      expr: SUM(CASE WHEN accepted_quantity IS NOT NULL AND CAST(accepted_quantity AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of allocations that have been accepted by dealers"
    - name: "allocation_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accepted_quantity IS NOT NULL AND CAST(accepted_quantity AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations accepted by dealers"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_demo_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demo vehicle program performance metrics tracking utilization, test drive activity, disposition outcomes, and program ROI for dealer demo fleet management"
  source: "`vibe_automotive_v1`.`dealer`.`demo_vehicle`"
  dimensions:
    - name: "demo_status"
      expr: demo_status
      comment: "Current status of demo vehicle"
    - name: "demo_usage_type"
      expr: demo_usage_type
      comment: "Type of demo usage (test drive, loaner, executive)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment for demo vehicle"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition (sold, returned to stock, etc.)"
    - name: "pdi_completed_flag"
      expr: pdi_completed_flag
      comment: "Whether PDI was completed"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type of demo vehicle"
    - name: "demo_start_month"
      expr: DATE_TRUNC('MONTH', demo_start_date)
      comment: "Month when demo period started"
    - name: "demo_end_month"
      expr: DATE_TRUNC('MONTH', demo_end_date)
      comment: "Month when demo period ended"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of vehicle disposition"
  measures:
    - name: "total_demo_vehicles"
      expr: COUNT(1)
      comment: "Total count of demo vehicles"
    - name: "total_test_drive_count"
      expr: SUM(CAST(test_drive_count AS DOUBLE))
      comment: "Total number of test drives conducted"
    - name: "total_sale_price"
      expr: SUM(CAST(sale_price_amount AS DOUBLE))
      comment: "Total sale price of disposed demo vehicles"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts on demo vehicles"
    - name: "total_floor_plan_interest"
      expr: SUM(CAST(floor_plan_interest_amount AS DOUBLE))
      comment: "Total floor plan interest cost for demo vehicles"
    - name: "total_current_odometer_km"
      expr: SUM(CAST(current_odometer_km AS DOUBLE))
      comment: "Total current odometer kilometers across demo fleet"
    - name: "total_mileage_overage_km"
      expr: SUM(CAST(mileage_overage_km AS DOUBLE))
      comment: "Total mileage overage kilometers beyond allowance"
    - name: "avg_test_drive_count_per_vehicle"
      expr: AVG(CAST(test_drive_count AS DOUBLE))
      comment: "Average number of test drives per demo vehicle"
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price_amount AS DOUBLE))
      comment: "Average sale price of disposed demo vehicles"
    - name: "avg_current_odometer_km"
      expr: AVG(CAST(current_odometer_km AS DOUBLE))
      comment: "Average current odometer reading across demo fleet"
    - name: "avg_demo_period_months"
      expr: AVG(CAST(demo_period_months AS DOUBLE))
      comment: "Average demo period duration in months"
    - name: "demo_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(test_drive_count AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demo vehicles that have been used for test drives"
    - name: "vehicles_with_accidents"
      expr: SUM(CASE WHEN CAST(accident_count AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of demo vehicles with accident history"
    - name: "accident_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(accident_count AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demo vehicles with accidents"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment volume and scheduling metrics for dealer service operations capacity planning and customer experience management"
  source: "`vibe_automotive_v1`.`dealer`.`dealer_service_appointment`"
  dimensions:
    - name: "appointment_id"
      expr: dealer_service_appointment_id
      comment: "Unique identifier for service appointment"
  measures:
    - name: "total_service_appointments"
      expr: COUNT(1)
      comment: "Total count of dealer service appointments scheduled"
    - name: "unique_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of unique customers with service appointments"
    - name: "unique_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of unique vehicles serviced"
$$;