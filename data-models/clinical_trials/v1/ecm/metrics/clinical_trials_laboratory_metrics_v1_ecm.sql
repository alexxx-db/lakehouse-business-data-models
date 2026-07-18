-- Metric views for domain: laboratory | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core laboratory result metrics tracking result volumes, out-of-range rates, critical values, and turnaround performance for clinical trial safety monitoring and data quality oversight."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Current status of the lab result (e.g., final, preliminary, corrected) for workflow tracking."
    - name: "lab_category"
      expr: lbcat
      comment: "Laboratory test category (e.g., hematology, chemistry, urinalysis) for panel-level analysis."
    - name: "lab_subcategory"
      expr: lbscat
      comment: "Laboratory test subcategory for granular panel grouping."
    - name: "out_of_range_flag"
      expr: out_of_range_flag
      comment: "Indicator whether the result is outside normal reference range."
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Flag indicating the result triggered a critical value alert requiring immediate clinical action."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Subject fasting status at time of collection for protocol compliance analysis."
    - name: "data_origin"
      expr: data_origin
      comment: "Source system of the lab result data for integration quality tracking."
    - name: "result_unit"
      expr: result_unit
      comment: "Unit of measurement for the reported result."
    - name: "collection_month"
      expr: DATE_TRUNC('month', collection_datetime)
      comment: "Month of specimen collection for temporal trend analysis."
    - name: "result_reported_month"
      expr: DATE_TRUNC('month', result_reported_datetime)
      comment: "Month when result was reported for turnaround analysis."
    - name: "query_open_flag"
      expr: query_open_flag
      comment: "Whether there is an open data query against this result, indicating data quality issues."
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of laboratory results recorded, baseline volume metric for workload planning."
    - name: "critical_value_count"
      expr: SUM(CASE WHEN critical_value_flag = true THEN 1 ELSE 0 END)
      comment: "Count of results flagging critical values requiring immediate clinical notification per ICH E6 safety reporting."
    - name: "out_of_range_count"
      expr: SUM(CASE WHEN out_of_range_flag = 'Y' THEN 1 ELSE 0 END)
      comment: "Count of results outside normal reference ranges, key safety signal indicator."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across results for central tendency monitoring."
    - name: "results_with_open_queries"
      expr: SUM(CASE WHEN query_open_flag = true THEN 1 ELSE 0 END)
      comment: "Count of results with unresolved data queries, indicating data cleaning backlog impacting database lock timelines."
    - name: "distinct_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with lab results, for enrollment and data completeness tracking."
    - name: "distinct_studies"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of active studies generating lab results for portfolio-level oversight."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_bioanalytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bioanalytical (PK/PD) result metrics for pharmacokinetic study oversight, tracking sample analysis volumes, exclusion rates, and incurred sample reanalysis compliance."
  source: "`clinical_trials_ecm`.`laboratory`.`bioanalytical_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the bioanalytical result (e.g., reportable, excluded, pending review)."
    - name: "result_category"
      expr: result_category
      comment: "Category of the bioanalytical result for classification analysis."
    - name: "matrix_type"
      expr: matrix_type
      comment: "Biological matrix type (e.g., plasma, serum, urine) for method-specific analysis."
    - name: "assay_platform"
      expr: assay_platform
      comment: "Analytical platform used (e.g., LC-MS/MS, ELISA) for technology utilization tracking."
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Whether the result was excluded from PK analysis, critical for data integrity."
    - name: "isr_flag"
      expr: isr_flag
      comment: "Incurred Sample Reanalysis flag indicating regulatory compliance sample."
    - name: "isr_result"
      expr: isr_result
      comment: "ISR pass/fail outcome for regulatory compliance reporting."
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "CDISC SDTM domain mapping for regulatory submission readiness."
    - name: "analysis_month"
      expr: DATE_TRUNC('month', analysis_timestamp)
      comment: "Month of analysis for temporal throughput trending."
  measures:
    - name: "total_bioanalytical_results"
      expr: COUNT(1)
      comment: "Total bioanalytical results generated, baseline throughput metric for lab capacity planning."
    - name: "excluded_results_count"
      expr: SUM(CASE WHEN exclusion_flag = true THEN 1 ELSE 0 END)
      comment: "Count of excluded bioanalytical results; high exclusion rates signal assay or sample handling issues requiring investigation."
    - name: "isr_samples_count"
      expr: SUM(CASE WHEN isr_flag = true THEN 1 ELSE 0 END)
      comment: "Count of incurred sample reanalysis samples for FDA/EMA regulatory compliance tracking."
    - name: "isr_pass_count"
      expr: SUM(CASE WHEN isr_flag = true AND isr_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of ISR samples that passed reanalysis criteria; ISR pass rate must meet 67% regulatory threshold."
    - name: "avg_numeric_result"
      expr: AVG(CAST(numeric_result AS DOUBLE))
      comment: "Average concentration/response value across bioanalytical results."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied, indicator of sample concentration levels and method range adequacy."
    - name: "distinct_subjects_analyzed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with bioanalytical data for PK population completeness assessment."
    - name: "blq_results_count"
      expr: SUM(CASE WHEN categorical_result = 'BLQ' THEN 1 ELSE 0 END)
      comment: "Count of Below Limit of Quantification results, important for PK modeling and dose-response assessment."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_specimen_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen collection metrics tracking collection volumes, protocol deviations, recollection rates, and collection quality for site performance management."
  source: "`clinical_trials_ecm`.`laboratory`.`specimen_collection`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Status of the specimen collection event (e.g., collected, missed, cancelled)."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (e.g., blood, urine, CSF) for logistics planning."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Subject fasting status at collection for protocol compliance monitoring."
    - name: "has_deviation"
      expr: has_deviation
      comment: "Whether a protocol deviation occurred during collection."
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of collection deviation for root cause analysis."
    - name: "is_unscheduled"
      expr: is_unscheduled
      comment: "Whether the collection was unscheduled (e.g., safety-driven repeat)."
    - name: "recollection_required"
      expr: recollection_required
      comment: "Whether recollection was needed due to sample inadequacy or handling error."
    - name: "collection_method"
      expr: collection_method
      comment: "Method of specimen collection (e.g., venipuncture, fingerstick)."
    - name: "collection_month"
      expr: DATE_TRUNC('month', collection_timestamp)
      comment: "Month of collection for temporal volume trending."
  measures:
    - name: "total_collections"
      expr: COUNT(1)
      comment: "Total specimen collection events, baseline workload metric for site and lab capacity planning."
    - name: "collections_with_deviations"
      expr: SUM(CASE WHEN has_deviation = true THEN 1 ELSE 0 END)
      comment: "Count of collections with protocol deviations; high rates trigger site retraining and potential regulatory findings."
    - name: "recollections_required"
      expr: SUM(CASE WHEN recollection_required = true THEN 1 ELSE 0 END)
      comment: "Count of specimens requiring recollection, indicating sample quality issues impacting subject burden and timelines."
    - name: "unscheduled_collections"
      expr: SUM(CASE WHEN is_unscheduled = true THEN 1 ELSE 0 END)
      comment: "Count of unscheduled collections, often safety-driven, for workload forecasting."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average specimen volume collected for adequacy monitoring against protocol requirements."
    - name: "distinct_subjects_collected"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with specimen collections for enrollment completeness tracking."
    - name: "distinct_sites"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of sites performing collections for operational footprint monitoring."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_specimen_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen shipment logistics metrics tracking temperature excursions, delivery performance, and shipment volumes critical for sample integrity and regulatory compliance."
  source: "`clinical_trials_ecm`.`laboratory`.`specimen_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the specimen shipment (e.g., in-transit, received, rejected)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., routine, stat, return) for priority analysis."
    - name: "temperature_condition"
      expr: temperature_condition
      comment: "Required temperature condition (e.g., ambient, refrigerated, frozen) for cold chain compliance."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion occurred during transit, potentially compromising sample integrity."
    - name: "courier_name"
      expr: courier_name
      comment: "Courier/carrier used for vendor performance benchmarking."
    - name: "courier_service_level"
      expr: courier_service_level
      comment: "Service level (e.g., overnight, same-day) for logistics cost and speed analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether shipment contains hazardous materials requiring special handling."
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_date)
      comment: "Month of shipment for volume trending."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total specimen shipments for logistics volume and capacity planning."
    - name: "temperature_excursion_count"
      expr: SUM(CASE WHEN temperature_excursion_flag = true THEN 1 ELSE 0 END)
      comment: "Count of shipments with temperature excursions; excursions risk sample degradation and regulatory non-compliance."
    - name: "avg_dry_ice_weight_kg"
      expr: AVG(CAST(dry_ice_weight_kg AS DOUBLE))
      comment: "Average dry ice weight per shipment for cold chain logistics cost optimization."
    - name: "rejected_shipments"
      expr: SUM(CASE WHEN shipment_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected shipments requiring investigation and potential recollection."
    - name: "distinct_origin_sites"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of unique originating sites for logistics network analysis."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory data query metrics tracking query volumes, resolution times, SLA breaches, and escalations for data management quality and database lock readiness."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Current status of the lab query (e.g., open, answered, closed) for backlog management."
    - name: "query_type"
      expr: query_type
      comment: "Type of query (e.g., missing data, discrepant value, out-of-range) for root cause analysis."
    - name: "query_category"
      expr: query_category
      comment: "Category of query for systematic issue identification."
    - name: "query_priority"
      expr: query_priority
      comment: "Priority level of the query for workload prioritization."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the query resolution breached the contracted SLA timeline."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the query was escalated due to non-response or complexity."
    - name: "safety_relevance_flag"
      expr: safety_relevance_flag
      comment: "Whether the query is safety-relevant requiring expedited resolution."
    - name: "data_correction_flag"
      expr: data_correction_flag
      comment: "Whether the query resulted in a data correction."
    - name: "raised_month"
      expr: DATE_TRUNC('month', raised_datetime)
      comment: "Month when query was raised for temporal trending."
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total lab queries raised, baseline metric for data quality workload."
    - name: "open_queries"
      expr: SUM(CASE WHEN query_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open queries; open query count is a key database lock readiness indicator."
    - name: "sla_breached_queries"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Count of queries that breached SLA, triggering contractual penalties and sponsor escalation."
    - name: "escalated_queries"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of escalated queries indicating systemic site or process issues."
    - name: "safety_relevant_queries"
      expr: SUM(CASE WHEN safety_relevance_flag = true THEN 1 ELSE 0 END)
      comment: "Count of safety-relevant queries requiring expedited resolution per GCP requirements."
    - name: "data_corrections"
      expr: SUM(CASE WHEN data_correction_flag = true THEN 1 ELSE 0 END)
      comment: "Count of queries resulting in data corrections, measuring data quality improvement impact."
    - name: "distinct_subjects_queried"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with lab queries for subject-level data quality assessment."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_pk_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacokinetic sample metrics tracking collection compliance, sampling window adherence, and sample exclusion rates critical for PK study integrity and regulatory submission."
  source: "`clinical_trials_ecm`.`laboratory`.`pk_sample`"
  dimensions:
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the PK sample (e.g., collected, received, analyzed, excluded)."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of PK sample (e.g., plasma, serum) for method-specific tracking."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the sample for workflow monitoring."
    - name: "pre_dose_flag"
      expr: pre_dose_flag
      comment: "Whether sample is a pre-dose baseline for PK profile construction."
    - name: "within_sampling_window"
      expr: within_sampling_window
      comment: "Whether sample was collected within the protocol-specified time window."
    - name: "sample_exclusion_flag"
      expr: sample_exclusion_flag
      comment: "Whether sample was excluded from PK analysis."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Whether a protocol deviation is associated with this sample."
    - name: "collection_method"
      expr: collection_method
      comment: "Method of sample collection for procedural compliance."
    - name: "collection_month"
      expr: DATE_TRUNC('month', collection_timestamp)
      comment: "Month of PK sample collection for temporal trending."
  measures:
    - name: "total_pk_samples"
      expr: COUNT(1)
      comment: "Total PK samples collected, baseline metric for bioanalytical lab workload planning."
    - name: "samples_within_window"
      expr: SUM(CASE WHEN within_sampling_window = true THEN 1 ELSE 0 END)
      comment: "Count of samples collected within protocol time window; window compliance is critical for PK parameter accuracy."
    - name: "samples_outside_window"
      expr: SUM(CASE WHEN within_sampling_window = false THEN 1 ELSE 0 END)
      comment: "Count of samples collected outside window, requiring time deviation documentation and potential exclusion."
    - name: "excluded_samples"
      expr: SUM(CASE WHEN sample_exclusion_flag = true THEN 1 ELSE 0 END)
      comment: "Count of excluded PK samples; high exclusion rates compromise PK parameter estimation and study power."
    - name: "samples_with_deviations"
      expr: SUM(CASE WHEN protocol_deviation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of samples associated with protocol deviations for GCP compliance monitoring."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume collected per PK sample for adequacy assessment against assay requirements."
    - name: "distinct_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with PK samples for PK population completeness."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_bioanalytical_assay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bioanalytical assay validation metrics tracking method performance, precision, accuracy, and GLP compliance for regulatory submission readiness."
  source: "`clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`"
  dimensions:
    - name: "assay_type"
      expr: assay_type
      comment: "Type of bioanalytical assay (e.g., ligand binding, chromatographic) for method portfolio analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status of the assay (e.g., validated, partial, in-progress)."
    - name: "matrix_type"
      expr: matrix_type
      comment: "Biological matrix the assay is validated for."
    - name: "species"
      expr: species
      comment: "Species the assay supports for cross-study applicability."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "Whether the assay meets Good Laboratory Practice standards required for regulatory submissions."
    - name: "gcp_compliant"
      expr: gcp_compliant
      comment: "Whether the assay meets Good Clinical Practice standards."
    - name: "assay_purpose"
      expr: assay_purpose
      comment: "Purpose of the assay (e.g., PK, immunogenicity, biomarker)."
    - name: "analyte_category"
      expr: analyte_category
      comment: "Category of analyte measured for portfolio classification."
  measures:
    - name: "total_assays"
      expr: COUNT(1)
      comment: "Total bioanalytical assays in the portfolio for method development capacity planning."
    - name: "validated_assays"
      expr: SUM(CASE WHEN validation_status = 'Validated' THEN 1 ELSE 0 END)
      comment: "Count of fully validated assays ready for sample analysis and regulatory submission."
    - name: "glp_compliant_assays"
      expr: SUM(CASE WHEN glp_compliant = true THEN 1 ELSE 0 END)
      comment: "Count of GLP-compliant assays meeting regulatory submission requirements."
    - name: "avg_accuracy_percent"
      expr: AVG(CAST(accuracy_percent AS DOUBLE))
      comment: "Average accuracy percentage across assays; FDA/EMA require ±15% (±20% at LLOQ) for validated methods."
    - name: "avg_inter_run_precision_cv"
      expr: AVG(CAST(inter_run_precision_cv AS DOUBLE))
      comment: "Average inter-run precision (CV%); must be ≤15% per regulatory guidance for method acceptance."
    - name: "avg_intra_run_precision_cv"
      expr: AVG(CAST(intra_run_precision_cv AS DOUBLE))
      comment: "Average intra-run precision (CV%); key method performance indicator for run acceptance criteria."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_shipment_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment manifest metrics for specimen logistics oversight tracking delivery performance, temperature excursions, and chain of custody integrity."
  source: "`clinical_trials_ecm`.`laboratory`.`shipment_manifest`"
  dimensions:
    - name: "manifest_status"
      expr: shipment_manifest_status
      comment: "Current status of the shipment manifest (e.g., shipped, received, in-transit)."
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest for shipment classification."
    - name: "temperature_condition"
      expr: temperature_condition
      comment: "Required temperature condition for cold chain compliance monitoring."
    - name: "is_temperature_excursion"
      expr: is_temperature_excursion
      comment: "Whether a temperature excursion was detected during transit."
    - name: "is_international"
      expr: is_international
      comment: "Whether shipment crosses international borders requiring customs/import permits."
    - name: "chain_of_custody_intact"
      expr: chain_of_custody_intact
      comment: "Whether chain of custody was maintained throughout transit."
    - name: "condition_on_receipt"
      expr: condition_on_receipt
      comment: "Condition of specimens upon receipt at destination lab."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for international logistics analysis."
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_date)
      comment: "Month of shipment for volume trending."
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total shipment manifests for logistics volume tracking."
    - name: "temperature_excursion_manifests"
      expr: SUM(CASE WHEN is_temperature_excursion = true THEN 1 ELSE 0 END)
      comment: "Count of manifests with temperature excursions threatening sample integrity."
    - name: "chain_of_custody_failures"
      expr: SUM(CASE WHEN chain_of_custody_intact = false THEN 1 ELSE 0 END)
      comment: "Count of shipments with broken chain of custody, a critical regulatory compliance failure."
    - name: "international_shipments"
      expr: SUM(CASE WHEN is_international = true THEN 1 ELSE 0 END)
      comment: "Count of international shipments for customs and import permit workload planning."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight for logistics cost estimation and carrier selection."
$$;
