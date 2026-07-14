-- Metric views for domain: store | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_profit_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store-level profit and loss metrics covering revenue, margin, cost structure, and operational efficiency. Primary financial steering dashboard for store operations leadership."
  source: "`vibe_retail_v1`.`store`.`store_profit_loss`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location identifier for store-level P&L analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department identifier enabling department-level profitability drill-down."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Financial period identifier for period-over-period trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reporting normalization."
    - name: "comp_sales_flag"
      expr: comp_sales_flag
      comment: "Comparable store sales flag distinguishing comp vs. non-comp stores for like-for-like analysis."
    - name: "pl_status"
      expr: pl_status
      comment: "P&L record status (e.g., draft, finalized) for filtering to approved financial data."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Period start date truncated to month for monthly trend reporting."
    - name: "reporting_entity"
      expr: reporting_entity
      comment: "Reporting entity identifier for multi-entity consolidated views."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue before deductions. Primary top-line revenue KPI for store performance reviews."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after returns and discounts. Core revenue measure used in comp-store and financial reporting."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars. Measures profitability after cost of goods sold across stores."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across store-period records. Key profitability rate metric for category and store benchmarking."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Drives gross margin analysis and procurement efficiency evaluation."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost. Critical for store operating expense management and labor productivity analysis."
    - name: "total_shrinkage"
      expr: SUM(CAST(shrinkage_amount AS DOUBLE))
      comment: "Total shrinkage loss amount. Directly impacts gross margin and triggers loss prevention interventions."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA. Primary operating profitability measure used in board-level store performance reviews."
    - name: "avg_ebitda_percent"
      expr: AVG(CAST(ebitda_percent AS DOUBLE))
      comment: "Average EBITDA margin percentage. Benchmarks store operational efficiency against targets and peers."
    - name: "total_occupancy_cost"
      expr: SUM(CAST(occupancy_cost_amount AS DOUBLE))
      comment: "Total occupancy cost (rent, utilities, etc.). Key fixed cost driver for store profitability and lease renegotiation decisions."
    - name: "total_discounts"
      expr: SUM(CAST(discounts_amount AS DOUBLE))
      comment: "Total discount amount applied. Measures promotional spend impact on net revenue."
    - name: "total_returns"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total returns value. Elevated returns signal product quality or customer experience issues requiring action."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing expense at store level. Used to evaluate local marketing ROI against sales lift."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses. Comprehensive cost base for store-level operating leverage analysis."
    - name: "avg_transaction_value"
      expr: AVG(CAST(atv_amount AS DOUBLE))
      comment: "Average transaction value (ATV). Key basket-size KPI used to evaluate upsell and cross-sell effectiveness."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(upt AS DOUBLE))
      comment: "Average units per transaction (UPT). Measures basket depth and is a leading indicator of cross-sell performance."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold. Volume metric used for inventory planning and sales velocity analysis."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions. Footfall-to-transaction conversion baseline for store traffic analysis."
    - name: "avg_comp_sales_growth_percent"
      expr: AVG(CAST(comp_sales_growth_percent AS DOUBLE))
      comment: "Average comparable store sales growth percentage. The primary like-for-like growth KPI reported to investors and the board."
    - name: "total_depreciation"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation charge. Required for EBIT calculation and capital investment payback analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_comparable_sales`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparable store sales performance metrics tracking like-for-like growth, traffic conversion, and basket metrics across stores and periods. Core retail KPI set for executive and investor reporting."
  source: "`vibe_retail_v1`.`store`.`comparable_sales`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location identifier for store-level comp sales analysis."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Financial period for period-over-period comp sales trending."
    - name: "format_id"
      expr: format_id
      comment: "Store format identifier for format-level comp sales benchmarking."
    - name: "comp_store_qualification_status"
      expr: comp_store_qualification_status
      comment: "Comp store qualification status to filter to qualified comp stores only."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Reporting period type (weekly, monthly, quarterly) for appropriate time-grain analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual comp sales trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year comp sales tracking."
    - name: "reporting_region"
      expr: reporting_region
      comment: "Reporting region for regional comp sales performance comparison."
    - name: "reporting_district"
      expr: reporting_district
      comment: "Reporting district for district-level comp sales management."
    - name: "remodel_flag"
      expr: remodel_flag
      comment: "Remodel flag to isolate or exclude recently remodeled stores from comp analysis."
    - name: "closure_flag"
      expr: closure_flag
      comment: "Closure flag to exclude temporarily closed stores from comp calculations."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period start date truncated to month for time-series analysis."
  measures:
    - name: "avg_comp_sales_growth_rate"
      expr: AVG(CAST(comp_sales_growth_rate AS DOUBLE))
      comment: "Average comparable store sales growth rate. The headline retail KPI reported to investors and used in quarterly business reviews."
    - name: "total_comp_sales_variance"
      expr: SUM(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Total comparable sales variance in currency. Quantifies the absolute dollar gap between current and prior period for budget reconciliation."
    - name: "avg_comp_sales_variance_percent"
      expr: AVG(CAST(comp_sales_variance_percent AS DOUBLE))
      comment: "Average comparable sales variance percentage. Normalized growth rate for cross-store and cross-format benchmarking."
    - name: "total_current_period_net_sales"
      expr: SUM(CAST(current_period_net_sales AS DOUBLE))
      comment: "Total current period net sales across comp stores. Baseline revenue measure for comp store cohort."
    - name: "total_prior_period_net_sales"
      expr: SUM(CAST(prior_period_net_sales AS DOUBLE))
      comment: "Total prior period net sales for the same comp store cohort. Denominator basis for growth rate validation."
    - name: "total_current_period_footfall"
      expr: SUM(CAST(current_period_footfall AS DOUBLE))
      comment: "Total current period customer footfall. Traffic volume KPI driving conversion and basket analysis."
    - name: "total_prior_period_footfall"
      expr: SUM(CAST(prior_period_footfall AS DOUBLE))
      comment: "Total prior period footfall for year-over-year traffic trend analysis."
    - name: "avg_current_conversion_rate"
      expr: AVG(CAST(current_period_conversion_rate AS DOUBLE))
      comment: "Average current period traffic-to-transaction conversion rate. Measures store effectiveness at converting visitors to buyers."
    - name: "avg_prior_conversion_rate"
      expr: AVG(CAST(prior_period_conversion_rate AS DOUBLE))
      comment: "Average prior period conversion rate for year-over-year conversion trend analysis."
    - name: "avg_current_atv"
      expr: AVG(CAST(current_period_atv AS DOUBLE))
      comment: "Average current period average transaction value. Basket size KPI for upsell and promotional effectiveness."
    - name: "avg_prior_atv"
      expr: AVG(CAST(prior_period_atv AS DOUBLE))
      comment: "Average prior period ATV for basket size trend comparison."
    - name: "avg_current_upt"
      expr: AVG(CAST(current_period_upt AS DOUBLE))
      comment: "Average current period units per transaction. Measures cross-sell depth and assortment effectiveness."
    - name: "total_current_units_sold"
      expr: SUM(CAST(current_period_units_sold AS DOUBLE))
      comment: "Total current period units sold across comp stores. Volume metric for inventory and replenishment planning."
    - name: "avg_sales_per_sqft"
      expr: AVG(CAST(sales_per_sqft AS DOUBLE))
      comment: "Average sales per square foot. Space productivity KPI used for store format investment and lease decisions."
    - name: "comp_store_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct comp-qualified store locations in the reporting cohort. Denominator context for all comp averages."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store traffic and conversion metrics measuring customer footfall, dwell time, and conversion rates. Drives staffing, layout, and promotional effectiveness decisions."
  source: "`vibe_retail_v1`.`store`.`traffic_count`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location for store-level traffic analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for zone-level traffic analysis within stores."
    - name: "zone_type"
      expr: zone_type
      comment: "Zone type (entrance, department, checkout) for traffic flow pattern analysis."
    - name: "counting_zone_code"
      expr: counting_zone_code
      comment: "Specific counting zone code for granular traffic sensor analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekly traffic pattern and staffing optimization."
    - name: "hour_of_day"
      expr: hour_of_day
      comment: "Hour of day for intraday traffic pattern and peak staffing analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag to isolate holiday traffic patterns for seasonal planning."
    - name: "is_promotional_event"
      expr: is_promotional_event
      comment: "Promotional event flag to measure promotional traffic lift."
    - name: "is_store_open"
      expr: is_store_open
      comment: "Store open flag to filter to valid trading hours for accurate conversion calculations."
    - name: "sensor_type"
      expr: sensor_type
      comment: "Sensor technology type for data quality stratification."
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Measurement date truncated to day for daily traffic trend analysis."
    - name: "measurement_week"
      expr: DATE_TRUNC('week', measurement_timestamp)
      comment: "Measurement week for weekly traffic trend reporting."
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code to analyze weather impact on store traffic."
  measures:
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average traffic-to-transaction conversion rate. Core store effectiveness KPI — low conversion triggers layout, staffing, or assortment interventions."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(average_dwell_time_minutes AS DOUBLE))
      comment: "Average customer dwell time in minutes. Longer dwell correlates with higher basket size; used to evaluate store layout and engagement."
    - name: "avg_accuracy_confidence"
      expr: AVG(CAST(accuracy_confidence_percent AS DOUBLE))
      comment: "Average sensor accuracy confidence percentage. Data quality KPI ensuring traffic counts are reliable for decision-making."
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average in-store temperature. Operational compliance metric for temperature-sensitive departments and customer comfort."
    - name: "traffic_observation_count"
      expr: COUNT(1)
      comment: "Total number of traffic measurement observations. Volume baseline for statistical reliability of traffic averages."
    - name: "high_quality_reading_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of high-quality traffic readings passing data quality checks. Used to assess sensor reliability and data trustworthiness."
    - name: "promotional_event_observation_count"
      expr: COUNT(CASE WHEN is_promotional_event = TRUE THEN 1 END)
      comment: "Count of traffic observations during promotional events. Baseline for measuring promotional traffic lift."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_shrinkage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store shrinkage and loss prevention metrics tracking retail value lost, recovery rates, and shrinkage patterns by type and location. Critical for loss prevention investment decisions."
  source: "`vibe_retail_v1`.`store`.`shrinkage_event`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location for store-level shrinkage benchmarking and hotspot identification."
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for department-level shrinkage analysis."
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Shrinkage type (theft, administrative error, vendor fraud, damage) for root cause analysis."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Responsible party type (internal, external, vendor) for targeted loss prevention strategy."
    - name: "detection_method"
      expr: detection_method
      comment: "Detection method (CCTV, inventory count, POS exception) for evaluating detection effectiveness."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status for tracking open vs. closed shrinkage cases."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period shrinkage trend analysis."
    - name: "incident_report_filed"
      expr: incident_report_filed
      comment: "Incident report filed flag for compliance and audit tracking."
    - name: "event_date_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Event date truncated to month for monthly shrinkage trend reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency shrinkage reporting."
  measures:
    - name: "total_retail_value_lost"
      expr: SUM(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Total retail value lost to shrinkage. Primary loss prevention KPI directly impacting gross margin and triggering security investment decisions."
    - name: "total_cost_value_lost"
      expr: SUM(CAST(cost_value_lost AS DOUBLE))
      comment: "Total cost value lost to shrinkage. Cost-basis shrinkage measure for P&L impact quantification."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from shrinkage events. Measures effectiveness of loss prevention and recovery programs."
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total units lost to shrinkage. Volume metric for inventory accuracy and replenishment impact assessment."
    - name: "shrinkage_event_count"
      expr: COUNT(1)
      comment: "Total number of shrinkage events recorded. Frequency metric for loss prevention resource allocation."
    - name: "avg_unit_retail_value"
      expr: AVG(CAST(unit_retail_value AS DOUBLE))
      comment: "Average retail value per unit lost. Identifies high-value shrinkage items requiring enhanced security measures."
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct store locations with shrinkage events. Measures breadth of shrinkage exposure across the estate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store audit compliance metrics tracking audit scores, findings, pass/fail rates, and corrective action status. Drives compliance investment and regulatory risk management decisions."
  source: "`vibe_retail_v1`.`store`.`audit`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location for store-level compliance benchmarking."
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for department-level audit performance analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type (food safety, fire safety, operational, regulatory) for type-specific compliance tracking."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Auditor type (internal, external, regulatory) for distinguishing self-assessment from third-party compliance."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Audit pass/fail status for compliance rate calculation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status for tracking open corrective actions."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating corrective action is required — used to prioritize follow-up resource allocation."
    - name: "citation_issued_flag"
      expr: citation_issued_flag
      comment: "Citation issued flag for regulatory risk exposure tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual compliance trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly compliance review reporting."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Audit date truncated to month for monthly compliance trend reporting."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency conducting the audit for agency-specific compliance tracking."
  measures:
    - name: "avg_overall_score_percent"
      expr: AVG(CAST(overall_score_percent AS DOUBLE))
      comment: "Average audit overall score percentage. Primary compliance quality KPI used in operational steering reviews and regulatory reporting."
    - name: "avg_previous_audit_score_percent"
      expr: AVG(CAST(previous_audit_score_percent AS DOUBLE))
      comment: "Average prior audit score for trend comparison and improvement tracking."
    - name: "avg_score_variance_percent"
      expr: AVG(CAST(score_variance_percent AS DOUBLE))
      comment: "Average score variance between current and prior audit. Positive trend indicates compliance improvement; negative triggers intervention."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total regulatory fine amount. Financial risk KPI for compliance investment justification and regulatory exposure management."
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Coverage metric ensuring audit frequency meets regulatory and internal requirements."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END)
      comment: "Count of audits with passing status. Numerator for compliance pass rate calculation."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of audits requiring corrective action. Workload metric for compliance remediation resource planning."
    - name: "citation_issued_count"
      expr: COUNT(CASE WHEN citation_issued_flag = TRUE THEN 1 END)
      comment: "Count of audits resulting in regulatory citations. Regulatory risk exposure metric triggering escalation to legal and compliance teams."
    - name: "distinct_audited_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct store locations audited. Coverage metric for audit program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_remodel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store remodel capital investment metrics tracking spend, ROI projections, schedule adherence, and format change outcomes. Drives capital allocation and store investment decisions."
  source: "`vibe_retail_v1`.`store`.`remodel`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location for store-level capital investment tracking."
    - name: "department_id"
      expr: department_id
      comment: "Department impacted by the remodel for department-level investment analysis."
    - name: "remodel_type"
      expr: remodel_type
      comment: "Remodel type (full, partial, refresh, technology) for investment category analysis."
    - name: "project_status"
      expr: project_status
      comment: "Project status for pipeline and completion tracking."
    - name: "format_change_flag"
      expr: format_change_flag
      comment: "Format change flag to isolate format conversion remodels for strategic impact analysis."
    - name: "temporary_closure_flag"
      expr: temporary_closure_flag
      comment: "Temporary closure flag to quantify sales disruption from remodel closures."
    - name: "comp_sales_exclusion_flag"
      expr: comp_sales_exclusion_flag
      comment: "Comp sales exclusion flag to track remodel impact on comparable store base."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start date truncated to month for capital expenditure phasing analysis."
    - name: "actual_completion_date_month"
      expr: DATE_TRUNC('month', actual_completion_date)
      comment: "Actual completion date truncated to month for delivery schedule analysis."
  measures:
    - name: "total_capital_budget"
      expr: SUM(CAST(capital_budget_amount AS DOUBLE))
      comment: "Total approved capital budget for remodels. Primary capital planning KPI for CFO and real estate investment decisions."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capital spend on remodels. Tracks budget utilization and identifies cost overruns requiring executive action."
    - name: "avg_roi_projection_percent"
      expr: AVG(CAST(roi_projection_percent AS DOUBLE))
      comment: "Average projected ROI percentage for remodel investments. Core capital allocation metric for prioritizing store investment pipeline."
    - name: "remodel_project_count"
      expr: COUNT(1)
      comment: "Total number of remodel projects. Pipeline volume metric for capital program management."
    - name: "format_change_count"
      expr: COUNT(CASE WHEN format_change_flag = TRUE THEN 1 END)
      comment: "Count of remodels involving a format change. Strategic transformation metric for store portfolio evolution tracking."
    - name: "temporary_closure_count"
      expr: COUNT(CASE WHEN temporary_closure_flag = TRUE THEN 1 END)
      comment: "Count of remodels requiring temporary store closure. Measures sales disruption risk in the remodel pipeline."
    - name: "distinct_remodeled_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct store locations undergoing remodel. Measures breadth of capital investment program across the estate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_direct_store_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct store delivery (DSD) receiving metrics tracking delivery compliance, cost variances, quantity accuracy, and vendor performance. Drives vendor management and receiving efficiency decisions."
  source: "`vibe_retail_v1`.`store`.`direct_store_delivery`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location for store-level DSD receiving performance analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department receiving the delivery for department-level vendor compliance tracking."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier for vendor-level delivery performance benchmarking."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Receipt status (accepted, rejected, partial) for delivery acceptance rate analysis."
    - name: "invoice_match_status"
      expr: invoice_match_status
      comment: "Invoice match status for accounts payable accuracy and chargeback management."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "On-time delivery flag for vendor delivery compliance tracking."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for identifying unresolved delivery discrepancies."
    - name: "scan_based_trading_flag"
      expr: scan_based_trading_flag
      comment: "Scan-based trading flag to segment DSD by trading model for cost analysis."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Receipt date truncated to month for monthly DSD volume and compliance trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency cost variance reporting."
  measures:
    - name: "total_cost_invoiced"
      expr: SUM(CAST(total_cost_invoiced AS DOUBLE))
      comment: "Total cost invoiced by vendors for DSD deliveries. Accounts payable baseline for vendor spend management."
    - name: "total_cost_received"
      expr: SUM(CAST(total_cost_received AS DOUBLE))
      comment: "Total cost of goods actually received. Compared against invoiced cost to identify billing discrepancies."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance between invoiced and received amounts. Drives chargeback and vendor compliance actions."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount issued to vendors. Measures vendor compliance cost recovery and contract enforcement effectiveness."
    - name: "total_quantity_invoiced"
      expr: SUM(CAST(total_quantity_invoiced AS DOUBLE))
      comment: "Total quantity invoiced by vendors. Volume baseline for quantity variance analysis."
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Compared against invoiced quantity to identify short shipments."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between invoiced and received. Measures vendor fill rate accuracy and inventory impact."
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Total number of DSD deliveries. Volume metric for receiving labor planning and vendor activity tracking."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN on_time_delivery_flag = TRUE THEN 1 END)
      comment: "Count of on-time deliveries. Numerator for vendor on-time delivery rate calculation."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors delivering via DSD. Measures vendor base breadth for supply chain risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store cluster portfolio metrics tracking cluster composition, sales performance, and strategic characteristics. Supports assortment, pricing, and promotional strategy decisions at cluster level."
  source: "`vibe_retail_v1`.`store`.`cluster`"
  dimensions:
    - name: "cluster_type"
      expr: cluster_type
      comment: "Cluster type for segmenting clusters by strategic purpose (assortment, pricing, promotional)."
    - name: "cluster_status"
      expr: cluster_status
      comment: "Cluster status (active, inactive, under review) for filtering to active clusters."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the cluster for regional strategy alignment."
    - name: "urbanization_level"
      expr: urbanization_level
      comment: "Urbanization level (urban, suburban, rural) for demographic-based cluster strategy."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone for seasonal assortment and demand planning by cluster."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy type for cluster-level price positioning analysis."
    - name: "promotional_intensity"
      expr: promotional_intensity
      comment: "Promotional intensity level for cluster-based promotional investment decisions."
    - name: "supports_omnichannel"
      expr: supports_omnichannel
      comment: "Omnichannel capability flag for digital-physical integration strategy analysis."
    - name: "cluster_level"
      expr: cluster_level
      comment: "Cluster hierarchy level for rollup and drill-down analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Cluster effective start date truncated to year for cluster lifecycle analysis."
  measures:
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales in USD across clusters. Revenue scale metric for cluster investment prioritization."
    - name: "total_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total annual sales across all clusters. Portfolio-level revenue baseline for strategic planning."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size in square feet within clusters. Space planning metric for assortment depth and fixture investment decisions."
    - name: "cluster_count"
      expr: COUNT(1)
      comment: "Total number of store clusters. Portfolio breadth metric for cluster strategy management."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store location portfolio metrics tracking estate composition, space productivity, and operational capabilities. Supports real estate, network planning, and omnichannel strategy decisions."
  source: "`vibe_retail_v1`.`store`.`location`"
  dimensions:
    - name: "format_id"
      expr: format_id
      comment: "Store format identifier for format-level estate analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Store lifecycle status (open, closed, under construction) for active estate filtering."
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic estate distribution analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region code for regional estate composition and performance benchmarking."
    - name: "district_code"
      expr: district_code
      comment: "District code for district-level store network management."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone for seasonal demand and assortment planning by geography."
    - name: "bopis_capable"
      expr: bopis_capable
      comment: "Buy online pick up in store capability flag for omnichannel network analysis."
    - name: "sfs_capable"
      expr: sfs_capable
      comment: "Ship from store capability flag for omnichannel fulfillment network planning."
    - name: "ropis_capable"
      expr: ropis_capable
      comment: "Reserve online pick up in store capability flag for omnichannel service level analysis."
    - name: "dsd_receiving"
      expr: dsd_receiving
      comment: "Direct store delivery receiving capability flag for supply chain network design."
    - name: "staffing_model_type"
      expr: staffing_model_type
      comment: "Staffing model type for labor cost benchmarking across store formats."
    - name: "opening_date_year"
      expr: DATE_TRUNC('year', opening_date)
      comment: "Store opening date truncated to year for estate vintage analysis."
  measures:
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling square footage across the store estate. Space asset metric for productivity benchmarking and real estate portfolio management."
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store. Format sizing benchmark for new store planning and assortment depth decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total gross square footage across the estate. Real estate asset base metric for occupancy cost benchmarking."
    - name: "store_count"
      expr: COUNT(1)
      comment: "Total number of store locations. Estate size metric fundamental to all per-store productivity calculations."
    - name: "bopis_capable_store_count"
      expr: COUNT(CASE WHEN bopis_capable = TRUE THEN 1 END)
      comment: "Count of BOPIS-capable stores. Omnichannel readiness metric for digital fulfillment network investment decisions."
    - name: "sfs_capable_store_count"
      expr: COUNT(CASE WHEN sfs_capable = TRUE THEN 1 END)
      comment: "Count of ship-from-store capable locations. Last-mile fulfillment network capacity metric."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Count of distinct countries in the store estate. Geographic diversification metric for international expansion strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store planogram compliance and space productivity metrics tracking deployment rates, compliance levels, and merchandising targets. Drives visual merchandising and space management decisions."
  source: "`vibe_retail_v1`.`store`.`store_planogram`"
  dimensions:
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for department-level planogram compliance analysis."
    - name: "format_id"
      expr: format_id
      comment: "Store format for format-specific planogram strategy analysis."
    - name: "planogram_status"
      expr: planogram_status
      comment: "Planogram status (active, draft, retired) for filtering to live planograms."
    - name: "planogram_type"
      expr: planogram_type
      comment: "Planogram type for segmenting by merchandising strategy (seasonal, everyday, promotional)."
    - name: "compliance_required_flag"
      expr: compliance_required_flag
      comment: "Compliance required flag to focus analysis on mandatory planograms."
    - name: "merchandising_strategy"
      expr: merchandising_strategy
      comment: "Merchandising strategy for planogram effectiveness analysis by strategy type."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Planogram effective start date truncated to month for seasonal planogram cycle analysis."
  measures:
    - name: "avg_compliance_tolerance_percent"
      expr: AVG(CAST(compliance_tolerance_percent AS DOUBLE))
      comment: "Average compliance tolerance percentage. Measures how strictly planogram compliance is enforced across the estate."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average target GMROI (Gross Margin Return on Inventory Investment) for planograms. Space productivity target metric for category management decisions."
    - name: "avg_target_sales_per_linear_foot"
      expr: AVG(CAST(target_sales_per_linear_foot AS DOUBLE))
      comment: "Average target sales per linear foot. Space productivity benchmark for planogram design and shelf allocation decisions."
    - name: "total_linear_feet"
      expr: SUM(CAST(total_linear_feet AS DOUBLE))
      comment: "Total linear shelf feet covered by planograms. Space asset metric for merchandising capacity planning."
    - name: "planogram_count"
      expr: COUNT(1)
      comment: "Total number of planograms. Portfolio size metric for merchandising operations workload management."
    - name: "compliance_required_planogram_count"
      expr: COUNT(CASE WHEN compliance_required_flag = TRUE THEN 1 END)
      comment: "Count of planograms with mandatory compliance requirements. Scope metric for compliance audit program planning."
$$;