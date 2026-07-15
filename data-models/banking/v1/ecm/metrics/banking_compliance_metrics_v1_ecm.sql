-- Metric views for domain: compliance | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

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
      comment: "Current status of the alert (e.g., Open, Closed)"
    - name: "alert_type"
      expr: alert_type
      comment: "Category/type of AML alert"
    - name: "priority"
      expr: priority
      comment: "Business‑assigned priority level"
    - name: "detection_date"
      expr: detection_date
      comment: "Date the alert was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_date)
      comment: "Month bucket for detection date"
    - name: "branch_id"
      expr: branch_id
      comment: "Branch where detection occurred"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of AML alerts generated"
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across alerts"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per alert"
    - name: "total_alert_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total monetary amount associated with alerts"
    - name: "high_risk_geography_alerts"
      expr: SUM(CASE WHEN high_risk_geography_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts flagged for high‑risk geography"
    - name: "pep_alerts"
      expr: SUM(CASE WHEN pep_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts involving politically exposed persons"
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
      comment: "Current status of the case"
    - name: "case_type"
      expr: case_type
      comment: "Type/category of the case"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the case"
    - name: "case_opened_month"
      expr: DATE_TRUNC('month', case_opened_date)
      comment: "Month when the case was opened"
    - name: "employee_id"
      expr: employee_id
      comment: "Investigator employee identifier"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of AML cases"
    - name: "total_case_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across cases"
    - name: "avg_case_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per case"
    - name: "total_case_transaction_amount"
      expr: SUM(CAST(total_transaction_amount AS DOUBLE))
      comment: "Total transaction amount linked to cases"
    - name: "cases_with_sar_filed"
      expr: SUM(CASE WHEN sar_filing_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of cases that have an associated SAR filing"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing volume and financial exposure metrics"
  source: "`banking_ecm`.`compliance`.`compliance_regulatory_filing`"
  dimensions:
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency receiving the filing"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing"
    - name: "branch_id"
      expr: branch_id
      comment: "Branch responsible for the filing"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month of the reporting period"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted"
    - name: "total_income_amount"
      expr: SUM(CAST(income_amount AS DOUBLE))
      comment: "Sum of income amounts reported"
    - name: "total_suspicious_activity_amount"
      expr: SUM(CAST(suspicious_activity_amount AS DOUBLE))
      comment: "Sum of suspicious activity amounts reported"
    - name: "avg_income_amount"
      expr: AVG(CAST(income_amount AS DOUBLE))
      comment: "Average income amount per filing"
    - name: "filings_with_fatca_jurisdiction"
      expr: SUM(CASE WHEN fatca_jurisdiction IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of filings that include a FATCA jurisdiction"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_sanctions_screening_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on sanctions screening effectiveness and risk"
  source: "`banking_ecm`.`compliance`.`sanctions_screening_event`"
  dimensions:
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening performed"
    - name: "disposition"
      expr: disposition
      comment: "Outcome disposition of the screening"
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month of the screening event"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned by the screening"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screening events"
    - name: "total_match_score"
      expr: SUM(CAST(match_score AS DOUBLE))
      comment: "Sum of match scores across screenings"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score per screening"
    - name: "sar_filed_events"
      expr: SUM(CASE WHEN sar_filed THEN 1 ELSE 0 END)
      comment: "Count of screenings that resulted in a SAR filing"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`compliance_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level breach impact and remediation metrics"
  source: "`banking_ecm`.`compliance`.`breach`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (e.g., Open, Closed)"
    - name: "breach_type"
      expr: breach_type
      comment: "Category of the breach"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the breach"
    - name: "regulator_name"
      expr: regulator_name
      comment: "Regulatory body overseeing the breach"
    - name: "occurrence_month"
      expr: DATE_TRUNC('month', occurrence_date)
      comment: "Month when the breach occurred"
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total number of compliance breaches recorded"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of breaches"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per breach"
    - name: "sar_filed_breaches"
      expr: SUM(CASE WHEN sar_filed_flag THEN 1 ELSE 0 END)
      comment: "Count of breaches that triggered SAR filing"
$$;
