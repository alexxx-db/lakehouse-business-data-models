-- Metric views for domain: fnb | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:27:36

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_event_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`"
  dimensions:
    - name: "Actual Covers"
      expr: actual_covers
    - name: "Beo Number"
      expr: beo_number
    - name: "Beverage Package Type"
      expr: beverage_package_type
    - name: "Billing Instructions"
      expr: billing_instructions
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dietary Requirements"
      expr: dietary_requirements
    - name: "Event Date"
      expr: event_date
    - name: "Event End Time"
      expr: event_end_time
    - name: "Event Name"
      expr: event_name
    - name: "Event Start Time"
      expr: event_start_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Banquet Event Order"
      expr: COUNT(DISTINCT banquet_event_order_id)
    - name: "Total Function Space Id Fk"
      expr: SUM(function_space_id_fk)
    - name: "Average Function Space Id Fk"
      expr: AVG(function_space_id_fk)
    - name: "Total Beverage Revenue"
      expr: SUM(beverage_revenue)
    - name: "Average Beverage Revenue"
      expr: AVG(beverage_revenue)
    - name: "Total Food Revenue"
      expr: SUM(food_revenue)
    - name: "Average Food Revenue"
      expr: AVG(food_revenue)
    - name: "Total Per Person Beverage Price"
      expr: SUM(per_person_beverage_price)
    - name: "Average Per Person Beverage Price"
      expr: AVG(per_person_beverage_price)
    - name: "Total Per Person Food Price"
      expr: SUM(per_person_food_price)
    - name: "Average Per Person Food Price"
      expr: AVG(per_person_food_price)
    - name: "Total Service Charge Amount"
      expr: SUM(service_charge_amount)
    - name: "Average Service Charge Amount"
      expr: AVG(service_charge_amount)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Percentage"
      expr: SUM(tax_percentage)
    - name: "Average Tax Percentage"
      expr: AVG(tax_percentage)
    - name: "Total Total Revenue"
      expr: SUM(total_revenue)
    - name: "Average Total Revenue"
      expr: AVG(total_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_menu_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Menu Package business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package`"
  dimensions:
    - name: "Advance Notice Days"
      expr: advance_notice_days
    - name: "Allergen Information"
      expr: allergen_information
    - name: "Approval Date"
      expr: approval_date
    - name: "Beverage Inclusion"
      expr: beverage_inclusion
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dietary Accommodations"
      expr: dietary_accommodations
    - name: "Included Courses"
      expr: included_courses
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Capacity"
      expr: maximum_capacity
    - name: "Menu Category"
      expr: menu_category
    - name: "Minimum Guarantee"
      expr: minimum_guarantee
    - name: "Package Code"
      expr: package_code
    - name: "Package Name"
      expr: package_name
    - name: "Package Notes"
      expr: package_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Banquet Menu Package"
      expr: COUNT(DISTINCT banquet_menu_package_id)
    - name: "Total Beverage Cost Percentage"
      expr: SUM(beverage_cost_percentage)
    - name: "Average Beverage Cost Percentage"
      expr: AVG(beverage_cost_percentage)
    - name: "Total Beverage Duration Hours"
      expr: SUM(beverage_duration_hours)
    - name: "Average Beverage Duration Hours"
      expr: AVG(beverage_duration_hours)
    - name: "Total Food Cost Percentage"
      expr: SUM(food_cost_percentage)
    - name: "Average Food Cost Percentage"
      expr: AVG(food_cost_percentage)
    - name: "Total Labor Hours Per Guest"
      expr: SUM(labor_hours_per_guest)
    - name: "Average Labor Hours Per Guest"
      expr: AVG(labor_hours_per_guest)
    - name: "Total Per Person Price"
      expr: SUM(per_person_price)
    - name: "Average Per Person Price"
      expr: AVG(per_person_price)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`discount`"
  dimensions:
    - name: "Applicable Menu Item Scope"
      expr: applicable_menu_item_scope
    - name: "Applicable Outlet Scope"
      expr: applicable_outlet_scope
    - name: "Applies To Service Charge"
      expr: applies_to_service_charge
    - name: "Applies To Tax"
      expr: applies_to_tax
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authorization Level Required"
      expr: authorization_level_required
    - name: "Discount Category"
      expr: discount_category
    - name: "Discount Code"
      expr: discount_code
    - name: "Combinable With Other Discounts"
      expr: combinable_with_other_discounts
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Description"
      expr: discount_description
    - name: "Discount Status"
      expr: discount_status
    - name: "Discount Type"
      expr: discount_type
    - name: "Internal Notes"
      expr: internal_notes
    - name: "Maximum Usage Per Check"
      expr: maximum_usage_per_check
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discount"
      expr: COUNT(DISTINCT discount_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Maximum Discount Amount Per Check"
      expr: SUM(maximum_discount_amount_per_check)
    - name: "Average Maximum Discount Amount Per Check"
      expr: AVG(maximum_discount_amount_per_check)
    - name: "Total Minimum Check Amount"
      expr: SUM(minimum_check_amount)
    - name: "Average Minimum Check Amount"
      expr: AVG(minimum_check_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Outlet business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`"
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

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_fnb_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Supply Agreement business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement`"
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
  comment: "Food Safety Inspection business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`"
  dimensions:
    - name: "Areas Inspected"
      expr: areas_inspected
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Corrective Action Completion Date"
      expr: corrective_action_completion_date
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Status"
      expr: corrective_action_status
    - name: "Corrective Actions Required"
      expr: corrective_actions_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Violations Count"
      expr: critical_violations_count
    - name: "Haccp Compliance Flag"
      expr: haccp_compliance_flag
    - name: "Inspection Checklist Used"
      expr: inspection_checklist_used
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Duration Minutes"
      expr: inspection_duration_minutes
    - name: "Inspection Grade"
      expr: inspection_grade
    - name: "Inspection Notes"
      expr: inspection_notes
    - name: "Inspection Number"
      expr: inspection_number
    - name: "Inspection Report Url"
      expr: inspection_report_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Food Safety Inspection"
      expr: COUNT(DISTINCT food_safety_inspection_id)
    - name: "Total Inspection Score"
      expr: SUM(inspection_score)
    - name: "Average Inspection Score"
      expr: AVG(inspection_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Item business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  dimensions:
    - name: "Alcohol Flag"
      expr: alcohol_flag
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Allergen Types"
      expr: allergen_types
    - name: "Brand Name"
      expr: brand_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Gluten Free Flag"
      expr: gluten_free_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Iso Food Safety Classification"
      expr: iso_food_safety_classification
    - name: "Item Category"
      expr: item_category
    - name: "Item Code"
      expr: item_code
    - name: "Item Name"
      expr: item_name
    - name: "Item Status"
      expr: item_status
    - name: "Item Subcategory"
      expr: item_subcategory
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Physical Count Date"
      expr: last_physical_count_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Item"
      expr: COUNT(DISTINCT inventory_item_id)
    - name: "Total Alcohol By Volume Percent"
      expr: SUM(alcohol_by_volume_percent)
    - name: "Average Alcohol By Volume Percent"
      expr: AVG(alcohol_by_volume_percent)
    - name: "Total Current On Hand Quantity"
      expr: SUM(current_on_hand_quantity)
    - name: "Average Current On Hand Quantity"
      expr: AVG(current_on_hand_quantity)
    - name: "Total Last Physical Count Quantity"
      expr: SUM(last_physical_count_quantity)
    - name: "Average Last Physical Count Quantity"
      expr: AVG(last_physical_count_quantity)
    - name: "Total Last Purchase Cost"
      expr: SUM(last_purchase_cost)
    - name: "Average Last Purchase Cost"
      expr: AVG(last_purchase_cost)
    - name: "Total Par Level"
      expr: SUM(par_level)
    - name: "Average Par Level"
      expr: AVG(par_level)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Required Storage Temperature Max"
      expr: SUM(required_storage_temperature_max)
    - name: "Average Required Storage Temperature Max"
      expr: AVG(required_storage_temperature_max)
    - name: "Total Required Storage Temperature Min"
      expr: SUM(required_storage_temperature_min)
    - name: "Average Required Storage Temperature Min"
      expr: AVG(required_storage_temperature_min)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Yield Percent"
      expr: SUM(yield_percent)
    - name: "Average Yield Percent"
      expr: AVG(yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu`"
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
    - name: "Menu Code"
      expr: menu_code
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
    - name: "Menu Description"
      expr: menu_description
    - name: "Dietary Options"
      expr: dietary_options
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
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
  comment: "Menu Item business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  dimensions:
    - name: "Allergen Flags"
      expr: allergen_flags
    - name: "Calorie Count"
      expr: calorie_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Food Safety Classification"
      expr: food_safety_classification
    - name: "Is Alcoholic"
      expr: is_alcoholic
    - name: "Is Available Banquet"
      expr: is_available_banquet
    - name: "Is Available Room Service"
      expr: is_available_room_service
    - name: "Is Gluten Free"
      expr: is_gluten_free
    - name: "Is Halal"
      expr: is_halal
    - name: "Is Kosher"
      expr: is_kosher
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Is Signature Item"
      expr: is_signature_item
    - name: "Is Vegan"
      expr: is_vegan
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Menu Item"
      expr: COUNT(DISTINCT menu_item_id)
    - name: "Total Alcohol Content Percent"
      expr: SUM(alcohol_content_percent)
    - name: "Average Alcohol Content Percent"
      expr: AVG(alcohol_content_percent)
    - name: "Total Cost Price"
      expr: SUM(cost_price)
    - name: "Average Cost Price"
      expr: AVG(cost_price)
    - name: "Total Gross Margin Percent"
      expr: SUM(gross_margin_percent)
    - name: "Average Gross Margin Percent"
      expr: AVG(gross_margin_percent)
    - name: "Total Standard Price"
      expr: SUM(standard_price)
    - name: "Average Standard Price"
      expr: AVG(standard_price)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical Count business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`physical_count`"
  dimensions:
    - name: "Adjustment Posted"
      expr: adjustment_posted
    - name: "Adjustment Posted Timestamp"
      expr: adjustment_posted_timestamp
    - name: "Adjustment Required"
      expr: adjustment_required
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Compliance Verified"
      expr: compliance_verified
    - name: "Count Date"
      expr: count_date
    - name: "Count End Timestamp"
      expr: count_end_timestamp
    - name: "Count Method"
      expr: count_method
    - name: "Count Number"
      expr: count_number
    - name: "Count Reason"
      expr: count_reason
    - name: "Count Start Timestamp"
      expr: count_start_timestamp
    - name: "Count Status"
      expr: count_status
    - name: "Count Type"
      expr: count_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Physical Count"
      expr: COUNT(DISTINCT physical_count_id)
    - name: "Total Total Variance Value"
      expr: SUM(total_variance_value)
    - name: "Average Total Variance Value"
      expr: AVG(total_variance_value)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Check business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  dimensions:
    - name: "Actual Delivery Time"
      expr: actual_delivery_time
    - name: "Business Date"
      expr: business_date
    - name: "Check Number"
      expr: check_number
    - name: "Check Status"
      expr: check_status
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Cover Count"
      expr: cover_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Duration Minutes"
      expr: delivery_duration_minutes
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Folio Reference Number"
      expr: folio_reference_number
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Manager Approval Required"
      expr: manager_approval_required
    - name: "Meal Period"
      expr: meal_period
    - name: "Opened Timestamp"
      expr: opened_timestamp
    - name: "Order Source"
      expr: order_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Check"
      expr: COUNT(DISTINCT pos_check_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Service Charge Amount"
      expr: SUM(service_charge_amount)
    - name: "Average Service Charge Amount"
      expr: AVG(service_charge_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tender Amount"
      expr: SUM(tender_amount)
    - name: "Average Tender Amount"
      expr: AVG(tender_amount)
    - name: "Total Tip Amount"
      expr: SUM(tip_amount)
    - name: "Average Tip Amount"
      expr: AVG(tip_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Check Line business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  dimensions:
    - name: "Course Number"
      expr: course_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Family Group Code"
      expr: family_group_code
    - name: "Is Complimentary"
      expr: is_complimentary
    - name: "Is Inclusive Tax"
      expr: is_inclusive_tax
    - name: "Is Open Item"
      expr: is_open_item
    - name: "Is Voided"
      expr: is_voided
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Major Group Code"
      expr: major_group_code
    - name: "Modifier Text"
      expr: modifier_text
    - name: "Preparation Time Minutes"
      expr: preparation_time_minutes
    - name: "Seat Number"
      expr: seat_number
    - name: "Sent To Kitchen Timestamp"
      expr: sent_to_kitchen_timestamp
    - name: "Served Timestamp"
      expr: served_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Check Line"
      expr: COUNT(DISTINCT pos_check_line_id)
    - name: "Total Cost Of Sales"
      expr: SUM(cost_of_sales)
    - name: "Average Cost Of Sales"
      expr: AVG(cost_of_sales)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Line Subtotal Amount"
      expr: SUM(line_subtotal_amount)
    - name: "Average Line Subtotal Amount"
      expr: AVG(line_subtotal_amount)
    - name: "Total Line Total Amount"
      expr: SUM(line_total_amount)
    - name: "Average Line Total Amount"
      expr: AVG(line_total_amount)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Service Charge Amount"
      expr: SUM(service_charge_amount)
    - name: "Average Service Charge Amount"
      expr: AVG(service_charge_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`recipe`"
  dimensions:
    - name: "Allergen Information"
      expr: allergen_information
    - name: "Ccp Details"
      expr: ccp_details
    - name: "Chef Notes"
      expr: chef_notes
    - name: "Recipe Code"
      expr: recipe_code
    - name: "Cooking Instructions"
      expr: cooking_instructions
    - name: "Cooking Time Minutes"
      expr: cooking_time_minutes
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Dietary Attributes"
      expr: dietary_attributes
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Haccp Hazard Analysis"
      expr: haccp_hazard_analysis
    - name: "Iso 22000 Ccp Flag"
      expr: iso_22000_ccp_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Recipe Name"
      expr: recipe_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recipe"
      expr: COUNT(DISTINCT recipe_id)
    - name: "Total Nutritional Carbohydrate Grams"
      expr: SUM(nutritional_carbohydrate_grams)
    - name: "Average Nutritional Carbohydrate Grams"
      expr: AVG(nutritional_carbohydrate_grams)
    - name: "Total Nutritional Fat Grams"
      expr: SUM(nutritional_fat_grams)
    - name: "Average Nutritional Fat Grams"
      expr: AVG(nutritional_fat_grams)
    - name: "Total Nutritional Protein Grams"
      expr: SUM(nutritional_protein_grams)
    - name: "Average Nutritional Protein Grams"
      expr: AVG(nutritional_protein_grams)
    - name: "Total Standard Beverage Cost Per Portion"
      expr: SUM(standard_beverage_cost_per_portion)
    - name: "Average Standard Beverage Cost Per Portion"
      expr: AVG(standard_beverage_cost_per_portion)
    - name: "Total Standard Food Cost Per Portion"
      expr: SUM(standard_food_cost_per_portion)
    - name: "Average Standard Food Cost Per Portion"
      expr: AVG(standard_food_cost_per_portion)
    - name: "Total Standard Portion Size"
      expr: SUM(standard_portion_size)
    - name: "Average Standard Portion Size"
      expr: AVG(standard_portion_size)
    - name: "Total Total Recipe Cost"
      expr: SUM(total_recipe_cost)
    - name: "Average Total Recipe Cost"
      expr: AVG(total_recipe_cost)
    - name: "Total Yield Quantity"
      expr: SUM(yield_quantity)
    - name: "Average Yield Quantity"
      expr: AVG(yield_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_recipe_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe Ingredient business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient`"
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

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_revenue_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Center business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`revenue_center`"
  dimensions:
    - name: "Allergen Menu Available Flag"
      expr: allergen_menu_available_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Revenue Center Code"
      expr: revenue_center_code
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
    - name: "Revenue Center Name"
      expr: revenue_center_name
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
  comment: "Room Service Order business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  dimensions:
    - name: "Actual Delivery Time"
      expr: actual_delivery_time
    - name: "Business Date"
      expr: business_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cover Count"
      expr: cover_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Duration Minutes"
      expr: delivery_duration_minutes
    - name: "Dietary Restrictions"
      expr: dietary_restrictions
    - name: "Dispatch Time"
      expr: dispatch_time
    - name: "Folio Reference"
      expr: folio_reference
    - name: "Guest Feedback Comment"
      expr: guest_feedback_comment
    - name: "Guest Satisfaction Rating"
      expr: guest_satisfaction_rating
    - name: "Is Vip Guest"
      expr: is_vip_guest
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Member Number"
      expr: loyalty_member_number
    - name: "On Time Delivery Flag"
      expr: on_time_delivery_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Service Order"
      expr: COUNT(DISTINCT room_service_order_id)
    - name: "Total Delivery Charge"
      expr: SUM(delivery_charge)
    - name: "Average Delivery Charge"
      expr: AVG(delivery_charge)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gratuity Amount"
      expr: SUM(gratuity_amount)
    - name: "Average Gratuity Amount"
      expr: AVG(gratuity_amount)
    - name: "Total Service Charge"
      expr: SUM(service_charge)
    - name: "Average Service Charge"
      expr: AVG(service_charge)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Transaction business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Corrective Action Notes"
      expr: corrective_action_notes
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Meal Period"
      expr: meal_period
    - name: "Notes"
      expr: notes
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Reversal Reason"
      expr: reversal_reason
    - name: "Source System Transaction Ref"
      expr: source_system_transaction_ref
    - name: "Transaction Date"
      expr: transaction_date
    - name: "Transaction Number"
      expr: transaction_number
    - name: "Transaction Status"
      expr: transaction_status
    - name: "Transaction Timestamp"
      expr: transaction_timestamp
    - name: "Transaction Type"
      expr: transaction_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Transaction"
      expr: COUNT(DISTINCT stock_transaction_id)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`storage_location`"
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
  comment: "Void Transaction business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`void_transaction`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Business Date"
      expr: business_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Covers Count"
      expr: covers_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Part"
      expr: day_part
    - name: "Investigation Notes"
      expr: investigation_notes
    - name: "Is Employee Meal"
      expr: is_employee_meal
    - name: "Is Manager Meal"
      expr: is_manager_meal
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Original Check Number"
      expr: original_check_number
    - name: "Original Transaction Timestamp"
      expr: original_transaction_timestamp
    - name: "Pos Terminal Code"
      expr: pos_terminal_code
    - name: "Requires Investigation"
      expr: requires_investigation
    - name: "Revenue Center Code"
      expr: revenue_center_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Void Transaction"
      expr: COUNT(DISTINCT void_transaction_id)
    - name: "Total Voided Amount"
      expr: SUM(voided_amount)
    - name: "Average Voided Amount"
      expr: AVG(voided_amount)
    - name: "Total Voided Quantity"
      expr: SUM(voided_quantity)
    - name: "Average Voided Quantity"
      expr: AVG(voided_quantity)
    - name: "Total Voided Service Charge Amount"
      expr: SUM(voided_service_charge_amount)
    - name: "Average Voided Service Charge Amount"
      expr: AVG(voided_service_charge_amount)
    - name: "Total Voided Tax Amount"
      expr: SUM(voided_tax_amount)
    - name: "Average Voided Tax Amount"
      expr: AVG(voided_tax_amount)
    - name: "Total Voided Total Amount"
      expr: SUM(voided_total_amount)
    - name: "Average Voided Total Amount"
      expr: AVG(voided_total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste Log business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`waste_log`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Food Category"
      expr: food_category
    - name: "Health Safety Incident Flag"
      expr: health_safety_incident_flag
    - name: "Iso 22000 Compliant Flag"
      expr: iso_22000_compliant_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Meal Period"
      expr: meal_period
    - name: "Notes"
      expr: notes
    - name: "Recording Staff Name"
      expr: recording_staff_name
    - name: "Storage Location"
      expr: storage_location
    - name: "Sustainability Impact Flag"
      expr: sustainability_impact_flag
    - name: "Unit Of Measure"
      expr: unit_of_measure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waste Log"
      expr: COUNT(DISTINCT waste_log_id)
    - name: "Total Quantity Wasted"
      expr: SUM(quantity_wasted)
    - name: "Average Quantity Wasted"
      expr: AVG(quantity_wasted)
    - name: "Total Total Waste Cost"
      expr: SUM(total_waste_cost)
    - name: "Average Total Waste Cost"
      expr: AVG(total_waste_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_wine_cellar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wine Cellar business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`wine_cellar`"
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