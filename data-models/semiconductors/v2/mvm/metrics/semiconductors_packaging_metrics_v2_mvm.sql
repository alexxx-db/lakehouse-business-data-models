-- Metric views for domain: packaging | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core assembly yield and quality metrics tracking first-pass yield, cumulative yield, DPPM, and scrap across packaging process steps"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "process_step"
      expr: process_step
      comment: "Assembly process step where yield was measured"
    - name: "yield_type"
      expr: yield_type
      comment: "Type of yield measurement (first-pass, cumulative, rework)"
    - name: "yield_category"
      expr: yield_category
      comment: "Categorical classification of yield performance"
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss for root cause analysis"
    - name: "top_defect_category"
      expr: top_defect_category
      comment: "Primary defect category driving yield loss"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped units"
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date when yield was measured"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of yield measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of yield measurement"
    - name: "step_sequence"
      expr: step_sequence
      comment: "Sequence number of the process step"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "avg_first_pass_yield_pct"
      expr: AVG(CAST(first_pass_yield_percent AS DOUBLE))
      comment: "Average first-pass yield percentage - critical quality metric for process capability"
    - name: "avg_cumulative_yield_pct"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield percentage across all process steps"
    - name: "avg_rework_yield_pct"
      expr: AVG(CAST(rework_yield_percent AS DOUBLE))
      comment: "Average rework yield percentage - measures recovery effectiveness"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average overall yield percentage"
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million - key quality metric for customer reporting"
    - name: "total_units_scrapped"
      expr: SUM(CAST(units_scrapped AS DOUBLE))
      comment: "Total units scrapped - direct cost and waste metric"
    - name: "total_input_quantity"
      expr: SUM(CAST(input_quantity AS DOUBLE))
      comment: "Total input quantity into process steps"
    - name: "total_output_quantity"
      expr: SUM(CAST(output_quantity AS DOUBLE))
      comment: "Total output quantity from process steps"
    - name: "total_loss_quantity"
      expr: SUM(CAST(loss_quantity AS DOUBLE))
      comment: "Total quantity lost in process - key efficiency metric"
    - name: "total_reject_quantity"
      expr: SUM(CAST(reject_quantity AS DOUBLE))
      comment: "Total rejected quantity - quality control metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly defect tracking and quality metrics including defect rates, DPPM, criticality, and root cause analysis"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_defect`"
  dimensions:
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect detected"
    - name: "defect_category"
      expr: defect_category
      comment: "Category classification of the defect"
    - name: "defect_code"
      expr: defect_code
      comment: "Specific defect code for tracking and analysis"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the defect"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level for prioritization"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if defect is critical"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defect (scrap, rework, use-as-is)"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the defect"
    - name: "inspection_tool"
      expr: inspection_tool
      comment: "Tool used to detect the defect"
    - name: "detected_date"
      expr: detected_date
      comment: "Date when defect was detected"
    - name: "detected_year"
      expr: YEAR(detected_date)
      comment: "Year of defect detection"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month of defect detection"
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift when defect was detected"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates if lot is on hold due to defect"
  measures:
    - name: "total_defect_records"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total count of defects detected - key quality metric"
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million - critical customer quality metric"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value for quantitative defects"
    - name: "critical_defect_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical defects requiring immediate action"
    - name: "hold_defect_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of defects resulting in lot holds - impacts throughput"
    - name: "unique_defect_types"
      expr: COUNT(DISTINCT defect_type)
      comment: "Number of unique defect types - process stability indicator"
    - name: "unique_root_causes"
      expr: COUNT(DISTINCT root_cause)
      comment: "Number of unique root causes identified"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly lot performance metrics tracking throughput, yield, cycle time, quality status, and WIP"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "assembly_lot_status"
      expr: assembly_lot_status
      comment: "Current status of the assembly lot"
    - name: "lot_status"
      expr: lot_status
      comment: "Lot status classification"
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-progress status"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the lot"
    - name: "assembly_site"
      expr: assembly_site
      comment: "Site where assembly is performed"
    - name: "current_process_step"
      expr: current_process_step
      comment: "Current process step in assembly flow"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates if lot is on hold"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for lot hold"
    - name: "start_date"
      expr: start_date
      comment: "Lot start date"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year lot started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month lot started"
    - name: "completion_date"
      expr: completion_date
      comment: "Lot completion date"
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of assembly lots"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average lot yield percentage - key manufacturing efficiency metric"
    - name: "avg_cumulative_yield_pct"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield across all process steps"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density - quality metric per unit area or volume"
    - name: "total_good_units"
      expr: SUM(CAST(good_unit_count AS DOUBLE))
      comment: "Total good units produced - primary output metric"
    - name: "total_scrap_units"
      expr: SUM(CAST(scrap_unit_count AS DOUBLE))
      comment: "Total scrapped units - waste and cost metric"
    - name: "total_reject_count"
      expr: SUM(CAST(reject_count AS DOUBLE))
      comment: "Total rejected units - quality control metric"
    - name: "total_unit_count"
      expr: SUM(CAST(unit_count AS DOUBLE))
      comment: "Total unit count processed"
    - name: "total_inspection_pass"
      expr: SUM(CAST(inspection_pass_count AS DOUBLE))
      comment: "Total units passing inspection"
    - name: "total_inspection_fail"
      expr: SUM(CAST(inspection_fail_count AS DOUBLE))
      comment: "Total units failing inspection"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost in USD - financial planning metric"
    - name: "lots_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots currently on hold - throughput blocker metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly order execution metrics tracking order fulfillment, yield performance, cost, and schedule adherence"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_order`"
  dimensions:
    - name: "assembly_order_status"
      expr: assembly_order_status
      comment: "Current status of the assembly order"
    - name: "assembly_site"
      expr: assembly_site
      comment: "Site where assembly order is executed"
    - name: "priority"
      expr: priority
      comment: "Order priority level"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for scheduling"
    - name: "order_source"
      expr: order_source
      comment: "Source system or channel of the order"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the order"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates if order is on hold"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost reporting"
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date for the order"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned start"
    - name: "completion_date"
      expr: completion_date
      comment: "Actual completion date"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of assembly orders"
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage - key performance vs plan metric"
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage - baseline for comparison"
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity - demand metric"
    - name: "total_completed_quantity"
      expr: SUM(CAST(completed_quantity AS DOUBLE))
      comment: "Total completed quantity - fulfillment metric"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defects across all orders - quality metric"
    - name: "total_cost_gross_usd"
      expr: SUM(CAST(cost_gross_amount AS DOUBLE))
      comment: "Total gross cost - financial metric before adjustments"
    - name: "total_cost_net_usd"
      expr: SUM(CAST(cost_net_amount AS DOUBLE))
      comment: "Total net cost - final financial metric after adjustments"
    - name: "total_cost_adjustment_usd"
      expr: SUM(CAST(cost_adjustment_amount AS DOUBLE))
      comment: "Total cost adjustments - variance tracking"
    - name: "orders_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders on hold - throughput blocker"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with orders"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_osat_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT vendor performance and capability metrics tracking quality ratings, DPPM, capacity, certifications, and partnership status"
  source: "`vibe_semiconductors_v1`.`packaging`.`osat_vendor`"
  dimensions:
    - name: "vendor_name"
      expr: vendor_name
      comment: "OSAT vendor name"
    - name: "vendor_code"
      expr: vendor_code
      comment: "Vendor code identifier"
    - name: "osat_vendor_status"
      expr: osat_vendor_status
      comment: "Current vendor status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Vendor qualification status"
    - name: "partnership_status"
      expr: partnership_status
      comment: "Partnership tier or status"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Vendor lifecycle status"
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier classification"
    - name: "country"
      expr: country
      comment: "Vendor country location"
    - name: "vendor_country"
      expr: vendor_country
      comment: "Vendor country for regional analysis"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if vendor is currently active"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification status"
    - name: "iatf_16949_certified"
      expr: iatf_16949_certified
      comment: "IATF 16949 automotive certification status"
    - name: "aec_q100_certified"
      expr: aec_q100_certified
      comment: "AEC-Q100 automotive qualification status"
    - name: "nda_ip_protection"
      expr: nda_ip_protection
      comment: "NDA and IP protection in place"
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total number of OSAT vendors"
    - name: "active_vendors"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active vendors - supply chain breadth metric"
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average vendor quality rating - key supplier performance metric"
    - name: "avg_scorecard_rating"
      expr: AVG(CAST(scorecard_rating AS DOUBLE))
      comment: "Average vendor scorecard rating - overall performance metric"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score - compliance and capability metric"
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average defects per million rate - critical quality metric for vendor selection"
    - name: "total_capacity_units_per_month"
      expr: SUM(CAST(capacity_units_per_month AS DOUBLE))
      comment: "Total monthly capacity across all vendors - supply chain capacity planning metric"
    - name: "iso_certified_vendors"
      expr: SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISO 9001 certified vendors"
    - name: "automotive_certified_vendors"
      expr: SUM(CASE WHEN iatf_16949_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of IATF 16949 certified vendors - automotive supply chain metric"
    - name: "aec_qualified_vendors"
      expr: SUM(CASE WHEN aec_q100_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of AEC-Q100 qualified vendors - automotive reliability metric"
    - name: "ip_protected_vendors"
      expr: SUM(CASE WHEN nda_ip_protection = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with IP protection - risk management metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package qualification program metrics tracking qualification status, test results, yield, cost, and compliance"
  source: "`vibe_semiconductors_v1`.`packaging`.`package_qualification`"
  dimensions:
    - name: "package_qualification_status"
      expr: package_qualification_status
      comment: "Current qualification status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification program status"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, etc.)"
    - name: "qualification_method"
      expr: qualification_method
      comment: "Method used for qualification"
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Industry standard applied (JEDEC, AEC, etc.)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass/fail result of qualification"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification"
    - name: "regulatory_compliance"
      expr: regulatory_compliance
      comment: "Regulatory compliance status"
    - name: "test_location"
      expr: test_location
      comment: "Location where qualification testing performed"
    - name: "external_audit_required"
      expr: external_audit_required
      comment: "Indicates if external audit is required"
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of qualification"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned qualification start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned qualification start"
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of qualification programs"
    - name: "passed_qualifications"
      expr: SUM(CASE WHEN pass_fail_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of passed qualifications - success rate metric"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage during qualification - process capability metric"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours - cycle time metric"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "total_qualification_cost_usd"
      expr: SUM(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Total qualification cost in USD - investment metric for new product introduction"
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity tested"
    - name: "external_audit_required_count"
      expr: SUM(CASE WHEN external_audit_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of qualifications requiring external audit - compliance metric"
    - name: "unique_qualification_standards"
      expr: COUNT(DISTINCT qualification_standard)
      comment: "Number of unique qualification standards applied"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package type portfolio metrics tracking technology capabilities, compliance, thermal performance, and lifecycle status"
  source: "`vibe_semiconductors_v1`.`packaging`.`package_type`"
  dimensions:
    - name: "package_name"
      expr: package_name
      comment: "Package type name"
    - name: "package_code"
      expr: package_code
      comment: "Package type code identifier"
    - name: "package_family"
      expr: package_family
      comment: "Package family classification"
    - name: "package_category"
      expr: package_category
      comment: "Package category"
    - name: "package_type_status"
      expr: package_type_status
      comment: "Current status of package type"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status (active, obsolete, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate technology type"
    - name: "is_advanced_package"
      expr: is_advanced_package
      comment: "Indicates if this is an advanced packaging technology"
    - name: "is_flip_chip"
      expr: is_flip_chip
      comment: "Indicates flip-chip technology"
    - name: "is_wire_bond"
      expr: is_wire_bond
      comment: "Indicates wire-bond technology"
    - name: "is_3d_ic"
      expr: is_3d_ic
      comment: "Indicates 3D IC stacking technology"
    - name: "is_heterogeneous_integration"
      expr: is_heterogeneous_integration
      comment: "Indicates heterogeneous integration capability"
    - name: "is_rohs_compliant"
      expr: is_rohs_compliant
      comment: "RoHS compliance status"
    - name: "is_reach_compliant"
      expr: is_reach_compliant
      comment: "REACH compliance status"
    - name: "lead_free"
      expr: lead_free
      comment: "Lead-free status"
    - name: "halogen_free"
      expr: halogen_free
      comment: "Halogen-free status"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "Moisture sensitivity level (MSL)"
  measures:
    - name: "total_package_types"
      expr: COUNT(1)
      comment: "Total number of package types in portfolio"
    - name: "advanced_package_count"
      expr: SUM(CASE WHEN is_advanced_package = TRUE THEN 1 ELSE 0 END)
      comment: "Count of advanced packaging technologies - innovation metric"
    - name: "flip_chip_package_count"
      expr: SUM(CASE WHEN is_flip_chip = TRUE THEN 1 ELSE 0 END)
      comment: "Count of flip-chip packages"
    - name: "three_d_ic_package_count"
      expr: SUM(CASE WHEN is_3d_ic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of 3D IC packages - advanced technology metric"
    - name: "heterogeneous_integration_count"
      expr: SUM(CASE WHEN is_heterogeneous_integration = TRUE THEN 1 ELSE 0 END)
      comment: "Count of heterogeneous integration packages - chiplet strategy metric"
    - name: "rohs_compliant_count"
      expr: SUM(CASE WHEN is_rohs_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RoHS compliant packages - regulatory compliance metric"
    - name: "reach_compliant_count"
      expr: SUM(CASE WHEN is_reach_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of REACH compliant packages - EU compliance metric"
    - name: "avg_thermal_resistance_ja"
      expr: AVG(CAST(thermal_resistance_ja AS DOUBLE))
      comment: "Average junction-to-ambient thermal resistance - thermal performance metric"
    - name: "avg_max_power_dissipation_w"
      expr: AVG(CAST(max_power_dissipation_w AS DOUBLE))
      comment: "Average maximum power dissipation in watts - power capability metric"
    - name: "avg_package_height_mm"
      expr: AVG(CAST(package_height_mm AS DOUBLE))
      comment: "Average package height in mm - form factor metric"
    - name: "avg_pitch_mm"
      expr: AVG(CAST(pitch_mm AS DOUBLE))
      comment: "Average pin pitch in mm - density metric"
    - name: "unique_package_families"
      expr: COUNT(DISTINCT package_family)
      comment: "Number of unique package families - portfolio breadth metric"
$$;