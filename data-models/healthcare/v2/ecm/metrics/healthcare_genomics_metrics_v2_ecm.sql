-- Metric views for domain: genomics | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`genomics_biobank_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biobank specimen inventory, consent posture, and storage quality KPIs used to steer research readiness, consent compliance, and cold-chain integrity."
  source: "`vibe_healthcare_v1`.`genomics`.`biobank_specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biospecimen (blood, tissue, saliva, etc.) for cohort composition analysis."
    - name: "specimen_status"
      expr: biobank_specimen_status
      comment: "Lifecycle status of the specimen (available, depleted, discarded) for inventory steering."
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location for freezer/site capacity planning."
    - name: "consent_for_research"
      expr: consent_for_research
      comment: "Whether the donor consented to research use — key for research-eligible inventory."
    - name: "deidentified_flag"
      expr: deidentified_flag
      comment: "Whether the specimen is de-identified — relevant to governance and sharing scope."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of specimen collection for accrual trend analysis."
  measures:
    - name: "Specimen Count"
      expr: COUNT(1)
      comment: "Total number of biobank specimens — baseline inventory volume."
    - name: "Distinct Donor Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients contributing specimens — measures biobank breadth for cohort viability."
    - name: "Research Consented Specimen Count"
      expr: COUNT(DISTINCT CASE WHEN consent_for_research = TRUE THEN biobank_specimen_id END)
      comment: "Specimens with valid research consent — the research-eligible inventory that steers study feasibility."
    - name: "Research Consent Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_for_research = TRUE THEN biobank_specimen_id END) / NULLIF(COUNT(DISTINCT biobank_specimen_id), 0), 2)
      comment: "Share of specimens with research consent — consent compliance KPI driving governance action."
    - name: "Deidentified Specimen Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN deidentified_flag = TRUE THEN biobank_specimen_id END) / NULLIF(COUNT(DISTINCT biobank_specimen_id), 0), 2)
      comment: "Share of de-identified specimens — indicates data-sharing readiness and privacy posture."
    - name: "Total Volume ML"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total banked specimen volume in mL — available material for assays and allocations."
    - name: "Avg Volume ML"
      expr: AVG(CAST(volume_ml AS DOUBLE))
      comment: "Average specimen volume — indicates whether aliquots are sufficient for downstream testing."
    - name: "Avg Freezer Temperature C"
      expr: AVG(CAST(freezer_temperature_c AS DOUBLE))
      comment: "Average freezer storage temperature — cold-chain integrity KPI; drift triggers quality intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`genomics_genetic_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genetic variant reporting KPIs for clinical actionability, pathogenicity yield, and ACMG classification quality across the molecular program."
  source: "`vibe_healthcare_v1`.`genomics`.`genetic_variant`"
  dimensions:
    - name: "gene_symbol"
      expr: gene_symbol
      comment: "Gene in which the variant occurs — for gene-level yield and actionability analysis."
    - name: "acmg_classification"
      expr: acmg_classification
      comment: "ACMG classification (pathogenic, likely pathogenic, VUS, benign) for interpretation quality steering."
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Reported clinical significance for the variant."
    - name: "variant_type"
      expr: variant_type
      comment: "Type of variant (SNV, indel, CNV) for assay coverage analysis."
    - name: "assay_method"
      expr: assay_method
      comment: "Assay method used to detect the variant — for platform performance comparison."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the variant was reported for reporting-volume trend analysis."
  measures:
    - name: "Variant Count"
      expr: COUNT(1)
      comment: "Total number of reported genetic variants — baseline reporting volume."
    - name: "Distinct Tested Patient Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with reported variants — reach of the genomic testing program."
    - name: "Actionable Variant Count"
      expr: COUNT(DISTINCT CASE WHEN actionable_flag = TRUE THEN genetic_variant_id END)
      comment: "Clinically actionable variants — drives clinical follow-up and precision-medicine intervention."
    - name: "Pathogenic Variant Count"
      expr: COUNT(DISTINCT CASE WHEN pathogenic_flag = TRUE THEN genetic_variant_id END)
      comment: "Pathogenic variants identified — the diagnostic yield that steers clinical genomics value."
    - name: "Pathogenic Yield Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pathogenic_flag = TRUE THEN genetic_variant_id END) / NULLIF(COUNT(DISTINCT genetic_variant_id), 0), 2)
      comment: "Share of variants classified pathogenic — key diagnostic yield KPI for program value review."
    - name: "Actionable Yield Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actionable_flag = TRUE THEN genetic_variant_id END) / NULLIF(COUNT(DISTINCT genetic_variant_id), 0), 2)
      comment: "Share of variants that are clinically actionable — measures clinical impact of testing."
    - name: "Avg Allele Frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Average population allele frequency of reported variants — informs rarity/prioritization decisions."
    - name: "Avg Variant Allele Frequency"
      expr: AVG(CAST(variant_allele_frequency AS DOUBLE))
      comment: "Average variant allele frequency (VAF) — quality/confidence signal for somatic and germline calls."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`genomics_pharmacogenomics_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacogenomics result KPIs measuring CPIC-guided actionable findings, evidence quality, and drug-gene interaction coverage to steer precision-prescribing programs."
  source: "`vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result`"
  dimensions:
    - name: "gene_symbol"
      expr: gene_symbol
      comment: "Gene evaluated in the PGx result for gene-level phenotype analysis."
    - name: "drug_name"
      expr: drug_name
      comment: "Affected drug for drug-gene interaction coverage analysis."
    - name: "drug_class"
      expr: drug_class
      comment: "Therapeutic class of the affected drug for portfolio-level prescribing insights."
    - name: "metabolizer_status"
      expr: metabolizer_status
      comment: "Metabolizer phenotype (poor, intermediate, normal, rapid) driving dosing recommendations."
    - name: "evidence_level"
      expr: evidence_level
      comment: "Evidence level of the PGx association for recommendation-strength analysis."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_date)
      comment: "Month the PGx result was produced for trend analysis."
  measures:
    - name: "PGx Result Count"
      expr: COUNT(1)
      comment: "Total pharmacogenomics results — baseline program volume."
    - name: "Distinct Patient Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with PGx results — reach of the precision-prescribing program."
    - name: "Distinct Drug Count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct drugs with PGx guidance — breadth of drug-gene coverage for formulary decisions."
    - name: "CPIC Guided Result Count"
      expr: COUNT(DISTINCT CASE WHEN cpic_guideline_flag = TRUE THEN pharmacogenomics_result_id END)
      comment: "Results backed by a CPIC guideline — actionable, guideline-concordant findings."
    - name: "CPIC Coverage Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cpic_guideline_flag = TRUE THEN pharmacogenomics_result_id END) / NULLIF(COUNT(DISTINCT pharmacogenomics_result_id), 0), 2)
      comment: "Share of PGx results with CPIC guideline support — guideline-concordance KPI for clinical governance."
    - name: "Actionable Phenotype Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN metabolizer_status IN ('poor','intermediate','rapid','ultrarapid') THEN pharmacogenomics_result_id END) / NULLIF(COUNT(DISTINCT pharmacogenomics_result_id), 0), 2)
      comment: "Share of results with a non-normal metabolizer phenotype requiring prescribing action — drives intervention volume."
$$;