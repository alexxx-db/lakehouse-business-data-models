-- Metric views for domain: research | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_claim_substantiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim substantiation portfolio metrics tracking approval rates, renewal compliance, and statistical confidence across product claims — critical for regulatory and marketing risk management."
  source: "`vibe_consumer_goods_v1`.`research`.`claim_substantiation`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of product claim (e.g. Efficacy, Safety, Environmental) for segmenting substantiation workload and risk."
    - name: "claim_approval_status"
      expr: claim_approval_status
      comment: "Approval status of the claim substantiation, used to track the pipeline of approved vs. pending claims."
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the claim (e.g. Skin Care, Hair Care) for brand and category-level compliance monitoring."
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type of evidence supporting the claim (e.g. Clinical, Consumer Test, Lab) for evidence quality analysis."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the claim, used to identify claims awaiting or failing legal clearance."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the claim, critical for market launch readiness and compliance reporting."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating whether the claim substantiation requires periodic renewal, used for compliance calendar management."
    - name: "claim_expiry_year"
      expr: YEAR(claim_expiry_date)
      comment: "Year the claim expires, used to identify near-term renewal obligations and compliance risk."
  measures:
    - name: "total_claim_substantiations"
      expr: COUNT(1)
      comment: "Total number of claim substantiation records. Baseline KPI for the size and complexity of the claims portfolio."
    - name: "avg_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level across all claim substantiations. Tracks the scientific robustness of the claims portfolio."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across claim substantiations. Monitors statistical significance quality; lower values indicate stronger evidence."
    - name: "total_substantiation_cost"
      expr: SUM(CAST(substantiation_cost_amount AS DOUBLE))
      comment: "Total cost incurred for claim substantiation activities. Tracks the financial investment in claims compliance and evidence generation."
    - name: "avg_substantiation_cost"
      expr: AVG(CAST(substantiation_cost_amount AS DOUBLE))
      comment: "Average cost per claim substantiation. Benchmarks efficiency of the substantiation process and identifies cost outliers."
    - name: "statistically_significant_claims_count"
      expr: COUNT(CASE WHEN statistical_significance_flag = TRUE THEN 1 END)
      comment: "Number of claims with statistically significant evidence. Tracks the proportion of the portfolio backed by rigorous science."
    - name: "renewal_required_claims_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of claims requiring renewal. Drives compliance calendar planning and resource allocation for re-substantiation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_consumer_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer testing performance metrics tracking study outcomes, satisfaction scores, and statistical quality across consumer validation studies for product development decisions."
  source: "`vibe_consumer_goods_v1`.`research`.`consumer_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of consumer test (e.g. Blind, Branded, Monadic) for methodology-level performance analysis."
    - name: "study_status"
      expr: study_status
      comment: "Current status of the consumer study (e.g. Active, Completed, Cancelled) for pipeline monitoring."
    - name: "study_design"
      expr: study_design
      comment: "Study design methodology used, enabling comparison of test quality across design approaches."
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Target consumer segment for the test, enabling segment-level performance and preference analysis."
    - name: "test_geography"
      expr: test_geography
      comment: "Geographic market where the consumer test was conducted, for regional performance benchmarking."
    - name: "statistical_significance_flag"
      expr: statistical_significance_flag
      comment: "Flag indicating whether the test results are statistically significant, used to filter actionable vs. inconclusive studies."
    - name: "test_start_year"
      expr: YEAR(test_start_date)
      comment: "Year the consumer test started, used for trend analysis of testing activity and outcomes over time."
  measures:
    - name: "total_consumer_tests"
      expr: COUNT(1)
      comment: "Total number of consumer tests conducted. Tracks the volume of consumer validation activity supporting product development."
    - name: "avg_overall_satisfaction_rating"
      expr: AVG(CAST(overall_satisfaction_rating AS DOUBLE))
      comment: "Average overall consumer satisfaction rating across all tests. Primary KPI for consumer acceptance of product prototypes."
    - name: "avg_efficacy_perception_rating"
      expr: AVG(CAST(efficacy_perception_rating AS DOUBLE))
      comment: "Average consumer-perceived efficacy rating. Tracks how well products deliver on their claimed benefits in consumer perception."
    - name: "avg_skin_feel_rating"
      expr: AVG(CAST(skin_feel_rating AS DOUBLE))
      comment: "Average skin feel rating from consumer tests. Key sensory KPI for personal care product development decisions."
    - name: "avg_fragrance_rating"
      expr: AVG(CAST(fragrance_rating AS DOUBLE))
      comment: "Average fragrance rating from consumer tests. Tracks consumer acceptance of fragrance profiles across product development iterations."
    - name: "avg_study_cost"
      expr: AVG(CAST(study_cost_amount AS DOUBLE))
      comment: "Average cost per consumer study. Benchmarks research investment efficiency and identifies cost outliers."
    - name: "total_study_cost"
      expr: SUM(CAST(study_cost_amount AS DOUBLE))
      comment: "Total investment in consumer testing. Tracks the financial commitment to consumer validation across the product portfolio."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across consumer tests. Monitors the scientific rigor of consumer validation studies."
    - name: "statistically_significant_tests_count"
      expr: COUNT(CASE WHEN statistical_significance_flag = TRUE THEN 1 END)
      comment: "Number of consumer tests with statistically significant results. Tracks the proportion of studies generating actionable, reliable insights."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_consumer_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular consumer test result metrics measuring attribute-level ratings, NPS, purchase intent, and adverse event rates to validate product performance at the respondent level."
  source: "`vibe_consumer_goods_v1`.`research`.`consumer_test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of consumer test (e.g., HUT, CLT, Sensory Panel) for methodology segmentation."
    - name: "attribute_tested"
      expr: attribute_tested
      comment: "Specific product attribute being tested (e.g., Lather, Fragrance, Skin Feel) for attribute-level performance analysis."
    - name: "result_status"
      expr: consumer_test_result_status
      comment: "Status of the test result record for data quality filtering."
    - name: "statistical_significance_flag"
      expr: statistical_significance_flag
      comment: "Flag indicating statistical significance of the result, critical for claim substantiation."
    - name: "respondent_demographic_segment"
      expr: respondent_demographic_segment
      comment: "Demographic segment of the respondent for segment-level performance analysis."
    - name: "test_location"
      expr: test_location
      comment: "Location where the test was conducted for geographic performance comparison."
    - name: "regulatory_submission_included"
      expr: regulatory_submission_included
      comment: "Flag indicating whether this result is included in a regulatory submission, for compliance tracking."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of the test date for trend analysis of consumer test activity."
  measures:
    - name: "total_test_results"
      expr: COUNT(DISTINCT consumer_test_result_id)
      comment: "Total number of consumer test result records. Baseline measure of consumer evidence volume."
    - name: "avg_rating_value"
      expr: AVG(CAST(rating_value AS DOUBLE))
      comment: "Average attribute rating value across all test results. Core consumer acceptance KPI for product development decisions."
    - name: "avg_score_value"
      expr: AVG(CAST(score_value AS DOUBLE))
      comment: "Average score value across test results. Tracks overall consumer performance scores for launch readiness assessment."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across test results. Monitors statistical rigor of consumer evidence used for claim substantiation."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level across test results. Tracks robustness of consumer evidence for regulatory and marketing claims."
    - name: "adverse_event_result_count"
      expr: COUNT(CASE WHEN adverse_event_reported = TRUE THEN consumer_test_result_id END)
      comment: "Number of test results with adverse events reported. Safety KPI that triggers product safety and regulatory review."
    - name: "avg_compliance_rate"
      expr: AVG(CAST(compliance_rate AS DOUBLE))
      comment: "Average protocol compliance rate across test results. Tracks data quality and study integrity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_inci_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "INCI ingredient library metrics tracking regulatory status, restriction flags, sustainability certifications, and concentration limits to manage ingredient compliance and portfolio governance."
  source: "`vibe_consumer_goods_v1`.`research`.`inci_library`"
  dimensions:
    - name: "library_status"
      expr: inci_library_status
      comment: "Current status of the INCI library entry (e.g., Active, Restricted, Prohibited) for compliance filtering."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the ingredient (e.g., Preservative, Emollient, Surfactant) for ingredient role analysis."
    - name: "origin_type"
      expr: origin_type
      comment: "Origin type of the ingredient (e.g., Natural, Synthetic, Biotechnology) for naturalness portfolio analysis."
    - name: "is_prohibited"
      expr: is_prohibited
      comment: "Flag indicating the ingredient is prohibited, for regulatory compliance risk management."
    - name: "is_restricted"
      expr: is_restricted
      comment: "Flag indicating the ingredient is restricted, for regulatory compliance risk management."
    - name: "allergen_flag"
      expr: allergen_flag
      comment: "Flag indicating allergen status, for consumer safety and labeling compliance."
    - name: "svhc_flag"
      expr: svhc_flag
      comment: "Flag indicating Substance of Very High Concern (SVHC) status under REACH, for regulatory risk management."
    - name: "sustainable_sourcing_flag"
      expr: sustainable_sourcing_flag
      comment: "Flag indicating sustainable sourcing certification, for ESG portfolio analysis."
  measures:
    - name: "total_inci_entries"
      expr: COUNT(DISTINCT inci_library_id)
      comment: "Total number of INCI library entries. Baseline measure of ingredient library coverage."
    - name: "prohibited_ingredient_count"
      expr: COUNT(CASE WHEN is_prohibited = TRUE THEN inci_library_id END)
      comment: "Number of prohibited ingredients in the library. Tracks regulatory risk exposure in the ingredient portfolio."
    - name: "restricted_ingredient_count"
      expr: COUNT(CASE WHEN is_restricted = TRUE THEN inci_library_id END)
      comment: "Number of restricted ingredients in the library. Tracks compliance complexity and formulation constraints."
    - name: "svhc_ingredient_count"
      expr: COUNT(CASE WHEN svhc_flag = TRUE THEN inci_library_id END)
      comment: "Number of SVHC-flagged ingredients. Tracks REACH regulatory risk in the ingredient portfolio."
    - name: "allergen_ingredient_count"
      expr: COUNT(CASE WHEN allergen_flag = TRUE THEN inci_library_id END)
      comment: "Number of allergen-flagged ingredients. Tracks consumer safety risk and labeling obligation volume."
    - name: "avg_maximum_permitted_concentration_pct"
      expr: AVG(CAST(maximum_permitted_concentration_percentage AS DOUBLE))
      comment: "Average maximum permitted concentration across INCI library entries. Tracks formulation headroom across the ingredient portfolio."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_percentage AS DOUBLE))
      comment: "Average purity percentage across INCI library entries. Tracks ingredient quality standards in the library."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_innovation_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Innovation pipeline metrics tracking brief volume, financial targets, and strategic alignment of consumer goods innovation requests."
  source: "`vibe_consumer_goods_v1`.`research`.`innovation_brief`"
  dimensions:
    - name: "brief_status"
      expr: innovation_brief_status
      comment: "Current status of the innovation brief (e.g. Draft, Approved, Rejected) for funnel and conversion analysis."
    - name: "brief_type"
      expr: brief_type
      comment: "Type of innovation brief (e.g. New Product, Renovation, Line Extension) for portfolio mix analysis."
    - name: "innovation_priority_tier"
      expr: innovation_priority_tier
      comment: "Priority tier of the innovation brief, used to segment investment and resource allocation by strategic importance."
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Target consumer segment for the innovation, enabling demand-driven portfolio analysis."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('month', target_launch_date)
      comment: "Month of the planned launch date for the innovation brief, enabling launch pipeline forecasting."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the innovation brief was submitted, used for cohort and trend analysis of innovation intake."
  measures:
    - name: "total_innovation_briefs"
      expr: COUNT(1)
      comment: "Total number of innovation briefs submitted. Tracks the volume and velocity of the innovation intake pipeline."
    - name: "total_estimated_development_budget"
      expr: SUM(CAST(estimated_development_budget AS DOUBLE))
      comment: "Total estimated development budget across all innovation briefs. Tracks the financial scale of the innovation pipeline before project approval."
    - name: "avg_estimated_npv"
      expr: AVG(CAST(estimated_npv AS DOUBLE))
      comment: "Average estimated net present value across innovation briefs. Key financial metric for prioritizing which innovations to fund."
    - name: "total_estimated_npv"
      expr: SUM(CAST(estimated_npv AS DOUBLE))
      comment: "Total estimated NPV across all innovation briefs. Represents the aggregate financial value of the innovation pipeline."
    - name: "avg_estimated_roi_percent"
      expr: AVG(CAST(estimated_roi_percent AS DOUBLE))
      comment: "Average estimated ROI percentage across innovation briefs. Tracks the expected return quality of the innovation portfolio."
    - name: "avg_target_gross_margin_percent"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across innovation briefs. Monitors margin ambition embedded in the innovation pipeline."
    - name: "avg_sustainability_target_score"
      expr: AVG(CAST(sustainability_target_score AS DOUBLE))
      comment: "Average sustainability target score across innovation briefs. Tracks ESG ambition at the ideation stage of the innovation funnel."
    - name: "approved_briefs_count"
      expr: COUNT(CASE WHEN innovation_brief_status = 'Approved' THEN 1 END)
      comment: "Number of innovation briefs that have been approved. Measures the conversion rate of ideas into funded projects."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory testing metrics tracking test throughput, pass/fail rates, and out-of-specification events — key quality and R&D efficiency KPIs for consumer goods product development."
  source: "`vibe_consumer_goods_v1`.`research`.`lab_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of laboratory test (e.g. Microbiological, Chemical, Physical) for workload and quality analysis by test category."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the lab test (e.g. Pending, In Progress, Completed) for throughput and backlog monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the lab test, used to track quality rates and identify problematic formulations."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out-of-specification flag for the lab test result. Identifies tests requiring investigation and potential reformulation."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Flag indicating whether the test required a retest, used to track first-pass quality rates in the lab."
    - name: "regulatory_flag"
      expr: regulatory_flag
      comment: "Flag indicating whether the test is required for regulatory compliance, used to prioritize regulatory-critical testing."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of the lab test, used for trend analysis of testing volume and quality outcomes over time."
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total number of lab tests conducted. Baseline KPI for laboratory throughput and capacity utilization."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured result value across lab tests. Tracks central tendency of test outcomes for specification compliance monitoring."
    - name: "avg_specification_target"
      expr: AVG(CAST(specification_target AS DOUBLE))
      comment: "Average specification target value across lab tests. Used to benchmark actual results against intended targets."
    - name: "oos_tests_count"
      expr: COUNT(CASE WHEN oos_flag = TRUE THEN 1 END)
      comment: "Number of out-of-specification lab tests. Critical quality KPI — high OOS rates signal formulation or process issues requiring immediate investigation."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Number of lab tests requiring a retest. Tracks first-pass quality rate and laboratory efficiency."
    - name: "regulatory_tests_count"
      expr: COUNT(CASE WHEN regulatory_flag = TRUE THEN 1 END)
      comment: "Number of regulatory-required lab tests. Tracks compliance testing workload and ensures regulatory obligations are met."
    - name: "distinct_formulations_tested"
      expr: COUNT(DISTINCT research_formulation_id)
      comment: "Number of distinct formulations tested in the lab. Tracks the breadth of laboratory testing coverage across the formulation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_patent_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent family portfolio metrics tracking family size, royalty rates, strategic importance, and licensing status to manage IP portfolio strategy and monetization."
  source: "`vibe_consumer_goods_v1`.`research`.`patent_family`"
  dimensions:
    - name: "family_status"
      expr: family_status
      comment: "Current status of the patent family (e.g., Active, Expired, Abandoned) for portfolio health analysis."
    - name: "family_type"
      expr: family_type
      comment: "Type of patent family for portfolio composition analysis."
    - name: "technology_area"
      expr: technology_area
      comment: "Technology area covered by the patent family for technology portfolio analysis."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Licensing status of the patent family for IP monetization tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Primary jurisdiction of the patent family for geographic IP coverage analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating confidential patent family status for access control and disclosure management."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of patent family filing for trend analysis of IP generation activity."
  measures:
    - name: "total_patent_families"
      expr: COUNT(DISTINCT patent_family_id)
      comment: "Total number of patent families. Baseline measure of IP portfolio breadth."
    - name: "avg_strategic_importance_score"
      expr: AVG(CAST(strategic_importance_score AS DOUBLE))
      comment: "Average strategic importance score across patent families. Tracks IP portfolio quality and competitive value."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across licensed patent families. Tracks IP monetization performance."
    - name: "total_royalty_rate"
      expr: SUM(CAST(royalty_rate AS DOUBLE))
      comment: "Sum of royalty rates across all patent families. Proxy for total IP licensing revenue potential."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent portfolio metrics tracking filing activity, maintenance costs, and IP coverage — strategic KPIs for protecting consumer goods innovation investments."
  source: "`vibe_consumer_goods_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "patent_filing_status"
      expr: patent_filing_status
      comment: "Current status of the patent filing (e.g. Filed, Granted, Abandoned, Expired) for IP portfolio health monitoring."
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (e.g. Utility, Design, Process) for IP portfolio composition analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the patent is filed, used for geographic IP coverage analysis and freedom-to-operate assessment."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the patent (e.g. Formulation, Packaging, Process) for R&D investment and IP strategy alignment."
    - name: "commercial_value_tier"
      expr: commercial_value_tier
      comment: "Commercial value tier of the patent, used to prioritize maintenance investment and licensing strategy."
    - name: "pct_application_flag"
      expr: pct_application_flag
      comment: "Flag indicating PCT (international) application, used to track global IP protection coverage."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of patent filing, used for trend analysis of IP generation activity and portfolio vintage."
  measures:
    - name: "total_patent_filings"
      expr: COUNT(1)
      comment: "Total number of patent filings. Tracks the volume of IP generation activity and innovation output."
    - name: "total_annual_maintenance_cost"
      expr: SUM(CAST(estimated_annual_maintenance_cost AS DOUBLE))
      comment: "Total estimated annual maintenance cost across all patent filings. Tracks the ongoing financial obligation of the IP portfolio."
    - name: "avg_annual_maintenance_cost"
      expr: AVG(CAST(estimated_annual_maintenance_cost AS DOUBLE))
      comment: "Average annual maintenance cost per patent filing. Benchmarks IP maintenance efficiency and identifies high-cost patents for value review."
    - name: "pct_applications_count"
      expr: COUNT(CASE WHEN pct_application_flag = TRUE THEN 1 END)
      comment: "Number of PCT (international) patent applications. Tracks the breadth of global IP protection strategy."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with patent filings. Measures the geographic breadth of IP protection coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_prototype`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype development metrics tracking packaging cost, sustainability, fill volumes, and consumer test eligibility to manage the physical product development pipeline."
  source: "`vibe_consumer_goods_v1`.`research`.`prototype`"
  dimensions:
    - name: "prototype_status"
      expr: prototype_status
      comment: "Current status of the prototype (e.g., In Development, Approved, Superseded) for pipeline tracking."
    - name: "prototype_type"
      expr: prototype_type
      comment: "Type of prototype (e.g., Formulation, Packaging, Combined) for development category analysis."
    - name: "primary_container_material"
      expr: primary_container_material
      comment: "Primary container material (e.g., HDPE, Glass, Aluminium) for sustainability and cost analysis."
    - name: "recyclability_classification"
      expr: recyclability_classification
      comment: "Recyclability classification of the prototype packaging for ESG portfolio analysis."
    - name: "sustainable_material_flag"
      expr: sustainable_material_flag
      comment: "Flag indicating use of sustainable materials, for ESG compliance tracking."
    - name: "consumer_test_eligible_flag"
      expr: consumer_test_eligible_flag
      comment: "Flag indicating the prototype is eligible for consumer testing, for pipeline readiness tracking."
    - name: "stability_test_status"
      expr: stability_test_status
      comment: "Stability test status of the prototype for quality gate tracking."
    - name: "generation"
      expr: generation
      comment: "Generation of the prototype (e.g., Gen 1, Gen 2) for iteration analysis."
  measures:
    - name: "total_prototypes"
      expr: COUNT(DISTINCT prototype_id)
      comment: "Total number of prototypes developed. Baseline measure of physical product development activity."
    - name: "total_estimated_packaging_cost"
      expr: SUM(CAST(estimated_packaging_cost AS DOUBLE))
      comment: "Total estimated packaging cost across all prototypes. Core cost management KPI for packaging development."
    - name: "avg_estimated_packaging_cost"
      expr: AVG(CAST(estimated_packaging_cost AS DOUBLE))
      comment: "Average estimated packaging cost per prototype. Benchmarks packaging cost efficiency across development iterations."
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_percent AS DOUBLE))
      comment: "Average recycled content percentage across prototypes. Tracks ESG packaging sustainability performance."
    - name: "avg_fill_volume_ml"
      expr: AVG(CAST(fill_volume_ml AS DOUBLE))
      comment: "Average fill volume in ml across prototypes. Tracks product sizing decisions across the development pipeline."
    - name: "avg_container_weight_grams"
      expr: AVG(CAST(container_weight_grams AS DOUBLE))
      comment: "Average container weight in grams across prototypes. Tracks lightweighting progress as a sustainability and cost KPI."
    - name: "consumer_test_eligible_count"
      expr: COUNT(CASE WHEN consumer_test_eligible_flag = TRUE THEN prototype_id END)
      comment: "Number of prototypes eligible for consumer testing. Tracks pipeline readiness for consumer validation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_raw_material_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material specification metrics tracking cost, purity, regulatory compliance, and sustainability flags to manage ingredient sourcing strategy and regulatory risk."
  source: "`vibe_consumer_goods_v1`.`research`.`raw_material_spec`"
  dimensions:
    - name: "spec_status"
      expr: raw_material_spec_status
      comment: "Current status of the raw material specification (e.g., Active, Obsolete, Under Review) for portfolio management."
    - name: "rd_approval_status"
      expr: rd_approval_status
      comment: "R&D approval status of the raw material specification for development pipeline tracking."
    - name: "physical_form"
      expr: physical_form
      comment: "Physical form of the raw material (e.g., Liquid, Powder, Solid) for formulation compatibility analysis."
    - name: "eu_restricted_flag"
      expr: eu_restricted_flag
      comment: "Flag indicating EU restriction on the raw material, for regulatory compliance risk analysis."
    - name: "us_fda_restricted_flag"
      expr: us_fda_restricted_flag
      comment: "Flag indicating US FDA restriction on the raw material, for regulatory compliance risk analysis."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Flag indicating organic certification, for sustainability and premium positioning analysis."
    - name: "palm_oil_derivative_flag"
      expr: palm_oil_derivative_flag
      comment: "Flag indicating palm oil derivative content, for deforestation and sustainability risk tracking."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Flag indicating hazardous material classification, for safety and regulatory risk management."
  measures:
    - name: "total_raw_material_specs"
      expr: COUNT(DISTINCT raw_material_spec_id)
      comment: "Total number of raw material specifications. Baseline measure of ingredient portfolio breadth."
    - name: "avg_cost_per_kg"
      expr: AVG(CAST(cost_per_kg AS DOUBLE))
      comment: "Average cost per kg across raw material specifications. Core procurement cost KPI for formulation cost management."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average purity percentage across raw material specifications. Tracks ingredient quality standards across the portfolio."
    - name: "eu_restricted_material_count"
      expr: COUNT(CASE WHEN eu_restricted_flag = TRUE THEN raw_material_spec_id END)
      comment: "Number of raw materials with EU restrictions. Tracks regulatory compliance risk in the ingredient portfolio."
    - name: "palm_oil_derivative_count"
      expr: COUNT(CASE WHEN palm_oil_derivative_flag = TRUE THEN raw_material_spec_id END)
      comment: "Number of raw materials that are palm oil derivatives. Tracks deforestation and sustainability risk in the ingredient portfolio."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_flag = TRUE THEN raw_material_spec_id END)
      comment: "Number of hazardous raw materials in the specification portfolio. Tracks safety and handling risk."
    - name: "avg_approved_concentration_max_pct"
      expr: AVG(CAST(approved_concentration_max_percent AS DOUBLE))
      comment: "Average maximum approved concentration percentage across raw material specs. Tracks formulation headroom for ingredient use."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_rd_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic R&D portfolio metrics tracking investment, budget performance, and project pipeline health across all active research and development initiatives."
  source: "`vibe_consumer_goods_v1`.`research`.`rd_project`"
  dimensions:
    - name: "project_status"
      expr: rd_project_status
      comment: "Current lifecycle status of the R&D project (e.g. Active, On Hold, Completed, Cancelled) for pipeline segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the R&D project type (e.g. Innovation, Renovation, Cost Reduction) for portfolio mix analysis."
    - name: "stage_gate_phase"
      expr: stage_gate_phase
      comment: "Current stage-gate phase of the project, enabling funnel and throughput analysis across development stages."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier assigned to the project, used to segment investment and resource allocation by priority."
    - name: "portfolio_category"
      expr: portfolio_category
      comment: "Portfolio category grouping for the project, enabling cross-category investment and pipeline analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification of the project, used to monitor high-risk project concentration in the portfolio."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('month', target_launch_date)
      comment: "Month of the planned product launch date, enabling launch pipeline forecasting by time period."
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the project started, used for cohort and vintage analysis of the R&D portfolio."
  measures:
    - name: "total_rd_projects"
      expr: COUNT(1)
      comment: "Total number of R&D projects in the portfolio. Baseline KPI for pipeline size and capacity planning."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total R&D budget allocated across all projects. Core financial KPI for investment oversight and resource governance."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total R&D budget actually spent across all projects. Tracks actual investment burn against allocation."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per R&D project. Benchmarks investment intensity and identifies outlier projects."
    - name: "total_sustainability_score"
      expr: SUM(CAST(sustainability_score AS DOUBLE))
      comment: "Sum of sustainability scores across all R&D projects. Used to track aggregate ESG commitment embedded in the innovation pipeline."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across R&D projects. Tracks the portfolio-level ESG quality of innovation investments."
    - name: "avg_target_cogs"
      expr: AVG(CAST(target_cogs AS DOUBLE))
      comment: "Average target cost of goods sold across R&D projects. Monitors cost competitiveness of the innovation pipeline at design stage."
    - name: "avg_target_rsp"
      expr: AVG(CAST(target_rsp AS DOUBLE))
      comment: "Average target retail selling price across R&D projects. Tracks the intended price positioning of the innovation pipeline."
    - name: "distinct_active_projects"
      expr: COUNT(DISTINCT rd_project_id)
      comment: "Count of distinct active R&D projects. Ensures accurate pipeline headcount without double-counting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_regulatory_dossier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory dossier metrics tracking submission pipeline, approval rates, and compliance completeness — essential for market authorization and launch readiness governance."
  source: "`vibe_consumer_goods_v1`.`research`.`regulatory_dossier`"
  dimensions:
    - name: "dossier_status"
      expr: dossier_status
      comment: "Current status of the regulatory dossier (e.g. In Preparation, Submitted, Approved, Rejected) for submission pipeline monitoring."
    - name: "dossier_type"
      expr: dossier_type
      comment: "Type of regulatory dossier (e.g. CPNP, FDA, ASEAN) for jurisdiction-specific compliance tracking."
    - name: "submission_jurisdiction"
      expr: submission_jurisdiction
      comment: "Jurisdiction for the regulatory submission, used for geographic compliance coverage analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the dossier (e.g. EU Cosmetics Regulation, FDA OTC) for framework-level compliance analysis."
    - name: "safety_assessment_status"
      expr: safety_assessment_status
      comment: "Safety assessment status within the dossier, used to identify dossiers blocked by incomplete safety documentation."
    - name: "gmp_compliance_status"
      expr: gmp_compliance_status
      comment: "GMP compliance status of the dossier, critical for regulatory submission eligibility."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of regulatory submission, used for trend analysis of submission activity and approval cycle times."
  measures:
    - name: "total_regulatory_dossiers"
      expr: COUNT(1)
      comment: "Total number of regulatory dossiers. Tracks the volume of regulatory submission activity and market authorization pipeline."
    - name: "approved_dossiers_count"
      expr: COUNT(CASE WHEN dossier_status = 'Approved' THEN 1 END)
      comment: "Number of approved regulatory dossiers. Tracks market authorization success rate and launch readiness."
    - name: "rejected_dossiers_count"
      expr: COUNT(CASE WHEN dossier_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected regulatory dossiers. Tracks regulatory failure rate and identifies systemic compliance gaps."
    - name: "additional_info_requested_count"
      expr: COUNT(CASE WHEN additional_information_requested = TRUE THEN 1 END)
      comment: "Number of dossiers where regulatory authorities requested additional information. Tracks dossier quality and submission completeness."
    - name: "inci_listing_complete_count"
      expr: COUNT(CASE WHEN inci_listing_complete = TRUE THEN 1 END)
      comment: "Number of dossiers with complete INCI ingredient listings. Tracks labeling compliance readiness across the submission portfolio."
    - name: "distinct_jurisdictions_submitted"
      expr: COUNT(DISTINCT submission_jurisdiction)
      comment: "Number of distinct jurisdictions with regulatory submissions. Tracks the geographic breadth of market authorization activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D formulation portfolio metrics tracking development status, sustainability performance, and consumer test scores across the active formulation pipeline."
  source: "`vibe_consumer_goods_v1`.`research`.`research_formulation`"
  dimensions:
    - name: "research_formulation_status"
      expr: research_formulation_status
      comment: "Current development status of the research formulation (e.g. In Development, Approved, Discontinued) for pipeline monitoring."
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g. Cream, Gel, Serum) for category-level portfolio analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the formulation (e.g. Concept, Development, Scale-Up) for stage-gate pipeline analysis."
    - name: "safety_assessment_status"
      expr: safety_assessment_status
      comment: "Safety assessment status of the formulation, used to identify formulations pending or failing safety clearance."
    - name: "stability_test_status"
      expr: stability_test_status
      comment: "Stability test status of the formulation, used to track launch readiness and identify stability failures."
    - name: "vegan_compliant_flag"
      expr: vegan_compliant_flag
      comment: "Flag indicating vegan compliance of the formulation, used to track the vegan-certified portfolio proportion."
    - name: "cruelty_free_flag"
      expr: cruelty_free_flag
      comment: "Flag indicating cruelty-free status of the formulation, used to track ethical sourcing compliance in the portfolio."
  measures:
    - name: "total_research_formulations"
      expr: COUNT(1)
      comment: "Total number of research formulations in development. Tracks the size and diversity of the active formulation pipeline."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across research formulations. Tracks the ESG quality of the formulation pipeline against corporate sustainability targets."
    - name: "avg_consumer_test_score"
      expr: AVG(CAST(consumer_test_score AS DOUBLE))
      comment: "Average consumer test score across research formulations. Tracks consumer acceptance quality of the formulation pipeline."
    - name: "avg_natural_content_percentage"
      expr: AVG(CAST(natural_content_percentage AS DOUBLE))
      comment: "Average natural content percentage across formulations. Tracks the portfolio's progress toward natural ingredient targets."
    - name: "avg_cost_target_per_unit"
      expr: AVG(CAST(cost_target_per_unit AS DOUBLE))
      comment: "Average cost target per unit across research formulations. Monitors cost competitiveness of the formulation pipeline at design stage."
    - name: "vegan_compliant_formulations_count"
      expr: COUNT(CASE WHEN vegan_compliant_flag = TRUE THEN 1 END)
      comment: "Number of vegan-compliant formulations. Tracks progress toward vegan portfolio targets and consumer demand alignment."
    - name: "cruelty_free_formulations_count"
      expr: COUNT(CASE WHEN cruelty_free_flag = TRUE THEN 1 END)
      comment: "Number of cruelty-free formulations. Tracks ethical compliance coverage of the formulation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study metrics tracking study completion, shelf-life outcomes, and GMP compliance across R&D stability programs — essential for product launch readiness and regulatory submission."
  source: "`vibe_consumer_goods_v1`.`research`.`research_stability_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the stability study (e.g. Ongoing, Completed, Failed) for pipeline and launch readiness monitoring."
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (e.g. Accelerated, Real-Time, Photostability) for methodology-level analysis."
    - name: "ich_condition"
      expr: ich_condition
      comment: "ICH stability condition (e.g. 25°C/60%RH, 40°C/75%RH) for regulatory condition-level performance analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition applied during the stability study, used to compare outcomes across environmental conditions."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Flag indicating GMP compliance of the stability study, critical for regulatory submission eligibility."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Flag indicating whether the study is included in a regulatory submission, used to track regulatory-grade study coverage."
    - name: "study_start_year"
      expr: YEAR(study_start_date)
      comment: "Year the stability study started, used for cohort analysis of study outcomes and shelf-life trends."
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total number of stability studies conducted. Tracks the volume of stability testing supporting product development and regulatory submissions."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average storage temperature across stability studies. Used to verify study conditions align with ICH guidelines."
    - name: "avg_humidity_pct"
      expr: AVG(CAST(humidity_pct AS DOUBLE))
      comment: "Average humidity percentage across stability studies. Monitors environmental condition consistency across the stability program."
    - name: "gmp_compliant_studies_count"
      expr: COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END)
      comment: "Number of GMP-compliant stability studies. Tracks the proportion of the stability portfolio eligible for regulatory submission."
    - name: "regulatory_submission_studies_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of stability studies included in regulatory submissions. Tracks regulatory-grade evidence generation for market authorization."
    - name: "distinct_formulations_in_stability"
      expr: COUNT(DISTINCT research_formulation_id)
      comment: "Number of distinct formulations under stability testing. Tracks stability coverage of the active formulation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_safety_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product safety assessment metrics tracking assessment outcomes, margin of safety, and compliance status — critical for regulatory approval and consumer protection governance."
  source: "`vibe_consumer_goods_v1`.`research`.`safety_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the safety assessment (e.g. In Progress, Approved, Rejected) for compliance pipeline monitoring."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of safety assessment (e.g. Dermatological, Toxicological, Microbiological) for risk categorization."
    - name: "safety_conclusion"
      expr: safety_conclusion
      comment: "Overall safety conclusion of the assessment (e.g. Safe, Conditionally Safe, Unsafe) for risk portfolio analysis."
    - name: "regulatory_market_scope"
      expr: regulatory_market_scope
      comment: "Market scope covered by the safety assessment (e.g. EU, US, ASEAN) for regulatory coverage analysis."
    - name: "restricted_substances_compliance"
      expr: restricted_substances_compliance
      comment: "Flag indicating compliance with restricted substances regulations, used to identify non-compliant formulations."
    - name: "cpnp_notification_required"
      expr: cpnp_notification_required
      comment: "Flag indicating whether CPNP notification is required, used for EU regulatory compliance tracking."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the safety assessment was conducted, used for trend analysis of safety compliance activity."
  measures:
    - name: "total_safety_assessments"
      expr: COUNT(1)
      comment: "Total number of safety assessments conducted. Baseline KPI for regulatory compliance workload and portfolio coverage."
    - name: "avg_margin_of_safety"
      expr: AVG(CAST(margin_of_safety AS DOUBLE))
      comment: "Average margin of safety across all assessed formulations. Critical risk KPI — low values signal potential consumer safety concerns requiring immediate action."
    - name: "avg_noael_value"
      expr: AVG(CAST(noael_value AS DOUBLE))
      comment: "Average No Observed Adverse Effect Level (NOAEL) across safety assessments. Tracks the toxicological safety threshold of the product portfolio."
    - name: "avg_systemic_exposure_estimate"
      expr: AVG(CAST(systemic_exposure_estimate AS DOUBLE))
      comment: "Average systemic exposure estimate across assessments. Monitors consumer exposure levels relative to safety thresholds."
    - name: "restricted_substances_non_compliant_count"
      expr: COUNT(CASE WHEN restricted_substances_compliance = FALSE THEN 1 END)
      comment: "Number of safety assessments flagging restricted substances non-compliance. Drives urgent remediation actions to prevent regulatory penalties and market withdrawal."
    - name: "cpnp_notification_required_count"
      expr: COUNT(CASE WHEN cpnp_notification_required = TRUE THEN 1 END)
      comment: "Number of products requiring CPNP notification. Tracks EU regulatory filing obligations and compliance calendar."
    - name: "distinct_formulations_assessed"
      expr: COUNT(DISTINCT research_formulation_id)
      comment: "Number of distinct research formulations that have undergone safety assessment. Tracks safety coverage of the active formulation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_scale_up_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scale-up trial metrics tracking manufacturing readiness, yield performance, and deviation rates as R&D formulations transition to commercial production — critical for launch readiness decisions."
  source: "`vibe_consumer_goods_v1`.`research`.`scale_up_trial`"
  dimensions:
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the scale-up trial (e.g. Planned, In Progress, Completed, Failed) for manufacturing readiness tracking."
    - name: "trial_type"
      expr: trial_type
      comment: "Type of scale-up trial (e.g. Pilot, Commercial Scale) for stage-appropriate performance benchmarking."
    - name: "manufacturing_readiness_level"
      expr: manufacturing_readiness_level
      comment: "Manufacturing readiness level achieved, used to assess technology transfer progress and launch readiness."
    - name: "deviation_observed_flag"
      expr: deviation_observed_flag
      comment: "Flag indicating whether a process deviation was observed during the trial, used to identify problematic scale-up transitions."
    - name: "trial_year"
      expr: YEAR(trial_date)
      comment: "Year the scale-up trial was conducted, used for trend analysis of manufacturing readiness over time."
  measures:
    - name: "total_scale_up_trials"
      expr: COUNT(1)
      comment: "Total number of scale-up trials conducted. Tracks the volume of technology transfer activity from R&D to manufacturing."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across scale-up trials. Primary manufacturing efficiency KPI — low yields signal process issues requiring reformulation or process optimization."
    - name: "avg_actual_output_kg"
      expr: AVG(CAST(actual_output_kg AS DOUBLE))
      comment: "Average actual output in kilograms per scale-up trial. Tracks production volume achievement against planned batch sizes."
    - name: "total_trial_cost"
      expr: SUM(CAST(trial_cost_amount AS DOUBLE))
      comment: "Total cost of scale-up trials. Tracks the financial investment in technology transfer and manufacturing readiness activities."
    - name: "avg_trial_cost"
      expr: AVG(CAST(trial_cost_amount AS DOUBLE))
      comment: "Average cost per scale-up trial. Benchmarks technology transfer efficiency and identifies cost outliers."
    - name: "deviation_trials_count"
      expr: COUNT(CASE WHEN deviation_observed_flag = TRUE THEN 1 END)
      comment: "Number of scale-up trials with observed process deviations. High deviation rates signal manufacturing readiness risk and potential launch delays."
    - name: "avg_scale_factor"
      expr: AVG(CAST(scale_factor AS DOUBLE))
      comment: "Average scale factor achieved across trials. Tracks the magnitude of scale-up from lab to commercial production."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_sensory_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sensory evaluation metrics tracking overall liking, purchase intent, attribute scores, and panel quality to guide formulation decisions and consumer acceptance."
  source: "`vibe_consumer_goods_v1`.`research`.`sensory_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the sensory evaluation (e.g., Planned, Completed, Cancelled) for pipeline tracking."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of sensory evaluation (e.g., Descriptive, Hedonic, Discrimination) for methodology analysis."
    - name: "panel_type"
      expr: panel_type
      comment: "Type of sensory panel (e.g., Expert, Consumer, Semi-Trained) for panel quality segmentation."
    - name: "product_category"
      expr: product_category
      comment: "Product category evaluated for category-level sensory performance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sensory evaluation for quality gate tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance of the evaluation methodology."
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of the sensory evaluation for trend analysis of sensory testing activity."
  measures:
    - name: "total_sensory_evaluations"
      expr: COUNT(DISTINCT sensory_evaluation_id)
      comment: "Total number of sensory evaluations conducted. Baseline measure of sensory testing activity."
    - name: "avg_overall_liking_score"
      expr: AVG(CAST(overall_liking_score AS DOUBLE))
      comment: "Average overall liking score across sensory evaluations. Primary consumer acceptance KPI for formulation decisions."
    - name: "avg_purchase_intent_score"
      expr: AVG(CAST(purchase_intent_score AS DOUBLE))
      comment: "Average purchase intent score across sensory evaluations. Tracks commercial viability of formulations."
    - name: "avg_texture_score"
      expr: AVG(CAST(texture_score AS DOUBLE))
      comment: "Average texture score across sensory evaluations. Tracks a key sensory attribute for consumer goods formulations."
    - name: "avg_odor_score"
      expr: AVG(CAST(odor_score AS DOUBLE))
      comment: "Average odor/fragrance score across sensory evaluations. Tracks fragrance performance as a key consumer acceptance driver."
    - name: "avg_color_score"
      expr: AVG(CAST(color_score AS DOUBLE))
      comment: "Average color score across sensory evaluations. Tracks visual quality attribute performance."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across sensory evaluations. Tracks panel reliability and data integrity."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across sensory evaluations. Tracks robustness of sensory evidence."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stability_timepoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability timepoint measurement metrics tracking pass/fail rates, deviation incidence, measured values vs. specifications, and regulatory reportability across stability study timepoints."
  source: "`vibe_consumer_goods_v1`.`research`.`stability_timepoint`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome at the stability timepoint. Core quality gate dimension for shelf-life and release decisions."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition at the timepoint for condition-level stability performance analysis."
    - name: "test_parameter"
      expr: test_parameter
      comment: "Stability parameter being measured (e.g., pH, Viscosity, Appearance) for parameter-level trend analysis."
    - name: "timepoint_label"
      expr: timepoint_label
      comment: "Label of the stability timepoint (e.g., T0, T3M, T6M) for time-series stability analysis."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Flag indicating a deviation was observed at this timepoint. Critical quality KPI for stability failure analysis."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flag indicating the result is regulatory reportable, for compliance obligation tracking."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Flag indicating this is a retest measurement, for retest rate analysis."
    - name: "measurement_date_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement for trend analysis of stability testing activity."
  measures:
    - name: "total_timepoints"
      expr: COUNT(DISTINCT stability_timepoint_id)
      comment: "Total number of stability timepoint measurements. Baseline measure of stability data volume."
    - name: "deviation_timepoint_count"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN stability_timepoint_id END)
      comment: "Number of timepoints with deviations observed. Critical quality KPI triggering stability failure investigation."
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN stability_timepoint_id END)
      comment: "Number of regulatory reportable stability results. Tracks compliance obligation volume for regulatory affairs."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across stability timepoints. Tracks central tendency of stability parameters over time."
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH value across stability timepoints. pH stability is a critical quality attribute for most consumer goods formulations."
    - name: "avg_viscosity_cps"
      expr: AVG(CAST(viscosity_cps AS DOUBLE))
      comment: "Average viscosity in cPs across stability timepoints. Viscosity stability is a key physical quality attribute."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average actual storage temperature across timepoints. Validates study condition adherence."
    - name: "avg_timepoint_months"
      expr: AVG(CAST(timepoint_months AS DOUBLE))
      comment: "Average timepoint interval in months across all measurements. Tracks study duration distribution."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`research_stage_gate_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stage-gate milestone metrics tracking R&D project progression, investment approvals, and decision quality across the innovation funnel — core governance KPIs for portfolio steering."
  source: "`vibe_consumer_goods_v1`.`research`.`stage_gate_milestone`"
  dimensions:
    - name: "gate_status"
      expr: gate_status
      comment: "Current status of the stage-gate review (e.g. Pending, Approved, Rejected, On Hold) for funnel throughput analysis."
    - name: "gate_decision"
      expr: gate_decision
      comment: "Decision outcome at the gate review (e.g. Go, No-Go, Hold) for conversion rate and portfolio quality analysis."
    - name: "gate_name"
      expr: gate_name
      comment: "Name of the stage-gate (e.g. Gate 1, Gate 3, Launch Gate) for funnel stage-level analysis."
    - name: "is_milestone_delayed"
      expr: is_milestone_delayed
      comment: "Flag indicating whether the milestone is delayed, used to track schedule adherence and identify bottlenecks in the innovation funnel."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status at the gate, used to identify projects with unresolved compliance issues blocking progression."
    - name: "planned_date_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Month of the planned gate review date, used for capacity planning of gate review resources."
  measures:
    - name: "total_gate_milestones"
      expr: COUNT(1)
      comment: "Total number of stage-gate milestones reviewed. Tracks the volume of governance activity across the innovation portfolio."
    - name: "total_investment_approved"
      expr: SUM(CAST(investment_approved_amount AS DOUBLE))
      comment: "Total investment approved at stage-gate reviews. Core financial governance KPI tracking capital committed to the innovation pipeline."
    - name: "avg_investment_approved"
      expr: AVG(CAST(investment_approved_amount AS DOUBLE))
      comment: "Average investment approved per gate milestone. Benchmarks investment intensity at each stage of the innovation funnel."
    - name: "avg_npv_estimate"
      expr: AVG(CAST(npv_estimate AS DOUBLE))
      comment: "Average NPV estimate at gate reviews. Tracks the financial quality of projects progressing through the innovation funnel."
    - name: "avg_technical_feasibility_score"
      expr: AVG(CAST(technical_feasibility_score AS DOUBLE))
      comment: "Average technical feasibility score at gate reviews. Monitors the technical readiness quality of projects advancing through the funnel."
    - name: "avg_market_attractiveness_score"
      expr: AVG(CAST(market_attractiveness_score AS DOUBLE))
      comment: "Average market attractiveness score at gate reviews. Tracks the commercial quality of projects in the innovation pipeline."
    - name: "delayed_milestones_count"
      expr: COUNT(CASE WHEN is_milestone_delayed = TRUE THEN 1 END)
      comment: "Number of delayed stage-gate milestones. Tracks schedule adherence and identifies systemic bottlenecks in the innovation process."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_percentage AS DOUBLE))
      comment: "Average deliverables completion percentage at gate reviews. Tracks readiness quality of projects entering gate reviews."
$$;
