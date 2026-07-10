-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication dispensing KPIs covering volume, cost, reimbursement mix, and patient counseling compliance. Core operational and financial view for pharmacy leadership."
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_status"
      expr: dispense_status
      comment: "Status of the dispense event (e.g., completed, cancelled) for throughput and exception analysis."
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (new, refill, etc.) used to segment fill mix."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule for controlled-drug oversight."
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_timestamp)
      comment: "Month of dispense for trending dispensing volume and cost."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts for multi-currency reporting."
  measures:
    - name: "Dispense Event Count"
      expr: COUNT(1)
      comment: "Total number of dispensing events — baseline pharmacy throughput volume."
    - name: "Total Medication Cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total acquisition/medication cost dispensed — drives drug spend management."
    - name: "Total Insurance Paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total insurer reimbursement collected — key revenue and payer-mix input."
    - name: "Total Patient Pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket dispensed — affordability and collections signal."
    - name: "Total Dispensing Fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fee revenue — professional-service margin driver."
    - name: "Avg Medication Cost Per Fill"
      expr: AVG(CAST(medication_cost_amount AS DOUBLE))
      comment: "Average drug cost per fill — flags high-cost drug utilization shifts."
    - name: "Total Dispensed Quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total units dispensed — inventory consumption planning input."
    - name: "Counseling Completion Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of dispenses with completed patient counseling — regulatory/quality compliance KPI."
    - name: "Generic Substitution Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fills with substitution made — generic dispensing efficiency and cost-savings lever."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim adjudication KPIs: billed vs paid amounts, reject rates, and copay burden. Steers revenue-cycle and payer-performance decisions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Adjudication status of the claim for approval/reject analysis."
    - name: "transaction_response_status"
      expr: transaction_response_status
      comment: "Real-time transaction response outcome for switch/PBM performance."
    - name: "reject_code"
      expr: reject_code
      comment: "Claim rejection reason code to drive remediation of top denial causes."
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_date)
      comment: "Month of claim submission for reimbursement trending."
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense-as-written code affecting reimbursement and generic strategy."
  measures:
    - name: "Claim Count"
      expr: COUNT(1)
      comment: "Total pharmacy claims processed — baseline claim volume."
    - name: "Total Billed Amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed to payers — top-line revenue exposure."
    - name: "Total Paid Amount"
      expr: SUM(CAST(total_amount_paid AS DOUBLE))
      comment: "Total amount actually paid — realized reimbursement."
    - name: "Total Plan Paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan-paid portion — payer contribution to steer contracting."
    - name: "Total Patient Copay"
      expr: SUM(CAST(patient_copay AS DOUBLE))
      comment: "Total patient copay collected — patient affordability metric."
    - name: "Total Ingredient Cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total drug ingredient cost — margin denominator against paid amount."
    - name: "Claim Reject Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reject_code IS NOT NULL AND reject_code <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims rejected — first-pass adjudication quality KPI driving revenue leakage remediation."
    - name: "Avg Copay Per Claim"
      expr: AVG(CAST(patient_copay AS DOUBLE))
      comment: "Average patient copay per claim — affordability and abandonment risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization KPIs: approval/denial rates, turnaround, and appeal outcomes. Supports access, staffing, and payer negotiation decisions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_pa_request`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Current PA status for pipeline and outcome analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the PA request for SLA prioritization."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denials to target documentation improvements."
    - name: "pa_request_month"
      expr: DATE_TRUNC('MONTH', pa_request_date)
      comment: "Month of PA request for volume and turnaround trending."
  measures:
    - name: "PA Request Count"
      expr: COUNT(1)
      comment: "Total prior authorization requests — access-workflow volume baseline."
    - name: "PA Approval Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pa_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests approved — patient access and payer-friction KPI."
    - name: "Appeal Submission Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests escalated to appeal — rework burden and denial-management signal."
    - name: "Specialty Medication PA Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN specialty_medication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PAs for specialty drugs — high-cost specialty pipeline exposure."
    - name: "Total Estimated Medication Cost"
      expr: SUM(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Total estimated cost of medications pending PA — financial exposure of the access pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse drug event (ADE) safety KPIs: severity mix, harm categories, reporting compliance, and preventability. Core patient-safety and regulatory view."
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "ADE severity classification for safety-risk stratification."
    - name: "harm_category"
      expr: harm_category
      comment: "Harm category of the event for outcome analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse event for pattern detection."
    - name: "detection_method"
      expr: detection_method
      comment: "How the ADE was detected to evaluate surveillance channels."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of ADE occurrence for safety trending."
  measures:
    - name: "ADE Count"
      expr: COUNT(1)
      comment: "Total adverse drug events — patient-safety baseline volume."
    - name: "Intervention Required Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN intervention_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs requiring intervention — clinical severity and resource-impact KPI."
    - name: "FDA Reporting Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_fda = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs reported to FDA — regulatory reporting compliance KPI."
    - name: "Root Cause Analysis Completion Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs with completed RCA — quality-improvement discipline KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory KPIs: on-hand value, days of supply, shortage exposure, and cycle-count variance. Drives supply-chain and working-capital decisions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status for availability and quarantine tracking."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "Controlled substance schedule for regulated-stock oversight."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status to focus stocking on preferred agents."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot for trending on-hand value."
  measures:
    - name: "Total Inventory Value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total on-hand inventory value — working-capital and shrink-risk KPI."
    - name: "Total Quantity On Hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units on hand — availability and overstock signal."
    - name: "Avg Cycle Count Variance"
      expr: AVG(CAST(cycle_count_variance AS DOUBLE))
      comment: "Average cycle-count variance — inventory-accuracy and diversion-risk KPI."
    - name: "Shortage Exposure Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shortage_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inventory items flagged in shortage — supply-continuity risk KPI."
    - name: "Avg Unit Cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit acquisition cost — procurement price trend indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription authoring KPIs: e-prescribing adoption, controlled-substance mix, and refill authorization. Steers prescribing quality and interoperability decisions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Prescription lifecycle status for pipeline analysis."
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription for order-mix analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance prescribing oversight."
    - name: "erx_transmission_status"
      expr: erx_transmission_status
      comment: "E-prescription transmission outcome for interoperability monitoring."
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Month of prescription for volume trending."
  measures:
    - name: "Prescription Count"
      expr: COUNT(1)
      comment: "Total prescriptions written — prescribing volume baseline."
    - name: "EPCS Adoption Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN epcs_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of eligible prescriptions using EPCS — controlled-substance e-prescribing compliance KPI."
    - name: "Prior Authorization Required Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions requiring PA — access-friction and staffing driver."
    - name: "Substitution Allowed Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_allowed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions permitting substitution — generic-utilization cost lever."
    - name: "Total Quantity Prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total units prescribed — demand-planning input."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled substance transaction KPIs: discrepancy rates, override/witness compliance, and PDMP reporting. Critical for diversion prevention and DEA compliance."
  source: "`vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of controlled-substance transaction for flow analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of the substance for regulated-tier oversight."
    - name: "department_code"
      expr: department_code
      comment: "Department involved for localized diversion monitoring."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of transaction for trend and audit sampling."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total controlled-substance transactions — baseline handling volume."
    - name: "Discrepancy Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions with discrepancies — diversion-risk and reconciliation KPI."
    - name: "Override Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions with overrides — cabinet-control and safety KPI."
    - name: "Witness Compliance Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN witnessed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions witnessed — waste/handling compliance KPI."
    - name: "PDMP Reporting Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdmp_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent reported to PDMP — regulatory reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication administration record KPIs: administration compliance, waste, and barcode verification. Steers med-safety and nursing-workflow decisions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Administration outcome (given, held, missed) for adherence analysis."
    - name: "administration_method"
      expr: administration_method
      comment: "Method of administration for route-specific safety review."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance administration oversight."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month of administration for trending."
  measures:
    - name: "Administration Count"
      expr: COUNT(1)
      comment: "Total medication administrations — baseline MAR volume."
    - name: "Total Waste Amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total medication waste quantity — cost-loss and diversion signal."
    - name: "Avg Dose Given"
      expr: AVG(CAST(dose_given AS DOUBLE))
      comment: "Average dose administered — dosing-pattern surveillance."
    - name: "First Dose Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_first_dose = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of administrations that are first-dose — high-alert monitoring focus KPI."
    - name: "STAT Order Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of STAT administrations — turnaround-urgency workload KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_therapy_mgmt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication therapy management KPIs: cost avoidance, drug-therapy-problem identification, and quality reporting. Demonstrates clinical-pharmacy value."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of MTM service delivered for program-mix analysis."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome status of the MTM encounter."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status for MTM revenue-capture tracking."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for volume and value trending."
  measures:
    - name: "MTM Encounter Count"
      expr: COUNT(1)
      comment: "Total MTM encounters — clinical-service volume baseline."
    - name: "Total Estimated Cost Avoidance"
      expr: SUM(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Total documented cost avoidance — headline value KPI for clinical pharmacy ROI."
    - name: "Drug Therapy Problem Identification Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drug_therapy_problem_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of encounters identifying a drug therapy problem — clinical-yield KPI."
    - name: "Quality Measure Reporting Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_measure_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of encounters reported to quality measures — value-based-care compliance KPI."
    - name: "Avg Cost Avoidance Per Encounter"
      expr: AVG(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Average cost avoidance per MTM encounter — per-service value benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rems_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REMS program compliance KPIs: enrollment, certification, and monitoring adherence for high-risk drugs. Regulatory-risk management view."
  source: "`vibe_healthcare_v1`.`pharmacy`.`rems_compliance`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "REMS program type for risk-tier segmentation."
    - name: "overall_compliance_status"
      expr: overall_compliance_status
      comment: "Overall compliance status of the REMS record."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category associated with the REMS program."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of REMS enrollment for trending."
  measures:
    - name: "REMS Record Count"
      expr: COUNT(1)
      comment: "Total REMS compliance records — program-population baseline."
    - name: "Overall Compliance Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of REMS records fully compliant — regulatory-adherence KPI."
    - name: "Prescriber Certification Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prescriber_certification_status = 'Certified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with certified prescribers — access-continuity compliance KPI."
    - name: "Lab Monitoring Compliance Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lab_monitoring_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed required lab monitoring — safety-monitoring adherence KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_drug_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking drug recall events and their impact"
  source: "`vibe_healthcare_v1`.`pharmacy`.`drug_recall`"
  dimensions:
    - name: "recall_month"
      expr: DATE_TRUNC('month', recall_initiation_date)
      comment: "Month when the recall was initiated"
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location associated with the recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Classification of the recall (e.g., Class I, II, III)"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Number of drug recall events"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of recalls"
$$;