-- Metric views for domain: quality | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures audit finding volume, severity distribution, repeat finding rates, and closure performance — drives GMP audit program effectiveness and supplier quality management."
  source: "`vibe_consumer_goods_v1`.`quality`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g. Critical, Major, Minor, Observation) for severity-based prioritization."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (Open, Closed, In Progress) for backlog management."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g. Documentation, Process, Equipment) for root-cause trend analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding — drives escalation and CAPA prioritization."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the finding must be reported to a regulatory authority."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding from a prior audit — key indicator of systemic quality failure."
    - name: "finding_date_month"
      expr: DATE_TRUNC('month', finding_date)
      comment: "Month the finding was identified, for trend analysis of audit quality over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline audit quality KPI."
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN finding_type = 'Critical' THEN 1 END)
      comment: "Count of critical audit findings. Highest-priority quality and regulatory risk indicator."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Count of repeat findings. Measures CAPA effectiveness — repeat findings signal systemic quality failures."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats. Core quality system maturity KPI — target is near zero."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open audit findings. Operational backlog and compliance risk indicator."
    - name: "regulatory_reportable_finding_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of findings requiring regulatory reporting. Tracks compliance obligation volume from audits."
    - name: "distinct_suppliers_with_findings"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers with audit findings. Measures breadth of supplier quality risk."
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_type = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings classified as critical. Audit severity concentration KPI for executive reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures batch release performance including release rates, rejection rates, QP certification compliance, and GMP adherence — critical for supply continuity and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`quality`.`batch_release`"
  dimensions:
    - name: "batch_release_status"
      expr: batch_release_status
      comment: "Current status of the batch release (e.g. Released, Rejected, On Hold, Pending)."
    - name: "release_decision"
      expr: release_decision
      comment: "Final release decision (Accept, Reject, Rework) for batch disposition analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Whether the batch meets GMP compliance requirements at release."
    - name: "qp_certification_flag"
      expr: qp_certification_flag
      comment: "Whether a Qualified Person has certified the batch — mandatory for EU pharmaceutical/cosmetic markets."
    - name: "regulatory_market"
      expr: regulatory_market
      comment: "Target regulatory market for the batch, enabling market-specific release performance analysis."
    - name: "manufacture_date_month"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month of manufacture, for batch release cycle time and throughput trending."
    - name: "release_date_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month of batch release, for release throughput and backlog trending."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch release records. Baseline throughput metric for manufacturing output."
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity released to market. Directly measures supply output available for distribution."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at batch release. Key cost-of-quality and yield loss metric."
    - name: "batch_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN release_decision = 'Reject' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches rejected at release. Core manufacturing quality KPI — high rates signal process instability."
    - name: "gmp_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting GMP compliance at release. Regulatory audit readiness KPI."
    - name: "qp_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qp_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches with QP certification. Mandatory compliance metric for regulated markets."
    - name: "capa_required_batch_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of batches requiring CAPA at release. Signals systemic quality issues needing corrective action."
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size_quantity AS DOUBLE))
      comment: "Average batch size at release. Benchmarks production scale and detects anomalous batch sizes."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity confirmed released. Tracks actual supply availability post-QA sign-off."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures corrective and preventive action (CAPA) effectiveness, cycle time, and closure rates — a core quality management KPI set for GMP compliance and continuous improvement."
  source: "`vibe_consumer_goods_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of the CAPA (e.g. Open, In Progress, Closed, Overdue)."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (Corrective vs Preventive), enabling split analysis of reactive vs proactive quality actions."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA, used to assess urgency distribution across the portfolio."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying quality event driving the CAPA."
    - name: "process_area"
      expr: process_area
      comment: "Business process area where the CAPA originates, for root-cause hotspot analysis."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Indicates whether the CAPA was triggered by a GMP deviation — critical for regulatory audit trails."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the CAPA effectiveness has been verified, measuring closure quality."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the CAPA was initiated, for trend and aging analysis."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records. Baseline volume metric for quality management workload."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open CAPAs. Operational backlog KPI — high open counts signal quality system stress."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of CAPAs past their due date without closure. Regulatory compliance risk indicator."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of CAPAs with verified effectiveness. Measures quality of CAPA closure, not just volume."
    - name: "effectiveness_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed CAPAs with verified effectiveness. Key GMP quality system maturity KPI."
    - name: "gmp_deviation_capa_count"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs triggered by GMP deviations. Directly tracks regulatory compliance exposure."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of CAPAs. Quantifies cost-of-poor-quality for executive reporting."
    - name: "avg_cost_impact_per_capa"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per CAPA. Benchmarks the financial severity of quality failures."
    - name: "regulatory_impact_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory impact. Tracks regulatory risk concentration in the quality portfolio."
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') AND due_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END), 0), 2)
      comment: "Percentage of open CAPAs that are overdue. Operational urgency and compliance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_change_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures change control cycle times, approval rates, GMP and regulatory impact, and closure performance — essential for quality system governance and regulatory compliance in consumer goods manufacturing."
  source: "`vibe_consumer_goods_v1`.`quality`.`change_control`"
  dimensions:
    - name: "change_control_status"
      expr: change_control_status
      comment: "Current lifecycle status of the change control record."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Process, Product, Equipment, Supplier) for change portfolio analysis."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority of the change request — drives resource allocation and scheduling."
    - name: "gmp_impact_flag"
      expr: gmp_impact_flag
      comment: "Whether the change has GMP impact — determines regulatory notification requirements."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the change requires regulatory approval before implementation."
    - name: "regulatory_impact_classification"
      expr: regulatory_impact_classification
      comment: "Classification of regulatory impact (e.g. Major, Minor, Notifiable) for submission planning."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the change was initiated, for change volume trending and backlog analysis."
  measures:
    - name: "total_change_controls"
      expr: COUNT(1)
      comment: "Total number of change control records. Baseline change management activity KPI."
    - name: "open_change_control_count"
      expr: COUNT(CASE WHEN change_control_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open change controls. Operational backlog metric for quality and regulatory teams."
    - name: "gmp_impact_change_count"
      expr: COUNT(CASE WHEN gmp_impact_flag = TRUE THEN 1 END)
      comment: "Count of changes with GMP impact. Tracks regulatory notification and validation workload."
    - name: "regulatory_impact_change_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring regulatory approval. Tracks submission pipeline driven by change management."
    - name: "gmp_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes with GMP impact. Measures regulatory complexity of the change portfolio."
    - name: "post_change_verification_required_count"
      expr: COUNT(CASE WHEN post_change_verification_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring post-implementation verification. Tracks validation workload from change management."
    - name: "effectiveness_review_required_count"
      expr: COUNT(CASE WHEN effectiveness_review_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring effectiveness review. Measures quality system closure rigor."
    - name: "distinct_skus_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs affected by change controls. Measures breadth of product portfolio impact."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_control_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures process capability and statistical process control performance including Cpk, Ppk, sigma levels, and out-of-control rates — drives manufacturing quality and continuous improvement decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`control_chart`"
  dimensions:
    - name: "control_chart_status"
      expr: control_chart_status
      comment: "Current status of the control chart (e.g. Active, Inactive, Under Review)."
    - name: "chart_type"
      expr: chart_type
      comment: "Type of control chart (e.g. X-bar R, X-bar S, p-chart, c-chart) for SPC methodology analysis."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Whether the process is currently out of statistical control — triggers immediate investigation."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Whether the control chart meets GMP requirements — regulatory compliance dimension."
    - name: "characteristic"
      expr: characteristic
      comment: "Quality characteristic being monitored (e.g. fill weight, pH, viscosity) for parameter-level analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the control chart became effective, for SPC program evolution tracking."
  measures:
    - name: "total_control_charts"
      expr: COUNT(1)
      comment: "Total number of active control charts. Measures breadth of SPC program coverage."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END)
      comment: "Count of processes currently out of statistical control. Immediate quality intervention trigger."
    - name: "out_of_control_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitored processes out of control. Process stability portfolio KPI for manufacturing leadership."
    - name: "avg_cpk"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) across all control charts. Core manufacturing quality KPI — target Cpk >= 1.33."
    - name: "avg_ppk"
      expr: AVG(CAST(ppk_value AS DOUBLE))
      comment: "Average process performance index (Ppk). Measures actual process performance including long-term variation."
    - name: "avg_sigma_level"
      expr: AVG(CAST(sigma_level AS DOUBLE))
      comment: "Average sigma level across monitored processes. Six Sigma program performance KPI."
    - name: "avg_process_capability_cpk"
      expr: AVG(CAST(process_capability_cpk AS DOUBLE))
      comment: "Average process capability Cpk from the process_capability_cpk field. Tracks capability improvement over time."
    - name: "gmp_compliant_chart_count"
      expr: COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END)
      comment: "Count of control charts meeting GMP requirements. Tracks SPC program regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_gmp_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures GMP audit program performance including audit outcomes, finding rates, CAPA requirements, and follow-up audit rates — core regulatory compliance and supplier quality KPIs."
  source: "`vibe_consumer_goods_v1`.`quality`.`gmp_audit`"
  dimensions:
    - name: "gmp_audit_status"
      expr: gmp_audit_status
      comment: "Current status of the GMP audit (e.g. Planned, In Progress, Completed, Closed)."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of GMP audit (e.g. Internal, Supplier, Regulatory) for audit program segmentation."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall result of the GMP audit (e.g. Satisfactory, Conditional, Unsatisfactory)."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall rating assigned to the audited entity — drives supplier qualification and risk decisions."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether a CAPA was required as a result of the audit — signals quality deficiencies found."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required — indicates unresolved findings from the current audit."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of the GMP audit, for audit program throughput and scheduling analysis."
  measures:
    - name: "total_gmp_audits"
      expr: COUNT(1)
      comment: "Total number of GMP audits conducted. Baseline audit program activity KPI."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA. Measures volume of quality deficiencies found during GMP audits."
    - name: "follow_up_audit_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Count of audits requiring follow-up. Indicates unresolved findings and ongoing compliance risk."
    - name: "capa_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GMP audits requiring CAPA. Measures audit finding severity rate across the audit program."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up. Tracks unresolved compliance issues in the audit portfolio."
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers audited. Measures GMP audit program coverage of the supply base."
    - name: "distinct_facilities_audited"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Count of distinct manufacturing facilities audited. Tracks internal GMP audit program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures incoming and in-process inspection performance including pass rates, sample quantities, and regulatory hold rates — drives supplier quality and inbound quality control decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot (e.g. Active, Completed, Rejected, On Hold)."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Incoming, In-Process, Final, Stability) for inspection workload segmentation."
    - name: "usage_decision"
      expr: usage_decision
      comment: "Final usage decision for the lot (Accept, Reject, Rework, Scrap) — core disposition KPI dimension."
    - name: "disposition_outcome"
      expr: disposition_outcome
      comment: "Outcome of the disposition decision, for quality yield analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the lot is under regulatory hold — tracks compliance risk in inventory."
    - name: "inspection_start_date_month"
      expr: DATE_TRUNC('month', inspection_start_date)
      comment: "Month inspection started, for throughput and cycle time trending."
    - name: "lot_origin_type"
      expr: lot_origin_type
      comment: "Origin type of the lot (e.g. Purchased, Manufactured, Returned) for source-based quality analysis."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots. Baseline inspection throughput metric."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity across all inspection lots. Measures volume of product under quality inspection."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total quantity sampled across inspection lots. Tracks sampling intensity and resource consumption."
    - name: "regulatory_hold_lot_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Count of lots under regulatory hold. Tracks compliance risk and potential supply disruption."
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots under regulatory hold. Regulatory risk concentration KPI."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN usage_decision IN ('Reject', 'Scrap') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots rejected or scrapped. Core incoming quality KPI for supplier management."
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot quantity at inspection. Benchmarks typical batch sizes entering the quality process."
    - name: "defect_count_total"
      expr: COUNT(CASE WHEN usage_decision IN ('Reject', 'Scrap', 'Rework') THEN 1 END)
      comment: "Count of lots with defect-driven dispositions (reject/scrap/rework). Aggregate quality failure volume."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures inspection result outcomes including out-of-spec rates, control chart violations, and measurement performance — drives process capability monitoring and quality control decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "inspection_result_status"
      expr: inspection_result_status
      comment: "Status of the inspection result (e.g. Pass, Fail, Pending Review)."
    - name: "result_valuation"
      expr: result_valuation
      comment: "Valuation of the result (e.g. Accepted, Rejected) for disposition analysis."
    - name: "is_within_spec"
      expr: is_within_spec
      comment: "Whether the measured value is within specification limits — primary quality pass/fail dimension."
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Whether the result triggered a control chart rule violation — signals process out-of-control condition."
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of defect if result is out of spec — for root-cause trend analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection — for method performance benchmarking."
    - name: "inspection_timestamp_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection, for quality trend analysis over time."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results. Baseline inspection throughput and workload KPI."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_within_spec = FALSE THEN 1 END)
      comment: "Count of results outside specification limits. Core quality failure volume KPI."
    - name: "out_of_spec_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_within_spec = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection results outside specification. Process quality rate KPI — drives process improvement."
    - name: "control_chart_violation_count"
      expr: COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END)
      comment: "Count of control chart rule violations. Signals process instability requiring immediate investigation."
    - name: "control_chart_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results triggering control chart violations. Process stability KPI for SPC programs."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results. Tracks central tendency of process output."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value. Benchmarks process performance against specification targets."
    - name: "regulatory_reportable_result_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of inspection results requiring regulatory reporting. Tracks compliance obligation volume."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_lab_test_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory testing KPIs tracking request volume, turnaround time performance, priority distribution, and regulatory compliance to steer lab capacity planning and quality testing SLA management."
  source: "`vibe_consumer_goods_v1`.`quality`.`lab_test_request`"
  dimensions:
    - name: "lab_test_request_status"
      expr: lab_test_request_status
      comment: "Current request status (pending, in-progress, completed, cancelled) for lab pipeline management."
    - name: "request_type"
      expr: request_type
      comment: "Type of test request (routine, stability, complaint, regulatory) for workload segmentation."
    - name: "test_type"
      expr: test_type
      comment: "Type of test being performed for capacity planning by test category."
    - name: "priority"
      expr: priority
      comment: "Request priority level for SLA management and resource allocation."
    - name: "lab_type"
      expr: lab_type
      comment: "Type of laboratory (internal, external, contract) for make-vs-buy analysis."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department submitting the test request for demand analysis and chargeback."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Flag for regulatory-mandated tests; ensures compliance testing is prioritised and tracked."
    - name: "requested_date_month"
      expr: DATE_TRUNC('month', requested_date)
      comment: "Month request was submitted for demand trend and capacity planning analysis."
  measures:
    - name: "total_test_requests"
      expr: COUNT(1)
      comment: "Total lab test requests submitted; baseline lab demand and workload volume indicator."
    - name: "regulatory_required_requests"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Regulatory-mandated test requests; ensures compliance testing coverage and prioritisation."
    - name: "avg_actual_turnaround_hours"
      expr: AVG(CAST(actual_turnaround_time_hours AS DOUBLE))
      comment: "Average actual turnaround time in hours; key lab SLA performance indicator for quality decision speed."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity submitted for testing; drives lab consumable and reagent demand planning."
    - name: "gmp_compliant_requests"
      expr: COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END)
      comment: "Test requests meeting GMP compliance requirements; tracks regulatory testing programme adherence."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks nonconformance events to measure quality failure rates, financial impact, and resolution efficiency across facilities, suppliers, and SKUs."
  source: "`vibe_consumer_goods_v1`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance record (e.g. Open, Closed, In Review) for pipeline analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance event, used to prioritize response and escalation."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect driving the nonconformance, enabling root-cause trend analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (e.g. incoming inspection, in-process, customer complaint)."
    - name: "is_gmp_related"
      expr: is_gmp_related
      comment: "Flag indicating whether the nonconformance is GMP-related, critical for regulatory risk tracking."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the nonconformance must be reported to a regulatory authority."
    - name: "reported_date"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month the nonconformance was reported, for trend analysis over time."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance events. Baseline KPI for quality failure volume."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by nonconformances. Drives scrap/rework cost estimation."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances in reporting currency. Key cost-of-quality KPI."
    - name: "avg_financial_impact_per_nc"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance event. Benchmarks severity of quality failures."
    - name: "gmp_related_nonconformance_count"
      expr: COUNT(CASE WHEN is_gmp_related = TRUE THEN 1 END)
      comment: "Count of GMP-related nonconformances. Directly informs regulatory risk posture and audit readiness."
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of nonconformances requiring regulatory reporting. Tracks compliance exposure."
    - name: "open_nonconformance_count"
      expr: COUNT(CASE WHEN nonconformance_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open/unresolved nonconformances. Operational backlog KPI for quality teams."
    - name: "gmp_nonconformance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_gmp_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances that are GMP-related. Regulatory risk concentration metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks consumer and trade product complaints including volume, severity, regulatory reportability, and resolution performance — a critical customer satisfaction and regulatory compliance KPI set."
  source: "`vibe_consumer_goods_v1`.`quality`.`product_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the product complaint (e.g. Open, Under Investigation, Closed)."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g. Safety, Quality, Labeling) for root-cause trend analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the complaint — drives escalation, regulatory reporting, and recall risk assessment."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel of the complaint (e.g. Consumer, Retailer, Regulator) for channel-specific quality analysis."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the complaint must be reported to a regulatory authority — tracks compliance exposure."
    - name: "is_adverse_event"
      expr: is_adverse_event
      comment: "Whether the complaint constitutes an adverse event — highest severity classification for safety monitoring."
    - name: "received_date_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month complaint was received, for volume trending and seasonal pattern detection."
    - name: "product_complaint_status"
      expr: product_complaint_status
      comment: "Detailed product complaint lifecycle status for pipeline management."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of product complaints. Baseline consumer quality signal and brand risk KPI."
    - name: "adverse_event_count"
      expr: COUNT(CASE WHEN is_adverse_event = TRUE THEN 1 END)
      comment: "Count of complaints classified as adverse events. Highest-priority safety KPI — triggers regulatory reporting."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting. Tracks compliance obligation volume."
    - name: "adverse_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_adverse_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints classified as adverse events. Safety risk concentration KPI for executive review."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open/unresolved complaints. Operational backlog and customer satisfaction risk indicator."
    - name: "total_complaint_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount associated with product complaints. Quantifies cost-of-quality from consumer issues."
    - name: "repeat_complaint_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with complaints. Identifies breadth of product quality issues across the portfolio."
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints requiring regulatory reporting. Regulatory compliance burden rate KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study KPIs tracking study portfolio, out-of-specification and out-of-trend rates, shelf life commitments, and storage condition coverage to steer product lifecycle and regulatory submission planning."
  source: "`vibe_consumer_goods_v1`.`quality`.`quality_stability_study`"
  dimensions:
    - name: "quality_stability_study_status"
      expr: quality_stability_study_status
      comment: "Current study status (ongoing, completed, cancelled) for portfolio management."
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (accelerated, long-term, stress) for regulatory programme segmentation."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition (25°C/60%RH, 40°C/75%RH) for ICH climatic zone analysis."
    - name: "ich_climatic_zone"
      expr: ich_climatic_zone
      comment: "ICH climatic zone for market-specific shelf life and regulatory submission planning."
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region for market-specific stability data requirements."
    - name: "product_category"
      expr: product_category
      comment: "Product category for portfolio-level stability programme analysis."
    - name: "stability_commitment_flag"
      expr: stability_commitment_flag
      comment: "Flag for studies with regulatory stability commitments; drives mandatory testing schedule compliance."
    - name: "study_start_date_month"
      expr: DATE_TRUNC('month', study_start_date)
      comment: "Month study started for portfolio timeline and resource planning."
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total stability studies in portfolio; baseline regulatory compliance programme volume."
    - name: "out_of_specification_studies"
      expr: COUNT(CASE WHEN out_of_specification_flag = TRUE THEN 1 END)
      comment: "Studies with out-of-specification results; critical indicator for shelf life risk and regulatory action."
    - name: "out_of_trend_studies"
      expr: COUNT(CASE WHEN out_of_trend_flag = TRUE THEN 1 END)
      comment: "Studies showing out-of-trend results; early warning indicator for potential shelf life failures."
    - name: "commitment_studies"
      expr: COUNT(CASE WHEN stability_commitment_flag = TRUE THEN 1 END)
      comment: "Studies with regulatory stability commitments; mandatory programme compliance tracking."
    - name: "avg_storage_temperature"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across studies; validates storage condition compliance."
    - name: "avg_storage_humidity"
      expr: AVG(CAST(storage_humidity_pct AS DOUBLE))
      comment: "Average storage humidity across studies; validates ICH storage condition adherence."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity percentage across stability studies; supports storage condition monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_regulatory_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures regulatory hold volume, financial impact, held quantities, and release performance — critical for supply chain risk management and regulatory compliance tracking."
  source: "`vibe_consumer_goods_v1`.`quality`.`regulatory_hold`"
  dimensions:
    - name: "regulatory_hold_status"
      expr: regulatory_hold_status
      comment: "Current status of the regulatory hold (e.g. Active, Released, Cancelled)."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of regulatory hold (e.g. Quality, Regulatory, Safety) for hold portfolio segmentation."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for the hold — enables root-cause analysis of hold triggers."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the regulatory hold — drives escalation and release prioritization."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required for this hold — tracks compliance obligations."
    - name: "hold_start_date_month"
      expr: DATE_TRUNC('month', hold_start_date)
      comment: "Month the hold was initiated, for hold volume trending and supply impact analysis."
  measures:
    - name: "total_regulatory_holds"
      expr: COUNT(1)
      comment: "Total number of regulatory holds. Baseline compliance risk and supply disruption KPI."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN regulatory_hold_status = 'Active' THEN 1 END)
      comment: "Count of currently active regulatory holds. Real-time supply risk and compliance exposure metric."
    - name: "total_held_quantity"
      expr: SUM(CAST(held_quantity AS DOUBLE))
      comment: "Total quantity under regulatory hold. Measures supply at risk due to quality or regulatory issues."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of regulatory holds. Quantifies cost of compliance failures and supply disruptions."
    - name: "avg_financial_impact_per_hold"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per regulatory hold. Benchmarks severity of individual hold events."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of holds requiring regulatory notification. Tracks compliance obligation volume from hold events."
    - name: "distinct_skus_on_hold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs under regulatory hold. Measures breadth of product portfolio at risk."
    - name: "distinct_suppliers_on_hold"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers with active holds. Tracks supply base compliance risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specification management KPIs tracking active specification coverage, critical quality attributes, regulatory basis, and review cadence to steer quality standards governance and product compliance."
  source: "`vibe_consumer_goods_v1`.`quality`.`specification`"
  dimensions:
    - name: "specification_status"
      expr: specification_status
      comment: "Current specification status (approved, draft, obsolete) for governance pipeline management."
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (raw material, finished product, packaging) for coverage analysis."
    - name: "specification_category"
      expr: specification_category
      comment: "Category of specification for portfolio segmentation and review prioritisation."
    - name: "material_type"
      expr: material_type
      comment: "Material type covered by the specification for supply chain quality alignment."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. obsolete specifications."
    - name: "critical_quality_attribute_flag"
      expr: critical_quality_attribute_flag
      comment: "Flag for critical quality attributes (CQAs) requiring enhanced monitoring and control."
    - name: "stability_indicating_flag"
      expr: stability_indicating_flag
      comment: "Flag for stability-indicating parameters requiring inclusion in stability programmes."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month specification became effective for governance timeline analysis."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total specifications in the quality system; baseline quality standards coverage indicator."
    - name: "active_specifications"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Active specifications; measures current quality standards coverage for products and materials."
    - name: "critical_quality_attribute_specs"
      expr: COUNT(CASE WHEN critical_quality_attribute_flag = TRUE THEN 1 END)
      comment: "Specifications covering critical quality attributes; drives enhanced monitoring and control programme scope."
    - name: "stability_indicating_specs"
      expr: COUNT(CASE WHEN stability_indicating_flag = TRUE THEN 1 END)
      comment: "Stability-indicating specifications; determines stability programme testing scope and regulatory submission content."
    - name: "customer_requirement_specs"
      expr: COUNT(CASE WHEN customer_requirement_flag = TRUE THEN 1 END)
      comment: "Specifications driven by customer requirements; links quality standards to commercial obligations."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average specification target value; used for portfolio-level specification tightness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_stability_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures product stability testing outcomes including out-of-specification rates, shelf-life impact, and trend flags — critical for product registration, shelf-life claims, and regulatory submissions."
  source: "`vibe_consumer_goods_v1`.`quality`.`stability_result`"
  dimensions:
    - name: "stability_result_status"
      expr: stability_result_status
      comment: "Current status of the stability result (e.g. Pass, Fail, Pending Review)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/Fail outcome of the stability test — primary quality disposition dimension."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition under which the stability test was conducted (e.g. 25C/60%RH, 40C/75%RH)."
    - name: "out_of_specification_flag"
      expr: out_of_specification_flag
      comment: "Whether the result is out of specification — triggers regulatory notification and shelf-life review."
    - name: "shelf_life_impact_flag"
      expr: shelf_life_impact_flag
      comment: "Whether the result impacts the approved shelf life — critical for product registration maintenance."
    - name: "trend_flag"
      expr: trend_flag
      comment: "Whether an adverse stability trend has been detected — early warning for OOS risk."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of stability testing, for longitudinal stability program tracking."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether the result has been included in a regulatory submission — tracks dossier completeness."
  measures:
    - name: "total_stability_results"
      expr: COUNT(1)
      comment: "Total number of stability test results. Baseline stability program throughput metric."
    - name: "out_of_specification_count"
      expr: COUNT(CASE WHEN out_of_specification_flag = TRUE THEN 1 END)
      comment: "Count of out-of-specification stability results. Triggers regulatory notification and shelf-life review."
    - name: "oos_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_specification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stability results that are out of specification. Core product quality and regulatory risk KPI."
    - name: "shelf_life_impact_count"
      expr: COUNT(CASE WHEN shelf_life_impact_flag = TRUE THEN 1 END)
      comment: "Count of results impacting approved shelf life. Directly affects product registration and market availability."
    - name: "adverse_trend_count"
      expr: COUNT(CASE WHEN trend_flag = TRUE THEN 1 END)
      comment: "Count of results with adverse stability trends. Early warning KPI for proactive shelf-life management."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured stability parameter value. Tracks central tendency of stability performance over time."
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average deviation percentage from specification target. Quantifies magnitude of stability drift."
    - name: "distinct_skus_in_stability"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with stability results. Measures breadth of stability program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_supplier_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures supplier quality assessment scores, approval rates, and risk ratings — drives supplier qualification decisions and procurement risk management."
  source: "`vibe_consumer_goods_v1`.`quality`.`supplier_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of supplier assessment (e.g. Initial Qualification, Periodic Review, For-Cause) for segmentation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Completed, In Progress, Pending) for pipeline management."
    - name: "asl_status"
      expr: asl_status
      comment: "Approved Supplier List status resulting from the assessment — drives procurement eligibility."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier based on assessment results — key procurement risk dimension."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the supplier is approved following the assessment — binary qualification outcome."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether a CAPA was required as a result of the assessment — signals quality deficiencies."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment, for supplier qualification throughput trending."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of supplier assessments conducted. Baseline supplier quality program activity KPI."
    - name: "approved_supplier_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Count of assessments resulting in supplier approval. Measures qualification throughput."
    - name: "supplier_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in approval. Supplier quality pass rate — low rates signal supply risk."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier quality score. Benchmarks supplier quality performance across the supply base."
    - name: "avg_gmp_compliance_score"
      expr: AVG(CAST(gmp_compliance_score AS DOUBLE))
      comment: "Average GMP compliance score across supplier assessments. Regulatory quality baseline for the supply base."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality system score. Tracks quality maturity of the supplier base over time."
    - name: "capa_required_assessment_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments requiring CAPA. Measures volume of supplier quality deficiencies needing remediation."
    - name: "distinct_suppliers_assessed"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers assessed. Measures coverage of the supplier qualification program."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score from supplier assessments. Tracks supply reliability alongside quality."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_usage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage decision KPIs tracking acceptance, rejection, and rework quantities, GMP compliance, and decision quality to steer inventory disposition and supply chain quality outcomes."
  source: "`vibe_consumer_goods_v1`.`quality`.`usage_decision`"
  dimensions:
    - name: "usage_decision_status"
      expr: usage_decision_status
      comment: "Current usage decision status for disposition pipeline management."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of usage decision (accept, reject, rework, retest) for disposition outcome analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the material for supply chain impact assessment."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection triggering the usage decision for quality programme segmentation."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for regulatory quality segmentation of decisions."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flag for decisions involving regulatory holds for compliance risk tracking."
    - name: "decision_date_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month decision was made for throughput trend and cycle time analysis."
  measures:
    - name: "total_usage_decisions"
      expr: COUNT(1)
      comment: "Total usage decisions made; baseline quality disposition throughput indicator."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted for use; measures quality-approved supply output."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected; key yield loss and cost of poor quality indicator."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity sent for rework; measures rework burden and associated cost."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total accepted quantity from the quantity_accepted field; cross-validates acceptance volume."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total rejected quantity from the quantity_rejected field; cross-validates rejection volume."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score at time of usage decision; tracks quality level of material being dispositioned."
    - name: "gmp_compliant_decisions"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Usage decisions meeting GMP compliance; regulatory quality disposition compliance rate numerator."
$$;
