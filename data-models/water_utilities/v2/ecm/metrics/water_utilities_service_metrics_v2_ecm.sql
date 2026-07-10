-- Metric views for domain: service | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for service orders — tracks order volume, SLA compliance, billable revenue, and field execution efficiency. Used by Operations VPs and Service Directors to steer field workforce performance and customer satisfaction."
  source: "`vibe_water_utilities_v1`.`service`.`order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of service order (e.g., turn-on, turn-off, repair, inspection) — primary segmentation for operational analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., open, completed, cancelled) — used to filter active vs. closed work."
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g., emergency, routine, scheduled) — critical for SLA breach analysis."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the order was scheduled — enables trend analysis of order volume over time."
    - name: "completion_date_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the order was completed — used to track throughput and backlog clearance."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Boolean indicating whether the SLA was met for this order — key dimension for SLA compliance segmentation."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the order is billable to the customer — used to separate revenue-generating from non-billable work."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome classification of the completed order — used to identify failure modes and resolution patterns."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of service orders — baseline volume metric for workload and capacity planning."
    - name: "completed_orders"
      expr: COUNT(CASE WHEN order_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed service orders — measures field execution throughput."
    - name: "sla_compliant_orders"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of orders where SLA was met — numerator for SLA compliance rate calculation."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN order_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed orders that met their SLA target — primary regulatory and customer satisfaction KPI for service delivery."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours to fulfill a service order — measures field response efficiency against SLA targets."
    - name: "total_billable_service_fees"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total billable service fee revenue from service orders — directly informs revenue forecasting and cost recovery analysis."
    - name: "avg_service_fee_per_order"
      expr: AVG(CAST(service_fee_amount AS DOUBLE))
      comment: "Average service fee per order — used to benchmark pricing and identify under-priced service types."
    - name: "billable_order_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Count of billable service orders — used to calculate cost recovery ratio against total order volume."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled orders — high cancellation rates signal scheduling inefficiency or customer dissatisfaction."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN priority = 'EMERGENCY' THEN 1 END)
      comment: "Count of emergency-priority orders — tracks unplanned demand that strains field resources and drives overtime costs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_connection_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for new service connection applications — tracks application pipeline, approval rates, fee revenue, and infrastructure demand. Used by Growth, Engineering, and Finance leadership to plan capacity and capital investment."
  source: "`vibe_water_utilities_v1`.`service`.`connection_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the connection application (e.g., pending, approved, rejected) — primary pipeline segmentation."
    - name: "application_type"
      expr: application_type
      comment: "Type of connection requested (e.g., residential, commercial, industrial) — drives capacity planning and rate classification."
    - name: "property_type"
      expr: property_type
      comment: "Property classification for the connection — used to segment demand by land use type."
    - name: "application_date_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month the application was submitted — enables trend analysis of new connection demand."
    - name: "infrastructure_upgrade_required"
      expr: infrastructure_upgrade_required
      comment: "Flag indicating whether infrastructure upgrade is required — used to identify capital-intensive connections."
    - name: "ami_enabled"
      expr: ami_enabled
      comment: "Whether AMI metering is enabled for this connection — tracks smart meter adoption in new connections."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of connection fees — used to track fee collection and outstanding receivables."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total connection applications submitted — baseline demand signal for growth and capacity planning."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved connection applications — measures pipeline conversion and approval throughput."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN application_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected applications — high rejection rates may signal capacity constraints or compliance issues."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved — key indicator of service availability and capacity adequacy."
    - name: "total_connection_fees_assessed"
      expr: SUM(CAST(total_fees_assessed AS DOUBLE))
      comment: "Total connection fees assessed across all applications — primary revenue metric for new connections and capital cost recovery."
    - name: "total_application_fees"
      expr: SUM(CAST(application_fee_amount AS DOUBLE))
      comment: "Total application fee revenue — tracks administrative cost recovery from the connection application process."
    - name: "total_capacity_charges"
      expr: SUM(CAST(capacity_charge_amount AS DOUBLE))
      comment: "Total capacity charges assessed — measures infrastructure cost recovery from new development."
    - name: "avg_connection_fee_per_application"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application — benchmarks fee adequacy against infrastructure cost."
    - name: "avg_estimated_flow_demand_gpm"
      expr: AVG(CAST(estimated_flow_demand_gpm AS DOUBLE))
      comment: "Average estimated flow demand in GPM per application — used to project system hydraulic load from new connections."
    - name: "infrastructure_upgrade_required_count"
      expr: COUNT(CASE WHEN infrastructure_upgrade_required = TRUE THEN 1 END)
      comment: "Count of applications requiring infrastructure upgrades — drives CIP prioritization and capital budget requests."
    - name: "capacity_available_count"
      expr: COUNT(CASE WHEN capacity_available = TRUE THEN 1 END)
      comment: "Count of applications where capacity is confirmed available — measures system headroom for growth."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_conservation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for water conservation programs — tracks water savings performance, budget utilization, incentive spend, and program effectiveness. Used by Conservation Managers, CFO, and Regulatory Affairs to demonstrate compliance and optimize program ROI."
  source: "`vibe_water_utilities_v1`.`service`.`conservation_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the conservation program (e.g., active, completed, suspended) — primary lifecycle segmentation."
    - name: "program_type"
      expr: program_type
      comment: "Type of conservation program (e.g., rebate, audit, education) — used to compare effectiveness across program categories."
    - name: "program_category"
      expr: program_category
      comment: "Broader category grouping for the program — enables portfolio-level analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (e.g., rebate, bill credit, direct install) — used to evaluate incentive structure effectiveness."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the program is mandated by regulation — distinguishes compliance-driven from voluntary programs."
    - name: "program_start_date_year"
      expr: DATE_TRUNC('year', program_start_date)
      comment: "Year the program started — enables multi-year trend analysis of conservation portfolio."
    - name: "customer_class_applicability"
      expr: customer_class_applicability
      comment: "Customer class the program targets (e.g., residential, commercial) — used to segment savings by customer type."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of conservation programs — baseline portfolio size metric."
    - name: "active_programs"
      expr: COUNT(CASE WHEN program_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active conservation programs — measures breadth of active conservation effort."
    - name: "total_actual_water_savings_gallons"
      expr: SUM(CAST(actual_water_savings_gallons AS DOUBLE))
      comment: "Total actual water savings achieved across all programs in gallons — primary outcome metric for conservation portfolio performance and regulatory reporting."
    - name: "total_target_water_savings_gallons"
      expr: SUM(CAST(target_water_savings_gallons AS DOUBLE))
      comment: "Total targeted water savings across all programs — denominator for savings achievement rate."
    - name: "water_savings_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_water_savings_gallons AS DOUBLE)) / NULLIF(SUM(CAST(target_water_savings_gallons AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted water savings actually achieved — key performance indicator for conservation program effectiveness and regulatory compliance."
    - name: "total_program_budget"
      expr: SUM(CAST(total_program_budget AS DOUBLE))
      comment: "Total budget allocated across all conservation programs — used for portfolio-level financial planning."
    - name: "total_budget_expended"
      expr: SUM(CAST(budget_expended_to_date AS DOUBLE))
      comment: "Total budget expended to date across all programs — tracks spend rate and budget burn."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_expended_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_program_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of program budget expended — measures financial execution efficiency and flags under/over-spending."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per program — used to benchmark incentive generosity and cost-effectiveness."
    - name: "avg_max_incentive_per_customer"
      expr: AVG(CAST(maximum_incentive_per_customer AS DOUBLE))
      comment: "Average maximum incentive per customer across programs — informs customer-facing program design and equity analysis."
    - name: "cost_per_gallon_saved"
      expr: ROUND(SUM(CAST(budget_expended_to_date AS DOUBLE)) / NULLIF(SUM(CAST(actual_water_savings_gallons AS DOUBLE)), 0), 4)
      comment: "Cost per gallon of water saved — the definitive ROI metric for conservation programs; compared against marginal cost of supply to justify program investment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_affordability_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for customer affordability and low-income assistance plans — tracks enrollment capacity, discount levels, and regulatory compliance. Used by Customer Affairs, Regulatory, and CFO to manage rate affordability obligations and revenue impact."
  source: "`vibe_water_utilities_v1`.`service`.`affordability_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the affordability plan (e.g., active, expired, pending) — primary lifecycle filter."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of affordability plan (e.g., LIRA, WRAP, senior discount) — used to compare program structures."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount offered (e.g., fixed amount, percentage) — used to analyze discount structure mix."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the plan is mandated by regulation — distinguishes compliance obligations from voluntary programs."
    - name: "auto_enrollment_flag"
      expr: auto_enrollment_flag
      comment: "Whether customers are auto-enrolled — used to assess outreach vs. passive enrollment strategy effectiveness."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the plan became effective — enables multi-year trend analysis of affordability program portfolio."
    - name: "eligibility_income_threshold_basis"
      expr: eligibility_income_threshold_basis
      comment: "Basis for income eligibility threshold (e.g., FPL, AMI) — used to compare eligibility criteria across plans."
  measures:
    - name: "total_affordability_plans"
      expr: COUNT(1)
      comment: "Total number of affordability plans — baseline portfolio count for regulatory reporting."
    - name: "active_plans"
      expr: COUNT(CASE WHEN plan_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active affordability plans — measures breadth of active customer assistance."
    - name: "total_max_benefit_amount"
      expr: SUM(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Total maximum benefit amount across all plans — measures maximum potential revenue impact of affordability programs."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across plans — benchmarks generosity of affordability programs against peer utilities."
    - name: "avg_discount_fixed_amount"
      expr: AVG(CAST(discount_fixed_amount AS DOUBLE))
      comment: "Average fixed discount amount across plans — used to assess bill impact of fixed-amount assistance programs."
    - name: "avg_eligibility_income_threshold_pct"
      expr: AVG(CAST(eligibility_income_threshold_percent AS DOUBLE))
      comment: "Average income threshold percentage (e.g., % of FPL) for eligibility — used to assess how broadly plans reach low-income customers."
    - name: "avg_eligibility_income_threshold_amount"
      expr: AVG(CAST(eligibility_income_threshold_amount AS DOUBLE))
      comment: "Average absolute income threshold amount for eligibility — used alongside percentage threshold for equity analysis."
    - name: "recertification_required_plan_count"
      expr: COUNT(CASE WHEN recertification_required_flag = TRUE THEN 1 END)
      comment: "Count of plans requiring periodic recertification — drives customer outreach workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service agreements — tracks active agreements, deposit exposure, billing configuration, and special service flags. Used by Customer Operations, Finance, and Regulatory to manage the service contract portfolio."
  source: "`vibe_water_utilities_v1`.`service`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the service agreement (e.g., active, terminated, suspended) — primary lifecycle segmentation."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for agreement termination — used to analyze churn drivers and involuntary disconnections."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the agreement became effective — enables cohort analysis of agreement vintages."
    - name: "deposit_status"
      expr: deposit_status
      comment: "Status of the security deposit (e.g., held, refunded, applied) — used to manage deposit liability."
    - name: "fire_protection_service_flag"
      expr: fire_protection_service_flag
      comment: "Whether the agreement includes fire protection service — used to segment fire service revenue."
    - name: "irrigation_service_flag"
      expr: irrigation_service_flag
      comment: "Whether the agreement includes irrigation service — used to segment seasonal demand."
    - name: "low_income_assistance_eligible"
      expr: low_income_assistance_eligible
      comment: "Whether the customer is eligible for low-income assistance — used to track affordability program reach."
    - name: "paperless_billing_enabled"
      expr: paperless_billing_enabled
      comment: "Whether paperless billing is enabled — tracks digital adoption rate across the customer base."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of service agreements — baseline portfolio size for customer operations planning."
    - name: "active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active service agreements — primary measure of active customer base size."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total security deposit amount held — measures deposit liability on the balance sheet."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per agreement — used to benchmark deposit policy adequacy against credit risk."
    - name: "total_minimum_usage_commitment_gallons"
      expr: SUM(CAST(minimum_usage_commitment_gallons AS DOUBLE))
      comment: "Total contracted minimum usage commitment in gallons — measures guaranteed revenue floor from take-or-pay provisions."
    - name: "auto_pay_enabled_count"
      expr: COUNT(CASE WHEN auto_pay_enabled = TRUE THEN 1 END)
      comment: "Count of agreements with auto-pay enabled — tracks payment automation adoption which reduces delinquency risk."
    - name: "paperless_billing_count"
      expr: COUNT(CASE WHEN paperless_billing_enabled = TRUE THEN 1 END)
      comment: "Count of agreements with paperless billing — measures digital channel adoption and paper cost reduction opportunity."
    - name: "low_income_eligible_count"
      expr: COUNT(CASE WHEN low_income_assistance_eligible = TRUE THEN 1 END)
      comment: "Count of agreements eligible for low-income assistance — used to assess affordability program reach and regulatory compliance."
    - name: "terminated_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'TERMINATED' THEN 1 END)
      comment: "Count of terminated agreements — tracks customer churn volume for retention analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_bulk_water_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for bulk water supply agreements with wholesale customers and interconnections — tracks contracted volumes, pricing, and revenue. Used by CFO, Wholesale Operations, and Regulatory Affairs to manage wholesale revenue and supply obligations."
  source: "`vibe_water_utilities_v1`.`service`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the bulk water agreement — primary lifecycle filter."
  measures:
    - name: "total_bulk_agreements"
      expr: COUNT(1)
      comment: "Total number of bulk water agreements — baseline wholesale portfolio count."
    - name: "active_bulk_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active bulk water agreements — measures active wholesale customer relationships."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service tariffs — tracks rate base, revenue requirements, and tariff lifecycle. Used by Regulatory Affairs, CFO, and Rate Analysts to manage rate case outcomes and tariff compliance."
  source: "`vibe_water_utilities_v1`.`service`.`tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current status of the tariff (e.g., effective, superseded, pending) — primary lifecycle filter."
    - name: "tariff_type"
      expr: tariff_type
      comment: "Type of tariff (e.g., potable water, recycled water, fire protection) — used to segment revenue by service type."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Rate structure (e.g., tiered, flat, seasonal) — used to analyze pricing model mix across the tariff portfolio."
    - name: "conservation_rate_flag"
      expr: conservation_rate_flag
      comment: "Whether the tariff includes conservation rate design — tracks adoption of conservation pricing."
    - name: "low_income_assistance_flag"
      expr: low_income_assistance_flag
      comment: "Whether the tariff includes low-income assistance provisions — used for affordability compliance tracking."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the tariff became effective — enables analysis of rate change history."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body that approved the tariff — used to segment tariffs by jurisdictional authority."
  measures:
    - name: "total_tariffs"
      expr: COUNT(1)
      comment: "Total number of tariffs in the portfolio — baseline count for regulatory inventory management."
    - name: "effective_tariffs"
      expr: COUNT(CASE WHEN tariff_status = 'EFFECTIVE' THEN 1 END)
      comment: "Count of currently effective tariffs — measures active rate schedule inventory."
    - name: "total_revenue_requirement"
      expr: SUM(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement across all tariffs — the foundational financial metric for rate case justification and utility financial planning."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base across all tariffs — measures the asset investment base on which the utility earns its allowed return."
    - name: "avg_rate_of_return_pct"
      expr: AVG(CAST(rate_of_return_percent AS DOUBLE))
      comment: "Average allowed rate of return across tariffs — key regulatory metric comparing actual vs. authorized return."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across tariffs — used to benchmark rate levels against peer utilities."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum monthly charge across tariffs — used to assess fixed cost recovery adequacy."
    - name: "conservation_rate_tariff_count"
      expr: COUNT(CASE WHEN conservation_rate_flag = TRUE THEN 1 END)
      comment: "Count of tariffs with conservation rate design — tracks regulatory compliance with conservation pricing mandates."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service territories — tracks demand, customer counts, and service capacity by geographic area. Used by Operations, Planning, and Executive leadership to allocate resources and plan infrastructure investment by territory."
  source: "`vibe_water_utilities_v1`.`service`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., active, inactive, pending annexation) — primary lifecycle filter."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., urban, suburban, rural) — used to segment performance by service area characteristics."
    - name: "service_classification"
      expr: service_classification
      comment: "Service classification of the territory — used to group territories by regulatory or operational category."
    - name: "state_code"
      expr: state_code
      comment: "State code for the territory — enables multi-state utility geographic analysis."
    - name: "potable_water_service_flag"
      expr: potable_water_service_flag
      comment: "Whether potable water service is provided in this territory — used to filter territories by service type."
    - name: "wastewater_service_flag"
      expr: wastewater_service_flag
      comment: "Whether wastewater service is provided — used to identify combined vs. water-only territories."
    - name: "recycled_water_service_flag"
      expr: recycled_water_service_flag
      comment: "Whether recycled water service is provided — tracks recycled water program geographic reach."
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of service territories — baseline geographic portfolio count."
    - name: "active_territories"
      expr: COUNT(CASE WHEN territory_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active service territories — measures operational geographic footprint."
    - name: "total_area_square_miles"
      expr: SUM(CAST(area_square_miles AS DOUBLE))
      comment: "Total service area in square miles — measures geographic scale of utility operations."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand in MGD across all territories — primary supply planning metric for system-wide demand management."
    - name: "total_peak_daily_demand_mgd"
      expr: SUM(CAST(peak_daily_demand_mgd AS DOUBLE))
      comment: "Total peak daily demand in MGD — drives infrastructure sizing and emergency supply planning."
    - name: "peak_to_average_demand_ratio"
      expr: ROUND(SUM(CAST(peak_daily_demand_mgd AS DOUBLE)) / NULLIF(SUM(CAST(average_daily_demand_mgd AS DOUBLE)), 0), 3)
      comment: "Ratio of peak to average daily demand — measures demand variability and system peaking factor; high ratios indicate need for storage or interconnection capacity."
    - name: "avg_area_per_territory_sq_miles"
      expr: AVG(CAST(area_square_miles AS DOUBLE))
      comment: "Average territory size in square miles — used to benchmark operational density and field service efficiency."
    - name: "recycled_water_territory_count"
      expr: COUNT(CASE WHEN recycled_water_service_flag = TRUE THEN 1 END)
      comment: "Count of territories with recycled water service — tracks geographic expansion of water reuse programs."
    - name: "combined_service_territory_count"
      expr: COUNT(CASE WHEN potable_water_service_flag = TRUE AND wastewater_service_flag = TRUE THEN 1 END)
      comment: "Count of territories providing both potable water and wastewater service — measures combined utility footprint."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for SLA definitions — tracks SLA target levels, compliance thresholds, and penalty exposure. Used by Operations, Regulatory, and Legal to manage service level commitments and regulatory obligations."
  source: "`vibe_water_utilities_v1`.`service`.`sla_definition`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., response time, restoration time, water quality) — primary segmentation for SLA portfolio analysis."
    - name: "sla_definition_status"
      expr: sla_definition_status
      comment: "Current status of the SLA definition (e.g., active, expired, draft) — lifecycle filter."
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric being defined — used to group SLA performance by metric type."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for SLA breach (e.g., financial, regulatory, service credit) — used to assess breach consequence severity."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the SLA definition became effective — enables trend analysis of SLA standard evolution."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SLA metric (e.g., hours, minutes, percentage) — used to group comparable SLA types."
  measures:
    - name: "total_sla_definitions"
      expr: COUNT(1)
      comment: "Total number of SLA definitions — baseline count of service level commitments in the portfolio."
    - name: "active_sla_definitions"
      expr: COUNT(CASE WHEN sla_definition_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active SLA definitions — measures scope of active service level obligations."
    - name: "avg_compliance_percentage_target"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average required compliance percentage across SLA definitions — benchmarks the stringency of service level commitments."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across definitions — used to assess overall service level ambition."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all SLA definitions — measures maximum financial exposure from SLA breaches."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA definition — used to prioritize SLA compliance efforts by financial risk."
    - name: "sla_definitions_with_penalties"
      expr: COUNT(CASE WHEN penalty_amount > 0 THEN 1 END)
      comment: "Count of SLA definitions with financial penalties — measures proportion of SLAs with direct financial consequences for breach."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service program enrollments — tracks enrollment pipeline, water savings outcomes, and incentive payments. Used by Conservation Managers, Customer Affairs, and Regulatory to measure program uptake and conservation outcomes."
  source: "`vibe_water_utilities_v1`.`service`.`service_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g., active, completed, cancelled) — primary lifecycle segmentation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the customer enrolled (e.g., online, phone, in-person) — used to optimize outreach strategy."
    - name: "verification_status"
      expr: verification_status
      comment: "Eligibility verification status — used to track compliance with program eligibility requirements."
    - name: "incentive_payment_method"
      expr: incentive_payment_method
      comment: "Method of incentive payment (e.g., bill credit, check, prepaid card) — used to analyze payment channel preferences."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment — enables trend analysis of program uptake over time."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this enrollment is subject to regulatory reporting — used to filter reportable enrollments."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the enrollment auto-renews — used to forecast future enrollment counts and incentive obligations."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of program enrollments — baseline volume metric for program uptake tracking."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active enrollments — measures current program participation level."
    - name: "total_incentive_amount_approved"
      expr: SUM(CAST(incentive_amount_approved AS DOUBLE))
      comment: "Total incentive amount approved across all enrollments — measures total financial commitment to program participants."
    - name: "total_incentive_amount_paid"
      expr: SUM(CAST(incentive_amount_paid AS DOUBLE))
      comment: "Total incentive amount actually paid — measures actual cash outflow for conservation incentives."
    - name: "incentive_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(incentive_amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(incentive_amount_approved AS DOUBLE)), 0), 2)
      comment: "Percentage of approved incentives that have been paid — measures program disbursement efficiency and outstanding incentive liability."
    - name: "total_water_savings_actual_gallons"
      expr: SUM(CAST(water_savings_actual_gallons AS DOUBLE))
      comment: "Total actual water savings achieved across all enrollments in gallons — primary conservation outcome metric for regulatory reporting."
    - name: "total_water_savings_target_gallons"
      expr: SUM(CAST(water_savings_target_gallons AS DOUBLE))
      comment: "Total targeted water savings across all enrollments — denominator for savings achievement rate."
    - name: "water_savings_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(water_savings_actual_gallons AS DOUBLE)) / NULLIF(SUM(CAST(water_savings_target_gallons AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted water savings achieved at enrollment level — measures individual program effectiveness and drives program design improvements."
    - name: "cancelled_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled enrollments — high cancellation rates signal program design or customer experience issues."
    - name: "avg_baseline_consumption_gallons"
      expr: AVG(CAST(baseline_consumption_gallons AS DOUBLE))
      comment: "Average baseline consumption in gallons per enrollment — used to assess the conservation potential of enrolled customers."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service offerings — tracks pricing, capacity, and lifecycle of the service product catalog. Used by Product Management, Finance, and Regulatory to manage the service portfolio and ensure rate adequacy."
  source: "`vibe_water_utilities_v1`.`service`.`offering`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the offering (e.g., active, retired, pending) — primary portfolio filter."
    - name: "service_type"
      expr: service_type
      comment: "Type of service offered (e.g., potable water, recycled water, fire protection) — primary segmentation for revenue analysis."
    - name: "customer_class"
      expr: customer_class
      comment: "Customer class the offering targets (e.g., residential, commercial, industrial) — used to segment pricing by customer type."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Rate structure type (e.g., tiered, flat, seasonal) — used to analyze pricing model mix."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of service delivery — used to segment offerings by delivery mechanism."
    - name: "ami_enabled_flag"
      expr: ami_enabled_flag
      comment: "Whether AMI metering is enabled for this offering — tracks smart meter integration in the product catalog."
    - name: "conservation_program_eligible_flag"
      expr: conservation_program_eligible_flag
      comment: "Whether the offering is eligible for conservation programs — used to assess conservation program reach."
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of service offerings — baseline product catalog count."
    - name: "active_offerings"
      expr: COUNT(CASE WHEN lifecycle_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active service offerings — measures active product portfolio breadth."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across offerings — benchmarks pricing levels across the product catalog."
    - name: "avg_volumetric_rate_amount"
      expr: AVG(CAST(volumetric_rate_amount AS DOUBLE))
      comment: "Average volumetric rate amount — used to assess consumption-based pricing adequacy."
    - name: "avg_minimum_monthly_charge"
      expr: AVG(CAST(minimum_monthly_charge AS DOUBLE))
      comment: "Average minimum monthly charge across offerings — measures fixed cost recovery floor across the product portfolio."
    - name: "avg_connection_fee"
      expr: AVG(CAST(connection_fee AS DOUBLE))
      comment: "Average connection fee across offerings — used to benchmark new connection cost recovery."
    - name: "avg_flow_capacity_gpm"
      expr: AVG(CAST(flow_capacity_gpm AS DOUBLE))
      comment: "Average flow capacity in GPM across offerings — used to assess hydraulic capacity commitments in the product catalog."
    - name: "avg_capacity_charge"
      expr: AVG(CAST(capacity_charge AS DOUBLE))
      comment: "Average capacity charge across offerings — measures infrastructure cost recovery through capacity fees."
    - name: "ami_enabled_offering_count"
      expr: COUNT(CASE WHEN ami_enabled_flag = TRUE THEN 1 END)
      comment: "Count of offerings with AMI enabled — tracks smart metering integration across the product catalog."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_special_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for special service contracts with large industrial and commercial customers — tracks contract value, volume commitments, and compliance requirements. Used by CFO, Legal, and Industrial Services to manage high-value customer contracts."
  source: "`vibe_water_utilities_v1`.`service`.`special_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the special contract (e.g., active, expired, under negotiation) — primary lifecycle filter."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of special contract (e.g., industrial, commercial, wholesale) — used to segment contract portfolio by customer category."
    - name: "negotiated_rate_structure"
      expr: negotiated_rate_structure
      comment: "Rate structure negotiated for the contract — used to analyze pricing model diversity in special contracts."
    - name: "iup_compliance_required_flag"
      expr: iup_compliance_required_flag
      comment: "Whether industrial user permit compliance is required — used to identify contracts with pretreatment obligations."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews — used to forecast contract retention and revenue continuity."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the contract became effective — enables vintage analysis of special contract portfolio."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the contract — used to segment contracts by billing frequency."
  measures:
    - name: "total_special_contracts"
      expr: COUNT(1)
      comment: "Total number of special contracts — baseline count of high-value customer agreements."
    - name: "active_special_contracts"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active special contracts — measures active high-value customer relationships."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total contract value across all special contracts — primary revenue metric for the high-value customer segment."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average contract value per special contract — benchmarks deal size and identifies outliers."
    - name: "total_minimum_volume_commitment_mgd"
      expr: SUM(CAST(minimum_volume_commitment_mgd AS DOUBLE))
      comment: "Total minimum volume commitment in MGD — measures guaranteed demand from special contract customers."
    - name: "total_maximum_volume_limit_mgd"
      expr: SUM(CAST(maximum_volume_limit_mgd AS DOUBLE))
      comment: "Total maximum volume limit in MGD — measures peak demand exposure from special contract customers."
    - name: "avg_base_rate_per_unit"
      expr: AVG(CAST(base_rate_per_unit AS DOUBLE))
      comment: "Average negotiated base rate per unit — used to compare special contract pricing against standard tariff rates."
    - name: "total_demand_charges"
      expr: SUM(CAST(demand_charge_amount AS DOUBLE))
      comment: "Total demand charges across special contracts — measures fixed demand revenue from large industrial customers."
    - name: "iup_compliance_required_count"
      expr: COUNT(CASE WHEN iup_compliance_required_flag = TRUE THEN 1 END)
      comment: "Count of contracts requiring IUP compliance — measures pretreatment program scope and regulatory oversight workload."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical and performance characteristics of service points"
  source: "`vibe_water_utilities_v1`.`service`.`point`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Classification of service (e.g., residential, commercial)"
    - name: "service_point_status"
      expr: service_point_status
      comment: "Current operational status of the point"
    - name: "territory_id"
      expr: territory_id
      comment: "Geographic territory of the service point"
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the service point was installed"
  measures:
    - name: "total_points"
      expr: COUNT(1)
      comment: "Total number of service points"
    - name: "avg_peak_demand_gpm"
      expr: AVG(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Average peak demand per service point (gallons per minute)"
    - name: "total_elevation_feet"
      expr: SUM(CAST(elevation_feet AS DOUBLE))
      comment: "Cumulative elevation of all service points"
    - name: "fire_service_indicator_count"
      expr: SUM(CASE WHEN fire_service_indicator THEN 1 ELSE 0 END)
      comment: "Count of service points flagged for fire service"
$$;