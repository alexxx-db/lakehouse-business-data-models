-- Schema for Domain: facility | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`facility` COMMENT 'Healthcare facility and physical infrastructure management. Owns hospitals, clinics, outpatient centers, care sites, bed management, room/unit configuration, OR/ICU/ED space, equipment assets, biomedical engineering, preventive maintenance, environmental services, facility licensing, and accreditation status. Supports multi-site integrated delivery networks. Integrates with SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`care_site` (
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care delivery location within the integrated delivery network (IDN). Primary key for the care site entity.',
    `parent_care_site_id` BIGINT COMMENT 'Reference to the parent care site in the organizational hierarchy, enabling health system→region→market→campus→site relationships. Null for top-level health system entities.',
    `npi_registry_id` BIGINT COMMENT 'Federal Employer Identification Number (EIN) assigned by the IRS for tax reporting and revenue cycle operations. Used in claims submission and payer contracting.',
    `accreditation_body` STRING COMMENT 'Organization providing voluntary accreditation for the care site. Accreditation demonstrates compliance with national quality and safety standards and may satisfy CMS deemed status requirements.. Valid values are `the_joint_commission|dnv_healthcare|hfap|cihq|aaahc|not_accredited`',
    `accreditation_expiration_date` DATE COMMENT 'Date the current accreditation expires. Triggers survey preparation and ensures continuous deemed status for Medicare participation.',
    `accreditation_status` STRING COMMENT 'Current status of voluntary accreditation. Accredited status may grant deemed status for Medicare Conditions of Participation and is often required for payer contracting.. Valid values are `accredited|provisional|denied|withdrawn|not_applicable`',
    `address_line_1` STRING COMMENT 'Primary street address of the care site including street number, street name, and unit/suite if applicable. Used for facility licensing, patient navigation, and emergency services dispatch.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building name, floor, department, or mail stop. Optional field for complex campus environments.',
    `ccn` STRING COMMENT 'Six-character CMS Certification Number (formerly Provider Number) assigned to Medicare-certified facilities. First two digits indicate state, third-fourth indicate facility type.. Valid values are `^[0-9A-Z]{6}$`',
    `city` STRING COMMENT 'City or municipality where the care site is physically located. Used for geographic reporting, service area analysis, and regulatory jurisdiction determination.',
    `closure_date` DATE COMMENT 'Date the care site permanently ceased operations. Used for historical analysis, medical records retention planning, and network capacity reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code. Supports international IDN operations and cross-border care coordination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish where the care site is located. Used for public health reporting, certificate of need (CON) analysis, and regional health planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this care site record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_access_hospital` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under the Medicare Rural Hospital Flexibility Program. CAH status provides cost-based reimbursement and reduced regulatory requirements.',
    `disproportionate_share_hospital` BOOLEAN COMMENT 'Indicates whether the facility qualifies for Medicare DSH payments due to serving a disproportionate share of low-income patients. Affects Medicare reimbursement rates.',
    `email_address` STRING COMMENT 'Primary email address for administrative and clinical correspondence. Used for referral notifications, quality reporting, and payer communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_services_available` BOOLEAN COMMENT 'Indicates whether the care site operates a 24/7 emergency department. Determines EMTALA obligations, EMS transport protocols, and trauma network participation.',
    `facility_type` STRING COMMENT 'Classification of the care delivery location based on services provided and regulatory designation. Determines applicable licensing, staffing, and quality reporting requirements. [ENUM-REF-CANDIDATE: acute_care_hospital|critical_access_hospital|ambulatory_surgery_center|clinic|urgent_care|rehabilitation_facility|skilled_nursing_facility — 7 candidates stripped; promote to reference product]',
    `fax_number` STRING COMMENT 'Fax number for medical records requests, prior authorizations, and clinical documentation exchange. Still widely used in healthcare for HIPAA-compliant transmission.',
    `go_live_date` DATE COMMENT 'Date the care site began operations and started accepting patients. Used for historical trending, market entry analysis, and anniversary planning.',
    `hierarchy_effective_date` DATE COMMENT 'Date the current organizational hierarchy relationship became effective. Supports time-variant hierarchy reporting for mergers, acquisitions, and reorganizations.',
    `hierarchy_level` STRING COMMENT 'Position of this care site within the IDN organizational hierarchy. Supports multi-level reporting, cost allocation, and governance structure representation.. Valid values are `health_system|region|market|campus|site`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this care site record was most recently modified. Used for change tracking, data quality monitoring, and downstream system synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the care site in decimal degrees. Used for geospatial analysis, service area mapping, and distance-based referral routing.',
    `license_effective_date` DATE COMMENT 'Date the current facility license became effective. Used to track license renewal cycles and ensure continuous compliance.',
    `license_expiration_date` DATE COMMENT 'Date the current facility license expires. Triggers renewal workflows and compliance monitoring to prevent operational disruption.',
    `license_number` STRING COMMENT 'State-issued facility license number. Required for legal operation and must be displayed publicly per state regulations.',
    `licensed_bed_capacity` STRING COMMENT 'Total number of inpatient beds the facility is licensed to operate by the state health department. Determines staffing requirements, certificate of need compliance, and CMS cost report bed counts.',
    `licensure_status` STRING COMMENT 'Current state of the facility license issued by the state health department. Active status is required for legal operation and Medicare/Medicaid participation.. Valid values are `active|provisional|suspended|revoked|expired`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the care site in decimal degrees. Used for geospatial analysis, service area mapping, and distance-based referral routing.',
    `medicaid_provider_number` STRING COMMENT 'State-specific Medicaid provider identification number. Required for Medicaid claims submission and varies by state Medicaid program.',
    `medicare_provider_number` STRING COMMENT 'Legacy Medicare provider identification number, now replaced by CCN but still used in some legacy systems and historical reporting.',
    `operational_status` STRING COMMENT 'Current operational state of the care site. Active status indicates the site is open and accepting patients. Used for capacity planning, referral routing, and network adequacy reporting.. Valid values are `active|inactive|under_construction|temporarily_closed|permanently_closed`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the care site. Determines tax status, regulatory oversight, and eligibility for certain federal programs and grants.. Valid values are `government_federal|government_state|government_local|nonprofit|for_profit|physician_owned`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the care site. Used for patient inquiries, referral coordination, and emergency contact.',
    `postal_code` STRING COMMENT 'Five-digit or nine-digit ZIP code for the care site location. Used for geographic market segmentation, service area mapping, and population health analytics.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `site_name` STRING COMMENT 'Official business name of the care delivery location as registered with state licensing authorities and used in patient-facing communications.',
    `site_npi` STRING COMMENT 'Type 2 NPI assigned to the organizational care site by CMS for billing and identification purposes. Required for Medicare/Medicaid claims submission.. Valid values are `^[0-9]{10}$`',
    `sole_community_hospital` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Sole Community Hospital, providing enhanced Medicare reimbursement for rural hospitals that are the sole source of care in their area.',
    `staffed_bed_capacity` STRING COMMENT 'Number of beds currently staffed and available for patient occupancy. May be less than licensed capacity due to staffing constraints or seasonal demand patterns.',
    `state` STRING COMMENT 'Two-letter US state or territory postal abbreviation. Determines applicable state licensing board, Medicaid program, and health department jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `teaching_status` BOOLEAN COMMENT 'Indicates whether the facility is a teaching hospital with approved residency programs. Teaching status affects CMS reimbursement through Graduate Medical Education (GME) payments and indirect medical education (IME) adjustments.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the care site location. Used for scheduling, appointment coordination, and timestamp normalization across multi-site IDN operations.',
    `trauma_level` STRING COMMENT 'American College of Surgeons trauma center verification level. Indicates capability to provide comprehensive trauma care and determines EMS transport protocols.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_designated`',
    `website_url` STRING COMMENT 'Public-facing website URL for the care site. Provides patient access to services information, provider directories, and online scheduling.',
    CONSTRAINT pk_care_site PRIMARY KEY(`care_site_id`)
) COMMENT 'Master record for every physical care delivery location within the integrated delivery network (IDN), including hospitals, clinics, outpatient centers, urgent care sites, ambulatory surgery centers, rehabilitation facilities, and specialty care locations. Captures site name, NPI, CMS certification number (CCN), facility type, tax ID, physical address, licensure status, accreditation body (TJC, DNV, HFAP), accreditation expiration, licensed bed capacity, trauma level designation, teaching status, ownership entity, operational status, go-live date, and operating hours configuration. Supports IDN organizational hierarchy via self-referential parent site reference defining health system→region→market→campus→site relationships, with hierarchy level and effective dating. Catalogs clinical services and programs offered at the site (cardiac surgery, trauma level, comprehensive stroke center, NICU level, radiation oncology, behavioral health, telehealth) with service line, CMS service type code, accreditation/certification requirements, and active status. SSOT for facility identity, organizational hierarchy, service capability, and site operating configuration across the enterprise.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Unique identifier for the building. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility that owns or operates this building.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Property parcels must be classified by geographic region for HSA/HRR assignment, regional health planning, certificate of need applications, and CMS geographic adjustment factors. Essential for facili',
    `organization_id` BIGINT COMMENT '',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the building meets Americans with Disabilities Act accessibility requirements including ramps, elevators, restrooms, and signage.',
    `address_line_1` STRING COMMENT 'Primary street address of the building including street number and name. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building designation. Organizational contact data classified as confidential.',
    `annual_property_tax_amount` DECIMAL(18,2) COMMENT 'Annual property tax liability for the building in US dollars. Used for budgeting and financial planning.',
    `city` STRING COMMENT 'City or municipality where the building is located. Organizational contact data classified as confidential.',
    `cms_certification_number` STRING COMMENT 'CMS-issued certification number (CCN) authorizing participation in Medicare and Medicaid programs. Required for federal reimbursement.',
    `building_code` STRING COMMENT 'Unique alphanumeric code assigned to the building for internal identification and facility management systems. Used in SAP PM and facility operations.. Valid values are `^[A-Z0-9]{2,20}$`',
    `construction_year` STRING COMMENT 'Year the building was originally constructed. Used for capital planning, depreciation calculations, and facility lifecycle management.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the building is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this building record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when the building record became active in the system or when the building was placed into service.',
    `electrical_service_capacity_kva` DECIMAL(18,2) COMMENT 'Total electrical service capacity of the building measured in kilovolt-amperes. Used for load planning, equipment installation approval, and utility management.',
    `emergency_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Total capacity of emergency backup generator systems in kilowatts. Critical for life safety systems, operating rooms, intensive care units, and emergency departments.',
    `emergency_generator_coverage_type` STRING COMMENT 'Scope of building systems and areas covered by emergency generator backup power. Determines operational resilience during utility outages.. Valid values are `full_building|life_safety_only|critical_systems|partial`',
    `facility_license_expiration_date` DATE COMMENT 'Expiration date of the state facility license. Tracked for renewal planning and regulatory compliance monitoring.',
    `facility_license_number` STRING COMMENT 'State-issued license number authorizing operation of healthcare services within the building. Required for regulatory compliance and reimbursement.',
    `fire_safety_classification` STRING COMMENT 'Building construction type classification based on fire resistance ratings and combustibility of structural elements per International Building Code.. Valid values are `type_i|type_ii|type_iii|type_iv|type_v`',
    `gross_square_footage` DECIMAL(18,2) COMMENT 'Total interior floor area of the building measured in square feet, including all floors and spaces. Used for space utilization analysis and facility cost allocation.',
    `helipad_available` BOOLEAN COMMENT 'Indicates whether the building has a rooftop or ground-level helipad for emergency medical transport. Critical for trauma centers and tertiary care facilities.',
    `hvac_system_type` STRING COMMENT 'Primary type of heating, ventilation, and air conditioning system serving the building. Critical for infection control, environmental services, and energy management.. Valid values are `central_chilled_water|variable_air_volume|constant_air_volume|heat_pump|split_system|packaged_unit`',
    `insurance_policy_number` STRING COMMENT 'Property and casualty insurance policy number covering the building. Used for risk management and claims processing.',
    `joint_commission_accreditation_expiration_date` DATE COMMENT 'Expiration date of The Joint Commission accreditation. Tracked for survey preparation and continuous compliance.',
    `joint_commission_accreditation_status` STRING COMMENT 'Current accreditation status from The Joint Commission indicating compliance with national healthcare quality and safety standards.. Valid values are `accredited|provisional|denied|not_applicable|pending`',
    `last_major_renovation_year` STRING COMMENT 'Year of the most recent major renovation or significant capital improvement project affecting the building structure or systems.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this building record was most recently modified. Used for audit trail and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the building in decimal degrees. Used for mapping, emergency response, and logistics planning.',
    `leed_certification_level` STRING COMMENT 'Level of LEED green building certification achieved by the building. Indicates sustainability performance and environmental design standards.. Valid values are `certified|silver|gold|platinum|not_certified`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the building in decimal degrees. Used for mapping, emergency response, and logistics planning.',
    `medical_gas_system_installed` BOOLEAN COMMENT 'Indicates whether the building has a medical gas distribution system for oxygen, medical air, nitrous oxide, and vacuum services. Required for clinical buildings.',
    `building_name` STRING COMMENT 'Official name of the building as recognized by the organization and used in signage, wayfinding, and facility documentation.',
    `net_usable_square_footage` DECIMAL(18,2) COMMENT 'Usable interior floor area excluding mechanical spaces, circulation, and structural elements. Used for space planning and departmental allocation.',
    `number_of_elevators` STRING COMMENT 'Total count of passenger and service elevators installed in the building. Used for vertical transportation capacity planning and maintenance scheduling.',
    `number_of_floors` STRING COMMENT 'Total count of floors in the building including basement and sub-basement levels. Used for elevator planning, emergency evacuation, and vertical transportation analysis.',
    `operational_status` STRING COMMENT 'Current operational state of the building indicating whether it is in service, under construction, renovation, or decommissioned.. Valid values are `active|inactive|under_construction|under_renovation|decommissioned|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership or control arrangement for the building. Impacts financial reporting, capital planning, and operational decision-making.. Valid values are `owned|leased|ground_lease|joint_venture|managed`',
    `parking_spaces_count` STRING COMMENT 'Total number of parking spaces associated with or adjacent to the building. Used for access planning, patient experience, and workforce management.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the building location. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `property_tax_parcel_number` STRING COMMENT 'Local government assessor parcel number used for property tax assessment and real estate records.',
    `replacement_value_amount` DECIMAL(18,2) COMMENT 'Estimated cost to replace the building at current construction prices. Used for insurance coverage determination and capital planning.',
    `seismic_zone` STRING COMMENT 'Seismic design category or zone classification indicating the level of earthquake risk and required structural design standards for the building location.. Valid values are `zone_0|zone_1|zone_2|zone_3|zone_4`',
    `sprinkler_system_type` STRING COMMENT 'Type of automatic fire sprinkler system installed in the building. Critical for fire safety compliance and insurance underwriting.. Valid values are `wet_pipe|dry_pipe|pre_action|deluge|none`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the building is located. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the building was decommissioned, sold, or otherwise removed from active service. Null for active buildings.',
    `building_type` STRING COMMENT 'Primary functional classification of the building indicating its predominant use within the healthcare delivery network.. Valid values are `clinical|administrative|research|parking|mixed_use|support`',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Physical building or structure associated with a care site. Tracks building name, code, address, construction year, square footage, number of floors, building type (clinical, administrative, research, parking), fire safety classification, seismic zone, HVAC system type, electrical capacity, emergency generator coverage, and current operational status. Supports facilities management, capital planning, and environmental services operations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique identifier for the clinical or administrative unit within the healthcare facility. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the parent facility or building where this unit is located. Links to the facility master data product.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Unit management accountability requires linking the manager to their clinician record for credentialing verification, privileging status, and regulatory reporting. Hospitals must track which credentia',
    `accepts_admissions` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is currently accepting new patient admissions. False when the unit is at capacity, under diversion, or temporarily closed to new admissions.',
    `accepts_transfers` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is currently accepting patient transfers from other units or facilities. Used in bed management and patient flow coordination.',
    `acuity_level` STRING COMMENT 'Typical patient acuity level served by the unit. Critical (ICU, CCU), acute (step-down, telemetry), intermediate (med-surg), general (rehab, skilled nursing), ambulatory (outpatient clinics).. Valid values are `critical|acute|intermediate|general|ambulatory`',
    `age_restriction` STRING COMMENT 'Age restriction policy for the unit. Pediatric-only (NICU, PICU, pediatric floors), adult-only (most general units), geriatric-only (specialized elder care), or all ages (ED, some outpatient clinics).. Valid values are `pediatric_only|adult_only|geriatric_only|all_ages`',
    `air_changes_per_hour` STRING COMMENT 'Number of complete air changes per hour in the unit. Minimum 6 ACH for general patient rooms, 12+ ACH for isolation rooms, 15+ ACH for operating rooms per ASHRAE and CDC guidelines.',
    `chest_pain_center_accreditation` BOOLEAN COMMENT 'Boolean flag indicating whether the unit (typically ED or cardiac unit) holds accreditation as a Chest Pain Center from the American College of Cardiology or Society of Cardiovascular Patient Care.',
    `unit_code` STRING COMMENT 'Short alphanumeric code used to identify the unit in operational systems, scheduling, and Admit Discharge Transfer (ADT) workflows. Typically 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit record was first created in the system. Used for audit trail and data lineage tracking.',
    `department_code` STRING COMMENT 'Short alphanumeric department code used in operational systems for grouping units into clinical or administrative departments. Used for reporting, scheduling, and organizational hierarchy.. Valid values are `^[A-Z0-9]{2,8}$`',
    `effective_date` DATE COMMENT 'Date when the unit became operational or when the current configuration became effective. Used for historical tracking and regulatory reporting.',
    `electronic_health_record_system` STRING COMMENT 'Name and version of the Electronic Health Record (EHR) system used in the unit, such as Epic Hyperspace 2023, Cerner Millennium PowerChart, or MEDITECH Expanse. Used for interoperability and training planning.',
    `emergency_power_backup` BOOLEAN COMMENT 'Boolean flag indicating whether the unit has emergency generator backup power. Required for critical care units (ICU, OR, ED, NICU) per NFPA 99 and Joint Commission Life Safety Standards.',
    `expiration_date` DATE COMMENT 'Date when the unit was closed, decommissioned, or when the current configuration expired. Null for active units. Used for historical tracking and capacity planning.',
    `floor_number` STRING COMMENT 'Physical floor or level within the building where the unit is located. May be numeric (1, 2, 3) or alphanumeric (G for ground, B1 for basement 1, M for mezzanine).',
    `gender_restriction` STRING COMMENT 'Gender restriction policy for the unit. Male-only or female-only for certain inpatient units (e.g., obstetrics, urology). Mixed for most units. Not applicable for procedural or diagnostic units.. Valid values are `male_only|female_only|mixed|not_applicable`',
    `hvac_system_type` STRING COMMENT 'Type of HVAC system serving the unit, such as Central Air, Variable Air Volume (VAV), Dedicated Outdoor Air System (DOAS), or Negative Pressure Isolation System. Critical for infection control and environmental safety.',
    `infection_control_zone` STRING COMMENT 'Infection control risk classification for the unit. Standard (general units), enhanced (oncology, transplant), high-risk (ICU, burn unit), isolation (dedicated infectious disease units). Drives environmental services protocols.. Valid values are `standard|enhanced|high_risk|isolation`',
    `is_twenty_four_seven` BOOLEAN COMMENT 'Boolean flag indicating whether the unit operates 24 hours a day, 7 days a week. True for ICU, ED, inpatient floors. False for outpatient clinics, procedural units with scheduled hours.',
    `isolation_room_count` STRING COMMENT 'Number of isolation rooms within the unit designed for patients requiring infection control precautions (contact, droplet, or airborne isolation). Critical for infection prevention and Healthcare-Associated Infection (HAI) management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit record was last updated in the system. Used for audit trail, change tracking, and data quality monitoring.',
    `licensed_bed_count` STRING COMMENT 'Total number of beds the unit is licensed to operate by state or federal regulatory authorities. This is the maximum legal capacity and is reported to CMS and state health departments.',
    `magnet_recognition` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is part of a Magnet-recognized nursing program by the American Nurses Credentialing Center (ANCC). Magnet recognition signifies excellence in nursing care and patient outcomes.',
    `medical_gas_system` STRING COMMENT 'Type of medical gas system installed in the unit, such as Oxygen, Medical Air, Vacuum, Full Surgical Suite Gases (O2, N2O, Medical Air, Vacuum), or None. Critical for clinical operations and safety inspections.',
    `unit_name` STRING COMMENT 'Full descriptive name of the unit, such as Medical Surgical Floor 3 West, Intensive Care Unit (ICU) North, Emergency Department (ED) Main, or Operating Room (OR) Suite B.',
    `negative_pressure_room_count` STRING COMMENT 'Number of negative pressure (airborne infection isolation) rooms within the unit, used for patients with airborne infectious diseases such as tuberculosis, measles, or COVID-19. Subset of isolation rooms.',
    `nurse_call_system_type` STRING COMMENT 'Type of nurse call system installed in the unit, such as Wired Pillow Speaker, Wireless Badge System, Integrated EMR Alert System, or Mobile App-Based. Used for patient safety and response time monitoring.',
    `nurse_to_patient_ratio` STRING COMMENT 'Target nurse-to-patient staffing ratio for the unit, expressed as 1:X (e.g., 1:2 for ICU, 1:4 for step-down, 1:6 for med-surg). Used for staffing planning and quality benchmarking.. Valid values are `^1:[0-9]{1,2}$`',
    `operational_hours_end` STRING COMMENT 'Daily end time for unit operations in HH:MM 24-hour format. For 24/7 units, this is typically 23:59. For outpatient or procedural units, this reflects scheduled closing time.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_hours_start` STRING COMMENT 'Daily start time for unit operations in HH:MM 24-hour format. For 24/7 units (ICU, ED), this is typically 00:00. For outpatient or procedural units, this reflects scheduled opening time.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `revenue_center_code` STRING COMMENT 'Four-digit revenue center code used on UB-04 claims for billing and reimbursement. Maps to CMS revenue code standards (e.g., 0100-0219 for room and board, 0300-0329 for laboratory).. Valid values are `^[0-9]{4}$`',
    `specialty_service_line` STRING COMMENT 'Clinical specialty or service line associated with the unit, such as Cardiology, Oncology, Pediatrics, Orthopedics, Neurology, General Surgery, Obstetrics, or Behavioral Health. Supports clinical analytics and resource planning.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the units physical space. Used for facility planning, space utilization analysis, and environmental services scheduling.',
    `staffed_bed_count` STRING COMMENT 'Number of beds currently staffed and available for patient occupancy. Staffed bed count is typically less than or equal to licensed bed count and reflects actual operational capacity based on workforce availability.',
    `unit_status` STRING COMMENT 'Current operational status of the unit. Active units are open and accepting patients. Inactive or temporarily closed units are not operational. Under construction units are being built or renovated. Decommissioned units are permanently closed.. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned`',
    `stroke_center_designation` STRING COMMENT 'Stroke center certification level for units providing acute stroke care. Comprehensive (highest), primary, acute stroke ready, or not designated. Impacts patient routing and quality reporting.. Valid values are `comprehensive|primary|acute_ready|not_designated`',
    `teaching_unit_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is designated as a teaching unit where medical residents, fellows, nursing students, or other trainees receive clinical education. Impacts staffing models and documentation requirements.',
    `telemetry_monitoring_capability` BOOLEAN COMMENT 'Boolean flag indicating whether the unit has continuous cardiac telemetry monitoring capability. True for ICU, CCU, step-down, and telemetry units. False for general med-surg and outpatient units.',
    `trauma_level` STRING COMMENT 'Trauma center level designation for Emergency Department (ED) units. Level 1 is highest capability (comprehensive trauma care), Level 4 is basic. Not applicable for non-ED units.. Valid values are `level_1|level_2|level_3|level_4|not_applicable`',
    `unit_type` STRING COMMENT 'High-level classification of the units operational purpose: inpatient (patient stays overnight), outpatient (same-day care), procedural (OR, cath lab), diagnostic (radiology, lab), administrative (offices), or support (pharmacy, supply).. Valid values are `inpatient|outpatient|procedural|diagnostic|administrative|support`',
    `wing_or_section` STRING COMMENT 'Wing, section, or zone designation within the floor, such as North, South, East, West, Tower A, Pavilion B. Used for wayfinding and spatial organization.',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Clinical or administrative unit within a building, such as ICU, ED, OR suite, NICU, med-surg floor, radiology department, pharmacy, or administrative wing. Captures unit name, unit code, unit type (inpatient, outpatient, procedural, diagnostic, administrative), specialty service line, licensed bed count, staffed bed count, isolation room count, negative pressure room count, unit manager, and operational hours. Supports ADT workflows, bed management, and staffing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the room. Primary key for the room entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the parent facility or hospital where this room is located. Links to the facility master data.',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center to which room occupancy and maintenance costs are allocated. Supports revenue cycle management and financial reporting.',
    `unit_id` BIGINT COMMENT 'Reference to the parent unit or department within the facility where this room is located. Links to the unit master data.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or service line that has primary operational responsibility for this room. Used for scheduling, cost allocation, and resource management.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the room by relevant accrediting bodies (e.g., The Joint Commission, AAAHC). Impacts operational authorization and reimbursement eligibility.. Valid values are `accredited|provisional|not_accredited|pending`',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the room is currently active and available for use in operational systems. Supports soft-delete patterns and historical record retention.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility requirements for patients and staff with disabilities. Required for regulatory compliance and patient access.',
    `bariatric_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped and structurally reinforced to accommodate bariatric patients (typically over 350 lbs). Includes specialized beds, lifts, and wider doorways.',
    `bed_count` STRING COMMENT 'Number of patient beds or stretchers that can be accommodated in the room. Used for bed management, capacity planning, and CMS reporting.',
    `boom_configuration` STRING COMMENT 'Description of ceiling-mounted equipment boom configuration in the room (e.g., single boom, dual boom, articulating arm). Relevant for OR and ICU rooms with suspended equipment.',
    `class` STRING COMMENT 'Classification of the room based on occupancy and privacy level. Impacts billing, patient preference, and infection control protocols.. Valid values are `private|semi_private|ward|suite|isolation|observation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the room record was first created in the system. Audit trail for data lineage and compliance.',
    `effective_from_date` DATE COMMENT 'Date from which the current room configuration, assignment, or status became effective. Supports temporal tracking and historical analysis.',
    `effective_to_date` DATE COMMENT 'Date until which the current room configuration, assignment, or status is valid. Null indicates current/active record. Supports temporal tracking and historical analysis.',
    `emergency_power_flag` BOOLEAN COMMENT 'Indicates whether the room is connected to emergency backup power systems. Critical for life-safety equipment in ORs, ICUs, and emergency departments.',
    `hand_hygiene_station_count` STRING COMMENT 'Number of hand hygiene stations (sinks or alcohol-based hand rub dispensers) in the room. Critical for infection prevention compliance and Joint Commission accreditation.',
    `hvac_air_exchange_rate` DECIMAL(18,2) COMMENT 'Number of complete air changes per hour (ACH) provided by the HVAC system. Critical for infection control, OR sterility, and regulatory compliance per ASHRAE 170.',
    `imaging_integration_flag` BOOLEAN COMMENT 'Indicates whether the room has integrated imaging equipment (e.g., C-arm, fluoroscopy, intraoperative CT/MRI). Common in hybrid ORs and interventional procedure rooms.',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped and certified for isolation of infectious patients. Critical for infection prevention and control workflows.',
    `last_deep_clean_date` DATE COMMENT 'Date of the most recent terminal or deep cleaning of the room. Used for infection prevention tracking, environmental services scheduling, and outbreak investigation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection of the room. Used for compliance tracking and accreditation readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the room record was last updated. Audit trail for data lineage and change tracking.',
    `lease_ownership_indicator` STRING COMMENT 'Indicates whether the room space is owned by the organization, leased from a third party, shared with another entity, or contracted. Impacts financial reporting and cost allocation.. Valid values are `owned|leased|shared|contracted`',
    `license_number` STRING COMMENT 'State or regulatory license number for the room, if applicable (e.g., for surgical suites, radiology rooms). Required for compliance and accreditation tracking.',
    `medical_air_outlet_count` STRING COMMENT 'Number of medical air outlets for compressed air delivery. Used for respiratory therapy and surgical equipment.',
    `monthly_space_cost` DECIMAL(18,2) COMMENT 'Allocated monthly cost for the room space, including lease payments, depreciation, utilities, and maintenance. Used for cost center chargebacks and financial analysis.',
    `room_name` STRING COMMENT 'Human-readable name or description of the room, often used for scheduling and communication (e.g., Cardiac Cath Lab 1, Pediatric Exam Room B).',
    `negative_pressure_flag` BOOLEAN COMMENT 'Indicates whether the room has negative pressure ventilation to prevent airborne pathogen spread. Required for airborne isolation (e.g., tuberculosis, COVID-19).',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the room or its equipment. Supports biomedical engineering and facilities management workflows.',
    `nitrous_oxide_outlet_count` STRING COMMENT 'Number of nitrous oxide gas outlets. Typically present in operating rooms and dental procedure rooms for anesthesia delivery.',
    `number` STRING COMMENT 'The official room number or identifier used for wayfinding, signage, and operational reference. May include alphanumeric codes (e.g., 3A-201, OR-5, ICU-12).',
    `nurse_call_system_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped with a nurse call system for patient-to-staff communication. Standard for patient rooms and required for CMS compliance.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of time the room is occupied over a reporting period. Key performance indicator for space utilization and capacity management.',
    `or_airflow_class` STRING COMMENT 'ISO cleanroom classification for operating room air quality and particulate control. Defines laminar airflow requirements for surgical sterility. Applicable only to OR rooms.. Valid values are `iso_5|iso_6|iso_7|iso_8|standard`',
    `oxygen_outlet_count` STRING COMMENT 'Number of medical gas outlets for oxygen delivery. Essential for patient care capacity planning and emergency preparedness.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the room measured in square feet. Used for space utilization analysis, cost allocation, and compliance with facility design standards.',
    `room_status` STRING COMMENT 'Current operational status of the room. Drives bed management, ADT workflows, and scheduling availability.. Valid values are `available|occupied|cleaning|out_of_service|maintenance|reserved`',
    `telemetry_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped with telemetry monitoring infrastructure for continuous cardiac and vital sign monitoring.',
    `room_type` STRING COMMENT 'Classification of the room based on its primary clinical or operational function. Determines equipment requirements, staffing, and scheduling rules. [ENUM-REF-CANDIDATE: patient|operating_room|procedure_room|exam_room|consultation_room|support_room|isolation_room|negative_pressure_room — 8 candidates stripped; promote to reference product]',
    `vacuum_outlet_count` STRING COMMENT 'Number of medical vacuum outlets for suctioning. Required for surgical, procedural, and critical care rooms.',
    `ventilator_outlet_count` STRING COMMENT 'Number of electrical outlets dedicated to ventilator equipment. Critical for ICU and critical care room planning and patient placement.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Individual room within a unit, including patient rooms, procedure rooms, operating rooms (OR suites with laminar airflow class, imaging integration, boom configuration), exam rooms, consultation rooms, and support rooms. Tracks room number, room name, room type (patient, OR, procedure, exam, consultation, support, isolation, negative pressure), room class (private, semi-private, ward), square footage, isolation capability, negative pressure flag, telemetry capability, ventilator outlet count, medical gas outlets (O2, vacuum, air, N2O), hand hygiene station count, OR-specific features (airflow class, HVAC air exchange rate per ASHRAE 170, equipment inventory), current room status (available, occupied, cleaning, out-of-service), last deep-clean date, and assigned department. Also captures space allocation and occupancy assignments linking rooms to departments, cost centers, and service lines with effective dating, allocated square footage, occupancy percentage, lease/ownership indicator, and monthly space cost. Supports ADT workflows, perioperative scheduling, bed management, space utilization analysis, infection prevention (isolation room tracking), and cost center chargebacks.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed` (
    `bed_id` BIGINT COMMENT 'Unique identifier for the individual patient bed. Primary key for the bed entity.',
    `building_id` BIGINT COMMENT 'FK to facility.building',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this bed is located.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient currently assigned to this bed. Null when bed status is available, dirty, blocked, or out_of_service. Links to Master Patient Index (MPI) for ADT event tracking.',
    `room_id` BIGINT COMMENT 'Reference to the specific room or unit where this bed is physically located.',
    `unit_id` BIGINT COMMENT 'FK to facility.unit',
    `visit_id` BIGINT COMMENT 'Reference to the current inpatient visit or encounter associated with the bed assignment. Null when bed is unoccupied. Used for linking bed utilization to clinical and billing events.',
    `age_restriction` STRING COMMENT 'Age-based restriction for patient assignment to this bed, driven by clinical care model and equipment. Values: adult (18+ years), pediatric (0-17 years), neonatal (newborn to 28 days), any (no restriction).. Valid values are `adult|pediatric|neonatal|any`',
    `asset_tag` STRING COMMENT 'Physical asset tag or serial number affixed to the bed frame for equipment tracking, preventive maintenance scheduling, and biomedical engineering inventory management.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the current patient was assigned to this bed. Used for calculating patient length of stay in specific bed/unit and bed utilization analytics.',
    `blocked_reason` STRING COMMENT 'Free-text explanation for why the bed is administratively blocked from patient assignment (e.g., construction, equipment failure, infection control hold, staffing shortage). Populated only when bed_status is blocked.',
    `bed_category` STRING COMMENT 'Clinical service line or specialty category of the bed. Used for capacity planning by service line, regulatory reporting, and patient placement algorithms. Values: medical, surgical, pediatric, maternity, psychiatric, rehabilitation.. Valid values are `medical|surgical|pediatric|maternity|psychiatric|rehabilitation`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bed record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `discharge_ready_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical team marked the patient as medically ready for discharge. Used to calculate discharge delays, bed turnover bottlenecks, and length of stay (LOS) optimization metrics.',
    `effective_end_date` DATE COMMENT 'Date when the bed was permanently removed from service or decommissioned. Null for active beds. Used for historical capacity reporting and facility planning analysis.',
    `effective_start_date` DATE COMMENT 'Date when the bed was first placed into service or added to the facility inventory. Used for bed lifecycle tracking and historical capacity analysis.',
    `expected_available_timestamp` TIMESTAMP COMMENT 'Estimated date and time when a currently unavailable bed (dirty, blocked, out_of_service, housekeeping) is expected to become available for patient assignment. Used for bed demand forecasting and patient placement planning.',
    `floor_number` STRING COMMENT 'Physical floor or level within the facility where the bed is located (e.g., 1, 2, 3, B1 for basement, G for ground). Used for wayfinding, emergency response, and facility planning.',
    `gender_restriction` STRING COMMENT 'Gender restriction for patient assignment to this bed, typically driven by shared room configurations or unit policies. Values: male (male patients only), female (female patients only), any (no restriction).. Valid values are `male|female|any`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the bed record is currently active in the system. Inactive beds are permanently removed from inventory (e.g., facility closure, unit reconfiguration). Used for historical reporting and capacity trend analysis.',
    `is_air_fluidized` BOOLEAN COMMENT 'Indicates whether the bed is an air-fluidized therapy bed used for severe pressure ulcer treatment and prevention. Specialized equipment requiring clinical justification and authorization.',
    `is_bariatric_capable` BOOLEAN COMMENT 'Indicates whether the bed is equipped to safely accommodate bariatric patients (typically weight capacity 350+ lbs). Impacts patient placement decisions and equipment requirements.',
    `is_isolation_capable` BOOLEAN COMMENT 'Indicates whether the bed is in a room suitable for isolation precautions (contact, droplet, or airborne). Supports infection control protocols and patient placement decisions.',
    `is_licensed` BOOLEAN COMMENT 'Indicates whether the bed is included in the facilitys licensed bed count as approved by state health department. Impacts regulatory reporting, reimbursement, and capacity planning.',
    `is_low_bed` BOOLEAN COMMENT 'Indicates whether the bed is a low-height bed designed for fall prevention, typically used for high-risk patients (elderly, confused, post-operative). Supports patient safety protocols.',
    `is_negative_pressure_room` BOOLEAN COMMENT 'Indicates whether the bed is located in a negative pressure isolation room designed for airborne infection control (e.g., tuberculosis, COVID-19, measles). Critical for infection prevention and control.',
    `is_private_room` BOOLEAN COMMENT 'Indicates whether the bed is in a private (single-occupancy) room. Impacts patient satisfaction, infection control, and room charge billing.',
    `is_staffed` BOOLEAN COMMENT 'Indicates whether the bed is currently staffed and operationally available for patient assignment. A bed may be licensed but not staffed due to nursing shortages or seasonal demand fluctuations.',
    `is_telemetry_capable` BOOLEAN COMMENT 'Indicates whether the bed location is equipped with continuous cardiac telemetry monitoring capability. Determines appropriate placement for patients requiring cardiac monitoring.',
    `label` STRING COMMENT 'Human-readable identifier for the bed, typically including unit, room, and bed position (e.g., 4-West-201-A, ICU-12-B, ED-Bay-3). Used for operational communication and bed board displays.',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Date and time when environmental services completed cleaning and disinfection of the bed and room. Critical for infection control, bed turnover tracking, and housekeeping performance metrics.',
    `last_maintenance_date` DATE COMMENT 'Date when the bed last received preventive maintenance inspection by biomedical engineering or facilities management. Used for compliance with equipment maintenance schedules and patient safety protocols.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this bed record was most recently modified. Audit field for change tracking and data quality monitoring.',
    `next_maintenance_due_date` DATE COMMENT 'Date when the bed is next scheduled for preventive maintenance inspection. Used for proactive maintenance planning and regulatory compliance tracking.',
    `out_of_service_reason` STRING COMMENT 'Free-text explanation for why the bed is out of service (e.g., biomedical equipment repair, structural maintenance, permanent closure). Populated only when bed_status is out_of_service.',
    `position` STRING COMMENT 'Position identifier within a multi-bed room (e.g., A, B, C, 1, 2, Window, Door). Used for precise bed identification and patient placement communication.',
    `bed_status` STRING COMMENT 'Current operational status of the bed. Core field for real-time bed management and ADT (Admit, Discharge, Transfer) operations. Values: available (ready for patient assignment), occupied (patient currently assigned), dirty (patient discharged, awaiting environmental services cleaning), blocked (administratively held), out_of_service (maintenance or repair required), housekeeping (cleaning in progress).. Valid values are `available|occupied|dirty|blocked|out_of_service|housekeeping`',
    `status_timestamp` TIMESTAMP COMMENT 'Date and time when the bed last changed status. Critical for calculating discharge-to-clean cycle time, bed turnover metrics, and hospital command center operations.',
    `bed_type` STRING COMMENT 'Classification of the bed based on clinical care level and purpose. Determines staffing ratios, reimbursement categories, and capacity reporting. Values: acute (general medical-surgical), icu (intensive care unit), observation (short-stay monitoring), ed (emergency department), or_table (operating room table), procedure (procedure room bed), bariatric (high weight capacity), low_bed (fall prevention), bassinet (neonatal/pediatric). [ENUM-REF-CANDIDATE: acute|icu|observation|ed|or_table|procedure|bariatric|low_bed|bassinet — 9 candidates stripped; promote to reference product]',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum safe patient weight capacity of the bed in pounds. Used for patient placement decisions and equipment safety compliance. Standard beds typically 350-500 lbs, bariatric beds 500-1000+ lbs.',
    CONSTRAINT pk_bed PRIMARY KEY(`bed_id`)
) COMMENT 'Individual patient bed within a room. Captures bed label (e.g., 4-West-201-A), bed type (acute, ICU, observation, ED, OR table, procedure, bariatric, low-bed, bassinet/crib), bed status (available, occupied, dirty, blocked, out-of-service, housekeeping-in-progress), bed feature flags (bariatric-capable, low-bed, air-fluidized, telemetry-capable, negative-pressure-room, isolation), last status change timestamp, current patient assignment reference, and discharge-ready timestamp. Core entity for real-time bed management, ADT operations, capacity planning, and discharge-to-clean cycle time tracking. Supports bed board dashboards, hospital command center operations, and CMS bed count reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` (
    `bed_status_event_id` BIGINT COMMENT 'Unique identifier for each bed status change event. Primary key for the bed status event transactional record.',
    `bed_id` BIGINT COMMENT 'Reference to the specific bed that experienced the status change. Links to the bed master resource.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the bed is located. Supports multi-site integrated delivery network tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the system user (nurse, environmental services staff, bed coordinator) who triggered the status change event.',
    `environmental_service_request_id` BIGINT COMMENT 'Reference to the environmental services work order created for bed cleaning. Enables discharge-to-clean cycle time tracking.',
    `maintenance_order_id` BIGINT COMMENT 'Reference to the biomedical engineering or facilities maintenance work order if the bed requires repair or preventive maintenance.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with this bed status event (e.g., patient being admitted or discharged). Null for non-patient-related events like maintenance.',
    `unit_id` BIGINT COMMENT 'Reference to the nursing unit or department where the bed resides (e.g., ICU, ED, Medical-Surgical).',
    `room_id` BIGINT COMMENT 'Reference to the specific room containing the bed. Supports room-level capacity and configuration tracking.',
    `visit_id` BIGINT COMMENT 'Reference to the specific patient encounter or visit associated with this bed event. Links to ADT (Admit-Discharge-Transfer) workflow.',
    `actual_availability_timestamp` TIMESTAMP COMMENT 'Actual date and time when the bed became available after cleaning or maintenance. Enables cycle time variance analysis.',
    `acuity_level` STRING COMMENT 'Clinical acuity level associated with the bed at the time of the event. Aligns bed capacity with patient care intensity requirements.. Valid values are `critical|acute|intermediate|observation|general`',
    `adt_event_type` STRING COMMENT 'Type of ADT event that triggered this bed status change. Aligns with HL7 ADT message types for interoperability.. Valid values are `admit|discharge|transfer|cancel|update`',
    `bed_assignment_method` STRING COMMENT 'Method used to assign or change the bed status (manual by staff, automated by system algorithm, or hybrid). Supports workflow optimization analysis.. Valid values are `manual|automated|hybrid`',
    `blocked_reason_category` STRING COMMENT 'High-level category for why a bed is blocked or unavailable. Supports root cause analysis of capacity constraints.. Valid values are `construction|equipment_failure|staffing_shortage|infection_control|administrative|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bed status event record was first created in the system. Supports audit trail and data lineage tracking.',
    `duration_minutes` STRING COMMENT 'Duration in minutes that the bed remained in the prior status before this event. Calculated field for cycle time analysis.',
    `event_sequence_number` STRING COMMENT 'Sequential number indicating the order of status changes for this bed. Supports chronological event reconstruction and audit trails.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the bed status change occurred. Critical for discharge-to-clean cycle time analysis and real-time bed board operations.',
    `expected_availability_timestamp` TIMESTAMP COMMENT 'Projected date and time when the bed will become available for the next patient. Used for bed turnover forecasting and transfer planning.',
    `initiating_user_role` STRING COMMENT 'Role or job function of the user who initiated the status change (e.g., Registered Nurse, Environmental Services Technician, Bed Coordinator).',
    `is_elective_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is related to a scheduled or elective admission (e.g., planned surgery).',
    `is_emergency_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is related to an emergency department admission or urgent care scenario.',
    `isolation_type` STRING COMMENT 'Type of infection control isolation precaution applied to the bed (e.g., contact, droplet, airborne, protective). Critical for infection prevention and bed assignment logic.. Valid values are `contact|droplet|airborne|protective|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bed status event record was last updated. Enables change tracking and data quality monitoring.',
    `new_status_code` STRING COMMENT 'The bed status after this event. Core field for real-time bed availability tracking and capacity management. [ENUM-REF-CANDIDATE: occupied|available|cleaning|maintenance|blocked|reserved|isolation — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments entered by staff regarding this bed status change. Provides qualitative context for operational review.',
    `prior_status_code` STRING COMMENT 'The bed status immediately before this event. Enables state transition analysis and workflow tracking. [ENUM-REF-CANDIDATE: occupied|available|cleaning|maintenance|blocked|reserved|isolation — 7 candidates stripped; promote to reference product]',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is high-priority (e.g., emergency department hold, urgent transfer). Supports command center escalation workflows.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the bed status changed (e.g., patient discharge, cleaning request, maintenance hold, isolation precaution, blocked for construction, reserved for transfer). [ENUM-REF-CANDIDATE: patient_discharge|patient_admission|cleaning_request|maintenance_hold|isolation_precaution|construction_block|transfer_reserved|emergency_hold — 8 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text explanation providing additional context for the status change. Supplements the standardized reason code.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system that generated this bed status event (e.g., Epic ADT, Cerner Millennium, bed management system).',
    `source_system_event_code` STRING COMMENT 'Unique identifier from the source system for this event. Enables traceability and reconciliation with operational systems.',
    CONSTRAINT pk_bed_status_event PRIMARY KEY(`bed_status_event_id`)
) COMMENT 'Transactional record of every bed status change event, capturing the bed reference, prior status, new status, reason code (patient discharge, cleaning request, maintenance hold, isolation precaution, blocked for construction, reserved for transfer), timestamp, initiating user, and associated housekeeping or maintenance work order reference. Enables real-time bed board operations, discharge-to-clean cycle time analysis, average length of stay (ALOS) tracking, and throughput optimization. Supports ADT event-driven workflows and hospital command center dashboards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`or_suite` (
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the operating room suite. Primary key for the OR suite master data.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: OR suites are physical spaces within buildings. Adding building_id enables facility management operations (building maintenance schedules, HVAC systems, emergency power), space planning, and building-',
    `care_site_id` BIGINT COMMENT 'Reference to the parent healthcare facility or hospital campus where this OR suite is located. Links to the facility master for multi-site integrated delivery networks.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: OR suites are clinical units within the facility hierarchy. Adding unit_id enables proper organizational hierarchy (care_site → building → unit → OR suite) and supports unit-level operational reportin',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the OR suite or parent surgical services program by The Joint Commission (TJC), AAAHC, or other accrediting body. Accreditation is required for many payer contracts and demonstrates compliance with quality and safety standards.. Valid values are `accredited|provisional|not_accredited|pending_survey`',
    `anesthesia_machine_model` STRING COMMENT 'Manufacturer and model of the anesthesia delivery system installed in the OR. Critical for anesthesia provider training, maintenance scheduling, and gas scavenging system compatibility.',
    `boom_configuration` STRING COMMENT 'Type and configuration of ceiling-mounted or wall-mounted booms for surgical lights, anesthesia equipment, monitors, and power/data connections. Dual booms provide greater flexibility for complex procedures. Configuration impacts room layout and equipment access.. Valid values are `none|single_ceiling_boom|dual_ceiling_boom|articulating_arm|wall_mounted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this OR suite record was first created in the system. Used for audit trail and data lineage tracking.',
    `emergency_power_backup_flag` BOOLEAN COMMENT 'Indicates whether the OR is connected to the emergency power system (generator or UPS) to maintain critical functions during power outages. Required for life safety and continuation of surgical procedures.',
    `emergency_use_flag` BOOLEAN COMMENT 'Indicates whether this OR is designated for emergency and trauma cases. Emergency ORs are held open or have priority access rules in surgical scheduling systems to ensure rapid availability for urgent cases.',
    `equipment_inventory_list` STRING COMMENT 'Comma-separated or structured list of major fixed and mobile equipment assigned to this OR suite (e.g., surgical table model, anesthesia machine, electrosurgical unit, video tower, microscope). Used for preventive maintenance scheduling and equipment tracking.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed in the OR suite. Clean agent systems (e.g., FM-200, Novec 1230) are preferred for ORs to avoid water damage to sensitive equipment. Sprinkler systems are common but may require equipment protection. Critical for life safety and regulatory compliance.. Valid values are `sprinkler|clean_agent|water_mist|none`',
    `hvac_air_exchange_rate_per_hour` STRING COMMENT 'Number of complete air changes per hour in the operating room. Minimum 15 air changes per hour is required for ORs per FGI guidelines; higher rates (20-25) are used in ultra-clean environments. Critical for infection control and regulatory compliance.',
    `imaging_integration_type` STRING COMMENT 'Type of intraoperative imaging equipment integrated into the OR suite. Hybrid ORs combine surgical and interventional radiology capabilities. C-arm fluoroscopy is common in orthopedic and spine procedures. Intraoperative MRI/CT enable real-time image-guided neurosurgery.. Valid values are `none|c_arm|intraoperative_mri|intraoperative_ct|fluoroscopy|hybrid_angio`',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates whether the OR can be configured for airborne or contact isolation procedures (e.g., negative pressure for tuberculosis cases, enhanced PPE protocols for infectious diseases). Critical for infection control and pandemic preparedness.',
    `laminar_airflow_class` STRING COMMENT 'ISO 14644-1 cleanroom classification for the operating room air quality. ISO Class 5 (Class 100) is the highest standard for ultra-clean orthopedic and implant surgeries. ISO Class 7 (Class 10,000) is typical for general surgery. Laminar airflow reduces surgical site infection (SSI) risk.. Valid values are `iso_5|iso_6|iso_7|iso_8|standard`',
    `last_accreditation_survey_date` DATE COMMENT 'Date of the most recent accreditation survey or inspection for the surgical services program. Used to track compliance cycles and prepare for upcoming surveys.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent completed preventive maintenance or deep cleaning cycle for the OR suite. Used to track compliance with maintenance schedules and regulatory requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this OR suite record was most recently modified. Used for audit trail, change tracking, and data quality monitoring.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the facility license for this OR suite. Alerts compliance teams to renew licenses before expiration to avoid regulatory penalties or loss of reimbursement eligibility.',
    `license_number` STRING COMMENT 'State or local regulatory license number for the operating room suite. Required for Medicare/Medicaid reimbursement and state health department inspections. Tracked per OR or per facility depending on jurisdiction.',
    `medical_gas_outlets_count` STRING COMMENT 'Total number of medical gas outlets (oxygen, nitrous oxide, medical air, vacuum, WAGD) installed in the OR suite. Minimum outlet counts are specified by FGI guidelines based on OR type and size.',
    `next_accreditation_survey_due_date` DATE COMMENT 'Scheduled or estimated date for the next accreditation survey. Alerts quality and compliance teams to prepare documentation and conduct internal readiness assessments.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance cycle. Alerts facility management and surgical scheduling teams to plan around maintenance downtime.',
    `operational_status` STRING COMMENT 'Current operational state of the OR suite. Active ORs are available for surgical scheduling. Inactive ORs are temporarily unavailable (e.g., equipment failure, staffing shortage). Maintenance and renovation statuses block scheduling for planned downtime. Decommissioned ORs are permanently closed.. Valid values are `active|inactive|maintenance|renovation|decommissioned`',
    `or_name` STRING COMMENT 'Descriptive name for the operating room suite, may include location or specialty designation (e.g., Main OR 5, Cardiac Surgery Suite A, Hybrid OR West Wing).',
    `or_number` STRING COMMENT 'Business identifier for the operating room suite, typically displayed as OR1, OR2, OR10, etc. Used in surgical scheduling systems like Epic OpTime and Cerner SurgiNet.. Valid values are `^OR[0-9]{1,4}$`',
    `or_type` STRING COMMENT 'Classification of the operating room by surgical specialty or capability. Determines equipment requirements, staffing models, and scheduling rules. General ORs support multiple specialties; specialized ORs are configured for specific procedures.. Valid values are `general|cardiac|orthopedic|neurosurgery|hybrid|endoscopy`',
    `pediatric_capable_flag` BOOLEAN COMMENT 'Indicates whether the OR is equipped and staffed to support pediatric surgical cases. Requires specialized equipment (pediatric anesthesia circuits, warming devices, smaller instruments) and trained perioperative staff.',
    `positive_pressure_maintained_flag` BOOLEAN COMMENT 'Indicates whether the OR maintains positive air pressure relative to adjacent corridors and support spaces. Positive pressure prevents contaminated air from entering the sterile field. Required for most ORs; negative pressure is used only for airborne isolation procedures.',
    `robotic_surgery_compatible_flag` BOOLEAN COMMENT 'Indicates whether the OR suite is configured and equipped to support robotic-assisted surgical systems (e.g., da Vinci Surgical System). Requires additional space, power, and structural support.',
    `room_height_feet` DECIMAL(18,2) COMMENT 'Ceiling height of the operating room in feet. Critical for surgical light placement, boom configuration, and laminar airflow system design.',
    `room_length_feet` DECIMAL(18,2) COMMENT 'Physical length dimension of the operating room in feet. Used for space planning, equipment placement, and compliance with facility design standards.',
    `room_width_feet` DECIMAL(18,2) COMMENT 'Physical width dimension of the operating room in feet. Minimum dimensions are regulated for different OR types to ensure safe equipment access and staff movement.',
    `scheduled_maintenance_window` STRING COMMENT 'Recurring time block reserved for preventive maintenance, deep cleaning, and equipment calibration (e.g., Every Sunday 6:00 AM - 12:00 PM, First Monday of month). OR is unavailable for surgical scheduling during this window.',
    `status_effective_timestamp` TIMESTAMP COMMENT 'Date and time when the current operational status became effective. Used to track OR availability history and calculate downtime metrics for capacity management.',
    `status_reason_code` STRING COMMENT 'Coded reason for the current operational status (e.g., EQUIP_FAIL for equipment failure, STAFF_SHORT for staffing shortage, SCHED_MAINT for scheduled maintenance, RENO for renovation). Supports root cause analysis of OR unavailability.',
    `surgical_table_type` STRING COMMENT 'Model or type of the primary surgical table installed in the OR (e.g., general surgery table, orthopedic fracture table, neurosurgery head frame table, robotic surgery table). Table type determines compatible procedures and patient positioning capabilities.',
    `video_integration_capability_flag` BOOLEAN COMMENT 'Indicates whether the OR has integrated video capture, recording, and display systems for endoscopic, laparoscopic, or robotic surgery. Supports surgical education, quality review, and telemedicine consultation.',
    CONSTRAINT pk_or_suite PRIMARY KEY(`or_suite_id`)
) COMMENT 'Operating room suite configuration master, capturing OR number, OR name, OR type (general, cardiac, orthopedic, neurosurgery, hybrid, endoscopy, cath lab), room dimensions, imaging integration (C-arm, intraoperative MRI), laminar airflow class, HVAC air exchange rate, boom configuration, equipment inventory list, scheduled maintenance window, and current operational status. Supports OpTime surgical scheduling and perioperative capacity management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` (
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Normalization: equipment_asset currently has current_location_building as STRING. Replacing with building_id FK enables referential integrity, supports equipment location tracking, facilitates buildin',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site (hospital, clinic, facility) where the equipment is currently located.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Normalization: equipment_asset currently has current_location_room as STRING. Replacing with room_id FK enables referential integrity, supports room-level equipment tracking (critical for OR suites, I',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Normalization: equipment_asset currently has current_location_unit as STRING. Replacing with unit_id FK enables referential integrity, supports unit-level equipment allocation tracking, facilitates un',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical or operational department responsible for the equipment. Used for cost allocation and accountability.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or capitalized cost of the equipment in USD. Basis for depreciation and capital planning.',
    `acquisition_date` DATE COMMENT 'Date the equipment was acquired or placed into service. Used for depreciation calculations and lifecycle planning.',
    `asset_tag` STRING COMMENT 'Externally visible unique asset tag identifier affixed to the physical equipment. Used for tracking and inventory management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment requires periodic calibration to maintain measurement accuracy and regulatory compliance.',
    `current_location_floor` STRING COMMENT 'Floor level within the building where the equipment is located.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the equipment asset over its useful life.. Valid values are `straight_line|declining_balance|units_of_production|not_applicable`',
    `disposal_method` STRING COMMENT 'Method used to dispose of retired equipment. Required for environmental compliance and asset accounting.. Valid values are `sold|donated|recycled|destroyed|returned_to_vendor|not_applicable`',
    `environmental_requirements` STRING COMMENT 'Special environmental conditions required for equipment operation (temperature range, humidity, ventilation). Important for facility infrastructure planning.',
    `equipment_category` STRING COMMENT 'High-level classification of equipment type for portfolio management and reporting. [ENUM-REF-CANDIDATE: biomedical|imaging|surgical|patient_monitoring|life_support|laboratory|facility_infrastructure|sterilization|therapeutic — 9 candidates stripped; promote to reference product]',
    `equipment_name` STRING COMMENT 'Common business name or description of the equipment asset (e.g., Ventilator, MRI Scanner, Infusion Pump).',
    `equipment_type` STRING COMMENT 'Detailed equipment type or subclass within the category (e.g., CT Scanner, Infusion Pump, Defibrillator).',
    `fda_device_class` STRING COMMENT 'FDA regulatory classification indicating the level of control necessary to assure safety and effectiveness. Class I (low risk), Class II (moderate risk), Class III (high risk).. Valid values are `class_i|class_ii|class_iii|not_applicable`',
    `infection_control_category` STRING COMMENT 'Spaulding classification for infection control and sterilization requirements. Critical items enter sterile tissue, semi-critical contact mucous membranes, non-critical contact intact skin.. Valid values are `critical|semi_critical|non_critical|not_applicable`',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed and commissioned at the current or original location.',
    `last_calibration_date` DATE COMMENT 'Date when the most recent calibration was performed on this equipment.',
    `last_pm_date` DATE COMMENT 'Date when the most recent preventive maintenance was completed on this equipment.',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or original equipment manufacturer (OEM).',
    `mobility_indicator` STRING COMMENT 'Indicates whether the equipment is permanently installed (fixed), can be moved by staff (portable), or is mounted on wheels/cart (mobile). Impacts tracking and location management requirements.. Valid values are `fixed|portable|mobile`',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for this equipment type.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration activity. Overdue calibration may result in equipment being taken out of service.',
    `next_pm_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity. Critical for compliance with TJC equipment management standards.',
    `notes` STRING COMMENT 'Free-text field for additional information, special handling instructions, or historical context about the equipment asset.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment asset. Determines availability for clinical use and maintenance scheduling.. Valid values are `in_service|out_of_service|under_repair|retired|condemned|quarantined`',
    `pm_compliance_status` STRING COMMENT 'Current compliance status of preventive maintenance schedule. Overdue status triggers escalation and may impact accreditation.. Valid values are `compliant|overdue|upcoming|not_applicable`',
    `pm_frequency_days` STRING COMMENT 'Number of days between scheduled preventive maintenance activities. Determined by manufacturer recommendations and risk category.',
    `power_requirements` STRING COMMENT 'Electrical power specifications for the equipment (voltage, amperage, phase). Critical for facility planning and electrical safety.',
    `recall_date` DATE COMMENT 'Date when the FDA recall was issued for this equipment model.',
    `recall_number` STRING COMMENT 'FDA-assigned recall identification number if the equipment is subject to an active recall.',
    `recall_remediation_date` DATE COMMENT 'Date when recall remediation actions (repair, replacement, software update) were completed for this equipment unit.',
    `recall_status` STRING COMMENT 'Current FDA recall or safety alert status for this equipment. Active recalls require immediate action and reporting.. Valid values are `no_recall|active_recall|recall_remediated|under_investigation`',
    `retirement_date` DATE COMMENT 'Date when the equipment was retired from active service. Used for asset disposal tracking and capital planning.',
    `risk_category` STRING COMMENT 'Clinical and operational risk classification based on potential impact to patient safety and care delivery if equipment fails. Aligns with ECRI and AAMI risk stratification frameworks.. Valid values are `critical|high|medium|low`',
    `sap_equipment_number` STRING COMMENT 'Equipment master record number in SAP PM (Plant Maintenance) module. Primary integration key for work orders, maintenance plans, and cost tracking.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the equipment unit. Critical for warranty claims, recalls, and service history tracking.',
    `service_contract_expiration_date` DATE COMMENT 'Date when the current service contract expires. Used for contract renewal planning.',
    `service_contract_number` STRING COMMENT 'Reference number for the active service or maintenance contract covering this equipment.',
    `service_contract_vendor` STRING COMMENT 'Name of the vendor or service provider responsible for maintenance under the service contract.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for medical devices. Enables traceability throughout the device lifecycle and supports recall management.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the equipment in years for depreciation and replacement planning purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires. Critical for service contract planning and repair cost management.',
    CONSTRAINT pk_equipment_asset PRIMARY KEY(`equipment_asset_id`)
) COMMENT 'Biomedical and facility equipment asset master, representing every capital and tracked equipment item including ventilators, infusion pumps, imaging systems (CT, MRI, X-ray, ultrasound), surgical robots, patient monitors, defibrillators, sterilizers, HVAC units, generators, elevators, and fire suppression systems. Captures asset tag, serial number, manufacturer, model, FDA device class, UDI (Unique Device Identifier), acquisition date, acquisition cost, useful life, depreciation method, current location (care site, building, unit, room), assigned department, warranty expiration, service contract reference, last PM date, next PM due date, PM compliance status, risk category (critical, high, medium, low per ECRI/AAMI), recall status, and operational status (in service, out of service, retired, condemned). Integrates with SAP PM equipment master. Supports biomedical engineering asset management, capital equipment planning, FDA recall tracking, and TJC EC.02.04.01 compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key for the maintenance order entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility location (room, unit, building) where the maintenance work is to be performed. Used when work order applies to infrastructure rather than a specific asset.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance work orders incur labor and parts costs (labor_cost, parts_cost, total_cost fields present) that must be charged to a specific cost center for financial reporting, budget tracking, and var',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the specific facility asset or biomedical equipment that is the subject of this maintenance work order. Links to the asset master data for equipment specifications and history.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule definition that generated this work order. Null for corrective, emergency, or ad-hoc work orders. Links to the PM schedule template for compliance tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the facilities or biomedical engineering technician assigned to execute this maintenance work order. Links to workforce/employee master data.',
    `tertiary_maintenance_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or approver who authorized the maintenance work order. Null if no approval was required or if work order is pending approval.',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or contractor who performed the maintenance work. Null for work performed by internal staff. Links to vendor master data.',
    `actual_completion_datetime` TIMESTAMP COMMENT 'Actual date and time when the maintenance work was completed and the asset or location was returned to service. Used for calculating actual labor duration and PM compliance rates.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the technician began work on the maintenance order. Captured by technician check-in or mobile work order system.',
    `approval_datetime` TIMESTAMP COMMENT 'Date and time when the maintenance work order was approved. Used for tracking approval cycle time and work order lifecycle metrics.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order requires management or budget approval before work can commence. Typically true for high-cost repairs or capital improvements.',
    `completion_notes` STRING COMMENT 'Detailed narrative notes entered by the technician upon work order completion, documenting work performed, parts replaced, findings, and any follow-up recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was first created in the data platform. Used for data lineage and audit trail purposes.',
    `downtime_minutes` STRING COMMENT 'Total duration in minutes that the asset or location was out of service due to this maintenance activity. Used for calculating equipment availability and operational impact metrics.',
    `failure_code` STRING COMMENT 'Standardized code classifying the type of equipment failure or maintenance issue. Used for failure mode analysis, trend reporting, and root cause analysis. Follows facility-specific or manufacturer failure taxonomy.. Valid values are `^[A-Z0-9]{2,10}$`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for the maintenance work order, calculated from labor hours and technician hourly rates. Used for total cost of ownership analysis and budget tracking.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended by technicians to complete the maintenance work order. Used for cost calculation, productivity analysis, and PM schedule estimation.',
    `order_status` STRING COMMENT 'Current lifecycle status of the maintenance work order. Tracks progression from creation through assignment, execution, completion, and closure. On-hold indicates temporary suspension pending parts or access. [ENUM-REF-CANDIDATE: created|assigned|in_progress|on_hold|completed|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the maintenance work order by its purpose: preventive (scheduled routine maintenance), corrective (repair of identified failure), emergency (urgent unplanned repair), inspection (regulatory or safety inspection), or recall (manufacturer-driven equipment recall).. Valid values are `preventive|corrective|emergency|inspection|recall`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts, materials, and consumables used in the maintenance work order. Aggregated from parts consumption records linked to this work order.',
    `priority_level` STRING COMMENT 'Business priority classification indicating the urgency and criticality of the maintenance work order. Critical indicates immediate patient safety or facility operations impact; urgent requires same-day response; routine is standard priority; scheduled is planned preventive maintenance.. Valid values are `critical|urgent|routine|scheduled`',
    `problem_description` STRING COMMENT 'Detailed narrative description of the maintenance issue, failure symptoms, or preventive maintenance task to be performed. Captured by the requestor or automatically populated from PM schedule template.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with vendor-performed maintenance work or parts procurement for this work order. Used for financial reconciliation and vendor payment processing.. Valid values are `^[A-Z0-9]{8,20}$`',
    `regulatory_driver` STRING COMMENT 'Identification of the regulatory requirement, accreditation standard, or compliance framework that mandates this maintenance activity. Examples include TJC EC.02.04.01 (environment of care), CMS conditions of participation, NFPA 99 (healthcare facilities code), NFPA 101 (life safety code), or state department of health regulations.',
    `request_datetime` TIMESTAMP COMMENT 'Date and time when the maintenance work order was originally requested or created in the system. Used for calculating response time and work order aging metrics.',
    `risk_assessment_score` STRING COMMENT 'Quantitative risk score assigned to the asset or maintenance activity based on risk-based assessment methodology such as Alternative Equipment Maintenance (AEM) or Authority Having Jurisdiction (AHJ) criteria. Higher scores indicate greater patient safety or operational risk.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order was triggered by or resulted in a safety incident, patient safety event, or environmental hazard. Used for safety reporting and root cause analysis.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the maintenance work is scheduled to be completed. Used for resource planning and downtime coordination with clinical operations.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the maintenance work is scheduled to begin. For preventive maintenance, this is calculated from the PM schedule frequency and last completion date.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the maintenance work order, including labor cost, parts cost, and any additional charges (contractor fees, disposal fees). Used for asset lifecycle cost analysis and facilities management KPIs.',
    `trade_type` STRING COMMENT 'Classification of the skilled trade or technical specialty required to perform the maintenance work. Biomedical covers medical equipment; other trades cover facility infrastructure systems.. Valid values are `biomedical|electrical|plumbing|hvac|carpentry|fire_protection`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was last modified in the data platform. Used for data lineage, change tracking, and audit trail purposes.',
    `vendor_service_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order was performed by an external vendor or contractor rather than internal facilities staff. Used for cost allocation and vendor performance tracking.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order is eligible for warranty claim or manufacturer reimbursement. Used for tracking warranty utilization and cost recovery.',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the maintenance work order, used for tracking and reference across systems and by technicians.. Valid values are `^[A-Z0-9]{8,20}$`',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Preventive and corrective maintenance work order for facility infrastructure and biomedical equipment, including the preventive maintenance schedule definitions that drive recurring work order generation. For work orders: captures work order number, order type (preventive, corrective, emergency, inspection-driven, recall-driven), priority level (critical, urgent, routine, scheduled), asset or location reference, problem description, failure code, assigned technician, trade type (biomedical, electrical, plumbing, HVAC, carpentry, fire protection), scheduled start and end datetime, actual start and completion datetime, labor hours, parts consumed with cost, total cost, and completion status. For PM schedules: captures schedule name, maintenance task template, frequency (daily, weekly, monthly, quarterly, semi-annual, annual), estimated labor hours, required trade, regulatory driver (TJC EC.02.04.01, CMS, NFPA 99, NFPA 101, state DOH), risk-based assessment score (AEM/AHJ), last completed date, next due date, and schedule active status. Integrates with SAP PM work order management and drives automated PM work order generation. Supports biomedical engineering PM compliance rates, facilities management KPIs, and regulatory audit evidence.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the equipment asset is located.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the equipment asset or facility system covered by this preventive maintenance schedule.',
    `auto_generate_work_order` BOOLEAN COMMENT 'Boolean flag indicating whether work orders should be automatically generated in SAP PM when the next due date is reached.',
    `cost_center` STRING COMMENT 'Financial cost center to which preventive maintenance labor and materials costs should be charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance schedule record was first created in the system.',
    `documentation_required` STRING COMMENT 'Type of documentation that must be completed and retained after maintenance (e.g., calibration certificate, inspection checklist, test results, compliance log).',
    `downtime_required` BOOLEAN COMMENT 'Boolean flag indicating whether the equipment or facility system must be taken offline or out of service to perform the maintenance task.',
    `equipment_category` STRING COMMENT 'Classification of the equipment or facility system (e.g., biomedical equipment, HVAC system, electrical system, plumbing system, fire safety system, medical gas system).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours the equipment or system will be unavailable during maintenance, used for operational planning and patient care continuity.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for resource planning and scheduling.',
    `frequency` STRING COMMENT 'Recurring interval at which the preventive maintenance task must be performed. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual — 7 candidates stripped; promote to reference product]',
    `frequency_interval` STRING COMMENT 'Numeric value representing the interval count for the maintenance frequency (e.g., every 3 months, every 6 weeks).',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval (time-based or usage-based).. Valid values are `days|weeks|months|years|hours|cycles`',
    `last_completed_date` DATE COMMENT 'Date when the preventive maintenance task was last successfully completed, used to calculate the next due date.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated, allowing time for scheduling and resource allocation.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance tasks to be performed, including inspection points, calibration steps, cleaning procedures, and safety checks.',
    `maintenance_type` STRING COMMENT 'Category of preventive maintenance activity to be performed on the equipment or facility system.. Valid values are `inspection|calibration|cleaning|lubrication|testing|replacement`',
    `manufacturer_recommendation` STRING COMMENT 'Manufacturer-recommended maintenance schedule or service bulletin reference that informs this preventive maintenance plan.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this preventive maintenance schedule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance schedule record was last modified.',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance task is due, based on frequency and last completed date. Drives automated work order generation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this preventive maintenance schedule.',
    `notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether stakeholder notification is required when work orders are generated or when maintenance is due.',
    `parts_required` STRING COMMENT 'List or description of spare parts, consumables, or materials required to complete the preventive maintenance task.',
    `planner_group` STRING COMMENT 'Maintenance planning group responsible for scheduling and coordinating this preventive maintenance activity.',
    `priority` STRING COMMENT 'Priority level of the preventive maintenance schedule, indicating urgency and impact on patient safety and facility operations.. Valid values are `critical|high|medium|low`',
    `regulatory_citation` STRING COMMENT 'Specific regulatory standard, code section, or citation that mandates this preventive maintenance requirement.',
    `regulatory_driver` STRING COMMENT 'Regulatory body or standard requiring this preventive maintenance activity (e.g., The Joint Commission (TJC), Centers for Medicare and Medicaid Services (CMS), National Fire Protection Association (NFPA), state Department of Health (DOH), Food and Drug Administration (FDA)).',
    `required_trade` STRING COMMENT 'Specific trade, skill, or certification required to perform the maintenance task (e.g., biomedical engineer, HVAC technician, electrician, plumber).',
    `safety_precautions` STRING COMMENT 'Required safety precautions, personal protective equipment (PPE), lockout/tagout procedures, or infection control measures that must be followed during maintenance.',
    `schedule_code` STRING COMMENT 'Unique business identifier or code for the preventive maintenance schedule, often used for integration with SAP PM and work order systems.',
    `schedule_end_date` DATE COMMENT 'Date when this preventive maintenance schedule expires or is no longer active. Null indicates an ongoing schedule.',
    `schedule_name` STRING COMMENT 'Descriptive name of the preventive maintenance schedule for identification and reporting purposes.',
    `schedule_start_date` DATE COMMENT 'Date when this preventive maintenance schedule becomes active and begins generating work orders.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule, indicating whether it is actively generating work orders.. Valid values are `active|inactive|suspended|completed`',
    `work_order_type` STRING COMMENT 'Type of work order to be generated for this preventive maintenance schedule in SAP PM (e.g., PM01 for preventive maintenance, PM02 for inspection).',
    `created_by` STRING COMMENT 'User ID or name of the person who created this preventive maintenance schedule record.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule defining the recurring maintenance plan for an equipment asset or facility system. Captures schedule name, associated asset or system, maintenance task description, frequency (daily, weekly, monthly, quarterly, annual), estimated labor hours, required trade, regulatory driver (TJC, CMS, NFPA, state DOH), last completed date, next due date, and schedule active status. Drives automated work order generation in SAP PM.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for the inspection finding record. Primary key.',
    `facility_inspection_id` BIGINT COMMENT 'Reference to the parent facility inspection during which this finding was identified.',
    `previous_finding_inspection_finding_id` BIGINT COMMENT 'Reference to the earlier inspection finding record if this is a recurrent deficiency. Null if first occurrence.',
    `employee_id` BIGINT COMMENT 'Reference to the individual (staff member, manager, or executive) assigned ownership and accountability for implementing the corrective action plan.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or operational unit responsible for addressing and remediating this finding.',
    `accreditation_impact_flag` BOOLEAN COMMENT 'Indicates whether this finding has potential to affect the facilitys accreditation status. True if accreditation-threatening, false otherwise.',
    `affected_location` STRING COMMENT 'Specific physical location, unit, department, or area within the facility where the deficiency was observed. May include building, floor, room, or unit identifiers.',
    `affected_patient_count` STRING COMMENT 'Estimated or actual number of patients potentially impacted by this deficiency. Null if not applicable or not determinable.',
    `citation_reference` STRING COMMENT 'Official citation number or reference code assigned by the regulatory body in their inspection report or enforcement action.',
    `corrective_action_owner_name` STRING COMMENT 'Full name of the individual responsible for executing and completing the corrective action plan.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the planned actions, interventions, and process changes to remediate the finding and prevent recurrence. May include immediate actions, systemic improvements, and monitoring plans.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection finding record was first created in the system.',
    `due_date` DATE COMMENT 'The deadline by which the corrective action plan must be completed and the finding resolved. Set by regulatory body or internal compliance team based on severity.',
    `extended_due_date` DATE COMMENT 'Revised deadline if an extension was granted by the regulatory authority or internal compliance leadership. Null if no extension was requested or approved.',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary fine or penalty assessed by the regulatory authority for this finding. Null if no financial penalty was imposed.',
    `finding_category` STRING COMMENT 'High-level classification of the finding area. Groups findings by operational domain for analysis and remediation planning. [ENUM-REF-CANDIDATE: environment_of_care|life_safety|infection_control|medication_management|patient_rights|quality_improvement|emergency_management|medical_staff|nursing|documentation — 10 candidates stripped; promote to reference product]',
    `finding_date` DATE COMMENT 'The date on which the deficiency or non-compliance was identified during the inspection.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the deficiency or non-compliance issue identified during the inspection. Includes specific observations, locations, and evidence.',
    `finding_number` STRING COMMENT 'Sequential or coded identifier assigned to this finding within the inspection report. Used for tracking and referencing specific deficiencies.',
    `inspector_name` STRING COMMENT 'Name of the surveyor or inspector who identified and documented this finding during the inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection finding record was most recently updated or modified.',
    `medicare_certification_impact_flag` BOOLEAN COMMENT 'Indicates whether this finding threatens the facilitys Medicare/Medicaid certification status. True if certification is at risk, false otherwise.',
    `notes` STRING COMMENT 'Additional comments, context, or supplementary information related to the finding, corrective actions, or resolution process. Free-text field for internal use.',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether this finding has direct implications for patient safety and quality of care. True if patient safety is affected, false otherwise.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat deficiency previously cited in an earlier inspection. True if recurrent, false if first occurrence.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory or accrediting organization that identified this finding. Examples include The Joint Commission, CMS, state health departments, OSHA, FDA.',
    `resolution_date` DATE COMMENT 'The date on which the corrective action was completed and the finding was resolved. Null if still open or in progress.',
    `resolution_status` STRING COMMENT 'Current state of the finding in the remediation lifecycle. Tracks progress from identification through verification and closure.. Valid values are `open|in_progress|pending_verification|resolved|closed|overdue`',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned to the finding based on potential impact to patient safety, regulatory compliance, and operational continuity. Higher scores indicate greater risk.',
    `root_cause_analysis_completion_date` DATE COMMENT 'The date on which the root cause analysis was completed and documented. Null if RCA was not required or not yet completed.',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis is required for this finding based on severity and organizational policy. True if RCA is mandated, false otherwise.',
    `severity_level` STRING COMMENT 'Classification of the seriousness and urgency of the finding. Immediate jeopardy indicates serious threat to patient safety requiring immediate correction; condition-level findings threaten accreditation; standard-level findings are isolated deficiencies; observations are opportunities for improvement.. Valid values are `immediate_jeopardy|condition_level|standard_level|observation|recommendation`',
    `standard_code` STRING COMMENT 'The specific regulatory standard, code, or requirement that was violated or not met. Examples include TJC standard codes, CMS Conditions of Participation (CoP), OSHA standards, state health department regulations.',
    `standard_description` STRING COMMENT 'Full text description of the regulatory standard or requirement that was cited in this finding.',
    `verification_date` DATE COMMENT 'The date on which the corrective action was verified as complete and effective by the compliance team or regulatory authority.',
    `verification_method` STRING COMMENT 'The approach used to validate that the corrective action was implemented effectively and the deficiency was remediated. May include follow-up inspections, audits, or documentation reviews. [ENUM-REF-CANDIDATE: document_review|site_visit|staff_interview|policy_review|data_analysis|observation|testing — 7 candidates stripped; promote to reference product]',
    `verified_by_name` STRING COMMENT 'Full name of the individual who verified that the corrective action was successfully implemented.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual deficiency or finding identified during a facility inspection. Captures finding number, associated inspection, standard or regulation cited (TJC standard code, CMS condition of participation, OSHA standard), finding description, severity level (immediate jeopardy, condition-level, standard-level, observation), responsible department, corrective action plan, corrective action owner, due date, and resolution status. Enables systematic tracking of regulatory deficiencies through remediation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` (
    `license_accreditation_id` BIGINT COMMENT 'Unique identifier for the facility license or accreditation credential record.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Facility-level licenses and accreditations (building permits, OR certifications, unit-specific credentials) must link to enterprise accreditation tracking for deemed status verification, CMS certifica',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Many licenses and permits are building-specific (occupancy permits, building operating licenses, fire safety certificates, elevator permits). Adding building_id enables building-level credential track',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility location to which this license or accreditation applies.',
    `accreditation_level` STRING COMMENT 'The level or tier of accreditation granted, if applicable. Examples include full accreditation, provisional accreditation, conditional accreditation, or specific program-level designations such as Level I Trauma Center or Primary Stroke Center.',
    `attestation_by` STRING COMMENT 'The name or identifier of the authorized individual who attested to the credential information.',
    `attestation_date` DATE COMMENT 'The date on which an authorized facility representative attested to the accuracy and completeness of the credential information for compliance or reporting purposes.',
    `bed_capacity_authorized` STRING COMMENT 'The number of licensed beds authorized under this credential, if applicable. Critical for hospital and inpatient facility licenses.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or accreditation credential record was first created in the system.',
    `credential_name` STRING COMMENT 'The full name or title of the license or accreditation credential as issued by the authority.',
    `credential_number` STRING COMMENT 'The unique license, certificate, or accreditation number issued by the governing authority. This is the externally-known identifier for the credential.',
    `credential_type` STRING COMMENT 'Type of license or accreditation credential. Examples include state hospital license, CMS Medicare certification, TJC accreditation, DNV accreditation, CLIA laboratory certificate, state pharmacy license, trauma center designation, stroke center certification. [ENUM-REF-CANDIDATE: state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license|trauma_center_designation|stroke_center_certification|ambulatory_surgery_center_license|behavioral_health_license|home_health_license|hospice_license|imaging_center_license|dialysis_facility_certification — promote to reference product]. Valid values are `state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license`',
    `deemed_status_flag` BOOLEAN COMMENT 'Indicates whether the facility has deemed status, meaning accreditation by an approved organization (e.g., The Joint Commission, DNV) satisfies CMS Medicare certification requirements.',
    `deeming_organization` STRING COMMENT 'The name of the accreditation organization that provides deemed status for CMS certification, if applicable. Examples include The Joint Commission, DNV Healthcare, HFAP.',
    `deficiency_count` STRING COMMENT 'The number of deficiencies or non-compliance findings identified during the most recent survey or inspection.',
    `document_reference_url` STRING COMMENT 'URL or file path reference to the scanned or electronic copy of the license or accreditation certificate document.',
    `effective_date` DATE COMMENT 'The date from which the license or accreditation becomes valid and enforceable for operational and regulatory purposes.',
    `expiration_date` DATE COMMENT 'The date on which the license or accreditation credential expires and must be renewed to maintain compliance.',
    `issue_date` DATE COMMENT 'The date on which the license or accreditation credential was originally issued or granted by the authority.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, accreditation organization, or government agency that issued the credential. Examples include state departments of health, CMS, The Joint Commission, DNV, CLIA.',
    `issuing_authority_code` STRING COMMENT 'Standardized code representing the issuing authority for system integration and reporting purposes.',
    `medicaid_provider_number` STRING COMMENT 'The state-assigned Medicaid provider number associated with this credential, if applicable.',
    `medicare_provider_number` STRING COMMENT 'The CMS-assigned Medicare provider number associated with this credential, if applicable. Critical for billing and reimbursement.',
    `next_survey_date` DATE COMMENT 'The scheduled or anticipated date for the next on-site survey, inspection, or audit by the issuing authority.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the license or accreditation credential. May include special conditions, restrictions, or historical context.',
    `payer_contract_requirement_flag` BOOLEAN COMMENT 'Indicates whether this credential is required for payer contracting or network participation agreements.',
    `plan_of_correction_approved_date` DATE COMMENT 'The date on which the issuing authority approved the facilitys plan of correction.',
    `plan_of_correction_due_date` DATE COMMENT 'The date by which the facility must submit a plan of correction to address identified deficiencies or non-compliance findings.',
    `plan_of_correction_submitted_date` DATE COMMENT 'The date on which the facility submitted its plan of correction to the issuing authority.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this credential information is publicly disclosed or reported to regulatory agencies, quality reporting organizations, or consumer transparency platforms.',
    `renewal_application_date` DATE COMMENT 'The date on which the renewal application for the license or accreditation was submitted to the issuing authority.',
    `renewal_due_date` DATE COMMENT 'The date by which the renewal application must be submitted to avoid lapse in credential status.',
    `scope_of_credential` STRING COMMENT 'Description of the services, procedures, or operational scope covered by the license or accreditation. May include bed capacity limits, service line restrictions, or specific procedural authorizations.',
    `license_accreditation_status` STRING COMMENT 'Current lifecycle status of the license or accreditation credential. Indicates whether the credential is active, pending renewal, expired, suspended, revoked, or inactive.. Valid values are `active|pending_renewal|expired|suspended|revoked|inactive`',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective.',
    `status_reason` STRING COMMENT 'Explanation or reason for the current status, particularly for suspended, revoked, or inactive credentials. May include regulatory findings, compliance failures, or voluntary surrender.',
    `survey_date` DATE COMMENT 'The date of the most recent on-site survey, inspection, or audit conducted by the issuing authority to assess compliance with standards.',
    `survey_outcome` STRING COMMENT 'The result or outcome of the most recent survey or inspection. May include findings such as full compliance, deficiencies identified, conditional status, or immediate jeopardy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or accreditation credential record was last updated or modified in the system.',
    CONSTRAINT pk_license_accreditation PRIMARY KEY(`license_accreditation_id`)
) COMMENT 'Facility license and accreditation credential record. Tracks credential type (state hospital license, CMS Medicare certification, TJC accreditation, DNV accreditation, CLIA laboratory certificate, state pharmacy license, trauma center designation, stroke center certification), issuing authority, license or certificate number, issue date, expiration date, renewal application date, current status (active, pending renewal, suspended, revoked), and associated care site. Critical for regulatory compliance and payer contracting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT 'Unique identifier for the space allocation record. Primary key.',
    `building_id` BIGINT COMMENT 'Reference to the specific building within the facility where the space is allocated.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the space is located. Links to the facility master data.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the financial allocation and chargeback of this space.',
    `room_id` BIGINT COMMENT 'Reference to the specific room, suite, or area being allocated. May be null for building-level or floor-level allocations.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Space allocation often occurs at unit level (allocating rooms to clinical units, assigning unit space to departments). Adding unit_id enables unit-level space allocation tracking, supports unit manage',
    `org_unit_id` BIGINT COMMENT 'Reference to the department that has been allocated this space for operational use.',
    `allocated_square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the space allocated to the department or cost center, measured in square feet.',
    `allocation_end_date` DATE COMMENT 'Date when the space allocation ends or is scheduled to end. Null indicates an open-ended allocation.',
    `allocation_notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or operational details about the space allocation.',
    `allocation_number` STRING COMMENT 'Business identifier for the space allocation record, used for tracking and reporting purposes.',
    `allocation_priority` STRING COMMENT 'Priority level of the space allocation, used for space planning and reallocation decisions during capacity constraints.. Valid values are `critical|high|medium|low`',
    `allocation_purpose` STRING COMMENT 'Business purpose or justification for the space allocation, describing the intended use and operational need.',
    `allocation_start_date` DATE COMMENT 'Date when the space allocation becomes effective and the department or cost center assumes responsibility.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the space allocation record, indicating whether it is currently in effect or has been terminated.. Valid values are `active|pending|expired|terminated|suspended`',
    `annual_space_cost` DECIMAL(18,2) COMMENT 'Annualized cost of the space allocation, calculated for budgeting and long-term financial planning purposes.',
    `approval_date` DATE COMMENT 'Date when the space allocation was formally approved by the responsible authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved the space allocation, used for governance and audit purposes.',
    `cost_per_square_foot` DECIMAL(18,2) COMMENT 'Unit cost per square foot of the allocated space, used for comparative analysis and benchmarking across facilities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the space allocation record was first created in the system, used for audit trail and data lineage.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record version became effective, supporting temporal tracking and historical analysis.',
    `effective_to_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record version ceased to be effective. Null indicates the current active version.',
    `floor_number` STRING COMMENT 'Floor or level within the building where the allocated space is located.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the space allocation record was last updated, supporting change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date when the space allocation was last reviewed for accuracy, utilization, and continued business need.',
    `lease_ownership_indicator` STRING COMMENT 'Indicates whether the space is owned by the organization, leased from a third party, subleased, or shared with other entities.. Valid values are `owned|leased|subleased|shared`',
    `monthly_space_cost` DECIMAL(18,2) COMMENT 'Monthly cost allocated to this space, including lease payments, depreciation, utilities, and maintenance, used for cost center chargebacks.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the space allocation to assess utilization and cost effectiveness.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Percentage of time or capacity that the allocated space is actively utilized, used for space utilization analysis and planning.',
    `primary_use_flag` BOOLEAN COMMENT 'Indicates whether this allocation represents the primary use of the space (true) or a secondary/shared use (false).',
    `service_line` STRING COMMENT 'Clinical or operational service line that utilizes the allocated space (e.g., Cardiology, Oncology, Emergency Services, Surgical Services).',
    `shared_space_flag` BOOLEAN COMMENT 'Indicates whether the space is shared among multiple departments or cost centers (true) or exclusively allocated to one entity (false).',
    `space_subtype` STRING COMMENT 'Detailed classification of the space within the primary type (e.g., patient room, exam room, office, conference room, supply closet).',
    `space_type` STRING COMMENT 'Classification of the allocated space by functional use category.. Valid values are `clinical|administrative|support|storage|common|mechanical`',
    `termination_reason` STRING COMMENT 'Reason for terminating or ending the space allocation, captured when allocation_status changes to terminated or expired.',
    `wing_section` STRING COMMENT 'Wing, section, or zone designation within the building for the allocated space, used for wayfinding and operational organization.',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Space allocation and occupancy record assigning rooms, suites, or areas to departments, cost centers, or service lines. Captures allocated space identifier, space type, assigned department or cost center, service line, allocation start date, allocation end date, allocated square footage, occupancy percentage, lease or ownership indicator, monthly space cost, and allocation status. Supports facilities planning, space utilization analysis, and cost center chargebacks.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` (
    `environmental_service_request_id` BIGINT COMMENT 'Unique identifier for the environmental services work request. Primary key.',
    `bed_id` BIGINT COMMENT 'Identifier of the specific bed requiring cleaning or disinfection.',
    `building_id` BIGINT COMMENT 'Identifier of the building within the facility where the service is requested.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the environmental service is requested.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who performed the quality inspection, typically environmental services supervisor or infection preventionist.',
    `primary_environmental_employee_id` BIGINT COMMENT 'Identifier of the staff member who submitted the environmental service request, typically nursing or unit coordinator.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room requiring environmental services.',
    `tertiary_environmental_cancelled_by_user_employee_id` BIGINT COMMENT 'Identifier of the staff member who cancelled the environmental service request.',
    `unit_id` BIGINT COMMENT 'Identifier of the clinical unit or department where the service is requested.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the request was assigned to an environmental services staff member.',
    `bed_board_integration_flag` BOOLEAN COMMENT 'Indicates whether this request is integrated with the real-time bed management system for automated bed status updates.',
    `bed_status_updated_flag` BOOLEAN COMMENT 'Indicates whether the bed status was automatically updated to available upon completion of cleaning.',
    `cancellation_reason` STRING COMMENT 'Reason for cancelling the environmental service request, such as patient readmission, room change, or duplicate request.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental service request was cancelled.',
    `cleaning_protocol_used` STRING COMMENT 'Specific cleaning and disinfection protocol applied based on infection control requirements. Contact precaution for resistant organisms; C. diff protocol uses sporicidal agents; COVID protocol follows CDC guidance; MRSA protocol for methicillin-resistant Staphylococcus aureus; standard for routine cleaning; enhanced for high-touch surfaces.. Valid values are `contact precaution|c diff protocol|covid protocol|standard|enhanced|mrsa protocol`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental services work was completed and the space was ready for occupancy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this record was first created in the data platform.',
    `discharge_to_clean_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from patient discharge to room ready for next admission. Critical metric for bed throughput optimization and Emergency Department (ED) boarding reduction.',
    `disinfectant_product_used` STRING COMMENT 'Name or identifier of the EPA-registered disinfectant product used for cleaning and disinfection.',
    `infection_prevention_alert_flag` BOOLEAN COMMENT 'Indicates whether this request was flagged for infection prevention review due to Healthcare-Associated Infection (HAI) risk or outbreak investigation.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the quality inspection was performed.',
    `isolation_precaution_type` STRING COMMENT 'Type of isolation precaution in effect for the location, such as contact, droplet, airborne, or protective environment. Determines cleaning protocol requirements. [ENUM-REF-CANDIDATE: contact|droplet|airborne|protective environment|standard|contact plus|neutropenic|reverse isolation — promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this record was last modified in the data platform.',
    `notes` STRING COMMENT 'Free-text notes or comments about the environmental service request, including special instructions, observations, or issues encountered.',
    `patient_discharge_timestamp` TIMESTAMP COMMENT 'Date and time when the patient was discharged from the bed or room, triggering the need for terminal or discharge cleaning. Used to calculate discharge-to-clean cycle time.',
    `priority_level` STRING COMMENT 'Urgency classification of the environmental service request. STAT requires immediate response; urgent within 30 minutes; routine within 2 hours; scheduled at predetermined time.. Valid values are `stat|urgent|routine|scheduled`',
    `quality_inspection_performed_flag` BOOLEAN COMMENT 'Indicates whether a quality inspection was conducted after cleaning completion.',
    `quality_inspection_result` STRING COMMENT 'Outcome of the quality inspection. Passed indicates the space meets cleanliness standards; failed requires rework; not inspected when inspection was not performed.. Valid values are `passed|failed|not inspected`',
    `request_number` STRING COMMENT 'Business identifier for the environmental service request, used for tracking and communication.',
    `request_status` STRING COMMENT 'Current lifecycle status of the environmental service request.. Valid values are `pending|assigned|in progress|completed|cancelled|on hold`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental service request was created. Critical for measuring response time and bed throughput metrics.',
    `request_to_start_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from request creation to work start. Measures environmental services responsiveness.',
    `request_type` STRING COMMENT 'Type of environmental service requested. Terminal clean is comprehensive end-of-stay cleaning; discharge clean is post-patient departure; isolation clean follows contact precaution protocols; routine clean is scheduled maintenance; spill response addresses immediate contamination; biohazard cleanup handles infectious or hazardous materials.. Valid values are `terminal clean|discharge clean|isolation clean|routine clean|spill response|biohazard cleanup`',
    `special_equipment_required` STRING COMMENT 'Description of any special equipment needed for the cleaning task, such as ultraviolet (UV) disinfection devices, electrostatic sprayers, or HEPA vacuums.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental services staff began the cleaning or disinfection work.',
    `work_duration_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes spent performing the cleaning or disinfection work, from start to completion.',
    CONSTRAINT pk_environmental_service_request PRIMARY KEY(`environmental_service_request_id`)
) COMMENT 'Environmental services (EVS) work request for cleaning, disinfection, and housekeeping tasks. Captures request type (terminal clean, discharge clean, isolation clean, routine clean, spill response, biohazard cleanup), requested location (bed, room, unit), priority level, request timestamp, assigned EVS staff, start time, completion time, cleaning protocol used (contact precaution, C. diff protocol, COVID protocol, standard), quality inspection result, and discharge-to-clean cycle time. Supports infection prevention, bed throughput optimization, and real-time bed board integration. Critical for patient flow and hospital throughput management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` (
    `capacity_snapshot_id` BIGINT COMMENT 'Unique identifier for the capacity snapshot record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Capacity snapshots can be tracked at building level for multi-building care sites (Hospital Main Building vs. Outpatient Building vs. Womens Pavilion). Adding building_id enables building-level capac',
    `care_site_id` BIGINT COMMENT 'Reference to the care site (hospital, clinic, outpatient facility) for which this capacity snapshot was captured.',
    `unit_id` BIGINT COMMENT 'Reference to the specific unit or department within the care site (e.g., ICU, ED, NICU, medical-surgical unit). Nullable if snapshot is at care site level.',
    `alternate_care_site_activation_status` STRING COMMENT 'Indicates whether alternate care sites (field hospitals, temporary facilities) have been activated to handle overflow capacity during emergencies.. Valid values are `activated|standby|inactive`',
    `ambulance_diversion_status` STRING COMMENT 'Indicates whether the facility is currently on ambulance diversion, meaning incoming ambulances are being redirected to other facilities due to capacity constraints.. Valid values are `active|inactive`',
    `available_beds` STRING COMMENT 'Number of staffed beds that are immediately available for patient assignment (not occupied, not in cleaning, not out of service).',
    `bariatric_beds_available` STRING COMMENT 'Number of bariatric-capable beds (designed for patients with high body mass index) currently available.',
    `beds_in_cleaning` STRING COMMENT 'Number of beds currently undergoing environmental services cleaning or terminal cleaning after patient discharge. These beds are temporarily unavailable.',
    `beds_out_of_service` STRING COMMENT 'Number of beds that are out of service due to maintenance, equipment failure, isolation requirements, or other operational reasons.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this capacity snapshot record was first created in the data system.',
    `disaster_census` STRING COMMENT 'Total number of patients being treated as a result of a declared disaster or mass casualty event at the time of the snapshot.',
    `ed_boarding_count` STRING COMMENT 'Number of admitted patients currently boarding in the Emergency Department awaiting an inpatient bed. ED boarding is a key capacity constraint metric.',
    `ed_bypass_status` STRING COMMENT 'Indicates whether the Emergency Department is on bypass status, temporarily not accepting new patients due to capacity or operational constraints.. Valid values are `active|inactive`',
    `ed_census` STRING COMMENT 'Total number of patients currently in the Emergency Department at the time of the snapshot, including those awaiting admission.',
    `eoc_activation_status` STRING COMMENT 'Indicates whether the hospital Emergency Operations Center has been activated to coordinate emergency response and capacity management.. Valid values are `activated|standby|inactive`',
    `icu_bypass_status` STRING COMMENT 'Indicates whether the ICU is on bypass status, temporarily not accepting new admissions due to capacity constraints.. Valid values are `active|inactive`',
    `icu_census` STRING COMMENT 'Total number of patients currently in the Intensive Care Unit at the time of the snapshot.',
    `isolation_beds_available` STRING COMMENT 'Number of isolation-capable beds (negative pressure or airborne infection isolation rooms) currently available for patients requiring isolation precautions.',
    `nicu_census` STRING COMMENT 'Total number of neonatal patients currently in the Neonatal Intensive Care Unit at the time of the snapshot.',
    `observation_beds_available` STRING COMMENT 'Number of observation beds currently available for patients under observation status (not formally admitted).',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Percentage of staffed beds that are currently occupied. Calculated as (occupied_beds / total_staffed_beds) * 100. Key performance indicator for capacity management.',
    `occupied_beds` STRING COMMENT 'Number of beds currently occupied by patients at the time of the snapshot.',
    `or_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of Operating Room capacity currently in use at the time of the snapshot. Calculated as (active OR cases / total OR capacity) * 100.',
    `pediatric_beds_available` STRING COMMENT 'Number of pediatric beds currently available for patients under 18 years of age.',
    `snapshot_source_system` STRING COMMENT 'The system or application that generated this capacity snapshot (e.g., Epic ADT, Hospital Command Center Dashboard, Bed Management System).',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The exact date and time when this capacity snapshot was captured. This is the principal business event timestamp for real-time capacity tracking.',
    `snapshot_type` STRING COMMENT 'Indicates whether this snapshot was captured as part of a scheduled interval, on-demand request, emergency response, or automated system trigger.. Valid values are `scheduled|on_demand|emergency|automated`',
    `surge_beds_available` STRING COMMENT 'Number of surge beds that can be activated in an emergency or disaster scenario. Surge beds are additional capacity beyond normal staffed beds.',
    `telemetry_beds_available` STRING COMMENT 'Number of telemetry-capable beds currently available for patients requiring continuous cardiac monitoring.',
    `total_licensed_beds` STRING COMMENT 'Total number of beds the facility is licensed to operate by state health department. This is the regulatory maximum capacity.',
    `total_staffed_beds` STRING COMMENT 'Total number of beds that are currently staffed and available for patient assignment. Staffed beds are a subset of licensed beds and reflect operational capacity.',
    `ventilator_availability_count` STRING COMMENT 'Number of mechanical ventilators currently available and ready for patient use. Critical for respiratory emergency preparedness and pandemic response.',
    CONSTRAINT pk_capacity_snapshot PRIMARY KEY(`capacity_snapshot_id`)
) COMMENT 'Point-in-time operational capacity snapshot for a care site or unit, capturing total licensed beds, total staffed beds, occupied beds, available beds, beds in cleaning, beds out-of-service, ED census, ED boarding count, ICU census, NICU census, OR utilization percentage, diversion status (ambulance diversion, ED bypass, ICU bypass), and snapshot timestamp. Supports emergency preparedness capacity tracking including surge bed availability, alternate care site activation status, ventilator availability, disaster census, and emergency operations center (EOC) activation status. Enables real-time capacity management, hospital command center operations, surge planning, CMS Emergency Preparedness Rule compliance (§482.15 capacity and resource tracking), and CMS bed count reporting (CMS-855A). This is the operational silver-layer record of capacity state, distinct from analytical aggregations. Note: comprehensive emergency preparedness planning artifacts (emergency operations plans, communication plans, training/exercise records) require coverage beyond capacity snapshots — see next_vibes_items.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` (
    `hazardous_material_id` BIGINT COMMENT 'Unique identifier for the hazardous material record. Primary key.',
    `building_id` BIGINT COMMENT 'Identifier of the specific building within the facility where the material is located.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the hazardous material is stored or used.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room or storage location where the hazardous material is kept.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Hazardous materials are often managed at unit level (pharmacy unit chemotherapy storage, lab unit chemical inventory, radiology unit contrast media). Adding unit_id enables unit-level hazmat tracking,',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department responsible for managing and using this hazardous material.',
    `activity_level` DECIMAL(18,2) COMMENT 'Radioactivity level of the material measured in curies (Ci) or becquerels (Bq), if applicable.',
    `biohazard_level` STRING COMMENT 'Biosafety level classification (BSL-1 through BSL-4) for biohazardous materials per CDC/NIH guidelines.. Valid values are `BSL-1|BSL-2|BSL-3|BSL-4|not_applicable`',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to chemical substances.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_name` STRING COMMENT 'Scientific or IUPAC chemical name of the hazardous substance.',
    `container_size` STRING COMMENT 'Size or capacity of the storage container with unit (e.g., 500 mL, 55 gallon, 150 lb cylinder).',
    `container_type` STRING COMMENT 'Type of container in which the hazardous material is stored (e.g., bottle, drum, compressed gas cylinder). [ENUM-REF-CANDIDATE: bottle|drum|cylinder|tank|vial|ampule|bag|carboy — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hazardous material record was first created in the system.',
    `current_quantity_on_hand` DECIMAL(18,2) COMMENT 'Current quantity of the hazardous material physically present in inventory at this location.',
    `disposal_method` STRING COMMENT 'Approved method for disposal of this hazardous material (e.g., incineration, chemical neutralization, licensed waste hauler, radioactive decay storage).',
    `epa_reportable_quantity_flag` BOOLEAN COMMENT 'Indicates whether the quantity on hand meets or exceeds EPA reportable quantity thresholds requiring notification.',
    `expiration_date` DATE COMMENT 'Date after which the hazardous material should not be used due to degradation or regulatory requirements.',
    `ghs_pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes (e.g., GHS02, GHS07) indicating hazard symbols required on labels.',
    `hazard_class` STRING COMMENT 'Primary hazard classification according to OSHA Globally Harmonized System (GHS) of Classification and Labeling of Chemicals. [ENUM-REF-CANDIDATE: flammable|corrosive|toxic|oxidizer|compressed_gas|explosive|radioactive|biohazard|reactive|carcinogen — 10 candidates stripped; promote to reference product]',
    `incompatible_materials` STRING COMMENT 'List of chemical classes or specific materials that are incompatible and must not be stored or used near this material.',
    `infectious_agent_name` STRING COMMENT 'Name of the infectious agent or pathogen if the material is biohazardous.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety inspection of this hazardous material storage location and container integrity.',
    `lot_number` STRING COMMENT 'Manufacturers lot or batch number for traceability and quality control.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier of the hazardous material.',
    `manufacturer_product_code` STRING COMMENT 'Manufacturers catalog or product code for the hazardous material.',
    `material_name` STRING COMMENT 'Common or trade name of the hazardous material as used in facility operations.',
    `maximum_allowable_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of the hazardous material permitted to be stored at this location per regulatory or facility policy limits.',
    `next_inspection_due_date` DATE COMMENT 'Date when the next scheduled safety inspection is due for this hazardous material.',
    `nfpa_rating` STRING COMMENT 'NFPA 704 diamond rating in format Health-Flammability-Instability-Special (e.g., 2-3-1-OX).. Valid values are `^[0-4]-[0-4]-[0-4](-[A-Z]{0,3})?$`',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the regulatory permit or license, if applicable.',
    `permit_number` STRING COMMENT 'Regulatory permit or license number authorizing storage or use of this hazardous material, if applicable.',
    `personal_protective_equipment_required` STRING COMMENT 'Description of personal protective equipment required when handling this material (e.g., gloves, goggles, respirator, lab coat).',
    `radioactive_isotope` STRING COMMENT 'Specific radioactive isotope designation (e.g., I-131, Tc-99m, Co-60) if the material is radioactive.',
    `radioactive_material_flag` BOOLEAN COMMENT 'Indicates whether the material is radioactive and subject to Nuclear Regulatory Commission (NRC) or state radiation control regulations.',
    `receipt_date` DATE COMMENT 'Date the hazardous material was received into facility inventory.',
    `regulatory_permit_required_flag` BOOLEAN COMMENT 'Indicates whether a regulatory permit or license is required to store or use this hazardous material.',
    `responsible_person_contact` STRING COMMENT 'Contact phone number or email for the responsible person.',
    `responsible_person_name` STRING COMMENT 'Name of the individual designated as responsible for this hazardous material inventory item.',
    `sara_title_iii_reportable_flag` BOOLEAN COMMENT 'Indicates whether this material is subject to SARA Title III (EPCRA) reporting requirements for emergency planning and community right-to-know.',
    `sds_document_number` STRING COMMENT 'Reference identifier or document management system ID for the Safety Data Sheet associated with this material.',
    `sds_revision_date` DATE COMMENT 'Date of the most recent revision of the Safety Data Sheet for this material.',
    `special_handling_instructions` STRING COMMENT 'Additional handling, storage, or usage instructions specific to this hazardous material.',
    `hazardous_material_status` STRING COMMENT 'Current lifecycle status of the hazardous material inventory record.. Valid values are `active|expired|disposed|quarantined|recalled`',
    `storage_cabinet_type` STRING COMMENT 'Type of specialized storage cabinet or container used for the hazardous material. [ENUM-REF-CANDIDATE: flammable_cabinet|corrosive_cabinet|general_chemical|refrigerated|ventilated|explosive_magazine|radioactive_shielded|biohazard_containment — 8 candidates stripped; promote to reference product]',
    `storage_location_description` STRING COMMENT 'Detailed description of the physical storage location within the facility (e.g., cabinet number, shelf, zone).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity fields (e.g., kilograms, liters, gallons, curies for radioactive materials). [ENUM-REF-CANDIDATE: kg|g|L|mL|gal|lb|oz|curie|becquerel|unit — 10 candidates stripped; promote to reference product]',
    `ventilation_requirement` STRING COMMENT 'Type of ventilation control required when using this hazardous material.. Valid values are `fume_hood|biosafety_cabinet|local_exhaust|general_ventilation|none`',
    `waste_stream_code` STRING COMMENT 'EPA hazardous waste code (e.g., D001, P-listed, U-listed) or facility-specific waste stream identifier for disposal tracking.',
    CONSTRAINT pk_hazardous_material PRIMARY KEY(`hazardous_material_id`)
) COMMENT 'Hazardous material inventory and safety data record for materials stored or used within facility operations, including chemicals, compressed gases, radioactive materials, and biohazardous waste. Captures material name, chemical name, CAS number, hazard class (OSHA GHS), storage location, maximum allowable quantity, current quantity on hand, SDS (Safety Data Sheet) reference, regulatory permit required flag, disposal method, and responsible department. Supports OSHA compliance, EPA reporting, and TJC Environment of Care standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique identifier for the safety incident or hazardous material inventory record. Primary key.',
    `bed_id` BIGINT COMMENT 'Foreign key linking to facility.bed. Business justification: Patient safety incidents often occur at bed level (patient falls from bed, bed equipment failures, bed rail incidents). Adding bed_id enables bed-level incident tracking, supports bed-specific root ca',
    `building_id` BIGINT COMMENT 'Reference to the specific building where the incident occurred or where the hazardous material is stored.',
    `care_site_id` BIGINT COMMENT 'Reference to the care site where the incident occurred or where the hazardous material is stored.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Patient safety incidents (falls, medication errors, pressure injuries) must link to affected patients for root cause analysis, CMS adverse event reporting, Joint Commission sentinel event investigatio',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Safety incidents (workplace injuries, hazmat spills, equipment failures) trigger compliance investigations for root cause analysis, OSHA 300 log determination, state DOH reporting, and corrective acti',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Safety incidents involving supply items (defective devices, hazardous material spills) require traceability to item master for root cause analysis, vendor notification, recall correlation, FDA MedWatc',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual who reported or documented the safety incident or hazardous material inventory entry.',
    `room_id` BIGINT COMMENT 'Reference to the specific room where the incident occurred or where the hazardous material is stored.',
    `unit_id` BIGINT COMMENT 'Reference to the specific unit or department where the incident occurred or where the hazardous material is stored.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department responsible for managing and monitoring this hazardous material inventory. Applicable when record_type is hazmat_inventory.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to the hazardous material. Applicable when record_type is hazmat_inventory.',
    `chemical_name` STRING COMMENT 'Scientific chemical name of the hazardous material as listed on the Safety Data Sheet (SDS). Applicable when record_type is hazmat_inventory.',
    `closure_date` DATE COMMENT 'Date on which the incident investigation and all corrective actions were completed and the incident was formally closed. Applicable when record_type is incident.',
    `cms_immediate_jeopardy_flag` BOOLEAN COMMENT 'Indicator of whether the incident constitutes an immediate jeopardy situation requiring notification to CMS. Applicable when record_type is incident.',
    `corrective_actions` STRING COMMENT 'Description of corrective and preventive actions implemented or planned to prevent recurrence of similar incidents. Applicable when record_type is incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this safety incident or hazardous material inventory record was first created in the system.',
    `current_quantity_on_hand` DECIMAL(18,2) COMMENT 'Current quantity of the hazardous material physically present in inventory at the storage location. Applicable when record_type is hazmat_inventory.',
    `disposal_method` STRING COMMENT 'Approved method for disposal of the hazardous material per regulatory requirements and facility policy. Applicable when record_type is hazmat_inventory.',
    `hazard_class` STRING COMMENT 'OSHA Globally Harmonized System (GHS) hazard classification of the material (e.g., flammable liquid, corrosive, toxic). Applicable when record_type is hazmat_inventory. [ENUM-REF-CANDIDATE: flammable_liquid|flammable_solid|oxidizer|corrosive|toxic|carcinogen|irritant|compressed_gas — promote to reference product]',
    `immediate_actions_taken` STRING COMMENT 'Description of the immediate response actions taken at the time of the incident to mitigate harm, secure the area, or address the hazard. Applicable when record_type is incident.',
    `incident_date` DATE COMMENT 'The calendar date on which the safety incident occurred. Applicable when record_type is incident.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the safety incident, including circumstances, conditions, and sequence of events. Applicable when record_type is incident.',
    `incident_number` STRING COMMENT 'Externally-known unique identifier or tracking number assigned to the safety incident for reporting and follow-up purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident investigation and resolution process. Applicable when record_type is incident.. Valid values are `open|under_investigation|corrective_action_pending|closed`',
    `incident_timestamp` TIMESTAMP COMMENT 'The precise date and time when the safety incident occurred. Principal business event timestamp. Applicable when record_type is incident.',
    `incident_type` STRING COMMENT 'Classification of the safety incident event type. Applicable when record_type is incident. [ENUM-REF-CANDIDATE: fire_smoke_event|utility_failure|water_intrusion|security_threat|hazmat_spill|workplace_injury|infant_abduction_drill|active_shooter_drill|infrastructure_failure — promote to reference product]. Valid values are `fire_smoke_event|utility_failure|water_intrusion|security_threat|hazmat_spill|workplace_injury`',
    `injuries_sustained_flag` BOOLEAN COMMENT 'Indicator of whether any injuries to staff, patients, or visitors resulted from the incident. Applicable when record_type is incident.',
    `injury_count` STRING COMMENT 'Number of individuals who sustained injuries as a result of the incident. Applicable when record_type is incident.',
    `injury_severity` STRING COMMENT 'Classification of the most severe injury sustained in the incident. Applicable when record_type is incident.. Valid values are `none|minor|moderate|severe|fatal`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this safety incident or hazardous material inventory record was most recently modified.',
    `maximum_allowable_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of the hazardous material permitted to be stored at this location per regulatory or facility policy limits. Applicable when record_type is hazmat_inventory.',
    `osha_300_log_required_flag` BOOLEAN COMMENT 'Indicator of whether the incident must be recorded on the OSHA 300 Log of Work-Related Injuries and Illnesses. Applicable when record_type is incident.',
    `osha_301_report_required_flag` BOOLEAN COMMENT 'Indicator of whether an OSHA 301 Injury and Illness Incident Report must be filed for the incident. Applicable when record_type is incident.',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of property damage resulting from the incident, in US dollars. Applicable when record_type is incident.',
    `property_damage_flag` BOOLEAN COMMENT 'Indicator of whether property damage occurred as a result of the incident. Applicable when record_type is incident.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the hazardous material quantity (e.g., gallons, liters, pounds, kilograms). Applicable when record_type is hazmat_inventory.. Valid values are `gallons|liters|pounds|kilograms|cubic_feet|units`',
    `record_type` STRING COMMENT 'Discriminator indicating whether this record represents a safety incident event or a hazardous material inventory entry.. Valid values are `incident|hazmat_inventory`',
    `regulatory_permit_required_flag` BOOLEAN COMMENT 'Indicator of whether a regulatory permit or license is required for storage or use of this hazardous material. Applicable when record_type is hazmat_inventory.',
    `reported_by_name` STRING COMMENT 'Name of the individual who reported or documented the safety incident or hazardous material inventory entry.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicator of whether a formal root cause analysis has been completed for the incident. Applicable when record_type is incident.',
    `root_cause_summary` STRING COMMENT 'Summary of the identified root cause(s) of the incident based on investigation and analysis. Applicable when record_type is incident.',
    `sds_reference_number` STRING COMMENT 'Reference number or identifier for the Safety Data Sheet document associated with this hazardous material. Applicable when record_type is hazmat_inventory.',
    `state_doh_notification_required_flag` BOOLEAN COMMENT 'Indicator of whether the incident requires notification to the state Department of Health. Applicable when record_type is incident.',
    `storage_location` STRING COMMENT 'Specific location description where the hazardous material is stored within the facility (e.g., room number, cabinet, storage area). Applicable when record_type is hazmat_inventory.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Facility safety and environment of care (EOC) incident record, including hazardous material inventory management. For incidents: captures event type (fire/smoke event, utility failure, water intrusion, security threat, hazardous material spill, workplace injury, infant/child abduction drill, active shooter drill, infrastructure failure), incident date and time, location (care site, building, unit, room), description, immediate actions taken, injuries sustained, property damage assessment, root cause analysis, corrective actions, regulatory reporting obligation (OSHA 300 log, OSHA 301, state DOH notification, CMS immediate jeopardy notification), and closure status. For hazardous materials inventory: captures material name, chemical name, CAS number, hazard class (OSHA GHS classification), storage location, maximum allowable quantity, current quantity on hand, SDS (Safety Data Sheet) reference, regulatory permit required flag, disposal method, and responsible department. Supports OSHA compliance, EPA Tier II reporting, TJC Environment of Care standards (EC.02.01.01 safety management, EC.02.02.01 security management), and comprehensive EOC management. Distinct from clinical patient safety events (adverse drug events, falls, hospital-acquired conditions) owned by the quality domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` (
    `site_hierarchy_id` BIGINT COMMENT 'Unique identifier for the site hierarchy node within the integrated delivery network (IDN). Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the physical care site when this hierarchy node represents an actual facility. Null for abstract organizational nodes (health system, region, market, campus). Links to facility.care_site for site-level nodes.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system account that last modified this hierarchy node record. Audit trail for accountability and compliance.',
    `parent_site_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the organizational hierarchy. Null for root-level health system node. Enables recursive parent-child relationships for multi-level IDN structures.',
    `aco_identifier` STRING COMMENT 'CMS-assigned ACO identifier if this hierarchy node participates in an ACO. Used for MSSP reporting and beneficiary attribution.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node participates in an Accountable Care Organization (ACO) model. Relevant for value-based care reporting and MSSP attribution.',
    `active_status` STRING COMMENT 'Current operational status of the hierarchy node. Tracks lifecycle including mergers, acquisitions, divestitures, and organizational restructuring within the IDN.. Valid values are `active|inactive|pending|merged|divested`',
    `ccn` STRING COMMENT 'Centers for Medicare and Medicaid Services (CMS) Certification Number for facilities within this hierarchy node. Required for Medicare/Medicaid participation.. Valid values are `^[0-9]{6}$`',
    `chest_pain_center_accreditation_flag` BOOLEAN COMMENT 'Indicates whether facilities in this hierarchy node hold Chest Pain Center accreditation from the American College of Cardiology (ACC) or Society of Cardiovascular Patient Care (SCPC).',
    `cms_star_rating` DECIMAL(18,2) COMMENT 'CMS Overall Hospital Quality Star Rating (1-5 stars) for facilities within this hierarchy node. Publicly reported quality measure impacting patient choice and value-based purchasing.',
    `cost_center_code` STRING COMMENT 'Primary cost center code assigned to this hierarchy node for financial accounting and management reporting. Aligns with SAP FI/CO or general ledger structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system. Audit trail for data lineage and compliance.',
    `critical_access_hospital_flag` BOOLEAN COMMENT 'Indicates whether facilities in this hierarchy node are designated as Critical Access Hospitals (CAH) under the Medicare Rural Hospital Flexibility Program.',
    `disproportionate_share_hospital_flag` BOOLEAN COMMENT 'Indicates whether facilities in this hierarchy node qualify for Disproportionate Share Hospital (DSH) payments due to serving a high percentage of low-income patients.',
    `effective_from_date` DATE COMMENT 'Date when this hierarchy relationship became effective. Supports temporal queries for historical organizational structure analysis and payer contract attribution.',
    `effective_to_date` DATE COMMENT 'Date when this hierarchy relationship ended or will end. Null for currently active relationships. Enables point-in-time organizational structure reconstruction.',
    `epic_organization_code` STRING COMMENT 'Epic EHR system organization identifier for this hierarchy node. Used for cross-system data integration and operational reporting from Epic Healthy Planet and Caboodle.',
    `geographic_region` STRING COMMENT 'Geographic region designation for the hierarchy node (e.g., Northeast, Mid-Atlantic, West Coast). Used for regional performance reporting and market analysis.',
    `hie_network_name` STRING COMMENT 'Name of the primary Health Information Exchange (HIE) network this hierarchy node participates in for clinical data sharing and care coordination.',
    `hie_participation_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node participates in regional or national Health Information Exchange (HIE) networks for interoperability and care coordination.',
    `joint_commission_accreditation_expiration_date` DATE COMMENT 'Expiration date of The Joint Commission accreditation for facilities within this hierarchy node. Triggers re-survey scheduling and compliance monitoring.',
    `joint_commission_accreditation_status` STRING COMMENT 'Current accreditation status from The Joint Commission (TJC) for facilities within this hierarchy node. Critical for regulatory compliance and payer contracting.. Valid values are `accredited|accredited_with_commendation|provisional|conditional|not_accredited|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was last updated. Supports change tracking and audit compliance for organizational structure changes.',
    `leapfrog_grade` STRING COMMENT 'Leapfrog Group Hospital Safety Grade (A-F) for facilities within this hierarchy node. Independent quality and safety rating used by employers and consumers.. Valid values are `A|B|C|D|F|not_rated`',
    `magnet_recognition_flag` BOOLEAN COMMENT 'Indicates whether facilities in this hierarchy node have achieved Magnet Recognition from the American Nurses Credentialing Center (ANCC) for nursing excellence.',
    `market_designation` STRING COMMENT 'Market or service area designation for the hierarchy node. Aligns with payer contracting territories and population health management catchment areas.',
    `node_code` STRING COMMENT 'Business identifier code for the hierarchy node. Used for reporting, payer contracting, and network planning. May align with Epic EHR organization codes or SAP organizational unit codes.',
    `node_level` STRING COMMENT 'Numeric depth of the node in the hierarchy tree. Root health system = 1, immediate children = 2, etc. Enables level-based queries and rollup aggregations.',
    `node_name` STRING COMMENT 'Full business name of the hierarchy node (e.g., Northeast Region, Metro Market, Downtown Campus, Main Hospital). Human-readable label for organizational rollup reporting.',
    `node_path` STRING COMMENT 'Materialized path from root to current node, typically slash-delimited hierarchy IDs (e.g., /1/5/12/45). Optimizes ancestor and descendant queries for reporting.',
    `node_type` STRING COMMENT 'Classification of the hierarchy node level within the IDN structure. Defines the organizational tier for multi-site rollup reporting and network planning. [ENUM-REF-CANDIDATE: health_system|region|market|campus|site|division|service_line — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments about this hierarchy node. Used for documenting organizational changes, mergers, acquisitions, or special considerations.',
    `npi` STRING COMMENT 'Type 2 (organizational) National Provider Identifier assigned by CMS for this hierarchy node when applicable. Used for claims submission and payer enrollment.. Valid values are `^[0-9]{10}$`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the hierarchy node. Impacts regulatory reporting, tax status, and payer contracting terms.. Valid values are `for_profit|non_profit|government|academic|faith_based|joint_venture`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary administrative or operational contact for this hierarchy node. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary administrative or operational contact for this hierarchy node. Used for internal coordination and escalation.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary administrative or operational contact for this hierarchy node. Organizational contact data classified as confidential.',
    `profit_center_code` STRING COMMENT 'Profit center code for this hierarchy node used in internal profitability analysis and segment reporting. Supports IDN-level financial consolidation.',
    `sap_organizational_unit` STRING COMMENT 'SAP S/4HANA organizational unit code for this hierarchy node. Links to SAP FI/CO cost centers, profit centers, and business areas for financial consolidation.',
    `sole_community_hospital_flag` BOOLEAN COMMENT 'Indicates whether facilities in this hierarchy node are designated as Sole Community Hospitals (SCH), qualifying for special Medicare payment adjustments.',
    `sort_order` STRING COMMENT 'Numeric sort order for displaying this hierarchy node among siblings in reports and user interfaces. Enables custom organizational display sequences.',
    `stroke_center_designation` STRING COMMENT 'Joint Commission or state-designated stroke center certification level for facilities within this hierarchy node. Impacts stroke care protocols and quality reporting.. Valid values are `comprehensive|thrombectomy_capable|primary|acute_ready|not_designated`',
    `tax_identification_number` STRING COMMENT 'Federal Tax Identification Number (TIN) or Employer Identification Number (EIN) associated with this hierarchy node for billing and revenue cycle purposes. May differ by organizational level.',
    `teaching_status` STRING COMMENT 'Academic teaching designation for the hierarchy node. Impacts Medicare Graduate Medical Education (GME) payments and case mix index (CMI) adjustments.. Valid values are `non_teaching|minor_teaching|major_teaching|academic_medical_center`',
    `trauma_level` STRING COMMENT 'American College of Surgeons (ACS) trauma center designation level for facilities within this hierarchy node. Impacts emergency department (ED) capabilities and transfer protocols.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_designated`',
    CONSTRAINT pk_site_hierarchy PRIMARY KEY(`site_hierarchy_id`)
) COMMENT 'Organizational and geographic hierarchy of care sites within the integrated delivery network (IDN), defining parent-child relationships between health system, region, market, hospital campus, and individual care site. Captures hierarchy node name, node type (health system, region, market, campus, site), parent node reference, effective start date, effective end date, and active status. Enables multi-site rollup reporting, network planning, and payer contracting at the IDN level.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`network_contract` (
    `network_contract_id` BIGINT COMMENT 'Primary key for the network_contract association',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to the care delivery location participating in the payer network',
    `payer_id` BIGINT COMMENT 'Foreign key linking to the insurance payer offering the network contract',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this contract automatically renews at the end of its term unless either party provides notice of non-renewal. True for evergreen contracts.',
    `claims_submission_endpoint` STRING COMMENT 'Specific EDI address, clearinghouse identifier, or portal URL for submitting claims under this contract. May differ from the payers default submission endpoint for contract-specific routing.',
    `contract_administrator_name` STRING COMMENT 'Name of the individual or department responsible for managing this contract relationship. Primary contact for contract questions, amendments, and dispute resolution.',
    `contract_effective_date` DATE COMMENT 'Date on which the current contract with this payer became or will become effective. Used to determine applicable fee schedules, billing rules, and benefit structures. [Moved from payer: Contract effective date in the payer product represents a single date, but each facility has its own contract effective date with the payer. Facility A may have contracted with Payer X in 2020 while Facility B contracted with the same payer in 2023. This attribute belongs in the association.]',
    `contract_number` STRING COMMENT 'Unique identifier assigned by the payer or contracting department to this specific network participation agreement. Used for contract reference in correspondence, claims, and audits.',
    `contract_status` STRING COMMENT 'Current status of the contractual relationship between the healthcare organization and this payer. Active indicates contract is in force; pending indicates contract is signed but not yet effective; suspended indicates temporary hold; terminated indicates contract ended by mutual agreement or breach; expired indicates contract term ended without renewal; negotiating indicates contract is under discussion but not yet signed. [Moved from payer: Contract status in the payer product appears to be a general payer relationship status, but true contract status is specific to each care_site-payer combination. A payer may have active contracts with some facilities and terminated contracts with others simultaneously. This attribute belongs in the association.]. Valid values are `active|pending|suspended|terminated|expired|negotiating`',
    `contract_termination_date` DATE COMMENT 'Date on which the current contract with this payer ends or ended. Null for open-ended contracts or contracts without specified end date. Used to manage contract renewals and transition planning. [Moved from payer: Contract termination date in the payer product represents a single date, but each facility has its own contract termination date with the payer. Some facilities may have ongoing contracts while others have terminated. This attribute belongs in the association.]',
    `credentialing_required_flag` BOOLEAN COMMENT 'Indicates whether individual provider credentialing is required for this facility to participate in the network under this contract. True for most commercial payers, may be false for government programs.',
    `effective_date` DATE COMMENT 'Date on which this network participation agreement became or will become active. Claims for services on or after this date are subject to this contracts terms.',
    `network_adequacy_status` STRING COMMENT 'Indicates whether this facilitys participation contributes to the payers network adequacy requirements under state or federal regulations. Compliant means the facility meets time/distance standards.',
    `network_tier` STRING COMMENT 'Classification of the facility within the payers network hierarchy. Determines patient cost-sharing levels and referral requirements. Preferred/Tier 1 typically indicates lower patient out-of-pocket costs.',
    `payment_terms_days` STRING COMMENT 'Number of days within which the payer is contractually obligated to remit payment for clean claims under this contract. Typically 30, 45, or 60 days.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether this contract requires prior authorization for certain services. Contract-specific flag may differ from payers general prior authorization policy.',
    `provider_count_at_facility` STRING COMMENT 'Number of individual providers at this facility who are credentialed and contracted under this network agreement. Used for network directory accuracy and adequacy reporting.',
    `reimbursement_method` STRING COMMENT 'Primary payment methodology defined in this contract. Determines how claims are priced and paid. DRG applies to inpatient hospital services, fee-for-service to itemized billing, capitation to per-member-per-month arrangements.',
    `network_contract_status` STRING COMMENT 'Current operational status of the network participation agreement. Active indicates the contract is in force and claims can be submitted. Suspended indicates temporary hold on network participation.',
    `termination_date` DATE COMMENT 'Date on which this network participation agreement ends or ended. Null for open-ended contracts. Claims for services after this date are not covered under this contract.',
    `timely_filing_limit_days` STRING COMMENT 'Number of days from date of service within which claims must be submitted under this contract. Contract-specific value may override the payers default timely filing limit.',
    CONSTRAINT pk_network_contract PRIMARY KEY(`network_contract_id`)
) COMMENT 'This association product represents the contractual network participation agreement between a care delivery site and an insurance payer. It captures the legal and operational terms governing how the facility participates in the payers provider network, including reimbursement methodology, network tier status, claims submission requirements, and credentialing obligations. Each record links one care_site to one payer with contract-specific attributes that exist only in the context of this bilateral agreement. This is the operational foundation for revenue cycle management, network adequacy compliance, and provider directory accuracy.. Existence Justification: Healthcare facilities routinely participate in multiple insurance payer networks simultaneously (Medicare, Medicaid, Blue Cross, Aetna, UnitedHealthcare, etc.), and each payer contracts with hundreds or thousands of facilities to build adequate provider networks. This is a foundational operational reality in healthcare revenue cycle management. Each care_site-payer combination has its own contract with unique terms: effective dates, reimbursement rates, network tier status, claims submission rules, and credentialing requirements. Business stakeholders actively manage these contracts through contracting departments, refer to them as payer contracts or network participation agreements, and query them regularly for network directory updates, contract renewals, and revenue cycle operations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` (
    `facility_program_participation_id` BIGINT COMMENT 'Primary key for facility_program_participation',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to the care delivery location participating in the quality program',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for coordinating this care sites participation in this specific quality program. Manages data submission, performance tracking, and compliance for this site-program combination.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to the quality program in which the care site is participating',
    `quality_program_participation_id` BIGINT COMMENT 'FK to SSOT owner quality.quality_program_participation for the program_participation entity.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was created. Supports audit trail and data lineage tracking.',
    `exemption_status` STRING COMMENT 'Indicates whether this care site has been granted an exemption from reporting or payment adjustment for this program and performance year. Captures CMS low-volume, extreme hardship, and other exemption categories.',
    `participation_end_date` DATE COMMENT 'Date the care site ceased participating in this quality program. Null for active participations. Used to track historical program participation and determine reporting obligations.',
    `participation_start_date` DATE COMMENT 'Date the care site began participating in this quality program. Determines when performance measurement and reporting obligations begin for this site-program combination.',
    `participation_status` STRING COMMENT 'Current lifecycle status of the care sites participation in this quality program. Active indicates ongoing participation with reporting obligations. Suspended indicates temporary pause. Withdrawn indicates voluntary exit.',
    `payment_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of payment adjustment (positive for incentive, negative for penalty) applied to this care sites Medicare reimbursement as a result of performance in this quality program for this performance year.',
    `performance_year` STRING COMMENT 'Calendar or program year for which this participation record and associated performance data applies. Aligns with the quality programs performance period configuration.',
    `program_participation_code` BIGINT COMMENT 'Unique surrogate identifier for the care site quality program participation record. Primary key for the association.',
    `submission_date` DATE COMMENT 'Date this care site submitted quality measure data or attestation for this program and performance year. Used to track compliance with submission deadlines.',
    `submission_method` STRING COMMENT 'Method by which this care site submits quality measure data to the program sponsor for this specific program. Determines submission workflows, data validation requirements, and deadlines.',
    `submission_status` STRING COMMENT 'Current status of the quality data submission for this care site-program-year combination. Tracks submission workflow from preparation through acceptance by program sponsor.',
    `total_performance_score` DECIMAL(18,2) COMMENT 'Composite performance score achieved by this care site for this quality program in this performance year. Calculated per program-specific methodology. Determines payment adjustments and public reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was last modified. Supports change tracking and data quality monitoring.',
    CONSTRAINT pk_facility_program_participation PRIMARY KEY(`facility_program_participation_id`)
) COMMENT 'This association product represents the participation relationship between care sites and quality programs within the integrated delivery network. It captures site-specific enrollment, performance tracking, and regulatory submission data for each care sites participation in CMS Value-Based Purchasing, MIPS, accreditation programs, and internal quality initiatives. Each record links one care site to one quality program with participation dates, coordinator assignments, submission methods, performance scores, and payment adjustments that exist only in the context of this specific site-program combination. SSOT for quality program participation tracking and performance management at the facility level.. Existence Justification: In healthcare integrated delivery networks, care sites participate in multiple quality programs simultaneously (a hospital participates in VBP, HRRP, HAC Reduction, MIPS, TJC accreditation), and each quality program spans multiple care sites across the health system. Quality teams actively manage site-specific participation including enrollment dates, coordinator assignments, submission methods, performance tracking, and payment adjustments for each site-program combination. This is an operational M:N relationship with substantial relationship data.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` (
    `block_assignment_id` BIGINT COMMENT 'Unique identifier for each OR block assignment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the surgeon or surgical team member assigned the block time',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to the operating room suite where the block time is allocated',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the block assignment. Active = currently in effect; Suspended = temporarily paused; Expired = past expiration date; Pending = future-dated; Cancelled = terminated before expiration.',
    `block_time_end` TIMESTAMP COMMENT 'End time of the recurring OR block window (e.g., 15:00:00 for afternoon end). Defines when the surgeons allocated OR time ends.',
    `block_time_start` TIMESTAMP COMMENT 'Start time of the recurring OR block window (e.g., 07:00:00 for a morning block). Defines when the surgeons allocated OR time begins.',
    `block_type` STRING COMMENT 'Classification of the OR block assignment. Dedicated = surgeon has exclusive use; Shared = multiple surgeons share the block; Flex = can be released if unused; Release = must be released if not booked by deadline; On-Call = reserved for emergency cases.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this block assignment record was created in the system. Audit trail for block allocation decisions.',
    `day_of_week` STRING COMMENT 'Day of the week on which this recurring block assignment is scheduled (e.g., Monday, Wednesday). Supports weekly recurring block schedules.',
    `effective_date` DATE COMMENT 'Date on which this block assignment becomes active. Supports future-dated block schedule changes and contract renewals.',
    `expiration_date` DATE COMMENT 'Date on which this block assignment expires or is scheduled for review. Null indicates an ongoing block assignment. Used for contract-based block allocations and periodic utilization reviews.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this block assignment record was last modified. Tracks changes to block schedules, priorities, or terms.',
    `priority_level` STRING COMMENT 'Priority ranking for this block assignment (1=highest, 5=lowest). Used to resolve conflicts when multiple surgeons request the same OR time slot or when blocks must be bumped for emergencies.',
    `release_deadline_hours` STRING COMMENT 'Number of hours before the block start time by which the surgeon must release unused block time (e.g., 72 hours). Allows facility to reallocate unused OR capacity.',
    `utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum utilization percentage required for the surgeon to retain this block assignment (e.g., 80.00 means surgeon must use at least 80% of allocated block time). Used for block release policies and utilization management.',
    CONSTRAINT pk_block_assignment PRIMARY KEY(`block_assignment_id`)
) COMMENT 'This association product represents the scheduled block time assignment between an operating room suite and a surgeon or surgical team member. It captures recurring OR block schedules that allocate specific time windows in specific operating rooms to specific surgeons. Each record links one OR suite to one employee (surgeon) with block schedule attributes including time windows, day of week, block type, priority level, and effective period. Critical for OR utilization management, surgical scheduling, and capacity planning in perioperative services.. Existence Justification: OR block scheduling is a core perioperative business process where surgeons are allocated recurring time blocks in specific operating rooms. One surgeon typically has block assignments in multiple ORs (e.g., general OR on Mondays, cardiac OR on Thursdays), and one OR has blocks assigned to multiple surgeons across different days and time windows. The business actively manages these block assignments with specific terms (block type, priority, utilization thresholds, release deadlines) and tracks them as operational entities called OR Block Assignments or Surgical Block Schedules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` (
    `equipment_authorization_id` BIGINT COMMENT 'Unique identifier for each equipment authorization record. Primary key.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to the equipment asset that requires authorized operators',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is authorized to operate the equipment',
    `equipment_competency_verifier_employee_id` BIGINT COMMENT 'Employee ID of the clinical educator, biomedical engineer, or supervisor who verified the employees competency to operate this equipment. Supports audit trail and accountability.',
    `assignment_end_date` DATE COMMENT 'Date when the equipment authorization expires or was terminated. Null indicates active authorization. Used for recertification scheduling and access control.',
    `assignment_start_date` DATE COMMENT 'Date when the equipment authorization became effective. Used for compliance tracking and audit trails.',
    `assignment_type` STRING COMMENT 'Classification of the authorization relationship. PRIMARY indicates the employee is the primary designated operator; BACKUP indicates backup/secondary operator; SHARED indicates shared equipment pool; TRAINING indicates trainee status with supervised use only.',
    `authorization_status` STRING COMMENT 'Current status of the equipment authorization. ACTIVE indicates valid authorization; EXPIRED indicates recertification needed; SUSPENDED indicates temporary hold; REVOKED indicates authorization withdrawn; PENDING indicates awaiting competency verification.',
    `competency_verified_date` DATE COMMENT 'Date when the employees competency to operate this specific equipment was verified through testing, observation, or certification. Required for TJC HR.01.06.01 compliance and clinical engineering safety protocols.',
    `notes` STRING COMMENT 'Free-text notes regarding special conditions, restrictions, or context for this equipment authorization (e.g., Authorized for day shift only, Requires supervision for first 30 days).',
    `primary_user_flag` BOOLEAN COMMENT 'Indicates whether this employee is designated as the primary user responsible for this equipment asset. Used for maintenance coordination, recall notifications, and equipment assignment tracking.',
    `recertification_due_date` DATE COMMENT 'Date when the employee must complete recertification or competency reassessment for this equipment. Frequency determined by equipment risk category, manufacturer requirements, and organizational policy.',
    `training_completion_date` DATE COMMENT 'Date when the employee completed formal training on this equipment type. May precede competency verification date. Used for training program tracking and compliance reporting.',
    CONSTRAINT pk_equipment_authorization PRIMARY KEY(`equipment_authorization_id`)
) COMMENT 'This association product represents the authorization and competency verification between equipment assets and clinical workforce members. It captures which employees are trained, authorized, and competent to operate specific medical and facility equipment. Each record links one equipment asset to one employee with competency verification dates, authorization periods, assignment type (primary vs backup operator), and usage authorization status. Supports biomedical engineering competency tracking, clinical staff credentialing, equipment safety compliance, and TJC HR.01.06.01 staff competency requirements.. Existence Justification: Healthcare operations require explicit tracking of which clinical staff members are trained, authorized, and competent to operate specific medical equipment assets. One employee can be authorized to use many different equipment types (ventilators, infusion pumps, imaging devices, surgical robots), and one equipment asset can have multiple authorized operators (primary user, backup operators, trained staff pool). This is an operational business process managed by biomedical engineering and clinical education departments, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization',
    `care_site_id` BIGINT COMMENT 'add column care_site_id (BIGINT) with FK to facility.care_site.care_site_id - organization should be linked to care_site to anchor the facility hierarchy',
    `parent_organization_id` BIGINT COMMENT 'Reference to the parent organization if this entity is part of a larger health system or integrated delivery network.',
    `accreditation_effective_date` DATE COMMENT 'Date when current accreditation status became effective.',
    `accreditation_expiration_date` DATE COMMENT 'Date when current accreditation expires and renewal is required.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing with recognized healthcare accrediting bodies.',
    `accrediting_body` STRING COMMENT 'Name of the primary accreditation organization (e.g., Joint Commission, DNV, HFAP).',
    `address_line_1` STRING COMMENT 'Primary street address of the organization facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `city` STRING COMMENT 'City where the organization facility is located.',
    `closure_date` DATE COMMENT 'Date when the organization ceased operations, if applicable.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the organization is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organization record was first created in the system.',
    `critical_access_hospital_indicator` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under Medicare.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the organization operates, if different from legal name.',
    `email_address` STRING COMMENT 'Primary email address for organizational communication.',
    `emergency_services_indicator` BOOLEAN COMMENT 'Indicates whether the facility provides emergency department services.',
    `established_date` DATE COMMENT 'Date when the organization was originally established or founded.',
    `facility_type` STRING COMMENT 'Specific facility classification based on care delivery focus and patient population served.',
    `fax_number` STRING COMMENT 'Fax number for document transmission to the organization.',
    `health_system_name` STRING COMMENT 'Name of the integrated delivery network or health system to which this organization belongs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organization record was last updated.',
    `license_effective_date` DATE COMMENT 'Date when the current facility license became effective.',
    `license_expiration_date` DATE COMMENT 'Date when the current facility license expires.',
    `license_number` STRING COMMENT 'State-issued license number authorizing the organization to operate as a healthcare facility.',
    `license_status` STRING COMMENT 'Current status of the facility operating license.',
    `medicaid_provider_number` STRING COMMENT 'State-issued Medicaid provider identification number for billing and reimbursement.',
    `medicare_provider_number` STRING COMMENT 'Six-digit CMS Certification Number (CCN) identifying the organization for Medicare billing.',
    `organization_name` STRING COMMENT 'Official legal name of the healthcare organization, facility, or entity.',
    `national_provider_identifier` STRING COMMENT 'Unique 10-digit identification number issued by CMS for healthcare providers and organizations.',
    `operational_start_date` DATE COMMENT 'Date when the facility began active operations and patient care delivery.',
    `operational_status` STRING COMMENT 'Current operational state of the organization in its lifecycle.',
    `ownership_type` STRING COMMENT 'Legal ownership structure and governance model of the organization.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organization.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the facility address.',
    `service_area_description` STRING COMMENT 'Geographic description of the primary service area or catchment area served by the organization.',
    `staffed_bed_count` STRING COMMENT 'Number of beds that are currently staffed and available for patient use.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the facility is located.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID assigned by the IRS.',
    `teaching_hospital_indicator` BOOLEAN COMMENT 'Indicates whether the facility is affiliated with a medical school and provides graduate medical education.',
    `total_bed_count` STRING COMMENT 'Total number of licensed beds available across all units in the facility.',
    `trauma_level` STRING COMMENT 'Trauma center designation level indicating capability to treat severe injuries.',
    `organization_type` STRING COMMENT 'Classification of the healthcare organization based on primary service delivery model.',
    `website_url` STRING COMMENT 'Official website URL for the organization.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for organization. Referenced by organization_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_service` (
    `facility_service_id` BIGINT COMMENT 'Unique identifier for the facility service record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Clinical services are often building-specific (Cardiac Surgery in Main Hospital Building, Outpatient Dialysis in Ambulatory Building). Adding building_id enables building-level service catalog managem',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility where this service is offered.',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center to which expenses and revenues for this service are allocated for accounting and financial reporting purposes.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Service line governance and accreditation requirements mandate a named medical director for each clinical service. Links to clinician record for credentialing verification, privileging confirmation, a',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Clinical services are often unit-specific (Cardiac Surgery in OR Unit 3, Interventional Cardiology in Cath Lab Unit). Adding unit_id enables unit-level service delivery tracking, supports unit-specifi',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit that has administrative ownership and operational responsibility for the service.',
    `accreditation_body` STRING COMMENT 'Name of the external accrediting or certifying organization that has granted accreditation or certification for this service, such as The Joint Commission, American College of Surgeons, Commission on Cancer, or specialty-specific bodies.',
    `accreditation_date` DATE COMMENT 'Date on which the service received its current accreditation or certification from the accrediting body.',
    `accreditation_expiration_date` DATE COMMENT 'Date on which the current accreditation or certification expires and must be renewed to maintain the service designation.',
    `accreditation_level` STRING COMMENT 'Specific level or designation of accreditation or certification achieved, such as Level I Trauma Center, Comprehensive Stroke Center, NICU Level III, Magnet Recognition, or Commission on Cancer Accredited Program.',
    `accreditation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service requires specific accreditation or certification from an external body such as The Joint Commission, American College of Surgeons, or specialty-specific accrediting organizations.',
    `bariatric_surgery_accreditation` STRING COMMENT 'Metabolic and Bariatric Surgery Accreditation and Quality Improvement Program (MBSAQIP) accreditation status for bariatric surgery services.',
    `cancer_program_accreditation` STRING COMMENT 'Commission on Cancer accreditation status or designation for oncology services, such as Comprehensive Community Cancer Program, Academic Comprehensive Cancer Program, or Community Cancer Program.',
    `chest_pain_center_accreditation` STRING COMMENT 'Accreditation status for chest pain or cardiac emergency services, such as Chest Pain Center with PCI or Chest Pain Center accreditation from the American College of Cardiology or Society of Cardiovascular Patient Care.',
    `clinical_specialty` STRING COMMENT 'Specific clinical specialty or subspecialty associated with the service, such as Cardiothoracic Surgery, Interventional Cardiology, Neonatology, Radiation Oncology, or Psychiatry.',
    `cms_service_type_code` STRING COMMENT 'CMS-defined service type code used for billing, claims processing, and regulatory reporting to identify the nature of the service provided.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this facility service record was first created in the system.',
    `emergency_service_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service is classified as an emergency service subject to Emergency Medical Treatment and Labor Act (EMTALA) requirements.',
    `end_date` DATE COMMENT 'Date on which the service was discontinued or is planned to be discontinued at the care site. Null if the service is ongoing.',
    `license_expiration_date` DATE COMMENT 'Date on which the service license expires and must be renewed to continue legal operation of the service.',
    `license_number` STRING COMMENT 'Official license number issued by the state or federal regulatory authority for services that require specific licensure to operate.',
    `license_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service requires a specific state or federal license to operate legally, such as a radiation therapy license or behavioral health program license.',
    `line` STRING COMMENT 'High-level service line grouping such as Cardiovascular, Neurosciences, Oncology, Womens Health, Pediatrics, Behavioral Health, Emergency Services, or Surgical Services.',
    `nicu_level` STRING COMMENT 'American Academy of Pediatrics NICU level designation (Level I through Level IV) indicating the complexity of neonatal care capabilities. Not applicable for non-neonatal services.. Valid values are `level_i|level_ii|level_iii|level_iv|not_applicable`',
    `patient_access_phone` STRING COMMENT 'Primary phone number for patients or referring providers to contact for scheduling, inquiries, or referrals to this service.',
    `payer_contracted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service is included in payer contracts and eligible for reimbursement under managed care agreements.',
    `referral_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether patients require a physician referral or prior authorization to access this service, commonly used for specialty services and payer contracting.',
    `service_category` STRING COMMENT 'Broad category of service delivery model indicating whether the service is provided on an inpatient, outpatient, ambulatory, emergency, telehealth, or home health basis.. Valid values are `inpatient|outpatient|ambulatory|emergency|telehealth|home_health`',
    `service_code` STRING COMMENT 'Unique alphanumeric code identifying the clinical service or program within the organizations service catalog.',
    `service_description` STRING COMMENT 'Detailed narrative description of the clinical service or program, including scope of care, patient populations served, and key capabilities or technologies available.',
    `service_name` STRING COMMENT 'Full descriptive name of the clinical service or program offered at the care site, such as Cardiac Surgery, Level I Trauma Center, Comprehensive Stroke Center, NICU Level III, Radiation Oncology, Behavioral Health, or Telehealth.',
    `service_status` STRING COMMENT 'Current operational status of the service indicating whether it is actively offered, temporarily suspended, planned for future launch, or discontinued.. Valid values are `active|inactive|suspended|planned|discontinued`',
    `start_date` DATE COMMENT 'Date on which the service was first made available to patients at the care site, marking the operational launch of the service or program.',
    `stroke_center_designation` STRING COMMENT 'The Joint Commission stroke center certification level indicating the facilitys capability to provide stroke care, such as Comprehensive Stroke Center, Primary Stroke Center, Acute Stroke Ready, or Thrombectomy-Capable. Not applicable for non-stroke services.. Valid values are `comprehensive|primary|acute_ready|thrombectomy_capable|not_applicable`',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service can be delivered via telehealth or virtual care modalities, supporting remote patient access.',
    `trauma_level` STRING COMMENT 'American College of Surgeons trauma center designation level (Level I through Level V) indicating the capability and resources available for trauma care. Not applicable for non-trauma services.. Valid values are `level_i|level_ii|level_iii|level_iv|level_v|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this facility service record was last modified or updated in the system.',
    `url` STRING COMMENT 'Web address or URL providing public-facing information about the service, used for patient education, referral routing, and marketing purposes.',
    `volume_annual` STRING COMMENT 'Estimated or actual annual volume of patients or procedures served by this service, used for capacity planning, quality benchmarking, and payer contracting negotiations.',
    CONSTRAINT pk_facility_service PRIMARY KEY(`facility_service_id`)
) COMMENT 'Catalog of services and clinical programs offered at a care site, such as cardiac surgery, level I trauma, comprehensive stroke center, NICU level III, radiation oncology, behavioral health, and telehealth. Captures service name, service line, clinical specialty, service category, CMS service type code, start date, end date, accreditation or certification required, and active status. Supports patient access, referral routing, and payer contracting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` (
    `facility_contract_id` BIGINT COMMENT 'Unique identifier for the facility contract record. Primary key.',
    `building_id` BIGINT COMMENT 'The specific building within the facility covered by this contract, if applicable. Allows building-level contract assignment.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Facility service contracts with vendors accessing PHI (IT, billing, transcription, shredding, cloud services) require executed BAAs per HIPAA. Real business process: contract-to-BAA mapping for compli',
    `care_site_id` BIGINT COMMENT 'The facility or care site to which this contract applies. Links to the facility master data.',
    `cost_center_id` BIGINT COMMENT 'The cost center or department to which contract expenses are allocated for financial reporting and budgeting.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor or service provider. Links to the vendor master data in supply chain or procurement systems.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Estimated or actual annual spend under this contract. Used for budgeting and variance analysis.',
    `approval_date` DATE COMMENT 'Date on which the contract was formally approved by the organization. Format: yyyy-MM-dd.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved the contract on behalf of the organization.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews unless notice is provided. True if auto-renewal is enabled, False otherwise.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the contract for easy identification and reporting.',
    `contract_number` STRING COMMENT 'The externally-known unique contract number or identifier assigned by the organization or vendor. Used for reference in procurement and vendor management systems.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract. Indicates whether the contract is active, expired, pending renewal, terminated, in draft, or suspended.. Valid values are `active|expired|pending_renewal|terminated|draft|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `document_url` STRING COMMENT 'URL or file path to the stored contract document in the document management system for reference and audit purposes.',
    `end_date` DATE COMMENT 'The date on which the contract expires or terminates. Nullable for open-ended or evergreen contracts. Format: yyyy-MM-dd.',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code used for posting contract expenses in the financial system.',
    `insurance_certificate_expiration_date` DATE COMMENT 'Expiration date of the vendors current insurance certificate on file. Used to track compliance with insurance requirements. Format: yyyy-MM-dd.',
    `insurance_requirement_description` STRING COMMENT 'Description of insurance coverage requirements the vendor must maintain (e.g., general liability, professional liability, workers compensation, minimum coverage amounts).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent vendor performance review or evaluation. Used to track vendor management activities. Format: yyyy-MM-dd.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this contract record. Supports audit trail and data governance.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next vendor performance review or evaluation. Supports proactive vendor management. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the contract.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required to terminate or opt out of renewal. Critical for contract management and planning.',
    `owner_email` STRING COMMENT 'Email address of the contract owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the internal staff member or department responsible for managing and overseeing this contract.',
    `owner_phone` STRING COMMENT 'Phone number of the contract owner for direct contact.',
    `payment_terms` STRING COMMENT 'Payment terms and schedule defined in the contract (e.g., Net 30, Net 60, monthly in arrears, quarterly in advance).',
    `performance_metric_description` STRING COMMENT 'Description of key performance indicators (KPIs) and metrics used to evaluate vendor performance under the contract.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on regulatory compliance requirements applicable to this contract, such as OSHA workplace safety, EPA environmental standards, Joint Commission requirements, or state health department regulations for contracted services.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an option to renew at the end of the term. True if renewal option exists, False otherwise.',
    `service_type` STRING COMMENT 'Category of service provided under this contract. Includes janitorial, biomedical equipment service (OEM and third-party), elevator maintenance, HVAC service, security, waste management (regulated medical waste, hazardous waste), food services, landscaping, and pest control. [ENUM-REF-CANDIDATE: janitorial|biomedical_equipment_service|elevator_maintenance|hvac_service|security_services|waste_management|food_services|landscaping|pest_control|other — 10 candidates stripped; promote to reference product]',
    `signed_date` DATE COMMENT 'Date on which the contract was signed by both parties. Used for audit trail and contract lifecycle tracking. Format: yyyy-MM-dd.',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT 'Maximum response time in hours guaranteed by the vendor under the SLA for service requests or incidents.',
    `sla_terms` STRING COMMENT 'Summary of the Service Level Agreement terms, including response times, uptime guarantees, and performance metrics defined in the contract.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Minimum uptime or availability percentage guaranteed by the vendor (e.g., 99.5% for critical systems).',
    `start_date` DATE COMMENT 'The date on which the contract becomes effective and services commence. Format: yyyy-MM-dd.',
    `termination_clause_description` STRING COMMENT 'Summary of the termination clause, including conditions under which either party may terminate the contract (e.g., for cause, for convenience, breach of terms).',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract over its full term. Used for budget planning and vendor spend analysis.',
    `value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for service requests and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the primary vendor contact or account manager for this contract.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the primary vendor contact for escalations and urgent service needs.',
    CONSTRAINT pk_facility_contract PRIMARY KEY(`facility_contract_id`)
) COMMENT 'Facility-specific vendor and service contracts for building operations, including janitorial services, biomedical equipment service agreements (OEM and third-party), elevator maintenance, HVAC service contracts, security services, waste management (regulated medical waste, hazardous waste), food services, landscaping, and pest control. Captures contract number, vendor name, vendor ID, service type, contract start and end dates, contract value, annual spend, SLA terms and performance metrics, renewal option, auto-renewal flag, notice period, insurance requirements, and contract status (active, expired, pending renewal, terminated). Distinct from clinical or payer contracts owned by other domains. Supports vendor performance management, budget forecasting, and regulatory compliance for contracted services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` (
    `facility_inspection_id` BIGINT COMMENT 'Unique identifier for the facility inspection record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Inspections are often building-specific (fire safety inspections, structural inspections, building code compliance, elevator inspections). Adding building_id enables building-level inspection tracking',
    `care_site_id` BIGINT COMMENT 'Reference to the facility where the inspection was conducted.',
    `org_unit_id` BIGINT COMMENT 'Reference to the primary department responsible for coordinating the inspection response and corrective actions.',
    `accreditation_cycle_year` STRING COMMENT 'Year within the accreditation cycle when this inspection occurred (typically 1, 2, or 3 for TJC triennial cycle).',
    `accreditation_decision` STRING COMMENT 'Specific accreditation decision issued by TJC or other accrediting body following the inspection.. Valid values are `accredited|accredited_with_follow_up|preliminary_denial|denied|not_applicable`',
    `certification_decision` STRING COMMENT 'Specific certification decision issued by CMS or state authority following the inspection.. Valid values are `certified|conditional_certification|certification_denied|not_applicable`',
    `cms_certification_number` STRING COMMENT 'CMS-assigned certification number associated with this inspection, if applicable.',
    `complaint_based_flag` BOOLEAN COMMENT 'Indicates whether the inspection was triggered by a complaint or allegation rather than a routine scheduled survey.',
    `condition_level_count` STRING COMMENT 'Number of findings classified as condition-level deficiencies, representing non-compliance with a CMS Condition of Participation.',
    `coordinator_name` STRING COMMENT 'Name of the facility staff member serving as the primary coordinator for the inspection and follow-up activities.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred by the facility for the inspection, including survey fees, consultant fees, and preparation costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system.',
    `deemed_status_applicable_flag` BOOLEAN COMMENT 'Indicates whether the inspection is related to deemed status, where TJC accreditation is accepted by CMS in lieu of a separate CMS certification survey.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection concluded.',
    `environment_of_care_chapter` STRING COMMENT 'Specific TJC Environment of Care chapter or section that was the focus of the inspection (e.g., EC.02.01.01 for Safety Management).',
    `findings_count` STRING COMMENT 'Total number of individual findings or deficiencies identified during the inspection.',
    `follow_up_survey_date` DATE COMMENT 'Date on which the follow-up survey was conducted or is scheduled to verify correction of deficiencies.',
    `follow_up_survey_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up survey is required to verify correction of deficiencies.',
    `immediate_jeopardy_count` STRING COMMENT 'Number of findings classified as immediate jeopardy, indicating situations where serious injury, harm, impairment, or death has occurred or is likely to occur.',
    `inspection_date` DATE COMMENT 'Date on which the inspection was conducted or initiated.',
    `inspection_number` STRING COMMENT 'Business identifier for the inspection, often assigned by the inspecting organization or internal tracking system.',
    `inspection_scope` STRING COMMENT 'Breadth of the inspection coverage. Indicates whether the inspection was facility-wide, focused on a specific department, system, unit, or service line.. Valid values are `facility_wide|department_specific|system_specific|unit_specific|service_line_specific`',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection. Tracks progression from scheduled through completion, report issuance, Plan of Correction (PoC) submission and acceptance, to closure. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|report_pending|report_issued|poc_submitted|poc_accepted|closed — 8 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Category of inspection conducted. Includes TJC (The Joint Commission) triennial survey, CMS (Centers for Medicare and Medicaid Services) certification survey, state DOH (Department of Health) survey, fire marshal inspection, OSHA (Occupational Safety and Health Administration) inspection, internal safety round, life safety code inspection, CMS validation survey, CMS complaint survey, and deemed status survey. [ENUM-REF-CANDIDATE: tjc_triennial_survey|cms_certification_survey|state_doh_survey|fire_marshal_inspection|osha_inspection|internal_safety_round|life_safety_code_inspection|cms_validation_survey|cms_complaint_survey|deemed_status_survey — 10 candidates stripped; promote to reference product]',
    `inspector_credentials` STRING COMMENT 'Professional credentials or certifications held by the inspector (e.g., RN, MD, CIH, PE).',
    `inspector_name` STRING COMMENT 'Full name of the lead inspector or surveyor who conducted the inspection.',
    `inspector_organization` STRING COMMENT 'Name of the organization or agency that the inspector represents (e.g., The Joint Commission, CMS, State Department of Health, Fire Marshal Office, OSHA).',
    `life_safety_code_edition` STRING COMMENT 'Edition of the NFPA (National Fire Protection Association) 101 Life Safety Code used as the standard for this inspection.',
    `next_scheduled_inspection_date` DATE COMMENT 'Date on which the next routine inspection is scheduled or anticipated.',
    `notes` STRING COMMENT 'General notes, observations, or comments related to the inspection that do not fit into structured fields.',
    `observation_count` STRING COMMENT 'Number of findings classified as observations, representing areas for improvement that do not constitute formal deficiencies.',
    `overall_disposition` STRING COMMENT 'Final outcome or decision rendered by the inspecting body. Includes passed, conditional, failed, preliminary denial of accreditation, accreditation with follow-up, accreditation denied, certification granted, or certification denied. [ENUM-REF-CANDIDATE: passed|conditional|failed|preliminary_denial_of_accreditation|accreditation_with_follow_up|accreditation_denied|certification_granted|certification_denied — 8 candidates stripped; promote to reference product]',
    `poc_acceptance_date` DATE COMMENT 'Date on which the inspecting body formally accepted the facilitys Plan of Correction.',
    `poc_completion_verification_date` DATE COMMENT 'Date on which the inspecting body verified that all corrective actions in the Plan of Correction have been completed.',
    `poc_due_date` DATE COMMENT 'Date by which the facility must submit its Plan of Correction to the inspecting body.',
    `poc_status` STRING COMMENT 'Current status of the Plan of Correction submission and review process. [ENUM-REF-CANDIDATE: not_required|pending_submission|submitted|under_review|accepted|rejected|revision_requested — 7 candidates stripped; promote to reference product]',
    `poc_submission_date` DATE COMMENT 'Date on which the facility submitted its Plan of Correction to the inspecting body.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory or accrediting authority that conducted or mandated the inspection (e.g., The Joint Commission, CMS, State Department of Health).',
    `report_issued_date` DATE COMMENT 'Date on which the formal inspection report was issued to the facility.',
    `scope_description` STRING COMMENT 'Detailed narrative describing the specific areas, departments, systems, or services included in the inspection scope.',
    `standard_level_count` STRING COMMENT 'Number of findings classified as standard-level deficiencies, representing non-compliance with a specific standard but not rising to condition-level.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection began.',
    `tjc_survey_type` STRING COMMENT 'Specific type of TJC survey conducted (triennial, mid-cycle, for-cause, follow-up, unannounced).. Valid values are `triennial|mid_cycle|for_cause|follow_up|unannounced|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified in the system.',
    CONSTRAINT pk_facility_inspection PRIMARY KEY(`facility_inspection_id`)
) COMMENT 'Regulatory, accreditation, and internal facility inspection record with detailed findings tracking and Plans of Correction (PoC) lifecycle management. Captures inspection type (TJC triennial survey, CMS certification survey, state DOH survey, fire marshal inspection, OSHA inspection, internal safety round, life safety code inspection), inspection date, inspector name and organization, scope (facility-wide, department, specific system), overall disposition (passed, conditional, failed, preliminary denial of accreditation). Individual findings are tracked as detail records capturing finding number, standard or regulation cited (TJC standard code, CMS Condition of Participation, OSHA standard, NFPA Life Safety Code), finding description, severity level (immediate jeopardy, condition-level, standard-level, observation), responsible department, corrective action plan narrative, corrective action owner, due date, resolution status, and evidence of correction. For CMS surveys: tracks Plan of Correction (PoC) submission date, CMS acceptance date, follow-up survey date, and PoC completion verification. Supports TJC Environment of Care chapter compliance, CMS certification lifecycle, state licensure survey management, and systematic deficiency remediation tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_parent_care_site_id` FOREIGN KEY (`parent_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
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
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_previous_finding_inspection_finding_id` FOREIGN KEY (`previous_finding_inspection_finding_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_parent_site_hierarchy_id` FOREIGN KEY (`parent_site_hierarchy_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`site_hierarchy`(`site_hierarchy_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ADD CONSTRAINT `fk_facility_facility_contract_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ADD CONSTRAINT `fk_facility_facility_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ADD CONSTRAINT `fk_facility_facility_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ADD CONSTRAINT `fk_facility_facility_inspection_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('dbx_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `parent_care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_value_regex' = 'the_joint_commission|dnv_healthcare|hfap|cihq|aaahc|not_accredited');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|withdrawn|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `critical_access_hospital` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital (CAH) Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `disproportionate_share_hospital` SET TAGS ('dbx_business_glossary_term' = 'Disproportionate Share Hospital (DSH) Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `emergency_services_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'health_system|region|market|campus|site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('dbx_business_glossary_term' = 'Licensure Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('dbx_value_regex' = 'active|provisional|suspended|revoked|expired');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|permanently_closed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'government_federal|government_state|government_local|nonprofit|for_profit|physician_owned');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Care Site Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `sole_community_hospital` SET TAGS ('dbx_business_glossary_term' = 'Sole Community Hospital (SCH) Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `teaching_status` SET TAGS ('dbx_business_glossary_term' = 'Teaching Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_designated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Parcel Geographic Region Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `organization_id` SET TAGS ('dbx_relationship' = 'incoming');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Property Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('dbx_business_glossary_term' = 'Electrical Service Capacity in Kilovolt-Amperes (kVA)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Emergency Generator Capacity in Kilowatts (kW)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Generator Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('dbx_value_regex' = 'full_building|life_safety_only|critical_systems|partial');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Facility License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Classification');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv|type_v');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `gross_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `gross_square_footage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `helipad_available` SET TAGS ('dbx_business_glossary_term' = 'Helipad Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_value_regex' = 'central_chilled_water|variable_air_volume|constant_air_volume|heat_pump|split_system|packaged_unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|not_applicable|pending');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_major_renovation_year` SET TAGS ('dbx_business_glossary_term' = 'Last Major Renovation Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|not_certified');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas System Installed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `net_usable_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Net Usable Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `net_usable_square_footage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_elevators` SET TAGS ('dbx_business_glossary_term' = 'Number of Elevators');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|under_renovation|decommissioned|planned');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|ground_lease|joint_venture|managed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `parking_spaces_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `property_tax_parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Parcel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_value_regex' = 'zone_0|zone_1|zone_2|zone_3|zone_4');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('dbx_business_glossary_term' = 'Sprinkler System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('dbx_value_regex' = 'wet_pipe|dry_pipe|pre_action|deluge|none');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|research|parking|mixed_use|support');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Manager Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_admissions` SET TAGS ('dbx_business_glossary_term' = 'Accepts Admissions Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_transfers` SET TAGS ('dbx_business_glossary_term' = 'Accepts Transfers Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Patient Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'critical|acute|intermediate|general|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'pediatric_only|adult_only|geriatric_only|all_ages');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `air_changes_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Air Changes Per Hour (ACH)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Chest Pain Center Accreditation Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `emergency_power_backup` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Backup Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male_only|female_only|mixed|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_risk|isolation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `is_twenty_four_seven` SET TAGS ('dbx_business_glossary_term' = 'Is Twenty-Four Seven (24/7) Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `isolation_room_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `magnet_recognition` SET TAGS ('dbx_business_glossary_term' = 'Magnet Recognition Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `negative_pressure_room_count` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_call_system_type` SET TAGS ('dbx_business_glossary_term' = 'Nurse Call System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('dbx_business_glossary_term' = 'Nurse to Patient Ratio');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('dbx_value_regex' = '^1:[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours End Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Start Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `specialty_service_line` SET TAGS ('dbx_business_glossary_term' = 'Specialty Service Line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `staffed_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_value_regex' = 'comprehensive|primary|acute_ready|not_designated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `teaching_unit_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Unit Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `telemetry_monitoring_capability` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Monitoring Capability Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|procedural|diagnostic|administrative|support');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `wing_or_section` SET TAGS ('dbx_business_glossary_term' = 'Wing or Section');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bariatric_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `class` SET TAGS ('dbx_business_glossary_term' = 'Room Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `class` SET TAGS ('dbx_value_regex' = 'private|semi_private|ward|suite|isolation|observation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `emergency_power_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hand_hygiene_station_count` SET TAGS ('dbx_business_glossary_term' = 'Hand Hygiene Station Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hvac_air_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Air Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `imaging_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Imaging Integration Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `isolation_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_deep_clean_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deep Clean Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Ownership Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_value_regex' = 'owned|leased|shared|contracted');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Medical Air Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Space Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('dbx_business_glossary_term' = 'Room Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `negative_pressure_flag` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nitrous_oxide_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Nitrous Oxide (N2O) Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nurse_call_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Nurse Call System Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Airflow Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('dbx_value_regex' = 'iso_5|iso_6|iso_7|iso_8|standard');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `oxygen_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Oxygen (O2) Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('dbx_business_glossary_term' = 'Room Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('dbx_value_regex' = 'available|occupied|cleaning|out_of_service|maintenance|reserved');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `telemetry_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Room Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `vacuum_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ventilator_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Ventilator Outlet Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'adult|pediatric|neonatal|any');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Bed Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('dbx_business_glossary_term' = 'Bed Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('dbx_value_regex' = 'medical|surgical|pediatric|maternity|psychiatric|rehabilitation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `discharge_ready_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Ready Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `expected_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Available Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|any');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_air_fluidized` SET TAGS ('dbx_business_glossary_term' = 'Air Fluidized Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_bariatric_capable` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_isolation_capable` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_low_bed` SET TAGS ('dbx_business_glossary_term' = 'Low Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_negative_pressure_room` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Room Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_private_room` SET TAGS ('dbx_business_glossary_term' = 'Private Room Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_staffed` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_telemetry_capable` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Bed Label');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `out_of_service_reason` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Bed Position');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('dbx_business_glossary_term' = 'Bed Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('dbx_value_regex' = 'available|occupied|dirty|blocked|out_of_service|housekeeping');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `status_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Status Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Pounds)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Status Event ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Work Order ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `actual_availability_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Availability Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'critical|acute|intermediate|observation|general');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('dbx_business_glossary_term' = 'ADT (Admit-Discharge-Transfer) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('dbx_value_regex' = 'admit|discharge|transfer|cancel|update');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('dbx_value_regex' = 'construction|equipment_failure|staffing_shortage|infection_control|administrative|other');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `expected_availability_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Availability Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('dbx_business_glossary_term' = 'Initiating User Role');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_elective_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Elective Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_emergency_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `new_status_code` SET TAGS ('dbx_business_glossary_term' = 'New Status Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `prior_status_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Suite Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending_survey');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `anesthesia_machine_model` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Machine Model');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Surgical Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_value_regex' = 'none|single_ceiling_boom|dual_ceiling_boom|articulating_arm|wall_mounted');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_power_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Backup Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Use Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `equipment_inventory_list` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inventory List');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_value_regex' = 'sprinkler|clean_agent|water_mist|none');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `hvac_air_exchange_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Air Exchange Rate Per Hour');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Imaging Integration Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('dbx_value_regex' = 'none|c_arm|intraoperative_mri|intraoperative_ct|fluoroscopy|hybrid_angio');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `isolation_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('dbx_business_glossary_term' = 'Laminar Airflow Cleanroom Classification (ISO)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('dbx_value_regex' = 'iso_5|iso_6|iso_7|iso_8|standard');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_accreditation_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accreditation Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas Outlets Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_accreditation_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Survey Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|renovation|decommissioned');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('dbx_value_regex' = '^OR[0-9]{1,4}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('dbx_value_regex' = 'general|cardiac|orthopedic|neurosurgery|hybrid|endoscopy');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `pediatric_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `positive_pressure_maintained_flag` SET TAGS ('dbx_business_glossary_term' = 'Positive Pressure Maintained Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `robotic_surgery_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Robotic Surgery Compatible Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Height in Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Length in Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_width_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Width in Feet');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `scheduled_maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Window');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `surgical_table_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Table Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `video_integration_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Integration Capability Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Care Site ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `current_location_floor` SET TAGS ('dbx_business_glossary_term' = 'Current Location Floor');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|donated|recycled|destroyed|returned_to_vendor|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `environmental_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Device Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `infection_control_category` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `infection_control_category` SET TAGS ('dbx_value_regex' = 'critical|semi_critical|non_critical|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `last_pm_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance (PM) Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `mobility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mobility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `mobility_indicator` SET TAGS ('dbx_value_regex' = 'fixed|portable|mobile');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `next_pm_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance (PM) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_repair|retired|condemned|quarantined');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `pm_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `pm_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|upcoming|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency in Days');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `power_requirements` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `recall_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Remediation Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'no_recall|active_recall|recall_remediated|under_investigation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `sap_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Equipment Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `service_contract_vendor` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Vendor');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `actual_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `approval_datetime` SET TAGS ('dbx_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Failure Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|inspection|recall');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|urgent|routine|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `request_datetime` SET TAGS ('dbx_business_glossary_term' = 'Request Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `trade_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `trade_type` SET TAGS ('dbx_value_regex' = 'biomedical|electrical|plumbing|hvac|carpentry|fire_protection');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `vendor_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Service Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `auto_generate_work_order` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Work Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_value_regex' = 'days|weeks|months|years|hours|cycles');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'inspection|calibration|cleaning|lubrication|testing|replacement');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `manufacturer_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `parts_required` SET TAGS ('dbx_business_glossary_term' = 'Parts Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `required_trade` SET TAGS ('dbx_business_glossary_term' = 'Required Trade or Skill');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `safety_precautions` SET TAGS ('dbx_business_glossary_term' = 'Safety Precautions');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `previous_finding_inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `accreditation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `affected_location` SET TAGS ('dbx_business_glossary_term' = 'Affected Location');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `affected_patient_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Patient Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Citation Reference');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `corrective_action_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `corrective_action_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `medicare_certification_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Certification Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `medicare_certification_impact_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|resolved|closed|overdue');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `root_cause_analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `root_cause_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'immediate_jeopardy|condition_level|standard_level|observation|recommendation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `standard_description` SET TAGS ('dbx_business_glossary_term' = 'Standard Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'License Accreditation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `attestation_by` SET TAGS ('dbx_business_glossary_term' = 'Attestation By');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `bed_capacity_authorized` SET TAGS ('dbx_business_glossary_term' = 'Bed Capacity Authorized');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `bed_capacity_authorized` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `deemed_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Deemed Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `deeming_organization` SET TAGS ('dbx_business_glossary_term' = 'Deeming Organization');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `next_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `payer_contract_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Requirement Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_due_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `scope_of_credential` SET TAGS ('dbx_business_glossary_term' = 'Scope of Credential');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('dbx_value_regex' = 'active|pending_renewal|expired|suspended|revoked|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `survey_outcome` SET TAGS ('dbx_business_glossary_term' = 'Survey Outcome');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocated_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Allocated Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocated_square_footage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_purpose` SET TAGS ('dbx_business_glossary_term' = 'Allocation Purpose');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `annual_space_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Space Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `cost_per_square_foot` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Square Foot');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `effective_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease or Ownership Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_value_regex' = 'owned|leased|subleased|shared');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `monthly_space_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Space Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `primary_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `shared_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Space Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `space_subtype` SET TAGS ('dbx_business_glossary_term' = 'Space Subtype');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `space_type` SET TAGS ('dbx_business_glossary_term' = 'Space Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `space_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|support|storage|common|mechanical');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `wing_section` SET TAGS ('dbx_business_glossary_term' = 'Wing or Section');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `environmental_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Service Request ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector User ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `primary_environmental_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `primary_environmental_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `primary_environmental_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `bed_board_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Bed Board Integration Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `bed_status_updated_flag` SET TAGS ('dbx_business_glossary_term' = 'Bed Status Updated Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cleaning_protocol_used` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Protocol Used');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `cleaning_protocol_used` SET TAGS ('dbx_value_regex' = 'contact precaution|c diff protocol|covid protocol|standard|enhanced|mrsa protocol');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `discharge_to_clean_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Discharge to Clean Cycle Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `disinfectant_product_used` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Product Used');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `infection_prevention_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Infection Prevention Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `isolation_precaution_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Precaution Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `patient_discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Patient Discharge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'stat|urgent|routine|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `quality_inspection_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not inspected');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Services (EVS) Request Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in progress|completed|cancelled|on hold');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_to_start_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Request to Start Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Services (EVS) Request Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'terminal clean|discharge clean|isolation clean|routine clean|spill response|biohazard cleanup');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `work_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Work Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Snapshot Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `alternate_care_site_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Alternate Care Site Activation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `alternate_care_site_activation_status` SET TAGS ('dbx_value_regex' = 'activated|standby|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ambulance_diversion_status` SET TAGS ('dbx_business_glossary_term' = 'Ambulance Diversion Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ambulance_diversion_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `available_beds` SET TAGS ('dbx_business_glossary_term' = 'Available Beds');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `bariatric_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `beds_in_cleaning` SET TAGS ('dbx_business_glossary_term' = 'Beds in Cleaning');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `beds_out_of_service` SET TAGS ('dbx_business_glossary_term' = 'Beds Out of Service');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `disaster_census` SET TAGS ('dbx_business_glossary_term' = 'Disaster Census');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ed_boarding_count` SET TAGS ('dbx_business_glossary_term' = 'Emergency Department (ED) Boarding Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ed_bypass_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Department (ED) Bypass Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ed_bypass_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ed_census` SET TAGS ('dbx_business_glossary_term' = 'Emergency Department (ED) Census');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `eoc_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Operations Center (EOC) Activation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `eoc_activation_status` SET TAGS ('dbx_value_regex' = 'activated|standby|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `icu_bypass_status` SET TAGS ('dbx_business_glossary_term' = 'Intensive Care Unit (ICU) Bypass Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `icu_bypass_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `icu_census` SET TAGS ('dbx_business_glossary_term' = 'Intensive Care Unit (ICU) Census');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `isolation_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Isolation Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `nicu_census` SET TAGS ('dbx_business_glossary_term' = 'Neonatal Intensive Care Unit (NICU) Census');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `observation_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Observation Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `occupied_beds` SET TAGS ('dbx_business_glossary_term' = 'Occupied Beds');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `or_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `or_utilization_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `pediatric_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `snapshot_source_system` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Source System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'scheduled|on_demand|emergency|automated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `surge_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Surge Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `telemetry_beds_available` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Beds Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `total_licensed_beds` SET TAGS ('dbx_business_glossary_term' = 'Total Licensed Beds');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `total_staffed_beds` SET TAGS ('dbx_business_glossary_term' = 'Total Staffed Beds');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `ventilator_availability_count` SET TAGS ('dbx_business_glossary_term' = 'Ventilator Availability Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `hazardous_material_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `activity_level` SET TAGS ('dbx_business_glossary_term' = 'Activity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_business_glossary_term' = 'Biohazard Safety Level (BSL)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_value_regex' = 'BSL-1|BSL-2|BSL-3|BSL-4|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `current_quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Current Quantity On Hand');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `epa_reportable_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reportable Quantity Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `infectious_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Infectious Agent Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `infectious_agent_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `manufacturer_product_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Product Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `maximum_allowable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Quantity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `nfpa_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Rating');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `nfpa_rating` SET TAGS ('dbx_value_regex' = '^[0-4]-[0-4]-[0-4](-[A-Z]{0,3})?$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `personal_protective_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `radioactive_isotope` SET TAGS ('dbx_business_glossary_term' = 'Radioactive Isotope');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `radioactive_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Radioactive Material Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `regulatory_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Contact');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `sara_title_iii_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) Title III Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `hazardous_material_status` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `hazardous_material_status` SET TAGS ('dbx_value_regex' = 'active|expired|disposed|quarantined|recalled');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `storage_cabinet_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Cabinet Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `storage_cabinet_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `storage_location_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `storage_location_description` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `ventilation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Requirement');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `ventilation_requirement` SET TAGS ('dbx_value_regex' = 'fume_hood|biosafety_cabinet|local_exhaust|general_ventilation|none');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `waste_stream_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `cms_immediate_jeopardy_flag` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Immediate Jeopardy Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `current_quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Current Quantity On Hand');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `immediate_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Actions Taken');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|closed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'fire_smoke_event|utility_failure|water_intrusion|security_threat|hazmat_spill|workplace_injury');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `injuries_sustained_flag` SET TAGS ('dbx_business_glossary_term' = 'Injuries Sustained Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|severe|fatal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `maximum_allowable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Quantity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `osha_300_log_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 300 Log Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `osha_301_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 301 Report Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `property_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `property_damage_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|cubic_feet|units');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'incident|hazmat_inventory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `regulatory_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `state_doh_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'State Department of Health (DOH) Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `state_doh_notification_required_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `site_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Site Hierarchy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `parent_site_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Site Hierarchy Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `aco_identifier` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Active Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|merged|divested');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `ccn` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `ccn` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `chest_pain_center_accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'Chest Pain Center Accreditation Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `cms_star_rating` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Star Rating');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `critical_access_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital (CAH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `disproportionate_share_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Disproportionate Share Hospital (DSH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Effective From Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Effective To Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `epic_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Epic Electronic Health Record (EHR) Organization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hie_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|accredited_with_commendation|provisional|conditional|not_accredited|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `leapfrog_grade` SET TAGS ('dbx_business_glossary_term' = 'Leapfrog Hospital Safety Grade');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `leapfrog_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|not_rated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `magnet_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Magnet Recognition Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `market_designation` SET TAGS ('dbx_business_glossary_term' = 'Market Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `node_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `node_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Path');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'for_profit|non_profit|government|academic|faith_based|joint_venture');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `sap_organizational_unit` SET TAGS ('dbx_business_glossary_term' = 'SAP Organizational Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `sole_community_hospital_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Community Hospital (SCH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_value_regex' = 'comprehensive|thrombectomy_capable|primary|acute_ready|not_designated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `teaching_status` SET TAGS ('dbx_business_glossary_term' = 'Teaching Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `teaching_status` SET TAGS ('dbx_value_regex' = 'non_teaching|minor_teaching|major_teaching|academic_medical_center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Center Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_designated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('dbx_subdomain' = 'service_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('dbx_association_edges' = 'facility.care_site,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Network Contract - Network Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Contract - Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Network Contract - Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `claims_submission_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Endpoint');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired|negotiating');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `credentialing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `provider_count_at_facility` SET TAGS ('dbx_business_glossary_term' = 'Contracted Provider Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Methodology');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('dbx_subdomain' = 'service_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('dbx_association_edges' = 'facility.care_site,quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `facility_program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'facility_program_participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Quality Program Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Exemption Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_participation_code` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `total_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Total Performance Score');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('dbx_association_edges' = 'facility.or_suite,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Block Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Block Assignment - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Block Assignment - Or Suite Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_time_end` SET TAGS ('dbx_business_glossary_term' = 'Block End Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_time_start` SET TAGS ('dbx_business_glossary_term' = 'Block Start Time');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Block Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Block Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Block Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `release_deadline_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Release Deadline');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Block Utilization Threshold');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('dbx_association_edges' = 'facility.equipment_asset,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization - Equipment Asset Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_competency_verifier_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Verifier Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_competency_verifier_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_competency_verifier_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `competency_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `primary_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary User Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `accreditation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `critical_access_hospital_indicator` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `emergency_services_indicator` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `health_system_name` SET TAGS ('dbx_business_glossary_term' = 'Health System Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `health_system_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `health_system_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `operational_start_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `staffed_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `teaching_hospital_indicator` SET TAGS ('dbx_business_glossary_term' = 'Teaching Hospital Indicator');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `total_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Total Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` SET TAGS ('dbx_subdomain' = 'service_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `facility_service_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Owner Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `accreditation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `bariatric_surgery_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Surgery Accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `cancer_program_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Cancer Program Accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Chest Pain Center Accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `clinical_specialty` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `cms_service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `emergency_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `nicu_level` SET TAGS ('dbx_business_glossary_term' = 'Neonatal Intensive Care Unit (NICU) Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `nicu_level` SET TAGS ('dbx_value_regex' = 'level_i|level_ii|level_iii|level_iv|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `payer_contracted_flag` SET TAGS ('dbx_business_glossary_term' = 'Payer Contracted Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_value_regex' = 'comprehensive|primary|acute_ready|thrombectomy_capable|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_i|level_ii|level_iii|level_iv|level_v|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Service Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_service` ALTER COLUMN `volume_annual` SET TAGS ('dbx_business_glossary_term' = 'Service Volume Annual');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` SET TAGS ('dbx_subdomain' = 'service_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `facility_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved By');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|terminated|draft|suspended');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `insurance_certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `insurance_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `performance_metric_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `termination_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `accreditation_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_value_regex' = 'accredited|accredited_with_follow_up|preliminary_denial|denied|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `certification_decision` SET TAGS ('dbx_business_glossary_term' = 'Certification Decision');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `certification_decision` SET TAGS ('dbx_value_regex' = 'certified|conditional_certification|certification_denied|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `complaint_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint-Based Inspection Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `condition_level_count` SET TAGS ('dbx_business_glossary_term' = 'Condition-Level Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Coordinator Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `deemed_status_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Deemed Status Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `environment_of_care_chapter` SET TAGS ('dbx_business_glossary_term' = 'Environment of Care (EC) Chapter');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `follow_up_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `follow_up_survey_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Survey Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `immediate_jeopardy_count` SET TAGS ('dbx_business_glossary_term' = 'Immediate Jeopardy (IJ) Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_value_regex' = 'facility_wide|department_specific|system_specific|unit_specific|service_line_specific');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspector_credentials` SET TAGS ('dbx_business_glossary_term' = 'Inspector Credentials');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `life_safety_code_edition` SET TAGS ('dbx_business_glossary_term' = 'Life Safety Code Edition');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `overall_disposition` SET TAGS ('dbx_business_glossary_term' = 'Overall Disposition');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `poc_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (PoC) Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `poc_completion_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (PoC) Completion Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `poc_due_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (PoC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `poc_status` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (PoC) Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `poc_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (PoC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `standard_level_count` SET TAGS ('dbx_business_glossary_term' = 'Standard-Level Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `tjc_survey_type` SET TAGS ('dbx_business_glossary_term' = 'TJC (The Joint Commission) Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `tjc_survey_type` SET TAGS ('dbx_value_regex' = 'triennial|mid_cycle|for_cause|follow_up|unannounced|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
