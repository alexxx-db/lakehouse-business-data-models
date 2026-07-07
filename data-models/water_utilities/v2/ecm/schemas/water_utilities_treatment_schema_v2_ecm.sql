-- Schema for Domain: treatment | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`treatment` COMMENT 'Authoritative domain for all water treatment and purification operations at WTPs and WWTPs. Owns process data for coagulation, filtration, disinfection (UV, chlorination, RO, UF, MF, GAC), CT compliance, chemical dosing, and finished water production. Integrates with SCADA/OSIsoft PI Historian for real-time process control and MOR regulatory submissions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility referenced by each facility record in the treatment domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each facility record in the treatment domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the facility backup operator employee referenced by each facility record in the treatment domain.',
    `facility_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the facility created by employee referenced by each facility record in the treatment domain.',
    `facility_operator_in_charge_employee_id` BIGINT COMMENT 'Unique identifier for the facility operator in charge employee referenced by each facility record in the treatment domain.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the facility service territory referenced by each facility record in the treatment domain.',
    `facility_territory_id` BIGINT COMMENT 'Unique identifier for the facility territory referenced by each facility record in the treatment domain.',
    `treatment_technology_id` BIGINT COMMENT 'Unique identifier for the primary treatment technology referenced by each facility record in the treatment domain.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency referenced by each facility record in the treatment domain.',
    `address` STRING COMMENT 'The address for the facility.',
    `address_city` STRING COMMENT 'The address city of the facility.',
    `address_line` STRING COMMENT 'The address line value recorded for each facility in the treatment domain.',
    `address_line1` STRING COMMENT 'First line of the street address for the facility (address line1).',
    `address_line2` STRING COMMENT 'The address line2 value recorded for each facility in the treatment domain.',
    `address_line_1` STRING COMMENT 'The address line 1 value recorded for each facility in the treatment domain.',
    `address_line_2` STRING COMMENT 'The address line 2 value recorded for each facility in the treatment domain.',
    `address_state` STRING COMMENT 'The address state value recorded for each facility in the treatment domain.',
    `address_zip` STRING COMMENT 'The address zip value recorded for each facility in the treatment domain.',
    `annual_energy_consumption_kwh` DECIMAL(18,2) COMMENT 'The annual energy consumption kwh value recorded for each facility in the treatment domain.',
    `annual_energy_kwh` DECIMAL(18,2) COMMENT 'The annual energy kwh value recorded for each facility in the treatment domain.',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'The annual operating cost usd value recorded for each facility in the treatment domain.',
    `asset_condition_rating` STRING COMMENT 'The asset condition rating value recorded for each facility in the treatment domain.',
    `asset_registry_id` BIGINT COMMENT 'Unique identifier for the asset registry referenced by each facility record in the treatment domain.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The average daily flow mgd value recorded for each facility in the treatment domain.',
    `average_daily_production_mgd` DECIMAL(18,2) COMMENT 'The average daily production mgd value recorded for each facility in the treatment domain.',
    `awia_erp_certification_date` DATE COMMENT 'The awia erp certification date associated with each facility record in the treatment domain.',
    `awia_risk_assessment_date` DATE COMMENT 'The awia risk assessment date associated with each facility record in the treatment domain.',
    `backup_power_available` BOOLEAN COMMENT 'The backup power available value recorded for each facility in the treatment domain.',
    `backup_power_capacity_kw` DECIMAL(18,2) COMMENT 'The backup power capacity kw value recorded for each facility in the treatment domain.',
    `chemical_storage_capacity_tons` DECIMAL(18,2) COMMENT 'The chemical storage capacity tons value recorded for each facility in the treatment domain.',
    `city` STRING COMMENT 'The city component of the address for each facility record.',
    `facility_code` STRING COMMENT 'The facility code value recorded for each facility in the treatment domain.',
    `commission_date` DATE COMMENT 'The commission date associated with each facility record in the treatment domain.',
    `commissioned_date` DATE COMMENT 'The commissioned date associated with each facility record in the treatment domain.',
    `commissioning_date` DATE COMMENT 'The commissioning date associated with each facility record in the treatment domain.',
    `country` STRING COMMENT 'The country component of the address for each facility record.',
    `country_code` STRING COMMENT 'The country code value recorded for each facility in the treatment domain.',
    `county` STRING COMMENT 'The county component of the address for each facility record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each facility record in the treatment domain.',
    `current_avg_flow_mgd` DECIMAL(18,2) COMMENT 'The current avg flow mgd value recorded for each facility in the treatment domain.',
    `current_capacity_mgd` DECIMAL(18,2) COMMENT 'The current capacity mgd value recorded for each facility in the treatment domain.',
    `current_flow_mgd` DECIMAL(18,2) COMMENT 'The current flow mgd value recorded for each facility in the treatment domain.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each facility in the treatment domain.',
    `decommission_date` DATE COMMENT 'The decommission date associated with each facility record in the treatment domain.',
    `decommissioned_date` DATE COMMENT 'The decommissioned date associated with each facility record in the treatment domain.',
    `decommissioning_date` DATE COMMENT 'The decommissioning date associated with each facility record in the treatment domain.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'The design capacity mgd value recorded for each facility in the treatment domain.',
    `disinfection_method` STRING COMMENT 'The disinfection method value recorded for each facility in the treatment domain.',
    `disinfection_type` STRING COMMENT 'The disinfection type value recorded for each facility in the treatment domain.',
    `ecm_mvm_depth_reconciliation_note` STRING COMMENT 'ECM attribute depth reconciled to match or exceed MVM (prior ecm_depth=2, mvm_depth=5). ECM now carries the full backbone attribute set. Ref: OSIsoft PI Historian.',
    `ecological_receptor_present_flag` BOOLEAN COMMENT 'The ecological receptor present flag value recorded for each facility in the treatment domain.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'The elevation ft value recorded for each facility in the treatment domain.',
    `elevation_m` DECIMAL(18,2) COMMENT 'The elevation m value recorded for each facility in the treatment domain.',
    `email_address` STRING COMMENT 'The email address value recorded for each facility in the treatment domain.',
    `emergency_contact_name` STRING COMMENT 'The emergency contact name used to identify each facility record in the treatment domain.',
    `emergency_contact_phone` STRING COMMENT 'The emergency contact phone value recorded for each facility in the treatment domain.',
    `emergency_generator_flag` BOOLEAN COMMENT 'The emergency generator flag value recorded for each facility in the treatment domain.',
    `emergency_response_plan_date` DATE COMMENT 'The emergency response plan date associated with each facility record in the treatment domain.',
    `emergency_storage_days` DECIMAL(18,2) COMMENT 'The emergency storage days value recorded for each facility in the treatment domain.',
    `energy_consumption_kwh_per_ml` DECIMAL(18,2) COMMENT 'The energy consumption kwh per ml value recorded for each facility in the treatment domain.',
    `energy_intensity_kwh_per_mg` DECIMAL(18,2) COMMENT 'The energy intensity kwh per mg value recorded for each facility in the treatment domain.',
    `energy_intensity_kwh_per_ml` DECIMAL(18,2) COMMENT 'The energy intensity kwh per ml value recorded for each facility in the treatment domain.',
    `energy_source` STRING COMMENT 'The energy source value recorded for each facility in the treatment domain.',
    `exposure_pathway_context` STRING COMMENT 'The exposure pathway context value recorded for each facility in the treatment domain.',
    `facility_status` STRING COMMENT 'The facility status value recorded for each facility in the treatment domain.',
    `facility_type` STRING COMMENT 'The facility type value recorded for each facility in the treatment domain.',
    `fluoridation_flag` BOOLEAN COMMENT 'The fluoridation flag value recorded for each facility in the treatment domain.',
    `gac_vessel_count` STRING COMMENT 'The gac vessel count value recorded for each facility in the treatment domain.',
    `has_backup_power` BOOLEAN COMMENT 'Boolean flag indicating whether the has backup power condition applies to the facility record.',
    `human_exposure_pathway_risk` STRING COMMENT 'The human exposure pathway risk value recorded for each facility in the treatment domain.',
    `ion_exchange_train_count` STRING COMMENT 'The ion exchange train count value recorded for each facility in the treatment domain.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the facility record.',
    `is_emergency_backup` BOOLEAN COMMENT 'Boolean flag indicating whether the is emergency backup condition applies to the facility record.',
    `is_emergency_interconnect` BOOLEAN COMMENT 'Boolean flag indicating whether the is emergency interconnect condition applies to the facility record.',
    `is_wholesale_supplier` BOOLEAN COMMENT 'Boolean flag indicating whether the is wholesale supplier condition applies to the facility record.',
    `last_expansion_date` DATE COMMENT 'The last expansion date associated with each facility record in the treatment domain.',
    `last_major_rehab_year` STRING COMMENT 'The last major rehab year value recorded for each facility in the treatment domain.',
    `last_major_upgrade_date` DATE COMMENT 'The last major upgrade date associated with each facility record in the treatment domain.',
    `last_major_upgrade_year` STRING COMMENT 'The last major upgrade year value recorded for each facility in the treatment domain.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the facility location.',
    `lims_facility_code` STRING COMMENT 'The lims facility code value recorded for each facility in the treatment domain.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the facility location.',
    `maximo_location_code` STRING COMMENT 'The maximo location code value recorded for each facility in the treatment domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each facility record in the treatment domain.',
    `multimedia_filter_count` STRING COMMENT 'The multimedia filter count value recorded for each facility in the treatment domain.',
    `facility_name` STRING COMMENT 'The facility name used to identify each facility record in the treatment domain.',
    `notes` STRING COMMENT 'The notes value recorded for each facility in the treatment domain.',
    `npdes_permit_number` STRING COMMENT 'The npdes permit number value recorded for each facility in the treatment domain.',
    `number_of_treatment_trains` STRING COMMENT 'The number of treatment trains value recorded for each facility in the treatment domain.',
    `ontology_class_uri` STRING COMMENT 'The ontology class uri value recorded for each facility in the treatment domain.',
    `operating_authority` STRING COMMENT 'The operating authority value recorded for each facility in the treatment domain.',
    `operating_permit_number` STRING COMMENT 'The operating permit number value recorded for each facility in the treatment domain.',
    `operating_status` STRING COMMENT 'The operating status value recorded for each facility in the treatment domain.',
    `operational_capacity_mgd` DECIMAL(18,2) COMMENT 'The operational capacity mgd value recorded for each facility in the treatment domain.',
    `operational_status` STRING COMMENT 'The operational status value recorded for each facility in the treatment domain.',
    `operator_certification_class` STRING COMMENT 'The operator certification class value recorded for each facility in the treatment domain.',
    `operator_certification_grade_required` STRING COMMENT 'The operator certification grade required value recorded for each facility in the treatment domain.',
    `operator_certification_level` STRING COMMENT 'The operator certification level value recorded for each facility in the treatment domain.',
    `operator_class_required` STRING COMMENT 'The operator class required value recorded for each facility in the treatment domain.',
    `operator_in_charge` DECIMAL(18,2) COMMENT 'The operator in charge value recorded for each facility in the treatment domain.',
    `operator_license_number` STRING COMMENT 'The operator license number value recorded for each facility in the treatment domain.',
    `operator_name` STRING COMMENT 'The operator name used to identify each facility record in the treatment domain.',
    `operator_organization` STRING COMMENT 'The operator organization value recorded for each facility in the treatment domain.',
    `owner_entity` STRING COMMENT 'The owner entity value recorded for each facility in the treatment domain.',
    `owner_organization` STRING COMMENT 'The owner organization value recorded for each facility in the treatment domain.',
    `ownership_type` STRING COMMENT 'The ownership type value recorded for each facility in the treatment domain.',
    `peak_capacity_mgd` DECIMAL(18,2) COMMENT 'The peak capacity mgd value recorded for each facility in the treatment domain.',
    `peak_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The peak daily flow mgd value recorded for each facility in the treatment domain.',
    `peak_design_flow_mgd` DECIMAL(18,2) COMMENT 'The peak design flow mgd value recorded for each facility in the treatment domain.',
    `permit_expiration_date` DATE COMMENT 'The permit expiration date associated with each facility record in the treatment domain.',
    `permit_number` STRING COMMENT 'The permit number value recorded for each facility in the treatment domain.',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'The permitted capacity mgd value recorded for each facility in the treatment domain.',
    `pfas_treatment_capable_flag` BOOLEAN COMMENT 'The pfas treatment capable flag value recorded for each facility in the treatment domain.',
    `phone_number` STRING COMMENT 'The phone number value recorded for each facility in the treatment domain.',
    `pi_server_name` STRING COMMENT 'The pi server name used to identify each facility record in the treatment domain.',
    `population_served` STRING COMMENT 'The population served value recorded for each facility in the treatment domain.',
    `postal_code` STRING COMMENT 'The postal code component of the address for each facility record.',
    `primacy_agency_code` STRING COMMENT 'The primacy agency code value recorded for each facility in the treatment domain.',
    `primary_disinfection_method` STRING COMMENT 'The primary disinfection method value recorded for each facility in the treatment domain.',
    `primary_source_type` STRING COMMENT 'The primary source type value recorded for each facility in the treatment domain.',
    `primary_source_water_type` STRING COMMENT 'The primary source water type value recorded for each facility in the treatment domain.',
    `primary_treatment_process` STRING COMMENT 'The primary treatment process value recorded for each facility in the treatment domain.',
    `pwsid` STRING COMMENT 'The pwsid value recorded for each facility in the treatment domain.',
    `rated_capacity_mgd` DECIMAL(18,2) COMMENT 'The rated capacity mgd value recorded for each facility in the treatment domain.',
    `record_status` STRING COMMENT 'The record status value recorded for each facility in the treatment domain.',
    `region_code` STRING COMMENT 'The region code value recorded for each facility in the treatment domain.',
    `regulatory_region` STRING COMMENT 'The regulatory region value recorded for each facility in the treatment domain.',
    `regulatory_standard_layer` STRING COMMENT 'The regulatory standard layer value recorded for each facility in the treatment domain.',
    `residuals_handling_method` STRING COMMENT 'The residuals handling method value recorded for each facility in the treatment domain.',
    `risk_resilience_assessment_date` DATE COMMENT 'The risk resilience assessment date associated with each facility record in the treatment domain.',
    `scada_system_code` STRING COMMENT 'The scada system code value recorded for each facility in the treatment domain.',
    `scada_system_name` STRING COMMENT 'The scada system name used to identify each facility record in the treatment domain.',
    `scada_system_type` STRING COMMENT 'The scada system type value recorded for each facility in the treatment domain.',
    `secondary_treatment_process` STRING COMMENT 'The secondary treatment process value recorded for each facility in the treatment domain.',
    `service_area_population` STRING COMMENT 'The service area population value recorded for each facility in the treatment domain.',
    `service_connections_count` STRING COMMENT 'The service connections count value recorded for each facility in the treatment domain.',
    `service_population` BIGINT COMMENT 'The service population value recorded for each facility in the treatment domain.',
    `site_area_acres` DECIMAL(18,2) COMMENT 'The site area acres value recorded for each facility in the treatment domain.',
    `source_water_type` STRING COMMENT 'The source water type value recorded for each facility in the treatment domain.',
    `state_code` STRING COMMENT 'The state code value recorded for each facility in the treatment domain.',
    `state_primacy_agency` STRING COMMENT 'The state primacy agency value recorded for each facility in the treatment domain.',
    `state_province` STRING COMMENT 'The state province value recorded for each facility in the treatment domain.',
    `street_address` STRING COMMENT 'The street address value recorded for each facility in the treatment domain.',
    `treatment_capacity_mgd` DECIMAL(18,2) COMMENT 'The treatment capacity mgd value recorded for each facility in the treatment domain.',
    `treatment_class` STRING COMMENT 'The treatment class value recorded for each facility in the treatment domain.',
    `treatment_permit_id` BIGINT COMMENT 'Unique identifier for the treatment permit referenced by each facility record in the treatment domain.',
    `treatment_process_type` STRING COMMENT 'The treatment process type value recorded for each facility in the treatment domain.',
    `treatment_technology` STRING COMMENT 'The treatment technology value recorded for each facility in the treatment domain.',
    `treatment_technology_primary` STRING COMMENT 'The treatment technology primary value recorded for each facility in the treatment domain.',
    `treatment_technology_type` STRING COMMENT 'The treatment technology type value recorded for each facility in the treatment domain.',
    `treatment_type` STRING COMMENT 'The treatment type value recorded for each facility in the treatment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each facility record in the treatment domain.',
    `year_built` STRING COMMENT 'The year built value recorded for each facility in the treatment domain.',
    `year_constructed` STRING COMMENT 'The year constructed value recorded for each facility in the treatment domain.',
    `zip_code` STRING COMMENT 'The zip code value recorded for each facility in the treatment domain.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Water treatment plant or facility master record. Stores facility-level attributes including design capacity, treatment technology, regulatory identifiers (PWSID), SCADA integration points, operator certification requirements, and AWIA risk assessment dates. Central entity for treatment operations, compliance reporting (MOR/DMR), and asset management integration (Maximo location). References EPA SDWA, AWIA Section 2013.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` (
    `process_unit_id` BIGINT COMMENT 'Unique identifier for the process unit. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each process unit record in the treatment domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each process unit record in the treatment domain.',
    `facility_id` BIGINT COMMENT 'Parent treatment facility. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master referenced by each process unit record in the treatment domain.',
    `asset_tag` STRING COMMENT 'The asset tag value recorded for each process unit in the treatment domain.',
    `baffling_factor` DECIMAL(18,2) COMMENT 'Baffling factor for CT calculations. Ref: OSIsoft PI Historian.',
    `bed_volumes_treated` DECIMAL(18,2) COMMENT 'The bed volumes treated value recorded for each process unit in the treatment domain.',
    `capacity_rating` DECIMAL(18,2) COMMENT 'The capacity rating value recorded for each process unit in the treatment domain.',
    `capacity_units` STRING COMMENT 'The capacity units value recorded for each process unit in the treatment domain.',
    `process_unit_code` STRING COMMENT 'The process unit code value recorded for each process unit in the treatment domain.',
    `commission_date` DATE COMMENT 'The commission date associated with each process unit record in the treatment domain.',
    `commissioned_date` DATE COMMENT 'The commissioned date associated with each process unit record in the treatment domain.',
    `commissioning_date` DATE COMMENT 'The commissioning date associated with each process unit record in the treatment domain.',
    `condition_rating` STRING COMMENT 'The condition rating value recorded for each process unit in the treatment domain.',
    `condition_score` DECIMAL(18,2) COMMENT 'The condition score value recorded for each process unit in the treatment domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: OSIsoft PI Historian.',
    `criticality_score` DECIMAL(18,2) COMMENT 'The criticality score value recorded for each process unit in the treatment domain.',
    `cumulative_volume_treated_mg` DECIMAL(18,2) COMMENT 'The cumulative volume treated mg value recorded for each process unit in the treatment domain.',
    `decommission_date` DATE COMMENT 'The decommission date associated with each process unit record in the treatment domain.',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Design capacity in gallons per minute. Ref: OSIsoft PI Historian.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'The design capacity mgd value recorded for each process unit in the treatment domain.',
    `design_detention_time_min` DECIMAL(18,2) COMMENT 'The design detention time min value recorded for each process unit in the treatment domain.',
    `design_flow_mgd` DECIMAL(18,2) COMMENT 'The design flow mgd value recorded for each process unit in the treatment domain.',
    `design_flow_rate_mgd` DECIMAL(18,2) COMMENT 'The design flow rate mgd value recorded for each process unit in the treatment domain.',
    `design_log_removal_credit` DECIMAL(18,2) COMMENT 'The design log removal credit value recorded for each process unit in the treatment domain.',
    `detention_time_minutes` DECIMAL(18,2) COMMENT 'Theoretical detention time in minutes. Ref: OSIsoft PI Historian.',
    `energy_consumption_kwh_per_mg` DECIMAL(18,2) COMMENT 'The energy consumption kwh per mg value recorded for each process unit in the treatment domain.',
    `expected_useful_life_years` STRING COMMENT 'The expected useful life years value recorded for each process unit in the treatment domain.',
    `gac_media_type` STRING COMMENT 'The gac media type value recorded for each process unit in the treatment domain.',
    `hydraulic_loading_rate_gpm_sqft` DECIMAL(18,2) COMMENT 'Hydraulic loading rate in GPM per square foot. Ref: OSIsoft PI Historian.',
    `hydraulic_retention_time_min` DECIMAL(18,2) COMMENT 'The hydraulic retention time min value recorded for each process unit in the treatment domain.',
    `in_service_flag` BOOLEAN COMMENT 'The in service flag value recorded for each process unit in the treatment domain.',
    `install_date` DATE COMMENT 'The install date associated with each process unit record in the treatment domain.',
    `installation_date` DATE COMMENT 'Date unit was installed. Ref: OSIsoft PI Historian.',
    `installed_date` DATE COMMENT 'The installed date associated with each process unit record in the treatment domain.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the process unit record.',
    `is_online` BOOLEAN COMMENT 'Boolean flag indicating whether the is online condition applies to the process unit record.',
    `is_redundant` BOOLEAN COMMENT 'Boolean flag indicating whether the is redundant condition applies to the process unit record.',
    `is_redundant_unit` BOOLEAN COMMENT 'Boolean flag indicating whether the is redundant unit condition applies to the process unit record.',
    `is_standby` BOOLEAN COMMENT 'Boolean flag indicating whether the is standby condition applies to the process unit record.',
    `ix_resin_type` STRING COMMENT 'The ix resin type value recorded for each process unit in the treatment domain.',
    `last_backwash_date` DATE COMMENT 'The last backwash date associated with each process unit record in the treatment domain.',
    `last_inspection_date` DATE COMMENT 'The last inspection date associated with each process unit record in the treatment domain.',
    `last_maintenance_date` DATE COMMENT 'The last maintenance date associated with each process unit record in the treatment domain.',
    `last_rehabilitation_date` DATE COMMENT 'The last rehabilitation date associated with each process unit record in the treatment domain.',
    `location_description` STRING COMMENT 'The location description value recorded for each process unit in the treatment domain.',
    `maintenance_zone` STRING COMMENT 'The maintenance zone value recorded for each process unit in the treatment domain.',
    `manufacturer` STRING COMMENT 'The manufacturer value recorded for each process unit in the treatment domain.',
    `maximo_asset_number` STRING COMMENT 'IBM Maximo asset number.',
    `media_depth_inches` DECIMAL(18,2) COMMENT 'The media depth inches value recorded for each process unit in the treatment domain.',
    `media_depth_m` DECIMAL(18,2) COMMENT 'The media depth m value recorded for each process unit in the treatment domain.',
    `media_type` STRING COMMENT 'Filter media type if applicable. Ref: OSIsoft PI Historian.',
    `membrane_type` STRING COMMENT 'The membrane type value recorded for each process unit in the treatment domain.',
    `model_number` STRING COMMENT 'The model number value recorded for each process unit in the treatment domain.',
    `process_unit_name` STRING COMMENT 'The process unit name used to identify each process unit record in the treatment domain.',
    `next_inspection_date` DATE COMMENT 'The next inspection date associated with each process unit record in the treatment domain.',
    `notes` STRING COMMENT 'The notes value recorded for each process unit in the treatment domain.',
    `ontology_concept_code` STRING COMMENT 'The ontology concept code value recorded for each process unit in the treatment domain.',
    `operational_status` STRING COMMENT 'Current operational status. Ref: OSIsoft PI Historian.',
    `pfas_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'The pfas removal efficiency pct value recorded for each process unit in the treatment domain.',
    `pi_element_path` STRING COMMENT 'The pi element path value recorded for each process unit in the treatment domain.',
    `pi_tag_prefix` STRING COMMENT 'The pi tag prefix value recorded for each process unit in the treatment domain.',
    `process_stage` STRING COMMENT 'The process stage value recorded for each process unit in the treatment domain.',
    `process_stage_order` STRING COMMENT 'The process stage order value recorded for each process unit in the treatment domain.',
    `process_type` STRING COMMENT 'The process type value recorded for each process unit in the treatment domain.',
    `process_unit_status` STRING COMMENT 'The process unit status value recorded for each process unit in the treatment domain.',
    `process_unit_type` STRING COMMENT 'The process unit type value recorded for each process unit in the treatment domain.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'The rated capacity value recorded for each process unit in the treatment domain.',
    `rated_capacity_mgd` DECIMAL(18,2) COMMENT 'The rated capacity mgd value recorded for each process unit in the treatment domain.',
    `rated_flow_rate_mgd` DECIMAL(18,2) COMMENT 'The rated flow rate mgd value recorded for each process unit in the treatment domain.',
    `record_status` STRING COMMENT 'The record status value recorded for each process unit in the treatment domain.',
    `redundancy_level` STRING COMMENT 'The redundancy level value recorded for each process unit in the treatment domain.',
    `regulatory_unit_code` STRING COMMENT 'The regulatory unit code value recorded for each process unit in the treatment domain.',
    `scada_system_code` STRING COMMENT 'The scada system code value recorded for each process unit in the treatment domain.',
    `scada_tag_prefix` STRING COMMENT 'The scada tag prefix value recorded for each process unit in the treatment domain.',
    `serial_number` STRING COMMENT 'The serial number value recorded for each process unit in the treatment domain.',
    `surface_area_sqft` DECIMAL(18,2) COMMENT 'Surface area in square feet. Ref: OSIsoft PI Historian.',
    `technology_category` STRING COMMENT 'The technology category value recorded for each process unit in the treatment domain.',
    `treatment_stage` STRING COMMENT 'The treatment stage value recorded for each process unit in the treatment domain.',
    `treatment_technology` STRING COMMENT 'Treatment technology employed by unit. Ref: OSIsoft PI Historian.',
    `treatment_technology_code` STRING COMMENT 'The treatment technology code value recorded for each process unit in the treatment domain.',
    `treatment_technology_type` STRING COMMENT 'The treatment technology type value recorded for each process unit in the treatment domain.',
    `treatment_train_number` STRING COMMENT 'The treatment train number value recorded for each process unit in the treatment domain.',
    `unit_code` STRING COMMENT 'The unit code value recorded for each process unit in the treatment domain.',
    `unit_name` STRING COMMENT 'Name of the process unit. Ref: OSIsoft PI Historian.',
    `unit_number` STRING COMMENT 'The unit number value recorded for each process unit in the treatment domain.',
    `unit_type` STRING COMMENT 'Type of process unit (filter, clarifier, etc.). Ref: OSIsoft PI Historian.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: OSIsoft PI Historian.',
    `uv_lamp_count` STRING COMMENT 'The uv lamp count value recorded for each process unit in the treatment domain.',
    `vendor` STRING COMMENT 'The vendor value recorded for each process unit in the treatment domain.',
    `vendor_name` STRING COMMENT 'The vendor name used to identify each process unit record in the treatment domain.',
    `volume_gallons` DECIMAL(18,2) COMMENT 'The volume gallons value recorded for each process unit in the treatment domain.',
    `volume_mg` DECIMAL(18,2) COMMENT 'The volume mg value recorded for each process unit in the treatment domain.',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Individual treatment process unit within a facility (filter, clarifier, membrane train, UV reactor, contact basin). Stores unit-specific design parameters (capacity, media type, surface area, hydraulic loading rate, detention time, baffling factor), operational status, and asset identifiers (Maximo asset number). Used for process control, performance monitoring, and maintenance scheduling.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` (
    `process_reading_id` BIGINT COMMENT 'Unique identifier for the process reading. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each process reading record in the treatment domain.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `installation_id` BIGINT COMMENT 'Unique identifier for the meter installation referenced by each process reading record in the treatment domain.',
    `online_instrument_id` BIGINT COMMENT 'Unique identifier for the online instrument referenced by each process reading record in the treatment domain.',
    `process_unit_id` BIGINT COMMENT 'Process unit generating the reading. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the process employee referenced by each process reading record in the treatment domain.',
    `process_operator_employee_id` BIGINT COMMENT 'Operator who recorded or verified reading. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each process reading record in the treatment domain.',
    `scada_tag_id` BIGINT COMMENT 'SCADA tag source. Ref: OSIsoft PI Historian.',
    `shift_assignment_id` BIGINT COMMENT 'Unique identifier for the shift assignment referenced by each process reading record in the treatment domain.',
    `alarm_state` STRING COMMENT 'Alarm state if applicable. Ref: OSIsoft PI Historian.',
    `batch_number` STRING COMMENT 'The batch number value recorded for each process reading in the treatment domain.',
    `calibration_due_date` DATE COMMENT 'The calibration due date associated with each process reading record in the treatment domain.',
    `compression_applied` BOOLEAN COMMENT 'The compression applied value recorded for each process reading in the treatment domain.',
    `ct_required` DOUBLE COMMENT 'The ct required value recorded for each process reading in the treatment domain.',
    `ct_value` DOUBLE COMMENT 'The ct value value recorded for each process reading in the treatment domain.',
    `dmr_reporting_flag` BOOLEAN COMMENT 'The dmr reporting flag value recorded for each process reading in the treatment domain.',
    `engineering_unit` STRING COMMENT 'Unit of measure. Ref: OSIsoft PI Historian.',
    `high_range_limit` DOUBLE COMMENT 'The high range limit value recorded for each process reading in the treatment domain.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The ingestion timestamp associated with each process reading record in the treatment domain.',
    `is_manual_entry` BOOLEAN COMMENT 'Indicates if reading was manually entered. Ref: OSIsoft PI Historian.',
    `is_regulatory_exceedance` BOOLEAN COMMENT 'Boolean flag indicating whether the is regulatory exceedance condition applies to the process reading record.',
    `last_calibration_date` DATE COMMENT 'The last calibration date associated with each process reading record in the treatment domain.',
    `location_description` STRING COMMENT 'The location description value recorded for each process reading in the treatment domain.',
    `low_range_limit` DOUBLE COMMENT 'The low range limit value recorded for each process reading in the treatment domain.',
    `measured_value` DOUBLE COMMENT 'Measured value. Ref: OSIsoft PI Historian.',
    `mor_reporting_flag` BOOLEAN COMMENT 'Indicates if reading is included in MOR. Ref: OSIsoft PI Historian.',
    `ontology_class_uri` STRING COMMENT 'The ontology class uri value recorded for each process reading in the treatment domain.',
    `parameter_type` STRING COMMENT 'Type of parameter measured. Ref: OSIsoft PI Historian.',
    `pi_server_name` STRING COMMENT 'The pi server name used to identify each process reading record in the treatment domain.',
    `process_stage` STRING COMMENT 'The process stage value recorded for each process reading in the treatment domain.',
    `quality_flag` BOOLEAN COMMENT 'Data quality flag. Ref: OSIsoft PI Historian.',
    `raw_value` DOUBLE COMMENT 'The raw value value recorded for each process reading in the treatment domain.',
    `reading_date` DATE COMMENT 'The reading date associated with each process reading record in the treatment domain.',
    `reading_status` STRING COMMENT 'The reading status value recorded for each process reading in the treatment domain.',
    `reading_timestamp` TIMESTAMP COMMENT 'Timestamp of the reading. Ref: OSIsoft PI Historian.',
    `regulatory_limit_type` STRING COMMENT 'The regulatory limit type value recorded for each process reading in the treatment domain.',
    `regulatory_limit_value` DOUBLE COMMENT 'The regulatory limit value value recorded for each process reading in the treatment domain.',
    `sample_interval_seconds` STRING COMMENT 'The sample interval seconds value recorded for each process reading in the treatment domain.',
    `scada_system_code` BIGINT COMMENT 'The scada system code value recorded for each process reading in the treatment domain.',
    `source_tag_name` STRING COMMENT 'The source tag name used to identify each process reading record in the treatment domain.',
    `substitution_reason` STRING COMMENT 'The substitution reason value recorded for each process reading in the treatment domain.',
    `treatment_process_type` STRING COMMENT 'The treatment process type value recorded for each process reading in the treatment domain.',
    `validated_timestamp` TIMESTAMP COMMENT 'The validated timestamp associated with each process reading record in the treatment domain.',
    CONSTRAINT pk_process_reading PRIMARY KEY(`process_reading_id`)
) COMMENT 'Time-series operational reading from a treatment process unit or instrument. Captures measured values (flow, pressure, chemical residual, turbidity, pH, temperature), quality flags, alarm states, CT calculations, and regulatory compliance indicators. Sourced from SCADA/PI Historian or manual operator entry. Used for MOR/DMR reporting, process optimization, and compliance verification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` (
    `chemical_dose_event_id` BIGINT COMMENT 'Unique identifier for the dose event. Ref: OSIsoft PI Historian.',
    `chemical_id` BIGINT COMMENT 'Chemical dosed. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Operator who initiated or verified dose. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Process unit where chemical was dosed. Ref: OSIsoft PI Historian.',
    `chemical_mass_applied_kg` DECIMAL(18,2) COMMENT 'Total chemical mass applied in kg. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: OSIsoft PI Historian.',
    `ct_compliance_flag` BOOLEAN COMMENT 'Indicates if CT compliance was achieved. Ref: OSIsoft PI Historian.',
    `dose_end_timestamp` TIMESTAMP COMMENT 'Dose event end timestamp. Ref: OSIsoft PI Historian.',
    `dose_rate_mg_per_l` DECIMAL(18,2) COMMENT 'Chemical dose rate in mg/L. Ref: OSIsoft PI Historian.',
    `dose_start_timestamp` TIMESTAMP COMMENT 'Dose event start timestamp. Ref: OSIsoft PI Historian.',
    `post_dose_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Measured residual after dosing in mg/L. Ref: OSIsoft PI Historian.',
    `target_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Target chemical residual in mg/L. Ref: OSIsoft PI Historian.',
    `water_flow_rate_mgd` DECIMAL(18,2) COMMENT 'Water flow rate during dosing in MGD. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_chemical_dose_event PRIMARY KEY(`chemical_dose_event_id`)
) COMMENT 'Chemical dosing event record capturing coagulant, disinfectant, pH adjustment, or other chemical application. Stores dose rate, mass applied, concentration, CT compliance, DBP formation risk, pump flow rate, target residual, and cost. Links to chemical inventory, process unit, operator, and water quality parameters. Used for regulatory reporting, cost allocation, and process control.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` (
    `ct_compliance_record_id` BIGINT COMMENT 'Unique identifier for CT compliance record. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `mor_submission_id` BIGINT COMMENT 'Associated MOR submission. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Contact basin or process unit. Ref: OSIsoft PI Historian.',
    `baffling_factor` DECIMAL(18,2) COMMENT 'Baffling factor applied. Ref: OSIsoft PI Historian.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp of CT calculation. Ref: OSIsoft PI Historian.',
    `compliance_status` STRING COMMENT 'Compliance status (compliant, non-compliant). Ref: OSIsoft PI Historian.',
    `contact_time_min` DECIMAL(18,2) COMMENT 'Contact time in minutes. Ref: OSIsoft PI Historian.',
    `ct_calculated` DECIMAL(18,2) COMMENT 'Calculated CT value. Ref: OSIsoft PI Historian.',
    `ct_ratio` DECIMAL(18,2) COMMENT 'Ratio of calculated to required CT. Ref: OSIsoft PI Historian.',
    `ct_required` DECIMAL(18,2) COMMENT 'Required CT value from EPA tables. Ref: OSIsoft PI Historian.',
    `disinfectant_concentration` DECIMAL(18,2) COMMENT 'Disinfectant concentration in mg/L. Ref: OSIsoft PI Historian.',
    `disinfectant_type` STRING COMMENT 'Type of disinfectant (chlorine, chloramine, etc.). Ref: OSIsoft PI Historian.',
    `log_inactivation_achieved` DECIMAL(18,2) COMMENT 'Log inactivation credit achieved. Ref: OSIsoft PI Historian.',
    `operator_verified` BOOLEAN COMMENT 'Indicates if operator verified calculation. Ref: OSIsoft PI Historian.',
    `ph_value` DECIMAL(18,2) COMMENT 'Water pH during CT calculation. Ref: OSIsoft PI Historian.',
    `target_organism` STRING COMMENT 'Target pathogen (Giardia, Cryptosporidium, virus). Ref: OSIsoft PI Historian.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Water temperature in Celsius. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_ct_compliance_record PRIMARY KEY(`ct_compliance_record_id`)
) COMMENT 'Contact time (CT) disinfection compliance record per EPA SWTR/LT2ESWTR. Calculates CT value (disinfectant concentration × contact time), compares to required CT from EPA tables based on pH, temperature, target organism (Giardia, Cryptosporidium, virus), and verifies log inactivation credit. Includes baffling factor, T10 basis, and operator verification. Used for MOR reporting and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` (
    `filter_run_id` BIGINT COMMENT 'Unique identifier for filter run. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `filter_unit_id` BIGINT COMMENT 'Filter unit. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Operator on duty. Ref: OSIsoft PI Historian.',
    `backwash_trigger_reason` STRING COMMENT 'Reason for backwash (headloss, turbidity, time). Ref: OSIsoft PI Historian.',
    `filter_to_waste_flag` BOOLEAN COMMENT 'Indicates if filter-to-waste was used. Ref: OSIsoft PI Historian.',
    `filter_to_waste_volume_mg` DECIMAL(18,2) COMMENT 'Filter-to-waste volume in MG. Ref: OSIsoft PI Historian.',
    `influent_turbidity_ntu` DECIMAL(18,2) COMMENT 'Average influent turbidity in NTU. Ref: OSIsoft PI Historian.',
    `initial_head_loss_ft` DECIMAL(18,2) COMMENT 'Initial head loss in feet. Ref: OSIsoft PI Historian.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if run met regulatory requirements. Ref: OSIsoft PI Historian.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Run duration in hours. Ref: OSIsoft PI Historian.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Filter run end timestamp. Ref: OSIsoft PI Historian.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Filter run start timestamp. Ref: OSIsoft PI Historian.',
    `terminal_effluent_turbidity_ntu` DECIMAL(18,2) COMMENT 'Terminal effluent turbidity in NTU. Ref: OSIsoft PI Historian.',
    `terminal_head_loss_ft` DECIMAL(18,2) COMMENT 'Terminal head loss in feet. Ref: OSIsoft PI Historian.',
    `volume_filtered_mg` DECIMAL(18,2) COMMENT 'Total volume filtered in million gallons. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_filter_run PRIMARY KEY(`filter_run_id`)
) COMMENT 'Filtration run record from start to backwash. Tracks run duration, volume filtered, influent/effluent turbidity, head loss progression, hydraulic loading rate, filter-to-waste volume, and backwash trigger reason. Used for turbidity compliance (0.3 NTU 95% / 1.0 NTU max per SWTR), filter performance optimization, and backwash scheduling. Links to filter unit, backwash event, and MOR submission.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` (
    `backwash_event_id` BIGINT COMMENT 'Unique identifier for backwash event. Ref: OSIsoft PI Historian.',
    `discharge_point_id` BIGINT COMMENT 'Foreign key linking to treatment.discharge_point. Business justification: Backwash wastewater is routed to a designated discharge_point (the description explicitly names backwash discharge point). Capturing which discharge_point received the backwash volume supports permi. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `filter_run_id` BIGINT COMMENT 'Foreign key linking to treatment.filter_run. Business justification: A filter_run terminates in a backwash_event; capturing the run that a backwash concluded links terminal head loss / turbidity breakthrough to the resulting backwash cycle for run-length optimization.. Ref: OSIsoft PI Historian.',
    `filter_unit_id` BIGINT COMMENT 'Filter unit backwashed. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Operator who initiated backwash. Ref: OSIsoft PI Historian.',
    `air_scour_duration_minutes` DECIMAL(18,2) COMMENT 'Air scour duration in minutes. Ref: OSIsoft PI Historian.',
    `air_scour_used` BOOLEAN COMMENT 'Indicates if air scour was used. Ref: OSIsoft PI Historian.',
    `backwash_end_timestamp` TIMESTAMP COMMENT 'Backwash end timestamp. Ref: OSIsoft PI Historian.',
    `backwash_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Backwash flow rate in GPM. Ref: OSIsoft PI Historian.',
    `backwash_start_timestamp` TIMESTAMP COMMENT 'Backwash start timestamp. Ref: OSIsoft PI Historian.',
    `backwash_water_volume_gal` DECIMAL(18,2) COMMENT 'Backwash water volume in gallons. Ref: OSIsoft PI Historian.',
    `chemical_aid_used` BOOLEAN COMMENT 'Indicates if chemical aid was used. Ref: OSIsoft PI Historian.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Backwash duration in minutes. Ref: OSIsoft PI Historian.',
    `filter_to_waste_used` BOOLEAN COMMENT 'Indicates if filter-to-waste was used. Ref: OSIsoft PI Historian.',
    `post_backwash_headloss_ft` DECIMAL(18,2) COMMENT 'Head loss after backwash in feet. Ref: OSIsoft PI Historian.',
    `pre_backwash_headloss_ft` DECIMAL(18,2) COMMENT 'Head loss before backwash in feet. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_backwash_event PRIMARY KEY(`backwash_event_id`)
) COMMENT 'Filter backwash event record. Captures backwash start/end timestamps, duration, flow rate, water volume, air scour usage, chemical aid dosing, media expansion, pre/post headloss, pre/post turbidity, filter-to-waste volume, and trigger reason (headloss, turbidity, time, manual). Used for water loss accounting, chemical inventory, energy consumption, and filter performance analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` (
    `finished_water_production_id` BIGINT COMMENT 'Unique identifier for production record. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `mor_submission_id` BIGINT COMMENT 'Associated MOR submission. Ref: OSIsoft PI Historian.',
    `avg_production_rate_gpm` DECIMAL(18,2) COMMENT 'Average production rate in GPM. Ref: OSIsoft PI Historian.',
    `backwash_volume_mg` DECIMAL(18,2) COMMENT 'Backwash water volume in MG. Ref: OSIsoft PI Historian.',
    `cl2_residual_avg_mg_l` DECIMAL(18,2) COMMENT 'Average chlorine residual in mg/L. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'The data quality flag value recorded for each finished water production in the treatment domain.',
    `filter_to_waste_volume_mg` DECIMAL(18,2) COMMENT 'Filter-to-waste volume in MG. Ref: OSIsoft PI Historian.',
    `finished_water_volume_mg` DECIMAL(18,2) COMMENT 'Finished water volume in MG. Ref: OSIsoft PI Historian.',
    `peak_production_rate_gpm` DECIMAL(18,2) COMMENT 'Peak production rate in GPM. Ref: OSIsoft PI Historian.',
    `ph_avg` DECIMAL(18,2) COMMENT 'Average pH. Ref: OSIsoft PI Historian.',
    `plant_efficiency_ratio` DECIMAL(18,2) COMMENT 'Plant efficiency ratio (finished / source). Ref: OSIsoft PI Historian.',
    `production_date` DATE COMMENT 'Date of production. Ref: OSIsoft PI Historian.',
    `source_water_volume_mg` DECIMAL(18,2) COMMENT 'Source water intake volume in MG. Ref: OSIsoft PI Historian.',
    `turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Average finished water turbidity in NTU. Ref: OSIsoft PI Historian.',
    `turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Maximum finished water turbidity in NTU. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_finished_water_production PRIMARY KEY(`finished_water_production_id`)
) COMMENT 'Daily or shift-level finished water production summary. Aggregates total volume produced, source water intake, backwash/filter-to-waste losses, plant efficiency ratio, average/peak production rates, and key water quality parameters (turbidity, chlorine residual, pH, fluoride, TOC). Used for MOR reporting, water audit (AWWA M36), capacity planning, and regulatory compliance verification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` (
    `source_water_intake_id` BIGINT COMMENT 'Unique identifier for intake event. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `water_source_id` BIGINT COMMENT 'Source water body or well. Ref: OSIsoft PI Historian.',
    `conductivity_us_per_cm` DECIMAL(18,2) COMMENT 'Conductivity in µS/cm. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'The data quality flag value recorded for each source water intake in the treatment domain.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Intake flow rate in GPM. Ref: OSIsoft PI Historian.',
    `intake_timestamp` TIMESTAMP COMMENT 'Timestamp of intake event. Ref: OSIsoft PI Historian.',
    `permit_compliance_status` STRING COMMENT 'Withdrawal permit compliance status. Ref: OSIsoft PI Historian.',
    `ph_level` DECIMAL(18,2) COMMENT 'Raw water pH. Ref: OSIsoft PI Historian.',
    `source_type` STRING COMMENT 'Source type (surface, groundwater). Ref: OSIsoft PI Historian.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Raw water temperature in Celsius. Ref: OSIsoft PI Historian.',
    `toc_mg_per_l` DECIMAL(18,2) COMMENT 'Total organic carbon in mg/L. Ref: OSIsoft PI Historian.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Raw water turbidity in NTU. Ref: OSIsoft PI Historian.',
    `volume_withdrawn_mg` DECIMAL(18,2) COMMENT 'Volume withdrawn in MG. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_source_water_intake PRIMARY KEY(`source_water_intake_id`)
) COMMENT 'Source water withdrawal event or reading. Captures volume withdrawn, flow rate, raw water quality (turbidity, TOC, pH, temperature, conductivity, dissolved oxygen, algae count), intake method, pump station status, permit compliance, and upstream event alerts. Used for source water protection, treatment process adjustment, and withdrawal permit compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` (
    `membrane_performance_id` BIGINT COMMENT 'Unique identifier for membrane performance record. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: A membrane_performance record (TMP, permeate flow, recovery, LRV) is measured on a SPECIFIC membrane train, which is modeled as a treatment process_unit (unit_type = membrane train). Currently membran. Ref: OSIsoft PI Historian.',
    `backwash_frequency_per_day` DECIMAL(18,2) COMMENT 'Backwash frequency per day. Ref: OSIsoft PI Historian.',
    `chemical_cleaning_count` STRING COMMENT 'Number of chemical cleanings performed. Ref: OSIsoft PI Historian.',
    `feed_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Feed flow rate in GPM. Ref: OSIsoft PI Historian.',
    `feed_turbidity_ntu` DECIMAL(18,2) COMMENT 'Feed water turbidity in NTU. Ref: OSIsoft PI Historian.',
    `integrity_test_result` STRING COMMENT 'Integrity test result (pass/fail). Ref: OSIsoft PI Historian.',
    `log_removal_value` DECIMAL(18,2) COMMENT 'Log removal credit. Ref: OSIsoft PI Historian.',
    `observation_timestamp` TIMESTAMP COMMENT 'Timestamp of observation. Ref: OSIsoft PI Historian.',
    `permeate_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Permeate flow rate in GPM. Ref: OSIsoft PI Historian.',
    `permeate_turbidity_ntu` DECIMAL(18,2) COMMENT 'Permeate turbidity in NTU. Ref: OSIsoft PI Historian.',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Recovery rate percentage. Ref: OSIsoft PI Historian.',
    `transmembrane_pressure_psi` DECIMAL(18,2) COMMENT 'TMP in PSI. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_membrane_performance PRIMARY KEY(`membrane_performance_id`)
) COMMENT 'Membrane filtration (MF/UF/NF/RO) performance record. Tracks transmembrane pressure (TMP), permeate flux, feed/permeate/concentrate quality (turbidity, TDS), recovery rate, salt rejection, fouling index, backwash frequency, chemical cleaning count, integrity test results, log removal credit, and specific energy consumption. Used for membrane life prediction, cleaning optimization, and regulatory compliance (LT2ESWTR).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` (
    `uv_disinfection_event_id` BIGINT COMMENT 'Unique identifier for UV event. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'UV reactor unit. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'The data quality flag value recorded for each uv disinfection event in the treatment domain.',
    `dose_compliance_flag` BOOLEAN COMMENT 'Indicates if dose requirement was met. Ref: OSIsoft PI Historian.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of UV event. Ref: OSIsoft PI Historian.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Flow rate in MGD. Ref: OSIsoft PI Historian.',
    `lamp_hours_elapsed` DECIMAL(18,2) COMMENT 'Lamp hours elapsed. Ref: OSIsoft PI Historian.',
    `lamp_status` STRING COMMENT 'Lamp operational status. Ref: OSIsoft PI Historian.',
    `target_pathogen` STRING COMMENT 'Target pathogen for inactivation. Ref: OSIsoft PI Historian.',
    `uv_dose_delivered_mj_cm2` DECIMAL(18,2) COMMENT 'UV dose delivered in mJ/cm². Ref: OSIsoft PI Historian.',
    `uv_dose_required_mj_cm2` DECIMAL(18,2) COMMENT 'UV dose required in mJ/cm². Ref: OSIsoft PI Historian.',
    `uv_intensity_mw_cm2` DECIMAL(18,2) COMMENT 'UV intensity in mW/cm². Ref: OSIsoft PI Historian.',
    `uv_transmittance_pct` DECIMAL(18,2) COMMENT 'UV transmittance percentage. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_uv_disinfection_event PRIMARY KEY(`uv_disinfection_event_id`)
) COMMENT 'UV disinfection event or alarm record. Captures UV dose delivered, dose required, UV intensity, transmittance, lamp status, lamp hours, flow rate, turbidity, target pathogen, log inactivation credit, and dose compliance flag. Used for LT2ESWTR compliance, lamp replacement scheduling, and process control. Links to SCADA tags and MOR submission.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` (
    `sludge_production_id` BIGINT COMMENT 'Unique identifier for sludge production record. Ref: OSIsoft PI Historian.',
    `discharge_point_id` BIGINT COMMENT 'Foreign key linking to treatment.discharge_point. Business justification: Treatment residuals/sludge are disposed at a defined discharge_point (outfall, sanitary sewer, lagoon) per the discharge_point description. sludge_production currently carries only a free-text disposa. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Hauling vendor. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Sludge-producing process unit. Ref: OSIsoft PI Historian.',
    `biosolids_class` STRING COMMENT 'Biosolids class (A or B per 40 CFR 503). Ref: OSIsoft PI Historian.',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Disposal cost in USD. Ref: OSIsoft PI Historian.',
    `disposal_method` STRING COMMENT 'Disposal method (landfill, land application, etc.). Ref: OSIsoft PI Historian.',
    `production_date` DATE COMMENT 'Date of sludge production. Ref: OSIsoft PI Historian.',
    `sludge_volume_gallons` DECIMAL(18,2) COMMENT 'Sludge volume in gallons. Ref: OSIsoft PI Historian.',
    `solids_content_pct` DECIMAL(18,2) COMMENT 'Solids content percentage. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_sludge_production PRIMARY KEY(`sludge_production_id`)
) COMMENT 'Treatment residuals (sludge/biosolids) production and disposal record. Tracks volume, solids content, biosolids class (A/B), disposal method (landfill, land application, beneficial reuse), hauler, cost, and analytical results (metals, pathogens, nutrients). Used for 40 CFR Part 503 compliance, cost allocation, and residuals management planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` (
    `chemical_inventory_id` BIGINT COMMENT 'Unique identifier for inventory record. Ref: OSIsoft PI Historian.',
    `chemical_id` BIGINT COMMENT 'Chemical product. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `expiration_date` DATE COMMENT 'Expiration date. Ref: OSIsoft PI Historian.',
    `lot_number` STRING COMMENT 'Manufacturer lot number. Ref: OSIsoft PI Historian.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Current on-hand quantity. Ref: OSIsoft PI Historian.',
    `receipt_date` DATE COMMENT 'Date received. Ref: OSIsoft PI Historian.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Reorder point quantity. Ref: OSIsoft PI Historian.',
    `storage_location` STRING COMMENT 'Storage location or tank. Ref: OSIsoft PI Historian.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost in USD. Ref: OSIsoft PI Historian.',
    `unit_of_measure` STRING COMMENT 'Unit of measure (gallons, pounds, etc.). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_chemical_inventory PRIMARY KEY(`chemical_inventory_id`)
) COMMENT 'Treatment chemical inventory record. Tracks on-hand quantity, storage location, lot number, receipt date, expiration date, unit cost, reorder point, safety stock level, and consumption rate. Links to chemical master, vendor, purchase order, and dose events. Used for procurement planning, cost allocation, and safety compliance (SDS management).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` (
    `process_control_setpoint_id` BIGINT COMMENT 'Unique identifier for setpoint. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Employee who approved setpoint. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Process unit. Ref: OSIsoft PI Historian.',
    `scada_tag_id` BIGINT COMMENT 'Foreign key linking to treatment.scada_tag. Business justification: A process control setpoint / alarm-limit configuration maps to a specific SCADA/historian tag that carries the controlled value. Linking setpoint to its scada_tag ties the target/high/low alarm limits. Ref: OSIsoft PI Historian.',
    `effective_date` DATE COMMENT 'Effective date of setpoint. Ref: OSIsoft PI Historian.',
    `high_alarm_limit` DECIMAL(18,2) COMMENT 'High alarm threshold. Ref: OSIsoft PI Historian.',
    `low_alarm_limit` DECIMAL(18,2) COMMENT 'Low alarm threshold. Ref: OSIsoft PI Historian.',
    `parameter_name` STRING COMMENT 'Parameter name (e.g., chlorine residual). Ref: OSIsoft PI Historian.',
    `target_value` DECIMAL(18,2) COMMENT 'Target setpoint value. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_process_control_setpoint PRIMARY KEY(`process_control_setpoint_id`)
) COMMENT 'Process control setpoint or alarm limit configuration. Defines target value, high/low alarm thresholds, control action, effective date range, and approval authority for key process parameters (chlorine residual, pH, turbidity, flow rate, chemical dose). Used for SCADA control logic, operator guidance, and regulatory compliance verification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` (
    `treatment_permit_id` BIGINT COMMENT 'Unique identifier for treatment permit. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `regulatory_agency_id` BIGINT COMMENT 'Regulatory agency reference. Ref: OSIsoft PI Historian.',
    `project_permit_id` BIGINT COMMENT 'Unique identifier for the project permit referenced by each treatment permit record in the treatment domain.',
    `effective_date` DATE COMMENT 'Permit effective date. Ref: OSIsoft PI Historian.',
    `expiration_date` DATE COMMENT 'Permit expiration date. Ref: OSIsoft PI Historian.',
    `issuing_agency` STRING COMMENT 'Issuing regulatory agency. Ref: OSIsoft PI Historian.',
    `permit_number` STRING COMMENT 'Permit number. Ref: OSIsoft PI Historian.',
    `permit_type` STRING COMMENT 'Permit type (operating, construction, etc.). Ref: OSIsoft PI Historian.',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'Permitted capacity in MGD. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_treatment_permit PRIMARY KEY(`treatment_permit_id`)
) COMMENT 'Treatment facility operating permit (SDWA, state primacy agency). Stores permit number, issuing agency, effective/expiration dates, permitted capacity, treatment technology requirements, monitoring schedules, and special conditions. Links to facility, permit conditions, and compliance violations. Used for permit renewal tracking and compliance management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` (
    `chemical_id` BIGINT COMMENT 'Unique identifier for chemical. Ref: OSIsoft PI Historian.',
    `cas_number` STRING COMMENT 'CAS registry number. Ref: OSIsoft PI Historian.',
    `chemical_type` STRING COMMENT 'Chemical type (coagulant, disinfectant, etc.). Ref: OSIsoft PI Historian.',
    `concentration_pct` DECIMAL(18,2) COMMENT 'Concentration percentage. Ref: OSIsoft PI Historian.',
    `density_lb_per_gal` DECIMAL(18,2) COMMENT 'Density in lb/gal. Ref: OSIsoft PI Historian.',
    `chemical_name` STRING COMMENT 'Chemical name. Ref: OSIsoft PI Historian.',
    `nsf_ansi_60_certified` BOOLEAN COMMENT 'NSF/ANSI 60 certification status. Ref: OSIsoft PI Historian.',
    `sds_document_url` STRING COMMENT 'Safety data sheet URL. Ref: OSIsoft PI Historian.',
    `unit_of_measure` STRING COMMENT 'Unit of measure. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_chemical PRIMARY KEY(`chemical_id`)
) COMMENT 'Treatment chemical master record. Defines chemical name, type (coagulant, disinfectant, pH adjuster, corrosion inhibitor), CAS number, concentration, density, safety classification, SDS reference, approved vendors, unit of measure, and typical dose range. Used for inventory management, dose event recording, and safety compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` (
    `treatment_violation_id` BIGINT COMMENT 'Unique identifier for violation. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `contaminant` STRING COMMENT 'Contaminant involved. Ref: OSIsoft PI Historian.',
    `exceedance_value` DECIMAL(18,2) COMMENT 'Measured exceedance value. Ref: OSIsoft PI Historian.',
    `public_notification_required` BOOLEAN COMMENT 'Public notification requirement. Ref: OSIsoft PI Historian.',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Regulatory limit exceeded. Ref: OSIsoft PI Historian.',
    `return_to_compliance_date` DATE COMMENT 'Date returned to compliance. Ref: OSIsoft PI Historian.',
    `violation_begin_date` DATE COMMENT 'Violation begin date. Ref: OSIsoft PI Historian.',
    `violation_end_date` DATE COMMENT 'Violation end date. Ref: OSIsoft PI Historian.',
    `violation_type` STRING COMMENT 'Violation type (MCL, MRDL, TT, M/R). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_treatment_violation PRIMARY KEY(`treatment_violation_id`)
) COMMENT 'Treatment-related regulatory violation record (SDWA MCL, MRDL, TT, monitoring/reporting). Captures violation type, contaminant, exceedance value, limit, violation period, public notification requirement, return-to-compliance date, and enforcement action. Links to facility, permit, and public notification. Used for SDWIS reporting and compliance tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` (
    `mor_submission_id` BIGINT COMMENT 'Unique identifier for MOR submission. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `regulatory_agency_id` BIGINT COMMENT 'Receiving regulatory agency. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Employee who submitted MOR. Ref: OSIsoft PI Historian.',
    `reporting_period_end` DATE COMMENT 'Reporting period end date. Ref: OSIsoft PI Historian.',
    `reporting_period_start` DATE COMMENT 'Reporting period start date. Ref: OSIsoft PI Historian.',
    `submission_date` DATE COMMENT 'Date submitted to agency. Ref: OSIsoft PI Historian.',
    `submission_status` STRING COMMENT 'Submission status (draft, submitted, approved). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_mor_submission PRIMARY KEY(`mor_submission_id`)
) COMMENT 'Monthly Operating Report (MOR) submission to state primacy agency. Aggregates production, water quality, CT compliance, filter performance, and operational data for the reporting period. Tracks submission date, approval status, reviewer, and data source. Links to facility, process readings, filter runs, and CT records. Used for regulatory compliance and historical reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` (
    `scada_tag_id` BIGINT COMMENT 'Unique identifier for SCADA tag. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Associated process unit. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'The data quality flag value recorded for each scada tag in the treatment domain.',
    `data_type` STRING COMMENT 'Data type (analog, digital, string). Ref: OSIsoft PI Historian.',
    `engineering_unit` STRING COMMENT 'Engineering unit of measure. Ref: OSIsoft PI Historian.',
    `high_alarm_limit` DECIMAL(18,2) COMMENT 'High alarm limit. Ref: OSIsoft PI Historian.',
    `low_alarm_limit` DECIMAL(18,2) COMMENT 'Low alarm limit. Ref: OSIsoft PI Historian.',
    `pi_point_name` STRING COMMENT 'OSIsoft PI point name.',
    `scan_rate_seconds` STRING COMMENT 'Scan rate in seconds. Ref: OSIsoft PI Historian.',
    `tag_description` STRING COMMENT 'Tag description. Ref: OSIsoft PI Historian.',
    `tag_name` STRING COMMENT 'SCADA tag name. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_scada_tag PRIMARY KEY(`scada_tag_id`)
) COMMENT 'SCADA/historian tag master record. Defines tag name, description, engineering unit, data type, scan rate, historian archive, PI point reference, alarm limits, and associated process unit or instrument. Used for SCADA integration, real-time monitoring, and historical data retrieval. Links to process readings and control setpoints.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` (
    `facility_service_allocation_id` BIGINT COMMENT 'Unique identifier for allocation. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `territory_id` BIGINT COMMENT 'Service territory. Ref: OSIsoft PI Historian.',
    `allocated_capacity_mgd` DECIMAL(18,2) COMMENT 'Allocated capacity in MGD. Ref: OSIsoft PI Historian.',
    `effective_date` DATE COMMENT 'Allocation effective date. Ref: OSIsoft PI Historian.',
    `expiration_date` DATE COMMENT 'Allocation expiration date. Ref: OSIsoft PI Historian.',
    `priority_tier` STRING COMMENT 'Priority tier (1=highest). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_facility_service_allocation PRIMARY KEY(`facility_service_allocation_id`)
) COMMENT 'Allocation of treatment facility capacity to service territories or wholesale customers. Defines allocated volume, priority tier, contract reference, effective dates, and cost allocation basis. Used for capacity planning, wholesale billing, and capital improvement prioritization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` (
    `chemical_supply_agreement_id` BIGINT COMMENT 'Unique identifier for supply agreement. Ref: OSIsoft PI Historian.',
    `chemical_id` BIGINT COMMENT 'Chemical product. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Chemical vendor. Ref: OSIsoft PI Historian.',
    `annual_volume_commitment` DECIMAL(18,2) COMMENT 'Annual volume commitment. Ref: OSIsoft PI Historian.',
    `contract_end_date` DATE COMMENT 'Contract end date. Ref: OSIsoft PI Historian.',
    `contract_number` STRING COMMENT 'Contract number. Ref: OSIsoft PI Historian.',
    `contract_start_date` DATE COMMENT 'Contract start date. Ref: OSIsoft PI Historian.',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price in USD. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_chemical_supply_agreement PRIMARY KEY(`chemical_supply_agreement_id`)
) COMMENT 'Chemical supply contract or blanket purchase agreement. Defines vendor, chemical, contract term, pricing (unit cost, volume discounts), delivery schedule, quality specifications, and payment terms. Links to vendor, chemical master, and purchase orders. Used for procurement planning and cost forecasting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` (
    `facility_project_id` BIGINT COMMENT 'Unique identifier for facility project. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Capital improvement project. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `budget_allocated_usd` DECIMAL(18,2) COMMENT 'Budget allocated in USD. Ref: OSIsoft PI Historian.',
    `project_completion_date` DATE COMMENT 'Project completion date. Ref: OSIsoft PI Historian.',
    `project_scope` STRING COMMENT 'Project scope description. Ref: OSIsoft PI Historian.',
    `project_start_date` DATE COMMENT 'Project start date. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_facility_project PRIMARY KEY(`facility_project_id`)
) COMMENT 'Capital improvement project at a treatment facility (expansion, rehabilitation, technology upgrade). Links facility to CIP project, tracks project scope, budget allocation, design/construction milestones, and asset handover. Used for capital planning, grant management, and asset lifecycle tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` (
    `operator_qualification_id` BIGINT COMMENT 'Unique identifier for operator qualification. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Employee. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `operator_license_id` BIGINT COMMENT 'Operator license. Ref: OSIsoft PI Historian.',
    `certification_grade` STRING COMMENT 'Certification grade (I, II, III, IV). Ref: OSIsoft PI Historian.',
    `qualification_date` DATE COMMENT 'Date qualified for facility. Ref: OSIsoft PI Historian.',
    `qualification_status` STRING COMMENT 'Qualification status (active, expired). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_operator_qualification PRIMARY KEY(`operator_qualification_id`)
) COMMENT 'Treatment operator certification and qualification record. Links employee to operator license, facility certification grade requirement, qualification date, and training completion. Used for regulatory compliance (state operator certification requirements), shift scheduling, and succession planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` (
    `process_maintenance_plan_id` BIGINT COMMENT 'Unique identifier for maintenance plan. Ref: IBM Maximo.',
    `pm_schedule_id` BIGINT COMMENT 'Preventive maintenance schedule. Ref: IBM Maximo.',
    `process_unit_id` BIGINT COMMENT 'Process unit. Ref: IBM Maximo.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated labor hours. Ref: IBM Maximo.',
    `frequency_days` STRING COMMENT 'Maintenance frequency in days. Ref: IBM Maximo.',
    `last_performed_date` DATE COMMENT 'Last performed date. Ref: IBM Maximo.',
    `maintenance_task_description` STRING COMMENT 'Maintenance task description. Ref: IBM Maximo.',
    `next_due_date` DATE COMMENT 'Next due date. Ref: IBM Maximo.',
    CONSTRAINT pk_process_maintenance_plan PRIMARY KEY(`process_maintenance_plan_id`)
) COMMENT 'Preventive maintenance plan for treatment process units. Defines maintenance tasks, frequency, labor/material requirements, and performance indicators. Links to process unit, PM schedule, and work orders. Used for maintenance scheduling, budget planning, and asset reliability.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` (
    `process_compliance_monitoring_id` BIGINT COMMENT 'Unique identifier for compliance monitoring record. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Process unit. Ref: OSIsoft PI Historian.',
    `compliance_status` STRING COMMENT 'Compliance status. Ref: OSIsoft PI Historian.',
    `last_sample_date` DATE COMMENT 'Last sample date. Ref: OSIsoft PI Historian.',
    `monitoring_frequency` STRING COMMENT 'Monitoring frequency (daily, weekly, monthly). Ref: OSIsoft PI Historian.',
    `monitoring_parameter` STRING COMMENT 'Parameter monitored. Ref: OSIsoft PI Historian.',
    `next_due_date` DATE COMMENT 'Next due date. Ref: OSIsoft PI Historian.',
    `regulatory_basis` STRING COMMENT 'Regulatory basis (SDWA, state rule). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_process_compliance_monitoring PRIMARY KEY(`process_compliance_monitoring_id`)
) COMMENT 'Compliance monitoring schedule and status for treatment processes. Tracks required monitoring frequency (daily, weekly, monthly), parameter, regulatory basis (SDWA, state rule), last sample date, next due date, and compliance status. Used for monitoring compliance, sample planning, and violation prevention.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` (
    `permit_compliance_obligation_id` BIGINT COMMENT 'Unique identifier for compliance obligation. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Responsible employee. Ref: OSIsoft PI Historian.',
    `treatment_permit_id` BIGINT COMMENT 'Treatment permit. Ref: OSIsoft PI Historian.',
    `completion_status` STRING COMMENT 'Completion status. Ref: OSIsoft PI Historian.',
    `due_date` DATE COMMENT 'Due date. Ref: OSIsoft PI Historian.',
    `obligation_description` STRING COMMENT 'Obligation description. Ref: OSIsoft PI Historian.',
    `regulatory_citation` STRING COMMENT 'Regulatory citation. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_permit_compliance_obligation PRIMARY KEY(`permit_compliance_obligation_id`)
) COMMENT 'Specific compliance obligation from a treatment permit. Defines requirement text, regulatory citation, due date, responsible party, verification method, and completion status. Links to treatment permit and compliance corrective actions. Used for permit compliance tracking and audit preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` (
    `water_source_id` BIGINT COMMENT 'Unique identifier for water source. Ref: OSIsoft PI Historian.',
    `capacity_mgd` DECIMAL(18,2) COMMENT 'Source capacity in MGD. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude. Ref: OSIsoft PI Historian.',
    `protection_zone` STRING COMMENT 'Source water protection zone. Ref: OSIsoft PI Historian.',
    `source_name` STRING COMMENT 'Source name. Ref: OSIsoft PI Historian.',
    `source_type` STRING COMMENT 'Source type (surface, groundwater, purchased). Ref: OSIsoft PI Historian.',
    `vulnerability_assessment_date` DATE COMMENT 'Vulnerability assessment date. Ref: OSIsoft PI Historian.',
    `water_rights_permit_number` STRING COMMENT 'Water rights permit number. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_water_source PRIMARY KEY(`water_source_id`)
) COMMENT 'Source water master record (surface water intake, groundwater well, purchased water interconnection). Defines source type, location, capacity, water rights, protection zone, vulnerability assessment, and historical quality trends. Links to facility, intake events, and source water quality monitoring. Used for source water protection and treatment process planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` (
    `discharge_point_id` BIGINT COMMENT 'Unique identifier for discharge point. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `discharge_type` STRING COMMENT 'Discharge type (outfall, sewer, lagoon). Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude. Ref: OSIsoft PI Historian.',
    `discharge_point_name` STRING COMMENT 'Discharge point name. Ref: OSIsoft PI Historian.',
    `npdes_permit_number` STRING COMMENT 'NPDES permit number. Ref: OSIsoft PI Historian.',
    `receiving_water_body` STRING COMMENT 'Receiving water body. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_discharge_point PRIMARY KEY(`discharge_point_id`)
) COMMENT 'Treatment residuals or backwash discharge point (outfall, sanitary sewer, lagoon). Defines discharge location, receiving water body, permit reference, flow measurement method, and monitoring requirements. Links to facility, discharge events, and effluent quality monitoring. Used for NPDES compliance and environmental reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` (
    `filter_unit_id` BIGINT COMMENT 'Unique identifier for filter unit. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `process_unit_id` BIGINT COMMENT 'Parent process unit. Ref: OSIsoft PI Historian.',
    `backwash_configuration` STRING COMMENT 'Backwash configuration (water only, air scour, etc.). Ref: OSIsoft PI Historian.',
    `design_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Design flow rate in GPM. Ref: OSIsoft PI Historian.',
    `filter_number` STRING COMMENT 'Filter number or identifier. Ref: OSIsoft PI Historian.',
    `filter_type` STRING COMMENT 'Filter type (rapid sand, dual media, GAC). Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Installation date. Ref: OSIsoft PI Historian.',
    `last_media_replacement_date` DATE COMMENT 'Last media replacement date. Ref: OSIsoft PI Historian.',
    `media_depth_inches` DECIMAL(18,2) COMMENT 'Media depth in inches. Ref: OSIsoft PI Historian.',
    `media_type` STRING COMMENT 'Filter media type. Ref: OSIsoft PI Historian.',
    `surface_area_sqft` DECIMAL(18,2) COMMENT 'Filter surface area in square feet. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_filter_unit PRIMARY KEY(`filter_unit_id`)
) COMMENT 'Individual filter unit within a treatment facility (rapid sand, dual media, GAC, membrane). Specialization of process_unit with filter-specific attributes: media type/depth, surface area, hydraulic loading rate, backwash configuration, and filter number. Links to filter runs, backwash events, and media replacement records. Used for filter performance tracking and maintenance planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` (
    `treatment_technology_id` BIGINT COMMENT 'Primary key for treatment_technology. Ref: OSIsoft PI Historian.',
    `prerequisite_treatment_technology_id` BIGINT COMMENT 'Self-referencing FK on treatment_technology (prerequisite_treatment_technology_id). Ref: OSIsoft PI Historian.',
    `asset_management_system` STRING COMMENT 'Enterprise asset management system tracking the physical assets that deploy this technology (e.g., IBM Maximo).',
    `backwash_required` BOOLEAN COMMENT 'Indicates whether the technology requires periodic backwashing (typical of filtration and membrane systems). Ref: OSIsoft PI Historian.',
    `chemical_dosing_required` BOOLEAN COMMENT 'Indicates whether the technology requires chemical dosing (e.g., coagulant, chlorine, antiscalant) to operate. Ref: OSIsoft PI Historian.',
    `commissioning_date` DATE COMMENT 'Date the treatment technology was first commissioned into service within the enterprise. Ref: OSIsoft PI Historian.',
    `ct_requirement_applicable` BOOLEAN COMMENT 'Indicates whether concentration-time (CT) disinfection compliance calculations apply to this technology. Ref: OSIsoft PI Historian.',
    `treatment_technology_description` STRING COMMENT 'Detailed narrative describing the treatment technology, its operating principle, and typical application context. Ref: OSIsoft PI Historian.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Principal quantitative rating of the technologys nominal treatment throughput capacity expressed in million gallons per day. Ref: OSIsoft PI Historian.',
    `effective_from_date` DATE COMMENT 'Date from which this treatment technology reference record becomes effective/approved for use. Ref: OSIsoft PI Historian.',
    `effective_until_date` DATE COMMENT 'Date after which this treatment technology reference record is no longer effective; null for open-ended records. Ref: OSIsoft PI Historian.',
    `energy_intensity_kwh_per_mg` DECIMAL(18,2) COMMENT 'Typical electrical energy consumption of the technology per million gallons treated, used for operational cost and sustainability analysis. Ref: OSIsoft PI Historian.',
    `facility_type_applicability` STRING COMMENT 'Indicates whether the technology applies to Water Treatment Plants (WTP), Wastewater Treatment Plants (WWTP), or both. Ref: OSIsoft PI Historian.',
    `iso_certification_reference` STRING COMMENT 'Reference to any applicable ISO certification standard for the technology or its operation (e.g., ISO 24512 for wastewater services).',
    `log_removal_credit` DECIMAL(18,2) COMMENT 'Regulatory log-removal or log-inactivation credit assignable to this technology for pathogen control (e.g., Giardia, Cryptosporidium, virus). Ref: OSIsoft PI Historian.',
    `media_replacement_interval_months` STRING COMMENT 'Typical interval, in months, between media or membrane element replacement for the technology (e.g., GAC media, RO membranes). Ref: OSIsoft PI Historian.',
    `monitoring_system_of_record` STRING COMMENT 'Name of the operational system of record capturing this technologys process and quality data (e.g., OSIsoft PI Historian, LabWare LIMS, IBM Maximo).',
    `osha_safety_classification` STRING COMMENT 'Occupational safety classification or hazard note applicable to operating the technology (e.g., chlorine gas handling, confined space). Ref: OSIsoft PI Historian.',
    `pfas_treatment_capable` BOOLEAN COMMENT 'Indicates whether the technology is validated for removing per- and polyfluoroalkyl substances (PFAS), supporting US per-compound MCL and EU sum-of-20 compliance. Ref: OSIsoft PI Historian.',
    `primary_chemical_used` STRING COMMENT 'Name of the primary treatment chemical associated with the technology (e.g., alum, ferric chloride, sodium hypochlorite, sodium hydroxide). Ref: OSIsoft PI Historian.',
    `primary_mechanism` STRING COMMENT 'The dominant treatment mechanism employed (physical separation, chemical reaction, biological degradation, or combined physicochemical). Ref: OSIsoft PI Historian.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment technology reference record was first captured in the reference master. Ref: OSIsoft PI Historian.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment technology reference record was last modified. Ref: OSIsoft PI Historian.',
    `regulatory_approval_status` STRING COMMENT 'Regulatory approval standing of the technology under applicable drinking water / wastewater regulations. Ref: OSIsoft PI Historian.',
    `regulatory_reference_code` STRING COMMENT 'Citation code for the regulatory rule or standard governing the technologys use (e.g., NPDWR, LCRR, SWTR section reference).',
    `scada_integration_supported` BOOLEAN COMMENT 'Indicates whether the technologys real-time process data integrates with SCADA / OSIsoft PI Historian for process control and Monthly Operating Report (MOR) submissions.',
    `target_contaminant_class` STRING COMMENT 'Primary class of contaminants the technology is designed to remove or inactivate. [ENUM-REF-CANDIDATE: pathogens|organics|inorganics|pfas|turbidity|nutrients|disinfection_byproducts|taste_odor — promote to reference product]. Ref: OSIsoft PI Historian.',
    `technology_code` STRING COMMENT 'Externally-known short code uniquely identifying the technology within the enterprise reference catalogue (e.g., UV, GAC, RO, UF, MF). Ref: OSIsoft PI Historian.',
    `technology_name` STRING COMMENT 'Human-readable name of the treatment technology (e.g., Ultraviolet Disinfection, Granular Activated Carbon Adsorption, Reverse Osmosis). Ref: OSIsoft PI Historian.',
    `technology_status` STRING COMMENT 'Current lifecycle state of the technology within the enterprise (in service, pilot, approved, retired, deprecated, or under evaluation). Ref: OSIsoft PI Historian.',
    `treatment_category` STRING COMMENT 'High-level treatment process category the technology belongs to. [ENUM-REF-CANDIDATE: coagulation|filtration|disinfection|adsorption|membrane|oxidation|softening|ion_exchange — promote to reference product]. Ref: OSIsoft PI Historian.',
    `treatment_stage` STRING COMMENT 'Position of the technology within the overall treatment train (pretreatment, primary, secondary, tertiary, advanced, or terminal disinfection). Ref: OSIsoft PI Historian.',
    `typical_capital_cost_usd` DECIMAL(18,2) COMMENT 'Representative capital cost of deploying the technology at nominal capacity, used for capital planning. Single-currency USD. Ref: OSIsoft PI Historian.',
    `typical_operating_cost_usd_per_mg` DECIMAL(18,2) COMMENT 'Representative operating cost per million gallons treated, used for lifecycle cost analysis. Single-currency USD. Ref: OSIsoft PI Historian.',
    `typical_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'Expected contaminant removal or inactivation efficiency of the technology expressed as a percentage under standard operating conditions. Ref: OSIsoft PI Historian.',
    `vendor_name` STRING COMMENT 'Name of the primary equipment vendor or original technology provider for this treatment technology. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_treatment_technology PRIMARY KEY(`treatment_technology_id`)
) COMMENT 'Master reference table for treatment_technology. Referenced by primary_treatment_technology_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_treatment_technology_id` FOREIGN KEY (`treatment_technology_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_technology`(`treatment_technology_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_mor_submission_id` FOREIGN KEY (`mor_submission_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`mor_submission`(`mor_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_filter_unit_id` FOREIGN KEY (`filter_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`filter_unit`(`filter_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_discharge_point_id` FOREIGN KEY (`discharge_point_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`discharge_point`(`discharge_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_filter_run_id` FOREIGN KEY (`filter_run_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`filter_run`(`filter_run_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_filter_unit_id` FOREIGN KEY (`filter_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`filter_unit`(`filter_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_mor_submission_id` FOREIGN KEY (`mor_submission_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`mor_submission`(`mor_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_discharge_point_id` FOREIGN KEY (`discharge_point_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`discharge_point`(`discharge_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ADD CONSTRAINT `fk_treatment_chemical_supply_agreement_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ADD CONSTRAINT `fk_treatment_chemical_supply_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ADD CONSTRAINT `fk_treatment_facility_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ADD CONSTRAINT `fk_treatment_process_maintenance_plan_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ADD CONSTRAINT `fk_treatment_process_compliance_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ADD CONSTRAINT `fk_treatment_process_compliance_monitoring_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ADD CONSTRAINT `fk_treatment_permit_compliance_obligation_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` ADD CONSTRAINT `fk_treatment_treatment_technology_prerequisite_treatment_technology_id` FOREIGN KEY (`prerequisite_treatment_technology_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_technology`(`treatment_technology_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_ecm_depth_target' = '5');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_operator_in_charge_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_operator_in_charge_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_business_glossary_term' = 'ECM/MVM Depth Reconciliation');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_mvm_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `number_of_treatment_trains` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `number_of_treatment_trains` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_capable_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_capable_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `primary_treatment_process` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `primary_treatment_process` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `secondary_treatment_process` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `secondary_treatment_process` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_capacity_mgd` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_capacity_mgd` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_primary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_primary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `baffling_factor` SET TAGS ('dbx_business_glossary_term' = 'Baffling Factor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `detention_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Detention Time');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `hydraulic_loading_rate_gpm_sqft` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Loading Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_integration' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `surface_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Surface Area');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_train_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `treatment_train_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Process Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_operator_employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `alarm_state` SET TAGS ('dbx_business_glossary_term' = 'Alarm State');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `mor_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'MOR Reporting');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `mor_reporting_flag` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dose Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_mass_applied_kg` SET TAGS ('dbx_business_glossary_term' = 'Mass Applied');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `ct_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CT Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `ct_compliance_flag` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dose End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_end_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_rate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Dose Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dose Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_start_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `post_dose_residual_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Post-Dose Residual');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `target_residual_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Target Residual');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `water_flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'CT Compliance Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_business_glossary_term' = 'MOR Submission');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `baffling_factor` SET TAGS ('dbx_business_glossary_term' = 'Baffling Factor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `contact_time_min` SET TAGS ('dbx_business_glossary_term' = 'Contact Time');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_calculated` SET TAGS ('dbx_business_glossary_term' = 'CT Calculated');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_ratio` SET TAGS ('dbx_business_glossary_term' = 'CT Ratio');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_required` SET TAGS ('dbx_business_glossary_term' = 'CT Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_required` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `disinfectant_concentration` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `log_inactivation_achieved` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `operator_verified` SET TAGS ('dbx_business_glossary_term' = 'Operator Verified');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `target_organism` SET TAGS ('dbx_business_glossary_term' = 'Target Organism');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_run_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Run ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_run_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `backwash_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Backwash Trigger');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_to_waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_to_waste_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `influent_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Influent Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `initial_head_loss_ft` SET TAGS ('dbx_business_glossary_term' = 'Initial Head Loss');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `terminal_effluent_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Terminal Effluent Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `terminal_effluent_turbidity_ntu` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `terminal_head_loss_ft` SET TAGS ('dbx_business_glossary_term' = 'Terminal Head Loss');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `volume_filtered_mg` SET TAGS ('dbx_business_glossary_term' = 'Volume Filtered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_event_id` SET TAGS ('dbx_business_glossary_term' = 'Backwash Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_event_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_run_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Run Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `air_scour_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Air Scour Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `air_scour_used` SET TAGS ('dbx_business_glossary_term' = 'Air Scour Used');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Backwash End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_end_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Backwash Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Backwash Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_start_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_water_volume_gal` SET TAGS ('dbx_business_glossary_term' = 'Backwash Water Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `chemical_aid_used` SET TAGS ('dbx_business_glossary_term' = 'Chemical Aid Used');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_to_waste_used` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste Used');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `post_backwash_headloss_ft` SET TAGS ('dbx_business_glossary_term' = 'Post-Backwash Headloss');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `pre_backwash_headloss_ft` SET TAGS ('dbx_business_glossary_term' = 'Pre-Backwash Headloss');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_business_glossary_term' = 'MOR Submission');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `avg_production_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Production Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `backwash_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Backwash Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `cl2_residual_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Average Chlorine Residual');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `cl2_residual_avg_mg_l` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `filter_to_waste_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `peak_production_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Production Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `ph_avg` SET TAGS ('dbx_business_glossary_term' = 'Average pH');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `plant_efficiency_ratio` SET TAGS ('dbx_business_glossary_term' = 'Plant Efficiency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `production_date` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `source_water_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Source Water Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Average Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_avg_ntu` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Max Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_max_ntu` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Intake ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `conductivity_us_per_cm` SET TAGS ('dbx_business_glossary_term' = 'Conductivity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `intake_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intake Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `intake_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `permit_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `permit_compliance_status` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `toc_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'TOC');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `volume_withdrawn_mg` SET TAGS ('dbx_business_glossary_term' = 'Volume Withdrawn');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `membrane_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Membrane Performance ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `membrane_performance_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `backwash_frequency_per_day` SET TAGS ('dbx_business_glossary_term' = 'Backwash Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `chemical_cleaning_count` SET TAGS ('dbx_business_glossary_term' = 'Chemical Cleaning Count');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `feed_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Feed Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `feed_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Feed Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `integrity_test_result` SET TAGS ('dbx_business_glossary_term' = 'Integrity Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `integrity_test_result` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `log_removal_value` SET TAGS ('dbx_business_glossary_term' = 'Log Removal');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `log_removal_value` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `permeate_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Permeate Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `permeate_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Permeate Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `permeate_turbidity_ntu` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `transmembrane_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Transmembrane Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_disinfection_event_id` SET TAGS ('dbx_business_glossary_term' = 'UV Disinfection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_disinfection_event_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `dose_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dose Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `dose_compliance_flag` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `lamp_hours_elapsed` SET TAGS ('dbx_business_glossary_term' = 'Lamp Hours');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `lamp_status` SET TAGS ('dbx_business_glossary_term' = 'Lamp Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `target_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Target Pathogen');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_delivered_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Dose Delivered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_delivered_mj_cm2` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_required_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Dose Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_required_mj_cm2` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_intensity_mw_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Intensity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_transmittance_pct` SET TAGS ('dbx_business_glossary_term' = 'UV Transmittance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `sludge_production_id` SET TAGS ('dbx_business_glossary_term' = 'Sludge Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `sludge_production_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `vendor_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `production_date` SET TAGS ('dbx_timeseries' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `sludge_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Sludge Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `solids_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Solids Content');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_supply' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_control' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_control_setpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Setpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_control_setpoint_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Tag Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `high_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `low_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_ssot_owner' = 'project.project_permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_ssot_stem' = 'permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permitted_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `density_lb_per_gal` SET TAGS ('dbx_business_glossary_term' = 'Density');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `nsf_ansi_60_certified` SET TAGS ('dbx_business_glossary_term' = 'NSF/ANSI 60 Certified');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `nsf_ansi_60_certified` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `sds_document_url` SET TAGS ('dbx_business_glossary_term' = 'SDS Document');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `contaminant` SET TAGS ('dbx_business_glossary_term' = 'Contaminant');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `exceedance_value` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `return_to_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Compliance Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Begin Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Violation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_business_glossary_term' = 'MOR Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_integration' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `high_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `low_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `pi_point_name` SET TAGS ('dbx_business_glossary_term' = 'PI Point Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `pi_point_name` SET TAGS ('dbx_integration' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scan_rate_seconds` SET TAGS ('dbx_business_glossary_term' = 'Scan Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_description` SET TAGS ('dbx_business_glossary_term' = 'Tag Description');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_integration' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_subdomain' = 'capital_contracts');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_association_edges' = 'treatment.facility,service.service_territory');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_service_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_service_allocation_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `territory_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `allocated_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_subdomain' = 'capital_contracts');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_association_edges' = 'treatment.chemical,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_procurement' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Supply Agreement ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_supply_agreement_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Commitment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_subdomain' = 'capital_contracts');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_association_edges' = 'treatment.facility,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_capital' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_project_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_project_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Project Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_scope` SET TAGS ('dbx_business_glossary_term' = 'Project Scope');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,workforce.employee');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_workforce' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Qualification ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operator License');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `certification_grade` SET TAGS ('dbx_business_glossary_term' = 'Certification Grade');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `certification_grade` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_subdomain' = 'process_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,asset.job_plan');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Process Maintenance Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_maintenance_plan_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,compliance.permit_condition');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Process Compliance Monitoring ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `last_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_parameter` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Parameter');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_parameter` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_association_edges' = 'treatment.treatment_permit,compliance.regulatory_requirement');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `permit_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Compliance Obligation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `permit_compliance_obligation_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_source_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_GIS' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_GIS' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `protection_zone` SET TAGS ('dbx_business_glossary_term' = 'Protection Zone');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `vulnerability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_rights_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Water Rights Permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_rights_permit_number` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_environmental' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_GIS' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_GIS' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_name` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `backwash_configuration` SET TAGS ('dbx_business_glossary_term' = 'Backwash Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `design_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_number` SET TAGS ('dbx_business_glossary_term' = 'Filter Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_type` SET TAGS ('dbx_business_glossary_term' = 'Filter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `last_media_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Media Replacement Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `media_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Media Depth');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `surface_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Surface Area');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` SET TAGS ('dbx_subdomain' = 'facility_assets');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` ALTER COLUMN `treatment_technology_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` ALTER COLUMN `prerequisite_treatment_technology_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` ALTER COLUMN `typical_capital_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_technology` ALTER COLUMN `typical_operating_cost_usd_per_mg` SET TAGS ('dbx_confidential' = 'true');
