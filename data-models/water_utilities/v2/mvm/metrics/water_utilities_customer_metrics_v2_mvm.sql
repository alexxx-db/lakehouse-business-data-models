-- Metric views for domain: customer | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and regulatory KPIs for customer complaints in the water utility. Tracks complaint volume, resolution performance, billing adjustments, regulatory escalations, and customer satisfaction to steer service quality and compliance posture."
  source: "`vibe_water_utilities_v1`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: category
      comment: "High-level complaint category (e.g. Water Quality, Billing, Pressure) used to segment complaint volumes and resolution performance by issue type."
    - name: "complaint_subcategory"
      expr: subcategory
      comment: "Granular sub-classification within a complaint category, enabling drill-down analysis of specific issue drivers."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current lifecycle status of the complaint (e.g. Open, In Progress, Resolved, Closed) for pipeline and backlog analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Complaint priority tier (e.g. Critical, High, Medium, Low) used to assess whether high-priority issues are resolved faster."
    - name: "assigned_to_department"
      expr: assigned_to_department
      comment: "Department responsible for resolving the complaint, enabling workload and resolution-rate analysis by department."
    - name: "contact_method"
      expr: contact_method
      comment: "Channel through which the complaint was received (e.g. Phone, Web, Email, Walk-in) for channel mix and cost-to-serve analysis."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicates whether the complaint was escalated to a regulatory agency, used to track regulatory risk exposure."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Name of the regulatory agency involved in escalated complaints, enabling agency-level compliance tracking."
    - name: "compensation_provided_flag"
      expr: compensation_provided_flag
      comment: "Indicates whether financial compensation was provided to the customer, used to monitor liability and service recovery costs."
    - name: "water_quality_test_required_flag"
      expr: water_quality_test_required_flag
      comment: "Flags complaints that triggered a water quality test requirement, linking complaint data to quality assurance workflows."
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Post-resolution satisfaction rating provided by the customer, used to evaluate service recovery effectiveness."
    - name: "reported_date_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month in which the complaint was reported, enabling trend analysis of complaint volumes over time."
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the complaint, used for systemic issue identification and preventive action planning."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints received. Baseline volume KPI used to track complaint load and trend over time."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of complaints currently open or in progress. Tracks backlog size and operational capacity pressure."
    - name: "resolved_complaints"
      expr: COUNT(CASE WHEN complaint_status IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of complaints that have been resolved or closed. Used as the numerator for resolution rate calculations."
    - name: "regulatory_escalated_complaints"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Number of complaints escalated to a regulatory agency. A critical compliance risk indicator — high values signal systemic service failures requiring executive intervention."
    - name: "complaints_with_compensation"
      expr: COUNT(CASE WHEN compensation_provided_flag = TRUE THEN 1 END)
      comment: "Number of complaints where financial compensation was provided to the customer. Tracks service recovery liability exposure."
    - name: "total_billing_adjustment_amount"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total dollar value of billing adjustments issued as part of complaint resolution. Directly measures financial impact of service failures on revenue."
    - name: "avg_billing_adjustment_amount"
      expr: AVG(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Average billing adjustment per complaint. Indicates the typical financial concession made per resolved complaint."
    - name: "complaints_requiring_water_quality_test"
      expr: COUNT(CASE WHEN water_quality_test_required_flag = TRUE THEN 1 END)
      comment: "Number of complaints that triggered a mandatory water quality test. Tracks the intersection of customer complaints and public health obligations."
    - name: "follow_up_required_complaints"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of complaints flagged for follow-up. Indicates unresolved or complex cases requiring additional resource allocation."
    - name: "distinct_affected_accounts"
      expr: COUNT(DISTINCT primary_customer_account_id)
      comment: "Number of unique customer accounts with at least one complaint. Measures breadth of customer dissatisfaction across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the customer account portfolio in the water utility. Covers account health, financial exposure, delinquency risk, digital adoption, and assistance program enrollment to support revenue management and customer equity decisions."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Residential, Commercial, Industrial) for segment-level performance analysis."
    - name: "account_class"
      expr: account_class
      comment: "Billing class of the account used for rate and revenue segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (e.g. Active, Inactive, Closed) for portfolio health monitoring."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assignment used to analyze revenue distribution and operational workload across billing periods."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method (e.g. ACH, Credit Card, Check) for payment channel mix and cost-to-collect analysis."
    - name: "autopay_enrolled_flag"
      expr: autopay_enrolled_flag
      comment: "Indicates whether the account is enrolled in autopay. Autopay enrollment correlates with lower delinquency and collection costs."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates paperless billing enrollment. Tracks digital adoption and associated cost savings."
    - name: "assistance_program_enrolled_flag"
      expr: assistance_program_enrolled_flag
      comment: "Indicates enrollment in a low-income or assistance program. Used for equity reporting and program capacity planning."
    - name: "shutoff_eligible_flag"
      expr: shutoff_eligible_flag
      comment: "Flags accounts eligible for service shutoff due to non-payment. Critical for collections risk management."
    - name: "lien_flag"
      expr: lien_flag
      comment: "Indicates a lien has been placed on the account. Tracks legal collection actions and associated financial risk."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating tier of the account used for risk segmentation and deposit policy decisions."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened, used for cohort analysis and new account acquisition trend tracking."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Total number of active customer accounts. Core portfolio size KPI used in executive dashboards and regulatory reporting."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total outstanding balance across all accounts. Measures aggregate accounts receivable exposure for cash flow management."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across all accounts. A primary delinquency and revenue-at-risk KPI for collections strategy."
    - name: "avg_past_due_amount"
      expr: AVG(CAST(past_due_amount AS DOUBLE))
      comment: "Average past-due balance per account. Indicates the typical delinquency burden and informs collection threshold policies."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held across all accounts. Tracks liability exposure from customer deposits and informs deposit policy adequacy."
    - name: "avg_monthly_consumption_gal"
      expr: AVG(CAST(average_monthly_consumption_gal AS DOUBLE))
      comment: "Average monthly water consumption in gallons across accounts. Used for demand forecasting, rate design, and conservation program targeting."
    - name: "total_monthly_consumption_gal"
      expr: SUM(CAST(average_monthly_consumption_gal AS DOUBLE))
      comment: "Aggregate average monthly consumption across all accounts. Provides a portfolio-level demand signal for infrastructure and supply planning."
    - name: "shutoff_eligible_accounts"
      expr: COUNT(CASE WHEN shutoff_eligible_flag = TRUE THEN 1 END)
      comment: "Number of accounts eligible for service shutoff. Tracks collections pipeline volume and informs shutoff moratorium policy decisions."
    - name: "autopay_enrolled_accounts"
      expr: COUNT(CASE WHEN autopay_enrolled_flag = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in autopay. Used as the numerator for autopay adoption rate, which correlates with lower delinquency."
    - name: "paperless_billing_accounts"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN 1 END)
      comment: "Number of accounts on paperless billing. Tracks digital channel adoption and drives print/mail cost reduction initiatives."
    - name: "assistance_program_enrolled_accounts"
      expr: COUNT(CASE WHEN assistance_program_enrolled_flag = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in assistance programs. Supports equity reporting, program funding justification, and capacity planning."
    - name: "lien_accounts"
      expr: COUNT(CASE WHEN lien_flag = TRUE THEN 1 END)
      comment: "Number of accounts with an active lien. Tracks legal collection action volume and associated administrative cost exposure."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average amount of the most recent payment per account. Indicates typical payment behavior and informs payment plan design."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service performance KPIs derived from interaction records. Tracks contact center efficiency, channel mix, escalation rates, first-contact resolution, and customer satisfaction to steer service delivery quality and staffing decisions."
  source: "`vibe_water_utilities_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (e.g. Inbound Call, Outbound Call, Chat, Email) for channel performance analysis."
    - name: "interaction_channel"
      expr: channel
      comment: "Communication channel used for the interaction (e.g. Phone, Web, IVR, In-Person) for channel mix and cost-to-serve analysis."
    - name: "interaction_category"
      expr: category
      comment: "High-level category of the interaction topic (e.g. Billing, Service, Outage) for demand driver analysis."
    - name: "interaction_subcategory"
      expr: subcategory
      comment: "Granular sub-classification of the interaction topic for drill-down root cause analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (e.g. Open, Closed, Pending) for workload and backlog monitoring."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the interaction was escalated to a supervisor or specialist. Used to track escalation rate as a service quality signal."
    - name: "first_contact_resolution_flag"
      expr: first_contact_resolution_flag
      comment: "Indicates whether the customer's issue was resolved on the first contact. FCR is a primary contact center efficiency KPI."
    - name: "callback_requested_flag"
      expr: callback_requested_flag
      comment: "Indicates whether the customer requested a callback, used to track callback demand and staffing adequacy."
    - name: "survey_completed_flag"
      expr: survey_completed_flag
      comment: "Indicates whether the customer completed a post-interaction survey, used to assess survey response rates and satisfaction data coverage."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction timestamp, used for trend analysis of contact volume and service performance over time."
    - name: "language_code"
      expr: language_code
      comment: "Language used during the interaction, used for multilingual service capacity planning and equity reporting."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Indicates whether an interpreter was required, used to track language access service demand and compliance."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions. Core contact volume KPI used for staffing, capacity planning, and trend analysis."
    - name: "escalated_interactions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of interactions that were escalated. High escalation volume signals agent training gaps or systemic service issues requiring management attention."
    - name: "first_contact_resolved_interactions"
      expr: COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END)
      comment: "Number of interactions resolved on first contact. Used as the numerator for FCR rate — a primary contact center efficiency and customer satisfaction KPI."
    - name: "callback_requested_interactions"
      expr: COUNT(CASE WHEN callback_requested_flag = TRUE THEN 1 END)
      comment: "Number of interactions where a callback was requested. Tracks unmet real-time service demand and callback queue pressure."
    - name: "survey_completed_interactions"
      expr: COUNT(CASE WHEN survey_completed_flag = TRUE THEN 1 END)
      comment: "Number of interactions where the customer completed a satisfaction survey. Used to assess survey coverage and the reliability of satisfaction scores."
    - name: "distinct_accounts_contacted"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts that had at least one interaction. Measures breadth of customer engagement and contact center reach."
    - name: "interpreter_required_interactions"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Number of interactions requiring an interpreter. Tracks language access service demand for equity compliance and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and service portfolio KPIs derived from service agreements. Tracks active service contracts, contracted demand, financial commitments, deposit exposure, and service type mix to support revenue management and infrastructure planning."
  source: "`vibe_water_utilities_v1`.`customer`.`service_agreement`"
  dimensions:
    - name: "service_agreement_type"
      expr: service_agreement_type
      comment: "Type of service agreement (e.g. Residential Water, Commercial Sewer, Irrigation) for portfolio segmentation and revenue analysis."
    - name: "service_agreement_status"
      expr: service_agreement_status
      comment: "Current status of the service agreement (e.g. Active, Terminated, Pending) for active portfolio and churn analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of utility service covered (e.g. Water, Sewer, Stormwater, Irrigation) for service mix and revenue attribution."
    - name: "service_class"
      expr: service_class
      comment: "Service class (e.g. Residential, Commercial, Industrial) used for rate class segmentation and regulatory reporting."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (e.g. Monthly, Bi-Monthly, Quarterly) for revenue timing and cash flow analysis."
    - name: "autopay_enrolled_flag"
      expr: autopay_enrolled_flag
      comment: "Indicates autopay enrollment at the agreement level, used to track payment automation adoption and delinquency risk."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates paperless billing enrollment at the agreement level for digital adoption tracking."
    - name: "fire_service_flag"
      expr: fire_service_flag
      comment: "Indicates whether the agreement includes fire protection service, used for fire service revenue and infrastructure planning."
    - name: "irrigation_flag"
      expr: irrigation_flag
      comment: "Indicates whether the agreement covers irrigation service, used for seasonal demand and conservation program targeting."
    - name: "special_contract_flag"
      expr: special_contract_flag
      comment: "Indicates a non-standard or negotiated contract, used to track special contract exposure and associated revenue risk."
    - name: "budget_billing_flag"
      expr: budget_billing_flag
      comment: "Indicates enrollment in budget billing (levelized payment plan), used for cash flow smoothing analysis and program adoption tracking."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the service agreement became effective, used for new service activation trend analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN service_agreement_status = 'Active' OR is_active = TRUE THEN 1 END)
      comment: "Total number of active service agreements. Core portfolio size KPI representing the utility's active service footprint."
    - name: "total_monthly_base_charge_revenue"
      expr: SUM(CAST(monthly_base_charge AS DOUBLE))
      comment: "Total monthly base charge revenue across all agreements. Represents the recurring fixed revenue floor and is a primary revenue stability KPI."
    - name: "avg_monthly_base_charge"
      expr: AVG(CAST(monthly_base_charge AS DOUBLE))
      comment: "Average monthly base charge per service agreement. Used for rate benchmarking and revenue per customer analysis."
    - name: "total_contracted_demand_mgd"
      expr: SUM(CAST(contracted_demand_mgd AS DOUBLE))
      comment: "Total contracted water demand in million gallons per day across all agreements. Critical for supply planning, treatment capacity sizing, and infrastructure investment decisions."
    - name: "avg_daily_usage_gpd"
      expr: AVG(CAST(average_daily_usage_gpd AS DOUBLE))
      comment: "Average daily water usage in gallons per day per agreement. Used for demand forecasting and conservation program targeting."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held across all service agreements. Tracks deposit liability exposure and informs deposit policy adequacy."
    - name: "total_connection_fee_revenue"
      expr: SUM(CAST(connection_fee AS DOUBLE))
      comment: "Total connection fees collected across service agreements. Tracks new connection revenue and infrastructure cost recovery."
    - name: "total_minimum_charge_revenue"
      expr: SUM(CAST(minimum_charge AS DOUBLE))
      comment: "Total minimum charge revenue across agreements. Represents the guaranteed revenue floor from minimum bill provisions."
    - name: "avg_monthly_usage_ccf"
      expr: AVG(CAST(average_monthly_usage_ccf AS DOUBLE))
      comment: "Average monthly usage in CCF (hundred cubic feet) per agreement. Standard utility consumption metric used for rate design and conservation benchmarking."
    - name: "budget_billing_agreements"
      expr: COUNT(CASE WHEN budget_billing_flag = TRUE OR is_budget_billing = TRUE THEN 1 END)
      comment: "Number of agreements enrolled in budget billing. Tracks levelized payment program adoption and its impact on cash flow predictability."
    - name: "special_contract_agreements"
      expr: COUNT(CASE WHEN special_contract_flag = TRUE THEN 1 END)
      comment: "Number of non-standard or negotiated service agreements. Tracks special contract exposure for revenue risk and contract management oversight."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New service connection pipeline KPIs derived from service applications. Tracks application volume, approval and rejection rates, processing cycle times, deposit and connection fee exposure, and SLA compliance to steer growth management and operational efficiency."
  source: "`vibe_water_utilities_v1`.`customer`.`service_application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of service application (e.g. New Service, Transfer, Upgrade) for pipeline segmentation and workload analysis."
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g. Submitted, Under Review, Approved, Rejected, Withdrawn) for pipeline health monitoring."
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of utility service requested (e.g. Water, Sewer, Irrigation) for demand mix and capacity planning."
    - name: "service_class_requested"
      expr: service_class_requested
      comment: "Service class requested (e.g. Residential, Commercial, Industrial) for growth segmentation and infrastructure planning."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g. Online, In-Person, Phone) for digital adoption and process efficiency analysis."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit was required for the application, used to track credit risk exposure in the new connection pipeline."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of the credit check performed during application processing, used for risk screening effectiveness analysis."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification during application processing, used for fraud risk and compliance monitoring."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Coded reason for application rejection, used to identify systemic barriers to service access and process improvement opportunities."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of application submission, used for new connection demand trend analysis and growth forecasting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the application, used to assess whether high-priority applications meet SLA targets."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of service applications submitted. Core new connection pipeline volume KPI used for growth tracking and capacity planning."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of approved service applications. Used as the numerator for approval rate and tracks new service connection throughput."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected service applications. Tracks rejection volume and, combined with total applications, informs approval rate and access equity analysis."
    - name: "withdrawn_applications"
      expr: COUNT(CASE WHEN application_status = 'Withdrawn' THEN 1 END)
      comment: "Number of withdrawn applications. High withdrawal rates may signal process friction, long wait times, or unmet service expectations."
    - name: "total_connection_fee_amount"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees assessed across all applications. Tracks new connection revenue and infrastructure cost recovery from growth."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application. Used for fee benchmarking and equity analysis of connection cost burdens."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across all applications. Tracks deposit liability exposure from the new connection pipeline."
    - name: "deposit_required_applications"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of applications requiring a deposit. Used as the numerator for deposit requirement rate, a credit risk and equity indicator."
    - name: "distinct_premises_applied"
      expr: COUNT(DISTINCT premise_id)
      comment: "Number of unique premises with a service application. Measures the geographic breadth of new connection demand."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure and service capacity KPIs derived from premise records. Tracks the physical service footprint, demand estimates, special service requirements, and infrastructure characteristics to support asset planning, capacity management, and equity reporting."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (e.g. Single Family, Multi-Family, Commercial, Industrial) for demand segmentation and infrastructure planning."
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (e.g. Active, Inactive, Demolished) for active service footprint analysis."
    - name: "building_type"
      expr: building_type
      comment: "Building type classification used for demand profiling and infrastructure sizing decisions."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the premise (e.g. Residential, Commercial, Industrial, Agricultural) for land-use-based demand analysis."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line (e.g. Lead, Copper, PVC) — critical for lead service line replacement program tracking and public health compliance."
    - name: "fire_protection_required_flag"
      expr: fire_protection_required_flag
      comment: "Indicates whether fire protection service is required at the premise, used for fire flow capacity planning."
    - name: "backflow_prevention_required_flag"
      expr: backflow_prevention_required_flag
      comment: "Indicates whether backflow prevention is required, used for cross-connection control program compliance tracking."
    - name: "industrial_user_permit_required_flag"
      expr: industrial_user_permit_required_flag
      comment: "Indicates whether an industrial user permit is required, used for pretreatment program compliance and regulatory reporting."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates premise-level low-income assistance eligibility, used for equity program targeting and affordability reporting."
    - name: "reclaimed_water_service_available_flag"
      expr: reclaimed_water_service_available_flag
      comment: "Indicates whether reclaimed water service is available at the premise, used for water reuse program capacity and adoption analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the premise became effective in the service territory, used for service footprint growth trend analysis."
  measures:
    - name: "total_active_premises"
      expr: COUNT(CASE WHEN premise_status = 'Active' THEN 1 END)
      comment: "Total number of active premises in the service territory. Core service footprint KPI used for infrastructure planning and regulatory reporting."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand in gallons across all premises. Primary demand planning KPI for supply, treatment, and distribution capacity decisions."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily demand per premise. Used for per-premise demand benchmarking and conservation program targeting."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in gallons per minute across all premises. Critical for distribution system hydraulic capacity planning and pressure zone management."
    - name: "avg_meter_size_inches"
      expr: AVG(CAST(meter_size_inches AS DOUBLE))
      comment: "Average meter size in inches across premises. Indicates the typical service connection capacity and informs meter replacement and upsizing programs."
    - name: "premises_requiring_fire_protection"
      expr: COUNT(CASE WHEN fire_protection_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring fire protection service. Used for fire flow capacity planning and fire service revenue analysis."
    - name: "premises_requiring_backflow_prevention"
      expr: COUNT(CASE WHEN backflow_prevention_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring backflow prevention devices. Tracks cross-connection control program scope and compliance obligations."
    - name: "premises_with_industrial_permit_required"
      expr: COUNT(CASE WHEN industrial_user_permit_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring an industrial user permit. Tracks pretreatment program scope for regulatory compliance reporting."
    - name: "total_building_square_footage"
      expr: SUM(CAST(building_square_footage AS DOUBLE))
      comment: "Total building square footage across all premises. Used as a proxy for service demand density and infrastructure investment prioritization."
    - name: "premises_eligible_for_low_income_assistance"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN 1 END)
      comment: "Number of premises eligible for low-income assistance programs. Supports affordability equity reporting and program funding justification."
    - name: "premises_with_reclaimed_water_available"
      expr: COUNT(CASE WHEN reclaimed_water_service_available_flag = TRUE THEN 1 END)
      comment: "Number of premises where reclaimed water service is available. Tracks water reuse program reach and potential adoption for conservation planning."
$$;