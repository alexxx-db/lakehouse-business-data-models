-- Metric views for domain: customer | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core account KPIs for the utility customer base"
  source: "`energy_utilities_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (Residential, Commercial, Industrial)"
    - name: "service_territory_code"
      expr: service_territory_code
      comment: "Geographic service territory code"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the account"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month the account was activated"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "total_open_balance"
      expr: SUM(CAST(open_balance AS DOUBLE))
      comment: "Sum of open balances across all accounts"
    - name: "average_open_balance"
      expr: AVG(CAST(open_balance AS DOUBLE))
      comment: "Average open balance per account"
    - name: "count_ami_enrolled"
      expr: SUM(CASE WHEN ami_enrolled THEN 1 ELSE 0 END)
      comment: "Number of accounts enrolled in AMI program"
    - name: "count_budget_billing_enrolled"
      expr: SUM(CASE WHEN budget_billing_enrolled THEN 1 ELSE 0 END)
      comment: "Number of accounts enrolled in budget billing"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for demand‑response and incentive program enrollments"
  source: "`energy_utilities_ecm`.`customer`.`customer_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Inactive, Cancelled)"
    - name: "dr_program_id"
      expr: dr_program_id
      comment: "Identifier of the demand‑response program"
    - name: "incentive_program_id"
      expr: incentive_program_id
      comment: "Identifier of the incentive program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of customer enrollments"
    - name: "count_demand_response_program"
      expr: SUM(CASE WHEN demand_response_program IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of enrollments participating in a demand response program"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling performance metrics"
  source: "`energy_utilities_ecm`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Category/type of complaint"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the complaint"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction associated with the complaint"
    - name: "complaint_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the complaint was created"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints received"
    - name: "total_billing_dispute_amount"
      expr: SUM(CAST(billing_dispute_amount AS DOUBLE))
      comment: "Sum of monetary amounts disputed in complaints"
    - name: "avg_resolution_time_days"
      expr: AVG(DATEDIFF(resolution_timestamp, created_timestamp))
      comment: "Average time (in days) to resolve a complaint"
    - name: "count_escalated"
      expr: SUM(CASE WHEN escalation_tier IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of complaints that were escalated"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction volume and engagement metrics"
  source: "`energy_utilities_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_category"
      expr: interaction_category
      comment: "High‑level category of the interaction"
    - name: "channel_type"
      expr: channel_type
      comment: "Communication channel used (Phone, Email, Chat, etc.)"
    - name: "interaction_date"
      expr: interaction_date
      comment: "Date of the interaction"
    - name: "agent_queue"
      expr: agent_queue
      comment: "Queue or team handling the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions"
    - name: "count_survey_response"
      expr: SUM(CASE WHEN survey_response_flag THEN 1 ELSE 0 END)
      comment: "Number of interactions that included a survey response"
    - name: "count_demand_response_enrollment"
      expr: SUM(CASE WHEN demand_response_enrollment_flag THEN 1 ELSE 0 END)
      comment: "Number of interactions that resulted in demand‑response enrollment"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_field_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field order execution and financial impact metrics"
  source: "`energy_utilities_ecm`.`customer`.`field_order`"
  dimensions:
    - name: "status"
      expr: field_order_status
      comment: "Current status of the field order"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being performed"
    - name: "priority"
      expr: priority
      comment: "Priority level of the field order"
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('day', scheduled_start_timestamp)
      comment: "Scheduled start date of the field order"
  measures:
    - name: "total_field_orders"
      expr: COUNT(1)
      comment: "Total number of field orders issued"
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Sum of gross amounts for all field orders"
    - name: "average_gross_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross amount per field order"
    - name: "count_emergency"
      expr: SUM(CASE WHEN is_emergency THEN 1 ELSE 0 END)
      comment: "Number of field orders flagged as emergency"
$$;
