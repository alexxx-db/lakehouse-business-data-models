-- Metric views for domain: laboratory | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core laboratory result quality and safety metrics. Tracks critical value flags, out-of-range rates, query burden, and result turnaround performance across studies, sites, and panels — essential for data quality oversight and patient safety monitoring."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_result`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for cross-study benchmarking of lab result quality."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier enabling site-level lab performance comparisons."
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Laboratory facility processing the result, used to benchmark facility performance."
    - name: "lab_panel_id"
      expr: lab_panel_id
      comment: "Panel identifier for panel-level quality and volume analysis."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the lab result (e.g., final, preliminary, corrected) for workflow tracking."
    - name: "lbcat"
      expr: lbcat
      comment: "CDISC lab category (e.g., hematology, chemistry) for domain-level quality analysis."
    - name: "lbscat"
      expr: lbscat
      comment: "CDISC lab sub-category for granular panel-level analysis."
    - name: "out_of_range_flag"
      expr: out_of_range_flag
      comment: "Indicates whether the result falls outside the reference range — key safety dimension."
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Flags results meeting critical value thresholds requiring immediate clinical action."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status, used to track data cleaning progress."
    - name: "data_origin"
      expr: data_origin
      comment: "Origin system of the result (e.g., central lab, local lab, LIMS) for data provenance analysis."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting state at collection, relevant for metabolic panel interpretation."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month of specimen collection for trend analysis of lab result volumes and quality."
    - name: "result_reported_month"
      expr: DATE_TRUNC('MONTH', result_reported_datetime)
      comment: "Month results were reported, used to track reporting timeliness trends."
  measures:
    - name: "total_lab_results"
      expr: COUNT(1)
      comment: "Total number of lab results processed. Baseline volume metric for capacity and workload planning."
    - name: "critical_value_result_count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Number of results flagged as critical values. Directly informs patient safety oversight and escalation SLA compliance."
    - name: "out_of_range_result_count"
      expr: COUNT(CASE WHEN out_of_range_flag IS NOT NULL AND out_of_range_flag != 'NORMAL' THEN 1 END)
      comment: "Number of results outside the normal reference range. Drives safety signal detection and protocol deviation review."
    - name: "query_open_result_count"
      expr: COUNT(CASE WHEN query_open_flag = TRUE THEN 1 END)
      comment: "Number of results with open data queries. Measures data cleaning backlog and site data quality burden."
    - name: "dbl_included_result_count"
      expr: COUNT(CASE WHEN dbl_included_flag = TRUE THEN 1 END)
      comment: "Number of results included in the database lock dataset. Tracks data lock readiness and completeness."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across the selected cohort. Used for population-level biomarker trend analysis."
    - name: "avg_normal_range_lower"
      expr: AVG(CAST(normal_range_lower AS DOUBLE))
      comment: "Average lower bound of the normal reference range applied to results in scope. Supports reference range consistency audits."
    - name: "avg_normal_range_upper"
      expr: AVG(CAST(normal_range_upper AS DOUBLE))
      comment: "Average upper bound of the normal reference range applied to results in scope. Supports reference range consistency audits."
    - name: "distinct_subjects_with_results"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one lab result. Measures subject-level lab data coverage and completeness."
    - name: "distinct_subjects_with_critical_values"
      expr: COUNT(DISTINCT CASE WHEN critical_value_flag = TRUE THEN trial_subject_id END)
      comment: "Number of unique subjects who have experienced at least one critical lab value. Key patient safety KPI for medical monitoring."
    - name: "sdv_verified_result_count"
      expr: COUNT(CASE WHEN sdv_status = 'VERIFIED' THEN 1 END)
      comment: "Number of results that have completed source data verification. Tracks clinical monitoring progress and data quality assurance."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_bioanalytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bioanalytical and PK/PD result quality metrics covering assay performance, ISR compliance, exclusion rates, and result completeness. Critical for regulatory submission readiness and bioanalytical method validation oversight."
  source: "`clinical_trials_ecm`.`laboratory`.`bioanalytical_result`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for cross-study bioanalytical performance benchmarking."
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Bioanalytical laboratory facility for facility-level performance tracking."
    - name: "bioanalytical_assay_id"
      expr: bioanalytical_assay_id
      comment: "Assay identifier enabling assay-level performance and quality analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm for comparative bioanalytical result analysis across arms."
    - name: "result_status"
      expr: result_status
      comment: "Status of the bioanalytical result (e.g., accepted, rejected, pending) for workflow monitoring."
    - name: "matrix_type"
      expr: matrix_type
      comment: "Biological matrix type (e.g., plasma, serum, urine) for matrix-specific performance analysis."
    - name: "assay_platform"
      expr: assay_platform
      comment: "Analytical platform used for the assay, enabling platform-level performance comparison."
    - name: "result_category"
      expr: result_category
      comment: "Categorical classification of the result (e.g., BLQ, quantifiable) for distribution analysis."
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "SDTM domain (e.g., PC, LB) for regulatory submission dataset alignment."
    - name: "isr_flag"
      expr: isr_flag
      comment: "Incurred sample reanalysis flag — identifies results subject to ISR for reproducibility assessment."
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Flags results excluded from analysis, used to monitor exclusion rates and data integrity."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_timestamp)
      comment: "Month of bioanalytical analysis for temporal trend monitoring."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of sample collection for longitudinal bioanalytical volume tracking."
  measures:
    - name: "total_bioanalytical_results"
      expr: COUNT(1)
      comment: "Total bioanalytical results processed. Baseline volume metric for assay throughput and capacity planning."
    - name: "excluded_result_count"
      expr: COUNT(CASE WHEN exclusion_flag = TRUE THEN 1 END)
      comment: "Number of results excluded from analysis. High exclusion rates signal assay or sample quality issues requiring investigation."
    - name: "isr_result_count"
      expr: COUNT(CASE WHEN isr_flag = TRUE THEN 1 END)
      comment: "Number of results subject to incurred sample reanalysis. ISR compliance is a regulatory requirement for bioanalytical method validation."
    - name: "calibration_curve_rejected_count"
      expr: COUNT(CASE WHEN calibration_curve_accepted = FALSE THEN 1 END)
      comment: "Number of results where the calibration curve was rejected. Directly impacts assay run acceptance and data integrity."
    - name: "sample_stability_failed_count"
      expr: COUNT(CASE WHEN sample_stability_flag = FALSE THEN 1 END)
      comment: "Number of results where sample stability criteria were not met. Stability failures can invalidate entire analytical runs."
    - name: "avg_numeric_result"
      expr: AVG(CAST(numeric_result AS DOUBLE))
      comment: "Average numeric bioanalytical result value. Used for population PK/PD trend analysis and dose-response assessment."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied across results. Elevated average dilution factors may indicate sample concentration issues."
    - name: "avg_time_deviation_hours"
      expr: AVG(CAST(time_deviation_hours AS DOUBLE))
      comment: "Average deviation from nominal sampling time in hours. Measures protocol compliance for PK sampling windows."
    - name: "distinct_subjects_analyzed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with bioanalytical results. Measures PK/PD data coverage across the enrolled population."
    - name: "blq_result_count"
      expr: COUNT(CASE WHEN result_category = 'BLQ' THEN 1 END)
      comment: "Number of results below the limit of quantification. High BLQ rates affect PK parameter estimation and regulatory acceptability."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_bioanalytical_assay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bioanalytical assay validation quality and regulatory compliance metrics. Tracks assay precision, accuracy, dynamic range, and GCP/GLP compliance status — essential for regulatory submission readiness and method lifecycle management."
  source: "`clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`"
  dimensions:
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Laboratory facility where the assay is validated and run."
    - name: "assay_type"
      expr: assay_type
      comment: "Type of assay (e.g., LC-MS/MS, ELISA, PCR) for technology-level performance benchmarking."
    - name: "analyte_category"
      expr: analyte_category
      comment: "Category of analyte (e.g., small molecule, biologic, biomarker) for portfolio-level assay management."
    - name: "matrix_type"
      expr: matrix_type
      comment: "Biological matrix (e.g., plasma, urine, CSF) for matrix-specific validation tracking."
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status (e.g., validated, in-validation, superseded) for assay lifecycle management."
    - name: "gcp_compliant"
      expr: gcp_compliant
      comment: "GCP compliance flag — regulatory requirement for clinical bioanalytical methods."
    - name: "glp_compliant"
      expr: glp_compliant
      comment: "GLP compliance flag — required for non-clinical and some clinical bioanalytical studies."
    - name: "species"
      expr: species
      comment: "Species for which the assay is validated, relevant for cross-species PK studies."
    - name: "validation_year"
      expr: YEAR(validation_date)
      comment: "Year of assay validation for temporal portfolio analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the assay validation expires, used for proactive renewal planning."
  measures:
    - name: "total_assays"
      expr: COUNT(1)
      comment: "Total number of bioanalytical assays in the portfolio. Baseline for assay lifecycle and capacity management."
    - name: "validated_assay_count"
      expr: COUNT(CASE WHEN validation_status = 'VALIDATED' THEN 1 END)
      comment: "Number of fully validated assays available for study use. Directly impacts study start readiness and regulatory submission eligibility."
    - name: "gcp_compliant_assay_count"
      expr: COUNT(CASE WHEN gcp_compliant = TRUE THEN 1 END)
      comment: "Number of assays meeting GCP compliance requirements. Regulatory submissions require GCP-compliant bioanalytical methods."
    - name: "avg_accuracy_percent"
      expr: AVG(CAST(accuracy_percent AS DOUBLE))
      comment: "Average assay accuracy percentage across the portfolio. Regulatory guidance (FDA/EMA) requires accuracy within 15% (20% at LLOQ)."
    - name: "avg_intra_run_precision_cv"
      expr: AVG(CAST(intra_run_precision_cv AS DOUBLE))
      comment: "Average intra-run precision CV%. Regulatory acceptance criterion is ≤15% CV (≤20% at LLOQ) — deviations require investigation."
    - name: "avg_inter_run_precision_cv"
      expr: AVG(CAST(inter_run_precision_cv AS DOUBLE))
      comment: "Average inter-run precision CV%. Measures reproducibility across analytical runs — critical for multi-site and multi-batch studies."
    - name: "avg_lloq"
      expr: AVG(CAST(lloq AS DOUBLE))
      comment: "Average lower limit of quantification across assays. Lower LLOQ enables detection of low drug concentrations, impacting PK parameter estimation."
    - name: "avg_uloq"
      expr: AVG(CAST(uloq AS DOUBLE))
      comment: "Average upper limit of quantification. Defines the upper boundary of the validated dynamic range."
    - name: "matrix_effect_assessed_count"
      expr: COUNT(CASE WHEN matrix_effect_assessed = TRUE THEN 1 END)
      comment: "Number of assays where matrix effect has been formally assessed. Matrix effect assessment is a regulatory requirement for LC-MS/MS methods."
    - name: "parallelism_assessed_count"
      expr: COUNT(CASE WHEN parallelism_assessed = TRUE THEN 1 END)
      comment: "Number of ligand-binding assays with parallelism assessment completed. Required for immunogenicity and large-molecule bioanalytical validation."
    - name: "avg_sample_volume_required_ul"
      expr: AVG(CAST(sample_volume_required_ul AS DOUBLE))
      comment: "Average sample volume required per assay in microliters. Informs specimen collection planning and patient burden assessment."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen integrity, collection quality, and chain-of-custody metrics. Tracks rejection rates, temperature excursions, volume adequacy, and processing timeliness — critical for data quality and regulatory compliance."
  source: "`clinical_trials_ecm`.`laboratory`.`specimen`"
  dimensions:
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Receiving laboratory facility for facility-level specimen quality benchmarking."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Collection site for site-level specimen quality and compliance analysis."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen (e.g., plasma, serum, urine) for matrix-specific quality tracking."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen, relevant for pre-analytical variability analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition of the specimen (e.g., analyzed, stored, destroyed) for inventory management."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting state at collection — affects interpretation of metabolic and lipid panels."
    - name: "chain_of_custody_status"
      expr: chain_of_custody_status
      comment: "Chain of custody integrity status — regulatory requirement for GCP-compliant specimen handling."
    - name: "collection_deviation_flag"
      expr: collection_deviation_flag
      comment: "Flags specimens collected with a protocol deviation — used for data quality and compliance reporting."
    - name: "is_primary"
      expr: is_primary
      comment: "Indicates whether this is a primary specimen or an aliquot, for inventory and analysis planning."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month of specimen collection for longitudinal volume and quality trend analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_datetime)
      comment: "Month of specimen receipt at the laboratory for turnaround time trend analysis."
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total specimens collected and tracked. Baseline volume metric for laboratory capacity and workload planning."
    - name: "rejected_specimen_count"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END)
      comment: "Number of specimens rejected at the laboratory. High rejection rates indicate site training or collection quality issues requiring intervention."
    - name: "collection_deviation_specimen_count"
      expr: COUNT(CASE WHEN collection_deviation_flag = TRUE THEN 1 END)
      comment: "Number of specimens collected with a protocol deviation. Drives protocol deviation reporting and site corrective action."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume collected per specimen in mL. Volumes below protocol minimums risk insufficient sample for all required assays."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across specimens. Deviations from protocol-specified storage conditions can compromise sample integrity."
    - name: "avg_actual_timepoint_hours"
      expr: AVG(CAST(actual_timepoint_hours AS DOUBLE))
      comment: "Average actual collection timepoint in hours post-dose. Used to assess PK sampling window compliance across the study."
    - name: "distinct_subjects_with_specimens"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one specimen collected. Measures specimen collection coverage across the enrolled population."
    - name: "avg_freeze_thaw_cycles"
      expr: AVG(CAST(freeze_thaw_cycles AS DOUBLE))
      comment: "Average number of freeze-thaw cycles experienced by specimens. Excessive cycles degrade analyte stability and can invalidate results."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_specimen_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen shipment logistics, temperature excursion, and chain-of-custody metrics. Tracks shipment integrity, courier performance, and regulatory compliance for cross-border specimen transport — critical for data integrity and import/export compliance."
  source: "`clinical_trials_ecm`.`laboratory`.`specimen_shipment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for study-level shipment performance analysis."
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Destination laboratory facility for facility-level receipt and excursion tracking."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Originating study site for site-level shipment compliance analysis."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, rejected) for logistics monitoring."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., routine, STAT, return) for service-level analysis."
    - name: "courier_name"
      expr: courier_name
      comment: "Courier used for the shipment — enables vendor performance benchmarking."
    - name: "courier_service_level"
      expr: courier_service_level
      comment: "Service level selected (e.g., overnight, 2-day) for SLA compliance analysis."
    - name: "temperature_condition"
      expr: temperature_condition
      comment: "Required temperature condition for the shipment (e.g., dry ice, refrigerated, ambient)."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags shipments that experienced a temperature excursion — directly impacts specimen integrity and data usability."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates shipments containing hazardous biological materials requiring special regulatory handling."
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month of shipment dispatch for longitudinal logistics volume and performance trending."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total specimen shipments dispatched. Baseline logistics volume metric for courier capacity and cost management."
    - name: "temperature_excursion_shipment_count"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of shipments with temperature excursions. Excursions risk specimen integrity and may require sample recollection, impacting study timelines."
    - name: "avg_excursion_max_temp_c"
      expr: AVG(CAST(excursion_max_temp_c AS DOUBLE))
      comment: "Average maximum temperature reached during excursion events. Quantifies severity of temperature deviations for risk assessment."
    - name: "avg_excursion_min_temp_c"
      expr: AVG(CAST(excursion_min_temp_c AS DOUBLE))
      comment: "Average minimum temperature reached during excursion events. Critical for cold-chain integrity assessment of biological specimens."
    - name: "avg_dry_ice_weight_kg"
      expr: AVG(CAST(dry_ice_weight_kg AS DOUBLE))
      comment: "Average dry ice weight per shipment in kg. Informs cold-chain packaging standards and regulatory UN3373 compliance."
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum recorded temperature across all shipments. Used to assess overall cold-chain performance by courier and route."
    - name: "avg_temperature_min_c"
      expr: AVG(CAST(temperature_min_c AS DOUBLE))
      comment: "Average minimum recorded temperature across all shipments. Monitors freeze risk for specimens requiring refrigerated (not frozen) transport."
    - name: "distinct_studies_shipped"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with active specimen shipments. Measures logistics operational breadth and multi-study coordination complexity."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory data query management metrics tracking query volume, resolution cycle times, SLA breach rates, and escalation patterns. Directly informs data cleaning efficiency, database lock readiness, and site performance."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_query`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for cross-study query burden comparison."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level query performance and data quality benchmarking."
    - name: "query_status"
      expr: query_status
      comment: "Current status of the query (e.g., open, answered, closed) for pipeline and backlog management."
    - name: "query_type"
      expr: query_type
      comment: "Type of query (e.g., missing data, out-of-range, discrepancy) for root cause analysis."
    - name: "query_category"
      expr: query_category
      comment: "Business category of the query for thematic data quality analysis."
    - name: "query_priority"
      expr: query_priority
      comment: "Priority level of the query (e.g., critical, high, routine) for workload triage."
    - name: "assigned_to_party_type"
      expr: assigned_to_party_type
      comment: "Party type responsible for resolving the query (e.g., site, CRO, sponsor) for accountability tracking."
    - name: "raised_by_role"
      expr: raised_by_role
      comment: "Role that raised the query (e.g., data manager, monitor, statistician) for process improvement analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flags queries that breached the resolution SLA — key operational performance indicator."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flags queries that required escalation, indicating complex or contested data issues."
    - name: "dbl_blocking_flag"
      expr: dbl_blocking_flag
      comment: "Flags queries blocking the database lock — critical for study timeline management."
    - name: "safety_relevance_flag"
      expr: safety_relevance_flag
      comment: "Flags queries with safety implications — these require expedited resolution per GCP requirements."
    - name: "data_correction_flag"
      expr: data_correction_flag
      comment: "Indicates queries that resulted in a data correction, measuring data amendment frequency."
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', raised_datetime)
      comment: "Month the query was raised for longitudinal query volume and aging trend analysis."
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of lab data queries raised. Baseline metric for data cleaning workload and site data quality assessment."
    - name: "open_query_count"
      expr: COUNT(CASE WHEN query_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open queries. Open query backlog is a primary indicator of database lock readiness."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of queries that breached the resolution SLA. SLA breaches indicate site performance issues and risk study timeline delays."
    - name: "dbl_blocking_query_count"
      expr: COUNT(CASE WHEN dbl_blocking_flag = TRUE THEN 1 END)
      comment: "Number of queries blocking the database lock. Critical path metric for study completion and regulatory submission timelines."
    - name: "safety_relevant_query_count"
      expr: COUNT(CASE WHEN safety_relevance_flag = TRUE THEN 1 END)
      comment: "Number of queries with safety implications. Safety-relevant queries require expedited resolution per GCP and may trigger adverse event reporting."
    - name: "escalated_query_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of queries requiring escalation. High escalation rates signal systemic data quality or site compliance issues."
    - name: "data_correction_count"
      expr: COUNT(CASE WHEN data_correction_flag = TRUE THEN 1 END)
      comment: "Number of queries resulting in a data correction. Measures the rate of data amendments, relevant for audit trail and regulatory inspection readiness."
    - name: "avg_corrected_value"
      expr: AVG(CAST(corrected_value AS DOUBLE))
      comment: "Average corrected numeric value across queries with data corrections. Provides context on the magnitude of data amendments."
    - name: "distinct_subjects_with_queries"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one open or historical lab query. Measures subject-level data quality burden."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory facility capability, certification, and operational readiness metrics. Tracks GCP/GLP certification status, analytical capability coverage, and qualification expiry — essential for vendor qualification and study start-up planning."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of laboratory facility (e.g., central lab, local lab, specialty lab) for network segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located for geographic coverage and regulatory jurisdiction analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility (e.g., active, suspended, closed) for network availability planning."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Sponsor qualification status of the facility — only qualified facilities can be used for GCP studies."
    - name: "gcp_certified"
      expr: gcp_certified
      comment: "GCP certification flag — mandatory for facilities processing clinical trial specimens."
    - name: "glp_certified"
      expr: glp_certified
      comment: "GLP certification flag — required for non-clinical and some early-phase clinical studies."
    - name: "network_affiliation"
      expr: network_affiliation
      comment: "Laboratory network affiliation (e.g., Covance, Labcorp, PPD) for vendor management and contract oversight."
    - name: "pk_analysis_capable"
      expr: pk_analysis_capable
      comment: "Indicates whether the facility can perform PK analysis — critical for study site assignment in PK-heavy studies."
    - name: "dmpk_analysis_capable"
      expr: dmpk_analysis_capable
      comment: "Indicates DMPK analysis capability for drug metabolism and pharmacokinetics studies."
    - name: "biobanking_capable"
      expr: biobanking_capable
      comment: "Indicates long-term biobanking capability for future biomarker and exploratory analyses."
    - name: "genomics_capable"
      expr: genomics_capable
      comment: "Indicates genomics analysis capability for companion diagnostic and pharmacogenomics studies."
    - name: "qualification_expiry_year"
      expr: YEAR(qualification_expiry_date)
      comment: "Year of qualification expiry for proactive re-qualification planning."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of laboratory facilities in the network. Baseline for network capacity and geographic coverage planning."
    - name: "gcp_certified_facility_count"
      expr: COUNT(CASE WHEN gcp_certified = TRUE THEN 1 END)
      comment: "Number of GCP-certified facilities available for clinical trial use. Directly constrains study site assignment options."
    - name: "qualified_facility_count"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END)
      comment: "Number of sponsor-qualified facilities. Only qualified facilities can be assigned to active studies — a key capacity constraint."
    - name: "pk_capable_facility_count"
      expr: COUNT(CASE WHEN pk_analysis_capable = TRUE THEN 1 END)
      comment: "Number of facilities capable of PK analysis. Informs feasibility assessment for PK-intensive study designs."
    - name: "biobanking_capable_facility_count"
      expr: COUNT(CASE WHEN biobanking_capable = TRUE THEN 1 END)
      comment: "Number of facilities with biobanking capability. Supports long-term sample retention planning for future exploratory analyses."
    - name: "genomics_capable_facility_count"
      expr: COUNT(CASE WHEN genomics_capable = TRUE THEN 1 END)
      comment: "Number of facilities with genomics capability. Critical for precision medicine and companion diagnostic study planning."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of countries with at least one active laboratory facility. Measures global network reach for multinational study support."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_lab_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory accreditation and regulatory certification compliance metrics. Tracks accreditation status, expiry risk, sponsor approval, and proficiency testing outcomes — essential for regulatory inspection readiness and vendor qualification governance."
  source: "`clinical_trials_ecm`.`laboratory`.`lab_accreditation`"
  dimensions:
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Primary laboratory facility for facility-level accreditation status tracking."
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., CAP, ISO 15189, CLIA) for regulatory framework analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (e.g., accredited, suspended, expired) — directly impacts facility eligibility for study use."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status for the specific accreditation standard."
    - name: "lab_type"
      expr: lab_type
      comment: "Type of laboratory (e.g., clinical, bioanalytical, pathology) for portfolio segmentation."
    - name: "gcp_compliant"
      expr: gcp_compliant
      comment: "GCP compliance flag for the accreditation record — regulatory requirement for clinical trial laboratories."
    - name: "sponsor_approved"
      expr: sponsor_approved
      comment: "Sponsor approval status — only sponsor-approved facilities can be used in sponsored studies."
    - name: "regulatory_submission_eligible"
      expr: regulatory_submission_eligible
      comment: "Indicates whether the facility is eligible for regulatory submission data generation."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the most recent regulatory inspection (e.g., satisfactory, with findings, critical findings)."
    - name: "proficiency_testing_status"
      expr: proficiency_testing_status
      comment: "Status of proficiency testing program participation — required for ongoing accreditation maintenance."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Accreditation renewal status for proactive expiry risk management."
    - name: "accreditation_expiry_year"
      expr: YEAR(accreditation_expiry_date)
      comment: "Year of accreditation expiry for renewal pipeline planning."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total accreditation records across the laboratory network. Baseline for accreditation portfolio management."
    - name: "active_accreditation_count"
      expr: COUNT(CASE WHEN accreditation_status = 'ACCREDITED' THEN 1 END)
      comment: "Number of currently active accreditations. Active accreditation is a prerequisite for regulatory submission eligibility."
    - name: "sponsor_approved_count"
      expr: COUNT(CASE WHEN sponsor_approved = TRUE THEN 1 END)
      comment: "Number of sponsor-approved accreditation records. Only sponsor-approved facilities can be assigned to active studies."
    - name: "regulatory_submission_eligible_count"
      expr: COUNT(CASE WHEN regulatory_submission_eligible = TRUE THEN 1 END)
      comment: "Number of accreditations qualifying the facility for regulatory submission data generation. Critical for NDA/BLA submission planning."
    - name: "gcp_compliant_accreditation_count"
      expr: COUNT(CASE WHEN gcp_compliant = TRUE THEN 1 END)
      comment: "Number of GCP-compliant accreditation records. GCP compliance is a non-negotiable regulatory requirement for clinical trial data."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN accreditation_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of accreditations expiring within the next 90 days. Proactive expiry management prevents study disruption due to lapsed accreditation."
    - name: "distinct_facilities_accredited"
      expr: COUNT(DISTINCT lab_facility_id)
      comment: "Number of distinct facilities with at least one accreditation record. Measures the breadth of the accredited laboratory network."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_pk_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacokinetic sample collection compliance and quality metrics. Tracks sampling window adherence, exclusion rates, volume adequacy, and protocol deviation rates — essential for PK data integrity and regulatory submission readiness."
  source: "`clinical_trials_ecm`.`laboratory`.`pk_sample`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for cross-study PK sampling compliance benchmarking."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level PK sampling quality analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm for arm-level PK sampling compliance comparison."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of PK sample (e.g., plasma, urine, CSF) for matrix-specific analysis."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the PK sample (e.g., collected, analyzed, excluded) for pipeline tracking."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the sample for pre-analytical workflow monitoring."
    - name: "analyte_name"
      expr: analyte_name
      comment: "Name of the analyte being measured — enables analyte-specific PK data quality analysis."
    - name: "nominal_time_point"
      expr: nominal_time_point
      comment: "Nominal PK sampling time point (e.g., 0h, 1h, 4h) for time-point-level compliance analysis."
    - name: "pre_dose_flag"
      expr: pre_dose_flag
      comment: "Identifies pre-dose (baseline) samples — critical for PK parameter calculation."
    - name: "within_sampling_window"
      expr: within_sampling_window
      comment: "Indicates whether the sample was collected within the protocol-specified sampling window — key PK compliance metric."
    - name: "sample_exclusion_flag"
      expr: sample_exclusion_flag
      comment: "Flags samples excluded from PK analysis — high exclusion rates impact PK parameter estimation reliability."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Flags samples associated with a protocol deviation — used for compliance reporting and data quality assessment."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of PK sample collection for longitudinal compliance trend analysis."
  measures:
    - name: "total_pk_samples"
      expr: COUNT(1)
      comment: "Total PK samples collected. Baseline volume metric for PK data completeness and study execution tracking."
    - name: "within_window_sample_count"
      expr: COUNT(CASE WHEN within_sampling_window = TRUE THEN 1 END)
      comment: "Number of PK samples collected within the protocol-specified sampling window. Window compliance directly impacts PK parameter estimation quality."
    - name: "excluded_sample_count"
      expr: COUNT(CASE WHEN sample_exclusion_flag = TRUE THEN 1 END)
      comment: "Number of PK samples excluded from analysis. High exclusion rates reduce PK dataset completeness and may require additional sampling."
    - name: "protocol_deviation_sample_count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of PK samples associated with a protocol deviation. Drives protocol deviation reporting and regulatory submission narratives."
    - name: "avg_actual_time_post_dose_hours"
      expr: AVG(CAST(actual_time_post_dose_hours AS DOUBLE))
      comment: "Average actual collection time post-dose in hours. Compared against nominal time points to assess systematic sampling timing bias."
    - name: "avg_nominal_time_hours"
      expr: AVG(CAST(nominal_time_hours AS DOUBLE))
      comment: "Average nominal PK sampling time in hours. Used alongside actual time to compute sampling window deviation statistics."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume of PK sample collected in mL. Volumes below the required minimum risk insufficient sample for bioanalytical analysis."
    - name: "avg_volume_required_ml"
      expr: AVG(CAST(volume_required_ml AS DOUBLE))
      comment: "Average volume required per PK sample per protocol. Used with collected volume to assess sample adequacy rates."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature of PK samples. Temperature deviations from protocol specifications can compromise analyte stability."
    - name: "distinct_subjects_with_pk_samples"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with PK samples collected. Measures PK data coverage across the enrolled population."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_specimen_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen collection operational quality and protocol compliance metrics. Tracks collection completeness, deviation rates, recollection burden, and fasting compliance — essential for site performance management and data quality oversight."
  source: "`clinical_trials_ecm`.`laboratory`.`specimen_collection`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for cross-study collection quality benchmarking."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level collection compliance and quality analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm for arm-level collection compliance comparison."
    - name: "collection_status"
      expr: collection_status
      comment: "Status of the collection event (e.g., completed, missed, partial) for completeness tracking."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected for matrix-specific quality analysis."
    - name: "collection_method"
      expr: collection_method
      comment: "Collection method used (e.g., venipuncture, fingerstick) for pre-analytical variability analysis."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting status at collection — protocol compliance for metabolic and lipid panels."
    - name: "has_deviation"
      expr: has_deviation
      comment: "Flags collection events with a protocol deviation — drives deviation reporting and site corrective action."
    - name: "recollection_required"
      expr: recollection_required
      comment: "Indicates whether recollection was required — high recollection rates signal site training or equipment issues."
    - name: "is_unscheduled"
      expr: is_unscheduled
      comment: "Identifies unscheduled collections (e.g., for adverse event workup) for protocol adherence analysis."
    - name: "hemolysis_grade"
      expr: hemolysis_grade
      comment: "Hemolysis grade of the collected specimen — hemolyzed samples may be rejected or yield unreliable results."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of specimen collection for longitudinal volume and quality trend analysis."
  measures:
    - name: "total_collections"
      expr: COUNT(1)
      comment: "Total specimen collection events. Baseline volume metric for site workload and protocol execution tracking."
    - name: "deviation_collection_count"
      expr: COUNT(CASE WHEN has_deviation = TRUE THEN 1 END)
      comment: "Number of collection events with a protocol deviation. Drives protocol deviation reporting and site performance management."
    - name: "recollection_required_count"
      expr: COUNT(CASE WHEN recollection_required = TRUE THEN 1 END)
      comment: "Number of collections requiring recollection. High recollection rates increase patient burden and site operational costs."
    - name: "unscheduled_collection_count"
      expr: COUNT(CASE WHEN is_unscheduled = TRUE THEN 1 END)
      comment: "Number of unscheduled collection events. Elevated unscheduled collections may indicate safety signals or protocol non-compliance."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume collected per collection event in mL. Volumes below protocol minimums risk insufficient sample for all required assays."
    - name: "avg_time_from_dose_hours"
      expr: AVG(CAST(time_from_dose_hours AS DOUBLE))
      comment: "Average time from dose administration to specimen collection in hours. Used to assess PK and PD sampling window compliance."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature at the collection site prior to shipment. Deviations risk pre-analytical sample degradation."
    - name: "distinct_subjects_collected"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one specimen collection. Measures collection coverage across the enrolled population."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`laboratory_reference_range`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reference range governance and regulatory compliance metrics. Tracks range version currency, sponsor-defined range adoption, CTCAE grading coverage, and approval status — essential for data standardization and regulatory submission readiness."
  source: "`clinical_trials_ecm`.`laboratory`.`reference_range`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for study-specific reference range governance analysis."
    - name: "lab_facility_id"
      expr: lab_facility_id
      comment: "Laboratory facility for facility-specific reference range management."
    - name: "lab_panel_id"
      expr: lab_panel_id
      comment: "Panel identifier for panel-level reference range coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the reference range (e.g., approved, pending, superseded) for governance tracking."
    - name: "sex_applicability"
      expr: sex_applicability
      comment: "Sex applicability of the reference range (e.g., male, female, all) for demographic-specific range management."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Specimen type for which the reference range applies."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Indicates whether this is the current active version of the reference range — superseded ranges should not be applied to new results."
    - name: "is_sponsor_defined"
      expr: is_sponsor_defined
      comment: "Indicates sponsor-defined ranges vs. laboratory-standard ranges — sponsor-defined ranges require additional governance oversight."
    - name: "range_source"
      expr: range_source
      comment: "Source of the reference range (e.g., lab-derived, literature, regulatory) for provenance and audit trail."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the reference range became effective for temporal governance analysis."
  measures:
    - name: "total_reference_ranges"
      expr: COUNT(1)
      comment: "Total reference range records. Baseline for reference range portfolio governance and version management."
    - name: "approved_range_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved reference ranges. Only approved ranges should be applied to clinical trial results for regulatory submissions."
    - name: "current_version_range_count"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Number of reference ranges that are the current active version. Ensures results are evaluated against up-to-date reference standards."
    - name: "sponsor_defined_range_count"
      expr: COUNT(CASE WHEN is_sponsor_defined = TRUE THEN 1 END)
      comment: "Number of sponsor-defined reference ranges. Sponsor-defined ranges require additional regulatory justification and governance documentation."
    - name: "avg_lower_limit"
      expr: AVG(CAST(lower_limit AS DOUBLE))
      comment: "Average lower reference limit across ranges in scope. Used for cross-facility reference range harmonization analysis."
    - name: "avg_upper_limit"
      expr: AVG(CAST(upper_limit AS DOUBLE))
      comment: "Average upper reference limit across ranges in scope. Used for cross-facility reference range harmonization analysis."
    - name: "avg_critical_low"
      expr: AVG(CAST(critical_low AS DOUBLE))
      comment: "Average critical low threshold across reference ranges. Informs critical value alert calibration and patient safety protocols."
    - name: "avg_critical_high"
      expr: AVG(CAST(critical_high AS DOUBLE))
      comment: "Average critical high threshold across reference ranges. Informs critical value alert calibration and patient safety protocols."
    - name: "distinct_facilities_with_ranges"
      expr: COUNT(DISTINCT lab_facility_id)
      comment: "Number of distinct facilities with defined reference ranges. Measures reference range governance coverage across the laboratory network."
$$;
