-- Metric views for domain: material | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_approved_material_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved material list (AML) metrics tracking material approval status, cost, substitution rates, and compliance certificate validity. Supports procurement governance, specification compliance, and project material readiness decisions."
  source: "`vibe_construction_v1`.`material`.`approved_material_list`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing approved materials to specific construction projects."
    - name: "approved_material_list_status"
      expr: approved_material_list_status
      comment: "Status of the AML entry (e.g. approved, pending, expired, revoked) for approval pipeline management."
    - name: "material_category"
      expr: material_category
      comment: "Category of the approved material for analysis by material type."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the approved material for supplier and manufacturer performance analysis."
    - name: "is_primary_material"
      expr: is_primary_material
      comment: "Flag indicating whether this is the primary approved material or an alternative."
    - name: "is_substituted"
      expr: is_substituted
      comment: "Flag indicating whether the material has been substituted from the original specification."
    - name: "substitution_allowed"
      expr: substitution_allowed
      comment: "Flag indicating whether substitution is permitted for this material entry."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous materials in the AML for compliance monitoring."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase for which the material is approved, enabling phase-level material readiness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the material cost for multi-currency financial reporting."
  measures:
    - name: "total_approved_materials"
      expr: COUNT(1)
      comment: "Total number of approved material list entries. Baseline metric for AML coverage and procurement governance scope."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity of materials approved for use. Supports procurement planning and budget estimation."
    - name: "total_approved_value"
      expr: SUM(approved_quantity * cost_per_unit)
      comment: "Total estimated value of approved materials (quantity × unit cost). Used for project material budget planning and cost commitment tracking."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost of approved materials. Used for cost benchmarking and procurement negotiation reference."
    - name: "substituted_material_count"
      expr: COUNT(CASE WHEN is_substituted = TRUE THEN 1 END)
      comment: "Number of AML entries where the material has been substituted. High substitution rates may indicate specification issues or supply-chain disruption."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_substituted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approved materials that have been substituted from the original specification. A key procurement governance and quality compliance KPI."
    - name: "expired_compliance_certificate_count"
      expr: COUNT(CASE WHEN compliance_certificate_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of AML entries with expired compliance certificates. Expired certificates represent a regulatory and quality risk requiring immediate renewal."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous materials in the approved material list. Supports HSE planning and regulatory compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_batch_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch and lot traceability metrics tracking material quality, inspection outcomes, quarantine status, and cost by batch. Supports quality management, regulatory compliance, and supply-chain traceability decisions."
  source: "`vibe_construction_v1`.`material`.`batch_lot`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing batch lots to specific construction projects."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where the batch lot is stored, for location-based quality analysis."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch lot (e.g. active, quarantined, expired, consumed)."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status of the batch lot, used to identify materials held pending quality resolution."
    - name: "material_type"
      expr: material_type
      comment: "Type of material in the batch lot for quality analysis by material category."
    - name: "supplier"
      expr: supplier
      comment: "Supplier of the batch lot for supplier quality performance analysis."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the batch lot for manufacturer quality benchmarking."
    - name: "currency"
      expr: currency
      comment: "Currency of the batch lot cost for multi-currency financial reporting."
  measures:
    - name: "total_batch_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all batch lots. Baseline inventory volume metric for batch-level stock management."
    - name: "total_batch_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total financial cost of all batch lots. Used for inventory valuation and cost-of-quality analysis."
    - name: "inspection_pass_count"
      expr: COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END)
      comment: "Number of batch lots that passed quality inspection. Measures supplier and material quality performance."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_passed = TRUE THEN 1 END)
      comment: "Number of batch lots that passed laboratory testing. Supports quality assurance and regulatory compliance reporting."
    - name: "quarantine_batch_count"
      expr: COUNT(CASE WHEN quarantine_status != 'RELEASED' AND quarantine_status IS NOT NULL THEN 1 END)
      comment: "Number of batch lots currently in quarantine. Quarantined batches represent blocked inventory and potential project delay risk."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_passed IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of inspected batch lots that passed quality inspection. Primary supplier quality KPI used in vendor performance management."
    - name: "avg_batch_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per batch lot. Used for cost benchmarking and procurement negotiation."
    - name: "total_batch_lots"
      expr: COUNT(1)
      comment: "Total number of batch lot records. Baseline volume metric for traceability coverage analysis."
    - name: "lot_traceability_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lot_traceability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batch lots with full traceability enabled. Regulatory compliance KPI for material provenance and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_conformance_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material conformance and test certificate metrics. Tracks compliance status, test results, and certificate validity to support quality assurance, regulatory compliance, and project handover readiness."
  source: "`vibe_construction_v1`.`material`.`conformance_certificate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing conformance certificates to specific construction projects."
    - name: "conformance_certificate_status"
      expr: conformance_certificate_status
      comment: "Status of the conformance certificate (e.g. active, expired, revoked) for validity tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certificate (e.g. compliant, non-compliant, pending) for regulatory reporting."
    - name: "material_type"
      expr: material_type
      comment: "Type of material covered by the certificate for quality analysis by material category."
    - name: "test_result"
      expr: test_result
      comment: "Test result (e.g. pass, fail, conditional) for quality performance analysis."
    - name: "test_method"
      expr: test_method
      comment: "Test method applied for methodology-level quality analysis."
    - name: "issuing_lab"
      expr: issuing_lab
      comment: "Laboratory that issued the certificate for lab performance benchmarking."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the certificate is currently active and valid."
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of conformance certificates. Baseline metric for quality documentation coverage."
    - name: "compliant_certificate_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of certificates with compliant status. Measures the proportion of materials meeting regulatory and specification requirements."
    - name: "non_compliant_certificate_count"
      expr: COUNT(CASE WHEN compliance_status != 'COMPLIANT' THEN 1 END)
      comment: "Number of non-compliant certificates. Each non-compliant certificate represents a quality or regulatory risk requiring management action."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conformance certificates with compliant status. Primary material quality compliance KPI for project handover and regulatory reporting."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_result = 'PASS' THEN 1 END)
      comment: "Number of certificates where the material test result was a pass. Measures material quality performance at the test level."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'PASS' THEN 1 END) / NULLIF(COUNT(CASE WHEN test_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of material tests that passed. Key quality assurance KPI used in project quality reviews and client reporting."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value across conformance certificates. Used for quality benchmarking against specification thresholds."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded during testing. Supports environmental condition analysis for temperature-sensitive material quality assurance."
    - name: "expired_certificate_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of conformance certificates that have expired. Expired certificates represent a compliance risk and must be renewed before project handover."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and issue metrics at the project and activity level. Tracks quantities issued, financial value of consumption, return rates, and inspection compliance to support cost control and material efficiency management."
  source: "`vibe_construction_v1`.`material`.`goods_issue`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing material consumption to specific construction projects."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Source warehouse for the goods issue, enabling warehouse-level consumption analysis."
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Status of the goods issue (e.g. posted, pending, cancelled) for pipeline and backlog analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the goods issue, used to identify unapproved or pending issues."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Reason for the goods issue (e.g. construction, maintenance, return) for consumption categorisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue financial values."
    - name: "is_returned"
      expr: is_returned
      comment: "Flag indicating whether the goods issue is a return transaction, enabling return rate analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status at issue, used to track compliance of material releases."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of issued material for safety and compliance reporting."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for attributing material consumption to specific work breakdown structure elements."
  measures:
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of materials issued from warehouse. Primary material consumption KPI for project cost-to-complete and budget tracking."
    - name: "total_gross_issue_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross financial value of materials issued. Used for project cost tracking and budget variance analysis."
    - name: "total_net_issue_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net financial value of materials issued after tax. Core project material cost metric for financial reporting."
    - name: "total_tax_on_issues"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues. Supports tax liability and financial reconciliation reporting."
    - name: "total_goods_issues"
      expr: COUNT(1)
      comment: "Total number of goods issue transactions. Baseline volume metric for operational throughput analysis."
    - name: "return_issue_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of goods issues that are return transactions. High return rates indicate over-issuing, poor planning, or quality problems."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods issues that are returns. A high return rate signals material planning inefficiency or quality issues requiring corrective action."
    - name: "avg_net_issue_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per goods issue transaction. Benchmarks typical issue size for material planning and cost estimation."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of goods issues requiring quality inspection before release. Supports quality control workload planning."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status != 'APPROVED' THEN 1 END)
      comment: "Number of goods issues not yet approved. Unapproved issues represent a financial control risk and potential project delay."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_hazmat_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous material inventory and compliance metrics. Tracks quantities, hazard classifications, inspection status, and regulatory compliance for hazardous materials on site to support HSE management and regulatory reporting."
  source: "`vibe_construction_v1`.`material`.`hazmat_register`"
  dimensions:
    - name: "site_id"
      expr: site_id
      comment: "Site identifier for attributing hazardous material holdings to specific construction sites."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where the hazardous material is stored for location-based compliance monitoring."
    - name: "hazmat_register_status"
      expr: hazmat_register_status
      comment: "Status of the hazmat register entry (e.g. active, disposed, expired) for inventory management."
    - name: "material_type"
      expr: material_type
      comment: "Type of hazardous material for classification-level risk analysis."
    - name: "un_hazard_class"
      expr: un_hazard_class
      comment: "UN hazard class of the material for regulatory classification and transport compliance."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the hazardous material for prioritised risk management."
    - name: "hse_notification_status"
      expr: hse_notification_status
      comment: "HSE notification status for tracking regulatory notification compliance."
    - name: "is_flammable"
      expr: is_flammable
      comment: "Flag indicating flammable materials for fire risk management."
    - name: "is_toxic"
      expr: is_toxic
      comment: "Flag indicating toxic materials for health risk management."
    - name: "storage_temperature_controlled"
      expr: storage_temperature_controlled
      comment: "Flag indicating whether temperature-controlled storage is required for compliance."
  measures:
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of hazardous materials currently on site. Primary regulatory compliance metric for hazmat inventory reporting."
    - name: "total_hazmat_entries"
      expr: COUNT(1)
      comment: "Total number of hazardous material register entries. Baseline metric for hazmat inventory scope and compliance coverage."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due < CURRENT_DATE() THEN 1 END)
      comment: "Number of hazmat entries with overdue inspections. Overdue inspections represent a direct regulatory compliance and safety risk requiring immediate action."
    - name: "flammable_material_quantity"
      expr: SUM(CASE WHEN is_flammable = TRUE THEN quantity_on_site ELSE 0 END)
      comment: "Total quantity of flammable hazardous materials on site. Critical fire risk KPI for site safety management and emergency planning."
    - name: "toxic_material_quantity"
      expr: SUM(CASE WHEN is_toxic = TRUE THEN quantity_on_site ELSE 0 END)
      comment: "Total quantity of toxic hazardous materials on site. Health risk KPI for HSE management and regulatory reporting."
    - name: "radioactive_material_quantity"
      expr: SUM(CASE WHEN is_radioactive = TRUE THEN quantity_on_site ELSE 0 END)
      comment: "Total quantity of radioactive materials on site. Highest-priority regulatory compliance KPI requiring mandatory reporting to authorities."
    - name: "inspection_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_inspection_due >= CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazmat entries with current (non-overdue) inspections. Primary HSE compliance KPI for hazardous material management."
    - name: "avg_temperature_max_celsius"
      expr: AVG(CAST(temperature_max_celsius AS DOUBLE))
      comment: "Average maximum storage temperature threshold across hazmat entries. Used for storage compliance monitoring and facility planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material take-off (MTO) line metrics tracking design quantities, procurement status, cost estimates, and variance against actual receipts. Supports project material planning, procurement readiness, and cost-to-complete analysis."
  source: "`vibe_construction_v1`.`material`.`mto_line`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing MTO lines to specific construction projects."
    - name: "mto_status"
      expr: mto_status
      comment: "Status of the MTO line (e.g. draft, approved, procured, received) for pipeline tracking."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement status of the MTO line for tracking progress from design to delivery."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. civil, mechanical, electrical) for MTO analysis by trade."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the MTO line is on the critical path, enabling prioritised procurement monitoring."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous materials in the MTO for compliance and safety planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MTO line cost estimates for multi-currency financial reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for MTO quantities."
  measures:
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total design quantity across MTO lines. Baseline material demand from engineering design, used for procurement planning and budget estimation."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net required quantity after accounting for stock on hand and committed orders. The actionable procurement demand figure."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity actually received against MTO lines. Measures procurement delivery performance against design requirements."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MTO lines. Primary material budget commitment metric for project cost management."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between design and actual received quantities. Positive variance indicates under-delivery; negative indicates over-delivery."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance on MTO lines. Directly impacts project budget and triggers cost control interventions."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across MTO lines. Used for cost benchmarking and procurement negotiation reference."
    - name: "critical_mto_line_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of MTO lines on the critical path. Enables focused procurement and delivery monitoring for schedule-critical materials."
    - name: "receipt_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(net_required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of net required quantity actually received. Primary MTO delivery performance KPI used in project progress reviews."
    - name: "avg_wastage_factor"
      expr: AVG(CAST(wastage_factor AS DOUBLE))
      comment: "Average wastage factor applied to MTO lines. Benchmarks material efficiency assumptions in design and supports sustainability target-setting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy and variance metrics. Tracks discrepancies between system book quantities and physical counts to support inventory accuracy management, audit compliance, and loss prevention."
  source: "`vibe_construction_v1`.`material`.`physical_inventory`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing inventory counts to specific construction projects."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse identifier for analysing inventory accuracy by storage location."
    - name: "physical_inventory_status"
      expr: physical_inventory_status
      comment: "Status of the physical inventory count (e.g. in-progress, completed, posted) for count cycle management."
    - name: "count_type"
      expr: count_type
      comment: "Type of inventory count (e.g. cycle count, full count, spot check) for methodology analysis."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating records requiring a recount due to discrepancy, used to track count quality."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory count quantities."
    - name: "warehouse_code"
      expr: warehouse_code
      comment: "Warehouse code for grouping inventory accuracy metrics by warehouse."
  measures:
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted during inventory. Baseline for inventory accuracy assessment."
    - name: "total_system_book_quantity"
      expr: SUM(CAST(system_book_quantity AS DOUBLE))
      comment: "Total system book quantity at time of count. Used as the reference for variance calculation."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between physical count and system book. Large variances indicate inventory control failures, theft, or system errors."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Primary inventory accuracy KPI for financial audit and loss prevention management."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_flag = TRUE THEN 1 END)
      comment: "Number of inventory lines requiring a recount. High recount rates indicate counting process quality issues."
    - name: "inventory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_quantity = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory lines with zero variance between physical count and system book. The primary inventory accuracy KPI for warehouse management performance."
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average financial variance per inventory line. Benchmarks typical discrepancy magnitude for risk assessment."
    - name: "total_inventory_lines_counted"
      expr: COUNT(1)
      comment: "Total number of inventory lines counted. Baseline metric for count coverage and audit completeness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requisition pipeline and fulfilment metrics. Tracks requisition volumes, cost estimates, approval cycle performance, and emergency demand to support procurement planning and project material readiness."
  source: "`vibe_construction_v1`.`material`.`requisition`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing requisitions to specific construction projects."
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g. draft, approved, fulfilled, cancelled) for pipeline analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requisition for identifying bottlenecks in the approval workflow."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the requisition for tracking delivery against demand."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition (e.g. urgent, normal, low) for demand triage and resource allocation."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating emergency requisitions, which carry higher cost and schedule risk."
    - name: "requester_department"
      expr: requester_department
      comment: "Department raising the requisition for demand pattern analysis by organisational unit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition cost estimates for multi-currency financial reporting."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for attributing requisition demand to specific work breakdown structure elements."
    - name: "safety_review_status"
      expr: safety_review_status
      comment: "Safety review status of the requisition, used to track compliance with HSE material handling requirements."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of material requisitions raised. Baseline demand volume metric for procurement workload planning."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials requested across all requisitions. Supports demand forecasting and procurement planning."
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross cost estimate of all requisitions. Used for budget commitment forecasting and procurement spend planning."
    - name: "total_cost_estimate_net"
      expr: SUM(CAST(cost_estimate_net AS DOUBLE))
      comment: "Total net cost estimate of all requisitions. Core procurement budget planning metric."
    - name: "total_cost_estimate_tax"
      expr: SUM(CAST(cost_estimate_tax AS DOUBLE))
      comment: "Total estimated tax on requisitions. Supports tax liability forecasting and financial planning."
    - name: "emergency_requisition_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency requisitions. High emergency requisition rates indicate poor material planning and carry premium cost risk."
    - name: "emergency_requisition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions flagged as emergency. A leading indicator of material planning maturity and project schedule risk."
    - name: "pending_approval_requisition_count"
      expr: COUNT(CASE WHEN approval_status != 'APPROVED' AND requisition_status NOT IN ('CANCELLED', 'FULFILLED') THEN 1 END)
      comment: "Number of requisitions awaiting approval. Approval backlog directly delays procurement and risks project schedule."
    - name: "avg_cost_estimate_net"
      expr: AVG(CAST(cost_estimate_net AS DOUBLE))
      comment: "Average net cost estimate per requisition. Benchmarks typical material demand value for budget planning."
    - name: "stock_available_requisition_count"
      expr: COUNT(CASE WHEN is_stock_available = TRUE THEN 1 END)
      comment: "Number of requisitions where stock is already available in warehouse. Indicates the proportion of demand that can be fulfilled without new procurement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability metrics across warehouses and materials. Supports procurement, operations, and supply-chain steering decisions on stock adequacy, reorder triggers, and blocked/reserved inventory."
  source: "`vibe_construction_v1`.`material`.`stock_level`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse identifier for grouping stock positions by storage location."
    - name: "material_code"
      expr: material_code
      comment: "Material code for grouping stock metrics by material type."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for contextualising quantity metrics."
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current status of the stock level record (e.g. active, blocked, quarantine)."
    - name: "location_code"
      expr: location_code
      comment: "Storage location code within the warehouse for granular inventory analysis."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the most recent stock movement, useful for identifying stagnant stock."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across selected warehouses and materials. Primary inventory availability KPI used by procurement and operations to prevent stockouts."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for confirmed demand. Indicates committed stock that cannot be reallocated without impacting project schedules."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked due to quality holds or compliance issues. High blocked stock signals quality or supplier problems requiring management intervention."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or from suppliers. Supports supply-chain visibility and delivery planning."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to purchase orders or work orders. Reflects near-term demand obligations against available stock."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection. Elevated values indicate inspection bottlenecks that may delay project material availability."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across stock positions. Used for inventory valuation benchmarking and cost trend analysis."
    - name: "total_available_quantity"
      expr: SUM(quantity_on_hand - reserved_quantity - blocked_quantity)
      comment: "Net available quantity (on-hand minus reserved and blocked). The most actionable availability metric for procurement and site operations decisions."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock positions where on-hand quantity has fallen below the reorder point. Directly triggers procurement action to avoid project delays."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of stock positions below safety stock threshold. A leading indicator of critical supply risk requiring immediate escalation."
    - name: "stock_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_on_hand AS DOUBLE)) / NULLIF(SUM(CAST(max_stock_level AS DOUBLE)), 0), 2)
      comment: "Percentage of maximum stock capacity currently utilised. Supports warehouse capacity planning and identifies over-stocking risks."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material receipt and movement throughput metrics. Tracks inbound goods flow, financial value of receipts, freight costs, and compliance status to support supply-chain performance management."
  source: "`vibe_construction_v1`.`material`.`stock_movement`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing material movements to specific construction projects."
    - name: "site_id"
      expr: site_id
      comment: "Site identifier for analysing material flow by delivery destination."
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt (e.g. standard, return, transfer) for movement classification."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. posted, pending, rejected) for pipeline analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the movement record, used to flag non-compliant receipts."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status at receipt, used to track inspection pass/fail rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement financial values for multi-currency reporting."
    - name: "material_code"
      expr: material_code
      comment: "Material code for analysing movement volumes and values by material type."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flag indicating whether the material is on the critical path, enabling prioritised monitoring."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous material movements requiring special handling and compliance tracking."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received across all movements. Core throughput KPI for supply-chain performance and project material delivery tracking."
    - name: "total_gross_receipt_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross financial value of material receipts. Used for budget consumption tracking and accounts payable forecasting."
    - name: "total_net_receipt_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net financial value of material receipts after tax. Supports cost-to-complete and project cost management reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on material receipts. Used for tax liability reporting and financial reconciliation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and logistics cost associated with material deliveries. Elevated freight costs signal logistics inefficiency or supply-chain disruption."
    - name: "avg_net_receipt_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per material receipt movement. Benchmarks typical delivery size for procurement planning."
    - name: "delivery_on_time_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Number of material deliveries received on or before the expected delivery date. Key supplier performance indicator."
    - name: "total_receipt_movements"
      expr: COUNT(1)
      comment: "Total number of stock movement records. Baseline volume metric for throughput and workload analysis."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Number of deliveries received after the expected date. Directly impacts project schedule and triggers supplier performance reviews."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND expected_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliveries received on or before the expected date. Primary supplier on-time delivery KPI used in vendor performance scorecards."
    - name: "non_compliant_receipt_count"
      expr: COUNT(CASE WHEN compliance_status != 'COMPLIANT' THEN 1 END)
      comment: "Number of material receipts with a non-compliant compliance status. Regulatory and quality risk indicator requiring management escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-warehouse stock transfer metrics tracking transfer volumes, costs, and on-time performance. Supports logistics planning, inventory rebalancing decisions, and supply-chain efficiency management."
  source: "`vibe_construction_v1`.`material`.`stock_transfer`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing stock transfers to specific construction projects."
    - name: "stock_transfer_status"
      expr: stock_transfer_status
      comment: "Status of the stock transfer (e.g. in-transit, completed, cancelled) for pipeline management."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Reason for the stock transfer (e.g. project demand, rebalancing, return) for logistics analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the transfer (e.g. road, rail, sea) for logistics cost and carbon analysis."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier executing the transfer for carrier performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for transfer quantities."
  measures:
    - name: "total_transfer_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials transferred between warehouses. Primary logistics throughput metric for supply-chain management."
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Baseline volume metric for logistics workload analysis."
    - name: "on_time_transfer_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND DATE(actual_arrival_timestamp) <= expected_arrival_date THEN 1 END)
      comment: "Number of stock transfers completed on or before the expected arrival date. Measures logistics execution performance."
    - name: "late_transfer_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND DATE(actual_arrival_timestamp) > expected_arrival_date THEN 1 END)
      comment: "Number of stock transfers completed after the expected arrival date. Late transfers risk project schedule delays and require logistics intervention."
    - name: "on_time_transfer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND DATE(actual_arrival_timestamp) <= expected_arrival_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND expected_arrival_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed stock transfers delivered on time. Primary logistics performance KPI for supply-chain management reviews."
    - name: "avg_transfer_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per stock transfer. Used for logistics planning and transport capacity optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_wastage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material wastage and loss metrics at project, cost centre, and material level. Tracks wastage quantities, financial cost of waste, recyclability, and hazardous waste to support sustainability, cost control, and regulatory compliance decisions."
  source: "`vibe_construction_v1`.`material`.`wastage`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for attributing wastage to specific construction projects."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (e.g. concrete, steel, timber) for waste stream analysis and sustainability reporting."
    - name: "wastage_status"
      expr: wastage_status
      comment: "Status of the wastage record (e.g. recorded, disposed, pending) for pipeline management."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (e.g. landfill, recycling, incineration) for environmental impact analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous waste, enabling targeted compliance and safety reporting."
    - name: "is_recyclable"
      expr: is_recyclable
      comment: "Flag indicating recyclable waste, supporting sustainability and circular economy KPIs."
    - name: "cause"
      expr: cause
      comment: "Root cause of wastage (e.g. over-ordering, damage, design change) for corrective action targeting."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for attributing wastage costs to specific work breakdown structure elements."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for time-series wastage trend analysis."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the wasted material for regulatory compliance reporting."
  measures:
    - name: "total_wastage_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material wasted. Primary wastage volume KPI for sustainability and material efficiency management."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity of material for the activities generating wastage. Used as the denominator for wastage rate calculations."
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity_consumed AS DOUBLE))
      comment: "Total actual quantity of material consumed including wastage. Supports consumption vs. plan variance analysis."
    - name: "total_waste_cost_gross"
      expr: SUM(CAST(waste_cost_gross AS DOUBLE))
      comment: "Total gross financial cost of material wastage. Directly impacts project profitability and is a key cost control KPI."
    - name: "total_waste_cost_net"
      expr: SUM(CAST(waste_cost_net AS DOUBLE))
      comment: "Total net financial cost of material wastage after adjustments. Used for project cost-to-complete and budget variance reporting."
    - name: "total_waste_cost_adjustment"
      expr: SUM(CAST(waste_cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to wastage records (e.g. credits, recoveries). Supports financial reconciliation of waste costs."
    - name: "avg_wastage_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average wastage percentage across records. Benchmarks material efficiency against industry norms and project targets."
    - name: "hazardous_wastage_quantity"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of hazardous material wasted. Regulatory compliance KPI requiring mandatory reporting and management oversight."
    - name: "recyclable_wastage_quantity"
      expr: SUM(CASE WHEN is_recyclable = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of recyclable material wasted. Sustainability KPI tracking circular economy performance and diversion from landfill."
    - name: "wastage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Wastage as a percentage of planned quantity. The primary material efficiency KPI used in project performance reviews and sustainability reporting."
    - name: "total_wastage_records"
      expr: COUNT(1)
      comment: "Total number of wastage records. Baseline volume metric for waste event frequency analysis."
$$;
