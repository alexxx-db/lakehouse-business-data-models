-- Metric views for domain: reference | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPIs over reference code set versions (ICD, CPT, HCPCS, etc.) tracking load quality, validation, and HIPAA compliance posture of the terminology supply chain."
  source: "`vibe_healthcare_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_type"
      expr: code_set_type
      comment: "Type of code set (e.g., ICD, CPT, HCPCS, LOINC) for portfolio segmentation."
    - name: "version_status"
      expr: version_status
      comment: "Lifecycle status of the code set version (active, superseded, deprecated)."
    - name: "load_status"
      expr: load_status
      comment: "Load pipeline outcome for the version, used to spot ingestion failures."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome, used to flag versions unsafe for downstream coding."
    - name: "source_authority"
      expr: source_authority
      comment: "Publishing authority of the code set (CMS, AMA, WHO) for source risk analysis."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year the version applies to."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month for trending version rollouts over time."
  measures:
    - name: "Version Count"
      expr: COUNT(1)
      comment: "Number of code set versions in scope; baseline for portfolio sizing."
    - name: "Distinct Code Sets Managed"
      expr: COUNT(DISTINCT code_set_name)
      comment: "Count of distinct code sets governed; measures terminology coverage breadth."
    - name: "HIPAA Compliant Version Count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END)
      comment: "Versions flagged HIPAA compliant; drives regulatory readiness monitoring."
    - name: "Validated Version Count"
      expr: COUNT(CASE WHEN validation_status = 'VALIDATED' THEN 1 END)
      comment: "Versions passing validation; numerator for validation coverage rate."
    - name: "Failed Load Count"
      expr: COUNT(CASE WHEN load_status = 'FAILED' THEN 1 END)
      comment: "Versions that failed to load; triggers data engineering intervention."
    - name: "Total Records Loaded"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Aggregate reference records loaded across versions; indicates data volume steward burden."
    - name: "Avg Records Per Version"
      expr: AVG(CAST(record_count AS DOUBLE))
      comment: "Average record count per version; helps size ingestion effort and anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG reference KPIs supporting reimbursement analytics: relative weight distribution, expected length of stay, and quality/readmission program flag prevalence."
  source: "`vibe_healthcare_v1`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type (surgical/medical) for reimbursement mix analysis."
    - name: "complication_level"
      expr: complication_level
      comment: "Complication/comorbidity level driving payment tier differentiation."
    - name: "grouper_system"
      expr: grouper_system
      comment: "Grouper system (MS-DRG, APR-DRG) used for the DRG definition."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service line reimbursement views."
  measures:
    - name: "DRG Count"
      expr: COUNT(1)
      comment: "Number of DRG definitions in scope; baseline for grouper coverage."
    - name: "Avg Relative Weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average DRG relative weight; core driver of case-mix index and expected revenue."
    - name: "Avg Geometric Mean LOS"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay; benchmark for utilization management."
    - name: "Avg National Payment"
      expr: AVG(CAST(national_average_payment AS DOUBLE))
      comment: "Average national payment amount; used for reimbursement benchmarking."
    - name: "Readmission Penalty DRG Count"
      expr: COUNT(CASE WHEN readmission_penalty_flag = TRUE THEN 1 END)
      comment: "DRGs subject to readmission penalty; focuses quality improvement effort."
    - name: "Quality Measure DRG Count"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "DRGs tied to quality measures; informs value-based care exposure."
    - name: "Bundled Payment DRG Count"
      expr: COUNT(CASE WHEN bundled_payment_flag = TRUE THEN 1 END)
      comment: "DRGs eligible for bundled payment; sizes episode-of-care opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CPT reference KPIs supporting RVU-based cost and reimbursement modeling and telemedicine eligibility tracking."
  source: "`vibe_healthcare_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "CPT category for service line and modifier analysis."
    - name: "section"
      expr: section
      comment: "CPT section grouping for procedure portfolio views."
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Lifecycle status of the CPT code (active, deleted)."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service line RVU analysis."
  measures:
    - name: "CPT Code Count"
      expr: COUNT(1)
      comment: "Number of CPT codes in scope; baseline coverage measure."
    - name: "Avg Total RVU"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total RVU; core input to physician productivity and cost modeling."
    - name: "Avg Work RVU"
      expr: AVG(CAST(work_rvu AS DOUBLE))
      comment: "Average work RVU; drives clinician compensation benchmarking."
    - name: "Avg National Payment Amount"
      expr: AVG(CAST(national_payment_amount AS DOUBLE))
      comment: "Average national payment amount; supports reimbursement projection."
    - name: "Telemedicine Eligible Count"
      expr: COUNT(CASE WHEN telemedicine_eligible = TRUE THEN 1 END)
      comment: "CPT codes eligible for telemedicine; sizes virtual care billing opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminology crosswalk KPIs measuring mapping quality, coverage, and usage across code systems for interoperability governance."
  source: "`vibe_healthcare_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of mapping (exact, approximate) for quality segmentation."
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Assessed quality tier of the mapping; drives remediation prioritization."
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source code system in the crosswalk for coverage analysis."
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target code system in the crosswalk for coverage analysis."
    - name: "mapping_authority"
      expr: mapping_authority
      comment: "Authority governing the mapping for source trust assessment."
  measures:
    - name: "Crosswalk Count"
      expr: COUNT(1)
      comment: "Number of crosswalk mappings in scope; baseline coverage measure."
    - name: "Approximate Mapping Count"
      expr: COUNT(CASE WHEN approximate_flag = TRUE THEN 1 END)
      comment: "Mappings flagged approximate; measures interoperability precision risk."
    - name: "No Map Count"
      expr: COUNT(CASE WHEN no_map_flag = TRUE THEN 1 END)
      comment: "Entries with no available target map; highlights coverage gaps."
    - name: "Total Mapping Usage"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Aggregate usage across mappings; identifies high-value mappings to maintain."
    - name: "Avg Mapping Usage"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage per mapping; supports prioritization of validation effort."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ICD diagnosis code reference KPIs tracking billable coverage, HAC/CC/MCC severity flags, and coding validity for revenue integrity."
  source: "`vibe_healthcare_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "icd_code_category"
      expr: icd_code_category
      comment: "ICD category for diagnosis portfolio segmentation."
    - name: "chapter"
      expr: chapter
      comment: "ICD chapter grouping for body-system analysis."
    - name: "code_type"
      expr: code_type
      comment: "Code type (ICD-10-CM, ICD-10-PCS) for coding scope views."
  measures:
    - name: "ICD Code Count"
      expr: COUNT(1)
      comment: "Number of ICD codes in scope; baseline coverage measure."
    - name: "Billable Code Count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Codes billable at full specificity; numerator for billable coverage rate."
    - name: "HAC Flagged Count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Hospital-acquired-condition codes; focuses patient safety and payment risk."
    - name: "MCC Flagged Count"
      expr: COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END)
      comment: "Major complication/comorbidity codes; drives case-mix and reimbursement uplift."
    - name: "Valid For Coding Count"
      expr: COUNT(CASE WHEN valid_for_coding_flag = TRUE THEN 1 END)
      comment: "Codes valid for active coding; measures usable diagnosis inventory."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NDC drug reference KPIs supporting formulary and pharmacy safety governance: high-alert, black-box, controlled substance, and vaccine prevalence."
  source: "`vibe_healthcare_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class grouping for formulary analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form for dispensing and inventory segmentation."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled-substance schedule for compliance monitoring."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the drug for coverage analysis."
    - name: "marketing_category"
      expr: marketing_category
      comment: "Marketing category (brand, generic) for cost mix analysis."
  measures:
    - name: "NDC Drug Count"
      expr: COUNT(1)
      comment: "Number of NDC drug records in scope; baseline coverage measure."
    - name: "High Alert Medication Count"
      expr: COUNT(CASE WHEN high_alert_medication_flag = TRUE THEN 1 END)
      comment: "High-alert medications; prioritizes medication safety controls."
    - name: "Black Box Warning Count"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Drugs carrying black-box warnings; informs clinical risk oversight."
    - name: "Vaccine Count"
      expr: COUNT(CASE WHEN vaccine_flag = TRUE THEN 1 END)
      comment: "Vaccine products; supports immunization program inventory tracking."
    - name: "Distinct Therapeutic Classes"
      expr: COUNT(DISTINCT therapeutic_class)
      comment: "Distinct therapeutic classes covered; measures formulary breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_geographic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic reference KPIs supporting market and health-equity analysis: population sizing, income, poverty, and uninsured rates by region."
  source: "`vibe_healthcare_v1`.`reference`.`geographic_region`"
  dimensions:
    - name: "region_type"
      expr: region_type
      comment: "Region type (state, CBSA, HRR) for geographic rollups."
    - name: "census_region"
      expr: census_region
      comment: "Census region for macro-market segmentation."
    - name: "state_abbreviation"
      expr: state_abbreviation
      comment: "State abbreviation for state-level market analysis."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification for access-to-care equity analysis."
  measures:
    - name: "Region Count"
      expr: COUNT(1)
      comment: "Number of geographic regions in scope; baseline coverage measure."
    - name: "Total Population Estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Aggregate population across regions; sizes addressable market."
    - name: "Avg Median Household Income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income; informs payer mix and market strategy."
    - name: "Avg Poverty Rate Pct"
      expr: AVG(CAST(poverty_rate_percent AS DOUBLE))
      comment: "Average poverty rate; drives health-equity and charity-care planning."
    - name: "Avg Uninsured Rate Pct"
      expr: AVG(CAST(uninsured_rate_percent AS DOUBLE))
      comment: "Average uninsured rate; informs community benefit and bad-debt exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_condition_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding and AMA indicator metrics for condition codes"
  source: "`vibe_healthcare_v1`.`reference`.`condition_code`"
  dimensions:
    - name: "condition_code_category"
      expr: condition_code_category
      comment: "Category of the condition code"
    - name: "code_type"
      expr: code_type
      comment: "Type of condition code (e.g., ICD-10, SNOMED)"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the condition code became effective"
  measures:
    - name: "condition_code_count"
      expr: COUNT(1)
      comment: "Total number of condition code records"
    - name: "ama_indicator_count"
      expr: SUM(CASE WHEN ama_indicator THEN 1 ELSE 0 END)
      comment: "Count of condition codes with AMA indicator set"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider workforce metrics from NPI registry"
  source: "`vibe_healthcare_v1`.`reference`.`npi_registry`"
  dimensions:
    - name: "provider_gender_code"
      expr: provider_gender_code
      comment: "Gender code of the provider"
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Primary taxonomy classification of the provider"
  measures:
    - name: "provider_count"
      expr: COUNT(1)
      comment: "Total number of provider registry entries"
    - name: "active_provider_count"
      expr: SUM(CASE WHEN deactivation_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of currently active providers (no deactivation date)"
$$;