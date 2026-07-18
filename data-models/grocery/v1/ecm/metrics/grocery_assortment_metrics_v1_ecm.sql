-- Metric views for domain: assortment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_slotting_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Slotting fee financial and allocation KPIs"
  source: "`grocery_ecm`.`assortment`.`slotting_fee`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the slotting fee"
    - name: "category_id"
      expr: category_id
      comment: "Category linked to the slotting fee"
    - name: "store_cluster_id"
      expr: store_cluster_id
      comment: "Store cluster where fee applies"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Fiscal year of the slotting fee"
    - name: "is_promotional"
      expr: is_promotional
      comment: "Flag indicating if fee is promotional"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total slotting fee amount collected"
    - name: "average_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average slotting fee per agreement"
    - name: "total_linear_feet_allocated"
      expr: SUM(CAST(linear_feet_allocated AS DOUBLE))
      comment: "Total linear feet allocated to slotting fee agreements"
    - name: "count_fee_records"
      expr: COUNT(1)
      comment: "Number of slotting fee records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_planogram_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram compliance effectiveness KPIs"
  source: "`grocery_ecm`.`assortment`.`planogram_compliance`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where compliance was recorded"
    - name: "category_id"
      expr: category_id
      comment: "Category of the fixture"
    - name: "fixture_id"
      expr: fixture_id
      comment: "Fixture identifier"
    - name: "planogram_id"
      expr: planogram_id
      comment: "Planogram identifier"
    - name: "compliance_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the compliance event"
  measures:
    - name: "average_compliance_score"
      expr: AVG(CAST(compliance_score_percentage AS DOUBLE))
      comment: "Average compliance score percentage"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total labor hours spent on compliance activities"
    - name: "count_compliance_records"
      expr: COUNT(1)
      comment: "Number of planogram compliance records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic assortment planning KPIs"
  source: "`grocery_ecm`.`assortment`.`assortment_plan`"
  dimensions:
    - name: "category_id"
      expr: category_id
      comment: "Category associated with the plan"
    - name: "store_cluster_id"
      expr: store_cluster_id
      comment: "Store cluster for the plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the assortment plan"
  measures:
    - name: "total_cost_plan_amount"
      expr: SUM(CAST(cost_plan_amount AS DOUBLE))
      comment: "Total planned cost for assortment"
    - name: "total_gmroi_target"
      expr: SUM(CAST(gmroi_target AS DOUBLE))
      comment: "Sum of GMROI targets across plans"
    - name: "average_margin_plan_percent"
      expr: AVG(CAST(margin_plan_percent AS DOUBLE))
      comment: "Average margin plan percent"
    - name: "count_assortment_plans"
      expr: COUNT(1)
      comment: "Number of assortment plans"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_category_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category level financial and operational performance KPIs"
  source: "`grocery_ecm`.`assortment`.`category`"
  dimensions:
    - name: "category_id"
      expr: category_id
      comment: "Primary key of the category"
    - name: "parent_category_id"
      expr: parent_category_id
      comment: "Parent category identifier"
    - name: "category_type"
      expr: category_type
      comment: "Type classification of the category"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the category"
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates if the category is seasonal"
  measures:
    - name: "average_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target for the category"
    - name: "average_shrink_rate_percent"
      expr: AVG(CAST(shrink_rate_percent AS DOUBLE))
      comment: "Average shrink rate percent"
    - name: "count_categories"
      expr: COUNT(1)
      comment: "Number of category records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation efficiency and profitability KPIs"
  source: "`grocery_ecm`.`assortment`.`space_allocation`"
  dimensions:
    - name: "store_cluster_id"
      expr: store_cluster_id
      comment: "Store cluster for the allocation"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "category_id"
      expr: category_id
      comment: "Category of the allocated space"
    - name: "season_name"
      expr: season_name
      comment: "Season name associated with the allocation"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the allocation"
  measures:
    - name: "total_linear_feet_allocated"
      expr: SUM(CAST(linear_feet_allocated AS DOUBLE))
      comment: "Total linear feet allocated across space allocations"
    - name: "total_square_footage_allocated"
      expr: SUM(CAST(square_footage_allocated AS DOUBLE))
      comment: "Total square footage allocated"
    - name: "average_target_gmroi_per_linear_foot"
      expr: AVG(CAST(target_gmroi_per_linear_foot AS DOUBLE))
      comment: "Average target GMROI per linear foot"
    - name: "count_space_allocations"
      expr: COUNT(1)
      comment: "Number of space allocation records"
$$;
