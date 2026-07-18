-- Metric views for domain: packaging | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks assembly packaging yield performance at the step level — the primary operational KPI for packaging line efficiency, scrap management, and process quality steering."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "process_step"
      expr: process_step
      comment: "Assembly process step name for yield breakdown by step — identifies which step is the yield detractor."
    - name: "assembly_yield_status"
      expr: assembly_yield_status
      comment: "Current status of the yield record (e.g. confirmed, provisional) for filtering active vs. draft data."
    - name: "step_sequence"
      expr: step_sequence
      comment: "Ordered sequence of the step within the assembly flow — enables waterfall yield analysis."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped units — drives Pareto analysis of top scrap drivers."
    - name: "step_date"
      expr: DATE_TRUNC('day', step_start_timestamp)
      comment: "Calendar day the step started — enables daily yield trend analysis."
    - name: "step_week"
      expr: DATE_TRUNC('week', step_start_timestamp)
      comment: "ISO week the step started — enables weekly yield trend reporting."
    - name: "step_month"
      expr: DATE_TRUNC('month', step_start_timestamp)
      comment: "Calendar month the step started — enables monthly yield trend reporting."
  measures:
    - name: "avg_step_yield_pct"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average step-level yield percentage — primary KPI for packaging process efficiency; a drop triggers immediate process investigation."
    - name: "avg_cumulative_yield_pct"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield through all steps — reflects end-to-end packaging efficiency and directly impacts cost of goods."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million units at the step level — key quality KPI used in customer scorecards and supplier negotiations."
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records — baseline volume metric for normalizing other KPIs."
    - name: "min_step_yield_pct"
      expr: MIN(yield_percent)
      comment: "Worst-case step yield observed — identifies the floor of process performance and flags outlier events requiring root cause."
    - name: "max_dppm"
      expr: MAX(dppm)
      comment: "Peak DPPM observed — flags worst-quality events for escalation and corrective action prioritization."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks packaging assembly defects at the unit level — drives quality root-cause analysis, CAPA prioritization, and DPPM reporting to customers."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_defect`"
  dimensions:
    - name: "defect_type"
      expr: defect_type
      comment: "Classification of the defect type (e.g. wire bond open, delamination) — primary dimension for Pareto defect analysis."
    - name: "defect_category"
      expr: defect_category
      comment: "Broader defect category grouping — enables roll-up analysis across defect families."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the defect — drives prioritization of corrective actions and customer escalation decisions."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the defective unit (scrap, rework, use-as-is) — informs cost impact and yield loss calculations."
    - name: "assembly_defect_status"
      expr: assembly_defect_status
      comment: "Current status of the defect record — filters open vs. closed defects for active quality management."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the defect is safety- or reliability-critical — used to escalate critical defects to executive review."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the associated lot is on hold due to this defect — operational flag for WIP management."
    - name: "detection_date"
      expr: DATE_TRUNC('day', detection_timestamp)
      comment: "Day the defect was detected — enables daily defect trend monitoring."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month the defect was detected — enables monthly defect trend and MoM comparison."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification of the defect — drives process improvement prioritization."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the defect was detected — identifies shift-level quality variation."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records — baseline defect volume KPI for trend and Pareto analysis."
    - name: "critical_defect_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of safety- or reliability-critical defects — executive-level quality risk indicator; any increase triggers immediate escalation."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM across defect records — primary customer-facing quality KPI; drives supplier scorecards and contract compliance."
    - name: "max_dppm"
      expr: MAX(dppm)
      comment: "Peak DPPM observed — identifies worst-case quality events for root-cause prioritization."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured defect dimension/value — tracks whether defect magnitudes are trending toward spec limits."
    - name: "held_lot_defect_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of defect records associated with lots currently on hold — quantifies WIP at risk and drives hold resolution urgency."
    - name: "distinct_lots_with_defects"
      expr: COUNT(DISTINCT assembly_lot_id)
      comment: "Number of distinct assembly lots affected by defects — measures breadth of quality impact across the production population."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks assembly lot lifecycle, yield, cost, and quality status — the central operational KPI hub for packaging throughput, WIP management, and cost performance."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the assembly lot (e.g. in-process, complete, scrapped) — primary WIP management dimension."
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-process status of the lot — enables granular WIP tracking across packaging stages."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition of the lot — drives release-to-ship decisions and customer delivery commitments."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is on hold — critical operational flag for WIP at risk and delivery risk management."
    - name: "assembly_site"
      expr: assembly_site
      comment: "Physical assembly site where the lot is being processed — enables site-level performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost estimates — required for multi-currency financial reporting."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the lot was started — enables monthly throughput and cycle time trend analysis."
    - name: "target_completion_month"
      expr: DATE_TRUNC('month', target_completion_date)
      comment: "Target completion month — enables on-time delivery performance analysis."
    - name: "current_process_step"
      expr: current_process_step
      comment: "Current process step the lot is at — enables WIP distribution analysis across the packaging flow."
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of assembly lots — baseline throughput volume KPI for capacity and demand planning."
    - name: "lots_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently on hold — measures WIP at risk; a rising hold count signals quality or supply chain issues requiring executive attention."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots on hold — normalized hold rate for cross-site and cross-period comparison; drives escalation thresholds."
    - name: "avg_cumulative_yield_pct"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average end-to-end cumulative yield across lots — primary packaging efficiency KPI directly tied to cost of goods sold."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across assembly lots — quality KPI used in process capability assessments and customer reporting."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated packaging cost across all lots — financial KPI for cost center budgeting and variance analysis."
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate per assembly lot — unit economics KPI for standard cost validation and pricing decisions."
    - name: "distinct_active_lots"
      expr: COUNT(DISTINCT CASE WHEN lot_status NOT IN ('complete', 'scrapped', 'cancelled') THEN assembly_lot_id END)
      comment: "Number of distinct lots currently active in the packaging pipeline — WIP inventory count for capacity and delivery planning."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks assembly order performance including cost, yield, and fulfillment status — the primary financial and operational KPI view for packaging order management."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_order`"
  dimensions:
    - name: "assembly_order_status"
      expr: assembly_order_status
      comment: "Current status of the assembly order — primary dimension for order pipeline and fulfillment analysis."
    - name: "assembly_site"
      expr: assembly_site
      comment: "Physical site executing the assembly order — enables site-level order performance benchmarking."
    - name: "order_source"
      expr: order_source
      comment: "Origin of the order (e.g. customer pull, forecast) — informs demand planning and order mix analysis."
    - name: "priority"
      expr: priority
      comment: "Order priority level — enables prioritized WIP management and on-time delivery analysis by priority tier."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the order is on hold — flags orders at risk of missing delivery commitments."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the order — drives quality gate release decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of order cost values — required for multi-currency financial consolidation."
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the order was released to production — enables monthly order intake and throughput trend analysis."
    - name: "target_ship_month"
      expr: DATE_TRUNC('month', target_ship_date)
      comment: "Target ship month — enables on-time delivery performance analysis by period."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the order was completed — enables actual throughput trend analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of assembly orders — baseline volume KPI for capacity utilization and demand planning."
    - name: "total_gross_cost"
      expr: SUM(CAST(cost_gross_amount AS DOUBLE))
      comment: "Total gross packaging cost across all orders — primary financial KPI for cost center budgeting and P&L reporting."
    - name: "total_net_cost"
      expr: SUM(CAST(cost_net_amount AS DOUBLE))
      comment: "Total net packaging cost after adjustments — used for actual cost reporting and margin analysis."
    - name: "total_cost_adjustment"
      expr: SUM(CAST(cost_adjustment_amount AS DOUBLE))
      comment: "Total cost adjustments applied to orders — tracks rework, scrap, and exception costs; a rising value signals process instability."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across assembly orders — primary packaging efficiency KPI; gap vs. expected yield drives cost variance."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage — baseline for yield variance analysis and process capability assessment."
    - name: "yield_gap_pct"
      expr: ROUND(AVG(CAST(expected_yield_percent AS DOUBLE)) - AVG(CAST(actual_yield_percent AS DOUBLE)), 2)
      comment: "Average gap between expected and actual yield — quantifies yield underperformance; directly tied to cost overruns and customer delivery shortfalls."
    - name: "orders_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of orders currently on hold — measures order pipeline at risk; drives escalation and expedite decisions."
    - name: "avg_net_cost_per_order"
      expr: AVG(CAST(cost_net_amount AS DOUBLE))
      comment: "Average net cost per assembly order — unit economics KPI for standard cost validation and pricing model calibration."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks package qualification status, cycle time, cost, and yield outcomes — drives qualification pipeline management, compliance readiness, and new product introduction decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`package_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g. in-progress, passed, failed) — primary dimension for qualification pipeline management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. initial, re-qualification, reliability) — enables analysis by qualification category."
    - name: "qualification_method"
      expr: qualification_method
      comment: "Method used for qualification — informs process standardization and method effectiveness analysis."
    - name: "qualification_result"
      expr: qualification_result
      comment: "Final result of the qualification (pass/fail) — primary outcome dimension for qualification success rate analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the qualification — enables risk-stratified pipeline management and resource prioritization."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the qualification meets compliance requirements — flags non-compliant qualifications for regulatory risk management."
    - name: "external_audit_required"
      expr: external_audit_required
      comment: "Indicates whether an external audit is required — drives audit scheduling and resource planning."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of qualification approval — enables monthly qualification throughput trend analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the qualification became effective — tracks qualification pipeline velocity."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of package qualifications — baseline pipeline volume KPI for NPI and capacity planning."
    - name: "qualification_pass_count"
      expr: COUNT(CASE WHEN qualification_result = 'pass' THEN 1 END)
      comment: "Number of qualifications that passed — measures qualification throughput and NPI readiness."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed — primary quality KPI for the qualification process; a declining rate signals systemic packaging or design issues."
    - name: "avg_qualification_cost_usd"
      expr: AVG(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Average cost per package qualification — financial KPI for NPI cost management and budget planning."
    - name: "total_qualification_cost_usd"
      expr: SUM(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Total spend on package qualifications — financial KPI for R&D and NPI cost center reporting."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield achieved during qualification — predicts production yield and informs go/no-go decisions for mass production."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average qualification test duration in hours — cycle time KPI for NPI schedule management; long durations delay product launches."
    - name: "compliance_qualified_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of qualifications meeting compliance requirements — regulatory readiness KPI for export control and customer compliance reporting."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_reliability_stress_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks reliability stress test outcomes, failure rates, and MTTF — the primary KPI view for product reliability assurance, customer warranty risk, and qualification gate decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`reliability_stress_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability stress test (e.g. HTOL, HAST, TC) — primary dimension for reliability analysis by test category."
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard governing the test (e.g. JEDEC, AEC-Q100) — enables compliance-based reliability reporting."
    - name: "reliability_stress_test_status"
      expr: reliability_stress_test_status
      comment: "Current status of the stress test — filters active vs. completed tests for pipeline management."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the test (pass/fail/conditional) — primary outcome dimension for reliability qualification decisions."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode observed during the test — drives root-cause analysis and design/process improvement prioritization."
    - name: "test_location"
      expr: test_location
      comment: "Location where the test was conducted — enables lab-level performance benchmarking."
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_timestamp)
      comment: "Month the stress test started — enables monthly reliability test throughput trend analysis."
    - name: "result_unit"
      expr: result_unit
      comment: "Unit of the result metric — required for correct interpretation of result values across different test types."
  measures:
    - name: "total_stress_tests"
      expr: COUNT(1)
      comment: "Total number of reliability stress tests conducted — baseline volume KPI for reliability program throughput."
    - name: "avg_mttf_hours"
      expr: AVG(CAST(mttf_hours AS DOUBLE))
      comment: "Average mean time to failure in hours — primary reliability KPI; directly informs warranty reserve calculations and customer reliability commitments."
    - name: "max_mttf_hours"
      expr: MAX(mttf_hours)
      comment: "Best-case MTTF observed — benchmarks peak reliability performance for product positioning."
    - name: "min_mttf_hours"
      expr: MIN(mttf_hours)
      comment: "Worst-case MTTF observed — flags reliability outliers requiring design or process corrective action."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average stress test result metric value — tracks whether reliability performance is trending toward or away from specification limits."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius — validates test condition consistency across labs and time periods."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity during stress tests — validates environmental condition consistency for test reproducibility."
    - name: "avg_voltage_v"
      expr: AVG(CAST(voltage_v AS DOUBLE))
      comment: "Average voltage applied during stress tests — validates electrical stress condition consistency."
    - name: "distinct_products_tested"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC catalog products covered by reliability stress tests — measures breadth of reliability qualification coverage."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_osat_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks OSAT vendor quality, audit performance, and DPPM — the primary supplier governance KPI view for vendor selection, scorecard reporting, and partnership management."
  source: "`vibe_semiconductors_v1`.`packaging`.`osat_vendor`"
  dimensions:
    - name: "vendor_country"
      expr: vendor_country
      comment: "Country of the OSAT vendor — enables geographic concentration risk analysis and regional performance benchmarking."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of OSAT vendor (e.g. full-service, test-only) — enables capability-based vendor segmentation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the vendor relationship (e.g. active, qualified, sunset) — drives vendor portfolio management decisions."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Partnership tier of the vendor — enables tiered vendor management and preferred supplier analysis."
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier classification of the vendor — informs supply risk and capacity allocation decisions."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification status — quality baseline filter for vendor qualification and compliance reporting."
    - name: "aec_q100_certified"
      expr: aec_q100_certified
      comment: "AEC-Q100 automotive qualification status — critical filter for automotive customer supply chain compliance."
    - name: "iatf_16949_certified"
      expr: iatf_16949_certified
      comment: "IATF 16949 automotive quality management certification — required for automotive supply chain eligibility."
    - name: "last_audit_month"
      expr: DATE_TRUNC('month', last_audit_date)
      comment: "Month of the most recent vendor audit — enables audit recency analysis and overdue audit identification."
  measures:
    - name: "total_osat_vendors"
      expr: COUNT(1)
      comment: "Total number of OSAT vendors in the portfolio — baseline supply base size KPI for concentration risk management."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average vendor audit score — primary supplier quality governance KPI; a declining score triggers re-audit or corrective action."
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average DPPM rate across OSAT vendors — quality KPI for vendor scorecard reporting and customer-facing quality commitments."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Lowest vendor audit score in the portfolio — identifies the weakest supplier link for risk mitigation prioritization."
    - name: "certified_vendor_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END)
      comment: "Number of ISO 9001 certified vendors — compliance coverage KPI for quality management system governance."
    - name: "automotive_qualified_vendor_count"
      expr: COUNT(CASE WHEN aec_q100_certified = TRUE THEN 1 END)
      comment: "Number of AEC-Q100 qualified vendors — automotive supply chain readiness KPI; directly impacts ability to serve automotive customers."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks packaging line capacity, yield, defect rate, and maintenance performance — the primary operational KPI view for manufacturing line efficiency and capacity planning."
  source: "`vibe_semiconductors_v1`.`packaging`.`packaging_line`"
  dimensions:
    - name: "packaging_line_status"
      expr: packaging_line_status
      comment: "Current operational status of the packaging line — primary dimension for capacity availability analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of packaging line (e.g. wire bond, flip chip) — enables technology-specific performance benchmarking."
    - name: "classification"
      expr: classification
      comment: "Classification of the packaging line — enables tiered line management and investment prioritization."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the line — filters qualified vs. unqualified lines for production eligibility decisions."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the line — required for regulatory compliance and safety audit reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the line became effective — tracks line commissioning timeline."
  measures:
    - name: "total_packaging_lines"
      expr: COUNT(1)
      comment: "Total number of packaging lines — baseline capacity asset count for capacity planning."
    - name: "avg_capacity_per_hour"
      expr: AVG(CAST(capacity_per_hour AS DOUBLE))
      comment: "Average throughput capacity per hour across packaging lines — primary capacity KPI for production planning and bottleneck identification."
    - name: "total_capacity_per_hour"
      expr: SUM(CAST(capacity_per_hour AS DOUBLE))
      comment: "Total installed packaging capacity per hour — aggregate capacity KPI for supply commitment and customer delivery planning."
    - name: "avg_current_yield_pct"
      expr: AVG(CAST(current_yield_percent AS DOUBLE))
      comment: "Average current yield percentage across packaging lines — operational efficiency KPI; a declining yield triggers maintenance or process investigation."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in PPM across packaging lines — quality KPI for line-level performance benchmarking and customer reporting."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures across packaging lines — equipment reliability KPI; drives preventive maintenance scheduling and capital investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair across packaging lines — maintenance efficiency KPI; high MTTR reduces effective capacity and impacts delivery commitments."
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per packaging line in kWh — sustainability and cost KPI for energy efficiency benchmarking and ESG reporting."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_material_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks incoming material lot quality, compliance status, and cost — drives supplier material quality governance, compliance risk management, and inventory cost control."
  source: "`vibe_semiconductors_v1`.`packaging`.`material_lot`"
  dimensions:
    - name: "material_lot_status"
      expr: material_lot_status
      comment: "Current status of the material lot (e.g. released, quarantined, rejected) — primary dimension for incoming material management."
    - name: "material_type"
      expr: material_type
      comment: "Type of packaging material — enables material category analysis for cost and quality benchmarking."
    - name: "incoming_inspection_status"
      expr: incoming_inspection_status
      comment: "Result of incoming inspection — drives material release decisions and supplier quality feedback."
    - name: "inspection_passed"
      expr: inspection_passed
      comment: "Boolean indicating whether the lot passed incoming inspection — primary quality gate dimension."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether the lot is quarantined — flags material at risk for production planning and compliance purposes."
    - name: "compliance_rohs_status"
      expr: compliance_rohs_status
      comment: "RoHS compliance status of the material lot — regulatory compliance dimension for customer and regulatory reporting."
    - name: "compliance_reach_status"
      expr: compliance_reach_status
      comment: "REACH compliance status of the material lot — regulatory compliance dimension for EU market access."
    - name: "compliance_itar_status"
      expr: compliance_itar_status
      comment: "ITAR compliance status of the material lot — export control dimension for defense and dual-use product management."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month the material lot was received — enables monthly incoming material volume and quality trend analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the material — enables storage compliance monitoring."
  measures:
    - name: "total_material_lots"
      expr: COUNT(1)
      comment: "Total number of material lots received — baseline incoming material volume KPI for supply chain planning."
    - name: "lots_passed_inspection"
      expr: COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END)
      comment: "Number of material lots that passed incoming inspection — measures supplier material quality throughput."
    - name: "incoming_inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of material lots passing incoming inspection — primary supplier material quality KPI; a declining rate triggers supplier corrective action."
    - name: "quarantined_lot_count"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of material lots currently quarantined — measures material supply risk; high quarantine counts signal supply disruption risk."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received across all lots — supply volume KPI for inventory planning and supplier performance tracking."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average material cost per unit — unit economics KPI for standard cost validation and supplier price benchmarking."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across material lots — composite supplier quality KPI used in vendor scorecards and sourcing decisions."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers providing material lots — supply base concentration KPI for single-source risk management."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks packaging inspection outcomes, defect density, and SPC control status — drives quality gate management, process control effectiveness, and customer quality reporting."
  source: "`vibe_semiconductors_v1`.`packaging`.`inspection_result`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Outcome of the inspection (pass/fail/conditional) — primary quality gate dimension for lot release decisions."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g. AOI, visual, X-ray) — enables method-level effectiveness analysis."
    - name: "inspection_step"
      expr: inspection_step
      comment: "Assembly step at which inspection was performed — enables step-level quality analysis."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defects detected — primary dimension for Pareto defect analysis."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of defects detected — drives prioritization of quality interventions."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of inspected units (accept, reject, rework) — informs yield loss and rework cost analysis."
    - name: "quality_outcome"
      expr: quality_outcome
      comment: "Overall quality outcome of the inspection — summary dimension for quality performance dashboards."
    - name: "is_spc_control"
      expr: is_spc_control
      comment: "Indicates whether the inspection is under SPC control — filters SPC-controlled vs. non-controlled inspections for process capability analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection — enables monthly quality trend analysis."
    - name: "defect_density_unit"
      expr: defect_density_unit
      comment: "Unit of defect density measurement — required for correct cross-step comparison."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records — baseline inspection volume KPI for quality program coverage."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across inspections — primary process quality KPI; trends directly inform SPC control limit adjustments."
    - name: "max_defect_density"
      expr: MAX(defect_density)
      comment: "Peak defect density observed — identifies worst-case quality events for root-cause escalation."
    - name: "inspection_fail_count"
      expr: COUNT(CASE WHEN inspection_status = 'fail' THEN 1 END)
      comment: "Number of failed inspections — absolute quality failure volume KPI for trend monitoring and corrective action tracking."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_status = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing — normalized quality gate pass rate; a declining rate triggers process investigation and customer notification."
    - name: "spc_controlled_inspection_count"
      expr: COUNT(CASE WHEN is_spc_control = TRUE THEN 1 END)
      comment: "Number of inspections under SPC control — measures process control coverage; low coverage signals quality system gaps."
    - name: "distinct_lots_inspected"
      expr: COUNT(DISTINCT assembly_lot_id)
      comment: "Number of distinct assembly lots inspected — measures inspection coverage breadth across the production population."
$$;
