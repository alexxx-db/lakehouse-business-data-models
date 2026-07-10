-- Schema for Domain: service | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`service` COMMENT 'Defines the catalog of water and wastewater services, rate structures, service tiers, contractual terms, service level agreements (SLAs), and service delivery configurations. Manages the relationship between service offerings and customer accounts, supporting rate case modeling and regulatory tariff compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the service offering. Primary key for the offering product.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service offerings (especially recycled water, surface water, or potable reuse) require authorization under a specific compliance permit. The offering already has regulatory_approval_date as a plain at',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: A service offering mandates a specific meter size type (e.g., 5/8" residential, 2" commercial). New connection processing, capacity planning, and tariff design all depend on this link. meter_size_requ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service offerings may be facility-specific (e.g., recycled water from specific reclamation facility, different water quality tiers based on treatment level). Needed for tariff design where rate struct',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether this offering requires or supports Advanced Metering Infrastructure (AMI) for automated meter reading and real-time consumption monitoring. True = AMI required or available; False = manual or Automatic Meter Reading (AMR) only.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the service contract automatically renews at the end of the contract term. True = auto-renews unless customer cancels; False = requires explicit renewal. Null if not applicable.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for this offering to protect the public water supply from contamination. True = backflow prevention required (common for commercial, industrial, and recycled water services); False = not required.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic base charge for the service offering, independent of consumption. Covers fixed costs such as meter maintenance, billing, and infrastructure access. Expressed in local currency (USD for U.S. utilities).',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle or schedule applicable to this offering. Examples: MNTH (monthly), QRTR (quarterly), BIMON (bi-monthly). Aligns with Oracle Utilities Customer Care and Billing (CC&B) billing cycle configuration.. Valid values are `^[A-Z0-9]{2,6}$`',
    `capacity_charge` DECIMAL(18,2) COMMENT 'Fee for reserving system capacity or infrastructure access, common in industrial and municipal bulk water agreements. May be based on meter size, peak demand, or contracted volume. Also known as a demand charge or readiness-to-serve charge.',
    `offering_code` STRING COMMENT 'Externally-known unique code for the service offering used in billing systems, tariff schedules, and customer communications. Examples: WTR-RES-01, WWC-COM-02, RCW-IND-01.. Valid values are `^[A-Z0-9]{6,12}$`',
    `connection_fee` DECIMAL(18,2) COMMENT 'One-time fee charged to establish a new service connection, including meter installation, service line connection, and administrative setup. May vary by customer class and service type.',
    `conservation_program_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers enrolled in this offering are eligible for water conservation programs, rebates, or incentives (e.g., low-flow fixture rebates, landscape conversion incentives). True = eligible; False = not eligible.',
    `contract_term_months` STRING COMMENT 'Standard contract duration in months for this offering. Common for commercial, industrial, and municipal agreements. Null for month-to-month residential service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_class` STRING COMMENT 'Customer segment or class to which this offering applies. Determines rate structure, service level expectations, and regulatory treatment. Residential = single-family and multi-family homes; Commercial = businesses and offices; Industrial = manufacturing and heavy water users; Municipal = government facilities; Agricultural = farms and irrigation; Institutional = schools, hospitals, non-profits.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `delivery_mode` STRING COMMENT 'Method by which the service is delivered and billed. Metered = consumption-based billing via Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR); Unmetered = fixed-rate service without consumption measurement; Flat rate = fixed periodic charge regardless of usage; Seasonal = service active only during specific periods; Temporary = short-term service for construction or events; Emergency = contingency supply during outages or disasters.. Valid values are `metered|unmetered|flat_rate|seasonal|temporary|emergency`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new customers. May vary based on estimated usage, customer class, or credit assessment. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for new customers enrolling in this offering. True = deposit required; False = no deposit. Deposit policies vary by customer class and credit history.',
    `offering_description` STRING COMMENT 'Detailed description of the service offering including scope, delivery specifications, and any special conditions or limitations. Used in customer agreements and regulatory filings.',
    `effective_end_date` DATE COMMENT 'Date on which the offering is no longer available for new customer enrollment. Null for open-ended offerings. Existing customers may continue under grandfathered terms.',
    `effective_start_date` DATE COMMENT 'Date on which the offering becomes available for customer enrollment and billing. Aligns with regulatory approval and operational readiness.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this offering includes dedicated fire protection service (e.g., fire hydrant access, private fire line). True = fire protection included; False = potable water or wastewater service only.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum sustained flow rate in Gallons per Minute (GPM) that the utility can deliver for this offering under normal conditions. Relevant for fire protection, industrial, and bulk water services. Null for standard residential metered service.',
    `late_payment_penalty_percent` DECIMAL(18,2) COMMENT 'Percentage penalty applied to overdue balances after the payment due date. Subject to Public Utilities Commission regulations. Null if no late fee applies.',
    `lifecycle_status` STRING COMMENT 'Current state of the offering in its lifecycle. Active = available for new customer enrollment; Inactive = temporarily unavailable; Pending approval = awaiting regulatory or internal approval; Suspended = on hold due to operational or regulatory issues; Retired = no longer offered to new customers; Grandfathered = legacy offering maintained only for existing customers under prior tariff terms.. Valid values are `active|inactive|pending_approval|suspended|retired|grandfathered`',
    `minimum_monthly_charge` DECIMAL(18,2) COMMENT 'Minimum amount a customer will be billed each billing period, regardless of consumption. Ensures cost recovery for fixed infrastructure and service availability. Null if no minimum applies.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this offering record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `offering_name` STRING COMMENT 'Human-readable name of the service offering as presented to customers and in regulatory tariff filings. Examples: Residential Potable Water Service, Commercial Wastewater Collection, Industrial Recycled Water Supply.',
    `pressure_range_psi_max` STRING COMMENT 'Maximum water pressure in PSI at the customer service connection under normal operating conditions. Excessive pressure may require Pressure Reducing Valve (PRV) installation. Null for wastewater or non-pressurized services.',
    `pressure_range_psi_min` STRING COMMENT 'Minimum water pressure in PSI guaranteed at the customer service connection under normal operating conditions. Part of service delivery specifications. Null for wastewater or non-pressurized services.',
    `rate_structure_type` STRING COMMENT 'Pricing model applied to the offering. Uniform = single rate for all consumption; Tiered = increasing or decreasing rates by consumption block (e.g., conservation pricing); Seasonal = rates vary by season (summer vs. winter); Time of use = rates vary by time of day or peak demand periods; Demand-based = charges based on peak flow or capacity reservation.. Valid values are `uniform|tiered|seasonal|time_of_use|demand_based`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the offering and its associated rate structure received regulatory approval from the Public Utilities Commission or other governing authority. Required for compliance with rate case documentation and audit trails.',
    `service_type` STRING COMMENT 'Primary category of water or wastewater service provided. Potable water = treated drinking water supply; Wastewater collection = sanitary sewer service; Recycled water = reclaimed water for non-potable uses; Fire protection = dedicated fire suppression service; Bulk water = wholesale or large-volume supply; Stormwater = stormwater management and drainage.. Valid values are `potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater`',
    `sla_response_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to respond to service requests, outages, or quality complaints for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies.',
    `sla_restoration_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to restore service following an outage or interruption for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for customer to terminate or discontinue service. Common for commercial and industrial contracts. Null for standard residential service.',
    `volumetric_rate_amount` DECIMAL(18,2) COMMENT 'Per-unit charge for water or wastewater service based on consumption volume. Typically expressed in dollars per thousand gallons ($/kgal) or dollars per hundred cubic feet ($/CCF). Null for unmetered or flat-rate offerings.',
    `volumetric_rate_unit` STRING COMMENT 'Unit of measure for volumetric billing. kgal = thousand gallons; CCF = hundred cubic feet; gallon = individual gallon; cubic meter = m³ (common in international contexts); acre-foot = volume unit for large agricultural or municipal contracts.. Valid values are `kgal|ccf|gallon|cubic_meter|acre_foot`',
    `water_quality_standard` STRING COMMENT 'Applicable water quality standard or regulatory compliance framework for this offering. Examples: Safe Drinking Water Act (SDWA) Primary Standards, Recycled Water Quality Standards (Title 22 California), Industrial Discharge Permit Limits. Null for non-water offerings (e.g., wastewater collection).',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master catalog of all water and wastewater service offerings available to customers, including potable water supply, wastewater collection, recycled water, fire protection, irrigation, and bulk water services. Defines the canonical service type, delivery mode, applicable customer classes (residential, commercial, industrial, municipal), regulatory tariff reference, connection fee schedule, service tier options, and lifecycle status. This is the SSOT for what Water Utilities offers in the market and the anchor entity for rate schedules, SLAs, and service agreements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` (
    `service_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the service_rate_schedule data product (auto-inserted pre-linking).',
    `billing_rate_schedule_id` BIGINT COMMENT '',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service rate schedules define approved tariff rate structures for specific service offerings. Currently has rate_case_id but missing the offering link. Rate schedules must be tied to the offerings the',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Rate schedules are applied by customer service class (residential, commercial, industrial, etc.). Each rate schedule should specify which service class it applies to. This is a standard water utility',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Rate schedules implement approved regulatory tariffs. In water utilities, tariffs are filed with and approved by the Public Utilities Commission, then rate schedules operationalize those tariffs. serv',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Rate schedules can vary by geographic territory due to different franchise agreements, cost structures, or regulatory jurisdictions. Water utilities often have territory-specific rate schedules. This',
    CONSTRAINT pk_service_rate_schedule PRIMARY KEY(`service_rate_schedule_id`)
) COMMENT 'Defines the approved tariff rate structures for each service offering, including tiered volumetric rates (with tier thresholds, unit prices, and tier sequences), flat fees, demand charges, seasonal rate adjustments, and minimum charges. Captures the rate case approval date, effective and expiration dates, regulatory authority, rate code, applicable customer class, and billing unit of measure. Tier definitions (inclining block, declining block, uniform) are maintained as structured components within each schedule. Supports rate case modeling and regulatory tariff compliance. Aligned with Oracle CC&B rate schedule configuration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key.',
    `facility_id` BIGINT COMMENT 'add column treatment_facility_id (BIGINT) with FK to treatment.facility.facility_id - service territories are served by specific treatment facilities',
    `acquisition_date` DATE COMMENT 'Date when the utility acquired this service territory through purchase, merger, or regulatory transfer from another provider.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the service territory measured in square miles.',
    `average_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Average daily water demand for the territory measured in million gallons per day, used for capacity planning and regulatory reporting.',
    `boundary_description` STRING COMMENT 'Textual description of the territory boundary using legal descriptions, street names, or geographic landmarks.',
    `territory_code` STRING COMMENT 'Externally-known unique code identifying the service territory, used in regulatory filings and franchise agreements.. Valid values are `^[A-Z0-9]{4,12}$`',
    `commercial_customer_count` STRING COMMENT 'Number of commercial customer accounts within the territory.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the territory is located (e.g., USA).. Valid values are `^[A-Z]{3}$`',
    `county_name` STRING COMMENT 'Primary county in which the service territory is located, used for regulatory reporting and jurisdictional analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of active customer accounts (service connections) within the territory.',
    `effective_end_date` DATE COMMENT 'Date when the utilitys authorization to serve this territory expires or was terminated. Null for active territories with no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the utility began providing service in this territory or when the current franchise agreement became effective.',
    `emergency_contact_phone` STRING COMMENT 'Primary emergency contact phone number for service issues or outages in this territory, published to customers and regulatory agencies.',
    `franchise_agreement_number` STRING COMMENT 'Identifier of the regulatory franchise agreement or certificate of public convenience and necessity (CPCN) authorizing service in this territory.',
    `franchise_expiration_date` DATE COMMENT 'Date when the current franchise agreement or certificate expires and requires renewal or renegotiation.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier or feature class name in Esri ArcGIS for the polygon geometry defining the territory boundary.',
    `industrial_customer_count` STRING COMMENT 'Number of industrial customer accounts within the territory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was last updated in the system.',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory (e.g., Downtown District, North County Service Area).',
    `notes` STRING COMMENT 'Free-form notes capturing special conditions, historical context, or operational considerations for this service territory.',
    `npdes_permit_jurisdiction` STRING COMMENT 'Regulatory authority responsible for wastewater discharge permits under the Clean Water Act (CWA) in this territory.',
    `operating_division_code` STRING COMMENT 'Internal code identifying the utilitys operating division or business unit responsible for service delivery in this territory.',
    `peak_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Peak daily water demand for the territory measured in million gallons per day, used for infrastructure sizing and emergency planning.',
    `population_served` STRING COMMENT 'Estimated total population residing within the service territory, used for regulatory reporting and capacity planning.',
    `potable_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides potable (drinking) water service within this territory.',
    `predecessor_utility_name` STRING COMMENT 'Name of the previous utility that served this territory before acquisition or transfer, used for historical data lineage.',
    `primacy_agency_jurisdiction` STRING COMMENT 'State or federal agency with primary regulatory authority over drinking water quality in this territory (e.g., California State Water Resources Control Board).',
    `rate_zone_code` STRING COMMENT 'Code identifying the rate zone or pricing district applicable to customers in this territory.',
    `recycled_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides recycled (reclaimed) water service for non-potable uses within this territory.',
    `regulatory_authority_name` STRING COMMENT 'Name of the state or local regulatory body with jurisdiction over rates and service quality in this territory (e.g., California Public Utilities Commission).',
    `residential_customer_count` STRING COMMENT 'Number of residential customer accounts within the territory.',
    `service_center_location` STRING COMMENT 'Name or identifier of the primary service center or operations facility serving this territory.',
    `service_classification` STRING COMMENT 'Geographic and demographic classification of the territory, used for rate design and infrastructure planning.. Valid values are `urban|suburban|rural|mixed`',
    `state_code` STRING COMMENT 'Two-letter U.S. state code where the territory is located (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `stormwater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides stormwater management service within this territory.',
    `tariff_schedule_reference` STRING COMMENT 'Reference to the applicable rate tariff schedule approved by the regulatory authority for this territory.',
    `territory_status` STRING COMMENT 'Current operational status of the service territory in the utilitys service portfolio.. Valid values are `active|inactive|pending|suspended|retired|transferred`',
    `territory_type` STRING COMMENT 'Classification of the service territory based on regulatory authorization and service delivery model.. Valid values are `franchise|certificated|contract|wholesale|retail|combined`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/Los_Angeles), used for operational scheduling and SCADA data timestamping.',
    `wastewater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides wastewater collection and treatment service within this territory.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the geographic service territories and franchise areas within which Water Utilities is authorized to provide water and wastewater services. Includes territory boundaries (GIS polygon references via Esri ArcGIS), regulatory franchise agreement identifiers, applicable state primacy agency jurisdiction, service type coverage (potable, wastewater, recycled), and territory classification (urban, suburban, rural). Supports tariff applicability and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_class` (
    `service_class_id` BIGINT COMMENT 'Unique identifier for the service class record. Primary key.',
    `asset_class_id` BIGINT COMMENT '',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service classes define rate structures and customer classifications that are applied to specific offerings. The offering.customer_class field references service_class.class_code, establishing a busine',
    `average_monthly_consumption_gallons` DECIMAL(18,2) COMMENT 'Typical average monthly water consumption in gallons for accounts in this service class. Used for rate modeling and demand forecasting.',
    `awwa_classification_code` STRING COMMENT 'Standard classification code from AWWA M1 Manual used for industry benchmarking and best practice alignment.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for accounts in this service class to protect the public water supply from contamination.',
    `billing_cycle_type` STRING COMMENT 'Standard billing frequency for accounts in this service class (e.g., monthly, bimonthly, quarterly). Determines meter reading and invoice generation schedules.. Valid values are `monthly|bimonthly|quarterly|annual|on_demand`',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service class (e.g., RSF for Residential Single-Family, COM for Commercial, IND for Industrial). Used in billing systems and regulatory reports.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_description` STRING COMMENT 'Detailed description of the service class, including eligibility criteria, typical usage characteristics, and any special conditions or restrictions.',
    `class_name` STRING COMMENT 'Full descriptive name of the service class (e.g., Residential Single-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, Wholesale).',
    `class_type` STRING COMMENT 'High-level category of the service class used for grouping and analysis. Aligns with regulatory reporting categories. [ENUM-REF-CANDIDATE: residential|commercial|industrial|irrigation|fire_protection|municipal|wholesale|other — 8 candidates stripped; promote to reference product]',
    `conservation_program_eligible` BOOLEAN COMMENT 'Indicates whether accounts in this service class are eligible for water conservation programs, rebates, or incentives.',
    `consumption_tier_structure` STRING COMMENT 'Type of rate structure applied to consumption for this class (e.g., flat rate, tiered/block rates, seasonal rates, time-of-use rates).. Valid values are `flat|tiered|seasonal|time_of_use`',
    `contract_term_months` STRING COMMENT 'Standard contract term length in months for accounts in this service class. Applicable primarily to wholesale and large industrial customers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was first created in the system.',
    `deposit_requirement_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new accounts in this service class. May vary based on credit risk and consumption history.',
    `disconnection_policy` STRING COMMENT 'Policy governing service disconnection for non-payment for this class (e.g., standard, protected for vulnerable populations, restricted for essential services).. Valid values are `standard|protected|restricted`',
    `drought_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether drought surcharges or emergency water use restrictions apply to this service class during water shortage conditions.',
    `effective_end_date` DATE COMMENT 'Date when this service class definition expires or was superseded. Null for currently active classes.',
    `effective_start_date` DATE COMMENT 'Date when this service class definition became or will become effective for billing and account assignment.',
    `fire_flow_requirement_gpm` STRING COMMENT 'Minimum fire flow capacity requirement in gallons per minute (GPM) for properties served under this class. Applicable primarily to commercial, industrial, and fire protection classes.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to overdue balances for accounts in this service class. Subject to regulatory limits.',
    `meter_size_range` STRING COMMENT 'Typical or allowable range of meter sizes (in inches) for accounts in this service class (e.g., 5/8-inch to 1-inch for residential, 2-inch to 6-inch for commercial).',
    `minimum_charge_applicable` BOOLEAN COMMENT 'Indicates whether a minimum monthly or periodic charge applies to accounts in this service class, regardless of consumption.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this service class record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was last modified.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or administrative comments regarding this service class.',
    `peak_demand_factor` DECIMAL(18,2) COMMENT 'Multiplier representing the ratio of peak demand to average demand for this service class. Used in capacity planning and infrastructure sizing.',
    `pressure_requirement_psi` STRING COMMENT 'Minimum service pressure requirement in pounds per square inch (PSI) for accounts in this service class. Ensures adequate pressure for intended use.',
    `puc_approval_date` DATE COMMENT 'Date when the Public Utilities Commission approved this service class and its associated rate structure. Required for regulated utilities.',
    `puc_filing_reference` STRING COMMENT 'Reference number or identifier of the PUC rate case filing or tariff document that established or modified this service class.',
    `rate_schedule_group` STRING COMMENT 'Identifier of the rate schedule group applicable to this service class. Links the class to specific rate structures and tariff schedules for billing purposes.',
    `regulatory_reporting_category` STRING COMMENT 'Classification code used for regulatory compliance reporting to state and federal agencies (e.g., EPA, PUC). Maps service class to required reporting categories.',
    `renewal_notification_days` STRING COMMENT 'Number of days advance notice required before contract renewal or rate changes for this service class.',
    `seasonal_rate_applicable` BOOLEAN COMMENT 'Indicates whether seasonal rate variations (e.g., higher summer rates for irrigation) apply to this service class.',
    `service_class_status` STRING COMMENT 'Current lifecycle status of the service class. Active classes are available for new account assignments; deprecated classes are phased out but may have existing accounts.. Valid values are `active|inactive|pending_approval|deprecated|suspended`',
    `service_level_agreement_tier` STRING COMMENT 'Service level tier defining response times, service restoration priorities, and quality commitments for this class (e.g., standard, priority, premium, critical).. Valid values are `standard|priority|premium|critical`',
    `tariff_classification` STRING COMMENT 'Official tariff classification as filed with and approved by the Public Utilities Commission. Used for rate case modeling and tariff compliance.',
    `water_quality_monitoring_frequency` STRING COMMENT 'Required frequency of water quality monitoring or testing for accounts in this service class. More stringent for industrial and high-risk classes.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `created_by` STRING COMMENT 'User identifier or system account that created this service class record.',
    CONSTRAINT pk_service_class PRIMARY KEY(`service_class_id`)
) COMMENT 'Reference classification of customer service classes used for rate application and regulatory reporting, such as Residential Single-Family, Residential Multi-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, and Wholesale. Each class carries a class code, description, applicable rate schedule group, billing cycle type, and regulatory reporting category. Aligned with PUC tariff classification and AWWA customer class standards.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the service agreement. Primary key for this entity representing the contractual relationship between Water Utilities and a customer account.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial and commercial service agreements require compliance permits (NPDES, discharge permits). Utility tracks permit governing each agreement for regulatory reporting, billing validation, and dis',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: A customer service agreement is the downstream result of an approved connection application. Linking agreement.connection_application_id -> connection_application establishes the origination traceabil',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service agreements need DMA context for NRW cost allocation, water loss recovery charges, zone-specific service terms, and consumption baseline establishment. Enables DMA-level revenue and loss accoun',
    `meter_id` BIGINT COMMENT 'Reference to the water or wastewater meter installed at the service point for consumption measurement. Links to AMI (Advanced Metering Infrastructure) or AMR (Automatic Meter Reading) systems.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Each service agreement is assigned to a specific service class which determines rate schedule applicability, billing cycle, and regulatory reporting. The service_class STRING attribute should be norma',
    `offering_id` BIGINT COMMENT 'Reference to the specific service offering (water, wastewater, reclaimed water, stormwater) that this agreement covers. Links to the service catalog.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: A customer service agreement is governed by a specific regulatory tariff that defines the rates, terms, and conditions applicable to the customer. The agreement currently stores rate_schedule_code as ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: A customer service agreement is always associated with a specific geographic service territory — the territory determines applicable rates, regulatory jurisdiction, and service rules. While territory ',
    `agreement_number` STRING COMMENT 'Externally visible unique business identifier for the service agreement. Used in customer communications, billing statements, and regulatory reporting.. Valid values are `^SA-[0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the service agreement. Active agreements are billed and serviced; suspended agreements are temporarily halted; terminated agreements are closed.. Valid values are `active|pending|suspended|terminated|cancelled`',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment is enabled for this service agreement. When true, invoices are automatically paid from the customers designated payment method.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the service agreement automatically renews at the end of the contract term. When false, agreement requires explicit renewal action.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention device installation and annual testing is required for this service agreement per SDWA (Safe Drinking Water Act) cross-connection control requirements.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule for this agreement (e.g., monthly, bi-monthly, quarterly). Determines meter reading and invoice generation timing.. Valid values are `^[A-Z0-9]{2,6}$`',
    `budget_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program, which averages annual usage into equal monthly payments to reduce seasonal bill variation.',
    `contract_term_months` STRING COMMENT 'Duration of the service agreement contract in months. Used for minimum commitment periods and early termination fee calculations.',
    `created_by_user` STRING COMMENT 'Identifier of the system user or process that created this service agreement record. Used for audit and accountability purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was first created in the system. Used for audit trail and data lineage tracking.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required and held for this service agreement. Based on credit assessment and service class. Refundable upon agreement termination.',
    `deposit_status` STRING COMMENT 'Current status of the security deposit for this agreement. Tracks whether deposit is required, currently held, waived based on credit, or refunded.. Valid values are `required|held|waived|refunded|forfeited`',
    `end_date` DATE COMMENT 'Date when the service agreement terminates or is scheduled to terminate. Null for open-ended agreements. Used for final billing and account closure.',
    `external_reference_code` STRING COMMENT 'External system identifier for this service agreement in legacy or third-party systems. Used for cross-system reconciliation and data migration tracking.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes fire protection service (private fire lines, sprinkler systems), which typically carries fixed monthly charges regardless of usage.',
    `industrial_user_permit_required` BOOLEAN COMMENT 'Indicates whether this service agreement requires an Industrial User Permit for wastewater discharge per NPDES (National Pollutant Discharge Elimination System) pretreatment program requirements.',
    `irrigation_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes irrigation or outdoor water service, which may be billed separately or subject to seasonal rates and wastewater exemptions.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the system user or process that last modified this service agreement record. Used for change audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated. Used for change tracking and data synchronization across systems.',
    `low_income_assistance_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for low-income customer assistance programs, rate discounts, or payment plans per regulatory requirements.',
    `minimum_usage_commitment_gallons` DECIMAL(18,2) COMMENT 'Minimum water usage volume (in gallons) that the customer commits to consume per billing period. Common for commercial and industrial agreements. Used for minimum charge calculations.',
    `paperless_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic billing instead of paper invoices. Supports environmental sustainability initiatives.',
    `rate_schedule_code` STRING COMMENT 'Code identifying the tariff rate schedule applied to this service agreement. Determines pricing structure, billing frequency, and charge calculations per approved rate case.. Valid values are `^[A-Z0-9]{2,10}$`',
    `renewal_date` DATE COMMENT 'Date when the service agreement is scheduled for renewal or renegotiation. Applicable for fixed-term contracts with renewal provisions.',
    `senior_citizen_discount_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for senior citizen rate discounts or special programs as defined by utility tariff.',
    `sla_response_time_hours` STRING COMMENT 'Contractually committed maximum response time in hours for service requests and emergency calls. Varies by service class and agreement type.',
    `sla_restoration_time_hours` STRING COMMENT 'Contractually committed maximum time in hours to restore service after an outage or interruption. Critical for commercial and industrial customers.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this service agreement data originated. Supports data lineage and multi-system integration scenarios.. Valid values are `CCB|CIS|ERP|LEGACY`',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special contractual conditions, exceptions, or custom terms negotiated for this service agreement. Examples include seasonal rate adjustments, volume discounts, or regulatory exemptions.',
    `start_date` DATE COMMENT 'Date when the service agreement becomes effective and service delivery begins. Used for billing proration and regulatory compliance reporting.',
    `termination_date` DATE COMMENT 'Actual date when the service agreement was terminated. Used for final billing, deposit refund processing, and regulatory reporting.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for service agreement termination. Examples include customer move-out, non-payment, property demolition, or service transfer.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Represents the active contractual relationship between Water Utilities and a customer account for a specific service offering at a service location. Captures agreement start and end dates, contracted service class, applicable rate schedule, minimum usage commitments, deposit requirements, special conditions, and agreement status. This is the SSOT for what service a customer account is enrolled in. Aligned with Oracle CC&B service agreement entity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`point` (
    `point_id` BIGINT COMMENT 'Unique identifier for the service point. Primary key for the service point entity representing the physical location where utility service is delivered.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service points (especially industrial discharge points) are directly tied to NPDES permits. Permits specify discharge locations; utility must map permit-to-service-point for DMR reporting, compliance',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service points require DMA assignment for NRW analysis, consumption pattern tracking, leak detection planning, and zone-level service analytics. Replaces denormalized dma_code with proper FK enabling',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: A service point (physical customer connection) must reference the asset location hierarchy for GIS integration, field crew dispatch, and infrastructure mapping. service.point has latitude/longitude de',
    `meter_id` BIGINT COMMENT 'Reference to the metering device currently installed at this service point for consumption measurement. Links to the asset registry meter record.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Service point physical tap location must reference the specific pipe main it connects to. Pressure complaint resolution, main break customer impact analysis, and LCRR compliance reporting all require ',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service points must reference pressure zones for hydraulic design validation, pressure guarantee compliance in SLAs, and service adequacy verification. Replaces denormalized pressure_zone_code with pr',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service points are classified by customer class (residential, commercial, industrial) which determines rate schedule, meter size requirements, and service level agreements. The customer_class STRING a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service points (delivery locations) are geographically located within service territories. point has latitude, longitude, and address fields, which place it within a territory boundary. This FK establ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service points receive water from specific treatment facilities - critical for water quality tracking (CT compliance, turbidity, chlorine residual), pressure zone management, and responding to custome',
    `activation_date` DATE COMMENT 'Date when service delivery was first activated at this service point, marking the beginning of billable service. May differ from installation date if there was a delay between physical installation and service turn-on.',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether this service point is equipped with Advanced Metering Infrastructure for automated remote meter reading and real-time consumption monitoring. True if AMI meter is installed; false for manual read meters.',
    `backflow_device_type` STRING COMMENT 'Type of backflow prevention device installed at this service point. RPZ is Reduced Pressure Zone; DCVA is Double Check Valve Assembly; PVB is Pressure Vacuum Breaker; AG is Air Gap; none indicates no device required; unknown indicates status not verified.. Valid values are `rpz|dcva|pvb|ag|none|unknown`',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether a backflow prevention device is required at this service point based on hazard assessment and cross-connection control regulations. True if backflow prevention is mandated; false otherwise.',
    `connection_material` STRING COMMENT 'Material composition of the service line connecting the distribution main to the customer premises. Critical for Lead and Copper Rule Revisions (LCRR) compliance and service line inventory reporting. [ENUM-REF-CANDIDATE: copper|pvc|hdpe|galvanized_steel|lead|ductile_iron|pex|unknown — 8 candidates stripped; promote to reference product]',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the service connection pipe in inches, representing the physical capacity of the service line connecting the distribution main to the customer premises. Common sizes include 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches.',
    `created_by_user` STRING COMMENT 'User identifier of the person or system process that created this service point record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was first created in the system. Used for audit trail and data lineage tracking.',
    `curb_stop_location` STRING COMMENT 'Description of the physical location of the curb stop valve (service shutoff valve) for this service point. Used by field crews for service disconnection and emergency shutoff.',
    `disconnection_date` DATE COMMENT 'Date when service was disconnected or terminated at this service point. Null if service is currently active.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the service point location in feet above mean sea level. Used for hydraulic modeling to calculate static pressure and pressure zone assignment.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Estimated average daily water demand at this service point in gallons, used for hydraulic modeling and capacity planning. Derived from historical consumption patterns or engineering estimates for new connections.',
    `fire_service_indicator` BOOLEAN COMMENT 'Indicates whether this service point includes fire protection service (fire sprinkler system or fire hydrant connection). True if fire service is provided; false for domestic-only service.',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this service point to its corresponding feature in the Esri ArcGIS utility network model. Enables spatial analysis and network tracing.',
    `installation_date` DATE COMMENT 'Date when the service point connection was physically installed and commissioned for service delivery. Used for asset age tracking and depreciation calculations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent field inspection or verification of this service point. Used for compliance tracking and preventive maintenance scheduling.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics.',
    `modified_by_user` STRING COMMENT 'User identifier of the person or system process that last modified this service point record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was last modified in the system. Used for audit trail and change tracking.',
    `ownership_type` STRING COMMENT 'Ownership responsibility for the service line infrastructure. Utility-owned indicates the utility maintains the entire service line; customer-owned indicates customer responsibility; shared indicates split ownership at a defined point (typically property line or curb stop).. Valid values are `utility_owned|customer_owned|shared|unknown`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous demand at this service point in gallons per minute, used for service line sizing and pressure analysis in hydraulic models.',
    `rate_schedule_code` STRING COMMENT 'Identifier for the tariff rate schedule applied to this service point for billing purposes. Rate schedules define the pricing structure including base charges, volumetric rates, and tier thresholds.',
    `route_code` STRING COMMENT 'Identifier for the meter reading or field service route to which this service point is assigned. Used for scheduling meter reading, field inspections, and maintenance activities.',
    `service_address_line1` STRING COMMENT 'Primary street address line of the physical location where service is delivered. Includes street number, street name, and street type.',
    `service_address_line2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, or other location qualifier at the service point address.',
    `service_city` STRING COMMENT 'City or municipality name where the service point is located.',
    `service_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the service point is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `service_point_description` STRING COMMENT 'Free-text description providing additional context about the service point location, special characteristics, or access instructions for field personnel.',
    `service_point_number` STRING COMMENT 'Externally-known business identifier for the service point, typically displayed on customer bills and used in customer service interactions. Unique across the utility service territory.. Valid values are `^SP[0-9]{8,12}$`',
    `service_point_status` STRING COMMENT 'Current operational status of the service point in its lifecycle. Active indicates service is being delivered; inactive indicates no current service; suspended indicates temporary service hold; pending_activation indicates awaiting turn-on; disconnected indicates service terminated; abandoned indicates permanently retired.. Valid values are `active|inactive|suspended|pending_activation|disconnected|abandoned`',
    `service_postal_code` STRING COMMENT 'ZIP code or postal code of the service point location, supporting 5-digit or 9-digit (ZIP+4) formats.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service point is located, following USPS state abbreviation standards.. Valid values are `^[A-Z]{2}$`',
    `service_type` STRING COMMENT 'Type of utility service delivered at this service point. Potable water is drinking water distribution; wastewater is sanitary sewer collection; recycled water is reclaimed water for irrigation or industrial use; stormwater is surface water drainage; combined is combined sewer system.. Valid values are `potable_water|wastewater|recycled_water|stormwater|combined`',
    CONSTRAINT pk_point PRIMARY KEY(`point_id`)
) COMMENT 'Represents the physical location where a utility service is delivered to a customer, corresponding to a metered connection point on the distribution or wastewater network. Captures the service point address, GIS coordinates (Esri ArcGIS), service type (potable water, wastewater, recycled water), connection size (pipe diameter in inches), pressure zone, DMA assignment, and active status. Links the commercial service agreement to the physical network infrastructure.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`connection_application` (
    `connection_application_id` BIGINT COMMENT 'Unique identifier for the connection application record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Connection applications requiring infrastructure upgrades (main extensions, pump station capacity, treatment plant expansion) trigger or are bundled into CIP projects. Applicants and customer service',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: New connections must be assigned to DMAs for capacity planning, NRW impact assessment, metering infrastructure planning, and zone-level demand forecasting. Essential for evaluating capacity_available',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: New connection applications require infrastructure capacity assessment at specific asset locations (pump stations, pressure zones, treatment facilities). Engineering reviews check available capacity',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Connection applications specify required meter size based on estimated demand (GPM). Engineering review validates sizing against meter_size_type specifications (max flow, pressure rating, accuracy cla',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Connection applications request a specific service offering from the catalog. connection_application currently has requested_service_type as a STRING field, which should be normalized to reference the',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New connection applications require pressure zone assignment for hydraulic capacity verification, infrastructure adequacy assessment, and pressure guarantee feasibility before approval. Critical for c',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: New connection applications must comply with regulatory requirements (backflow prevention, cross-connection control, capacity standards, water quality). Application review process validates against ap',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: A connection application is submitted for a specific service class (e.g., residential, commercial, industrial) which determines applicable rates, deposit requirements, meter sizing, and regulatory req',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Connection applications are submitted for service within a specific franchise territory. The service_address fields are application-specific and should be retained, but a FK to service_territory is ne',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether the connection will be equipped with Advanced Metering Infrastructure (AMI) for automated meter reading and real-time monitoring.',
    `applicant_email` STRING COMMENT 'Primary email address of the applicant for correspondence and notifications regarding the connection application.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_name` STRING COMMENT 'Full legal name of the individual or organization applying for the service connection.',
    `applicant_phone` STRING COMMENT 'Primary contact phone number of the applicant for communication regarding the connection application.. Valid values are `^+?[1-9]d{1,14}$`',
    `application_date` DATE COMMENT 'Date when the connection application was formally submitted by the applicant.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for processing the connection application, in USD.',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned to the connection request. Format: CA-YYYYNNNN.. Valid values are `^CA-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the connection application in the approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `application_type` STRING COMMENT 'Type of service connection application: new connection, service upgrade, disconnection, transfer of service, reconnection, or temporary service.. Valid values are `new_connection|service_upgrade|disconnection|transfer|reconnection|temporary_service`',
    `approval_date` DATE COMMENT 'Date when the connection application was officially approved by the utility.',
    `capacity_available` BOOLEAN COMMENT 'Indicates whether sufficient system capacity (pressure, flow, treatment capacity) is available to serve the requested connection without infrastructure upgrades.',
    `capacity_charge_amount` DECIMAL(18,2) COMMENT 'System development or capacity charge assessed to fund infrastructure expansion to serve the new connection, in USD.',
    `completion_date` DATE COMMENT 'Date when the physical service connection was completed and the service was activated.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or tap fee assessed for establishing the new service connection, in USD.',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the requested service connection in inches (e.g., 0.75, 1.0, 1.5, 2.0). Critical for capacity planning and meter sizing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was first created in the system.',
    `estimated_flow_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak flow demand in gallons per minute (GPM) for the requested service connection. Used for hydraulic modeling and capacity verification.',
    `infrastructure_upgrade_required` BOOLEAN COMMENT 'Indicates whether main extensions, pump station upgrades, or other infrastructure improvements are required to serve the connection.',
    `meter_type_requested` STRING COMMENT 'Type or model of water meter requested or recommended for the connection (e.g., positive displacement, turbine, compound, electromagnetic).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the connection application, including special requirements, site conditions, or coordination details.',
    `number_of_units` STRING COMMENT 'Number of dwelling units, commercial units, or service points at the property (e.g., apartments in a multi-family building).',
    `payment_status` STRING COMMENT 'Status of fee payment for the connection application: unpaid, partially paid, fully paid, waived, or refunded.. Valid values are `unpaid|partial|paid|waived|refunded`',
    `property_type` STRING COMMENT 'Classification of the property requesting service: residential, commercial, industrial, institutional, agricultural, or mixed-use.. Valid values are `residential|commercial|industrial|institutional|agricultural|mixed_use`',
    `rejection_date` DATE COMMENT 'Date when the connection application was rejected or denied by the utility.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the connection application was rejected (e.g., insufficient capacity, incomplete documentation, non-compliance with standards).',
    `requested_service_date` DATE COMMENT 'Date by which the applicant requests the service connection to be activated or completed.',
    `service_address_line1` STRING COMMENT 'Primary street address line where the water or wastewater service connection is requested.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the service location.',
    `service_city` STRING COMMENT 'City or municipality where the service connection is requested.',
    `service_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service connection location for GIS mapping and network planning.',
    `service_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service connection location for GIS mapping and network planning.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code for the service address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service connection is requested.. Valid values are `^[A-Z]{2}$`',
    `technical_review_date` DATE COMMENT 'Date when the technical feasibility and capacity review of the connection application was completed.',
    `total_fees_assessed` DECIMAL(18,2) COMMENT 'Total of all fees assessed for the connection application (application fee, connection fee, capacity charge, and any other charges), in USD.',
    CONSTRAINT pk_connection_application PRIMARY KEY(`connection_application_id`)
) COMMENT 'Tracks customer applications for new service connections, service upgrades, disconnections, and transfers. Captures application date, requested service type, service address, applicant details, connection size requested, estimated flow demand (GPM), application status, review milestones, fees assessed, and approval or rejection details. Supports the new service onboarding workflow and capacity planning. Aligned with Microsoft Dynamics 365 field service request intake.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`order` (
    `order_id` BIGINT COMMENT 'Unique identifier for the service order. Primary key for the service order entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Service orders (turn-on, turn-off, meter change, maintenance) are performed in the context of a service agreement. Adding service_agreement_id FK establishes the agreement context for the service orde',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: Service orders are often generated from approved connection applications (new service installations, upgrades). Adding connection_application_id FK tracks the originating application that triggered th',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service orders require DMA assignment for operational planning, NRW event correlation (service work causing leaks), zone-based work scheduling, and DMA-level service activity tracking. Essential for c',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Service orders for hydrant flushing, flow testing, annual inspection, and fire department coordination reference specific hydrants. Utilities issue service orders against individual hydrants to track ',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Service orders for meter set, turn-on, and replacement directly reference the resulting meter installation. Field service completion workflows, work order closure, and service activation confirmation ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service orders for new connections or upgrades may be contingent on CIP project completion (e.g., service available after main extension project completes). Customer service and field operations need',
    `point_id` BIGINT COMMENT 'Reference to the physical service delivery point (meter location) where the field activity will be performed.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service orders (connect/disconnect/repair) need pressure zone context for crew routing optimization, pressure impact assessment during isolation events, service restoration verification, and zone-base',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this service order.',
    `meter_id` BIGINT COMMENT 'Serial number or identifier of the meter removed during a meter exchange service order.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service orders are executed according to defined SLA standards. order currently has sla_target_hours, sla_actual_hours, and sla_met_flag. The target hours should be derived from sla_definition rather',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Service orders for service line inspection, replacement (especially LCRR lead service line replacement programs), leak repair, and material verification reference specific service lines. LCRR complian',
    `sewer_service_connection_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_service_connection. Business justification: Service orders for sewer connect, disconnect, transfer, and lateral inspection operations must reference the specific sewer service connection being acted upon. Field crews and dispatch systems requir',
    `territory_id` BIGINT COMMENT 'Reference to the field crew or work team assigned to perform the service order.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the field crew completed the service order activity.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the field crew began performing the service order activity.',
    `appointment_window_end` TIMESTAMP COMMENT 'End of the time window communicated to the customer for the service order appointment.',
    `appointment_window_start` TIMESTAMP COMMENT 'Beginning of the time window communicated to the customer for the service order appointment.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the service order activity is billable to the customer account.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the service order was cancelled, if applicable.',
    `completion_date` DATE COMMENT 'Date when the service order was marked as completed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was first created in the system.',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact person for this service order, used for appointment confirmation and access coordination.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact person for appointment confirmation and field crew communication.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service location, used for crew dispatch and asset tracking.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service location, used for crew dispatch and asset tracking.',
    `meter_reading_unit` STRING COMMENT 'Unit of measure for the meter reading value captured during the service order.. Valid values are `gallons|cubic_meters|cubic_feet|liters`',
    `meter_reading_value` DECIMAL(18,2) COMMENT 'Final meter reading captured during the service order activity, measured in appropriate units (gallons, cubic meters, etc.).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was last modified in the system.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the service order, used for customer communication and field crew reference.. Valid values are `^SO-[0-9]{8}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the service order in the field service workflow. [ENUM-REF-CANDIDATE: draft|scheduled|dispatched|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the service order activity. Defines the nature of field work to be performed. [ENUM-REF-CANDIDATE: turn_on|turn_off|reconnection|meter_set|meter_exchange|service_upgrade|final_read|leak_investigation — 8 candidates stripped; promote to reference product]',
    `outcome_code` STRING COMMENT 'Standardized code indicating the final outcome or result of the service order execution.. Valid values are `completed_as_planned|partial_completion|unable_to_complete|customer_not_available|access_denied|equipment_failure`',
    `priority` STRING COMMENT 'Priority level assigned to the service order, determining dispatch sequence and response time requirements.. Valid values are `emergency|urgent|standard|low`',
    `requested_date` DATE COMMENT 'Date when the customer or system requested the service order to be performed.',
    `scheduled_date` DATE COMMENT 'Date when the field crew is scheduled to perform the service order activity.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned date and time when the field crew is expected to complete the service order activity.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the field crew is scheduled to begin the service order activity.',
    `service_address` STRING COMMENT 'Full street address where the field service activity will be performed. Used for crew dispatch and navigation.',
    `service_fee_amount` DECIMAL(18,2) COMMENT 'Monetary charge assessed to the customer for the service order activity, in US dollars.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours elapsed from order creation to completion, used for SLA compliance tracking.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the service order was completed within the target SLA timeframe.',
    `special_instructions` STRING COMMENT 'Additional instructions or notes for the field crew regarding access, safety, or customer requirements.',
    `work_performed_description` STRING COMMENT 'Detailed narrative description of the work actually performed by the field crew, including any findings or issues encountered.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Operational work orders issued to field crews for service-related activities including new service turn-ons, turn-offs, reconnections after non-payment, meter sets, service upgrades, and final reads. Captures order type, scheduled date, completion date, assigned crew, service point reference, work performed, and outcome status. Distinct from asset maintenance work orders (owned by asset domain). Aligned with Oracle CC&B field activity and Microsoft Dynamics 365 field service.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`tariff` (
    `tariff_id` BIGINT COMMENT 'Unique identifier for the regulatory tariff filing record. Primary key.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Tariffs are regulatory filings that authorize specific rate schedules. Regulatory compliance and rate case tracking require linking the approved tariff document to the rate schedules it authorizes for',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tariffs must comply with regulatory requirements (rate structure mandates, affordability requirements, conservation pricing rules). Tariff filings reference compliance with state/federal mandates. Lin',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Tariff filings are class-specific, with separate rate schedules and regulatory approvals for each customer class. The customer_class STRING attribute should be normalized to a FK to service_class, all',
    `superseded_tariff_id` BIGINT COMMENT 'Reference to the prior tariff that this tariff replaces. Establishes the lineage of rate changes and enables historical rate analysis.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Tariffs apply to specific service territories and franchise areas. Currently service_territory is a STRING field describing where the tariff applies. Should be FK to service_territory for referential',
    `adjustment_clause_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes automatic adjustment clauses or riders that allow for rate changes without a full rate case. Common adjustment clauses include purchased water adjustment clauses (PWAC), infrastructure surcharges, and cost recovery mechanisms for specific capital programs.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority formally approved the tariff filing. This date may differ from the effective date due to statutory notice periods or phased implementation.',
    `approval_order_number` STRING COMMENT 'The official order or docket number issued by the regulatory authority approving this tariff. This reference links the tariff to the formal regulatory decision and provides traceability to the rate case proceeding.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'The foundational rate component approved by the regulatory authority, typically expressed as a fixed monthly charge or per-unit volumetric rate. This is the core revenue component before adjustments, surcharges, or riders.',
    `billing_frequency` STRING COMMENT 'The standard billing cycle for customers under this tariff. Defines how often charges are calculated and invoices are issued.. Valid values are `monthly|bimonthly|quarterly|annual`',
    `conservation_rate_flag` BOOLEAN COMMENT 'Indicates whether the tariff incorporates conservation-oriented rate design features such as increasing block rates, seasonal pricing, or water budget-based rates intended to promote efficient water use.',
    `cost_of_service_study_reference` STRING COMMENT 'Reference to the cost-of-service study or rate design analysis that supports the tariff rates. This study allocates utility costs to customer classes and justifies the rate structure to the regulatory authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which tariff rates and charges are denominated. For U.S. water utilities, this is typically USD.. Valid values are `USD`',
    `tariff_description` STRING COMMENT 'A detailed narrative description of the tariff, including its purpose, scope, applicability, and key terms. This field captures the regulatory intent and business context of the tariff.',
    `document_url` STRING COMMENT 'The web address or document management system link to the official tariff filing document, including all schedules, exhibits, and supporting materials. Provides direct access to the complete regulatory record.',
    `effective_date` DATE COMMENT 'The date on which the tariff becomes binding and enforceable. Rates and terms specified in the tariff apply to all qualifying service from this date forward.',
    `expiration_date` DATE COMMENT 'The date on which the tariff ceases to be in force, if applicable. Null for tariffs that remain active until superseded by a subsequent filing.',
    `filing_date` DATE COMMENT 'The date on which the tariff was officially filed with the Public Utilities Commission or state regulatory authority. This date triggers statutory review periods and notice requirements.',
    `hearing_date` DATE COMMENT 'The date of the public hearing or evidentiary proceeding held by the regulatory authority to review the tariff filing. Null if no hearing was required or held.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was most recently updated. Supports change tracking and audit compliance.',
    `low_income_assistance_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes provisions for low-income customer assistance programs, such as lifeline rates, bill discounts, or affordability programs mandated or approved by the regulatory authority.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'The minimum monthly or periodic charge that applies regardless of consumption. Ensures cost recovery for fixed infrastructure and customer service costs.',
    `tariff_name` STRING COMMENT 'The official name or title of the tariff as it appears in regulatory filings and customer communications.',
    `notes` STRING COMMENT 'Free-form text field for additional context, clarifications, or special conditions related to the tariff. May include notes on implementation, transition provisions, or regulatory stipulations.',
    `public_notice_date` DATE COMMENT 'The date on which public notice of the tariff filing was provided to customers and stakeholders, as required by regulatory statute. Public notice periods allow for customer comment and intervention in rate proceedings.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'The net investment in utility plant and working capital upon which the utility is allowed to earn a return. Rate base is calculated as gross plant in service less accumulated depreciation plus working capital allowances.',
    `rate_of_return_percent` DECIMAL(18,2) COMMENT 'The allowed rate of return on rate base approved by the regulatory authority. Expressed as a decimal percentage (e.g., 0.0725 for 7.25%). This is the weighted average cost of capital (WACC) the utility is permitted to earn.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the detailed rate schedule document or section number within the tariff filing that specifies the complete pricing structure, including block tiers, surcharges, and adjustments.',
    `rate_structure_type` STRING COMMENT 'The pricing methodology employed by the tariff. Flat rates charge a fixed amount regardless of usage, uniform rates charge a constant per-unit price, declining block rates decrease with higher usage tiers, increasing block rates increase with higher usage tiers to promote conservation, seasonal rates vary by time of year, and time-of-use rates vary by time of day or demand period.. Valid values are `flat|uniform|declining_block|increasing_block|seasonal|time_of_use`',
    `regulatory_authority` STRING COMMENT 'The name of the Public Utilities Commission, state regulatory agency, or other governing body that has jurisdiction over this tariff filing. Examples include State Public Service Commission, Public Utilities Commission, or Department of Public Utilities.',
    `revenue_requirement_amount` DECIMAL(18,2) COMMENT 'The total annual revenue requirement approved by the regulatory authority for the utility under this tariff. This is the aggregate revenue the utility is authorized to collect to cover operating expenses, capital costs, and allowed return on investment.',
    `service_rules_reference` STRING COMMENT 'Reference to the service rules, terms, and conditions document or section number within the tariff filing that governs service delivery, customer obligations, disconnection policies, and dispute resolution procedures.',
    `tariff_number` STRING COMMENT 'The official regulatory tariff number assigned by the Public Utilities Commission or state regulatory authority. This is the externally-known identifier used in all regulatory filings and rate case proceedings.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `tariff_status` STRING COMMENT 'Current lifecycle status of the tariff filing. Draft indicates internal preparation, filed means submitted to the regulator, pending approval is under regulatory review, approved means accepted by the commission, active is currently in force, suspended is temporarily halted, superseded is replaced by a newer tariff, and withdrawn is retracted before approval. [ENUM-REF-CANDIDATE: draft|filed|pending_approval|approved|active|suspended|superseded|withdrawn — 8 candidates stripped; promote to reference product]',
    `tariff_type` STRING COMMENT 'Classification of the tariff based on the customer segment and service arrangement it governs. General service tariffs apply to standard retail customers, special contracts cover negotiated agreements with large users, wholesale tariffs govern bulk water sales to other utilities, and industrial/municipal/residential/commercial designate specific customer classes. [ENUM-REF-CANDIDATE: general_service|special_contract|wholesale|industrial|municipal|residential|commercial — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_tariff PRIMARY KEY(`tariff_id`)
) COMMENT 'Master record of regulatory tariff filings and associated rate case proceedings with the Public Utilities Commission or state regulatory authority. Captures the full lifecycle from rate case filing (test year, requested revenue requirement, hearing dates, intervenor parties) through approval (final order, approved revenue requirement) to the effective tariff (tariff number, effective date, tariff type, incorporated rate schedules and service rules). This is the regulatory anchor for all rate and service term compliance, linking rate case proceedings to their resulting approved pricing structures. Supports financial planning, regulatory compliance, and rate modeling.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` (
    `conservation_program_id` BIGINT COMMENT 'Unique identifier for the water conservation program record. Primary key.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Conservation programs are frequently scoped to specific DMAs for targeted NRW reduction and demand management. DMA-level leakage metrics (target_nrw_percentage, minimum_night_flow) directly drive cons',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Conservation programs are often mandated by regulatory requirements (drought response orders, demand management mandates, water use efficiency standards). Program design, targets, and reporting tied t',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: A conservation program is often mandated or governed by a specific regulatory tariff (e.g., a tiered pricing tariff that funds the rebate program). The conservation_program table currently stores tari',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Conservation programs are often territory-specific with territory-level water savings targets and regulatory mandates. Adding this link enables territory-based program management and reporting.',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Conservation programs are explicitly designed to protect or reduce withdrawals from specific water sources (drought response, source water protection mandates). Program effectiveness reporting and reg',
    `actual_participant_count` STRING COMMENT 'Current count of customers or accounts enrolled and participating in the conservation program.',
    `actual_water_savings_gallons` BIGINT COMMENT 'Measured or estimated cumulative water savings achieved by the program to date, in gallons.',
    `budget_expended_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of program budget spent as of the last reporting period, in US dollars.',
    `contact_email` STRING COMMENT 'Primary email address for customer inquiries and program communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for customer inquiries and program support.. Valid values are `^+?[0-9]{10,15}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the conservation program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was first created in the system.',
    `customer_class_applicability` STRING COMMENT 'Customer class segments eligible to participate in this conservation program.. Valid values are `residential|commercial|industrial|agricultural|municipal|all`',
    `eligibility_criteria` STRING COMMENT 'Detailed requirements and conditions that customers must meet to participate in the conservation program, including customer class, service type, meter size, and usage thresholds.',
    `enrollment_end_date` DATE COMMENT 'Date when customer enrollment or application for the program closes. Null for open enrollment programs.',
    `enrollment_start_date` DATE COMMENT 'Date when customer enrollment or application for the program opens.',
    `funding_source` STRING COMMENT 'Source of funds supporting the conservation program, such as operating budget, capital improvement program, state grants, or federal funding.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the incentive provided per qualifying customer or installation, in US dollars.',
    `incentive_type` STRING COMMENT 'Type of financial or non-financial incentive offered to customers participating in the program.. Valid values are `rebate|discount|credit|grant|free_equipment|rate_reduction`',
    `incentive_unit` STRING COMMENT 'Unit of measure for calculating and distributing the incentive to program participants.. Valid values are `per_fixture|per_device|per_audit|per_gallon_saved|per_account|lump_sum`',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the conservation program record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was last updated.',
    `last_reported_date` DATE COMMENT 'Date of the most recent performance report submitted for this conservation program.',
    `marketing_campaign_code` STRING COMMENT 'Code linking the conservation program to specific marketing and outreach campaigns for tracking effectiveness.',
    `maximum_incentive_per_customer` DECIMAL(18,2) COMMENT 'Cap on the total incentive amount a single customer can receive under this program during the program period, in US dollars.',
    `performance_metric_definition` STRING COMMENT 'Description of the key performance indicators (KPIs) used to measure program success, such as gallons saved per dollar spent or participation rate.',
    `program_category` STRING COMMENT 'Target sector or application area for the conservation program.. Valid values are `indoor|outdoor|commercial|industrial|agricultural|residential`',
    `program_code` STRING COMMENT 'Unique business identifier code for the conservation program, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_description` STRING COMMENT 'Detailed description of the conservation program objectives, activities, and benefits to customers and the utility.',
    `program_end_date` DATE COMMENT 'Date when the conservation program concludes and no new participants are accepted. Null for ongoing programs.',
    `program_name` STRING COMMENT 'Full descriptive name of the conservation program as presented to customers and in regulatory filings.',
    `program_notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the conservation program administration and operations.',
    `program_start_date` DATE COMMENT 'Date when the conservation program becomes active and customers can begin participating.',
    `program_status` STRING COMMENT 'Current lifecycle status of the conservation program.. Valid values are `draft|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the conservation program by delivery mechanism and approach. [ENUM-REF-CANDIDATE: rebate|tiered_pricing|water_audit|drought_surcharge|education|restriction|incentive — 7 candidates stripped; promote to reference product]',
    `program_website_url` STRING COMMENT 'Web address where customers can find detailed program information, eligibility requirements, and application forms.',
    `regulatory_approval_date` DATE COMMENT 'Date when the conservation program received regulatory approval from the governing authority.',
    `regulatory_approval_number` STRING COMMENT 'Approval or permit number issued by the state Public Utilities Commission or environmental agency authorizing the program.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the conservation program is required by state or federal regulation (True) or is voluntary (False).',
    `regulatory_mandate_reference` STRING COMMENT 'Citation or reference to the specific regulation, statute, or executive order requiring or authorizing the conservation program.',
    `reporting_frequency` STRING COMMENT 'Frequency at which program performance and results are reported to regulatory agencies and utility management.. Valid values are `monthly|quarterly|annually|on_demand`',
    `target_participant_count` STRING COMMENT 'Goal for the number of customers or accounts participating in the conservation program.',
    `target_water_savings_gallons` BIGINT COMMENT 'Projected total water savings goal for the program over its duration, measured in gallons.',
    `total_program_budget` DECIMAL(18,2) COMMENT 'Total allocated budget for the conservation program over its entire duration, in US dollars.',
    CONSTRAINT pk_conservation_program PRIMARY KEY(`conservation_program_id`)
) COMMENT 'Master catalog of customer programs including water conservation programs (rebates, tiered pricing incentives, water audits, drought surcharges), demand management programs, and customer affordability/assistance programs (lifeline rates, PIPP, bill discounts, emergency assistance). Captures program name, program type, eligibility criteria (including income thresholds for affordability programs), incentive or benefit structure, funding source, program period, target outcomes, enrollment tracking, and regulatory mandate reference. Supports AWWA water efficiency goals, state conservation mandates, and regulatory affordability requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'Primary key for the program_enrollment association',
    `agreement_id` BIGINT COMMENT 'Foreign key linking this enrollment record to the specific service agreement (customer account + service location) that is participating in the conservation program.',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking this enrollment record to the specific conservation or assistance program the service agreement is enrolled in.',
    `enrollment_date` DATE COMMENT 'The date on which the service agreement was formally enrolled in the conservation program. Belongs to the enrollment event, not to the agreement or the program catalog.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this specific enrollment record. Tracks whether the customers participation in this program is active, pending approval, suspended, completed, or cancelled. Belongs to the enrollment, not to the agreement or program.',
    `incentive_amount_awarded` DECIMAL(18,2) COMMENT 'The actual monetary incentive amount awarded to this service agreement under this specific program enrollment. May differ from the programs standard incentive_amount due to partial qualification, caps, or pro-ration. Belongs to the enrollment record, not to the program catalog or the agreement.',
    `participation_end_date` DATE COMMENT 'The date on which the customers active participation in the program ended or is scheduled to end. Null for ongoing open-ended enrollments. Belongs to the enrollment record, not to the programs overall end date.',
    `participation_start_date` DATE COMMENT 'The date on which the customers active participation in the program began (e.g., device installation date for a rebate program, or first billing cycle under a tiered incentive). May differ from enrollment_date if there is an approval or installation lag.',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'This association product represents the Enrollment event between a service agreement and a conservation program. It captures the operational record of a customer account (via their service agreement) participating in a utility-sponsored or regulatory-mandated conservation, demand management, or affordability assistance program. Each record links one service agreement to one conservation program and carries enrollment-specific attributes — dates, status, and incentive disbursement — that exist only in the context of this participation relationship. Supports AWWA water efficiency reporting, state conservation mandate compliance, and affordability program administration.. Existence Justification: In water utilities, customers (via their service agreements) actively enroll in conservation programs such as rebate programs, water audits, tiered pricing incentives, and affordability assistance programs. A single service agreement can be enrolled in multiple conservation programs simultaneously (e.g., a low-income customer enrolled in both a PIPP affordability program and a water audit rebate program), and each conservation program has many enrolled service agreements. The business actively manages these enrollments — creating, updating, and closing enrollment records — with specific enrollment dates, statuses, and incentive disbursement amounts that belong to neither the agreement nor the program alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_superseded_tariff_id` FOREIGN KEY (`superseded_tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ADD CONSTRAINT `fk_service_program_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ADD CONSTRAINT `fk_service_program_enrollment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `ami_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `backflow_prevention_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `capacity_charge` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `connection_fee` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `conservation_program_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'metered|unmetered|flat_rate|seasonal|temporary|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `fire_protection_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Capacity in Gallons per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `late_payment_penalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|retired|grandfathered');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `minimum_monthly_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Monthly Charge');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `pressure_range_psi_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `pressure_range_psi_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'uniform|tiered|seasonal|time_of_use|demand_based');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `sla_restoration_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Restoration Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `volumetric_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `volumetric_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `volumetric_rate_unit` SET TAGS ('dbx_value_regex' = 'kgal|ccf|gallon|cubic_meter|acre_foot');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `water_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Standard');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for service_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_ssot_owner' = 'billing.billing_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `facility_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `facility_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `area_square_miles` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Miles');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `average_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `commercial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `industrial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Industrial Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `npdes_permit_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `operating_division_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Division Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `peak_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `potable_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Potable Water Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `predecessor_utility_name` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Utility Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `predecessor_utility_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `primacy_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `rate_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `recycled_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Recycled Water Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `residential_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Residential Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_center_location` SET TAGS ('dbx_business_glossary_term' = 'Service Center Location');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_business_glossary_term' = 'Service Classification');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|mixed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `stormwater_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `tariff_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired|transferred');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'franchise|certificated|contract|wholesale|retail|combined');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `wastewater_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_ssot_owner' = 'asset.asset_class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `average_monthly_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Consumption in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `awwa_classification_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Classification Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual|on_demand');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Service Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Service Class Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Service Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_type` SET TAGS ('dbx_business_glossary_term' = 'Service Class Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `conservation_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `consumption_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Consumption Tier Structure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `consumption_tier_structure` SET TAGS ('dbx_value_regex' = 'flat|tiered|seasonal|time_of_use');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `deposit_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `disconnection_policy` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Policy');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `disconnection_policy` SET TAGS ('dbx_value_regex' = 'standard|protected|restricted');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `drought_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drought Surcharge Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `fire_flow_requirement_gpm` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Requirement in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `meter_size_range` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Range');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `minimum_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Class Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `peak_demand_factor` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Factor');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `pressure_requirement_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Requirement in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `puc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utilities Commission (PUC) Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `puc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Public Utilities Commission (PUC) Filing Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `rate_schedule_group` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Group');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `renewal_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `seasonal_rate_applicable` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Rate Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_business_glossary_term' = 'Service Class Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|deprecated|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|critical');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `tariff_classification` SET TAGS ('dbx_business_glossary_term' = 'Tariff Classification');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `budget_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'required|held|waived|refunded|forfeited');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `fire_protection_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `industrial_user_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `irrigation_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Irrigation Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `low_income_assistance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `low_income_assistance_eligible` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `minimum_usage_commitment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Minimum Usage Commitment in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `paperless_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `senior_citizen_discount_eligible` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Discount Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `sla_restoration_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Restoration Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CCB|CIS|ERP|LEGACY');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions and Terms');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `ami_enabled` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `backflow_device_type` SET TAGS ('dbx_business_glossary_term' = 'Backflow Device Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `backflow_device_type` SET TAGS ('dbx_value_regex' = 'rpz|dcva|pvb|ag|none|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `connection_material` SET TAGS ('dbx_business_glossary_term' = 'Connection Material');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `connection_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Connection Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `curb_stop_location` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Location');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `estimated_daily_demand_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Daily Demand (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `fire_service_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fire Service Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|shared|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `peak_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (Gallons Per Minute - GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_description` SET TAGS ('dbx_business_glossary_term' = 'Service Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_business_glossary_term' = 'Service Point Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_value_regex' = '^SP[0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|disconnected|abandoned');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater|recycled_water|stormwater|combined');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `ami_enabled` SET TAGS ('dbx_business_glossary_term' = 'AMI (Advanced Metering Infrastructure) Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_connection|service_upgrade|disconnection|transfer|reconnection|temporary_service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `capacity_available` SET TAGS ('dbx_business_glossary_term' = 'Capacity Available');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `capacity_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `connection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `connection_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Connection Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `estimated_flow_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Estimated Flow Demand (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `infrastructure_upgrade_required` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Upgrade Required');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `meter_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Meter Type Requested');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|waived|refunded');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|mixed_use');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `technical_review_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `total_fees_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Assessed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `appointment_window_end` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window End Time');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `appointment_window_start` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Order Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `meter_reading_unit` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `meter_reading_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_meters|cubic_feet|liters');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `meter_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Value');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Service Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Service Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Service Order Outcome Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_value_regex' = 'completed_as_planned|partial_completion|unable_to_complete|customer_not_available|access_denied|equipment_failure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Service Order Priority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|urgent|standard|low');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `superseded_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Tariff Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `adjustment_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Clause Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `approval_order_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `conservation_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `cost_of_service_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Cost of Service Study Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Tariff Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_of_return_percent` SET TAGS ('dbx_business_glossary_term' = 'Rate of Return Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_of_return_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'flat|uniform|declining_block|increasing_block|seasonal|time_of_use');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `service_rules_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Rules Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `actual_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Participant Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `actual_water_savings_gallons` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Savings (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `budget_expended_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expended To Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_business_glossary_term' = 'Customer Class Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|all');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|credit|grant|free_equipment|rate_reduction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Unit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_value_regex' = 'per_fixture|per_device|per_audit|per_gallon_saved|per_account|lump_sum');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `maximum_incentive_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Incentive Per Customer');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `performance_metric_definition` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Definition');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|commercial|industrial|agricultural|residential');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_mandate_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `target_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Target Participant Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `target_water_savings_gallons` SET TAGS ('dbx_business_glossary_term' = 'Target Water Savings (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `total_program_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Program Budget');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` SET TAGS ('dbx_association_edges' = 'service.agreement,service.conservation_program');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Program Enrollment Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Agreement Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Conservation Program Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `incentive_amount_awarded` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Awarded');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_enrollment` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
