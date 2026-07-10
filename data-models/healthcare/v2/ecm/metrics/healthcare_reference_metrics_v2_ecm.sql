-- Metric views for domain: reference | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and load-quality KPIs over reference code-set versions. Steers data-stewardship investment by surfacing validation failures, load errors, and HIPAA compliance gaps across terminology releases."
  source: "`vibe_healthcare_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_type"
      expr: code_set_type
      comment: "Type of terminology (ICD, CPT, LOINC, etc.) for governance segmentation."
    - name: "version_status"
      expr: version_status
      comment: "Lifecycle status of the code-set version (active, superseded, retired)."
    - name: "load_status"
      expr: load_status
      comment: "ETL load outcome status used to monitor pipeline reliability."
    - name: "validation_status"
      expr: validation_status
      comment: "Data-quality validation outcome for the loaded version."
    - name: "source_authority"
      expr: source_authority
      comment: "Governing authority that publishes the code set (CMS, AMA, WHO, etc.)."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year the version applies to."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the version becomes effective, for release-cadence trending."
  measures:
    - name: "version_count"
      expr: COUNT(1)
      comment: "Total number of code-set versions tracked; baseline governance volume."
    - name: "distinct_code_set_count"
      expr: COUNT(DISTINCT code_set_name)
      comment: "Number of distinct code sets under management; breadth of terminology governance."
    - name: "hipaa_compliant_version_count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END)
      comment: "Count of HIPAA-compliant versions; the compliance numerator for coverage rate."
    - name: "hipaa_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of versions flagged HIPAA compliant; direct HIPAA risk indicator for leadership."
    - name: "failed_load_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN load_status = 'FAILED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of versions whose load failed; pipeline reliability KPI triggering remediation."
    - name: "validation_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'FAILED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of versions failing validation; data-quality risk KPI."
    - name: "total_record_count"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total reference records loaded across all versions; scale of the terminology asset."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RVU and reimbursement analytics over the CPT code master. Informs fee-schedule strategy, telemedicine coverage decisions, and identifies high-value procedure families by relative value units."
  source: "`vibe_healthcare_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "High-level CPT category for grouping procedure economics."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service-line analysis."
    - name: "section"
      expr: section
      comment: "CPT section (surgery, radiology, medicine, etc.)."
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Active/deleted status of the CPT code."
    - name: "global_period"
      expr: global_period
      comment: "Global surgical period classification affecting bundling economics."
  measures:
    - name: "cpt_code_count"
      expr: COUNT(1)
      comment: "Number of CPT codes; baseline catalog size for coverage planning."
    - name: "avg_total_rvu"
      expr: ROUND(AVG(CAST(total_rvu AS DOUBLE)), 2)
      comment: "Average total RVU per code; benchmarks procedure value density by family."
    - name: "avg_work_rvu"
      expr: ROUND(AVG(CAST(work_rvu AS DOUBLE)), 2)
      comment: "Average physician work RVU; drives provider compensation modeling."
    - name: "avg_national_payment_amount"
      expr: ROUND(AVG(CAST(national_payment_amount AS DOUBLE)), 2)
      comment: "Average national payment amount; benchmarks expected reimbursement per code."
    - name: "avg_conversion_factor"
      expr: ROUND(AVG(CAST(conversion_factor AS DOUBLE)), 4)
      comment: "Average conversion factor applied; sensitivity input for fee-schedule modeling."
    - name: "telemedicine_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telemedicine_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of codes eligible for telemedicine; steers virtual-care service expansion."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG reimbursement and length-of-stay analytics. Steers inpatient case-mix strategy, payment benchmarking, and readmission-penalty exposure at the DRG level."
  source: "`vibe_healthcare_v1`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "Medical vs surgical DRG classification for case-mix analysis."
    - name: "complication_level"
      expr: complication_level
      comment: "CC/MCC complication severity tier affecting payment weight."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service-line reimbursement analysis."
    - name: "grouper_system"
      expr: grouper_system
      comment: "DRG grouper system version (MS-DRG, APR-DRG)."
  measures:
    - name: "drg_count"
      expr: COUNT(1)
      comment: "Number of DRGs; baseline case-mix catalog size."
    - name: "avg_relative_weight"
      expr: ROUND(AVG(CAST(relative_weight AS DOUBLE)), 4)
      comment: "Average DRG relative weight; core case-mix-index driver for revenue planning."
    - name: "avg_national_average_payment"
      expr: ROUND(AVG(CAST(national_average_payment AS DOUBLE)), 2)
      comment: "Average national payment per DRG; benchmarks expected inpatient reimbursement."
    - name: "avg_geometric_mean_los"
      expr: ROUND(AVG(CAST(geometric_mean_los AS DOUBLE)), 2)
      comment: "Average geometric-mean length of stay; benchmark for utilization management."
    - name: "readmission_penalty_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_penalty_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of DRGs subject to readmission penalty; quantifies value-based-purchasing exposure."
    - name: "bundled_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bundled_payment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of DRGs under bundled payment; steers bundled-care contracting strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ICD diagnosis-code governance analytics. Surfaces billable-code coverage, HAC/CC/MCC composition, and code-lifecycle churn that drive documentation and coding-quality programs."
  source: "`vibe_healthcare_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "icd_code_category"
      expr: icd_code_category
      comment: "ICD category grouping for diagnosis-family analysis."
    - name: "chapter"
      expr: chapter
      comment: "ICD chapter for body-system-level segmentation."
    - name: "code_type"
      expr: code_type
      comment: "Code type (ICD-10-CM, ICD-10-PCS) classification."
  measures:
    - name: "icd_code_count"
      expr: COUNT(1)
      comment: "Number of ICD codes; baseline diagnosis catalog size."
    - name: "billable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of codes that are billable; informs coding-completeness and claim-readiness."
    - name: "mcc_code_count"
      expr: COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END)
      comment: "Count of major-complication/comorbidity codes; drives CDI targeting for revenue capture."
    - name: "cc_code_count"
      expr: COUNT(CASE WHEN cc_flag = TRUE THEN 1 END)
      comment: "Count of complication/comorbidity codes; secondary CDI revenue-capture lever."
    - name: "hac_code_count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Count of hospital-acquired-condition codes; monitors patient-safety and penalty exposure."
    - name: "valid_for_coding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN valid_for_coding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of codes valid for coding; data-quality KPI for the reference asset."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug reference analytics for formulary and safety governance. Surfaces high-alert, black-box, and controlled-substance composition that steer medication-safety and formulary-management programs."
  source: "`vibe_healthcare_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class for formulary and utilization segmentation."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form for dispensing and inventory analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled-substance schedule for compliance monitoring."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary inclusion status for coverage analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for clinical segmentation."
  measures:
    - name: "ndc_drug_count"
      expr: COUNT(1)
      comment: "Number of NDC drug records; baseline drug-catalog size."
    - name: "distinct_active_ingredient_count"
      expr: COUNT(DISTINCT active_ingredient)
      comment: "Number of distinct active ingredients; breadth of the pharmacologic catalog."
    - name: "high_alert_medication_count"
      expr: COUNT(CASE WHEN high_alert_medication_flag = TRUE THEN 1 END)
      comment: "Count of high-alert medications; drives medication-safety oversight."
    - name: "black_box_warning_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of drugs with black-box warnings; risk-management indicator."
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule <> '' THEN 1 END)
      comment: "Count of controlled substances; scope of DEA-regulated inventory for compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Code-mapping quality analytics. Monitors mapping coverage, no-map gaps, and approximate-mapping risk that steer interoperability and terminology-mapping investment."
  source: "`vibe_healthcare_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of code mapping for interoperability segmentation."
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source terminology system in the crosswalk."
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target terminology system in the crosswalk."
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Assessed quality tier of the mapping."
    - name: "mapping_authority"
      expr: mapping_authority
      comment: "Authority that published the mapping."
  measures:
    - name: "crosswalk_count"
      expr: COUNT(1)
      comment: "Number of crosswalk mappings; baseline interoperability coverage."
    - name: "no_map_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_map_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of no-map entries; quantifies terminology gaps requiring remediation."
    - name: "approximate_map_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approximate_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of approximate mappings; data-quality risk for automated coding."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total times mappings were used; prioritizes high-traffic mappings for validation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_geographic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population and socioeconomic reference analytics by geography. Steers market prioritization, health-equity, and ACO service-area planning using population and SDOH indicators."
  source: "`vibe_healthcare_v1`.`reference`.`geographic_region`"
  dimensions:
    - name: "region_type"
      expr: region_type
      comment: "Region granularity (CBSA, HRR, state, etc.)."
    - name: "state_abbreviation"
      expr: state_abbreviation
      comment: "State for market and regulatory segmentation."
    - name: "census_region"
      expr: census_region
      comment: "Census region for national roll-ups."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification for access-to-care analysis."
  measures:
    - name: "region_count"
      expr: COUNT(1)
      comment: "Number of geographic regions; baseline coverage of the market footprint."
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Total estimated population across regions; addressable-market sizing."
    - name: "avg_poverty_rate_pct"
      expr: ROUND(AVG(CAST(poverty_rate_percent AS DOUBLE)), 2)
      comment: "Average poverty rate; health-equity and SDOH investment indicator."
    - name: "avg_uninsured_rate_pct"
      expr: ROUND(AVG(CAST(uninsured_rate_percent AS DOUBLE)), 2)
      comment: "Average uninsured rate; informs financial-assistance and coverage strategy."
    - name: "avg_median_household_income"
      expr: ROUND(AVG(CAST(median_household_income AS DOUBLE)), 2)
      comment: "Average median household income; market economic-profile indicator."
    - name: "aco_service_area_count"
      expr: COUNT(CASE WHEN aco_service_area_flag = TRUE THEN 1 END)
      comment: "Count of ACO service-area regions; value-based-care footprint sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPI registry analytics for provider-network reference data. Monitors active-provider coverage, entity mix, and deactivation churn feeding credentialing and network-adequacy programs."
  source: "`vibe_healthcare_v1`.`reference`.`npi_registry`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Individual vs organization NPI entity type."
    - name: "practice_state"
      expr: practice_state
      comment: "Practice state for network-adequacy and geographic analysis."
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Primary provider taxonomy for specialty segmentation."
  measures:
    - name: "npi_count"
      expr: COUNT(1)
      comment: "Number of NPI records; baseline provider-reference volume."
    - name: "active_npi_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of active NPIs; data-freshness and network-integrity KPI."
    - name: "deactivated_npi_count"
      expr: COUNT(CASE WHEN deactivation_date IS NOT NULL THEN 1 END)
      comment: "Count of deactivated NPIs; provider-churn indicator for network maintenance."
    - name: "distinct_taxonomy_count"
      expr: COUNT(DISTINCT primary_taxonomy_code)
      comment: "Number of distinct taxonomies; specialty breadth of the reference registry."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_loinc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "LOINC observation-code governance analytics. Surfaces active-code coverage and orderable-observation mix supporting lab interoperability and result-mapping programs."
  source: "`vibe_healthcare_v1`.`reference`.`loinc_code`"
  dimensions:
    - name: "class"
      expr: class
      comment: "LOINC class grouping for lab-domain segmentation."
    - name: "scale_type"
      expr: scale_type
      comment: "Scale type (quantitative, ordinal, nominal) for result-handling analysis."
    - name: "panel_type"
      expr: panel_type
      comment: "Panel vs single-observation classification."
    - name: "system"
      expr: system
      comment: "Specimen/system component for clinical segmentation."
  measures:
    - name: "loinc_code_count"
      expr: COUNT(1)
      comment: "Number of LOINC codes; baseline observation-catalog size."
    - name: "active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of active LOINC codes; catalog-freshness KPI."
    - name: "distinct_component_count"
      expr: COUNT(DISTINCT component)
      comment: "Number of distinct observation components; breadth of measurable concepts."
    - name: "orderable_observation_count"
      expr: COUNT(CASE WHEN order_observation_flag = TRUE THEN 1 END)
      comment: "Count of orderable observations; scope of CPOE-mappable lab tests."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SNOMED CT concept governance analytics. Monitors active-concept coverage, reportable/quality-measure inclusion, and mapping readiness feeding clinical-terminology and quality programs."
  source: "`vibe_healthcare_v1`.`reference`.`snomed_concept`"
  dimensions:
    - name: "semantic_tag"
      expr: semantic_tag
      comment: "SNOMED semantic tag for concept-type segmentation."
    - name: "top_level_hierarchy"
      expr: top_level_hierarchy
      comment: "Top-level SNOMED hierarchy for high-level grouping."
    - name: "concept_status"
      expr: concept_status
      comment: "Concept lifecycle status."
    - name: "hierarchy"
      expr: hierarchy
      comment: "Concept hierarchy classification."
  measures:
    - name: "concept_count"
      expr: COUNT(1)
      comment: "Number of SNOMED concepts; baseline clinical-terminology size."
    - name: "active_concept_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of active concepts; terminology-freshness KPI."
    - name: "reportable_concept_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Count of reportable concepts; scope of surveillance/regulatory reporting."
    - name: "ehr_preferred_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ehr_preferred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of EHR-preferred concepts; documentation-standardization indicator."
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