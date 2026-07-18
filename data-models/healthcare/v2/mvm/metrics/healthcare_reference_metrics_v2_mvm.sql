-- Metric views for domain: reference | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:19:49

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Code Set Version business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "Checksum Algorithm"
      expr: checksum_algorithm
    - name: "Code Set Name"
      expr: code_set_name
    - name: "Code Set Type"
      expr: code_set_type
    - name: "Compliance Year"
      expr: compliance_year
    - name: "Copyright Notice"
      expr: copyright_notice
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Download Timestamp"
      expr: download_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "File Hash"
      expr: file_hash
    - name: "File Name"
      expr: file_name
    - name: "Format Type"
      expr: format_type
    - name: "Is Hipaa Compliant"
      expr: is_hipaa_compliant
    - name: "Language Code"
      expr: language_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "License Type"
      expr: license_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Code Set Version"
      expr: COUNT(DISTINCT code_set_version_id)
    - name: "Total Record Count"
      expr: SUM(record_count)
    - name: "Average Record Count"
      expr: AVG(record_count)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cpt Code business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "Age Range High"
      expr: age_range_high
    - name: "Age Range Low"
      expr: age_range_low
    - name: "Category"
      expr: cpt_code_category
    - name: "Clinical Family"
      expr: clinical_family
    - name: "Cpt Code"
      expr: cpt_code
    - name: "Cpt Code Status"
      expr: cpt_code_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Facility Indicator"
      expr: facility_indicator
    - name: "Full Descriptor"
      expr: full_descriptor
    - name: "Gender Specific"
      expr: gender_specific
    - name: "Global Period"
      expr: global_period
    - name: "Medically Unlikely Edit Value"
      expr: medically_unlikely_edit_value
    - name: "Modifier Indicator"
      expr: modifier_indicator
    - name: "Multiple Procedure Indicator"
      expr: multiple_procedure_indicator
    - name: "Ncci Edit Indicator"
      expr: ncci_edit_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cpt Code"
      expr: COUNT(DISTINCT cpt_code_id)
    - name: "Total Anesthesia Base Units"
      expr: SUM(anesthesia_base_units)
    - name: "Average Anesthesia Base Units"
      expr: AVG(anesthesia_base_units)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Malpractice Rvu"
      expr: SUM(malpractice_rvu)
    - name: "Average Malpractice Rvu"
      expr: AVG(malpractice_rvu)
    - name: "Total National Payment Amount"
      expr: SUM(national_payment_amount)
    - name: "Average National Payment Amount"
      expr: AVG(national_payment_amount)
    - name: "Total Practice Expense Rvu"
      expr: SUM(practice_expense_rvu)
    - name: "Average Practice Expense Rvu"
      expr: AVG(practice_expense_rvu)
    - name: "Total Total Rvu"
      expr: SUM(total_rvu)
    - name: "Average Total Rvu"
      expr: AVG(total_rvu)
    - name: "Total Work Rvu"
      expr: SUM(work_rvu)
    - name: "Average Work Rvu"
      expr: AVG(work_rvu)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crosswalk business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "Approximate Flag"
      expr: approximate_flag
    - name: "Choice List Indicator"
      expr: choice_list_indicator
    - name: "Combination Flag"
      expr: combination_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Directionality"
      expr: directionality
    - name: "Effective Date"
      expr: effective_date
    - name: "Last Validated Date"
      expr: last_validated_date
    - name: "Map Group"
      expr: map_group
    - name: "Map Priority"
      expr: map_priority
    - name: "Mapping Authority"
      expr: mapping_authority
    - name: "Mapping Purpose"
      expr: mapping_purpose
    - name: "Mapping Quality"
      expr: mapping_quality
    - name: "Mapping Rule"
      expr: mapping_rule
    - name: "Mapping Type"
      expr: mapping_type
    - name: "No Map Flag"
      expr: no_map_flag
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crosswalk"
      expr: COUNT(DISTINCT crosswalk_id)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drg business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`drg`"
  dimensions:
    - name: "Bundled Payment Flag"
      expr: bundled_payment_flag
    - name: "Clinical Family"
      expr: clinical_family
    - name: "Code"
      expr: drg_code
    - name: "Complication Level"
      expr: complication_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Drg Type"
      expr: drg_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Grouper System"
      expr: grouper_system
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "National Case Volume"
      expr: national_case_volume
    - name: "Operating Room Procedure Flag"
      expr: operating_room_procedure_flag
    - name: "Post Acute Transfer Flag"
      expr: post_acute_transfer_flag
    - name: "Principal Diagnosis Range End"
      expr: principal_diagnosis_range_end
    - name: "Principal Diagnosis Range Start"
      expr: principal_diagnosis_range_start
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drg"
      expr: COUNT(DISTINCT drg_id)
    - name: "Total Arithmetic Mean Los"
      expr: SUM(arithmetic_mean_los)
    - name: "Average Arithmetic Mean Los"
      expr: AVG(arithmetic_mean_los)
    - name: "Total Cost Outlier Threshold"
      expr: SUM(cost_outlier_threshold)
    - name: "Average Cost Outlier Threshold"
      expr: AVG(cost_outlier_threshold)
    - name: "Total Geometric Mean Los"
      expr: SUM(geometric_mean_los)
    - name: "Average Geometric Mean Los"
      expr: AVG(geometric_mean_los)
    - name: "Total National Average Charges"
      expr: SUM(national_average_charges)
    - name: "Average National Average Charges"
      expr: AVG(national_average_charges)
    - name: "Total National Average Payment"
      expr: SUM(national_average_payment)
    - name: "Average National Average Payment"
      expr: AVG(national_average_payment)
    - name: "Total Relative Weight"
      expr: SUM(relative_weight)
    - name: "Average Relative Weight"
      expr: AVG(relative_weight)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_hcpcs_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcpcs Code business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`hcpcs_code`"
  dimensions:
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Asc Payment Indicator"
      expr: asc_payment_indicator
    - name: "Assistant Surgeon Indicator"
      expr: assistant_surgeon_indicator
    - name: "Bilateral Surgery Indicator"
      expr: bilateral_surgery_indicator
    - name: "Category"
      expr: hcpcs_code_category
    - name: "Co Surgeon Indicator"
      expr: co_surgeon_indicator
    - name: "Code"
      expr: code
    - name: "Code Type"
      expr: code_type
    - name: "Coverage Indicator"
      expr: coverage_indicator
    - name: "Diagnosis Requirement Indicator"
      expr: diagnosis_requirement_indicator
    - name: "Dme Indicator"
      expr: dme_indicator
    - name: "Drug Indicator"
      expr: drug_indicator
    - name: "Effective Date"
      expr: effective_date
    - name: "Frequency Limit"
      expr: frequency_limit
    - name: "Gender Restriction"
      expr: gender_restriction
    - name: "Global Period"
      expr: global_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcpcs Code"
      expr: COUNT(DISTINCT hcpcs_code_id)
    - name: "Total Anesthesia Base Units"
      expr: SUM(anesthesia_base_units)
    - name: "Average Anesthesia Base Units"
      expr: AVG(anesthesia_base_units)
    - name: "Total Intraoperative Percentage"
      expr: SUM(intraoperative_percentage)
    - name: "Average Intraoperative Percentage"
      expr: AVG(intraoperative_percentage)
    - name: "Total Postoperative Percentage"
      expr: SUM(postoperative_percentage)
    - name: "Average Postoperative Percentage"
      expr: AVG(postoperative_percentage)
    - name: "Total Preoperative Percentage"
      expr: SUM(preoperative_percentage)
    - name: "Average Preoperative Percentage"
      expr: AVG(preoperative_percentage)
    - name: "Total Quantity Limit"
      expr: SUM(quantity_limit)
    - name: "Average Quantity Limit"
      expr: AVG(quantity_limit)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Icd Code business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "Age High"
      expr: age_high
    - name: "Age Low"
      expr: age_low
    - name: "Billable Flag"
      expr: billable_flag
    - name: "Category"
      expr: icd_code_category
    - name: "Cc Flag"
      expr: cc_flag
    - name: "Chapter"
      expr: chapter
    - name: "Chapter Code"
      expr: chapter_code
    - name: "Code"
      expr: code
    - name: "Code Type"
      expr: code_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Etiology Code Flag"
      expr: etiology_code_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gender Specific Flag"
      expr: gender_specific_flag
    - name: "Hac Flag"
      expr: hac_flag
    - name: "Long Description"
      expr: long_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Icd Code"
      expr: COUNT(DISTINCT icd_code_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_loinc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loinc Code business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`loinc_code`"
  dimensions:
    - name: "Class"
      expr: class
    - name: "Component"
      expr: component
    - name: "Consumer Name"
      expr: consumer_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecated Date"
      expr: deprecated_date
    - name: "Display Name"
      expr: display_name
    - name: "Effective Date"
      expr: effective_date
    - name: "Example Ucum Units"
      expr: example_ucum_units
    - name: "Example Units"
      expr: example_units
    - name: "External Copyright Notice"
      expr: external_copyright_notice
    - name: "Hl7 Field Subfield Code"
      expr: hl7_field_subfield_code
    - name: "Hl7 V3 Code System Oid"
      expr: hl7_v3_code_system_oid
    - name: "Is Active"
      expr: is_active
    - name: "Last Verified Date"
      expr: last_verified_date
    - name: "Local Code"
      expr: local_code
    - name: "Loinc Number"
      expr: loinc_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loinc Code"
      expr: COUNT(DISTINCT loinc_code_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ndc Drug business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "Active Ingredient"
      expr: active_ingredient
    - name: "Application Number"
      expr: application_number
    - name: "Atc Code"
      expr: atc_code
    - name: "Biosimilar Flag"
      expr: biosimilar_flag
    - name: "Black Box Warning Flag"
      expr: black_box_warning_flag
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fhir Medication Code"
      expr: fhir_medication_code
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Gpi Code"
      expr: gpi_code
    - name: "High Alert Medication Flag"
      expr: high_alert_medication_flag
    - name: "Labeler Name"
      expr: labeler_name
    - name: "Marketing Category"
      expr: marketing_category
    - name: "Marketing End Date"
      expr: marketing_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ndc Drug"
      expr: COUNT(DISTINCT ndc_drug_id)
    - name: "Total Package Quantity"
      expr: SUM(package_quantity)
    - name: "Average Package Quantity"
      expr: AVG(package_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snomed Concept business metrics"
  source: "`vibe_healthcare_v1`.`reference`.`snomed_concept`"
  dimensions:
    - name: "Clinical Documentation Section"
      expr: clinical_documentation_section
    - name: "Concept Class"
      expr: concept_class
    - name: "Concept Definition"
      expr: concept_definition
    - name: "Concept Status"
      expr: concept_status
    - name: "Cpt Map Target"
      expr: cpt_map_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Definition Status"
      expr: definition_status
    - name: "Effective Time"
      expr: effective_time
    - name: "Fhir Value Set Membership"
      expr: fhir_value_set_membership
    - name: "Fully Specified Name"
      expr: fully_specified_name
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Icd10 Map Correlation"
      expr: icd10_map_correlation
    - name: "Icd10 Map Target"
      expr: icd10_map_target
    - name: "Is Ehr Preferred"
      expr: is_ehr_preferred
    - name: "Is Leaf Concept"
      expr: is_leaf_concept
    - name: "Is Primitive"
      expr: is_primitive
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Snomed Concept"
      expr: COUNT(DISTINCT snomed_concept_id)
    - name: "Total Module Code"
      expr: SUM(module_code)
    - name: "Average Module Code"
      expr: AVG(module_code)
$$;
