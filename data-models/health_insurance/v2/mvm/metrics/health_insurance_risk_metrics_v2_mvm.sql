-- Metric views for domain: risk | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over member risk scores. Tracks RAF score performance, risk score accuracy, CMS submission quality, and HCC burden across the member population. Used by actuarial, risk adjustment, and finance teams to steer payment accuracy and compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  filter: is_active = TRUE
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "The CMS payment year associated with the risk score, used to trend RAF performance year-over-year."
    - name: "risk_score_type"
      expr: risk_score_type
      comment: "Classification of the risk score (e.g., initial, mid-year, final), enabling comparison across score submission stages."
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current processing status of the risk score record (e.g., submitted, accepted, rejected), used to monitor pipeline health."
    - name: "model_name"
      expr: model_name
      comment: "Name of the CMS risk adjustment model used (e.g., CMS-HCC, RxHCC), enabling model-level performance comparison."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk adjustment model applied, supporting version-over-version accuracy analysis."
    - name: "risk_adjustment_factor_category"
      expr: risk_adjustment_factor_category
      comment: "Category of the risk adjustment factor (e.g., community, institutional), used to segment population risk profiles."
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of the CMS submission for this risk score record, critical for compliance and resubmission tracking."
    - name: "variance_category"
      expr: variance_category
      comment: "Categorization of the score variance between plan-calculated and CMS-published scores, used to prioritize correction efforts."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Indicates whether the risk score was manually overridden, used to audit data integrity and override frequency."
    - name: "score_effective_date_month"
      expr: DATE_TRUNC('MONTH', score_effective_date)
      comment: "Month of the score effective date, enabling monthly trending of risk score submissions and RAF values."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the risk score coverage period begins, used for annual cohort analysis."
  measures:
    - name: "total_members_scored"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Total unique members with an active risk score. Baseline population metric for all RAF and HCC analyses."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average Risk Adjustment Factor (RAF) score across the scored population. A primary actuarial KPI — rising RAF indicates higher predicted cost burden; falling RAF may signal under-coding or population health improvement."
    - name: "total_raf_score"
      expr: SUM(CAST(raf_score AS DOUBLE))
      comment: "Sum of all RAF scores across the population. Used to estimate total expected payment liability and compare against CMS-published totals."
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average risk score as calculated by the health plan. Compared against avg_raf_score and avg_cms_published_score to identify systematic coding gaps."
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score. The authoritative benchmark against which plan-calculated scores are reconciled for payment accuracy."
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan-calculated and CMS-published scores. Negative variance indicates under-coding risk; positive variance may trigger audit scrutiny."
    - name: "total_score_variance"
      expr: SUM(CAST(score_variance AS DOUBLE))
      comment: "Aggregate score variance across all members. Quantifies the total financial exposure from coding discrepancies between plan and CMS."
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic adjustment component of the risk score. Tracks the contribution of age/gender factors to overall RAF, informing enrollment strategy."
    - name: "avg_hcc_count_per_member"
      expr: AVG(CAST(hcc_count AS DOUBLE))
      comment: "Average number of Hierarchical Condition Categories (HCCs) per member. A key indicator of coding completeness and chronic disease burden in the population."
    - name: "total_hcc_count"
      expr: SUM(CAST(hcc_count AS DOUBLE))
      comment: "Total HCC diagnoses captured across all scored members. Used to assess overall coding volume and identify gaps versus benchmark populations."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk score records that were manually overridden. High rates signal data quality issues or process breakdowns requiring investigation."
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average model confidence score for risk score predictions. Low confidence scores indicate unreliable RAF estimates that may require clinical review or data remediation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_score_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and actuarial KPI layer over risk score run executions. Monitors population-level RAF performance, model run quality, and normalization across CMS model years. Used by actuarial and risk adjustment operations teams."
  source: "`vibe_health_insurance_v1`.`risk`.`score_run`"
  filter: is_active = TRUE
  dimensions:
    - name: "cms_model_year"
      expr: cms_model_year
      comment: "CMS model year for the score run, enabling year-over-year comparison of population RAF and normalization trends."
    - name: "model_name"
      expr: model_name
      comment: "Name of the risk adjustment model used in the run (e.g., CMS-HCC V24, V28), supporting model migration impact analysis."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model applied, used to track model upgrade impacts on population RAF scores."
    - name: "run_type"
      expr: run_type
      comment: "Type of score run (e.g., initial, mid-year, final, prospective), used to compare RAF trajectories across submission cycles."
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the score run (e.g., completed, failed, in-progress), used to monitor pipeline reliability."
    - name: "model_status"
      expr: model_status
      comment: "Approval or validation status of the model used in the run, ensuring only certified models drive payment calculations."
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (e.g., prospective, concurrent), used to segment RAF analysis by prediction methodology."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment covered by the score run (e.g., ESRD, aged/disabled, community), enabling segment-level RAF benchmarking."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the score run execution date, used to track run frequency and RAF trends over time."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the score run input data, used to filter or flag runs with compromised input quality."
  measures:
    - name: "total_score_runs"
      expr: COUNT(1)
      comment: "Total number of score runs executed. Baseline operational metric for monitoring run cadence and pipeline throughput."
    - name: "avg_population_raf_score"
      expr: AVG(CAST(average_raf_score AS DOUBLE))
      comment: "Average of the population-level average RAF scores across all score runs. The primary actuarial KPI for tracking risk score trends and CMS payment adequacy."
    - name: "total_population_raf_score"
      expr: SUM(CAST(total_raf_score AS DOUBLE))
      comment: "Sum of total RAF scores across all score runs. Represents aggregate expected payment liability across the enrolled population."
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average normalization factor applied across score runs. Deviations from 1.0 indicate CMS recalibration impacts on payment rates."
    - name: "total_member_population"
      expr: SUM(CAST(member_population_count AS DOUBLE))
      comment: "Total member-run population count across all score runs. Used to assess coverage completeness and identify population gaps."
    - name: "avg_member_population_per_run"
      expr: AVG(CAST(member_population_count AS DOUBLE))
      comment: "Average number of members included per score run. Significant drops may indicate data feed failures or eligibility processing issues."
    - name: "failed_run_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN run_status = 'FAILED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of score runs that failed execution. High failure rates directly delay CMS submissions and risk payment penalties."
    - name: "data_quality_flagged_run_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_quality_flag IS NOT NULL AND data_quality_flag != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of score runs flagged for data quality issues. Drives prioritization of data remediation efforts before CMS submission deadlines."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and quality KPI layer over HCC-to-ICD10 mappings. Monitors mapping coverage, coefficient distribution, and adjustment factor profiles. Used by clinical coding, risk adjustment, and compliance teams to ensure accurate diagnosis-to-HCC translation."
  source: "`vibe_health_insurance_v1`.`risk`.`hcc_mapping`"
  filter: is_active = TRUE
  dimensions:
    - name: "hcc_code"
      expr: hcc_code
      comment: "The Hierarchical Condition Category code, the primary clinical grouping used in CMS risk adjustment payment models."
    - name: "model_year"
      expr: model_year
      comment: "CMS model year for the HCC mapping, enabling year-over-year comparison of mapping changes and coefficient shifts."
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction grouping for HCC combinations that receive additional risk score credit, used to identify high-value interaction opportunities."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the HCC hierarchy, used to analyze coding at parent vs. child condition levels."
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Current status of the HCC mapping record (e.g., active, deprecated, pending review), used to govern mapping lifecycle."
    - name: "mapping_source"
      expr: mapping_source
      comment: "Source system or authority that produced the HCC mapping, used to assess mapping provenance and reliability."
    - name: "review_status"
      expr: review_status
      comment: "Clinical or compliance review status of the mapping, used to track pending reviews and ensure mapping accuracy."
    - name: "is_mapped"
      expr: is_mapped
      comment: "Indicates whether the ICD-10 code has been successfully mapped to an HCC, used to identify unmapped diagnosis gaps."
    - name: "is_excluded"
      expr: is_excluded
      comment: "Indicates whether the mapping is excluded from risk score calculations, used to audit exclusion patterns."
    - name: "interaction_flag"
      expr: interaction_flag
      comment: "Flag indicating whether this HCC participates in a disease interaction group, used to identify interaction coding opportunities."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the HCC mapping became effective, used to track mapping vintage and identify stale mappings."
  measures:
    - name: "total_active_mappings"
      expr: COUNT(1)
      comment: "Total active HCC-to-ICD10 mappings. Baseline governance metric for monitoring mapping catalog completeness."
    - name: "total_mapped_icd10_codes"
      expr: COUNT(DISTINCT icd10_code)
      comment: "Number of unique ICD-10 codes with active HCC mappings. Measures coding coverage breadth — gaps indicate potential RAF revenue leakage."
    - name: "total_mapped_hcc_codes"
      expr: COUNT(DISTINCT hcc_code)
      comment: "Number of unique HCC codes covered by active mappings. Tracks the clinical condition coverage of the risk model."
    - name: "avg_hcc_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient (risk weight) across active mappings. Higher coefficients indicate higher-acuity conditions; shifts signal model recalibration impacts on payment."
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor across HCC mappings. Tracks the demographic adjustment contribution to risk scores across the mapping catalog."
    - name: "avg_gender_adjustment_factor"
      expr: AVG(CAST(gender_adjustment_factor AS DOUBLE))
      comment: "Average gender adjustment factor across HCC mappings. Used to assess gender-based risk weighting distribution in the model."
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight assigned to HCC mappings. Directly reflects the payment impact per mapped condition — a key actuarial calibration metric."
    - name: "unmapped_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mapped = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC mapping records where the ICD-10 code is not yet mapped. High rates indicate coding gaps that reduce RAF scores and CMS payments."
    - name: "excluded_mapping_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mappings excluded from risk score calculations. Unexpectedly high exclusion rates may indicate systematic coding suppression requiring compliance review."
    - name: "interaction_eligible_mapping_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interaction_flag IS NOT NULL AND interaction_flag != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mappings eligible for disease interaction group credit. Tracks the opportunity to capture additional RAF value from comorbidity coding."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and financial risk KPI layer over RADV (Risk Adjustment Data Validation) audits. Monitors audit error rates, payment error exposure, settlement amounts, and HCC validation outcomes. Used by compliance, legal, and finance teams to manage CMS audit risk."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  filter: is_active = TRUE
  dimensions:
    - name: "audit_year"
      expr: audit_year
      comment: "CMS audit year, used to track RADV audit outcomes and financial exposure trends year-over-year."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (e.g., contract-level, targeted, validation), used to segment audit risk by audit methodology."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., open, closed, appealed), used to monitor audit pipeline and resolution velocity."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against the audit finding, used to track appeal success rates and financial recovery."
    - name: "audit_source"
      expr: audit_source
      comment: "Source or initiator of the audit (e.g., CMS, internal, third-party), used to differentiate regulatory vs. proactive audit activity."
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record requests for the audit, used to track documentation completeness and submission timeliness."
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Boolean flag indicating whether an audit error was identified, used as a primary filter for error rate analysis."
    - name: "hcc_mapping_version"
      expr: hcc_mapping_version
      comment: "Version of the HCC mapping used during the audit, used to assess whether mapping version differences contributed to audit errors."
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_timestamp)
      comment: "Month the audit began, used to trend audit volume and error rates over time."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of RADV audit records. Baseline metric for audit volume monitoring and resource planning."
    - name: "audit_error_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audited records with identified errors. The primary RADV compliance KPI — CMS uses this rate to extrapolate payment recovery amounts across the full contract."
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error amount across all audited records. Represents the estimated financial liability from CMS payment recoupment — a critical CFO-level risk metric."
    - name: "avg_extrapolated_payment_error"
      expr: AVG(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Average extrapolated payment error per audit record. Used to benchmark per-member audit risk and prioritize remediation investments."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts paid or received across closed RADV audits. Represents realized financial impact of CMS audit outcomes on plan financials."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across audited records. Compared against plan-submitted RAF to quantify systematic over- or under-coding identified by CMS auditors."
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit records with an active or completed appeal. Tracks the plan's use of the appeals process to recover from adverse audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_raps_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS submission quality and compliance KPI layer over RAPS (Risk Adjustment Processing System) submissions. Monitors submission acceptance rates, rejection rates, risk score trends, and payment year coverage. Used by risk adjustment operations and compliance teams."
  source: "`vibe_health_insurance_v1`.`risk`.`raps_submission`"
  filter: is_active = TRUE
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for the RAPS submission, used to track submission performance and risk score trends by payment year."
    - name: "risk_adjustment_year"
      expr: risk_adjustment_year
      comment: "Risk adjustment data year for the submission, used to align submission activity with the correct data collection period."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (e.g., MA, PDP, MAPD) associated with the submission, enabling plan-type-level submission quality analysis."
    - name: "raps_submission_status"
      expr: raps_submission_status
      comment: "Current status of the RAPS submission (e.g., submitted, accepted, rejected, pending), used to monitor submission pipeline health."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status for the submission file, the authoritative indicator of whether CMS accepted the submission for processing."
    - name: "plan_contract_number"
      expr: plan_contract_number
      comment: "CMS contract number for the submitting plan, used to segment submission quality by contract."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission, used to track submission cadence and identify late or missing submission cycles."
    - name: "error_disposition"
      expr: error_disposition
      comment: "Disposition category for submission errors, used to classify and prioritize error remediation by error type."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of RAPS submission records. Baseline metric for submission volume monitoring and operational throughput."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across RAPS submissions. Tracks the RAF value being submitted to CMS — the primary revenue driver for MA plans."
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across all RAPS submissions. Represents total risk-adjusted payment basis submitted to CMS for the period."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor submitted across all RAPS records. Compared against CMS-published factors to identify systematic submission discrepancies."
    - name: "cms_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_acknowledgment_status = 'ACCEPTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RAPS submissions acknowledged as accepted by CMS. The primary submission quality KPI — low acceptance rates directly reduce risk-adjusted payments."
    - name: "cms_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_acknowledgment_status = 'REJECTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RAPS submissions rejected by CMS. Drives immediate operational response — rejected submissions must be corrected and resubmitted before payment deadlines."
$$;