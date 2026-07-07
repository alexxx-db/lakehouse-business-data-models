-- Metric views for domain: pharmacy | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims financial and utilization metrics. Tracks drug spend, member cost-sharing, plan liability, dispensing patterns, and specialty/generic drug economics at the claim line level. Primary KPI surface for pharmacy cost management and benefit performance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  filter: is_active = TRUE AND line_status NOT IN ('VOID', 'REVERSED')
  dimensions:
    - name: "dispensed_month"
      expr: DATE_TRUNC('MONTH', dispensed_date)
      comment: "Calendar month of drug dispensing — primary time axis for trend analysis and period-over-period comparisons."
    - name: "dispensed_year"
      expr: YEAR(dispensed_date)
      comment: "Calendar year of drug dispensing — used for annual budget vs. actuals and year-over-year benchmarking."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail-order, specialty) — key dimension for channel mix analysis and mail-order penetration tracking."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug — drives cost-sharing analysis and tier utilization mix reporting."
    - name: "drug_coverage_status"
      expr: drug_coverage_status
      comment: "Coverage status of the drug at time of dispensing — used to segment covered vs. non-covered utilization."
    - name: "generic_indicator"
      expr: CASE WHEN generic_indicator = TRUE THEN 'Generic' ELSE 'Brand' END
      comment: "Generic vs. brand drug flag — critical dimension for generic dispensing rate and cost-savings analysis."
    - name: "specialty_drug_indicator"
      expr: CASE WHEN specialty_drug_indicator = TRUE THEN 'Specialty' ELSE 'Non-Specialty' END
      comment: "Specialty drug flag — specialty drugs represent disproportionate cost and require separate trend monitoring."
    - name: "compound_indicator"
      expr: CASE WHEN compound_indicator = TRUE THEN 'Compound' ELSE 'Non-Compound' END
      comment: "Compound drug flag — compound claims carry elevated fraud/waste/abuse risk and require dedicated oversight."
    - name: "coverage_gap_indicator"
      expr: CASE WHEN coverage_gap_indicator = TRUE THEN 'In Coverage Gap' ELSE 'Not In Coverage Gap' END
      comment: "Medicare Part D coverage gap (donut hole) indicator — used for Part D benefit phase cost analysis."
    - name: "low_income_subsidy_indicator"
      expr: CASE WHEN low_income_subsidy_indicator = TRUE THEN 'LIS' ELSE 'Non-LIS' END
      comment: "Low Income Subsidy (LIS/Extra Help) indicator — required for CMS Part D reporting and equity analysis."
    - name: "catastrophic_coverage_indicator"
      expr: CASE WHEN catastrophic_coverage_indicator = TRUE THEN 'Catastrophic' ELSE 'Non-Catastrophic' END
      comment: "Catastrophic coverage phase indicator — identifies high-cost members in the catastrophic benefit phase."
    - name: "line_type"
      expr: line_type
      comment: "Claim line type classification — used to segment original fills, refills, and reversals."
    - name: "basis_of_cost_determination"
      expr: basis_of_cost_determination
      comment: "Basis used to determine ingredient cost (AWP, MAC, WAC, etc.) — informs pricing methodology analysis."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code — enables drug-level cost and utilization drill-down."
    - name: "step_therapy_indicator"
      expr: CASE WHEN step_therapy_indicator = TRUE THEN 'Step Therapy Required' ELSE 'No Step Therapy' END
      comment: "Step therapy flag — tracks adherence to step therapy protocols and associated cost avoidance."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of pharmacy claim lines processed — baseline volume metric for utilization trend monitoring."
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost (ingredient cost + dispensing fee before rebates) — primary pharmacy spend KPI for budget management and PBM contract performance."
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan after member cost-sharing — net plan liability and key driver of medical loss ratio."
    - name: "total_patient_pay_amount"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total out-of-pocket cost borne by members — tracks member affordability and cost-sharing burden."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost component of pharmacy claims — used to evaluate PBM pricing performance against AWP/MAC benchmarks."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies — benchmarked against PBM contract dispensing fee guarantees."
    - name: "total_true_oop_amount"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total true out-of-pocket spend (CMS Part D TrOOP) — required for Medicare Part D benefit phase tracking and CMS regulatory reporting."
    - name: "total_manufacturer_discount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied at point of sale — tracks coverage gap discount program value and ACA compliance."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts applied to claims — measures impact of member incentive programs on pharmacy spend."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax collected on pharmacy claims — required for state tax compliance and cost reporting."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total drug quantity dispensed across all claim lines — used for utilization management and drug supply analysis."
    - name: "avg_gross_drug_cost_per_claim"
      expr: AVG(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Average gross drug cost per claim line — benchmarks unit cost trends and identifies cost outliers by drug or channel."
    - name: "avg_patient_pay_per_claim"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average member out-of-pocket cost per claim — monitors member affordability and cost-sharing design effectiveness."
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan-paid amount per claim line — tracks plan cost per dispensing event across channels and tiers."
    - name: "generic_claim_lines"
      expr: COUNT(CASE WHEN generic_indicator = TRUE THEN 1 END)
      comment: "Count of generic drug claim lines — numerator for generic dispensing rate calculation."
    - name: "specialty_drug_claim_lines"
      expr: COUNT(CASE WHEN specialty_drug_indicator = TRUE THEN 1 END)
      comment: "Count of specialty drug claim lines — specialty drugs typically represent 50%+ of pharmacy spend despite low volume."
    - name: "specialty_drug_total_cost"
      expr: SUM(CASE WHEN specialty_drug_indicator = TRUE THEN CAST(gross_drug_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross drug cost attributable to specialty drugs — critical KPI for specialty pharmacy cost management and trend."
    - name: "mail_order_claim_lines"
      expr: COUNT(CASE WHEN pharmacy_channel = 'MAIL' THEN 1 END)
      comment: "Count of mail-order claim lines — numerator for mail-order penetration rate, a key PBM contract performance guarantee."
    - name: "distinct_members_with_claims"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of distinct members with at least one pharmacy claim — measures pharmacy benefit utilization breadth."
    - name: "distinct_drugs_dispensed"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs dispensed — tracks formulary utilization breadth and off-formulary exposure."
    - name: "coverage_gap_claim_lines"
      expr: COUNT(CASE WHEN coverage_gap_indicator = TRUE THEN 1 END)
      comment: "Count of claims in the Medicare Part D coverage gap phase — required for CMS Part D benefit phase reporting."
    - name: "coverage_gap_total_cost"
      expr: SUM(CASE WHEN coverage_gap_indicator = TRUE THEN CAST(gross_drug_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total drug cost incurred during the coverage gap phase — informs Part D benefit design and member communication strategy."
    - name: "prior_auth_claim_lines"
      expr: COUNT(CASE WHEN prior_authorization_id IS NOT NULL THEN 1 END)
      comment: "Count of claim lines requiring prior authorization — measures PA program scope and administrative burden."
    - name: "quantity_limit_claim_lines"
      expr: COUNT(CASE WHEN quantity_limit_indicator = TRUE THEN 1 END)
      comment: "Count of claim lines subject to quantity limits — tracks quantity limit program utilization and clinical appropriateness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy prior authorization (PA) operational and outcome metrics. Tracks PA request volumes, approval/denial rates, turnaround times, and specialty drug PA patterns. Critical for regulatory compliance (CMS timeliness standards), member access, and utilization management effectiveness."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  filter: is_active = TRUE
  dimensions:
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Calendar month of PA request — primary time axis for PA volume trend and timeliness reporting."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Calendar year of PA request — used for annual PA program performance review."
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the PA request (Approved, Denied, Pending, Withdrawn) — primary outcome dimension."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of PA request (new, renewal, appeal) — used to segment workload and outcome analysis."
    - name: "request_type"
      expr: request_type
      comment: "Request type classification — distinguishes standard vs. expedited requests for timeliness compliance."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel associated with the PA (retail, mail, specialty) — used for channel-level PA burden analysis."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the drug requiring PA — identifies tier-level PA burden and formulary design opportunities."
    - name: "lob"
      expr: lob
      comment: "Line of business (Commercial, Medicare, Medicaid) — required for LOB-level PA compliance and reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for PA denial — identifies top denial drivers for clinical criteria review and member appeal patterns."
    - name: "review_level"
      expr: review_level
      comment: "Level of clinical review applied (standard, peer-to-peer, medical director) — tracks escalation patterns."
    - name: "specialty_drug_flag"
      expr: CASE WHEN specialty_drug_flag = TRUE THEN 'Specialty' ELSE 'Non-Specialty' END
      comment: "Specialty drug PA flag — specialty PAs require dedicated tracking due to cost and clinical complexity."
    - name: "appeal_indicator"
      expr: CASE WHEN appeal_indicator = TRUE THEN 'Appeal' ELSE 'Initial Request' END
      comment: "Indicates whether the PA is an appeal of a prior denial — tracks appeal volume and overturn rates."
    - name: "criteria_met"
      expr: CASE WHEN criteria_met = TRUE THEN 'Criteria Met' ELSE 'Criteria Not Met' END
      comment: "Whether clinical criteria were met for the PA — primary clinical outcome dimension."
    - name: "step_therapy_required"
      expr: CASE WHEN step_therapy_required = TRUE THEN 'Step Therapy Required' ELSE 'No Step Therapy' END
      comment: "Step therapy requirement flag — tracks step therapy program scope and compliance."
    - name: "cms_part_d_reportable"
      expr: CASE WHEN cms_part_d_reportable = TRUE THEN 'CMS Reportable' ELSE 'Non-Reportable' END
      comment: "CMS Part D reportability flag — identifies PAs subject to CMS coverage determination timeliness requirements."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of pharmacy PA requests — baseline volume metric for PA program workload and staffing."
    - name: "approved_pa_requests"
      expr: COUNT(CASE WHEN pa_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved PA requests — numerator for PA approval rate calculation."
    - name: "denied_pa_requests"
      expr: COUNT(CASE WHEN pa_status = 'DENIED' THEN 1 END)
      comment: "Count of denied PA requests — numerator for PA denial rate; high denial rates may indicate formulary or criteria issues."
    - name: "appeal_pa_requests"
      expr: COUNT(CASE WHEN appeal_indicator = TRUE THEN 1 END)
      comment: "Count of PA requests that are appeals — tracks appeal volume as a signal of member/provider dissatisfaction."
    - name: "specialty_drug_pa_requests"
      expr: COUNT(CASE WHEN specialty_drug_flag = TRUE THEN 1 END)
      comment: "Count of PA requests for specialty drugs — specialty PA volume drives disproportionate cost and clinical review burden."
    - name: "criteria_met_requests"
      expr: COUNT(CASE WHEN criteria_met = TRUE THEN 1 END)
      comment: "Count of PA requests where clinical criteria were met — measures clinical appropriateness of PA program."
    - name: "step_therapy_completed_requests"
      expr: COUNT(CASE WHEN step_therapy_completed = TRUE THEN 1 END)
      comment: "Count of PAs where step therapy was completed prior to request — measures step therapy protocol adherence."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total drug quantity approved across all PA decisions — used for supply planning and utilization forecasting."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total drug quantity requested across all PA submissions — compared to approved quantity to measure restriction impact."
    - name: "avg_approved_quantity"
      expr: AVG(CAST(approved_quantity AS DOUBLE))
      comment: "Average approved drug quantity per PA — benchmarks approval generosity and clinical appropriateness."
    - name: "distinct_members_with_pa"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members with at least one PA request — measures PA program member reach and access burden."
    - name: "distinct_drugs_requiring_pa"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs requiring PA — tracks formulary PA coverage breadth and potential access barriers."
    - name: "cms_reportable_pa_requests"
      expr: COUNT(CASE WHEN cms_part_d_reportable = TRUE THEN 1 END)
      comment: "Count of CMS Part D reportable PA requests — required for CMS coverage determination timeliness compliance reporting."
    - name: "quantity_limit_applied_requests"
      expr: COUNT(CASE WHEN quantity_limit_applied = TRUE THEN 1 END)
      comment: "Count of PA requests where quantity limits were applied — tracks quantity limit program utilization and member impact."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary drug tier composition and cost-sharing structure metrics. Tracks formulary coverage breadth, tier distribution, cost-sharing design, and prior authorization/step therapy requirements. Used by pharmacy benefit design teams to optimize formulary strategy and ensure regulatory compliance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`"
  filter: is_active = TRUE
  dimensions:
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Plan year of formulary tier assignment — used for year-over-year formulary design comparison."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year associated with the formulary tier — aligns formulary analysis to plan year cycles."
    - name: "tier_name"
      expr: tier_name
      comment: "Formulary tier name (e.g., Tier 1 Generic, Tier 2 Preferred Brand) — primary dimension for tier mix and cost-sharing analysis."
    - name: "tier_number"
      expr: tier_number
      comment: "Numeric tier identifier — enables ordered tier analysis and tier migration tracking."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Drug coverage status on the formulary (covered, non-covered, restricted) — tracks formulary access."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for the tier assignment (retail, mail, specialty) — used for channel-specific cost-sharing analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code — required for LOB-level formulary design and compliance analysis."
    - name: "prior_auth_required"
      expr: CASE WHEN prior_auth_required = TRUE THEN 'PA Required' ELSE 'No PA' END
      comment: "Prior authorization requirement flag — identifies drugs with PA requirements for access and administrative burden analysis."
    - name: "step_therapy_required"
      expr: CASE WHEN step_therapy_required = TRUE THEN 'Step Therapy Required' ELSE 'No Step Therapy' END
      comment: "Step therapy requirement flag — tracks step therapy program scope across formulary tiers."
    - name: "quantity_limit_required"
      expr: CASE WHEN quantity_limit_required = TRUE THEN 'QL Required' ELSE 'No QL' END
      comment: "Quantity limit requirement flag — identifies drugs with quantity restrictions for utilization management analysis."
    - name: "specialty_drug_flag"
      expr: CASE WHEN specialty_drug_flag = TRUE THEN 'Specialty' ELSE 'Non-Specialty' END
      comment: "Specialty drug flag on formulary tier — used to analyze specialty tier composition and cost-sharing design."
    - name: "deductible_applies"
      expr: CASE WHEN deductible_applies = TRUE THEN 'Deductible Applies' ELSE 'No Deductible' END
      comment: "Whether the deductible applies before cost-sharing — critical for benefit design and member cost modeling."
    - name: "mac_pricing_applicable"
      expr: CASE WHEN mac_pricing_applicable = TRUE THEN 'MAC Pricing' ELSE 'Non-MAC' END
      comment: "MAC pricing applicability flag — identifies drugs subject to maximum allowable cost pricing."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization required — distinguishes clinical PA types for formulary management."
  measures:
    - name: "total_formulary_drug_tier_entries"
      expr: COUNT(1)
      comment: "Total number of formulary drug tier assignments — baseline measure of formulary coverage breadth."
    - name: "distinct_drugs_on_formulary"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs covered on the formulary — measures formulary breadth and member access to medications."
    - name: "drugs_requiring_prior_auth"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN 1 END)
      comment: "Count of formulary drug tier entries requiring prior authorization — measures PA program scope and potential access barriers."
    - name: "drugs_requiring_step_therapy"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN 1 END)
      comment: "Count of formulary drug tier entries requiring step therapy — measures step therapy program breadth."
    - name: "drugs_requiring_quantity_limit"
      expr: COUNT(CASE WHEN quantity_limit_required = TRUE THEN 1 END)
      comment: "Count of formulary drug tier entries with quantity limits — measures quantity limit program scope."
    - name: "specialty_drug_tier_entries"
      expr: COUNT(CASE WHEN specialty_drug_flag = TRUE THEN 1 END)
      comment: "Count of specialty drug formulary tier entries — tracks specialty formulary coverage and tier placement."
    - name: "avg_copay_retail_30"
      expr: AVG(CAST(copay_retail_30 AS DOUBLE))
      comment: "Average retail 30-day copay across formulary tier entries — benchmarks member cost-sharing burden at retail."
    - name: "avg_copay_retail_90"
      expr: AVG(CAST(copay_retail_90 AS DOUBLE))
      comment: "Average retail 90-day copay across formulary tier entries — benchmarks extended supply cost-sharing design."
    - name: "avg_copay_mail_order"
      expr: AVG(CAST(copay_mail_order AS DOUBLE))
      comment: "Average mail-order copay across formulary tier entries — used to evaluate mail-order cost incentive design."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate across formulary tier entries — measures member cost-sharing percentage design."
    - name: "avg_quantity_limit_max"
      expr: AVG(CAST(ql_max_quantity AS DOUBLE))
      comment: "Average maximum quantity limit across formulary entries with QL — benchmarks quantity restriction stringency."
    - name: "distinct_formularies_covered"
      expr: COUNT(DISTINCT formulary_id)
      comment: "Count of distinct formularies represented — used for multi-formulary portfolio management."
    - name: "deductible_applicable_entries"
      expr: COUNT(CASE WHEN deductible_applies = TRUE THEN 1 END)
      comment: "Count of formulary tier entries where deductible applies — measures deductible exposure in benefit design."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary exception request outcome and timeliness metrics. Tracks exception request volumes, approval/denial rates, expedited request handling, and CMS coverage determination compliance. Critical for regulatory compliance, member access, and formulary design feedback."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`"
  filter: is_active = TRUE
  dimensions:
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Calendar month of exception request — primary time axis for exception volume trend and timeliness reporting."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Calendar year of exception request — used for annual exception program performance review."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the formulary exception (Approved, Denied, Pending, Withdrawn) — primary outcome dimension."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of formulary exception (tier exception, non-formulary exception, etc.) — used to segment exception workload."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid) — required for LOB-level exception compliance reporting."
    - name: "is_expedited"
      expr: CASE WHEN is_expedited = TRUE THEN 'Expedited' ELSE 'Standard' END
      comment: "Expedited request flag — CMS requires faster turnaround for expedited requests; critical for compliance monitoring."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for exception denial — identifies top denial drivers for formulary design improvement."
    - name: "requestor_type"
      expr: requestor_type
      comment: "Who submitted the exception request (member, prescriber, plan) — used for channel analysis and process improvement."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the exception was submitted (phone, portal, fax) — used for digital adoption and efficiency analysis."
    - name: "review_level"
      expr: review_level
      comment: "Level of review applied to the exception — tracks escalation patterns and clinical review burden."
    - name: "cms_coverage_determination_type"
      expr: cms_coverage_determination_type
      comment: "CMS coverage determination type — required for Part D coverage determination regulatory reporting."
    - name: "appeal_rights_notified"
      expr: CASE WHEN appeal_rights_notified = TRUE THEN 'Notified' ELSE 'Not Notified' END
      comment: "Whether member was notified of appeal rights — CMS regulatory requirement; non-compliance carries significant penalty risk."
    - name: "supporting_doc_received"
      expr: CASE WHEN supporting_doc_received = TRUE THEN 'Docs Received' ELSE 'Docs Pending' END
      comment: "Whether supporting clinical documentation was received — tracks documentation completeness and processing delays."
    - name: "current_drug_tier"
      expr: current_drug_tier
      comment: "Current formulary tier of the drug being excepted — identifies which tiers generate the most exception activity."
    - name: "requested_drug_tier"
      expr: requested_drug_tier
      comment: "Requested formulary tier for the exception — shows member/prescriber tier preference patterns."
  measures:
    - name: "total_exception_requests"
      expr: COUNT(1)
      comment: "Total number of formulary exception requests — baseline volume metric for exception program workload."
    - name: "approved_exception_requests"
      expr: COUNT(CASE WHEN exception_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved formulary exception requests — numerator for exception approval rate."
    - name: "denied_exception_requests"
      expr: COUNT(CASE WHEN exception_status = 'DENIED' THEN 1 END)
      comment: "Count of denied formulary exception requests — high denial rates may signal formulary access issues."
    - name: "expedited_exception_requests"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Count of expedited formulary exception requests — CMS requires 24-hour turnaround; volume drives compliance risk."
    - name: "appeal_rights_notified_count"
      expr: COUNT(CASE WHEN appeal_rights_notified = TRUE THEN 1 END)
      comment: "Count of exceptions where member was notified of appeal rights — CMS compliance metric; 100% target required."
    - name: "supporting_docs_received_count"
      expr: COUNT(CASE WHEN supporting_doc_received = TRUE THEN 1 END)
      comment: "Count of exceptions with supporting documentation received — tracks documentation completeness rate."
    - name: "distinct_members_with_exceptions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members filing formulary exceptions — measures member access barrier breadth."
    - name: "distinct_drugs_excepted"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs subject to exception requests — identifies drugs with formulary placement issues."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total drug quantity requested via formulary exceptions — used for supply planning and exception impact assessment."
    - name: "avg_quantity_requested"
      expr: AVG(CAST(quantity_requested AS DOUBLE))
      comment: "Average drug quantity requested per exception — benchmarks request scope and clinical appropriateness."
    - name: "cms_reportable_exceptions"
      expr: COUNT(CASE WHEN cms_coverage_determination_type IS NOT NULL THEN 1 END)
      comment: "Count of CMS-reportable coverage determination exceptions — required for Part D regulatory compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dispensing_pharmacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing pharmacy network composition, contract performance, and capability metrics. Tracks network adequacy, pharmacy type mix, mail-order capability, specialty accreditation, and contract terms. Used by network management and PBM oversight teams."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`"
  filter: is_active = TRUE
  dimensions:
    - name: "pharmacy_type"
      expr: pharmacy_type
      comment: "Type of dispensing pharmacy (retail, mail-order, specialty, long-term care) — primary dimension for network composition analysis."
    - name: "dispensing_state_code"
      expr: dispensing_state_code
      comment: "State where the pharmacy is licensed to dispense — used for geographic network adequacy analysis."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Current network participation status (in-network, out-of-network, terminated) — tracks network adequacy."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of pharmacy contract (preferred, standard, specialty) — used for contract tier analysis."
    - name: "chain_independent_flag"
      expr: chain_independent_flag
      comment: "Chain vs. independent pharmacy flag — used for network diversity and independent pharmacy access analysis."
    - name: "mail_order_capable"
      expr: CASE WHEN mail_order_capable = TRUE THEN 'Mail Order Capable' ELSE 'Retail Only' END
      comment: "Mail-order capability flag — used for mail-order network adequacy and penetration analysis."
    - name: "cold_chain_certified"
      expr: CASE WHEN cold_chain_certified = TRUE THEN 'Cold Chain Certified' ELSE 'Not Certified' END
      comment: "Cold chain certification flag — required for specialty biologics dispensing network adequacy."
    - name: "twenty_four_hour_flag"
      expr: CASE WHEN twenty_four_hour_flag = TRUE THEN '24-Hour' ELSE 'Standard Hours' END
      comment: "24-hour pharmacy availability flag — used for member access and network adequacy standards compliance."
    - name: "accepts_electronic_prescriptions"
      expr: CASE WHEN accepts_electronic_prescriptions = TRUE THEN 'e-Prescribing' ELSE 'Paper Only' END
      comment: "Electronic prescription acceptance flag — tracks e-prescribing adoption and operational efficiency."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by the pharmacy — used for LOB-level network adequacy analysis."
    - name: "ingredient_cost_basis"
      expr: ingredient_cost_basis
      comment: "Basis for ingredient cost calculation (AWP, MAC, WAC) — used for pricing methodology analysis."
    - name: "specialty_accreditation_code"
      expr: specialty_accreditation_code
      comment: "Specialty pharmacy accreditation code (URAC, ACHC, etc.) — required for specialty network credentialing compliance."
    - name: "contract_effective_month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
      comment: "Month of contract effective date — used for contract cohort analysis and renewal planning."
  measures:
    - name: "total_network_pharmacies"
      expr: COUNT(1)
      comment: "Total number of active dispensing pharmacies in the network — primary network adequacy metric."
    - name: "mail_order_capable_pharmacies"
      expr: COUNT(CASE WHEN mail_order_capable = TRUE THEN 1 END)
      comment: "Count of mail-order capable pharmacies — used for mail-order network adequacy and penetration strategy."
    - name: "cold_chain_certified_pharmacies"
      expr: COUNT(CASE WHEN cold_chain_certified = TRUE THEN 1 END)
      comment: "Count of cold-chain certified pharmacies — measures specialty biologics dispensing network capacity."
    - name: "twenty_four_hour_pharmacies"
      expr: COUNT(CASE WHEN twenty_four_hour_flag = TRUE THEN 1 END)
      comment: "Count of 24-hour pharmacies in the network — measures member access to after-hours dispensing."
    - name: "e_prescribing_pharmacies"
      expr: COUNT(CASE WHEN accepts_electronic_prescriptions = TRUE THEN 1 END)
      comment: "Count of pharmacies accepting electronic prescriptions — tracks e-prescribing adoption and operational efficiency."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT dispensing_state_code)
      comment: "Count of distinct states with network pharmacy coverage — measures geographic network adequacy breadth."
    - name: "avg_awp_discount_percent"
      expr: AVG(CAST(awp_discount_percent AS DOUBLE))
      comment: "Average AWP discount percentage across network pharmacies — benchmarks pricing performance against PBM contract guarantees."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Average dispensing fee across network pharmacies — benchmarks dispensing fee levels against contract terms."
    - name: "performance_audit_pharmacies"
      expr: COUNT(CASE WHEN performance_audit_provision = TRUE THEN 1 END)
      comment: "Count of pharmacies with performance audit provisions in their contracts — measures audit program coverage."
    - name: "distinct_chain_organizations"
      expr: COUNT(DISTINCT chain_organization_name)
      comment: "Count of distinct chain pharmacy organizations in the network — measures network concentration and chain dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pbm_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PBM contract financial terms, performance guarantees, and rebate economics metrics. Tracks contract portfolio composition, rebate pass-through rates, dispensing fee guarantees, and generic dispensing rate commitments. Used by pharmacy finance and vendor management teams to oversee PBM performance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`"
  filter: is_active = TRUE
  dimensions:
    - name: "contract_effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of contract effective date — used for contract cohort and renewal cycle analysis."
    - name: "contract_effective_year"
      expr: YEAR(effective_date)
      comment: "Year of contract effective date — used for annual contract portfolio review."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of PBM contract (full-service, carve-out, specialty-only) — primary dimension for contract portfolio analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, pending renewal) — used for contract lifecycle management."
    - name: "lob_scope"
      expr: lob_scope
      comment: "Line of business scope covered by the contract — used for LOB-level PBM contract analysis."
    - name: "governing_state_code"
      expr: governing_state_code
      comment: "State law governing the contract — used for regulatory compliance and state-level contract analysis."
    - name: "ingredient_cost_basis"
      expr: ingredient_cost_basis
      comment: "Ingredient cost basis methodology (AWP, MAC, WAC) — used for pricing methodology benchmarking."
    - name: "rebate_settlement_frequency"
      expr: rebate_settlement_frequency
      comment: "Frequency of rebate settlement (quarterly, semi-annual, annual) — used for cash flow planning."
    - name: "mail_order_flag"
      expr: CASE WHEN mail_order_flag = TRUE THEN 'Mail Order Included' ELSE 'Retail Only' END
      comment: "Mail-order inclusion flag — identifies contracts covering mail-order dispensing."
    - name: "specialty_pharmacy_flag"
      expr: CASE WHEN specialty_pharmacy_flag = TRUE THEN 'Specialty Included' ELSE 'No Specialty' END
      comment: "Specialty pharmacy inclusion flag — identifies contracts covering specialty drug dispensing."
    - name: "performance_guarantee_flag"
      expr: CASE WHEN performance_guarantee_flag = TRUE THEN 'Performance Guarantee' ELSE 'No Guarantee' END
      comment: "Performance guarantee flag — contracts with guarantees require active monitoring against committed metrics."
    - name: "prior_auth_flag"
      expr: CASE WHEN prior_auth_flag = TRUE THEN 'PA Program' ELSE 'No PA' END
      comment: "Prior authorization program flag — identifies contracts with PA management services."
    - name: "auto_renewal_flag"
      expr: CASE WHEN auto_renewal_flag = TRUE THEN 'Auto-Renewal' ELSE 'Manual Renewal' END
      comment: "Auto-renewal flag — contracts with auto-renewal require proactive notice management."
  measures:
    - name: "total_pbm_contracts"
      expr: COUNT(1)
      comment: "Total number of active PBM contracts — baseline measure for contract portfolio size."
    - name: "contracts_with_performance_guarantees"
      expr: COUNT(CASE WHEN performance_guarantee_flag = TRUE THEN 1 END)
      comment: "Count of contracts with performance guarantees — measures PBM accountability coverage across the portfolio."
    - name: "avg_rebate_guarantee_pmpm"
      expr: AVG(CAST(rebate_guarantee_pmpm AS DOUBLE))
      comment: "Average guaranteed rebate PMPM across PBM contracts — benchmarks rebate economics and negotiation outcomes."
    - name: "total_rebate_guarantee_pmpm"
      expr: SUM(CAST(rebate_guarantee_pmpm AS DOUBLE))
      comment: "Total guaranteed rebate PMPM across all contracts — measures total rebate commitment in the PBM portfolio."
    - name: "avg_rebate_pass_through_pct"
      expr: AVG(CAST(rebate_pass_through_pct AS DOUBLE))
      comment: "Average rebate pass-through percentage across contracts — measures how much of manufacturer rebates flow back to the plan."
    - name: "avg_awp_discount_retail_pct"
      expr: AVG(CAST(awp_discount_retail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for retail dispensing — benchmarks retail pricing performance across PBM contracts."
    - name: "avg_awp_discount_mail_pct"
      expr: AVG(CAST(awp_discount_mail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for mail-order dispensing — benchmarks mail-order pricing performance."
    - name: "avg_dispensing_fee_retail"
      expr: AVG(CAST(dispensing_fee_retail AS DOUBLE))
      comment: "Average retail dispensing fee across PBM contracts — benchmarks dispensing fee terms against market standards."
    - name: "avg_dispensing_fee_mail_order"
      expr: AVG(CAST(dispensing_fee_mail_order AS DOUBLE))
      comment: "Average mail-order dispensing fee across PBM contracts — benchmarks mail-order fee terms."
    - name: "avg_dispensing_fee_specialty"
      expr: AVG(CAST(dispensing_fee_specialty AS DOUBLE))
      comment: "Average specialty dispensing fee across PBM contracts — benchmarks specialty fee terms given high specialty drug costs."
    - name: "avg_generic_dispensing_rate_guarantee"
      expr: AVG(CAST(generic_dispensing_rate_guarantee AS DOUBLE))
      comment: "Average guaranteed generic dispensing rate across PBM contracts — measures PBM commitment to generic utilization."
    - name: "avg_mail_order_penetration_guarantee"
      expr: AVG(CAST(mail_order_penetration_guarantee AS DOUBLE))
      comment: "Average guaranteed mail-order penetration rate across contracts — measures PBM commitment to mail-order channel shift."
    - name: "auto_renewal_contracts"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of contracts with auto-renewal provisions — identifies contracts requiring proactive renewal notice management."
    - name: "distinct_formularies_under_contract"
      expr: COUNT(DISTINCT formulary_id)
      comment: "Count of distinct formularies managed under PBM contracts — measures formulary portfolio complexity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing benchmark and trend metrics. Tracks AWP, WAC, MAC, and RBP pricing levels, price change rates, and dispensing fee economics by drug, channel, and formulary tier. Used by pharmacy finance and PBM oversight teams to monitor drug cost trends and validate PBM pricing performance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  filter: is_active = TRUE
  dimensions:
    - name: "pricing_file_month"
      expr: DATE_TRUNC('MONTH', pricing_file_date)
      comment: "Month of pricing file — primary time axis for drug price trend analysis."
    - name: "pricing_file_year"
      expr: YEAR(pricing_file_date)
      comment: "Year of pricing file — used for annual drug price inflation analysis."
    - name: "price_type"
      expr: price_type
      comment: "Type of price (AWP, WAC, MAC, RBP, contract) — used to segment pricing analysis by methodology."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier associated with the pricing record — used for tier-level pricing analysis."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for the pricing record (retail, mail, specialty) — used for channel-level pricing benchmarking."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of the pricing data (Medi-Span, Red Book, Gold Standard) — used for pricing data quality and source analysis."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing record (active, expired, superseded) — used to filter current vs. historical pricing."
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source drug code (brand, generic, single-source) — used for generic vs. brand pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record — used for multi-currency pricing normalization."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule — used for controlled substance pricing trend monitoring."
    - name: "days_supply"
      expr: days_supply
      comment: "Days supply associated with the pricing record — used for days-supply-level pricing analysis."
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of active drug pricing records — baseline measure for pricing file completeness."
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average AWP (Average Wholesale Price) across pricing records — primary benchmark for drug cost trend monitoring."
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average WAC (Wholesale Acquisition Cost) across pricing records — manufacturer list price benchmark."
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average MAC (Maximum Allowable Cost) price — benchmarks generic drug pricing ceiling effectiveness."
    - name: "avg_rbp_price"
      expr: AVG(CAST(rbp_price AS DOUBLE))
      comment: "Average Reference-Based Pricing (RBP) price — used for RBP program performance and savings analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price — measures actual negotiated price levels across the drug portfolio."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee in pricing records — benchmarks dispensing fee levels against contract terms."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage — measures pricing discount depth achieved vs. AWP benchmark."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage from prior period — tracks drug price inflation trend across the formulary."
    - name: "avg_prior_unit_price"
      expr: AVG(CAST(prior_unit_price AS DOUBLE))
      comment: "Average prior period unit price — used with current unit price to calculate price change magnitude."
    - name: "distinct_drugs_priced"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs with active pricing records — measures pricing file coverage completeness."
    - name: "price_increases_count"
      expr: COUNT(CASE WHEN price_change_pct > 0 THEN 1 END)
      comment: "Count of drugs with price increases in the current pricing file — tracks drug price inflation breadth."
    - name: "price_decreases_count"
      expr: COUNT(CASE WHEN price_change_pct < 0 THEN 1 END)
      comment: "Count of drugs with price decreases — tracks generic entry and competitive pricing dynamics."
$$;