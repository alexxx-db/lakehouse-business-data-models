-- Metric views for domain: clinical | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_test_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinical test order metrics tracking order volume, turnaround time performance, billing status, and operational efficiency for genomic testing services"
  source: "`genomics_biotech_ecm`.`clinical`.`test_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the test order (e.g., pending, in-progress, completed, cancelled)"
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the test order was placed, truncated to day for time-series analysis"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the test order was placed for monthly trend analysis"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected for testing (e.g., blood, saliva, tissue)"
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g., routine, urgent, stat)"
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the test order"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for the test"
    - name: "patient_gender"
      expr: patient_gender
      comment: "Patient gender for demographic analysis"
    - name: "ordering_physician_npi"
      expr: ordering_physician_npi
      comment: "National Provider Identifier of the ordering physician"
    - name: "completed_date"
      expr: DATE_TRUNC('day', completed_date)
      comment: "Date the test order was completed"
  measures:
    - name: "total_test_orders"
      expr: COUNT(1)
      comment: "Total number of test orders placed"
    - name: "total_test_revenue"
      expr: SUM(CAST(test_price_usd AS DOUBLE))
      comment: "Total revenue from test orders in USD"
    - name: "avg_test_price"
      expr: AVG(CAST(test_price_usd AS DOUBLE))
      comment: "Average price per test order in USD"
    - name: "avg_actual_tat_hours"
      expr: AVG(CAST(actual_tat_hours AS DOUBLE))
      comment: "Average actual turnaround time in hours from order to completion"
    - name: "total_actual_tat_hours"
      expr: SUM(CAST(actual_tat_hours AS DOUBLE))
      comment: "Total actual turnaround time hours across all orders"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with test orders"
    - name: "distinct_ordering_physicians"
      expr: COUNT(DISTINCT ordering_physician_npi)
      comment: "Number of unique ordering physicians"
    - name: "distinct_performing_labs"
      expr: COUNT(DISTINCT performing_laboratory_id)
      comment: "Number of unique performing laboratories processing orders"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_genomic_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genomic variant analysis metrics tracking variant detection rates, clinical significance distribution, quality scores, and incidental findings for precision medicine decision-making"
  source: "`genomics_biotech_ecm`.`clinical`.`genomic_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Current status of the genomic result (e.g., preliminary, final, amended)"
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance classification of the variant (e.g., pathogenic, benign, VUS)"
    - name: "variant_classification"
      expr: variant_classification
      comment: "Variant classification type (e.g., SNV, indel, CNV)"
    - name: "result_type"
      expr: result_type
      comment: "Type of genomic result (e.g., germline, somatic, pharmacogenomic)"
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome where the variant is located"
    - name: "zygosity"
      expr: zygosity
      comment: "Zygosity of the variant (e.g., heterozygous, homozygous)"
    - name: "incidental_finding_flag"
      expr: incidental_finding_flag
      comment: "Boolean flag indicating whether this is an incidental finding"
    - name: "reporting_date"
      expr: DATE_TRUNC('day', reporting_date)
      comment: "Date the genomic result was reported"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month the genomic result was reported for trend analysis"
    - name: "acmg_classification_criteria"
      expr: acmg_classification_criteria
      comment: "ACMG classification criteria applied to the variant"
  measures:
    - name: "total_genomic_results"
      expr: COUNT(1)
      comment: "Total number of genomic results generated"
    - name: "distinct_patients_with_results"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with genomic results"
    - name: "distinct_variants_detected"
      expr: COUNT(DISTINCT CONCAT(chromosome, ':', CAST(genomic_position_start AS STRING), ':', reference_allele, '>', alternate_allele))
      comment: "Number of unique variants detected across all results"
    - name: "avg_phred_quality_score"
      expr: AVG(CAST(phred_quality_score AS DOUBLE))
      comment: "Average Phred quality score for variant calls, indicating confidence"
    - name: "avg_variant_allele_frequency"
      expr: AVG(CAST(variant_allele_frequency AS DOUBLE))
      comment: "Average variant allele frequency across all results"
    - name: "avg_maf_gnomad"
      expr: AVG(CAST(maf_gnomad AS DOUBLE))
      comment: "Average minor allele frequency from gnomAD population database"
    - name: "incidental_findings_count"
      expr: SUM(CASE WHEN incidental_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of incidental findings requiring clinical action"
    - name: "distinct_test_orders"
      expr: COUNT(DISTINCT test_order_id)
      comment: "Number of unique test orders producing genomic results"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical report delivery and amendment metrics tracking report generation efficiency, amendment rates, turnaround time, and compliance for regulatory and quality management"
  source: "`genomics_biotech_ecm`.`clinical`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the clinical report (e.g., draft, finalized, delivered, amended)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the report (e.g., portal, fax, mail)"
    - name: "format"
      expr: format
      comment: "Report format (e.g., PDF, HL7, FHIR)"
    - name: "language"
      expr: language
      comment: "Language in which the report is written"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment if report was amended (e.g., correction, addendum)"
    - name: "finalized_date"
      expr: DATE_TRUNC('day', finalized_timestamp)
      comment: "Date the report was finalized"
    - name: "finalized_month"
      expr: DATE_TRUNC('month', finalized_timestamp)
      comment: "Month the report was finalized for trend analysis"
    - name: "phi_compliant_flag"
      expr: phi_compliant_flag
      comment: "Boolean flag indicating PHI compliance status"
    - name: "genetic_counseling_recommended_flag"
      expr: genetic_counseling_recommended_flag
      comment: "Boolean flag indicating whether genetic counseling was recommended"
    - name: "confirmatory_testing_recommended_flag"
      expr: confirmatory_testing_recommended_flag
      comment: "Boolean flag indicating whether confirmatory testing was recommended"
    - name: "patient_sex"
      expr: patient_sex
      comment: "Patient sex as recorded in the report"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of clinical reports generated"
    - name: "distinct_patients_reported"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with clinical reports"
    - name: "amended_reports_count"
      expr: SUM(CASE WHEN amendment_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Total count of reports that have been amended"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours from order to report finalization"
    - name: "genetic_counseling_recommended_count"
      expr: SUM(CASE WHEN genetic_counseling_recommended_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports recommending genetic counseling"
    - name: "confirmatory_testing_recommended_count"
      expr: SUM(CASE WHEN confirmatory_testing_recommended_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports recommending confirmatory testing"
    - name: "distinct_test_orders"
      expr: COUNT(DISTINCT test_order_id)
      comment: "Number of unique test orders associated with reports"
    - name: "distinct_assay_versions"
      expr: COUNT(DISTINCT assay_version_id)
      comment: "Number of unique assay versions used in reports"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_analytical_validation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assay analytical validation performance metrics tracking accuracy, sensitivity, specificity, linearity, and precision for regulatory compliance and quality assurance"
  source: "`genomics_biotech_ecm`.`clinical`.`analytical_validation`"
  dimensions:
    - name: "validation_status"
      expr: validation_status
      comment: "Current status of the analytical validation study (e.g., in-progress, completed, approved)"
    - name: "validation_type"
      expr: validation_type
      comment: "Type of validation performed (e.g., initial, revalidation, verification)"
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Overall pass/fail determination for the validation study"
    - name: "validation_start_date"
      expr: DATE_TRUNC('day', validation_start_date)
      comment: "Date the validation study started"
    - name: "validation_completion_date"
      expr: DATE_TRUNC('day', validation_completion_date)
      comment: "Date the validation study was completed"
    - name: "validation_approval_date"
      expr: DATE_TRUNC('day', validation_approval_date)
      comment: "Date the validation study was approved"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use statement for the validated assay"
    - name: "approving_scientist_name"
      expr: approving_scientist_name
      comment: "Name of the scientist who approved the validation"
  measures:
    - name: "total_validations"
      expr: COUNT(1)
      comment: "Total number of analytical validation studies performed"
    - name: "avg_analytical_sensitivity"
      expr: AVG(CAST(analytical_sensitivity AS DOUBLE))
      comment: "Average analytical sensitivity percentage across validation studies"
    - name: "avg_analytical_specificity"
      expr: AVG(CAST(analytical_specificity AS DOUBLE))
      comment: "Average analytical specificity percentage across validation studies"
    - name: "avg_accuracy_bias"
      expr: AVG(CAST(accuracy_bias AS DOUBLE))
      comment: "Average accuracy bias across validation studies"
    - name: "avg_precision_repeatability"
      expr: AVG(CAST(precision_repeatability AS DOUBLE))
      comment: "Average precision repeatability percentage across validation studies"
    - name: "avg_precision_reproducibility"
      expr: AVG(CAST(precision_reproducibility AS DOUBLE))
      comment: "Average precision reproducibility percentage across validation studies"
    - name: "avg_linearity_r_squared"
      expr: AVG(CAST(linearity_r_squared AS DOUBLE))
      comment: "Average linearity R-squared value indicating assay linearity performance"
    - name: "avg_lod_value"
      expr: AVG(CAST(lod_value AS DOUBLE))
      comment: "Average limit of detection value across validation studies"
    - name: "passed_validations_count"
      expr: SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of validation studies that passed acceptance criteria"
    - name: "distinct_assay_versions_validated"
      expr: COUNT(DISTINCT assay_version_id)
      comment: "Number of unique assay versions that have been validated"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_assay_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assay quality control run metrics tracking QC pass rates, sequencing quality metrics, control performance, and lot release eligibility for manufacturing and quality operations"
  source: "`genomics_biotech_ecm`.`clinical`.`assay_qc_run`"
  dimensions:
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the run (e.g., pass, fail, pending review)"
    - name: "run_date"
      expr: DATE_TRUNC('day', run_date)
      comment: "Date the QC run was performed"
    - name: "run_month"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month the QC run was performed for trend analysis"
    - name: "positive_control_result"
      expr: positive_control_result
      comment: "Result of the positive control sample"
    - name: "negative_control_result"
      expr: negative_control_result
      comment: "Result of the negative control sample"
    - name: "no_template_control_result"
      expr: no_template_control_result
      comment: "Result of the no-template control"
    - name: "lot_release_eligible_flag"
      expr: lot_release_eligible_flag
      comment: "Boolean flag indicating whether the run is eligible for lot release"
    - name: "capa_initiated_flag"
      expr: capa_initiated_flag
      comment: "Boolean flag indicating whether a CAPA was initiated due to QC failure"
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Boolean flag indicating whether this run is part of a regulatory submission"
    - name: "westgard_rule_evaluation"
      expr: westgard_rule_evaluation
      comment: "Westgard rule evaluation result for statistical QC"
  measures:
    - name: "total_qc_runs"
      expr: COUNT(1)
      comment: "Total number of assay QC runs performed"
    - name: "avg_q30_score_percent"
      expr: AVG(CAST(q30_score_percent AS DOUBLE))
      comment: "Average Q30 score percentage indicating base call quality"
    - name: "avg_mean_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean coverage depth across QC runs"
    - name: "avg_on_target_rate_percent"
      expr: AVG(CAST(on_target_rate_percent AS DOUBLE))
      comment: "Average on-target rate percentage for targeted sequencing"
    - name: "avg_duplicate_rate_percent"
      expr: AVG(CAST(duplicate_rate_percent AS DOUBLE))
      comment: "Average duplicate rate percentage indicating library complexity"
    - name: "avg_error_rate_percent"
      expr: AVG(CAST(error_rate_percent AS DOUBLE))
      comment: "Average error rate percentage for sequencing accuracy"
    - name: "avg_cluster_density"
      expr: AVG(CAST(cluster_density AS DOUBLE))
      comment: "Average cluster density for flow cell performance"
    - name: "avg_contamination_check_percent"
      expr: AVG(CAST(contamination_check_percent AS DOUBLE))
      comment: "Average contamination check percentage"
    - name: "avg_coverage_uniformity_percent"
      expr: AVG(CAST(coverage_uniformity_percent AS DOUBLE))
      comment: "Average coverage uniformity percentage indicating even coverage"
    - name: "lot_release_eligible_count"
      expr: SUM(CASE WHEN lot_release_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of QC runs eligible for lot release"
    - name: "capa_initiated_count"
      expr: SUM(CASE WHEN capa_initiated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of QC runs that triggered CAPA initiation"
    - name: "distinct_performing_labs"
      expr: COUNT(DISTINCT performing_laboratory_id)
      comment: "Number of unique performing laboratories running QC"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_patient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient demographic and consent metrics tracking patient population characteristics, consent status, research participation, and regulatory compliance for clinical operations and research enrollment"
  source: "`genomics_biotech_ecm`.`clinical`.`patient`"
  dimensions:
    - name: "patient_status"
      expr: patient_status
      comment: "Current status of the patient record (e.g., active, inactive, deceased)"
    - name: "biological_sex"
      expr: biological_sex
      comment: "Biological sex of the patient"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of the patient"
    - name: "race"
      expr: race
      comment: "Race of the patient for demographic analysis"
    - name: "ethnicity"
      expr: ethnicity
      comment: "Ethnicity of the patient for demographic analysis"
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status of the patient"
    - name: "research_participation_flag"
      expr: research_participation_flag
      comment: "Boolean flag indicating whether patient participates in research"
    - name: "hipaa_authorization_flag"
      expr: hipaa_authorization_flag
      comment: "Boolean flag indicating HIPAA authorization status"
    - name: "gdpr_data_subject_rights_flag"
      expr: gdpr_data_subject_rights_flag
      comment: "Boolean flag indicating GDPR data subject rights acknowledgment"
    - name: "de_identification_flag"
      expr: de_identification_flag
      comment: "Boolean flag indicating whether patient data is de-identified"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language of the patient for communication"
    - name: "communication_preference"
      expr: communication_preference
      comment: "Preferred communication method (e.g., email, phone, mail)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the patient's address"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the patient's address"
  measures:
    - name: "total_patients"
      expr: COUNT(1)
      comment: "Total number of patients in the system"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients (should equal total_patients for this table)"
    - name: "research_participants_count"
      expr: SUM(CASE WHEN research_participation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients participating in research studies"
    - name: "hipaa_authorized_count"
      expr: SUM(CASE WHEN hipaa_authorization_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients with HIPAA authorization on file"
    - name: "gdpr_compliant_count"
      expr: SUM(CASE WHEN gdpr_data_subject_rights_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients with GDPR data subject rights acknowledged"
    - name: "de_identified_count"
      expr: SUM(CASE WHEN de_identification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients with de-identified data"
    - name: "distinct_referring_physicians"
      expr: COUNT(DISTINCT referring_physician_npi)
      comment: "Number of unique referring physicians"
    - name: "distinct_insurance_providers"
      expr: COUNT(DISTINCT insurance_provider)
      comment: "Number of unique insurance providers"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_variant_interpretation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Variant interpretation and classification metrics tracking ACMG classification distribution, interpretation turnaround time, report inclusion rates, and clinical actionability for precision medicine reporting"
  source: "`genomics_biotech_ecm`.`clinical`.`variant_interpretation`"
  dimensions:
    - name: "interpretation_status"
      expr: interpretation_status
      comment: "Current status of the variant interpretation (e.g., draft, reviewed, finalized)"
    - name: "acmg_classification"
      expr: acmg_classification
      comment: "ACMG classification of the variant (e.g., pathogenic, likely pathogenic, VUS, likely benign, benign)"
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance determination of the variant"
    - name: "variant_type"
      expr: variant_type
      comment: "Type of variant (e.g., SNV, indel, CNV, structural)"
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome where the variant is located"
    - name: "zygosity"
      expr: zygosity
      comment: "Zygosity of the variant (e.g., heterozygous, homozygous)"
    - name: "report_inclusion_flag"
      expr: report_inclusion_flag
      comment: "Boolean flag indicating whether variant is included in the clinical report"
    - name: "inheritance_pattern"
      expr: inheritance_pattern
      comment: "Inheritance pattern of the variant (e.g., autosomal dominant, autosomal recessive)"
    - name: "interpretation_date"
      expr: DATE_TRUNC('day', interpretation_date)
      comment: "Date the variant interpretation was performed"
    - name: "interpretation_month"
      expr: DATE_TRUNC('month', interpretation_date)
      comment: "Month the variant interpretation was performed for trend analysis"
    - name: "phi_flag"
      expr: phi_flag
      comment: "Boolean flag indicating whether interpretation contains PHI"
  measures:
    - name: "total_variant_interpretations"
      expr: COUNT(1)
      comment: "Total number of variant interpretations performed"
    - name: "distinct_variants_interpreted"
      expr: COUNT(DISTINCT variant_identifier)
      comment: "Number of unique variants that have been interpreted"
    - name: "avg_allele_frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Average allele frequency across interpreted variants"
    - name: "report_included_count"
      expr: SUM(CASE WHEN report_inclusion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of variant interpretations included in clinical reports"
    - name: "pathogenic_count"
      expr: SUM(CASE WHEN acmg_classification IN ('Pathogenic', 'Likely Pathogenic') THEN 1 ELSE 0 END)
      comment: "Count of variants classified as pathogenic or likely pathogenic"
    - name: "vus_count"
      expr: SUM(CASE WHEN acmg_classification = 'VUS' THEN 1 ELSE 0 END)
      comment: "Count of variants classified as variants of uncertain significance"
    - name: "distinct_test_orders"
      expr: COUNT(DISTINCT test_order_id)
      comment: "Number of unique test orders with variant interpretations"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT genomic_result_id)
      comment: "Number of unique genomic results with variant interpretations"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical specimen collection and processing metrics tracking specimen volume, rejection rates, preanalytical quality, and turnaround time for laboratory operations and quality management"
  source: "`genomics_biotech_ecm`.`clinical`.`clinical_specimen`"
  dimensions:
    - name: "specimen_status"
      expr: specimen_status
      comment: "Current status of the clinical specimen (e.g., received, processing, stored, rejected)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen (e.g., blood, saliva, tissue, buccal swab)"
    - name: "preanalytical_qc_status"
      expr: preanalytical_qc_status
      comment: "Preanalytical quality control status of the specimen"
    - name: "collection_date"
      expr: DATE_TRUNC('day', collection_date)
      comment: "Date the specimen was collected"
    - name: "collection_month"
      expr: DATE_TRUNC('month', collection_date)
      comment: "Month the specimen was collected for trend analysis"
    - name: "received_date"
      expr: DATE_TRUNC('day', received_date)
      comment: "Date the specimen was received at the laboratory"
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Boolean flag indicating whether patient consent was obtained"
    - name: "clotting_observed"
      expr: clotting_observed
      comment: "Boolean flag indicating whether clotting was observed in the specimen"
    - name: "container_type"
      expr: container_type
      comment: "Type of container used for specimen collection"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition of the specimen (e.g., room temperature, refrigerated, frozen)"
    - name: "source_anatomical_site"
      expr: source_anatomical_site
      comment: "Anatomical site from which the specimen was collected"
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of clinical specimens received"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with specimens collected"
    - name: "avg_quantity_received"
      expr: AVG(CAST(quantity_received AS DOUBLE))
      comment: "Average quantity of specimen received"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of specimen received across all specimens"
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume collected in milliliters"
    - name: "total_volume_collected_ml"
      expr: SUM(CAST(volume_collected_ml AS DOUBLE))
      comment: "Total volume collected in milliliters across all specimens"
    - name: "rejected_specimens_count"
      expr: SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of specimens that were rejected"
    - name: "clotted_specimens_count"
      expr: SUM(CASE WHEN clotting_observed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specimens with clotting observed"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specimens with patient consent obtained"
    - name: "distinct_test_orders"
      expr: COUNT(DISTINCT test_order_id)
      comment: "Number of unique test orders associated with specimens"
    - name: "distinct_collection_sites"
      expr: COUNT(DISTINCT address_id)
      comment: "Number of unique collection sites"
$$;
