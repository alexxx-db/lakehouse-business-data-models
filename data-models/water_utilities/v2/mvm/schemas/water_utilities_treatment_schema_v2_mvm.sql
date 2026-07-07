-- Schema for Domain: treatment | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`treatment` COMMENT 'Authoritative domain for all water treatment and purification operations at WTPs and WWTPs. Owns process data for coagulation, filtration, disinfection (UV, chlorination, RO, UF, MF, GAC), CT compliance, chemical dosing, and finished water production. Integrates with SCADA/OSIsoft PI Historian for real-time process control and MOR regulatory submissions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility referenced by each facility record in the treatment domain.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency referenced by each facility record in the treatment domain.',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: A water treatment facility draws from a primary water source (surface water intake, groundwater well, purchased interconnection). The facility table currently stores source_water_type, primary_source_',
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
    `service_area_population` STRING COMMENT 'The service area population value recorded for each facility in the treatment domain.',
    `service_connections_count` STRING COMMENT 'The service connections count value recorded for each facility in the treatment domain.',
    `service_population` BIGINT COMMENT 'The service population value recorded for each facility in the treatment domain.',
    `site_area_acres` DECIMAL(18,2) COMMENT 'The site area acres value recorded for each facility in the treatment domain.',
    `state_code` STRING COMMENT 'The state code value recorded for each facility in the treatment domain.',
    `state_primacy_agency` STRING COMMENT 'The state primacy agency value recorded for each facility in the treatment domain.',
    `state_province` STRING COMMENT 'The state province value recorded for each facility in the treatment domain.',
    `street_address` STRING COMMENT 'The street address value recorded for each facility in the treatment domain.',
    `treatment_capacity_mgd` DECIMAL(18,2) COMMENT 'The treatment capacity mgd value recorded for each facility in the treatment domain.',
    `treatment_class` STRING COMMENT 'The treatment class value recorded for each facility in the treatment domain.',
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
    `facility_id` BIGINT COMMENT 'Parent treatment facility. Ref: OSIsoft PI Historian.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Process units occupy specific physical locations within the facility location hierarchy (filter gallery, pump room, chemical building). Linking to asset.location enables GIS-based asset management, lo',
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
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `installation_id` BIGINT COMMENT 'Unique identifier for the meter installation referenced by each process reading record in the treatment domain.',
    `process_unit_id` BIGINT COMMENT 'Process unit generating the reading. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each process reading record in the treatment domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Process readings flagged as regulatory exceedances (is_regulatory_exceedance=true) or DMR-reportable (dmr_reporting_flag=true) must reference the specific regulatory requirement (MCL, treatment techni',
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
    `process_unit_id` BIGINT COMMENT 'Contact basin or process unit. Ref: OSIsoft PI Historian.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: CT compliance records demonstrate log inactivation credits required by specific rules (SWTR, LT2ESWTR). Operators and compliance staff must trace each CT calculation to the governing regulatory requir',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` (
    `finished_water_production_id` BIGINT COMMENT 'Unique identifier for production record. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` (
    `treatment_permit_id` BIGINT COMMENT 'Unique identifier for treatment permit. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `regulatory_agency_id` BIGINT COMMENT 'Regulatory agency reference. Ref: OSIsoft PI Historian.',
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
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Discharge points (backwash discharge, filter-to-waste, plant drain) operate under specific NPDES/discharge compliance permits distinct from treatment permits. Regulators and operators must know which ',
    `facility_id` BIGINT COMMENT 'Treatment facility. Ref: OSIsoft PI Historian.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Discharge points (backwash, plant effluent) require metered volume tracking for NPDES permit compliance and discharge monitoring reports (DMRs). Linking discharge_point to its meter installation enabl',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: A treatment facility discharge point physically connects to a distribution pipe main as the entry point of finished water into the network. This link is fundamental for hydraulic modeling, water quali',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Discharge point outfall structures are physical assets requiring NPDES permit compliance inspections, condition assessments, and maintenance work orders. Linking discharge_point to asset registry enab',
    `discharge_type` STRING COMMENT 'Discharge type (outfall, sewer, lagoon). Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude. Ref: OSIsoft PI Historian.',
    `discharge_point_name` STRING COMMENT 'Discharge point name. Ref: OSIsoft PI Historian.',
    `receiving_water_body` STRING COMMENT 'Receiving water body. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_discharge_point PRIMARY KEY(`discharge_point_id`)
) COMMENT 'Treatment residuals or backwash discharge point (outfall, sanitary sewer, lagoon). Defines discharge location, receiving water body, permit reference, flow measurement method, and monitoring requirements. Links to facility, discharge events, and effluent quality monitoring. Used for NPDES compliance and environmental reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_capacity_mgd` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_capacity_mgd` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_class` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Process Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dose Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'CT Compliance Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_subdomain' = 'process_monitoring');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permitted_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_subdomain' = 'process_monitoring');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_subdomain' = 'facility_operations');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_PK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_FK' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
