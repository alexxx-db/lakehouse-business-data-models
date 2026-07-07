-- Metric views for domain: customer | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_enforcement_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of enforcement actions on accounts."
  source: "`vibe_water_utilities_v1`.`customer`.`account_enforcement_impact`"
  dimensions:
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity level of the enforcement impact"
    - name: "impact_resolution_month"
      expr: DATE_TRUNC('month', impact_resolution_date)
      comment: "Month when impact was resolved"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account identifier"
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Sum of monetary impact from enforcement actions"
    - name: "count_enforcement_impacts"
      expr: COUNT(1)
      comment: "Number of enforcement impact records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status change metrics for customer accounts."
  source: "`vibe_water_utilities_v1`.`customer`.`account_status_history`"
  dimensions:
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the status effective date"
    - name: "new_status_code"
      expr: new_status_code
      comment: "New status code after change"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system identifier"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Identifier of the customer account"
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance amount across accounts"
    - name: "total_reconnection_fee"
      expr: SUM(CAST(reconnection_fee_amount AS DOUBLE))
      comment: "Total reconnection fees charged"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held"
    - name: "count_status_changes"
      expr: COUNT(1)
      comment: "Number of account status change records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling performance and financial adjustments."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the complaint"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month the complaint was reported"
  measures:
    - name: "total_billing_adjustment"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments issued for complaints"
    - name: "count_compensation_provided"
      expr: SUM(CASE WHEN compensation_provided_flag THEN 1 ELSE 0 END)
      comment: "Number of complaints where compensation was provided"
    - name: "average_resolution_time_days"
      expr: AVG(DATEDIFF(resolution_timestamp, reported_timestamp))
      comment: "Average time in days to resolve complaints"
    - name: "count_complaints"
      expr: COUNT(1)
      comment: "Total number of complaint records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit holdings across accounts and services."
  source: "`vibe_water_utilities_v1`.`customer`.`deposit`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the deposit"
    - name: "service_agreement_id"
      expr: service_agreement_id
      comment: "Service agreement linked to the deposit"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account owning the deposit"
  measures:
    - name: "count_deposits"
      expr: COUNT(1)
      comment: "Number of deposit records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_parcel_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation and tax metrics for parcels owned by customers."
  source: "`vibe_water_utilities_v1`.`customer`.`parcel`"
  dimensions:
    - name: "county"
      expr: county
      comment: "County where parcel is located"
    - name: "city"
      expr: city
      comment: "City of the parcel"
    - name: "zip_code"
      expr: zip_code
      comment: "Postal code"
    - name: "owner_name"
      expr: owner_name
      comment: "Name of the parcel owner"
  measures:
    - name: "total_tax_assessed"
      expr: SUM(CAST(tax_assessed_value AS DOUBLE))
      comment: "Total tax-assessed value of parcels"
    - name: "average_valuation_usd"
      expr: AVG(CAST(valuation_usd AS DOUBLE))
      comment: "Average valuation in USD"
    - name: "count_parcels"
      expr: COUNT(1)
      comment: "Number of parcel records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water demand and building size metrics for premises."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise"
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Flag indicating water service availability"
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Pressure zone of the premise"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the premise record was created"
  measures:
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across premises"
    - name: "average_building_square_footage"
      expr: AVG(CAST(building_square_footage AS DOUBLE))
      comment: "Average building square footage"
    - name: "count_premises"
      expr: COUNT(1)
      comment: "Number of premise records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_active_customer_accounts`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Count of active service accounts by class and type, the top-line customer base metric for the utility."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  filter: account_status = 'ACTIVE'
  dimensions:
    - name: "Account Class"
      expr: account_class
      comment: "Residential/commercial/industrial/municipal"
    - name: "Account Type"
      expr: account_type
      comment: "Account type"
    - name: "Billing Cycle"
      expr: billing_cycle_code
      comment: "Billing cycle"
  measures:
    - name: "Active Accounts"
      expr: COUNT(1)
      comment: "Number of active accounts"
    - name: "Total Meters"
      expr: SUM(CAST(meter_count AS DOUBLE))
      comment: "Total metered connections"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_average_monthly_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average monthly water consumption per account by customer class, a demand and conservation planning KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "Account Class"
      expr: account_class
      comment: "Customer class"
    - name: "Account Type"
      expr: account_type
      comment: "Account type"
  measures:
    - name: "Avg Monthly Consumption Gal"
      expr: ROUND(AVG(CAST(average_monthly_consumption_gal AS DOUBLE)), 0)
      comment: "Average monthly consumption"
    - name: "Accounts"
      expr: COUNT(1)
      comment: "Number of accounts"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_ar_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total current balance and delinquency counts across accounts, driving cash flow and collections strategy."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "Account Class"
      expr: account_class
      comment: "Customer class"
    - name: "Credit Rating"
      expr: credit_rating
      comment: "Credit rating band"
  measures:
    - name: "Total Current Balance USD"
      expr: ROUND(SUM(CAST(current_balance_amount AS DOUBLE)), 2)
      comment: "Sum of current balances"
    - name: "Total Delinquencies"
      expr: SUM(CAST(delinquency_count AS DOUBLE))
      comment: "Total delinquency events"
    - name: "Lien Accounts %"
      expr: ROUND(100.0 * SUM(CASE WHEN lien_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with liens"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_autopay_paperless_adoption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adoption rate of autopay and paperless billing, a cost-to-serve and digital engagement KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "Account Class"
      expr: account_class
      comment: "Customer class"
  measures:
    - name: "AutoPay Adoption %"
      expr: ROUND(100.0 * SUM(CASE WHEN autopay_enrolled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent enrolled in autopay"
    - name: "Paperless Adoption %"
      expr: ROUND(100.0 * SUM(CASE WHEN paperless_billing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent enrolled in paperless"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_assistance_program_enrollment_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of accounts enrolled in affordability programs, an equity and affordability KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "Account Class"
      expr: account_class
      comment: "Customer class"
    - name: "Account Status"
      expr: account_status
      comment: "Status"
  measures:
    - name: "Assistance Enrollment %"
      expr: ROUND(100.0 * SUM(CASE WHEN assistance_program_enrolled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent enrolled in assistance"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint volume by category and share resulting in compensation, a service quality and reputational KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_complaint`"
  dimensions:
    - name: "Complaint Category"
      expr: complaint_category
      comment: "Category of complaint"
    - name: "Assigned Department"
      expr: assigned_to_department
      comment: "Owning department"
  measures:
    - name: "Complaint Count"
      expr: COUNT(1)
      comment: "Number of complaints"
    - name: "Compensated %"
      expr: ROUND(100.0 * SUM(CASE WHEN compensation_provided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with compensation"
    - name: "Total Billing Adjustments USD"
      expr: ROUND(SUM(CAST(billing_adjustment_amount AS DOUBLE)), 2)
      comment: "Total complaint-driven billing adjustments"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_case_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average days a case stays open by type and priority, an AWWA customer-service SLA KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`case`"
  dimensions:
    - name: "Case Type"
      expr: case_type
      comment: "Case type"
    - name: "Case Priority"
      expr: case_priority
      comment: "Priority"
    - name: "Assigned Department"
      expr: assigned_department
      comment: "Owning department"
  measures:
    - name: "Avg Days Open"
      expr: ROUND(AVG(CAST(days_open AS DOUBLE)), 1)
      comment: "Average case age in days"
    - name: "Case Count"
      expr: COUNT(1)
      comment: "Number of cases"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_interaction_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average customer satisfaction score and callback completion across interaction channels, a CX KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`interaction`"
  dimensions:
    - name: "Channel"
      expr: channel
      comment: "Interaction channel"
    - name: "Interaction Category"
      expr: interaction_category
      comment: "Category"
  measures:
    - name: "Avg CSAT"
      expr: ROUND(AVG(CAST(customer_satisfaction_score AS DOUBLE)), 2)
      comment: "Average satisfaction score"
    - name: "Callback Completion %"
      expr: ROUND(100.0 * SUM(CASE WHEN callback_completed_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN callback_requested_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percent of requested callbacks completed"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_assistance_enrollment_arrearage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total arrearage forgiven and benefits applied through assistance enrollments, an affordability impact KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment`"
  dimensions:
    - name: "Assistance Program"
      expr: assistance_program_id
      comment: "Program"
    - name: "Approved"
      expr: approved_flag
      comment: "Approval flag"
  measures:
    - name: "Total Arrearage Forgiven USD"
      expr: ROUND(SUM(CAST(arrearage_forgiven AS DOUBLE)), 2)
      comment: "Total arrearage forgiven"
    - name: "Total Benefit Applied USD"
      expr: ROUND(SUM(CAST(benefit_amount_applied AS DOUBLE)), 2)
      comment: "Total benefit applied"
    - name: "Avg AMI %"
      expr: ROUND(AVG(CAST(ami_percentage AS DOUBLE)), 1)
      comment: "Average area median income percentage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_application_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval rate of service applications and average connection fees, a growth pipeline KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`service_application`"
  dimensions:
    - name: "Application Type"
      expr: application_type
      comment: "New/transfer/modify"
    - name: "Application Status"
      expr: application_status
      comment: "Status"
    - name: "Credit Check Status"
      expr: credit_check_status
      comment: "Credit check outcome"
  measures:
    - name: "Approval %"
      expr: ROUND(100.0 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent approved"
    - name: "Avg Connection Fee USD"
      expr: ROUND(AVG(CAST(connection_fee_amount AS DOUBLE)), 2)
      comment: "Average connection fee"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_deposit_holdings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total security deposits held, applied, and refunded, a liability and cash-management KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`deposit`"
  dimensions:
    - name: "Deposit Category"
      expr: deposit_category
      comment: "Deposit category"
    - name: "Classification"
      expr: classification
      comment: "Deposit classification"
  measures:
    - name: "Total Deposit Held USD"
      expr: ROUND(SUM(CAST(amount_usd AS DOUBLE)), 2)
      comment: "Total deposit amount"
    - name: "Total Refunded USD"
      expr: ROUND(SUM(CAST(amount_refunded AS DOUBLE)), 2)
      comment: "Total refunded"
    - name: "Total Balance Remaining USD"
      expr: ROUND(SUM(CAST(balance_remaining AS DOUBLE)), 2)
      comment: "Remaining balance"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_status_delinquency_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume of status transitions and average days delinquent at transition, a lifecycle and collections KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`account_status_history`"
  dimensions:
    - name: "New Status"
      expr: new_status_code
      comment: "Resulting status"
    - name: "Initiated By System"
      expr: initiated_by_system_code
      comment: "Initiating system"
  measures:
    - name: "Transition Count"
      expr: COUNT(1)
      comment: "Number of transitions"
    - name: "Avg Days Delinquent"
      expr: ROUND(AVG(CAST(days_delinquent AS DOUBLE)), 1)
      comment: "Average days delinquent"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_conservation_program_savings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average actual reduction percentage achieved by conservation program enrollees, a demand-management KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_program_enrollment`"
  dimensions:
    - name: "Conservation Program"
      expr: conservation_program_id
      comment: "Program"
    - name: "Certification Status"
      expr: certification_status
      comment: "Certification status"
  measures:
    - name: "Avg Reduction %"
      expr: ROUND(AVG(CAST(actual_reduction_pct AS DOUBLE)), 2)
      comment: "Average realized reduction"
    - name: "Enrollments"
      expr: COUNT(1)
      comment: "Number of enrollments"
    - name: "Avg Baseline Usage Gal"
      expr: ROUND(AVG(CAST(baseline_usage_gallons AS DOUBLE)), 0)
      comment: "Average baseline usage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise_demand_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Estimated daily demand and building attributes across premises, supporting distribution and capacity planning."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "Building Type"
      expr: building_type
      comment: "Building type"
    - name: "Territory"
      expr: territory_id
      comment: "Service territory"
  measures:
    - name: "Total Estimated Daily Demand Gal"
      expr: ROUND(SUM(CAST(estimated_daily_demand_gallons AS DOUBLE)), 0)
      comment: "Sum of estimated daily demand"
    - name: "Premises"
      expr: COUNT(1)
      comment: "Number of premises"
    - name: "Backflow Required %"
      expr: ROUND(100.0 * SUM(CASE WHEN backflow_prevention_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring backflow prevention"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_overflow_premise_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleanup cost and customer compensation from SSO/CSO events affecting premises, an environmental and liability KPI."
  source: "`vibe_water_utilities_v1`.`customer`.`premise_overflow_impact`"
  dimensions:
    - name: "Contamination Level"
      expr: contamination_level
      comment: "Contamination severity"
    - name: "Compensation Status"
      expr: compensation_status
      comment: "Compensation status"
  measures:
    - name: "Total Cleanup Cost USD"
      expr: ROUND(SUM(CAST(cleanup_cost AS DOUBLE)), 2)
      comment: "Total cleanup cost"
    - name: "Total Compensation USD"
      expr: ROUND(SUM(CAST(customer_compensation_amount AS DOUBLE)), 2)
      comment: "Total customer compensation"
    - name: "Impacted Premises"
      expr: COUNT(1)
      comment: "Number of impacted premises"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_segment_revenue_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue contribution and customer counts by segment, a strategic portfolio KPI for rate design."
  source: "`vibe_water_utilities_v1`.`customer`.`segment`"
  dimensions:
    - name: "Segment Name"
      expr: segment_name
      comment: "Segment"
    - name: "Regulatory Reporting Category"
      expr: regulatory_reporting_category
      comment: "Reporting category"
  measures:
    - name: "Avg Revenue Contribution %"
      expr: ROUND(AVG(CAST(revenue_contribution_pct AS DOUBLE)), 2)
      comment: "Average revenue contribution"
    - name: "Total Customers"
      expr: SUM(CAST(customer_count AS DOUBLE))
      comment: "Total customers in segment"
    - name: "Avg Conservation Target %"
      expr: ROUND(AVG(CAST(conservation_target_pct AS DOUBLE)), 2)
      comment: "Average conservation target"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_third_party_notification_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active third-party notification arrangements, protecting vulnerable customers per medical baseline and LIRA programs."
  source: "`vibe_water_utilities_v1`.`customer`.`third_party_notification`"
  dimensions:
    - name: "Arrangement Status"
      expr: arrangement_status
      comment: "Status"
    - name: "Consent Method"
      expr: consent_method
      comment: "Consent method"
  measures:
    - name: "Active Arrangements"
      expr: SUM(CASE WHEN arrangement_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Count of active arrangements"
    - name: "Medical Baseline %"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_baseline_program_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with medical baseline"
$$;