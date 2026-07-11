-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core laboratory order metrics tracking order volume, turnaround time, cancellation rates, and operational efficiency across order types and priorities."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the lab order (STAT, routine, urgent) for segmenting by urgency"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the lab order (pending, completed, cancelled) for workflow analysis"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (blood, urine, tissue) for test mix analysis"
    - name: "order_date"
      expr: order_date
      comment: "Date the lab order was placed for time-series trending"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for monthly volume trending"
    - name: "is_send_out"
      expr: is_send_out
      comment: "Whether the test was sent to a reference lab for outsourcing analysis"
    - name: "is_point_of_care"
      expr: point_of_care_test
      comment: "Whether the test was performed at point of care for service model segmentation"
    - name: "fasting_required"
      expr: fasting_required
      comment: "Whether fasting was required for the test for patient preparation analysis"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether prior authorization was required for payer compliance tracking"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen for operational process analysis"
  measures:
    - name: "total_lab_orders"
      expr: COUNT(1)
      comment: "Total number of laboratory orders placed"
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled lab orders for quality and waste analysis"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders cancelled - key quality and efficiency metric"
    - name: "stat_orders"
      expr: SUM(CASE WHEN order_priority = 'STAT' THEN 1 ELSE 0 END)
      comment: "Count of STAT priority orders for urgent care capacity planning"
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_priority = 'STAT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders marked STAT - indicator of emergency demand and workflow pressure"
    - name: "send_out_orders"
      expr: SUM(CASE WHEN is_send_out = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tests sent to reference labs for outsourcing cost analysis"
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_send_out = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders sent to reference labs - key metric for test menu adequacy and cost control"
    - name: "point_of_care_orders"
      expr: SUM(CASE WHEN point_of_care_test = TRUE THEN 1 ELSE 0 END)
      comment: "Count of point-of-care tests for decentralized testing volume tracking"
    - name: "authorization_required_orders"
      expr: SUM(CASE WHEN authorization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders requiring prior authorization for payer compliance workload"
    - name: "unique_patients_tested"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with lab orders for patient reach analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result quality and turnaround metrics tracking critical values, amendments, result timeliness, and clinical decision support effectiveness."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (final, preliminary, corrected) for result lifecycle tracking"
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Whether the result is abnormal for clinical significance analysis"
    - name: "is_critical_value"
      expr: is_critical_value
      comment: "Whether the result is a critical value requiring immediate notification"
    - name: "is_amended"
      expr: is_amended
      comment: "Whether the result was amended after initial release for quality tracking"
    - name: "result_date"
      expr: DATE(result_datetime)
      comment: "Date the result was finalized for time-series analysis"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month of result finalization for monthly trending"
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result (normal, high, low) for decision support analysis"
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that performed the test (chemistry, hematology) for operational segmentation"
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results reported"
    - name: "critical_value_results"
      expr: SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical value results requiring urgent notification"
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are critical values - key patient safety and clinical urgency metric"
    - name: "abnormal_results"
      expr: SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of abnormal test results for clinical yield analysis"
    - name: "abnormal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are abnormal - indicator of test appropriateness and patient acuity"
    - name: "amended_results"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of results that were amended after initial release"
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results amended - key quality metric for result accuracy and process reliability"
    - name: "critical_values_notified_timely"
      expr: SUM(CASE WHEN is_critical_value = TRUE AND critical_value_notification_datetime IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of critical values with documented notification for patient safety compliance"
    - name: "critical_value_notification_compliance_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_value = TRUE AND critical_value_notification_datetime IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of critical values with documented notification - critical patient safety and regulatory compliance metric"
    - name: "unique_patients_with_results"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with test results for patient reach analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen collection and handling quality metrics tracking rejection rates, turnaround time, and pre-analytical quality for laboratory operations."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (blood, urine, tissue) for specimen mix analysis"
    - name: "accession_status"
      expr: accession_status
      comment: "Status of specimen accession (accepted, rejected, pending) for workflow tracking"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen for process standardization analysis"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for specimen rejection for root cause quality analysis"
    - name: "priority"
      expr: priority
      comment: "Priority level of the specimen (STAT, routine) for urgency segmentation"
    - name: "collection_date"
      expr: DATE(collection_datetime)
      comment: "Date the specimen was collected for time-series trending"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month of specimen collection for monthly volume analysis"
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting status of patient at collection for protocol compliance tracking"
    - name: "biohazard_level"
      expr: biohazard_level
      comment: "Biohazard classification of specimen for safety protocol analysis"
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens collected"
    - name: "rejected_specimens"
      expr: SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of specimens rejected for quality issues"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens rejected - critical pre-analytical quality metric impacting turnaround time and patient experience"
    - name: "stat_specimens"
      expr: SUM(CASE WHEN priority = 'STAT' THEN 1 ELSE 0 END)
      comment: "Count of STAT priority specimens for urgent care workload tracking"
    - name: "total_volume_collected_ml"
      expr: SUM(CAST(volume_collected_ml AS DOUBLE))
      comment: "Total volume of specimens collected in milliliters for capacity planning"
    - name: "avg_volume_per_specimen_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume collected per specimen for collection protocol optimization"
    - name: "unique_patients_with_specimens"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with specimens collected for patient reach analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood bank inventory and utilization metrics tracking unit status, wastage, transfusion rates, and blood product cost management."
  source: "`vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of blood unit (available, issued, expired, discarded) for inventory management"
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product (RBC, plasma, platelets) for product mix analysis"
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group (A, B, AB, O) for inventory distribution analysis"
    - name: "rh_type"
      expr: rh_type
      comment: "Rh factor (positive, negative) for inventory segmentation"
    - name: "discard_reason"
      expr: discard_reason
      comment: "Reason for unit discard (expired, contaminated) for waste root cause analysis"
    - name: "donation_month"
      expr: DATE_TRUNC('MONTH', donation_date)
      comment: "Month of blood donation for supply trending"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of unit expiration for inventory planning"
    - name: "irradiation_status"
      expr: irradiation_status
      comment: "Whether unit was irradiated for special processing tracking"
    - name: "leukoreduction_status"
      expr: leukoreduction_status
      comment: "Leukoreduction status for quality and processing analysis"
    - name: "crossmatch_required_flag"
      expr: crossmatch_required_flag
      comment: "Whether crossmatch is required for workflow complexity analysis"
  measures:
    - name: "total_blood_units"
      expr: COUNT(1)
      comment: "Total number of blood bank units in inventory"
    - name: "units_transfused"
      expr: SUM(CASE WHEN transfusion_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of units transfused to patients"
    - name: "units_discarded"
      expr: SUM(CASE WHEN discard_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of units discarded due to expiration or quality issues"
    - name: "discard_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discard_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blood units discarded - critical metric for inventory efficiency and cost control"
    - name: "utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transfusion_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units transfused - key metric for blood bank efficiency and supply chain optimization"
    - name: "total_volume_ml"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total volume of blood products in milliliters for capacity tracking"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood bank units for financial management"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges for blood bank units for revenue tracking"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per blood unit for cost benchmarking"
    - name: "units_with_temperature_alarms"
      expr: SUM(CASE WHEN temperature_alarm_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of units with temperature excursions for quality and safety monitoring"
    - name: "temperature_alarm_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_alarm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units with temperature alarms - critical patient safety and regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfusion safety and outcome metrics tracking transfusion reactions, consent compliance, and hemovigilance for patient safety and regulatory reporting."
  source: "`vibe_healthcare_v1`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Status of the transfusion event (completed, in progress, stopped) for workflow tracking"
    - name: "transfusion_reaction_occurred"
      expr: transfusion_reaction_occurred
      comment: "Whether a transfusion reaction occurred for safety analysis"
    - name: "transfusion_reaction_type"
      expr: transfusion_reaction_type
      comment: "Type of transfusion reaction (allergic, febrile, hemolytic) for clinical categorization"
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity of transfusion reaction (mild, moderate, severe) for risk stratification"
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Whether patient consent was obtained for regulatory compliance tracking"
    - name: "hemovigilance_reported"
      expr: hemovigilance_reported
      comment: "Whether event was reported to hemovigilance system for regulatory compliance"
    - name: "crossmatch_result"
      expr: crossmatch_result
      comment: "Result of crossmatch testing (compatible, incompatible) for safety protocol analysis"
    - name: "transfusion_date"
      expr: DATE(transfusion_start_datetime)
      comment: "Date of transfusion for time-series trending"
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Month of transfusion for monthly volume analysis"
  measures:
    - name: "total_transfusion_events"
      expr: COUNT(1)
      comment: "Total number of transfusion events performed"
    - name: "transfusions_with_reactions"
      expr: SUM(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transfusions resulting in adverse reactions"
    - name: "transfusion_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfusions with adverse reactions - critical patient safety and quality metric for hemovigilance"
    - name: "severe_reactions"
      expr: SUM(CASE WHEN reaction_severity = 'severe' THEN 1 ELSE 0 END)
      comment: "Count of severe transfusion reactions for high-risk event tracking"
    - name: "severe_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reaction_severity = 'severe' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfusions with severe reactions - critical patient safety metric requiring immediate investigation"
    - name: "transfusions_without_consent"
      expr: SUM(CASE WHEN consent_obtained = FALSE OR consent_obtained IS NULL THEN 1 ELSE 0 END)
      comment: "Count of transfusions without documented consent"
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfusions with documented consent - critical regulatory compliance and legal risk metric"
    - name: "hemovigilance_reporting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hemovigilance_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of reactions reported to hemovigilance - regulatory compliance metric for adverse event reporting"
    - name: "avg_transfusion_rate_ml_per_hour"
      expr: AVG(CAST(transfusion_rate AS DOUBLE))
      comment: "Average transfusion rate in ml per hour for clinical protocol adherence analysis"
    - name: "unique_patients_transfused"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients receiving transfusions for patient reach analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology culture and antimicrobial resistance metrics tracking organism identification, susceptibility patterns, and infection control for antibiotic stewardship and public health."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_status"
      expr: culture_status
      comment: "Status of culture (final, preliminary, in progress) for workflow tracking"
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed (aerobic, anaerobic, fungal) for test mix analysis"
    - name: "growth_result"
      expr: growth_result
      comment: "Result of culture growth (positive, negative, contaminated) for clinical yield analysis"
    - name: "mdro_flag"
      expr: mdro_flag
      comment: "Whether organism is multi-drug resistant for infection control and antibiotic stewardship"
    - name: "mdro_type"
      expr: mdro_type
      comment: "Type of multi-drug resistant organism (MRSA, VRE, CRE) for epidemiological tracking"
    - name: "public_health_reportable_flag"
      expr: public_health_reportable_flag
      comment: "Whether organism is reportable to public health for regulatory compliance"
    - name: "hai_associated_flag"
      expr: hai_associated_flag
      comment: "Whether culture is associated with healthcare-associated infection for quality tracking"
    - name: "infection_control_notified_flag"
      expr: infection_control_notified_flag
      comment: "Whether infection control was notified for outbreak prevention tracking"
    - name: "antibiotic_stewardship_flag"
      expr: antibiotic_stewardship_flag
      comment: "Whether case was flagged for antibiotic stewardship review for antimicrobial optimization"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month of culture result for epidemiological trending"
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures performed"
    - name: "positive_cultures"
      expr: SUM(CASE WHEN growth_result = 'positive' THEN 1 ELSE 0 END)
      comment: "Count of cultures with positive growth"
    - name: "culture_positivity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN growth_result = 'positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures with positive growth - key metric for test appropriateness and infection prevalence"
    - name: "mdro_cultures"
      expr: SUM(CASE WHEN mdro_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cultures identifying multi-drug resistant organisms"
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mdro_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN growth_result = 'positive' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of positive cultures with MDRO - critical antibiotic stewardship and infection control metric"
    - name: "hai_associated_cultures"
      expr: SUM(CASE WHEN hai_associated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cultures associated with healthcare-associated infections"
    - name: "hai_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hai_associated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures associated with HAI - critical quality and patient safety metric for infection prevention"
    - name: "public_health_reportable_cultures"
      expr: SUM(CASE WHEN public_health_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cultures requiring public health reporting for regulatory compliance"
    - name: "infection_control_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN infection_control_notified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN mdro_flag = TRUE OR hai_associated_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of high-risk cultures with infection control notification - compliance metric for outbreak prevention"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time from collection to result in hours for operational efficiency"
    - name: "unique_patients_with_cultures"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with microbiology cultures for infection prevalence analysis"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pathology reporting and cancer registry metrics tracking diagnostic accuracy, turnaround time, critical findings, and tumor board review for oncology quality and outcomes."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of pathology report (final, preliminary, amended) for workflow tracking"
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report (surgical, cytology, autopsy) for service mix analysis"
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Whether report contains critical findings requiring urgent notification"
    - name: "cancer_registry_reportable_flag"
      expr: cancer_registry_reportable_flag
      comment: "Whether case is reportable to cancer registry for regulatory compliance"
    - name: "tumor_board_reviewed_flag"
      expr: tumor_board_reviewed_flag
      comment: "Whether case was reviewed by tumor board for multidisciplinary care quality"
    - name: "histologic_type"
      expr: histologic_type
      comment: "Histologic type of tumor for oncology case mix analysis"
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Histologic grade of tumor for prognostic stratification"
    - name: "tnm_stage"
      expr: tnm_stage
      comment: "TNM staging of cancer for outcomes analysis and registry reporting"
    - name: "margin_status"
      expr: margin_status
      comment: "Surgical margin status (positive, negative) for surgical quality tracking"
    - name: "sign_out_month"
      expr: DATE_TRUNC('MONTH', sign_out_timestamp)
      comment: "Month of report sign-out for volume trending"
  measures:
    - name: "total_pathology_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports issued"
    - name: "critical_value_reports"
      expr: SUM(CASE WHEN critical_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports with critical findings"
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_value_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with critical findings - patient safety and clinical urgency metric"
    - name: "cancer_registry_reportable_cases"
      expr: SUM(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases reportable to cancer registry"
    - name: "tumor_board_reviewed_cases"
      expr: SUM(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases reviewed by tumor board"
    - name: "tumor_board_review_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of cancer cases reviewed by tumor board - quality metric for multidisciplinary oncology care"
    - name: "positive_margin_cases"
      expr: SUM(CASE WHEN margin_status = 'positive' THEN 1 ELSE 0 END)
      comment: "Count of cases with positive surgical margins"
    - name: "positive_margin_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN margin_status = 'positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with positive margins - critical surgical quality and oncology outcomes metric"
    - name: "avg_tumor_size_cm"
      expr: AVG(CAST(tumor_size_cm AS DOUBLE))
      comment: "Average tumor size in centimeters for prognostic analysis"
    - name: "unique_patients_with_pathology"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with pathology reports for patient reach analysis"
$$;