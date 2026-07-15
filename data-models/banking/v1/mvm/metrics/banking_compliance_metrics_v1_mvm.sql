-- Metric views for domain: compliance | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_aml_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AML alert performance and risk metrics"
  source: "`banking_ecm`.`compliance`.`aml_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (e.g., open, closed)"
    - name: "alert_type"
      expr: alert_type
      comment: "Classification of the alert (e.g., transaction, account)"
    - name: "priority"
      expr: priority
      comment: "Business‑assigned priority level"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_date)
      comment: "Month in which the alert was detected"
    - name: "branch_id"
      expr: branch_id
      comment: "Branch where detection occurred"
    - name: "high_risk_geography_flag"
      expr: high_risk_geography_flag
      comment: "Boolean flag for high‑risk geography"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of AML alerts generated"
    - name: "total_alert_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of the monetary amount associated with alerts"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across alerts"
    - name: "high_risk_geography_alerts"
      expr: SUM(CASE WHEN high_risk_geography_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts flagged for high‑risk geography"
    - name: "pep_flagged_alerts"
      expr: SUM(CASE WHEN pep_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts where the party is a politically exposed person"
    - name: "sar_filed_alerts"
      expr: SUM(CASE WHEN sar_filed_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts that resulted in a SAR filing"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_aml_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated view of AML case outcomes and exposure"
  source: "`banking_ecm`.`compliance`.`aml_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., open, closed, escalated)"
    - name: "case_type"
      expr: case_type
      comment: "Type of AML case (e.g., structuring, fraud)"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the case"
    - name: "case_opened_month"
      expr: DATE_TRUNC('month', case_opened_date)
      comment: "Month the case was opened"
    - name: "assigned_investigator_name"
      expr: assigned_investigator_name
      comment: "Investigator responsible for the case"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of AML cases"
    - name: "total_case_transaction_amount"
      expr: SUM(CAST(total_transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts linked to cases"
    - name: "average_case_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across cases"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_sanctions_screening_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions screening effectiveness and risk exposure"
  source: "`banking_ecm`.`compliance`.`sanctions_screening_event`"
  dimensions:
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening performed (e.g., OFAC, EU)"
    - name: "disposition"
      expr: disposition
      comment: "Outcome of the screening (e.g., match, no_match)"
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month of the screening event"
    - name: "branch_id"
      expr: branch_id
      comment: "Branch where screening was executed"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned by the screening system"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screening events processed"
    - name: "average_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score for screened entities"
    - name: "sar_filed_screenings"
      expr: SUM(CASE WHEN sar_filed THEN 1 ELSE 0 END)
      comment: "Count of screenings that triggered a SAR filing"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial exposure and reporting volume from regulatory filings"
  source: "`banking_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., submitted, approved)"
  measures:
    - name: "total_filing_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount reported in regulatory filings"
    - name: "average_suspicious_activity_amount"
      expr: AVG(CAST(suspicious_activity_amount AS DOUBLE))
      comment: "Average amount per suspicious activity reported"
    - name: "total_suspicious_activity_amount"
      expr: SUM(CAST(suspicious_activity_amount AS DOUBLE))
      comment: "Cumulative amount of suspicious activity across filings"
$$;
