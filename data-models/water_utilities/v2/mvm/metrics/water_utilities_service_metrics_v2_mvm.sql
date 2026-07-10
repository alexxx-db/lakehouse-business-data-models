-- Metric views for domain: service | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over service agreements — tracks active portfolio size, financial exposure via deposits, program adoption rates, and SLA commitment coverage. Used by VP of Customer Service and CFO to steer contract strategy, pricing, and risk."
  source: "`vibe_water_utilities_v1`.`service`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g., Active, Suspended, Terminated) — primary segmentation for portfolio health analysis."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assigned to the agreement (e.g., Monthly, Bi-Monthly) — used to analyze revenue timing and cash-flow patterns."
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule applied to the agreement — enables revenue and pricing analysis by tariff tier."
    - name: "contract_term_months"
      expr: contract_term_months
      comment: "Contract duration in months — used to segment short-term vs. long-term commitments for renewal risk analysis."
    - name: "auto_pay_enabled"
      expr: auto_pay_enabled
      comment: "Indicates whether automatic payment is enabled — used to assess payment risk and collections exposure."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Indicates whether the agreement auto-renews — used to forecast contract retention and churn risk."
    - name: "low_income_assistance_eligible"
      expr: low_income_assistance_eligible
      comment: "Flags agreements eligible for low-income assistance programs — used for regulatory reporting and equity analysis."
    - name: "budget_billing_enabled"
      expr: budget_billing_enabled
      comment: "Indicates whether budget billing is active — used to assess revenue smoothing and customer financial stability."
    - name: "fire_protection_service_flag"
      expr: fire_protection_service_flag
      comment: "Flags agreements that include fire protection service — used for infrastructure planning and regulatory compliance."
    - name: "irrigation_service_flag"
      expr: irrigation_service_flag
      comment: "Flags agreements with irrigation service — used for seasonal demand forecasting and conservation program targeting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the agreement became effective — used for cohort analysis and new-agreement trend reporting."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the agreement is scheduled to end — used for renewal pipeline and churn forecasting."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active service agreements — primary portfolio size KPI used by leadership to track service footprint."
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of service agreements across all statuses — baseline denominator for rate calculations."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit liability held across all agreements — used by Finance to manage cash reserves and credit risk exposure."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per agreement — benchmarks deposit policy effectiveness and customer credit risk profile."
    - name: "total_minimum_usage_commitment_gallons"
      expr: SUM(CAST(minimum_usage_commitment_gallons AS DOUBLE))
      comment: "Total contracted minimum usage volume in gallons across all agreements — used by Operations to plan minimum revenue floor and infrastructure capacity."
    - name: "avg_minimum_usage_commitment_gallons"
      expr: AVG(CAST(minimum_usage_commitment_gallons AS DOUBLE))
      comment: "Average minimum usage commitment per agreement in gallons — used to benchmark contract terms and identify under-committed segments."
    - name: "auto_pay_adoption_count"
      expr: COUNT(CASE WHEN auto_pay_enabled = TRUE THEN agreement_id END)
      comment: "Number of agreements with auto-pay enabled — used to track payment automation adoption and reduce collections cost."
    - name: "auto_renewal_adoption_count"
      expr: COUNT(CASE WHEN auto_renewal_enabled = TRUE THEN agreement_id END)
      comment: "Number of agreements with auto-renewal enabled — used to forecast contract retention and reduce churn risk."
    - name: "low_income_assistance_eligible_count"
      expr: COUNT(CASE WHEN low_income_assistance_eligible = TRUE THEN agreement_id END)
      comment: "Number of agreements eligible for low-income assistance — used for regulatory equity reporting and program budget planning."
    - name: "paperless_billing_adoption_count"
      expr: COUNT(CASE WHEN paperless_billing_enabled = TRUE THEN agreement_id END)
      comment: "Number of agreements enrolled in paperless billing — tracks digital adoption and operational cost reduction from print/mail elimination."
    - name: "terminated_agreements_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN agreement_id END)
      comment: "Count of terminated agreements — used to monitor churn rate and trigger retention intervention analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_connection_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over new service connection applications — tracks application pipeline volume, approval rates, fee revenue, and infrastructure demand signals. Used by Engineering, Finance, and Regulatory Affairs to manage growth capacity and compliance."
  source: "`vibe_water_utilities_v1`.`service`.`connection_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the connection application (e.g., Pending, Approved, Rejected) — primary segmentation for pipeline health."
    - name: "application_type"
      expr: application_type
      comment: "Type of connection application (e.g., New Service, Upgrade, Temporary) — used to segment demand by service category."
    - name: "property_type"
      expr: property_type
      comment: "Type of property requesting connection (e.g., Residential, Commercial, Industrial) — used for capacity planning and rate class assignment."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of application fees — used to track fee collection efficiency and outstanding receivables."
    - name: "capacity_available"
      expr: capacity_available
      comment: "Indicates whether system capacity is available at the requested connection point — used to flag infrastructure constraint hotspots."
    - name: "infrastructure_upgrade_required"
      expr: infrastructure_upgrade_required
      comment: "Flags applications requiring infrastructure upgrades — used to prioritize capital investment planning."
    - name: "ami_enabled"
      expr: ami_enabled
      comment: "Indicates whether AMI (Advanced Metering Infrastructure) is requested — used to track smart meter deployment pipeline."
    - name: "application_date_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month the application was submitted — used for trend analysis of new connection demand."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the application was approved — used to measure approval throughput and processing velocity."
    - name: "service_city"
      expr: service_city
      comment: "City of the requested service address — used for geographic demand analysis and capacity planning by service area."
    - name: "service_state"
      expr: service_state
      comment: "State of the requested service address — used for multi-jurisdiction regulatory and capacity reporting."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of connection applications submitted — primary pipeline volume KPI for growth and capacity planning."
    - name: "approved_applications_count"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN connection_application_id END)
      comment: "Number of approved connection applications — used to track approval throughput and service expansion rate."
    - name: "rejected_applications_count"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN connection_application_id END)
      comment: "Number of rejected applications — used to identify systemic barriers to service access and compliance risk."
    - name: "infrastructure_upgrade_required_count"
      expr: COUNT(CASE WHEN infrastructure_upgrade_required = TRUE THEN connection_application_id END)
      comment: "Number of applications requiring infrastructure upgrades — directly drives capital expenditure planning and project prioritization."
    - name: "total_application_fees_assessed"
      expr: SUM(CAST(application_fee_amount AS DOUBLE))
      comment: "Total application fees assessed — tracks fee revenue from new connection pipeline, used by Finance for revenue forecasting."
    - name: "total_connection_fees_assessed"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees assessed across all applications — key capital recovery revenue metric for infrastructure investment."
    - name: "total_capacity_charges_assessed"
      expr: SUM(CAST(capacity_charge_amount AS DOUBLE))
      comment: "Total capacity charges assessed — measures system development charge revenue used to fund infrastructure expansion."
    - name: "total_fees_assessed"
      expr: SUM(CAST(total_fees_assessed AS DOUBLE))
      comment: "Total all-in fees assessed per application — comprehensive fee revenue KPI for new connection pipeline."
    - name: "avg_connection_size_inches"
      expr: AVG(CAST(connection_size_inches AS DOUBLE))
      comment: "Average requested connection size in inches — used to assess demand profile and infrastructure sizing requirements."
    - name: "avg_estimated_flow_demand_gpm"
      expr: AVG(CAST(estimated_flow_demand_gpm AS DOUBLE))
      comment: "Average estimated flow demand in gallons per minute across applications — used for hydraulic capacity planning."
    - name: "total_estimated_flow_demand_gpm"
      expr: SUM(CAST(estimated_flow_demand_gpm AS DOUBLE))
      comment: "Total estimated flow demand in GPM across all pending/approved applications — aggregate demand signal for system capacity planning."
    - name: "capacity_constrained_applications_count"
      expr: COUNT(CASE WHEN capacity_available = FALSE THEN connection_application_id END)
      comment: "Number of applications where system capacity is unavailable — critical infrastructure constraint indicator for capital planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_conservation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for water conservation programs — tracks water savings performance, budget utilization, incentive spend, and regulatory mandate compliance. Used by Conservation, Regulatory Affairs, and Finance leadership."
  source: "`vibe_water_utilities_v1`.`service`.`conservation_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the conservation program (e.g., Active, Completed, Suspended) — primary segmentation for portfolio health."
    - name: "program_type"
      expr: program_type
      comment: "Type of conservation program (e.g., Rebate, Audit, Education) — used to analyze effectiveness by program category."
    - name: "program_category"
      expr: program_category
      comment: "Category of the conservation program — used for portfolio segmentation and budget allocation analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (e.g., Rebate, Bill Credit, Direct Install) — used to compare cost-effectiveness across incentive mechanisms."
    - name: "customer_class_applicability"
      expr: customer_class_applicability
      comment: "Customer class the program targets (e.g., Residential, Commercial) — used for equity and market penetration analysis."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the program is mandated by regulation — used to prioritize compliance-critical programs in budget planning."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of program funding (e.g., Rate Revenue, Grant, State Fund) — used for financial accountability and grant reporting."
    - name: "program_start_date_year"
      expr: DATE_TRUNC('YEAR', program_start_date)
      comment: "Year the program started — used for multi-year trend analysis of conservation investment and savings."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the program reports results — used to align reporting cadence with regulatory and executive review cycles."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN conservation_program_id END)
      comment: "Number of currently active conservation programs — tracks breadth of conservation portfolio for regulatory and strategic reporting."
    - name: "total_actual_water_savings_gallons"
      expr: SUM(CAST(actual_water_savings_gallons AS DOUBLE))
      comment: "Total actual water savings achieved in gallons across all programs — primary conservation outcome KPI used by executives and regulators."
    - name: "total_target_water_savings_gallons"
      expr: SUM(CAST(target_water_savings_gallons AS DOUBLE))
      comment: "Total targeted water savings in gallons across all programs — denominator for savings attainment rate calculation."
    - name: "total_program_budget"
      expr: SUM(CAST(total_program_budget AS DOUBLE))
      comment: "Total budgeted spend across all conservation programs — used by Finance for budget planning and rate case preparation."
    - name: "total_budget_expended"
      expr: SUM(CAST(budget_expended_to_date AS DOUBLE))
      comment: "Total budget expended to date across all programs — used to track spend velocity and forecast budget exhaustion."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive value offered across programs — measures financial commitment to demand-side management."
    - name: "avg_incentive_per_program"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per conservation program — used to benchmark program generosity and cost-effectiveness."
    - name: "total_max_incentive_per_customer"
      expr: SUM(CAST(maximum_incentive_per_customer AS DOUBLE))
      comment: "Sum of maximum per-customer incentive caps across programs — used to estimate maximum incentive liability exposure."
    - name: "regulatory_mandate_program_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN conservation_program_id END)
      comment: "Number of programs driven by regulatory mandate — used to track compliance obligations and prioritize resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over service offerings — tracks pricing structure, rate competitiveness, capacity commitments, and lifecycle health of the product catalog. Used by Product Management, Regulatory Affairs, and Finance."
  source: "`vibe_water_utilities_v1`.`service`.`offering`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the offering (e.g., Active, Deprecated, Pending) — used to manage product catalog health."
    - name: "service_type"
      expr: service_type
      comment: "Type of service delivered by the offering (e.g., Potable Water, Recycled Water, Fire Protection) — primary product segmentation."
    - name: "customer_class"
      expr: customer_class
      comment: "Customer class the offering targets (e.g., Residential, Commercial, Industrial) — used for pricing equity and market analysis."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Rate structure applied (e.g., Tiered, Flat, Inclining Block) — used to analyze pricing strategy and conservation incentive alignment."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle for the offering — used to align revenue recognition and cash-flow forecasting."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of service delivery — used to segment offerings by infrastructure type and operational cost driver."
    - name: "conservation_program_eligible_flag"
      expr: conservation_program_eligible_flag
      comment: "Indicates whether customers on this offering are eligible for conservation programs — used for program targeting and regulatory reporting."
    - name: "fire_protection_service_flag"
      expr: fire_protection_service_flag
      comment: "Flags offerings that include fire protection service — used for regulatory compliance and infrastructure planning."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the offering became effective — used for rate history and regulatory filing trend analysis."
    - name: "water_quality_standard"
      expr: water_quality_standard
      comment: "Water quality standard associated with the offering — used for compliance and customer communication analysis."
  measures:
    - name: "total_active_offerings"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN offering_id END)
      comment: "Number of currently active service offerings — tracks product catalog breadth for market coverage analysis."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across offerings — used by Regulatory Affairs to benchmark pricing levels for rate case filings."
    - name: "avg_volumetric_rate_amount"
      expr: AVG(CAST(volumetric_rate_amount AS DOUBLE))
      comment: "Average volumetric rate per unit across offerings — key pricing KPI for conservation incentive and revenue adequacy analysis."
    - name: "avg_minimum_monthly_charge"
      expr: AVG(CAST(minimum_monthly_charge AS DOUBLE))
      comment: "Average minimum monthly charge across offerings — used to assess revenue floor and fixed cost recovery adequacy."
    - name: "total_connection_fee_revenue_potential"
      expr: SUM(CAST(connection_fee AS DOUBLE))
      comment: "Sum of connection fees across all offerings — estimates total connection fee revenue potential from the product catalog."
    - name: "avg_flow_capacity_gpm"
      expr: AVG(CAST(flow_capacity_gpm AS DOUBLE))
      comment: "Average flow capacity in GPM across offerings — used by Engineering to assess whether product commitments align with system capacity."
    - name: "avg_late_payment_penalty_percent"
      expr: AVG(CAST(late_payment_penalty_percent AS DOUBLE))
      comment: "Average late payment penalty rate across offerings — used to benchmark collections policy and revenue protection effectiveness."
    - name: "total_capacity_charge_revenue_potential"
      expr: SUM(CAST(capacity_charge AS DOUBLE))
      comment: "Sum of capacity charges across all offerings — estimates system development charge revenue potential for capital recovery planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs over service orders — tracks order fulfillment velocity, SLA compliance, billable revenue, and field operations efficiency. Used by Operations, Customer Service, and Finance leadership."
  source: "`vibe_water_utilities_v1`.`service`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the service order (e.g., Open, Completed, Cancelled) — primary segmentation for workload and backlog analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of service order (e.g., New Connection, Disconnect, Repair, Meter Read) — used to analyze workload composition and resource allocation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the order (e.g., Emergency, High, Normal) — used to assess SLA risk and dispatch prioritization."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome of the completed order — used to track first-time completion rates and identify recurring failure patterns."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the order generates a billable charge — used to separate revenue-generating work from non-billable operations."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the order was completed within SLA — primary SLA compliance dimension for regulatory and customer satisfaction reporting."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the order was scheduled — used for workload forecasting and capacity planning."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the order was completed — used for throughput trend analysis and backlog burn-down reporting."
    - name: "requested_date_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the order was requested — used for demand trend analysis and seasonal workload planning."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of service orders — baseline workload volume KPI for operations capacity planning."
    - name: "completed_orders_count"
      expr: COUNT(CASE WHEN order_status = 'Completed' THEN order_id END)
      comment: "Number of completed service orders — tracks operational throughput and field crew productivity."
    - name: "sla_met_orders_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN order_id END)
      comment: "Number of orders completed within SLA — numerator for SLA compliance rate; directly tied to regulatory commitments and customer satisfaction."
    - name: "sla_breached_orders_count"
      expr: COUNT(CASE WHEN sla_met_flag = FALSE THEN order_id END)
      comment: "Number of orders that breached SLA — used to trigger operational intervention and regulatory risk assessment."
    - name: "total_service_fee_revenue"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fee revenue generated from billable orders — key revenue KPI for field operations financial performance."
    - name: "avg_service_fee_amount"
      expr: AVG(CAST(service_fee_amount AS DOUBLE))
      comment: "Average service fee per order — used to benchmark pricing adequacy and identify under-priced service categories."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours to complete an order relative to SLA — used to identify systemic delays and resource bottlenecks."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual SLA hours consumed across all orders — used to measure aggregate field labor demand and overtime risk."
    - name: "billable_orders_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN order_id END)
      comment: "Number of billable service orders — used to track revenue-generating work volume and billing conversion rate."
    - name: "avg_meter_reading_value"
      expr: AVG(CAST(meter_reading_value AS DOUBLE))
      comment: "Average meter reading value recorded during service orders — used to validate meter accuracy and detect anomalous consumption patterns."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over service points — tracks active service point inventory, demand profile, AMI deployment, and infrastructure characteristics. Used by Engineering, Asset Management, and Operations leadership for capacity and investment planning."
  source: "`vibe_water_utilities_v1`.`service`.`point`"
  dimensions:
    - name: "service_point_status"
      expr: service_point_status
      comment: "Current status of the service point (e.g., Active, Inactive, Disconnected) — primary segmentation for active service footprint analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of service delivered at the point (e.g., Potable, Recycled, Fire) — used for demand and infrastructure segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the service point (e.g., Utility, Customer, Private) — used for asset responsibility and maintenance planning."
    - name: "ami_enabled"
      expr: ami_enabled
      comment: "Indicates whether AMI is installed at the service point — used to track smart meter deployment progress and data quality coverage."
    - name: "backflow_prevention_required"
      expr: backflow_prevention_required
      comment: "Flags service points requiring backflow prevention — used for regulatory compliance tracking and inspection scheduling."
    - name: "fire_service_indicator"
      expr: fire_service_indicator
      comment: "Indicates whether the point serves fire protection — used for regulatory compliance and infrastructure planning."
    - name: "connection_material"
      expr: connection_material
      comment: "Material of the service connection (e.g., Copper, PVC, Lead) — used for asset risk assessment and lead service line replacement planning."
    - name: "service_city"
      expr: service_city
      comment: "City of the service point — used for geographic demand and infrastructure analysis."
    - name: "service_state"
      expr: service_state
      comment: "State of the service point — used for multi-jurisdiction regulatory and capacity reporting."
    - name: "activation_date_year"
      expr: DATE_TRUNC('YEAR', activation_date)
      comment: "Year the service point was activated — used for vintage analysis and infrastructure age profiling."
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule assigned to the service point — used for revenue and pricing analysis by tariff tier."
  measures:
    - name: "total_active_service_points"
      expr: COUNT(CASE WHEN service_point_status = 'Active' THEN point_id END)
      comment: "Number of currently active service points — primary service footprint KPI used by executives to track customer base size and infrastructure utilization."
    - name: "total_service_points"
      expr: COUNT(1)
      comment: "Total service points across all statuses — baseline inventory count for asset management and capacity planning."
    - name: "ami_enabled_count"
      expr: COUNT(CASE WHEN ami_enabled = TRUE THEN point_id END)
      comment: "Number of service points with AMI enabled — tracks smart meter deployment progress, a key capital program KPI."
    - name: "backflow_prevention_required_count"
      expr: COUNT(CASE WHEN backflow_prevention_required = TRUE THEN point_id END)
      comment: "Number of service points requiring backflow prevention — used to size compliance inspection programs and regulatory reporting."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily demand in gallons across all active service points — primary demand planning KPI for system capacity and treatment planning."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily demand per service point in gallons — used to benchmark consumption profiles and identify high-demand outliers."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in GPM across all service points — critical hydraulic capacity planning KPI for distribution system design."
    - name: "avg_connection_size_inches"
      expr: AVG(CAST(connection_size_inches AS DOUBLE))
      comment: "Average connection size in inches across service points — used to assess infrastructure sizing adequacy and upgrade needs."
    - name: "fire_service_point_count"
      expr: COUNT(CASE WHEN fire_service_indicator = TRUE THEN point_id END)
      comment: "Number of service points designated for fire protection — used for regulatory compliance and fire flow capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over conservation program enrollments — tracks participation rates, incentive disbursement, and enrollment lifecycle. Used by Conservation and Finance leadership to evaluate program uptake and cost-effectiveness."
  source: "`vibe_water_utilities_v1`.`service`.`program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the program enrollment (e.g., Active, Completed, Withdrawn) — primary segmentation for participation analysis."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — used for trend analysis of program uptake velocity and seasonal participation patterns."
    - name: "participation_start_date_month"
      expr: DATE_TRUNC('MONTH', participation_start_date)
      comment: "Month participation began — used for cohort analysis of program engagement and retention."
    - name: "participation_end_date_month"
      expr: DATE_TRUNC('MONTH', participation_end_date)
      comment: "Month participation ended — used to analyze program completion rates and dropout timing."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of program enrollments — primary participation volume KPI for conservation program performance reporting."
    - name: "active_enrollments_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN program_enrollment_id END)
      comment: "Number of currently active program enrollments — tracks live participation base for program management and budget forecasting."
    - name: "total_incentive_amount_awarded"
      expr: SUM(CAST(incentive_amount_awarded AS DOUBLE))
      comment: "Total incentive dollars awarded to enrolled participants — primary financial KPI for conservation program cost tracking and budget management."
    - name: "avg_incentive_amount_awarded"
      expr: AVG(CAST(incentive_amount_awarded AS DOUBLE))
      comment: "Average incentive awarded per enrollment — used to benchmark per-participant cost and evaluate program cost-effectiveness."
    - name: "distinct_programs_with_enrollments"
      expr: COUNT(DISTINCT conservation_program_id)
      comment: "Number of distinct conservation programs with at least one enrollment — used to assess program portfolio reach and adoption breadth."
    - name: "distinct_agreements_enrolled"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct service agreements enrolled in conservation programs — measures customer participation breadth across the service portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory tariffs — tracks rate base, revenue requirements, rate of return, and tariff lifecycle. Used by Regulatory Affairs, Finance, and Executive leadership for rate case management and financial planning."
  source: "`vibe_water_utilities_v1`.`service`.`tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current status of the tariff (e.g., Active, Superseded, Pending) — primary segmentation for effective rate schedule analysis."
    - name: "tariff_type"
      expr: tariff_type
      comment: "Type of tariff (e.g., General Metered, Fire Protection, Recycled Water) — used to segment revenue requirement by service category."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Rate structure of the tariff (e.g., Tiered, Flat, Inclining Block) — used to analyze pricing strategy and conservation alignment."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body that approved the tariff — used for multi-jurisdiction compliance and rate case tracking."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency under the tariff — used for revenue timing and cash-flow analysis."
    - name: "conservation_rate_flag"
      expr: conservation_rate_flag
      comment: "Indicates whether the tariff includes conservation rate incentives — used to track conservation-aligned pricing adoption."
    - name: "low_income_assistance_flag"
      expr: low_income_assistance_flag
      comment: "Indicates whether the tariff includes low-income assistance provisions — used for equity and regulatory compliance reporting."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the tariff became effective — used for rate history trend analysis and rate case cycle tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tariff — used for multi-currency financial consolidation."
  measures:
    - name: "total_active_tariffs"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN tariff_id END)
      comment: "Number of currently active tariffs — tracks regulatory rate schedule portfolio size for compliance and rate case management."
    - name: "total_revenue_requirement"
      expr: SUM(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement across all active tariffs — primary financial planning KPI for rate case filings and revenue adequacy assessment."
    - name: "avg_revenue_requirement"
      expr: AVG(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Average revenue requirement per tariff — used to benchmark tariff sizing and identify outliers in rate case analysis."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base across all tariffs — key regulatory finance KPI representing the asset investment base on which return is earned."
    - name: "avg_rate_of_return_percent"
      expr: AVG(CAST(rate_of_return_percent AS DOUBLE))
      comment: "Average authorized rate of return across tariffs — used by Finance and Regulatory Affairs to monitor return adequacy and investor relations."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across tariffs — used to benchmark pricing levels across rate schedules and jurisdictions."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum monthly charge across tariffs — used to assess fixed cost recovery adequacy and revenue floor stability."
    - name: "conservation_rate_tariff_count"
      expr: COUNT(CASE WHEN conservation_rate_flag = TRUE THEN tariff_id END)
      comment: "Number of tariffs with conservation rate provisions — tracks adoption of conservation-aligned pricing across the rate schedule portfolio."
    - name: "low_income_assistance_tariff_count"
      expr: COUNT(CASE WHEN low_income_assistance_flag = TRUE THEN tariff_id END)
      comment: "Number of tariffs with low-income assistance provisions — used for equity reporting and regulatory compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over service territories — tracks service area size, demand profile, customer base composition, and franchise health. Used by Executive, Regulatory Affairs, and Planning leadership for strategic growth and compliance management."
  source: "`vibe_water_utilities_v1`.`service`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., Active, Inactive, Pending) — primary segmentation for operational service area analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., Municipal, Unincorporated, Wholesale) — used to segment service obligations and regulatory requirements."
    - name: "service_classification"
      expr: service_classification
      comment: "Service classification of the territory — used for regulatory reporting and rate zone analysis."
    - name: "state_code"
      expr: state_code
      comment: "State code of the territory — used for multi-state regulatory compliance and geographic performance analysis."
    - name: "operating_division_code"
      expr: operating_division_code
      comment: "Operating division responsible for the territory — used for divisional performance benchmarking and resource allocation."
    - name: "potable_water_service_flag"
      expr: potable_water_service_flag
      comment: "Indicates whether potable water service is provided — used to segment territories by service type for capacity and compliance planning."
    - name: "recycled_water_service_flag"
      expr: recycled_water_service_flag
      comment: "Indicates whether recycled water service is provided — used to track water reuse program coverage and regulatory compliance."
    - name: "wastewater_service_flag"
      expr: wastewater_service_flag
      comment: "Indicates whether wastewater service is provided — used to segment integrated utility territories for cost allocation."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the territory became effective — used for franchise history and service area expansion trend analysis."
    - name: "rate_zone_code"
      expr: rate_zone_code
      comment: "Rate zone assigned to the territory — used for pricing equity analysis across service areas."
  measures:
    - name: "total_active_territories"
      expr: COUNT(CASE WHEN territory_status = 'Active' THEN territory_id END)
      comment: "Number of currently active service territories — tracks geographic service footprint for strategic planning and regulatory reporting."
    - name: "total_service_area_square_miles"
      expr: SUM(CAST(area_square_miles AS DOUBLE))
      comment: "Total service area in square miles across all territories — primary geographic scale KPI for infrastructure planning and franchise management."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand in million gallons per day across all territories — primary system-wide demand KPI for treatment and distribution capacity planning."
    - name: "total_peak_daily_demand_mgd"
      expr: SUM(CAST(peak_daily_demand_mgd AS DOUBLE))
      comment: "Total peak daily demand in MGD across all territories — critical infrastructure sizing KPI for capital investment and drought resilience planning."
    - name: "avg_average_daily_demand_mgd"
      expr: AVG(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Average daily demand per territory in MGD — used to benchmark territory-level demand and identify high-growth or high-stress service areas."
    - name: "recycled_water_territory_count"
      expr: COUNT(CASE WHEN recycled_water_service_flag = TRUE THEN territory_id END)
      comment: "Number of territories with recycled water service — tracks water reuse program geographic coverage for regulatory and sustainability reporting."
    - name: "wastewater_territory_count"
      expr: COUNT(CASE WHEN wastewater_service_flag = TRUE THEN territory_id END)
      comment: "Number of territories with wastewater service — used for integrated utility service scope analysis and cost allocation."
    - name: "avg_area_square_miles"
      expr: AVG(CAST(area_square_miles AS DOUBLE))
      comment: "Average territory size in square miles — used to benchmark territory scale and identify consolidation or expansion opportunities."
$$;