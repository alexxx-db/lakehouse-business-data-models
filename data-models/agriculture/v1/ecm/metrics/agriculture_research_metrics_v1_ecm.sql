-- Metric views for domain: research | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`research_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trial performance and scope metrics"
  source: "`agriculture_ecm`.`research`.`trial`"
  dimensions:
    - name: "program_id"
      expr: program_id
      comment: "Program identifier linking trial to research program"
    - name: "crop_species"
      expr: crop_species
      comment: "Crop species under trial"
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the trial (e.g., Active, Completed)"
    - name: "start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Calendar year when trial started"
    - name: "trial_type"
      expr: trial_type
      comment: "Classification of trial (e.g., Field, Greenhouse)"
  measures:
    - name: "total_trials"
      expr: COUNT(1)
      comment: "Total number of research trials"
    - name: "total_economic_threshold"
      expr: SUM(CAST(economic_threshold AS DOUBLE))
      comment: "Sum of economic threshold values across trials (USD)"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`research_yield_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield outcomes per trial and variety"
  source: "`agriculture_ecm`.`research`.`yield_measurement`"
  dimensions:
    - name: "trial_id"
      expr: trial_id
      comment: "Identifier of the trial associated with the measurement"
    - name: "variety_id"
      expr: variety_id
      comment: "Variety being measured"
    - name: "crop_species"
      expr: crop_species
      comment: "Crop species of the measurement"
    - name: "harvest_year"
      expr: DATE_TRUNC('year', harvest_date)
      comment: "Year of harvest"
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates if the variety is genetically modified"
  measures:
    - name: "total_harvested_weight_kg"
      expr: SUM(CAST(harvested_weight_kg AS DOUBLE))
      comment: "Total harvested weight across measurements (kg)"
    - name: "avg_adjusted_yield_bu_ac"
      expr: AVG(CAST(adjusted_yield_bu_ac AS DOUBLE))
      comment: "Average adjusted yield (bushels per acre)"
    - name: "total_adjusted_yield_mt_ha"
      expr: SUM(CAST(adjusted_yield_mt_ha AS DOUBLE))
      comment: "Total adjusted yield (metric tons per hectare)"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`research_input_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Input usage cost and exposure metrics"
  source: "`agriculture_ecm`.`research`.`input_usage`"
  dimensions:
    - name: "trial_id"
      expr: trial_id
      comment: "Trial associated with the input usage"
    - name: "input_material_type"
      expr: input_material_type
      comment: "Type/category of input material"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost values"
    - name: "gmo_input_flag"
      expr: gmo_input_flag
      comment: "Boolean flag indicating GMO input"
    - name: "usage_status"
      expr: usage_status
      comment: "Status of the usage record (e.g., Completed, Pending)"
  measures:
    - name: "total_input_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of inputs used per trial (currency as per record)"
    - name: "avg_area_treated_ha"
      expr: AVG(CAST(area_treated_ha AS DOUBLE))
      comment: "Average area treated per input usage record (hectares)"
    - name: "total_quantity_used"
      expr: SUM(CAST(quantity_used AS DOUBLE))
      comment: "Total quantity of input material used"
    - name: "gmo_input_count"
      expr: SUM(CASE WHEN gmo_input_flag THEN 1 ELSE 0 END)
      comment: "Count of input records flagged as GMO"
    - name: "total_input_records"
      expr: COUNT(1)
      comment: "Total number of input usage records"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`research_accession`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accession quality and inventory metrics"
  source: "`agriculture_ecm`.`research`.`accession`"
  dimensions:
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier for the accession"
    - name: "crop_species"
      expr: crop_species
      comment: "Crop species of the accession"
    - name: "collection_country_code"
      expr: collection_country_code
      comment: "Country where accession was collected"
    - name: "storage_type"
      expr: storage_type
      comment: "Storage type (e.g., Cold, Ambient)"
    - name: "organic_eligible"
      expr: organic_eligible
      comment: "Indicates if accession is eligible for organic certification"
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status label for the accession"
  measures:
    - name: "total_available_seed_quantity_g"
      expr: SUM(CAST(available_seed_quantity_g AS DOUBLE))
      comment: "Total available seed quantity across accessions (grams)"
    - name: "avg_germination_rate_pct"
      expr: AVG(CAST(germination_rate_pct AS DOUBLE))
      comment: "Average germination rate percentage"
    - name: "total_accessions"
      expr: COUNT(1)
      comment: "Total number of accession records"
    - name: "gmo_accession_count"
      expr: SUM(CASE WHEN gmo_status = 'GMO' THEN 1 ELSE 0 END)
      comment: "Count of accessions flagged as GMO"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`research_biotech_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biotech submission throughput and approval metrics"
  source: "`agriculture_ecm`.`research`.`biotech_submission`"
  dimensions:
    - name: "program_id"
      expr: program_id
      comment: "Program linked to the submission"
    - name: "crop_species"
      expr: crop_species
      comment: "Crop species targeted by the submission"
    - name: "is_gmo_submission"
      expr: is_gmo_submission
      comment: "Boolean indicating if the submission involves a GMO"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., New, Amendment)"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Priority flag for the submission"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of biotech submissions"
    - name: "avg_decision_time_days"
      expr: AVG(DATEDIFF(agency_decision_date, submission_date))
      comment: "Average days from submission to agency decision"
    - name: "approved_submission_count"
      expr: SUM(CASE WHEN submission_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of submissions with status Approved"
$$;
