-- Metric views for domain: clinical | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_assay_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality metrics for assay QC runs, enabling monitoring of pass rates and error trends"
  source: "`genomics_biotech_ecm`.`clinical`.`assay_qc_run`"
  dimensions:
    - name: "run_date"
      expr: DATE_TRUNC('day', run_date)
      comment: "Date of the QC run (day level)"
    - name: "qc_status"
      expr: qc_status
      comment: "Pass/Fail status of the QC run"
    - name: "asset_id"
      expr: asset_id
      comment: "Instrument asset identifier used for the run"
    - name: "lot_id"
      expr: lot_id
      comment: "Lot identifier of the reagent used"
    - name: "flow_cell_id"
      expr: flow_cell_id
      comment: "Flow cell identifier used in sequencing"
  measures:
    - name: "total_qc_runs"
      expr: COUNT(1)
      comment: "Total number of assay QC runs recorded"
    - name: "pass_count"
      expr: SUM(CASE WHEN qc_status = 'PASS' THEN 1 ELSE 0 END)
      comment: "Count of QC runs that passed quality criteria"
    - name: "avg_error_rate_percent"
      expr: AVG(CAST(error_rate_percent AS DOUBLE))
      comment: "Average sequencing error rate across QC runs"
    - name: "avg_duplicate_rate_percent"
      expr: AVG(CAST(duplicate_rate_percent AS DOUBLE))
      comment: "Average duplicate read rate across QC runs"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_test_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and operational efficiency metrics for clinical test orders"
  source: "`genomics_biotech_ecm`.`clinical`.`test_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the order was placed (day level)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the test order"
    - name: "account_id"
      expr: account_id
      comment: "Account (customer) identifier for the order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of test orders placed"
    - name: "total_revenue_usd"
      expr: SUM(CAST(test_price_usd AS DOUBLE))
      comment: "Total revenue from test orders (USD)"
    - name: "avg_actual_tat_hours"
      expr: AVG(CAST(actual_tat_hours AS DOUBLE))
      comment: "Average actual turnaround time (hours) per order"
    - name: "avg_test_price_usd"
      expr: AVG(CAST(test_price_usd AS DOUBLE))
      comment: "Average price per test order (USD)"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_genomic_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical significance and frequency metrics for genomic variant results"
  source: "`genomics_biotech_ecm`.`clinical`.`genomic_result`"
  dimensions:
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinically interpreted significance of the variant"
    - name: "variant_classification"
      expr: variant_classification
      comment: "Classification of the variant (e.g., SNV, INDEL)"
    - name: "gene_model_id"
      expr: gene_model_id
      comment: "Identifier of the gene model associated with the variant"
  measures:
    - name: "total_variants"
      expr: COUNT(1)
      comment: "Total number of genomic variant records generated"
    - name: "pathogenic_variant_count"
      expr: SUM(CASE WHEN clinical_significance = 'Pathogenic' THEN 1 ELSE 0 END)
      comment: "Count of variants classified as pathogenic"
    - name: "avg_maf_gnomad"
      expr: AVG(CAST(maf_gnomad AS DOUBLE))
      comment: "Average minor allele frequency (gnomAD) across variants"
    - name: "avg_allele_frequency"
      expr: AVG(CAST(variant_allele_frequency AS DOUBLE))
      comment: "Average observed allele frequency in the cohort"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`clinical_assay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost metrics for clinical assays"
  source: "`genomics_biotech_ecm`.`clinical`.`clinical_assay`"
  dimensions:
    - name: "assay_type"
      expr: assay_type
      comment: "Type/category of the assay"
    - name: "platform"
      expr: platform
      comment: "Technology platform used for the assay"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the assay (e.g., Active, Retired)"
  measures:
    - name: "total_assays"
      expr: COUNT(1)
      comment: "Total number of clinical assays defined"
    - name: "avg_price_usd"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average assay price (USD)"
    - name: "avg_limit_of_detection"
      expr: AVG(CAST(limit_of_detection AS DOUBLE))
      comment: "Average limit of detection across assays"
    - name: "avg_sensitivity_percent"
      expr: AVG(CAST(sensitivity_percent AS DOUBLE))
      comment: "Average analytical sensitivity percentage"
    - name: "avg_specificity_percent"
      expr: AVG(CAST(specificity_percent AS DOUBLE))
      comment: "Average analytical specificity percentage"
$$;
