-- Schema for Domain: facility | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`facility` COMMENT 'Healthcare facility and physical infrastructure management. Owns hospitals, clinics, outpatient centers, care sites, bed management, room/unit configuration, OR/ICU/ED space, equipment assets, biomedical engineering, preventive maintenance, environmental services, facility licensing, and accreditation status. Supports multi-site integrated delivery networks. Integrates with SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`care_site` (
    `care_site_id` BIGINT COMMENT 'Primary key for care site.',
    `parent_care_site_id` BIGINT COMMENT 'Self-referential FK for organizational hierarchy.',
    `npi_registry_id` BIGINT COMMENT 'Link to NPI registry for Type 2 (organizational) NPI.',
    `accreditation_body` STRING COMMENT 'TJC, DNV, HFAP, etc.',
    `accreditation_expiration_date` DATE COMMENT 'Date accreditation expires.',
    `accreditation_status` STRING COMMENT 'Accredited, Provisional, Denied, etc.',
    `address_line_1` STRING COMMENT 'Street address line 1.',
    `address_line_2` STRING COMMENT 'Street address line 2.',
    `ccn` STRING COMMENT 'CMS CCN (6-digit provider number).',
    `city` STRING COMMENT 'City name.',
    `closure_date` DATE COMMENT 'Date site closed.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code.',
    `county` STRING COMMENT 'County name.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `critical_access_hospital` BOOLEAN COMMENT 'CMS CAH designation.',
    `disproportionate_share_hospital` BOOLEAN COMMENT 'CMS DSH designation.',
    `email_address` STRING COMMENT 'Main email address.',
    `emergency_services_available` BOOLEAN COMMENT 'True if site has an emergency department.',
    `facility_type` STRING COMMENT 'Hospital, Clinic, ASC, SNF, etc.',
    `fax_number` STRING COMMENT 'Main fax number.',
    `go_live_date` DATE COMMENT 'Date site went live in EHR.',
    `hierarchy_effective_date` DATE COMMENT 'Date this hierarchy assignment became effective.',
    `hierarchy_level` STRING COMMENT 'System, Hospital, Campus, Building, Department, Unit.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `latitude` DECIMAL(18,2) COMMENT 'Geocoded latitude.',
    `license_effective_date` DATE COMMENT 'Date license became effective.',
    `license_expiration_date` DATE COMMENT 'Date license expires.',
    `license_number` STRING COMMENT 'State facility license number.',
    `licensed_bed_capacity` STRING COMMENT 'Total licensed inpatient beds.',
    `licensure_status` STRING COMMENT 'Active, Expired, Suspended, etc.',
    `longitude` DECIMAL(18,2) COMMENT 'Geocoded longitude.',
    `medicaid_provider_number` STRING COMMENT 'State Medicaid provider number.',
    `medicare_provider_number` STRING COMMENT 'Medicare enrollment provider number.',
    `operational_status` STRING COMMENT 'Active, Inactive, Planned, Closed.',
    `ownership_type` STRING COMMENT 'Government, Non-Profit, For-Profit, etc.',
    `phone_number` STRING COMMENT 'Main phone number.',
    `postal_code` STRING COMMENT 'ZIP or postal code.',
    `site_name` STRING COMMENT 'Official name of the care site.',
    `site_npi` STRING COMMENT 'Type 2 organizational NPI.',
    `sole_community_hospital` BOOLEAN COMMENT 'CMS SCH designation.',
    `staffed_bed_capacity` STRING COMMENT 'Total staffed inpatient beds.',
    `state` STRING COMMENT 'State or province code.',
    `teaching_status` BOOLEAN COMMENT 'True if academic medical center or teaching hospital.',
    `time_zone` STRING COMMENT 'IANA time zone identifier.',
    `trauma_level` STRING COMMENT 'Level I, II, III, IV, or V trauma center designation.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `website_url` STRING COMMENT 'Public website URL.',
    CONSTRAINT pk_care_site PRIMARY KEY(`care_site_id`)
) COMMENT 'Healthcare delivery site (hospital, clinic, department) with licensure, accreditation, and operational attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Primary key for building.',
    `care_site_id` BIGINT COMMENT 'Parent care site.',
    `geographic_region_id` BIGINT COMMENT 'Geographic region for property tax parcel.',
    `ada_compliant` BOOLEAN COMMENT 'True if ADA compliant.',
    `address_line_1` STRING COMMENT 'Street address line 1.',
    `address_line_2` STRING COMMENT 'Street address line 2.',
    `annual_property_tax_amount` DECIMAL(18,2) COMMENT 'The annual property tax amount of the facility building record.',
    `building_type` STRING COMMENT 'Inpatient, Outpatient, MOB, Administrative, etc.',
    `city` STRING COMMENT 'City name.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the facility building record.',
    `building_code` STRING COMMENT 'Internal building code.',
    `construction_year` STRING COMMENT 'Year building was constructed.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date of this record.',
    `electrical_service_capacity_kva` DECIMAL(18,2) COMMENT 'Electrical service capacity in KVA.',
    `emergency_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Emergency generator capacity in KW.',
    `emergency_generator_coverage_type` STRING COMMENT 'Full, Partial, Life Safety Only, etc.',
    `facility_license_expiration_date` DATE COMMENT 'Timestamp capturing the facility license expiration date associated with the facility building record.',
    `facility_license_number` STRING COMMENT 'State facility license number.',
    `fire_safety_classification` STRING COMMENT 'NFPA fire safety classification.',
    `gross_square_footage` DECIMAL(18,2) COMMENT 'Total gross square footage.',
    `helipad_available` BOOLEAN COMMENT 'True if helipad available.',
    `hvac_system_type` STRING COMMENT 'The hvac system type value classifying the facility building record.',
    `insurance_policy_number` STRING COMMENT 'Property insurance policy number.',
    `joint_commission_accreditation_expiration_date` DATE COMMENT 'TJC accreditation expiration date.',
    `joint_commission_accreditation_status` STRING COMMENT 'TJC accreditation status.',
    `last_major_renovation_year` STRING COMMENT 'Year of last major renovation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `latitude` DECIMAL(18,2) COMMENT 'Geocoded latitude.',
    `leed_certification_level` STRING COMMENT 'LEED certification level (Certified, Silver, Gold, Platinum).',
    `longitude` DECIMAL(18,2) COMMENT 'Geocoded longitude.',
    `medical_gas_system_installed` BOOLEAN COMMENT 'True if medical gas system installed.',
    `building_name` STRING COMMENT 'Official building name.',
    `net_usable_square_footage` DECIMAL(18,2) COMMENT 'The net usable square footage of the facility building record.',
    `number_of_elevators` STRING COMMENT 'Total number of elevators.',
    `number_of_floors` STRING COMMENT 'Total number of floors.',
    `operational_status` STRING COMMENT 'Active, Inactive, Under Construction, etc.',
    `ownership_type` STRING COMMENT 'Owned, Leased, etc.',
    `parking_spaces_count` STRING COMMENT 'Total parking spaces.',
    `postal_code` STRING COMMENT 'ZIP or postal code.',
    `property_tax_parcel_number` STRING COMMENT 'County property tax parcel number.',
    `replacement_value_amount` DECIMAL(18,2) COMMENT 'Estimated replacement value.',
    `seismic_zone` STRING COMMENT 'Seismic zone classification.',
    `sprinkler_system_type` STRING COMMENT 'Wet, Dry, Pre-Action, etc.',
    `state_province` STRING COMMENT 'State or province code.',
    `termination_date` DATE COMMENT 'Termination date of this record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Physical building structure with construction, safety, and property attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`unit` (
    `unit_id` BIGINT COMMENT 'Primary key for unit.',
    `care_site_id` BIGINT COMMENT 'Parent care site.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center.',
    `clinician_id` BIGINT COMMENT 'Nurse manager or unit director.',
    `accepts_admissions` BOOLEAN COMMENT 'True if unit accepts direct admissions.',
    `accepts_transfers` BOOLEAN COMMENT 'True if unit accepts transfers.',
    `acuity_level` STRING COMMENT 'Critical, Acute, Sub-Acute, etc.',
    `age_restriction` STRING COMMENT 'Adult, Pediatric, Neonatal, None.',
    `air_changes_per_hour` STRING COMMENT 'HVAC air changes per hour.',
    `chest_pain_center_accreditation` BOOLEAN COMMENT 'True if chest pain center accredited.',
    `unit_code` STRING COMMENT 'Internal unit code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `department_code` STRING COMMENT 'Financial department code.',
    `effective_date` DATE COMMENT 'Effective date of this record.',
    `electronic_health_record_system` STRING COMMENT 'EHR system name.',
    `emergency_power_backup` BOOLEAN COMMENT 'True if emergency power backup available.',
    `expiration_date` DATE COMMENT 'Expiration date of this record.',
    `floor_number` STRING COMMENT 'Floor number or name.',
    `gender_restriction` STRING COMMENT 'Male, Female, None.',
    `hvac_system_type` STRING COMMENT 'The hvac system type value classifying the facility unit record.',
    `infection_control_zone` STRING COMMENT 'Infection control zone classification.',
    `is_twenty_four_seven` BOOLEAN COMMENT 'True if unit operates 24/7.',
    `isolation_room_count` STRING COMMENT 'Number of isolation-capable rooms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `licensed_bed_count` STRING COMMENT 'Total licensed beds.',
    `magnet_recognition` BOOLEAN COMMENT 'True if Magnet-recognized unit.',
    `medical_gas_system` STRING COMMENT 'Medical gas system type.',
    `unit_name` STRING COMMENT 'Official unit name.',
    `negative_pressure_room_count` STRING COMMENT 'Number of negative pressure rooms.',
    `nurse_call_system_type` STRING COMMENT 'The nurse call system type value classifying the facility unit record.',
    `nurse_to_patient_ratio` DECIMAL(18,2) COMMENT 'Target nurse-to-patient ratio (e.g. 1:4).',
    `operational_hours_end` STRING COMMENT 'End time for non-24/7 units (HH:MM).',
    `operational_hours_start` STRING COMMENT 'Start time for non-24/7 units (HH:MM).',
    `revenue_center_code` STRING COMMENT 'UB-04 revenue center code.',
    `specialty_service_line` STRING COMMENT 'Cardiology, Oncology, Pediatrics, etc.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage.',
    `staffed_bed_count` STRING COMMENT 'Total staffed beds.',
    `stroke_center_designation` STRING COMMENT 'Primary, Comprehensive, Thrombectomy-Capable, etc.',
    `teaching_unit_flag` BOOLEAN COMMENT 'True if teaching unit.',
    `telemetry_monitoring_capability` BOOLEAN COMMENT 'True if telemetry monitoring available.',
    `trauma_level` STRING COMMENT 'Level I, II, III, IV, V.',
    `unit_status` STRING COMMENT 'Active, Inactive, Temporarily Closed, etc.',
    `unit_type` STRING COMMENT 'ICU, Med-Surg, ED, OR, etc.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `wing_or_section` STRING COMMENT 'Wing or section identifier.',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Clinical nursing unit or department with bed capacity, acuity, and staffing attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`room` (
    `room_id` BIGINT COMMENT 'Primary key for room.',
    `care_site_id` BIGINT COMMENT 'Parent care site.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center.',
    `unit_id` BIGINT COMMENT 'Parent unit.',
    `org_unit_id` BIGINT COMMENT 'Workforce organizational unit.',
    `accreditation_status` STRING COMMENT 'The accreditation status value classifying the facility room record.',
    `active_flag` BOOLEAN COMMENT 'True if room is active.',
    `ada_compliant_flag` BOOLEAN COMMENT 'True if ADA compliant.',
    `bariatric_capable_flag` BOOLEAN COMMENT 'True if bariatric capable.',
    `bed_count` STRING COMMENT 'Number of beds in room.',
    `boom_configuration` STRING COMMENT 'Ceiling boom configuration.',
    `class` STRING COMMENT 'Private, Semi-Private, Ward, etc.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_from_date` DATE COMMENT 'Timestamp capturing the effective from date associated with the facility room record.',
    `effective_to_date` DATE COMMENT 'Timestamp capturing the effective to date associated with the facility room record.',
    `emergency_power_flag` BOOLEAN COMMENT 'True if emergency power available.',
    `hand_hygiene_station_count` STRING COMMENT 'Number of hand hygiene stations.',
    `hvac_air_exchange_rate` DECIMAL(18,2) COMMENT 'Air changes per hour.',
    `imaging_integration_flag` BOOLEAN COMMENT 'True if imaging integration available.',
    `isolation_capable_flag` BOOLEAN COMMENT 'True if isolation capable.',
    `last_deep_clean_date` DATE COMMENT 'Date of last deep clean.',
    `last_inspection_date` DATE COMMENT 'Date of last inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `lease_ownership_indicator` STRING COMMENT 'Owned, Leased, etc.',
    `license_number` STRING COMMENT 'Room license number (if applicable).',
    `medical_air_outlet_count` STRING COMMENT 'Number of medical air outlets.',
    `monthly_space_cost` DECIMAL(18,2) COMMENT 'Monthly space cost allocation.',
    `room_name` STRING COMMENT 'The room name of the facility room record.',
    `negative_pressure_flag` BOOLEAN COMMENT 'True if negative pressure room.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Timestamp capturing the next scheduled maintenance date associated with the facility room record.',
    `nitrous_oxide_outlet_count` STRING COMMENT 'Number of nitrous oxide outlets.',
    `nurse_call_system_flag` BOOLEAN COMMENT 'True if nurse call system installed.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Average occupancy percentage.',
    `or_airflow_class` STRING COMMENT 'ISO Class 5, 6, 7, 8, etc.',
    `oxygen_outlet_count` STRING COMMENT 'Number of oxygen outlets.',
    `room_number` STRING COMMENT 'Room number or identifier.',
    `room_status` STRING COMMENT 'Active, Inactive, Under Renovation, etc.',
    `room_type` STRING COMMENT 'Patient Room, OR, Procedure Room, etc.',
    `square_footage` DECIMAL(18,2) COMMENT 'Room square footage.',
    `telemetry_capable_flag` BOOLEAN COMMENT 'True if telemetry capable.',
    `vacuum_outlet_count` STRING COMMENT 'Number of vacuum outlets.',
    `ventilator_outlet_count` STRING COMMENT 'Number of ventilator outlets.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Physical room within a unit with bed count, medical gas, and environmental attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed` (
    `bed_id` BIGINT COMMENT 'Primary key for bed.',
    `building_id` BIGINT COMMENT 'Parent building.',
    `care_site_id` BIGINT COMMENT 'Parent care site.',
    `mpi_record_id` BIGINT COMMENT 'Currently assigned patient.',
    `room_id` BIGINT COMMENT 'Parent room.',
    `unit_id` BIGINT COMMENT 'Parent unit.',
    `visit_id` BIGINT COMMENT 'Currently assigned visit.',
    `age_restriction` STRING COMMENT 'Adult, Pediatric, Neonatal, None.',
    `asset_tag` STRING COMMENT 'Asset tag number.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Timestamp of current patient assignment.',
    `bed_status` STRING COMMENT 'Occupied, Available, Cleaning, Blocked, etc.',
    `bed_type` STRING COMMENT 'Standard, ICU, Bariatric, etc.',
    `blocked_reason` STRING COMMENT 'Reason bed is blocked.',
    `bed_category` STRING COMMENT 'Licensed, Staffed, Surge, etc.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_ready_timestamp` TIMESTAMP COMMENT 'Timestamp when patient became discharge-ready.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the facility bed record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the facility bed record.',
    `expected_available_timestamp` TIMESTAMP COMMENT 'Expected timestamp when bed will be available.',
    `floor_number` STRING COMMENT 'The floor number of the facility bed record.',
    `gender_restriction` STRING COMMENT 'Male, Female, None.',
    `is_active` BOOLEAN COMMENT 'True if bed is active.',
    `is_air_fluidized` BOOLEAN COMMENT 'True if bed is air-fluidized (wound care).',
    `is_bariatric_capable` BOOLEAN COMMENT 'True if bed is bariatric capable.',
    `is_isolation_capable` BOOLEAN COMMENT 'True if bed is isolation capable.',
    `is_licensed` BOOLEAN COMMENT 'True if bed is licensed.',
    `is_low_bed` BOOLEAN COMMENT 'True if bed is a low bed (fall prevention).',
    `is_negative_pressure_room` BOOLEAN COMMENT 'True if bed is in a negative pressure room.',
    `is_private_room` BOOLEAN COMMENT 'True if bed is in a private room.',
    `is_staffed` BOOLEAN COMMENT 'True if bed is staffed.',
    `is_telemetry_capable` BOOLEAN COMMENT 'True if bed is telemetry capable.',
    `label` STRING COMMENT 'Bed label or identifier (e.g. A, B, 1, 2).',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Timestamp of last cleaning.',
    `last_maintenance_date` DATE COMMENT 'Date of last maintenance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `next_maintenance_due_date` DATE COMMENT 'Timestamp capturing the next maintenance due date associated with the facility bed record.',
    `out_of_service_reason` STRING COMMENT 'Reason bed is out of service.',
    `position` STRING COMMENT 'Position within room (e.g. Window, Door).',
    `status_timestamp` TIMESTAMP COMMENT 'Timestamp of last status change.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Weight capacity in pounds.',
    CONSTRAINT pk_bed PRIMARY KEY(`bed_id`)
) COMMENT 'Individual bed with status, assignment, and capability attributes for ADT and capacity management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` (
    `bed_status_event_id` BIGINT COMMENT 'Primary key for bed status event.',
    `bed_id` BIGINT COMMENT 'Unique identifier for the bed within the facility bed status event record.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `employee_id` BIGINT COMMENT 'Employee who triggered event.',
    `environmental_service_request_id` BIGINT COMMENT 'Related environmental service request.',
    `maintenance_order_id` BIGINT COMMENT 'Related maintenance order.',
    `mpi_record_id` BIGINT COMMENT 'Patient (if applicable).',
    `unit_id` BIGINT COMMENT 'Unique identifier for the primary bed unit within the facility bed status event record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the facility bed status event record.',
    `visit_id` BIGINT COMMENT 'Visit (if applicable).',
    `actual_availability_timestamp` TIMESTAMP COMMENT 'Actual timestamp when bed became available.',
    `acuity_level` STRING COMMENT 'Patient acuity level at time of event.',
    `adt_event_type` STRING COMMENT 'ADT event type (Admit, Discharge, Transfer, etc.).',
    `bed_assignment_method` STRING COMMENT 'Manual, Auto-Assign, etc.',
    `blocked_reason_category` STRING COMMENT 'Category of blocked reason.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `duration_minutes` STRING COMMENT 'Duration in this status (minutes).',
    `event_sequence_number` STRING COMMENT 'Sequence number for this bed.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of status change.',
    `expected_availability_timestamp` TIMESTAMP COMMENT 'Expected timestamp when bed will be available.',
    `initiating_user_role` STRING COMMENT 'Role of user who initiated event.',
    `is_elective_flag` BOOLEAN COMMENT 'True if elective admission.',
    `is_emergency_flag` BOOLEAN COMMENT 'True if emergency admission.',
    `isolation_type` STRING COMMENT 'Isolation type (Contact, Droplet, Airborne, etc.).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `new_status_code` STRING COMMENT 'New bed status code.',
    `notes` STRING COMMENT 'Free-text notes.',
    `prior_status_code` STRING COMMENT 'Prior bed status code.',
    `priority_flag` BOOLEAN COMMENT 'True if priority assignment.',
    `reason_code` STRING COMMENT 'Reason code for status change.',
    `reason_description` STRING COMMENT 'The reason description of the facility bed status event record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility bed status event record.',
    `source_system_event_code` STRING COMMENT 'The source system event code value classifying the facility bed status event record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_bed_status_event PRIMARY KEY(`bed_status_event_id`)
) COMMENT 'Bed status change event log for ADT, housekeeping, and capacity management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`or_suite` (
    `or_suite_id` BIGINT COMMENT 'Primary key for OR suite.',
    `building_id` BIGINT COMMENT 'Parent building.',
    `care_site_id` BIGINT COMMENT 'Parent care site.',
    `unit_id` BIGINT COMMENT 'Parent unit.',
    `accreditation_status` STRING COMMENT 'The accreditation status value classifying the facility or suite record.',
    `anesthesia_machine_model` STRING COMMENT 'The anesthesia machine model of the facility or suite record.',
    `boom_configuration` STRING COMMENT 'Ceiling boom configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `emergency_power_backup_flag` BOOLEAN COMMENT 'True if emergency power backup available.',
    `emergency_use_flag` BOOLEAN COMMENT 'True if designated for emergency use.',
    `equipment_inventory_list` STRING COMMENT 'Comma-separated list of equipment.',
    `fire_suppression_system_type` STRING COMMENT 'The fire suppression system type value classifying the facility or suite record.',
    `hvac_air_exchange_rate_per_hour` STRING COMMENT 'Air changes per hour.',
    `imaging_integration_type` STRING COMMENT 'C-Arm, Fluoro, CT, MRI, etc.',
    `isolation_capable_flag` BOOLEAN COMMENT 'True if isolation capable.',
    `laminar_airflow_class` STRING COMMENT 'ISO Class 5, 6, 7, 8, etc.',
    `last_accreditation_survey_date` DATE COMMENT 'Date of last accreditation survey.',
    `last_maintenance_date` DATE COMMENT 'Date of last maintenance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `license_expiration_date` DATE COMMENT 'Timestamp capturing the license expiration date associated with the facility or suite record.',
    `license_number` STRING COMMENT 'OR license number (if applicable).',
    `medical_gas_outlets_count` STRING COMMENT 'Total medical gas outlets.',
    `next_accreditation_survey_due_date` DATE COMMENT 'Timestamp capturing the next accreditation survey due date associated with the facility or suite record.',
    `next_maintenance_due_date` DATE COMMENT 'Timestamp capturing the next maintenance due date associated with the facility or suite record.',
    `operational_status` STRING COMMENT 'Active, Inactive, Under Maintenance, etc.',
    `or_name` STRING COMMENT 'The or name of the facility or suite record.',
    `or_number` STRING COMMENT 'OR number or identifier.',
    `or_type` STRING COMMENT 'General, Cardiac, Neuro, Ortho, etc.',
    `pediatric_capable_flag` BOOLEAN COMMENT 'True if pediatric capable.',
    `positive_pressure_maintained_flag` BOOLEAN COMMENT 'True if positive pressure maintained.',
    `robotic_surgery_compatible_flag` BOOLEAN COMMENT 'True if robotic surgery compatible.',
    `room_height_feet` DECIMAL(18,2) COMMENT 'Room height in feet.',
    `room_length_feet` DECIMAL(18,2) COMMENT 'Room length in feet.',
    `room_width_feet` DECIMAL(18,2) COMMENT 'Room width in feet.',
    `scheduled_maintenance_window` STRING COMMENT 'Scheduled maintenance window (e.g. Sundays 6am-12pm).',
    `status_effective_timestamp` TIMESTAMP COMMENT 'Timestamp when status became effective.',
    `status_reason_code` STRING COMMENT 'Reason code for status.',
    `surgical_table_type` STRING COMMENT 'The surgical table type value classifying the facility or suite record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `video_integration_capability_flag` BOOLEAN COMMENT 'True if video integration available.',
    CONSTRAINT pk_or_suite PRIMARY KEY(`or_suite_id`)
) COMMENT 'Operating room suite with airflow, equipment, and accreditation attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` (
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset within the facility equipment asset record.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the facility equipment asset record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility equipment asset record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the facility equipment asset record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the facility equipment asset record.',
    `asset_class` STRING COMMENT 'The asset class of the facility equipment asset record.',
    `asset_name` STRING COMMENT 'The asset name of the facility equipment asset record.',
    `asset_status` STRING COMMENT 'The asset status value classifying the facility equipment asset record.',
    `asset_tag` STRING COMMENT 'The asset tag of the facility equipment asset record.',
    `asset_type` STRING COMMENT 'The asset type value classifying the facility equipment asset record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility equipment asset record.',
    `current_book_value` DECIMAL(18,2) COMMENT 'The current book value of the facility equipment asset record.',
    `decommission_date` DATE COMMENT 'Timestamp capturing the decommission date associated with the facility equipment asset record.',
    `depreciation_method` STRING COMMENT 'The depreciation method of the facility equipment asset record.',
    `fda_device_class` STRING COMMENT 'The fda device class of the facility equipment asset record.',
    `installation_date` DATE COMMENT 'Timestamp capturing the installation date associated with the facility equipment asset record.',
    `is_life_support` BOOLEAN COMMENT 'Boolean flag indicating the is life support status of the facility equipment asset record.',
    `is_radiation_producing` BOOLEAN COMMENT 'Boolean flag indicating the is radiation producing status of the facility equipment asset record.',
    `last_pm_date` DATE COMMENT 'Timestamp capturing the last pm date associated with the facility equipment asset record.',
    `manufacturer` STRING COMMENT 'The manufacturer of the facility equipment asset record.',
    `model_number` STRING COMMENT 'The model number of the facility equipment asset record.',
    `next_pm_due_date` DATE COMMENT 'Timestamp capturing the next pm due date associated with the facility equipment asset record.',
    `pm_frequency_days` STRING COMMENT 'The pm frequency days of the facility equipment asset record.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'The purchase cost of the facility equipment asset record.',
    `purchase_date` DATE COMMENT 'Timestamp capturing the purchase date associated with the facility equipment asset record.',
    `risk_category` STRING COMMENT 'The risk category of the facility equipment asset record.',
    `serial_number` STRING COMMENT 'The serial number of the facility equipment asset record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility equipment asset record.',
    `udi_code` STRING COMMENT 'The udi code value classifying the facility equipment asset record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility equipment asset record.',
    `useful_life_months` STRING COMMENT 'The useful life months of the facility equipment asset record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility equipment asset record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `warranty_expiration_date` DATE COMMENT 'Timestamp capturing the warranty expiration date associated with the facility equipment asset record.',
    CONSTRAINT pk_equipment_asset PRIMARY KEY(`equipment_asset_id`)
) COMMENT 'Medical equipment asset with maintenance, calibration, and recall tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance order within the facility maintenance order record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the assigned employee within the facility maintenance order record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility maintenance order record.',
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset within the facility maintenance order record.',
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the pm schedule within the facility maintenance order record.',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the facility maintenance order record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility maintenance order record.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'The downtime hours of the facility maintenance order record.',
    `failure_code` STRING COMMENT 'The failure code value classifying the facility maintenance order record.',
    `labor_cost` DECIMAL(18,2) COMMENT 'The labor cost of the facility maintenance order record.',
    `labor_hours` DECIMAL(18,2) COMMENT 'The labor hours of the facility maintenance order record.',
    `order_status` STRING COMMENT 'The order status value classifying the facility maintenance order record.',
    `order_type` STRING COMMENT 'The order type value classifying the facility maintenance order record.',
    `parts_cost` DECIMAL(18,2) COMMENT 'The parts cost of the facility maintenance order record.',
    `priority_level` STRING COMMENT 'The priority level of the facility maintenance order record.',
    `problem_description` STRING COMMENT 'The problem description of the facility maintenance order record.',
    `requested_date` DATE COMMENT 'Timestamp capturing the requested date associated with the facility maintenance order record.',
    `resolution_description` STRING COMMENT 'The resolution description of the facility maintenance order record.',
    `root_cause` STRING COMMENT 'The root cause of the facility maintenance order record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the facility maintenance order record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility maintenance order record.',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the facility maintenance order record.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the facility maintenance order record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility maintenance order record.',
    `vendor_name` STRING COMMENT 'The vendor name of the facility maintenance order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility maintenance order record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    `work_order_number` STRING COMMENT 'The work order number of the facility maintenance order record.',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Maintenance work order for equipment and facility assets.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the pm schedule within the facility pm schedule record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility pm schedule record.',
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset within the facility pm schedule record.',
    `compliance_window_days` STRING COMMENT 'The compliance window days of the facility pm schedule record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility pm schedule record.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated duration hours of the facility pm schedule record.',
    `frequency_days` STRING COMMENT 'The frequency days of the facility pm schedule record.',
    `frequency_type` STRING COMMENT 'The frequency type value classifying the facility pm schedule record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the facility pm schedule record.',
    `last_performed_date` DATE COMMENT 'Timestamp capturing the last performed date associated with the facility pm schedule record.',
    `next_due_date` DATE COMMENT 'Timestamp capturing the next due date associated with the facility pm schedule record.',
    `procedure_description` STRING COMMENT 'The procedure description of the facility pm schedule record.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'The regulatory requirement flag of the facility pm schedule record.',
    `schedule_name` STRING COMMENT 'The schedule name of the facility pm schedule record.',
    `schedule_type` STRING COMMENT 'The schedule type value classifying the facility pm schedule record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility pm schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility pm schedule record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility pm schedule record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule for equipment and facility assets.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the inspection within the facility inspection record.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the facility inspection record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility inspection record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the inspector employee within the facility inspection record.',
    `inspection_category` STRING COMMENT 'The inspection category of the facility inspection record.',
    `corrective_action_due_date` DATE COMMENT 'Timestamp capturing the corrective action due date associated with the facility inspection record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility inspection record.',
    `critical_findings_count` STRING COMMENT 'The critical findings count of the facility inspection record.',
    `findings_count` STRING COMMENT 'The findings count of the facility inspection record.',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the facility inspection record.',
    `inspection_status` STRING COMMENT 'The inspection status value classifying the facility inspection record.',
    `inspection_type` STRING COMMENT 'The inspection type value classifying the facility inspection record.',
    `inspector_name` STRING COMMENT 'The inspector name of the facility inspection record.',
    `inspector_organization` STRING COMMENT 'The inspector organization of the facility inspection record.',
    `notes` STRING COMMENT 'The notes of the facility inspection record.',
    `overall_result` STRING COMMENT 'The overall result of the facility inspection record.',
    `performed_date` DATE COMMENT 'Timestamp capturing the performed date associated with the facility inspection record.',
    `report_url` STRING COMMENT 'The report url of the facility inspection record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the facility inspection record.',
    `score` DECIMAL(18,2) COMMENT 'The score of the facility inspection record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility inspection record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility inspection record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility inspection record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Regulatory inspection (TJC, CMS, State, Fire Marshal, etc.).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for the inspection finding within the facility inspection finding record.',
    `inspection_id` BIGINT COMMENT 'Unique identifier for the inspection within the facility inspection finding record.',
    `corrective_action_completed_date` DATE COMMENT 'Timestamp capturing the corrective action completed date associated with the facility inspection finding record.',
    `corrective_action_description` STRING COMMENT 'The corrective action description of the facility inspection finding record.',
    `corrective_action_due_date` DATE COMMENT 'Timestamp capturing the corrective action due date associated with the facility inspection finding record.',
    `corrective_action_required` BOOLEAN COMMENT 'The corrective action required of the facility inspection finding record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility inspection finding record.',
    `finding_category` STRING COMMENT 'The finding category of the facility inspection finding record.',
    `finding_code` STRING COMMENT 'The finding code value classifying the facility inspection finding record.',
    `finding_description` STRING COMMENT 'The finding description of the facility inspection finding record.',
    `location_description` STRING COMMENT 'The location description of the facility inspection finding record.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference of the facility inspection finding record.',
    `repeat_finding_flag` BOOLEAN COMMENT 'The repeat finding flag of the facility inspection finding record.',
    `resolution_status` STRING COMMENT 'The resolution status value classifying the facility inspection finding record.',
    `severity_level` STRING COMMENT 'The severity level of the facility inspection finding record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility inspection finding record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility inspection finding record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual finding from a regulatory inspection.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` (
    `license_accreditation_id` BIGINT COMMENT 'Unique identifier for the license accreditation within the facility license accreditation record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility license accreditation record.',
    `accreditation_body` STRING COMMENT 'The accreditation body of the facility license accreditation record.',
    `accreditation_status` STRING COMMENT 'The accreditation status value classifying the facility license accreditation record.',
    `bed_count_licensed` STRING COMMENT 'The bed count licensed of the facility license accreditation record.',
    `conditions_of_participation_met` BOOLEAN COMMENT 'The conditions of participation met of the facility license accreditation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility license accreditation record.',
    `deficiency_count` STRING COMMENT 'The deficiency count of the facility license accreditation record.',
    `document_url` STRING COMMENT 'The document url of the facility license accreditation record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the facility license accreditation record.',
    `issue_date` DATE COMMENT 'Timestamp capturing the issue date associated with the facility license accreditation record.',
    `issuing_authority` STRING COMMENT 'The issuing authority of the facility license accreditation record.',
    `last_survey_date` DATE COMMENT 'Timestamp capturing the last survey date associated with the facility license accreditation record.',
    `license_number` STRING COMMENT 'The license number of the facility license accreditation record.',
    `license_type` STRING COMMENT 'The license type value classifying the facility license accreditation record.',
    `next_survey_date` DATE COMMENT 'Timestamp capturing the next survey date associated with the facility license accreditation record.',
    `notes` STRING COMMENT 'The notes of the facility license accreditation record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the facility license accreditation record.',
    `service_scope` STRING COMMENT 'The service scope of the facility license accreditation record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility license accreditation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility license accreditation record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility license accreditation record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_license_accreditation PRIMARY KEY(`license_accreditation_id`)
) COMMENT 'Facility license or accreditation credential.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT 'Unique identifier for the space allocation within the facility space allocation record.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the facility space allocation record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the facility space allocation record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the facility space allocation record.',
    `allocated_square_feet` DECIMAL(18,2) COMMENT 'The allocated square feet of the facility space allocation record.',
    `allocation_type` STRING COMMENT 'The allocation type value classifying the facility space allocation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility space allocation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility space allocation record.',
    `is_shared` BOOLEAN COMMENT 'Boolean flag indicating the is shared status of the facility space allocation record.',
    `notes` STRING COMMENT 'The notes of the facility space allocation record.',
    `occupancy_count` STRING COMMENT 'The occupancy count of the facility space allocation record.',
    `purpose` STRING COMMENT 'The purpose of the facility space allocation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the facility space allocation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility space allocation record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility space allocation record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Space allocation to department or cost center.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` (
    `environmental_service_request_id` BIGINT COMMENT 'Unique identifier for the environmental service request within the facility environmental service request record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the assigned employee within the facility environmental service request record.',
    `bed_id` BIGINT COMMENT 'Unique identifier for the bed within the facility environmental service request record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the facility environmental service request record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the facility environmental service request record.',
    `assigned_timestamp` TIMESTAMP COMMENT 'The assigned timestamp of the facility environmental service request record.',
    `cleaning_type` STRING COMMENT 'The cleaning type value classifying the facility environmental service request record.',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the facility environmental service request record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility environmental service request record.',
    `inspection_passed_flag` BOOLEAN COMMENT 'The inspection passed flag of the facility environmental service request record.',
    `isolation_precaution_type` STRING COMMENT 'The isolation precaution type value classifying the facility environmental service request record.',
    `notes` STRING COMMENT 'The notes of the facility environmental service request record.',
    `priority_level` STRING COMMENT 'The priority level of the facility environmental service request record.',
    `request_status` STRING COMMENT 'The request status value classifying the facility environmental service request record.',
    `request_type` STRING COMMENT 'The request type value classifying the facility environmental service request record.',
    `requested_timestamp` TIMESTAMP COMMENT 'The requested timestamp of the facility environmental service request record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility environmental service request record.',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the facility environmental service request record.',
    `turnaround_minutes` STRING COMMENT 'The turnaround minutes of the facility environmental service request record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility environmental service request record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_environmental_service_request PRIMARY KEY(`environmental_service_request_id`)
) COMMENT 'Housekeeping and environmental services request.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` (
    `capacity_snapshot_id` BIGINT COMMENT 'Unique identifier for the capacity snapshot within the facility capacity snapshot record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility capacity snapshot record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the facility capacity snapshot record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility capacity snapshot record.',
    `diversion_status` STRING COMMENT 'The diversion status value classifying the facility capacity snapshot record.',
    `ed_boarding_count` STRING COMMENT 'The ed boarding count of the facility capacity snapshot record.',
    `icu_available` STRING COMMENT 'The icu available of the facility capacity snapshot record.',
    `icu_occupied` STRING COMMENT 'The icu occupied of the facility capacity snapshot record.',
    `occupancy_rate` DECIMAL(18,2) COMMENT 'The occupancy rate of the facility capacity snapshot record.',
    `pending_admissions` STRING COMMENT 'The pending admissions of the facility capacity snapshot record.',
    `pending_discharges` STRING COMMENT 'The pending discharges of the facility capacity snapshot record.',
    `snapshot_date` DATE COMMENT 'Timestamp capturing the snapshot date associated with the facility capacity snapshot record.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The snapshot timestamp of the facility capacity snapshot record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility capacity snapshot record.',
    `surge_level` STRING COMMENT 'The surge level of the facility capacity snapshot record.',
    `total_available_beds` STRING COMMENT 'The total available beds of the facility capacity snapshot record.',
    `total_blocked_beds` STRING COMMENT 'The total blocked beds of the facility capacity snapshot record.',
    `total_licensed_beds` STRING COMMENT 'The total licensed beds of the facility capacity snapshot record.',
    `total_occupied_beds` STRING COMMENT 'The total occupied beds of the facility capacity snapshot record.',
    `total_staffed_beds` STRING COMMENT 'The total staffed beds of the facility capacity snapshot record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility capacity snapshot record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_capacity_snapshot PRIMARY KEY(`capacity_snapshot_id`)
) COMMENT 'Point-in-time capacity snapshot (census, occupancy, diversion status).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`service` (
    `service_id` BIGINT COMMENT 'Unique identifier for the service within the facility service record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility service record.',
    `accreditation_required_flag` BOOLEAN COMMENT 'The accreditation required flag of the facility service record.',
    `service_category` STRING COMMENT 'The service category of the facility service record.',
    `service_code` STRING COMMENT 'The service code value classifying the facility service record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility service record.',
    `deactivation_date` DATE COMMENT 'Timestamp capturing the deactivation date associated with the facility service record.',
    `department_code` STRING COMMENT 'The department code value classifying the facility service record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility service record.',
    `medical_director_name` STRING COMMENT 'The medical director name of the facility service record.',
    `service_name` STRING COMMENT 'The service name of the facility service record.',
    `service_status` STRING COMMENT 'The service status value classifying the facility service record.',
    `service_type` STRING COMMENT 'The service type value classifying the facility service record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility service record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility service record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility service record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Clinical service line offered at a care site.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the contract within the facility contract record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility contract record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the facility contract record.',
    `annual_value` DECIMAL(18,2) COMMENT 'The annual value of the facility contract record.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the facility contract record.',
    `contract_category` STRING COMMENT 'The contract category of the facility contract record.',
    `contract_number` STRING COMMENT 'The contract number of the facility contract record.',
    `contract_status` STRING COMMENT 'The contract status value classifying the facility contract record.',
    `contract_type` STRING COMMENT 'The contract type value classifying the facility contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility contract record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the facility contract record.',
    `document_url` STRING COMMENT 'The document url of the facility contract record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility contract record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the facility contract record.',
    `contract_name` STRING COMMENT 'The contract name of the facility contract record.',
    `notes` STRING COMMENT 'The notes of the facility contract record.',
    `owner_name` STRING COMMENT 'The owner name of the facility contract record.',
    `payment_terms` STRING COMMENT 'The payment terms of the facility contract record.',
    `renewal_notice_days` STRING COMMENT 'The renewal notice days of the facility contract record.',
    `renewal_type` STRING COMMENT 'The renewal type value classifying the facility contract record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility contract record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the facility contract record.',
    `termination_reason` STRING COMMENT 'The termination reason of the facility contract record.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the facility contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility contract record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility contract record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Facility vendor contract (service, maintenance, lease, etc.).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` (
    `hazardous_material_id` BIGINT COMMENT 'Unique identifier for the hazardous material within the facility hazardous material record.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the facility hazardous material record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility hazardous material record.',
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location within the facility hazardous material record.',
    `cas_number` STRING COMMENT 'The cas number of the facility hazardous material record.',
    `chemical_name` STRING COMMENT 'The chemical name of the facility hazardous material record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility hazardous material record.',
    `dot_shipping_name` STRING COMMENT 'The dot shipping name of the facility hazardous material record.',
    `epa_waste_code` STRING COMMENT 'The epa waste code value classifying the facility hazardous material record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the facility hazardous material record.',
    `ghs_classification` STRING COMMENT 'The ghs classification of the facility hazardous material record.',
    `hazard_class` STRING COMMENT 'The hazard class of the facility hazardous material record.',
    `is_carcinogen` BOOLEAN COMMENT 'Boolean flag indicating the is carcinogen status of the facility hazardous material record.',
    `is_radioactive` BOOLEAN COMMENT 'Boolean flag indicating the is radioactive status of the facility hazardous material record.',
    `last_inventory_date` DATE COMMENT 'Timestamp capturing the last inventory date associated with the facility hazardous material record.',
    `material_name` STRING COMMENT 'The material name of the facility hazardous material record.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the facility hazardous material record.',
    `responsible_person_name` STRING COMMENT 'The responsible person name of the facility hazardous material record.',
    `sds_document_url` STRING COMMENT 'The sds document url of the facility hazardous material record.',
    `sds_revision_date` DATE COMMENT 'Timestamp capturing the sds revision date associated with the facility hazardous material record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility hazardous material record.',
    `storage_requirement` STRING COMMENT 'The storage requirement of the facility hazardous material record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the facility hazardous material record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility hazardous material record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility hazardous material record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_hazardous_material PRIMARY KEY(`hazardous_material_id`)
) COMMENT 'Hazardous material inventory (chemical, radioactive, biohazard).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique identifier for the safety incident within the facility safety incident record.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the facility safety incident record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility safety incident record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the reported by employee within the facility safety incident record.',
    `closed_date` DATE COMMENT 'Timestamp capturing the closed date associated with the facility safety incident record.',
    `corrective_action` STRING COMMENT 'The corrective action of the facility safety incident record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility safety incident record.',
    `safety_incident_description` STRING COMMENT 'The safety incident description of the facility safety incident record.',
    `incident_category` STRING COMMENT 'The incident category of the facility safety incident record.',
    `incident_date` DATE COMMENT 'Timestamp capturing the incident date associated with the facility safety incident record.',
    `incident_number` STRING COMMENT 'The incident number of the facility safety incident record.',
    `incident_status` STRING COMMENT 'The incident status value classifying the facility safety incident record.',
    `incident_time` TIMESTAMP COMMENT 'Timestamp capturing the incident time associated with the facility safety incident record.',
    `incident_type` STRING COMMENT 'The incident type value classifying the facility safety incident record.',
    `injuries_count` STRING COMMENT 'The injuries count of the facility safety incident record.',
    `investigation_status` STRING COMMENT 'The investigation status value classifying the facility safety incident record.',
    `location_description` STRING COMMENT 'The location description of the facility safety incident record.',
    `osha_recordable_flag` BOOLEAN COMMENT 'The osha recordable flag of the facility safety incident record.',
    `persons_involved_count` STRING COMMENT 'The persons involved count of the facility safety incident record.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'The regulatory reportable flag of the facility safety incident record.',
    `root_cause` STRING COMMENT 'The root cause of the facility safety incident record.',
    `severity_level` STRING COMMENT 'The severity level of the facility safety incident record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility safety incident record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility safety incident record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility safety incident record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Facility safety incident (slip/fall, equipment failure, etc.).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` (
    `site_hierarchy_id` BIGINT COMMENT 'Unique identifier for the site hierarchy within the facility site hierarchy record.',
    `organization_id` BIGINT COMMENT 'Unique identifier for the organization within the facility site hierarchy record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the parent care site within the facility site hierarchy record.',
    `primary_care_site_id` BIGINT COMMENT 'Unique identifier for the primary care site within the facility site hierarchy record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility site hierarchy record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility site hierarchy record.',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the facility site hierarchy record.',
    `hierarchy_type` STRING COMMENT 'The hierarchy type value classifying the facility site hierarchy record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the facility site hierarchy record.',
    `path` STRING COMMENT 'The path of the facility site hierarchy record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the facility site hierarchy record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the facility site hierarchy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility site hierarchy record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility site hierarchy record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_site_hierarchy PRIMARY KEY(`site_hierarchy_id`)
) COMMENT 'Facility organizational hierarchy (system > hospital > campus > building > department > unit).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`network_contract` (
    `network_contract_id` BIGINT COMMENT 'Unique identifier for the network contract within the facility network contract record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility network contract record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the facility network contract record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the facility network contract record.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the facility network contract record.',
    `base_rate` DECIMAL(18,2) COMMENT 'The base rate of the facility network contract record.',
    `contract_name` STRING COMMENT 'The contract name of the facility network contract record.',
    `contract_number` STRING COMMENT 'The contract number of the facility network contract record.',
    `contract_status` STRING COMMENT 'The contract status value classifying the facility network contract record.',
    `contract_type` STRING COMMENT 'The contract type value classifying the facility network contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility network contract record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility network contract record.',
    `fee_schedule_type` STRING COMMENT 'The fee schedule type value classifying the facility network contract record.',
    `network_tier` STRING COMMENT 'The network tier of the facility network contract record.',
    `notes` STRING COMMENT 'The notes of the facility network contract record.',
    `reimbursement_methodology` STRING COMMENT 'The reimbursement methodology of the facility network contract record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the facility network contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility network contract record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility network contract record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_network_contract PRIMARY KEY(`network_contract_id`)
) COMMENT 'Payer network contract participation at facility level.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` (
    `facility_program_participation_id` BIGINT COMMENT 'Unique identifier for the facility program participation within the facility facility program participation record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility facility program participation record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the facility facility program participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility facility program participation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility facility program participation record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the facility facility program participation record.',
    `last_attestation_date` DATE COMMENT 'Timestamp capturing the last attestation date associated with the facility facility program participation record.',
    `next_reporting_due_date` DATE COMMENT 'Timestamp capturing the next reporting due date associated with the facility facility program participation record.',
    `notes` STRING COMMENT 'The notes of the facility facility program participation record.',
    `participation_scope` STRING COMMENT 'The participation scope of the facility facility program participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the facility facility program participation record.',
    `performance_tier` STRING COMMENT 'The performance tier of the facility facility program participation record.',
    `program_name` STRING COMMENT 'The program name of the facility facility program participation record.',
    `program_type` STRING COMMENT 'The program type value classifying the facility facility program participation record.',
    `ssot_reference` STRING COMMENT 'The ssot reference of the facility facility program participation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the facility facility program participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility facility program participation record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility facility program participation record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_facility_program_participation PRIMARY KEY(`facility_program_participation_id`)
) COMMENT 'SSOT resolved: defer to quality.quality_program_participation as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` (
    `block_assignment_id` BIGINT COMMENT 'Unique identifier for the block assignment within the facility block assignment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the facility block assignment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the facility block assignment record.',
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the or suite within the facility block assignment record.',
    `service_id` BIGINT COMMENT 'Unique identifier for the service within the facility block assignment record.',
    `block_name` STRING COMMENT 'The block name of the facility block assignment record.',
    `block_type` STRING COMMENT 'The block type value classifying the facility block assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility block assignment record.',
    `day_of_week` STRING COMMENT 'The day of week of the facility block assignment record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the facility block assignment record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the facility block assignment record.',
    `end_time` TIMESTAMP COMMENT 'Timestamp capturing the end time associated with the facility block assignment record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the facility block assignment record.',
    `notes` STRING COMMENT 'The notes of the facility block assignment record.',
    `priority_level` STRING COMMENT 'The priority level of the facility block assignment record.',
    `release_days_before` STRING COMMENT 'The release days before of the facility block assignment record.',
    `start_time` TIMESTAMP COMMENT 'Timestamp capturing the start time associated with the facility block assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility block assignment record.',
    `utilization_target_pct` DECIMAL(18,2) COMMENT 'The utilization target pct of the facility block assignment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility block assignment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_block_assignment PRIMARY KEY(`block_assignment_id`)
) COMMENT 'OR block time assignment to surgeon or service.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` (
    `equipment_authorization_id` BIGINT COMMENT 'Unique identifier for the equipment authorization within the facility equipment authorization record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the facility equipment authorization record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the facility equipment authorization record.',
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset within the facility equipment authorization record.',
    `authorization_status` STRING COMMENT 'The authorization status value classifying the facility equipment authorization record.',
    `authorization_type` STRING COMMENT 'The authorization type value classifying the facility equipment authorization record.',
    `competency_verified_date` DATE COMMENT 'Timestamp capturing the competency verified date associated with the facility equipment authorization record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the facility equipment authorization record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the facility equipment authorization record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the facility equipment authorization record.',
    `notes` STRING COMMENT 'The notes of the facility equipment authorization record.',
    `renewal_required_flag` BOOLEAN COMMENT 'The renewal required flag of the facility equipment authorization record.',
    `training_completed_date` DATE COMMENT 'Timestamp capturing the training completed date associated with the facility equipment authorization record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the facility equipment authorization record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the facility equipment authorization record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_equipment_authorization PRIMARY KEY(`equipment_authorization_id`)
) COMMENT 'Provider authorization to use specific equipment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization.',
    `care_site_id` BIGINT COMMENT 'Anchor point to facility hierarchy.',
    `parent_organization_id` BIGINT COMMENT 'Self-referential FK for organizational hierarchy.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date of this record.',
    `hierarchy_level` STRING COMMENT 'Hierarchy level (1=System, 2=Hospital, 3=Campus, etc.).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `organization_name` STRING COMMENT 'Official organization name.',
    `organization_status` STRING COMMENT 'Active, Inactive, Merged, etc.',
    `organization_type` STRING COMMENT 'Health System, Hospital, Clinic, Department, Unit, etc.',
    `termination_date` DATE COMMENT 'Termination date of this record.',
    `vibe_structural_fix` STRING COMMENT 'Marker indicating VIBE structural remediation applied',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `vibe_type_normalization_marker` STRING COMMENT 'Marker recording that type/classification normalization pass was applied.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Healthcare organization (health system, hospital, clinic, department, unit) with self-referential hierarchy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_parent_care_site_id` FOREIGN KEY (`parent_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_environmental_service_request_id` FOREIGN KEY (`environmental_service_request_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`environmental_service_request`(`environmental_service_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_primary_care_site_id` FOREIGN KEY (`primary_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_entity' = 'care_site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_subdomain' = 'core');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `care_site_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `parent_care_site_id` SET TAGS ('pii_business_glossary_term' = 'Parent Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `parent_care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_business_glossary_term' = 'NPI Registry Reference');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `critical_access_hospital` SET TAGS ('pii_business_glossary_term' = 'Critical Access Hospital');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `disproportionate_share_hospital` SET TAGS ('pii_business_glossary_term' = 'Disproportionate Share Hospital');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `emergency_services_available` SET TAGS ('pii_business_glossary_term' = 'Emergency Services Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `go_live_date` SET TAGS ('pii_business_glossary_term' = 'Go Live Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_effective_date` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('pii_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_business_glossary_term' = 'Licensed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('pii_business_glossary_term' = 'Licensure Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicaid_provider_number` SET TAGS ('pii_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicare_provider_number` SET TAGS ('pii_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_business_glossary_term' = 'Site NPI');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `sole_community_hospital` SET TAGS ('pii_business_glossary_term' = 'Sole Community Hospital');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_business_glossary_term' = 'Staffed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `teaching_status` SET TAGS ('pii_business_glossary_term' = 'Teaching Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `time_zone` SET TAGS ('pii_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('pii_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_entity' = 'building');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_subdomain' = 'physical_plant');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Property Tax Parcel Region');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ada_compliant` SET TAGS ('pii_business_glossary_term' = 'ADA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Property Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('pii_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('pii_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `construction_year` SET TAGS ('pii_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_business_glossary_term' = 'Electrical Service Capacity KVA');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_business_glossary_term' = 'Emergency Generator Capacity KW');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('pii_business_glossary_term' = 'Emergency Generator Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Facility License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_business_glossary_term' = 'Facility License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('pii_business_glossary_term' = 'Fire Safety Classification');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `gross_square_footage` SET TAGS ('pii_business_glossary_term' = 'Gross Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `helipad_available` SET TAGS ('pii_business_glossary_term' = 'Helipad Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('pii_business_glossary_term' = 'HVAC System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Joint Commission Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Joint Commission Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_major_renovation_year` SET TAGS ('pii_business_glossary_term' = 'Last Major Renovation Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('pii_business_glossary_term' = 'LEED Certification Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_business_glossary_term' = 'Medical Gas System Installed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `net_usable_square_footage` SET TAGS ('pii_business_glossary_term' = 'Net Usable Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_elevators` SET TAGS ('pii_business_glossary_term' = 'Number of Elevators');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_floors` SET TAGS ('pii_business_glossary_term' = 'Number of Floors');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `parking_spaces_count` SET TAGS ('pii_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `property_tax_parcel_number` SET TAGS ('pii_business_glossary_term' = 'Property Tax Parcel Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('pii_business_glossary_term' = 'Replacement Value Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('pii_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('pii_business_glossary_term' = 'Sprinkler System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_entity' = 'unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_subdomain' = 'clinical_space');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Manager Clinician');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_admissions` SET TAGS ('pii_business_glossary_term' = 'Accepts Admissions');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_transfers` SET TAGS ('pii_business_glossary_term' = 'Accepts Transfers');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `air_changes_per_hour` SET TAGS ('pii_business_glossary_term' = 'Air Changes Per Hour');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('pii_business_glossary_term' = 'Chest Pain Center Accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('pii_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_business_glossary_term' = 'Electronic Health Record System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `emergency_power_backup` SET TAGS ('pii_business_glossary_term' = 'Emergency Power Backup');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `floor_number` SET TAGS ('pii_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `hvac_system_type` SET TAGS ('pii_business_glossary_term' = 'HVAC System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('pii_business_glossary_term' = 'Infection Control Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `is_twenty_four_seven` SET TAGS ('pii_business_glossary_term' = 'Is 24/7');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `isolation_room_count` SET TAGS ('pii_business_glossary_term' = 'Isolation Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('pii_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `magnet_recognition` SET TAGS ('pii_business_glossary_term' = 'Magnet Recognition');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_business_glossary_term' = 'Medical Gas System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `negative_pressure_room_count` SET TAGS ('pii_business_glossary_term' = 'Negative Pressure Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_call_system_type` SET TAGS ('pii_business_glossary_term' = 'Nurse Call System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_business_glossary_term' = 'Nurse to Patient Ratio');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('pii_business_glossary_term' = 'Operational Hours End');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('pii_business_glossary_term' = 'Operational Hours Start');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `specialty_service_line` SET TAGS ('pii_business_glossary_term' = 'Specialty Service Line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `square_footage` SET TAGS ('pii_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `staffed_bed_count` SET TAGS ('pii_business_glossary_term' = 'Staffed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('pii_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `teaching_unit_flag` SET TAGS ('pii_business_glossary_term' = 'Teaching Unit Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `telemetry_monitoring_capability` SET TAGS ('pii_business_glossary_term' = 'Telemetry Monitoring Capability');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('pii_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('pii_business_glossary_term' = 'Unit Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('pii_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `wing_or_section` SET TAGS ('pii_business_glossary_term' = 'Wing or Section');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_entity' = 'room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_subdomain' = 'clinical_space');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `unit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ada_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'ADA Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bariatric_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Bariatric Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bed_count` SET TAGS ('pii_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `boom_configuration` SET TAGS ('pii_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `class` SET TAGS ('pii_business_glossary_term' = 'Room Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_to_date` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `emergency_power_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Power Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hand_hygiene_station_count` SET TAGS ('pii_business_glossary_term' = 'Hand Hygiene Station Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hvac_air_exchange_rate` SET TAGS ('pii_business_glossary_term' = 'HVAC Air Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `imaging_integration_flag` SET TAGS ('pii_business_glossary_term' = 'Imaging Integration Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `isolation_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_deep_clean_date` SET TAGS ('pii_business_glossary_term' = 'Last Deep Clean Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('pii_business_glossary_term' = 'Lease Ownership Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Medical Air Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('pii_business_glossary_term' = 'Monthly Space Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_business_glossary_term' = 'Room Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `negative_pressure_flag` SET TAGS ('pii_business_glossary_term' = 'Negative Pressure Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nitrous_oxide_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Nitrous Oxide Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nurse_call_system_flag` SET TAGS ('pii_business_glossary_term' = 'Nurse Call System Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `occupancy_percentage` SET TAGS ('pii_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('pii_business_glossary_term' = 'OR Airflow Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `oxygen_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Oxygen Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_number` SET TAGS ('pii_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('pii_business_glossary_term' = 'Room Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_type` SET TAGS ('pii_business_glossary_term' = 'Room Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `square_footage` SET TAGS ('pii_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `telemetry_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Telemetry Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `vacuum_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Vacuum Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ventilator_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Ventilator Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_entity' = 'bed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_subdomain' = 'clinical_space');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `room_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `asset_tag` SET TAGS ('pii_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `assignment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('pii_business_glossary_term' = 'Bed Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_type` SET TAGS ('pii_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `blocked_reason` SET TAGS ('pii_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('pii_business_glossary_term' = 'Bed Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `discharge_ready_timestamp` SET TAGS ('pii_business_glossary_term' = 'Discharge Ready Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `expected_available_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expected Available Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `floor_number` SET TAGS ('pii_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_air_fluidized` SET TAGS ('pii_business_glossary_term' = 'Is Air Fluidized');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_bariatric_capable` SET TAGS ('pii_business_glossary_term' = 'Is Bariatric Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_isolation_capable` SET TAGS ('pii_business_glossary_term' = 'Is Isolation Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('pii_business_glossary_term' = 'Is Licensed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_low_bed` SET TAGS ('pii_business_glossary_term' = 'Is Low Bed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_negative_pressure_room` SET TAGS ('pii_business_glossary_term' = 'Is Negative Pressure Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_private_room` SET TAGS ('pii_business_glossary_term' = 'Is Private Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_staffed` SET TAGS ('pii_business_glossary_term' = 'Is Staffed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_telemetry_capable` SET TAGS ('pii_business_glossary_term' = 'Is Telemetry Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `label` SET TAGS ('pii_business_glossary_term' = 'Bed Label');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `out_of_service_reason` SET TAGS ('pii_business_glossary_term' = 'Out of Service Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `position` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `status_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_business_glossary_term' = 'Weight Capacity Lbs');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_entity' = 'bed_status_event');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_subdomain' = 'clinical_space');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_status_event_id` SET TAGS ('pii_business_glossary_term' = 'Bed Status Event Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_status_event_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Service Request');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Primary Bed Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `unit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `room_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `actual_availability_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Availability Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('pii_business_glossary_term' = 'ADT Event Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('pii_business_glossary_term' = 'Bed Assignment Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('pii_business_glossary_term' = 'Blocked Reason Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `expected_availability_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expected Availability Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_business_glossary_term' = 'Initiating User Role');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_elective_flag` SET TAGS ('pii_business_glossary_term' = 'Is Elective Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_emergency_flag` SET TAGS ('pii_business_glossary_term' = 'Is Emergency Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('pii_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `new_status_code` SET TAGS ('pii_business_glossary_term' = 'New Status Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `prior_status_code` SET TAGS ('pii_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `priority_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_event_code` SET TAGS ('pii_business_glossary_term' = 'Source System Event Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_entity' = 'or_suite');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_subdomain' = 'surgical');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'OR Suite Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_suite_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `building_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `unit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `anesthesia_machine_model` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Machine Model');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('pii_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_power_backup_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Power Backup Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_use_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Use Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `equipment_inventory_list` SET TAGS ('pii_business_glossary_term' = 'Equipment Inventory List');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('pii_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `hvac_air_exchange_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'HVAC Air Exchange Rate Per Hour');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Integration Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `isolation_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('pii_business_glossary_term' = 'Laminar Airflow Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_accreditation_survey_date` SET TAGS ('pii_business_glossary_term' = 'Last Accreditation Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_business_glossary_term' = 'Medical Gas Outlets Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_accreditation_survey_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Accreditation Survey Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_business_glossary_term' = 'OR Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('pii_business_glossary_term' = 'OR Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('pii_business_glossary_term' = 'OR Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `pediatric_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Pediatric Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `positive_pressure_maintained_flag` SET TAGS ('pii_business_glossary_term' = 'Positive Pressure Maintained Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `robotic_surgery_compatible_flag` SET TAGS ('pii_business_glossary_term' = 'Robotic Surgery Compatible Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_height_feet` SET TAGS ('pii_business_glossary_term' = 'Room Height Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_length_feet` SET TAGS ('pii_business_glossary_term' = 'Room Length Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_width_feet` SET TAGS ('pii_business_glossary_term' = 'Room Width Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `scheduled_maintenance_window` SET TAGS ('pii_business_glossary_term' = 'Scheduled Maintenance Window');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_reason_code` SET TAGS ('pii_business_glossary_term' = 'Status Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `surgical_table_type` SET TAGS ('pii_business_glossary_term' = 'Surgical Table Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `video_integration_capability_flag` SET TAGS ('pii_business_glossary_term' = 'Video Integration Capability Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_entity' = 'equipment_asset');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_subdomain' = 'asset_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_entity' = 'maintenance_order');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_subdomain' = 'asset_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_entity' = 'pm_schedule');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_subdomain' = 'asset_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_subdomain' = 'regulatory_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_entity' = 'inspection');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_subdomain' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_subdomain' = 'regulatory_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_entity' = 'inspection_finding');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_subdomain' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_subdomain' = 'regulatory_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_entity' = 'license_accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_subdomain' = 'regulatory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `conditions_of_participation_met` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_entity' = 'space_allocation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_subdomain' = 'space_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_entity' = 'environmental_service_request');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_subdomain' = 'environmental_services');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_entity' = 'capacity_snapshot');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_entity' = 'service');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_subdomain' = 'service_line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `deactivation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `medical_director_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_subdomain' = 'vendor_contracts');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_entity' = 'contract');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_subdomain' = 'vendor_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'PII');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_pattern' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_subdomain' = 'regulatory_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_entity' = 'hazardous_material');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_subdomain' = 'safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `dot_shipping_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_subdomain' = 'regulatory_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_entity' = 'safety_incident');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_subdomain' = 'safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_entity' = 'site_hierarchy');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_subdomain' = 'core');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_subdomain' = 'vendor_contracts');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_association_edges' = 'facility.care_site,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_entity' = 'network_contract');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_subdomain' = 'network');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_subdomain' = 'vendor_contracts');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_association_edges' = 'facility.care_site,quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_entity' = 'facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_subdomain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot_primary' = 'quality.quality_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot_pair' = 'facility.facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_ssot_reference' = 'quality.quality_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `participation_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_association_edges' = 'facility.or_suite,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_entity' = 'block_assignment');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_subdomain' = 'surgical');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_association_edges' = 'facility.equipment_asset,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_entity' = 'equipment_authorization');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_subdomain' = 'asset_management');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_entity' = 'organization');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_subdomain' = 'core');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_id` SET TAGS ('pii_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('pii_business_glossary_term' = 'Parent Organization');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_business_glossary_term' = 'Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_status` SET TAGS ('pii_business_glossary_term' = 'Organization Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_type` SET TAGS ('pii_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
