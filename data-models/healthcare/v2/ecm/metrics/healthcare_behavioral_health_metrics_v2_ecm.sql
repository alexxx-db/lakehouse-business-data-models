-- Metric views for domain: behavioral_health | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_crisis_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Behavioral health crisis response KPIs: acuity mix, involuntary hold rates, safety-plan completion, and mobile crisis utilization. Steers crisis staffing and patient-safety interventions."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`crisis_episode`"
  dimensions:
    - name: "crisis_type"
      expr: crisis_type
      comment: "Type of crisis presentation (e.g., psychiatric, SUD, mixed)."
    - name: "crisis_severity"
      expr: crisis_severity
      comment: "Clinician-rated severity of the crisis episode."
    - name: "crisis_status"
      expr: crisis_status
      comment: "Current lifecycle status of the crisis episode."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the crisis episode (admit, discharge, transfer, etc.)."
    - name: "crisis_source"
      expr: crisis_source
      comment: "Origin/channel through which the crisis was reported."
    - name: "crisis_start_month"
      expr: DATE_TRUNC('MONTH', crisis_start_timestamp)
      comment: "Month bucket of crisis onset for trend analysis."
  measures:
    - name: "Crisis Episode Count"
      expr: COUNT(1)
      comment: "Total crisis episodes; baseline volume for crisis-service capacity planning."
    - name: "Suicide Risk Episode Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suicide_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of crisis episodes flagged with suicide risk; drives safety-protocol and staffing decisions."
    - name: "Involuntary Hold Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN involuntary_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of episodes resulting in involuntary hold; monitors legal/clinical escalation intensity."
    - name: "Safety Plan Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_plan_created_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of crisis episodes with a documented safety plan; core quality-of-care compliance metric."
    - name: "Mobile Crisis Team Utilization Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mobile_crisis_team_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of episodes served by a mobile crisis team; informs community-response investment."
    - name: "Law Enforcement Involvement Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_involved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of episodes involving law enforcement; risk/community-relations indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_mat_treatment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication-Assisted Treatment (MAT) effectiveness and compliance KPIs: adherence, take-home dosing, X-waiver coverage, and treatment retention. Steers OUD program quality and regulatory oversight."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`mat_treatment`"
  dimensions:
    - name: "treatment_phase"
      expr: treatment_phase
      comment: "Phase of MAT (induction, stabilization, maintenance)."
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current status of the MAT treatment course."
    - name: "medication_name"
      expr: medication_name
      comment: "MAT medication (e.g., buprenorphine, methadone, naltrexone)."
    - name: "dosing_frequency"
      expr: dosing_frequency
      comment: "Prescribed dosing frequency."
    - name: "treatment_start_month"
      expr: DATE_TRUNC('MONTH', treatment_start_date)
      comment: "Month bucket of treatment start for cohort trend analysis."
  measures:
    - name: "MAT Treatment Count"
      expr: COUNT(1)
      comment: "Total MAT treatment courses; baseline for OUD program volume."
    - name: "Avg Adherence Rate"
      expr: ROUND(AVG(CAST(adherence_rate AS DOUBLE)), 2)
      comment: "Average medication adherence rate across MAT courses; key treatment-effectiveness KPI."
    - name: "Take Home Dose Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN take_home_dose_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of courses with take-home dosing privileges; program-progression and risk indicator."
    - name: "DEA X Waiver Coverage Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dea_x_waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of courses prescribed under a DEA X-waiver; regulatory-capacity monitoring."
    - name: "Active Treatment Retention Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN treatment_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of MAT courses still active; treatment-retention outcome KPI."
    - name: "Avg Dose Amount"
      expr: ROUND(AVG(CAST(dose_amount AS DOUBLE)), 2)
      comment: "Average prescribed dose amount; dosing-pattern and titration oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_otp_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opioid Treatment Program (OTP) enrollment KPIs: take-home privilege progression, central-registry reporting, and Part 2 consent coverage. Steers SAMHSA compliance and program capacity."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current OTP enrollment status."
    - name: "program_type"
      expr: program_type
      comment: "OTP program type/model."
    - name: "phase_level"
      expr: phase_level
      comment: "Patient phase level within the OTP take-home schedule."
    - name: "take_home_privilege_level"
      expr: take_home_privilege_level
      comment: "Assigned take-home privilege tier."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month bucket of OTP enrollment for trend analysis."
  measures:
    - name: "OTP Enrollment Count"
      expr: COUNT(1)
      comment: "Total OTP enrollments; baseline program-census metric."
    - name: "Take Home Authorization Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN take_home_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollees with take-home authorization; progression and diversion-risk indicator."
    - name: "Central Registry Reported Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN central_registry_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments reported to the central registry; regulatory-compliance KPI."
    - name: "Part 2 Consent On File Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN part2_consent_on_file = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments with 42 CFR Part 2 consent on file; privacy-compliance KPI."
    - name: "Take Home Dose Eligibility Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN take_home_dose_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollees eligible for take-home doses; program-progression outcome metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_part2_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 consent-management KPIs: signed/active consent coverage, revocation rates, redisclosure prohibition, and expiration tracking. Core privacy-compliance surveillance for SUD data disclosure."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`part2_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the Part 2 consent (active, expired, revoked)."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of Part 2 consent form."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of disclosure authorized by the consent."
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Stated purpose of the authorized disclosure."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month bucket of consent capture for trend analysis."
  measures:
    - name: "Part 2 Consent Count"
      expr: COUNT(1)
      comment: "Total Part 2 consent records; baseline for consent-governance volume."
    - name: "Patient Signature Present Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_signature_present_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents with a captured patient signature; documentation-completeness KPI."
    - name: "Consent Revocation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revoked_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents revoked; patient-trust and disclosure-risk indicator."
    - name: "Redisclosure Prohibition Coverage Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redisclosure_prohibited_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents carrying the redisclosure-prohibition notice; Part 2 compliance KPI."
    - name: "CFR Part 2 Applicable Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cfr_part2_applicable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents flagged as subject to 42 CFR Part 2; scopes protected-data governance workload."
    - name: "Segmented Data Handling Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN segmented_data_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents requiring data segmentation; measures sensitive-data segregation coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_psychiatric_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standardized psychiatric screening KPIs (PHQ-9, GAD-7, C-SSRS): screening volume, suicide-risk detection, follow-up compliance, and severity scoring. Steers behavioral-health quality and safety programs."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of psychiatric assessment performed."
    - name: "assessment_instrument"
      expr: assessment_instrument
      comment: "Standardized instrument used (PHQ-9, GAD-7, C-SSRS, etc.)."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (complete, in-progress)."
    - name: "severity_level"
      expr: severity_level
      comment: "Interpreted severity band of the assessment result."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month bucket of assessment date for screening-trend analysis."
  measures:
    - name: "Psychiatric Assessment Count"
      expr: COUNT(1)
      comment: "Total standardized assessments administered; screening-throughput baseline."
    - name: "Avg Total Score"
      expr: ROUND(AVG(CAST(total_score AS DOUBLE)), 2)
      comment: "Average standardized instrument total score; population symptom-burden indicator."
    - name: "Suicidal Ideation Detection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suicidal_ideation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments detecting suicidal ideation; drives safety-escalation protocols."
    - name: "Follow Up Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments requiring follow-up; care-continuity and workload indicator."
    - name: "Safety Plan Documented Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_plan_documented = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments with a documented safety plan; safety-compliance quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`behavioral_health_sud_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Substance Use Disorder (SUD) episode KPIs: relapse rate, level-of-care mix, Part 2 consent coverage, and active-episode census. Steers SUD program outcomes and ASAM placement decisions."
  source: "`vibe_healthcare_v1`.`behavioral_health`.`sud_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the SUD episode (open, closed)."
    - name: "primary_substance"
      expr: primary_substance
      comment: "Primary substance associated with the episode."
    - name: "asam_level_of_care"
      expr: asam_level_of_care
      comment: "ASAM level-of-care placement for the episode."
    - name: "treatment_setting"
      expr: treatment_setting
      comment: "Treatment setting (inpatient, outpatient, residential)."
    - name: "episode_start_month"
      expr: DATE_TRUNC('MONTH', episode_start_date)
      comment: "Month bucket of episode start for cohort trend analysis."
  measures:
    - name: "SUD Episode Count"
      expr: COUNT(1)
      comment: "Total SUD episodes; baseline for program census and demand planning."
    - name: "Relapse Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN relapse_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of episodes flagged with relapse; core treatment-outcome KPI."
    - name: "Active Episode Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN episode_status = 'open' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of episodes currently open; active-caseload steering metric."
    - name: "Part 2 Consent On File Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN part2_consent_on_file = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of SUD episodes with Part 2 consent on file; privacy-compliance KPI."
    - name: "Distinct Patient Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with SUD episodes; deduplicated program-reach measure."
$$;