-- Metric views for domain: fnb | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check level metrics for F&B outlet revenue performance, discount analysis, service charge capture, and tip yield. Primary KPI layer for outlet revenue management and guest spend analysis."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  filter: check_status != 'VOID'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the POS check, used for daily and period-over-period revenue trending."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "Foreign key to the F&B outlet, enabling revenue breakdown by outlet."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (e.g. Breakfast, Lunch, Dinner, Late Night) for daypart revenue analysis."
    - name: "order_type"
      expr: order_type
      comment: "Order type (e.g. Dine-In, Room Service, Takeaway, Banquet) for channel mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Channel or system through which the order was placed (e.g. POS terminal, mobile app, phone)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Cash, Credit Card, Room Charge) for payment mix and settlement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency property reporting."
    - name: "check_status"
      expr: check_status
      comment: "Status of the POS check (e.g. Closed, Open, Voided) for operational monitoring."
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of POS checks (covers). Baseline volume metric for outlet throughput and cover count benchmarking."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total F&B revenue including tax, service charge, and tips. Primary top-line revenue KPI for outlet performance."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Pre-tax, pre-service-charge revenue subtotal. Used to compute net food and beverage revenue excluding ancillary charges."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all checks. Tracks promotional spend and discount leakage impacting net revenue."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected. Key revenue line for labor cost offset and service model evaluation."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all checks. Required for regulatory reporting and tax remittance reconciliation."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity/tip collected. Indicator of guest satisfaction and service quality at the outlet level."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average check value per transaction. Core KPI for guest spend benchmarking against average check targets."
    - name: "avg_subtotal_per_check"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average pre-tax subtotal per check. Used to track spend trends net of tax and service charge variability."
    - name: "avg_discount_per_check"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per check. Helps identify over-discounting patterns by outlet, meal period, or channel."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level metrics for F&B menu item sales, cost of sales, margin, and void analysis. Enables menu engineering, item profitability, and waste/void management decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  filter: is_voided = False
  dimensions:
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Foreign key to the menu item sold. Enables item-level profitability and popularity analysis."
    - name: "pos_check_id"
      expr: pos_check_id
      comment: "Foreign key to the parent POS check. Enables check-level aggregation from line items."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major group classification (e.g. Food, Beverage, Alcohol) for category-level revenue and cost analysis."
    - name: "family_group_code"
      expr: family_group_code
      comment: "Family group sub-classification for granular menu category performance reporting."
    - name: "course_number"
      expr: course_number
      comment: "Course sequence (e.g. Starter, Main, Dessert) for course-level revenue and upsell analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Used to track comp cost and guest recognition program spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item for multi-currency property reporting."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all non-voided line items. Primary measure for item-level and category-level revenue contribution."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge line subtotal. Used for net revenue analysis excluding ancillary charges."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of goods sold at line item level. Core input for gross margin and food/beverage cost percentage KPIs."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line item level. Enables item-level discount analysis and promotional effectiveness measurement."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items sold. Drives menu popularity ranking and demand forecasting for procurement."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across all line items. Used to monitor price realization and menu pricing effectiveness."
    - name: "avg_cost_of_sales_per_line"
      expr: AVG(CAST(cost_of_sales AS DOUBLE))
      comment: "Average cost of sales per line item. Benchmarks item-level cost efficiency across menu categories."
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items sold. Measures menu breadth utilization and identifies slow-moving items for menu rationalization."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge at line item level. Supports service charge allocation and revenue recognition accuracy."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax at line item level. Required for tax compliance reporting and audit reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order metrics covering revenue, delivery performance, guest satisfaction, and operational efficiency. Enables management of in-room dining as a distinct revenue and service quality channel."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  filter: order_status != 'CANCELLED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the room service order for daily and period-level trending."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet fulfilling the room service order. Enables outlet-level room service performance comparison."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the room service order (e.g. Delivered, Pending, Cancelled) for operational monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the room service order was placed (e.g. Phone, In-Room Tablet, App)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the room service order for settlement and revenue recognition."
    - name: "is_vip_guest"
      expr: is_vip_guest
      comment: "Flag indicating VIP guest orders. Enables differentiated service level monitoring for high-value guests."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Flag indicating whether the order was delivered within the promised time window. Key service quality dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the room service order for multi-currency property reporting."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of room service orders. Baseline volume metric for in-room dining demand and staffing decisions."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total room service revenue including delivery charge, service charge, and tax. Primary revenue KPI for in-room dining channel."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Pre-charge subtotal revenue from room service orders. Used for net food revenue analysis."
    - name: "total_delivery_charge"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Tracks delivery fee revenue contribution and pricing strategy effectiveness."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on room service orders. Indicator of guest satisfaction and service quality."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Tracks promotional spend and discount leakage in the in-room dining channel."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average room service order value. Benchmarks in-room dining spend per order and tracks upsell effectiveness."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_delivery_flag = True THEN 1 ELSE 0 END)
      comment: "Count of orders delivered on time. Numerator for on-time delivery rate calculation; key service quality KPI."
    - name: "total_orders_for_otd_rate"
      expr: COUNT(1)
      comment: "Total order count denominator for on-time delivery rate. Pair with on_time_delivery_count to compute delivery SLA compliance."
    - name: "vip_order_count"
      expr: SUM(CASE WHEN is_vip_guest = True THEN 1 ELSE 0 END)
      comment: "Count of room service orders from VIP guests. Enables VIP service level monitoring and differentiated experience management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock transaction metrics covering cost of goods movement, waste, variance, and procurement spend. Enables food and beverage cost control, waste reduction, and inventory accuracy management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  filter: transaction_status != 'CANCELLED'
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for daily and period-level inventory movement trending."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (e.g. Purchase, Issue, Transfer, Waste, Adjustment) for cost flow categorization."
    - name: "primary_stock_fnb_outlet_id"
      expr: primary_stock_fnb_outlet_id
      comment: "F&B outlet holding the primary stock. Enables outlet-level inventory cost and waste analysis."
    - name: "inventory_item_id"
      expr: inventory_item_id
      comment: "Foreign key to the inventory item. Enables item-level cost and waste tracking."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g. Spoilage, Over-production, Breakage) for targeted waste reduction initiatives."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock transaction for daypart-level cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the stock transaction for multi-currency property cost reporting."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the stock transaction (e.g. Posted, Pending, Reversed) for reconciliation and audit."
  measures:
    - name: "total_transaction_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost value of all stock transactions. Primary cost-of-goods metric for F&B cost control and P&L reporting."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all transaction types. Drives consumption analysis and procurement planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock transactions. Tracks cost inflation and supplier pricing trends over time."
    - name: "total_waste_cost"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of waste transactions. Key KPI for food waste reduction programs and sustainability reporting."
    - name: "total_waste_quantity"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity wasted. Enables waste rate calculation and benchmarking against industry sustainability targets."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total inventory variance amount (physical count vs. system). Measures inventory accuracy and shrinkage exposure."
    - name: "total_purchase_cost"
      expr: SUM(CASE WHEN transaction_type = 'PURCHASE' THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of purchase transactions. Primary procurement spend metric for vendor management and budget control."
    - name: "distinct_items_transacted"
      expr: COUNT(DISTINCT inventory_item_id)
      comment: "Count of distinct inventory items with stock movements. Measures active inventory breadth and procurement complexity."
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Baseline volume metric for inventory activity and operational throughput."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_food_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety inspection metrics covering compliance scores, violation rates, HACCP adherence, and corrective action tracking. Enables risk management, regulatory compliance, and brand protection decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the food safety inspection for temporal compliance trend analysis."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet inspected. Enables outlet-level compliance benchmarking and risk ranking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Routine, Follow-up, Complaint-driven) for inspection program management."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Completed, Pending, In Progress) for workflow monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance outcome (e.g. Compliant, Non-Compliant, Conditional) for regulatory risk classification."
    - name: "inspection_grade"
      expr: inspection_grade
      comment: "Letter or numeric grade assigned by the inspector. Used for public health reporting and brand risk management."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body conducting the inspection. Enables jurisdiction-level compliance tracking."
    - name: "haccp_compliance_flag"
      expr: haccp_compliance_flag
      comment: "Flag indicating HACCP compliance at time of inspection. Critical food safety standard adherence indicator."
    - name: "iso_22000_compliance_flag"
      expr: iso_22000_compliance_flag
      comment: "Flag indicating ISO 22000 compliance at time of inspection. International food safety management standard adherence."
    - name: "reinspection_required_flag"
      expr: reinspection_required_flag
      comment: "Flag indicating whether a reinspection was required. Signals serious compliance failures requiring follow-up."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of food safety inspections conducted. Baseline metric for inspection program coverage and frequency."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average food safety inspection score. Primary KPI for overall food safety compliance performance across outlets."
    - name: "min_inspection_score"
      expr: MIN(CAST(inspection_score AS DOUBLE))
      comment: "Minimum inspection score recorded. Identifies worst-performing outlets requiring immediate corrective action."
    - name: "haccp_compliant_count"
      expr: SUM(CASE WHEN haccp_compliance_flag = True THEN 1 ELSE 0 END)
      comment: "Count of inspections where HACCP compliance was confirmed. Numerator for HACCP compliance rate calculation."
    - name: "iso_22000_compliant_count"
      expr: SUM(CASE WHEN iso_22000_compliance_flag = True THEN 1 ELSE 0 END)
      comment: "Count of inspections where ISO 22000 compliance was confirmed. Tracks international food safety standard adherence."
    - name: "reinspection_required_count"
      expr: SUM(CASE WHEN reinspection_required_flag = True THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring reinspection. Measures severity of compliance failures and regulatory risk exposure."
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant inspection outcomes. Key risk metric for brand protection and regulatory penalty avoidance."
    - name: "distinct_outlets_inspected"
      expr: COUNT(DISTINCT fnb_outlet_id)
      comment: "Count of distinct F&B outlets inspected. Measures inspection program coverage across the property portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory item master metrics covering stock levels, cost benchmarks, dietary and compliance attributes, and reorder management. Enables procurement efficiency, dietary compliance, and cost standard governance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level category of the inventory item (e.g. Food, Beverage, Cleaning) for category-level cost and stock analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category of the inventory item for granular procurement and cost analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the inventory item (e.g. Active, Discontinued, On Hold) for active inventory management."
    - name: "alcohol_flag"
      expr: alcohol_flag
      comment: "Flag indicating alcoholic items. Enables separate food vs. beverage cost and compliance reporting."
    - name: "halal_certified_flag"
      expr: halal_certified_flag
      comment: "Flag indicating halal certification. Supports dietary compliance reporting for halal-certified properties."
    - name: "kosher_certified_flag"
      expr: kosher_certified_flag
      comment: "Flag indicating kosher certification. Supports dietary compliance reporting for kosher-certified properties."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Flag indicating organic items. Tracks organic sourcing penetration for sustainability and brand positioning."
    - name: "local_sourced_flag"
      expr: local_sourced_flag
      comment: "Flag indicating locally sourced items. Supports local sourcing KPIs for sustainability and community engagement reporting."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating items requiring temperature-controlled storage. Enables cold chain compliance monitoring."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the inventory item. Required for quantity normalization in consumption and procurement analysis."
  measures:
    - name: "total_active_items"
      expr: COUNT(1)
      comment: "Total count of active inventory items. Baseline metric for inventory portfolio size and complexity management."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE))
      comment: "Total current on-hand quantity across all active items. Measures overall inventory stock level for procurement planning."
    - name: "total_on_hand_value"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total estimated value of on-hand inventory (quantity × standard cost). Key balance sheet and working capital metric."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per inventory item. Benchmarks cost baseline for procurement negotiation and cost standard reviews."
    - name: "avg_last_purchase_cost"
      expr: AVG(CAST(last_purchase_cost AS DOUBLE))
      comment: "Average last purchase cost per item. Tracks actual procurement cost vs. standard cost for variance analysis."
    - name: "items_below_par_level"
      expr: SUM(CASE WHEN current_on_hand_quantity < par_level THEN 1 ELSE 0 END)
      comment: "Count of items with on-hand quantity below par level. Operational alert metric for stockout risk and procurement urgency."
    - name: "items_below_reorder_point"
      expr: SUM(CASE WHEN current_on_hand_quantity < reorder_point THEN 1 ELSE 0 END)
      comment: "Count of items at or below reorder point. Triggers procurement action to prevent service disruption."
    - name: "total_last_physical_count_quantity"
      expr: SUM(CAST(last_physical_count_quantity AS DOUBLE))
      comment: "Total quantity from last physical count. Used to compute inventory variance against system on-hand quantities."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inventory items. Drives accurate recipe costing and portion cost calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item master metrics covering pricing, cost, margin, and dietary attribute distribution. Enables menu engineering, pricing strategy, and dietary compliance governance decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet offering the menu item. Enables outlet-level menu portfolio and pricing analysis."
    - name: "menu_id"
      expr: menu_id
      comment: "Menu to which the item belongs. Enables menu-level item count, pricing, and margin analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the menu item (e.g. Appetizer, Main Course, Dessert, Beverage) for category-level menu engineering."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category for granular menu item classification and analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (e.g. Active, Inactive, Seasonal) for active menu management."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Flag indicating alcoholic menu items. Enables food vs. beverage revenue and margin split analysis."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag indicating vegan menu items. Tracks vegan menu penetration for dietary inclusivity reporting."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Flag indicating vegetarian menu items. Tracks vegetarian menu breadth for dietary inclusivity."
    - name: "is_halal"
      expr: is_halal
      comment: "Flag indicating halal-certified menu items. Supports halal compliance reporting for relevant markets."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Flag indicating signature menu items. Enables signature item performance tracking and brand differentiation analysis."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag indicating seasonal menu items. Supports seasonal menu planning and availability management."
    - name: "menu_section"
      expr: menu_section
      comment: "Section of the menu (e.g. Starters, Mains, Sides) for section-level pricing and margin analysis."
  measures:
    - name: "total_active_menu_items"
      expr: COUNT(1)
      comment: "Total count of active menu items. Baseline metric for menu portfolio size and complexity."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard selling price across menu items. Benchmarks menu pricing level and tracks price positioning strategy."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price per menu item. Tracks cost baseline for menu engineering and margin management."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Primary menu profitability KPI for menu engineering decisions."
    - name: "total_menu_revenue_potential"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Sum of standard prices across all active menu items. Proxy for menu revenue potential and pricing portfolio value."
    - name: "signature_item_count"
      expr: SUM(CASE WHEN is_signature_item = True THEN 1 ELSE 0 END)
      comment: "Count of signature menu items. Tracks brand differentiation through signature offerings."
    - name: "vegan_item_count"
      expr: SUM(CASE WHEN is_vegan = True THEN 1 ELSE 0 END)
      comment: "Count of vegan menu items. Measures dietary inclusivity and tracks progress against vegan menu expansion targets."
    - name: "halal_item_count"
      expr: SUM(CASE WHEN is_halal = True THEN 1 ELSE 0 END)
      comment: "Count of halal-certified menu items. Supports halal compliance and market-specific menu adequacy reporting."
    - name: "distinct_menus_covered"
      expr: COUNT(DISTINCT menu_id)
      comment: "Count of distinct menus containing active items. Measures menu portfolio breadth across outlets."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe master metrics covering standard costs, nutritional profiles, yield, and food safety compliance. Enables recipe cost governance, nutritional transparency, and HACCP/ISO 22000 compliance management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`recipe`"
  filter: recipe_status = 'ACTIVE'
  dimensions:
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet owning the recipe. Enables outlet-level recipe portfolio and cost analysis."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (e.g. Food, Beverage, Cocktail, Sauce) for category-level cost and compliance analysis."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type of the recipe for culinary portfolio and menu diversity analysis."
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (e.g. Active, Draft, Retired) for recipe lifecycle management."
    - name: "iso_22000_ccp_flag"
      expr: iso_22000_ccp_flag
      comment: "Flag indicating the recipe has a defined Critical Control Point per ISO 22000. Tracks food safety standard compliance at recipe level."
    - name: "preparation_method"
      expr: preparation_method
      comment: "Preparation method (e.g. Grilled, Fried, Raw) for food safety risk classification and technique analysis."
    - name: "skill_level_required"
      expr: skill_level_required
      comment: "Skill level required to execute the recipe. Supports kitchen staffing and training investment decisions."
  measures:
    - name: "total_active_recipes"
      expr: COUNT(1)
      comment: "Total count of active recipes. Baseline metric for culinary portfolio size and standardization coverage."
    - name: "avg_total_recipe_cost"
      expr: AVG(CAST(total_recipe_cost AS DOUBLE))
      comment: "Average total cost per recipe. Benchmarks recipe cost baseline for menu pricing and cost standard governance."
    - name: "avg_standard_food_cost_per_portion"
      expr: AVG(CAST(standard_food_cost_per_portion AS DOUBLE))
      comment: "Average standard food cost per portion. Core input for food cost percentage calculation and menu engineering."
    - name: "avg_standard_beverage_cost_per_portion"
      expr: AVG(CAST(standard_beverage_cost_per_portion AS DOUBLE))
      comment: "Average standard beverage cost per portion. Core input for beverage cost percentage and cocktail profitability analysis."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Tracks recipe efficiency and portion standardization across the culinary portfolio."
    - name: "avg_nutritional_protein_grams"
      expr: AVG(CAST(nutritional_protein_grams AS DOUBLE))
      comment: "Average protein content per recipe portion. Supports nutritional transparency and health-conscious menu positioning."
    - name: "avg_nutritional_fat_grams"
      expr: AVG(CAST(nutritional_fat_grams AS DOUBLE))
      comment: "Average fat content per recipe portion. Supports nutritional labeling compliance and dietary health reporting."
    - name: "avg_nutritional_carbohydrate_grams"
      expr: AVG(CAST(nutritional_carbohydrate_grams AS DOUBLE))
      comment: "Average carbohydrate content per recipe portion. Supports nutritional transparency and dietary compliance reporting."
    - name: "iso_22000_ccp_recipe_count"
      expr: SUM(CASE WHEN iso_22000_ccp_flag = True THEN 1 ELSE 0 END)
      comment: "Count of recipes with ISO 22000 Critical Control Points defined. Measures food safety governance coverage across the recipe portfolio."
    - name: "total_recipe_cost_sum"
      expr: SUM(CAST(total_recipe_cost AS DOUBLE))
      comment: "Total sum of all active recipe costs. Provides aggregate cost baseline for culinary portfolio cost management."
$$;