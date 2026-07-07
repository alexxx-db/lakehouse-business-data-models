-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core laboratory order metrics tracking order volume, turnaround time, cancellation rates, and operational efficiency across order priorities and statuses."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the lab order (STAT, routine, urgent) for segmenting turnaround time and resource allocation analysis."
    - name: "lab_order_status"
      expr: lab_order_status
      comment: "Current status of the lab order (pending, in-progress, completed, cancelled) for workflow and completion tracking."
    - name: "order_status"
      expr: order_status
      comment: "General order status for high-level order lifecycle tracking and operational dashboards."
    - name: "point_of_care_test"
      expr: point_of_care_test
      comment: "Flag indicating whether test is performed at point of care vs central lab, critical for capacity planning and quality monitoring."
    - name: "is_send_out"
      expr: is_send_out
      comment: "Flag indicating whether specimen is sent to reference lab, key for cost analysis and turnaround time expectations."
    - name: "fasting_required"
      expr: fasting_required
      comment: "Flag indicating whether patient fasting is required, important for scheduling and patient preparation compliance."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Flag indicating whether payer authorization is required, critical for revenue cycle and denial prevention."
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year of order placement for year-over-year trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for seasonal trend analysis and capacity planning."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used for specimen collection (venipuncture, capillary, etc.) for quality and training analysis."
  measures:
    - name: "total_lab_orders"
      expr: COUNT(1)
      comment: "Total number of lab orders placed, fundamental volume metric for capacity planning and workload management."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN lab_order_status = 'cancelled' OR order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled lab orders, key quality and efficiency metric indicating waste and rework."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lab_order_status = 'cancelled' OR order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders cancelled, critical quality metric for process improvement and cost reduction initiatives."
    - name: "send_out_orders"
      expr: COUNT(CASE WHEN is_send_out = TRUE THEN 1 END)
      comment: "Count of orders sent to reference labs, key for cost management and strategic insourcing decisions."
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders requiring send-out to reference labs, strategic metric for capacity and capability investment decisions."
    - name: "stat_orders"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Count of STAT priority orders, critical for emergency department and ICU performance monitoring."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders marked STAT, key operational metric for resource allocation and appropriateness monitoring."
    - name: "point_of_care_orders"
      expr: COUNT(CASE WHEN point_of_care_test = TRUE THEN 1 END)
      comment: "Count of point-of-care tests performed, important for decentralized testing strategy and quality oversight."
    - name: "authorization_required_orders"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Count of orders requiring payer authorization, key revenue cycle metric for denial prevention and cash flow."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patient count receiving lab services, key for population health and utilization analysis."
    - name: "distinct_visits"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visit count with lab orders, important for encounter-level utilization and efficiency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result quality and turnaround metrics tracking critical values, abnormal results, amendments, and notification compliance."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "test_result_status"
      expr: test_result_status
      comment: "Status of the test result (preliminary, final, corrected) for result lifecycle and quality tracking."
    - name: "result_status"
      expr: result_status
      comment: "General result status for high-level result completion tracking."
    - name: "critical_flag"
      expr: critical_flag
      comment: "Flag indicating critical/panic value requiring immediate clinical action, key patient safety metric."
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Flag indicating result outside normal reference range, important for clinical decision support and quality."
    - name: "is_critical_value"
      expr: is_critical_value
      comment: "Boolean indicating critical value status, essential for patient safety monitoring and regulatory compliance."
    - name: "is_amended"
      expr: is_amended
      comment: "Flag indicating result has been amended, key quality metric for error tracking and process improvement."
    - name: "delta_check_flag"
      expr: delta_check_flag
      comment: "Flag indicating significant change from previous result, important for quality control and clinical validation."
    - name: "result_year"
      expr: YEAR(result_datetime)
      comment: "Year of result finalization for year-over-year quality and volume trend analysis."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month of result finalization for seasonal trend and capacity planning analysis."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section performing the test (chemistry, hematology, microbiology) for departmental performance tracking."
    - name: "test_name"
      expr: test_name
      comment: "Name of the test performed for test-specific quality and utilization analysis."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results produced, fundamental volume metric for laboratory productivity and capacity."
    - name: "critical_value_results"
      expr: COUNT(CASE WHEN critical_flag = TRUE OR is_critical_value = TRUE THEN 1 END)
      comment: "Count of critical/panic value results, essential patient safety metric requiring immediate notification."
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_flag = TRUE OR is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are critical values, key patient safety and acuity metric for resource planning."
    - name: "abnormal_results"
      expr: COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END)
      comment: "Count of abnormal test results, important clinical quality metric for population health and diagnostic yield."
    - name: "abnormal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results outside normal range, key metric for test appropriateness and clinical utility."
    - name: "amended_results"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Count of results requiring amendment/correction, critical quality metric for error rate and process improvement."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results amended, key quality metric for laboratory accuracy and regulatory compliance."
    - name: "critical_values_notified"
      expr: COUNT(CASE WHEN critical_value_notification_datetime IS NOT NULL THEN 1 END)
      comment: "Count of critical values with documented notification, essential patient safety and compliance metric."
    - name: "critical_value_notification_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_value_notification_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_flag = TRUE OR is_critical_value = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical values with documented notification, regulatory compliance and patient safety metric."
    - name: "delta_check_flags"
      expr: COUNT(CASE WHEN delta_check_flag = TRUE THEN 1 END)
      comment: "Count of results triggering delta check alerts, quality control metric for result validation and error detection."
    - name: "distinct_patients_tested"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patient count with test results, key for population reach and utilization analysis."
    - name: "distinct_tests_performed"
      expr: COUNT(DISTINCT test_catalog_id)
      comment: "Unique test types performed, important for test menu diversity and capability assessment."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across all tests, useful for population health trending and quality control."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen quality and handling metrics tracking rejection rates, collection quality, storage compliance, and pre-analytical process performance."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_status"
      expr: specimen_status
      comment: "Current status of specimen (collected, received, rejected, disposed) for specimen lifecycle tracking."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (blood, urine, tissue) for collection quality and handling analysis."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used for specimen collection, important for quality control and training effectiveness."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Patient fasting status at collection, critical for test validity and result interpretation."
    - name: "fasting_flag"
      expr: fasting_flag
      comment: "Boolean indicating fasting specimen, key for quality assurance and protocol compliance."
    - name: "hemolysis_index"
      expr: hemolysis_index
      comment: "Degree of hemolysis in specimen, critical pre-analytical quality metric affecting result validity."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for specimen rejection (hemolyzed, insufficient volume, mislabeled), key for quality improvement."
    - name: "collection_year"
      expr: YEAR(collection_date)
      comment: "Year of specimen collection for year-over-year quality trend analysis."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of specimen collection for seasonal quality and volume trend analysis."
    - name: "container_type"
      expr: container_type
      comment: "Type of collection container used, important for protocol compliance and quality control."
    - name: "biohazard_level"
      expr: biohazard_level
      comment: "Biohazard classification of specimen, critical for safety compliance and handling protocols."
    - name: "retention_status"
      expr: retention_status
      comment: "Current retention status of specimen, important for storage capacity and compliance management."
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens collected, fundamental volume metric for phlebotomy and collection operations."
    - name: "rejected_specimens"
      expr: COUNT(CASE WHEN specimen_status = 'rejected' OR rejection_reason IS NOT NULL THEN 1 END)
      comment: "Count of rejected specimens, critical pre-analytical quality metric driving recollection costs and delays."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN specimen_status = 'rejected' OR rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens rejected, key quality metric for phlebotomy training and process improvement."
    - name: "hemolyzed_specimens"
      expr: COUNT(CASE WHEN hemolysis_index IS NOT NULL AND hemolysis_index != 'none' THEN 1 END)
      comment: "Count of hemolyzed specimens, major pre-analytical quality issue affecting result accuracy and recollection."
    - name: "hemolysis_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hemolysis_index IS NOT NULL AND hemolysis_index != 'none' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens with hemolysis, critical quality metric for collection technique and training effectiveness."
    - name: "fasting_specimens"
      expr: COUNT(CASE WHEN fasting_flag = TRUE THEN 1 END)
      comment: "Count of fasting specimens collected, important for protocol compliance and patient preparation quality."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average specimen volume collected in milliliters, key metric for collection adequacy and efficiency."
    - name: "total_volume_collected_ml"
      expr: SUM(CAST(volume_collected_ml AS DOUBLE))
      comment: "Total specimen volume collected across all specimens, useful for supply planning and capacity analysis."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius, critical quality control metric for specimen integrity and compliance."
    - name: "distinct_patients_collected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patient count with specimens collected, key for phlebotomy workload and access analysis."
    - name: "distinct_visits_with_specimens"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visit count with specimen collection, important for encounter-level collection efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood bank inventory and transfusion metrics tracking unit utilization, wastage, crossmatch efficiency, and blood product management."
  source: "`vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "blood_bank_unit_status"
      expr: blood_bank_unit_status
      comment: "Current status of blood unit (available, reserved, issued, transfused, discarded) for inventory management."
    - name: "unit_status"
      expr: unit_status
      comment: "General unit status for high-level inventory tracking and availability analysis."
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product (RBC, plasma, platelets, cryoprecipitate) for inventory mix and demand planning."
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group (A, B, AB, O) for inventory stratification and crossmatch planning."
    - name: "rh_type"
      expr: rh_type
      comment: "Rh factor (positive/negative) for inventory management and emergency preparedness."
    - name: "crossmatch_required_flag"
      expr: crossmatch_required_flag
      comment: "Flag indicating whether crossmatch is required, important for workflow and turnaround time analysis."
    - name: "irradiation_status"
      expr: irradiation_status
      comment: "Irradiation status of unit, critical for immunocompromised patient safety and inventory segmentation."
    - name: "leukoreduction_status"
      expr: leukoreduction_status
      comment: "Leukoreduction status, important for quality and specialized patient population requirements."
    - name: "cmv_status"
      expr: cmv_status
      comment: "CMV antibody status, critical for neonatal and immunocompromised patient transfusion safety."
    - name: "discard_reason"
      expr: discard_reason
      comment: "Reason for unit discard (expired, contaminated, damaged), key for waste reduction and cost management."
    - name: "temperature_alarm_flag"
      expr: temperature_alarm_flag
      comment: "Flag indicating storage temperature excursion, critical patient safety and quality metric."
    - name: "issue_year"
      expr: YEAR(issue_timestamp)
      comment: "Year of unit issue for year-over-year utilization trend analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month of unit issue for seasonal demand planning and inventory optimization."
  measures:
    - name: "total_blood_units"
      expr: COUNT(1)
      comment: "Total number of blood units in inventory system, fundamental metric for blood bank operations and capacity."
    - name: "units_transfused"
      expr: COUNT(CASE WHEN transfusion_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of units actually transfused to patients, key utilization metric for clinical demand and inventory planning."
    - name: "units_discarded"
      expr: COUNT(CASE WHEN discard_timestamp IS NOT NULL OR discard_reason IS NOT NULL THEN 1 END)
      comment: "Count of units discarded/wasted, critical cost and quality metric for inventory management optimization."
    - name: "discard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discard_timestamp IS NOT NULL OR discard_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units discarded, key efficiency metric for inventory turnover and waste reduction initiatives."
    - name: "transfusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfusion_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units transfused, utilization efficiency metric for inventory optimization and demand forecasting."
    - name: "crossmatch_required_units"
      expr: COUNT(CASE WHEN crossmatch_required_flag = TRUE THEN 1 END)
      comment: "Count of units requiring crossmatch, important for workflow planning and turnaround time management."
    - name: "irradiated_units"
      expr: COUNT(CASE WHEN irradiation_status = 'irradiated' THEN 1 END)
      comment: "Count of irradiated units, key for specialized patient population support and processing capacity."
    - name: "temperature_alarm_units"
      expr: COUNT(CASE WHEN temperature_alarm_flag = TRUE THEN 1 END)
      comment: "Count of units with temperature excursions, critical patient safety and quality control metric."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges for blood products, key revenue metric for blood bank financial performance."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood products, essential for margin analysis and cost management."
    - name: "avg_charge_per_unit"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per blood unit, important pricing and revenue optimization metric."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per blood unit, key for cost control and supplier negotiation analysis."
    - name: "total_volume_ml"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total volume of blood products in milliliters, useful for inventory capacity and supply planning."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius, critical quality control metric for product integrity and compliance."
    - name: "distinct_patients_transfused"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patient count receiving transfusions, key for clinical utilization and patient safety monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anatomic pathology quality and turnaround metrics tracking cancer diagnosis, critical value notification, amendment rates, and reporting timeliness."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "pathology_report_status"
      expr: pathology_report_status
      comment: "Current status of pathology report (preliminary, final, amended) for workflow and turnaround tracking."
    - name: "report_status"
      expr: report_status
      comment: "General report status for high-level completion tracking and operational dashboards."
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report (surgical, cytology, autopsy) for workload and resource allocation analysis."
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Flag indicating critical pathology finding requiring immediate notification, key patient safety metric."
    - name: "cancer_registry_reportable_flag"
      expr: cancer_registry_reportable_flag
      comment: "Flag indicating case must be reported to cancer registry, essential for regulatory compliance and public health."
    - name: "tumor_board_reviewed_flag"
      expr: tumor_board_reviewed_flag
      comment: "Flag indicating case reviewed by multidisciplinary tumor board, quality metric for complex case management."
    - name: "histologic_type"
      expr: histologic_type
      comment: "Histologic classification of tissue, important for cancer registry and clinical research analysis."
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Tumor grade classification, critical for cancer staging and treatment planning."
    - name: "tnm_stage"
      expr: tnm_stage
      comment: "TNM cancer stage, essential for oncology outcomes tracking and registry reporting."
    - name: "margin_status"
      expr: margin_status
      comment: "Surgical margin status (positive/negative), critical quality metric for surgical oncology outcomes."
    - name: "tumor_site"
      expr: tumor_site
      comment: "Anatomic site of tumor, important for cancer registry and epidemiologic analysis."
    - name: "sign_out_year"
      expr: YEAR(sign_out_timestamp)
      comment: "Year of report sign-out for year-over-year volume and turnaround trend analysis."
    - name: "sign_out_month"
      expr: DATE_TRUNC('MONTH', sign_out_timestamp)
      comment: "Month of report sign-out for seasonal workload and capacity planning."
  measures:
    - name: "total_pathology_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports issued, fundamental volume metric for anatomic pathology workload."
    - name: "cancer_cases"
      expr: COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END)
      comment: "Count of cancer registry reportable cases, critical for oncology program tracking and regulatory compliance."
    - name: "cancer_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that are cancer diagnoses, key metric for oncology program volume and case mix."
    - name: "critical_value_reports"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Count of reports with critical findings, essential patient safety metric requiring immediate notification."
    - name: "critical_values_notified"
      expr: COUNT(CASE WHEN critical_value_notification_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of critical values with documented notification, key patient safety and compliance metric."
    - name: "critical_value_notification_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_value_notification_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical pathology findings with documented notification, regulatory compliance and safety metric."
    - name: "amended_reports"
      expr: COUNT(CASE WHEN amended_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of reports requiring amendment, critical quality metric for diagnostic accuracy and process improvement."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amended_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports amended, key quality metric for pathologist accuracy and peer review effectiveness."
    - name: "tumor_board_reviewed_cases"
      expr: COUNT(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 END)
      comment: "Count of cases reviewed by tumor board, quality metric for multidisciplinary care and complex case management."
    - name: "positive_margin_cases"
      expr: COUNT(CASE WHEN margin_status = 'positive' THEN 1 END)
      comment: "Count of cases with positive surgical margins, critical quality metric for surgical oncology outcomes."
    - name: "avg_tumor_size_cm"
      expr: AVG(CAST(tumor_size_cm AS DOUBLE))
      comment: "Average tumor size in centimeters, important for cancer staging and outcomes analysis."
    - name: "distinct_patients_with_pathology"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patient count with pathology reports, key for anatomic pathology utilization and access analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology culture quality and infection control metrics tracking pathogen detection, MDRO surveillance, HAI monitoring, and antibiotic stewardship."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "microbiology_culture_status"
      expr: microbiology_culture_status
      comment: "Current status of culture (pending, final, preliminary) for workflow and turnaround tracking."
    - name: "culture_status"
      expr: culture_status
      comment: "General culture status for high-level completion tracking."
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed (blood, urine, wound, respiratory) for workload and epidemiology analysis."
    - name: "growth_result"
      expr: growth_result
      comment: "Culture growth result (positive, negative, contaminated), key for infection detection and quality control."
    - name: "gram_stain_result"
      expr: gram_stain_result
      comment: "Gram stain result, important for rapid preliminary diagnosis and empiric therapy guidance."
    - name: "mdro_flag"
      expr: mdro_flag
      comment: "Flag indicating multidrug-resistant organism detected, critical for infection control and antibiotic stewardship."
    - name: "mdro_type"
      expr: mdro_type
      comment: "Type of MDRO detected (MRSA, VRE, CRE), essential for surveillance and outbreak management."
    - name: "hai_associated_flag"
      expr: hai_associated_flag
      comment: "Flag indicating healthcare-associated infection, key quality and regulatory reporting metric."
    - name: "hai_event_type"
      expr: hai_event_type
      comment: "Type of HAI event (CLABSI, CAUTI, SSI), critical for NHSN reporting and quality improvement."
    - name: "public_health_reportable_flag"
      expr: public_health_reportable_flag
      comment: "Flag indicating reportable disease to public health, essential for regulatory compliance and surveillance."
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Flag indicating critical microbiology finding requiring immediate notification, patient safety metric."
    - name: "antibiotic_stewardship_flag"
      expr: antibiotic_stewardship_flag
      comment: "Flag indicating case requires antibiotic stewardship review, key for antimicrobial optimization programs."
    - name: "infection_control_notified_flag"
      expr: infection_control_notified_flag
      comment: "Flag indicating infection control was notified, important for outbreak prevention and surveillance."
    - name: "result_year"
      expr: YEAR(result_datetime)
      comment: "Year of culture result for year-over-year infection trend and surveillance analysis."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month of culture result for seasonal infection pattern and outbreak detection."
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures performed, fundamental volume metric for microbiology lab workload."
    - name: "positive_cultures"
      expr: COUNT(CASE WHEN growth_result = 'positive' THEN 1 END)
      comment: "Count of cultures with positive growth, key metric for infection detection rate and clinical utility."
    - name: "positive_culture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN growth_result = 'positive' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures yielding positive growth, diagnostic yield metric for test appropriateness and stewardship."
    - name: "mdro_detections"
      expr: COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END)
      comment: "Count of multidrug-resistant organisms detected, critical infection control and antibiotic stewardship metric."
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN growth_result = 'positive' THEN 1 END), 0), 2)
      comment: "Percentage of positive cultures that are MDROs, key antimicrobial resistance surveillance metric."
    - name: "hai_cases"
      expr: COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END)
      comment: "Count of healthcare-associated infections, critical quality and patient safety metric for regulatory reporting."
    - name: "hai_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures associated with HAI, key quality metric for infection prevention program effectiveness."
    - name: "public_health_reportable_cases"
      expr: COUNT(CASE WHEN public_health_reportable_flag = TRUE THEN 1 END)
      comment: "Count of reportable diseases detected, essential for public health surveillance and regulatory compliance."
    - name: "critical_value_cultures"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Count of cultures with critical findings, patient safety metric requiring immediate clinical notification."
    - name: "critical_values_notified"
      expr: COUNT(CASE WHEN critical_value_notified_datetime IS NOT NULL THEN 1 END)
      comment: "Count of critical microbiology findings with documented notification, patient safety and compliance metric."
    - name: "antibiotic_stewardship_cases"
      expr: COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END)
      comment: "Count of cases flagged for antibiotic stewardship review, key metric for antimicrobial optimization programs."
    - name: "infection_control_notifications"
      expr: COUNT(CASE WHEN infection_control_notified_flag = TRUE THEN 1 END)
      comment: "Count of cases with infection control notification, important for outbreak prevention and surveillance effectiveness."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours from collection to result, critical operational efficiency and patient care metric."
    - name: "avg_colony_count"
      expr: AVG(CAST(colony_count AS DOUBLE))
      comment: "Average colony count for quantitative cultures, useful for infection severity and contamination assessment."
    - name: "distinct_patients_cultured"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patient count with cultures performed, key for infection surveillance and utilization analysis."
$$;