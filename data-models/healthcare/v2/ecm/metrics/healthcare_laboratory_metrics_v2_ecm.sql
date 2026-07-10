-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab order volume, turnaround, and operational efficiency KPIs for laboratory throughput and service-level steering."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (STAT, routine) for service-level analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the lab order."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected for the order."
    - name: "is_send_out"
      expr: is_send_out
      comment: "Whether the order was sent out to a reference lab."
    - name: "point_of_care_test"
      expr: point_of_care_test
      comment: "Whether the order is a point-of-care test."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Order month bucket for trend analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of lab orders placed."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with lab orders, indicating reach."
    - name: "send_out_orders"
      expr: SUM(CASE WHEN is_send_out = TRUE THEN 1 ELSE 0 END)
      comment: "Count of send-out orders to reference labs (cost/outsourcing driver)."
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_send_out = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of orders sent to external reference labs."
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of cancelled orders indicating workflow waste."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of orders cancelled."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_priority = 'STAT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of STAT (urgent) orders driving staffing demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Result quality, critical value management, and amendment KPIs central to lab safety and reliability."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Result status (final, preliminary, corrected)."
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Whether the result was flagged abnormal."
    - name: "is_critical_value"
      expr: is_critical_value
      comment: "Whether the result is a critical/panic value."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that performed the test."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Result month bucket for trend analysis."
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of test results produced."
    - name: "critical_value_results"
      expr: SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical value results requiring notification."
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of results that are critical values."
    - name: "amended_results"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of amended results indicating potential quality issues."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of results amended after release, a quality signal."
    - name: "abnormal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of abnormal results."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory revenue-cycle KPIs including charge capture, void rates, and STAT surcharges for financial steering."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_charge`"
  dimensions:
    - name: "charge_entry_method"
      expr: charge_entry_method
      comment: "Method of charge entry (auto, manual)."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section generating the charge."
    - name: "point_of_care_indicator"
      expr: point_of_care_indicator
      comment: "Whether the charge is for a point-of-care test."
    - name: "reference_lab_indicator"
      expr: reference_lab_indicator
      comment: "Whether the charge is for a reference lab test."
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_created_timestamp)
      comment: "Charge creation month for trending."
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of lab charges captured."
    - name: "total_stat_surcharge"
      expr: SUM(CAST(stat_surcharge_amount AS DOUBLE))
      comment: "Total STAT surcharge revenue."
    - name: "avg_stat_surcharge"
      expr: AVG(CAST(stat_surcharge_amount AS DOUBLE))
      comment: "Average STAT surcharge per charge."
    - name: "voided_charges"
      expr: SUM(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of voided charges representing lost/corrected revenue."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of charges voided, a revenue integrity metric."
    - name: "distinct_patients_charged"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with lab charges."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control performance and proficiency testing KPIs for regulatory compliance and analytical reliability."
  source: "`vibe_healthcare_v1`.`laboratory`.`qc_run`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC run (internal QC, proficiency testing)."
    - name: "qc_level"
      expr: qc_level
      comment: "QC material level."
    - name: "qc_run_status"
      expr: qc_run_status
      comment: "Status of the QC run."
    - name: "pt_graded_result"
      expr: pt_graded_result
      comment: "Proficiency testing graded result."
    - name: "qc_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "QC run month for trend monitoring."
  measures:
    - name: "total_qc_runs"
      expr: COUNT(1)
      comment: "Total number of QC runs performed."
    - name: "qc_pass_count"
      expr: SUM(CASE WHEN pass_fail_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of QC runs that passed."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "QC pass rate, a core analytical quality KPI."
    - name: "avg_pt_z_score"
      expr: AVG(CAST(pt_z_score AS DOUBLE))
      comment: "Average proficiency testing z-score indicating accuracy vs peer group."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology culture KPIs for infection control, MDRO surveillance, and turnaround performance."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_type"
      expr: culture_type
      comment: "Type of microbiology culture."
    - name: "culture_status"
      expr: culture_status
      comment: "Status of the culture workflow."
    - name: "growth_result"
      expr: growth_result
      comment: "Growth result of the culture."
    - name: "mdro_flag"
      expr: mdro_flag
      comment: "Whether a multi-drug-resistant organism was identified."
    - name: "hai_associated_flag"
      expr: hai_associated_flag
      comment: "Whether the culture is associated with a healthcare-acquired infection."
    - name: "culture_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Collection month for surveillance trending."
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures."
    - name: "mdro_positive_count"
      expr: SUM(CASE WHEN mdro_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MDRO-positive cultures for stewardship escalation."
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mdro_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of cultures identifying MDROs, a key infection-control KPI."
    - name: "hai_associated_count"
      expr: SUM(CASE WHEN hai_associated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HAI-associated cultures."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average culture turnaround time in hours."
    - name: "critical_value_count"
      expr: SUM(CASE WHEN critical_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cultures with critical values requiring notification."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen collection and pre-analytical quality KPIs including rejection rates driving lab quality and redraw costs."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen."
    - name: "accession_status"
      expr: accession_status
      comment: "Accession status of the specimen."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason a specimen was rejected."
    - name: "priority"
      expr: priority
      comment: "Specimen processing priority."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Collection month for trending."
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens collected."
    - name: "rejected_specimens"
      expr: SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of rejected specimens driving redraws and delays."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Specimen rejection rate, a pre-analytical quality KPI."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with collected specimens."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood transfusion safety KPIs including reaction rates and hemovigilance for patient safety steering."
  source: "`vibe_healthcare_v1`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Status of the transfusion event."
    - name: "transfusion_reaction_occurred"
      expr: transfusion_reaction_occurred
      comment: "Whether a transfusion reaction occurred."
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity of the transfusion reaction."
    - name: "crossmatch_result"
      expr: crossmatch_result
      comment: "Crossmatch compatibility result."
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Transfusion month for trending."
  measures:
    - name: "total_transfusions"
      expr: COUNT(1)
      comment: "Total number of transfusion events."
    - name: "reaction_count"
      expr: SUM(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transfusion reactions, a critical safety event."
    - name: "reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Transfusion reaction rate, key patient safety KPI."
    - name: "hemovigilance_reported_count"
      expr: SUM(CASE WHEN hemovigilance_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events reported to hemovigilance."
    - name: "avg_volume_transfused_ml"
      expr: AVG(CAST(transfusion_rate AS DOUBLE))
      comment: "Average transfusion rate (ml) across events."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_susceptibility_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Antimicrobial susceptibility KPIs supporting antibiotic stewardship and resistance surveillance."
  source: "`vibe_healthcare_v1`.`laboratory`.`susceptibility_result`"
  dimensions:
    - name: "antibiotic_class"
      expr: antibiotic_class
      comment: "Class of antibiotic tested."
    - name: "susceptibility_interpretation"
      expr: susceptibility_interpretation
      comment: "Interpretation (susceptible, intermediate, resistant)."
    - name: "result_status"
      expr: result_status
      comment: "Status of the susceptibility result."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Result month for resistance trending."
  measures:
    - name: "total_susceptibility_results"
      expr: COUNT(1)
      comment: "Total susceptibility results reported."
    - name: "resistant_count"
      expr: SUM(CASE WHEN susceptibility_interpretation = 'Resistant' THEN 1 ELSE 0 END)
      comment: "Count of resistant interpretations for stewardship."
    - name: "resistance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN susceptibility_interpretation = 'Resistant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Resistance rate, a core antimicrobial resistance surveillance KPI."
    - name: "reportable_public_health_count"
      expr: SUM(CASE WHEN reportable_to_public_health_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of results reportable to public health authorities."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_reagent_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent inventory and cost KPIs supporting supply management and waste reduction in the lab."
  source: "`vibe_healthcare_v1`.`laboratory`.`reagent_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Status of the reagent lot."
    - name: "qc_validation_status"
      expr: qc_validation_status
      comment: "QC validation status of the lot."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the reagent is hazardous."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Receipt month for inventory trending."
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of reagent lots."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_lot_cost AS DOUBLE))
      comment: "Total reagent lot cost for spend management."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total reagent quantity on hand."
    - name: "quarantined_lots"
      expr: SUM(CASE WHEN quarantine_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of quarantined lots indicating quality holds."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average reagent cost per unit."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anatomic pathology KPIs including cancer reporting, amendments, and critical value management."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the pathology report."
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report."
    - name: "cancer_registry_reportable_flag"
      expr: cancer_registry_reportable_flag
      comment: "Whether the case is reportable to the cancer registry."
    - name: "tumor_board_reviewed_flag"
      expr: tumor_board_reviewed_flag
      comment: "Whether the case was reviewed at tumor board."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Received month for trending."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports."
    - name: "cancer_reportable_count"
      expr: SUM(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cancer-registry-reportable cases."
    - name: "amended_reports"
      expr: SUM(CASE WHEN amended_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of amended reports, a quality signal."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN amended_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of amended pathology reports."
    - name: "critical_value_count"
      expr: SUM(CASE WHEN critical_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports with critical values."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood bank inventory KPIs including discard rates and cost for supply and waste management."
  source: "`vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product."
    - name: "unit_status"
      expr: unit_status
      comment: "Status of the blood bank unit."
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group."
    - name: "rh_type"
      expr: rh_type
      comment: "Rh type."
    - name: "donation_month"
      expr: DATE_TRUNC('MONTH', donation_date)
      comment: "Donation month for inventory trending."
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total number of blood bank units."
    - name: "discarded_units"
      expr: SUM(CASE WHEN discard_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of discarded units representing wasted product."
    - name: "discard_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discard_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Blood product discard rate, a key waste KPI."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood bank units."
    - name: "total_volume_ml"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total blood volume in inventory."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_molecular_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular/genomic testing KPIs including variant detection, turnaround, and companion diagnostics."
  source: "`vibe_healthcare_v1`.`laboratory`.`molecular_test`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of molecular test."
    - name: "test_status"
      expr: test_status
      comment: "Status of the molecular test."
    - name: "variant_detected"
      expr: variant_detected
      comment: "Whether a variant was detected."
    - name: "companion_diagnostic"
      expr: companion_diagnostic
      comment: "Whether the test is a companion diagnostic."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', result_reported_timestamp)
      comment: "Result reported month for trending."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of molecular tests."
    - name: "variant_detected_count"
      expr: SUM(CASE WHEN variant_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tests detecting a variant."
    - name: "variant_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN variant_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Variant detection rate."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average sequencing quality score."
    - name: "avg_coverage_pct"
      expr: AVG(CAST(coverage_percentage AS DOUBLE))
      comment: "Average genomic coverage percentage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_point_of_care_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-care testing KPIs including QC compliance and abnormal result rates for decentralized testing oversight."
  source: "`vibe_healthcare_v1`.`laboratory`.`point_of_care_test`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of POC test."
    - name: "test_status"
      expr: test_status
      comment: "Status of the POC test."
    - name: "qc_status"
      expr: qc_status
      comment: "QC status at time of test."
    - name: "clia_waived_flag"
      expr: clia_waived_flag
      comment: "Whether the test is CLIA-waived."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_datetime)
      comment: "Test month for trending."
  measures:
    - name: "total_poc_tests"
      expr: COUNT(1)
      comment: "Total number of point-of-care tests."
    - name: "abnormal_count"
      expr: SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of abnormal POC results."
    - name: "critical_value_count"
      expr: SUM(CASE WHEN critical_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical POC results."
    - name: "corrected_result_count"
      expr: SUM(CASE WHEN corrected_result_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrected POC results, a quality signal."
    - name: "corrected_result_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrected_result_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of POC results corrected."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab instrument fleet KPIs including operational status and downtime for capacity and maintenance planning."
  source: "`vibe_healthcare_v1`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of laboratory instrument."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the instrument."
    - name: "lab_section"
      expr: lab_section
      comment: "Lab section where instrument is deployed."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer."
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of instruments in the fleet."
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total instrument downtime hours affecting capacity."
    - name: "avg_downtime_hours"
      expr: AVG(CAST(total_downtime_hours AS DOUBLE))
      comment: "Average downtime hours per instrument."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of the instrument fleet."
    - name: "active_instrument_count"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active instruments for capacity planning."
$$;