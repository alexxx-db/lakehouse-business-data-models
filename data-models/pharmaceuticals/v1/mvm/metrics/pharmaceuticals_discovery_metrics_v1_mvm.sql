-- Metric views for domain: discovery | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_compound`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the compound registry — tracks portfolio composition, physicochemical quality, and progression readiness to guide lead selection and investment decisions."
  source: "`pharmaceuticals_ecm`.`discovery`.`compound`"
  dimensions:
    - name: "compound_status"
      expr: compound_status
      comment: "Current lifecycle status of the compound (e.g. Active, Deprecated, On-Hold) — primary filter for portfolio health dashboards."
    - name: "compound_class"
      expr: compound_class
      comment: "Chemical class of the compound (e.g. small molecule, biologic) — used to segment portfolio by modality."
    - name: "discovery_stage"
      expr: discovery_stage
      comment: "Stage within the discovery pipeline (e.g. Hit, Lead, Candidate) — critical for funnel analysis."
    - name: "mechanism_of_action"
      expr: mechanism_of_action
      comment: "Mechanism by which the compound exerts its effect — used to group compounds by MOA for target coverage analysis."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the compound (e.g. internal synthesis, vendor, in-licensed) — informs make-vs-buy strategy."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the compound was handled under GLP conditions — required for regulatory submission eligibility filtering."
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the compound was registered — enables year-over-year portfolio growth trending."
  measures:
    - name: "total_compounds"
      expr: COUNT(1)
      comment: "Total number of compounds in the registry. Baseline KPI for portfolio size and throughput tracking."
    - name: "avg_molecular_weight_da"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight (Daltons) across compounds. Tracks Lipinski Rule-of-Five compliance at portfolio level — deviations signal drug-likeness risk."
    - name: "avg_logp"
      expr: AVG(CAST(logp AS DOUBLE))
      comment: "Average calculated LogP (lipophilicity) across compounds. High average LogP correlates with poor solubility and ADME liabilities — a key portfolio quality signal."
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average compound purity percentage. Low purity undermines assay reliability and regulatory submissions — monitored to maintain data integrity."
    - name: "avg_tpsa_angstrom2"
      expr: AVG(CAST(tpsa_angstrom2 AS DOUBLE))
      comment: "Average topological polar surface area. High TPSA predicts poor oral absorption and CNS penetration — used to flag permeability risk across the portfolio."
    - name: "avg_solubility_aqueous_um"
      expr: AVG(CAST(solubility_aqueous_um AS DOUBLE))
      comment: "Average aqueous solubility (µM) across compounds. Low solubility is a leading cause of attrition — portfolio-level monitoring enables early intervention."
    - name: "distinct_molecular_targets_covered"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets addressed by registered compounds. Measures target diversity and portfolio breadth — low diversity signals concentration risk."
    - name: "distinct_therapeutic_areas_covered"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Number of distinct therapeutic areas represented in the compound portfolio. Informs strategic diversification and pipeline balance decisions."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_hts_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for High-Throughput Screening campaigns — measures screening productivity, hit quality, and assay performance to guide HTS investment and CRO strategy."
  source: "`pharmaceuticals_ecm`.`discovery`.`hts_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the HTS campaign (e.g. Planned, Active, Completed, Failed) — primary operational filter."
    - name: "screen_type"
      expr: screen_type
      comment: "Type of screen (e.g. Primary, Confirmatory, Counter-screen) — used to segment funnel stages."
    - name: "assay_technology"
      expr: assay_technology
      comment: "Detection technology used (e.g. HTRF, AlphaScreen, FRET) — informs technology platform performance benchmarking."
    - name: "cro_involved"
      expr: cro_involved
      comment: "Whether a CRO was engaged for this campaign — enables internal vs. outsourced performance comparison."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the campaign was conducted under GLP — required for regulatory submission eligibility."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the campaign was planned to start — supports annual throughput and capacity planning analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality classification for the campaign — used to exclude low-quality campaigns from KPI calculations."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of HTS campaigns. Baseline throughput KPI for screening operations capacity planning."
    - name: "avg_hit_rate_percent"
      expr: AVG(CAST(hit_rate_percent AS DOUBLE))
      comment: "Average hit rate (%) across campaigns. The primary HTS efficiency KPI — low hit rates signal poor library quality or target tractability issues requiring strategic intervention."
    - name: "avg_z_prime_factor"
      expr: AVG(CAST(z_prime_factor AS DOUBLE))
      comment: "Average Z-prime factor across campaigns. Z' > 0.5 is the industry threshold for a valid assay — portfolio-level monitoring flags systematic assay quality degradation."
    - name: "avg_signal_to_background_ratio"
      expr: AVG(CAST(signal_to_background_ratio AS DOUBLE))
      comment: "Average signal-to-background ratio. A leading indicator of assay sensitivity — low values predict high false-negative rates and wasted screening spend."
    - name: "avg_coefficient_of_variation_percent"
      expr: AVG(CAST(coefficient_of_variation_percent AS DOUBLE))
      comment: "Average coefficient of variation (%) across campaigns. Measures assay reproducibility — high CV indicates unreliable data that inflates downstream attrition costs."
    - name: "avg_screening_concentration_um"
      expr: AVG(CAST(screening_concentration_um AS DOUBLE))
      comment: "Average screening concentration (µM). Tracks assay condition consistency across campaigns — deviations affect hit rate comparability."
    - name: "distinct_molecular_targets_screened"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets screened. Measures target coverage breadth — informs portfolio diversification and target prioritization decisions."
    - name: "distinct_projects_with_campaigns"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of distinct discovery projects that have run at least one HTS campaign. Tracks active project engagement with screening infrastructure."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_screening_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular screening result KPIs — measures compound potency, selectivity, and hit quality at the assay-result level to prioritize hit-to-lead progression and identify false positives."
  source: "`pharmaceuticals_ecm`.`discovery`.`screening_result`"
  dimensions:
    - name: "result_classification"
      expr: result_classification
      comment: "Classification of the screening result (e.g. Hit, Inactive, Inconclusive, PAINS) — primary filter for hit triage workflows."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the result — used to exclude unreliable data points from potency and selectivity KPIs."
    - name: "pan_assay_interference_flag"
      expr: pan_assay_interference_flag
      comment: "Whether the compound is flagged as a PAINS (pan-assay interference compound) — critical for filtering false positives from hit lists."
    - name: "is_hit_to_lead_eligible"
      expr: is_hit_to_lead_eligible
      comment: "Whether the result qualifies the compound for hit-to-lead progression — key decision gate dimension."
    - name: "run_year"
      expr: YEAR(run_date)
      comment: "Year the screening run was executed — enables year-over-year hit quality trending."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the screening run — supports monthly throughput and quality monitoring."
  measures:
    - name: "total_screening_results"
      expr: COUNT(1)
      comment: "Total number of screening results. Baseline throughput KPI for screening operations — tracks data generation velocity."
    - name: "avg_ic50_nm"
      expr: AVG(CAST(ic50_nm AS DOUBLE))
      comment: "Average IC50 (nM) across results. The primary potency KPI — lower values indicate more potent compounds. Portfolio-level trends guide lead series selection."
    - name: "avg_ec50_nm"
      expr: AVG(CAST(ec50_nm AS DOUBLE))
      comment: "Average EC50 (nM) — measures agonist potency. Complements IC50 for full potency profile assessment across the screened set."
    - name: "avg_selectivity_score"
      expr: AVG(CAST(selectivity_score AS DOUBLE))
      comment: "Average selectivity score across results. High selectivity reduces off-target safety liabilities — a critical lead optimization KPI tracked by medicinal chemistry leadership."
    - name: "avg_percent_inhibition"
      expr: AVG(CAST(percent_inhibition AS DOUBLE))
      comment: "Average percent inhibition at screening concentration. Tracks overall hit quality and assay window effectiveness across campaigns."
    - name: "avg_z_prime_factor"
      expr: AVG(CAST(z_prime_factor AS DOUBLE))
      comment: "Average Z-prime factor at result level. Monitors per-run assay quality — systematic Z' degradation triggers assay re-validation before further screening spend."
    - name: "avg_curve_fit_r_squared"
      expr: AVG(CAST(curve_fit_r_squared AS DOUBLE))
      comment: "Average R-squared of dose-response curve fits. Low R² indicates poor curve quality and unreliable IC50/EC50 values — used to quality-gate potency data entering SAR analysis."
    - name: "hit_to_lead_eligible_count"
      expr: COUNT(CASE WHEN is_hit_to_lead_eligible = TRUE THEN 1 END)
      comment: "Number of results flagged as hit-to-lead eligible. Tracks the productive output of screening campaigns — the key funnel conversion metric from HTS to lead generation."
    - name: "pains_flagged_count"
      expr: COUNT(CASE WHEN pan_assay_interference_flag = TRUE THEN 1 END)
      comment: "Number of results flagged as pan-assay interference compounds. High PAINS counts indicate library quality issues that inflate apparent hit rates and waste medicinal chemistry resources."
    - name: "distinct_compounds_screened"
      expr: COUNT(DISTINCT compound_id)
      comment: "Number of distinct compounds that have been screened. Measures library coverage and screening breadth — informs library expansion investment decisions."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_adme_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADME (Absorption, Distribution, Metabolism, Excretion) profiling KPIs — measures pharmacokinetic quality of compounds to predict clinical success and guide lead optimization priorities."
  source: "`pharmaceuticals_ecm`.`discovery`.`adme_profile`"
  dimensions:
    - name: "metabolic_stability_class"
      expr: metabolic_stability_class
      comment: "Classification of metabolic stability (e.g. High, Medium, Low) — primary filter for ADME risk stratification."
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the ADME profile (e.g. Complete, Pending, Failed) — used to filter analysis to validated profiles."
    - name: "progression_recommendation"
      expr: progression_recommendation
      comment: "ADME-based progression recommendation (e.g. Progress, Optimize, Deprioritize) — the key decision output of ADME profiling."
    - name: "bbb_penetration"
      expr: bbb_penetration
      comment: "Whether the compound penetrates the blood-brain barrier — critical dimension for CNS vs. peripheral target programs."
    - name: "cyp_inhibition_flag"
      expr: cyp_inhibition_flag
      comment: "Whether the compound inhibits CYP enzymes — a major drug-drug interaction liability flag used in safety triage."
    - name: "pgp_substrate"
      expr: pgp_substrate
      comment: "Whether the compound is a P-glycoprotein substrate — affects CNS penetration and oral bioavailability predictions."
    - name: "species"
      expr: species
      comment: "Species in which the ADME profile was generated (e.g. human, rat, mouse) — required for cross-species PK translation analysis."
    - name: "assay_year"
      expr: YEAR(assay_date)
      comment: "Year the ADME assay was conducted — supports longitudinal ADME quality trending."
  measures:
    - name: "total_adme_profiles"
      expr: COUNT(1)
      comment: "Total number of ADME profiles generated. Tracks ADME throughput — a key operational KPI for the DMPK function."
    - name: "avg_bioavailability_pct"
      expr: AVG(CAST(bioavailability_pct AS DOUBLE))
      comment: "Average oral bioavailability (%) across profiled compounds. The single most important PK parameter for oral drug programs — portfolio average below 20% signals systemic lead quality issues."
    - name: "avg_half_life_h"
      expr: AVG(CAST(half_life_h AS DOUBLE))
      comment: "Average plasma half-life (hours). Drives dosing frequency decisions — too short requires frequent dosing (compliance risk), too long raises accumulation/safety concerns."
    - name: "avg_clearance_ml_min_kg"
      expr: AVG(CAST(clearance_ml_min_kg AS DOUBLE))
      comment: "Average clearance (mL/min/kg). High clearance predicts short half-life and poor exposure — a leading indicator of PK failure in clinical translation."
    - name: "avg_plasma_protein_binding_pct"
      expr: AVG(CAST(plasma_protein_binding_pct AS DOUBLE))
      comment: "Average plasma protein binding (%). Very high PPB (>99%) reduces free drug fraction and efficacy — monitored to flag compounds with insufficient free drug exposure."
    - name: "avg_permeability_caco2_nm_s"
      expr: AVG(CAST(permeability_caco2_nm_s AS DOUBLE))
      comment: "Average Caco-2 permeability (nm/s). The standard in-vitro surrogate for intestinal absorption — low values predict poor oral bioavailability before costly in-vivo studies."
    - name: "avg_solubility_um"
      expr: AVG(CAST(solubility_um AS DOUBLE))
      comment: "Average aqueous solubility (µM) from ADME profiling. Low solubility is a top cause of formulation failure — portfolio monitoring enables early formulation strategy decisions."
    - name: "avg_adme_risk_score"
      expr: AVG(CAST(adme_risk_score AS DOUBLE))
      comment: "Average composite ADME risk score. Aggregated risk signal used by portfolio committees to rank compounds for progression — rising average risk score triggers lead optimization re-prioritization."
    - name: "avg_volume_of_distribution_l_kg"
      expr: AVG(CAST(volume_of_distribution_l_kg AS DOUBLE))
      comment: "Average volume of distribution (L/kg). Informs tissue distribution and dosing regimen design — extreme values flag potential tissue accumulation or CNS exposure issues."
    - name: "cyp_inhibition_compound_count"
      expr: COUNT(CASE WHEN cyp_inhibition_flag = TRUE THEN 1 END)
      comment: "Number of compounds with CYP inhibition liability. CYP inhibitors carry drug-drug interaction risk that can block regulatory approval — tracked to manage portfolio safety liability."
    - name: "distinct_compounds_profiled"
      expr: COUNT(DISTINCT compound_id)
      comment: "Number of distinct compounds with ADME profiles. Measures DMPK coverage of the compound portfolio — gaps indicate compounds advancing without PK characterization."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_lead_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead series portfolio KPIs — tracks the quality, progression, and attrition of chemical series from hit identification through candidate nomination to inform portfolio investment decisions."
  source: "`pharmaceuticals_ecm`.`discovery`.`lead_series`"
  dimensions:
    - name: "series_status"
      expr: series_status
      comment: "Current status of the lead series (e.g. Active, Deprioritized, Nominated) — primary portfolio health dimension."
    - name: "current_stage"
      expr: current_stage
      comment: "Current discovery stage of the series (e.g. Hit-to-Lead, Lead Optimization, Candidate Selection) — funnel stage dimension."
    - name: "modality"
      expr: modality
      comment: "Drug modality of the series (e.g. small molecule, antibody, PROTAC) — used to segment portfolio by modality strategy."
    - name: "nce_nbe_classification"
      expr: nce_nbe_classification
      comment: "New Chemical Entity vs. New Biological Entity classification — affects regulatory pathway and IP strategy."
    - name: "safety_flag"
      expr: safety_flag
      comment: "Whether the series has an identified safety liability — critical risk filter for portfolio prioritization."
    - name: "stage_gate_decision"
      expr: stage_gate_decision
      comment: "Decision made at the most recent stage gate (e.g. Progress, Hold, Terminate) — tracks portfolio governance outcomes."
    - name: "series_start_year"
      expr: YEAR(series_start_date)
      comment: "Year the lead series was initiated — enables cohort analysis of series progression rates over time."
    - name: "sar_maturity_level"
      expr: sar_maturity_level
      comment: "Maturity of the SAR understanding for the series — used to assess readiness for candidate nomination."
  measures:
    - name: "total_lead_series"
      expr: COUNT(1)
      comment: "Total number of lead series in the portfolio. Baseline KPI for pipeline breadth — tracks the number of active chemical series available for candidate nomination."
    - name: "avg_drug_likeness_score"
      expr: AVG(CAST(drug_likeness_score AS DOUBLE))
      comment: "Average drug-likeness score across lead series. Composite measure of Lipinski/Veber compliance — portfolio average below threshold signals systemic lead quality issues requiring medicinal chemistry intervention."
    - name: "avg_oral_bioavailability_pct"
      expr: AVG(CAST(oral_bioavailability_pct AS DOUBLE))
      comment: "Average oral bioavailability (%) across lead series. Key PK quality KPI at series level — low portfolio average predicts high clinical attrition and drives formulation strategy decisions."
    - name: "avg_potency_benchmark_nm"
      expr: AVG(CAST(potency_benchmark_nm AS DOUBLE))
      comment: "Average best-in-series potency benchmark (nM). Tracks the potency ceiling of the portfolio — rising average signals lead optimization is not achieving target product profile requirements."
    - name: "avg_molecular_weight_da"
      expr: AVG(CAST(molecular_weight_da AS DOUBLE))
      comment: "Average molecular weight (Da) of lead series scaffolds. Tracks Lipinski compliance at series level — high average MW predicts poor oral absorption and formulation challenges."
    - name: "series_with_safety_flag_count"
      expr: COUNT(CASE WHEN safety_flag = TRUE THEN 1 END)
      comment: "Number of lead series with identified safety liabilities. Safety flags are the leading cause of late-stage attrition — portfolio-level count informs risk management and go/no-go decisions."
    - name: "distinct_molecular_targets_in_portfolio"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets addressed by active lead series. Measures target diversity — concentration on few targets signals portfolio concentration risk."
    - name: "distinct_therapeutic_areas_in_portfolio"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Number of distinct therapeutic areas represented in the lead series portfolio. Informs strategic balance and diversification decisions at the portfolio committee level."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_candidate_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate nomination KPIs — the critical discovery-to-development handoff gate. Tracks nomination volume, quality, and strategic alignment to measure discovery productivity and pipeline generation rate."
  source: "`pharmaceuticals_ecm`.`discovery`.`candidate_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the candidate nomination (e.g. Approved, Pending, Deferred, Withdrawn) — primary governance filter."
    - name: "modality"
      expr: modality
      comment: "Drug modality of the nominated candidate (e.g. small molecule, biologic, PROTAC) — used to track modality mix of the pipeline."
    - name: "nce_nbe_classification"
      expr: nce_nbe_classification
      comment: "NCE vs. NBE classification — affects regulatory pathway, IP strategy, and development cost projections."
    - name: "first_in_class"
      expr: first_in_class
      comment: "Whether the candidate is first-in-class for its target — a key strategic differentiator and premium pricing indicator."
    - name: "orphan_drug_eligible"
      expr: orphan_drug_eligible
      comment: "Whether the candidate qualifies for orphan drug designation — affects regulatory incentives, market exclusivity, and development economics."
    - name: "portfolio_priority"
      expr: portfolio_priority
      comment: "Portfolio priority tier assigned to the candidate — used to allocate development resources and track strategic alignment."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Intended regulatory pathway (e.g. Standard, Fast Track, Breakthrough Therapy) — informs development timeline and resource planning."
    - name: "nomination_year"
      expr: YEAR(nomination_date)
      comment: "Year of candidate nomination — the primary time dimension for pipeline generation rate trending."
    - name: "ip_status"
      expr: ip_status
      comment: "Intellectual property status of the nominated candidate — critical for commercial viability assessment."
  measures:
    - name: "total_nominations"
      expr: COUNT(1)
      comment: "Total number of candidate nominations. The primary discovery productivity KPI — tracks the rate at which discovery converts compounds into development candidates."
    - name: "approved_nominations_count"
      expr: COUNT(CASE WHEN nomination_status = 'Approved' THEN 1 END)
      comment: "Number of approved candidate nominations. Measures successful discovery-to-development handoffs — the ultimate output KPI of the discovery organization."
    - name: "first_in_class_nominations_count"
      expr: COUNT(CASE WHEN first_in_class = TRUE THEN 1 END)
      comment: "Number of first-in-class candidate nominations. First-in-class candidates command premium pricing and stronger IP — tracks the innovation quality of the discovery pipeline."
    - name: "orphan_drug_eligible_count"
      expr: COUNT(CASE WHEN orphan_drug_eligible = TRUE THEN 1 END)
      comment: "Number of candidates eligible for orphan drug designation. Orphan designation provides regulatory incentives and market exclusivity — tracked for portfolio strategy and BD/licensing value."
    - name: "glp_compliant_nominations_count"
      expr: COUNT(CASE WHEN glp_compliant = TRUE THEN 1 END)
      comment: "Number of nominations with GLP-compliant supporting data. GLP compliance is required for IND-enabling studies — tracks regulatory readiness of the nomination pipeline."
    - name: "distinct_therapeutic_areas_nominated"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Number of distinct therapeutic areas with candidate nominations. Measures pipeline diversification — concentration in one area signals strategic risk."
    - name: "distinct_molecular_targets_nominated"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets with nominated candidates. Tracks target coverage of the development pipeline — informs target strategy and portfolio balance."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_compound_synthesis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compound synthesis operational KPIs — measures synthetic efficiency, yield, and purity to optimize medicinal chemistry throughput and reduce cycle time from design to compound availability."
  source: "`pharmaceuticals_ecm`.`discovery`.`compound_synthesis`"
  dimensions:
    - name: "synthesis_status"
      expr: synthesis_status
      comment: "Current status of the synthesis (e.g. Completed, Failed, In-Progress) — primary operational filter."
    - name: "synthesis_purpose"
      expr: synthesis_purpose
      comment: "Purpose of the synthesis (e.g. SAR, ADME, Scale-up, Library) — used to segment synthesis activity by strategic intent."
    - name: "compound_type"
      expr: compound_type
      comment: "Type of compound being synthesized (e.g. analog, scaffold, reference) — informs SAR campaign progress tracking."
    - name: "synthetic_method"
      expr: synthetic_method
      comment: "Synthetic methodology used — enables method performance benchmarking and best-practice identification."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the synthesis was conducted under GLP — required for regulatory submission eligibility."
    - name: "registered_in_library"
      expr: registered_in_library
      comment: "Whether the synthesized compound was registered in the compound library — tracks library growth and compound availability."
    - name: "synthesis_year"
      expr: YEAR(synthesis_date)
      comment: "Year of synthesis — enables year-over-year synthesis throughput and efficiency trending."
  measures:
    - name: "total_synthesis_records"
      expr: COUNT(1)
      comment: "Total number of synthesis records. Baseline throughput KPI for medicinal chemistry operations — tracks compound production velocity."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average synthesis yield (%). The primary synthetic efficiency KPI — low yields increase cost-per-compound and slow SAR cycles. Portfolio-level monitoring identifies systematic chemistry challenges."
    - name: "avg_hplc_purity_percent"
      expr: AVG(CAST(hplc_purity_percent AS DOUBLE))
      comment: "Average HPLC purity (%) of synthesized compounds. Low purity compromises assay data quality and can invalidate SAR conclusions — a critical quality gate metric."
    - name: "avg_nmr_purity_percent"
      expr: AVG(CAST(nmr_purity_percent AS DOUBLE))
      comment: "Average NMR purity (%) — orthogonal purity measure to HPLC. Combined with HPLC purity, provides comprehensive structural confirmation quality assessment."
    - name: "avg_product_mass_mg"
      expr: AVG(CAST(product_mass_mg AS DOUBLE))
      comment: "Average product mass (mg) per synthesis. Tracks whether synthesis scale is sufficient for planned assay requirements — insufficient mass causes assay delays and re-synthesis costs."
    - name: "avg_reaction_duration_hours"
      expr: AVG(CAST(reaction_duration_hours AS DOUBLE))
      comment: "Average reaction duration (hours). Cycle time KPI for synthesis operations — long average durations constrain SAR iteration speed and compound delivery timelines."
    - name: "failed_synthesis_count"
      expr: COUNT(CASE WHEN synthesis_status = 'Failed' THEN 1 END)
      comment: "Number of failed synthesis attempts. Synthesis failure rate directly impacts medicinal chemistry productivity and project timelines — tracked to identify problematic chemotypes or methods."
    - name: "library_registered_count"
      expr: COUNT(CASE WHEN registered_in_library = TRUE THEN 1 END)
      comment: "Number of synthesized compounds successfully registered in the compound library. Tracks the net contribution of synthesis operations to the screening collection — the ultimate output of the synthesis function."
    - name: "distinct_compounds_synthesized"
      expr: COUNT(DISTINCT compound_id)
      comment: "Number of distinct compounds produced. Measures chemical diversity output of the synthesis function — informs SAR coverage and library expansion strategy."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_sar_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structure-Activity Relationship (SAR) study KPIs — measures the productivity and quality of SAR campaigns to guide lead optimization investment and predict candidate nomination readiness."
  source: "`pharmaceuticals_ecm`.`discovery`.`sar_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the SAR study (e.g. Active, Completed, On-Hold, Terminated) — primary operational filter."
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the SAR study (e.g. Exploratory, Focused, Optimization) — tracks maturity of SAR understanding."
    - name: "progression_decision"
      expr: progression_decision
      comment: "Decision on whether to progress the series based on SAR findings (e.g. Progress, Optimize, Terminate) — key portfolio governance output."
    - name: "metabolic_stability_flag"
      expr: metabolic_stability_flag
      comment: "Whether metabolic stability was identified as a liability in the SAR study — used to flag series requiring DMPK-focused optimization."
    - name: "permeability_flag"
      expr: permeability_flag
      comment: "Whether permeability was identified as a liability — flags series requiring formulation or chemical modification to improve absorption."
    - name: "patent_filing_flag"
      expr: patent_filing_flag
      comment: "Whether a patent was filed based on SAR findings — tracks IP generation output of the SAR program."
    - name: "nce_nbe_type"
      expr: nce_nbe_type
      comment: "NCE vs. NBE classification of the compounds studied — used to segment SAR productivity by modality."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the SAR study was initiated — enables cohort analysis of study completion rates and cycle times."
  measures:
    - name: "total_sar_studies"
      expr: COUNT(1)
      comment: "Total number of SAR studies. Baseline KPI for lead optimization throughput — tracks the volume of active SAR campaigns across the portfolio."
    - name: "avg_potency_range_min_nm"
      expr: AVG(CAST(potency_range_min_nm AS DOUBLE))
      comment: "Average best potency achieved (nM) across SAR studies. Tracks the potency ceiling of lead optimization — rising average signals failure to achieve target product profile potency requirements."
    - name: "avg_selectivity_ratio"
      expr: AVG(CAST(selectivity_ratio AS DOUBLE))
      comment: "Average selectivity ratio across SAR studies. Selectivity is a primary safety driver — low average selectivity across the portfolio predicts high off-target toxicity attrition in development."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across SAR studies. Low data quality undermines SAR conclusions and leads to incorrect optimization decisions — monitored to maintain scientific rigor."
    - name: "patent_filing_count"
      expr: COUNT(CASE WHEN patent_filing_flag = TRUE THEN 1 END)
      comment: "Number of SAR studies that generated patent filings. Tracks IP generation productivity of the medicinal chemistry function — a key output KPI for R&D value creation."
    - name: "metabolic_stability_liability_count"
      expr: COUNT(CASE WHEN metabolic_stability_flag = TRUE THEN 1 END)
      comment: "Number of SAR studies with metabolic stability liabilities. High count signals systemic metabolic liability in the chemical portfolio — triggers DMPK-focused optimization strategy."
    - name: "distinct_lead_series_in_sar"
      expr: COUNT(DISTINCT lead_series_id)
      comment: "Number of distinct lead series with active SAR studies. Measures the breadth of lead optimization activity — informs resource allocation across the medicinal chemistry portfolio."
    - name: "distinct_molecular_targets_in_sar"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets being optimized through SAR. Tracks target coverage of the lead optimization portfolio — informs target strategy and resource prioritization."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_molecular_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular target portfolio KPIs — measures target quality, validation status, and druggability to guide target selection investment and prioritize discovery programs."
  source: "`pharmaceuticals_ecm`.`discovery`.`molecular_target`"
  dimensions:
    - name: "validation_status"
      expr: validation_status
      comment: "Target validation status (e.g. Validated, In-Progress, Hypothetical) — primary filter for target readiness assessment."
    - name: "target_class"
      expr: target_class
      comment: "Biological class of the target (e.g. GPCR, Kinase, Ion Channel, Protease) — used to segment portfolio by target class for technology platform alignment."
    - name: "target_type"
      expr: target_type
      comment: "Type of molecular target (e.g. protein, RNA, DNA) — informs modality selection and assay development strategy."
    - name: "modality"
      expr: modality
      comment: "Preferred drug modality for the target — used to align target portfolio with modality capability investments."
    - name: "novelty_status"
      expr: novelty_status
      comment: "Novelty classification of the target (e.g. First-in-Class, Best-in-Class, Fast-Follower) — key strategic dimension for IP and competitive positioning."
    - name: "prioritization_tier"
      expr: prioritization_tier
      comment: "Portfolio prioritization tier assigned to the target — used to allocate discovery resources and track strategic alignment."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Whether the target has identified safety concerns — critical risk filter for target investment decisions."
    - name: "protein_structure_available"
      expr: protein_structure_available
      comment: "Whether a protein structure is available for structure-based drug design — a key enabler of rational drug design and hit-to-lead efficiency."
  measures:
    - name: "total_molecular_targets"
      expr: COUNT(1)
      comment: "Total number of molecular targets in the discovery portfolio. Baseline KPI for target portfolio breadth — tracks the number of biological hypotheses under investigation."
    - name: "avg_genetic_association_score"
      expr: AVG(CAST(genetic_association_score AS DOUBLE))
      comment: "Average genetic association score across targets. Human genetic validation is the strongest predictor of clinical success — portfolio average tracks the evidence quality of the target portfolio."
    - name: "validated_targets_count"
      expr: COUNT(CASE WHEN validation_status = 'Validated' THEN 1 END)
      comment: "Number of fully validated molecular targets. Validated targets have the highest probability of clinical success — tracks the productive output of the target validation function."
    - name: "targets_with_safety_concerns_count"
      expr: COUNT(CASE WHEN safety_concern_flag = TRUE THEN 1 END)
      comment: "Number of targets with identified safety concerns. Safety liabilities at the target level predict late-stage attrition — portfolio-level count informs risk management and target deprioritization decisions."
    - name: "targets_with_protein_structure_count"
      expr: COUNT(CASE WHEN protein_structure_available = TRUE THEN 1 END)
      comment: "Number of targets with available protein structures. Structural data enables structure-based drug design, which significantly improves hit-to-lead efficiency — tracks SBDD capability coverage."
    - name: "distinct_therapeutic_areas_targeted"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Number of distinct therapeutic areas represented in the target portfolio. Measures strategic diversification — concentration in one area signals portfolio concentration risk."
    - name: "distinct_indications_targeted"
      expr: COUNT(DISTINCT indication_id)
      comment: "Number of distinct indications addressed by the target portfolio. Tracks disease coverage breadth — informs business development and licensing strategy for indication expansion."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discovery project portfolio KPIs — tracks project health, strategic alignment, and pipeline progression at the program level to inform R&D investment allocation and portfolio governance decisions."
  source: "`pharmaceuticals_ecm`.`discovery`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the discovery project (e.g. Active, On-Hold, Terminated, Completed) — primary portfolio health filter."
    - name: "project_type"
      expr: project_type
      comment: "Type of discovery project (e.g. Internal, Collaboration, In-Licensed) — used to segment portfolio by sourcing strategy."
    - name: "phase"
      expr: phase
      comment: "Current discovery phase of the project (e.g. Target ID, Hit ID, Lead Opt, Candidate Selection) — primary funnel stage dimension."
    - name: "modality"
      expr: modality
      comment: "Drug modality of the project (e.g. small molecule, biologic, cell therapy) — used to track modality mix and capability alignment."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier assigned to the project — used to allocate resources and track alignment with corporate strategy."
    - name: "external_collaboration_flag"
      expr: external_collaboration_flag
      comment: "Whether the project involves an external collaboration — used to track make-vs-partner strategy and collaboration ROI."
    - name: "portfolio_decision"
      expr: portfolio_decision
      comment: "Most recent portfolio committee decision (e.g. Continue, Accelerate, Pause, Terminate) — tracks governance outcomes."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the project was initiated — enables cohort analysis of project progression and attrition rates."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of discovery projects. Baseline portfolio size KPI — tracks the breadth of the R&D pipeline and resource demand."
    - name: "active_projects_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Number of currently active discovery projects. The primary pipeline health KPI — tracks productive R&D capacity utilization and pipeline replenishment rate."
    - name: "external_collaboration_projects_count"
      expr: COUNT(CASE WHEN external_collaboration_flag = TRUE THEN 1 END)
      comment: "Number of projects with external collaborations. Tracks the open innovation strategy — rising count indicates increasing reliance on external innovation, informing BD and partnership investment decisions."
    - name: "glp_compliant_projects_count"
      expr: COUNT(CASE WHEN glp_compliance_flag = TRUE THEN 1 END)
      comment: "Number of projects operating under GLP compliance. GLP compliance is required for IND-enabling studies — tracks regulatory readiness of the active project portfolio."
    - name: "distinct_therapeutic_areas_in_pipeline"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Number of distinct therapeutic areas represented in the project portfolio. Measures strategic diversification — used by portfolio committees to assess concentration risk and balance."
    - name: "distinct_molecular_targets_in_pipeline"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets being pursued across projects. Tracks target diversity of the pipeline — informs target strategy and identifies redundant programs competing for the same target."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`discovery_assay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assay capability and quality KPIs — measures the performance, cost-efficiency, and regulatory readiness of the assay portfolio to optimize screening infrastructure investment and CRO strategy."
  source: "`pharmaceuticals_ecm`.`discovery`.`assay`"
  dimensions:
    - name: "assay_type"
      expr: assay_type
      comment: "Type of assay (e.g. Biochemical, Cell-based, Phenotypic) — primary dimension for assay portfolio segmentation."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the assay (e.g. Validated, In-Validation, Retired) — used to filter analysis to production-ready assays."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform used (e.g. HTRF, AlphaScreen, SPR) — enables platform performance and cost benchmarking."
    - name: "automation_compatible"
      expr: automation_compatible
      comment: "Whether the assay is compatible with automated screening — key dimension for HTS throughput capacity planning."
    - name: "outsourced_to_cro"
      expr: outsourced_to_cro
      comment: "Whether the assay is outsourced to a CRO — enables internal vs. outsourced cost and quality benchmarking."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the assay is GLP-compliant — required for regulatory submission eligibility."
    - name: "regulatory_submission_eligible"
      expr: regulatory_submission_eligible
      comment: "Whether the assay data is eligible for regulatory submissions — tracks the regulatory-grade assay portfolio."
    - name: "throughput_capacity"
      expr: throughput_capacity
      comment: "Throughput capacity classification (e.g. Low, Medium, High, Ultra-HTS) — used for screening capacity planning."
  measures:
    - name: "total_assays"
      expr: COUNT(1)
      comment: "Total number of assays in the portfolio. Baseline KPI for assay capability breadth — tracks the screening toolkit available to discovery programs."
    - name: "avg_z_prime_factor"
      expr: AVG(CAST(z_prime_factor AS DOUBLE))
      comment: "Average Z-prime factor across assays. Z' is the gold-standard assay quality metric — portfolio average below 0.5 indicates systemic assay quality issues requiring investment in assay development."
    - name: "avg_cost_per_well_usd"
      expr: AVG(CAST(cost_per_well_usd AS DOUBLE))
      comment: "Average cost per well (USD) across assays. The primary assay economics KPI — drives screening budget planning and CRO vs. internal cost-benefit analysis."
    - name: "avg_signal_window"
      expr: AVG(CAST(signal_window AS DOUBLE))
      comment: "Average signal window across assays. Wider signal windows improve hit detection sensitivity — portfolio-level monitoring identifies assays at risk of high false-negative rates."
    - name: "avg_coefficient_of_variation_pct"
      expr: AVG(CAST(coefficient_of_variation_pct AS DOUBLE))
      comment: "Average coefficient of variation (%) across assays. Measures assay reproducibility — high CV indicates unreliable data that inflates downstream attrition costs."
    - name: "regulatory_eligible_assay_count"
      expr: COUNT(CASE WHEN regulatory_submission_eligible = TRUE THEN 1 END)
      comment: "Number of assays eligible for regulatory submissions. Tracks the regulatory-grade assay capability — insufficient regulatory-grade assays create bottlenecks in IND filing timelines."
    - name: "automation_compatible_assay_count"
      expr: COUNT(CASE WHEN automation_compatible = TRUE THEN 1 END)
      comment: "Number of automation-compatible assays. Automation compatibility is a prerequisite for HTS — tracks the proportion of the assay portfolio accessible for large-scale screening campaigns."
    - name: "distinct_molecular_targets_covered"
      expr: COUNT(DISTINCT molecular_target_id)
      comment: "Number of distinct molecular targets with validated assays. Measures assay coverage of the target portfolio — gaps indicate targets that cannot yet be screened, blocking discovery programs."
$$;
