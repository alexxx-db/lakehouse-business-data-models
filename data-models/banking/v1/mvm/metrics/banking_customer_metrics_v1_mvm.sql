-- Metric views for domain: customer | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`customer_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key customer-level metrics for overall portfolio management."
  source: "`banking_ecm`.`customer`.`party`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the party."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating classification of the party."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment assigned to the customer."
    - name: "country_id"
      expr: country_id
      comment: "Country of domicile (FK to reference.country)."
  measures:
    - name: "total_customers"
      expr: COUNT(1)
      comment: "Total number of customer parties."
    - name: "average_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average Customer Lifetime Value score across parties."
    - name: "pep_customer_count"
      expr: SUM(CASE WHEN is_pep THEN 1 ELSE 0 END)
      comment: "Count of parties flagged as Politically Exposed Persons (PEP)."
    - name: "sanctioned_customer_count"
      expr: SUM(CASE WHEN is_sanctioned THEN 1 ELSE 0 END)
      comment: "Count of parties flagged as sanctioned."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`customer_individual_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual customer profile metrics focusing on income, digital adoption and risk."
  source: "`banking_ecm`.`customer`.`individual_profile`"
  dimensions:
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment of the individual customer."
    - name: "education_level"
      expr: education_level
      comment: "Highest education level attained."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status."
    - name: "digital_banking_enrollment_flag"
      expr: digital_banking_enrollment_flag
      comment: "Whether the individual is enrolled in digital banking."
    - name: "pep_flag"
      expr: pep_flag
      comment: "PEP flag for the individual."
  measures:
    - name: "total_individuals"
      expr: COUNT(1)
      comment: "Total number of individual profiles."
    - name: "average_annual_income"
      expr: AVG(CAST(annual_income_amount AS DOUBLE))
      comment: "Average annual income amount across individuals."
    - name: "average_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average CLTV score for individuals."
    - name: "digital_enrollment_count"
      expr: SUM(CASE WHEN digital_banking_enrollment_flag THEN 1 ELSE 0 END)
      comment: "Count of individuals enrolled in digital banking."
    - name: "pep_individual_count"
      expr: SUM(CASE WHEN pep_flag THEN 1 ELSE 0 END)
      comment: "Count of individuals flagged as PEP."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`customer_kyc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC record metrics to monitor risk and regulatory compliance."
  source: "`banking_ecm`.`customer`.`kyc_record`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC status of the record."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates if the record is subject to regulatory reporting."
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction associated with the KYC record (FK)."
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity linked to the KYC record (FK)."
  measures:
    - name: "total_kyc_records"
      expr: COUNT(1)
      comment: "Total number of KYC records."
    - name: "average_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across KYC records."
    - name: "high_risk_kyc_count"
      expr: SUM(CASE WHEN overall_risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of KYC records with overall risk score >= 80 (high risk)."
    - name: "regulatory_reporting_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag THEN 1 ELSE 0 END)
      comment: "Count of KYC records flagged for regulatory reporting."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`customer_onboarding_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Onboarding case performance metrics for new customer acquisition."
  source: "`banking_ecm`.`customer`.`onboarding_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the onboarding case."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (e.g., digital, branch)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the case."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates if the case breached its SLA."
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type associated with the case (FK)."
  measures:
    - name: "total_onboarding_cases"
      expr: COUNT(1)
      comment: "Total number of onboarding cases."
    - name: "average_expected_balance"
      expr: AVG(CAST(expected_account_balance AS DOUBLE))
      comment: "Average expected account balance for onboarding cases."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of cases that breached SLA."
$$;
