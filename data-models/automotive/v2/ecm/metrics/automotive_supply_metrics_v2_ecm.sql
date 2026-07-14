-- Metric views for domain: supply | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs: on-time delivery, quality (PPM defects), compliance, and overall performance tier. Critical for supplier relationship management and sourcing decisions."
  source: "`vibe_automotive_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "evaluation_period_start"
      expr: evaluation_period_start
      comment: "Start date of the supplier evaluation period"
    - name: "evaluation_period_end"
      expr: evaluation_period_end
      comment: "End date of the supplier evaluation period"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of supplier evaluation for time-series trending"
    - name: "evaluation_quarter"
      expr: DATE_TRUNC('QUARTER', evaluation_date)
      comment: "Quarter of supplier evaluation for quarterly business reviews"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier classification (e.g., Preferred, Approved, Conditional, Disqualified)"
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the scorecard (e.g., Draft, Approved, Published)"
    - name: "corrective_action_required"
      expr: corrective_action_flag
      comment: "Flag indicating whether corrective action is required for this supplier"
    - name: "scoring_methodology_version"
      expr: scoring_methodology_version
      comment: "Version of the scoring methodology used for comparability across periods"
  measures:
    - name: "supplier_count"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Number of unique suppliers evaluated in the period"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across all evaluated suppliers"
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers - critical for production continuity"
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across suppliers - key quality metric for IATF 16949 compliance"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score (regulatory, contractual, ESG) across suppliers"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score measuring supplier communication and issue resolution speed"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score for ESG reporting and sustainable sourcing initiatives"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supplier risk score for supply chain risk management"
    - name: "avg_ppap_completion_rate"
      expr: AVG(CAST(ppap_on_time_completion_rate AS DOUBLE))
      comment: "Average PPAP on-time completion rate - critical for new product launch readiness"
    - name: "avg_delivery_quantity_accuracy"
      expr: AVG(CAST(delivery_quantity_accuracy_pct AS DOUBLE))
      comment: "Average delivery quantity accuracy percentage - impacts inventory planning and production scheduling"
    - name: "corrective_action_rate"
      expr: AVG(CAST(CASE WHEN corrective_action_flag = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of supplier scorecards requiring corrective action - indicator of supplier base health"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics and supply chain performance: freight costs, on-time arrival, shipment volumes, and expedited shipment rates. Essential for supply chain efficiency and cost management."
  source: "`vibe_automotive_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month of actual shipment arrival for time-series analysis"
    - name: "shipment_quarter"
      expr: DATE_TRUNC('QUARTER', actual_arrival_timestamp)
      comment: "Quarter of actual shipment arrival for quarterly reporting"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., In Transit, Arrived, Delayed, Cancelled)"
    - name: "transport_mode"
      expr: mode_of_transport
      comment: "Mode of transport (e.g., Air, Ocean, Rail, Truck) for modal analysis"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether shipment was expedited - premium freight indicator"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether shipment contains hazardous materials requiring special handling"
    - name: "temperature_controlled"
      expr: temperature_control_required
      comment: "Flag indicating whether shipment requires temperature control (e.g., batteries, electronics)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms code defining cost and risk transfer point (e.g., FOB, CIF, DDP)"
  measures:
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments received"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments - key supply chain cost driver"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment for cost benchmarking"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters of all inbound shipments"
    - name: "avg_volume_per_shipment"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average volume per shipment for container utilization analysis"
    - name: "expedited_shipment_rate"
      expr: AVG(CAST(CASE WHEN is_expedited = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of shipments that were expedited - indicator of supply chain disruption and premium freight spend"
    - name: "hazardous_shipment_rate"
      expr: AVG(CAST(CASE WHEN is_hazardous = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of shipments containing hazardous materials requiring special handling"
    - name: "temperature_controlled_rate"
      expr: AVG(CAST(CASE WHEN temperature_control_required = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of shipments requiring temperature control - impacts freight cost and carrier selection"
    - name: "avg_container_count"
      expr: AVG(CAST(container_count AS DOUBLE))
      comment: "Average number of containers per shipment for logistics planning"
    - name: "avg_pallet_count"
      expr: AVG(CAST(pallet_count AS DOUBLE))
      comment: "Average number of pallets per shipment for warehouse receiving capacity planning"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming quality control KPIs: defect rates (PPM), inspection pass rates, and disposition outcomes. Critical for supplier quality management and IATF 16949 compliance."
  source: "`vibe_automotive_v1`.`supply`.`inbound_inspection`"
  dimensions:
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for time-series quality trending"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_timestamp)
      comment: "Quarter of inspection for quarterly quality reviews"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection result (e.g., Pass, Fail, Conditional Accept, Reject)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Pending, Completed, Escalated)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for inspected material (e.g., Accept, Reject, Return to Supplier, Use As Is, Rework)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Inspection method used (e.g., Visual, Dimensional, Functional, Destructive)"
    - name: "inspection_location"
      expr: inspection_location
      comment: "Physical location where inspection was performed"
    - name: "part_number"
      expr: part_number
      comment: "Part number of inspected material for part-level quality analysis"
    - name: "part_revision"
      expr: part_revision
      comment: "Part revision level for tracking quality across engineering changes"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inbound inspections performed"
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in parts per million - key supplier quality metric for IATF 16949"
    - name: "pass_rate"
      expr: AVG(CAST(CASE WHEN inspection_result = 'Pass' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of inspections that passed - indicator of incoming material quality"
    - name: "rejection_rate"
      expr: AVG(CASE WHEN disposition IN ('Reject', 'Return to Supplier') THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of inspections resulting in rejection or return - drives supplier corrective action"
    - name: "conditional_accept_rate"
      expr: AVG(CAST(CASE WHEN disposition = 'Conditional Accept' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of inspections conditionally accepted - indicates borderline quality requiring monitoring"
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per inspection for statistical process control"
    - name: "avg_defect_count"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average number of defects found per inspection"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation (RFQ) process efficiency: cycle time, response rates, approval rates, and tooling requirements. Essential for sourcing strategy and supplier engagement."
  source: "`vibe_automotive_v1`.`supply`.`rfq`"
  dimensions:
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month when RFQ was issued for time-series sourcing activity analysis"
    - name: "issue_quarter"
      expr: DATE_TRUNC('QUARTER', issue_timestamp)
      comment: "Quarter when RFQ was issued for quarterly sourcing planning"
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Draft, Issued, Responses Received, Awarded, Cancelled)"
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., Standard, Expedited, Prototype, Production)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ (e.g., Pending, Approved, Rejected)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFQ (e.g., Critical, High, Medium, Low)"
    - name: "tooling_required"
      expr: tooling_required
      comment: "Flag indicating whether tooling investment is required - impacts total cost of ownership"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating whether regulatory approval is required for the sourced part"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for spend category analysis"
    - name: "program_model_year"
      expr: program_model_year
      comment: "Target vehicle program model year for program-specific sourcing"
    - name: "delivery_schedule_type"
      expr: delivery_schedule_type
      comment: "Delivery schedule type (e.g., JIT, JIS, Batch) for supply chain planning"
  measures:
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued in the period"
    - name: "avg_target_price"
      expr: AVG(CAST(target_price_amount AS DOUBLE))
      comment: "Average target price across RFQs for cost benchmarking"
    - name: "total_target_spend"
      expr: SUM(CAST(target_price_amount AS DOUBLE))
      comment: "Total target spend across all RFQs - represents sourcing pipeline value"
    - name: "avg_quantity_estimate"
      expr: AVG(CAST(quantity_estimate AS DOUBLE))
      comment: "Average estimated quantity per RFQ for volume planning"
    - name: "total_quantity_estimate"
      expr: SUM(CAST(quantity_estimate AS DOUBLE))
      comment: "Total estimated quantity across all RFQs - represents sourcing volume pipeline"
    - name: "tooling_required_rate"
      expr: AVG(CAST(CASE WHEN tooling_required = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of RFQs requiring tooling investment - impacts capital expenditure planning"
    - name: "regulatory_approval_rate"
      expr: AVG(CAST(CASE WHEN regulatory_approval_required = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of RFQs requiring regulatory approval - impacts sourcing lead time"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount negotiated per RFQ"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price_amount AS DOUBLE))
      comment: "Average net price after discounts per RFQ"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ response analysis: quoted prices vs. targets, supplier competitiveness, lead times, and tooling costs. Critical for supplier selection and cost negotiation."
  source: "`vibe_automotive_v1`.`supply`.`rfq_response`"
  dimensions:
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when RFQ response was submitted for time-series analysis"
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_timestamp)
      comment: "Quarter when RFQ response was submitted for quarterly sourcing reviews"
    - name: "rfq_response_status"
      expr: rfq_response_status
      comment: "Status of the RFQ response (e.g., Submitted, Under Review, Accepted, Rejected)"
    - name: "response_source"
      expr: response_source
      comment: "Source of the response (e.g., Portal, Email, Manual Entry)"
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Flag indicating whether responding supplier is a preferred supplier"
    - name: "freight_included"
      expr: freight_included
      comment: "Flag indicating whether freight cost is included in quoted price"
    - name: "quoted_currency"
      expr: quoted_currency
      comment: "Currency of quoted price for multi-currency analysis"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Proposed shipping method (e.g., Air, Ocean, Ground)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty offered (e.g., Standard, Extended, Limited)"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the quoted part"
  measures:
    - name: "response_count"
      expr: COUNT(1)
      comment: "Total number of RFQ responses received"
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all responses for price benchmarking"
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total quoted price including all costs"
    - name: "avg_tooling_cost"
      expr: AVG(CAST(tooling_cost AS DOUBLE))
      comment: "Average tooling cost quoted - key component of total cost of ownership"
    - name: "total_tooling_cost"
      expr: SUM(CAST(tooling_cost AS DOUBLE))
      comment: "Total tooling cost across all responses - impacts capital expenditure"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days quoted by suppliers - critical for production planning"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by suppliers"
    - name: "avg_tax_amount"
      expr: AVG(CAST(tax_amount AS DOUBLE))
      comment: "Average tax amount per response for total landed cost calculation"
    - name: "avg_capacity_commitment"
      expr: AVG(CAST(capacity_commitment AS DOUBLE))
      comment: "Average capacity commitment offered by suppliers - indicates supplier scalability"
    - name: "avg_warranty_period_months"
      expr: AVG(CAST(warranty_period_months AS DOUBLE))
      comment: "Average warranty period in months offered by suppliers"
    - name: "preferred_supplier_rate"
      expr: AVG(CAST(CASE WHEN is_preferred_supplier = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of responses from preferred suppliers - indicates supplier base engagement"
    - name: "freight_included_rate"
      expr: AVG(CAST(CASE WHEN freight_included = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of quotes including freight - impacts price comparability"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_ppap_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Part Approval Process (PPAP) element tracking: submission status, approval rates, and defect rates. Essential for new product launch readiness and IATF 16949 compliance."
  source: "`vibe_automotive_v1`.`supply`.`ppap_element`"
  dimensions:
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when PPAP element was submitted for launch readiness tracking"
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', created_timestamp)
      comment: "Quarter when PPAP element was submitted for program milestone tracking"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when PPAP element was approved"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of PPAP element submission (e.g., Pending, Approved, Rejected, Resubmit Required)"
    - name: "element_type"
      expr: element_type
      comment: "Type of PPAP element (e.g., Design Records, Engineering Change Documents, Process Flow Diagram, FMEA, Control Plan, MSA, Dimensional Results, Material Test Results, Initial Process Studies, Qualified Lab Documentation, Appearance Approval Report, Sample Production Parts, Master Sample, Checking Aids, Customer-Specific Requirements, Part Submission Warrant)"
    - name: "element_code"
      expr: element_code
      comment: "PPAP element code for standardized tracking"
    - name: "required_flag"
      expr: required_flag
      comment: "Flag indicating whether this element is required for PPAP approval"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether PPAP element contains confidential information"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard applicable to this PPAP element (e.g., IATF 16949, ISO 9001, Customer-Specific)"
    - name: "part_number"
      expr: part_number
      comment: "Part number for part-level PPAP tracking"
    - name: "part_revision"
      expr: part_revision
      comment: "Part revision level for tracking PPAP across engineering changes"
    - name: "document_format"
      expr: document_format
      comment: "Format of PPAP document (e.g., PDF, Excel, CAD, Image)"
  measures:
    - name: "ppap_element_count"
      expr: COUNT(1)
      comment: "Total number of PPAP elements submitted"
    - name: "approval_rate"
      expr: AVG(CAST(CASE WHEN submission_status = 'Approved' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of PPAP elements approved - key indicator of supplier readiness for production launch"
    - name: "rejection_rate"
      expr: AVG(CAST(CASE WHEN submission_status = 'Rejected' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of PPAP elements rejected - indicates quality of supplier submissions"
    - name: "resubmit_rate"
      expr: AVG(CAST(CASE WHEN submission_status = 'Resubmit Required' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of PPAP elements requiring resubmission - impacts launch timeline"
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in parts per million from initial process studies - predictor of production quality"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE) / 1048576.0)
      comment: "Average file size in megabytes for document management capacity planning"
    - name: "required_element_rate"
      expr: AVG(CAST(CASE WHEN required_flag = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of PPAP elements that are required vs. optional"
    - name: "confidential_element_rate"
      expr: AVG(CAST(CASE WHEN is_confidential = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of PPAP elements marked confidential - impacts access control requirements"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit performance: audit scores, findings severity distribution, re-audit rates, and closure status. Critical for supplier risk management and continuous improvement."
  source: "`vibe_automotive_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month when audit was conducted for time-series audit activity tracking"
    - name: "audit_quarter"
      expr: DATE_TRUNC('QUARTER', audit_date)
      comment: "Quarter when audit was conducted for quarterly audit planning"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Process Audit, Product Audit, System Audit, Layered Process Audit, Special Audit)"
    - name: "audit_standard"
      expr: audit_standard
      comment: "Audit standard used (e.g., IATF 16949, ISO 9001, VDA 6.3, Customer-Specific)"
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method (e.g., On-Site, Remote, Hybrid)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on audit findings (e.g., Low, Medium, High, Critical)"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of audit findings (e.g., Open, In Progress, Closed, Overdue)"
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating whether re-audit is required based on findings severity"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the audit record (e.g., Active, Archived)"
    - name: "audit_location"
      expr: audit_location
      comment: "Physical location where audit was conducted"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of supplier audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score across all supplier audits - key indicator of supplier base quality"
    - name: "avg_major_findings"
      expr: AVG(CAST(findings_major_count AS DOUBLE))
      comment: "Average number of major findings per audit - indicates severity of supplier issues"
    - name: "avg_minor_findings"
      expr: AVG(CAST(findings_minor_count AS DOUBLE))
      comment: "Average number of minor findings per audit"
    - name: "avg_observations"
      expr: AVG(CAST(findings_observation_count AS DOUBLE))
      comment: "Average number of observations per audit - opportunities for improvement"
    - name: "total_major_findings"
      expr: SUM(CAST(findings_major_count AS DOUBLE))
      comment: "Total major findings across all audits - drives corrective action prioritization"
    - name: "total_minor_findings"
      expr: SUM(CAST(findings_minor_count AS DOUBLE))
      comment: "Total minor findings across all audits"
    - name: "re_audit_rate"
      expr: AVG(CAST(CASE WHEN re_audit_required = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of audits requiring re-audit - indicator of supplier quality system maturity"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_ckd_kit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Completely Knocked Down (CKD) kit management: kit values, compliance status, quality status, and PPAP readiness. Essential for global manufacturing footprint and local content compliance."
  source: "`vibe_automotive_v1`.`supply`.`ckd_kit`"
  dimensions:
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_date)
      comment: "Month when CKD kit was dispatched for time-series shipment tracking"
    - name: "dispatch_quarter"
      expr: DATE_TRUNC('QUARTER', dispatch_date)
      comment: "Quarter when CKD kit was dispatched for quarterly volume planning"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_date)
      comment: "Month when CKD kit actually arrived at destination plant"
    - name: "kit_status"
      expr: kit_status
      comment: "Current status of CKD kit (e.g., Planned, Packed, In Transit, Arrived, Unpacked, Installed)"
    - name: "kit_type"
      expr: kit_type
      comment: "Type of CKD kit (e.g., Full Vehicle, Sub-Assembly, Powertrain, Body, Trim)"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of CKD kit (e.g., Approved, Inspection Required, Hold, Rejected)"
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP status of CKD kit components (e.g., Approved, Pending, Interim Approval, Not Required)"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of CKD kit inspection (e.g., Pass, Fail, Conditional)"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for import/export compliance"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether kit contains hazardous materials requiring special handling"
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle for which CKD kit is intended"
    - name: "target_plant_code"
      expr: target_plant_code
      comment: "Destination plant code for CKD kit"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used (e.g., Ocean, Air, Rail, Truck)"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms defining cost and risk transfer point"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of kit value for multi-currency analysis"
  measures:
    - name: "ckd_kit_count"
      expr: COUNT(1)
      comment: "Total number of CKD kits shipped"
    - name: "total_kit_value_usd"
      expr: SUM(CAST(kit_value_usd AS DOUBLE))
      comment: "Total value of CKD kits in USD - represents capital tied up in global supply chain"
    - name: "avg_kit_value_usd"
      expr: AVG(CAST(kit_value_usd AS DOUBLE))
      comment: "Average value per CKD kit in USD for cost benchmarking"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of CKD kits in kilograms for freight planning"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of CKD kits in cubic meters for container utilization"
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per CKD kit in kilograms"
    - name: "avg_volume_cbm"
      expr: AVG(CAST(total_volume_cbm AS DOUBLE))
      comment: "Average volume per CKD kit in cubic meters"
    - name: "avg_parts_count"
      expr: AVG(CAST(total_parts_count AS DOUBLE))
      comment: "Average number of parts per CKD kit for complexity assessment"
    - name: "ppap_approved_rate"
      expr: AVG(CAST(CASE WHEN ppap_status = 'Approved' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of CKD kits with approved PPAP status - critical for production launch readiness"
    - name: "quality_approved_rate"
      expr: AVG(CAST(CASE WHEN quality_status = 'Approved' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of CKD kits with approved quality status"
    - name: "inspection_pass_rate"
      expr: AVG(CAST(CASE WHEN inspection_result = 'Pass' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of CKD kits passing inspection - indicator of packing and shipping quality"
    - name: "hazardous_material_rate"
      expr: AVG(CAST(CASE WHEN hazardous_material_flag = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of CKD kits containing hazardous materials - impacts shipping cost and compliance"
    - name: "regulatory_approved_rate"
      expr: AVG(CAST(CASE WHEN regulatory_approval_status = 'Approved' THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of CKD kits with regulatory approval - critical for customs clearance"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_scheduling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling agreement performance: actual vs. target on-time delivery and quality (PPM), annual volumes, and pricing. Essential for JIT/JIS supply chain management."
  source: "`vibe_automotive_v1`.`supply`.`scheduling_agreement`"
  dimensions:
    - name: "agreement_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when scheduling agreement became effective"
    - name: "agreement_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when scheduling agreement expires"
    - name: "scheduling_agreement_status"
      expr: scheduling_agreement_status
      comment: "Current status of scheduling agreement (e.g., Active, Expired, Suspended, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of scheduling agreement (e.g., JIT, JIS, Kanban, Consignment)"
    - name: "delivery_rhythm"
      expr: delivery_rhythm
      comment: "Delivery rhythm (e.g., Hourly, Daily, Weekly, Monthly)"
    - name: "kanban_flag"
      expr: kanban_flag
      comment: "Flag indicating whether Kanban pull system is used"
    - name: "early_termination_allowed"
      expr: early_termination_allowed
      comment: "Flag indicating whether early termination is allowed"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Flag indicating whether renewal option exists"
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of pricing for multi-currency analysis"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g., Net 30, Net 60, COD)"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of active scheduling agreements"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across scheduling agreements for cost benchmarking"
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total annual volume committed across all scheduling agreements - represents supply base capacity"
    - name: "avg_annual_volume"
      expr: AVG(CAST(total_annual_volume AS DOUBLE))
      comment: "Average annual volume per scheduling agreement"
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target on-time delivery percentage across agreements"
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage - key JIT/JIS performance metric"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target defect rate in parts per million across agreements"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual defect rate in parts per million - key quality performance metric"
    - name: "kanban_rate"
      expr: AVG(CAST(CASE WHEN kanban_flag = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of scheduling agreements using Kanban pull system"
    - name: "early_termination_allowed_rate"
      expr: AVG(CAST(CASE WHEN early_termination_allowed = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of agreements allowing early termination - indicates contract flexibility"
    - name: "renewal_option_rate"
      expr: AVG(CAST(CASE WHEN renewal_option = TRUE THEN 1.0 ELSE 0.0 END AS INT))
      comment: "Percentage of agreements with renewal option - indicates long-term supplier relationships"
$$;