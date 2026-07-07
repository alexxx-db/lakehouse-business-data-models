-- Metric views for domain: post_acute | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`post_acute_home_health_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Home health episode KPIs for utilization, reimbursement, and episode management steering."
  source: "`vibe_healthcare_v1`.`post_acute`.`home_health_episode`"
  dimensions:
    - name: "episode_status"
      expr: home_health_episode_status
      comment: "Current lifecycle status of the home health episode (active, discharged, etc.)."
    - name: "discipline_types"
      expr: discipline_types
      comment: "Clinical disciplines delivering care during the episode (nursing, PT, OT, etc.)."
    - name: "hhrg_code"
      expr: hhrg_code
      comment: "Home Health Resource Group code driving case-mix and reimbursement."
    - name: "hipps_code"
      expr: hipps_code
      comment: "HIPPS payment classification code for the episode."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis driving the episode of care."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral into home health (hospital, physician, etc.)."
    - name: "start_of_care_month"
      expr: DATE_TRUNC('MONTH', start_of_care_date)
      comment: "Month of start-of-care for episode volume trending."
    - name: "certification_period_start_month"
      expr: DATE_TRUNC('MONTH', certification_period_start)
      comment: "Month the certification period begins for compliance trending."
  measures:
    - name: "episode_count"
      expr: COUNT(1)
      comment: "Total number of home health episodes — baseline volume metric for capacity planning."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients served by home health — panel size for population health steering."
    - name: "total_episode_payment"
      expr: SUM(CAST(episode_payment_amount AS DOUBLE))
      comment: "Total home health episode reimbursement — top-line revenue driver."
    - name: "avg_episode_payment"
      expr: AVG(CAST(episode_payment_amount AS DOUBLE))
      comment: "Average reimbursement per episode — case-mix and pricing efficiency indicator."
    - name: "total_episode_amount"
      expr: SUM(CAST(episode_amount AS DOUBLE))
      comment: "Total billed episode amount — used with payment to assess yield."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`post_acute_hospice_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hospice episode KPIs for census, level-of-care mix, and per-diem revenue steering."
  source: "`vibe_healthcare_v1`.`post_acute`.`hospice_episode`"
  dimensions:
    - name: "episode_status"
      expr: hospice_episode_status
      comment: "Current lifecycle status of the hospice episode."
    - name: "level_of_care"
      expr: level_of_care
      comment: "Hospice level of care (routine, continuous, respite, inpatient) driving per-diem rate."
    - name: "benefit_period"
      expr: benefit_period
      comment: "Medicare hospice benefit period classification."
    - name: "discharge_reason"
      expr: discharge_reason
      comment: "Reason the hospice episode ended (death, revocation, transfer)."
    - name: "terminal_diagnosis_code"
      expr: terminal_diagnosis_code
      comment: "Terminal diagnosis certifying hospice eligibility."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of hospice admission for census trending."
  measures:
    - name: "episode_count"
      expr: COUNT(1)
      comment: "Total hospice episodes — baseline census/volume metric."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients on hospice service — census steering metric."
    - name: "total_per_diem"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per-diem revenue across hospice episodes — revenue driver."
    - name: "avg_per_diem"
      expr: AVG(CAST(per_diem_amount AS DOUBLE))
      comment: "Average per-diem rate — level-of-care mix and pricing indicator."
    - name: "advance_directive_on_file_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN advance_directive_on_file = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of hospice episodes with an advance directive on file — quality/compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`post_acute_snf_stay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skilled nursing facility stay KPIs for length-of-stay, readmission, and PDPM reimbursement steering."
  source: "`vibe_healthcare_v1`.`post_acute`.`snf_stay`"
  dimensions:
    - name: "stay_status"
      expr: snf_stay_status
      comment: "Current lifecycle status of the SNF stay."
    - name: "admission_source"
      expr: admission_source
      comment: "Source of admission into the SNF (hospital, community, etc.)."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition from the SNF stay."
    - name: "rug_pdpm_code"
      expr: rug_pdpm_code
      comment: "PDPM classification code driving reimbursement case-mix."
    - name: "rug_iv_group"
      expr: rug_iv_group
      comment: "RUG-IV group classification for case-mix analysis."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis for the SNF stay."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of SNF admission for volume trending."
  measures:
    - name: "stay_count"
      expr: COUNT(1)
      comment: "Total SNF stays — baseline volume metric for capacity planning."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with a SNF stay — panel size metric."
    - name: "total_daily_rate_revenue"
      expr: SUM(CAST(daily_rate AS DOUBLE))
      comment: "Total daily-rate revenue across stays — revenue driver."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate — pricing and case-mix efficiency indicator."
    - name: "readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of SNF stays flagged as readmissions — critical quality/cost KPI for value-based care."
$$;