-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account health, credit risk, and revenue performance"
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "Account Status"
      expr: account_status
      comment: "Current operational status of the customer account"
    - name: "Account Type"
      expr: account_type
      comment: "Classification of account (direct, distributor, OEM, etc.)"
    - name: "Credit Rating"
      expr: credit_rating
      comment: "Credit risk rating assigned to the account"
    - name: "Revenue Tier"
      expr: revenue_tier
      comment: "Revenue band classification for account segmentation"
    - name: "Geographic Region"
      expr: geographic_region
      comment: "Geographic market region of the account"
    - name: "Industry Vertical"
      expr: industry_vertical
      comment: "Target industry vertical (automotive, consumer, industrial, etc.)"
    - name: "Strategic Classification"
      expr: strategic_classification
      comment: "Strategic importance tier (key account, strategic partner, standard, etc.)"
    - name: "Sales Region"
      expr: sales_region
      comment: "Sales territory region assignment"
    - name: "Compliance Status"
      expr: compliance_status
      comment: "Overall compliance standing of the account"
    - name: "Creation Year"
      expr: YEAR(creation_date)
      comment: "Year the account was created"
    - name: "Creation Quarter"
      expr: CONCAT('Q', QUARTER(creation_date), '-', YEAR(creation_date))
      comment: "Quarter and year the account was created"
    - name: "Last Order Year"
      expr: YEAR(last_order_date)
      comment: "Year of most recent order"
  measures:
    - name: "Total Accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Distinct count of customer accounts"
    - name: "Active Accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Count of accounts in active status"
    - name: "Average Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Mean credit risk score across accounts"
    - name: "High Risk Accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) > 70 THEN account_id END)
      comment: "Count of accounts with risk score above 70"
    - name: "Tax Exempt Accounts"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = true THEN account_id END)
      comment: "Count of accounts with tax exemption status"
    - name: "Accounts With Recent Orders"
      expr: COUNT(DISTINCT CASE WHEN last_order_date >= DATE_SUB(CURRENT_DATE(), 90) THEN account_id END)
      comment: "Count of accounts with orders in the last 90 days"
    - name: "Dormant Accounts"
      expr: COUNT(DISTINCT CASE WHEN last_order_date < DATE_SUB(CURRENT_DATE(), 365) OR last_order_date IS NULL THEN account_id END)
      comment: "Count of accounts with no orders in the past year"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account team coverage and workload metrics. Used by Sales Operations and HR to ensure adequate customer coverage, identify overloaded team members, and optimize account team assignments."
  source: "`vibe_semiconductors_v1`.`customer`.`account_team`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the team assignment (Active, Inactive, Pending) for coverage management."
    - name: "role"
      expr: role
      comment: "Role of the team member on the account for coverage type analysis."
    - name: "team_role"
      expr: team_role
      comment: "Team role classification for organizational coverage analysis."
    - name: "responsibility_area"
      expr: responsibility_area
      comment: "Area of responsibility for workload distribution analysis."
    - name: "coverage_region"
      expr: coverage_region
      comment: "Geographic coverage region for regional coverage gap analysis."
    - name: "territory"
      expr: territory
      comment: "Sales territory for territory coverage analysis."
    - name: "is_primary_owner"
      expr: is_primary_owner
      comment: "Whether the team member is the primary account owner for ownership clarity."
    - name: "is_active"
      expr: is_active
      comment: "Whether the assignment is currently active for coverage health tracking."
    - name: "assignment_start_year_month"
      expr: DATE_TRUNC('month', assignment_start_date)
      comment: "Month the assignment started for team stability analysis."
  measures:
    - name: "total_account_assignments"
      expr: COUNT(DISTINCT account_team_id)
      comment: "Total account team assignments. Baseline measure of coverage portfolio size."
    - name: "active_assignments"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN account_team_id END)
      comment: "Number of active account team assignments. Tracks current coverage capacity."
    - name: "unique_accounts_covered"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts with team coverage. Identifies coverage gaps in the account portfolio."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage per assignment. High averages signal overloaded team members; low averages signal underutilization."
    - name: "avg_workload_percentage"
      expr: AVG(CAST(workload_percentage AS DOUBLE))
      comment: "Average workload percentage per team assignment. Tracks team capacity utilization for resource planning."
    - name: "total_allocation_percent"
      expr: SUM(CAST(allocation_percent AS DOUBLE))
      comment: "Total allocation percentage across all assignments. Used to identify over-allocated team members when grouped by employee."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit and financial health metrics for risk management and credit policy decisions"
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "Credit Profile Status"
      expr: credit_profile_status
      comment: "Current status of the credit profile"
    - name: "Credit Rating Internal"
      expr: credit_rating_internal
      comment: "Internal credit rating classification"
    - name: "Credit Rating External"
      expr: credit_rating_external
      comment: "External agency credit rating"
    - name: "Risk Category"
      expr: risk_category
      comment: "Risk tier classification (low, medium, high)"
    - name: "Credit Hold Status"
      expr: CASE WHEN credit_hold_flag = true THEN 'On Hold' ELSE 'Active' END
      comment: "Whether account is on credit hold"
    - name: "Preferred Customer Status"
      expr: CASE WHEN is_preferred_customer = true THEN 'Preferred' ELSE 'Standard' END
      comment: "Preferred customer designation"
    - name: "Credit Review Year"
      expr: YEAR(credit_review_date)
      comment: "Year of most recent credit review"
    - name: "Credit Limit Band"
      expr: CASE WHEN CAST(credit_limit_usd AS DOUBLE) < 100000 THEN 'Under 100K' WHEN CAST(credit_limit_usd AS DOUBLE) < 500000 THEN '100K-500K' WHEN CAST(credit_limit_usd AS DOUBLE) < 1000000 THEN '500K-1M' ELSE 'Over 1M' END
      comment: "Credit limit tier for segmentation"
  measures:
    - name: "Total Credit Profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Distinct count of credit profiles"
    - name: "Total Credit Limit USD"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Sum of all credit limits in USD"
    - name: "Total Outstanding Balance USD"
      expr: SUM(CAST(outstanding_balance_usd AS DOUBLE))
      comment: "Sum of all outstanding balances in USD"
    - name: "Total Available Credit USD"
      expr: SUM(CAST(available_credit_usd AS DOUBLE))
      comment: "Sum of available credit across all accounts"
    - name: "Average Credit Limit USD"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Mean credit limit per account"
    - name: "Average Credit Utilization Pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Mean credit utilization percentage across accounts"
    - name: "Accounts On Credit Hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = true THEN credit_profile_id END)
      comment: "Count of accounts currently on credit hold"
    - name: "High Utilization Accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(credit_utilization_pct AS DOUBLE) > 80 THEN credit_profile_id END)
      comment: "Count of accounts with credit utilization above 80%"
    - name: "Total Overdue Amount USD"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Sum of all overdue balances in USD"
    - name: "Preferred Customers"
      expr: COUNT(DISTINCT CASE WHEN is_preferred_customer = true THEN credit_profile_id END)
      comment: "Count of accounts with preferred customer status"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration pipeline metrics tracking customer design activity, NRE commitments, and qualification progress. Used by Sales and Product teams to manage design funnel conversion and protect revenue from channel conflict."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the design registration (Pending, Approved, Expired, etc.) for funnel management."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the registered design for product readiness tracking."
    - name: "package_type"
      expr: package_type
      comment: "Package type for packaging mix analysis."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology mix analysis."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation for roadmap alignment."
    - name: "target_application"
      expr: target_application
      comment: "Target application for market vertical analysis."
    - name: "design_complexity"
      expr: design_complexity
      comment: "Design complexity classification for engineering resource planning."
    - name: "special_pricing_flag"
      expr: special_pricing_flag
      comment: "Whether special pricing is required, for pricing exception management."
    - name: "registration_year_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of registration for trend analysis."
    - name: "approval_year_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of approval for conversion cycle analysis."
    - name: "production_target_year_month"
      expr: DATE_TRUNC('month', production_target_date)
      comment: "Expected production target month for revenue timing."
  measures:
    - name: "total_registrations"
      expr: COUNT(DISTINCT customer_design_registration_id)
      comment: "Total design registrations. Baseline measure of design funnel activity volume."
    - name: "approved_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Approved' THEN customer_design_registration_id END)
      comment: "Number of approved design registrations. Tracks successfully protected design opportunities."
    - name: "total_estimated_annual_volume"
      expr: SUM(CAST(estimated_annual_volume AS BIGINT))
      comment: "Total estimated annual unit volume across all registrations. Drives capacity and wafer start planning."
    - name: "total_nre_budget_amount"
      expr: SUM(CAST(nre_budget_amount AS DOUBLE))
      comment: "Total NRE budget committed across design registrations. Tracks engineering investment pipeline."
    - name: "avg_nre_budget_amount"
      expr: AVG(CAST(nre_budget_amount AS DOUBLE))
      comment: "Average NRE budget per registration. Benchmarks NRE deal size for pricing and resource planning."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield across registered designs. Low yield expectations signal process or design risk."
    - name: "registrations_with_special_pricing"
      expr: COUNT(DISTINCT CASE WHEN special_pricing_flag = TRUE THEN customer_design_registration_id END)
      comment: "Number of registrations requiring special pricing. Tracks pricing exception volume for margin management."
    - name: "expired_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Expired' OR expiry_date < CURRENT_DATE THEN customer_design_registration_id END)
      comment: "Number of expired design registrations. Expired registrations represent lost revenue protection opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue opportunity metrics for strategic account planning and forecasting"
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_win`"
  dimensions:
    - name: "Design Win Status"
      expr: design_win_status
      comment: "Current stage of the design win (won, active, lost, etc.)"
    - name: "Design Phase"
      expr: design_phase
      comment: "Current design phase (concept, development, qualification, production)"
    - name: "Application Segment"
      expr: application_segment
      comment: "Target application market segment"
    - name: "End Application"
      expr: end_application
      comment: "Final end-use application"
    - name: "Competitive Displacement"
      expr: CASE WHEN competitive_displacement_flag = true THEN 'Displacement' ELSE 'New Design' END
      comment: "Whether win displaced a competitor"
    - name: "NRE Required"
      expr: CASE WHEN nre_required_flag = true THEN 'NRE Required' ELSE 'No NRE' END
      comment: "Whether non-recurring engineering is required"
    - name: "Win Year"
      expr: YEAR(win_date)
      comment: "Year the design win was secured"
    - name: "Win Quarter"
      expr: CONCAT('Q', QUARTER(win_date), '-', YEAR(win_date))
      comment: "Quarter and year of design win"
    - name: "Production Ramp Year"
      expr: YEAR(production_ramp_date)
      comment: "Year production is expected to ramp"
    - name: "Probability Band"
      expr: CASE WHEN CAST(win_probability_percent AS DOUBLE) < 25 THEN 'Low (0-25%)' WHEN CAST(win_probability_percent AS DOUBLE) < 50 THEN 'Medium (25-50%)' WHEN CAST(win_probability_percent AS DOUBLE) < 75 THEN 'High (50-75%)' ELSE 'Very High (75-100%)' END
      comment: "Win probability tier"
  measures:
    - name: "Total Design Wins"
      expr: COUNT(DISTINCT customer_design_win_id)
      comment: "Distinct count of design win records"
    - name: "Active Design Wins"
      expr: COUNT(DISTINCT CASE WHEN design_win_status = 'Active' THEN customer_design_win_id END)
      comment: "Count of design wins in active status"
    - name: "Total Estimated Annual Revenue USD"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Sum of estimated annual revenue from all design wins"
    - name: "Total Estimated Annual Volume"
      expr: SUM(CAST(estimated_annual_volume AS BIGINT))
      comment: "Sum of estimated annual unit volume across design wins"
    - name: "Average Estimated Annual Revenue USD"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Mean estimated annual revenue per design win"
    - name: "Total NRE Amount USD"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Sum of non-recurring engineering costs across design wins"
    - name: "Competitive Displacements"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = true THEN customer_design_win_id END)
      comment: "Count of design wins that displaced competitors"
    - name: "Weighted Revenue Opportunity USD"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE) * CAST(win_probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted sum of estimated annual revenue"
    - name: "High Probability Wins"
      expr: COUNT(DISTINCT CASE WHEN CAST(win_probability_percent AS DOUBLE) >= 75 THEN customer_design_win_id END)
      comment: "Count of design wins with 75%+ win probability"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_ltb_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-Time-Buy (LTB) notification metrics tracking product discontinuance communications, customer acknowledgment rates, and committed LTB revenue. Used by Product Management and Sales to manage EOL transitions and capture final revenue."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_ltb_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the LTB notification (Issued, Acknowledged, Expired) for EOL management."
    - name: "customer_ltb_notification_status"
      expr: customer_ltb_notification_status
      comment: "Customer-specific LTB notification status for individual account EOL tracking."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of LTB notification for EOL communication classification."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Customer acknowledgment status for compliance and revenue commitment tracking."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to deliver the notification for communication effectiveness analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the LTB notification for triage and escalation management."
    - name: "transition_plan_status"
      expr: transition_plan_status
      comment: "Status of the customer transition plan for migration support tracking."
    - name: "acknowledged_flag"
      expr: acknowledged_flag
      comment: "Whether the customer has acknowledged the LTB notification for compliance tracking."
    - name: "acknowledgment_required_flag"
      expr: acknowledgment_required_flag
      comment: "Whether acknowledgment is required for regulatory or contractual compliance."
    - name: "notification_year_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month of notification issuance for EOL activity trend analysis."
    - name: "final_order_year_month"
      expr: DATE_TRUNC('month', final_order_date)
      comment: "Month of final order deadline for LTB revenue capture planning."
    - name: "final_shipment_year_month"
      expr: DATE_TRUNC('month', final_shipment_date)
      comment: "Month of final shipment for supply chain EOL planning."
  measures:
    - name: "total_ltb_notifications"
      expr: COUNT(DISTINCT customer_ltb_notification_id)
      comment: "Total LTB notifications issued. Baseline measure of EOL communication activity."
    - name: "acknowledged_notifications"
      expr: COUNT(DISTINCT CASE WHEN acknowledged_flag = TRUE THEN customer_ltb_notification_id END)
      comment: "Number of acknowledged LTB notifications. Unacknowledged notifications represent compliance and revenue risk."
    - name: "unacknowledged_notifications"
      expr: COUNT(DISTINCT CASE WHEN acknowledged_flag = FALSE OR acknowledged_flag IS NULL THEN customer_ltb_notification_id END)
      comment: "Number of unacknowledged LTB notifications. Requires follow-up to ensure customers can place final orders."
    - name: "total_estimated_ltb_revenue_usd"
      expr: SUM(CAST(estimated_ltb_revenue_usd AS DOUBLE))
      comment: "Total estimated LTB revenue in USD. Measures the revenue opportunity from EOL last-time-buy orders."
    - name: "avg_estimated_ltb_revenue_usd"
      expr: AVG(CAST(estimated_ltb_revenue_usd AS DOUBLE))
      comment: "Average estimated LTB revenue per notification. Benchmarks EOL revenue opportunity per product-customer pair."
    - name: "notifications_past_acknowledgment_deadline"
      expr: COUNT(DISTINCT CASE WHEN acknowledgment_deadline < CURRENT_DATE AND (acknowledged_flag = FALSE OR acknowledged_flag IS NULL) THEN customer_ltb_notification_id END)
      comment: "Notifications past acknowledgment deadline without customer acknowledgment. Represents compliance and revenue risk requiring escalation."
    - name: "notifications_past_final_order_date"
      expr: COUNT(DISTINCT CASE WHEN final_order_date < CURRENT_DATE THEN customer_ltb_notification_id END)
      comment: "Notifications where the final order date has passed. Tracks EOL completion and any missed revenue opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer sample request metrics tracking evaluation activity, fulfillment performance, and sample costs. Used by Sales and Product teams to measure design-in activity and evaluate sample program effectiveness."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_sample_request`"
  dimensions:
    - name: "customer_sample_request_status"
      expr: customer_sample_request_status
      comment: "Current status of the sample request (Pending, Fulfilled, Cancelled) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sample request for governance tracking."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status for operational performance tracking."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (Engineering, Production, Qualification) for program mix analysis."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample request (Evaluation, Qualification, Demo) for design-in activity analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the sample request for fulfillment triage."
    - name: "evaluation_outcome"
      expr: evaluation_outcome
      comment: "Outcome of the sample evaluation (Positive, Negative, Pending) for conversion analysis."
    - name: "target_application"
      expr: target_application
      comment: "Target application for the sample for market vertical analysis."
    - name: "request_year_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of sample request for trend analysis."
    - name: "ship_year_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month of sample shipment for fulfillment cycle analysis."
    - name: "delivery_requested_year_month"
      expr: DATE_TRUNC('month', delivery_requested_date)
      comment: "Requested delivery month for on-time fulfillment analysis."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(DISTINCT customer_sample_request_id)
      comment: "Total sample requests. Baseline measure of design-in activity and customer evaluation pipeline."
    - name: "fulfilled_sample_requests"
      expr: COUNT(DISTINCT CASE WHEN fulfillment_status = 'Fulfilled' THEN customer_sample_request_id END)
      comment: "Number of fulfilled sample requests. Tracks sample program execution effectiveness."
    - name: "total_sample_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of samples provided. Tracks sample program investment for ROI analysis."
    - name: "avg_sample_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per sample request. Benchmarks sample program cost efficiency."
    - name: "total_net_sample_cost"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost of samples after adjustments. Tracks actual sample program spend."
    - name: "positive_evaluation_outcomes"
      expr: COUNT(DISTINCT CASE WHEN evaluation_outcome = 'Positive' THEN customer_sample_request_id END)
      comment: "Number of sample requests with positive evaluation outcomes. Positive evaluations are leading indicators of design wins."
    - name: "overdue_sample_requests"
      expr: COUNT(DISTINCT CASE WHEN delivery_requested_date < CURRENT_DATE AND fulfillment_status != 'Fulfilled' THEN customer_sample_request_id END)
      comment: "Sample requests past requested delivery date and not yet fulfilled. Overdue samples risk customer satisfaction and design-in timelines."
    - name: "unique_accounts_requesting_samples"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts requesting samples. Measures breadth of active design-in engagement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_distributor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor partnership and channel agreement metrics for channel strategy and partner performance management"
  source: "`vibe_semiconductors_v1`.`customer`.`distributor_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
      comment: "Current status of the distributor agreement"
    - name: "Agreement Type"
      expr: agreement_type
      comment: "Type of distributor agreement"
    - name: "Distributor Tier"
      expr: distributor_tier
      comment: "Tier classification of the distributor"
    - name: "Territory"
      expr: territory
      comment: "Geographic territory covered by the agreement"
    - name: "Exclusivity"
      expr: CASE WHEN exclusivity_flag = true THEN 'Exclusive' ELSE 'Non-Exclusive' END
      comment: "Whether distributor has exclusive rights"
    - name: "Auto Renew"
      expr: CASE WHEN auto_renew_flag = true THEN 'Auto-Renew' ELSE 'Manual Renew' END
      comment: "Whether agreement auto-renews"
    - name: "Price Protection"
      expr: CASE WHEN price_protection_flag = true THEN 'Price Protected' ELSE 'No Protection' END
      comment: "Whether price protection is included"
    - name: "Stock Rotation Allowed"
      expr: CASE WHEN stock_rotation_allowed_flag = true THEN 'Rotation Allowed' ELSE 'No Rotation' END
      comment: "Whether stock rotation rights are granted"
    - name: "Effective Year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective"
    - name: "Expiry Year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires"
  measures:
    - name: "Total Distributor Agreements"
      expr: COUNT(DISTINCT distributor_agreement_id)
      comment: "Distinct count of distributor agreements"
    - name: "Active Distributor Agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN distributor_agreement_id END)
      comment: "Count of currently active distributor agreements"
    - name: "Average Commission Rate Pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Mean commission rate percentage across agreements"
    - name: "Total Credit Limit USD"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Sum of credit limits extended to distributors"
    - name: "Total MDF Entitlement USD"
      expr: SUM(CAST(mdf_entitlement_amount AS DOUBLE))
      comment: "Sum of market development fund entitlements"
    - name: "Average Discount Rate Pct"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Mean discount rate percentage across agreements"
    - name: "Exclusive Agreements"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = true THEN distributor_agreement_id END)
      comment: "Count of exclusive distributor agreements"
    - name: "Agreements With Price Protection"
      expr: COUNT(DISTINCT CASE WHEN price_protection_flag = true THEN distributor_agreement_id END)
      comment: "Count of agreements with price protection terms"
    - name: "Auto Renew Agreements"
      expr: COUNT(DISTINCT CASE WHEN auto_renew_flag = true THEN distributor_agreement_id END)
      comment: "Count of agreements with auto-renewal"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and interaction metrics for relationship management and sales effectiveness tracking"
  source: "`vibe_semiconductors_v1`.`customer`.`engagement_activity`"
  dimensions:
    - name: "Activity Type"
      expr: activity_type
      comment: "Type of engagement activity (meeting, call, email, demo, etc.)"
    - name: "Activity Category"
      expr: activity_category
      comment: "Category classification of the activity"
    - name: "Activity Status"
      expr: activity_status
      comment: "Current status of the activity"
    - name: "Activity Outcome"
      expr: activity_outcome
      comment: "Outcome or result of the activity"
    - name: "Activity Channel"
      expr: activity_channel
      comment: "Channel through which activity occurred"
    - name: "Priority"
      expr: priority
      comment: "Priority level of the activity"
    - name: "Is Billable"
      expr: CASE WHEN is_billable = true THEN 'Billable' ELSE 'Non-Billable' END
      comment: "Whether activity is billable to customer"
    - name: "Is Escalated"
      expr: CASE WHEN is_escalated = true THEN 'Escalated' ELSE 'Normal' END
      comment: "Whether activity was escalated"
    - name: "Activity Year"
      expr: YEAR(activity_date)
      comment: "Year the activity occurred"
    - name: "Activity Quarter"
      expr: CONCAT('Q', QUARTER(activity_date), '-', YEAR(activity_date))
      comment: "Quarter and year of activity"
    - name: "Activity Month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of activity"
  measures:
    - name: "Total Engagement Activities"
      expr: COUNT(DISTINCT engagement_activity_id)
      comment: "Distinct count of customer engagement activities"
    - name: "Completed Activities"
      expr: COUNT(DISTINCT CASE WHEN activity_status = 'Completed' THEN engagement_activity_id END)
      comment: "Count of completed engagement activities"
    - name: "Total Budget Amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of budget amounts across activities"
    - name: "Billable Activities"
      expr: COUNT(DISTINCT CASE WHEN is_billable = true THEN engagement_activity_id END)
      comment: "Count of billable engagement activities"
    - name: "Escalated Activities"
      expr: COUNT(DISTINCT CASE WHEN is_escalated = true THEN engagement_activity_id END)
      comment: "Count of escalated activities"
    - name: "Activities With Follow-Up"
      expr: COUNT(DISTINCT CASE WHEN follow_up_due_date IS NOT NULL THEN engagement_activity_id END)
      comment: "Count of activities requiring follow-up"
    - name: "Overdue Follow-Ups"
      expr: COUNT(DISTINCT CASE WHEN follow_up_due_date < CURRENT_DATE() THEN engagement_activity_id END)
      comment: "Count of activities with overdue follow-up"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_nda_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NDA agreement portfolio metrics tracking coverage, expiry risk, and compliance. Used by Legal, Sales, and Compliance teams to ensure all customer engagements involving sensitive IP are properly protected."
  source: "`vibe_semiconductors_v1`.`customer`.`nda_agreement`"
  dimensions:
    - name: "nda_agreement_status"
      expr: nda_agreement_status
      comment: "Current status of the NDA (Active, Expired, Terminated) for portfolio coverage analysis."
    - name: "nda_type"
      expr: nda_type
      comment: "Type of NDA (Mutual, One-way) for legal structure analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Agreement type classification for legal portfolio management."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the NDA for IP protection risk assessment."
    - name: "mutual_flag"
      expr: mutual_flag
      comment: "Whether the NDA is mutual for legal obligation symmetry analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the NDA auto-renews for contract management."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction for legal risk analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the NDA for cross-border legal compliance."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the NDA became effective for portfolio vintage analysis."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the NDA expires for renewal risk management."
  measures:
    - name: "total_nda_agreements"
      expr: COUNT(DISTINCT nda_agreement_id)
      comment: "Total NDA agreements. Baseline measure of legal coverage portfolio size."
    - name: "active_nda_agreements"
      expr: COUNT(DISTINCT CASE WHEN nda_agreement_status = 'Active' THEN nda_agreement_id END)
      comment: "Number of active NDAs. Tracks the scope of legally protected customer engagements."
    - name: "expired_ndas"
      expr: COUNT(DISTINCT CASE WHEN expiry_date < CURRENT_DATE AND nda_agreement_status = 'Active' THEN nda_agreement_id END)
      comment: "NDAs that have expired but are still marked active. Represents immediate IP protection risk requiring legal remediation."
    - name: "unique_accounts_with_nda"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts covered by at least one NDA. Measures breadth of legal IP protection coverage."
    - name: "mutual_nda_count"
      expr: COUNT(DISTINCT CASE WHEN mutual_flag = TRUE THEN nda_agreement_id END)
      comment: "Number of mutual NDAs. Mutual NDAs create reciprocal obligations requiring careful compliance management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement metrics for pricing strategy, margin management, and contract compliance"
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
      comment: "Current status of the pricing agreement"
    - name: "Agreement Type"
      expr: agreement_type
      comment: "Type of pricing agreement (volume, contract, spot, etc.)"
    - name: "Pricing Type"
      expr: pricing_type
      comment: "Pricing model (fixed, tiered, volume-based, etc.)"
    - name: "Pricing Channel"
      expr: pricing_channel
      comment: "Sales channel for the pricing agreement"
    - name: "Pricing Region"
      expr: pricing_region
      comment: "Geographic region for pricing"
    - name: "Currency Code"
      expr: currency_code
      comment: "Currency of the pricing agreement"
    - name: "Price Locked"
      expr: CASE WHEN is_price_locked = true THEN 'Locked' ELSE 'Flexible' END
      comment: "Whether price is locked or subject to change"
    - name: "Volume Tier"
      expr: volume_tier
      comment: "Volume tier for tiered pricing"
    - name: "Approval Year"
      expr: YEAR(approval_date)
      comment: "Year the agreement was approved"
    - name: "Effective Year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective"
    - name: "Expiry Year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires"
  measures:
    - name: "Total Price Agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Distinct count of pricing agreements"
    - name: "Active Price Agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN price_agreement_id END)
      comment: "Count of currently active pricing agreements"
    - name: "Average Unit Price USD"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Mean unit price across all agreements in USD"
    - name: "Average Discount Pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Mean discount percentage across agreements"
    - name: "Total Tier Price Value USD"
      expr: SUM(CAST(tier_price AS DOUBLE))
      comment: "Sum of tier prices across all agreements"
    - name: "Locked Price Agreements"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = true THEN price_agreement_id END)
      comment: "Count of agreements with locked pricing"
    - name: "Agreements Expiring Soon"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN price_agreement_id END)
      comment: "Count of agreements expiring in the next 90 days"
    - name: "Average Minimum Order Quantity"
      expr: AVG(CAST(minimum_order_quantity AS BIGINT))
      comment: "Mean minimum order quantity across agreements"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_qualification_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer product qualification metrics for quality assurance and customer readiness tracking"
  source: "`vibe_semiconductors_v1`.`customer`.`qualification_status`"
  dimensions:
    - name: "Overall Qualification Status"
      expr: overall_qualification_status
      comment: "Overall qualification state (qualified, in-progress, failed, etc.)"
    - name: "Qualification Type"
      expr: qualification_type
      comment: "Type of qualification (product, process, supplier, etc.)"
    - name: "Qualification Level"
      expr: qualification_level
      comment: "Level or tier of qualification"
    - name: "Qualification Standard"
      expr: qualification_standard
      comment: "Standard or specification being qualified against"
    - name: "AEC-Q Status"
      expr: aec_q_status
      comment: "Automotive Electronics Council qualification status"
    - name: "PPAP Status"
      expr: ppap_status
      comment: "Production Part Approval Process status"
    - name: "IATF 16949 Status"
      expr: iatf_16949_status
      comment: "Automotive quality management system certification status"
    - name: "Lifecycle Status"
      expr: lifecycle_status
      comment: "Product lifecycle stage"
    - name: "Requalification Required"
      expr: CASE WHEN requalification_required_flag = true THEN 'Requalification Required' ELSE 'Current' END
      comment: "Whether requalification is needed"
    - name: "Qualification Year"
      expr: YEAR(qualification_date)
      comment: "Year qualification was achieved"
    - name: "Completion Year"
      expr: YEAR(completion_date)
      comment: "Year qualification was completed"
  measures:
    - name: "Total Qualification Records"
      expr: COUNT(DISTINCT qualification_status_id)
      comment: "Distinct count of qualification status records"
    - name: "Qualified Products"
      expr: COUNT(DISTINCT CASE WHEN overall_qualification_status = 'Qualified' THEN qualification_status_id END)
      comment: "Count of fully qualified product-customer combinations"
    - name: "In Progress Qualifications"
      expr: COUNT(DISTINCT CASE WHEN overall_qualification_status = 'In Progress' THEN qualification_status_id END)
      comment: "Count of qualifications currently in progress"
    - name: "Average Qualification Score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Mean qualification score across all records"
    - name: "AEC-Q Qualified Count"
      expr: COUNT(DISTINCT CASE WHEN aec_q_status = 'Qualified' THEN qualification_status_id END)
      comment: "Count of AEC-Q qualified products"
    - name: "PPAP Approved Count"
      expr: COUNT(DISTINCT CASE WHEN ppap_status = 'Approved' THEN qualification_status_id END)
      comment: "Count of PPAP approved products"
    - name: "Requalification Required Count"
      expr: COUNT(DISTINCT CASE WHEN requalification_required_flag = true THEN qualification_status_id END)
      comment: "Count of products requiring requalification"
    - name: "Qualification Success Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN overall_qualification_status = 'Qualified' THEN qualification_status_id END) / NULLIF(COUNT(DISTINCT qualification_status_id), 0), 2)
      comment: "Percentage of qualifications that achieved qualified status"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market segment strategic metrics covering revenue targets, discount rates, and market share goals. Used by Marketing, Sales Strategy, and executive leadership to allocate resources across market verticals and evaluate segment performance."
  source: "`vibe_semiconductors_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (Active, Inactive) for portfolio management."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (Geographic, Vertical, Strategic) for segmentation strategy analysis."
    - name: "market_vertical"
      expr: market_vertical
      comment: "Market vertical (Automotive, AI/ML, Consumer, Industrial) for vertical market performance analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the segment for regional strategy analysis."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier for resource allocation decisions."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the segment for margin management."
    - name: "sales_motion"
      expr: sales_motion
      comment: "Sales motion (Direct, Channel, Hybrid) for go-to-market strategy analysis."
    - name: "tam_band"
      expr: tam_band
      comment: "Total Addressable Market band for market sizing and opportunity analysis."
    - name: "target_customer_type"
      expr: target_customer_type
      comment: "Target customer type for segment definition and targeting analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active for portfolio health tracking."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the segment became effective for portfolio vintage analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of market segments. Baseline measure of market segmentation breadth."
    - name: "active_segments"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN segment_id END)
      comment: "Number of active market segments. Tracks the productive segment portfolio."
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_usd AS DOUBLE))
      comment: "Total revenue target across all segments in USD. Aggregates the company's market revenue ambition for executive planning."
    - name: "avg_market_share_target_pct"
      expr: AVG(CAST(market_share_target_percent AS DOUBLE))
      comment: "Average market share target across segments. Benchmarks competitive ambition and informs go-to-market investment."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across segments. Tracks pricing generosity by segment for margin management."
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total target revenue across all segments. Cross-validates revenue_target_usd for planning consistency."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_tool_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer tool capacity allocation metrics for fab capacity planning and customer commitment management"
  source: "`vibe_semiconductors_v1`.`customer`.`tool_allocation`"
  dimensions:
    - name: "Allocation Status"
      expr: allocation_status
      comment: "Current status of the tool allocation"
    - name: "Allocation Type"
      expr: allocation_type
      comment: "Type of allocation (reserved, committed, flexible, etc.)"
    - name: "Priority Tier"
      expr: priority_tier
      comment: "Priority tier for capacity allocation"
    - name: "Priority Level"
      expr: priority_level
      comment: "Priority level classification"
    - name: "Overflow Allowed"
      expr: CASE WHEN overflow_allowed_flag = true THEN 'Overflow Allowed' ELSE 'No Overflow' END
      comment: "Whether overflow capacity is permitted"
    - name: "Allocation Period"
      expr: allocation_period
      comment: "Time period for the allocation"
    - name: "Allocation Year"
      expr: YEAR(allocation_start_date)
      comment: "Year the allocation started"
    - name: "Allocation Quarter"
      expr: CONCAT('Q', QUARTER(allocation_start_date), '-', YEAR(allocation_start_date))
      comment: "Quarter and year of allocation start"
  measures:
    - name: "Total Tool Allocations"
      expr: COUNT(DISTINCT tool_allocation_id)
      comment: "Distinct count of tool allocation records"
    - name: "Active Tool Allocations"
      expr: COUNT(DISTINCT CASE WHEN allocation_status = 'Active' THEN tool_allocation_id END)
      comment: "Count of currently active tool allocations"
    - name: "Total Allocated Capacity Pct"
      expr: SUM(CAST(allocated_capacity_pct AS DOUBLE))
      comment: "Sum of allocated capacity percentages"
    - name: "Average Allocated Capacity Pct"
      expr: AVG(CAST(allocated_capacity_pct AS DOUBLE))
      comment: "Mean allocated capacity percentage per allocation"
    - name: "Total Wafer Starts Per Week"
      expr: SUM(CAST(wafer_starts_per_week AS BIGINT))
      comment: "Sum of committed wafer starts per week across allocations"
    - name: "Average Utilization Target Pct"
      expr: AVG(CAST(utilization_target_pct AS DOUBLE))
      comment: "Mean utilization target percentage"
    - name: "Total Reservation Fee USD"
      expr: SUM(CAST(reservation_fee_usd AS DOUBLE))
      comment: "Sum of reservation fees collected"
    - name: "High Priority Allocations"
      expr: COUNT(DISTINCT CASE WHEN priority_tier IN ('Tier 1', 'High') THEN tool_allocation_id END)
      comment: "Count of high-priority tool allocations"
    - name: "Allocations With Overflow"
      expr: COUNT(DISTINCT CASE WHEN overflow_allowed_flag = true THEN tool_allocation_id END)
      comment: "Count of allocations permitting overflow capacity"
$$;
