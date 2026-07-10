-- Metric views for domain: research | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_rd_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic R&D portfolio metrics tracking investment, pipeline health, and project delivery performance across all active research initiatives."
  source: "`vibe_consumer_goods_v1`.`research`.`rd_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the R&D project (e.g. Active, On Hold, Completed, Cancelled) — primary filter for portfolio health views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the R&D project type (e.g. Innovation, Renovation, Cost Reduction) — used to segment investment by strategic intent."
    - name: "stage_gate_phase"
      expr: stage_gate_phase
      comment: "Current stage-gate phase of the project — enables funnel analysis across the innovation pipeline."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier assigned to the project — used to weight portfolio investment decisions."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('MONTH', target_launch_date)
      comment: "Month of the planned product launch — enables launch pipeline forecasting by time horizon."
    - name: "actual_launch_date_month"
      expr: DATE_TRUNC('MONTH', actual_launch_date)
      comment: "Month of the actual product launch — used to compare planned vs. actual launch timing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which project budgets are denominated — required for multi-currency portfolio roll-ups."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway required for the project — used to assess regulatory complexity and resource needs."
  measures:
    - name: "total_rd_projects"
      expr: COUNT(1)
      comment: "Total number of R&D projects in the portfolio — baseline measure for pipeline size and capacity planning."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total R&D budget allocated across all projects — primary investment exposure metric for CFO and R&D leadership."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total R&D budget actually spent — used alongside budget_allocated to assess burn rate and financial control."
    - name: "avg_budget_allocated_per_project"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per R&D project — benchmarks investment intensity per initiative."
    - name: "avg_budget_spent_per_project"
      expr: AVG(CAST(budget_spent AS DOUBLE))
      comment: "Average budget spent per R&D project — used to track average cost-to-date per initiative."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across R&D projects — tracks ESG alignment of the innovation pipeline, a key board-level metric."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_cogs AS DOUBLE))
      comment: "Average target COGS across projects — proxy for margin ambition in the pipeline; lower COGS targets indicate higher margin potential."
    - name: "distinct_active_projects"
      expr: COUNT(DISTINCT CASE WHEN project_status = 'Active' THEN rd_project_id END)
      comment: "Count of currently active R&D projects — measures live pipeline depth for resource allocation decisions."
    - name: "projects_with_patent_filed"
      expr: COUNT(DISTINCT CASE WHEN patent_filing_status IS NOT NULL AND patent_filing_status != '' THEN rd_project_id END)
      comment: "Number of R&D projects with a patent filing status recorded — indicates IP generation rate from the innovation pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_claim_substantiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim substantiation pipeline metrics tracking approval rates, renewal compliance, statistical confidence, and cost efficiency of product claim validation."
  source: "`vibe_consumer_goods_v1`.`research`.`claim_substantiation`"
  dimensions:
    - name: "claim_approval_status"
      expr: claim_approval_status
      comment: "Current approval status of the claim (e.g. Approved, Pending, Rejected) — primary dimension for claim pipeline health."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of product claim (e.g. Efficacy, Safety, Environmental) — used to segment substantiation workload by claim category."
    - name: "claim_category"
      expr: claim_category
      comment: "Business category of the claim — enables portfolio analysis by claim domain."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the claim — critical for compliance reporting and market launch readiness."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the claim — tracks legal clearance pipeline for advertising compliance."
    - name: "substantiation_method"
      expr: substantiation_method
      comment: "Method used to substantiate the claim (e.g. Clinical Study, Consumer Test, Expert Panel) — used to assess evidence quality mix."
    - name: "claim_effective_date_month"
      expr: DATE_TRUNC('MONTH', claim_effective_date)
      comment: "Month the claim became effective — enables trend analysis of claim approvals over time."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the claim requires periodic renewal — used to identify claims at risk of lapsing."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim substantiation records — baseline measure for substantiation workload."
    - name: "approved_claims"
      expr: COUNT(DISTINCT CASE WHEN claim_approval_status = 'Approved' THEN claim_substantiation_id END)
      comment: "Number of claims with approved status — measures the productive output of the substantiation process."
    - name: "total_substantiation_cost"
      expr: SUM(CAST(substantiation_cost_amount AS DOUBLE))
      comment: "Total cost incurred for claim substantiation — key input for R&D cost management and budget planning."
    - name: "avg_substantiation_cost"
      expr: AVG(CAST(substantiation_cost_amount AS DOUBLE))
      comment: "Average cost per claim substantiation — benchmarks efficiency of the substantiation process."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level across substantiated claims — measures scientific rigor of the claims portfolio."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across claim substantiation studies — lower values indicate stronger statistical evidence supporting claims."
    - name: "statistically_significant_claims"
      expr: COUNT(DISTINCT CASE WHEN statistical_significance_flag = TRUE THEN claim_substantiation_id END)
      comment: "Number of claims backed by statistically significant evidence — measures the strength of the claims portfolio for regulatory and advertising purposes."
    - name: "claims_requiring_renewal"
      expr: COUNT(DISTINCT CASE WHEN renewal_required_flag = TRUE THEN claim_substantiation_id END)
      comment: "Number of claims requiring periodic renewal — drives renewal workload planning and compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_consumer_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer testing performance metrics tracking study outcomes, satisfaction scores, purchase intent, and statistical validity across product trials."
  source: "`vibe_consumer_goods_v1`.`research`.`consumer_test`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the consumer study (e.g. Planned, In Progress, Completed) — primary filter for active vs. completed test pipeline."
    - name: "study_type"
      expr: study_type
      comment: "Type of consumer study (e.g. Blind Test, In-Home Use Test, Focus Group) — used to segment results by methodology."
    - name: "study_design"
      expr: study_design
      comment: "Design of the study (e.g. Monadic, Sequential Monadic) — used to assess comparability of results across studies."
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Consumer segment targeted by the study — enables segmentation of test outcomes by consumer profile."
    - name: "test_geography"
      expr: test_geography
      comment: "Geographic market where the consumer test was conducted — used for regional performance benchmarking."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the consumer test — required for claim substantiation and dossier filing."
    - name: "test_start_date_month"
      expr: DATE_TRUNC('MONTH', test_start_date)
      comment: "Month the consumer test started — enables trend analysis of testing activity over time."
    - name: "ethics_committee_approval"
      expr: ethics_committee_approval
      comment: "Whether ethics committee approval was obtained — compliance gate for consumer research governance."
  measures:
    - name: "total_consumer_tests"
      expr: COUNT(1)
      comment: "Total number of consumer tests conducted — baseline measure for consumer research throughput."
    - name: "avg_overall_satisfaction_rating"
      expr: AVG(CAST(overall_satisfaction_rating AS DOUBLE))
      comment: "Average overall consumer satisfaction rating across tests — primary KPI for product acceptance and launch readiness."
    - name: "avg_efficacy_perception_rating"
      expr: AVG(CAST(efficacy_perception_rating AS DOUBLE))
      comment: "Average perceived efficacy rating from consumers — measures how well the product delivers on its claimed benefits."
    - name: "avg_skin_feel_rating"
      expr: AVG(CAST(skin_feel_rating AS DOUBLE))
      comment: "Average skin feel rating — key sensory attribute driving consumer preference in personal care categories."
    - name: "avg_fragrance_rating"
      expr: AVG(CAST(fragrance_rating AS DOUBLE))
      comment: "Average fragrance rating — critical sensory dimension for consumer acceptance in beauty and personal care."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across consumer tests — measures scientific rigor of consumer research."
    - name: "total_study_cost"
      expr: SUM(CAST(study_cost_amount AS DOUBLE))
      comment: "Total cost of consumer studies — key input for R&D budget management and cost-per-insight analysis."
    - name: "avg_study_cost"
      expr: AVG(CAST(study_cost_amount AS DOUBLE))
      comment: "Average cost per consumer study — benchmarks research efficiency and informs future study budgeting."
    - name: "statistically_significant_tests"
      expr: COUNT(DISTINCT CASE WHEN statistical_significance_flag = TRUE THEN consumer_test_id END)
      comment: "Number of consumer tests with statistically significant results — measures the proportion of tests generating actionable evidence."
    - name: "adverse_event_tests"
      expr: COUNT(DISTINCT CASE WHEN adverse_event_reported = TRUE THEN consumer_test_id END)
      comment: "Number of consumer tests with at least one adverse event reported — critical safety signal for product development risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_safety_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product safety assessment metrics tracking assessment completion, margin of safety, regulatory compliance, and toxicological risk across the formulation portfolio."
  source: "`vibe_consumer_goods_v1`.`research`.`safety_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the safety assessment (e.g. In Progress, Completed, Approved) — primary filter for compliance pipeline."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of safety assessment (e.g. Cosmetic Safety Report, Toxicological Review) — used to segment workload by assessment category."
    - name: "regulatory_market_scope"
      expr: regulatory_market_scope
      comment: "Geographic market scope of the safety assessment — used to track regulatory coverage by region."
    - name: "safety_conclusion"
      expr: safety_conclusion
      comment: "Overall safety conclusion of the assessment (e.g. Safe, Conditionally Safe, Unsafe) — primary outcome dimension for risk management."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the safety assessment was conducted — enables trend analysis of safety review throughput."
    - name: "restricted_substances_compliance"
      expr: restricted_substances_compliance
      comment: "Whether the formulation complies with restricted substances regulations — critical compliance gate."
    - name: "cpnp_notification_required"
      expr: cpnp_notification_required
      comment: "Whether CPNP (EU Cosmetic Products Notification Portal) notification is required — tracks EU regulatory obligations."
  measures:
    - name: "total_safety_assessments"
      expr: COUNT(1)
      comment: "Total number of safety assessments conducted — baseline measure for regulatory compliance workload."
    - name: "avg_margin_of_safety"
      expr: AVG(CAST(margin_of_safety AS DOUBLE))
      comment: "Average margin of safety across assessed formulations — key toxicological KPI; values below threshold trigger reformulation."
    - name: "min_margin_of_safety"
      expr: MIN(CAST(margin_of_safety AS DOUBLE))
      comment: "Minimum margin of safety observed — identifies the highest-risk formulation in the portfolio requiring immediate attention."
    - name: "avg_noael_value"
      expr: AVG(CAST(noael_value AS DOUBLE))
      comment: "Average No Observed Adverse Effect Level (NOAEL) across assessments — measures the toxicological safety threshold of the formulation portfolio."
    - name: "avg_systemic_exposure_estimate"
      expr: AVG(CAST(systemic_exposure_estimate AS DOUBLE))
      comment: "Average systemic exposure estimate — used alongside NOAEL to calculate margin of safety and assess consumer risk."
    - name: "assessments_with_restricted_substance_findings"
      expr: COUNT(DISTINCT CASE WHEN restricted_substances_compliance = FALSE THEN safety_assessment_id END)
      comment: "Number of assessments identifying restricted substance non-compliance — critical regulatory risk signal requiring immediate remediation."
    - name: "assessments_requiring_cpnp_notification"
      expr: COUNT(DISTINCT CASE WHEN cpnp_notification_required = TRUE THEN safety_assessment_id END)
      comment: "Number of products requiring CPNP notification — tracks EU regulatory filing obligations and compliance workload."
    - name: "assessments_requiring_fda_registration"
      expr: COUNT(DISTINCT CASE WHEN fda_registration_required = TRUE THEN safety_assessment_id END)
      comment: "Number of products requiring FDA registration — tracks US regulatory filing obligations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory testing quality and throughput metrics tracking pass/fail rates, out-of-specification incidents, retest rates, and specification compliance across R&D lab operations."
  source: "`vibe_consumer_goods_v1`.`research`.`lab_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the lab test (e.g. Pending, In Progress, Completed) — primary filter for lab workload management."
    - name: "test_type"
      expr: test_type
      comment: "Type of lab test (e.g. Microbiological, Physical, Chemical) — used to segment quality results by test category."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the lab test — primary quality outcome dimension."
    - name: "test_method"
      expr: test_method
      comment: "Analytical method used for the test — used to assess method performance and standardization."
    - name: "test_priority"
      expr: test_priority
      comment: "Priority level of the test — used to manage lab scheduling and turnaround time targets."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the lab test was conducted — enables trend analysis of lab throughput and quality over time."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out-of-specification flag — identifies tests where results fell outside defined specification limits."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Whether the test was a retest — used to calculate retest rates as a quality process efficiency metric."
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total number of lab tests conducted — baseline measure for lab throughput and capacity utilization."
    - name: "oos_test_count"
      expr: COUNT(DISTINCT CASE WHEN oos_flag = TRUE THEN lab_test_id END)
      comment: "Number of out-of-specification test results — primary quality signal; high OOS rates indicate formulation or process instability."
    - name: "retest_count"
      expr: COUNT(DISTINCT CASE WHEN retest_flag = TRUE THEN lab_test_id END)
      comment: "Number of retests conducted — measures rework burden in the lab; high retest rates indicate quality or process issues."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured result value across lab tests — used to track central tendency of test outcomes against specification targets."
    - name: "avg_specification_target"
      expr: AVG(CAST(specification_target AS DOUBLE))
      comment: "Average specification target value — used as a reference baseline for evaluating result_value against intended quality standards."
    - name: "failed_tests"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'Fail' THEN lab_test_id END)
      comment: "Number of lab tests with a fail outcome — measures quality failure rate in the R&D testing pipeline."
    - name: "regulatory_flagged_tests"
      expr: COUNT(DISTINCT CASE WHEN regulatory_flag = TRUE THEN lab_test_id END)
      comment: "Number of lab tests flagged for regulatory significance — tracks tests that must be included in regulatory submissions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study portfolio metrics tracking study completion, shelf-life outcomes, GMP compliance, and regulatory submission readiness across the formulation stability program."
  source: "`vibe_consumer_goods_v1`.`research`.`research_stability_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the stability study (e.g. Ongoing, Completed, Discontinued) — primary filter for active stability program management."
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (e.g. Accelerated, Long-Term, Intermediate) — used to segment results by ICH study category."
    - name: "ich_condition"
      expr: ich_condition
      comment: "ICH storage condition applied in the study (e.g. 25°C/60%RH, 40°C/75%RH) — standard regulatory dimension for stability reporting."
    - name: "overall_stability_conclusion"
      expr: overall_stability_conclusion
      comment: "Overall conclusion of the stability study (e.g. Stable, Unstable, Conditionally Stable) — primary outcome dimension for shelf-life decisions."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the formulation under study — used to benchmark stability performance by category."
    - name: "study_start_date_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month the stability study started — enables trend analysis of stability program initiation over time."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Whether the study was conducted under GMP conditions — critical compliance dimension for regulatory submission eligibility."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether the study data is intended for regulatory submission — used to prioritize and track regulatory-grade stability work."
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total number of stability studies in the program — baseline measure for stability workload and portfolio coverage."
    - name: "gmp_compliant_studies"
      expr: COUNT(DISTINCT CASE WHEN gmp_compliant_flag = TRUE THEN research_stability_study_id END)
      comment: "Number of stability studies conducted under GMP — measures the proportion of regulatory-grade stability data available."
    - name: "regulatory_submission_studies"
      expr: COUNT(DISTINCT CASE WHEN regulatory_submission_flag = TRUE THEN research_stability_study_id END)
      comment: "Number of stability studies flagged for regulatory submission — tracks the pipeline of studies supporting dossier filings."
    - name: "completed_studies"
      expr: COUNT(DISTINCT CASE WHEN study_status = 'Completed' THEN research_stability_study_id END)
      comment: "Number of completed stability studies — measures productive output of the stability program."
    - name: "distinct_formulations_studied"
      expr: COUNT(DISTINCT product_formulation_id)
      comment: "Number of distinct formulations covered by stability studies — measures breadth of stability program coverage across the formulation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP portfolio metrics tracking patent filing activity, legal status, commercial value, and maintenance cost across the innovation pipeline."
  source: "`vibe_consumer_goods_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "legal_status"
      expr: legal_status
      comment: "Current legal status of the patent filing (e.g. Pending, Granted, Abandoned) — primary dimension for IP portfolio health."
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (e.g. Utility, Design, Process) — used to segment IP portfolio by protection category."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the patent is filed — used to assess geographic IP coverage and maintenance cost by market."
    - name: "commercial_value_tier"
      expr: commercial_value_tier
      comment: "Commercial value tier assigned to the patent — used to prioritize maintenance investment and licensing strategy."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the patent (e.g. Formulation, Packaging, Process) — used to segment IP by R&D capability area."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing status of the patent — used to track IP monetization and freedom-to-operate exposure."
    - name: "filing_date_year"
      expr: DATE_TRUNC('YEAR', filing_date)
      comment: "Year of patent filing — enables trend analysis of IP generation rate over time."
    - name: "pct_application_flag"
      expr: pct_application_flag
      comment: "Whether the filing is a PCT (Patent Cooperation Treaty) application — indicates international IP protection strategy."
  measures:
    - name: "total_patent_filings"
      expr: COUNT(1)
      comment: "Total number of patent filings — baseline measure for IP generation rate from the R&D pipeline."
    - name: "total_annual_maintenance_cost"
      expr: SUM(CAST(estimated_annual_maintenance_cost AS DOUBLE))
      comment: "Total estimated annual maintenance cost across all patent filings — key IP portfolio cost management metric."
    - name: "avg_annual_maintenance_cost"
      expr: AVG(CAST(estimated_annual_maintenance_cost AS DOUBLE))
      comment: "Average annual maintenance cost per patent filing — benchmarks IP maintenance efficiency by jurisdiction and technology domain."
    - name: "granted_patents"
      expr: COUNT(DISTINCT CASE WHEN legal_status = 'Granted' THEN patent_filing_id END)
      comment: "Number of granted patents — measures the productive IP output of the R&D program."
    - name: "pct_filings"
      expr: COUNT(DISTINCT CASE WHEN pct_application_flag = TRUE THEN patent_filing_id END)
      comment: "Number of PCT international patent applications — measures the breadth of international IP protection strategy."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions with patent filings — measures geographic breadth of IP protection."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_regulatory_dossier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission pipeline metrics tracking dossier status, approval timelines, compliance completeness, and market authorization progress."
  source: "`vibe_consumer_goods_v1`.`research`.`regulatory_dossier`"
  dimensions:
    - name: "dossier_status"
      expr: dossier_status
      comment: "Current status of the regulatory dossier (e.g. In Preparation, Submitted, Approved, Rejected) — primary filter for regulatory pipeline management."
    - name: "dossier_type"
      expr: dossier_type
      comment: "Type of regulatory dossier (e.g. CPNP, FDA, ASEAN) — used to segment regulatory workload by authority and market."
    - name: "regulatory_authority_name"
      expr: regulatory_authority_name
      comment: "Name of the regulatory authority receiving the dossier — used to track submission pipeline by regulatory body."
    - name: "target_market_country_code"
      expr: target_market_country_code
      comment: "Country code of the target market — enables geographic analysis of regulatory approval pipeline."
    - name: "safety_assessment_status"
      expr: safety_assessment_status
      comment: "Status of the safety assessment supporting the dossier — tracks a critical dependency for dossier completeness."
    - name: "gmp_compliance_status"
      expr: gmp_compliance_status
      comment: "GMP compliance status of the manufacturing site — required for dossier approval in most markets."
    - name: "target_submission_date_month"
      expr: DATE_TRUNC('MONTH', target_submission_date)
      comment: "Month of the planned regulatory submission — enables submission pipeline forecasting."
    - name: "additional_information_requested"
      expr: additional_information_requested
      comment: "Whether the regulatory authority has requested additional information — flags dossiers at risk of delay."
  measures:
    - name: "total_dossiers"
      expr: COUNT(1)
      comment: "Total number of regulatory dossiers — baseline measure for regulatory submission workload."
    - name: "approved_dossiers"
      expr: COUNT(DISTINCT CASE WHEN dossier_status = 'Approved' THEN regulatory_dossier_id END)
      comment: "Number of approved regulatory dossiers — measures the productive output of the regulatory affairs function."
    - name: "dossiers_with_additional_info_requested"
      expr: COUNT(DISTINCT CASE WHEN additional_information_requested = TRUE THEN regulatory_dossier_id END)
      comment: "Number of dossiers where the authority has requested additional information — measures regulatory query burden and submission quality."
    - name: "dossiers_with_allergen_declaration_complete"
      expr: COUNT(DISTINCT CASE WHEN allergen_declaration_complete = TRUE THEN regulatory_dossier_id END)
      comment: "Number of dossiers with complete allergen declarations — tracks compliance readiness for allergen labeling requirements."
    - name: "dossiers_with_inci_listing_complete"
      expr: COUNT(DISTINCT CASE WHEN inci_listing_complete = TRUE THEN regulatory_dossier_id END)
      comment: "Number of dossiers with complete INCI ingredient listings — measures labeling compliance readiness."
    - name: "distinct_markets_covered"
      expr: COUNT(DISTINCT target_market_country_code)
      comment: "Number of distinct markets with regulatory dossiers — measures geographic breadth of the regulatory approval program."
    - name: "rejected_dossiers"
      expr: COUNT(DISTINCT CASE WHEN dossier_status = 'Rejected' THEN regulatory_dossier_id END)
      comment: "Number of rejected regulatory dossiers — measures regulatory submission quality and identifies markets with compliance challenges."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_scale_up_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing scale-up trial metrics tracking yield performance, deviation rates, cost efficiency, and technology transfer readiness across the R&D-to-manufacturing transition."
  source: "`vibe_consumer_goods_v1`.`research`.`scale_up_trial`"
  dimensions:
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the scale-up trial (e.g. Planned, In Progress, Completed, Failed) — primary filter for technology transfer pipeline."
    - name: "trial_type"
      expr: trial_type
      comment: "Type of scale-up trial (e.g. Pilot, Commercial Scale) — used to segment results by manufacturing readiness level."
    - name: "manufacturing_readiness_level"
      expr: manufacturing_readiness_level
      comment: "Manufacturing readiness level achieved — measures technology transfer maturity for launch planning."
    - name: "technology_transfer_checklist_status"
      expr: technology_transfer_checklist_status
      comment: "Status of the technology transfer checklist — tracks readiness for commercial manufacturing handover."
    - name: "deviation_observed_flag"
      expr: deviation_observed_flag
      comment: "Whether a process deviation was observed during the trial — primary quality signal for scale-up risk."
    - name: "trial_date_month"
      expr: DATE_TRUNC('MONTH', trial_date)
      comment: "Month the scale-up trial was conducted — enables trend analysis of technology transfer activity."
    - name: "manufacturing_site_code"
      expr: manufacturing_site_code
      comment: "Code of the manufacturing site where the trial was conducted — used to benchmark performance by facility."
  measures:
    - name: "total_scale_up_trials"
      expr: COUNT(1)
      comment: "Total number of scale-up trials conducted — baseline measure for technology transfer throughput."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across scale-up trials — primary manufacturing efficiency KPI; low yields indicate process optimization opportunities."
    - name: "total_trial_cost"
      expr: SUM(CAST(trial_cost_amount AS DOUBLE))
      comment: "Total cost of scale-up trials — key input for R&D-to-manufacturing transition cost management."
    - name: "avg_trial_cost"
      expr: AVG(CAST(trial_cost_amount AS DOUBLE))
      comment: "Average cost per scale-up trial — benchmarks technology transfer efficiency and informs future trial budgeting."
    - name: "avg_actual_output_kg"
      expr: AVG(CAST(actual_output_kg AS DOUBLE))
      comment: "Average actual output in kg per trial — measures production volume achieved at scale relative to batch size targets."
    - name: "avg_batch_size_kg"
      expr: AVG(CAST(batch_size_kg AS DOUBLE))
      comment: "Average planned batch size in kg — used as denominator reference for yield and output efficiency calculations."
    - name: "trials_with_deviations"
      expr: COUNT(DISTINCT CASE WHEN deviation_observed_flag = TRUE THEN scale_up_trial_id END)
      comment: "Number of scale-up trials with process deviations — measures process robustness and technology transfer risk."
    - name: "avg_scale_factor"
      expr: AVG(CAST(scale_factor AS DOUBLE))
      comment: "Average scale factor achieved in trials — measures the magnitude of scale-up from lab to manufacturing, informing process scalability."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_innovation_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Innovation pipeline financial and strategic metrics tracking NPV, ROI, market size, and budget efficiency of innovation briefs from ideation through approval."
  source: "`vibe_consumer_goods_v1`.`research`.`innovation_brief`"
  dimensions:
    - name: "brief_status"
      expr: brief_status
      comment: "Current status of the innovation brief (e.g. Draft, Submitted, Approved, Rejected) — primary filter for innovation funnel analysis."
    - name: "brief_type"
      expr: brief_type
      comment: "Type of innovation brief (e.g. New Product, Renovation, Line Extension) — used to segment pipeline by innovation type."
    - name: "innovation_priority_tier"
      expr: innovation_priority_tier
      comment: "Strategic priority tier of the innovation brief — used to weight portfolio investment and resource allocation."
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Target consumer segment for the innovation — enables portfolio analysis by consumer cohort."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('MONTH', target_launch_date)
      comment: "Month of the planned product launch from the brief — enables launch pipeline forecasting."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the brief was submitted — enables trend analysis of innovation ideation activity."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway required for the innovation — used to assess regulatory complexity and time-to-market risk."
  measures:
    - name: "total_innovation_briefs"
      expr: COUNT(1)
      comment: "Total number of innovation briefs — baseline measure for innovation pipeline volume."
    - name: "total_estimated_npv"
      expr: SUM(CAST(estimated_npv AS DOUBLE))
      comment: "Total estimated NPV across all innovation briefs — primary financial value measure for the innovation pipeline; used in portfolio prioritization."
    - name: "avg_estimated_npv"
      expr: AVG(CAST(estimated_npv AS DOUBLE))
      comment: "Average estimated NPV per innovation brief — benchmarks financial value of individual innovation opportunities."
    - name: "total_estimated_market_size"
      expr: SUM(CAST(estimated_market_size AS DOUBLE))
      comment: "Total addressable market size across innovation briefs — measures the aggregate market opportunity being pursued."
    - name: "avg_estimated_roi_pct"
      expr: AVG(CAST(estimated_roi_percent AS DOUBLE))
      comment: "Average estimated ROI percentage across innovation briefs — key financial efficiency metric for portfolio prioritization."
    - name: "total_estimated_development_budget"
      expr: SUM(CAST(estimated_development_budget AS DOUBLE))
      comment: "Total estimated development budget across all innovation briefs — measures total investment commitment in the innovation pipeline."
    - name: "avg_sustainability_target_score"
      expr: AVG(CAST(sustainability_target_score AS DOUBLE))
      comment: "Average sustainability target score across innovation briefs — tracks ESG ambition embedded in the innovation pipeline."
    - name: "approved_briefs"
      expr: COUNT(DISTINCT CASE WHEN brief_status = 'Approved' THEN innovation_brief_id END)
      comment: "Number of approved innovation briefs — measures the conversion rate of the innovation funnel from ideation to commitment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_sensory_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sensory evaluation performance metrics tracking consumer liking scores, purchase intent, and sensory attribute performance across product development stages."
  source: "`vibe_consumer_goods_v1`.`research`.`sensory_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the sensory evaluation (e.g. Planned, Completed, Cancelled) — primary filter for evaluation pipeline."
    - name: "panel_type"
      expr: panel_type
      comment: "Type of sensory panel (e.g. Expert, Consumer, Semi-Trained) — used to segment results by panel expertise level."
    - name: "evaluation_methodology"
      expr: evaluation_methodology
      comment: "Methodology used for the evaluation (e.g. Descriptive Analysis, Hedonic, Triangle Test) — used to ensure methodological comparability."
    - name: "product_category"
      expr: product_category
      comment: "Product category evaluated — enables benchmarking of sensory performance by category."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sensory evaluation — tracks which evaluations have been formally signed off for use in development decisions."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the sensory evaluation was conducted — enables trend analysis of sensory testing activity."
  measures:
    - name: "total_sensory_evaluations"
      expr: COUNT(1)
      comment: "Total number of sensory evaluations conducted — baseline measure for sensory testing throughput."
    - name: "avg_overall_liking_score"
      expr: AVG(CAST(overall_liking_score AS DOUBLE))
      comment: "Average overall liking score across sensory evaluations — primary consumer acceptance KPI for product development go/no-go decisions."
    - name: "avg_purchase_intent_score"
      expr: AVG(CAST(purchase_intent_score AS DOUBLE))
      comment: "Average purchase intent score — measures commercial potential of prototypes; directly linked to launch revenue forecasting."
    - name: "avg_texture_score"
      expr: AVG(CAST(texture_score AS DOUBLE))
      comment: "Average texture score — key sensory attribute for personal care and food products; drives reformulation decisions."
    - name: "avg_odor_score"
      expr: AVG(CAST(odor_score AS DOUBLE))
      comment: "Average odor/fragrance score — critical sensory dimension for consumer acceptance in beauty and personal care."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across evaluations — measures the reliability of sensory data used in development decisions."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level of sensory evaluations — measures the scientific rigor of sensory data supporting product decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stage_gate_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stage-gate process metrics tracking milestone completion rates, investment approvals, NPV estimates, and decision quality across the R&D innovation funnel."
  source: "`vibe_consumer_goods_v1`.`research`.`stage_gate_milestone`"
  dimensions:
    - name: "gate_status"
      expr: gate_status
      comment: "Current status of the stage-gate milestone (e.g. Pending, Passed, Failed, On Hold) — primary filter for pipeline progression analysis."
    - name: "gate_decision"
      expr: gate_decision
      comment: "Decision made at the gate review (e.g. Go, No-Go, Hold) — primary outcome dimension for funnel conversion analysis."
    - name: "gate_name"
      expr: gate_name
      comment: "Name of the stage gate (e.g. Gate 1 Concept, Gate 3 Development) — used to analyze funnel conversion by stage."
    - name: "gate_number"
      expr: gate_number
      comment: "Sequential gate number — used to order and analyze the innovation funnel progression."
    - name: "is_milestone_delayed"
      expr: is_milestone_delayed
      comment: "Whether the milestone is delayed — used to identify bottlenecks in the innovation pipeline."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of the gate review — enables trend analysis of stage-gate throughput over time."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status at the gate — tracks regulatory readiness as a gate criterion."
  measures:
    - name: "total_gate_milestones"
      expr: COUNT(1)
      comment: "Total number of stage-gate milestones — baseline measure for innovation funnel activity."
    - name: "total_investment_approved"
      expr: SUM(CAST(investment_approved_amount AS DOUBLE))
      comment: "Total investment approved at stage-gate reviews — measures capital commitment flowing through the innovation pipeline."
    - name: "avg_investment_approved"
      expr: AVG(CAST(investment_approved_amount AS DOUBLE))
      comment: "Average investment approved per gate milestone — benchmarks investment intensity by gate stage."
    - name: "avg_npv_estimate"
      expr: AVG(CAST(npv_estimate AS DOUBLE))
      comment: "Average NPV estimate at gate reviews — measures the financial value of projects progressing through the innovation funnel."
    - name: "avg_technical_feasibility_score"
      expr: AVG(CAST(technical_feasibility_score AS DOUBLE))
      comment: "Average technical feasibility score at gate reviews — measures the technical risk profile of the innovation pipeline."
    - name: "avg_consumer_acceptance_score"
      expr: AVG(CAST(consumer_acceptance_score AS DOUBLE))
      comment: "Average consumer acceptance score at gate reviews — measures consumer validation strength of projects advancing through the funnel."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score at gate reviews — tracks ESG performance of the innovation pipeline at each stage."
    - name: "delayed_milestones"
      expr: COUNT(DISTINCT CASE WHEN is_milestone_delayed = TRUE THEN stage_gate_milestone_id END)
      comment: "Number of delayed stage-gate milestones — measures pipeline execution risk and identifies projects requiring intervention."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_percentage AS DOUBLE))
      comment: "Average deliverables completion percentage at gate reviews — measures readiness of projects to advance through the innovation funnel."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_prototype`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype development efficiency and value metrics"
  source: "`vibe_consumer_goods_v1`.`research`.`prototype`"
  dimensions:
    - name: "prototype_status"
      expr: prototype_status
      comment: "Current status of the prototype (e.g., Active, Closed)"
    - name: "target_launch_market"
      expr: target_launch_market
      comment: "Intended launch market for the prototype"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Formulation linked to the prototype"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project driving the prototype"
  measures:
    - name: "total_prototypes"
      expr: COUNT(1)
      comment: "Total prototypes created"
    - name: "lead_time_days"
      expr: AVG(DATEDIFF(packaging_approval_date, DATE(created_timestamp)))
      comment: "Average days from prototype creation to packaging approval"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation development metrics focusing on cost, sustainability and sensory performance"
  source: "`vibe_consumer_goods_v1`.`research`.`research_formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g., Shampoo, Lotion)"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the formulation"
    - name: "development_status"
      expr: development_status
      comment: "Current development status (e.g., InDevelopment, Completed)"
    - name: "formulation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the formulation record was created"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project associated with the formulation"
  measures:
    - name: "total_formulations"
      expr: COUNT(1)
      comment: "Total research formulations recorded"
    - name: "average_cost_target_per_unit"
      expr: AVG(CAST(cost_target_per_unit AS DOUBLE))
      comment: "Average target cost per unit for formulations"
    - name: "average_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across formulations"
    - name: "average_sensory_evaluation_score"
      expr: AVG(CAST(sensory_evaluation_score AS DOUBLE))
      comment: "Average sensory evaluation score for formulations"
$$;