-- Metric views for domain: fnb | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check level metrics capturing F&B revenue performance, discounting, service charges, and guest spend patterns. Primary fact table for outlet and revenue center financial KPIs."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  filter: check_status != 'VOIDED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Calendar date of the transaction used for daily, weekly, and monthly trend analysis."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (Breakfast, Lunch, Dinner, Late Night) for daypart revenue analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Dine-In, Takeaway, Delivery, Room Service) for channel mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Origin channel of the order (POS, App, Phone, Online) for digital vs. in-person split."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (Cash, Credit Card, Room Charge, Loyalty Points) for payment mix reporting."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the POS check (Open, Closed, Voided) for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property benchmarking."
    - name: "revenue_center_id"
      expr: revenue_center_id
      comment: "Revenue center identifier for outlet-level P&L attribution."
    - name: "segment_id"
      expr: segment_id
      comment: "Guest segment identifier for segmented revenue and spend analysis."
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of POS checks. Baseline volume metric for covers and transaction throughput."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total F&B revenue including tax, service charge, and tips. Primary top-line revenue KPI."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net food and beverage revenue before tax and service charges. Used for cost ratio calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all checks. Tracks promotional spend and discount leakage."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Key component of non-room F&B ancillary revenue."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on F&B transactions. Required for tax compliance and remittance reporting."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity collected. Indicator of guest satisfaction and service quality."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average spend per check. Core KPI for pricing strategy and upsell effectiveness benchmarked against average_check_target."
    - name: "avg_subtotal_per_check"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average pre-tax, pre-service-charge spend per check. Used for menu engineering and pricing decisions."
    - name: "avg_discount_per_check"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per check. Monitors discount depth and promotional effectiveness."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and revenue dilution risk."
    - name: "service_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of subtotal revenue. Validates service charge policy compliance."
    - name: "unique_guests_served"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests served. Measures guest reach and repeat visitation potential."
    - name: "loyalty_member_checks"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct loyalty members transacting. Tracks loyalty program engagement in F&B."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Reconciliation metric for cash and payment management."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level POS metrics for menu item performance, cost of sales, and waste analysis. Enables menu engineering, item profitability, and kitchen throughput decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  filter: is_voided = FALSE
  dimensions:
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Menu item identifier for item-level performance analysis."
    - name: "revenue_center_id"
      expr: revenue_center_id
      comment: "Revenue center for outlet-level item mix and contribution analysis."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major group classification (Food, Beverage, etc.) for high-level category revenue split."
    - name: "family_group_code"
      expr: family_group_code
      comment: "Family group classification for mid-level category analysis (e.g., Starters, Mains, Desserts)."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency line item reporting."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Used to track comp cost and VIP/service recovery spend."
    - name: "course_number"
      expr: course_number
      comment: "Course sequence number for dining flow analysis and kitchen pacing."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property item performance benchmarking."
  measures:
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items sold. Core volume metric for menu popularity and demand forecasting."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue at line item level including tax and service charge. Enables item-level revenue attribution."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge revenue at line level. Used for item cost ratio calculations."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of goods sold at line level. Direct input to gross margin and food/beverage cost percentage KPIs."
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line item level. Identifies high-discount items for pricing review."
    - name: "total_line_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges at line level for detailed revenue component analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit. Tracks pricing consistency and yield against menu price points."
    - name: "cost_of_sales_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_of_sales AS DOUBLE)) / NULLIF(SUM(CAST(line_subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Cost of sales as a percentage of net revenue. Primary food/beverage cost control KPI for menu engineering."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE) - CAST(cost_of_sales AS DOUBLE))
      comment: "Gross margin in absolute terms per line item. Identifies highest and lowest margin items for menu optimization."
    - name: "complimentary_item_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(cost_of_sales AS DOUBLE) ELSE 0 END)
      comment: "Total cost of complimentary items. Tracks service recovery and VIP amenity costs against budget."
    - name: "voided_line_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided line items. Operational quality metric — high void rates indicate training or system issues."
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of distinct menu items sold. Measures menu breadth utilization and identifies dead menu items."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order metrics covering delivery performance, revenue, guest satisfaction, and operational efficiency. Critical for in-room dining P&L and guest experience management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  filter: order_status != 'CANCELLED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the room service order for daily trend and daypart analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the room service order (Pending, In-Progress, Delivered, Cancelled) for operational monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the order was placed (Phone, App, In-Room Tablet) for digital adoption tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for room service orders. Tracks room charge vs. direct payment split."
    - name: "is_vip_guest"
      expr: is_vip_guest
      comment: "VIP guest flag for differentiated service level analysis and VIP revenue contribution."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Whether the order was delivered on time. Key operational SLA dimension for delivery performance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency room service revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property room service benchmarking."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet fulfilling the room service order for kitchen workload and revenue attribution."
    - name: "segment_id"
      expr: segment_id
      comment: "Guest segment for segmented room service revenue and satisfaction analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total room service orders placed. Baseline volume metric for demand planning and staffing."
    - name: "total_room_service_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total room service revenue. Key in-room dining top-line KPI for ancillary revenue management."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net room service revenue before tax and service charges. Used for cost ratio and margin calculations."
    - name: "total_delivery_charge_revenue"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Tracks delivery fee revenue and its contribution to room service P&L."
    - name: "total_gratuity_collected"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity on room service orders. Indicator of guest satisfaction and service quality."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Monitors promotional spend and discount policy adherence."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average room service order value. Benchmarks upsell effectiveness and pricing strategy for in-room dining."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room service orders delivered on time. Primary SLA metric for guest experience and operational excellence."
    - name: "vip_order_revenue"
      expr: SUM(CASE WHEN is_vip_guest = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from VIP guest room service orders. Tracks high-value guest spend and VIP program ROI."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of net room service revenue. Monitors promotional intensity and revenue dilution."
    - name: "unique_guests_ordering"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests placing room service orders. Measures in-room dining adoption across the guest base."
    - name: "avg_service_charge_per_order"
      expr: AVG(CAST(service_charge AS DOUBLE))
      comment: "Average service charge per room service order. Validates service charge policy and identifies anomalies."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock transaction metrics for F&B cost control, waste management, and supply chain efficiency. Enables procurement, waste reduction, and inventory optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  filter: transaction_status != 'CANCELLED'
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for daily and period-over-period inventory movement analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (Purchase, Transfer, Waste, Adjustment, Issue) for inventory flow categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the stock transaction for reconciliation and audit trail management."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (Spoilage, Over-production, Breakage) for targeted waste reduction initiatives."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock transaction for daypart consumption analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency inventory cost reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property inventory cost benchmarking."
    - name: "inventory_item_id"
      expr: inventory_item_id
      comment: "Inventory item identifier for item-level consumption and waste analysis."
    - name: "source_fnb_outlet_id"
      expr: source_fnb_outlet_id
      comment: "Source outlet for inter-outlet transfer and consumption attribution."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Baseline volume metric for inventory activity monitoring."
    - name: "total_stock_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements. Primary inventory cost KPI for F&B cost of goods sold tracking."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all transaction types. Measures inventory throughput and consumption volume."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock transactions. Tracks procurement price trends and cost inflation."
    - name: "total_waste_cost"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of wasted inventory. Critical KPI for food waste reduction programs and sustainability reporting."
    - name: "total_waste_quantity"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of wasted inventory. Operational metric for waste reduction and yield improvement initiatives."
    - name: "waste_cost_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transaction_type = 'WASTE' THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Waste cost as a percentage of total stock cost. Key sustainability and cost control KPI for F&B operations."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total inventory variance amount. Identifies shrinkage, theft, or counting errors requiring investigation."
    - name: "total_purchase_cost"
      expr: SUM(CASE WHEN transaction_type = 'PURCHASE' THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of purchase transactions. Tracks procurement spend for budget vs. actual analysis."
    - name: "distinct_items_transacted"
      expr: COUNT(DISTINCT inventory_item_id)
      comment: "Number of distinct inventory items with stock movements. Measures inventory breadth and active SKU utilization."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory item master metrics for stock health, compliance, and procurement management. Enables purchasing decisions, allergen compliance, and sustainability reporting."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level item category (Food, Beverage, Cleaning, etc.) for category-level inventory analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category for granular item classification and procurement grouping."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the inventory item (Active, Discontinued, On-Hold) for active inventory management."
    - name: "halal_certified_flag"
      expr: halal_certified_flag
      comment: "Halal certification flag for dietary compliance reporting and menu labeling."
    - name: "kosher_certified_flag"
      expr: kosher_certified_flag
      comment: "Kosher certification flag for dietary compliance and guest accommodation tracking."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Organic sourcing flag for sustainability reporting and premium ingredient tracking."
    - name: "local_sourced_flag"
      expr: local_sourced_flag
      comment: "Local sourcing flag for sustainability KPIs and farm-to-table program measurement."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Temperature-controlled storage requirement flag for food safety compliance monitoring."
    - name: "allergen_flag"
      expr: allergen_flag
      comment: "Allergen presence flag for food safety compliance and guest allergy management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantity standardization and procurement ordering."
  measures:
    - name: "total_active_items"
      expr: COUNT(1)
      comment: "Total number of active inventory items. Baseline metric for SKU portfolio size management."
    - name: "total_on_hand_value"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total estimated on-hand inventory value (quantity × standard cost). Key balance sheet and working capital metric."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE))
      comment: "Total on-hand quantity across all active items. Aggregate stock level for procurement planning."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per inventory item. Tracks cost base trends for procurement benchmarking."
    - name: "items_below_par_level"
      expr: COUNT(CASE WHEN CAST(current_on_hand_quantity AS DOUBLE) < CAST(par_level AS DOUBLE) THEN 1 END)
      comment: "Number of items with stock below par level. Critical operational alert metric for preventing stockouts."
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN CAST(current_on_hand_quantity AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 END)
      comment: "Number of items at or below reorder point. Triggers procurement action to prevent service disruption."
    - name: "avg_last_purchase_cost"
      expr: AVG(CAST(last_purchase_cost AS DOUBLE))
      comment: "Average last purchase cost. Tracks recent procurement pricing trends and cost inflation signals."
    - name: "local_sourced_item_count"
      expr: COUNT(CASE WHEN local_sourced_flag = TRUE THEN 1 END)
      comment: "Count of locally sourced items. Measures progress against local sourcing sustainability targets."
    - name: "local_sourced_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN local_sourced_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active inventory items that are locally sourced. Sustainability KPI for ESG and farm-to-table reporting."
    - name: "allergen_item_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory items containing allergens. Food safety compliance metric for allergen management programs."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item master metrics for menu engineering, pricing strategy, dietary compliance, and item portfolio management. Enables data-driven menu optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level menu item category (Starter, Main, Dessert, Beverage) for category mix analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category for granular menu section analysis and engineering."
    - name: "menu_section"
      expr: menu_section
      comment: "Menu section placement for menu layout optimization and item visibility analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current availability status of the menu item for active menu portfolio management."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Signature item flag for tracking flagship dish performance and brand differentiation."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary option portfolio analysis and guest accommodation tracking."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Vegetarian flag for dietary mix reporting and menu balance assessment."
    - name: "is_halal"
      expr: is_halal
      comment: "Halal certification flag for dietary compliance and market segment accommodation."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for dietary accommodation portfolio tracking."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Alcoholic item flag for beverage mix analysis and regulatory compliance reporting."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Seasonal availability flag for seasonal menu planning and inventory alignment."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet for outlet-specific menu portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency menu pricing analysis."
  measures:
    - name: "total_active_menu_items"
      expr: COUNT(1)
      comment: "Total active menu items. Baseline metric for menu portfolio size and complexity management."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average menu item selling price. Tracks pricing tier positioning and average price point strategy."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average menu item cost price. Monitors cost base for menu engineering and margin management."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Primary menu profitability KPI for engineering decisions."
    - name: "total_menu_revenue_potential"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Sum of all standard prices. Proxy for menu revenue ceiling and pricing portfolio value."
    - name: "signature_item_count"
      expr: COUNT(CASE WHEN is_signature_item = TRUE THEN 1 END)
      comment: "Number of signature menu items. Tracks brand differentiation portfolio and flagship dish investment."
    - name: "dietary_compliant_item_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vegan = TRUE OR is_vegetarian = TRUE OR is_gluten_free = TRUE OR is_halal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of menu items meeting at least one dietary compliance standard. Measures menu inclusivity for diverse guest needs."
    - name: "avg_alcohol_content_pct"
      expr: AVG(CASE WHEN is_alcoholic = TRUE THEN CAST(alcohol_content_percent AS DOUBLE) END)
      comment: "Average alcohol content percentage for alcoholic items. Supports responsible service and regulatory compliance reporting."
    - name: "high_margin_item_count"
      expr: COUNT(CASE WHEN CAST(gross_margin_percent AS DOUBLE) >= 70 THEN 1 END)
      comment: "Count of menu items with gross margin at or above 70%. Identifies star items for menu promotion and upsell focus."
    - name: "cost_to_price_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_price AS DOUBLE)) / NULLIF(SUM(CAST(standard_price AS DOUBLE)), 0), 2)
      comment: "Aggregate cost-to-price ratio across menu items. Validates menu pricing strategy against cost structure targets."
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_revenue_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue center master metrics for outlet portfolio management, target setting, and operational compliance. Enables property-level F&B structure governance and performance target tracking."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`revenue_center`"
  filter: revenue_center_status = 'ACTIVE'
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category classification (Food, Beverage, Banquet, etc.) for P&L category reporting."
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (Restaurant, Bar, Café, Room Service) for outlet mix and portfolio analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service style (Full Service, Quick Service, Buffet) for service model performance comparison."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for culinary portfolio diversity and market positioning analysis."
    - name: "revenue_center_status"
      expr: revenue_center_status
      comment: "Operational status of the revenue center for active portfolio management."
    - name: "iso_22000_certified_flag"
      expr: iso_22000_certified_flag
      comment: "ISO 22000 food safety certification flag for compliance portfolio tracking."
    - name: "pos_integration_enabled_flag"
      expr: pos_integration_enabled_flag
      comment: "POS integration status flag for technology adoption and data completeness monitoring."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property revenue center portfolio analysis."
    - name: "usali_department_code"
      expr: usali_department_code
      comment: "USALI department code for standardized hospitality financial reporting alignment."
  measures:
    - name: "total_active_revenue_centers"
      expr: COUNT(1)
      comment: "Total active revenue centers. Baseline metric for F&B outlet portfolio size and capacity planning."
    - name: "avg_food_cost_target_pct"
      expr: AVG(CAST(food_cost_target_percentage AS DOUBLE))
      comment: "Average food cost target percentage across revenue centers. Benchmarks cost targets for budget setting and performance evaluation."
    - name: "avg_beverage_cost_target_pct"
      expr: AVG(CAST(beverage_cost_target_percentage AS DOUBLE))
      comment: "Average beverage cost target percentage. Tracks beverage cost management targets across the outlet portfolio."
    - name: "avg_labor_cost_target_pct"
      expr: AVG(CAST(labor_cost_target_percentage AS DOUBLE))
      comment: "Average labor cost target percentage. Key input for total F&B cost structure and staffing budget governance."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across revenue centers. Validates service charge policy consistency."
    - name: "avg_check_target_amount"
      expr: AVG(CAST(average_check_target_amount AS DOUBLE))
      comment: "Average check target amount across revenue centers. Tracks pricing ambition and upsell target setting."
    - name: "iso_22000_certified_count"
      expr: COUNT(CASE WHEN iso_22000_certified_flag = TRUE THEN 1 END)
      comment: "Number of ISO 22000 certified revenue centers. Food safety compliance KPI for regulatory and brand standards."
    - name: "iso_22000_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_22000_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active revenue centers with ISO 22000 certification. Strategic food safety compliance KPI for brand and regulatory governance."
    - name: "pos_integrated_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pos_integration_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revenue centers with POS integration enabled. Technology adoption KPI for data completeness and digital transformation tracking."
$$;
