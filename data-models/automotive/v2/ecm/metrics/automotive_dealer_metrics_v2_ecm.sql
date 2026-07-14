-- Metric views for domain: dealer | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_dealership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core dealership entity metrics tracking dealer network size, geographic distribution, certification status, and facility capacity across the franchise network."
  source: "`vibe_automotive_v1`.`dealer`.`dealership`"
  dimensions:
    - name: "dealer_status"
      expr: dealer_status
      comment: "Current operational status of the dealership (active, inactive, suspended, terminated)"
    - name: "dealer_tier"
      expr: dealer_tier
      comment: "Dealership tier classification (Tier 1, Tier 2, Tier 3) based on volume and performance"
    - name: "franchise_type"
      expr: franchise_type
      comment: "Type of franchise agreement (exclusive, non-exclusive, multi-brand)"
    - name: "country"
      expr: country_code
      comment: "Country where the dealership operates"
    - name: "state_province"
      expr: state_province_code
      comment: "State or province location of the dealership"
    - name: "market_region"
      expr: market_region_code
      comment: "Market region classification for the dealership"
    - name: "sales_district"
      expr: sales_district_code
      comment: "Sales district assignment for the dealership"
    - name: "ev_certified_flag"
      expr: ev_certified
      comment: "Whether the dealership is certified to sell and service electric vehicles"
    - name: "adas_certified_flag"
      expr: adas_certified
      comment: "Whether the dealership is certified for ADAS (Advanced Driver Assistance Systems) service"
    - name: "warranty_authorized_flag"
      expr: warranty_authorized
      comment: "Whether the dealership is authorized to perform warranty repairs"
    - name: "pdi_certified_flag"
      expr: pdi_certified
      comment: "Whether the dealership is certified to perform Pre-Delivery Inspections"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the dealership was activated in the network"
    - name: "activation_quarter"
      expr: CONCAT('Q', QUARTER(activation_date), '-', YEAR(activation_date))
      comment: "Quarter and year the dealership was activated"
  measures:
    - name: "dealership_count"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Total number of unique dealerships in the network"
    - name: "active_dealership_count"
      expr: COUNT(DISTINCT CASE WHEN dealer_status = 'active' THEN dealership_id END)
      comment: "Number of dealerships with active operational status"
    - name: "total_service_bay_capacity"
      expr: SUM(CAST(service_bay_count AS DOUBLE))
      comment: "Total number of service bays across all dealerships for service capacity planning"
    - name: "total_lot_capacity"
      expr: SUM(CAST(lot_capacity AS DOUBLE))
      comment: "Total vehicle lot capacity across all dealerships for inventory planning"
    - name: "total_showroom_capacity"
      expr: SUM(CAST(showroom_display_capacity AS DOUBLE))
      comment: "Total showroom display capacity across all dealerships"
    - name: "avg_service_bays_per_dealer"
      expr: AVG(CAST(service_bay_count AS DOUBLE))
      comment: "Average number of service bays per dealership for benchmarking facility standards"
    - name: "avg_lot_capacity_per_dealer"
      expr: AVG(CAST(lot_capacity AS DOUBLE))
      comment: "Average vehicle lot capacity per dealership"
    - name: "ev_certified_dealership_count"
      expr: COUNT(DISTINCT CASE WHEN ev_certified = TRUE THEN dealership_id END)
      comment: "Number of dealerships certified for electric vehicle sales and service"
    - name: "adas_certified_dealership_count"
      expr: COUNT(DISTINCT CASE WHEN adas_certified = TRUE THEN dealership_id END)
      comment: "Number of dealerships certified for ADAS service and calibration"
    - name: "warranty_authorized_dealership_count"
      expr: COUNT(DISTINCT CASE WHEN warranty_authorized = TRUE THEN dealership_id END)
      comment: "Number of dealerships authorized to perform warranty repairs"
    - name: "ev_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ev_certified = TRUE THEN dealership_id END) / NULLIF(COUNT(DISTINCT dealership_id), 0), 2)
      comment: "Percentage of dealerships certified for EV sales and service, critical for electrification strategy"
    - name: "total_ev_charger_capacity"
      expr: SUM(CAST(ev_charger_count AS DOUBLE))
      comment: "Total number of EV chargers across all dealerships for electrification infrastructure tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail sales transaction metrics tracking revenue, profitability, financing penetration, and deal structure across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`retail_sale`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the retail deal (pending, completed, cancelled, unwound)"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing used (cash, finance, lease, balloon)"
    - name: "vehicle_condition"
      expr: vehicle_condition
      comment: "Condition of the vehicle sold (new, used, certified pre-owned, demo)"
    - name: "fleet_sale_flag"
      expr: fleet_sale
      comment: "Whether the sale was to a fleet customer vs retail individual"
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Whether Pre-Delivery Inspection was completed before delivery"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle sold"
    - name: "sale_year"
      expr: YEAR(sale_date)
      comment: "Year the sale was completed"
    - name: "sale_quarter"
      expr: CONCAT('Q', QUARTER(sale_date), '-', YEAR(sale_date))
      comment: "Quarter and year the sale was completed"
    - name: "sale_month"
      expr: DATE_TRUNC('MONTH', sale_date)
      comment: "Month the sale was completed for time-series analysis"
    - name: "delivery_year"
      expr: YEAR(delivery_date)
      comment: "Year the vehicle was delivered to the customer"
    - name: "lender_name"
      expr: lender_name
      comment: "Name of the financial institution providing financing"
  measures:
    - name: "retail_sale_count"
      expr: COUNT(DISTINCT retail_sale_id)
      comment: "Total number of retail sales transactions"
    - name: "completed_sale_count"
      expr: COUNT(DISTINCT CASE WHEN deal_status = 'completed' THEN retail_sale_id END)
      comment: "Number of completed retail sales transactions"
    - name: "total_sale_revenue"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total revenue from retail vehicle sales, primary top-line metric for dealer profitability"
    - name: "total_msrp_amount"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Total MSRP value of vehicles sold for pricing analysis"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts given off MSRP"
    - name: "total_front_end_gross"
      expr: SUM(CAST(front_end_gross AS DOUBLE))
      comment: "Total front-end gross profit (vehicle margin) across all sales, key profitability metric"
    - name: "total_back_end_gross"
      expr: SUM(CAST(back_end_gross AS DOUBLE))
      comment: "Total back-end gross profit (F&I products) across all sales, key profitability metric"
    - name: "total_fi_product_revenue"
      expr: SUM(CAST(fi_product_revenue AS DOUBLE))
      comment: "Total revenue from Finance & Insurance products, critical profit center for dealers"
    - name: "total_oem_incentive_amount"
      expr: SUM(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Total OEM incentives applied to sales"
    - name: "total_finance_amount"
      expr: SUM(CAST(finance_amount AS DOUBLE))
      comment: "Total amount financed across all sales"
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment AS DOUBLE))
      comment: "Total down payments collected"
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowances given"
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average retail sale price per transaction"
    - name: "avg_front_end_gross"
      expr: AVG(CAST(front_end_gross AS DOUBLE))
      comment: "Average front-end gross profit per sale, key per-unit profitability metric"
    - name: "avg_back_end_gross"
      expr: AVG(CAST(back_end_gross AS DOUBLE))
      comment: "Average back-end gross profit per sale, key F&I performance metric"
    - name: "avg_fi_product_revenue"
      expr: AVG(CAST(fi_product_revenue AS DOUBLE))
      comment: "Average F&I product revenue per sale"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per sale"
    - name: "finance_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN financing_type IN ('finance', 'lease') THEN retail_sale_id END) / NULLIF(COUNT(DISTINCT retail_sale_id), 0), 2)
      comment: "Percentage of sales with financing or lease, critical for F&I revenue optimization"
    - name: "fleet_sale_mix"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fleet_sale = TRUE THEN retail_sale_id END) / NULLIF(COUNT(DISTINCT retail_sale_id), 0), 2)
      comment: "Percentage of sales to fleet customers vs retail"
    - name: "avg_apr"
      expr: AVG(CAST(apr AS DOUBLE))
      comment: "Average Annual Percentage Rate on financed sales"
    - name: "discount_to_msrp_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp_amount AS DOUBLE)), 0), 2)
      comment: "Average discount as percentage of MSRP, key pricing strategy metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer inventory metrics tracking stock levels, aging, turn rates, and floor plan costs across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory unit (in-stock, in-transit, sold, reserved, hold)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (new, used, certified pre-owned, demo, loaner)"
    - name: "certified_pre_owned_flag"
      expr: certified_pre_owned
      comment: "Whether the vehicle is certified pre-owned"
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Whether Pre-Delivery Inspection has been completed"
    - name: "recall_hold_flag"
      expr: recall_hold
      comment: "Whether the vehicle is on hold due to an open recall"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the vehicle (sedan, SUV, truck, coupe, etc.)"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (FWD, RWD, AWD, 4WD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (automatic, manual, CVT, dual-clutch)"
    - name: "exterior_color"
      expr: exterior_color_name
      comment: "Exterior color of the vehicle"
    - name: "interior_color"
      expr: interior_color_name
      comment: "Interior color of the vehicle"
    - name: "source_type"
      expr: source_type
      comment: "Source of the inventory (factory order, allocation, trade-in, auction, transfer)"
    - name: "transport_status"
      expr: transport_status
      comment: "Current transport status (at-plant, in-transit, at-port, at-dealer)"
    - name: "location_code"
      expr: location_code
      comment: "Physical location code within the dealership lot"
    - name: "floor_plan_lender"
      expr: floor_plan_lender
      comment: "Financial institution providing floor plan financing"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year the vehicle was received at the dealership"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the vehicle was received at the dealership"
  measures:
    - name: "inventory_unit_count"
      expr: COUNT(DISTINCT dealer_inventory_id)
      comment: "Total number of inventory units at dealers"
    - name: "in_stock_unit_count"
      expr: COUNT(DISTINCT CASE WHEN inventory_status = 'in-stock' THEN dealer_inventory_id END)
      comment: "Number of units currently in stock and available"
    - name: "sold_unit_count"
      expr: COUNT(DISTINCT CASE WHEN inventory_status = 'sold' THEN dealer_inventory_id END)
      comment: "Number of units with sold status"
    - name: "recall_hold_unit_count"
      expr: COUNT(DISTINCT CASE WHEN recall_hold = TRUE THEN dealer_inventory_id END)
      comment: "Number of units on hold due to open recalls, critical for compliance and sales velocity"
    - name: "total_inventory_value_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of dealer inventory, key working capital metric"
    - name: "total_inventory_value_invoice"
      expr: SUM(CAST(invoice_price AS DOUBLE))
      comment: "Total invoice value of dealer inventory, key floor plan liability metric"
    - name: "total_inventory_value_asking"
      expr: SUM(CAST(asking_price AS DOUBLE))
      comment: "Total asking price value of dealer inventory"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of dealer inventory"
    - name: "avg_days_on_lot"
      expr: AVG(CAST(days_on_lot AS DOUBLE))
      comment: "Average number of days inventory has been on the lot, key turn rate and aging metric"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per inventory unit"
    - name: "avg_invoice_price"
      expr: AVG(CAST(invoice_price AS DOUBLE))
      comment: "Average invoice price per inventory unit"
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price per inventory unit"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pdi_completed = TRUE THEN dealer_inventory_id END) / NULLIF(COUNT(DISTINCT dealer_inventory_id), 0), 2)
      comment: "Percentage of inventory units with completed PDI, critical for sales readiness"
    - name: "recall_hold_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN recall_hold = TRUE THEN dealer_inventory_id END) / NULLIF(COUNT(DISTINCT dealer_inventory_id), 0), 2)
      comment: "Percentage of inventory on recall hold, critical for sales velocity and compliance"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy across inventory"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy across inventory"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer performance scorecard metrics tracking sales attainment, customer satisfaction, operational efficiency, and franchise compliance across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`performance_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard (draft, published, final, archived)"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (platinum, gold, silver, bronze, needs improvement)"
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the scorecard period"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the scorecard period"
    - name: "franchise_compliance_status"
      expr: franchise_compliance_status
      comment: "Franchise agreement compliance status (compliant, non-compliant, conditional)"
    - name: "incentive_eligibility_flag"
      expr: incentive_eligibility_flag
      comment: "Whether the dealer is eligible for incentive programs based on performance"
    - name: "published_year"
      expr: YEAR(published_date)
      comment: "Year the scorecard was published"
    - name: "published_quarter"
      expr: CONCAT('Q', QUARTER(published_date), '-', YEAR(published_date))
      comment: "Quarter and year the scorecard was published"
  measures:
    - name: "scorecard_count"
      expr: COUNT(DISTINCT performance_scorecard_id)
      comment: "Total number of performance scorecards"
    - name: "published_scorecard_count"
      expr: COUNT(DISTINCT CASE WHEN scorecard_status = 'published' THEN performance_scorecard_id END)
      comment: "Number of published performance scorecards"
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across dealers, primary dealer performance metric"
    - name: "avg_composite_score_benchmark"
      expr: AVG(CAST(composite_score_benchmark AS DOUBLE))
      comment: "Average composite score benchmark for comparison"
    - name: "avg_csi_score"
      expr: AVG(CAST(csi_score AS DOUBLE))
      comment: "Average Customer Satisfaction Index score, critical customer experience metric"
    - name: "avg_csi_benchmark"
      expr: AVG(CAST(csi_benchmark AS DOUBLE))
      comment: "Average CSI benchmark for comparison"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score, critical customer loyalty metric"
    - name: "avg_nps_benchmark"
      expr: AVG(CAST(nps_benchmark AS DOUBLE))
      comment: "Average NPS benchmark for comparison"
    - name: "avg_new_vehicle_sales_attainment"
      expr: AVG(CAST(new_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average new vehicle sales attainment percentage vs objective, key sales performance metric"
    - name: "avg_used_vehicle_sales_attainment"
      expr: AVG(CAST(used_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average used vehicle sales attainment percentage vs objective"
    - name: "total_new_vehicle_sales_actual"
      expr: SUM(CAST(new_vehicle_sales_actual AS DOUBLE))
      comment: "Total actual new vehicle sales across all dealers"
    - name: "total_new_vehicle_sales_objective"
      expr: SUM(CAST(new_vehicle_sales_objective AS DOUBLE))
      comment: "Total new vehicle sales objective across all dealers"
    - name: "total_used_vehicle_sales_actual"
      expr: SUM(CAST(used_vehicle_sales_actual AS DOUBLE))
      comment: "Total actual used vehicle sales across all dealers"
    - name: "total_used_vehicle_sales_objective"
      expr: SUM(CAST(used_vehicle_sales_objective AS DOUBLE))
      comment: "Total used vehicle sales objective across all dealers"
    - name: "total_parts_revenue_actual"
      expr: SUM(CAST(parts_revenue_actual AS DOUBLE))
      comment: "Total actual parts revenue across all dealers"
    - name: "total_parts_revenue_objective"
      expr: SUM(CAST(parts_revenue_objective AS DOUBLE))
      comment: "Total parts revenue objective across all dealers"
    - name: "total_service_revenue_actual"
      expr: SUM(CAST(service_revenue_actual AS DOUBLE))
      comment: "Total actual service revenue across all dealers"
    - name: "total_service_revenue_objective"
      expr: SUM(CAST(service_revenue_objective AS DOUBLE))
      comment: "Total service revenue objective across all dealers"
    - name: "avg_market_share"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across dealers, key competitive position metric"
    - name: "avg_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate across dealers, key working capital efficiency metric"
    - name: "avg_service_absorption_rate"
      expr: AVG(CAST(service_absorption_rate_pct AS DOUBLE))
      comment: "Average service absorption rate, key fixed operations profitability metric"
    - name: "avg_parts_fill_rate"
      expr: AVG(CAST(parts_fill_rate_pct AS DOUBLE))
      comment: "Average parts fill rate, key parts operations efficiency metric"
    - name: "avg_warranty_claim_approval_rate"
      expr: AVG(CAST(warranty_claim_approval_rate_pct AS DOUBLE))
      comment: "Average warranty claim approval rate, key warranty administration quality metric"
    - name: "avg_training_compliance"
      expr: AVG(CAST(training_compliance_pct AS DOUBLE))
      comment: "Average training compliance percentage, key franchise compliance metric"
    - name: "avg_facility_standards_score"
      expr: AVG(CAST(facility_standards_score AS DOUBLE))
      comment: "Average facility standards score, key franchise compliance metric"
    - name: "incentive_eligible_dealer_count"
      expr: COUNT(DISTINCT CASE WHEN incentive_eligibility_flag = TRUE THEN performance_scorecard_id END)
      comment: "Number of dealers eligible for incentive programs based on performance"
    - name: "incentive_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN incentive_eligibility_flag = TRUE THEN performance_scorecard_id END) / NULLIF(COUNT(DISTINCT performance_scorecard_id), 0), 2)
      comment: "Percentage of dealers eligible for incentive programs, key network quality metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_csi_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Satisfaction Index survey metrics tracking customer experience, satisfaction scores, NPS, and complaint resolution across sales and service interactions."
  source: "`vibe_automotive_v1`.`dealer`.`csi_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the survey (completed, partial, not-started, expired)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (sales, service, delivery, post-purchase, follow-up)"
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the survey was completed (email, SMS, phone, web, in-person)"
    - name: "nps_category"
      expr: nps_category
      comment: "Net Promoter Score category (promoter, passive, detractor)"
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Overall sentiment category (positive, neutral, negative)"
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Whether the survey included a customer complaint"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint if present"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required based on survey responses"
    - name: "follow_up_completed_flag"
      expr: follow_up_completed_flag
      comment: "Whether required follow-up has been completed"
    - name: "oem_program_compliant_flag"
      expr: oem_program_compliant_flag
      comment: "Whether the survey meets OEM program compliance requirements"
    - name: "dealer_performance_impact_flag"
      expr: dealer_performance_impact_flag
      comment: "Whether the survey impacts dealer performance metrics"
    - name: "market_code"
      expr: market_code
      comment: "Market code where the survey was conducted"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region code for the survey"
    - name: "survey_program_code"
      expr: survey_program_code
      comment: "Survey program code"
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year the survey was conducted"
    - name: "survey_quarter"
      expr: CONCAT('Q', QUARTER(survey_date), '-', YEAR(survey_date))
      comment: "Quarter and year the survey was conducted"
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month the survey was conducted"
  measures:
    - name: "survey_count"
      expr: COUNT(DISTINCT csi_survey_id)
      comment: "Total number of CSI surveys"
    - name: "completed_survey_count"
      expr: COUNT(DISTINCT CASE WHEN survey_status = 'completed' THEN csi_survey_id END)
      comment: "Number of completed surveys"
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall satisfaction score, primary customer satisfaction metric"
    - name: "avg_sales_consultant_score"
      expr: AVG(CAST(sales_consultant_score AS DOUBLE))
      comment: "Average sales consultant score, key sales experience metric"
    - name: "avg_service_advisor_score"
      expr: AVG(CAST(service_advisor_score AS DOUBLE))
      comment: "Average service advisor score, key service experience metric"
    - name: "avg_service_quality_score"
      expr: AVG(CAST(service_quality_score AS DOUBLE))
      comment: "Average service quality score"
    - name: "avg_service_timeliness_score"
      expr: AVG(CAST(service_timeliness_score AS DOUBLE))
      comment: "Average service timeliness score"
    - name: "avg_delivery_process_score"
      expr: AVG(CAST(delivery_process_score AS DOUBLE))
      comment: "Average delivery process score"
    - name: "avg_pricing_transparency_score"
      expr: AVG(CAST(pricing_transparency_score AS DOUBLE))
      comment: "Average pricing transparency score"
    - name: "avg_problem_resolution_score"
      expr: AVG(CAST(problem_resolution_score AS DOUBLE))
      comment: "Average problem resolution score"
    - name: "avg_facility_cleanliness_score"
      expr: AVG(CAST(facility_cleanliness_score AS DOUBLE))
      comment: "Average facility cleanliness score"
    - name: "avg_staff_courtesy_score"
      expr: AVG(CAST(staff_courtesy_score AS DOUBLE))
      comment: "Average staff courtesy score"
    - name: "avg_vehicle_condition_score"
      expr: AVG(CAST(vehicle_condition_score AS DOUBLE))
      comment: "Average vehicle condition score at delivery"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from text analysis"
    - name: "avg_survey_completion_percentage"
      expr: AVG(CAST(survey_completion_percentage AS DOUBLE))
      comment: "Average survey completion percentage"
    - name: "complaint_count"
      expr: COUNT(DISTINCT CASE WHEN complaint_flag = TRUE THEN csi_survey_id END)
      comment: "Number of surveys with customer complaints"
    - name: "complaint_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN complaint_flag = TRUE THEN csi_survey_id END) / NULLIF(COUNT(DISTINCT csi_survey_id), 0), 2)
      comment: "Percentage of surveys with complaints, key quality and satisfaction metric"
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'promoter' THEN csi_survey_id END)
      comment: "Number of promoters (NPS 9-10)"
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'detractor' THEN csi_survey_id END)
      comment: "Number of detractors (NPS 0-6)"
    - name: "follow_up_required_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN csi_survey_id END)
      comment: "Number of surveys requiring follow-up action"
    - name: "follow_up_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN csi_survey_id END) / NULLIF(COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN csi_survey_id END), 0), 2)
      comment: "Percentage of required follow-ups completed, key service recovery metric"
    - name: "oem_program_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oem_program_compliant_flag = TRUE THEN csi_survey_id END) / NULLIF(COUNT(DISTINCT csi_survey_id), 0), 2)
      comment: "Percentage of surveys meeting OEM program compliance, key franchise compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_incentive_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer incentive claim metrics tracking claim submission, approval, payment, and dispute resolution for dealer incentive programs."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_incentive_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the incentive claim (draft, submitted, under-review, approved, rejected, paid, disputed)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of incentive claim (volume, CSI, facility, training, allocation, special)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the claim is under dispute"
    - name: "accrual_posted_flag"
      expr: accrual_posted
      comment: "Whether the accrual has been posted to financials"
    - name: "evidence_verified_flag"
      expr: evidence_verified
      comment: "Whether supporting evidence has been verified"
    - name: "country_code"
      expr: country_code
      comment: "Country where the claim was submitted"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the claim"
    - name: "program_year"
      expr: program_year
      comment: "Program year of the incentive claim"
    - name: "program_quarter"
      expr: program_quarter
      comment: "Program quarter of the incentive claim"
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the claim"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type associated with the claim"
    - name: "vehicle_line_code"
      expr: vehicle_line_code
      comment: "Vehicle line code associated with the claim"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the claim was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter and year the claim was submitted"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the claim was paid"
  measures:
    - name: "claim_count"
      expr: COUNT(DISTINCT dealer_incentive_claim_id)
      comment: "Total number of dealer incentive claims"
    - name: "submitted_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status IN ('submitted', 'under-review', 'approved', 'paid') THEN dealer_incentive_claim_id END)
      comment: "Number of claims that have been submitted"
    - name: "approved_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status IN ('approved', 'paid') THEN dealer_incentive_claim_id END)
      comment: "Number of approved claims"
    - name: "paid_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'paid' THEN dealer_incentive_claim_id END)
      comment: "Number of paid claims"
    - name: "rejected_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'rejected' THEN dealer_incentive_claim_id END)
      comment: "Number of rejected claims"
    - name: "disputed_claim_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN dealer_incentive_claim_id END)
      comment: "Number of claims under dispute"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed by dealers"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for payment"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to dealers, key incentive program cost metric"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average amount claimed per claim"
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average amount approved per claim"
    - name: "avg_paid_amount"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average amount paid per claim"
    - name: "claim_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN claim_status IN ('approved', 'paid') THEN dealer_incentive_claim_id END) / NULLIF(COUNT(DISTINCT CASE WHEN claim_status IN ('submitted', 'under-review', 'approved', 'rejected', 'paid') THEN dealer_incentive_claim_id END), 0), 2)
      comment: "Percentage of submitted claims that are approved, key program administration quality metric"
    - name: "claim_dispute_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN dealer_incentive_claim_id END) / NULLIF(COUNT(DISTINCT dealer_incentive_claim_id), 0), 2)
      comment: "Percentage of claims under dispute, key program administration quality metric"
    - name: "evidence_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN evidence_verified = TRUE THEN dealer_incentive_claim_id END) / NULLIF(COUNT(DISTINCT dealer_incentive_claim_id), 0), 2)
      comment: "Percentage of claims with verified evidence"
    - name: "total_claimed_units"
      expr: SUM(CAST(claimed_units AS DOUBLE))
      comment: "Total units claimed across all claims"
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved across all claims"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_vehicle_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle allocation metrics tracking allocation decisions, acceptance rates, delivery performance, and allocation rule effectiveness across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`vehicle_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (pending, accepted, rejected, delivered, cancelled)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (stock, customer-order, demo, loaner, special)"
    - name: "is_customer_order_flag"
      expr: is_customer_order
      comment: "Whether the allocation is for a specific customer order vs dealer stock"
    - name: "pdi_required_flag"
      expr: pdi_required
      comment: "Whether Pre-Delivery Inspection is required"
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Whether Pre-Delivery Inspection has been completed"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the allocation (high, medium, low)"
    - name: "allocation_rule_code"
      expr: allocation_rule_code
      comment: "Code of the allocation rule applied"
    - name: "production_plant_code"
      expr: production_plant_code
      comment: "Production plant code where the vehicle was built"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the allocation"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory code for the allocation"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (truck, rail, vessel, drive-away)"
    - name: "port_of_entry_code"
      expr: port_of_entry_code
      comment: "Port of entry code for imported vehicles"
    - name: "hold_code"
      expr: hold_code
      comment: "Hold code if allocation is on hold"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code if allocation was rejected by dealer"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year the allocation was made"
    - name: "allocation_quarter"
      expr: CONCAT('Q', QUARTER(allocation_date), '-', YEAR(allocation_date))
      comment: "Quarter and year the allocation was made"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the allocation was made"
  measures:
    - name: "allocation_count"
      expr: COUNT(DISTINCT vehicle_allocation_id)
      comment: "Total number of vehicle allocations"
    - name: "accepted_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN allocation_status = 'accepted' THEN vehicle_allocation_id END)
      comment: "Number of allocations accepted by dealers"
    - name: "rejected_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN allocation_status = 'rejected' THEN vehicle_allocation_id END)
      comment: "Number of allocations rejected by dealers"
    - name: "delivered_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN allocation_status = 'delivered' THEN vehicle_allocation_id END)
      comment: "Number of allocations delivered to dealers"
    - name: "customer_order_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN is_customer_order = TRUE THEN vehicle_allocation_id END)
      comment: "Number of allocations for specific customer orders"
    - name: "total_allocation_value_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of allocated vehicles"
    - name: "total_allocation_value_invoice"
      expr: SUM(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Total dealer invoice value of allocated vehicles"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount associated with allocations"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per allocated vehicle"
    - name: "avg_dealer_invoice_price"
      expr: AVG(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Average dealer invoice price per allocated vehicle"
    - name: "allocation_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN allocation_status = 'accepted' THEN vehicle_allocation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN allocation_status IN ('accepted', 'rejected') THEN vehicle_allocation_id END), 0), 2)
      comment: "Percentage of allocations accepted by dealers, key allocation effectiveness metric"
    - name: "allocation_rejection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN allocation_status = 'rejected' THEN vehicle_allocation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN allocation_status IN ('accepted', 'rejected') THEN vehicle_allocation_id END), 0), 2)
      comment: "Percentage of allocations rejected by dealers, key allocation quality metric"
    - name: "customer_order_mix"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_customer_order = TRUE THEN vehicle_allocation_id END) / NULLIF(COUNT(DISTINCT vehicle_allocation_id), 0), 2)
      comment: "Percentage of allocations for customer orders vs dealer stock"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pdi_completed = TRUE THEN vehicle_allocation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN pdi_required = TRUE THEN vehicle_allocation_id END), 0), 2)
      comment: "Percentage of required PDIs completed"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity of vehicles accepted by dealers"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_floor_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Floor plan financing metrics tracking dealer inventory financing costs, interest expense, aging, and floor plan utilization across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`floor_plan`"
  dimensions:
    - name: "floor_plan_status"
      expr: floor_plan_status
      comment: "Current status of the floor plan (active, paid-off, defaulted, aged)"
    - name: "financing_institution_name"
      expr: financing_institution_name
      comment: "Name of the financial institution providing floor plan financing"
    - name: "financing_institution_code"
      expr: financing_institution_code
      comment: "Code of the financial institution"
    - name: "aged_inventory_flag"
      expr: aged_inventory_flag
      comment: "Whether the inventory is aged beyond threshold"
    - name: "default_flag"
      expr: default_flag
      comment: "Whether the floor plan is in default"
    - name: "curtailment_paid_flag"
      expr: curtailment_paid_flag
      comment: "Whether curtailment payment has been made"
    - name: "oem_assistance_program_code"
      expr: oem_assistance_program_code
      comment: "OEM assistance program code if applicable"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the floor plan (current, overdue, in-progress)"
    - name: "financing_start_year"
      expr: YEAR(financing_start_date)
      comment: "Year the floor plan financing started"
    - name: "financing_start_quarter"
      expr: CONCAT('Q', QUARTER(financing_start_date), '-', YEAR(financing_start_date))
      comment: "Quarter and year the floor plan financing started"
    - name: "payoff_year"
      expr: YEAR(payoff_date)
      comment: "Year the floor plan was paid off"
  measures:
    - name: "floor_plan_count"
      expr: COUNT(DISTINCT floor_plan_id)
      comment: "Total number of floor plan financing records"
    - name: "active_floor_plan_count"
      expr: COUNT(DISTINCT CASE WHEN floor_plan_status = 'active' THEN floor_plan_id END)
      comment: "Number of active floor plan financing records"
    - name: "aged_inventory_count"
      expr: COUNT(DISTINCT CASE WHEN aged_inventory_flag = TRUE THEN floor_plan_id END)
      comment: "Number of floor plan units with aged inventory"
    - name: "default_count"
      expr: COUNT(DISTINCT CASE WHEN default_flag = TRUE THEN floor_plan_id END)
      comment: "Number of floor plan units in default"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding floor plan balance across all dealers, key working capital liability metric"
    - name: "total_dealer_invoice_amount"
      expr: SUM(CAST(dealer_invoice_amount AS DOUBLE))
      comment: "Total dealer invoice amount financed"
    - name: "total_msrp_amount"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Total MSRP amount of floor plan inventory"
    - name: "total_interest_paid"
      expr: SUM(CAST(total_interest_paid AS DOUBLE))
      comment: "Total interest paid on floor plan financing, key dealer cost metric"
    - name: "total_daily_interest_amount"
      expr: SUM(CAST(daily_interest_amount AS DOUBLE))
      comment: "Total daily interest accruing on floor plan"
    - name: "total_curtailment_amount"
      expr: SUM(CAST(curtailment_amount AS DOUBLE))
      comment: "Total curtailment amount due"
    - name: "total_oem_assistance_amount"
      expr: SUM(CAST(oem_assistance_amount AS DOUBLE))
      comment: "Total OEM assistance amount for floor plan support"
    - name: "total_per_unit_floor_plan_cost"
      expr: SUM(CAST(per_unit_floor_plan_cost AS DOUBLE))
      comment: "Total per-unit floor plan cost"
    - name: "total_credit_line_amount"
      expr: SUM(CAST(credit_line_amount AS DOUBLE))
      comment: "Total credit line amount available"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Average outstanding floor plan balance per unit"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_pct AS DOUBLE))
      comment: "Average interest rate on floor plan financing"
    - name: "avg_days_in_inventory"
      expr: AVG(CAST(days_in_inventory AS DOUBLE))
      comment: "Average number of days inventory has been on floor plan, key turn rate metric"
    - name: "aged_inventory_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN aged_inventory_flag = TRUE THEN floor_plan_id END) / NULLIF(COUNT(DISTINCT floor_plan_id), 0), 2)
      comment: "Percentage of floor plan inventory that is aged, key inventory health metric"
    - name: "default_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN default_flag = TRUE THEN floor_plan_id END) / NULLIF(COUNT(DISTINCT floor_plan_id), 0), 2)
      comment: "Percentage of floor plan units in default, key credit risk metric"
    - name: "floor_plan_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_line_amount AS DOUBLE)), 0), 2)
      comment: "Floor plan utilization as percentage of credit line, key working capital efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_service_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service capacity metrics tracking service bay utilization, technician headcount, labor hours, and service capacity planning across the dealer network."
  source: "`vibe_automotive_v1`.`dealer`.`service_capacity`"
  dimensions:
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current status of the capacity configuration (active, inactive, planned, under-review)"
    - name: "diagnostic_equipment_level"
      expr: diagnostic_equipment_level
      comment: "Level of diagnostic equipment (basic, advanced, premium)"
    - name: "has_mobile_service_capability_flag"
      expr: has_mobile_service_capability
      comment: "Whether the dealership has mobile service capability"
    - name: "dms_system_code"
      expr: dms_system_code
      comment: "DMS system code used by the dealership"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the capacity configuration became effective"
  measures:
    - name: "service_capacity_record_count"
      expr: COUNT(DISTINCT service_capacity_id)
      comment: "Total number of service capacity records"
    - name: "total_service_bays"
      expr: SUM(CAST(total_service_bays AS DOUBLE))
      comment: "Total number of service bays across all dealers"
    - name: "total_general_service_bays"
      expr: SUM(CAST(general_service_bays AS DOUBLE))
      comment: "Total number of general service bays"
    - name: "total_express_service_bays"
      expr: SUM(CAST(express_service_bays AS DOUBLE))
      comment: "Total number of express service bays"
    - name: "total_ev_service_bays"
      expr: SUM(CAST(ev_service_bays AS DOUBLE))
      comment: "Total number of EV-certified service bays"
    - name: "total_adas_service_bays"
      expr: SUM(CAST(adas_service_bays AS DOUBLE))
      comment: "Total number of ADAS-certified service bays"
    - name: "total_body_shop_bays"
      expr: SUM(CAST(body_shop_bays AS DOUBLE))
      comment: "Total number of body shop bays"
    - name: "total_technician_headcount"
      expr: SUM(CAST(total_technician_headcount AS DOUBLE))
      comment: "Total number of technicians across all dealers"
    - name: "total_a_tech_headcount"
      expr: SUM(CAST(a_tech_headcount AS DOUBLE))
      comment: "Total number of A-level technicians"
    - name: "total_b_tech_headcount"
      expr: SUM(CAST(b_tech_headcount AS DOUBLE))
      comment: "Total number of B-level technicians"
    - name: "total_c_tech_headcount"
      expr: SUM(CAST(c_tech_headcount AS DOUBLE))
      comment: "Total number of C-level technicians"
    - name: "total_ev_certified_tech_count"
      expr: SUM(CAST(ev_certified_tech_count AS DOUBLE))
      comment: "Total number of EV-certified technicians"
    - name: "total_adas_certified_tech_count"
      expr: SUM(CAST(adas_certified_tech_count AS DOUBLE))
      comment: "Total number of ADAS-certified technicians"
    - name: "total_mobile_service_technician_count"
      expr: SUM(CAST(mobile_service_technician_count AS DOUBLE))
      comment: "Total number of mobile service technicians"
    - name: "total_body_shop_tech_count"
      expr: SUM(CAST(body_shop_tech_count AS DOUBLE))
      comment: "Total number of body shop technicians"
    - name: "total_available_labor_hours_per_day"
      expr: SUM(CAST(available_labor_hours_per_day AS DOUBLE))
      comment: "Total available labor hours per day across all dealers, key service capacity metric"
    - name: "total_loaner_fleet_size"
      expr: SUM(CAST(loaner_fleet_size AS DOUBLE))
      comment: "Total loaner fleet size across all dealers"
    - name: "avg_capacity_utilization"
      expr: AVG(CAST(current_capacity_utilization_pct AS DOUBLE))
      comment: "Average current capacity utilization percentage, key service efficiency metric"
    - name: "avg_target_capacity_utilization"
      expr: AVG(CAST(target_capacity_utilization_pct AS DOUBLE))
      comment: "Average target capacity utilization percentage"
    - name: "avg_loaner_fleet_utilization"
      expr: AVG(CAST(loaner_fleet_utilization_pct AS DOUBLE))
      comment: "Average loaner fleet utilization percentage"
    - name: "avg_ro_cycle_time_hours"
      expr: AVG(CAST(avg_ro_cycle_time_hours AS DOUBLE))
      comment: "Average repair order cycle time in hours, key service efficiency metric"
    - name: "avg_hours_per_shift"
      expr: AVG(CAST(hours_per_shift AS DOUBLE))
      comment: "Average hours per shift"
    - name: "mobile_service_capability_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_mobile_service_capability = TRUE THEN service_capacity_id END) / NULLIF(COUNT(DISTINCT service_capacity_id), 0), 2)
      comment: "Percentage of dealers with mobile service capability"
$$;