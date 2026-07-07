-- Metric views for domain: fnb | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_event_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet and event order revenue metrics covering food, beverage, service charges, and tax. Enables catering sales performance management and event profitability analysis."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`"
  filter: event_status NOT IN ('CANCELLED', 'NO_SHOW')
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the banquet event for temporal revenue trend analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event (wedding, conference, gala, etc.) for segment-level revenue analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event order (confirmed, tentative, completed) for pipeline and conversion tracking."
    - name: "beverage_package_type"
      expr: beverage_package_type
      comment: "Beverage package type selected for the event. Drives beverage revenue mix analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup style (theatre, banquet, classroom) for space utilization and capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the event order for multi-currency catering revenue reporting."
  measures:
    - name: "total_event_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total gross revenue from banquet event orders. Primary catering revenue KPI for sales performance and forecasting."
    - name: "total_food_revenue"
      expr: SUM(CAST(food_revenue AS DOUBLE))
      comment: "Total food revenue from banquet events. Used to track food mix and per-person food yield."
    - name: "total_beverage_revenue"
      expr: SUM(CAST(beverage_revenue AS DOUBLE))
      comment: "Total beverage revenue from banquet events. Tracks beverage attach rate and package uptake."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected on banquet orders. Key for labor cost recovery in catering operations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on banquet orders. Required for tax compliance and remittance."
    - name: "event_order_count"
      expr: COUNT(1)
      comment: "Total number of banquet event orders. Volume baseline for catering pipeline and conversion rate analysis."
    - name: "avg_revenue_per_event"
      expr: AVG(CAST(total_revenue AS DOUBLE))
      comment: "Average total revenue per banquet event. Benchmarks event value and informs minimum spend policies."
    - name: "avg_food_revenue_per_event"
      expr: AVG(CAST(food_revenue AS DOUBLE))
      comment: "Average food revenue per event. Supports per-person food pricing strategy and package design."
    - name: "avg_beverage_revenue_per_event"
      expr: AVG(CAST(beverage_revenue AS DOUBLE))
      comment: "Average beverage revenue per event. Informs beverage package pricing and upsell strategy."
    - name: "beverage_to_food_revenue_ratio"
      expr: ROUND(SUM(CAST(beverage_revenue AS DOUBLE)) / NULLIF(SUM(CAST(food_revenue AS DOUBLE)), 0), 4)
      comment: "Ratio of beverage to food revenue. Industry benchmark for catering mix; higher ratios indicate strong beverage upsell."
    - name: "avg_per_person_food_price"
      expr: AVG(CAST(per_person_food_price AS DOUBLE))
      comment: "Average per-person food price across events. Core pricing KPI for catering sales and package benchmarking."
    - name: "avg_per_person_beverage_price"
      expr: AVG(CAST(per_person_beverage_price AS DOUBLE))
      comment: "Average per-person beverage price across events. Supports beverage package yield management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_menu_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet menu package metrics for catering product portfolio management, pricing analysis, and cost control. Supports catering sales strategy and package profitability."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package`"
  filter: package_status = 'ACTIVE'
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of banquet package (Full Day, Half Day, Dinner, Reception) for portfolio segmentation."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category of the package for cuisine and service style analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (Active, Inactive, Seasonal) for portfolio management."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Flag for seasonal packages. Supports seasonal catering planning."
    - name: "service_style"
      expr: service_style
      comment: "Service style (Buffet, Plated, Family Style) for operational planning."
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Flag indicating whether package price is tax-inclusive. Impacts revenue recognition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package pricing."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of banquet menu packages. Baseline for catering portfolio breadth."
    - name: "avg_per_person_price"
      expr: AVG(CAST(per_person_price AS DOUBLE))
      comment: "Average per-person package price. Benchmarks catering pricing strategy."
    - name: "avg_food_cost_percentage"
      expr: AVG(CAST(food_cost_percentage AS DOUBLE))
      comment: "Average food cost percentage across packages. Core catering profitability KPI."
    - name: "avg_beverage_cost_percentage"
      expr: AVG(CAST(beverage_cost_percentage AS DOUBLE))
      comment: "Average beverage cost percentage across packages. Tracks beverage margin performance."
    - name: "avg_labor_hours_per_guest"
      expr: AVG(CAST(labor_hours_per_guest AS DOUBLE))
      comment: "Average labor hours required per guest. Drives staffing cost forecasting for events."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across packages. Validates pricing policy consistency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B discount program metrics covering discount value, usage scope, and promotional structure. Enables discount policy governance and margin impact analysis."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`discount`"
  filter: discount_status = 'ACTIVE'
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed amount, BOGO) for discount structure analysis."
    - name: "discount_category"
      expr: discount_category
      comment: "Category of discount (loyalty, promotional, employee, manager) for discount program segmentation."
    - name: "discount_status"
      expr: discount_status
      comment: "Status of the discount (active, expired, suspended) for active discount portfolio management."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue class the discount applies to (food, beverage, all) for revenue impact scoping."
    - name: "combinable_with_other_discounts"
      expr: combinable_with_other_discounts
      comment: "Flag indicating if the discount can be combined with others. Controls discount stacking risk."
    - name: "promo_code_required"
      expr: promo_code_required
      comment: "Flag indicating a promo code is required. Differentiates targeted vs. open discounts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the discount for multi-currency discount reporting."
  measures:
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage across active discounts. Benchmarks promotional depth and margin erosion risk."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average fixed discount amount. Supports discount value benchmarking and policy governance."
    - name: "avg_minimum_check_amount"
      expr: AVG(CAST(minimum_check_amount AS DOUBLE))
      comment: "Average minimum check amount required to qualify for a discount. Informs discount threshold policy design."
    - name: "avg_max_discount_per_check"
      expr: AVG(CAST(maximum_discount_amount_per_check AS DOUBLE))
      comment: "Average maximum discount cap per check. Tracks discount exposure limits and margin protection policies."
    - name: "active_discount_count"
      expr: COUNT(1)
      comment: "Total number of active discounts. Baseline for promotional program complexity and governance."
    - name: "combinable_discount_count"
      expr: SUM(CASE WHEN combinable_with_other_discounts = true THEN 1 ELSE 0 END)
      comment: "Number of discounts that can be combined with others. Tracks discount stacking risk exposure."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Outlet business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`fnb_outlet`"
  dimensions:
    - name: "Accepts Reservations Flag"
      expr: accepts_reservations_flag
    - name: "Ada Compliant Flag"
      expr: ada_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Category"
      expr: cuisine_category
    - name: "Dress Code"
      expr: dress_code
    - name: "Email Address"
      expr: email_address
    - name: "Iso 22000 Certification Date"
      expr: iso_22000_certification_date
    - name: "Iso 22000 Certified Flag"
      expr: iso_22000_certified_flag
    - name: "Iso 22000 Expiry Date"
      expr: iso_22000_expiry_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Location Description"
      expr: location_description
    - name: "Menu Last Updated Date"
      expr: menu_last_updated_date
    - name: "Opening Date"
      expr: opening_date
    - name: "Operating Hours Weekday"
      expr: operating_hours_weekday
    - name: "Operating Hours Weekend"
      expr: operating_hours_weekend
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fnb Outlet"
      expr: COUNT(DISTINCT fnb_outlet_id)
    - name: "Total Average Check Target"
      expr: SUM(average_check_target)
    - name: "Average Average Check Target"
      expr: AVG(average_check_target)
    - name: "Total Beverage Cost Percentage Target"
      expr: SUM(beverage_cost_percentage_target)
    - name: "Average Beverage Cost Percentage Target"
      expr: AVG(beverage_cost_percentage_target)
    - name: "Total Food Cost Percentage Target"
      expr: SUM(food_cost_percentage_target)
    - name: "Average Food Cost Percentage Target"
      expr: AVG(food_cost_percentage_target)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B outlet master metrics covering financial targets, compliance certifications, and operational attributes. Enables outlet portfolio management and performance benchmarking."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`"
  filter: outlet_status = 'ACTIVE'
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (restaurant, bar, café, banquet) for outlet category benchmarking."
    - name: "cuisine_category"
      expr: cuisine_category
      comment: "Cuisine category for culinary portfolio and brand positioning analysis."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Operational status of the outlet for active portfolio management."
    - name: "service_style"
      expr: service_style
      comment: "Service style (full service, quick service, buffet) for operational model analysis."
    - name: "iso_22000_certified_flag"
      expr: iso_22000_certified_flag
      comment: "ISO 22000 food safety certification status. Compliance KPI for regulatory and brand standards."
    - name: "accepts_reservations_flag"
      expr: accepts_reservations_flag
      comment: "Flag indicating the outlet accepts reservations. Supports revenue management and capacity planning."
  measures:
    - name: "avg_check_target"
      expr: AVG(CAST(average_check_target AS DOUBLE))
      comment: "Average check target across outlets. Benchmarks revenue per cover targets for outlet performance management."
    - name: "avg_food_cost_target_pct"
      expr: AVG(CAST(food_cost_percentage_target AS DOUBLE))
      comment: "Average food cost target percentage across outlets. Baseline for food cost performance benchmarking."
    - name: "avg_beverage_cost_target_pct"
      expr: AVG(CAST(beverage_cost_percentage_target AS DOUBLE))
      comment: "Average beverage cost target percentage across outlets. Baseline for beverage cost performance benchmarking."
    - name: "outlet_count"
      expr: COUNT(1)
      comment: "Total number of active F&B outlets. Portfolio size baseline for capacity and investment planning."
    - name: "iso_22000_certified_outlet_count"
      expr: SUM(CASE WHEN iso_22000_certified_flag = true THEN 1 ELSE 0 END)
      comment: "Number of ISO 22000 certified outlets. Compliance portfolio KPI for regulatory standing and brand standards."
    - name: "iso_22000_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_22000_certified_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active outlets with ISO 22000 certification. Strategic food safety compliance KPI for executive reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_fnb_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Supply Agreement business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`fnb_supply_agreement`"
  dimensions:
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Last Purchase Date"
      expr: last_purchase_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Vendor Item Code"
      expr: vendor_item_code
    - name: "Agreement End Date Month"
      expr: DATE_TRUNC('MONTH', agreement_end_date)
    - name: "Agreement Start Date Month"
      expr: DATE_TRUNC('MONTH', agreement_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fnb Supply Agreement"
      expr: COUNT(DISTINCT fnb_supply_agreement_id)
    - name: "Total Last Purchase Cost"
      expr: SUM(last_purchase_cost)
    - name: "Average Last Purchase Cost"
      expr: AVG(last_purchase_cost)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_food_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety inspection metrics tracking compliance scores, violation rates, and corrective action status. Critical for regulatory compliance, brand protection, and ISO 22000 certification management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the food safety inspection for compliance trend analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, follow-up, audit, regulatory) for inspection category analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (completed, pending, failed) for compliance monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status outcome (compliant, non-compliant, conditional) for regulatory reporting."
    - name: "inspection_grade"
      expr: inspection_grade
      comment: "Grade assigned by the inspector (A, B, C, etc.) for public-facing compliance benchmarking."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body conducting the inspection for jurisdiction-level compliance tracking."
    - name: "haccp_compliance_flag"
      expr: haccp_compliance_flag
      comment: "HACCP compliance flag for food safety program adherence reporting."
    - name: "iso_22000_compliance_flag"
      expr: iso_22000_compliance_flag
      comment: "ISO 22000 compliance flag for certification maintenance tracking."
    - name: "reinspection_required_flag"
      expr: reinspection_required_flag
      comment: "Flag indicating a reinspection is required. Tracks non-compliance severity."
  measures:
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average food safety inspection score. Primary compliance KPI for regulatory standing and brand protection."
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of food safety inspections. Baseline for inspection frequency and regulatory coverage."
    - name: "reinspection_required_count"
      expr: SUM(CASE WHEN reinspection_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of inspections requiring reinspection. Critical compliance risk KPI; high counts signal systemic food safety failures."
    - name: "haccp_compliant_count"
      expr: SUM(CASE WHEN haccp_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of inspections with HACCP compliance confirmed. Tracks HACCP program effectiveness."
    - name: "iso_22000_compliant_count"
      expr: SUM(CASE WHEN iso_22000_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of inspections with ISO 22000 compliance confirmed. Supports certification audit readiness."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinspection_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. Regulatory risk KPI; target is 0% for premium hospitality brands."
    - name: "haccp_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_compliance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "HACCP compliance rate across all inspections. Mandatory food safety program KPI for regulatory and brand standards."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B inventory item master metrics covering stock levels, cost, and dietary/compliance attributes. Enables procurement planning, cost management, and food safety compliance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the inventory item (food, beverage, dry goods) for category-level stock analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Subcategory for granular inventory classification and procurement planning."
    - name: "item_status"
      expr: item_status
      comment: "Status of the inventory item (active, discontinued, on-hold) for active stock management."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag for temperature-controlled items. Critical for cold chain compliance and storage cost allocation."
    - name: "alcohol_flag"
      expr: alcohol_flag
      comment: "Flag for alcoholic items. Required for liquor license compliance and beverage cost tracking."
    - name: "local_sourced_flag"
      expr: local_sourced_flag
      comment: "Flag for locally sourced items. Supports sustainability reporting and local procurement targets."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Flag for organic items. Supports premium menu positioning and sustainability KPIs."
  measures:
    - name: "total_on_hand_value"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total value of current on-hand inventory (quantity × standard cost). Primary inventory asset KPI for balance sheet and working capital management."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per inventory item. Benchmarks procurement pricing and cost inflation trends."
    - name: "total_current_on_hand_quantity"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE))
      comment: "Total quantity of all active inventory items on hand. Baseline for stock coverage and reorder planning."
    - name: "items_below_par_count"
      expr: SUM(CASE WHEN current_on_hand_quantity < par_level THEN 1 ELSE 0 END)
      comment: "Number of items below par level. Critical procurement alert KPI; drives reorder decisions and prevents stockouts."
    - name: "items_below_reorder_point_count"
      expr: SUM(CASE WHEN current_on_hand_quantity < reorder_point THEN 1 ELSE 0 END)
      comment: "Number of items at or below reorder point. Triggers procurement action to prevent service disruption."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inventory items. Informs recipe costing accuracy and portion control standards."
    - name: "active_item_count"
      expr: COUNT(1)
      comment: "Total number of active inventory items. Baseline for inventory complexity and procurement portfolio management."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`menu`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Allergen Information"
      expr: allergen_information
    - name: "Approved Date"
      expr: approved_date
    - name: "Beverage Description"
      expr: beverage_description
    - name: "Beverage Inclusion Flag"
      expr: beverage_inclusion_flag
    - name: "Course Count"
      expr: course_count
    - name: "Course Description"
      expr: course_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Currency Code"
      expr: currency_code
    - name: "Dietary Options"
      expr: dietary_options
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Capacity"
      expr: maximum_capacity
    - name: "Meal Period"
      expr: meal_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Menu"
      expr: COUNT(DISTINCT menu_id)
    - name: "Total Per Person Price"
      expr: SUM(per_person_price)
    - name: "Average Per Person Price"
      expr: AVG(per_person_price)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item master metrics for menu engineering, pricing analysis, and cost management. Enables data-driven menu optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the menu item (Appetizer, Entree, Dessert, Beverage) for menu section analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Subcategory for granular menu engineering analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (Active, Inactive, Seasonal) for menu lifecycle management."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag for seasonal items. Supports seasonal menu planning and cost forecasting."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Flag for signature items. Tracks performance of brand-defining menu items."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag for vegan items. Supports dietary preference trend analysis."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Flag for gluten-free items. Tracks dietary accommodation menu coverage."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Flag for alcoholic items. Separates food and beverage cost analysis."
  measures:
    - name: "total_menu_items"
      expr: COUNT(1)
      comment: "Total number of menu items. Baseline for menu breadth and complexity analysis."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard selling price across menu items. Benchmarks menu pricing strategy."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price across menu items. Tracks ingredient cost trends."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Core menu profitability KPI."
    - name: "total_active_items"
      expr: COUNT(CASE WHEN item_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active menu items. Tracks menu size for operational complexity management."
    - name: "signature_item_count"
      expr: SUM(CASE WHEN is_signature_item = TRUE THEN 1 ELSE 0 END)
      comment: "Number of signature menu items. Tracks brand differentiation through menu composition."
    - name: "avg_alcohol_content_pct"
      expr: AVG(CASE WHEN is_alcoholic = TRUE THEN alcohol_content_percent ELSE NULL END)
      comment: "Average alcohol content percentage for alcoholic items. Supports responsible service compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count metrics tracking variance, count accuracy, and adjustment activity. Enables inventory accuracy management and audit compliance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`physical_count`"
  filter: count_status != 'CANCELLED'
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date of the physical count for periodic inventory accuracy trend analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, spot, cycle) for count methodology analysis."
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (in-progress, completed, approved) for count completion monitoring."
    - name: "count_reason"
      expr: count_reason
      comment: "Reason for the count (scheduled, discrepancy, audit) for root cause analysis."
    - name: "adjustment_required"
      expr: adjustment_required
      comment: "Flag indicating whether an inventory adjustment was required. Tracks count accuracy outcomes."
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating a recount was needed. Proxy for count quality and process adherence."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count for period-end inventory reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for variance value reporting."
  measures:
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total monetary variance identified across all physical counts. Primary inventory accuracy KPI for loss prevention and audit."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage per count. Benchmarks inventory accuracy against industry targets (typically <1%)."
    - name: "count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events. Baseline for count frequency compliance and audit coverage."
    - name: "counts_requiring_adjustment"
      expr: SUM(CASE WHEN adjustment_required = true THEN 1 ELSE 0 END)
      comment: "Number of counts that required inventory adjustments. Measures inventory discrepancy frequency."
    - name: "counts_requiring_recount"
      expr: SUM(CASE WHEN recount_required = true THEN 1 ELSE 0 END)
      comment: "Number of counts that required a recount. Proxy for count process quality and staff training needs."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring adjustment. Key inventory control KPI; high rates signal systemic shrinkage or process failure."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount. Measures count process reliability and staff competency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check metrics providing revenue, discount, tip, and service charge performance across outlets, meal periods, and order types. Core operational KPI layer for F&B revenue management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  filter: check_status != 'VOIDED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the POS check for daily trend analysis."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (breakfast, lunch, dinner, late-night) for daypart revenue analysis."
    - name: "order_type"
      expr: order_type
      comment: "Order type (dine-in, takeaway, delivery, room-charge) for channel mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source channel of the order (POS, app, phone) for omnichannel analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (cash, card, room charge, loyalty) for tender mix analysis."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the check (open, closed, voided) for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency reporting."
  measures:
    - name: "total_check_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from all POS checks. Primary F&B revenue KPI used in daily revenue reporting and P&L."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-service-charge subtotals. Used to isolate net food and beverage revenue before charges."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all checks. Tracks promotional spend and discount leakage impacting margin."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected. Key for labor cost recovery and gratuity pool management."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all checks. Required for tax compliance and remittance reporting."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity/tip collected. Informs staff compensation and service quality benchmarking."
    - name: "check_count"
      expr: COUNT(1)
      comment: "Total number of POS checks. Baseline volume metric for throughput and staffing analysis."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average check value per transaction. Core hospitality KPI for spend-per-cover benchmarking and menu engineering."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and margin erosion risk."
    - name: "service_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of subtotal. Validates service charge policy compliance across outlets."
    - name: "avg_tip_per_check"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per check. Proxy for guest satisfaction and service quality at the transaction level."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level POS metrics enabling menu item profitability, void analysis, and cost-of-sales tracking. Drives menu engineering and waste reduction decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  filter: is_voided = false
  dimensions:
    - name: "family_group_code"
      expr: family_group_code
      comment: "Family group classification (food, beverage, etc.) for category-level revenue analysis."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major group classification for hierarchical menu revenue reporting."
    - name: "course_number"
      expr: course_number
      comment: "Course sequence (starter, main, dessert) for course-level revenue and margin analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Used to track comp cost and policy adherence."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency line-level reporting."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all non-voided check lines. Granular revenue base for menu engineering and item profitability."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of sales across all lines. Core input for gross margin and food cost percentage calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total line-level discounts. Identifies which menu categories absorb the most promotional spend."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items ordered. Drives menu popularity ranking and procurement forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per line item. Used in menu pricing strategy and yield management."
    - name: "gross_margin_amount"
      expr: SUM((CAST(line_total_amount AS DOUBLE)) - (CAST(cost_of_sales AS DOUBLE)))
      comment: "Gross margin in absolute terms (revenue minus cost of sales). Primary profitability KPI for menu engineering."
    - name: "food_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_of_sales AS DOUBLE)) / NULLIF(SUM(CAST(line_total_amount AS DOUBLE)), 0), 2)
      comment: "Food cost as a percentage of line revenue. Industry-standard KPI; target typically 28-35% for food, 18-24% for beverage."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of non-voided check lines. Volume baseline for item mix and throughput analysis."
    - name: "avg_line_revenue"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average revenue per check line. Supports upsell effectiveness and menu item contribution analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe cost and nutritional metrics enabling menu engineering, food cost management, and dietary compliance. Supports standard cost setting and culinary program governance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`recipe`"
  filter: recipe_status = 'ACTIVE'
  dimensions:
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (food, beverage, cocktail, dessert) for category-level cost analysis."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for culinary program and menu diversity analysis."
    - name: "recipe_status"
      expr: recipe_status
      comment: "Status of the recipe (active, archived, in-development) for active recipe portfolio management."
    - name: "seasonal_availability"
      expr: seasonal_availability
      comment: "Seasonal availability of the recipe for menu planning and procurement forecasting."
    - name: "iso_22000_ccp_flag"
      expr: iso_22000_ccp_flag
      comment: "Flag indicating the recipe has a critical control point per ISO 22000. Food safety compliance dimension."
  measures:
    - name: "avg_total_recipe_cost"
      expr: AVG(CAST(total_recipe_cost AS DOUBLE))
      comment: "Average total cost per recipe. Core menu engineering KPI for pricing and margin management."
    - name: "avg_food_cost_per_portion"
      expr: AVG(CAST(standard_food_cost_per_portion AS DOUBLE))
      comment: "Average standard food cost per portion. Primary recipe costing KPI for menu pricing and food cost control."
    - name: "avg_beverage_cost_per_portion"
      expr: AVG(CAST(standard_beverage_cost_per_portion AS DOUBLE))
      comment: "Average standard beverage cost per portion. Supports beverage menu pricing and cost management."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Informs batch production planning and portion standardization."
    - name: "avg_nutritional_protein_grams"
      expr: AVG(CAST(nutritional_protein_grams AS DOUBLE))
      comment: "Average protein content per recipe. Supports nutritional labeling compliance and health-focused menu positioning."
    - name: "avg_nutritional_fat_grams"
      expr: AVG(CAST(nutritional_fat_grams AS DOUBLE))
      comment: "Average fat content per recipe. Supports nutritional compliance and dietary accommodation reporting."
    - name: "avg_nutritional_carbohydrate_grams"
      expr: AVG(CAST(nutritional_carbohydrate_grams AS DOUBLE))
      comment: "Average carbohydrate content per recipe. Supports dietary labeling and health-conscious menu management."
    - name: "recipe_count"
      expr: COUNT(1)
      comment: "Total number of active recipes. Baseline for culinary portfolio breadth and menu complexity management."
    - name: "ccp_recipe_count"
      expr: SUM(CASE WHEN iso_22000_ccp_flag = true THEN 1 ELSE 0 END)
      comment: "Number of recipes with critical control points. Food safety compliance KPI for HACCP and ISO 22000 program management."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_recipe_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe Ingredient business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`recipe_ingredient`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Allergen Contribution"
      expr: allergen_contribution
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Control Point Flag"
      expr: critical_control_point_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Ingredient Category"
      expr: ingredient_category
    - name: "Ingredient Name"
      expr: ingredient_name
    - name: "Line Number"
      expr: line_number
    - name: "Local Sourcing Flag"
      expr: local_sourcing_flag
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nutritional Value Per Unit"
      expr: nutritional_value_per_unit
    - name: "Organic Certified Flag"
      expr: organic_certified_flag
    - name: "Preparation Instruction"
      expr: preparation_instruction
    - name: "Seasonality Flag"
      expr: seasonality_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recipe Ingredient"
      expr: COUNT(DISTINCT recipe_ingredient_id)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Par Level"
      expr: SUM(par_level)
    - name: "Average Par Level"
      expr: AVG(par_level)
    - name: "Total Quantity Required"
      expr: SUM(quantity_required)
    - name: "Average Quantity Required"
      expr: AVG(quantity_required)
    - name: "Total Standard Cost Per Unit"
      expr: SUM(standard_cost_per_unit)
    - name: "Average Standard Cost Per Unit"
      expr: AVG(standard_cost_per_unit)
    - name: "Total Waste Percentage"
      expr: SUM(waste_percentage)
    - name: "Average Waste Percentage"
      expr: AVG(waste_percentage)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_revenue_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Center business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`revenue_center`"
  dimensions:
    - name: "Allergen Menu Available Flag"
      expr: allergen_menu_available_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Covers Per Day Target"
      expr: covers_per_day_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Day Part Service Flag"
      expr: day_part_service_flag
    - name: "Dress Code"
      expr: dress_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Gratuity Policy"
      expr: gratuity_policy
    - name: "Iso 22000 Certified Flag"
      expr: iso_22000_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Micros Rvc Number"
      expr: micros_rvc_number
    - name: "Notes"
      expr: notes
    - name: "Opening Date"
      expr: opening_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Center"
      expr: COUNT(DISTINCT revenue_center_id)
    - name: "Total Average Check Target Amount"
      expr: SUM(average_check_target_amount)
    - name: "Average Average Check Target Amount"
      expr: AVG(average_check_target_amount)
    - name: "Total Beverage Cost Target Percentage"
      expr: SUM(beverage_cost_target_percentage)
    - name: "Average Beverage Cost Target Percentage"
      expr: AVG(beverage_cost_target_percentage)
    - name: "Total Food Cost Target Percentage"
      expr: SUM(food_cost_target_percentage)
    - name: "Average Food Cost Target Percentage"
      expr: AVG(food_cost_target_percentage)
    - name: "Total Labor Cost Target Percentage"
      expr: SUM(labor_cost_target_percentage)
    - name: "Average Labor Cost Target Percentage"
      expr: AVG(labor_cost_target_percentage)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order metrics covering revenue, delivery performance, and guest satisfaction. Enables in-room dining profitability and service level management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  filter: order_status != 'CANCELLED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the room service order for daily revenue and volume trend analysis."
    - name: "order_status"
      expr: order_status
      comment: "Status of the room service order (pending, delivered, cancelled) for fulfillment monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Source channel of the order (phone, app, in-room tablet) for channel mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the room service order for tender mix analysis."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Flag indicating on-time delivery. Core service level KPI for guest satisfaction management."
    - name: "is_vip_guest"
      expr: is_vip_guest
      comment: "VIP guest flag for premium service level differentiation and VIP revenue tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the room service order."
  measures:
    - name: "total_room_service_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total room service revenue. Primary in-room dining revenue KPI for F&B department P&L."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-charge subtotal for room service orders. Isolates net food and beverage revenue."
    - name: "total_delivery_charge"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Tracks delivery fee revenue and cost recovery."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on room service orders. Informs staff compensation and service quality."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Tracks promotional spend in in-room dining channel."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of room service orders. Volume baseline for in-room dining demand and staffing."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average room service order value. Benchmarks in-room dining spend and informs menu pricing strategy."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_delivery_flag = true THEN 1 ELSE 0 END)
      comment: "Number of orders delivered on time. Service level compliance metric for guest satisfaction management."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_delivery_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time delivery rate for room service. Critical guest satisfaction KPI; target typically 90%+ for luxury properties."
    - name: "vip_order_revenue"
      expr: SUM(CASE WHEN is_vip_guest = true THEN total_amount ELSE 0 END)
      comment: "Total room service revenue from VIP guests. Tracks premium guest spend and informs VIP service investment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock transaction metrics covering cost of goods movement, variance, and waste. Enables inventory cost control, shrinkage analysis, and procurement efficiency measurement."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  filter: transaction_status != 'CANCELLED'
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for daily inventory movement trend analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (receipt, issue, transfer, adjustment, waste) for movement category analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (posted, pending, reversed) for reconciliation monitoring."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock movement for daypart consumption analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for waste-type stock transactions. Supports waste reduction targeting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity reporting consistency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the stock transaction for multi-currency cost reporting."
  measures:
    - name: "total_stock_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements. Primary inventory cost KPI for COGS and food cost percentage calculations."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all transaction types. Volume baseline for consumption and procurement planning."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total inventory variance in monetary terms. Key shrinkage and loss KPI for inventory control and audit."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock transactions. Tracks cost inflation and supplier pricing trends."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Volume baseline for inventory activity and operational throughput."
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Variance as a percentage of total stock cost. Industry-standard shrinkage rate KPI; target typically below 1-2%."
    - name: "waste_transaction_cost"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN total_cost ELSE 0 END)
      comment: "Total cost of waste-type stock transactions. Isolates waste-driven inventory loss for sustainability and cost reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`storage_location`"
  dimensions:
    - name: "Access Restriction Level"
      expr: access_restriction_level
    - name: "Active From Date"
      expr: active_from_date
    - name: "Active Until Date"
      expr: active_until_date
    - name: "Allergen Segregation Required Flag"
      expr: allergen_segregation_required_flag
    - name: "Barcode"
      expr: barcode
    - name: "Building Name"
      expr: building_name
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Floor Level"
      expr: floor_level
    - name: "Hazmat Approved Flag"
      expr: hazmat_approved_flag
    - name: "Inspection Frequency Days"
      expr: inspection_frequency_days
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Location Code"
      expr: location_code
    - name: "Location Name"
      expr: location_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Location"
      expr: COUNT(DISTINCT storage_location_id)
    - name: "Total Capacity Cubic Meters"
      expr: SUM(capacity_cubic_meters)
    - name: "Average Capacity Cubic Meters"
      expr: AVG(capacity_cubic_meters)
    - name: "Total Target Temperature Max Celsius"
      expr: SUM(target_temperature_max_celsius)
    - name: "Average Target Temperature Max Celsius"
      expr: AVG(target_temperature_max_celsius)
    - name: "Total Target Temperature Min Celsius"
      expr: SUM(target_temperature_min_celsius)
    - name: "Average Target Temperature Min Celsius"
      expr: AVG(target_temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_void_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS void transaction metrics tracking voided revenue, quantities, and investigation rates. Enables fraud detection, loss prevention, and operational control monitoring."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`void_transaction`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the void for daily void trend and anomaly detection."
    - name: "void_type"
      expr: void_type
      comment: "Type of void (item void, check void, split) for void category analysis."
    - name: "void_reason_code"
      expr: void_reason_code
      comment: "Reason code for the void (error, guest request, manager comp) for root cause analysis."
    - name: "void_status"
      expr: void_status
      comment: "Current status of the void transaction for reconciliation monitoring."
    - name: "requires_investigation"
      expr: requires_investigation
      comment: "Flag indicating the void requires investigation. Prioritizes fraud and loss prevention review."
    - name: "day_part"
      expr: day_part
      comment: "Day part during which the void occurred for operational pattern analysis."
    - name: "is_employee_meal"
      expr: is_employee_meal
      comment: "Flag for employee meal voids to separate operational comps from guest-facing voids."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the voided transaction."
  measures:
    - name: "total_voided_amount"
      expr: SUM(CAST(voided_total_amount AS DOUBLE))
      comment: "Total monetary value of all voided transactions. Primary loss prevention KPI; high values trigger fraud investigation."
    - name: "total_voided_quantity"
      expr: SUM(CAST(voided_quantity AS DOUBLE))
      comment: "Total quantity of items voided. Volume baseline for void frequency and portion control analysis."
    - name: "total_voided_service_charge"
      expr: SUM(CAST(voided_service_charge_amount AS DOUBLE))
      comment: "Total service charges voided. Tracks service charge recovery leakage."
    - name: "total_voided_tax"
      expr: SUM(CAST(voided_tax_amount AS DOUBLE))
      comment: "Total tax voided. Required for tax reconciliation and compliance reporting."
    - name: "void_count"
      expr: COUNT(1)
      comment: "Total number of void transactions. Baseline frequency metric for operational control monitoring."
    - name: "investigation_required_count"
      expr: SUM(CASE WHEN requires_investigation = true THEN 1 ELSE 0 END)
      comment: "Number of voids flagged for investigation. Critical fraud and loss prevention KPI."
    - name: "investigation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_investigation = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voids requiring investigation. Fraud risk indicator; elevated rates trigger internal audit escalation."
    - name: "avg_voided_amount"
      expr: AVG(CAST(voided_total_amount AS DOUBLE))
      comment: "Average value per void transaction. Benchmarks void severity and informs authorization threshold policies."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food and beverage waste metrics tracking waste cost, quantity, and sustainability impact by outlet, category, and meal period. Drives cost reduction and sustainability reporting."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`waste_log`"
  dimensions:
    - name: "waste_date"
      expr: waste_date
      comment: "Date of waste recording for daily and trend waste analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (food, beverage, packaging) for targeted reduction initiatives."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (spoilage, over-production, trim, plate waste) for root cause analysis."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason for waste occurrence. Drives corrective action prioritization."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period during which waste occurred. Identifies high-waste dayparts for operational intervention."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of disposal (composting, landfill, donation) for sustainability reporting."
    - name: "food_category"
      expr: food_category
      comment: "Food category of wasted item for category-level waste cost analysis."
    - name: "sustainability_impact_flag"
      expr: sustainability_impact_flag
      comment: "Flag indicating sustainability-relevant waste events for ESG reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for waste cost reporting."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(total_waste_cost AS DOUBLE))
      comment: "Total cost of food and beverage waste. Primary waste KPI for cost control and sustainability targets."
    - name: "total_quantity_wasted"
      expr: SUM(CAST(quantity_wasted AS DOUBLE))
      comment: "Total quantity of items wasted. Volume baseline for waste reduction program tracking."
    - name: "avg_unit_waste_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of wasted items. Identifies high-value waste categories for prioritized intervention."
    - name: "waste_log_count"
      expr: COUNT(1)
      comment: "Total number of waste log entries. Frequency baseline for waste event monitoring."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(total_waste_cost AS DOUBLE))
      comment: "Average waste cost per waste log entry. Benchmarks waste severity and informs portion control decisions."
    - name: "sustainability_waste_cost"
      expr: SUM(CASE WHEN sustainability_impact_flag = true THEN total_waste_cost ELSE 0 END)
      comment: "Total waste cost flagged as having sustainability impact. Core ESG reporting metric for environmental compliance."
    - name: "health_safety_incident_waste_count"
      expr: SUM(CASE WHEN health_safety_incident_flag = true THEN 1 ELSE 0 END)
      comment: "Count of waste events linked to health and safety incidents. Critical food safety KPI for regulatory compliance."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_wine_cellar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wine Cellar business metrics"
  source: "`travel_hospitality_ecm`.`fnb`.`wine_cellar`"
  dimensions:
    - name: "Appellation"
      expr: appellation
    - name: "Bin Location"
      expr: bin_location
    - name: "Bottle Size Ml"
      expr: bottle_size_ml
    - name: "By The Glass Program Flag"
      expr: by_the_glass_program_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Food Pairing Recommendations"
      expr: food_pairing_recommendations
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Last Inventory Count Date"
      expr: last_inventory_count_date
    - name: "Last Purchase Date"
      expr: last_purchase_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Optimal Drinking Window End"
      expr: optimal_drinking_window_end
    - name: "Optimal Drinking Window Start"
      expr: optimal_drinking_window_start
    - name: "Par Level"
      expr: par_level
    - name: "Producer Name"
      expr: producer_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wine Cellar"
      expr: COUNT(DISTINCT wine_cellar_id)
    - name: "Total Alcohol By Volume Pct"
      expr: SUM(alcohol_by_volume_pct)
    - name: "Average Alcohol By Volume Pct"
      expr: AVG(alcohol_by_volume_pct)
    - name: "Total Purchase Cost Per Bottle"
      expr: SUM(purchase_cost_per_bottle)
    - name: "Average Purchase Cost Per Bottle"
      expr: AVG(purchase_cost_per_bottle)
    - name: "Total Selling Price Bottle"
      expr: SUM(selling_price_bottle)
    - name: "Average Selling Price Bottle"
      expr: AVG(selling_price_bottle)
    - name: "Total Selling Price Glass"
      expr: SUM(selling_price_glass)
    - name: "Average Selling Price Glass"
      expr: AVG(selling_price_glass)
    - name: "Total Storage Temperature Celsius"
      expr: SUM(storage_temperature_celsius)
    - name: "Average Storage Temperature Celsius"
      expr: AVG(storage_temperature_celsius)
$$;
