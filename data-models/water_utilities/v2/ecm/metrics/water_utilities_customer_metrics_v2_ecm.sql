-- Metric views for domain: customer | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics providing executive visibility into the active customer base, cost center distribution, and fund allocation. Used for revenue forecasting, service territory planning, and financial stewardship reporting."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Finance cost center to which the account is assigned — enables cost allocation analysis by operational unit."
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the account — supports GASB fund-based financial reporting."
    - name: "organization_id"
      expr: organization_id
      comment: "Organization (commercial/industrial customer entity) linked to the account — enables B2B vs residential segmentation."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts in scope. Baseline KPI for customer base sizing, growth tracking, and service territory capacity planning."
    - name: "distinct_organizations_served"
      expr: COUNT(DISTINCT organization_id)
      comment: "Number of distinct organizations (commercial/industrial entities) with active accounts. Drives B2B revenue strategy and industrial user compliance planning."
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers across accounts. Indicates operational complexity and cost allocation breadth for financial management."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint volume, resolution performance, and financial impact metrics. Critical for service quality management, regulatory compliance, and customer satisfaction steering. Executives use these KPIs to identify systemic service failures and prioritize remediation investments."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g., billing, water quality, pressure, service interruption) — primary grouping for root-cause analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, resolved, escalated) — used to track backlog and resolution pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the complaint — enables triage analysis and SLA compliance monitoring."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicates whether the complaint was escalated to a regulatory agency — critical for compliance risk tracking."
    - name: "contact_method"
      expr: contact_method
      comment: "Channel through which the complaint was received (phone, web, in-person) — informs omnichannel service strategy."
    - name: "water_quality_test_required_flag"
      expr: water_quality_test_required_flag
      comment: "Flags complaints requiring a water quality test — links complaint volume to quality assurance workload."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area associated with the complaint — enables geographic hotspot analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone linked to the complaint — supports hydraulic performance correlation."
    - name: "reported_date"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month the complaint was reported — enables trend analysis over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints filed. Baseline KPI for service quality monitoring and regulatory reporting (e.g., annual CCR complaint counts)."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Number of complaints escalated to a regulatory agency. High values signal systemic compliance risk and potential enforcement exposure."
    - name: "regulatory_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that escalated to regulatory agencies. A rising rate is a leading indicator of regulatory enforcement risk."
    - name: "total_billing_adjustment_amount"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total dollar value of billing adjustments issued as complaint resolutions. Directly impacts revenue and is a proxy for service failure financial cost."
    - name: "avg_billing_adjustment_amount"
      expr: AVG(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Average billing adjustment per complaint. Tracks the per-incident financial cost of service failures for budgeting and loss control."
    - name: "water_quality_test_required_count"
      expr: COUNT(CASE WHEN water_quality_test_required_flag = TRUE THEN 1 END)
      comment: "Number of complaints requiring a water quality test. Drives laboratory workload planning and public health response prioritization."
    - name: "compensation_provided_count"
      expr: COUNT(CASE WHEN compensation_provided_flag = TRUE THEN 1 END)
      comment: "Number of complaints where customer compensation was provided. Tracks goodwill expenditure and service recovery program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer case management metrics covering volume, financial exposure, SLA performance, and resolution efficiency. Used by operations and customer service leadership to manage workload, enforce service levels, and control case-related costs."
  source: "`vibe_water_utilities_v1`.`customer`.`case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of customer case (billing dispute, service request, compliance, etc.) — primary dimension for workload categorization."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, closed, escalated) — used to monitor active backlog and closure rates."
    - name: "priority"
      expr: priority
      comment: "Priority level of the case — enables SLA tier analysis and resource allocation decisions."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case was initiated (phone, web, field) — informs channel efficiency and cost-to-serve analysis."
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the SLA target was met for this case — core dimension for service level compliance reporting."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for the case — enables departmental workload and performance benchmarking."
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_timestamp)
      comment: "Month the case was opened — supports trend analysis and seasonal demand planning."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of cases. Baseline KPI for customer service workload management and staffing decisions."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Number of cases where the SLA target was met. Directly measures service delivery performance against contractual and regulatory commitments."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resolved within SLA. A key executive KPI for customer service quality and regulatory compliance."
    - name: "total_case_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges associated with cases. Tracks revenue recovery from case-related fees (e.g., reconnection, investigation fees)."
    - name: "total_case_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on case charges. Required for financial reconciliation and tax reporting."
    - name: "total_case_total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total financial exposure across all cases (charges + tax). Informs revenue impact assessment and collections prioritization."
    - name: "avg_case_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per case. Benchmarks cost-per-case for operational efficiency and pricing of case-related services."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Number of currently open cases. Real-time backlog indicator for staffing and escalation management."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service application pipeline metrics tracking application volume, approval rates, processing efficiency, and financial requirements. Used by operations and finance leadership to manage new customer onboarding, connection fee revenue, and deposit liability."
  source: "`vibe_water_utilities_v1`.`customer`.`service_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (pending, approved, rejected, withdrawn) — primary dimension for pipeline stage analysis."
    - name: "application_type"
      expr: application_type
      comment: "Type of service application (new service, transfer, upgrade) — enables product mix analysis."
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of service requested (water, sewer, reclaimed) — drives capacity planning and revenue forecasting by service line."
    - name: "service_class_requested"
      expr: service_class_requested
      comment: "Customer class requested (residential, commercial, industrial) — enables rate class demand forecasting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (online, in-person, phone) — informs digital adoption and channel cost analysis."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Whether a deposit was required — segments applicants by credit risk profile."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory for the application — enables geographic demand analysis and capacity planning."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of application submission — supports trend analysis and seasonal demand forecasting."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total service applications received. Baseline KPI for new customer acquisition pipeline and growth tracking."
    - name: "approved_application_count"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of approved applications. Measures successful onboarding throughput and conversion from application to active service."
    - name: "rejected_application_count"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected applications. Tracks denial rates for credit risk management and equity/access reporting."
    - name: "application_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved. Key conversion metric for new customer acquisition efficiency."
    - name: "total_connection_fee_amount"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees across applications. Tracks capital recovery revenue from new service connections — a significant infrastructure funding source."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application. Benchmarks fee adequacy against infrastructure cost recovery targets."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across applications. Tracks deposit liability exposure and cash flow from security deposits."
    - name: "deposit_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications requiring a deposit. Indicates credit risk profile of the applicant pool and deposit program utilization."
    - name: "withdrawn_application_count"
      expr: COUNT(CASE WHEN application_status = 'Withdrawn' THEN 1 END)
      comment: "Number of withdrawn applications. A rising withdrawal rate may signal process friction, pricing concerns, or competitive service alternatives."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account status transition metrics tracking delinquency, disconnection, reconnection, and financial exposure across the customer lifecycle. Critical for collections management, revenue protection, and regulatory compliance (e.g., shutoff moratorium tracking)."
  source: "`vibe_water_utilities_v1`.`customer`.`account_status_history`"
  dimensions:
    - name: "new_status_code"
      expr: new_status_code
      comment: "The status the account transitioned to — primary dimension for lifecycle stage analysis (active, delinquent, disconnected, etc.)."
    - name: "previous_status_code"
      expr: previous_status_code
      comment: "The status the account transitioned from — enables transition flow analysis (e.g., active-to-delinquent rate)."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the status change — supports root-cause analysis of delinquency and disconnection drivers."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the customer of the status change — informs communication effectiveness analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether a regulatory hold prevented action — tracks compliance with shutoff moratoriums and low-income protections."
    - name: "medical_certification_flag"
      expr: medical_certification_flag
      comment: "Whether a medical certification was on file — critical for life-safety compliance and shutoff eligibility."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the status change was reversed — tracks error rates and process quality in account management."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the status change took effect — enables trend analysis of delinquency and disconnection cycles."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total account status transitions. Baseline KPI for account lifecycle activity volume and collections workflow throughput."
    - name: "total_outstanding_balance_amount"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance at time of status change. Measures aggregate delinquent receivables exposure — a critical revenue protection KPI."
    - name: "avg_outstanding_balance_amount"
      expr: AVG(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Average outstanding balance per status transition. Benchmarks typical delinquency depth for collections strategy calibration."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts associated with status changes. Tracks deposit collection and refund activity for cash flow management."
    - name: "total_reconnection_fee_amount"
      expr: SUM(CAST(reconnection_fee_amount AS DOUBLE))
      comment: "Total reconnection fees assessed. Tracks revenue from reconnection charges and measures the financial burden on customers returning to service."
    - name: "regulatory_hold_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of status changes blocked by regulatory holds. Tracks compliance with shutoff moratoriums and low-income protection regulations."
    - name: "medical_certification_hold_count"
      expr: COUNT(CASE WHEN medical_certification_flag = TRUE THEN 1 END)
      comment: "Number of accounts with medical certifications on file at time of status change. Critical for life-safety compliance and shutoff eligibility audits."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status transitions that were reversed. A high reversal rate indicates process errors in account management or collections."
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status changes where customer notification was sent. Measures compliance with notice requirements before shutoff or other adverse actions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_assistance_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assistance program enrollment metrics tracking program uptake, fund utilization, and grant-backed enrollment. Used by finance and customer service leadership to manage affordability program budgets, demonstrate equity outcomes, and comply with low-income assistance reporting requirements."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment`"
  dimensions:
    - name: "assistance_program_id"
      expr: assistance_program_id
      comment: "Assistance program the customer is enrolled in — primary dimension for program-level performance analysis."
    - name: "fund_id"
      expr: fund_id
      comment: "Fund from which the assistance benefit is drawn — enables fund-level budget consumption tracking."
    - name: "grant_id"
      expr: grant_id
      comment: "Grant funding the enrollment — tracks grant utilization rates for compliance with grant reporting requirements."
    - name: "affordability_plan_id"
      expr: affordability_plan_id
      comment: "Affordability plan associated with the enrollment — enables plan-level participation and cost analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total assistance program enrollments. Baseline KPI for affordability program reach and equity reporting."
    - name: "distinct_programs_utilized"
      expr: COUNT(DISTINCT assistance_program_id)
      comment: "Number of distinct assistance programs with active enrollments. Measures program portfolio utilization breadth."
    - name: "grant_backed_enrollment_count"
      expr: COUNT(CASE WHEN grant_id IS NOT NULL THEN 1 END)
      comment: "Number of enrollments backed by a grant. Tracks grant fund utilization and compliance with grant-funded assistance program requirements."
    - name: "grant_backed_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grant_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments backed by grant funding. Informs grant dependency risk and sustainability of assistance program funding."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conservation and service program enrollment metrics tracking participation rates, water savings achieved, and incentive payments. Used by conservation managers and finance to evaluate program ROI, report water savings to regulators, and manage incentive budgets."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, completed, withdrawn) — primary dimension for program participation pipeline analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the enrollment — tracks compliance with program eligibility requirements."
    - name: "conservation_program_id"
      expr: conservation_program_id
      comment: "Conservation program the customer is enrolled in — enables program-level performance comparison."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment — supports trend analysis and seasonal program uptake patterns."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total program enrollments. Baseline KPI for conservation and service program adoption tracking."
    - name: "total_water_savings_gallons"
      expr: SUM(CAST(water_savings_achieved_gallons AS DOUBLE))
      comment: "Total water savings achieved across all enrolled customers in gallons. Primary outcome KPI for conservation program effectiveness and regulatory reporting."
    - name: "avg_water_savings_per_enrollment_gallons"
      expr: AVG(CAST(water_savings_achieved_gallons AS DOUBLE))
      comment: "Average water savings per enrolled customer in gallons. Benchmarks per-customer conservation impact for program design optimization."
    - name: "total_incentive_amount_received"
      expr: SUM(CAST(incentive_amount_received AS DOUBLE))
      comment: "Total incentive payments disbursed to enrolled customers. Tracks program expenditure against conservation budget allocations."
    - name: "avg_incentive_per_enrollment"
      expr: AVG(CAST(incentive_amount_received AS DOUBLE))
      comment: "Average incentive payment per enrollment. Used to assess cost-effectiveness of incentive-based conservation programs."
    - name: "cost_per_gallon_saved"
      expr: ROUND(SUM(CAST(incentive_amount_received AS DOUBLE)) / NULLIF(SUM(CAST(water_savings_achieved_gallons AS DOUBLE)), 0), 4)
      comment: "Cost in dollars per gallon of water saved through incentive programs. The definitive ROI metric for conservation program investment decisions."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Number of currently active program enrollments. Tracks live program participation for operational planning and budget forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction metrics covering contact volume, channel distribution, resolution quality, and satisfaction scores. Used by customer experience leadership to optimize service delivery, manage contact center costs, and track first-contact resolution performance."
  source: "`vibe_water_utilities_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (inquiry, complaint, service request, etc.) — primary dimension for contact reason analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (phone, web, chat, in-person) — drives channel cost and digital adoption analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (open, resolved, escalated) — tracks resolution pipeline and backlog."
    - name: "interaction_category"
      expr: interaction_category
      comment: "Business category of the interaction — enables topic-level demand analysis for staffing and knowledge base investment."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the interaction was escalated — key quality indicator for first-line resolution effectiveness."
    - name: "first_contact_resolution_flag"
      expr: first_contact_resolution_flag
      comment: "Whether the issue was resolved on first contact — the gold standard metric for contact center efficiency."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Whether an interpreter was required — tracks language access service demand for equity and compliance planning."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of the interaction — enables trend analysis and seasonal contact volume forecasting."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total customer interactions. Baseline KPI for contact center volume, staffing demand, and customer engagement tracking."
    - name: "first_contact_resolution_count"
      expr: COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END)
      comment: "Number of interactions resolved on first contact. Measures contact center efficiency and customer effort reduction."
    - name: "first_contact_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions resolved on first contact. The primary contact center efficiency KPI — directly linked to customer satisfaction and cost-to-serve."
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated interactions. Tracks service failure volume requiring management intervention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that required escalation. A rising escalation rate signals degrading first-line service quality."
    - name: "callback_requested_count"
      expr: COUNT(CASE WHEN callback_requested_flag = TRUE THEN 1 END)
      comment: "Number of interactions where a callback was requested. Tracks unresolved contact demand and callback queue depth."
    - name: "interpreter_required_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Number of interactions requiring language interpretation. Drives language access staffing and compliance with Title VI requirements."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_enforcement_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enforcement action impact metrics tracking financial exposure, service restrictions, and customer response compliance. Used by compliance and legal leadership to manage regulatory enforcement risk, quantify financial penalties, and track customer remediation timelines."
  source: "`vibe_water_utilities_v1`.`customer`.`account_enforcement_impact`"
  dimensions:
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the enforcement impact (low, medium, high, critical) — primary dimension for risk prioritization."
    - name: "account_restriction_type"
      expr: account_restriction_type
      comment: "Type of account restriction imposed — tracks restriction portfolio for compliance management."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the customer of the enforcement impact — tracks notification compliance."
    - name: "customer_response_required_flag"
      expr: customer_response_required_flag
      comment: "Whether a customer response is required — segments impacts by response obligation for follow-up management."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was sent — tracks notification compliance rate."
  measures:
    - name: "total_enforcement_impacts"
      expr: COUNT(1)
      comment: "Total enforcement action impacts on customer accounts. Baseline KPI for regulatory enforcement activity volume."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of enforcement actions on customers. Quantifies aggregate penalty and remediation cost exposure — a key risk management KPI."
    - name: "avg_financial_impact_amount"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per enforcement action. Benchmarks typical enforcement cost for risk modeling and insurance planning."
    - name: "total_affected_service_count"
      expr: SUM(CAST(affected_service_count AS DOUBLE))
      comment: "Total number of services affected by enforcement actions. Measures the operational breadth of enforcement impacts on service delivery."
    - name: "notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enforcement impacts where customer notification was sent. Tracks compliance with mandatory notification requirements."
    - name: "customer_response_received_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_response_received_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN customer_response_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required customer responses that were actually received. Tracks customer compliance with enforcement response obligations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment analytics providing revenue contribution, conservation target, and usage threshold metrics by segment. Used by rate-setting teams, conservation planners, and finance to design equitable rate structures, set conservation goals, and forecast demand by customer class."
  source: "`vibe_water_utilities_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of customer segment (residential, commercial, industrial, irrigation) — primary dimension for rate class analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, inactive, under review) — filters analysis to active segments."
    - name: "service_class_code"
      expr: service_class_code
      comment: "Service class code associated with the segment — links segments to rate schedules for revenue modeling."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory associated with the segment — enables geographic rate and demand analysis."
    - name: "regulatory_reporting_category"
      expr: regulatory_reporting_category
      comment: "Regulatory reporting category for the segment — supports compliance reporting by customer class."
    - name: "seasonal_variation_flag"
      expr: seasonal_variation_flag
      comment: "Whether the segment exhibits seasonal demand variation — informs demand forecasting and rate design."
    - name: "assistance_program_eligible"
      expr: assistance_program_eligible
      comment: "Whether the segment is eligible for assistance programs — tracks affordability program reach by customer class."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of customer segments defined. Baseline KPI for segmentation model complexity and coverage."
    - name: "total_revenue_contribution_pct"
      expr: SUM(CAST(revenue_contribution_pct AS DOUBLE))
      comment: "Sum of revenue contribution percentages across segments. Used to verify that segment revenue allocations sum to 100% and to identify revenue concentration risk."
    - name: "avg_monthly_usage_gallons"
      expr: AVG(CAST(average_monthly_usage_gallons AS DOUBLE))
      comment: "Average monthly water usage in gallons across segments. Drives demand forecasting, infrastructure sizing, and rate adequacy analysis."
    - name: "total_monthly_usage_gallons"
      expr: SUM(CAST(average_monthly_usage_gallons AS DOUBLE))
      comment: "Total average monthly water usage in gallons across all segments. Baseline for system-wide demand planning and source water adequacy assessment."
    - name: "avg_conservation_target_pct"
      expr: AVG(CAST(conservation_target_pct AS DOUBLE))
      comment: "Average conservation target percentage across segments. Tracks the ambition level of conservation goals for regulatory compliance and drought planning."
    - name: "assistance_eligible_segment_count"
      expr: COUNT(CASE WHEN assistance_program_eligible = TRUE THEN 1 END)
      comment: "Number of segments eligible for assistance programs. Measures the breadth of affordability program coverage across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premise-level infrastructure and service availability metrics. Used by engineering, planning, and operations to assess service coverage, infrastructure demand, and compliance with backflow prevention and industrial user permit requirements."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (residential, commercial, industrial, multi-family) — primary dimension for demand and infrastructure analysis."
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (active, inactive, demolished) — filters to active service locations."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory of the premise — enables geographic service coverage and capacity analysis."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the premise — supports land use planning and future demand forecasting."
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Whether water service is available at the premise — tracks service coverage gaps."
    - name: "wastewater_service_available_flag"
      expr: wastewater_service_available_flag
      comment: "Whether wastewater service is available — tracks sewer service coverage for infrastructure planning."
    - name: "backflow_prevention_required_flag"
      expr: backflow_prevention_required_flag
      comment: "Whether backflow prevention is required — tracks cross-connection control compliance obligations."
    - name: "industrial_user_permit_required_flag"
      expr: industrial_user_permit_required_flag
      comment: "Whether an industrial user permit is required — tracks pretreatment program compliance obligations."
  measures:
    - name: "total_premises"
      expr: COUNT(1)
      comment: "Total number of premises in the service area. Baseline KPI for service territory sizing and infrastructure planning."
    - name: "water_service_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN water_service_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of premises with water service available. Measures service coverage completeness — a key equity and regulatory compliance metric."
    - name: "wastewater_service_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN wastewater_service_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of premises with wastewater service available. Tracks sewer service coverage for public health and environmental compliance."
    - name: "backflow_prevention_required_count"
      expr: COUNT(CASE WHEN backflow_prevention_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring backflow prevention devices. Drives cross-connection control program workload and compliance tracking."
    - name: "industrial_user_permit_required_count"
      expr: COUNT(CASE WHEN industrial_user_permit_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring industrial user permits. Tracks pretreatment program compliance obligations and enforcement workload."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily water demand per premise in gallons. Drives infrastructure sizing, pressure zone design, and source water adequacy planning."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across all premises in gallons. System-wide demand baseline for capacity planning and drought contingency."
    - name: "avg_connection_fee_paid_amount"
      expr: AVG(CAST(connection_fee_paid_amount AS DOUBLE))
      comment: "Average connection fee paid per premise. Benchmarks fee adequacy against infrastructure cost recovery targets over time."
    - name: "total_connection_fee_paid_amount"
      expr: SUM(CAST(connection_fee_paid_amount AS DOUBLE))
      comment: "Total connection fees collected across premises. Tracks cumulative infrastructure cost recovery from development contributions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hierarchy metrics tracking consolidated billing relationships, payment responsibility structures, and multi-account arrangements. Used by finance and customer service to manage complex commercial/industrial account structures, consolidated billing programs, and payment allocation."
  source: "`vibe_water_utilities_v1`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of account hierarchy (consolidated billing, master-sub, landlord-tenant) — primary dimension for relationship structure analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the hierarchy (parent, child, grandchild) — enables multi-tier account structure analysis."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the hierarchy relationship (active, terminated, pending) — filters to active consolidation arrangements."
    - name: "billing_consolidation_flag"
      expr: billing_consolidation_flag
      comment: "Whether billing is consolidated under this hierarchy — tracks consolidated billing program participation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hierarchy arrangement — tracks pending approvals for operational readiness."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs/consumption within the hierarchy — informs billing complexity and audit requirements."
  measures:
    - name: "total_hierarchy_relationships"
      expr: COUNT(1)
      comment: "Total account hierarchy relationships. Baseline KPI for consolidated billing program scale and complexity."
    - name: "consolidated_billing_count"
      expr: COUNT(CASE WHEN billing_consolidation_flag = TRUE THEN 1 END)
      comment: "Number of hierarchy relationships with consolidated billing. Tracks consolidated billing program adoption among multi-account customers."
    - name: "consolidated_billing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_consolidation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hierarchy relationships using consolidated billing. Measures program penetration among eligible multi-account customers."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average cost/consumption allocation percentage within hierarchies. Validates that allocation structures are properly configured for billing accuracy."
    - name: "consumption_rollup_count"
      expr: COUNT(CASE WHEN consumption_rollup_flag = TRUE THEN 1 END)
      comment: "Number of hierarchies with consumption rollup enabled. Tracks demand aggregation arrangements relevant to tiered rate and demand charge calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer deposit metrics tracking deposit liability, fund allocation, and bank account distribution. Used by finance to manage deposit escrow obligations, GASB liability reporting, and cash flow from security deposit programs."
  source: "`vibe_water_utilities_v1`.`customer`.`deposit`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund holding the deposit — enables fund-level deposit liability tracking for GASB reporting."
    - name: "bank_account_id"
      expr: bank_account_id
      comment: "Bank account holding the deposit — tracks deposit escrow account utilization."
  measures:
    - name: "total_deposits"
      expr: COUNT(1)
      comment: "Total number of customer deposits on file. Baseline KPI for deposit program scale and liability exposure."
    - name: "distinct_customers_with_deposits"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts with active deposits. Measures deposit program reach and credit risk management coverage."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_sampling_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead and copper rule (LCR/LCRR) and other regulatory sampling participation metrics. Used by compliance and water quality teams to track customer participation rates, sampling plan coverage, and sample collection progress for regulatory reporting."
  source: "`vibe_water_utilities_v1`.`customer`.`sampling_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status (active, withdrawn, completed) — primary dimension for sampling program pipeline analysis."
    - name: "sampling_plan_id"
      expr: sampling_plan_id
      comment: "Sampling plan the customer is participating in — enables plan-level participation rate analysis."
    - name: "notification_preference"
      expr: notification_preference
      comment: "Customer notification preference for sampling events — informs outreach strategy for sample collection scheduling."
  measures:
    - name: "total_sampling_participants"
      expr: COUNT(1)
      comment: "Total customer sampling participants. Baseline KPI for regulatory sampling program coverage and LCRR compliance."
    - name: "active_participant_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Number of currently active sampling participants. Tracks live sampling program enrollment for regulatory minimum sample count compliance."
    - name: "active_participation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled participants currently active. Measures sampling program retention and attrition for regulatory compliance planning."
    - name: "distinct_sampling_plans_covered"
      expr: COUNT(DISTINCT sampling_plan_id)
      comment: "Number of distinct sampling plans with customer participation. Tracks regulatory sampling plan coverage breadth."
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