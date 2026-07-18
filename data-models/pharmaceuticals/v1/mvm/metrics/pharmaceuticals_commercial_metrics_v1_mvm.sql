-- Metric views for domain: commercial | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_sales_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sales KPIs measuring quota attainment, prescription volume, market share, and incentive compensation across brands, territories, and sales reps. Primary steering dashboard for commercial leadership."
  source: "`pharmaceuticals_ecm`.`commercial`.`sales_performance`"
  dimensions:
    - name: "performance_period_start_date"
      expr: performance_period_start_date
      comment: "Start date of the performance measurement period, used for time-series trending of sales KPIs."
    - name: "performance_period_end_date"
      expr: performance_period_end_date
      comment: "End date of the performance measurement period."
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the performance period (e.g., Monthly, Quarterly, Annual) for cohort analysis."
    - name: "performance_status"
      expr: performance_status
      comment: "Current status of the performance record (e.g., Final, Provisional) to filter for confirmed results."
    - name: "data_source"
      expr: data_source
      comment: "Source system feeding the performance data, enabling data lineage and reconciliation."
    - name: "quota_currency"
      expr: quota_currency
      comment: "Currency denomination of quota and performance amounts for multi-currency analysis."
    - name: "incentive_compensation_currency"
      expr: incentive_compensation_currency
      comment: "Currency of incentive compensation payouts for financial reporting."
  measures:
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total sales quota assigned across all reps and territories. Baseline for attainment analysis and resource planning."
    - name: "total_actual_performance_amount"
      expr: SUM(CAST(actual_performance_amount AS DOUBLE))
      comment: "Total actual sales performance amount achieved. Core revenue-proxy KPI for commercial steering."
    - name: "avg_quota_attainment_percent"
      expr: AVG(CAST(quota_attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage across the selected cohort. Directly drives incentive compensation decisions and territory realignment."
    - name: "avg_market_share_percent"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share percentage. A primary competitive KPI used in brand strategy reviews and portfolio prioritization."
    - name: "total_new_prescriptions"
      expr: SUM(CAST(new_prescriptions AS DOUBLE))
      comment: "Total new prescriptions generated. Leading indicator of brand adoption and HCP engagement effectiveness."
    - name: "total_prescriptions"
      expr: SUM(CAST(total_prescriptions AS DOUBLE))
      comment: "Total prescription volume (new + refill). Core demand metric for supply chain planning and revenue forecasting."
    - name: "avg_call_attainment_percent"
      expr: AVG(CAST(call_attainment_percent AS DOUBLE))
      comment: "Average call plan attainment percentage. Measures field force execution discipline; low attainment triggers coaching or territory restructuring."
    - name: "total_incentive_compensation_amount"
      expr: SUM(CAST(incentive_compensation_amount AS DOUBLE))
      comment: "Total incentive compensation paid out. Critical for HR cost management and ensuring pay-for-performance alignment."
    - name: "total_sample_units_distributed"
      expr: SUM(CAST(sample_units_distributed AS DOUBLE))
      comment: "Total sample units distributed by the field force. Proxy for HCP engagement depth and brand trial generation."
    - name: "avg_sample_drop_rate"
      expr: AVG(CAST(sample_drop_rate AS DOUBLE))
      comment: "Average sample drop rate per call. Indicates sampling program efficiency and compliance with PDMA guidelines."
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Count of performance records in the selected period and cohort. Used to validate data completeness and coverage."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial order-level revenue metrics covering gross sales, net revenue, discounts, rebates, and order fulfillment patterns. Foundational for gross-to-net revenue analysis and demand management."
  source: "`pharmaceuticals_ecm`.`commercial`.`sales_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the sales order was placed. Primary time dimension for revenue trend analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., Open, Shipped, Cancelled). Used to filter for revenue-recognized orders."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., Standard, Return, Sample). Enables segmentation of commercial vs. non-commercial flows."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed (e.g., Direct, Distributor, Specialty Pharmacy). Key for channel mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order for multi-currency revenue reporting."
    - name: "order_source"
      expr: order_source
      comment: "System or process that originated the order (e.g., CRM, EDI, Manual). Supports data quality and channel attribution."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order. Relevant for cash flow forecasting and accounts receivable management."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the order. Used for logistics cost analysis and delivery performance tracking."
    - name: "sample_distribution_flag"
      expr: sample_distribution_flag
      comment: "Indicates whether the order is a sample distribution. Separates commercial revenue from sample program costs."
    - name: "phrma_code_compliant_flag"
      expr: phrma_code_compliant_flag
      comment: "Indicates PhRMA code compliance for the order. Required for compliance reporting and audit readiness."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross sales amount before discounts and rebates. Top-line revenue KPI for commercial performance reviews."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net sales amount after discounts and rebates. The primary revenue metric for P&L reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across orders. Key gross-to-net deduction tracked for pricing governance."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebates granted. Major gross-to-net deduction impacting net revenue; monitored by finance and market access."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on orders. Required for tax compliance reporting and financial close."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per order. Indicates deal size trends and pricing effectiveness across channels."
    - name: "gross_to_net_deduction_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE) - CAST(net_amount AS DOUBLE))
      comment: "Total gross-to-net deductions (discounts + rebates + tax combined as gross minus net). Critical for net revenue management and payer contract evaluation."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of sales orders. Volume metric for demand planning and field force productivity benchmarking."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled orders. Elevated cancellation rates signal supply, pricing, or customer satisfaction issues requiring intervention."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_call_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field force call execution metrics measuring HCP engagement frequency, channel mix, sample activity, and compliance. Drives call plan optimization and promotional effectiveness analysis."
  source: "`pharmaceuticals_ecm`.`commercial`.`call_activity`"
  dimensions:
    - name: "call_date"
      expr: call_date
      comment: "Date of the HCP call. Primary time dimension for call trend and seasonality analysis."
    - name: "call_type"
      expr: call_type
      comment: "Type of call (e.g., Face-to-Face, Remote, Phone). Enables channel mix analysis and ROI comparison across call types."
    - name: "call_status"
      expr: call_status
      comment: "Status of the call record (e.g., Submitted, Approved, Rejected). Used to filter for valid, compliant call records."
    - name: "call_outcome"
      expr: call_outcome
      comment: "Outcome of the HCP interaction (e.g., Positive, Neutral, Negative). Informs next-best-action and targeting strategy."
    - name: "channel_mix_code"
      expr: channel_mix_code
      comment: "Channel mix code for the call. Supports omnichannel engagement analysis and promotional spend allocation."
    - name: "detail_priority_1_product"
      expr: detail_priority_1_product
      comment: "Primary product detailed during the call. Measures share-of-voice and promotional focus by brand."
    - name: "kol_flag"
      expr: kol_flag
      comment: "Indicates whether the HCP is a Key Opinion Leader. Enables KOL-specific engagement tracking and ROI measurement."
    - name: "samples_dropped_flag"
      expr: samples_dropped_flag
      comment: "Indicates whether samples were dropped during the call. Used to correlate sampling activity with prescription lift."
    - name: "phrma_code_compliant_flag"
      expr: phrma_code_compliant_flag
      comment: "PhRMA code compliance flag for the call. Non-compliant calls require immediate remediation to avoid regulatory risk."
    - name: "sunshine_act_reportable_flag"
      expr: sunshine_act_reportable_flag
      comment: "Indicates whether the call has Sunshine Act reportable transfers of value. Required for Open Payments compliance reporting."
    - name: "speaker_program_flag"
      expr: speaker_program_flag
      comment: "Indicates whether the call was associated with a speaker program. Enables speaker program ROI and compliance tracking."
  measures:
    - name: "total_calls"
      expr: COUNT(1)
      comment: "Total number of HCP calls executed. Primary field force activity volume metric for call plan attainment tracking."
    - name: "total_transfer_of_value_usd"
      expr: SUM(CAST(transfer_of_value_usd AS DOUBLE))
      comment: "Total transfer of value in USD across all calls. Mandatory for Sunshine Act / Open Payments aggregate reporting."
    - name: "total_meal_cost_usd"
      expr: SUM(CAST(meal_cost_usd AS DOUBLE))
      comment: "Total meal costs incurred during HCP calls. Monitored for PhRMA code compliance and promotional spend governance."
    - name: "avg_meal_cost_per_call_usd"
      expr: AVG(CAST(meal_cost_usd AS DOUBLE))
      comment: "Average meal cost per call. Benchmarked against PhRMA code limits; spikes trigger compliance review."
    - name: "calls_with_samples_count"
      expr: COUNT(CASE WHEN samples_dropped_flag = TRUE THEN 1 END)
      comment: "Number of calls where samples were dropped. Measures sampling program reach and correlates with prescription generation."
    - name: "kol_call_count"
      expr: COUNT(CASE WHEN kol_flag = TRUE THEN 1 END)
      comment: "Number of calls made to Key Opinion Leaders. KOL engagement is a leading indicator of scientific advocacy and brand endorsement."
    - name: "sunshine_act_reportable_call_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable_flag = TRUE THEN 1 END)
      comment: "Count of calls with Sunshine Act reportable transfers of value. Drives Open Payments filing completeness and risk management."
    - name: "non_compliant_call_count"
      expr: COUNT(CASE WHEN phrma_code_compliant_flag = FALSE THEN 1 END)
      comment: "Count of calls flagged as non-compliant with PhRMA code. Any non-zero value triggers compliance investigation and rep coaching."
    - name: "unique_hcps_called"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs reached. Measures breadth of promotional reach and targeting coverage against the target list."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_copay_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient access and copay program financial metrics tracking redemption volumes, benefit utilization, out-of-pocket reduction, and gross-to-net impact. Critical for patient affordability strategy and program ROI evaluation."
  source: "`pharmaceuticals_ecm`.`commercial`.`copay_redemption`"
  dimensions:
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date of the copay redemption transaction. Primary time dimension for program utilization trending."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (e.g., Approved, Rejected, Reversed). Used to isolate valid redemptions for financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-currency financial reporting."
    - name: "pharmacy_chain_code"
      expr: pharmacy_chain_code
      comment: "Pharmacy chain where the redemption occurred. Enables channel-level program performance analysis."
    - name: "prescriber_specialty"
      expr: prescriber_specialty
      comment: "Specialty of the prescribing HCP. Identifies which specialties drive the highest copay program utilization."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the redemption. Supports geographic access gap analysis and program expansion decisions."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the redemption. Enables cross-TA program cost and utilization benchmarking."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the redemption was reversed. Reversals reduce net program liability and must be tracked for accurate financial accruals."
    - name: "payer_adjudication_status"
      expr: payer_adjudication_status
      comment: "Payer adjudication outcome for the redemption. Rejected adjudications indicate formulary or eligibility barriers requiring market access intervention."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total copay redemption transactions. Primary volume metric for program utilization and patient reach."
    - name: "total_transaction_amount"
      expr: SUM(CAST(total_transaction_amount AS DOUBLE))
      comment: "Total financial value of all copay redemption transactions. Core gross-to-net deduction metric for net revenue management."
    - name: "total_patient_out_of_pocket_amount"
      expr: SUM(CAST(patient_out_of_pocket_amount AS DOUBLE))
      comment: "Total patient out-of-pocket costs after copay assistance. Measures program effectiveness in reducing patient financial burden."
    - name: "total_insurance_paid_amount"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurance across redemptions. Indicates payer coverage levels and formulary access quality."
    - name: "total_retail_price_amount"
      expr: SUM(CAST(retail_price_amount AS DOUBLE))
      comment: "Total retail price of dispensed product. Baseline for calculating effective patient savings and program subsidy rates."
    - name: "avg_patient_out_of_pocket_amount"
      expr: AVG(CAST(patient_out_of_pocket_amount AS DOUBLE))
      comment: "Average patient out-of-pocket cost per redemption. Benchmarks affordability and guides copay cap adjustments."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total units dispensed through copay redemptions. Demand signal for supply chain and inventory planning."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversed redemptions. High reversal rates indicate program fraud risk or eligibility verification failures."
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of distinct patients who redeemed copay benefits. Measures program reach and patient access breadth."
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct prescribers whose patients used the copay program. Indicates HCP adoption and prescribing confidence supported by patient access programs."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_kol_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Opinion Leader engagement metrics tracking honorarium spend, engagement activity, compliance status, and strategic relationship depth. Supports medical affairs investment governance and Sunshine Act reporting."
  source: "`pharmaceuticals_ecm`.`commercial`.`kol_engagement`"
  dimensions:
    - name: "engagement_date"
      expr: engagement_date
      comment: "Date of the KOL engagement activity. Primary time dimension for engagement trend and spend pacing analysis."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of KOL engagement (e.g., Advisory Board, Speaker Program, Publication). Enables ROI comparison across engagement modalities."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the engagement (e.g., Planned, Completed, Cancelled). Used to filter for executed engagements in spend reporting."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status for the engagement. Non-approved engagements represent regulatory and reputational risk."
    - name: "strategic_relationship_tier"
      expr: strategic_relationship_tier
      comment: "Tier classification of the KOL relationship (e.g., Tier 1, Tier 2). Drives investment prioritization and engagement frequency targets."
    - name: "honorarium_currency"
      expr: honorarium_currency
      comment: "Currency of the honorarium payment for multi-currency financial reporting."
    - name: "transparency_reporting_required"
      expr: transparency_reporting_required
      comment: "Indicates whether the engagement requires transparency reporting (e.g., Sunshine Act). Drives compliance filing completeness."
    - name: "engagement_topic"
      expr: engagement_topic
      comment: "Topic or therapeutic area of the engagement. Enables scientific focus analysis and alignment with pipeline priorities."
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of KOL engagements executed. Primary activity volume metric for medical affairs program management."
    - name: "total_honorarium_amount"
      expr: SUM(CAST(honorarium_amount AS DOUBLE))
      comment: "Total honorarium paid to KOLs. Core spend metric for Sunshine Act reporting and medical affairs budget governance."
    - name: "avg_honorarium_per_engagement"
      expr: AVG(CAST(honorarium_amount AS DOUBLE))
      comment: "Average honorarium per engagement. Benchmarked against fair market value assessments to ensure compliance with anti-kickback regulations."
    - name: "total_engagement_hours"
      expr: SUM(CAST(engagement_duration_hours AS DOUBLE))
      comment: "Total hours of KOL engagement. Measures depth of scientific collaboration and supports fair market value justification."
    - name: "avg_engagement_duration_hours"
      expr: AVG(CAST(engagement_duration_hours AS DOUBLE))
      comment: "Average duration per KOL engagement in hours. Used to validate fair market value rates and engagement quality."
    - name: "compliance_approved_engagement_count"
      expr: COUNT(CASE WHEN compliance_approval_status = 'Approved' THEN 1 END)
      comment: "Count of engagements with confirmed compliance approval. Non-approved engagements must be remediated before payment processing."
    - name: "transparency_reportable_engagement_count"
      expr: COUNT(CASE WHEN transparency_reporting_required = TRUE THEN 1 END)
      comment: "Count of engagements requiring transparency reporting. Drives Open Payments filing completeness and regulatory risk management."
    - name: "unique_kols_engaged"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct KOLs engaged. Measures breadth of scientific network activation and relationship portfolio health."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_brand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand planning KPIs tracking revenue targets, prescription volume targets, market share goals, and plan execution status. Enables brand strategy governance and annual operating plan performance management."
  source: "`pharmaceuticals_ecm`.`commercial`.`brand_plan`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Fiscal year of the brand plan. Primary time dimension for annual planning cycle analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the brand plan (e.g., Draft, Approved, Active). Used to filter for approved, actionable plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of brand plan (e.g., Launch, Growth, Maintenance). Enables lifecycle-stage segmentation of planning KPIs."
    - name: "launch_phase"
      expr: launch_phase
      comment: "Launch phase of the brand (e.g., Pre-Launch, Launch, Post-Launch). Critical for tracking launch readiness and execution milestones."
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency of the brand plan budget for multi-currency financial planning."
    - name: "channel_strategy"
      expr: channel_strategy
      comment: "Promotional channel strategy defined in the plan. Enables channel mix investment analysis."
    - name: "plan_start_date"
      expr: plan_start_date
      comment: "Start date of the brand plan period."
    - name: "plan_end_date"
      expr: plan_end_date
      comment: "End date of the brand plan period."
    - name: "target_hcp_segment"
      expr: target_hcp_segment
      comment: "Target HCP segment defined in the brand plan. Enables alignment analysis between targeting strategy and field execution."
  measures:
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target AS DOUBLE))
      comment: "Total revenue target across all brand plans. Primary financial planning KPI for commercial leadership and CFO reporting."
    - name: "avg_revenue_target"
      expr: AVG(CAST(revenue_target AS DOUBLE))
      comment: "Average revenue target per brand plan. Benchmarks ambition levels across brands and therapeutic areas."
    - name: "total_prescription_volume_target"
      expr: SUM(CAST(prescription_volume_target AS DOUBLE))
      comment: "Total prescription volume target across brand plans. Demand planning baseline for supply chain and manufacturing capacity."
    - name: "avg_market_share_target"
      expr: AVG(CAST(market_share_target AS DOUBLE))
      comment: "Average market share target across brand plans. Competitive ambition metric reviewed in brand strategy sessions."
    - name: "active_brand_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Count of currently active brand plans. Indicates the breadth of active commercial programs requiring resource allocation."
    - name: "brand_plan_count"
      expr: COUNT(1)
      comment: "Total number of brand plans. Portfolio breadth metric for commercial operations planning."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_hcp_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCP targeting and segmentation metrics measuring target list composition, KOL coverage, prescribing potential, and engagement eligibility. Drives field force targeting strategy and call plan optimization."
  source: "`pharmaceuticals_ecm`.`commercial`.`hcp_target`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Current targeting status of the HCP (e.g., Active, Inactive, Pending). Used to filter for actionable targets."
    - name: "target_tier"
      expr: target_tier
      comment: "Tier classification of the HCP target (e.g., Tier 1, Tier 2, Tier 3). Primary segmentation for call frequency and resource allocation."
    - name: "specialty_segment"
      expr: specialty_segment
      comment: "Medical specialty segment of the targeted HCP. Enables specialty-level targeting coverage and penetration analysis."
    - name: "market_potential_segment"
      expr: market_potential_segment
      comment: "Market potential segment assigned to the HCP. Drives prioritization of high-value prescribers for promotional investment."
    - name: "prescribing_potential_decile"
      expr: prescribing_potential_decile
      comment: "Prescribing potential decile (1-10) of the HCP. Top-decile HCPs represent the highest ROI targets for field force investment."
    - name: "is_kol"
      expr: is_kol
      comment: "Indicates whether the HCP is classified as a Key Opinion Leader. KOL coverage is a strategic metric for medical affairs and commercial alignment."
    - name: "current_brand_prescriber"
      expr: current_brand_prescriber
      comment: "Indicates whether the HCP currently prescribes the brand. Distinguishes retention vs. acquisition targeting strategies."
    - name: "competitor_prescriber"
      expr: competitor_prescriber
      comment: "Indicates whether the HCP primarily prescribes a competitor product. Identifies conversion opportunity targets."
    - name: "do_not_contact_flag"
      expr: do_not_contact_flag
      comment: "Indicates HCPs who have opted out of contact. Must be excluded from call plans to ensure compliance."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the HCP targeting record became effective. Used for point-in-time target list analysis."
  measures:
    - name: "total_hcp_targets"
      expr: COUNT(1)
      comment: "Total number of HCP targets on the target list. Baseline for field force sizing and call plan capacity planning."
    - name: "kol_target_count"
      expr: COUNT(CASE WHEN is_kol = TRUE THEN 1 END)
      comment: "Number of KOLs on the target list. KOL coverage breadth is a strategic metric for scientific engagement and brand advocacy."
    - name: "current_prescriber_count"
      expr: COUNT(CASE WHEN current_brand_prescriber = TRUE THEN 1 END)
      comment: "Number of HCPs currently prescribing the brand. Measures prescriber base size and retention program scope."
    - name: "competitor_prescriber_count"
      expr: COUNT(CASE WHEN competitor_prescriber = TRUE THEN 1 END)
      comment: "Number of competitor prescribers on the target list. Quantifies the conversion opportunity pipeline for brand switching campaigns."
    - name: "do_not_contact_count"
      expr: COUNT(CASE WHEN do_not_contact_flag = TRUE THEN 1 END)
      comment: "Number of HCPs flagged as do-not-contact. Must be monitored to ensure field force compliance and avoid regulatory violations."
    - name: "sample_eligible_hcp_count"
      expr: COUNT(CASE WHEN is_sample_eligible = TRUE THEN 1 END)
      comment: "Number of HCPs eligible to receive samples. Determines the addressable universe for sampling programs and PDMA compliance scope."
    - name: "avg_face_to_face_call_mix_pct"
      expr: AVG(CAST(call_type_mix_pct_f2f AS DOUBLE))
      comment: "Average planned face-to-face call mix percentage across targets. Informs channel strategy and field force deployment model decisions."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_mlr_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical-Legal-Regulatory (MLR) review cycle metrics tracking submission volumes, approval rates, review cycle times, and compliance status. Governs promotional material quality and regulatory risk management."
  source: "`pharmaceuticals_ecm`.`commercial`.`mlr_review`"
  dimensions:
    - name: "submission_date"
      expr: submission_date
      comment: "Date the promotional material was submitted for MLR review. Primary time dimension for review pipeline and backlog analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current overall review status (e.g., Pending, Approved, Rejected, Withdrawn). Primary filter for pipeline management."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final approval decision on the MLR submission. Tracks approval rates and rejection patterns for process improvement."
    - name: "medical_review_status"
      expr: medical_review_status
      comment: "Status of the medical review component. Bottleneck analysis for review cycle time optimization."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Status of the legal review component. Identifies legal review as a cycle time bottleneck."
    - name: "regulatory_review_status"
      expr: regulatory_review_status
      comment: "Status of the regulatory review component. Regulatory rejections have the highest remediation cost and timeline impact."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the promotional material (e.g., Digital, Print, Sales Aid). Enables channel-level compliance analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority governing the submission (e.g., FDA, EMA). Required for jurisdiction-specific compliance reporting."
    - name: "phrama_code_compliant"
      expr: phrama_code_compliant
      comment: "Indicates PhRMA code compliance of the promotional material. Non-compliant materials must be withdrawn immediately."
    - name: "sunshine_act_applicable"
      expr: sunshine_act_applicable
      comment: "Indicates whether the material has Sunshine Act implications. Drives transparency reporting obligations."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total MLR review submissions. Measures promotional material pipeline volume and review team workload."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN approval_decision = 'Approved' THEN 1 END)
      comment: "Count of approved MLR submissions. Numerator for approval rate calculation; low approval rates signal content quality issues."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN approval_decision = 'Rejected' THEN 1 END)
      comment: "Count of rejected MLR submissions. High rejection rates indicate systemic content quality or compliance gaps requiring process intervention."
    - name: "non_compliant_material_count"
      expr: COUNT(CASE WHEN phrama_code_compliant = FALSE THEN 1 END)
      comment: "Count of promotional materials flagged as non-compliant with PhRMA code. Any non-zero value requires immediate escalation and withdrawal."
    - name: "fair_balance_verified_count"
      expr: COUNT(CASE WHEN fair_balance_verified = TRUE THEN 1 END)
      comment: "Count of submissions with verified fair balance. Fair balance verification is an FDA regulatory requirement for all promotional materials."
    - name: "sunshine_act_applicable_count"
      expr: COUNT(CASE WHEN sunshine_act_applicable = TRUE THEN 1 END)
      comment: "Count of MLR submissions with Sunshine Act applicability. Drives Open Payments reporting scope and compliance filing requirements."
    - name: "unique_brands_under_review"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with active MLR submissions. Measures breadth of promotional activity requiring compliance oversight."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_psp_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient Support Program enrollment and benefit utilization metrics tracking patient access, benefit consumption, and program adherence. Measures patient affordability program effectiveness and financial exposure."
  source: "`pharmaceuticals_ecm`.`commercial`.`psp_enrollment`"
  dimensions:
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the patient enrolled in the support program. Primary time dimension for enrollment trend and cohort analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g., Active, Inactive, Completed, Withdrawn). Used to segment active vs. historical program participants."
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit provided (e.g., Copay Assistance, Free Drug, Nurse Support). Enables benefit mix analysis and cost allocation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the patient enrolled (e.g., HCP Office, Online, Phone). Informs channel optimization for enrollment efficiency."
    - name: "eligibility_verification_status"
      expr: eligibility_verification_status
      comment: "Status of eligibility verification for the enrollment. Unverified enrollments represent financial risk and compliance exposure."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the enrolled patient. Enables cross-TA program cost and utilization benchmarking."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Indicates whether patient consent was obtained. HIPAA compliance requirement; enrollments without consent must be remediated."
    - name: "transparency_reporting_required"
      expr: transparency_reporting_required
      comment: "Indicates whether the enrollment requires transparency reporting. Drives regulatory filing obligations."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total patient support program enrollments. Primary volume metric for program reach and patient access effectiveness."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of currently active enrollments. Measures live program participation and ongoing financial liability."
    - name: "total_max_benefit_amount"
      expr: SUM(CAST(max_benefit_amount AS DOUBLE))
      comment: "Total maximum benefit amount committed across all enrollments. Measures total program financial exposure for budget accrual."
    - name: "total_remaining_benefit_amount"
      expr: SUM(CAST(remaining_benefit_amount AS DOUBLE))
      comment: "Total remaining benefit amount not yet utilized. Indicates unutilized program capacity and potential budget release."
    - name: "avg_max_benefit_per_enrollment"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit per enrolled patient. Benchmarks program generosity and guides benefit cap calibration decisions."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END)
      comment: "Count of enrollments with confirmed patient consent. HIPAA compliance metric; gap between total and consent count drives remediation priority."
    - name: "unique_patients_enrolled"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of distinct patients enrolled in support programs. Measures unduplicated patient reach for program impact reporting."
    - name: "unique_prescribers_referring"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs whose patients are enrolled. Indicates HCP adoption of patient support programs and prescribing confidence."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_sample_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample inventory and distribution compliance metrics tracking sample disbursement, reconciliation status, PDMA compliance, and Sunshine Act reportability. Supports regulatory compliance and field force accountability."
  source: "`pharmaceuticals_ecm`.`commercial`.`sample_management`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the sample transaction. Primary time dimension for sample activity trending and reconciliation period analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of sample transaction (e.g., Disbursement, Receipt, Adjustment, Return). Enables transaction-level inventory flow analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status of the sample lot (e.g., Available, Expired, Quarantined). Drives sample availability and compliance decisions."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the sample record (e.g., Reconciled, Discrepant, Pending). Unreconciled records represent PDMA compliance risk."
    - name: "pdma_compliant"
      expr: pdma_compliant
      comment: "Indicates PDMA (Prescription Drug Marketing Act) compliance for the sample transaction. Non-compliant transactions require immediate investigation."
    - name: "sunshine_act_reportable"
      expr: sunshine_act_reportable
      comment: "Indicates whether the sample transaction is reportable under the Sunshine Act. Drives Open Payments filing completeness."
    - name: "hcp_signature_captured"
      expr: hcp_signature_captured
      comment: "Indicates whether HCP signature was captured for the sample. PDMA requires HCP signature for all sample disbursements."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the sampled product. Enables cross-TA sample program cost and compliance analysis."
    - name: "sample_form_type"
      expr: sample_form_type
      comment: "Type of sample request form used. Supports PDMA documentation compliance tracking."
  measures:
    - name: "total_sample_transactions"
      expr: COUNT(1)
      comment: "Total sample management transactions. Baseline activity volume for PDMA compliance audit scope."
    - name: "pdma_non_compliant_count"
      expr: COUNT(CASE WHEN pdma_compliant = FALSE THEN 1 END)
      comment: "Count of PDMA non-compliant sample transactions. Any non-zero value triggers regulatory investigation and corrective action."
    - name: "missing_signature_count"
      expr: COUNT(CASE WHEN hcp_signature_captured = FALSE THEN 1 END)
      comment: "Count of sample disbursements without HCP signature. PDMA violation risk; drives field force compliance coaching."
    - name: "sunshine_act_reportable_sample_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable = TRUE THEN 1 END)
      comment: "Count of sample transactions requiring Sunshine Act reporting. Drives Open Payments filing completeness and aggregate spend accuracy."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Count of unreconciled sample transactions. Elevated unreconciled counts indicate inventory control failures and PDMA audit risk."
    - name: "unique_hcps_sampled"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs who received samples. Measures sampling program reach and correlates with prescription generation."
$$;
