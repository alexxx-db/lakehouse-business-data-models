-- Metric views for domain: supply | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier master KPIs covering risk, quality, financial health, and compliance posture across the supplier base. Used by procurement leadership and supply chain risk teams to tier and manage suppliers."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classifies the supplier (e.g., OEM, distributor, contract manufacturer) for segmented performance analysis."
    - name: "supplier_group"
      expr: supplier_group
      comment: "Commodity or strategic grouping of the supplier for portfolio-level reporting."
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current lifecycle status of the supplier (active, blocked, under review) for operational filtering."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier headquarters for geographic concentration and geopolitical risk analysis."
    - name: "financial_rating"
      expr: financial_rating
      comment: "External financial health rating of the supplier for credit and continuity risk assessment."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and export-control compliance status of the supplier."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the supplier handles ITAR-controlled materials, critical for export compliance gating."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Indicates whether the supplier handles EAR-controlled materials."
    - name: "is_certified_kga"
      expr: is_certified_kga
      comment: "Whether the supplier holds Known Good Assembly certification, relevant for advanced packaging sourcing."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of distinct active suppliers in the approved base. Executives use this to assess supply base breadth and single-source concentration risk."
    - name: "avg_supplier_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all suppliers. A rising average signals deteriorating supply chain resilience and triggers supplier development or diversification actions."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average ESG/sustainability score across the supplier base. Tracked for CHIPS Act compliance and corporate sustainability commitments."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit extended to suppliers, indicating financial exposure and payment risk concentration."
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 70 THEN supplier_id END)
      comment: "Number of suppliers with risk score >= 70. A key watch-list metric for supply chain risk committees and quarterly business reviews."
    - name: "itar_controlled_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN supplier_id END)
      comment: "Count of ITAR-controlled suppliers. Drives export compliance program scope and audit prioritization."
    - name: "pct_compliant_suppliers"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers in compliant status. A leading indicator of supply chain regulatory risk; drops trigger corrective action programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement spend, cycle time, and compliance KPIs derived from purchase orders. Used by CPO, procurement operations, and finance for spend analytics, supplier performance, and working capital management."
  source: "`vibe_semiconductors_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order (open, closed, cancelled) for pipeline and backlog analysis."
    - name: "purchase_order_type"
      expr: purchase_order_type
      comment: "Type of purchase order (standard, blanket, consignment) for spend categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (FOB, CIF, DDP) affecting landed cost and risk transfer point analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for procurement governance and bottleneck identification."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Flags export-controlled purchase orders requiring additional compliance review."
    - name: "purchase_group"
      expr: purchase_group
      comment: "Procurement group responsible for the order, enabling team-level spend accountability."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for trend analysis and spend run-rate reporting."
  measures:
    - name: "total_po_gross_spend"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross procurement spend across all purchase orders. Primary spend metric for CPO dashboards and budget variance analysis."
    - name: "total_po_net_spend"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net procurement spend after discounts. Used for actual cost accounting and supplier rebate tracking."
    - name: "total_po_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax liability on purchase orders. Relevant for VAT reclaim and tax planning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured across purchase orders. Measures negotiation effectiveness and contract compliance."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid across purchase orders. Benchmarked against standard cost to identify price variance and negotiation opportunities."
    - name: "total_po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of distinct purchase orders. Used to assess procurement workload, maverick buying, and process efficiency."
    - name: "avg_po_gross_value"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross value per purchase order. Low averages may indicate excessive PO fragmentation and processing inefficiency."
    - name: "total_freight_spend"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost on purchase orders. Tracked separately for logistics cost optimization and incoterms strategy decisions."
    - name: "ear_controlled_po_count"
      expr: COUNT(DISTINCT CASE WHEN is_ear_controlled = TRUE THEN purchase_order_id END)
      comment: "Number of EAR-controlled purchase orders. Drives export compliance workload planning and license utilization tracking."
    - name: "pct_approved_pos"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN purchase_order_id END) / NULLIF(COUNT(DISTINCT purchase_order_id), 0), 2)
      comment: "Percentage of purchase orders that have received approval. Low rates indicate procurement governance bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit quality, compliance, and corrective action KPIs. Used by supplier quality engineering and procurement leadership to manage audit programs, track findings severity, and drive corrective action closure."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (initial qualification, surveillance, for-cause) for program coverage analysis."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (quality, environmental, export control) for domain-specific compliance tracking."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, closed) for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the audit for regulatory reporting and supplier tiering."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from audit findings. Tracks closure rate and overdue actions."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (excellent, satisfactory, marginal, unsatisfactory) for supplier tiering decisions."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the audited supplier is ITAR-controlled, for export compliance audit program scoping."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit execution for trend and cadence reporting."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(DISTINCT supplier_audit_id)
      comment: "Total number of supplier audits conducted. Measures audit program coverage and cadence against plan."
    - name: "avg_audit_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from supplier audits. Trending upward signals deteriorating supplier quality posture requiring escalation."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(audit_cost_usd AS DOUBLE))
      comment: "Average cost per supplier audit in USD. Used for audit program budget planning and cost-per-finding efficiency analysis."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_usd AS DOUBLE))
      comment: "Total spend on supplier audits. Tracked against quality budget and benchmarked against defect prevention savings."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Informs resource planning for audit teams and identifies scope creep."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score from audits. Tracks ESG compliance progress across the supply base for CHIPS Act and corporate reporting."
    - name: "open_corrective_action_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status NOT IN ('Closed', 'Verified') THEN supplier_audit_id END)
      comment: "Number of audits with open corrective actions. A key quality governance metric — high counts indicate systemic supplier quality issues."
    - name: "pct_audits_compliant"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN supplier_audit_id END) / NULLIF(COUNT(DISTINCT supplier_audit_id), 0), 2)
      comment: "Percentage of audits resulting in compliant status. Headline metric for supplier quality program effectiveness on executive dashboards."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (SCAR) KPIs tracking defect response, cost of quality, and closure performance. Used by supplier quality engineers and procurement leadership to manage supplier non-conformance and drive root cause elimination."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_corrective_action`"
  dimensions:
    - name: "supplier_corrective_action_status"
      expr: supplier_corrective_action_status
      comment: "Current status of the corrective action (issued, in-progress, closed, overdue) for pipeline management."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action implementation step specifically."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (process, material, equipment, human) for Pareto analysis and systemic improvement targeting."
    - name: "severity"
      expr: severity
      comment: "Severity level of the non-conformance (critical, major, minor) for prioritization and escalation decisions."
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the corrective action for resource allocation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the non-conformance has regulatory or export control compliance implications."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of effectiveness verification for closed corrective actions, ensuring recurrence prevention."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the corrective action is due for on-time closure rate trending."
  measures:
    - name: "total_scars_issued"
      expr: COUNT(DISTINCT supplier_corrective_action_id)
      comment: "Total supplier corrective actions issued. Volume metric for supplier quality program intensity and supplier non-conformance rate."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of quality incurred from supplier corrective actions. Directly tied to cost-of-poor-quality (COPQ) reporting."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of supplier corrective actions. Used for budget provisioning and insurance/warranty reserve calculations."
    - name: "avg_actual_cost_per_scar"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks cost efficiency of supplier quality resolution and identifies high-cost defect categories."
    - name: "open_scar_count"
      expr: COUNT(DISTINCT CASE WHEN supplier_corrective_action_status NOT IN ('Closed', 'Verified') THEN supplier_corrective_action_id END)
      comment: "Number of open SCARs. A critical operational metric — high open counts signal unresolved supplier quality risks in the supply chain."
    - name: "critical_scar_count"
      expr: COUNT(DISTINCT CASE WHEN severity = 'Critical' THEN supplier_corrective_action_id END)
      comment: "Number of critical-severity corrective actions. Triggers executive escalation and potential supplier disqualification reviews."
    - name: "pct_scars_closed_on_time"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN supplier_corrective_action_status = 'Closed' AND verification_date <= due_date THEN supplier_corrective_action_id END) / NULLIF(COUNT(DISTINCT CASE WHEN supplier_corrective_action_status = 'Closed' THEN supplier_corrective_action_id END), 0), 2)
      comment: "Percentage of closed SCARs resolved by their due date. Measures supplier responsiveness and quality management system effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality, compliance, and financial KPIs. Used by receiving operations, quality control, and accounts payable to manage incoming material acceptance, inspection outcomes, and invoice matching."
  source: "`vibe_semiconductors_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (posted, reversed, blocked) for inbound material flow management."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection outcome (accepted, rejected, under inspection) for incoming quality rate tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the received goods for export control and regulatory gating."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP-style movement type for goods receipt categorization (standard receipt, return, transfer)."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating a compliance exception on the receipt requiring review."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt for inbound volume trending and lead time analysis."
  measures:
    - name: "total_receipts"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipts. Measures inbound supply chain throughput and receiving workload."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received. Core supply chain throughput metric for capacity and demand fulfillment analysis."
    - name: "total_gross_amount_received"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods received. Used for GR/IR (goods receipt/invoice receipt) reconciliation and accrual accounting."
    - name: "total_net_amount_received"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received after adjustments. Primary input for accounts payable matching and inventory valuation."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score at goods receipt. Elevated scores indicate incoming material quality or compliance risks requiring escalation."
    - name: "compliance_exception_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of receipts with compliance exceptions. Drives export control review workload and supplier corrective action triggers."
    - name: "pct_receipts_quality_accepted"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_status = 'Accepted' THEN goods_receipt_id END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of goods receipts passing quality inspection. Key incoming quality rate metric — declines trigger supplier audits and SCARs."
    - name: "total_tax_amount_received"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods receipts. Used for VAT/GST reclaim calculations and tax compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics KPIs covering delivery performance, freight cost, and supply chain risk. Used by logistics operations, procurement, and supply chain risk teams to manage carrier performance and inbound lead times."
  source: "`vibe_semiconductors_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "inbound_shipment_status"
      expr: inbound_shipment_status
      comment: "Current status of the inbound shipment (in-transit, delivered, delayed, customs-hold) for real-time supply chain visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, sea, road, rail) for freight cost and lead time benchmarking by mode."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms affecting risk transfer and landed cost calculation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Customs and export control compliance status of the shipment."
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for geopolitical risk analysis and trade compliance reporting."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Indicates whether cold chain handling is required, for specialized logistics cost and compliance tracking."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Flags EAR-controlled shipments requiring export license verification at receipt."
    - name: "estimated_arrival_date_month"
      expr: DATE_TRUNC('MONTH', estimated_arrival_date)
      comment: "Month of estimated arrival for inbound supply pipeline planning."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(DISTINCT inbound_shipment_id)
      comment: "Total number of inbound shipments. Measures inbound logistics volume and carrier utilization."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost. Primary logistics spend metric for cost reduction initiatives and carrier contract negotiations."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per inbound shipment. Benchmarked by transport mode and carrier to identify cost optimization opportunities."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total inbound shipment weight in kilograms. Used for carrier capacity planning and freight rate negotiation."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total inbound shipment volume in cubic meters. Supports warehouse receiving capacity planning."
    - name: "avg_shipment_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across inbound shipments. Elevated scores indicate supply disruption risk requiring proactive mitigation."
    - name: "on_time_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_arrival_date <= estimated_arrival_date THEN inbound_shipment_id END)
      comment: "Number of shipments delivered on or before estimated arrival date. Numerator for on-time delivery rate calculation."
    - name: "late_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_arrival_date > estimated_arrival_date THEN inbound_shipment_id END)
      comment: "Number of shipments arriving after estimated arrival date. Drives carrier performance reviews and safety stock adjustments."
    - name: "pct_on_time_delivery"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_arrival_date <= estimated_arrival_date THEN inbound_shipment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_arrival_date IS NOT NULL THEN inbound_shipment_id END), 0), 2)
      comment: "On-time delivery rate for inbound shipments. Critical carrier KPI used in quarterly business reviews and contract renewal decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_disruption_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain disruption event KPIs covering financial impact, fab production risk, and resolution effectiveness. Used by supply chain risk management, operations leadership, and the C-suite to quantify and respond to supply disruptions."
  source: "`vibe_semiconductors_v1`.`supply`.`disruption_event`"
  dimensions:
    - name: "disruption_type"
      expr: disruption_type
      comment: "Type of disruption (natural disaster, geopolitical, logistics, quality) for root cause categorization and risk model calibration."
    - name: "disruption_category"
      expr: disruption_category
      comment: "Business category of the disruption for portfolio-level risk reporting."
    - name: "disruption_event_status"
      expr: disruption_event_status
      comment: "Current status of the disruption event (active, mitigated, resolved) for real-time risk dashboard."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the disruption (operational, management, executive) for governance routing."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the disrupted material is EAR-controlled, adding export compliance complexity to resolution."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the disrupted material is ITAR-controlled, requiring special handling in mitigation planning."
    - name: "disruption_start_month"
      expr: DATE_TRUNC('MONTH', disruption_start_timestamp)
      comment: "Month the disruption began for trend analysis and seasonality assessment."
  measures:
    - name: "total_disruption_events"
      expr: COUNT(DISTINCT disruption_event_id)
      comment: "Total number of supply disruption events. Headline risk metric for executive supply chain risk dashboards."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of supply disruptions. Directly informs risk reserve provisioning and insurance coverage decisions."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disruption event. Used to calibrate risk scoring models and prioritize mitigation investments."
    - name: "total_impacted_po_quantity"
      expr: SUM(CAST(impacted_po_quantity AS DOUBLE))
      comment: "Total purchase order quantity impacted by disruptions. Quantifies supply shortfall risk to production schedules."
    - name: "avg_disruption_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across active disruption events. Trending metric for supply chain resilience assessment."
    - name: "active_disruption_count"
      expr: COUNT(DISTINCT CASE WHEN disruption_event_status NOT IN ('Resolved', 'Closed') THEN disruption_event_id END)
      comment: "Number of currently active disruption events. Real-time risk exposure metric for operations war rooms and executive briefings."
    - name: "high_escalation_disruption_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_level IN ('Executive', 'Management') THEN disruption_event_id END)
      comment: "Number of disruptions escalated to management or executive level. Indicates severity of current supply chain stress."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk assessment KPIs covering probability, impact severity, and mitigation effectiveness. Used by supply chain risk officers and procurement leadership to prioritize risk mitigation investments and monitor residual risk."
  source: "`vibe_semiconductors_v1`.`supply`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of supply risk (single-source, geopolitical, financial, quality) for portfolio risk analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (active, expired, under review) for risk register currency."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of potential impact (critical, high, medium, low) for risk prioritization and escalation routing."
    - name: "disruption_status"
      expr: disruption_status
      comment: "Status of any associated disruption event for integrated risk-disruption reporting."
    - name: "disruption_escalation_level"
      expr: disruption_escalation_level
      comment: "Escalation level of the associated disruption for governance and response tracking."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment for trend analysis and review cadence compliance."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total number of supply risk assessments in the register. Measures risk management program coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all assessments. Portfolio-level risk posture metric for executive risk committees."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of risk materialization across the portfolio. Used to calibrate risk models and prioritize mitigation spend."
    - name: "high_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 70 THEN risk_assessment_id END)
      comment: "Number of high-risk assessments (score >= 70). Watch-list metric for supply chain risk committees requiring active mitigation plans."
    - name: "critical_impact_risk_count"
      expr: COUNT(DISTINCT CASE WHEN impact_severity = 'Critical' THEN risk_assessment_id END)
      comment: "Number of risks with critical impact severity. Drives executive escalation and business continuity planning activation."
    - name: "expired_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN risk_expiration_date < CURRENT_DATE() THEN risk_assessment_id END)
      comment: "Number of risk assessments past their expiration date. Indicates risk register staleness and compliance gaps in the risk management program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard KPIs covering delivery, quality, and corrective action metrics. Used by procurement and supplier quality teams for quarterly business reviews, supplier tiering, and strategic sourcing decisions."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Status of the scorecard (active, closed, under review) for reporting period management."
    - name: "scorecard_type"
      expr: scorecard_type
      comment: "Type of scorecard (quarterly, annual, for-cause) for program segmentation."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall supplier performance rating for tiering and preferred supplier designation decisions."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the supplier (preferred, approved, conditional) for sourcing strategy alignment."
    - name: "pcn_compliance"
      expr: pcn_compliance
      comment: "Whether the supplier is compliant with product change notification obligations — critical for semiconductor supply chain management."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of corrective action verification for closed scorecard periods."
    - name: "scoring_period_start_month"
      expr: DATE_TRUNC('MONTH', scoring_period_start)
      comment: "Start month of the scoring period for time-series performance trending."
  measures:
    - name: "total_scorecards"
      expr: COUNT(DISTINCT supplier_scorecard_id)
      comment: "Total number of supplier scorecards issued. Measures supplier performance management program coverage."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all scored suppliers. Primary delivery performance KPI for supplier QBRs and contract renewal decisions."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score from scorecards. Aggregated risk posture metric for supply base health reporting."
    - name: "pct_pcn_compliant_scorecards"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pcn_compliance = TRUE THEN supplier_scorecard_id END) / NULLIF(COUNT(DISTINCT supplier_scorecard_id), 0), 2)
      comment: "Percentage of scorecards where the supplier is PCN-compliant. Critical for semiconductor supply chain — non-compliance triggers qualification holds."
    - name: "preferred_tier_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_tier = 'Preferred' THEN supplier_scorecard_id END)
      comment: "Number of scorecards for preferred-tier suppliers. Tracks preferred supplier base size for strategic sourcing concentration analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply forecast accuracy, volume, and risk KPIs. Used by supply planning, procurement, and operations leadership to manage material availability, identify forecast variances, and drive supply-demand balancing decisions."
  source: "`vibe_semiconductors_v1`.`supply`.`supply_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of supply forecast (consensus, statistical, supplier-committed) for accuracy benchmarking by method."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (draft, approved, published) for planning cycle governance."
    - name: "forecast_source"
      expr: forecast_source
      comment: "Source system or process generating the forecast for data lineage and accuracy attribution."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flags forecasts with compliance implications (e.g., export-controlled materials) requiring additional review."
    - name: "is_ltb"
      expr: is_ltb
      comment: "Indicates last-time-buy forecasts — critical for end-of-life material planning and inventory build decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast for multi-currency spend planning."
    - name: "horizon_start_month"
      expr: DATE_TRUNC('MONTH', horizon_start_date)
      comment: "Start month of the forecast horizon for time-phased supply planning analysis."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted supply quantity. Primary supply planning volume metric for capacity and procurement commitment decisions."
    - name: "total_prior_forecast_quantity"
      expr: SUM(CAST(prior_forecast_quantity AS DOUBLE))
      comment: "Total prior period forecast quantity. Used as denominator for forecast accuracy and variance analysis."
    - name: "total_forecast_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total forecast variance (current vs. prior). Large variances indicate supply plan instability requiring root cause investigation."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average forecasted price per unit. Used for procurement budget planning and price trend monitoring."
    - name: "total_forecasted_spend"
      expr: SUM(CAST(quantity AS DOUBLE) * CAST(price_per_unit AS DOUBLE))
      comment: "Total forecasted procurement spend (quantity × price). Primary financial planning metric for procurement budget and cash flow forecasting."
    - name: "ltb_forecast_count"
      expr: COUNT(DISTINCT CASE WHEN is_ltb = TRUE THEN supply_forecast_id END)
      comment: "Number of last-time-buy forecasts. Tracks end-of-life material exposure requiring strategic inventory build decisions."
    - name: "total_active_forecasts"
      expr: COUNT(DISTINCT supply_forecast_id)
      comment: "Total number of active supply forecasts. Measures planning coverage across the material portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_requirement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requirements planning (MRP) KPIs covering demand coverage, planned cost, and planning horizon. Used by supply planners and operations leadership to ensure material availability for fab production and identify supply gaps."
  source: "`vibe_semiconductors_v1`.`supply`.`material_requirement_plan`"
  dimensions:
    - name: "material_requirement_plan_status"
      expr: material_requirement_plan_status
      comment: "Status of the MRP record (planned, firmed, released, cancelled) for production planning pipeline management."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, MPS, reorder point) for planning methodology analysis."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing rule applied (exact, fixed, economic order quantity) for inventory optimization analysis."
    - name: "batch_managed_flag"
      expr: batch_managed_flag
      comment: "Indicates batch-managed materials requiring lot traceability, relevant for semiconductor process materials."
    - name: "is_fixed_lot"
      expr: is_fixed_lot
      comment: "Indicates fixed lot size materials for procurement commitment planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the planned cost for multi-currency financial planning."
    - name: "demand_date_month"
      expr: DATE_TRUNC('MONTH', demand_date)
      comment: "Month of material demand for time-phased supply planning and capacity alignment."
  measures:
    - name: "total_demand_quantity"
      expr: SUM(CAST(demand_quantity AS DOUBLE))
      comment: "Total material demand quantity from MRP. Primary input for procurement commitment and supplier capacity reservation decisions."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned supply quantity from MRP. Compared against demand quantity to identify supply gaps requiring expediting."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned procurement cost from MRP runs. Used for budget planning and purchase order commitment forecasting."
    - name: "avg_planned_cost_per_record"
      expr: AVG(CAST(planned_cost AS DOUBLE))
      comment: "Average planned cost per MRP record. Benchmarks material cost trends and identifies high-cost items for strategic sourcing focus."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned across all materials. Measures supply chain buffer investment and resilience posture."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across materials. Used to assess replenishment trigger levels and inventory policy adequacy."
    - name: "supply_demand_gap_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE) - CAST(demand_quantity AS DOUBLE))
      comment: "Net supply vs. demand gap (planned minus demand). Negative values indicate supply shortfalls requiring immediate procurement action."
    - name: "total_mrp_records"
      expr: COUNT(DISTINCT material_requirement_plan_id)
      comment: "Total number of MRP planning records. Measures planning coverage and MRP run completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_sourcing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing contract portfolio KPIs covering contract value, coverage, and compliance. Used by strategic sourcing, legal, and procurement leadership to manage contract lifecycle, supplier obligations, and spend under contract."
  source: "`vibe_semiconductors_v1`.`supply`.`sourcing_contract`"
  dimensions:
    - name: "sourcing_contract_status"
      expr: sourcing_contract_status
      comment: "Current status of the sourcing contract (active, expired, under negotiation) for contract portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sourcing contract (long-term agreement, spot, framework) for spend strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for contract governance and compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio valuation."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms in the contract for logistics cost and risk allocation analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract vintage and renewal cycle analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the contract expires for renewal pipeline management and coverage gap identification."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all sourcing contracts. Measures spend under contract — a key procurement governance metric for coverage ratio analysis."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average sourcing contract value. Benchmarks contract size and identifies fragmentation in the contract portfolio."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price. Compared against spot market prices to quantify contract savings and negotiation effectiveness."
    - name: "total_active_contracts"
      expr: COUNT(DISTINCT CASE WHEN sourcing_contract_status = 'Active' THEN sourcing_contract_id END)
      comment: "Number of active sourcing contracts. Measures contract coverage breadth across the supply base."
    - name: "expiring_contracts_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN sourcing_contract_id END)
      comment: "Number of contracts expiring within 90 days. Critical renewal pipeline metric — gaps trigger supply continuity risk."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total contracted target quantity across all sourcing agreements. Used for supply commitment planning and capacity reservation."
    - name: "total_contracts"
      expr: COUNT(DISTINCT sourcing_contract_id)
      comment: "Total number of sourcing contracts in the portfolio. Baseline for contract coverage ratio and procurement governance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification program KPIs covering qualification status, audit outcomes, and corrective action performance. Used by supplier quality and procurement teams to manage the approved vendor base and qualification pipeline."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, conditional, disqualified, in-progress) for approved vendor base management."
    - name: "qualification_program_type"
      expr: qualification_program_type
      comment: "Type of qualification program (initial, re-qualification, process change) for program coverage analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of qualification audit conducted for methodology benchmarking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall qualification rating for supplier tiering and sourcing eligibility decisions."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from qualification findings for closure tracking."
    - name: "validity_end_date_month"
      expr: DATE_TRUNC('MONTH', validity_end_date)
      comment: "Month the qualification expires for re-qualification pipeline management."
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT supplier_qualification_id)
      comment: "Total number of supplier qualifications. Measures qualification program scope and approved vendor base size."
    - name: "qualified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN supplier_qualification_id END)
      comment: "Number of fully qualified suppliers. Tracks approved vendor base size for single-source risk and supply continuity planning."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score from supplier qualifications. Measures overall supply base risk posture."
    - name: "expiring_qualifications_90_days"
      expr: COUNT(DISTINCT CASE WHEN validity_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN supplier_qualification_id END)
      comment: "Number of supplier qualifications expiring within 90 days. Drives re-qualification scheduling to prevent approved vendor base gaps."
    - name: "open_corrective_action_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status NOT IN ('Closed', 'Verified') THEN supplier_qualification_id END)
      comment: "Number of qualifications with open corrective actions. Indicates qualification program quality gaps requiring resolution."
    - name: "pct_qualifications_passed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN supplier_qualification_id END) / NULLIF(COUNT(DISTINCT supplier_qualification_id), 0), 2)
      comment: "Percentage of qualification assessments resulting in full qualification. Measures qualification program pass rate and supplier readiness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_osat_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT (Outsourced Semiconductor Assembly and Test) work order KPIs covering assembly cost, quality, and delivery performance. Used by packaging operations, supply chain, and finance to manage OSAT vendor performance and cost."
  source: "`vibe_semiconductors_v1`.`supply`.`osat_work_order`"
  dimensions:
    - name: "osat_work_order_status"
      expr: osat_work_order_status
      comment: "Current status of the OSAT work order (issued, in-progress, completed, cancelled) for production pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the work order for procurement governance."
    - name: "package_type"
      expr: package_type
      comment: "Package type (BGA, QFN, flip-chip) for cost and yield analysis by package technology."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Export control and regulatory compliance status of the work order."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Flags EAR-controlled OSAT work orders requiring export license management."
    - name: "priority"
      expr: priority
      comment: "Business priority of the work order for capacity allocation and expediting decisions."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of work order approval for volume trending and capacity planning."
  measures:
    - name: "total_assembly_cost"
      expr: SUM(CAST(total_assembly_cost AS DOUBLE))
      comment: "Total OSAT assembly cost across all work orders. Primary cost metric for packaging cost of goods sold (COGS) and OSAT vendor spend management."
    - name: "avg_unit_assembly_cost"
      expr: AVG(CAST(unit_assembly_cost AS DOUBLE))
      comment: "Average unit assembly cost per work order. Benchmarked across OSAT vendors and package types for cost reduction negotiations."
    - name: "total_nre_charges"
      expr: SUM(CAST(nre_charge AS DOUBLE))
      comment: "Total non-recurring engineering charges from OSAT work orders. Tracked separately for new product introduction cost accounting."
    - name: "total_die_quantity"
      expr: SUM(CAST(die_quantity AS DOUBLE))
      comment: "Total die quantity committed to OSAT assembly. Measures packaging throughput and die inventory consumption rate."
    - name: "avg_quality_rating"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across OSAT work orders. Proxy for OSAT vendor quality performance used in vendor selection and QBRs."
    - name: "total_work_orders"
      expr: COUNT(DISTINCT osat_work_order_id)
      comment: "Total number of OSAT work orders issued. Measures OSAT program volume and vendor utilization."
    - name: "ear_controlled_work_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_ear_controlled = TRUE THEN osat_work_order_id END)
      comment: "Number of EAR-controlled OSAT work orders. Drives export compliance workload and license utilization planning for OSAT operations."
$$;