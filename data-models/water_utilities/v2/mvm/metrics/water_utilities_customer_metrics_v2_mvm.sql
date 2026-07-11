-- Metric views for domain: customer | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for customer complaints in the water utility — tracks complaint volume, resolution performance, regulatory escalation exposure, billing adjustment liability, and customer satisfaction outcomes. Used by Customer Experience, Regulatory Affairs, and Operations leadership to steer service quality and compliance posture."
  source: "`vibe_water_utilities_v1`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_subcategory"
      expr: subcategory
      comment: "Granular complaint subcategory enabling drill-down analysis beneath the top-level category."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current lifecycle status of the complaint (e.g. Open, In Progress, Resolved, Closed) for pipeline and backlog analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Complaint priority tier (e.g. Critical, High, Medium, Low) used to assess urgency distribution and SLA risk."
    - name: "assigned_to_department"
      expr: assigned_to_department
      comment: "Department responsible for resolving the complaint — enables workload and resolution-rate analysis by organizational unit."
    - name: "contact_method"
      expr: contact_method
      comment: "Channel through which the complaint was received (e.g. Phone, Web, Email, Walk-in) for channel-mix and cost-to-serve analysis."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicates whether the complaint was escalated to a regulatory agency — critical for compliance risk segmentation."
    - name: "water_quality_test_required_flag"
      expr: water_quality_test_required_flag
      comment: "Flags complaints that triggered a mandatory water quality test, linking customer complaints to quality assurance workflows."
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Post-resolution satisfaction rating provided by the customer — used to segment complaints by outcome quality."
    - name: "reported_date_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the complaint was reported — enables trend analysis of complaint intake volume over time."
    - name: "actual_resolution_date_month"
      expr: DATE_TRUNC('MONTH', actual_resolution_date)
      comment: "Month the complaint was actually resolved — used to track resolution throughput and backlog clearance trends."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification assigned during investigation — drives systemic improvement initiatives and infrastructure investment decisions."
    - name: "compensation_provided_flag"
      expr: compensation_provided_flag
      comment: "Indicates whether financial or service compensation was provided to the customer — used to track liability exposure and policy adherence."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints received. Baseline volume KPI used by Customer Experience leadership to track service quality trends and staffing needs."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Count of complaints currently open or in-progress. Measures active backlog and operational capacity pressure — a leading indicator of customer satisfaction risk."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Number of complaints escalated to a regulatory agency. Directly measures compliance and reputational risk exposure — tracked by Regulatory Affairs and the C-suite."
    - name: "regulatory_escalation_rate_numerator"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Numerator for regulatory escalation rate (complaints escalated to regulator). Divide by total_complaints in the BI layer to compute the escalation rate percentage."
    - name: "water_quality_test_triggered_count"
      expr: COUNT(CASE WHEN water_quality_test_required_flag = TRUE THEN 1 END)
      comment: "Number of complaints that triggered a mandatory water quality test. Links customer complaint volume to quality assurance workload and public health risk."
    - name: "compensation_provided_count"
      expr: COUNT(CASE WHEN compensation_provided_flag = TRUE THEN 1 END)
      comment: "Number of complaints where compensation was provided to the customer. Tracks liability event frequency and policy adherence."
    - name: "total_billing_adjustment_amount"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total dollar value of billing adjustments issued as a result of complaints. Directly measures financial liability from complaint resolution — a key CFO and Revenue Assurance metric."
    - name: "avg_billing_adjustment_amount"
      expr: AVG(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Average billing adjustment amount per complaint. Benchmarks the cost-per-complaint for billing-related resolutions and informs adjustment policy thresholds."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of complaints requiring follow-up action. Measures unresolved complexity in the complaint pipeline and drives resource planning for follow-up workflows."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for customer interactions (calls, chats, emails, walk-ins) in the water utility. Tracks contact center efficiency, first-contact resolution, escalation rates, and customer satisfaction. Used by Customer Operations, Contact Center Management, and CX leadership."
  source: "`vibe_water_utilities_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g. Inbound Call, Outbound Call, Chat, Email, Walk-in) — used to segment volume and performance by contact type."
    - name: "interaction_channel"
      expr: channel
      comment: "Channel through which the interaction occurred (e.g. Phone, Web, IVR, In-Person) — drives channel-mix and digital adoption analysis."
    - name: "interaction_subcategory"
      expr: subcategory
      comment: "Granular subcategory of the interaction reason — enables drill-down into specific demand types for staffing and self-service deflection planning."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (e.g. Open, Closed, Escalated) — used to track open interaction backlog."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the interaction was escalated to a supervisor or specialist — key quality and efficiency indicator."
    - name: "first_contact_resolution_flag"
      expr: first_contact_resolution_flag
      comment: "Indicates whether the customer's issue was resolved on the first contact — the primary contact center efficiency KPI."
    - name: "callback_requested_flag"
      expr: callback_requested_flag
      comment: "Indicates whether the customer requested a callback — used to measure demand for callback capacity and queue management."
    - name: "language_code"
      expr: language_code
      comment: "Language used during the interaction — used to assess multilingual service demand and staffing requirements."
    - name: "interaction_timestamp_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month the interaction occurred — enables monthly trend analysis of contact volume and performance."
    - name: "agent_name"
      expr: agent_name
      comment: "Name of the agent who handled the interaction — used for agent-level performance analysis and coaching prioritization."
    - name: "survey_completed_flag"
      expr: survey_completed_flag
      comment: "Indicates whether the customer completed a post-interaction satisfaction survey — used to assess survey response rates and satisfaction data coverage."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions. Baseline contact volume KPI used to track demand, staffing adequacy, and channel utilization."
    - name: "escalated_interactions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of interactions that were escalated. Measures service complexity and front-line resolution capability — a key contact center quality KPI."
    - name: "first_contact_resolved_interactions"
      expr: COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END)
      comment: "Number of interactions resolved on the first contact. Numerator for First Contact Resolution (FCR) rate — the primary efficiency KPI for contact center operations."
    - name: "callback_requested_count"
      expr: COUNT(CASE WHEN callback_requested_flag = TRUE THEN 1 END)
      comment: "Number of interactions where a callback was requested. Measures demand for callback capacity and is used to optimize queue management and staffing."
    - name: "survey_completed_count"
      expr: COUNT(CASE WHEN survey_completed_flag = TRUE THEN 1 END)
      comment: "Number of interactions where the customer completed a satisfaction survey. Used to assess survey response rate coverage and the reliability of satisfaction data."
    - name: "distinct_customers_contacted"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts that had at least one interaction in the period. Measures breadth of customer engagement and is used to identify high-contact customers for proactive outreach."
    - name: "open_interactions"
      expr: COUNT(CASE WHEN interaction_status NOT IN ('Closed') THEN 1 END)
      comment: "Number of interactions currently open or in-progress. Measures active workload backlog in the contact center — a leading indicator of resolution capacity pressure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for new service applications in the water utility — tracks application intake volume, approval and rejection rates, processing cycle times, deposit and connection fee revenue, and credit risk. Used by Customer Onboarding, Revenue, and Operations leadership to manage growth and onboarding efficiency."
  source: "`vibe_water_utilities_v1`.`customer`.`service_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current lifecycle status of the application (e.g. Submitted, Under Review, Approved, Rejected, Withdrawn) — used to track pipeline health and conversion rates."
    - name: "application_type"
      expr: application_type
      comment: "Type of service application (e.g. New Service, Transfer, Upgrade) — used to segment application volume by growth driver."
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of utility service requested (e.g. Water, Wastewater, Reclaimed) — used to track demand by service line."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g. Online, In-Person, Phone) — used for digital adoption and channel cost analysis."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of the credit check performed during application review — used to assess credit risk distribution across the applicant pool."
    - name: "credit_check_result"
      expr: credit_check_result
      comment: "Outcome of the credit check (e.g. Pass, Fail, Refer) — used to segment applications by credit risk and deposit requirement triggers."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit was required for the application — used to track deposit policy application rates and revenue from deposits."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification for the applicant — used to track compliance with identity verification requirements and fraud risk."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier assigned to the application — used to assess SLA compliance by priority segment."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Standardized code for the reason an application was rejected — used to identify systemic rejection drivers and improve application quality."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the application was submitted — enables monthly trend analysis of new service demand and growth."
    - name: "meter_size_requested"
      expr: meter_size_requested
      comment: "Meter size requested by the applicant — used to segment applications by infrastructure demand and connection fee tier."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of service applications received. Baseline growth and demand KPI — used by leadership to track new customer acquisition pipeline volume."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of applications approved. Numerator for approval rate — measures onboarding conversion and growth throughput."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN 1 END)
      comment: "Number of applications rejected. Used to track rejection volume and, combined with total_applications, compute rejection rate for quality and policy analysis."
    - name: "withdrawn_applications"
      expr: COUNT(CASE WHEN application_status = 'Withdrawn' THEN 1 END)
      comment: "Number of applications withdrawn by the applicant. Measures demand leakage — high withdrawal rates may indicate friction in the application process or competitive loss."
    - name: "deposit_required_count"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of applications where a deposit was required. Measures credit risk exposure in the applicant pool and deposit policy application frequency."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected or required across all applications. Measures deposit liability and cash flow from new customer onboarding — a key Revenue and Treasury metric."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per application. Benchmarks deposit policy outcomes and is used to assess whether deposit thresholds are appropriately calibrated to credit risk."
    - name: "total_connection_fee_amount"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fee revenue from service applications. Directly measures infrastructure recovery revenue from new connections — a key capital recovery KPI for Finance."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application. Used to benchmark fee levels against cost-of-service and inform tariff review decisions."
    - name: "sla_breached_applications"
      expr: COUNT(CASE WHEN submission_date IS NOT NULL AND sla_due_date IS NOT NULL AND review_completed_date > sla_due_date THEN 1 END)
      comment: "Number of applications where the review was completed after the SLA due date. Measures SLA compliance failure rate — a key operational performance and customer commitment KPI."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service premises in the water utility — tracks active premise inventory, service availability, infrastructure characteristics, demand estimates, and special program enrollment. Used by Asset Management, Operations Planning, and Revenue leadership to understand the served customer base and infrastructure exposure."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (e.g. Active, Inactive, Pending) — used to segment the active service base from inactive or pending premises."
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (e.g. Residential, Commercial, Industrial, Multi-Family) — primary segmentation dimension for demand and revenue analysis."
    - name: "building_type"
      expr: building_type
      comment: "Physical building type (e.g. Single Family, Apartment, Office, Warehouse) — used for infrastructure planning and demand forecasting."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the premise — used to align service planning with land use and regulatory requirements."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line (e.g. Copper, Lead, PVC, Galvanized) — critical for lead service line replacement program tracking and public health compliance."
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Indicates whether water service is available at the premise — used to track service coverage and identify unserved premises."
    - name: "wastewater_service_available_flag"
      expr: wastewater_service_available_flag
      comment: "Indicates whether wastewater service is available at the premise — used to track sewer service coverage."
    - name: "reclaimed_water_service_available_flag"
      expr: reclaimed_water_service_available_flag
      comment: "Indicates whether reclaimed water service is available — used to track recycled water program penetration and conservation initiative reach."
    - name: "backflow_prevention_required_flag"
      expr: backflow_prevention_required_flag
      comment: "Indicates whether backflow prevention is required at the premise — used to track compliance program enrollment and public health risk exposure."
    - name: "industrial_user_permit_required_flag"
      expr: industrial_user_permit_required_flag
      comment: "Indicates whether an industrial user permit is required — used to track industrial pretreatment program compliance obligations."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates whether the premise is eligible for low-income assistance programs — used to track affordability program reach and equity metrics."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the premise became effective — used to track new premise additions over time as a growth indicator."
  measures:
    - name: "total_premises"
      expr: COUNT(1)
      comment: "Total number of premises in the service territory. Baseline inventory KPI representing the total addressable service base — used by Operations and Revenue leadership for capacity and revenue planning."
    - name: "active_premises"
      expr: COUNT(CASE WHEN premise_status = 'Active' THEN 1 END)
      comment: "Number of currently active premises. Measures the live served customer base — the primary denominator for per-premise revenue and demand KPIs."
    - name: "premises_with_water_service"
      expr: COUNT(CASE WHEN water_service_available_flag = TRUE THEN 1 END)
      comment: "Number of premises with water service available. Measures water service coverage across the premise inventory — used for service territory planning and growth analysis."
    - name: "premises_requiring_backflow_prevention"
      expr: COUNT(CASE WHEN backflow_prevention_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring backflow prevention devices. Measures the scale of the backflow compliance program and public health risk exposure in the distribution system."
    - name: "premises_with_industrial_permit_required"
      expr: COUNT(CASE WHEN industrial_user_permit_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring an industrial user permit. Measures the scope of the industrial pretreatment compliance program — a key regulatory obligation metric."
    - name: "premises_low_income_eligible"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN 1 END)
      comment: "Number of premises eligible for low-income assistance programs. Measures affordability program reach and is used by Customer Equity and Regulatory Affairs to demonstrate social equity commitments."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across all premises in gallons. A critical supply planning and infrastructure capacity KPI used by Operations and Engineering leadership."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily water demand per premise in gallons. Used to benchmark demand by premise type and identify high-demand segments for infrastructure investment prioritization."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in gallons per minute across all premises. Measures maximum instantaneous system load — a critical input for distribution system capacity planning and pressure zone management."
    - name: "avg_meter_size_inches"
      expr: AVG(CAST(meter_size_inches AS DOUBLE))
      comment: "Average meter size in inches across premises. Used to understand the infrastructure profile of the customer base and inform meter replacement and upgrade programs."
    - name: "total_connection_fee_paid_amount"
      expr: SUM(CAST(connection_fee_paid_amount AS DOUBLE))
      comment: "Total connection fees paid across all premises. Measures cumulative infrastructure recovery revenue from new connections — a key capital finance and rate-setting metric."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for organizational (commercial and industrial) customer accounts in the water utility — tracks account portfolio health, credit risk, deposit exposure, industrial user program compliance, and digital adoption. Used by Commercial Sales, Credit Risk, and Regulatory Affairs leadership."
  source: "`vibe_water_utilities_v1`.`customer`.`organization`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the organizational account (e.g. Active, Inactive, Closed, Suspended) — primary segmentation for active portfolio analysis."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of organization (e.g. Corporation, LLC, Government, Non-Profit) — used to segment the commercial customer base by legal entity type."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business customer segment (e.g. Small Business, Mid-Market, Enterprise, Industrial) — primary commercial segmentation dimension for revenue and service strategy."
    - name: "credit_tier"
      expr: credit_tier
      comment: "Credit risk tier assigned to the organization — used to segment the portfolio by credit quality and manage deposit and payment term policies."
    - name: "industrial_user_flag"
      expr: industrial_user_flag
      comment: "Indicates whether the organization is classified as an industrial user subject to pretreatment regulations — critical for regulatory compliance tracking."
    - name: "industrial_user_classification"
      expr: industrial_user_classification
      comment: "Specific industrial user classification (e.g. Significant Industrial User, Categorical Industrial User) — used for tiered regulatory compliance management."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the organization is tax-exempt — used for revenue and billing analysis to distinguish taxable from non-taxable accounts."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates whether the organization is enrolled in paperless billing — used to track digital adoption and paper billing cost reduction progress."
    - name: "auto_pay_enrolled_flag"
      expr: auto_pay_enrolled_flag
      comment: "Indicates whether the organization is enrolled in auto-pay — used to track payment automation adoption and its impact on collections efficiency."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for this organization — used to segment accounts by credit risk and track deposit policy application."
    - name: "account_opened_date_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the account was opened — used to track new commercial account acquisition trends over time."
    - name: "naics_code"
      expr: naics_code
      comment: "North American Industry Classification System code — used to segment industrial and commercial customers by industry for demand and compliance analysis."
  measures:
    - name: "total_organizations"
      expr: COUNT(1)
      comment: "Total number of organizational customer accounts. Baseline commercial portfolio size KPI used by Commercial Sales and Revenue leadership."
    - name: "active_organizations"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of currently active organizational accounts. Measures the live commercial customer base — the primary denominator for commercial revenue per account KPIs."
    - name: "industrial_user_count"
      expr: COUNT(CASE WHEN industrial_user_flag = TRUE THEN 1 END)
      comment: "Number of organizations classified as industrial users. Measures the scope of the industrial pretreatment compliance program — a key regulatory obligation and risk metric."
    - name: "iup_permit_active_count"
      expr: COUNT(CASE WHEN iup_permit_number IS NOT NULL AND iup_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of organizations with an active Industrial User Permit (IUP). Measures current regulatory compliance status of the industrial customer base — a critical Regulatory Affairs KPI."
    - name: "iup_permit_expired_count"
      expr: COUNT(CASE WHEN iup_permit_number IS NOT NULL AND iup_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of organizations with an expired Industrial User Permit. Measures regulatory non-compliance exposure in the industrial customer portfolio — requires immediate action by Regulatory Affairs."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount held across all organizational accounts. Measures total deposit liability and cash held as credit risk collateral — a key Treasury and Credit Risk metric."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit extended to organizational accounts. Benchmarks credit exposure per account and is used by Credit Risk management to assess portfolio-level credit risk."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all organizational accounts. Measures aggregate credit exposure in the commercial portfolio — a key Credit Risk and CFO metric."
    - name: "paperless_billing_enrolled_count"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN 1 END)
      comment: "Number of organizations enrolled in paperless billing. Numerator for paperless billing adoption rate — used to track digital transformation progress and paper billing cost reduction."
    - name: "auto_pay_enrolled_count"
      expr: COUNT(CASE WHEN auto_pay_enrolled_flag = TRUE THEN 1 END)
      comment: "Number of organizations enrolled in auto-pay. Measures payment automation adoption — directly linked to collections efficiency and days sales outstanding (DSO) reduction."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_person`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for individual (residential) customer persons in the water utility — tracks customer base demographics, digital adoption, assistance program enrollment, life support and vulnerability flags, and consent compliance. Used by Customer Experience, Equity, Compliance, and Revenue leadership."
  source: "`vibe_water_utilities_v1`.`customer`.`person`"
  dimensions:
    - name: "person_status"
      expr: person_status
      comment: "Current status of the person record (e.g. Active, Inactive, Deceased) — used to segment the active residential customer base."
    - name: "person_type"
      expr: person_type
      comment: "Type of person (e.g. Primary Account Holder, Co-Applicant, Authorized User) — used to understand account holder composition."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment classification (e.g. Residential Standard, Senior, Low-Income, Life Support) — primary segmentation for equity and service strategy analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Customer's preferred language — used to assess multilingual service demand and ensure equitable access to utility services."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates whether the customer is enrolled in paperless billing — used to track digital adoption and paper billing cost reduction."
    - name: "autopay_enrollment_flag"
      expr: autopay_enrollment_flag
      comment: "Indicates whether the customer is enrolled in auto-pay — used to track payment automation adoption and collections efficiency."
    - name: "life_support_equipment_flag"
      expr: life_support_equipment_flag
      comment: "Indicates whether the customer uses life-support equipment — critical for service interruption planning and regulatory compliance with life-support customer protections."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates whether the customer is eligible for low-income assistance programs — used to track affordability program reach and equity metrics."
    - name: "senior_citizen_flag"
      expr: senior_citizen_flag
      comment: "Indicates whether the customer is a senior citizen — used to track senior program enrollment and ensure appropriate service protections."
    - name: "disability_accommodation_flag"
      expr: disability_accommodation_flag
      comment: "Indicates whether the customer requires a disability accommodation — used to ensure ADA compliance and track accommodation program scope."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification for the customer (e.g. Verified, Pending, Failed) — used to track compliance with identity verification requirements and fraud risk."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the person record was created — used to track new residential customer acquisition trends over time."
  measures:
    - name: "total_persons"
      expr: COUNT(1)
      comment: "Total number of person records. Baseline residential customer base size KPI used by Customer Experience and Revenue leadership for portfolio sizing."
    - name: "active_persons"
      expr: COUNT(CASE WHEN person_status = 'Active' THEN 1 END)
      comment: "Number of currently active person records. Measures the live residential customer base — the primary denominator for per-customer revenue and service KPIs."
    - name: "life_support_customer_count"
      expr: COUNT(CASE WHEN life_support_equipment_flag = TRUE THEN 1 END)
      comment: "Number of customers with life-support equipment. Measures the scope of life-support customer protections required — a critical public safety and regulatory compliance KPI."
    - name: "low_income_assistance_eligible_count"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN 1 END)
      comment: "Number of customers eligible for low-income assistance programs. Measures affordability program reach and is used by Customer Equity and Regulatory Affairs to demonstrate social equity commitments."
    - name: "senior_citizen_count"
      expr: COUNT(CASE WHEN senior_citizen_flag = TRUE THEN 1 END)
      comment: "Number of senior citizen customers. Measures the scope of senior protection programs and is used to ensure appropriate service safeguards are in place."
    - name: "paperless_billing_enrolled_count"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN 1 END)
      comment: "Number of customers enrolled in paperless billing. Numerator for paperless billing adoption rate — used to track digital transformation progress and paper billing cost reduction."
    - name: "autopay_enrolled_count"
      expr: COUNT(CASE WHEN autopay_enrollment_flag = TRUE THEN 1 END)
      comment: "Number of customers enrolled in auto-pay. Measures payment automation adoption — directly linked to collections efficiency and bad debt reduction."
    - name: "identity_verified_count"
      expr: COUNT(CASE WHEN identity_verification_status = 'Verified' THEN 1 END)
      comment: "Number of customers with a verified identity. Measures compliance with identity verification requirements and the proportion of the customer base with confirmed identity — a fraud risk and regulatory compliance KPI."
    - name: "marketing_consent_count"
      expr: COUNT(CASE WHEN marketing_consent_flag = TRUE THEN 1 END)
      comment: "Number of customers who have provided marketing consent. Measures the addressable audience for utility communications and conservation program outreach — a key Customer Engagement KPI."
    - name: "data_sharing_consent_count"
      expr: COUNT(CASE WHEN data_sharing_consent_flag = TRUE THEN 1 END)
      comment: "Number of customers who have provided data sharing consent. Measures compliance with data privacy consent requirements and the eligible population for data-driven programs — a Privacy and Compliance KPI."
$$;