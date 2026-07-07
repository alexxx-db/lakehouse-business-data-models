-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`supply` COMMENT 'Systems of record: ICON procurement (UNICEF), SAP Materials Management, UNICEF Supply Division systems, WFP LESS (logistics), Humanitarian OpenStreetMap. Covers commodities, warehousing, procurement, and distribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`commodity` (
    `commodity_id` BIGINT COMMENT 'Unique identifier for the humanitarian commodity or relief item in the supply chain master catalog.',
    `supply_category_id` BIGINT COMMENT 'FK to the supply commodity category lookup classifying this commodity.',
    `commodity_category` STRING COMMENT 'Primary classification of the commodity by humanitarian sector or program area (e.g., shelter, health, nutrition, WASH, food, education, protection, NFI general, emergency relief). [ENUM-REF-CANDIDATE: shelter|health|nutrition|wash|food|education|protection|nfi_general|emergency_relief|other — 10 candidates stripped; promote to reference product]',
    `commodity_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the commodity item across procurement, warehousing, and distribution systems. Often aligned with UNSPSC or internal cataloging standards.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the commodity requires continuous temperature-controlled storage and transport (cold chain) from procurement through distribution, typical for vaccines and certain medical supplies.',
    `commodity_status` STRING COMMENT 'Current lifecycle status of the commodity in the master catalog (e.g., active for procurement and distribution, inactive, discontinued, pending approval, restricted use).. Valid values are `active|inactive|discontinued|pending_approval|restricted`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the commodity is manufactured or produced, relevant for customs, import regulations, and donor reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the commodity record was first created in the master catalog system, following organizational timestamp format.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the commodity including specifications, intended use, and any special characteristics relevant to field operations and beneficiary distribution.',
    `diluent_required_flag` BOOLEAN COMMENT 'Whether a diluent is required for reconstitution.',
    `donor_restricted_flag` BOOLEAN COMMENT 'Indicates whether the commodity is subject to donor-imposed restrictions on use, distribution geography, or beneficiary eligibility, requiring compliance tracking in distribution planning.',
    `donor_restriction_notes` STRING COMMENT 'Free-text description of specific donor restrictions or conditions attached to the commodity, including geographic limitations, beneficiary eligibility criteria, or usage constraints.',
    `doses_per_vial` STRING COMMENT 'Number of doses per vial for vaccines.',
    `effective_end_date` DATE COMMENT 'Date after which the commodity record is no longer active for procurement and distribution, supporting lifecycle management and historical tracking. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which the commodity record becomes active and available for procurement and distribution operations, supporting temporal validity tracking.',
    `epi_schedule_inclusion_flag` BOOLEAN COMMENT 'Whether this vaccine is part of the national Expanded Programme on Immunization schedule.',
    `gavi_cofinanced_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the gavi cofinanced condition applies.',
    `gavi_eligible_flag` BOOLEAN COMMENT 'Whether this commodity is eligible for Gavi co-financing',
    `harmonized_tariff_code` STRING COMMENT 'International Harmonized System (HS) tariff classification code for the commodity, used for customs clearance, import/export documentation, and duty calculation.',
    `hazard_classification` STRING COMMENT 'Specific hazard classification code or category (e.g., flammable, corrosive, toxic, biohazard) if the commodity is flagged as hazardous material, following UN or GHS standards.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the commodity is classified as hazardous material requiring special handling, storage, and transport procedures per international safety standards.',
    `in_kind_donation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the commodity is eligible to be received as an in-kind donation from corporate or individual donors, subject to organizational acceptance policies and quality standards.',
    `is_vaccine_flag` BOOLEAN COMMENT 'Whether this commodity is a vaccine requiring cold chain management.',
    `kit_assembly_flag` BOOLEAN COMMENT 'Indicates whether the commodity is a pre-assembled kit or bundle composed of multiple component items (e.g., hygiene kit, shelter kit, medical kit) rather than a single item.',
    `kit_component_count` STRING COMMENT 'Number of distinct component items included in the kit or assembly if the commodity is flagged as a kit, used for bill of materials tracking and inventory management.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently modified the commodity record, supporting audit trail and data governance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the commodity record was most recently updated or modified, following organizational timestamp format.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or producer of the commodity, important for quality assurance, traceability, and compliance with donor or regulatory requirements.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturer-assigned part number or model identifier for the commodity, used for precise specification matching and procurement accuracy.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from suppliers per procurement transaction, driven by vendor requirements or economic order quantity considerations.',
    `commodity_name` STRING COMMENT 'Full descriptive name of the humanitarian commodity or relief item as it appears in procurement documents and distribution manifests.',
    `procurement_lead_time_days` STRING COMMENT 'Average number of days required from purchase order issuance to commodity receipt at warehouse, used for supply chain planning and emergency response preparedness.',
    `quality_certification` STRING COMMENT 'Quality certifications or standards compliance held by the commodity (e.g., ISO, WHO prequalification, FDA approval, CE marking), ensuring safety and efficacy for humanitarian use.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers automatic reorder or procurement action to maintain adequate stock for field operations and emergency response.',
    `shelf_life_days` STRING COMMENT 'Number of days the commodity remains usable and safe from the date of manufacture or receipt, critical for inventory rotation and distribution planning.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling, storage, or transport requirements not captured in structured fields, including fragility, orientation, stacking limits, or security considerations.',
    `sphere_compliant_flag` BOOLEAN COMMENT 'Indicates whether the commodity meets Sphere Humanitarian Charter and Minimum Standards for quality, safety, and appropriateness in humanitarian response.',
    `standard_unit_cost` DECIMAL(18,2) COMMENT 'Standard or average cost per unit of measure for the commodity, used for budgeting, procurement planning, and financial reporting. Currency is organizational default unless otherwise specified.',
    `storage_humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity percentage allowed in storage environment to prevent commodity degradation, mold, or spoilage.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain commodity integrity and safety, particularly critical for medical supplies and cold-chain items.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain commodity integrity and safety, particularly critical for medical supplies and cold-chain items.',
    `subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the primary commodity category (e.g., within WASH: hygiene kits, water purification tablets, sanitation supplies).',
    `ultra_cold_chain_required_flag` BOOLEAN COMMENT 'Whether ultra-cold chain storage (-60 to -80C) is required.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure used for inventory tracking, procurement, and distribution of the commodity (e.g., each, box, carton, pallet, kg, liter, meter, set, kit, dose). [ENUM-REF-CANDIDATE: each|box|carton|pallet|kg|liter|meter|set|kit|dose|vial|bottle|bag|roll — 14 candidates stripped; promote to reference product]',
    `vaccine_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vaccine condition applies.',
    `vaccine_type` STRING COMMENT 'Type of vaccine (e.g., Pentavalent, PCV13, Rotavirus, MR, BCG, OPV, IPV, HPV, Yellow Fever).',
    `volume_per_unit_cubic_meters` DECIMAL(18,2) COMMENT 'Volume in cubic meters occupied by a single unit of the commodity, used for warehouse space planning, transport capacity optimization, and last-mile logistics.',
    `vvm_type` STRING COMMENT 'Classification type categorizing the vvm for this record.',
    `weight_per_unit_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms of a single unit of the commodity, used for logistics planning, freight cost calculation, and warehouse capacity management.',
    `who_pq_reference` STRING COMMENT 'WHO Prequalification reference number for this commodity',
    `who_pq_reference_number` STRING COMMENT 'WHO Prequalification reference number.',
    `who_pq_status` STRING COMMENT 'Current status indicator for the who pq workflow state.',
    CONSTRAINT pk_commodity PRIMARY KEY(`commodity_id`)
) COMMENT 'Supply item or commodity managed in humanitarian logistics. Source systems: ICON procurement (UNICEF Supply Division), SAP MM, WFP LESS. Systems-of-record: SAP MM, ICON, Supply Division catalogue. Framework: IPSAS 12 / WHO Essential Medicines List / UNICEF Supply Catalogue.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Unique identifier for the warehouse facility in the humanitarian supply network.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office that manages this warehouse facility.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Warehouses require designated managers for accountability, security clearance, inventory oversight, and operational decision-making. Nonprofit supply chain audits and donor compliance reports require ',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization operating this warehouse, if applicable.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Warehouses in foreign jurisdictions require local operating permits, customs bonds, and facility registrations. Real business process: country office compliance tracking for operational authority.',
    `access_restrictions` STRING COMMENT 'Description of any access restrictions or special requirements for entering the warehouse facility.',
    `address_line1` STRING COMMENT 'Primary street address line of the warehouse facility.',
    `address_line2` STRING COMMENT 'Secondary address line for additional location details such as building or unit number.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (state, province, region) where the warehouse is located.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (district, county) where the warehouse is located.',
    `city` STRING COMMENT 'City or municipality where the warehouse is located.',
    `cluster_affiliation` STRING COMMENT 'Primary OCHA humanitarian cluster that this warehouse supports in emergency response operations. [ENUM-REF-CANDIDATE: logistics|health|wash|shelter|nutrition|protection|education|food_security|multi_cluster — 9 candidates stripped; promote to reference product]',
    `warehouse_code` STRING COMMENT 'Externally-known unique alphanumeric code for the warehouse facility used in logistics documentation and tracking systems.. Valid values are `^[A-Z0-9]{3,12}$`',
    `cold_chain_capacity_liters` DECIMAL(18,2) COMMENT 'Total cold chain storage capacity in liters at +2 to +8 C',
    `cold_chain_equipment_count` STRING COMMENT 'Number of cold chain equipment units at this warehouse.',
    `cold_chain_functional_percentage` DECIMAL(18,2) COMMENT 'Percentage of cold chain equipment that is functional.',
    `commissioning_date` DATE COMMENT 'Date when the warehouse facility was officially commissioned and became operational.',
    `contact_email` STRING COMMENT 'Primary email address for warehouse operations communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the warehouse contact person or operations team.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the warehouse is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse record was first created in the system.',
    `customs_bonded` BOOLEAN COMMENT 'Indicates whether the warehouse operates as a customs bonded facility allowing duty-free storage of international goods.',
    `decommissioning_date` DATE COMMENT 'Date when the warehouse facility was decommissioned and ceased operations, if applicable.',
    `emergency_access_24_7` BOOLEAN COMMENT 'Indicates whether the warehouse can be accessed 24 hours a day, 7 days a week for emergency response operations.',
    `evm_assessment_date` DATE COMMENT 'Date of last Effective Vaccine Management assessment.',
    `evm_score` DECIMAL(18,2) COMMENT 'Effective Vaccine Management assessment score.',
    `facility_type` STRING COMMENT 'Classification of the warehouse based on its role in the humanitarian supply network.. Valid values are `central_warehouse|field_warehouse|transit_hub|pre_positioning_depot|cold_chain_facility|mobile_storage_unit`',
    `forklift_capacity_kg` STRING COMMENT 'Maximum lifting capacity of forklifts available at the warehouse, measured in kilograms.',
    `freezer_capacity_liters` DECIMAL(18,2) COMMENT 'Total freezer storage capacity in liters (-20C).',
    `gis_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GIS coordinates measured in meters, indicating the precision of the location data.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the warehouse is certified to store hazardous materials according to international standards.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety, security, or compliance inspection of the warehouse facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse facility in decimal degrees for GIS mapping and logistics planning.',
    `loading_docks_count` STRING COMMENT 'Number of loading docks available at the warehouse for receiving and dispatching cargo.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse facility in decimal degrees for GIS mapping and logistics planning.',
    `managing_entity` STRING COMMENT 'Type of entity responsible for the day-to-day management and operation of the warehouse facility.. Valid values are `direct_operation|partner_managed|government_shared|consortium|third_party_logistics`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse record was last modified in the system.',
    `warehouse_name` STRING COMMENT 'Official name of the warehouse facility as recognized by the organization and partners.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations regarding the warehouse facility and its operations.',
    `operational_hours` STRING COMMENT 'Standard operating hours of the warehouse facility including days and times of operation.',
    `operational_status` STRING COMMENT 'Current operational state of the warehouse facility in its lifecycle.. Valid values are `operational|under_construction|temporarily_closed|decommissioned|standby|emergency_activated`',
    `ownership_type` STRING COMMENT 'Legal ownership or usage arrangement for the warehouse facility.. Valid values are `owned|leased|donated|government_provided|temporary_use`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse location.',
    `remote_temperature_monitoring_flag` BOOLEAN COMMENT 'Whether the warehouse has remote/IoT temperature monitoring.',
    `security_level` STRING COMMENT 'Security classification level of the warehouse based on threat assessment and protection measures in place.. Valid values are `minimal|low|medium|high|maximum`',
    `storage_capacity_m3` DECIMAL(18,2) COMMENT 'Total storage capacity of the warehouse measured in cubic meters (m³).',
    `storage_capacity_pallets` STRING COMMENT 'Total storage capacity of the warehouse measured in standard pallet positions.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the warehouse has temperature control capability for cold-chain commodities.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature that can be maintained in the warehouse for cold-chain storage, measured in degrees Celsius.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature that can be maintained in the warehouse for cold-chain storage, measured in degrees Celsius.',
    `ultra_cold_capacity_liters` DECIMAL(18,2) COMMENT 'Ultra-cold storage capacity in liters (-60 to -80C).',
    `vaccine_storage_certified_flag` BOOLEAN COMMENT 'Whether warehouse is certified for vaccine storage',
    `vaccine_storage_tier` STRING COMMENT 'Tier in vaccine supply chain (National, Regional, District, Service Delivery Point).',
    `wms_system_name` STRING COMMENT 'Name of the warehouse management system software used to track inventory and operations at this facility.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Physical warehouse or storage facility for humanitarian supplies. Source systems: SAP WM, WFP LESS, UNICEF Supply Division systems.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key for the vendor entity.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Many vendors are partner organizations (local NGOs, CBOs). Critical for due diligence integration—vendor screening must reference partnership capacity assessments, risk registers, and accreditation re',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: OFAC/UN sanctions screening is mandatory pre-award requirement for all vendors in nonprofit sector. Real business process: vendor vetting before contract execution to ensure donor compliance.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Vendors access e-procurement portals for RFQ responses, bid submissions, and PO acknowledgments. Tracking the platform enables audit trails for vendor interactions, access provisioning, and compliance',
    `address_line_1` STRING COMMENT 'First line of the vendors primary business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the vendors primary business address, typically containing building, suite, or unit information.',
    `bank_account_number` STRING COMMENT 'The vendors primary bank account number for payment processing and fund transfers.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendors primary bank account is held.',
    `bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the vendors bank, used for international wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `blacklist_effective_date` DATE COMMENT 'The date when the vendor blacklist or debarment status became effective.',
    `blacklist_expiry_date` DATE COMMENT 'The date when the vendor blacklist or debarment status expires, after which the vendor may be eligible for reinstatement (nullable for permanent debarments).',
    `blacklist_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether the vendor is currently blacklisted or debarred from humanitarian procurement due to fraud, corruption, poor performance, or ethical violations.',
    `blacklist_reason` STRING COMMENT 'Detailed explanation of why the vendor was blacklisted or debarred, including the nature of the violation and the decision authority.',
    `city` STRING COMMENT 'City or municipality where the vendors primary business address is located.',
    `vendor_code` STRING COMMENT 'Internal unique alphanumeric code assigned to the vendor for procurement and supply chain operations.',
    `cold_chain_certified_flag` BOOLEAN COMMENT 'Whether this vendor is certified for cold chain logistics.',
    `commodity_categories` STRING COMMENT 'Comma-separated list of commodity categories that the vendor supplies, such as NFI (Non-Food Items), medical supplies, WASH (Water Sanitation and Hygiene) equipment, shelter materials, food commodities, or logistics services.',
    `country_of_operation` STRING COMMENT 'Primary country where the vendor operates or is registered, using ISO 3166-1 alpha-3 country code (e.g., USA, GBR, KEN).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Preferred currency for transactions with the vendor, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fleet_size` STRING COMMENT 'Number of vehicles or transport units in the vendors fleet (applicable for transport and logistics providers). Indicates capacity for humanitarian logistics operations.',
    `gmp_certification_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether the vendor holds Good Manufacturing Practice (GMP) certification, required for pharmaceutical and medical supply vendors.',
    `humanitarian_network_membership` STRING COMMENT 'Comma-separated list of humanitarian logistics networks or consortia the vendor is a member of, such as WFP Logistics Hub Framework (LHF), UNHRD (UN Humanitarian Response Depot), or Logistics Cluster.',
    `iso_certification` STRING COMMENT 'Comma-separated list of ISO certifications held by the vendor, such as ISO 9001 (Quality Management), ISO 14001 (Environmental Management), or ISO 45001 (Occupational Health and Safety).',
    `last_performance_review_date` DATE COMMENT 'The date when the vendors performance was last formally reviewed and assessed by the procurement or supply chain team.',
    `last_performance_score` DECIMAL(18,2) COMMENT 'The most recent performance score assigned to the vendor during the last performance review, typically on a scale of 0-100 or 0-5, measuring quality, delivery, compliance, and responsiveness.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was last modified or updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor, supplier, or service provider as registered with governing authorities.',
    `payment_terms_days` DECIMAL(18,2) COMMENT 'Standard payment terms offered by the vendor, expressed as the number of days from invoice date to payment due date (e.g., 30, 60, 90 days).',
    `performance_tier` STRING COMMENT 'Classification tier based on the vendors historical performance, quality, delivery reliability, and compliance with humanitarian standards. Tier 1 represents preferred vendors with excellent track records.. Valid values are `tier_1_preferred|tier_2_approved|tier_3_conditional|tier_4_probation`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendors primary business address.',
    `prequalification_date` DATE COMMENT 'The date when the vendor successfully completed the prequalification process and was approved for humanitarian procurement.',
    `prequalification_expiry_date` DATE COMMENT 'The date when the vendors prequalification status expires and requires renewal or reassessment.',
    `prequalification_status` STRING COMMENT 'Indicates whether the vendor has completed and passed the organizations prequalification process for humanitarian procurement, ensuring compliance with quality, ethical, and operational standards.. Valid values are `prequalified|not_prequalified|pending_review|expired`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the vendor contact person used for procurement communications, purchase orders, and supply chain coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization for procurement and supply chain coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact person, including country code, used for urgent procurement and logistics coordination.',
    `registration_date` DATE COMMENT 'The date when the vendor was first registered in the organizations vendor management system.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the vendors primary business address is located.',
    `tax_identification_number` STRING COMMENT 'The vendors tax identification number (TIN), VAT number, or equivalent tax registration identifier issued by the country of operation.',
    `transport_modes_offered` STRING COMMENT 'Comma-separated list of transportation modes offered by the vendor (applicable for logistics and transport providers), such as air freight, sea freight, road transport, rail transport, or last-mile delivery.',
    `un_vendor_number` STRING COMMENT 'The unique vendor registration number assigned by the United Nations Global Marketplace (UNGM) for vendors participating in UN procurement.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the procurement system, indicating whether the vendor is eligible for new contracts and purchase orders.. Valid values are `active|inactive|suspended|blacklisted|pending_approval|debarred`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the primary service or product category they provide in the humanitarian supply chain. [ENUM-REF-CANDIDATE: commodity_supplier|manufacturer|freight_forwarder|clearing_agent|trucking_company|air_cargo_operator|last_mile_delivery_partner|warehouse_operator|service_provider|customs_broker|cold_chain_provider — promote to reference product]',
    `warehouse_capacity_sqm` DECIMAL(18,2) COMMENT 'Total warehouse storage capacity in square meters available from the vendor (applicable for warehouse operators and logistics providers).',
    `who_pq_manufacturer_flag` BOOLEAN COMMENT 'Whether this vendor is a WHO-prequalified vaccine manufacturer.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers, vendors, service providers, and logistics operators engaged in humanitarian procurement and supply chain operations. Covers commodity suppliers, international manufacturers, freight forwarders, clearing agents, trucking companies, air cargo operators, and last-mile delivery partners. Captures vendor registration details, country of operation, commodity categories supplied, transport modes offered (where applicable), pre-qualification status, performance tier, fleet size (for transport providers), blacklist/debarment flags, UN vendor registration number, compliance certifications (e.g., ISO, GMP), and humanitarian logistics network membership (e.g., WFP LHF, UNHRD). SSOT for all supplier and service provider identity within the supply domain.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the donor grant or funding source that finances this purchase order. Critical for donor-restricted fund compliance and Budget versus Actual (BvA) tracking per 2 CFR 200.',
    `bid_id` BIGINT COMMENT 'Foreign key linking to supply.bid. Business justification: In competitive procurement, a purchase order is awarded to the winning bid. purchase_order has rfq_id (linking to the solicitation) but no bid_id (linking to the specific awarded bid). Adding bid_id t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase orders must be charged to cost centers for expense tracking, budget control, and financial reporting. Essential for nonprofit expense allocation and grant compliance.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office, field office, or headquarters unit that issued this purchase order. Used for budget tracking and procurement authority validation.',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Restricted funds require tracking which purchase orders are charged against them for donor compliance reporting, audit trails, and fund balance management. Fund managers must reconcile procurement spe',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.framework_agreement. Business justification: Framework agreements (LTAs, blanket POs) use a call-off mechanism where individual purchase orders are issued against the master agreement. This FK links call-off POs to their parent framework agreeme',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Purchase orders require GL account coding for proper financial classification, accrual accounting, and financial statement preparation. Core requirement for nonprofit financial management.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project that requested this procurement. Links PO to program budget and donor restrictions.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGOs routinely procure from local partner organizations to support localization commitments and capacity building. Links PO to partnership agreements, due diligence records, and performance reviews. E',
    `user_account_id` BIGINT COMMENT 'Reference to the staff member who provided final approval for this purchase order. Used for audit trail and accountability per RACI (Responsible Accountable Consulted Informed) framework.',
    `procurement_request_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_request. Business justification: procurement_request is the internal requisition that initiates procurement. The existing chain is procurement_request → rfq → purchase_order, but for direct procurement (no RFQ/competitive process), t',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to supply.rfq. Business justification: Purchase orders are issued after RFQ evaluation and vendor award. This FK links the PO to the competitive bidding process that preceded it. Standard procurement workflow: procurement_request → rfq → p',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Purchase orders originate from ERP/procurement systems. Tracking source platform is essential for data lineage, audit trails, system migration planning, and reconciling PO data across integrated platf',
    `supply_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.supply_agreement. Business justification: purchase_order already has framework_agreement_id (linking to the LTA/blanket agreement), but supply_agreement captures commodity-specific pricing and lead-time terms with vendors. Adding supply_agree',
    `tertiary_purchase_modified_by_user_user_account_id` BIGINT COMMENT 'Reference to the staff member who last modified this purchase order record. Used for accountability and audit trail.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor organization receiving this purchase order. Links to vendor master data for payment and performance tracking.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or project site where commodities should be delivered. Used for logistics planning and goods receipt verification.',
    `actual_delivery_date` DATE COMMENT 'Date when goods were actually received and verified. Populated upon goods receipt and used for vendor on-time delivery KPI tracking.',
    `approval_workflow_status` STRING COMMENT 'Current status of the purchase order in the multi-level approval workflow. Tracks progression through procurement authority levels per delegation of authority matrix.. Valid values are `not_submitted|pending_review|approved|rejected|revision_requested`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order received final approval. Used for procurement cycle time measurement and compliance audit trail.',
    `commodity_category` STRING COMMENT 'High-level classification of commodities on this purchase order: NFI (Non-Food Items), medical supplies, food, WASH (Water Sanitation and Hygiene), shelter materials, education supplies, protection items, or logistics equipment. Used for sector-specific reporting. [ENUM-REF-CANDIDATE: nfi|medical|food|wash|shelter|education|protection|logistics — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order (e.g., USD, EUR, GBP). Used for multi-currency procurement and exchange rate tracking.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full physical delivery address for commodity shipment. Captured for logistics coordination and proof of delivery. Organizational contact data classified as confidential.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this purchase order should be visible in donor reporting and transparency portals (e.g., IATI - International Aid Transparency Initiative). Used for public accountability and donor stewardship.',
    `emergency_flag` BOOLEAN COMMENT 'Indicates whether this purchase order was issued under emergency procurement procedures due to humanitarian crisis or disaster response. Allows expedited approval and relaxed competitive bidding requirements per CERF (Central Emergency Response Fund) guidelines.',
    `erp_document_reference` STRING COMMENT 'Reference number or document ID from the source ERP system (SAP S/4HANA, Unit4, etc.). Used for system integration, reconciliation, and audit trail back to operational system of record.',
    `expected_delivery_date` DATE COMMENT 'Vendor-committed delivery date as agreed in the purchase order. Used for goods receipt scheduling and vendor performance measurement.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Total freight, shipping, and logistics charges for delivery of commodities. Critical for last-mile logistics cost tracking.',
    `gavi_co_financed_flag` BOOLEAN COMMENT 'Whether this PO is funded through Gavi co-financing.',
    `goods_receipt_status` STRING COMMENT 'Aggregate status of goods receipt across all purchase order line items. Used for three-way matching (PO-GRN-Invoice) and inventory management.. Valid values are `not_received|partially_received|fully_received|over_received|discrepancy`',
    `incoterm` STRING COMMENT 'Delivery terms defining the division of costs and risks between buyer and seller per Incoterms 2020 (e.g., DDP = Delivered Duty Paid, FOB = Free On Board). Critical for humanitarian supply chain cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_matching_status` STRING COMMENT 'Status of three-way matching between purchase order, goods receipt note, and vendor invoice. Critical for accounts payable processing and financial control per 2 CFR 200.. Valid values are `not_matched|matched|variance|blocked`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last updated. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text notes and special instructions for the vendor, logistics team, or procurement staff. May include delivery instructions, quality requirements, or donor-specific compliance notes.',
    `payment_method` DECIMAL(18,2) COMMENT 'Method by which vendor will be paid (bank transfer, wire, check, letter of credit, mobile money, cash). Used for treasury planning and compliance with donor payment restrictions.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Agreed payment terms with vendor (e.g., Net 30, Net 60, 50% advance / 50% on delivery). Governs accounts payable scheduling and cash flow management.',
    `po_date` DATE COMMENT 'Date when the purchase order was officially issued to the vendor. Principal business event timestamp for procurement tracking and lead time calculation.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number issued to vendor. Business identifier used in procurement communications and three-way matching (PO-GRN-Invoice).. Valid values are `^PO-[A-Z0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from draft through approval, issuance, goods receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type: standard (one-time procurement), blanket (recurring deliveries), contract (long-term agreement), emergency (urgent humanitarian response), framework (pre-negotiated terms).. Valid values are `standard|blanket|contract|emergency|framework`',
    `procurement_method` STRING COMMENT 'Method used to select the vendor: competitive bidding, request for quotation (RFQ), sole source justification, framework agreement, or emergency procurement waiver. Required for donor compliance and audit trail per 2 CFR 200.. Valid values are `competitive_bidding|request_for_quotation|sole_source|framework_agreement|emergency_procurement`',
    `requested_delivery_date` DATE COMMENT 'Date by which the requesting program needs the commodities delivered. Used for procurement lead time planning and emergency response timeline tracking.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, duties, and freight charges. Base procurement value for budget tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount (VAT, GST, sales tax) applied to this purchase order. May be zero for tax-exempt humanitarian procurement.',
    `total_amount` DECIMAL(18,2) COMMENT 'Grand total value of the purchase order including subtotal, taxes, freight, and all other charges. Used for budget commitment and three-way matching.',
    `vaccine_procurement_flag` BOOLEAN COMMENT 'Whether this purchase order is for vaccine procurement.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Procurement purchase order for goods or services. Source systems: ICON procurement (UNICEF), SAP MM/Procurement, WFP procurement systems. Systems-of-record: SAP MM (Materials Management), ICON procurement. Framework: IPSAS 12 (Inventories) / IATI v2.03 transaction elements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that is financing this procurement. Used for fund accounting and donor reporting.',
    `beneficiary_needs_assessment_id` BIGINT COMMENT 'Foreign key linking to beneficiary.needs_assessment. Business justification: Goods receipts fulfill commodities identified in needs assessments. Closes the loop from assessment to procurement to delivery. Essential for needs-based accountability, procurement justification audi',
    `commodity_id` BIGINT COMMENT 'Identifier of the commodity or Non-Food Item (NFI) being received. Links to the master commodity catalog.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods receipts trigger expense recognition that must be allocated to cost centers for budget consumption tracking and program expense reporting. Essential for nonprofit financial control.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Goods receipts must be charged to funds for donor reporting and fund accounting. Critical for nonprofit grant compliance and restricted fund tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods receipts require GL account assignment for inventory/expense posting and financial statement preparation. Core requirement for nonprofit inventory and expense accounting.',
    `inkind_donation_id` BIGINT COMMENT 'Reference to the in-kind donation record if goods are received as donated commodities rather than purchased. Null for purchased goods.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project for which these goods are intended. Links supply chain to program delivery.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Goods often received by partner organizations at field locations. Establishes custody accountability, validates against partnership agreement authorized locations, supports audit trails for partner-ma',
    `project_site_id` BIGINT COMMENT 'Reference to the field project site if goods were received directly at a program location rather than a central warehouse.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received. Links this receipt to the originating procurement document.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: goods_receipt already has purchase_order_id (linking to the PO header) but lacks purchase_order_line_id (linking to the specific line item). In procurement, goods are received against specific PO line',
    `shipment_id` BIGINT COMMENT 'Reference to the inbound shipment or logistics movement that delivered these goods.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who physically received and inspected the goods. Responsible for verifying quantity and condition.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who posted or finalized the goods receipt transaction, triggering inventory update and financial posting.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor who delivered the goods. Used for three-way matching and vendor performance tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or field storage location where goods were physically received.',
    `waybill_id` BIGINT COMMENT 'Foreign key linking to supply.waybill. Business justification: Goods receipts are recorded when commodities arrive at a warehouse. The waybill is the shipping document that accompanies the delivery. The goods_receipt table has delivery_note_number (STRING) which ',
    `batch_lot_id` BIGINT COMMENT 'FK to batch/lot record for vaccine and pharmaceutical tracking',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the received commodity, critical for traceability and recall management, especially for medical supplies and food items.',
    `cold_chain_intact_flag` BOOLEAN COMMENT 'Whether the cold chain was maintained during transport.',
    `condition_on_arrival` STRING COMMENT 'Assessment of the physical condition of the goods upon receipt. Good indicates acceptable condition, damaged indicates physical damage, expired indicates past expiry date, partial_damage indicates some units damaged, quality_issue indicates substandard quality.. Valid values are `good|damaged|expired|partial_damage|quality_issue`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this goods receipt record was first created in the database. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_date` DATE COMMENT 'Date on which the goods cleared customs and were released for delivery to the warehouse or field location.',
    `customs_cleared` BOOLEAN COMMENT 'Indicates whether the goods have cleared customs and import formalities. True if cleared, False if pending customs clearance.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether there was a discrepancy between ordered and received quantities or condition. True if discrepancy exists, False if receipt matches order exactly.',
    `discrepancy_notes` STRING COMMENT 'Detailed notes explaining any discrepancies in quantity, quality, or condition between what was ordered and what was received. Includes reasons for rejection or partial acceptance.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt should be included in donor reporting and visibility dashboards. True for donor-funded procurements.',
    `expiry_date` DATE COMMENT 'Manufacturer expiry or best-before date for perishable commodities, medical supplies, and food items. Critical for FEFO (First Expired First Out) inventory management.',
    `freight_charges` DECIMAL(18,2) COMMENT 'Transportation and freight costs associated with this goods receipt, if separately tracked.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether the received goods require formal quality inspection before being released to inventory. True for medical supplies, food items, and high-value commodities.',
    `inspection_status` STRING COMMENT 'Status of the quality inspection process. Pending indicates inspection not yet completed, passed indicates goods approved for use, failed indicates goods rejected, waived indicates inspection was not required.. Valid values are `pending|passed|failed|waived`',
    `lot_number` STRING COMMENT 'Supplier or donor lot number for the received commodity, used for tracking and quality control purposes.',
    `manufacturing_date` DATE COMMENT 'Date on which the commodity was manufactured, used to calculate shelf life and ensure quality standards.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this goods receipt record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'General notes and comments about the goods receipt, including special handling instructions, observations, or contextual information.',
    `quality_check_status` STRING COMMENT 'Current status indicator for the quality check workflow state.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of the commodity that was originally ordered on the purchase order or expected from the donation.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The actual quantity of the commodity physically received and accepted at the warehouse or field location.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of the commodity that was rejected upon receipt due to damage, expiry, or quality issues.',
    `receipt_date` DATE COMMENT 'The date on which the goods were physically received at the warehouse or field location. This is the principal business event date for this transaction.',
    `receipt_document_number` STRING COMMENT 'The externally-known unique document number for this goods receipt, typically generated by the ERP system (e.g., SAP goods receipt document number).. Valid values are `^GR[0-9]{10}$`',
    `receipt_number` STRING COMMENT 'Count or number of receipt items associated with this record.',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Draft indicates pending finalization, posted indicates completed and inventory updated, reversed indicates a correction was applied, cancelled indicates the receipt was voided.. Valid values are `draft|posted|reversed|cancelled`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods receipt was recorded in the system, including time zone information.',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items such as medical equipment, vehicles, or high-value assets.',
    `storage_location_code` STRING COMMENT 'Specific storage location or bin within the warehouse where the received goods were placed. Used for precise inventory tracking.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the goods received, calculated as quantity received multiplied by unit cost. Used for accounts payable and budget tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the received commodity as stated on the purchase order or donation valuation. Used for inventory valuation and financial accounting.',
    `unit_of_measure` STRING COMMENT 'The unit in which the commodity quantity is measured. EA=Each, KG=Kilogram, LT=Liter, MT=Metric Ton, BX=Box, CS=Case, PK=Pack. [ENUM-REF-CANDIDATE: EA|KG|LT|MT|BX|CS|PK — 7 candidates stripped; promote to reference product]',
    `vvm_status_on_arrival` STRING COMMENT 'Vaccine Vial Monitor stage observed on arrival (VVM stage 1-4).',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of commodities at a warehouse or field location against a purchase order or in-kind donation. Records receipt date, receiving warehouse, commodity, quantity received, condition on arrival (good/damaged/expired), batch/lot number, expiry date, receiving officer, discrepancy notes, and SAP goods receipt document number. Triggers inventory update and initiates three-way matching for AP payment processing.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique identifier for the inventory balance record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Reference to the donor grant funding this inventory. Used for fund accounting and donor reporting. Links to grant master data.',
    `batch_lot_id` BIGINT COMMENT 'FK to batch/lot for vaccine inventory tracking by lot',
    `cold_chain_equipment_id` BIGINT COMMENT 'FK to cold chain equipment storing this inventory.',
    `commodity_id` BIGINT COMMENT 'Reference to the commodity or Non-Food Item (NFI) being tracked in inventory. Links to the commodity master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory balances must map to GL accounts for balance sheet reporting and inventory valuation. Essential for nonprofit financial statement preparation and asset accounting.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project for which this inventory is allocated or reserved. Links to program master data.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where the commodity is held. Links to warehouse master data.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the commodity. Used for quality control, recall management, and traceability.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the warehouse location. Used for geographic reporting and OCHA SitRep aggregation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory valuation. Used for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `donor_restriction_flag` BOOLEAN COMMENT 'Indicates whether this inventory is subject to donor-imposed restrictions on use, distribution, or geographic allocation. True if restricted, False if unrestricted.',
    `expiration_date` DATE COMMENT 'Expiration or best-before date for perishable commodities such as medical supplies, food, or nutrition items. Used for FEFO (First Expired First Out) distribution planning.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether this inventory was received as an in-kind donation rather than purchased. True if in-kind donation, False if purchased. Used for donor reporting and GAAP compliance.',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (receipt, issue, transfer, or adjustment) for this balance record. Used for aging analysis and pipeline monitoring.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this commodity at this warehouse. Used for inventory accuracy tracking and audit compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was last modified. Used for audit trail and change tracking.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum stock capacity or target level for this commodity at this warehouse. Used for inventory optimization and storage planning.',
    `notes` STRING COMMENT 'Free-text notes or comments about this inventory balance record. Used for documenting special conditions, quality issues, or operational context.',
    `pipeline_status` STRING COMMENT 'Current status of the inventory balance in the commodity pipeline. Used for OCHA cluster reporting and pipeline gap analysis.. Valid values are `Available|Reserved|In Transit|Quarantined|Expired|Depleted`',
    `quantity_available` DECIMAL(18,2) COMMENT 'Net quantity available for new distribution allocations. Calculated as quantity_on_hand minus quantity_reserved minus quantity_quarantined.',
    `quantity_in_transit` DECIMAL(18,2) COMMENT 'Quantity currently in transit to this warehouse from suppliers or other warehouses. Not yet available for distribution.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical stock quantity available in the warehouse. Represents the total inventory balance at the snapshot date.',
    `quantity_quarantined` DECIMAL(18,2) COMMENT 'Quantity held in quarantine due to quality issues, expiration concerns, or pending inspection. Not available for distribution.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'Quantity allocated or reserved for planned distribution events but not yet dispatched. Reduces available stock for new allocations.',
    `reorder_level` DECIMAL(18,2) COMMENT 'Minimum stock level threshold that triggers a replenishment order. Used for pipeline management and pre-positioning decisions.',
    `snapshot_date` DATE COMMENT 'Date for which this inventory balance snapshot is recorded. Supports historical trend analysis and time-series reporting.',
    `storage_condition` STRING COMMENT 'Required storage condition for the commodity. Used for warehouse capacity planning and quality assurance.. Valid values are `Ambient|Refrigerated|Frozen|Controlled|Hazardous`',
    `total_valuation` DECIMAL(18,2) COMMENT 'Total monetary value of the inventory balance. Calculated as quantity_on_hand multiplied by unit_cost. Used for financial statements and donor reporting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or average cost per unit of the commodity. Used for inventory valuation and financial reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the commodity quantity. Used for consistent reporting and distribution planning. [ENUM-REF-CANDIDATE: EA|KG|LTR|MTR|BOX|CARTON|PALLET|DOSE|VIAL|TABLET|KIT — 11 candidates stripped; promote to reference product]',
    `vvm_current_stage` STRING COMMENT 'Current VVM stage for vaccine inventory (VVM stage 1-4).',
    `vvm_stage` STRING COMMENT 'Current VVM stage of inventory (1-4) for vaccine commodities',
    `warehouse_location` STRING COMMENT 'Geographic location of the warehouse including city, region, or country. Used for logistics planning and SitRep reporting.',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Current and historical stock balance records for each commodity at each warehouse location. Captures commodity, warehouse, stock quantity on hand, quantity reserved for distribution, quantity in transit, quantity quarantined, reorder level, maximum stock level, last physical count date, and stock valuation. Supports commodity pipeline management, pre-positioning decisions, and OCHA cluster reporting on pipeline gaps.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction record. Primary key for the stock movement log.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source that financed the procurement or distribution of this commodity. Critical for donor reporting and fund accounting.',
    `batch_lot_id` BIGINT COMMENT 'FK to batch/lot for vaccine and pharmaceutical traceability',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: Stock movements document items issued for specific case management interventions (GBV dignity kits, child protection supplies, emergency assistance). Audit trail for case-based assistance. Critical fo',
    `cold_chain_equipment_id` BIGINT COMMENT 'FK to cold chain equipment used for this movement.',
    `commodity_id` BIGINT COMMENT 'Identifier of the commodity or Non-Food Item (NFI) being moved. Links to the commodity master catalog.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Inventory discrepancies, unauthorized movements, or missing documentation identified during audits become findings requiring corrective action. Real business process: audit resolution and inventory co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stock movements (issues, adjustments) trigger expense postings to cost centers when inventory is consumed. Essential for nonprofit program expense allocation and budget tracking.',
    `distribution_event_id` BIGINT COMMENT 'Identifier of the beneficiary distribution event associated with this stock issue (applicable for movement_type = issue to beneficiaries). Links commodity pipeline to field delivery operations.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Stock movements must charge funds when inventory is issued for distributions. Critical for nonprofit fund accounting and donor reporting on commodity usage.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Stock movements require GL accounts for proper accounting treatment (expense, COGS, adjustment). Core requirement for nonprofit inventory accounting and financial reporting.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Stock transfers to/from partner warehouses are routine in partnership arrangements. Essential for inventory accountability, validates movements against partnership agreement scope, supports partner re',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created this stock movement record. Part of audit trail for accountability and compliance.',
    `project_site_id` BIGINT COMMENT 'Identifier of the program or project for which this stock movement is being executed. Links commodity pipeline to program delivery for MEL reporting.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Stock movements track inventory transfers between warehouses or within a warehouse. The source_location_id (BIGINT) currently holds the origin warehouse reference. Renaming to source_warehouse_id and ',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who authorized or approved this stock movement transaction. Required for accountability and audit trail, especially for adjustments, losses, and write-offs.',
    `stock_warehouse_id` BIGINT COMMENT 'Identifier of the warehouse, distribution point, or field location to which the commodity is being moved. Null for issue transactions to final beneficiaries or write-offs.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external supplier or vendor from whom goods were received (applicable for movement_type = receipt). Null for internal movements.',
    `authorizing_officer_name` STRING COMMENT 'Full name of the staff member who authorized this stock movement. Denormalized for reporting and audit trail readability.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch/lot number for the commodity. Critical for traceability, recall management, and quality control, especially for medical supplies and food items.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `carrier_name` STRING COMMENT 'Name of the transport carrier or logistics service provider responsible for moving the commodity (applicable for transfers and receipts). Null for internal hand-carry movements.',
    `count_team_reference` STRING COMMENT 'Reference identifier for the physical inventory count team or cycle that generated this movement record (applicable only for movement_type = physical_count). Links to physical inventory count documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost fields. Typically the organizations functional currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `donor_restriction_code` STRING COMMENT 'Classification of donor-imposed restrictions on the use of this commodity. Unrestricted = no limitations; Geographic_restricted = specific country/region only; Program_restricted = specific program use only; Beneficiary_restricted = specific beneficiary population only; Time_restricted = must be distributed within donor-specified timeframe. Critical for compliance with donor agreements.. Valid values are `unrestricted|geographic_restricted|program_restricted|beneficiary_restricted|time_restricted`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the commodity batch being moved. Critical for FEFO (First Expired First Out) inventory management, especially for medical supplies, food items, and time-sensitive NFIs.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether this commodity was received as an in-kind donation (True) or procured through cash purchase (False). Critical for donor reporting and IATI transparency.',
    `inspection_date` DATE COMMENT 'Date on which quality inspection was performed on the commodity. Null if inspection was not required or waived.',
    `inspector_name` STRING COMMENT 'Name of the staff member or third-party inspector who performed the quality inspection. Null if inspection was not required or waived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was last updated. Part of audit trail for data lineage and compliance.',
    `movement_date` DATE COMMENT 'Business date on which the stock movement occurred or is scheduled to occur. This is the operational event date, distinct from system audit timestamps.',
    `movement_number` STRING COMMENT 'Externally-known unique reference number for this stock movement transaction, used for audit trail and cross-system reconciliation. Format typically includes movement type prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `movement_status` STRING COMMENT 'Current lifecycle status of the stock movement transaction. Tracks workflow state from initiation through completion or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `movement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical stock movement was executed or recorded. Used for detailed audit trail and sequence reconstruction.',
    `movement_type` STRING COMMENT 'Classification of the stock movement transaction. Receipt = goods received into warehouse; Issue = goods distributed/issued out; Transfer = movement between warehouses; Adjustment = correction entry; Physical_count = reconciliation from physical inventory count; Loss = documented loss/damage; Write_off = removal from inventory due to expiry/obsolescence. [ENUM-REF-CANDIDATE: receipt|issue|transfer|adjustment|physical_count|loss|write_off — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments about this stock movement transaction. Used to capture additional context, special handling instructions, or operational observations.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this receipt transaction. Links stock movement to procurement documentation for donor reporting and financial reconciliation.. Valid values are `^PO-[A-Z0-9-]{6,20}$`',
    `quality_inspection_status` STRING COMMENT 'Result of quality inspection performed on the commodity at the time of receipt or movement. Pending = inspection not yet completed; Passed = meets quality standards; Failed = rejected; Waived = inspection requirement waived for emergency; Not_required = commodity type does not require inspection.. Valid values are `pending|passed|failed|waived|not_required`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the commodity being moved in the transaction. Always positive; movement direction is determined by movement_type. Precision supports fractional units for medical supplies and bulk commodities.',
    `reason_code` STRING COMMENT 'Standardized code explaining the business reason for the stock movement. Critical for loss analysis, donor reporting, and pipeline management. Normal_receipt = routine procurement; Emergency_receipt = rapid response; Beneficiary_distribution = direct aid delivery; Program_issue = program consumption; Inter_warehouse_transfer = logistics optimization; Count_adjustment = inventory reconciliation; Expiry/Damage/Theft/Loss_in_transit/Obsolescence = loss categories. [ENUM-REF-CANDIDATE: normal_receipt|emergency_receipt|beneficiary_distribution|program_issue|inter_warehouse_transfer|count_adjustment|expiry|damage|theft|loss_in_transit|obsolescence — 11 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of the reason for the stock movement, especially for adjustments, losses, and write-offs. Provides context beyond the standardized reason code.',
    `reference_document_number` STRING COMMENT 'Unique number of the source document (GRN, waybill, distribution order, count sheet, etc.) that authorizes or records this movement. Provides full audit trail linkage.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that authorizes or records this stock movement. GRN = Goods Received Note; Waybill = transport document; Distribution_order = beneficiary distribution plan; Count_sheet = physical inventory count; Adjustment_memo = correction authorization; Loss_report = documented loss/damage; Write_off_authorization = disposal approval. [ENUM-REF-CANDIDATE: GRN|waybill|distribution_order|count_sheet|adjustment_memo|loss_report|write_off_authorization — 7 candidates stripped; promote to reference product]',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items such as medical equipment, vehicles, or high-value assets. Null for bulk commodities.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of this stock movement transaction (quantity × unit_cost), in the organizations functional currency. Used for inventory valuation, grant expenditure tracking, and donor reporting. Confidential business data.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for the shipment associated with this stock movement. Enables real-time visibility of in-transit commodities.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for this stock movement (applicable for transfers and receipts). Road = truck/vehicle; Air = aircraft; Sea = ship/barge; Rail = train; Pipeline = bulk liquid/gas; Hand_carry = manual transport for small quantities.. Valid values are `road|air|sea|rail|pipeline|hand_carry`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the commodity at the time of this movement, in the organizations functional currency. Used for inventory valuation and donor financial reporting. Confidential business data.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Standardized to organizational commodity catalog units. [ENUM-REF-CANDIDATE: piece|box|carton|pallet|kg|liter|meter|dose|kit|set — 10 candidates stripped; promote to reference product]',
    `vvm_status_at_movement` TIMESTAMP COMMENT 'VVM stage at time of stock movement.',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional log of all inventory movements including receipts, issues, transfers between warehouses, adjustments, physical count reconciliations, losses, and write-offs. Each record captures movement type (receipt/issue/transfer/adjustment/physical_count/loss/write-off), commodity, source location, destination location, quantity, movement date, reference document (GRN/waybill/distribution order/count sheet), reason code, authorizing officer, and count team reference (for physical count adjustments). Provides full commodity pipeline audit trail for donor reporting, IATI transparency, inventory accuracy management, and loss detection.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` (
    `distribution_plan_id` BIGINT COMMENT 'Unique identifier for the distribution plan. Primary key for the distribution plan entity.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding agreement that finances this distribution plan.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Distribution plans must reference budgets for cost planning, authorization, and budget availability verification. Essential for nonprofit program planning and financial control.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: Fundraising campaigns often directly fund specific distribution initiatives (e.g., emergency response campaigns, seasonal distributions). Campaign managers need to track distribution outcomes and bene',
    `chs_self_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.chs_self_assessment. Business justification: CHS Commitment 6 (coordinated, complementary response) requires distribution planning evidence. Real business process: CHS verification and certification audit trail for humanitarian quality standards',
    `community_id` BIGINT COMMENT 'Foreign key linking to beneficiary.community. Business justification: Distribution plans target entire communities for blanket distributions (emergency response, mass vaccination campaigns, community-level WASH infrastructure). Standard humanitarian response approach fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution plans require cost center assignment for expense tracking and program cost allocation. Essential for nonprofit program expense management and reporting.',
    `country_office_id` BIGINT COMMENT 'Identifier of the field office responsible for executing this distribution plan.',
    `intervention_id` BIGINT COMMENT 'Identifier of the humanitarian program this distribution plan supports.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the partner organization (CSO, CBO, INGO) collaborating on this distribution plan.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Distribution plans are created in logistics/program management platforms. System tracking supports data lineage for donor reporting, integration monitoring between supply and program systems, and plat',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who approved this distribution plan.',
    `project_site_id` BIGINT COMMENT 'Identifier of the primary project site where distribution will occur.',
    `actual_end_date` DATE COMMENT 'Actual date when distribution activities were completed in the field.',
    `actual_start_date` DATE COMMENT 'Actual date when distribution activities commenced in the field.',
    `approval_date` DATE COMMENT 'Date when the distribution plan was formally approved for execution.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before this distribution plan can be executed.',
    `beneficiary_category` STRING COMMENT 'Primary category of beneficiaries targeted by this distribution plan. IDP (Internally Displaced Person), PoC (Person of Concern), refugee, host community, returnee, or other vulnerable population classification.. Valid values are `idp|refugee|host_community|returnee|poc|vulnerable_population`',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the budget amount (e.g., USD, EUR, GBP).',
    `cold_chain_capacity_verified_flag` BOOLEAN COMMENT 'Whether cold chain capacity has been verified for this plan.',
    `coordination_cluster` STRING COMMENT 'Humanitarian cluster or sector coordinating this distribution (e.g., Food Security, WASH, Shelter, Health, Protection).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution plan record was first created in the system.',
    `distribution_duration_days` STRING COMMENT 'Planned duration in days for the distribution activities to be completed.',
    `distribution_frequency` STRING COMMENT 'Planned frequency of distribution events under this plan (one-time, recurring weekly, monthly, etc.).. Valid values are `one_time|weekly|biweekly|monthly|quarterly|as_needed`',
    `distribution_modality` STRING COMMENT 'Method by which humanitarian commodities or assistance will be delivered to beneficiaries (direct distribution, voucher-based, cash transfer, etc.).. Valid values are `direct|voucher|cash_in_kind|mobile_money|e_voucher|hybrid`',
    `distribution_type` STRING COMMENT 'Classification of the distribution plan based on urgency and frequency (emergency relief, routine program distribution, seasonal support, etc.).. Valid values are `emergency|routine|seasonal|one_time|recurring`',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Estimated total budget allocated for this distribution plan including commodity costs, logistics, and operational expenses.',
    `estimated_total_volume_m3` DECIMAL(18,2) COMMENT 'Estimated total volume in cubic meters of all commodities to be distributed under this plan.',
    `estimated_total_weight_kg` DECIMAL(18,2) COMMENT 'Estimated total weight in kilograms of all commodities to be distributed under this plan.',
    `funding_source` STRING COMMENT 'Primary funding source or donor supporting this distribution plan (e.g., USAID, DFID, CERF, private donations).',
    `geographic_coverage_admin1` STRING COMMENT 'First-level administrative division (province, state, region) where distribution will occur.',
    `geographic_coverage_admin2` STRING COMMENT 'Second-level administrative division (district, county) where distribution will occur.',
    `geographic_coverage_admin3` STRING COMMENT 'Third-level administrative division (sub-district, municipality) where distribution will occur.',
    `geographic_coverage_country` STRING COMMENT 'Three-letter ISO country code where the distribution will take place.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution plan record was last updated or modified.',
    `mel_indicator_alignment` STRING COMMENT 'Key MEL indicators or KPIs (Key Performance Indicators) that this distribution plan contributes to achieving.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this distribution plan.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the distribution plan indicating its approval and execution state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_progress|completed|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `planned_end_date` DATE COMMENT 'Scheduled date when distribution activities are planned to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when distribution activities are planned to begin.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for this distribution plan considering security, logistics, and operational challenges.. Valid values are `low|medium|high|critical`',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goals that this distribution plan supports (e.g., SDG 1: No Poverty, SDG 2: Zero Hunger).',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether security clearance or authorization is required before distribution can proceed in the target area.',
    `target_beneficiary_count` STRING COMMENT 'Planned number of individual beneficiaries or households to be reached by this distribution plan.',
    `target_household_count` STRING COMMENT 'Planned number of households to receive assistance under this distribution plan.',
    `vaccine_campaign_flag` BOOLEAN COMMENT 'Whether this distribution plan is for a vaccination campaign.',
    CONSTRAINT pk_distribution_plan PRIMARY KEY(`distribution_plan_id`)
) COMMENT 'Master plan for the distribution of humanitarian commodities to beneficiaries at field locations. Captures distribution plan name, target program, geographic coverage (country/admin levels), planned distribution date range, target beneficiary count, commodity list with planned quantities per beneficiary, distribution modality (direct/voucher/cash-in-kind), responsible field office, and approval status. Links supply chain planning to field operations and MEL targets.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`distribution_order` (
    `distribution_order_id` BIGINT COMMENT 'Unique identifier for the distribution order. Primary key for the distribution order entity.',
    `award_id` BIGINT COMMENT 'Reference to the specific grant or funding agreement under which this distribution order is charged. Ensures proper fund accounting and compliance.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Distribution orders must be checked against budgets for authorization and budget control. Essential for nonprofit financial control and program spending oversight.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution orders trigger distribution expenses that must be allocated to cost centers for program cost tracking. Essential for nonprofit expense allocation and reporting.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse from which commodities will be released and dispatched. Source location for stock movement.',
    `distribution_plan_id` BIGINT COMMENT 'Reference to the originating distribution plan that authorized this order. Links the order to the strategic distribution planning process.',
    `distribution_warehouse_id` BIGINT COMMENT 'Reference to the field distribution point where commodities will be delivered for beneficiary distribution. Target location for last-mile logistics.',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: Distribution orders fulfill assistance to specific households. Direct operational link between supply chain execution and beneficiary delivery. Critical for household-level distribution tracking, rati',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program under which this distribution order is executed. Links order to program budget and objectives.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Distribution orders often executed by partner organizations at field level. Links execution to partnership agreements, validates against partner capacity and geographic scope, supports performance rev',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member responsible for overseeing the loading and dispatch of commodities from the warehouse. Accountability for stock release.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the distribution will take place. Geographic context for delivery operations.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Distribution orders deliver to individual beneficiaries (cash/voucher programs, individual assistance, protection items). Common in protection, health, and individual case management programs. Enables',
    `actual_delivery_date` DATE COMMENT 'Actual date when commodities were delivered to the destination distribution point. Used for performance tracking and variance analysis.',
    `approved_date` DATE COMMENT 'Date when the distribution order was officially approved by authorized personnel. Marks transition from draft to approved status.',
    `beneficiary_count` STRING COMMENT 'Estimated number of beneficiaries who will receive assistance from this distribution order. Used for impact measurement and Monitoring Evaluation and Learning (MEL) reporting.',
    `carrier_name` STRING COMMENT 'Name of the transport carrier or logistics provider responsible for delivering the commodities. May be internal fleet or third-party contractor.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether commodities in this order require cold chain (temperature-controlled) logistics. Critical for vaccines, medicines, and perishable items.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution order record was first created in the system. Audit trail for data lineage and compliance.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this distribution order requires customs clearance for cross-border shipment. Triggers customs documentation and compliance processes.',
    `customs_reference` STRING COMMENT 'Reference number for customs clearance documentation if cross-border shipment is required. Used for tracking and compliance verification.',
    `delivery_instructions` STRING COMMENT 'Special instructions or notes for the delivery of commodities to the destination distribution point. May include access constraints, security protocols, or handling requirements.',
    `dispatch_date` DATE COMMENT 'Date when commodities were physically dispatched from the issuing warehouse. Marks the start of last-mile logistics execution.',
    `distribution_type` STRING COMMENT 'Classification of the distribution approach. General distributions serve entire populations, targeted distributions serve specific vulnerable groups, emergency distributions respond to crises.. Valid values are `general|targeted|emergency|seasonal|supplementary|blanket`',
    `driver_contact` STRING COMMENT 'Contact phone number for the driver during transit. Enables real-time communication for tracking and issue resolution during delivery.',
    `driver_name` STRING COMMENT 'Name of the driver responsible for transporting the commodities. Used for accountability and security purposes in field operations.',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether this distribution order is part of an emergency response operation. True for rapid-onset disaster or crisis response orders.',
    `estimated_value_usd` DECIMAL(18,2) COMMENT 'Estimated total monetary value of all commodities in this distribution order, expressed in US dollars. Used for financial tracking and donor reporting.',
    `household_count` STRING COMMENT 'Estimated number of households that will be served by this distribution order. Key metric for humanitarian assistance planning and reporting.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether commodities in this order were received as in-kind donations rather than purchased. Affects valuation and donor acknowledgment processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution order record was last updated in the system. Audit trail for change tracking and data quality monitoring.',
    `medical_supplies_flag` BOOLEAN COMMENT 'Indicates whether this distribution order contains medical supplies or pharmaceuticals. Triggers special handling and regulatory compliance requirements.',
    `nfi_flag` BOOLEAN COMMENT 'Indicates whether this distribution order contains Non-Food Items such as shelter materials, hygiene kits, or household supplies. Used for commodity classification.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to this distribution order. Captures context, issues, or special circumstances not covered by structured fields.',
    `order_date` DATE COMMENT 'Date when the distribution order was created and entered into the system. Business event timestamp for order initiation.',
    `order_number` STRING COMMENT 'Human-readable unique order number assigned to this distribution order for tracking and reference purposes. Format: DO-YYYYMMDD-sequence.. Valid values are `^DO-[0-9]{8}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the distribution order. Tracks progression from draft through approval, dispatch, transit, delivery, and closure. [ENUM-REF-CANDIDATE: draft|approved|dispatched|in_transit|delivered|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification of the distribution order. Determines urgency of dispatch and delivery, with emergency orders receiving expedited processing.. Valid values are `emergency|high|medium|low`',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for delivery of commodities to the destination distribution point. Used for logistics planning and beneficiary communication.',
    `special_handling_requirements` STRING COMMENT 'Specific handling requirements for commodities in this order, such as fragile items, hazardous materials, or temperature-sensitive goods. Ensures proper care during transport.',
    `total_commodity_lines` STRING COMMENT 'Total number of distinct commodity line items included in this distribution order. Summary count for order complexity assessment.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodities in this distribution order, expressed in standard units. Summary measure for order volume.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of all commodities in this distribution order, measured in cubic meters. Used for warehouse space and transport capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of all commodities in this distribution order, measured in kilograms. Used for transport planning and capacity management.',
    `transport_cost_usd` DECIMAL(18,2) COMMENT 'Actual or estimated cost of transporting commodities from warehouse to distribution point, expressed in US dollars. Used for budget tracking and cost analysis.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for dispatching commodities from warehouse to distribution point. Critical for logistics planning and cost allocation.. Valid values are `road|air|sea|rail|multimodal|hand_carry`',
    `vaccine_distribution_flag` BOOLEAN COMMENT 'Whether this distribution order includes vaccines.',
    `vehicle_registration` STRING COMMENT 'Registration number or identifier of the vehicle used for transporting commodities. Used for fleet management and security tracking.',
    `waybill_reference` STRING COMMENT 'Reference number of the transport waybill or shipping document accompanying the commodity shipment. Used for tracking and proof of dispatch.',
    CONSTRAINT pk_distribution_order PRIMARY KEY(`distribution_order_id`)
) COMMENT 'Operational order authorizing the release and dispatch of commodities from a warehouse to a field distribution point for beneficiary delivery. Captures order number, originating distribution plan, issuing warehouse, destination distribution point, commodity lines with quantities, dispatch date, transport mode, waybill reference, loading officer, and order status (draft/approved/dispatched/delivered/closed). Triggers stock movement and last-mile logistics execution.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`waybill` (
    `waybill_id` BIGINT COMMENT 'Unique identifier for the waybill shipping document. Primary key for the waybill entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that finances this shipment. Required for donor reporting and fund accounting.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Transport incidents (accidents, seal tampering, driver misconduct, cargo diversion) trigger compliance incident reports requiring investigation. Real business process: logistics incident management an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waybills represent transport costs that must be allocated to cost centers for logistics expense tracking. Essential for nonprofit program cost allocation and reporting.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Waybill is the shipping document that accompanies commodity movements from warehouse to distribution point. Each waybill is issued for a specific distribution order. The distribution_order table has w',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Waybills require GL accounts for freight expense posting and financial reporting. Essential for nonprofit expense accounting and financial statement preparation.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project that this shipment supports. Links commodities to program activities and beneficiaries.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse from which the commodities were dispatched. Links to warehouse master data.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Waybills often involve partner organizations as shippers or receivers in last-mile logistics. Tracks logistics responsibility, validates against partnership agreement transport obligations, supports a',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to supply.shipment. Business justification: Waybill is the shipping document for a shipment. In humanitarian logistics, waybills accompany both international shipments (sea/air freight) and domestic distribution movements. This FK links the way',
    `vendor_id` BIGINT COMMENT 'Reference to the transport company or carrier responsible for moving the commodities. Links to partner or vendor master data.',
    `waybill_warehouse_id` BIGINT COMMENT 'Reference to the destination location (warehouse, distribution point, or project site) where commodities are being delivered.',
    `actual_delivery_date` DATE COMMENT 'Actual date when commodities were delivered and received at destination. Used for performance measurement against estimated delivery date.',
    `arrival_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vehicle arrived at the destination location. Used to calculate actual transit time and delivery performance.',
    `cold_chain_equipment_used` STRING COMMENT 'Cold chain equipment used during transport (cold box type, vaccine carrier type).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this waybill record was first created in the system. Part of audit trail for data lineage and compliance.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether customs clearance is required for this shipment (cross-border movements). True for international shipments.',
    `customs_declaration_number` STRING COMMENT 'Official customs declaration or clearance document number for cross-border shipments. Required for international humanitarian aid movements.',
    `departure_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vehicle departed from the origin warehouse. Used for transit time analysis and security tracking.',
    `discrepancy_notes` STRING COMMENT 'Detailed explanation of any quantity discrepancies, damage, or quality issues identified upon receipt. Critical for loss investigation and donor reporting.',
    `discrepancy_quantity` DECIMAL(18,2) COMMENT 'Difference between total dispatched and total received quantities. Positive values indicate shortages, negative values indicate overages.',
    `dispatch_date` DATE COMMENT 'Date when the shipment was dispatched from the origin warehouse. Critical for lead time calculation and delivery performance tracking.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers between origin and destination. Used for cost calculation and transit time estimation.',
    `driver_contact_number` STRING COMMENT 'Mobile phone number of the driver for real-time communication during transit. Essential for emergency contact and route coordination.',
    `driver_license_number` STRING COMMENT 'Official driver license number for verification and compliance purposes. Required for audit trails and security checks.',
    `driver_name` STRING COMMENT 'Full name of the driver responsible for transporting the commodities. Used for accountability and security verification.',
    `estimated_delivery_date` DATE COMMENT 'Planned or expected date of arrival at destination. Used for distribution planning and beneficiary communication.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling. True if hazardous materials present.',
    `ice_packs_count` STRING COMMENT 'Number of conditioned ice packs used for transport.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the cargo insurance policy covering this shipment. Required for claims processing in case of loss or damage.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is required for this shipment. True for high-value or high-risk shipments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this waybill record was last updated. Tracks the most recent change for audit and synchronization purposes.',
    `priority_level` STRING COMMENT 'Urgency classification for the shipment. Critical priority typically reserved for life-saving commodities in emergency response.. Valid values are `critical|high|medium|low`',
    `receipt_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a physical or digital signature was captured upon receipt. True if signature obtained, False otherwise.',
    `received_by_name` STRING COMMENT 'Full name of the person who received and signed for the shipment at destination. Critical for accountability and audit trail.',
    `received_by_title` STRING COMMENT 'Job title or role of the person who received the shipment. Provides context for authorization level and responsibility.',
    `remarks` STRING COMMENT 'General notes, special instructions, or additional context about the shipment. May include handling instructions, security concerns, or coordination notes.',
    `route_description` STRING COMMENT 'Description of the planned transport route including major waypoints, checkpoints, or transit hubs. Important for security planning in conflict zones.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was intact upon arrival at destination. True if intact, False if broken or tampered.',
    `seal_number` STRING COMMENT 'Unique security seal number applied to the shipment container or vehicle to prevent tampering. Critical for loss prevention and donor audit compliance.. Valid values are `^SEAL[0-9]{6,10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the waybill shipment. Tracks progression from dispatch through final receipt and reconciliation.. Valid values are `draft|dispatched|in_transit|arrived|received|cancelled`',
    `shipment_type` STRING COMMENT 'Classification of the shipment purpose. Distinguishes between emergency relief, routine program supplies, warehouse transfers, and returns.. Valid values are `emergency_relief|program_supply|inter_warehouse_transfer|return_shipment`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled transport (cold chain). True for medical supplies, vaccines, or perishable items.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Exceedance may compromise commodity efficacy.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Critical for cold chain compliance and commodity quality.',
    `total_dispatched_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodity items dispatched on this waybill. Sum of all line-item dispatched quantities.',
    `total_received_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodity items received at destination. Used to calculate overall shipment discrepancy.',
    `transport_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for transporting this shipment. Includes carrier fees, fuel surcharges, and handling charges.',
    `transport_cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the transport cost amount. Essential for multi-currency operations and financial reporting.',
    `vaccine_transport_flag` BOOLEAN COMMENT 'Whether this waybill covers vaccine/cold chain transport.',
    `vehicle_registration` STRING COMMENT 'Official registration or license plate number of the vehicle used for transport. Critical for security tracking and incident investigation.. Valid values are `^[A-Z0-9-]{5,15}$`',
    `waybill_number` STRING COMMENT 'Externally-known unique waybill document number used for tracking and reference by transporters, warehouses, and auditors. Typically follows organizational numbering convention.. Valid values are `^WB[0-9]{8,12}$`',
    CONSTRAINT pk_waybill PRIMARY KEY(`waybill_id`)
) COMMENT 'Transactional shipping document accompanying commodity movements between warehouses or to distribution points. Records waybill number, dispatch date, origin warehouse, destination location, transporter/carrier, vehicle registration, driver details, commodity lines with dispatched quantities, seal numbers, departure time, arrival time, received quantities, and discrepancy notes. Critical for last-mile accountability, loss tracking, and donor audit compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` (
    `inkind_donation_id` BIGINT COMMENT 'Unique identifier for the in-kind donation record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding agreement under which this in-kind donation is allocated, if applicable. Links donation to programmatic funding.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: In-kind donations are of specific commodities from the master commodity catalog. The inkind_donation table currently has commodity_type, commodity_description, and commodity_category (all STRING) whic',
    `community_id` BIGINT COMMENT 'Foreign key linking to beneficiary.community. Business justification: In-kind donations allocated to specific communities (community infrastructure, blanket distributions, school supplies for community schools). Common in emergency response and community development pro',
    `constituent_id` BIGINT COMMENT 'Reference to the donor entity (individual, corporation, government, or partner organization) that provided this in-kind donation.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: In-kind donations must be credited to funds for fund accounting and donor reporting. Essential for nonprofit contribution tracking and restricted fund management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: In-kind donations must be recorded to revenue/asset GL accounts for contribution accounting. Essential for nonprofit financial reporting and GAAP/IFRS compliance.',
    `impact_story_id` BIGINT COMMENT 'Foreign key linking to communication.impact_story. Business justification: In-kind donations are frequently featured in impact stories for donor stewardship, demonstrating tangible support and program outcomes. Standard practice links specific donations to stories for acknow',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project for which this in-kind donation is designated, supporting program-level tracking and reporting.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: In-kind donations often received through or from partner organizations. Tracks partner contribution to cost-sharing requirements, validates against partnership agreement terms, supports IATI reporting',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage facility where the in-kind donation was received and is currently stored.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: In-kind donations must be reported on IRS Form 990 Schedule M with fair market valuations and donor acknowledgments. Real business process: annual tax filing preparation.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to supply.shipment. Business justification: In-kind donations arrive via international or domestic shipments. The inkind_donation table has shipping_tracking_number (STRING) which is a reference string. Establishing shipment_id FK to shipment.s',
    `acknowledgment_date` DATE COMMENT 'Date the donor acknowledgment or receipt was issued for this in-kind donation. Required for donor stewardship and tax compliance.',
    `acknowledgment_status` STRING COMMENT 'Current status of donor acknowledgment and receipt processing: pending, acknowledged, receipt issued, or thank-you communication sent.. Valid values are `pending|acknowledged|receipt_issued|thank_you_sent`',
    `allocation_status` STRING COMMENT 'Current allocation and distribution status of the in-kind donation: unallocated (in warehouse), allocated to program, distributed to beneficiaries, or consumed/used.. Valid values are `unallocated|allocated|distributed|consumed`',
    `batch_lot_number` STRING COMMENT 'Manufacturer batch or lot number for the donated commodity, used for quality control, recall management, and traceability.',
    `condition_status` STRING COMMENT 'Physical condition of the donated commodity at receipt: new, good, fair, damaged, or expired. Critical for distribution planning and beneficiary safety.. Valid values are `new|good|fair|damaged|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this in-kind donation record was first created in the system.',
    `customs_clearance_date` DATE COMMENT 'Date the in-kind donation cleared customs and was released for domestic distribution.',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance for the in-kind donation: pending, cleared, held for inspection, released, or exempted from duties.. Valid values are `pending|cleared|held|released|exempted`',
    `donation_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this in-kind donation for tracking and acknowledgment purposes.',
    `donor_name` STRING COMMENT 'Name of the donor organization or individual providing the in-kind donation for acknowledgment and reporting purposes.',
    `donor_restrictions` STRING COMMENT 'Any restrictions or conditions imposed by the donor on the use, distribution, or geographic allocation of the in-kind donation. Critical for compliance with donor intent.',
    `donor_type` STRING COMMENT 'Classification of the donor providing the in-kind donation: individual, corporate partner, government agency, foundation, multilateral organization, bilateral agency, or Civil Society Organization (CSO). [ENUM-REF-CANDIDATE: individual|corporate|government|foundation|multilateral|bilateral|cso — 7 candidates stripped; promote to reference product]',
    `estimated_fair_market_value` DECIMAL(18,2) COMMENT 'Estimated fair market value of the in-kind donation in the reporting currency, used for non-cash contribution accounting per FASB ASC 958 and donor stewardship reporting.',
    `expiration_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive commodities (e.g., medical supplies, food items). Critical for distribution prioritization and safety.',
    `iati_reporting_flag` BOOLEAN COMMENT 'Boolean indicator whether this in-kind donation must be reported to the International Aid Transparency Initiative (IATI) for transparency and accountability (True = reportable, False = not reportable).',
    `iati_transaction_type` STRING COMMENT 'IATI transaction type code for this in-kind donation (typically code 1 for incoming funds/resources or code 11 for incoming commitments).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this in-kind donation record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the in-kind donation, including special handling instructions, donor communications, or operational observations.',
    `quality_inspection_date` DATE COMMENT 'Date the quality inspection was performed on the in-kind donation to verify condition and compliance with standards.',
    `quality_inspection_flag` BOOLEAN COMMENT 'Boolean indicator whether the in-kind donation underwent quality inspection upon receipt (True = inspected, False = not inspected).',
    `quality_inspection_result` STRING COMMENT 'Result of the quality inspection: passed (acceptable for distribution), failed (rejected), conditional (usable with restrictions), or not inspected.. Valid values are `passed|failed|conditional|not_inspected`',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the donated commodity received, expressed in the unit of measure specified.',
    `receipt_date` DATE COMMENT 'Date the in-kind donation was physically received at the warehouse or field location. Used for accounting recognition and inventory tracking.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the in-kind donation was received and logged into the inventory system.',
    `receiving_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the in-kind donation was received.. Valid values are `^[A-Z]{3}$`',
    `receiving_location_name` STRING COMMENT 'Name of the warehouse, field office, or storage location where the in-kind donation was received.',
    `restricted_use_flag` BOOLEAN COMMENT 'Boolean indicator whether the in-kind donation has donor-imposed restrictions on its use or distribution (True = restricted, False = unrestricted).',
    `shipment_origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code from which the in-kind donation was shipped.. Valid values are `^[A-Z]{3}$`',
    `tax_deductible_flag` BOOLEAN COMMENT 'Boolean indicator whether this in-kind donation qualifies for tax deduction by the donor under applicable tax regulations (True = deductible, False = not deductible).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the donated commodity quantity (e.g., pieces, boxes, pallets, kilograms, liters, doses).',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated fair market value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `valuation_method` STRING COMMENT 'Method used to determine the fair market value of the in-kind donation: donor estimate, market price research, independent appraisal, catalog price, or replacement cost.. Valid values are `donor_estimate|market_price|appraisal|catalog_price|replacement_cost`',
    CONSTRAINT pk_inkind_donation PRIMARY KEY(`inkind_donation_id`)
) COMMENT 'Master record of in-kind commodity donations received from donors, governments, or corporate partners. Captures donation reference, donor identity, commodity type and description, quantity, estimated fair market value, condition, donor restrictions on use, receipt date, receiving warehouse, acknowledgment status, and IATI reporting flag. Distinct from cash-funded procurement; supports non-cash contribution accounting per FASB ASC 958 and donor stewardship reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`procurement_request` (
    `procurement_request_id` BIGINT COMMENT 'Unique identifier for the procurement request. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source that will cover the cost of this procurement. Essential for fund accounting and donor reporting.',
    `beneficiary_needs_assessment_id` BIGINT COMMENT 'Foreign key linking to beneficiary.needs_assessment. Business justification: Procurement requests originate from identified needs in assessments. Standard procurement justification workflow required by donors and internal controls. Essential for needs-based procurement account',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Procurement requests must reference budget lines for authorization and budget availability verification. Essential for nonprofit budget control and requisition approval workflow. Replaces denormalized',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Procurement requests require cost center assignment for expense planning and approval workflow. Essential for nonprofit budget planning and financial control.',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Procurement requests must identify funding source at requisition stage for budget control and approval workflows. Ensures requests dont exceed available fund balances and comply with donor restrictio',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor-funded procurement must comply with donor-specific rules (USAID source/origin, EU visibility, geographic restrictions). Real business process: pre-award compliance verification before requisitio',
    `feedback_case_id` BIGINT COMMENT 'Foreign key linking to communication.feedback_case. Business justification: Procurement requests often originate from feedback cases reporting commodity shortages, quality issues, or unmet needs. This creates the accountability loop where beneficiary feedback directly influen',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.framework_agreement. Business justification: Procurement requests can be fulfilled via call-off from existing framework agreements (LTAs) rather than going through a new competitive bidding process. This FK links the procurement request to the f',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project for which this procurement is requested. Links the request to program delivery needs.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Procurement requests often originate from partner organizations implementing field programs. Tracks accountability for partner-initiated procurement, validates against partnership agreement scope, and',
    `vendor_id` BIGINT COMMENT 'Identifier of a preferred or pre-qualified vendor for this procurement, if applicable. May be based on prior performance, framework agreements, or emergency response partnerships.',
    `user_account_id` BIGINT COMMENT 'Identifier of the user (staff member) who provided final approval for this procurement request. Links to workforce or user management system.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (country office, program unit, or field team) that raised this procurement request.',
    `project_site_id` BIGINT COMMENT 'Identifier of the specific field project site or location where the procured items or services will be delivered or utilized.',
    `tertiary_procurement_last_modified_by_user_user_account_id` BIGINT COMMENT 'Identifier of the user who last modified this procurement request record. Used for audit trail and accountability.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse, project site, or field location where the procured items should be delivered.',
    `approval_date` DATE COMMENT 'Date on which the procurement request was formally approved and authorized to proceed to procurement execution.',
    `approval_level_required` STRING COMMENT 'Highest approval authority level required for this procurement request based on value thresholds and organizational delegation of authority: team lead, program manager, country director, regional director, headquarters procurement, Chief Financial Officer (CFO), or Chief Executive Officer (CEO). [ENUM-REF-CANDIDATE: team_lead|program_manager|country_director|regional_director|hq_procurement|cfo|ceo — 7 candidates stripped; promote to reference product]',
    `commodity_category` STRING COMMENT 'High-level category of the commodity or service being requested, aligned with humanitarian cluster or functional area: Water Sanitation and Hygiene (WASH), health, nutrition, shelter, education, protection, logistics, Information and Communication Technology (ICT), or administration. [ENUM-REF-CANDIDATE: wash|health|nutrition|shelter|education|protection|logistics|ict|admin — 9 candidates stripped; promote to reference product]',
    `compliance_check_required` BOOLEAN COMMENT 'Boolean flag indicating whether this procurement requires additional compliance checks such as sanctions screening, export control review, or anti-terrorism financing verification. True if compliance check is required, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement request record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated costs (e.g., USD, EUR, GBP). Essential for multi-currency grant management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full text address for delivery if the delivery location is not a standard warehouse or registered site. Includes street, city, region, and country details.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this procurement request and its details should be visible to the donor in transparency reports or donor portals. True if donor visibility is required, false otherwise.',
    `environmental_impact_assessment` STRING COMMENT 'Classification of the environmental impact of this procurement: not required (no significant impact), low impact (minimal environmental footprint), moderate impact (some environmental considerations), high impact (significant environmental review needed), or assessment pending (evaluation in progress).. Valid values are `not_required|low_impact|moderate_impact|high_impact|assessment_pending`',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for the entire procurement request, calculated as quantity requested multiplied by estimated unit cost. May include additional costs such as shipping or taxes.',
    `estimated_unit_cost` DECIMAL(18,2) COMMENT 'Estimated cost per unit of the requested item or service. Used for budget planning and approval thresholds.',
    `item_description` STRING COMMENT 'Detailed narrative description of the commodity, service, or work being requested. Includes specifications, quality standards, and any technical requirements.',
    `justification_narrative` STRING COMMENT 'Detailed business justification for this procurement request. Explains the program need, beneficiary impact, alignment with Theory of Change (ToC) or Logical Framework (LogFrame), and why this procurement is necessary.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement request record was last updated or modified. Used for audit trail and change tracking.',
    `local_procurement_preference` BOOLEAN COMMENT 'Boolean flag indicating whether this procurement should prioritize local or in-country vendors to support local economies and reduce lead times. True if local preference applies, false otherwise.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Numeric quantity of the item or service being requested. May represent units, volume, weight, or service hours depending on the request type.',
    `rejection_reason` STRING COMMENT 'Narrative explanation if the procurement request was rejected. Includes reasons such as insufficient budget, lack of justification, non-compliance with procurement policy, or program priority changes.',
    `request_date` DATE COMMENT 'Date on which this procurement request was formally submitted for review and approval. Represents the principal business event timestamp for this transaction.',
    `request_status` STRING COMMENT 'Current lifecycle status of the procurement request: draft (being prepared), submitted (awaiting review), under review (being evaluated), approved (authorized for procurement), rejected (not approved), cancelled (withdrawn), in procurement (being sourced), or fulfilled (completed). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|cancelled|in_procurement|fulfilled — 8 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the procurement request by the nature of what is being requested: goods, services, works, consultancy, Non-Food Items (NFI), medical supplies, equipment, vehicle, or construction. [ENUM-REF-CANDIDATE: goods|services|works|consultancy|nfi|medical_supplies|equipment|vehicle|construction — 9 candidates stripped; promote to reference product]',
    `required_delivery_date` DATE COMMENT 'Date by which the requested items or services must be delivered to the requesting location. Critical for supply chain planning and program delivery timelines.',
    `requisition_number` STRING COMMENT 'Externally visible unique requisition number assigned to this procurement request. Used for tracking and reference across systems and communications.. Valid values are `^PR-[0-9]{6,10}$`',
    `sole_source_justification` STRING COMMENT 'Justification narrative if this procurement is requested as a sole-source (non-competitive) procurement. Must explain why competitive bidding is not feasible or appropriate.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requested quantity: each, box, carton, kilogram, liter, meter, cubic meter, pallet, set, service hour, day, or month. [ENUM-REF-CANDIDATE: each|box|carton|kg|liter|meter|m3|pallet|set|service_hour|day|month — 12 candidates stripped; promote to reference product]',
    `urgency_level` STRING COMMENT 'Classification of the urgency of this procurement request: routine (standard lead time), urgent (expedited processing), emergency (immediate need), or life-saving (critical humanitarian response).. Valid values are `routine|urgent|emergency|life_saving`',
    CONSTRAINT pk_procurement_request PRIMARY KEY(`procurement_request_id`)
) COMMENT 'Internal requisition raised by program or field teams requesting procurement of commodities or services. Captures requisition number, requesting unit/program, commodity or service description, quantity, estimated budget, urgency level (routine/urgent/emergency), required delivery date, funding source, justification narrative, and approval workflow status. Initiates the procurement cycle and links program needs to supply chain execution.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the Request for Quotation record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office issuing this RFQ.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: RFQs frequently issued to partner organizations as potential suppliers, especially for local procurement. Supports localization strategy, validates partner prequalification status from capacity assess',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or committee with authority to approve the award decision, based on procurement threshold policies.',
    `procurement_request_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_request. Business justification: RFQs are issued in response to approved procurement requests. This FK links the competitive bidding process to the internal requisition that triggered it. Standard procurement workflow: field team rai',
    `project_site_id` BIGINT COMMENT 'Reference to the program or project for which this procurement is being conducted.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: RFQs are published through e-procurement platforms for vendor access. System tracking enables vendor access log audits, platform performance monitoring, and compliance reporting for transparent procur',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to this RFQ (technical specifications, terms of reference, drawings, sample contracts).',
    `award_date` DATE COMMENT 'Date when the contract or purchase order was officially awarded to the winning vendor.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total contract value awarded to the winning vendor, in the currency specified by currency_code.',
    `bid_opening_date` TIMESTAMP COMMENT 'Scheduled date and time when submitted bids will be opened, typically in the presence of authorized personnel or bidders.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled, if applicable (e.g., insufficient responsive bids, budget constraints, program changes, emergency situation resolved).',
    `clarification_deadline` TIMESTAMP COMMENT 'Date and time by which vendors may submit questions or requests for clarification regarding the RFQ specifications.',
    `commodity_category` STRING COMMENT 'High-level classification of the goods or services being procured (e.g., WASH supplies, medical equipment, food commodities, construction services, IT equipment).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial amounts in this RFQ (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_deadline` DATE COMMENT 'Required date by which goods must be delivered or services completed. Critical for emergency response and program timelines.',
    `delivery_location` STRING COMMENT 'Destination address or site where goods must be delivered or services performed (warehouse, project site, country office).',
    `donor_visibility` BOOLEAN COMMENT 'Indicates whether this procurement is subject to donor reporting and audit requirements (True) or is internally funded (False).',
    `emergency_procurement` BOOLEAN COMMENT 'Indicates whether this RFQ was issued under emergency procurement procedures, allowing expedited timelines and simplified processes.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Internal estimated budget or cost ceiling for this procurement. May not be disclosed to vendors to ensure competitive pricing.',
    `evaluation_completion_date` DATE COMMENT 'Date when the bid evaluation process was completed and final scoring/ranking was determined.',
    `evaluation_criteria` STRING COMMENT 'Documented criteria and weighting used to evaluate and score vendor bids (e.g., price 40%, technical quality 30%, delivery time 20%, past performance 10%).',
    `incoterm` STRING COMMENT 'Incoterms rule defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., DDP - Delivered Duty Paid, FOB - Free on Board). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invited_vendor_count` STRING COMMENT 'Number of vendors invited to submit quotations for this RFQ. Relevant for restricted tenders and competitive bidding documentation.',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued and published to vendors.',
    `item_description` STRING COMMENT 'Detailed technical specification and description of the goods or services being procured, including quality standards, technical requirements, and performance criteria.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ record was last updated or modified.',
    `minimum_qualification_requirements` STRING COMMENT 'Mandatory qualifications vendors must meet to be eligible (e.g., certifications, licenses, financial capacity, prior experience, quality standards compliance).',
    `notes` STRING COMMENT 'Additional internal notes, special instructions, or contextual information relevant to this RFQ process.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Agreed payment schedule and conditions (e.g., Net 30, 50% advance / 50% on delivery, milestone-based payments).',
    `procurement_method` STRING COMMENT 'Method of procurement used: open competitive bidding, restricted tender (invited vendors only), direct procurement, framework agreement call-off, or emergency procurement.. Valid values are `open_competitive|restricted|direct|framework_agreement|emergency`',
    `procurement_type` STRING COMMENT 'Category of procurement: goods (commodities, equipment), services (professional services), works (construction), consultancy, NFI (Non-Food Items), or medical supplies.. Valid values are `goods|services|works|consultancy|nfi|medical_supplies`',
    `published_url` STRING COMMENT 'Web address where the RFQ documentation is publicly posted, supporting transparency and open competitive bidding.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Total quantity of goods or volume of services requested in this RFQ.',
    `received_bid_count` STRING COMMENT 'Number of valid bids or quotations received by the submission deadline.',
    `responsive_bid_count` STRING COMMENT 'Number of bids that met all mandatory requirements and were deemed responsive for evaluation.',
    `rfq_number` STRING COMMENT 'Externally-known unique business identifier for the RFQ, typically following organizational numbering convention (e.g., RFQ-USA-2024-00123).. Valid values are `^RFQ-[A-Z]{3}-[0-9]{4}-[0-9]{5}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ: draft (being prepared), open (accepting bids), closed (submission deadline passed), under evaluation (bids being reviewed), awarded (vendor selected), or cancelled.. Valid values are `draft|open|closed|under_evaluation|awarded|cancelled`',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which vendor quotations or bids must be submitted. No late submissions accepted after this timestamp.',
    `title` STRING COMMENT 'Descriptive title or subject of the RFQ, summarizing the goods or services being procured.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requested quantity (e.g., each, kilogram, liter, box, service hour). [ENUM-REF-CANDIDATE: each|kg|liter|meter|box|carton|pallet|service_hour|day|month — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation (RFQ) or Invitation to Bid (ITB) issued to vendors during competitive procurement processes, including all vendor-submitted quotations and bid evaluation documentation. Captures RFQ number, issuing office, commodity/service specifications, quantity, submission deadline, evaluation criteria, list of invited vendors, vendor responses with offered unit prices and delivery terms, bid evaluation scores, award decision, and RFQ status (open/closed/awarded/cancelled). Supports transparent competitive bidding per 2 CFR 200 procurement standards, organizational procurement policy thresholds, and value-for-money documentation for donor audits.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key for the shipment entity.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Cargo loss, theft, diversion, quality failures, or customs violations trigger compliance incidents requiring investigation and donor notification. Real business process: incident reporting and correct',
    `crisis_communication_id` BIGINT COMMENT 'Foreign key linking to communication.crisis_communication. Business justification: Emergency shipments during crises require coordinated crisis communication for media relations, stakeholder updates, and operational coordination. Links supply chain response to crisis communication m',
    `distribution_event_id` BIGINT COMMENT 'Reference to the distribution event this shipment supports, if applicable.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Shipments frequently managed by or consigned to partner organizations for last-mile delivery. Critical for logistics coordination, tracks custody transfer points, validates against partnership agreeme',
    `project_site_id` BIGINT COMMENT 'Reference to the field project site receiving or sending this shipment.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Shipments are tracked in TMS/logistics platforms. System reference enables integration health monitoring, data quality assessments, and troubleshooting shipment visibility issues critical for emergenc',
    `warehouse_id` BIGINT COMMENT 'Reference to the origin or destination warehouse for this shipment.',
    `actual_arrival_date` DATE COMMENT 'Actual date when the shipment arrived at the destination port or warehouse, as confirmed by receiving personnel.',
    `actual_departure_date` DATE COMMENT 'Actual date when the shipment departed from the origin port or warehouse, as confirmed by the carrier or freight forwarder.',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading number for sea freight or Airway Bill number for air freight, serving as the legal document of title and receipt for the cargo.',
    `carrier_name` STRING COMMENT 'Name of the shipping line, airline, trucking company, or freight forwarder contracted to transport the shipment.',
    `carrier_reference_number` STRING COMMENT 'Carrier-assigned tracking number or booking reference for the shipment.',
    `cold_chain_monitoring_device` STRING COMMENT 'Type of temperature monitoring device used during shipment.',
    `cold_chain_verified_flag` BOOLEAN COMMENT 'Whether cold chain integrity was verified for this shipment',
    `container_number` STRING COMMENT 'ISO container number for sea freight (e.g., ABCD1234567) or vehicle registration/truck number for road transport.',
    `container_type` STRING COMMENT 'Type of container or vehicle used: 20ft or 40ft standard containers, 40ft high cube for volume cargo, refrigerated for cold chain medical supplies, open top or flat rack for oversized items, truck for road transport, or aircraft for air freight. [ENUM-REF-CANDIDATE: 20ft_standard|40ft_standard|40ft_high_cube|refrigerated|open_top|flat_rack|truck|aircraft — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system, supporting audit trail and data lineage tracking.',
    `customs_broker_name` STRING COMMENT 'Name of the licensed customs broker or clearing agent engaged to facilitate customs clearance and import documentation in the destination country.',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance process: not required for domestic shipments, pending initiation, documentation submitted to customs broker, under review by customs authority, cleared and released, held for inspection or additional documentation, or exemption granted under humanitarian duty-free privileges. [ENUM-REF-CANDIDATE: not_required|pending|documentation_submitted|under_review|cleared|held|exemption_granted — 7 candidates stripped; promote to reference product]',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment destination country (e.g., SYR, YEM, SDN for field operations).. Valid values are `^[A-Z]{3}$`',
    `destination_location_name` STRING COMMENT 'Human-readable name of the final destination warehouse, project site, or distribution point for the shipment.',
    `destination_port_code` STRING COMMENT 'UN/LOCODE or IATA code for the arrival port (sea) or airport (air) where the shipment enters the destination country.',
    `duty_exemption_reference` STRING COMMENT 'Reference number or letter from host government granting duty and tax exemption for humanitarian relief goods under bilateral agreements or United Nations privileges.',
    `estimated_arrival_date` DATE COMMENT 'Planned or estimated date when the shipment is expected to arrive at the destination port or warehouse.',
    `estimated_departure_date` DATE COMMENT 'Planned or estimated date when the shipment is scheduled to depart from the origin port or warehouse.',
    `freight_cost_usd` DECIMAL(18,2) COMMENT 'Total freight transportation cost in United States Dollars, including carrier charges, fuel surcharges, and handling fees.',
    `hazmat_classification` STRING COMMENT 'UN hazardous materials classification code (e.g., UN1170 for ethanol, UN3373 for biological substances) if the shipment contains dangerous goods requiring special handling and documentation.',
    `import_permit_number` STRING COMMENT 'Government-issued import permit or license number required for controlled goods such as medical supplies, pharmaceuticals, or telecommunications equipment.',
    `incoterm` STRING COMMENT 'Incoterms 2020 code defining the division of costs and risks between buyer and seller: EXW (Ex Works), FCA (Free Carrier), CPT (Carriage Paid To), CIP (Carriage and Insurance Paid To), DAP (Delivered at Place), DPU (Delivered at Place Unloaded), DDP (Delivered Duty Paid), FAS (Free Alongside Ship), FOB (Free on Board), CFR (Cost and Freight), CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the shipment cargo against loss, damage, or theft during transit.',
    `insured_value_usd` DECIMAL(18,2) COMMENT 'Declared value of the shipment cargo in United States Dollars for insurance purposes, representing the replacement cost of the goods.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was last modified, supporting audit trail and change tracking for status updates and documentation changes.',
    `number_of_cartons` STRING COMMENT 'Total count of individual cartons, boxes, or packages in the shipment, used for inventory reconciliation and distribution planning.',
    `number_of_pallets` STRING COMMENT 'Total count of pallets or skids in the shipment, used for warehouse handling and loading dock planning.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment origin country (e.g., USA, DNK, ARE for procurement hubs).. Valid values are `^[A-Z]{3}$`',
    `origin_location_name` STRING COMMENT 'Human-readable name of the origin location, warehouse, or facility from which the shipment departs.',
    `origin_port_code` STRING COMMENT 'UN/LOCODE or IATA code for the departure port (sea) or airport (air) from which the shipment originates.',
    `phytosanitary_certificate_number` STRING COMMENT 'Certificate number issued by the origin country plant protection authority for shipments containing agricultural products, seeds, or wooden packaging materials, certifying compliance with international phytosanitary standards.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the shipment, used for tracking and coordination with freight forwarders, customs brokers, and field offices.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment: planned for pipeline forecasting, booked with carrier, in transit en route, customs clearance awaiting documentation, cleared and released, delivered to final destination, or cancelled. [ENUM-REF-CANDIDATE: planned|booked|in_transit|customs_clearance|cleared|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment purpose: emergency relief for rapid response, pre-positioned stock for contingency warehouses, program supply for ongoing operations, in-kind donation from corporate or government donors, medical supply for health programs, or Non-Food Item (NFI) consignment for shelter and household goods.. Valid values are `emergency_relief|pre_positioned_stock|program_supply|in_kind_donation|medical_supply|nfi_consignment`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing special handling requirements such as fragile goods, keep upright, protect from moisture, security escort required, or priority unloading for emergency relief supplies.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled transport (cold chain) for medical supplies, vaccines, or perishable goods.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum allowed temperature in Celsius for temperature-controlled shipments, ensuring cold chain integrity for vaccines and medical supplies.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum required temperature in Celsius for temperature-controlled shipments, ensuring cold chain integrity for vaccines and medical supplies.',
    `total_cargo_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipment cargo in cubic meters, used for warehouse space planning and freight costing for volumetric shipments.',
    `total_cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment cargo in kilograms, including packaging and pallets, used for freight costing and capacity planning.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this shipment: sea freight for ocean containers, air freight for urgent relief supplies, road transport for last-mile delivery, rail transport for overland corridors, or multimodal for combined methods.. Valid values are `sea_freight|air_freight|road_transport|rail_transport|multimodal`',
    `vaccine_shipment_flag` BOOLEAN COMMENT 'Whether this shipment contains vaccines requiring cold chain',
    `vvm_status_at_arrival` TIMESTAMP COMMENT 'VVM stage recorded at arrival.',
    `vvm_status_at_departure` TIMESTAMP COMMENT 'VVM stage recorded at departure.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Master record for international and domestic commodity shipments including sea freight, air freight, and road transport consignments. Captures shipment reference, origin country/port, destination country/port/warehouse, transport mode, carrier/freight forwarder, container/vehicle details, bill of lading or airway bill number, estimated and actual departure/arrival dates, customs clearance status and documentation (import permits, phytosanitary certificates, exemption letters), duty/tax exemption reference, and total cargo weight/volume. Supports pipeline tracking for pre-positioned emergency stocks, customs broker coordination, and import compliance for humanitarian duty-free privileges under host government agreements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` (
    `framework_agreement_id` BIGINT COMMENT 'Unique identifier for the framework agreement record. Primary key.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Framework agreements are managed in contract management systems. System tracking supports compliance audits, contract lifecycle visibility, and integration with procurement platforms for call-off orde',
    `country_office_id` BIGINT COMMENT 'Reference to the country office or field office that established and manages this framework agreement.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Long-term procurement agreements exceeding donor thresholds require pre-approval and compliance with donor procurement regulations. Real business process: donor notification and approval workflow.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Long-term procurement agreements with partner organizations for recurring supplies (e.g., consortium arrangements, local sourcing commitments). Links framework terms to partnership agreements, validat',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or procurement officer responsible for managing this framework agreement and approving call-off orders.',
    `user_account_id` BIGINT COMMENT 'Reference to the user who created this framework agreement record in the system. Audit trail field.',
    `renewed_framework_agreement_id` BIGINT COMMENT 'Self-referencing FK on framework_agreement (renewed_framework_agreement_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the pre-qualified vendor with whom this Long-Term Agreement (LTA) or framework contract is established.',
    `agreement_number` STRING COMMENT 'Externally-known unique reference number for this Long-Term Agreement (LTA) or blanket purchase agreement. Used in procurement documentation and call-off orders.. Valid values are `^[A-Z]{2,4}-[A-Z]{3}-d{4}-d{3,5}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the framework agreement. Active agreements enable emergency purchase orders within 24-72 hours without full competitive bidding. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Active|Suspended|Expired|Terminated|Renewed — 7 candidates stripped; promote to reference product]',
    `agreement_title` STRING COMMENT 'Descriptive title or name of the framework agreement, typically indicating the commodity categories or services covered.',
    `agreement_type` STRING COMMENT 'Classification of the framework agreement type. LTA = Long-Term Agreement for recurring commodity procurement; Blanket Purchase Agreement = pre-negotiated terms for multiple call-offs; Framework Contract = multi-supplier arrangement; Standing Offer = vendor commitment to supply at agreed terms; Indefinite Delivery Contract = flexible quantity and delivery schedule; Master Service Agreement = overarching service terms.. Valid values are `LTA|Blanket Purchase Agreement|Framework Contract|Standing Offer|Indefinite Delivery Contract|Master Service Agreement`',
    `approval_date` DATE COMMENT 'Date when the framework agreement was formally approved and authorized for use.',
    `call_off_mechanism` STRING COMMENT 'Agreed method or process for placing call-off orders against this framework agreement (e.g., formal purchase order, email request, vendor portal).. Valid values are `Purchase Order|Email Request|Online Portal|Phone Order|Automated Replenishment|EDI Transaction`',
    `commodity_categories` STRING COMMENT 'Comma-separated list of commodity categories or Non-Food Item (NFI) types covered under this framework agreement (e.g., Shelter Materials, WASH Supplies, Medical Supplies, Emergency Relief Commodities).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this framework agreement record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this framework agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard delivery lead time in days from call-off order placement to delivery at destination, as agreed in the framework contract. Critical for emergency response planning.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Pre-negotiated discount percentage off vendor catalog prices, if applicable. Null if pricing structure is not discount-based.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this framework agreement and associated call-off orders must be reported to donors for transparency and accountability. True if donor reporting is required.',
    `effective_end_date` DATE COMMENT 'Date when the framework agreement expires and no further call-off orders can be placed. Nullable for open-ended agreements subject to periodic review.',
    `effective_start_date` DATE COMMENT 'Date when the framework agreement becomes binding and call-off orders can be placed against it.',
    `emergency_delivery_lead_time_days` STRING COMMENT 'Expedited delivery lead time in days for emergency call-off orders, typically 24-72 hours for humanitarian rapid-response procurement.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the framework agreement, indicating countries, regions, or field offices where the vendor can deliver under this LTA. Comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `incoterm` STRING COMMENT 'Standard Incoterm defining the division of costs and risks between vendor and buyer for delivery under this framework agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this framework agreement record was last updated. Audit trail field.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent vendor performance review conducted for this framework agreement.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity per single call-off order as stipulated in the framework agreement. Null if no maximum applies.',
    `maximum_order_value` DECIMAL(18,2) COMMENT 'Maximum cumulative monetary value of all call-off orders that can be placed against this framework agreement over its validity period. Null if no ceiling applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity per call-off order as stipulated in the framework agreement. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational guidance related to this framework agreement.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Agreed payment terms for call-off orders under this framework agreement (e.g., Net 30, Net 60, Advance Payment, Letter of Credit, Progress Payments).',
    `performance_rating` STRING COMMENT 'Overall performance rating of the vendor under this framework agreement based on delivery timeliness, quality, and compliance. Updated periodically through performance reviews.. Valid values are `Excellent|Good|Satisfactory|Needs Improvement|Unsatisfactory`',
    `pricing_structure` STRING COMMENT 'Agreed pricing or discount structure mechanism for commodities under this framework agreement. Determines how unit costs are calculated for call-off orders.. Valid values are `Fixed Unit Price|Tiered Discount|Volume-Based Discount|Cost Plus Fixed Fee|Market Price Adjustment|Negotiated Rate Card`',
    `quality_standards` STRING COMMENT 'Quality certification or compliance standards required for commodities supplied under this framework agreement (e.g., ISO 9001, GMP, Sphere-compliant, WHO Prequalification).',
    `renewal_option_count` STRING COMMENT 'Number of renewal periods available under the framework agreement terms. Null if no renewal options exist.',
    `renewal_terms` STRING COMMENT 'Conditions and process for renewing or extending the framework agreement beyond the initial validity period. May include automatic renewal clauses or renegotiation requirements.',
    `sole_source_justification` STRING COMMENT 'Documentation and rationale for sole-source or limited-competition procurement if this framework agreement was not established through full competitive bidding. Required for 2 CFR 200 compliance.',
    `termination_clause` STRING COMMENT 'Conditions under which either party may terminate the framework agreement prior to the effective end date (e.g., for cause, for convenience, notice period requirements).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for termination of the framework agreement by either party.',
    `total_orders_placed` STRING COMMENT 'Cumulative count of call-off purchase orders placed against this framework agreement since effective start date. Used for utilization tracking.',
    `total_value_utilized` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all call-off orders placed against this framework agreement. Tracked against maximum order value ceiling.',
    `validity_period_months` STRING COMMENT 'Duration of the framework agreement in months from effective start date. Typical humanitarian LTAs range from 12 to 36 months.',
    CONSTRAINT pk_framework_agreement PRIMARY KEY(`framework_agreement_id`)
) COMMENT 'Master record for Long-Term Agreements (LTAs), blanket purchase agreements, and framework contracts established with pre-qualified vendors for recurring commodity procurement. Captures agreement reference number, vendor, commodity categories covered, agreed pricing/discount structure, validity period, maximum order value, geographic scope, call-off mechanism, and renewal terms. Critical for humanitarian rapid-response procurement where pre-negotiated LTAs enable emergency purchase orders within 24-72 hours without full competitive bidding. Supports 2 CFR 200 sole-source justification documentation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`bid` (
    `bid_id` BIGINT COMMENT 'Unique identifier for this bid submission record. Primary key.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to the Request for Quotation for which this bid was submitted.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor organization that submitted this bid.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary value of the vendors bid or quotation for the goods/services specified in the RFQ.',
    `awarded_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether this bid was awarded the contract. Only one bid per RFQ should have awarded_flag = True.',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid: submitted (received), under_evaluation (being scored), responsive (meets requirements), non_responsive (disqualified), awarded (won contract), not_awarded (lost), withdrawn (vendor withdrew).',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the bid amount (e.g., USD, EUR, GBP).',
    `financial_score` DECIMAL(18,2) COMMENT 'Score assigned during financial evaluation of the bid based on pricing competitiveness and value for money.',
    `rank` STRING COMMENT 'Ranking position of this bid among all responsive bids for the RFQ, based on total_score (1 = highest ranked).',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the bid was rejected or deemed non-responsive (e.g., late submission, missing documents, failed technical requirements, price exceeds budget).',
    `submission_date` TIMESTAMP COMMENT 'Date and time when the vendor submitted their bid or quotation, must be before the RFQ submission deadline.',
    `technical_score` DECIMAL(18,2) COMMENT 'Score assigned during technical evaluation of the bid based on quality, specifications compliance, and vendor capability.',
    `total_score` DECIMAL(18,2) COMMENT 'Combined weighted score from technical and financial evaluation, used for final bid ranking and award decision.',
    `validity_days` STRING COMMENT 'Number of days from submission date during which the vendor commits to honor the quoted price and terms.',
    CONSTRAINT pk_bid PRIMARY KEY(`bid_id`)
) COMMENT 'This association product represents the Bid or Quotation submitted by a vendor in response to a Request for Quotation (RFQ). It captures the complete bid submission including pricing, technical proposal, evaluation scores, and award decision. Each record links one RFQ to one vendor with attributes that exist only in the context of this specific bid submission. Essential for procurement audit trails, competitive bidding transparency, and donor compliance reporting per 2 CFR 200 procurement standards.. Existence Justification: In humanitarian procurement operations, RFQs are issued to multiple vendors during competitive bidding processes, and each vendor submits a formal bid with pricing, technical proposals, and delivery terms. The business actively manages each bid submission through evaluation scoring, ranking, and award decisions. This is not a simple reference but an operational business entity that procurement officers create, evaluate, and audit for donor compliance per 2 CFR 200 standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` (
    `supply_distribution_line_id` BIGINT COMMENT 'Primary key for supply_distribution_line',
    `batch_lot_id` BIGINT COMMENT 'FK to the batch/lot for this distribution line.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the commodity master catalog. Identifies which specific commodity is being dispatched on this line.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to the parent distribution order. Each line item belongs to exactly one distribution order.',
    `distribution_plan_line_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan_line. Business justification: distribution_plan_line captures planned commodity quantities per distribution plan. supply_distribution_line captures actual dispatch quantities. Adding distribution_plan_line_id to supply_distributio',
    `field_distribution_line_id` BIGINT COMMENT 'Unique identifier for this distribution order line item. Primary key for the association.',
    `waybill_id` BIGINT COMMENT 'Foreign key linking to supply.waybill. Business justification: supply_distribution_line tracks commodity dispatch and receipt at the line level. waybill is the transport document accompanying the shipment. Adding waybill_id to supply_distribution_line links each ',
    `batch_number` STRING COMMENT 'Manufacturer or warehouse batch/lot number for the commodity dispatched on this line. Critical for traceability, recalls, and quality control. Identified in detection phase relationship data.',
    `condition_on_dispatch` STRING COMMENT 'Physical condition assessment of the commodity at the time of dispatch from the warehouse.',
    `condition_on_receipt` STRING COMMENT 'Physical condition assessment of the commodity upon receipt at the destination distribution point. Used to identify damage during transport.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for the commodity batch dispatched on this line. Essential for perishable goods, medical supplies, and food commodities. Identified in detection phase relationship data.',
    `line_number` STRING COMMENT 'Sequential line number within the distribution order for human reference and sorting (e.g., line 1, line 2). Identified in detection phase relationship data.',
    `line_status` STRING COMMENT 'Current status of this distribution line item tracking its progression through the distribution lifecycle.',
    `line_total_value` DECIMAL(18,2) COMMENT 'Total monetary value of this line item, calculated as quantity_dispatched × unit_value. Used for distribution order valuation and donor reporting. Identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Free-text notes specific to this line item, such as special handling instructions, quality observations, or discrepancy explanations.',
    `quantity_discrepancy` DECIMAL(18,2) COMMENT 'Difference between quantity_dispatched and quantity_received (dispatched minus received). Positive values indicate shortages, negative values indicate overages. Triggers investigation and reconciliation. Identified in detection phase relationship data.',
    `quantity_dispatched` DECIMAL(18,2) COMMENT 'Quantity of this commodity dispatched from the warehouse on this line, measured in the commoditys standard unit of measure. Identified in detection phase relationship data.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Actual quantity of this commodity received at the destination distribution point, as confirmed by receiving personnel. Used to identify losses, damages, or discrepancies during transport. Identified in detection phase relationship data.',
    `storage_location_code` STRING COMMENT 'Specific warehouse bin, shelf, or storage location code from which this commodity was picked for dispatch. Supports warehouse operations and inventory accuracy.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this line (e.g., kg, liters, pieces, cartons). Should match the commoditys standard UOM but captured here for line-level clarity. Identified in detection phase relationship data.',
    `unit_value` DECIMAL(18,2) COMMENT 'Monetary value per unit of the commodity on this line, used for inventory valuation and financial reporting. May vary by batch or procurement source. Identified in detection phase relationship data.',
    `vvm_status_at_distribution` TIMESTAMP COMMENT 'VVM stage at time of distribution.',
    CONSTRAINT pk_supply_distribution_line PRIMARY KEY(`supply_distribution_line_id`)
) COMMENT 'SSOT for supply-chain distribution line items tracking commodity dispatch, receipt, and logistics from warehouse to distribution point. Distinct from field.field_distribution_line which captures field-level operational distribution to beneficiaries.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique system identifier for this purchase order line item. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the specific commodity being procured on this line',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to the parent purchase order document',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order (1, 2, 3...). Used for human reference and document display order.',
    `line_status` STRING COMMENT 'Current fulfillment status of this purchase order line (pending, approved, ordered, partially_received, fully_received, cancelled). Tracks line-level receipt progress.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total amount for this line (quantity_ordered × unit_price). Contributes to purchase_order.subtotal_amount.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of the commodity ordered on this line, expressed in the commoditys standard unit of measure.',
    `quantity_outstanding` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received (quantity_ordered - quantity_received). Drives open PO reporting and follow-up with vendors.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of this commodity actually received against this line. Updated by goods receipt notes (GRN). Used for three-way matching.',
    `requested_delivery_date` DATE COMMENT 'Program-requested delivery date for this specific commodity line. May differ from other lines on the same PO due to urgency or program schedules.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for this line (e.g., EA, KG, BOX, PALLET). Typically matches commodity.unit_of_measure but captured at line level for procurement flexibility.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for this commodity on this purchase order. Vendor-specific and time-specific pricing.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'This association product represents the line-item detail of procurement purchase orders, capturing the specific commodities ordered on each PO. Each record links one purchase order to one commodity with line-specific quantities, pricing, delivery schedules, and receipt tracking. This is the operational record that procurement officers create when building multi-line purchase orders and that warehouse staff update when receiving shipments.. Existence Justification: In humanitarian procurement operations, purchase orders routinely contain multiple commodity line items (medical supplies, shelter materials, WASH items on a single PO), and each commodity appears across many purchase orders over time as programs continuously procure relief items. Procurement officers actively manage line-item details including per-line quantities, vendor pricing, delivery schedules, and receipt tracking—this is the operational record that drives three-way matching and inventory management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for supply_agreement',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the commodity being supplied under this agreement',
    `framework_agreement_id` BIGINT COMMENT 'Unique identifier for this supply agreement record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing the commodity under this agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement (active, suspended, expired, pending, terminated).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Volume or negotiated discount percentage applied by this vendor for this commodity.',
    `end_date` DATE COMMENT 'Expiration or end date of this supply agreement. May be null for open-ended agreements.',
    `last_supply_date` DATE COMMENT 'Most recent date when this vendor successfully delivered this commodity. Tracks relationship history.',
    `lead_time_days` STRING COMMENT 'Number of days from purchase order to delivery for this commodity from this specific vendor. Vendor-specific performance metric.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from this vendor for this commodity. Vendor-specific commercial term.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance score (0.00 to 5.00) for this vendor supplying this specific commodity, based on quality, timeliness, and compliance. Relationship-specific metric.',
    `prequalification_date` DATE COMMENT 'Date when this vendor was prequalified to supply this specific commodity. Relationship-specific approval date.',
    `quality_certification` STRING COMMENT 'Specific quality certifications or compliance documentation provided by this vendor for this commodity (e.g., GMP, ISO, SPHERE compliance certificates).',
    `start_date` DATE COMMENT 'Effective start date of this supply agreement between the vendor and commodity.',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure for this commodity from this specific vendor. Varies by vendor-commodity combination.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'SSOT for commodity supply agreements with vendors covering pricing, lead times, quality certifications, and procurement terms under framework agreements. Distinct from partnership.partnership_agreement which governs programmatic IP partnerships.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` (
    `distribution_plan_line_id` BIGINT COMMENT 'Unique identifier for this distribution plan line item. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the specific commodity included in this distribution plan.',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to the distribution plan that includes this commodity line item.',
    `allocation_status` STRING COMMENT 'Current status of inventory allocation for this commodity line item, tracking whether planned quantities have been reserved from warehouse stock.',
    `commodity_category` STRING COMMENT 'Primary category of commodities included in this distribution plan. NFI (Non-Food Item), food, medical supplies, WASH (Water Sanitation and Hygiene), shelter materials, education kits, or protection items. [Moved from distribution_plan: This attribute in distribution_plan appears to be a summary/denormalized field. The actual commodity category should be retrieved from the commodity master via the distribution_plan_line association. If a plan includes multiple commodity categories, this single-valued field cannot accurately represent the reality.] [ENUM-REF-CANDIDATE: nfi|food|medical|wash|shelter|education|protection — 7 candidates stripped; promote to reference product]',
    `commodity_priority` STRING COMMENT 'Priority level of this commodity within the distribution plan, indicating urgency or importance for distribution execution.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this distribution plan line item was created in the system.',
    `donor_restriction_code` STRING COMMENT 'Code indicating any donor-specific restrictions or earmarking applicable to this commodity in this distribution plan.',
    `estimated_unit_cost` DECIMAL(18,2) COMMENT 'Estimated cost per unit of this commodity for this distribution plan, used for budget planning and donor reporting.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this distribution plan line item was last updated.',
    `line_status` STRING COMMENT 'Lifecycle status of this distribution plan line item, indicating whether it is active, cancelled, or completed.',
    `quantity_planned` DECIMAL(18,2) COMMENT 'Planned quantity of this commodity to be distributed under this plan, expressed in the commoditys unit of measure.',
    `total_commodity_items` STRING COMMENT 'Total number of distinct commodity line items included in this distribution plan. [Moved from distribution_plan: This is a derived count that should be calculated from the number of distribution_plan_line records associated with the plan, not stored redundantly in the plan header.]',
    `total_estimated_value` DECIMAL(18,2) COMMENT 'Total estimated value of this line item (quantity_planned × estimated_unit_cost), contributing to overall distribution plan budget.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned quantity (e.g., pieces, kg, liters, boxes). Should align with commodity master unit of measure.',
    CONSTRAINT pk_distribution_plan_line PRIMARY KEY(`distribution_plan_line_id`)
) COMMENT 'This association product represents the line-item relationship between distribution plans and commodities in humanitarian supply chain operations. It captures the bill of materials for each distribution event, specifying which commodities are included in each distribution plan with planned quantities, priorities, and allocation details. Each record links one distribution plan to one commodity with attributes that exist only in the context of this specific plan-commodity pairing.. Existence Justification: In humanitarian supply chain operations, distribution plans specify a bill of materials (list of commodities with quantities) for each distribution event. A single distribution plan includes multiple commodities (e.g., shelter kits, water purification tablets, blankets, food rations), and each commodity appears in multiple distribution plans across different programs, locations, and time periods. The business actively manages these plan-commodity pairings with specific quantities, priorities, allocation statuses, and cost estimates.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` (
    `commodity_supply_agreement_id` BIGINT COMMENT 'Unique identifier for this commodity supply agreement record',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the humanitarian commodity that the partner is prequalified to supply',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to the partner organization that is prequalified to supply the commodity',
    `agreement_status` STRING COMMENT 'Current status indicator for the agreement workflow state.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit_cost_agreement. Partners may quote in local currency rather than USD.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this commodity supply agreement.',
    `last_supply_date` DATE COMMENT 'Date of the most recent successful supply transaction of this commodity by this partner. Used to track active supply relationships and recency of performance.',
    `lead_time_days` STRING COMMENT 'Number of days this partner requires to deliver this commodity from order placement. Partner-specific and may differ from the commoditys standard procurement_lead_time_days.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity this partner requires for orders of this commodity. Partner-specific constraint that may differ from the commoditys standard minimum_order_quantity.',
    `notes` STRING COMMENT 'Free-text notes capturing special terms, restrictions, or conditions specific to this partner-commodity supply relationship (e.g., seasonal availability, geographic restrictions, donor preferences).',
    `performance_rating` DECIMAL(18,2) COMMENT 'Numeric performance rating (typically 0-100 or 1-5 scale) for this partners historical performance in supplying this specific commodity. Based on delivery timeliness, quality, and compliance.',
    `prequalification_date` DATE COMMENT 'Date on which the partner was prequalified to supply this commodity. Establishes the start of the supply relationship.',
    `prequalification_expiry_date` DATE COMMENT 'Date on which the prequalification expires and requires renewal or reassessment. Used to manage active supplier rosters.',
    `prequalification_status` STRING COMMENT 'Current status of the partners prequalification to supply this commodity. Controls whether the partner can be included in RFQs for this commodity.',
    `quality_certification` STRING COMMENT 'Attribute capturing the quality certification information for the commodity supply agreement entity.',
    `quality_certification_verified` BOOLEAN COMMENT 'Indicates whether the partners quality certifications for supplying this commodity have been verified and approved (e.g., ISO standards, Sphere compliance, cold chain capability).',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this commodity supply agreement.',
    `unit_cost_agreement` DECIMAL(18,2) COMMENT 'Negotiated or agreed unit cost for this commodity from this partner, used for budgeting and sourcing decisions. May differ from standard_unit_cost in the commodity master.',
    `unit_price` DECIMAL(18,2) COMMENT 'Attribute capturing the unit price information for the commodity supply agreement entity.',
    CONSTRAINT pk_commodity_supply_agreement PRIMARY KEY(`commodity_supply_agreement_id`)
) COMMENT 'This association product represents the prequalification and supply agreement between a humanitarian commodity and a partner organization. It captures the partners capacity and terms to supply specific commodities, including agreed pricing, lead times, quality certifications, and historical performance. Each record links one commodity to one partner organization with attributes that exist only in the context of this supply relationship. Used for sourcing decisions, RFQ targeting, and localization strategy in humanitarian procurement.. Existence Justification: In humanitarian supply chain operations, partner organizations are prequalified to supply specific commodities based on capacity assessments, certifications, and past performance. A single commodity (e.g., water purification tablets) can be sourced from multiple prequalified partners at different unit costs and lead times, and a single partner organization can supply multiple different commodities (e.g., WASH items, shelter materials, medical supplies). The business actively manages these supply agreements as operational records with partner-specific pricing, lead times, quality certifications, and performance ratings.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` (
    `cold_chain_equipment_id` BIGINT COMMENT 'Unique identifier for the cold chain equipment record.',
    `country_id` BIGINT COMMENT 'FK to field.country',
    `project_site_id` BIGINT COMMENT 'Reference identifier linking to the associated project site entity.',
    `warehouse_id` BIGINT COMMENT 'Reference identifier linking to the associated warehouse entity.',
    `capacity_liters` DECIMAL(18,2) COMMENT 'Net vaccine storage capacity in liters',
    `created_at` TIMESTAMP COMMENT 'Timestamp recording when the created action was performed.',
    `equipment_code` STRING COMMENT 'Unique asset code for the cold chain equipment unit',
    `equipment_type` STRING COMMENT 'Type of equipment: solar_direct_drive, ice_lined_refrigerator, cold_room, vaccine_carrier, freezer',
    `functional_status` STRING COMMENT 'Functional / Non-functional / Under_repair / Decommissioned',
    `installation_date` DATE COMMENT 'Date and time when the installation event occurred for this cold chain equipment.',
    `last_maintenance_date` DATE COMMENT 'Date and time when the last maintenance event occurred for this cold chain equipment.',
    `manufacturer` STRING COMMENT 'Attribute capturing the manufacturer information for the cold chain equipment entity.',
    `model_number` STRING COMMENT 'Count or number of model items associated with this record.',
    `net_vaccine_storage_capacity_liters` DECIMAL(18,2) COMMENT 'Net vaccine storage capacity in liters',
    `next_maintenance_due_date` DATE COMMENT 'Date and time when the next maintenance due event occurred for this cold chain equipment.',
    `power_source` STRING COMMENT 'Power source: solar, electric, gas, kerosene, passive',
    `pqs_code` STRING COMMENT 'WHO Performance Quality and Safety (PQS) prequalification code',
    `serial_number` STRING COMMENT 'Count or number of serial items associated with this record.',
    `cold_chain_equipment_status` STRING COMMENT 'Operational status: functioning, needs_repair, decommissioned',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Attribute capturing the temperature range max celsius information for the cold chain equipment entity.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Attribute capturing the temperature range min celsius information for the cold chain equipment entity.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp recording when the updated action was performed.',
    `who_pqs_code` STRING COMMENT 'WHO Performance Quality and Safety (PQS) prequalification code',
    CONSTRAINT pk_cold_chain_equipment PRIMARY KEY(`cold_chain_equipment_id`)
) COMMENT 'Cold chain equipment asset tracking for vaccine and temperature-sensitive commodity storage (e.g., solar refrigerators, cold rooms, vaccine carriers). Source systems: UNICEF Cold Chain Equipment Manager, WHO PQS catalogue.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`batch_lot` (
    `batch_lot_id` BIGINT COMMENT 'Unique identifier for the batch lot record.',
    `commodity_id` BIGINT COMMENT 'Reference identifier linking to the associated commodity entity.',
    `goods_receipt_id` BIGINT COMMENT 'Reference identifier linking to the associated goods receipt entity.',
    `warehouse_id` BIGINT COMMENT 'Reference identifier linking to the associated warehouse entity.',
    `batch_number` STRING COMMENT 'Manufacturer batch/lot number',
    `country_of_origin` STRING COMMENT 'Attribute capturing the country of origin information for the batch lot entity.',
    `created_at` TIMESTAMP COMMENT 'Timestamp recording when the created action was performed.',
    `disposal_date` DATE COMMENT 'Date and time when the disposal event occurred for this batch lot.',
    `disposal_reason` STRING COMMENT 'Attribute capturing the disposal reason information for the batch lot entity.',
    `expiry_date` DATE COMMENT 'Expiration date of the batch',
    `is_expired_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the is expired condition applies.',
    `manufacture_date` DATE COMMENT 'Date and time when the manufacture event occurred for this batch lot.',
    `manufacturer_name` STRING COMMENT 'Human-readable name or label for the manufacturer.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Attribute capturing the quantity received information for the batch lot entity.',
    `quantity_remaining` DECIMAL(18,2) COMMENT 'Attribute capturing the quantity remaining information for the batch lot entity.',
    `storage_temperature_requirement` STRING COMMENT 'Required storage temperature range',
    `unit_of_measure` STRING COMMENT 'Attribute capturing the unit of measure information for the batch lot entity.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp recording when the updated action was performed.',
    `vvm_stage` STRING COMMENT 'Vaccine Vial Monitor stage at receipt: vvm1, vvm2, vvm3, vvm4',
    `vvm_stage_on_receipt` STRING COMMENT 'Vaccine Vial Monitor stage on receipt (1-4, 1=good, 4=discard)',
    `who_pq_reference` STRING COMMENT 'WHO PQ listing reference number',
    `who_pq_status` STRING COMMENT 'WHO Prequalification status: prequalified, pending, not_applicable, withdrawn',
    CONSTRAINT pk_batch_lot PRIMARY KEY(`batch_lot_id`)
) COMMENT 'Batch/lot tracking for commodities, particularly vaccines and pharmaceuticals, including expiry management and WHO prequalification status.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` (
    `temperature_excursion_id` BIGINT COMMENT 'Unique identifier for the temperature excursion record.',
    `batch_lot_id` BIGINT COMMENT 'Reference identifier linking to the associated batch lot entity.',
    `cold_chain_equipment_id` BIGINT COMMENT 'Reference identifier linking to the associated cold chain equipment entity.',
    `warehouse_id` BIGINT COMMENT 'Reference identifier linking to the associated warehouse entity.',
    `action_taken` STRING COMMENT 'Corrective action: disposed, quarantined, redistributed, continued_use',
    `cause` STRING COMMENT 'Root cause: power_failure / door_left_open / equipment_malfunction / transport_delay',
    `commodities_affected_quantity` DECIMAL(18,2) COMMENT 'Attribute capturing the commodities affected quantity information for the temperature excursion entity.',
    `commodity_disposition` STRING COMMENT 'Outcome: usable / quarantined / discarded',
    `created_at` TIMESTAMP COMMENT 'Timestamp recording when the created action was performed.',
    `duration_minutes` STRING COMMENT 'Attribute capturing the duration minutes information for the temperature excursion entity.',
    `excursion_end_timestamp` TIMESTAMP COMMENT 'Date and time when the excursion end event occurred for this temperature excursion.',
    `excursion_start_timestamp` TIMESTAMP COMMENT 'Date and time when the excursion start event occurred for this temperature excursion.',
    `excursion_type` STRING COMMENT 'Type: heat_exposure, freeze_exposure, power_failure, door_open, equipment_malfunction',
    `is_commodity_compromised` BOOLEAN COMMENT 'Boolean indicator specifying whether the record commodity compromised.',
    `max_temperature_celsius` DECIMAL(18,2) COMMENT 'Attribute capturing the max temperature celsius information for the temperature excursion entity.',
    `min_temperature_celsius` DECIMAL(18,2) COMMENT 'Attribute capturing the min temperature celsius information for the temperature excursion entity.',
    `reported_by` STRING COMMENT 'Reference to the user or entity that performed the reported action.',
    `reported_by_staff_name` STRING COMMENT 'Name of staff who reported',
    `root_cause` STRING COMMENT 'Attribute capturing the root cause information for the temperature excursion entity.',
    `severity` STRING COMMENT 'Severity classification: minor, moderate, critical',
    `updated_at` TIMESTAMP COMMENT 'Timestamp recording when the updated action was performed.',
    `vvm_stage_after` STRING COMMENT 'VVM stage after excursion: vvm1, vvm2, vvm3, vvm4',
    `vvm_stage_before` STRING COMMENT 'VVM stage before excursion: vvm1, vvm2, vvm3, vvm4',
    CONSTRAINT pk_temperature_excursion PRIMARY KEY(`temperature_excursion_id`)
) COMMENT 'Temperature excursion event records for cold chain monitoring. Captures deviations from acceptable temperature ranges that may compromise vaccine/commodity integrity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` (
    `gavi_cofinancing_id` BIGINT COMMENT 'Unique identifier for the gavi cofinancing record.',
    `batch_lot_id` BIGINT COMMENT 'Reference identifier linking to the associated batch lot entity.',
    `country_id` BIGINT COMMENT 'Reference identifier linking to the associated country entity.',
    `country_office_id` BIGINT COMMENT 'Reference identifier linking to the associated country office entity.',
    `commodity_id` BIGINT COMMENT 'Reference identifier linking to the associated gavi commodity entity.',
    `gavi_vaccine_commodity_id` BIGINT COMMENT 'Vaccine commodity',
    `cofinancing_group` STRING COMMENT 'Attribute capturing the cofinancing group information for the gavi cofinancing entity.',
    `cofinancing_obligation_usd` DECIMAL(18,2) COMMENT 'Country co-financing obligation amount in USD',
    `cofinancing_paid_usd` DECIMAL(18,2) COMMENT 'Amount actually paid by country',
    `cofinancing_phase` STRING COMMENT 'Phase (initial self-financing, preparatory transition, accelerated transition, fully self-financing)',
    `cofinancing_rate_percent` DECIMAL(18,2) COMMENT 'Attribute capturing the cofinancing rate percent information for the gavi cofinancing entity.',
    `cofinancing_reference` STRING COMMENT 'Attribute capturing the cofinancing reference information for the gavi cofinancing entity.',
    `cofinancing_status` STRING COMMENT 'Current status indicator for the cofinancing workflow state.',
    `country_share_amount` DECIMAL(18,2) COMMENT 'Country co-financing share',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this gavi cofinancing.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `default_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the default condition applies.',
    `doses_procured` BIGINT COMMENT 'Attribute capturing the doses procured information for the gavi cofinancing entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the gavi cofinancing entity.',
    `gavi_contribution_usd` DECIMAL(18,2) COMMENT 'Gavi contribution amount in USD',
    `gavi_phase` STRING COMMENT 'Gavi support phase: initial_self_financing / preparatory_transition / accelerated_transition / fully_self_financing',
    `gavi_share_amount` DECIMAL(18,2) COMMENT 'Gavi share',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this gavi cofinancing.',
    `notes` STRING COMMENT 'Additional notes',
    `payment_date` DECIMAL(18,2) COMMENT 'Date co-financing payment was made',
    `payment_due_date` DECIMAL(18,2) COMMENT 'Date and time when the payment due event occurred for this gavi cofinancing.',
    `payment_received_date` DECIMAL(18,2) COMMENT 'Date and time when the payment received event occurred for this gavi cofinancing.',
    `payment_status` DECIMAL(18,2) COMMENT 'Paid / Partially_paid / Overdue / Waived',
    `price_per_dose_usd` DECIMAL(18,2) COMMENT 'Weighted average price per dose',
    `gavi_cofinancing_status` STRING COMMENT 'Current status indicator for the gavi cofinancing workflow state.',
    `total_procurement_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the total procurement quantity or measurement.',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this gavi cofinancing.',
    `vaccine_name` STRING COMMENT 'Human-readable name or label for the vaccine.',
    CONSTRAINT pk_gavi_cofinancing PRIMARY KEY(`gavi_cofinancing_id`)
) COMMENT 'Gavi co-financing tracking for vaccine procurement';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` (
    `vaccine_vial_monitor_state_id` BIGINT COMMENT 'Unique identifier for the vaccine vial monitor state record.',
    `batch_lot_id` BIGINT COMMENT 'FK to supply.batch_lot',
    `cold_chain_equipment_id` BIGINT COMMENT 'Foreign key linking to supply.cold_chain_equipment. Business justification: vaccine_vial_monitor_state records VVM observations (heat exposure stages 1-4) for vaccines. These observations are made at specific cold chain equipment locations (refrigerators, freezers, cold boxes',
    `action_taken` STRING COMMENT 'Action: none / prioritize_use / quarantine / discard',
    `active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the active condition applies.',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `vaccine_vial_monitor_state_description` STRING COMMENT 'Human readable description of the VVM stage and usability guidance.',
    `discard_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the discard condition applies.',
    `heat_exposure_level` STRING COMMENT 'Attribute capturing the heat exposure level information for the vaccine vial monitor state entity.',
    `is_usable` BOOLEAN COMMENT 'Whether vaccine at this VVM stage may still be used.',
    `location_type` STRING COMMENT 'Where observed: warehouse / health_facility / outreach_site / in_transit',
    `notes` STRING COMMENT 'Additional observation notes',
    `observation_date` DATE COMMENT 'Date VVM was observed',
    `observer_staff_name` STRING COMMENT 'Staff who observed VVM',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Number of vials at this VVM stage',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last-updated timestamp.',
    `usable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the usable condition applies.',
    `vaccine_vial_monitor_code` BIGINT COMMENT 'Primary key',
    `vvm_stage` STRING COMMENT 'VVM stage number (1-4) indicating heat exposure of the vaccine vial.',
    `vvm_stage_code` STRING COMMENT 'Enum value: VVM1, VVM2, VVM3, VVM4.',
    `vvm_stage_description` STRING COMMENT 'Detailed textual description providing context about the vvm stage.',
    `vvm_stage_name` STRING COMMENT 'Human-readable name or label for the vvm stage.',
    CONSTRAINT pk_vaccine_vial_monitor_state PRIMARY KEY(`vaccine_vial_monitor_state_id`)
) COMMENT 'Reference/enum lookup of vaccine vial monitor (VVM) stages 1-4 indicating cumulative heat exposure and usability of vaccine vials.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` (
    `gavi_cofinancing_tracking_id` BIGINT COMMENT 'Unique identifier for the gavi cofinancing tracking record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `commodity_id` BIGINT COMMENT 'Reference identifier linking to the associated commodity entity.',
    `country_id` BIGINT COMMENT 'Reference identifier linking to the associated country entity.',
    `gavi_cofinancing_id` BIGINT COMMENT 'Foreign key linking to supply.gavi_cofinancing. Business justification: gavi_cofinancing_tracking records payment obligations and tracking data for Gavi co-financing arrangements. gavi_cofinancing is the master co-financing record. Adding gavi_cofinancing_id to gavi_cofin',
    `cofinancing_currency` STRING COMMENT 'Attribute capturing the cofinancing currency information for the gavi cofinancing tracking entity.',
    `cofinancing_obligation_amount` DECIMAL(18,2) COMMENT 'Country co-financing obligation in USD',
    `cofinancing_paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by country',
    `compliance_status` STRING COMMENT 'Gavi compliance: compliant, non_compliant, under_review',
    `country_cofinanced_doses` DECIMAL(18,2) COMMENT 'Attribute capturing the country cofinanced doses information for the gavi cofinancing tracking entity.',
    `created_at` TIMESTAMP COMMENT 'Timestamp recording when the created action was performed.',
    `default_count` STRING COMMENT 'Number of consecutive co-financing defaults',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the gavi cofinancing tracking entity.',
    `gavi_funded_doses` DECIMAL(18,2) COMMENT 'Attribute capturing the gavi funded doses information for the gavi cofinancing tracking entity.',
    `gavi_phase` STRING COMMENT 'Country phase: initial_self_financing, preparatory_transition, accelerated_transition, fully_self_financing',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the gavi cofinancing tracking entity.',
    `payment_status` DECIMAL(18,2) COMMENT 'Status: paid, partial, overdue, defaulted, waived',
    `price_per_dose_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the price per dose usd information for the gavi cofinancing tracking entity.',
    `procurement_mechanism` STRING COMMENT 'UNICEF_SD, PAHO_revolving_fund, self_procurement',
    `total_doses_procured` DECIMAL(18,2) COMMENT 'Attribute capturing the total doses procured information for the gavi cofinancing tracking entity.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp recording when the updated action was performed.',
    `vaccine_type` STRING COMMENT 'Vaccine programme: pentavalent, pneumococcal, rotavirus, measles, hpv, etc.',
    CONSTRAINT pk_gavi_cofinancing_tracking PRIMARY KEY(`gavi_cofinancing_tracking_id`)
) COMMENT 'Gavi Alliance co-financing tracking for vaccine procurement. Tracks country co-financing obligations, payments, and compliance with Gavi graduation thresholds.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`supply_category` (
    `supply_category_id` BIGINT COMMENT 'Primary key for supply_category',
    `parent_category_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent supply category, enabling a hierarchical commodity taxonomy (e.g., Oral Rehydration Salts rolls up to Medical Supplies). Null for top-level categories.',
    `parent_supply_category_id` BIGINT COMMENT 'Self-referencing FK on supply_category (parent_supply_category_id)',
    `average_unit_volume_m3` DECIMAL(18,2) COMMENT 'Average volume per standard unit of measure in cubic metres. Used for warehouse space planning, container load calculations, and freight volume estimation.',
    `average_unit_weight_kg` DECIMAL(18,2) COMMENT 'Average gross weight per standard unit of measure in kilograms. Used for freight cost estimation, cargo manifest preparation, and logistics planning in WFP LESS and UNICEF Supply Division systems.',
    `budget_line_code` STRING COMMENT 'Donor or organizational budget line code associated with this supply category for financial planning, expenditure tracking, and donor reporting. Maps to programme budget structures in SAP and eTools.',
    `category_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the supply category, aligned with ICON procurement commodity codes and SAP MM material group codes (e.g., MED-001, WASH-003). Used as the primary lookup key across procurement and logistics systems.',
    `category_description` STRING COMMENT 'Detailed narrative description of the supply category, including the types of items it encompasses, intended use in humanitarian operations, and any scope boundaries.',
    `category_name` STRING COMMENT 'Human-readable name of the supply category (e.g., Medical Supplies, WASH Equipment, Food Commodities). Used in procurement documents, donor reports, and logistics manifests.',
    `category_short_name` STRING COMMENT 'Abbreviated display name for the supply category used in dashboards, reports, and space-constrained UI elements (e.g., MED, WASH, FOOD).',
    `category_status` STRING COMMENT 'Current lifecycle status of the supply category record: active (in use for procurement), inactive (suspended), phased_out (retired from use), or under_review (pending reclassification or update).',
    `category_type` STRING COMMENT 'Broad classification of the supply category by nature of the item: commodity (bulk goods), service (contracted services), equipment (durable assets), consumable (single-use items), or non_food_item (NFI). Drives procurement rules and asset management treatment.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether items in this supply category require temperature-controlled cold chain storage and transport (True), such as vaccines, blood products, or certain pharmaceuticals. Triggers cold chain logistics planning and monitoring requirements.',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether items in this category are classified as controlled substances (e.g., narcotic pharmaceuticals, dual-use chemicals) requiring special import permits, chain-of-custody documentation, and regulatory compliance under national and international law.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply category record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `customs_duty_exempt_flag` BOOLEAN COMMENT 'Indicates whether items in this category are eligible for customs duty exemption under host country agreements, UN privileges and immunities, or humanitarian exemption frameworks. Drives customs documentation requirements.',
    `effective_from_date` DATE COMMENT 'Date from which this supply category record is valid and available for use in procurement transactions. Supports temporal validity management in SAP MM and ICON procurement.',
    `effective_to_date` DATE COMMENT 'Date after which this supply category record is no longer valid for new procurement transactions. Null indicates an open-ended validity period. Supports category lifecycle management.',
    `gl_account_code` STRING COMMENT 'SAP General Ledger account code to which procurement expenditure for this supply category is posted. Ensures correct financial coding for donor fund accounting, budget monitoring, and IPSAS-compliant financial statements.',
    `harmonized_system_code` STRING COMMENT 'World Customs Organization Harmonized System (HS) tariff code for the supply category, used for customs clearance, import/export documentation, and duty exemption applications in humanitarian operations.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether items in this category are classified as hazardous materials (HAZMAT) under IATA/IMDG/ADR regulations, requiring special packaging, labelling, transport documentation, and handling procedures.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this category within the commodity taxonomy hierarchy. Level 1 = top-level segment, Level 2 = family, Level 3 = class, Level 4 = commodity, consistent with UNSPSC hierarchy conventions.',
    `hierarchy_path` STRING COMMENT 'Full materialized path string representing the categorys position in the taxonomy tree (e.g., Supplies > Medical > Pharmaceuticals > Antibiotics). Facilitates roll-up reporting without recursive queries.',
    `import_license_required_flag` BOOLEAN COMMENT 'Indicates whether items in this category require an import license or permit from host country authorities prior to shipment. Triggers pre-clearance workflow in ICON procurement and logistics planning.',
    `inspection_standard` STRING COMMENT 'Reference to the applicable quality inspection standard or specification for items in this category (e.g., ISO 2859-1, WHO GMP, UNICEF Supply Division Technical Specification). Used to guide procurement quality assurance activities.',
    `interagency_standard_flag` BOOLEAN COMMENT 'Indicates whether this supply category is covered by an inter-agency standard item catalogue (e.g., IAPSO, UNICEF Supply Division catalogue, WFP standard items). Enables cross-agency procurement collaboration and joint procurement initiatives.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply category record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental data loads, and audit compliance.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in calendar days from purchase order issuance to delivery at the designated delivery point for items in this category. Used for supply planning, reorder point calculation, and emergency response preparedness.',
    `long_term_agreement_eligible_flag` BOOLEAN COMMENT 'Indicates whether items in this category are eligible for procurement under a Long-Term Agreement (LTA) or framework contract, enabling faster procurement and volume discounts. Drives LTA establishment decisions in ICON procurement.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum number of days of remaining shelf life required at the time of receipt or delivery for items in this category. Items not meeting this threshold are rejected. Standard procurement quality control requirement.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, procurement guidance, or special handling instructions relevant to this supply category. Not used for structured data; intended for human-readable supplementary information.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether items in this category have a limited shelf life and are subject to expiry management, FEFO (First Expired First Out) stock rotation, and disposal protocols.',
    `procurement_category` STRING COMMENT 'High-level procurement classification distinguishing goods, works, services, or consultancy. Determines applicable procurement rules, thresholds, and approval workflows under UN Financial Regulations and donor compliance requirements.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether items in this category require pre-shipment or post-receipt quality inspection by a third-party inspection agency or internal quality assurance team before acceptance.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Stock level threshold at which a replenishment order should be triggered for items in this category, expressed in the standard unit of measure. Supports SAP MM MRP and WFP LESS inventory management.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum buffer stock quantity to be maintained for items in this category to mitigate supply disruption risk, expressed in the standard unit of measure. Aligned with humanitarian pipeline management standards.',
    `secondary_unit_of_measure` STRING COMMENT 'Alternative unit of measure used for ordering, shipping, or reporting (e.g., CTN for carton, PAL for pallet). Supports unit conversion in warehouse management and logistics planning.',
    `sector` STRING COMMENT 'Humanitarian cluster or sector to which this supply category primarily belongs (e.g., Health, WASH, Nutrition, Shelter, Education, Logistics, Protection). Aligns with IASC cluster system for inter-agency coordination and donor reporting. [ENUM-REF-CANDIDATE: health|wash|nutrition|shelter|education|logistics|protection|food_security|emergency_telecommunications|camp_coordination — promote to reference product]',
    `shelf_life_days` STRING COMMENT 'Standard shelf life in days for items in this category from the date of manufacture or receipt. Used for expiry date calculation, stock rotation planning, and minimum remaining shelf life (MRSL) enforcement at point of receipt.',
    `source_system_category_id` STRING COMMENT 'Native identifier of this supply category in the originating source system (e.g., SAP MM material group key, ICON commodity code). Enables traceability and reconciliation between the lakehouse and operational systems.',
    `source_system_code` STRING COMMENT 'Code identifying the authoritative source system from which this supply category record originates (e.g., ICON for UNICEF ICON procurement, SAP_MM for SAP Materials Management, WFP_LESS for WFP Logistics Execution Support System, MANUAL for manually entered records).',
    `sphere_standard_reference` STRING COMMENT 'Reference to the applicable Sphere Handbook minimum standard or indicator for this supply category (e.g., Sphere WASH 2.1 — Water Supply). Ensures procurement quantities and specifications meet humanitarian minimum standards.',
    `standard_unit_of_measure` STRING COMMENT 'Standard unit of measure for items in this category (e.g., EA for each, KG for kilogram, L for litre, MT for metric tonne, SET for set). Aligns with SAP MM base unit of measure and ICON procurement unit codes.',
    `strategic_stock_flag` BOOLEAN COMMENT 'Indicates whether items in this category are designated as strategic pre-positioned stock for emergency response (True) or standard replenishment stock (False). Drives warehouse pre-positioning decisions and emergency release protocols.',
    `unit_conversion_factor` DECIMAL(18,2) COMMENT 'Numeric conversion factor between the standard unit of measure and the secondary unit of measure (e.g., 1 CTN = 24 EA → factor = 24.000000). Used in SAP MM unit conversion and logistics volume calculations.',
    `unspsc_code` STRING COMMENT 'Eight-digit United Nations Standard Products and Services Code (UNSPSC) classifying the supply category within the globally recognized commodity taxonomy. Mandatory for UN agency procurement compliance and donor reporting.',
    `valuation_method` STRING COMMENT 'Accounting method used to value inventory for items in this category in SAP Materials Management and financial reporting (e.g., standard_cost, moving_average, fifo, weighted_average). Impacts balance sheet valuation and donor financial reporting.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number for this supply category record, incremented on each update. Supports optimistic concurrency control and change history tracking in the Databricks Silver layer.',
    `who_essential_medicine_flag` BOOLEAN COMMENT 'Indicates whether items in this category appear on the WHO Model List of Essential Medicines. Relevant for health supply procurement prioritization, formulary management, and donor compliance in health programme supply chains.',
    CONSTRAINT pk_supply_category PRIMARY KEY(`supply_category_id`)
) COMMENT 'Master reference table for supply_category. Referenced by supply_category_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ADD CONSTRAINT `fk_supply_commodity_supply_category_id` FOREIGN KEY (`supply_category_id`) REFERENCES `vibe_ngo_v1`.`supply`.`supply_category`(`supply_category_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_bid_id` FOREIGN KEY (`bid_id`) REFERENCES `vibe_ngo_v1`.`supply`.`bid`(`bid_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `vibe_ngo_v1`.`supply`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_request_id` FOREIGN KEY (`procurement_request_id`) REFERENCES `vibe_ngo_v1`.`supply`.`procurement_request`(`procurement_request_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_ngo_v1`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supply_agreement_id` FOREIGN KEY (`supply_agreement_id`) REFERENCES `vibe_ngo_v1`.`supply`.`supply_agreement`(`supply_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inkind_donation_id` FOREIGN KEY (`inkind_donation_id`) REFERENCES `vibe_ngo_v1`.`supply`.`inkind_donation`(`inkind_donation_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_waybill_id` FOREIGN KEY (`waybill_id`) REFERENCES `vibe_ngo_v1`.`supply`.`waybill`(`waybill_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_cold_chain_equipment_id` FOREIGN KEY (`cold_chain_equipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`cold_chain_equipment`(`cold_chain_equipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cold_chain_equipment_id` FOREIGN KEY (`cold_chain_equipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`cold_chain_equipment`(`cold_chain_equipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_stock_warehouse_id` FOREIGN KEY (`stock_warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_distribution_warehouse_id` FOREIGN KEY (`distribution_warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_waybill_warehouse_id` FOREIGN KEY (`waybill_warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `vibe_ngo_v1`.`supply`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_procurement_request_id` FOREIGN KEY (`procurement_request_id`) REFERENCES `vibe_ngo_v1`.`supply`.`procurement_request`(`procurement_request_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_renewed_framework_agreement_id` FOREIGN KEY (`renewed_framework_agreement_id`) REFERENCES `vibe_ngo_v1`.`supply`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ADD CONSTRAINT `fk_supply_bid_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_ngo_v1`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ADD CONSTRAINT `fk_supply_bid_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ADD CONSTRAINT `fk_supply_supply_distribution_line_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ADD CONSTRAINT `fk_supply_supply_distribution_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ADD CONSTRAINT `fk_supply_supply_distribution_line_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ADD CONSTRAINT `fk_supply_supply_distribution_line_distribution_plan_line_id` FOREIGN KEY (`distribution_plan_line_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan_line`(`distribution_plan_line_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ADD CONSTRAINT `fk_supply_supply_distribution_line_waybill_id` FOREIGN KEY (`waybill_id`) REFERENCES `vibe_ngo_v1`.`supply`.`waybill`(`waybill_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `vibe_ngo_v1`.`supply`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ADD CONSTRAINT `fk_supply_distribution_plan_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ADD CONSTRAINT `fk_supply_distribution_plan_line_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ADD CONSTRAINT `fk_supply_commodity_supply_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` ADD CONSTRAINT `fk_supply_cold_chain_equipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` ADD CONSTRAINT `fk_supply_batch_lot_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` ADD CONSTRAINT `fk_supply_batch_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_ngo_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` ADD CONSTRAINT `fk_supply_batch_lot_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_cold_chain_equipment_id` FOREIGN KEY (`cold_chain_equipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`cold_chain_equipment`(`cold_chain_equipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` ADD CONSTRAINT `fk_supply_gavi_cofinancing_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` ADD CONSTRAINT `fk_supply_gavi_cofinancing_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` ADD CONSTRAINT `fk_supply_gavi_cofinancing_gavi_vaccine_commodity_id` FOREIGN KEY (`gavi_vaccine_commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ADD CONSTRAINT `fk_supply_vaccine_vial_monitor_state_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_ngo_v1`.`supply`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ADD CONSTRAINT `fk_supply_vaccine_vial_monitor_state_cold_chain_equipment_id` FOREIGN KEY (`cold_chain_equipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`cold_chain_equipment`(`cold_chain_equipment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` ADD CONSTRAINT `fk_supply_gavi_cofinancing_tracking_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` ADD CONSTRAINT `fk_supply_gavi_cofinancing_tracking_gavi_cofinancing_id` FOREIGN KEY (`gavi_cofinancing_id`) REFERENCES `vibe_ngo_v1`.`supply`.`gavi_cofinancing`(`gavi_cofinancing_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ADD CONSTRAINT `fk_supply_supply_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_ngo_v1`.`supply`.`supply_category`(`supply_category_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ADD CONSTRAINT `fk_supply_supply_category_parent_supply_category_id` FOREIGN KEY (`parent_supply_category_id`) REFERENCES `vibe_ngo_v1`.`supply`.`supply_category`(`supply_category_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`supply` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`supply` SET TAGS ('pii_domain' = 'supply');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('pii_column_comment_framework' = 'IPSAS 12 + WHO + UNICEF SD');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_category` SET TAGS ('pii_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('pii_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('pii_business_glossary_term' = 'Commodity Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('pii_value_regex' = 'active|inactive|discontinued|pending_approval|restricted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `country_of_origin` SET TAGS ('pii_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `country_of_origin` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_description` SET TAGS ('pii_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `diluent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Diluent Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restricted_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Restricted Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restriction_notes` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restriction_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `doses_per_vial` SET TAGS ('pii_business_glossary_term' = 'Doses Per Vial');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `epi_schedule_inclusion_flag` SET TAGS ('pii_business_glossary_term' = 'EPI Schedule Inclusion Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `gavi_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Gavi Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('pii_business_glossary_term' = 'Harmonized Tariff Code (HS Code)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `hazard_classification` SET TAGS ('pii_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `hazardous_material_flag` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `in_kind_donation_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `is_vaccine_flag` SET TAGS ('pii_business_glossary_term' = 'Is Vaccine Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `kit_assembly_flag` SET TAGS ('pii_business_glossary_term' = 'Kit or Assembly Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `kit_component_count` SET TAGS ('pii_business_glossary_term' = 'Kit Component Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_part_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('pii_business_glossary_term' = 'Commodity Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `quality_certification` SET TAGS ('pii_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `reorder_point_quantity` SET TAGS ('pii_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `shelf_life_days` SET TAGS ('pii_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `sphere_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Sphere (Humanitarian Charter and Minimum Standards) Compliant Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `standard_unit_cost` SET TAGS ('pii_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `standard_unit_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('pii_business_glossary_term' = 'Storage Humidity Maximum (Percent)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `subcategory` SET TAGS ('pii_business_glossary_term' = 'Commodity Subcategory');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `ultra_cold_chain_required_flag` SET TAGS ('pii_business_glossary_term' = 'Ultra Cold Chain Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `vaccine_type` SET TAGS ('pii_business_glossary_term' = 'Vaccine Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `volume_per_unit_cubic_meters` SET TAGS ('pii_business_glossary_term' = 'Volume per Unit (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `weight_per_unit_kg` SET TAGS ('pii_business_glossary_term' = 'Weight per Unit (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `who_pq_reference` SET TAGS ('pii_business_glossary_term' = 'WHO PQ Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `who_pq_reference_number` SET TAGS ('pii_business_glossary_term' = 'WHO PQ Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Manager Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `statutory_registration_id` SET TAGS ('pii_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `access_restrictions` SET TAGS ('pii_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `cluster_affiliation` SET TAGS ('pii_business_glossary_term' = 'OCHA (Office for the Coordination of Humanitarian Affairs) Cluster Affiliation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('pii_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `cold_chain_capacity_liters` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Capacity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `cold_chain_equipment_count` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Equipment Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `cold_chain_functional_percentage` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Functional Percentage');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `commissioning_date` SET TAGS ('pii_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `customs_bonded` SET TAGS ('pii_business_glossary_term' = 'Customs Bonded Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `decommissioning_date` SET TAGS ('pii_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `emergency_access_24_7` SET TAGS ('pii_business_glossary_term' = '24/7 Emergency Access');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `evm_assessment_date` SET TAGS ('pii_business_glossary_term' = 'EVM Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `evm_score` SET TAGS ('pii_business_glossary_term' = 'EVM Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('pii_value_regex' = 'central_warehouse|field_warehouse|transit_hub|pre_positioning_depot|cold_chain_facility|mobile_storage_unit');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `forklift_capacity_kg` SET TAGS ('pii_business_glossary_term' = 'Forklift Capacity (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `freezer_capacity_liters` SET TAGS ('pii_business_glossary_term' = 'Freezer Capacity (Liters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `gis_accuracy_meters` SET TAGS ('pii_business_glossary_term' = 'GIS (Geographic Information System) Accuracy (Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `hazmat_certified` SET TAGS ('pii_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `loading_docks_count` SET TAGS ('pii_business_glossary_term' = 'Loading Docks Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `managing_entity` SET TAGS ('pii_business_glossary_term' = 'Managing Entity Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `managing_entity` SET TAGS ('pii_value_regex' = 'direct_operation|partner_managed|government_shared|consortium|third_party_logistics');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('pii_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Warehouse Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_hours` SET TAGS ('pii_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'operational|under_construction|temporarily_closed|decommissioned|standby|emergency_activated');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'owned|leased|donated|government_provided|temporary_use');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `remote_temperature_monitoring_flag` SET TAGS ('pii_business_glossary_term' = 'Remote Temperature Monitoring Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('pii_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('pii_value_regex' = 'minimal|low|medium|high|maximum');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_m3` SET TAGS ('pii_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('pii_business_glossary_term' = 'Storage Capacity (Pallets)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('pii_business_glossary_term' = 'Temperature Controlled Capability');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_range_max_c` SET TAGS ('pii_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_range_min_c` SET TAGS ('pii_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `ultra_cold_capacity_liters` SET TAGS ('pii_business_glossary_term' = 'Ultra Cold Capacity (Liters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `vaccine_storage_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Storage Certified');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `vaccine_storage_tier` SET TAGS ('pii_business_glossary_term' = 'Vaccine Storage Tier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `wms_system_name` SET TAGS ('pii_business_glossary_term' = 'Warehouse Management System (WMS) Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `wms_system_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `wms_system_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Supplier Portal System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_business_glossary_term' = 'Bank Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_effective_date` SET TAGS ('pii_business_glossary_term' = 'Blacklist Effective Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Blacklist Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_flag` SET TAGS ('pii_business_glossary_term' = 'Blacklist Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_reason` SET TAGS ('pii_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `cold_chain_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Certified Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `commodity_categories` SET TAGS ('pii_business_glossary_term' = 'Commodity Categories Supplied');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `country_of_operation` SET TAGS ('pii_business_glossary_term' = 'Country of Operation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `fleet_size` SET TAGS ('pii_business_glossary_term' = 'Fleet Size');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `gmp_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `humanitarian_network_membership` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Logistics Network Membership');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `iso_certification` SET TAGS ('pii_business_glossary_term' = 'International Organization for Standardization (ISO) Certification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `last_performance_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `last_performance_score` SET TAGS ('pii_business_glossary_term' = 'Last Performance Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms_days` SET TAGS ('pii_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `performance_tier` SET TAGS ('pii_business_glossary_term' = 'Vendor Performance Tier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `performance_tier` SET TAGS ('pii_value_regex' = 'tier_1_preferred|tier_2_approved|tier_3_conditional|tier_4_probation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('pii_value_regex' = 'prequalified|not_prequalified|pending_review|expired');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Vendor Registration Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `transport_modes_offered` SET TAGS ('pii_business_glossary_term' = 'Transport Modes Offered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `un_vendor_number` SET TAGS ('pii_business_glossary_term' = 'United Nations (UN) Vendor Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|blacklisted|pending_approval|debarred');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('pii_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `warehouse_capacity_sqm` SET TAGS ('pii_business_glossary_term' = 'Warehouse Capacity in Square Meters');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `who_pq_manufacturer_flag` SET TAGS ('pii_business_glossary_term' = 'WHO PQ Manufacturer Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('pii_column_comment_framework' = 'IPSAS 12 + IATI');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `bid_id` SET TAGS ('pii_business_glossary_term' = 'Bid Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Office Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_request_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Request Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Source System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `supply_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Supply Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `tertiary_purchase_modified_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Delivery Location Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('pii_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_requested');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `commodity_category` SET TAGS ('pii_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('pii_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `emergency_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Procurement Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `erp_document_reference` SET TAGS ('pii_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('pii_business_glossary_term' = 'Freight and Shipping Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `gavi_co_financed_flag` SET TAGS ('pii_business_glossary_term' = 'Gavi Co-Financed Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('pii_value_regex' = 'not_received|partially_received|fully_received|over_received|discrepancy');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_matching_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Matching Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_matching_status` SET TAGS ('pii_value_regex' = 'not_matched|matched|variance|blocked');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Issue Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_value_regex' = '^PO-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_value_regex' = 'standard|blanket|contract|emergency|framework');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_method` SET TAGS ('pii_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_method` SET TAGS ('pii_value_regex' = 'competitive_bidding|request_for_quotation|sole_source|framework_agreement|emergency_procurement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `subtotal_amount` SET TAGS ('pii_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `vaccine_procurement_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Procurement Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `beneficiary_needs_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Needs Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inkind_donation_id` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `shipment_id` SET TAGS ('pii_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Officer ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Warehouse ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `waybill_id` SET TAGS ('pii_business_glossary_term' = 'Waybill Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Batch Lot ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `cold_chain_intact_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Intact Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_arrival` SET TAGS ('pii_business_glossary_term' = 'Condition on Arrival');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_arrival` SET TAGS ('pii_value_regex' = 'good|damaged|expired|partial_damage|quality_issue');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `customs_clearance_date` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `customs_cleared` SET TAGS ('pii_business_glossary_term' = 'Customs Cleared Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `freight_charges` SET TAGS ('pii_business_glossary_term' = 'Freight Charges');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_required` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('pii_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_ordered` SET TAGS ('pii_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_rejected` SET TAGS ('pii_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Document Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('pii_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_value_regex' = 'draft|posted|reversed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('pii_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `vvm_status_on_arrival` SET TAGS ('pii_business_glossary_term' = 'VVM Status On Arrival');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Balance ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Batch Lot ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `cold_chain_equipment_id` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Equipment ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `donor_restriction_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_movement_date` SET TAGS ('pii_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('pii_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `maximum_stock_level` SET TAGS ('pii_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Inventory Balance Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `pipeline_status` SET TAGS ('pii_business_glossary_term' = 'Pipeline Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `pipeline_status` SET TAGS ('pii_value_regex' = 'Available|Reserved|In Transit|Quarantined|Expired|Depleted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_available` SET TAGS ('pii_business_glossary_term' = 'Quantity Available for Distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_in_transit` SET TAGS ('pii_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('pii_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_business_glossary_term' = 'Quantity Quarantined');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('pii_business_glossary_term' = 'Quantity Reserved for Distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `reorder_level` SET TAGS ('pii_business_glossary_term' = 'Reorder Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `snapshot_date` SET TAGS ('pii_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_condition` SET TAGS ('pii_business_glossary_term' = 'Storage Condition Requirement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_condition` SET TAGS ('pii_value_regex' = 'Ambient|Refrigerated|Frozen|Controlled|Hazardous');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `total_valuation` SET TAGS ('pii_business_glossary_term' = 'Total Inventory Valuation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `total_valuation` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `vvm_current_stage` SET TAGS ('pii_business_glossary_term' = 'VVM Current Stage');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `vvm_stage` SET TAGS ('pii_business_glossary_term' = 'VVM Stage');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `warehouse_location` SET TAGS ('pii_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `warehouse_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('pii_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Batch Lot ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `case_record_id` SET TAGS ('pii_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `cold_chain_equipment_id` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Equipment ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `distribution_event_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Event ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Source Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Authorizing Officer ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `authorizing_officer_name` SET TAGS ('pii_business_glossary_term' = 'Authorizing Officer Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `authorizing_officer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `authorizing_officer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `carrier_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `carrier_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `count_team_reference` SET TAGS ('pii_business_glossary_term' = 'Physical Count Team Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `donor_restriction_code` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `donor_restriction_code` SET TAGS ('pii_value_regex' = 'unrestricted|geographic_restricted|program_restricted|beneficiary_restricted|time_restricted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Commodity Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspector_name` SET TAGS ('pii_business_glossary_term' = 'Quality Inspector Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspector_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspector_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_date` SET TAGS ('pii_business_glossary_term' = 'Movement Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_number` SET TAGS ('pii_business_glossary_term' = 'Movement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_number` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('pii_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('pii_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('pii_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Movement Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_value_regex' = '^PO-[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('pii_value_regex' = 'pending|passed|failed|waived|not_required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Movement Reason Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('pii_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('pii_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Movement Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `tracking_number` SET TAGS ('pii_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'road|air|sea|rail|pipeline|hand_carry');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `vvm_status_at_movement` SET TAGS ('pii_business_glossary_term' = 'VVM Status At Movement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_plan_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `community_id` SET TAGS ('pii_business_glossary_term' = 'Community Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Field Office ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Planning System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual Distribution End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Distribution Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `beneficiary_category` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `beneficiary_category` SET TAGS ('pii_value_regex' = 'idp|refugee|host_community|returnee|poc|vulnerable_population');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `cold_chain_capacity_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Capacity Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `coordination_cluster` SET TAGS ('pii_business_glossary_term' = 'Coordination Cluster');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_duration_days` SET TAGS ('pii_business_glossary_term' = 'Distribution Duration (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_frequency` SET TAGS ('pii_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_frequency` SET TAGS ('pii_value_regex' = 'one_time|weekly|biweekly|monthly|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_modality` SET TAGS ('pii_business_glossary_term' = 'Distribution Modality');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_modality` SET TAGS ('pii_value_regex' = 'direct|voucher|cash_in_kind|mobile_money|e_voucher|hybrid');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_type` SET TAGS ('pii_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_type` SET TAGS ('pii_value_regex' = 'emergency|routine|seasonal|one_time|recurring');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_total_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Volume (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_total_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Weight (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin1` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin2` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin3` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Administrative Level 3');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_country` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Country');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `mel_indicator_alignment` SET TAGS ('pii_business_glossary_term' = 'MEL (Monitoring Evaluation and Learning) Indicator Alignment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `planned_end_date` SET TAGS ('pii_business_glossary_term' = 'Planned Distribution End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Distribution Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'SDG (Sustainable Development Goal) Alignment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `security_clearance_required` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `target_beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `target_household_count` SET TAGS ('pii_business_glossary_term' = 'Target Household Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `vaccine_campaign_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Campaign Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_order_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Warehouse Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_plan_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Destination Distribution Point Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `household_id` SET TAGS ('pii_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Loading Officer Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Order Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `beneficiary_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `carrier_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `carrier_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `customs_reference` SET TAGS ('pii_business_glossary_term' = 'Customs Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `delivery_instructions` SET TAGS ('pii_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `dispatch_date` SET TAGS ('pii_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_type` SET TAGS ('pii_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_type` SET TAGS ('pii_value_regex' = 'general|targeted|emergency|seasonal|supplementary|blanket');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('pii_business_glossary_term' = 'Driver Contact Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('pii_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `emergency_response_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `estimated_value_usd` SET TAGS ('pii_business_glossary_term' = 'Estimated Value in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `household_count` SET TAGS ('pii_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Supplies Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `nfi_flag` SET TAGS ('pii_business_glossary_term' = 'Non-Food Item (NFI) Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `order_number` SET TAGS ('pii_value_regex' = '^DO-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'emergency|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `special_handling_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_commodity_lines` SET TAGS ('pii_business_glossary_term' = 'Total Commodity Lines');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_quantity` SET TAGS ('pii_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Total Volume in Cubic Meters (M3)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_cost_usd` SET TAGS ('pii_business_glossary_term' = 'Transport Cost in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'road|air|sea|rail|multimodal|hand_carry');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `vaccine_distribution_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Distribution Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `waybill_reference` SET TAGS ('pii_business_glossary_term' = 'Waybill Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `waybill_id` SET TAGS ('pii_business_glossary_term' = 'Waybill Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `distribution_order_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Origin Warehouse Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_id` SET TAGS ('pii_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Transporter Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `waybill_warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `arrival_timestamp` SET TAGS ('pii_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `cold_chain_equipment_used` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Equipment Used');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `customs_declaration_number` SET TAGS ('pii_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `departure_timestamp` SET TAGS ('pii_business_glossary_term' = 'Departure Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `discrepancy_notes` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `discrepancy_quantity` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `dispatch_date` SET TAGS ('pii_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `distance_km` SET TAGS ('pii_business_glossary_term' = 'Distance in Kilometers (KM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('pii_business_glossary_term' = 'Driver Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('pii_business_glossary_term' = 'Driver License Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('pii_business_glossary_term' = 'Driver Full Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `estimated_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `hazardous_material_flag` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `ice_packs_count` SET TAGS ('pii_business_glossary_term' = 'Ice Packs Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `insurance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `receipt_signature_captured_flag` SET TAGS ('pii_business_glossary_term' = 'Receipt Signature Captured Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `receipt_signature_captured_flag` SET TAGS ('pii_type' = 'signature');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('pii_business_glossary_term' = 'Received By Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_title` SET TAGS ('pii_business_glossary_term' = 'Received By Job Title');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Waybill Remarks');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `route_description` SET TAGS ('pii_business_glossary_term' = 'Route Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_intact_flag` SET TAGS ('pii_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_number` SET TAGS ('pii_business_glossary_term' = 'Security Seal Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_number` SET TAGS ('pii_value_regex' = '^SEAL[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_status` SET TAGS ('pii_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_status` SET TAGS ('pii_value_regex' = 'draft|dispatched|in_transit|arrived|received|cancelled');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_type` SET TAGS ('pii_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_type` SET TAGS ('pii_value_regex' = 'emergency_relief|program_supply|inter_warehouse_transfer|return_shipment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('pii_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_max_celsius` SET TAGS ('pii_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_min_celsius` SET TAGS ('pii_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `total_dispatched_quantity` SET TAGS ('pii_business_glossary_term' = 'Total Dispatched Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `total_received_quantity` SET TAGS ('pii_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `transport_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Transport Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `transport_cost_currency` SET TAGS ('pii_business_glossary_term' = 'Transport Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vaccine_transport_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Transport Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{5,15}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `waybill_number` SET TAGS ('pii_business_glossary_term' = 'Waybill Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `waybill_number` SET TAGS ('pii_value_regex' = '^WB[0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `inkind_donation_id` SET TAGS ('pii_business_glossary_term' = 'In-Kind Donation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `community_id` SET TAGS ('pii_business_glossary_term' = 'Community Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Warehouse Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `shipment_id` SET TAGS ('pii_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'pending|acknowledged|receipt_issued|thank_you_sent');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `allocation_status` SET TAGS ('pii_value_regex' = 'unallocated|allocated|distributed|consumed');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `batch_lot_number` SET TAGS ('pii_business_glossary_term' = 'Batch Lot Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `condition_status` SET TAGS ('pii_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `condition_status` SET TAGS ('pii_value_regex' = 'new|good|fair|damaged|expired');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `customs_clearance_date` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `customs_clearance_status` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `customs_clearance_status` SET TAGS ('pii_value_regex' = 'pending|cleared|held|released|exempted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donation_reference_number` SET TAGS ('pii_business_glossary_term' = 'Donation Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_business_glossary_term' = 'Donor Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_person_type' = 'person_name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_masking_policy' = 'mask_non_prod');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_name` SET TAGS ('pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_restrictions` SET TAGS ('pii_business_glossary_term' = 'Donor Restrictions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `donor_type` SET TAGS ('pii_business_glossary_term' = 'Donor Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `estimated_fair_market_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Fair Market Value (FMV)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `iati_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Reporting Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `iati_transaction_type` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Transaction Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `quality_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `quality_inspection_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `quality_inspection_result` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `quality_inspection_result` SET TAGS ('pii_value_regex' = 'passed|failed|conditional|not_inspected');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receiving_country_code` SET TAGS ('pii_business_glossary_term' = 'Receiving Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receiving_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receiving_location_name` SET TAGS ('pii_business_glossary_term' = 'Receiving Location Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receiving_location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `receiving_location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `restricted_use_flag` SET TAGS ('pii_business_glossary_term' = 'Restricted Use Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `shipment_origin_country_code` SET TAGS ('pii_business_glossary_term' = 'Shipment Origin Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `shipment_origin_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `tax_deductible_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Deductible Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `valuation_currency_code` SET TAGS ('pii_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `valuation_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `valuation_method` SET TAGS ('pii_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ALTER COLUMN `valuation_method` SET TAGS ('pii_value_regex' = 'donor_estimate|market_price|appraisal|catalog_price|replacement_cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `procurement_request_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Request ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `beneficiary_needs_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Needs Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `feedback_case_id` SET TAGS ('pii_business_glossary_term' = 'Feedback Case Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Organizational Unit ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `tertiary_procurement_last_modified_by_user_user_account_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `approval_level_required` SET TAGS ('pii_business_glossary_term' = 'Approval Level Required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `commodity_category` SET TAGS ('pii_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `compliance_check_required` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `delivery_address` SET TAGS ('pii_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `delivery_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `delivery_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `delivery_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('pii_value_regex' = 'not_required|low_impact|moderate_impact|high_impact|assessment_pending');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `estimated_total_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `estimated_unit_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `justification_narrative` SET TAGS ('pii_business_glossary_term' = 'Justification Narrative');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `local_procurement_preference` SET TAGS ('pii_business_glossary_term' = 'Local Procurement Preference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `quantity_requested` SET TAGS ('pii_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `request_status` SET TAGS ('pii_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `request_type` SET TAGS ('pii_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `required_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `requisition_number` SET TAGS ('pii_value_regex' = '^PR-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `sole_source_justification` SET TAGS ('pii_business_glossary_term' = 'Sole Source Justification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ALTER COLUMN `urgency_level` SET TAGS ('pii_value_regex' = 'routine|urgent|emergency|life_saving');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `procurement_request_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Request Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Publishing System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('pii_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `bid_opening_date` SET TAGS ('pii_business_glossary_term' = 'Bid Opening Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `clarification_deadline` SET TAGS ('pii_business_glossary_term' = 'Clarification Deadline');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `commodity_category` SET TAGS ('pii_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `delivery_deadline` SET TAGS ('pii_business_glossary_term' = 'Delivery Deadline');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `donor_visibility` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `emergency_procurement` SET TAGS ('pii_business_glossary_term' = 'Emergency Procurement Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `evaluation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('pii_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `invited_vendor_count` SET TAGS ('pii_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `minimum_qualification_requirements` SET TAGS ('pii_business_glossary_term' = 'Minimum Qualification Requirements');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `procurement_method` SET TAGS ('pii_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `procurement_method` SET TAGS ('pii_value_regex' = 'open_competitive|restricted|direct|framework_agreement|emergency');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `procurement_type` SET TAGS ('pii_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `procurement_type` SET TAGS ('pii_value_regex' = 'goods|services|works|consultancy|nfi|medical_supplies');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `published_url` SET TAGS ('pii_business_glossary_term' = 'Published Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `quantity_requested` SET TAGS ('pii_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `received_bid_count` SET TAGS ('pii_business_glossary_term' = 'Received Bid Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `responsive_bid_count` SET TAGS ('pii_business_glossary_term' = 'Responsive Bid Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('pii_value_regex' = '^RFQ-[A-Z]{3}-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('pii_value_regex' = 'draft|open|closed|under_evaluation|awarded|cancelled');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('pii_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `distribution_event_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Event Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Tracking System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('pii_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `actual_departure_date` SET TAGS ('pii_business_glossary_term' = 'Actual Departure Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('pii_business_glossary_term' = 'Bill of Lading (BOL) or Airway Bill Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier or Freight Forwarder Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `carrier_reference_number` SET TAGS ('pii_business_glossary_term' = 'Carrier Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `cold_chain_monitoring_device` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Monitoring Device');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `cold_chain_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Verified');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `container_number` SET TAGS ('pii_business_glossary_term' = 'Container or Vehicle Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `container_type` SET TAGS ('pii_business_glossary_term' = 'Container or Vehicle Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `customs_broker_name` SET TAGS ('pii_business_glossary_term' = 'Customs Broker Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `customs_broker_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `customs_broker_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('pii_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('pii_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_location_name` SET TAGS ('pii_business_glossary_term' = 'Destination Location Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `destination_port_code` SET TAGS ('pii_business_glossary_term' = 'Destination Port or Airport Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `duty_exemption_reference` SET TAGS ('pii_business_glossary_term' = 'Duty and Tax Exemption Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('pii_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `estimated_departure_date` SET TAGS ('pii_business_glossary_term' = 'Estimated Departure Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `freight_cost_usd` SET TAGS ('pii_business_glossary_term' = 'Freight Cost in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `hazmat_classification` SET TAGS ('pii_business_glossary_term' = 'Hazardous Materials (HAZMAT) Classification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `import_permit_number` SET TAGS ('pii_business_glossary_term' = 'Import Permit Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Cargo Insurance Policy Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `insured_value_usd` SET TAGS ('pii_business_glossary_term' = 'Insured Value in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `number_of_cartons` SET TAGS ('pii_business_glossary_term' = 'Number of Cartons or Packages');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `number_of_pallets` SET TAGS ('pii_business_glossary_term' = 'Number of Pallets');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_country_code` SET TAGS ('pii_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_location_name` SET TAGS ('pii_business_glossary_term' = 'Origin Location Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `origin_port_code` SET TAGS ('pii_business_glossary_term' = 'Origin Port or Airport Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `phytosanitary_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Phytosanitary Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('pii_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('pii_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('pii_value_regex' = 'emergency_relief|pre_positioned_stock|program_supply|in_kind_donation|medical_supply|nfi_consignment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `temperature_controlled` SET TAGS ('pii_business_glossary_term' = 'Temperature Controlled Shipment Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `temperature_range_max_c` SET TAGS ('pii_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `temperature_range_min_c` SET TAGS ('pii_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `total_cargo_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Total Cargo Volume in Cubic Meters');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `total_cargo_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Total Cargo Weight in Kilograms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'sea_freight|air_freight|road_transport|rail_transport|multimodal');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `vaccine_shipment_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Shipment Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `vvm_status_at_arrival` SET TAGS ('pii_business_glossary_term' = 'VVM Status At Arrival');
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ALTER COLUMN `vvm_status_at_departure` SET TAGS ('pii_business_glossary_term' = 'VVM Status At Departure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'Contract System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Procurement Officer ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `renewed_framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Renewed Framework Agreement Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `renewed_framework_agreement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}-[A-Z]{3}-d{4}-d{3,5}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_title` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Title');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Long-Term Agreement (LTA) Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'LTA|Blanket Purchase Agreement|Framework Contract|Standing Offer|Indefinite Delivery Contract|Master Service Agreement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `call_off_mechanism` SET TAGS ('pii_business_glossary_term' = 'Call-Off Mechanism');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `call_off_mechanism` SET TAGS ('pii_value_regex' = 'Purchase Order|Email Request|Online Portal|Phone Order|Automated Replenishment|EDI Transaction');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `commodity_categories` SET TAGS ('pii_business_glossary_term' = 'Commodity Categories Covered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `donor_visibility_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `emergency_delivery_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Emergency Delivery Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `last_performance_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `maximum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `maximum_order_value` SET TAGS ('pii_business_glossary_term' = 'Maximum Order Value');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `performance_rating` SET TAGS ('pii_value_regex' = 'Excellent|Good|Satisfactory|Needs Improvement|Unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `pricing_structure` SET TAGS ('pii_business_glossary_term' = 'Pricing Structure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `pricing_structure` SET TAGS ('pii_value_regex' = 'Fixed Unit Price|Tiered Discount|Volume-Based Discount|Cost Plus Fixed Fee|Market Price Adjustment|Negotiated Rate Card');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `quality_standards` SET TAGS ('pii_business_glossary_term' = 'Quality Standards');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('pii_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('pii_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `sole_source_justification` SET TAGS ('pii_business_glossary_term' = 'Sole Source Justification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `termination_clause` SET TAGS ('pii_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `total_orders_placed` SET TAGS ('pii_business_glossary_term' = 'Total Call-Off Orders Placed');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `total_value_utilized` SET TAGS ('pii_business_glossary_term' = 'Total Value Utilized');
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ALTER COLUMN `validity_period_months` SET TAGS ('pii_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` SET TAGS ('pii_association_edges' = 'supply.rfq,supply.vendor');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `bid_id` SET TAGS ('pii_business_glossary_term' = 'Bid Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Bid - Rfq Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Bid - Vendor Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Bid Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `awarded_flag` SET TAGS ('pii_business_glossary_term' = 'Award Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `bid_status` SET TAGS ('pii_business_glossary_term' = 'Bid Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Bid Currency');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `financial_score` SET TAGS ('pii_business_glossary_term' = 'Financial Evaluation Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `rank` SET TAGS ('pii_business_glossary_term' = 'Bid Rank');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Bid Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `technical_score` SET TAGS ('pii_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `total_score` SET TAGS ('pii_business_glossary_term' = 'Total Bid Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`bid` ALTER COLUMN `validity_days` SET TAGS ('pii_business_glossary_term' = 'Bid Validity Period');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_association_edges' = 'supply.distribution_order,supply.commodity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_ssot_scope' = 'supply_chain_distribution_line');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_ssot_owner' = 'supply');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_ssot_boundary' = 'supply_chain_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` SET TAGS ('pii_disambiguated_from' = 'field.field_distribution_line');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `supply_distribution_line_id` SET TAGS ('pii_business_glossary_term' = 'supply_distribution_line Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Batch Lot ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Line - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `distribution_order_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Line - Distribution Order Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `distribution_plan_line_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `field_distribution_line_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Line Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `waybill_id` SET TAGS ('pii_business_glossary_term' = 'Waybill Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `condition_on_dispatch` SET TAGS ('pii_business_glossary_term' = 'Condition on Dispatch');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `line_total_value` SET TAGS ('pii_business_glossary_term' = 'Line Total Value');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `quantity_discrepancy` SET TAGS ('pii_business_glossary_term' = 'Quantity Discrepancy');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `quantity_dispatched` SET TAGS ('pii_business_glossary_term' = 'Quantity Dispatched');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `storage_location_code` SET TAGS ('pii_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `storage_location_code` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `unit_value` SET TAGS ('pii_business_glossary_term' = 'Unit Value');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_distribution_line` ALTER COLUMN `vvm_status_at_distribution` SET TAGS ('pii_business_glossary_term' = 'VVM Status At Distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_association_edges' = 'supply.purchase_order,supply.commodity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line - Purchase Order Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('pii_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('pii_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `quantity_outstanding` SET TAGS ('pii_business_glossary_term' = 'Quantity Outstanding');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_association_edges' = 'supply.commodity,supply.vendor');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_ssot_scope' = 'supply_vendor_agreement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_ssot_owner' = 'supply');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_ssot_boundary' = 'vendor_agreement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` SET TAGS ('pii_disambiguated_from' = 'partnership.partnership_agreement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('pii_business_glossary_term' = 'supply_agreement Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Supply Agreement - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supply Agreement - Vendor Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `last_supply_date` SET TAGS ('pii_business_glossary_term' = 'Last Supply Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `prequalification_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `quality_certification` SET TAGS ('pii_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` SET TAGS ('pii_subdomain' = 'field_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` SET TAGS ('pii_association_edges' = 'supply.distribution_plan,supply.commodity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `distribution_plan_line_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Line ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Line - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `distribution_plan_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Plan Line - Distribution Plan Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `commodity_category` SET TAGS ('pii_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `commodity_priority` SET TAGS ('pii_business_glossary_term' = 'Commodity Priority');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `donor_restriction_code` SET TAGS ('pii_business_glossary_term' = 'Donor Restriction Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `estimated_unit_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `quantity_planned` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `total_commodity_items` SET TAGS ('pii_business_glossary_term' = 'Total Commodity Items');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `total_estimated_value` SET TAGS ('pii_business_glossary_term' = 'Total Estimated Value');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` SET TAGS ('pii_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` SET TAGS ('pii_association_edges' = 'supply.commodity,partnership.partner_org');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `commodity_supply_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Supply Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `commodity_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Supply Agreement - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Commodity Supply Agreement - Partner Org Id');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Agreement Currency');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `last_supply_date` SET TAGS ('pii_business_glossary_term' = 'Last Supply Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Partner Lead Time');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Partner Minimum Order Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Supply Agreement Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Supply Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `prequalification_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `prequalification_status` SET TAGS ('pii_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `quality_certification_verified` SET TAGS ('pii_business_glossary_term' = 'Quality Certification Verified');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ALTER COLUMN `unit_cost_agreement` SET TAGS ('pii_business_glossary_term' = 'Agreed Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` SET TAGS ('pii_cold_chain' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` SET TAGS ('pii_vaccine' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`cold_chain_equipment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` SET TAGS ('pii_cold_chain' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` SET TAGS ('pii_vaccine' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`batch_lot` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` SET TAGS ('pii_cold_chain' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` SET TAGS ('pii_vaccine' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` ALTER COLUMN `reported_by_staff_name` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`supply`.`temperature_excursion` ALTER COLUMN `reported_by_staff_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` SET TAGS ('pii_cold_chain' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` SET TAGS ('pii_vaccine' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing` ALTER COLUMN `vaccine_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ALTER COLUMN `cold_chain_equipment_id` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Equipment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ALTER COLUMN `location_type` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ALTER COLUMN `observer_staff_name` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ALTER COLUMN `observer_staff_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vaccine_vial_monitor_state` ALTER COLUMN `vvm_stage_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` SET TAGS ('pii_subdomain' = 'cold_chain');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`supply`.`gavi_cofinancing_tracking` ALTER COLUMN `gavi_cofinancing_id` SET TAGS ('pii_business_glossary_term' = 'Gavi Cofinancing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ALTER COLUMN `supply_category_id` SET TAGS ('pii_business_glossary_term' = 'Supply Category Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ALTER COLUMN `parent_supply_category_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ALTER COLUMN `category_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_category` ALTER COLUMN `category_short_name` SET TAGS ('pii_type' = 'name');
