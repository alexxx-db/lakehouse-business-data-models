-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy dispensing KPIs covering fill volume, revenue capture, patient cost share, and counseling compliance across locations and payers."
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_status"
      expr: dispense_status
      comment: "Lifecycle status of the dispense (dispensed, reversed, pending) for throughput and exception analysis."
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (new fill, refill, etc.) used to segment volume."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled-substance schedule for compliance and diversion monitoring."
    - name: "dispensing_location_name"
      expr: dispensing_location_name
      comment: "Name of the dispensing pharmacy location for site-level performance."
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_timestamp)
      comment: "Month of dispense for trending fill volume and revenue over time."
  measures:
    - name: "Dispense Events"
      expr: COUNT(1)
      comment: "Total number of dispensing events; baseline throughput volume."
    - name: "Total Dispensed Quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total units dispensed; drives inventory demand and capacity planning."
    - name: "Total Medication Cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total acquisition/medication cost dispensed; core pharmacy cost driver."
    - name: "Total Insurance Paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total reimbursed by insurance; revenue capture from payers."
    - name: "Total Patient Pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket; affordability and collections indicator."
    - name: "Total Dispensing Fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees earned; service revenue component."
    - name: "Avg Patient Pay"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient cost share per fill; affordability KPI."
    - name: "Counseling Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of dispenses with completed patient counseling; regulatory/quality compliance."
    - name: "Substitution Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_made_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fills where generic/therapeutic substitution occurred; cost-savings lever."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim adjudication KPIs covering paid amounts, reject rates, patient copay, and reversals for revenue-cycle steering."
  source: "`vibe_healthcare_v1`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Adjudication status of the claim (paid, rejected, reversed) for revenue-cycle monitoring."
    - name: "transaction_response_status"
      expr: transaction_response_status
      comment: "Payer transaction response outcome for adjudication analysis."
    - name: "reject_code"
      expr: reject_code
      comment: "Standard reject reason code for denial-driver analysis."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination-of-benefits flag for multi-payer claim segmentation."
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_date)
      comment: "Month of claim submission for adjudication trending."
  measures:
    - name: "Rx Claims"
      expr: COUNT(1)
      comment: "Total pharmacy claims processed; baseline claim volume."
    - name: "Total Plan Paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by plans; core reimbursement revenue."
    - name: "Total Patient Copay"
      expr: SUM(CAST(patient_copay AS DOUBLE))
      comment: "Total patient copay collected; affordability and collections."
    - name: "Total Ingredient Cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total drug ingredient cost billed; margin driver."
    - name: "Total Amount Paid"
      expr: SUM(CAST(total_amount_paid AS DOUBLE))
      comment: "Total paid across all payers; overall claim value."
    - name: "Claim Reject Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims rejected; denial-management KPI driving rework."
    - name: "Claim Reversal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims reversed; indicates rework and dispensing errors."
    - name: "Avg Patient Copay"
      expr: AVG(CAST(patient_copay AS DOUBLE))
      comment: "Average patient copay per claim; affordability indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription lifecycle KPIs covering volume, e-prescribing transmission, controlled substances, prior-auth burden, and refill utilization."
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Status of the prescription (active, discontinued, expired) for lifecycle analysis."
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription for volume segmentation."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance monitoring."
    - name: "erx_transmission_status"
      expr: erx_transmission_status
      comment: "Electronic prescribing transmission outcome for interoperability tracking."
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Month prescription was written for volume trending."
  measures:
    - name: "Prescriptions"
      expr: COUNT(1)
      comment: "Total prescriptions written; baseline prescribing volume."
    - name: "Total Quantity Prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total units prescribed; demand and dosing volume indicator."
    - name: "EPCS Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN epcs_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent electronic prescribing of controlled substances; compliance and modernization KPI."
    - name: "Prior Auth Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions requiring prior authorization; administrative burden and delay driver."
    - name: "Substitution Allowed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions permitting substitution; generic-savings opportunity."
    - name: "Distinct Prescribers"
      expr: COUNT(DISTINCT prescription_prescriber_clinician_id)
      comment: "Number of distinct prescribers; prescribing-base breadth."
    - name: "Distinct Patients"
      expr: COUNT(DISTINCT prescription_patient_mpi_record_id)
      comment: "Number of distinct patients prescribed for; reach and panel size."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory KPIs covering stock value, days of supply, shortages, and expiration risk for supply-chain steering."
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status (active, quarantined, etc.) for stock-health analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance stock segmentation."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the stocked drug for coverage-aligned inventory."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot for trend analysis."
  measures:
    - name: "Inventory Line Items"
      expr: COUNT(1)
      comment: "Number of inventory line records; catalog breadth baseline."
    - name: "Total Inventory Value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total on-hand inventory value; working-capital tied up in stock."
    - name: "Total Quantity On Hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units on hand; physical stock position."
    - name: "Avg Unit Cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit acquisition cost; cost-trend indicator."
    - name: "Shortage Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shortage_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of items flagged in shortage; availability risk driving substitution/sourcing action."
    - name: "High Alert Med Share Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN high_alert_medication = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of stock that is high-alert medication; safety exposure indicator."
    - name: "Avg Cycle Count Variance"
      expr: AVG(CAST(cycle_count_variance AS DOUBLE))
      comment: "Average cycle-count variance; inventory accuracy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication prior-authorization KPIs covering approval rates, denials, appeals, and turnaround for access-to-therapy steering."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_pa_request`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Prior-authorization status (approved, denied, pending) for pipeline analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for root-cause and payer-behavior analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the PA request for prioritization SLAs."
    - name: "specialty_medication_flag"
      expr: specialty_medication_flag
      comment: "Whether the request is for a specialty medication; high-cost segment."
    - name: "pa_request_month"
      expr: DATE_TRUNC('MONTH', pa_request_date)
      comment: "Month of PA request for volume and turnaround trending."
  measures:
    - name: "PA Requests"
      expr: COUNT(1)
      comment: "Total prior-authorization requests; administrative volume baseline."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pa_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests approved; patient access-to-therapy KPI."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pa_status = 'denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests denied; access barrier and rework driver."
    - name: "Appeal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests appealed; downstream administrative burden."
    - name: "Total Estimated Medication Cost"
      expr: SUM(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Total estimated medication cost under PA; financial exposure of gated therapies."
    - name: "Step Therapy Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN step_therapy_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring step therapy; access-restriction indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_therapy_mgmt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management KPIs covering intervention volume, cost avoidance, and CMS Part D compliance for value-based pharmacy."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of MTM service delivered for program-mix analysis."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome status of the intervention for effectiveness analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the MTM service for revenue realization."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of MTM service for volume and outcome trending."
  measures:
    - name: "MTM Services"
      expr: COUNT(1)
      comment: "Total MTM services delivered; program throughput baseline."
    - name: "Total Estimated Cost Avoidance"
      expr: SUM(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Total estimated cost avoidance from interventions; value-of-service KPI."
    - name: "Avg Cost Avoidance"
      expr: AVG(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Average cost avoidance per MTM service; intervention efficiency."
    - name: "Drug Therapy Problem Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN drug_therapy_problem_identified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews identifying a drug therapy problem; clinical yield of the program."
    - name: "CMS Part D Compliant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_part_d_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of services meeting CMS Part D requirements; regulatory compliance KPI."
    - name: "Prescriber Notified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prescriber_notified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of interventions communicated to prescriber; closed-loop follow-through."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse drug event KPIs covering severity, preventability, harm, and regulatory reporting for medication-safety steering."
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the ADE for safety prioritization."
    - name: "harm_category"
      expr: harm_category
      comment: "Category of patient harm for outcome analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse drug event for pattern detection."
    - name: "detection_method"
      expr: detection_method
      comment: "How the event was detected for surveillance-effectiveness analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event occurred for safety trending."
  measures:
    - name: "Adverse Drug Events"
      expr: COUNT(1)
      comment: "Total adverse drug events; core patient-safety volume metric."
    - name: "Intervention Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN intervention_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs requiring clinical intervention; harm-severity indicator."
    - name: "Reported To FDA Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_fda = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs reported to FDA; regulatory reporting compliance."
    - name: "RCA Performed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs with root-cause analysis; learning-system maturity KPI."
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