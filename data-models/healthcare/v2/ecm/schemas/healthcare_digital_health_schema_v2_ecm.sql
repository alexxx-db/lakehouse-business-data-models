-- Schema for Domain: digital_health | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`digital_health` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` (
    `rpm_device_reading_id` BIGINT COMMENT 'Unique identifier for the rpm device reading within the digital health rpm device reading record.',
    `rpm_device_id` BIGINT COMMENT 'Unique identifier for the device within the digital health rpm device reading record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health rpm device reading record.',
    `primary_rpm_alert_threshold_id` BIGINT COMMENT 'Unique identifier for the primary rpm alert threshold within the digital health rpm device reading record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the reviewed by clinician within the digital health rpm device reading record.',
    `rpm_alert_threshold_id` BIGINT COMMENT 'Unique identifier for the secondary rpm alert threshold within the digital health rpm device reading record.',
    `rpm_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm enrollment within the digital health rpm device reading record.',
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health rpm device reading record.',
    `abnormal_flag` BOOLEAN COMMENT 'The abnormal flag of the digital health rpm device reading record.',
    `alert_generated_flag` BOOLEAN COMMENT 'The alert generated flag of the digital health rpm device reading record.',
    `alert_triggered_flag` BOOLEAN COMMENT 'The alert triggered flag of the digital health rpm device reading record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health rpm device reading record.',
    `data_quality_flag` BOOLEAN COMMENT 'The data quality flag of the digital health rpm device reading record.',
    `data_source` STRING COMMENT 'The data source of the digital health rpm device reading record.',
    `device_manufacturer` STRING COMMENT 'The device manufacturer of the digital health rpm device reading record.',
    `device_model` STRING COMMENT 'The device model of the digital health rpm device reading record.',
    `device_serial_number` STRING COMMENT 'The device serial number of the digital health rpm device reading record.',
    `device_type` STRING COMMENT 'The device type value classifying the digital health rpm device reading record.',
    `diastolic_bp` STRING COMMENT 'The diastolic bp of the digital health rpm device reading record.',
    `diastolic_value` DECIMAL(18,2) COMMENT 'The diastolic value of the digital health rpm device reading record.',
    `glucose` DECIMAL(18,2) COMMENT 'The glucose of the digital health rpm device reading record.',
    `glucose_mg_dl` STRING COMMENT 'The glucose mg dl of the digital health rpm device reading record.',
    `glucose_value` DECIMAL(18,2) COMMENT 'The glucose value of the digital health rpm device reading record.',
    `heart_rate` STRING COMMENT 'The heart rate of the digital health rpm device reading record.',
    `heart_rate_bpm` STRING COMMENT 'The heart rate bpm of the digital health rpm device reading record.',
    `heart_rate_value` DECIMAL(18,2) COMMENT 'The heart rate value of the digital health rpm device reading record.',
    `is_abnormal_flag` BOOLEAN COMMENT 'Boolean flag indicating the is abnormal flag status of the digital health rpm device reading record.',
    `is_alert_triggered_flag` BOOLEAN COMMENT 'Boolean flag indicating the is alert triggered flag status of the digital health rpm device reading record.',
    `is_out_of_range_flag` BOOLEAN COMMENT 'Boolean flag indicating the is out of range flag status of the digital health rpm device reading record.',
    `loinc_code` STRING COMMENT 'The loinc code value classifying the digital health rpm device reading record.',
    `manual_entry_flag` BOOLEAN COMMENT 'The manual entry flag of the digital health rpm device reading record.',
    `measure_type` STRING COMMENT 'The measure type value classifying the digital health rpm device reading record.',
    `measure_value` DECIMAL(18,2) COMMENT 'The measure value of the digital health rpm device reading record.',
    `measurement_type` STRING COMMENT 'The measurement type value classifying the digital health rpm device reading record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the digital health rpm device reading record.',
    `measurement_value` DECIMAL(18,2) COMMENT 'The measurement value of the digital health rpm device reading record.',
    `metric_type` STRING COMMENT 'The metric type value classifying the digital health rpm device reading record.',
    `out_of_range_flag` BOOLEAN COMMENT 'The out of range flag of the digital health rpm device reading record.',
    `quality_flag` BOOLEAN COMMENT 'The quality flag of the digital health rpm device reading record.',
    `reading_timestamp` TIMESTAMP COMMENT 'The reading timestamp of the digital health rpm device reading record.',
    `reading_type` STRING COMMENT 'The reading type value classifying the digital health rpm device reading record.',
    `reading_unit` STRING COMMENT 'The reading unit of the digital health rpm device reading record.',
    `reading_value` DECIMAL(18,2) COMMENT 'The reading value of the digital health rpm device reading record.',
    `received_timestamp` TIMESTAMP COMMENT 'The received timestamp of the digital health rpm device reading record.',
    `respiratory_rate` STRING COMMENT 'The respiratory rate of the digital health rpm device reading record.',
    `reviewed_flag` BOOLEAN COMMENT 'The reviewed flag of the digital health rpm device reading record.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'The reviewed timestamp of the digital health rpm device reading record.',
    `spo2` STRING COMMENT 'The spo2 of the digital health rpm device reading record.',
    `spo2_percent` DECIMAL(18,2) COMMENT 'The spo2 percent of the digital health rpm device reading record.',
    `spo2_value` DECIMAL(18,2) COMMENT 'The spo2 value of the digital health rpm device reading record.',
    `systolic_bp` STRING COMMENT 'The systolic bp of the digital health rpm device reading record.',
    `systolic_value` DECIMAL(18,2) COMMENT 'The systolic value of the digital health rpm device reading record.',
    `temperature_c` DECIMAL(18,2) COMMENT 'The temperature c of the digital health rpm device reading record.',
    `temperature_value` DECIMAL(18,2) COMMENT 'The temperature value of the digital health rpm device reading record.',
    `threshold_breached_flag` BOOLEAN COMMENT 'The threshold breached flag of the digital health rpm device reading record.',
    `transmission_method` STRING COMMENT 'The transmission method of the digital health rpm device reading record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the digital health rpm device reading record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health rpm device reading record.',
    `weight` DECIMAL(18,2) COMMENT 'The weight of the digital health rpm device reading record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'The weight kg of the digital health rpm device reading record.',
    `weight_value` DECIMAL(18,2) COMMENT 'The weight value of the digital health rpm device reading record.',
    CONSTRAINT pk_rpm_device_reading PRIMARY KEY(`rpm_device_reading_id`)
) COMMENT 'Table digital_health.rpm_device_reading capturing rpm device reading records.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` (
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health rpm program enrollment record.',
    `care_program_id` BIGINT COMMENT 'Unique identifier for the care program within the digital health rpm program enrollment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the digital health rpm program enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health rpm program enrollment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the rpm clinician within the digital health rpm program enrollment record.',
    `rpm_enrolling_clinician_id` BIGINT COMMENT 'Unique identifier for the rpm enrolling clinician within the digital health rpm program enrollment record.',
    `rpm_ordering_clinician_id` BIGINT COMMENT 'ordering clinician id',
    `adherence_rate` DECIMAL(18,2) COMMENT 'The adherence rate of the digital health rpm program enrollment record.',
    `alert_notification_method` STRING COMMENT 'The alert notification method of the digital health rpm program enrollment record.',
    `billing_code` STRING COMMENT 'The billing code value classifying the digital health rpm program enrollment record.',
    `billing_cpt_code` STRING COMMENT 'The billing cpt code value classifying the digital health rpm program enrollment record.',
    `billing_eligible_flag` BOOLEAN COMMENT 'The billing eligible flag of the digital health rpm program enrollment record.',
    `condition_monitored` STRING COMMENT 'The condition monitored of the digital health rpm program enrollment record.',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the digital health rpm program enrollment record.',
    `consent_obtained_flag` BOOLEAN COMMENT 'The consent obtained flag of the digital health rpm program enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health rpm program enrollment record.',
    `device_count` STRING COMMENT 'The device count of the digital health rpm program enrollment record.',
    `device_shipped_date` DATE COMMENT 'Timestamp capturing the device shipped date associated with the digital health rpm program enrollment record.',
    `device_shipped_flag` BOOLEAN COMMENT 'The device shipped flag of the digital health rpm program enrollment record.',
    `device_type` STRING COMMENT 'The device type value classifying the digital health rpm program enrollment record.',
    `device_type_assigned` STRING COMMENT 'The device type assigned of the digital health rpm program enrollment record.',
    `diastolic_high_threshold` STRING COMMENT 'The diastolic high threshold of the digital health rpm program enrollment record.',
    `disenrollment_date` DATE COMMENT 'Timestamp capturing the disenrollment date associated with the digital health rpm program enrollment record.',
    `disenrollment_reason` STRING COMMENT 'The disenrollment reason of the digital health rpm program enrollment record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the digital health rpm program enrollment record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the digital health rpm program enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the digital health rpm program enrollment record.',
    `glucose_high_threshold` DECIMAL(18,2) COMMENT 'The glucose high threshold of the digital health rpm program enrollment record.',
    `glucose_low_threshold` DECIMAL(18,2) COMMENT 'The glucose low threshold of the digital health rpm program enrollment record.',
    `hr_high_threshold` STRING COMMENT 'The hr high threshold of the digital health rpm program enrollment record.',
    `hr_low_threshold` STRING COMMENT 'The hr low threshold of the digital health rpm program enrollment record.',
    `last_reading_date` DATE COMMENT 'Timestamp capturing the last reading date associated with the digital health rpm program enrollment record.',
    `monitored_condition` STRING COMMENT 'The monitored condition of the digital health rpm program enrollment record.',
    `monitored_conditions` STRING COMMENT 'The monitored conditions of the digital health rpm program enrollment record.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency of the digital health rpm program enrollment record.',
    `monthly_reading_days_count` STRING COMMENT 'The monthly reading days count of the digital health rpm program enrollment record.',
    `monthly_reimbursement_amount` DECIMAL(18,2) COMMENT 'The monthly reimbursement amount of the digital health rpm program enrollment record.',
    `program_type` STRING COMMENT 'The program type value classifying the digital health rpm program enrollment record.',
    `reading_frequency` STRING COMMENT 'The reading frequency of the digital health rpm program enrollment record.',
    `reading_frequency_required` STRING COMMENT 'The reading frequency required of the digital health rpm program enrollment record.',
    `reimbursement_eligible_flag` BOOLEAN COMMENT 'The reimbursement eligible flag of the digital health rpm program enrollment record.',
    `spo2_low_threshold` DECIMAL(18,2) COMMENT 'The spo2 low threshold of the digital health rpm program enrollment record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the digital health rpm program enrollment record.',
    `systolic_high_threshold` STRING COMMENT 'The systolic high threshold of the digital health rpm program enrollment record.',
    `total_readings_count` STRING COMMENT 'The total readings count of the digital health rpm program enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health rpm program enrollment record.',
    `weight_change_threshold_kg` DECIMAL(18,2) COMMENT 'The weight change threshold kg of the digital health rpm program enrollment record.',
    CONSTRAINT pk_rpm_program_enrollment PRIMARY KEY(`rpm_program_enrollment_id`)
) COMMENT 'Records for rpm program enrollment in the digital health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` (
    `rpm_alert_threshold_id` BIGINT COMMENT 'Unique identifier for the rpm alert threshold within the digital health rpm alert threshold record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health rpm alert threshold record.',
    `rpm_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm enrollment within the digital health rpm alert threshold record.',
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health rpm alert threshold record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the set by clinician within the digital health rpm alert threshold record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the digital health rpm alert threshold record.',
    `alert_action` STRING COMMENT 'The alert action of the digital health rpm alert threshold record.',
    `alert_recipient_role` STRING COMMENT 'The alert recipient role of the digital health rpm alert threshold record.',
    `alert_severity` STRING COMMENT 'The alert severity of the digital health rpm alert threshold record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health rpm alert threshold record.',
    `critical_max_value` DECIMAL(18,2) COMMENT 'The critical max value of the digital health rpm alert threshold record.',
    `critical_min_value` DECIMAL(18,2) COMMENT 'The critical min value of the digital health rpm alert threshold record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the digital health rpm alert threshold record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the digital health rpm alert threshold record.',
    `escalation_rule` STRING COMMENT 'The escalation rule of the digital health rpm alert threshold record.',
    `high_critical_value` DECIMAL(18,2) COMMENT 'The high critical value of the digital health rpm alert threshold record.',
    `high_warning_value` DECIMAL(18,2) COMMENT 'The high warning value of the digital health rpm alert threshold record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the digital health rpm alert threshold record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the digital health rpm alert threshold record.',
    `low_critical_value` DECIMAL(18,2) COMMENT 'The low critical value of the digital health rpm alert threshold record.',
    `low_warning_value` DECIMAL(18,2) COMMENT 'The low warning value of the digital health rpm alert threshold record.',
    `max_threshold_value` DECIMAL(18,2) COMMENT 'The max threshold value of the digital health rpm alert threshold record.',
    `measure_type` STRING COMMENT 'The measure type value classifying the digital health rpm alert threshold record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the digital health rpm alert threshold record.',
    `metric_type` STRING COMMENT 'The metric type value classifying the digital health rpm alert threshold record.',
    `min_threshold_value` DECIMAL(18,2) COMMENT 'The min threshold value of the digital health rpm alert threshold record.',
    `notification_channel` STRING COMMENT 'The notification channel of the digital health rpm alert threshold record.',
    `notification_method` STRING COMMENT 'The notification method of the digital health rpm alert threshold record.',
    `notification_recipient_role` STRING COMMENT 'The notification recipient role of the digital health rpm alert threshold record.',
    `reading_type` STRING COMMENT 'The reading type value classifying the digital health rpm alert threshold record.',
    `threshold_name` STRING COMMENT 'The threshold name of the digital health rpm alert threshold record.',
    `threshold_source` STRING COMMENT 'The threshold source of the digital health rpm alert threshold record.',
    `threshold_type` STRING COMMENT 'The threshold type value classifying the digital health rpm alert threshold record.',
    `threshold_unit` STRING COMMENT 'The threshold unit of the digital health rpm alert threshold record.',
    `threshold_value_max` DECIMAL(18,2) COMMENT 'The threshold value max of the digital health rpm alert threshold record.',
    `threshold_value_min` DECIMAL(18,2) COMMENT 'The threshold value min of the digital health rpm alert threshold record.',
    `unit` STRING COMMENT 'The unit of the digital health rpm alert threshold record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health rpm alert threshold record.',
    CONSTRAINT pk_rpm_alert_threshold PRIMARY KEY(`rpm_alert_threshold_id`)
) COMMENT 'Stores rpm alert threshold records for the digital health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` (
    `prom_response_id` BIGINT COMMENT 'Unique identifier for the prom response within the digital health prom response record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health prom response record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the prom clinician within the digital health prom response record.',
    `prom_instrument_id` BIGINT COMMENT 'Unique identifier for the prom instrument within the digital health prom response record.',
    `prom_ordering_clinician_id` BIGINT COMMENT 'Unique identifier for the prom ordering clinician within the digital health prom response record.',
    `prom_question_id` BIGINT COMMENT 'Unique identifier for the question within the digital health prom response record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the digital health prom response record.',
    `administered_date` DATE COMMENT 'Timestamp capturing the administered date associated with the digital health prom response record.',
    `administered_timestamp` TIMESTAMP COMMENT 'The administered timestamp of the digital health prom response record.',
    `administration_date` DATE COMMENT 'Timestamp capturing the administration date associated with the digital health prom response record.',
    `administration_method` STRING COMMENT 'The administration method of the digital health prom response record.',
    `administration_mode` STRING COMMENT 'The administration mode of the digital health prom response record.',
    `baseline_flag` BOOLEAN COMMENT 'The baseline flag of the digital health prom response record.',
    `collection_method` STRING COMMENT 'The collection method of the digital health prom response record.',
    `collection_timestamp` TIMESTAMP COMMENT 'The collection timestamp of the digital health prom response record.',
    `completed_flag` BOOLEAN COMMENT 'The completed flag of the digital health prom response record.',
    `completion_status` STRING COMMENT 'The completion status value classifying the digital health prom response record.',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp of the digital health prom response record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health prom response record.',
    `follow_up_number` STRING COMMENT 'The follow up number of the digital health prom response record.',
    `instrument_code` STRING COMMENT 'The instrument code value classifying the digital health prom response record.',
    `instrument_name` STRING COMMENT 'The instrument name of the digital health prom response record.',
    `instrument_version` STRING COMMENT 'The instrument version of the digital health prom response record.',
    `is_complete_flag` BOOLEAN COMMENT 'Boolean flag indicating the is complete flag status of the digital health prom response record.',
    `loinc_code` STRING COMMENT 'The loinc code value classifying the digital health prom response record.',
    `numeric_score` DECIMAL(18,2) COMMENT 'The numeric score of the digital health prom response record.',
    `percentile_rank` DECIMAL(18,2) COMMENT 'The percentile rank of the digital health prom response record.',
    `question_text` STRING COMMENT 'The question text of the digital health prom response record.',
    `raw_score` DECIMAL(18,2) COMMENT 'The raw score of the digital health prom response record.',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the digital health prom response record.',
    `response_numeric_score` DECIMAL(18,2) COMMENT 'The response numeric score of the digital health prom response record.',
    `response_numeric_value` DECIMAL(18,2) COMMENT 'The response numeric value of the digital health prom response record.',
    `response_payload` STRING COMMENT 'The response payload of the digital health prom response record.',
    `response_score` STRING COMMENT 'The response score of the digital health prom response record.',
    `response_status` STRING COMMENT 'The response status value classifying the digital health prom response record.',
    `response_timestamp` TIMESTAMP COMMENT 'The response timestamp of the digital health prom response record.',
    `response_value` DECIMAL(18,2) COMMENT 'The response value of the digital health prom response record.',
    `score_interpretation` STRING COMMENT 'The score interpretation of the digital health prom response record.',
    `severity_category` STRING COMMENT 'The severity category of the digital health prom response record.',
    `survey_name` STRING COMMENT 'The survey name of the digital health prom response record.',
    `survey_version` STRING COMMENT 'The survey version of the digital health prom response record.',
    `t_score` DECIMAL(18,2) COMMENT 'The t score of the digital health prom response record.',
    `total_score` STRING COMMENT 'The total score of the digital health prom response record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health prom response record.',
    CONSTRAINT pk_prom_response PRIMARY KEY(`prom_response_id`)
) COMMENT 'Data product capturing prom response records within the digital health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` (
    `portal_engagement_event_id` BIGINT COMMENT 'Unique identifier for the portal engagement event within the digital health portal engagement event record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health portal engagement event record.',
    `portal_account_id` BIGINT COMMENT 'Unique identifier for the portal account within the digital health portal engagement event record.',
    `portal_session_id` BIGINT COMMENT 'Unique identifier for the session within the digital health portal engagement event record.',
    `appointment_action_flag` BOOLEAN COMMENT 'The appointment action flag of the digital health portal engagement event record.',
    `appointment_booked_flag` BOOLEAN COMMENT 'The appointment booked flag of the digital health portal engagement event record.',
    `appointment_scheduled_flag` BOOLEAN COMMENT 'The appointment scheduled flag of the digital health portal engagement event record.',
    `bill_paid_flag` BOOLEAN COMMENT 'The bill paid flag of the digital health portal engagement event record.',
    `bill_pay_action_flag` BOOLEAN COMMENT 'The bill pay action flag of the digital health portal engagement event record.',
    `browser_type` STRING COMMENT 'The browser type value classifying the digital health portal engagement event record.',
    `channel` STRING COMMENT 'The channel of the digital health portal engagement event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health portal engagement event record.',
    `device_platform` STRING COMMENT 'The device platform of the digital health portal engagement event record.',
    `device_type` STRING COMMENT 'The device type value classifying the digital health portal engagement event record.',
    `duration_seconds` STRING COMMENT 'The duration seconds of the digital health portal engagement event record.',
    `engagement_score` DECIMAL(18,2) COMMENT 'The engagement score of the digital health portal engagement event record.',
    `event_category` STRING COMMENT 'The event category of the digital health portal engagement event record.',
    `event_description` STRING COMMENT 'The event description of the digital health portal engagement event record.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the digital health portal engagement event record.',
    `event_type` STRING COMMENT 'The event type value classifying the digital health portal engagement event record.',
    `feature_accessed` STRING COMMENT 'The feature accessed of the digital health portal engagement event record.',
    `ip_address` STRING COMMENT 'The ip address of the digital health portal engagement event record.',
    `ip_address_masked` STRING COMMENT 'The ip address masked of the digital health portal engagement event record.',
    `login_flag` BOOLEAN COMMENT 'The login flag of the digital health portal engagement event record.',
    `message_read_flag` BOOLEAN COMMENT 'The message read flag of the digital health portal engagement event record.',
    `message_sent_flag` BOOLEAN COMMENT 'The message sent flag of the digital health portal engagement event record.',
    `page_viewed` STRING COMMENT 'The page viewed of the digital health portal engagement event record.',
    `result_viewed_flag` BOOLEAN COMMENT 'The result viewed flag of the digital health portal engagement event record.',
    `session_duration_seconds` STRING COMMENT 'The session duration seconds of the digital health portal engagement event record.',
    `test_result_viewed_flag` BOOLEAN COMMENT 'The test result viewed flag of the digital health portal engagement event record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health portal engagement event record.',
    `user_agent` STRING COMMENT 'The user agent of the digital health portal engagement event record.',
    CONSTRAINT pk_portal_engagement_event PRIMARY KEY(`portal_engagement_event_id`)
) COMMENT 'Records for portal engagement event in the digital health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` (
    `device_reading_id` BIGINT COMMENT 'Unique identifier for the device reading within the digital health device reading record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the digital health device reading record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health device reading record.',
    `rpm_device_id` BIGINT COMMENT 'Unique identifier for the rpm device within the digital health device reading record.',
    `rpm_device_reading_id` BIGINT COMMENT 'Unique identifier for the rpm device reading within the digital health device reading record.',
    `rpm_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm enrollment within the digital health device reading record.',
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health device reading record.',
    `abnormal_flag` BOOLEAN COMMENT 'The abnormal flag of the digital health device reading record.',
    `alert_triggered_flag` BOOLEAN COMMENT 'The alert triggered flag of the digital health device reading record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health device reading record.',
    `data_source` STRING COMMENT 'The data source of the digital health device reading record.',
    `device_id` BIGINT COMMENT 'Unique identifier for the device within the digital health device reading record.',
    `device_type` STRING COMMENT 'The device type value classifying the digital health device reading record.',
    `diastolic_value` DECIMAL(18,2) COMMENT 'The diastolic value of the digital health device reading record.',
    `glucose_mg_dl` DECIMAL(18,2) COMMENT 'The glucose mg dl of the digital health device reading record.',
    `glucose_value` DECIMAL(18,2) COMMENT 'The glucose value of the digital health device reading record.',
    `heart_rate` DECIMAL(18,2) COMMENT 'The heart rate of the digital health device reading record.',
    `heart_rate_bpm` STRING COMMENT 'The heart rate bpm of the digital health device reading record.',
    `is_abnormal_flag` BOOLEAN COMMENT 'Boolean flag indicating the is abnormal flag status of the digital health device reading record.',
    `manual_entry_flag` BOOLEAN COMMENT 'The manual entry flag of the digital health device reading record.',
    `measure_type` STRING COMMENT 'The measure type value classifying the digital health device reading record.',
    `measure_value` DECIMAL(18,2) COMMENT 'The measure value of the digital health device reading record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the digital health device reading record.',
    `measurement_value` DECIMAL(18,2) COMMENT 'The measurement value of the digital health device reading record.',
    `metric_type` STRING COMMENT 'The metric type value classifying the digital health device reading record.',
    `numeric_value` DECIMAL(18,2) COMMENT 'The numeric value of the digital health device reading record.',
    `out_of_range_flag` BOOLEAN COMMENT 'The out of range flag of the digital health device reading record.',
    `reading_timestamp` TIMESTAMP COMMENT 'The reading timestamp of the digital health device reading record.',
    `reading_type` STRING COMMENT 'The reading type value classifying the digital health device reading record.',
    `reading_unit` STRING COMMENT 'The reading unit of the digital health device reading record.',
    `reading_value` DECIMAL(18,2) COMMENT 'The reading value of the digital health device reading record.',
    `received_timestamp` TIMESTAMP COMMENT 'The received timestamp of the digital health device reading record.',
    `spo2_pct` DECIMAL(18,2) COMMENT 'The spo2 pct of the digital health device reading record.',
    `spo2_value` DECIMAL(18,2) COMMENT 'The spo2 value of the digital health device reading record.',
    `systolic_value` DECIMAL(18,2) COMMENT 'The systolic value of the digital health device reading record.',
    `threshold_breach_flag` BOOLEAN COMMENT 'The threshold breach flag of the digital health device reading record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the digital health device reading record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health device reading record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'The weight kg of the digital health device reading record.',
    `weight_value` DECIMAL(18,2) COMMENT 'The weight value of the digital health device reading record.',
    CONSTRAINT pk_device_reading PRIMARY KEY(`device_reading_id`)
) COMMENT 'heart rate, glucose, SpO2, weight sensor readings';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` (
    `rpm_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm enrollment within the digital health rpm enrollment record.',
    `care_program_id` BIGINT COMMENT 'Unique identifier for the care program within the digital health rpm enrollment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the digital health rpm enrollment record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health rpm enrollment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the rpm clinician within the digital health rpm enrollment record.',
    `rpm_device_id` BIGINT COMMENT 'Unique identifier for the rpm device within the digital health rpm enrollment record.',
    `rpm_enrolling_clinician_id` BIGINT COMMENT 'Unique identifier for the rpm enrolling clinician within the digital health rpm enrollment record.',
    `rpm_ordering_clinician_id` BIGINT COMMENT 'ordering clinician id',
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health rpm enrollment record.',
    `adherence_rate` DECIMAL(18,2) COMMENT 'The adherence rate of the digital health rpm enrollment record.',
    `billing_code` STRING COMMENT 'The billing code value classifying the digital health rpm enrollment record.',
    `billing_eligible_flag` BOOLEAN COMMENT 'The billing eligible flag of the digital health rpm enrollment record.',
    `billing_program_code` STRING COMMENT 'The billing program code value classifying the digital health rpm enrollment record.',
    `consent_date` DATE COMMENT 'Timestamp capturing the consent date associated with the digital health rpm enrollment record.',
    `consent_obtained_flag` BOOLEAN COMMENT 'The consent obtained flag of the digital health rpm enrollment record.',
    `cpt_billing_code` STRING COMMENT 'The cpt billing code value classifying the digital health rpm enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health rpm enrollment record.',
    `device_count` STRING COMMENT 'The device count of the digital health rpm enrollment record.',
    `disenrollment_date` DATE COMMENT 'Timestamp capturing the disenrollment date associated with the digital health rpm enrollment record.',
    `disenrollment_reason` STRING COMMENT 'The disenrollment reason of the digital health rpm enrollment record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the digital health rpm enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the digital health rpm enrollment record.',
    `last_reading_timestamp` TIMESTAMP COMMENT 'The last reading timestamp of the digital health rpm enrollment record.',
    `monitored_condition` STRING COMMENT 'The monitored condition of the digital health rpm enrollment record.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency of the digital health rpm enrollment record.',
    `program_name` STRING COMMENT 'The program name of the digital health rpm enrollment record.',
    `program_type` STRING COMMENT 'The program type value classifying the digital health rpm enrollment record.',
    `reimbursement_eligible_flag` BOOLEAN COMMENT 'The reimbursement eligible flag of the digital health rpm enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health rpm enrollment record.',
    CONSTRAINT pk_rpm_enrollment PRIMARY KEY(`rpm_enrollment_id`)
) COMMENT 'RPM program enrollment and alert thresholds';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` (
    `rpm_device_id` BIGINT COMMENT 'Unique identifier for the rpm device within the digital health rpm device record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the digital health rpm device record.',
    `battery_level_pct` DECIMAL(18,2) COMMENT 'The battery level pct of the digital health rpm device record.',
    `connectivity_type` STRING COMMENT 'The connectivity type value classifying the digital health rpm device record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health rpm device record.',
    `device_serial_number` STRING COMMENT 'The device serial number of the digital health rpm device record.',
    `device_status` STRING COMMENT 'The device status value classifying the digital health rpm device record.',
    `device_type` STRING COMMENT 'The device type value classifying the digital health rpm device record.',
    `firmware_version` STRING COMMENT 'The firmware version of the digital health rpm device record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the digital health rpm device record.',
    `issued_date` DATE COMMENT 'Timestamp capturing the issued date associated with the digital health rpm device record.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The last sync timestamp of the digital health rpm device record.',
    `manufacturer` STRING COMMENT 'The manufacturer of the digital health rpm device record.',
    `model_number` STRING COMMENT 'The model number of the digital health rpm device record.',
    `returned_date` DATE COMMENT 'Timestamp capturing the returned date associated with the digital health rpm device record.',
    `udi_code` STRING COMMENT 'The udi code value classifying the digital health rpm device record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health rpm device record.',
    CONSTRAINT pk_rpm_device PRIMARY KEY(`rpm_device_id`)
) COMMENT 'RPM device registered to a patient for remote monitoring.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`alert_threshold` (
    `alert_threshold_id` BIGINT COMMENT 'Unique identifier for the alert threshold within the digital health alert threshold record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the digital health alert threshold record.',
    `rpm_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm enrollment within the digital health alert threshold record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health alert threshold record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the digital health alert threshold record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the digital health alert threshold record.',
    `escalation_rule` STRING COMMENT 'The escalation rule of the digital health alert threshold record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the digital health alert threshold record.',
    `lower_critical_value` DECIMAL(18,2) COMMENT 'The lower critical value of the digital health alert threshold record.',
    `lower_warning_value` DECIMAL(18,2) COMMENT 'The lower warning value of the digital health alert threshold record.',
    `notify_clinician_flag` BOOLEAN COMMENT 'The notify clinician flag of the digital health alert threshold record.',
    `reading_type` STRING COMMENT 'The reading type value classifying the digital health alert threshold record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the digital health alert threshold record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health alert threshold record.',
    `upper_critical_value` DECIMAL(18,2) COMMENT 'The upper critical value of the digital health alert threshold record.',
    `upper_warning_value` DECIMAL(18,2) COMMENT 'The upper warning value of the digital health alert threshold record.',
    CONSTRAINT pk_alert_threshold PRIMARY KEY(`alert_threshold_id`)
) COMMENT 'RPM alert threshold defining escalation bounds for a monitored reading type.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` (
    `prom_instrument_id` BIGINT COMMENT 'Unique identifier for the prom instrument within the digital health prom instrument record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health prom instrument record.',
    `domain_measured` STRING COMMENT 'The domain measured of the digital health prom instrument record.',
    `instrument_code` STRING COMMENT 'The instrument code value classifying the digital health prom instrument record.',
    `instrument_name` STRING COMMENT 'The instrument name of the digital health prom instrument record.',
    `instrument_version` STRING COMMENT 'The instrument version of the digital health prom instrument record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the digital health prom instrument record.',
    `loinc_panel_code` STRING COMMENT 'The loinc panel code value classifying the digital health prom instrument record.',
    `max_score` DECIMAL(18,2) COMMENT 'The max score of the digital health prom instrument record.',
    `min_score` DECIMAL(18,2) COMMENT 'The min score of the digital health prom instrument record.',
    `scoring_method` STRING COMMENT 'The scoring method of the digital health prom instrument record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health prom instrument record.',
    CONSTRAINT pk_prom_instrument PRIMARY KEY(`prom_instrument_id`)
) COMMENT 'Patient-reported outcome measure instrument definition (e.g. PROMIS, PHQ-9).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`device_alert_threshold` (
    `device_alert_threshold_id` BIGINT COMMENT 'Unique identifier for the device alert threshold within the digital health device alert threshold record.',
    `rpm_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the rpm program enrollment within the digital health device alert threshold record.',
    `alert_recipient_role` STRING COMMENT 'The alert recipient role of the digital health device alert threshold record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital health device alert threshold record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the digital health device alert threshold record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the digital health device alert threshold record.',
    `high_critical_value` DECIMAL(18,2) COMMENT 'The high critical value of the digital health device alert threshold record.',
    `high_warning_value` DECIMAL(18,2) COMMENT 'The high warning value of the digital health device alert threshold record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the digital health device alert threshold record.',
    `low_critical_value` DECIMAL(18,2) COMMENT 'The low critical value of the digital health device alert threshold record.',
    `low_warning_value` DECIMAL(18,2) COMMENT 'The low warning value of the digital health device alert threshold record.',
    `measure_type` STRING COMMENT 'The measure type value classifying the digital health device alert threshold record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the digital health device alert threshold record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital health device alert threshold record.',
    CONSTRAINT pk_device_alert_threshold PRIMARY KEY(`device_alert_threshold_id`)
) COMMENT 'Alert thresholds for RPM device readings.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` (
    `prom_question_id` BIGINT COMMENT 'Primary key for prom_question',
    `prom_instrument_id` BIGINT COMMENT 'Foreign key linking to digital_health.prom_instrument. Business justification: A prom_question is a master reference item belonging to exactly ONE PROM instrument (e.g. a PHQ-9 question belongs to the PHQ-9 instrument). prom_instrument (PROMIS, PHQ-9 definitions) is the parent; ',
    `parent_prom_question_id` BIGINT COMMENT 'Self-referencing FK on prom_question (parent_prom_question_id)',
    `answer_option_set` STRING COMMENT 'Reference name or identifier of the value set / answer option list used to constrain valid responses to this question.',
    `clinical_domain` STRING COMMENT 'Health domain or construct the question assesses (e.g., depression, physical function, pain, anxiety, quality of life). [ENUM-REF-CANDIDATE: depression|anxiety|physical_function|pain|fatigue|quality_of_life|social_function — promote to reference product]',
    `conditional_display_logic` STRING COMMENT 'Skip-logic / branching expression that determines whether this question is shown based on prior responses.',
    `copyright_holder` STRING COMMENT 'Organization or author holding copyright/licensing rights over the question and instrument content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this question reference record was first captured in the master table.',
    `display_sequence` STRING COMMENT 'Ordinal position of the question within the instrument presentation order.',
    `effective_from_date` DATE COMMENT 'Date from which this question version becomes valid for administration.',
    `effective_to_date` DATE COMMENT 'Date after which this question version is no longer valid for administration (nullable for open-ended).',
    `help_text` STRING COMMENT 'Optional supplementary guidance or clarification shown to the patient to aid comprehension of the question.',
    `is_required` BOOLEAN COMMENT 'Indicates whether a patient must answer this question for the survey to be considered complete.',
    `is_reverse_scored` BOOLEAN COMMENT 'Indicates whether the question response is reverse-scored when computing the domain or scale score.',
    `language_code` STRING COMMENT 'ISO 639 language code identifying the language of this question rendering for multilingual survey delivery.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this question reference record was last modified.',
    `license_type` STRING COMMENT 'Licensing classification governing permitted use of the question content.',
    `loinc_code` STRING COMMENT 'LOINC code that standardizes the question/observation for interoperability and reporting.',
    `max_score` STRING COMMENT 'Maximum numeric score achievable for this question, used for scoring and normalization.',
    `min_score` STRING COMMENT 'Minimum numeric score achievable for this question, used for scoring and normalization.',
    `question_code` STRING COMMENT 'Externally-known unique short code identifying the question within its instrument (e.g., PHQ9_Q1, PROMIS_PF_03). Used as the operational business key.',
    `question_status` STRING COMMENT 'Current lifecycle state of the question definition in the reference master.',
    `question_text` STRING COMMENT 'The full human-readable text of the question as presented to the patient.',
    `question_type` STRING COMMENT 'Structural type of the question determining how the patient response is captured and validated.',
    `recall_period` STRING COMMENT 'Time window the patient is asked to consider when answering (e.g., past 7 days), affecting response interpretation.',
    `response_format` STRING COMMENT 'Format of the expected patient response (e.g., Likert scale, Numeric Rating Scale, Visual Analog Scale).',
    `scoring_weight` DECIMAL(18,2) COMMENT 'Relative weight applied to this question when aggregating into the instrument-level scale score.',
    `short_label` STRING COMMENT 'Abbreviated display label used in dashboards, charts, and compact survey UIs.',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept code associated with the clinical concept the question measures, where applicable.',
    `unit_of_measure` STRING COMMENT 'Unit associated with numeric responses to the question, where applicable (e.g., days, count, points).',
    CONSTRAINT pk_prom_question PRIMARY KEY(`prom_question_id`)
) COMMENT 'Master reference table for prom_question. Referenced by question_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` (
    `portal_session_id` BIGINT COMMENT 'Primary key for portal_session',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose portal account is associated with this session.',
    `portal_account_id` BIGINT COMMENT 'Identifier of the portal user account that authenticated this session.',
    `parent_portal_session_id` BIGINT COMMENT 'Self-referencing FK on portal_session (parent_portal_session_id)',
    `access_channel` STRING COMMENT 'The interface/channel through which the portal session was initiated.',
    `authentication_method` STRING COMMENT 'The authentication mechanism used to establish this session.',
    `browser_name` STRING COMMENT 'Web browser or client application name reported during the session.',
    `consent_acknowledged` BOOLEAN COMMENT 'Indicates whether the user acknowledged required privacy/consent terms during the session.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the session origin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this session record was first captured in the system.',
    `device_identifier` STRING COMMENT 'Unique device fingerprint or registered device identifier associated with the session.',
    `device_type` STRING COMMENT 'Category of device used to access the portal session.',
    `failed_login_attempts` STRING COMMENT 'Count of failed authentication attempts recorded prior to or during establishment of this session.',
    `geo_location` STRING COMMENT 'Approximate geographic location (city/region) derived from the sessions originating network.',
    `idle_timeout_minutes` STRING COMMENT 'Configured inactivity threshold in minutes after which the session auto-terminates.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent user interaction within the session, used for idle timeout evaluation.',
    `login_timestamp` TIMESTAMP COMMENT 'The real-world timestamp when the portal session was authenticated and started.',
    `logout_timestamp` TIMESTAMP COMMENT 'The timestamp when the portal session ended, either by explicit logout or termination. Nullable for active sessions.',
    `mfa_verified` BOOLEAN COMMENT 'Indicates whether multi-factor authentication was successfully completed for this session.',
    `operating_system` STRING COMMENT 'Operating system name and version reported by the client device.',
    `page_view_count` STRING COMMENT 'Number of distinct portal pages or screens viewed during the session.',
    `proxy_access_indicator` BOOLEAN COMMENT 'Indicates whether the session was conducted by an authorized proxy (e.g., caregiver, guardian) on behalf of the patient.',
    `session_duration_seconds` STRING COMMENT 'Total elapsed active duration of the session measured in seconds.',
    `session_status` STRING COMMENT 'Current lifecycle state of the portal session.',
    `session_token` STRING COMMENT 'Opaque externally-referenced session token/identifier used to correlate the session across the portal application layer.',
    `session_type` STRING COMMENT 'Classifies the kind of portal session by the role of the authenticated user.',
    `source_ip_address` STRING COMMENT 'Originating IP address from which the portal session was established, captured for security auditing.',
    `termination_reason` STRING COMMENT 'The reason the session ended or was terminated.',
    `user_agent` STRING COMMENT 'Full user-agent header captured for the session for diagnostic and security purposes.',
    CONSTRAINT pk_portal_session PRIMARY KEY(`portal_session_id`)
) COMMENT 'Master reference table for portal_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_rpm_device_id` FOREIGN KEY (`rpm_device_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_device`(`rpm_device_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_primary_rpm_alert_threshold_id` FOREIGN KEY (`primary_rpm_alert_threshold_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold`(`rpm_alert_threshold_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_rpm_alert_threshold_id` FOREIGN KEY (`rpm_alert_threshold_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold`(`rpm_alert_threshold_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_rpm_program_enrollment_id` FOREIGN KEY (`rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment`(`rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_rpm_program_enrollment_id` FOREIGN KEY (`rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment`(`rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_prom_instrument_id` FOREIGN KEY (`prom_instrument_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`prom_instrument`(`prom_instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_prom_question_id` FOREIGN KEY (`prom_question_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`prom_question`(`prom_question_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_portal_session_id` FOREIGN KEY (`portal_session_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`portal_session`(`portal_session_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_rpm_device_id` FOREIGN KEY (`rpm_device_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_device`(`rpm_device_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_rpm_device_reading_id` FOREIGN KEY (`rpm_device_reading_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading`(`rpm_device_reading_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_rpm_program_enrollment_id` FOREIGN KEY (`rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment`(`rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_rpm_device_id` FOREIGN KEY (`rpm_device_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_device`(`rpm_device_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_rpm_program_enrollment_id` FOREIGN KEY (`rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment`(`rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`alert_threshold` ADD CONSTRAINT `fk_digital_health_alert_threshold_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_alert_threshold` ADD CONSTRAINT `fk_digital_health_device_alert_threshold_rpm_program_enrollment_id` FOREIGN KEY (`rpm_program_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment`(`rpm_program_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ADD CONSTRAINT `fk_digital_health_prom_question_prom_instrument_id` FOREIGN KEY (`prom_instrument_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`prom_instrument`(`prom_instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ADD CONSTRAINT `fk_digital_health_prom_question_parent_prom_question_id` FOREIGN KEY (`parent_prom_question_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`prom_question`(`prom_question_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ADD CONSTRAINT `fk_digital_health_portal_session_parent_portal_session_id` FOREIGN KEY (`parent_portal_session_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`portal_session`(`portal_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`digital_health` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`digital_health` SET TAGS ('pii_domain' = 'digital_health');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `rpm_device_reading_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `rpm_program_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `diastolic_bp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `diastolic_bp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `glucose_mg_dl` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `glucose_mg_dl` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `heart_rate` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `heart_rate` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `heart_rate_bpm` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `measurement_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `reading_value` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `reading_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `respiratory_rate` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `spo2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `spo2` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `spo2_percent` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `systolic_bp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `systolic_bp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `temperature_c` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `weight_kg` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `weight_kg` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `rpm_program_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `condition_monitored` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ALTER COLUMN `monitored_conditions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_program_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `prom_response_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `collection_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `instrument_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `question_text` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_numeric_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_value` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `survey_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `total_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ALTER COLUMN `total_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `portal_engagement_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `portal_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address_masked` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `test_result_viewed_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `user_agent` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `user_agent` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `device_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `device_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `measurement_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ALTER COLUMN `reading_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `monitored_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` ALTER COLUMN `rpm_device_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`alert_threshold` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`alert_threshold` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_alert_threshold` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_alert_threshold` SET TAGS ('pii_subdomain' = 'remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `prom_question_id` SET TAGS ('pii_business_glossary_term' = 'Prom Question Identifier');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `prom_instrument_id` SET TAGS ('pii_business_glossary_term' = 'Prom Instrument Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `parent_prom_question_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `clinical_domain` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_question` ALTER COLUMN `conditional_display_logic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `portal_session_id` SET TAGS ('pii_business_glossary_term' = 'Portal Session Identifier');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `parent_portal_session_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `browser_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `geo_location` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `operating_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `session_token` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `session_token` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `source_ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ALTER COLUMN `user_agent` SET TAGS ('pii_confidential' = 'true');
