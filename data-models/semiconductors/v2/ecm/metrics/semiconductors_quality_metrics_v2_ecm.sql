-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core yield performance metrics tracking die yield, defect density, and yield gap across process steps, tools, and SKUs. Yield is the primary semiconductor manufacturing efficiency KPI used by operations VPs and fab managers to steer process improvement investments."
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "process_node"
      expr: process_node
      comment: "Technology process node (e.g. 7nm, 5nm) for yield stratification by node generation."
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage in manufacturing where yield was measured (e.g. wafer probe, final test) for stage-specific yield analysis."
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Root cause category of yield loss (e.g. random defects, systematic, parametric) to prioritize improvement programs."
    - name: "yield_record_status"
      expr: yield_record_status
      comment: "Lifecycle status of the yield record for filtering active vs. archived data."
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint at which yield was evaluated, enabling gate-by-gate yield funnel analysis."
    - name: "defect_type"
      expr: defect_type
      comment: "Classification of defect type contributing to yield loss for Pareto analysis."
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift (day/night/weekend) to detect shift-based yield variation."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of yield measurement event for time-series trending."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of yield measurement for monthly yield trend reporting."
  measures:
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across all records in scope. Primary KPI for fab efficiency — a 1% yield improvement at scale translates to tens of millions in revenue recovery."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percentage, used alongside avg_yield_percentage to compute yield attainment gap."
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield. Directly quantifies the improvement opportunity and drives engineering resource allocation decisions."
    - name: "total_good_die_count"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total count of good (passing) die produced. Directly maps to revenue-generating output and is the primary throughput KPI for fab operations."
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total die processed (good + bad). Used as denominator for yield rate calculations and capacity utilization analysis."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all yield records. Tracks absolute defect volume to assess process stability and drive corrective action prioritization."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter — the standard semiconductor process quality metric used to benchmark process cleanliness and tool performance."
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Total number of yield records in scope. Used as a volume baseline for averaging and rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect-level quality metrics capturing defect density, spatial distribution, and severity across wafers, tools, and process steps. Used by process engineers and quality managers to identify systematic defect sources and drive root cause elimination."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_classification"
      expr: defect_classification
      comment: "Defect classification category (e.g. particle, scratch, pattern) for Pareto-driven root cause analysis."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the defect for risk-based prioritization of corrective actions."
    - name: "defect_layer"
      expr: defect_layer
      comment: "Process layer where defect was detected, enabling layer-specific yield loss attribution."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (e.g. optical inspection, e-beam) for inspection effectiveness analysis."
    - name: "defect_status"
      expr: defect_status
      comment: "Current disposition status of the defect record (open, closed, under review)."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision for the defect (use-as-is, rework, scrap) for cost impact analysis."
    - name: "edge_exclusion_zone_flag"
      expr: edge_exclusion_zone_flag
      comment: "Flag indicating whether defect is in the wafer edge exclusion zone, used to separate systematic edge defects from random bulk defects."
    - name: "repeatability_flag"
      expr: repeatability_flag
      comment: "Flag indicating whether the defect is a repeating systematic defect, critical for identifying tool or process excursions."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of defect detection event for time-series defect trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of defect detection for monthly defect rate trending."
  measures:
    - name: "defect_record_count"
      expr: COUNT(1)
      comment: "Total number of defect records. Baseline volume metric for defect rate calculations and trend monitoring."
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per wafer zone. Key process quality metric used to identify spatial patterns and tool-induced defect clustering."
    - name: "avg_defect_area_um2"
      expr: AVG(CAST(defect_area_um2 AS DOUBLE))
      comment: "Average defect area in square micrometers. Larger defect areas indicate more severe process excursions with higher yield impact."
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers. Critical for assessing whether defects are within or beyond the critical dimension threshold for the technology node."
    - name: "repeatability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeatability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are repeating/systematic. High repeatability rates signal tool or process excursions requiring immediate engineering intervention."
    - name: "edge_exclusion_defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edge_exclusion_zone_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects located in the edge exclusion zone. Elevated edge defect rates indicate edge-bead removal or wafer handling issues."
    - name: "distinct_wafers_with_defects"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers with at least one defect record. Used to assess the breadth of a defect excursion across the wafer population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness and cycle-time metrics. CAPA closure rate and cost are primary QMS KPIs tracked by quality directors and used in ISO 9001 / IATF 16949 management reviews to demonstrate continuous improvement."
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for stratifying improvement actions by nature."
    - name: "capa_record_status"
      expr: capa_record_status
      comment: "Current status of the CAPA (open, in-progress, closed, overdue) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA for resource allocation and escalation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA for risk-based quality management."
    - name: "severity"
      expr: severity
      comment: "Severity of the nonconformance driving the CAPA, used to prioritize high-impact actions."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that triggered the CAPA (customer complaint, internal audit, process excursion) for systemic issue identification."
    - name: "detection_phase"
      expr: detection_phase
      comment: "Manufacturing phase where the issue was detected (design, fabrication, test, field) for cost-of-quality analysis."
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status of CAPA closure to track governance compliance."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month CAPA was created for trend analysis of quality issue volume over time."
  measures:
    - name: "capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPA records. Baseline volume metric for quality issue tracking and management review reporting."
    - name: "open_capa_count"
      expr: SUM(CASE WHEN capa_record_status NOT IN ('Closed', 'Cancelled') THEN 1 ELSE 0 END)
      comment: "Count of open/in-progress CAPAs. A leading indicator of unresolved quality risk — high open counts signal quality system backlog requiring management attention."
    - name: "closed_capa_count"
      expr: SUM(CASE WHEN capa_record_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of closed CAPAs. Used with total count to compute closure rate for QMS performance reporting."
    - name: "capa_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_record_status = 'Closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs that have been closed. Core QMS KPI for ISO 9001 management reviews — low closure rates indicate systemic quality governance failures."
    - name: "total_capa_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred across all CAPAs. Quantifies the financial impact of quality failures and drives cost-of-poor-quality (COPQ) reporting."
    - name: "avg_capa_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA. Used to benchmark CAPA cost efficiency and identify outlier high-cost quality events."
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of open CAPAs. Provides forward-looking quality cost exposure for financial planning."
    - name: "effectiveness_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_result IS NOT NULL AND verification_result != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs with a completed effectiveness verification. Measures CAPA process maturity — unverified CAPAs indicate incomplete corrective action cycles."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance report (NCR) volume, severity, and financial impact metrics. NCRs are the primary quality event record in semiconductor manufacturing, tracked by quality managers and operations leadership to measure process control effectiveness and customer impact."
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "nonconformance_report_status"
      expr: nonconformance_report_status
      comment: "Current status of the NCR (open, under review, closed, on hold) for pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the nonconformance for risk-based prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority level of the NCR for resource allocation."
    - name: "detection_point"
      expr: detection_point
      comment: "Point in the manufacturing process where the nonconformance was detected for cost-of-quality analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of the nonconforming material (use-as-is, rework, scrap, return to supplier) for material cost impact analysis."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on material due to nonconformance for operational impact assessment."
    - name: "is_customer_impact"
      expr: is_customer_impact
      comment: "Flag indicating whether the nonconformance has customer impact — critical for escalation and customer notification decisions."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating regulatory or contractual requirement to notify the customer."
    - name: "report_month"
      expr: DATE_TRUNC('month', report_timestamp)
      comment: "Month the NCR was reported for trend analysis of nonconformance volume over time."
  measures:
    - name: "ncr_count"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports. Primary quality event volume metric for management review and process control trending."
    - name: "customer_impact_ncr_count"
      expr: SUM(CASE WHEN is_customer_impact = TRUE THEN 1 ELSE 0 END)
      comment: "Count of NCRs with confirmed customer impact. Directly tied to customer satisfaction and potential revenue risk — a key escalation trigger metric."
    - name: "customer_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customer_impact = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that have customer impact. Measures the effectiveness of internal quality gates at preventing customer escapes."
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances in reporting currency. Quantifies cost-of-poor-quality (COPQ) for executive financial review."
    - name: "avg_financial_impact"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per NCR. Used to benchmark severity and prioritize high-cost nonconformance categories."
    - name: "open_ncr_count"
      expr: SUM(CASE WHEN nonconformance_report_status NOT IN ('Closed', 'Cancelled') THEN 1 ELSE 0 END)
      comment: "Count of open NCRs. Measures the current quality backlog and unresolved risk exposure in the manufacturing pipeline."
    - name: "scrap_disposition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition_decision = 'Scrap' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs resulting in scrap disposition. High scrap rates directly drive material cost and yield loss — a key cost-of-quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective Parts Per Million (DPPM) quality metrics by customer and product. DPPM is the semiconductor industry's primary customer-facing quality KPI, used in quarterly business reviews with customers and tracked by quality and sales leadership to manage customer satisfaction and contractual quality commitments."
  source: "`vibe_semiconductors_v1`.`quality`.`dppm_record`"
  dimensions:
    - name: "closure_status"
      expr: closure_status
      comment: "Status of the DPPM record closure for pipeline management."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of quality notification associated with the DPPM event for categorization."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the DPPM record for filtering active vs. historical data."
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Flag indicating whether the affected product is KGD (Known Good Die) certified — DPPM on KGD products has premium customer impact."
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_start_date)
      comment: "Month of shipment start for DPPM trending by shipment cohort."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of DPPM event for time-series quality trend analysis."
  measures:
    - name: "dppm_record_count"
      expr: COUNT(1)
      comment: "Total number of DPPM records. Baseline volume metric for quality event tracking."
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average DPPM value across all records. The primary customer-facing quality KPI — semiconductor customers typically require DPPM below 10-50 ppm under supply agreements."
    - name: "total_defective_units"
      expr: SUM(CAST(defective_units AS DOUBLE))
      comment: "Total count of defective units reported. Absolute defect volume metric for warranty cost and customer impact quantification."
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS DOUBLE))
      comment: "Total units shipped across all DPPM records. Used as denominator for DPPM rate calculations and shipment volume tracking."
    - name: "computed_dppm_rate"
      expr: ROUND(1000000.0 * SUM(CAST(defective_units AS DOUBLE)) / NULLIF(SUM(CAST(total_units_shipped AS DOUBLE)), 0), 2)
      comment: "Computed DPPM rate (defective units per million shipped) from raw counts. More accurate than averaging reported DPPM values — used for customer scorecards and quality agreements."
    - name: "distinct_customers_with_dppm"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with DPPM events. Measures breadth of quality impact across the customer base — a key customer satisfaction risk indicator."
    - name: "distinct_products_with_dppm"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC catalog products with DPPM events. Identifies whether quality issues are product-specific or systemic across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint volume, escalation, and financial impact metrics. Customer complaints are the most visible quality signal for commercial relationships — tracked by quality, sales, and executive leadership to protect revenue and customer retention."
  source: "`vibe_semiconductors_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (e.g. electrical failure, mechanical damage, documentation) for Pareto analysis."
    - name: "customer_complaint_status"
      expr: customer_complaint_status
      comment: "Current status of the complaint (open, in-progress, closed) for pipeline management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint for risk-based escalation and prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the complaint for resource allocation."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the complaint for executive visibility and intervention decisions."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the complaint was received (email, portal, field visit) for channel effectiveness analysis."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Flag indicating whether the complaint includes a warranty claim — directly impacts financial liability."
    - name: "regulatory_report_flag"
      expr: regulatory_report_flag
      comment: "Flag indicating whether the complaint requires regulatory reporting — critical for compliance risk management."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_timestamp)
      comment: "Month the complaint was received for trend analysis of complaint volume over time."
  measures:
    - name: "complaint_count"
      expr: COUNT(1)
      comment: "Total number of customer complaints. Primary customer quality KPI tracked in quarterly business reviews and customer satisfaction programs."
    - name: "escalated_complaint_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints that have been escalated. Escalated complaints represent the highest customer relationship risk and require executive attention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that escalated. High escalation rates signal systemic quality or responsiveness failures threatening customer retention."
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints with associated warranty claims. Directly quantifies warranty liability exposure for financial planning."
    - name: "total_complaint_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost associated with customer complaints. Measures the direct financial impact of customer quality failures including investigation, rework, and replacement costs."
    - name: "avg_complaint_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per customer complaint. Used to benchmark complaint handling efficiency and prioritize high-cost complaint categories."
    - name: "total_dppm_impact"
      expr: SUM(CAST(dppm_impact AS DOUBLE))
      comment: "Total DPPM impact attributed to customer complaints. Links complaint volume to the DPPM quality metric for integrated customer quality reporting."
    - name: "distinct_customers_with_complaints"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with active complaints. Measures breadth of customer quality dissatisfaction across the account base."
    - name: "open_complaint_count"
      expr: SUM(CASE WHEN customer_complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 ELSE 0 END)
      comment: "Count of open customer complaints. Measures current customer quality backlog and unresolved relationship risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming and in-process inspection lot quality metrics including yield, defect density, and KGD certification rates. Used by quality engineers and supply chain managers to evaluate supplier quality, incoming material acceptance, and in-process quality gates."
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot (accepted, rejected, under review) for pipeline management."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (incoming, in-process, final) for stage-specific quality analysis."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage in the manufacturing process where inspection occurred for quality gate effectiveness analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection result (pass/fail/conditional) for acceptance rate trending."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot being inspected (production, qualification, engineering) for stratified quality analysis."
    - name: "material_type"
      expr: material_type
      comment: "Material type of the inspected lot for material-specific quality benchmarking."
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Flag indicating KGD certification status — KGD lots command premium pricing and require higher quality standards."
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "IATF 16949 compliance flag for automotive-grade quality reporting."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of inspection measurement for time-series quality trend analysis."
  measures:
    - name: "inspection_lot_count"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed. Baseline volume metric for inspection throughput and quality gate activity."
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots that passed. Primary incoming quality acceptance rate KPI — low pass rates signal supplier quality degradation or process excursions."
    - name: "kgd_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN kgd_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots achieving KGD certification. KGD certification rate directly impacts premium product revenue and customer qualification status."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inspection lots. Core quality efficiency metric for process and supplier performance benchmarking."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across inspection lots. Standard semiconductor quality metric for process cleanliness assessment."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across inspection lots. Used for capacity planning and to normalize defect counts for rate calculations."
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total units inspected across all lots. Measures inspection throughput volume for capacity and resource planning."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value across inspection lots. Used for process capability analysis and specification compliance trending."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test performance metrics including failure rates, FIT rates, and test coverage. Reliability qualification is mandatory for semiconductor product release — tracked by reliability engineers and product managers to ensure products meet JEDEC and customer lifetime requirements."
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, ELFR, THB, etc.) for test-specific performance analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the reliability test for pipeline management."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification status (pass/fail/in-progress) for product release decision support."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, re-qualification, process change) for qualification program management."
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade achieved (automotive, industrial, commercial) for product segmentation and pricing decisions."
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism identified (electromigration, TDDB, HCI, etc.) for technology node reliability risk assessment."
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Flag indicating KGD certification status for premium product reliability tracking."
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "JEDEC compliance flag for industry-standard reliability qualification reporting."
    - name: "test_execution_month"
      expr: DATE_TRUNC('month', test_execution_timestamp)
      comment: "Month of test execution for reliability qualification pipeline trending."
  measures:
    - name: "reliability_test_count"
      expr: COUNT(1)
      comment: "Total number of reliability tests executed. Baseline metric for qualification pipeline throughput."
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN test_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reliability tests that passed. Core product qualification KPI — failures block product release and require root cause investigation."
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average Failure In Time (FIT) rate across reliability tests. FIT rate is the primary semiconductor reliability metric used in customer datasheets and lifetime warranty calculations."
    - name: "avg_fit_rate_confidence"
      expr: AVG(CAST(fit_rate_confidence AS DOUBLE))
      comment: "Average confidence level of FIT rate estimates. Low confidence indicates insufficient sample sizes, requiring additional testing investment."
    - name: "avg_failure_time_hours"
      expr: AVG(CAST(failure_time_hours AS DOUBLE))
      comment: "Average time-to-failure in hours across reliability tests. Used to compute MTTF and validate product lifetime specifications."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Used for reliability lab capacity planning and qualification cycle time optimization."
    - name: "avg_weibull_shape_parameter"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) across tests. Beta < 1 indicates infant mortality, beta = 1 random failures, beta > 1 wear-out — critical for burn-in and warranty strategy decisions."
    - name: "avg_weibull_scale_parameter"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta, characteristic life) in hours. Directly quantifies product lifetime for warranty and reliability specification compliance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_spc_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart metrics tracking process stability, out-of-control events, and measurement performance. SPC is the primary real-time process control mechanism in semiconductor fabs — out-of-control rates drive immediate tool holds and process engineering response."
  source: "`vibe_semiconductors_v1`.`quality`.`spc_chart`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC chart (X-bar R, EWMA, CUSUM, etc.) for chart-specific performance analysis."
    - name: "spc_chart_status"
      expr: spc_chart_status
      comment: "Current status of the SPC chart for active monitoring pipeline management."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter being monitored (e.g. film thickness, CD, overlay) for parameter-specific process control analysis."
    - name: "parameter_unit"
      expr: parameter_unit
      comment: "Unit of measurement for the monitored parameter."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Flag indicating whether the measurement triggered an out-of-control signal — the primary SPC alert metric."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Flag indicating whether this is a baseline measurement used for control limit calculation."
    - name: "assignable_cause_code"
      expr: assignable_cause_code
      comment: "Code identifying the assignable cause of an out-of-control event for root cause categorization."
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift for detecting shift-based process variation patterns."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of SPC measurement for process stability trend analysis."
  measures:
    - name: "spc_measurement_count"
      expr: COUNT(1)
      comment: "Total number of SPC measurements. Baseline metric for process monitoring coverage and sampling frequency compliance."
    - name: "out_of_control_count"
      expr: SUM(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of out-of-control SPC signals. Each signal requires engineering investigation — high counts indicate process instability requiring immediate intervention."
    - name: "out_of_control_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC measurements triggering out-of-control signals. The primary process stability KPI — industry target is typically below 0.3% for a stable process (3-sigma)."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value. Used to track process mean drift relative to target for process centering analysis."
    - name: "avg_control_limit_center"
      expr: AVG(CAST(control_limit_center AS DOUBLE))
      comment: "Average center line (process mean) of SPC control charts. Tracks process mean stability over time."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average upper control limit across SPC charts. Used with lower limit to assess control limit width and process capability."
    - name: "avg_control_limit_lower"
      expr: AVG(CAST(control_limit_lower AS DOUBLE))
      comment: "Average lower control limit across SPC charts. Used with upper limit to assess control limit width and process capability."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter_name)
      comment: "Number of distinct process parameters under SPC monitoring. Measures SPC coverage breadth — low coverage indicates gaps in process control that increase excursion risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_supplier_quality_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality performance scorecard metrics tracking incoming quality rate, delivery conformance, and overall supplier quality scores. Used by supply chain and quality leadership to manage supplier development programs, qualification decisions, and sourcing strategy."
  source: "`vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard (active, archived, under review) for filtering current supplier performance data."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Supplier tier classification (Tier 1, Tier 2, etc.) for stratified supplier quality analysis."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (chemical, equipment, packaging, EDA) for category-specific quality benchmarking."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Quality trend direction (improving, stable, declining) for proactive supplier management decisions."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Start month of the evaluation period for time-series supplier quality trending."
  measures:
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of supplier quality scorecards. Baseline metric for supplier quality program coverage."
    - name: "avg_overall_quality_score"
      expr: AVG(CAST(overall_quality_score AS DOUBLE))
      comment: "Average overall supplier quality score. Primary supplier performance KPI used in supplier development programs and sourcing decisions — low scores trigger corrective action or disqualification."
    - name: "avg_incoming_quality_rate"
      expr: AVG(CAST(kpi_incoming_quality_rate AS DOUBLE))
      comment: "Average incoming quality rate across suppliers. Measures the percentage of incoming material meeting specifications — directly impacts production yield and schedule."
    - name: "avg_delivery_conformance"
      expr: AVG(CAST(kpi_delivery_conformance AS DOUBLE))
      comment: "Average delivery conformance rate across suppliers. On-time delivery is a critical supply chain KPI — low conformance disrupts fab production schedules."
    - name: "avg_cost_of_poor_quality"
      expr: AVG(CAST(kpi_cost_of_poor_quality AS DOUBLE))
      comment: "Average cost of poor quality per supplier scorecard. Quantifies the financial burden of supplier quality failures for total cost of ownership analysis."
    - name: "total_cost_of_poor_quality"
      expr: SUM(CAST(kpi_cost_of_poor_quality AS DOUBLE))
      comment: "Total cost of poor quality across all supplier scorecards. Aggregated COPQ metric for executive supply chain quality reporting and supplier investment decisions."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(kpi_responsiveness AS DOUBLE))
      comment: "Average supplier responsiveness score. Measures how quickly suppliers respond to quality issues — critical for minimizing production disruption from supplier quality events."
    - name: "distinct_suppliers_evaluated"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with quality scorecards. Measures supplier quality program coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_qualification_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification report metrics tracking qualification outcomes, yield performance, and DPPM results. Qualification reports are the formal evidence of product readiness for customer release — tracked by product engineering and quality management to manage product launch timelines and customer commitments."
  source: "`vibe_semiconductors_v1`.`quality`.`qualification_report`"
  dimensions:
    - name: "qualification_report_status"
      expr: qualification_report_status
      comment: "Current status of the qualification report (draft, approved, rejected, superseded) for pipeline management."
    - name: "qualification_result"
      expr: qualification_result
      comment: "Overall qualification result (pass/fail/conditional) for product release decision support."
    - name: "report_type"
      expr: report_type
      comment: "Type of qualification report (JEDEC, AEC-Q100, customer-specific) for standards-based reporting."
    - name: "report_month"
      expr: DATE_TRUNC('month', report_date)
      comment: "Month the qualification report was issued for qualification pipeline trending."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the qualification became effective for product availability timeline analysis."
  measures:
    - name: "qualification_report_count"
      expr: COUNT(1)
      comment: "Total number of qualification reports. Baseline metric for qualification pipeline throughput and product release velocity."
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualification reports with a passing result. Core product quality KPI — low pass rates delay product launches and impact revenue commitments."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage reported in qualification reports. Validates that production yield meets the minimum threshold required for product release."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM reported in qualification reports. Validates that defect rates meet customer and industry quality specifications for product release."
    - name: "distinct_products_qualified"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC catalog products with qualification reports. Measures the breadth of the qualified product portfolio available for customer shipment."
    - name: "distinct_customers_with_qualifications"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers for whom qualification reports have been issued. Measures customer qualification program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit finding metrics tracking finding severity, closure rates, and audit scores. Audit findings are the primary output of QMS audits (ISO 9001, IATF 16949, customer audits) — tracked by quality management to demonstrate continuous improvement and maintain certifications."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_audit_finding`"
  dimensions:
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the audit finding (major nonconformance, minor nonconformance, observation, opportunity for improvement) for severity-based prioritization."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that generated the finding (internal, customer, third-party, regulatory) for audit program management."
    - name: "closure_status"
      expr: closure_status
      comment: "Current closure status of the finding for pipeline management and overdue tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding for risk-based prioritization of corrective actions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the finding for risk-based quality management decisions."
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Flag indicating whether this is a repeat finding from a previous audit — repeat findings signal ineffective corrective actions and are a major audit red flag."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the finding for regulatory and certification reporting."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of the audit for finding volume trend analysis over time."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline metric for audit quality performance and QMS health assessment."
    - name: "major_nonconformance_count"
      expr: SUM(CASE WHEN finding_classification = 'Major Nonconformance' THEN 1 ELSE 0 END)
      comment: "Count of major nonconformance findings. Major nonconformances can result in certification suspension — a critical risk metric for quality leadership."
    - name: "repeat_issue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_issue = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit findings that are repeat issues. High repeat rates indicate systemic corrective action ineffectiveness — a key QMS maturity indicator."
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_status = 'Closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit findings that have been closed. Core QMS KPI for ISO 9001 management reviews — low closure rates risk certification non-renewal."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all findings. Provides a composite quality system performance indicator for management review and certification body reporting."
    - name: "open_finding_count"
      expr: SUM(CASE WHEN closure_status NOT IN ('Closed', 'Cancelled') THEN 1 ELSE 0 END)
      comment: "Count of open audit findings. Measures current QMS corrective action backlog and unresolved compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer map quality metrics tracking die yield, defect density, and KGD certification rates at the wafer level. Wafer maps are the fundamental spatial quality record in semiconductor manufacturing — used by process engineers and yield managers to identify spatial yield patterns and tool-induced defects."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_status"
      expr: map_status
      comment: "Current status of the wafer map (active, archived, under review) for filtering current data."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect captured in the wafer map for defect-type-specific yield analysis."
    - name: "defect_zone"
      expr: defect_zone
      comment: "Spatial zone on the wafer where defects are concentrated for spatial pattern analysis."
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Wafer flat/notch orientation for detecting orientation-dependent process effects."
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Flag indicating KGD certification status of the wafer map for premium product yield tracking."
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance flag for quality system reporting."
    - name: "map_generation_month"
      expr: DATE_TRUNC('month', map_generation_timestamp)
      comment: "Month the wafer map was generated for time-series yield trend analysis."
  measures:
    - name: "wafer_map_count"
      expr: COUNT(1)
      comment: "Total number of wafer maps. Baseline metric for wafer inspection throughput."
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across all wafer maps. The primary wafer-level yield KPI used by fab managers and process engineers to track manufacturing efficiency."
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per square millimeter. Standard process quality metric for benchmarking process cleanliness and tool performance across technology nodes."
    - name: "kgd_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_kgd_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafer maps achieving KGD certification. KGD yield directly determines premium product revenue and customer qualification compliance."
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone in millimeters. Larger exclusion zones reduce usable die area — tracking this metric supports die area optimization decisions."
    - name: "distinct_wafers_mapped"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers with wafer maps. Measures wafer inspection coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold metrics tracking hold volume, affected quantity, and resolution rates. Quality holds represent material at risk — tracked by operations and quality management to minimize WIP exposure, resolve holds quickly, and reduce the financial impact of held inventory."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the quality hold (active, released, expired, cancelled) for pipeline management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (process excursion, customer complaint, audit finding, etc.) for root cause categorization."
    - name: "hold_category"
      expr: hold_category
      comment: "Category of the hold for stratified analysis of hold drivers."
    - name: "priority"
      expr: priority
      comment: "Priority level of the hold for resource allocation and escalation decisions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the hold for tracking disposition progress."
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity affected by the hold (wafer lot, die bank, finished good) for impact scope analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the hold was initiated for hold volume trend analysis."
  measures:
    - name: "hold_count"
      expr: COUNT(1)
      comment: "Total number of quality holds. Baseline metric for quality hold pipeline volume and manufacturing disruption assessment."
    - name: "active_hold_count"
      expr: SUM(CASE WHEN hold_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active quality holds. Measures current WIP at risk — a key operational risk metric for fab management."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of units/wafers affected by quality holds. Quantifies the scale of material at risk for financial exposure and production impact assessment."
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average quantity affected per quality hold. Used to benchmark hold severity and prioritize resolution resources."
    - name: "hold_release_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_status IN ('Released', 'Closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quality holds that have been released. Measures hold resolution efficiency — low release rates indicate quality backlog and WIP accumulation risk."
    - name: "kgd_certified_hold_count"
      expr: SUM(CASE WHEN is_kgd_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quality holds on KGD-certified material. KGD holds have premium revenue impact and require priority resolution."
$$;