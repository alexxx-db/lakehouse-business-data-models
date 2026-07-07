-- Metric views for domain: clinical_ai | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_patient_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive clinical risk KPIs (readmission, sepsis, fall, deterioration) used by clinical leadership to target interventions and monitor model-driven care escalation."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk stratification bucket (e.g. low/medium/high) for cohort analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the patient score for prioritization."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk being scored (readmission, sepsis, fall, deterioration)."
    - name: "risk_model_name"
      expr: risk_model_name
      comment: "Name of the risk model that produced the score."
    - name: "risk_model_version"
      expr: risk_model_version
      comment: "Version of the risk model for lineage-aware performance comparison."
    - name: "score_month"
      expr: DATE_TRUNC('MONTH', score_date)
      comment: "Month the risk score was generated, for trend analysis."
  measures:
    - name: "Scored Patient Records"
      expr: COUNT(1)
      comment: "Total number of risk score records produced — model coverage volume."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average predicted risk score across the cohort — population risk burden signal."
    - name: "Avg Readmission Risk Score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk — informs discharge planning and care management staffing."
    - name: "Avg Sepsis Risk Score"
      expr: AVG(CAST(sepsis_risk_score AS DOUBLE))
      comment: "Average sepsis risk — drives early-warning surveillance decisions."
    - name: "Avg Deterioration Risk Score"
      expr: AVG(CAST(deterioration_risk_score AS DOUBLE))
      comment: "Average deterioration index — supports rapid-response team resourcing."
    - name: "Alert Triggered Count"
      expr: SUM(CASE WHEN alert_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of scores that triggered a clinical alert — measures alert burden."
    - name: "Intervention Recommended Count"
      expr: SUM(CASE WHEN intervention_recommended_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Scores where an intervention was recommended — downstream care action volume."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap closure KPIs used by population health and quality leaders to steer outreach investment and quality program performance."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`care_gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (e.g. screening, immunization) for measure-level analysis."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (open/closed/excluded)."
    - name: "priority"
      expr: priority
      comment: "Care gap priority for outreach prioritization."
    - name: "closure_method"
      expr: closure_method
      comment: "How the gap was closed for outreach effectiveness analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the gap was identified, for trend and backlog analysis."
  measures:
    - name: "Total Care Gaps"
      expr: COUNT(1)
      comment: "Total identified care gaps — overall quality opportunity volume."
    - name: "Closed Care Gaps"
      expr: SUM(CASE WHEN closed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of closed gaps — quality improvement throughput."
    - name: "Open Care Gaps"
      expr: SUM(CASE WHEN open_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of open gaps — the actionable outreach backlog."
    - name: "Excluded Care Gaps"
      expr: SUM(CASE WHEN exclusion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of excluded gaps — impacts measure denominator accuracy."
    - name: "Care Gap Closure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of care gaps closed — headline quality program KPI."
    - name: "Outreach Attempted Count"
      expr: SUM(CASE WHEN outreach_attempted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Gaps where outreach was attempted — engagement effort volume."
    - name: "Distinct Patients With Gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with at least one care gap — outreach population size."
    - name: "Avg Care Gap Priority Score"
      expr: AVG(CAST(care_gap_priority_score AS DOUBLE))
      comment: "Average priority score — helps rank cohorts for intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_model_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI model governance and performance KPIs used by AI governance committees to steer deployment, review cadence, and regulatory posture."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`model_card`"
  dimensions:
    - name: "model_type"
      expr: model_type
      comment: "Type/category of the model for governance segmentation."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Deployment lifecycle status of the model."
    - name: "approval_status"
      expr: approval_status
      comment: "Governance approval status of the model."
    - name: "fda_samd_class"
      expr: fda_samd_class
      comment: "FDA Software-as-a-Medical-Device classification for regulatory risk analysis."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory clearance status of the model."
  measures:
    - name: "Total Models"
      expr: COUNT(1)
      comment: "Total registered model cards — AI portfolio size."
    - name: "Deployed Model Count"
      expr: SUM(CASE WHEN deployed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deployed models — production AI footprint."
    - name: "Approved Model Count"
      expr: SUM(CASE WHEN approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Governance-approved models — compliance-cleared inventory."
    - name: "Retired Model Count"
      expr: SUM(CASE WHEN retired_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Retired models — lifecycle turnover signal."
    - name: "Model Deployment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deployed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of models deployed to production — AI operationalization efficiency."
    - name: "Avg AUC ROC"
      expr: AVG(CAST(auc_roc AS DOUBLE))
      comment: "Average AUC-ROC across models — portfolio predictive quality."
    - name: "Avg Precision"
      expr: AVG(CAST(precision_metric AS DOUBLE))
      comment: "Average precision — false-positive burden signal across the portfolio."
    - name: "Avg Recall"
      expr: AVG(CAST(recall_metric AS DOUBLE))
      comment: "Average recall — missed-case risk signal across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_bias_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI fairness and bias monitoring KPIs used by AI governance and compliance leaders to detect algorithmic disparity and steer remediation."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring`"
  dimensions:
    - name: "protected_attribute"
      expr: protected_attribute
      comment: "Protected attribute being evaluated for bias (e.g. race, sex, age)."
    - name: "fairness_metric"
      expr: fairness_metric
      comment: "Fairness metric used in the evaluation."
    - name: "monitored_subgroup"
      expr: monitored_subgroup
      comment: "Subgroup being monitored for disparate outcomes."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation action for detected bias."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of bias evaluation, for trend monitoring."
  measures:
    - name: "Bias Evaluations"
      expr: COUNT(1)
      comment: "Total bias monitoring evaluations run — fairness oversight coverage."
    - name: "Bias Detected Count"
      expr: SUM(CASE WHEN bias_detected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Evaluations where bias was detected — the actionable fairness risk count."
    - name: "Threshold Breach Count"
      expr: SUM(CASE WHEN threshold_breached_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Evaluations breaching fairness thresholds — triggers remediation."
    - name: "Bias Detection Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN bias_detected_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of evaluations detecting bias — headline algorithmic fairness KPI."
    - name: "Avg Disparate Impact Ratio"
      expr: AVG(CAST(disparate_impact_ratio AS DOUBLE))
      comment: "Average disparate impact ratio — magnitude of subgroup outcome disparity."
    - name: "Avg Equal Opportunity Difference"
      expr: AVG(CAST(equal_opportunity_difference AS DOUBLE))
      comment: "Average equal-opportunity difference — fairness gap severity."
    - name: "Models Monitored"
      expr: COUNT(DISTINCT model_card_id)
      comment: "Distinct models covered by bias monitoring — governance breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_clinical_nlp_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical NLP extraction quality KPIs used by data science and CDI leaders to steer NLP pipeline investment and code-capture reliability."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of extracted clinical entity (diagnosis, medication, procedure)."
    - name: "entity_category"
      expr: entity_category
      comment: "Category grouping of the extracted entity."
    - name: "code_system"
      expr: code_system
      comment: "Terminology code system the entity was mapped to (ICD, SNOMED, LOINC)."
    - name: "nlp_model_name"
      expr: nlp_model_name
      comment: "NLP model that produced the extraction, for model comparison."
    - name: "extraction_month"
      expr: DATE_TRUNC('MONTH', extracted_at)
      comment: "Month of extraction, for pipeline throughput trends."
  measures:
    - name: "Extracted Entities"
      expr: COUNT(1)
      comment: "Total NLP-extracted entities — pipeline output volume."
    - name: "Avg Confidence Score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average extraction confidence — NLP reliability signal driving human-review policy."
    - name: "Negated Entity Count"
      expr: SUM(CASE WHEN negation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Entities marked negated — critical for avoiding false positive code capture."
    - name: "Uncertain Entity Count"
      expr: SUM(CASE WHEN uncertainty_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Entities flagged uncertain — candidates for clinician validation."
    - name: "Family History Entity Count"
      expr: SUM(CASE WHEN family_history_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Entities attributed to family history — prevents attribution errors in coding."
    - name: "Notes Processed"
      expr: COUNT(DISTINCT note_id)
      comment: "Distinct clinical notes processed by NLP — documentation coverage."
    - name: "Patients Covered"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with NLP-derived data — analytic population reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_model_inference_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Model serving operations KPIs used by ML engineering leaders to steer reliability, latency, and drift management of production AI."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`model_inference_log`"
  dimensions:
    - name: "inference_type"
      expr: inference_type
      comment: "Batch vs real-time inference type for operational segmentation."
    - name: "serving_environment"
      expr: serving_environment
      comment: "Serving environment (prod/staging) for reliability tracking."
    - name: "endpoint_name"
      expr: endpoint_name
      comment: "Serving endpoint name for per-endpoint monitoring."
    - name: "prediction_label"
      expr: prediction_label
      comment: "Predicted class label for outcome distribution analysis."
    - name: "inference_month"
      expr: DATE_TRUNC('MONTH', inference_at)
      comment: "Month of inference, for volume and drift trends."
  measures:
    - name: "Total Inferences"
      expr: COUNT(1)
      comment: "Total model inference calls — production AI utilization volume."
    - name: "Error Inference Count"
      expr: SUM(CASE WHEN error_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Inferences that errored — serving reliability risk."
    - name: "Inference Error Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN error_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of failed inferences — headline serving reliability KPI."
    - name: "Drift Detected Count"
      expr: SUM(CASE WHEN drift_detected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Inferences where drift was detected — triggers model retraining decisions."
    - name: "Avg Prediction Confidence"
      expr: AVG(CAST(prediction_confidence AS DOUBLE))
      comment: "Average prediction confidence — model certainty signal in production."
    - name: "Avg Output Probability"
      expr: AVG(CAST(output_probability AS DOUBLE))
      comment: "Average predicted probability — production score distribution indicator."
    - name: "Models Serving"
      expr: COUNT(DISTINCT model_card_id)
      comment: "Distinct models actively serving inferences — production portfolio activity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_samd_regulatory_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SaMD regulatory compliance KPIs used by regulatory affairs and AI governance to steer FDA submission pipeline and clearance posture."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking`"
  dimensions:
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "FDA regulatory pathway (510k, De Novo, PMA) for submission strategy analysis."
    - name: "samd_class"
      expr: samd_class
      comment: "SaMD classification for regulatory risk segmentation."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance status of the SaMD."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Governing regulatory body for jurisdiction analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of regulatory submission, for pipeline throughput."
  measures:
    - name: "Regulatory Records"
      expr: COUNT(1)
      comment: "Total SaMD regulatory tracking records — regulatory portfolio size."
    - name: "Cleared SaMD Count"
      expr: SUM(CASE WHEN cleared_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cleared SaMD devices — market-ready AI inventory."
    - name: "SaMD Clearance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cleared_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of SaMD submissions cleared — regulatory success KPI."
    - name: "Clinical Validation Required Count"
      expr: SUM(CASE WHEN clinical_validation_required = TRUE THEN 1 ELSE 0 END)
      comment: "SaMD requiring clinical validation — resource-planning signal for regulatory affairs."
    - name: "Predetermined Change Control Count"
      expr: SUM(CASE WHEN predetermined_change_control_plan_flag = TRUE THEN 1 ELSE 0 END)
      comment: "SaMD with predetermined change control plans — modern FDA compliance readiness."
    - name: "Models Under Regulatory Tracking"
      expr: COUNT(DISTINCT model_card_id)
      comment: "Distinct models under regulatory tracking — governance coverage of AI portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_ai_feature_store_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feature store operations KPIs used by ML platform leaders to steer feature freshness, online/offline coverage, and point-in-time correctness."
  source: "`vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity`"
  dimensions:
    - name: "entity_level"
      expr: entity_level
      comment: "Entity grain of the feature (patient/encounter) for coverage analysis."
    - name: "feature_group_name"
      expr: feature_group_name
      comment: "Feature group name for grouping-level monitoring."
    - name: "feature_data_type"
      expr: feature_data_type
      comment: "Data type of the feature value for schema analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the feature snapshot, for freshness trends."
  measures:
    - name: "Feature Records"
      expr: COUNT(1)
      comment: "Total feature store entity records — feature catalog volume."
    - name: "Current Feature Count"
      expr: SUM(CASE WHEN is_current_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Features marked current — freshness of the feature store."
    - name: "Online Feature Count"
      expr: SUM(CASE WHEN is_online_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Features available online — real-time serving readiness."
    - name: "Point In Time Correct Count"
      expr: SUM(CASE WHEN point_in_time_correct_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Features validated for point-in-time correctness — training-serving skew prevention."
    - name: "Online Feature Coverage Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_online_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of features served online — real-time ML enablement KPI."
    - name: "Distinct Feature Groups"
      expr: COUNT(DISTINCT feature_group_name)
      comment: "Distinct feature groups maintained — feature engineering breadth."
    - name: "Patients With Features"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with computed features — analytic population coverage."
$$;