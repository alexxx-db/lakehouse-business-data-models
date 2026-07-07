-- Metric views for domain: quality | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release quality metrics tracking release decisions, GMP compliance, rejected quantities, and release cycle performance across manufacturing batches. Supports QA leadership in monitoring release throughput, rejection rates, and regulatory compliance posture."
  source: "`vibe_consumer_goods_v1`.`quality`.`batch_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current release status of the batch (e.g., Released, Rejected, On Hold) — primary grouping for release pipeline analysis."
    - name: "release_decision"
      expr: release_decision
      comment: "Final release decision recorded by the qualified person — used to segment approved vs. rejected batches."
    - name: "qc_inspection_status"
      expr: qc_inspection_status
      comment: "QC inspection outcome for the batch — enables correlation between inspection results and release decisions."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates whether the batch met GMP compliance requirements — critical regulatory dimension."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flags batches that required a corrective and preventive action — signals quality risk."
    - name: "regulatory_market"
      expr: regulatory_market
      comment: "Target regulatory market for the batch release — supports market-specific compliance reporting."
    - name: "manufacturing_site_code"
      expr: manufacturing_site_code
      comment: "Manufacturing site that produced the batch — enables site-level quality benchmarking."
    - name: "release_date"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month of batch release — used for trend analysis of release throughput over time."
    - name: "regulatory_hold_status"
      expr: regulatory_hold_status
      comment: "Indicates whether the batch is under a regulatory hold — critical for compliance risk monitoring."
    - name: "batch_size_uom"
      expr: batch_size_uom
      comment: "Unit of measure for batch size — supports normalized quantity comparisons across product lines."
  measures:
    - name: "total_batches_released"
      expr: COUNT(DISTINCT batch_release_id)
      comment: "Total number of distinct batch release records — baseline throughput KPI for the release pipeline."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity of product released to market — directly tied to supply availability and revenue enablement."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected during batch release — key quality cost and waste indicator for executive review."
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity approved for release — used to compute release yield when compared against batch size."
    - name: "total_batch_size_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Sum of all batch sizes processed through the release workflow — denominator for yield and rejection rate calculations."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across batch release records — monitors data governance health of the release process."
    - name: "batches_with_capa"
      expr: COUNT(DISTINCT CASE WHEN capa_required_flag = TRUE THEN batch_release_id END)
      comment: "Number of batches that required a CAPA — indicates systemic quality issues requiring corrective action investment."
    - name: "batches_gmp_compliant"
      expr: COUNT(DISTINCT CASE WHEN gmp_compliance_flag = TRUE THEN batch_release_id END)
      comment: "Number of batches meeting GMP compliance — core regulatory KPI for quality leadership and auditors."
    - name: "batches_on_regulatory_hold"
      expr: COUNT(DISTINCT CASE WHEN regulatory_hold_status IS NOT NULL AND regulatory_hold_status != '' THEN batch_release_id END)
      comment: "Number of batches currently under a regulatory hold — high-priority risk metric for compliance officers."
    - name: "total_release_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with batch releases — supports cost-of-quality and financial impact analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) performance metrics tracking open/closed CAPAs, cycle times, effectiveness, regulatory impact, and cost. Enables quality leadership to monitor systemic issue resolution velocity and regulatory risk exposure."
  source: "`vibe_consumer_goods_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of the CAPA (e.g., Open, Closed, In Progress) — primary dimension for pipeline health monitoring."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (Corrective vs. Preventive) — enables analysis of reactive vs. proactive quality investment."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA — used to triage high-risk quality issues requiring immediate leadership attention."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the underlying quality event — drives escalation and resource allocation decisions."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for CAPA resolution — enables departmental quality performance benchmarking."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the CAPA (e.g., audit, complaint, deviation) — identifies systemic quality failure sources."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the CAPA event must be reported to a regulatory authority — critical compliance dimension."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Flags CAPAs arising from GMP deviations — key dimension for regulatory audit readiness."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Indicates whether the CAPA effectiveness has been formally verified — measures closure quality, not just closure count."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the CAPA was initiated — supports trend analysis of quality event frequency over time."
    - name: "closed_date_month"
      expr: DATE_TRUNC('month', closed_date)
      comment: "Month the CAPA was closed — used to track resolution throughput and backlog aging."
  measures:
    - name: "total_capas"
      expr: COUNT(DISTINCT capa_id)
      comment: "Total number of CAPA records — baseline volume KPI for quality event management."
    - name: "open_capas"
      expr: COUNT(DISTINCT CASE WHEN capa_status NOT IN ('Closed', 'Completed') THEN capa_id END)
      comment: "Number of currently open CAPAs — critical operational metric indicating unresolved quality risk backlog."
    - name: "capas_with_regulatory_impact"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN capa_id END)
      comment: "Number of CAPAs with regulatory reporting obligations — directly tied to compliance risk and regulatory relationship management."
    - name: "capas_effectiveness_verified"
      expr: COUNT(DISTINCT CASE WHEN effectiveness_verified = TRUE THEN capa_id END)
      comment: "Number of CAPAs with confirmed effectiveness verification — measures true closure quality, not just administrative closure."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of all CAPAs — enables cost-of-quality analysis and investment prioritization by leadership."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per CAPA — benchmarks the financial burden of individual quality events."
    - name: "capas_with_customer_impact"
      expr: COUNT(DISTINCT CASE WHEN customer_impact_flag = TRUE THEN capa_id END)
      comment: "Number of CAPAs that impacted customers — directly linked to customer satisfaction and brand risk."
    - name: "capas_gmp_deviation"
      expr: COUNT(DISTINCT CASE WHEN gmp_deviation_flag = TRUE THEN capa_id END)
      comment: "Number of CAPAs originating from GMP deviations — key regulatory compliance risk indicator."
    - name: "total_capa_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount recorded against CAPA records — supports cost-of-quality and financial impact reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics covering lot disposition, sample quantities, defect counts, and regulatory holds. Provides QA and supply chain leadership with visibility into incoming and in-process inspection performance."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot — primary dimension for pipeline and backlog analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., incoming, in-process, final) — enables stage-specific quality analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Detailed inspection outcome status — used to segment passed, failed, and pending lots."
    - name: "usage_decision"
      expr: usage_decision
      comment: "Final usage decision for the lot (e.g., Accept, Reject, Rework) — key disposition KPI dimension."
    - name: "disposition_outcome"
      expr: disposition_outcome
      comment: "Outcome of the lot disposition process — supports analysis of rejection and rework rates."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates GMP compliance status of the inspection lot — regulatory compliance dimension."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flags lots under regulatory hold — high-priority risk dimension for compliance monitoring."
    - name: "inspection_priority"
      expr: inspection_priority
      comment: "Priority assigned to the inspection lot — supports triage and resource allocation in QC labs."
    - name: "lot_origin_type"
      expr: lot_origin_type
      comment: "Origin type of the lot (e.g., production, procurement) — enables source-specific quality benchmarking."
    - name: "inspection_start_date_month"
      expr: DATE_TRUNC('month', inspection_start_date)
      comment: "Month inspection started — supports trend analysis of inspection volume and throughput."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Total number of inspection lots — baseline throughput KPI for the QC inspection pipeline."
    - name: "lots_on_regulatory_hold"
      expr: COUNT(DISTINCT CASE WHEN regulatory_hold_flag = TRUE THEN inspection_lot_id END)
      comment: "Number of lots currently under regulatory hold — critical compliance risk metric for quality leadership."
    - name: "lots_gmp_compliant"
      expr: COUNT(DISTINCT CASE WHEN gmp_compliance_flag = TRUE THEN inspection_lot_id END)
      comment: "Number of inspection lots meeting GMP compliance — core regulatory KPI."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity across all inspection lots — measures volume of product flowing through QC inspection."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity drawn for inspection — supports sampling efficiency and coverage analysis."
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot size entering inspection — used to benchmark lot sizing consistency across suppliers and production lines."
    - name: "lots_accepted"
      expr: COUNT(DISTINCT CASE WHEN usage_decision = 'Accept' OR usage_decision_code = 'A' THEN inspection_lot_id END)
      comment: "Number of lots accepted after inspection — numerator for lot acceptance rate calculation."
    - name: "lots_rejected"
      expr: COUNT(DISTINCT CASE WHEN usage_decision = 'Reject' OR usage_decision_code = 'R' THEN inspection_lot_id END)
      comment: "Number of lots rejected after inspection — key quality failure rate indicator for supplier and process management."
    - name: "total_inspection_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with inspection lots — supports cost-of-inspection and quality cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking pass/fail rates, measured values vs. specification limits, defect classifications, and out-of-spec rates. Enables QA and R&D leadership to monitor product quality at the characteristic level and drive specification improvements."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "inspection_result_status"
      expr: inspection_result_status
      comment: "Overall status of the inspection result record — primary dimension for pass/fail analysis."
    - name: "result_status"
      expr: result_status
      comment: "Detailed result status (e.g., Pass, Fail, Inconclusive) — used to segment quality outcomes."
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Name of the quality characteristic being tested — enables characteristic-level defect rate analysis."
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of detected defects (e.g., Critical, Major, Minor) — drives prioritization of quality interventions."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of the defect — used to escalate critical quality failures to leadership."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection — supports method effectiveness and standardization analysis."
    - name: "is_within_spec"
      expr: is_within_spec
      comment: "Boolean flag indicating whether the measured value is within specification limits — primary out-of-spec dimension."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the result must be reported to a regulatory authority — compliance risk dimension."
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Flags results that required a retest — indicates first-pass quality and lab efficiency."
    - name: "result_valuation"
      expr: result_valuation
      comment: "Qualitative valuation of the result (e.g., Accepted, Rejected) — supports disposition analysis."
    - name: "inspection_timestamp_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection — enables trend analysis of quality result volumes and failure rates over time."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(DISTINCT inspection_result_id)
      comment: "Total number of inspection result records — baseline volume KPI for QC lab throughput."
    - name: "results_within_spec"
      expr: COUNT(DISTINCT CASE WHEN is_within_spec = TRUE THEN inspection_result_id END)
      comment: "Number of inspection results within specification — numerator for first-pass yield and spec compliance rate."
    - name: "results_out_of_spec"
      expr: COUNT(DISTINCT CASE WHEN is_within_spec = FALSE THEN inspection_result_id END)
      comment: "Number of out-of-specification results — critical quality failure indicator driving CAPA and regulatory reporting decisions."
    - name: "results_requiring_retest"
      expr: COUNT(DISTINCT CASE WHEN retest_indicator = TRUE THEN inspection_result_id END)
      comment: "Number of results that required a retest — measures first-pass quality and lab rework burden."
    - name: "results_regulatory_reportable"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN inspection_result_id END)
      comment: "Number of inspection results with regulatory reporting obligations — compliance risk volume metric."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results — used to monitor process centering relative to specification targets."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value recorded — supports statistical process control and trend analysis."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target specification value — provides context for interpreting measured value deviations."
    - name: "control_chart_violations"
      expr: COUNT(DISTINCT CASE WHEN control_chart_violation_flag = TRUE THEN inspection_result_id END)
      comment: "Number of results triggering a control chart rule violation — early warning indicator for process drift requiring intervention."
    - name: "total_inspection_result_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with inspection results — supports cost-of-testing analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance event metrics tracking defect volumes, financial impact, regulatory exposure, and resolution status. Provides quality and operations leadership with a comprehensive view of product and process failures driving cost and risk."
  source: "`vibe_consumer_goods_v1`.`quality`.`nonconformance`"
  dimensions:
    - name: "nc_status"
      expr: nc_status
      comment: "Current status of the nonconformance record — primary dimension for open/closed pipeline analysis."
    - name: "nc_type"
      expr: nc_type
      comment: "Type of nonconformance (e.g., product, process, supplier) — enables root cause category analysis."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of the defect — supports Pareto analysis of quality failure types."
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of defect severity (Critical, Major, Minor) — drives prioritization and escalation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity level of the nonconformance — used to triage and escalate high-risk quality events."
    - name: "detection_source"
      expr: detection_source
      comment: "Source where the nonconformance was detected (e.g., incoming inspection, customer complaint) — identifies detection effectiveness."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the nonconformance — enables departmental quality accountability reporting."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates regulatory reporting obligation — critical compliance risk dimension."
    - name: "is_gmp_related"
      expr: is_gmp_related
      comment: "Flags GMP-related nonconformances — key dimension for regulatory audit readiness."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision for the nonconforming material — supports scrap, rework, and use-as-is analysis."
    - name: "detected_date_month"
      expr: DATE_TRUNC('month', detected_date)
      comment: "Month the nonconformance was detected — enables trend analysis of quality event frequency."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(DISTINCT nonconformance_id)
      comment: "Total number of nonconformance events — baseline quality failure volume KPI."
    - name: "open_nonconformances"
      expr: COUNT(DISTINCT CASE WHEN nc_status NOT IN ('Closed', 'Completed') THEN nonconformance_id END)
      comment: "Number of currently open nonconformances — measures unresolved quality risk backlog requiring leadership attention."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by nonconformances — directly tied to supply risk and potential revenue loss."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformance events — primary cost-of-quality KPI for executive review and investment decisions."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance — benchmarks the cost burden of individual quality failures."
    - name: "nonconformances_regulatory_reportable"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN nonconformance_id END)
      comment: "Number of nonconformances requiring regulatory reporting — compliance risk volume metric for quality and regulatory affairs leadership."
    - name: "nonconformances_gmp_related"
      expr: COUNT(DISTINCT CASE WHEN is_gmp_related = TRUE THEN nonconformance_id END)
      comment: "Number of GMP-related nonconformances — key regulatory compliance indicator for audit readiness."
    - name: "total_nc_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount recorded against nonconformance records — supports cost-of-quality financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product complaint metrics tracking complaint volumes, severity, regulatory reportability, investigation outcomes, and adverse events. Enables quality, regulatory affairs, and customer experience leadership to monitor consumer safety risk and complaint resolution performance."
  source: "`vibe_consumer_goods_v1`.`quality`.`product_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the product complaint — primary dimension for open/closed complaint pipeline analysis."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g., safety, quality, labeling) — enables Pareto analysis of complaint types."
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint — supports segmentation of complaint root causes and resolution strategies."
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint — drives escalation and regulatory reporting decisions."
    - name: "severity_level"
      expr: severity_level
      comment: "Detailed severity classification — used for risk stratification of complaint portfolio."
    - name: "is_adverse_event"
      expr: is_adverse_event
      comment: "Flags complaints classified as adverse events — highest-priority safety dimension for regulatory reporting."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Indicates whether the complaint must be reported to a regulatory authority — compliance obligation dimension."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Regulatory reportability flag — used to track complaints with formal regulatory reporting requirements."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the complaint investigation — monitors investigation throughput and backlog."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (e.g., consumer, retailer, social media) — supports channel-specific quality monitoring."
    - name: "received_date_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month the complaint was received — enables trend analysis of complaint volumes over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(DISTINCT product_complaint_id)
      comment: "Total number of product complaints received — baseline consumer quality signal KPI."
    - name: "adverse_event_complaints"
      expr: COUNT(DISTINCT CASE WHEN is_adverse_event = TRUE THEN product_complaint_id END)
      comment: "Number of complaints classified as adverse events — highest-priority consumer safety metric requiring immediate executive attention."
    - name: "regulatory_reportable_complaints"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN product_complaint_id END)
      comment: "Number of complaints with regulatory reporting obligations — compliance risk volume metric for regulatory affairs leadership."
    - name: "open_complaints"
      expr: COUNT(DISTINCT CASE WHEN complaint_status NOT IN ('Closed', 'Completed', 'Resolved') THEN product_complaint_id END)
      comment: "Number of currently open complaints — measures unresolved consumer quality risk and customer experience backlog."
    - name: "complaints_under_investigation"
      expr: COUNT(DISTINCT CASE WHEN investigation_status NOT IN ('Completed', 'Closed') AND investigation_status IS NOT NULL THEN product_complaint_id END)
      comment: "Number of complaints currently under active investigation — monitors investigation pipeline capacity and throughput."
    - name: "complaints_with_sample_returned"
      expr: COUNT(DISTINCT CASE WHEN sample_returned_flag = TRUE THEN product_complaint_id END)
      comment: "Number of complaints where a product sample was returned for lab analysis — indicates depth of investigation and evidence quality."
    - name: "total_complaint_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with product complaints — supports cost-of-quality and customer remediation cost analysis."
    - name: "avg_complaint_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average financial amount per complaint — benchmarks the cost burden of individual consumer quality events."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_usage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage decision metrics tracking accepted, rejected, and reworked quantities from quality inspection dispositions. Provides supply chain and quality leadership with visibility into material flow outcomes, rejection rates, and rework costs."
  source: "`vibe_consumer_goods_v1`.`quality`.`usage_decision`"
  dimensions:
    - name: "usage_decision_status"
      expr: usage_decision_status
      comment: "Current status of the usage decision — primary dimension for decision pipeline analysis."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of usage decision (e.g., Accept, Reject, Rework, Retest) — core disposition dimension."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the material — used to segment accepted, rejected, and reworked material flows."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Status of the disposition process — monitors completion of material disposition workflows."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection that led to the usage decision — enables stage-specific disposition analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance status of the usage decision — regulatory compliance dimension."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flags usage decisions under regulatory hold — high-priority compliance risk dimension."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required as part of the usage decision — links disposition to corrective action."
    - name: "decision_date_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month the usage decision was made — supports trend analysis of disposition throughput."
    - name: "stock_posting_type"
      expr: stock_posting_type
      comment: "Type of stock posting resulting from the usage decision — links quality disposition to inventory management."
  measures:
    - name: "total_usage_decisions"
      expr: COUNT(DISTINCT usage_decision_id)
      comment: "Total number of usage decisions made — baseline throughput KPI for the quality disposition process."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted through usage decisions — measures volume of material cleared for use or sale."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected through usage decisions — key quality waste and supply risk KPI."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity sent for rework — measures rework burden and associated cost-of-quality."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Sum of quantity_accepted field — alternative accepted quantity measure for cross-validation and completeness."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Sum of quantity_rejected field — alternative rejected quantity measure supporting rejection rate calculations."
    - name: "total_quantity_rework"
      expr: SUM(CAST(quantity_rework AS DOUBLE))
      comment: "Sum of quantity_rework field — supports rework rate and cost-of-rework analysis."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across usage decisions — composite quality performance indicator for supplier and process benchmarking."
    - name: "decisions_on_regulatory_hold"
      expr: COUNT(DISTINCT CASE WHEN regulatory_hold_flag = TRUE THEN usage_decision_id END)
      comment: "Number of usage decisions under regulatory hold — compliance risk metric requiring immediate quality leadership attention."
    - name: "total_usage_decision_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with usage decisions — supports cost-of-quality and material write-off analysis."
$$;