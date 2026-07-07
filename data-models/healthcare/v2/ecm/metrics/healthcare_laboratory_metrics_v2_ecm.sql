-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab order volume, turnaround, and fulfillment KPIs for operational steering of the laboratory service line."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (STAT, routine) for prioritization and TAT SLA analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current order lifecycle status for backlog and completion tracking."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Specimen type ordered, for volume mix analysis by sample category."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the order was placed, for trend analysis."
    - name: "is_send_out"
      expr: is_send_out
      comment: "Whether the order was sent to a reference lab (in-house vs send-out mix)."
    - name: "point_of_care_test"
      expr: point_of_care_test
      comment: "Whether the order is a point-of-care test."
  measures:
    - name: "Total Lab Orders"
      expr: COUNT(1)
      comment: "Total number of lab orders placed — baseline volume KPI for capacity planning."
    - name: "Distinct Patients Ordered"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients with lab orders — measures patient reach of lab services."
    - name: "Cancelled Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled — signals waste and workflow issues leadership acts on."
    - name: "Send Out Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders sent to reference labs — drives insourcing/cost decisions."
    - name: "STAT Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of STAT orders — indicates urgent workload demand and staffing needs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen processing quality and pre-analytic KPIs including rejection rates and volumes."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen for quality analysis by sample category."
    - name: "specimen_status"
      expr: specimen_status
      comment: "Lifecycle status of the specimen."
    - name: "priority"
      expr: priority
      comment: "Specimen processing priority."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of specimen collection for trending."
    - name: "condition_at_receipt"
      expr: condition_at_receipt
      comment: "Condition of specimen at receipt for pre-analytic quality review."
  measures:
    - name: "Total Specimens"
      expr: COUNT(1)
      comment: "Total specimens processed — baseline lab throughput volume."
    - name: "Specimen Rejection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of specimens rejected — key pre-analytic quality KPI that triggers process improvement."
    - name: "Avg Volume Collected ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average specimen volume collected — informs collection adequacy and redraw risk."
    - name: "Avg Transport Temperature C"
      expr: AVG(CAST(transport_temperature_c AS DOUBLE))
      comment: "Average transport temperature — monitors cold-chain integrity for specimen validity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test result quality and turnaround KPIs including critical values, abnormal rates and amendments."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Result lifecycle status (preliminary, final, corrected)."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that performed the test, for workload and quality by section."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month result was reported for trend analysis."
    - name: "test_name"
      expr: test_name
      comment: "Name of the test performed."
  measures:
    - name: "Total Test Results"
      expr: COUNT(1)
      comment: "Total test results reported — baseline analytic output volume."
    - name: "Critical Value Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results flagged critical — drives patient safety and notification workflow monitoring."
    - name: "Abnormal Result Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of abnormal results — informs population health and test utilization review."
    - name: "Amended Result Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results amended after release — quality indicator leadership investigates."
    - name: "Delta Check Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delta_check_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results triggering delta checks — signals result verification burden."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology culture KPIs for infection control including MDRO detection, HAI association and turnaround."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed."
    - name: "culture_status"
      expr: culture_status
      comment: "Culture lifecycle status."
    - name: "specimen_source_code"
      expr: specimen_source_code
      comment: "Specimen source for infection site analysis."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month culture resulted for infection trending."
  measures:
    - name: "Total Cultures"
      expr: COUNT(1)
      comment: "Total microbiology cultures performed — baseline micro workload."
    - name: "MDRO Detection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cultures positive for multidrug-resistant organisms — critical infection-control KPI."
    - name: "HAI Associated Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cultures associated with healthcare-acquired infections — drives infection prevention action."
    - name: "Avg Turnaround Time Hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average culture turnaround time — antibiotic stewardship and TAT SLA metric."
    - name: "Public Health Reportable Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN public_health_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cultures reportable to public health — compliance monitoring KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control run KPIs including QC pass rate and Westgard rule violations for analytic quality assurance."
  source: "`vibe_healthcare_v1`.`laboratory`.`qc_run`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC run."
    - name: "qc_level"
      expr: qc_level
      comment: "QC material level."
    - name: "qc_status"
      expr: qc_status
      comment: "QC run status."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month of QC run for trend analysis."
  measures:
    - name: "Total QC Runs"
      expr: COUNT(1)
      comment: "Total QC runs performed — baseline QA activity volume."
    - name: "QC Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of QC runs passing — core analytic quality KPI that triggers instrument review."
    - name: "Westgard Violation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN westgard_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of QC runs violating Westgard rules — flags systematic analytic error."
    - name: "Avg PT Z Score"
      expr: AVG(CAST(pt_z_score AS DOUBLE))
      comment: "Average proficiency-testing z-score — external quality assessment performance metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfusion safety KPIs including reaction rates and consent compliance for blood bank governance."
  source: "`vibe_healthcare_v1`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Blood product type transfused."
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Status of the transfusion event."
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity of any transfusion reaction."
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Month of transfusion for trend analysis."
  measures:
    - name: "Total Transfusions"
      expr: COUNT(1)
      comment: "Total transfusion events — baseline blood utilization volume."
    - name: "Transfusion Reaction Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reaction_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transfusions with a reaction — critical patient-safety KPI for hemovigilance."
    - name: "Consent Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transfusions with documented consent — regulatory compliance KPI."
    - name: "Total Volume Transfused ml"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total volume transfused — blood product utilization for supply planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory revenue and charge-capture KPIs for financial steering of lab services."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_charge`"
  dimensions:
    - name: "lab_charge_status"
      expr: lab_charge_status
      comment: "Charge lifecycle status (submitted, voided)."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that generated the charge for revenue by section."
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_created_timestamp)
      comment: "Month charge was created for revenue trending."
    - name: "reference_lab_indicator"
      expr: reference_lab_indicator
      comment: "Whether charge is for a reference lab test."
  measures:
    - name: "Total Charges"
      expr: COUNT(1)
      comment: "Total lab charges — baseline billing activity volume."
    - name: "Total STAT Surcharge Amount"
      expr: SUM(CAST(stat_surcharge_amount AS DOUBLE))
      comment: "Total STAT surcharge revenue — incremental revenue from urgent testing."
    - name: "Voided Charge Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of charges voided — revenue integrity KPI leadership monitors for leakage."
    - name: "Point Of Care Charge Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN point_of_care_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of charges from point-of-care testing — service mix insight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood inventory KPIs including wastage/discard rate and cost for supply chain management."
  source: "`vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product in inventory."
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group for inventory-mix analysis."
    - name: "blood_bank_unit_status"
      expr: blood_bank_unit_status
      comment: "Current status of the blood unit."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Expiration month for inventory expiry planning."
  measures:
    - name: "Total Blood Units"
      expr: COUNT(1)
      comment: "Total blood units in inventory — baseline supply volume."
    - name: "Unit Discard Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discard_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of units discarded — key wastage KPI driving inventory-management action."
    - name: "Total Cost Amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood inventory — financial exposure of blood supply."
    - name: "Temperature Alarm Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_alarm_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of units with temperature alarms — cold-chain integrity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_molecular_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular/genomic testing KPIs including variant detection and result completeness for precision-medicine service oversight."
  source: "`vibe_healthcare_v1`.`laboratory`.`molecular_test`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Molecular test result status."
    - name: "test_methodology"
      expr: test_methodology
      comment: "Testing methodology used."
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance classification of the variant."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month test resulted for trending."
  measures:
    - name: "Total Molecular Tests"
      expr: COUNT(1)
      comment: "Total molecular tests performed — baseline precision-medicine volume."
    - name: "Variant Detection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN detected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of molecular tests with a detected variant — yield KPI for test utilization review."
    - name: "Reportable Result Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results that are reportable — clinical actionability KPI."
    - name: "Amended Test Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of molecular tests amended — quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_susceptibility_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Antimicrobial susceptibility KPIs including resistance rate for antibiotic stewardship steering."
  source: "`vibe_healthcare_v1`.`laboratory`.`susceptibility_result`"
  dimensions:
    - name: "antibiotic_class"
      expr: antibiotic_class
      comment: "Antibiotic class tested for stewardship analysis."
    - name: "antibiotic_name"
      expr: antibiotic_name
      comment: "Specific antibiotic agent tested."
    - name: "susceptibility_interpretation"
      expr: susceptibility_interpretation
      comment: "Interpretation (S/I/R) of the susceptibility result."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month result reported for resistance trending."
  measures:
    - name: "Total Susceptibility Results"
      expr: COUNT(1)
      comment: "Total susceptibility results — baseline stewardship data volume."
    - name: "Resistance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resistance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results showing resistance — antibiogram KPI steering empiric therapy policy."
    - name: "Inducible Resistance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inducible_resistance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent showing inducible resistance — advanced resistance-monitoring KPI."
    - name: "Avg MIC Value"
      expr: AVG(CAST(mic_value AS DOUBLE))
      comment: "Average minimum inhibitory concentration — quantitative resistance trend indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab instrument fleet KPIs including downtime and operational availability for capital and maintenance decisions."
  source: "`vibe_healthcare_v1`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of laboratory instrument."
    - name: "lab_section"
      expr: lab_section
      comment: "Lab section where instrument is deployed."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer for vendor performance analysis."
  measures:
    - name: "Total Instruments"
      expr: COUNT(1)
      comment: "Total instruments in the fleet — baseline capital-asset count."
    - name: "Total Downtime Hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total instrument downtime — operational availability KPI driving maintenance investment."
    - name: "Avg Acquisition Cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average instrument acquisition cost — capital planning input."
    - name: "Non Operational Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status <> 'Operational' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of instruments not operational — fleet availability KPI leadership acts on."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_point_of_care_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-care testing KPIs including QC compliance and critical results for decentralized testing oversight."
  source: "`vibe_healthcare_v1`.`laboratory`.`point_of_care_test`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of point-of-care test."
    - name: "device_type"
      expr: device_type
      comment: "POC device type used."
    - name: "performing_location_name"
      expr: performing_location_name
      comment: "Location where POC test was performed."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_datetime)
      comment: "Month POC test performed for trending."
  measures:
    - name: "Total POC Tests"
      expr: COUNT(1)
      comment: "Total point-of-care tests — baseline decentralized testing volume."
    - name: "QC Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_passed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POC tests with passing QC — compliance KPI for CLIA-waived testing oversight."
    - name: "Critical Value Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POC tests with critical values — patient safety KPI."
    - name: "EHR Transmission Failure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ehr_transmission_status <> 'Success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POC results failing EHR transmission — interoperability KPI for result-integration monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_reagent_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent inventory KPIs including recall exposure, QC validation and cost for supply-chain management."
  source: "`vibe_healthcare_v1`.`laboratory`.`reagent_lot`"
  dimensions:
    - name: "reagent_type"
      expr: reagent_type
      comment: "Type of reagent."
    - name: "lot_status"
      expr: lot_status
      comment: "Reagent lot status."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Reagent manufacturer for vendor analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Expiration month for inventory expiry planning."
  measures:
    - name: "Total Reagent Lots"
      expr: COUNT(1)
      comment: "Total reagent lots tracked — baseline reagent inventory count."
    - name: "Recall Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lots under recall — supply-risk KPI driving remediation action."
    - name: "QC Validation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_validated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lots QC-validated before use — analytic quality compliance KPI."
    - name: "Total Reagent Value"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total reagent inventory value — cost control input for lab operations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anatomic pathology KPIs including critical findings, cancer reporting and amendments for diagnostic quality."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report."
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status."
    - name: "tumor_site"
      expr: tumor_site
      comment: "Anatomic tumor site for oncology analysis."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month case received for trending."
  measures:
    - name: "Total Pathology Reports"
      expr: COUNT(1)
      comment: "Total pathology reports — baseline anatomic pathology volume."
    - name: "Cancer Registry Reportable Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports reportable to cancer registry — regulatory compliance KPI."
    - name: "Amended Report Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amended_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of pathology reports amended — diagnostic quality KPI."
    - name: "Tumor Board Review Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases reviewed at tumor board — multidisciplinary care quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_clia_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CLIA certification compliance KPIs including sanctions, inspection outcomes and PT enrollment for regulatory risk oversight."
  source: "`vibe_healthcare_v1`.`laboratory`.`clia_certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of CLIA certificate."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Certificate status."
    - name: "testing_complexity_level"
      expr: testing_complexity_level
      comment: "Testing complexity level authorized."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Certificate expiration month for renewal planning."
  measures:
    - name: "Total Certificates"
      expr: COUNT(1)
      comment: "Total CLIA certificates tracked — baseline regulatory footprint."
    - name: "Sanctioned Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_imposed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of certificates with sanctions — critical regulatory-risk KPI for executive oversight."
    - name: "PT Enrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proficiency_testing_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent enrolled in proficiency testing — compliance readiness KPI."
    - name: "Total Annual Fees"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual CLIA fees — regulatory cost of doing lab business."
$$;