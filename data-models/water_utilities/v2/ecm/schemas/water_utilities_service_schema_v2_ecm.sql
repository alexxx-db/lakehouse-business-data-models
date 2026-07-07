-- Schema for Domain: service | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`service` COMMENT 'Defines the catalog of water and wastewater services, rate structures, service tiers, contractual terms, service level agreements (SLAs), and service delivery configurations. Manages the relationship between service offerings and customer accounts, supporting rate case modeling and regulatory tariff compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the service offering. Primary key for the offering product. Ref: AWWA.',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether this offering requires or supports Advanced Metering Infrastructure (AMI) for automated meter reading and real-time consumption monitoring. True = AMI required or available; False = manual or Automatic Meter Reading (AMR) only. Ref: AWWA.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the service contract automatically renews at the end of the contract term. True = auto-renews unless customer cancels; False = requires explicit renewal. Null if not applicable. Ref: AWWA.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for this offering to protect the public water supply from contamination. True = backflow prevention required (common for commercial, industrial, and recycled water services); False = not required. Ref: AWWA.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic base charge for the service offering, independent of consumption. Covers fixed costs such as meter maintenance, billing, and infrastructure access. Expressed in local currency (USD for U.S. utilities). Ref: AWWA.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle or schedule applicable to this offering. Examples: MNTH (monthly), QRTR (quarterly), BIMON (bi-monthly). Aligns with Oracle Utilities Customer Care and Billing (CC&B) billing cycle configuration. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    `capacity_charge` DECIMAL(18,2) COMMENT 'Fee for reserving system capacity or infrastructure access, common in industrial and municipal bulk water agreements. May be based on meter size, peak demand, or contracted volume. Also known as a demand charge or readiness-to-serve charge. Ref: AWWA.',
    `offering_code` STRING COMMENT 'Externally-known unique code for the service offering used in billing systems, tariff schedules, and customer communications. Examples: WTR-RES-01, WWC-COM-02, RCW-IND-01. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,12}$`',
    `connection_fee` DECIMAL(18,2) COMMENT 'One-time fee charged to establish a new service connection, including meter installation, service line connection, and administrative setup. May vary by customer class and service type. Ref: AWWA.',
    `conservation_program_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers enrolled in this offering are eligible for water conservation programs, rebates, or incentives (e.g., low-flow fixture rebates, landscape conversion incentives). True = eligible; False = not eligible. Ref: AWWA.',
    `contract_term_months` STRING COMMENT 'Standard contract duration in months for this offering. Common for commercial, industrial, and municipal agreements. Null for month-to-month residential service. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was first created in the system. Used for audit trail and data lineage tracking. Ref: AWWA.',
    `customer_class` STRING COMMENT 'Customer segment or class to which this offering applies. Determines rate structure, service level expectations, and regulatory treatment. Residential = single-family and multi-family homes; Commercial = businesses and offices; Industrial = manufacturing and heavy water users; Municipal = government facilities; Agricultural = farms and irrigation; Institutional = schools, hospitals, non-profits. Ref: AWWA.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `delivery_mode` STRING COMMENT 'Method by which the service is delivered and billed. Metered = consumption-based billing via Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR); Unmetered = fixed-rate service without consumption measurement; Flat rate = fixed periodic charge regardless of usage; Seasonal = service active only during specific periods; Temporary = short-term service for construction or events; Emergency = contingency supply during outages or disasters. Ref: AWWA.. Valid values are `metered|unmetered|flat_rate|seasonal|temporary|emergency`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new customers. May vary based on estimated usage, customer class, or credit assessment. Null if no deposit is required. Ref: AWWA.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for new customers enrolling in this offering. True = deposit required; False = no deposit. Deposit policies vary by customer class and credit history. Ref: AWWA.',
    `offering_description` STRING COMMENT 'Detailed description of the service offering including scope, delivery specifications, and any special conditions or limitations. Used in customer agreements and regulatory filings. Ref: AWWA.',
    `dummy_attribute` STRING COMMENT 'The dummy attribute value recorded for each offering in the service domain.',
    `effective_end_date` DATE COMMENT 'Date on which the offering is no longer available for new customer enrollment. Null for open-ended offerings. Existing customers may continue under grandfathered terms. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date on which the offering becomes available for customer enrollment and billing. Aligns with regulatory approval and operational readiness. Ref: AWWA.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this offering includes dedicated fire protection service (e.g., fire hydrant access, private fire line). True = fire protection included; False = potable water or wastewater service only. Ref: AWWA.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum sustained flow rate in Gallons per Minute (GPM) that the utility can deliver for this offering under normal conditions. Relevant for fire protection, industrial, and bulk water services. Null for standard residential metered service. Ref: AWWA.',
    `late_payment_penalty_percent` DECIMAL(18,2) COMMENT 'Percentage penalty applied to overdue balances after the payment due date. Subject to Public Utilities Commission regulations. Null if no late fee applies. Ref: AWWA.',
    `lifecycle_status` STRING COMMENT 'Current state of the offering in its lifecycle. Active = available for new customer enrollment; Inactive = temporarily unavailable; Pending approval = awaiting regulatory or internal approval; Suspended = on hold due to operational or regulatory issues; Retired = no longer offered to new customers; Grandfathered = legacy offering maintained only for existing customers under prior tariff terms. Ref: AWWA.. Valid values are `active|inactive|pending_approval|suspended|retired|grandfathered`',
    `meter_size_required_inches` DECIMAL(18,2) COMMENT 'Standard meter size in inches required or recommended for this offering based on expected flow and customer class. Common sizes: 0.625 (5/8 inch), 0.75 (3/4 inch), 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches. Null for unmetered service. Ref: AWWA.',
    `minimum_monthly_charge` DECIMAL(18,2) COMMENT 'Minimum amount a customer will be billed each billing period, regardless of consumption. Ensures cost recovery for fixed infrastructure and service availability. Null if no minimum applies. Ref: AWWA.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this offering record. Used for audit trail and accountability. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was last modified. Used for audit trail, change tracking, and data synchronization. Ref: AWWA.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each offering in the service domain.',
    `offering_name` STRING COMMENT 'Human-readable name of the service offering as presented to customers and in regulatory tariff filings. Examples: Residential Potable Water Service, Commercial Wastewater Collection, Industrial Recycled Water Supply. Ref: AWWA.',
    `pressure_range_psi_max` STRING COMMENT 'Maximum water pressure in PSI at the customer service connection under normal operating conditions. Excessive pressure may require Pressure Reducing Valve (PRV) installation. Null for wastewater or non-pressurized services. Ref: AWWA.',
    `pressure_range_psi_min` STRING COMMENT 'Minimum water pressure in PSI guaranteed at the customer service connection under normal operating conditions. Part of service delivery specifications. Null for wastewater or non-pressurized services. Ref: AWWA.',
    `rate_structure_type` STRING COMMENT 'Pricing model applied to the offering. Uniform = single rate for all consumption; Tiered = increasing or decreasing rates by consumption block (e.g., conservation pricing); Seasonal = rates vary by season (summer vs. winter); Time of use = rates vary by time of day or peak demand periods; Demand-based = charges based on peak flow or capacity reservation. Ref: AWWA.. Valid values are `uniform|tiered|seasonal|time_of_use|demand_based`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the offering and its associated rate structure received regulatory approval from the Public Utilities Commission or other governing authority. Required for compliance with rate case documentation and audit trails. Ref: AWWA.',
    `service_domain_verified_flag` BOOLEAN COMMENT 'Marker attribute confirming service domain VREQ-016 coverage. Ref: AWWA.',
    `service_type` STRING COMMENT 'Primary category of water or wastewater service provided. Potable water = treated drinking water supply; Wastewater collection = sanitary sewer service; Recycled water = reclaimed water for non-potable uses; Fire protection = dedicated fire suppression service; Bulk water = wholesale or large-volume supply; Stormwater = stormwater management and drainage. Ref: AWWA.. Valid values are `potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater`',
    `sla_response_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to respond to service requests, outages, or quality complaints for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies. Ref: AWWA.',
    `sla_restoration_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to restore service following an outage or interruption for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies. Ref: AWWA.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for customer to terminate or discontinue service. Common for commercial and industrial contracts. Null for standard residential service. Ref: AWWA.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added to satisfy VIBE requirement for target touch. Ref: AWWA.',
    `volumetric_rate_amount` DECIMAL(18,2) COMMENT 'Per-unit charge for water or wastewater service based on consumption volume. Typically expressed in dollars per thousand gallons ($/kgal) or dollars per hundred cubic feet ($/CCF). Null for unmetered or flat-rate offerings. Ref: AWWA.',
    `volumetric_rate_unit` DECIMAL(18,2) COMMENT 'Unit of measure for volumetric billing. kgal = thousand gallons; CCF = hundred cubic feet; gallon = individual gallon; cubic meter = m³ (common in international contexts); acre-foot = volume unit for large agricultural or municipal contracts. Ref: AWWA.',
    `water_quality_standard` STRING COMMENT 'Applicable water quality standard or regulatory compliance framework for this offering. Examples: Safe Drinking Water Act (SDWA) Primary Standards, Recycled Water Quality Standards (Title 22 California), Industrial Discharge Permit Limits. Null for non-water offerings (e.g., wastewater collection). Ref: AWWA.',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master catalog of all water and wastewater service offerings available to customers, including potable water supply, wastewater collection, recycled water, fire protection, irrigation, and bulk water services. Defines the canonical service type, delivery mode, applicable customer classes (residential, commercial, industrial, municipal), regulatory tariff reference, connection fee schedule, service tier options, and lifecycle status. This is the SSOT for what Water Utilities offers in the market and the anchor entity for rate schedules, SLAs, and service agreements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` (
    `service_rate_schedule_id` DECIMAL(18,2) COMMENT 'Unique identifier for the service_rate_schedule data product (auto-inserted pre-linking). Ref: Oracle CC&B.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the approved by regulatory agency referenced by each service rate schedule record in the service domain.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.rate_case. Business justification: Rate schedules are approved through rate case proceedings. Essential for tracking regulatory approval, effective dates, and revenue requirement allocation across customer classes. Required for PUC com. Ref: Oracle CC&B.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service rate schedules define approved tariff rate structures for specific service offerings. Currently has rate_case_id but missing the offering link. Rate schedules must be tied to the offerings the. Ref: Oracle CC&B.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Rate schedules are applied by customer service class (residential, commercial, industrial, etc.). Each rate schedule should specify which service class it applies to. This is a standard water utility. Ref: Oracle CC&B.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the service created by employee referenced by each service rate schedule record in the service domain.',
    `service_rate_case_id` DECIMAL(18,2) COMMENT 'Unique identifier for the service rate case referenced by each service rate schedule record in the service domain.',
    `service_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the service responsible employee referenced by each service rate schedule record in the service domain.',
    `superseded_by_schedule_id` DECIMAL(18,2) COMMENT 'FK to service.service_rate_schedule (superseding). Ref: Oracle CC&B.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Rate schedules implement approved regulatory tariffs. In water utilities, tariffs are filed with and approved by the Public Utilities Commission, then rate schedules operationalize those tariffs. serv. Ref: Oracle CC&B.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Rate schedules can vary by geographic territory due to different franchise agreements, cost structures, or regulatory jurisdictions. Water utilities often have territory-specific rate schedules. This. Ref: Oracle CC&B.',
    `billing_billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Reference to primary billing.billing_rate_schedule for SSOT alignment. Ref: Oracle CC&B.',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key to SSOT entity billing.billing_rate_schedule. Ref: Oracle CC&B.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each service rate schedule in the service domain.',
    `approval_authority` STRING COMMENT 'Governing body or commission that approved the rate schedule. Ref: Oracle CC&B.',
    `approval_date` TIMESTAMP COMMENT 'Date of commission/board approval. Ref: Oracle CC&B.',
    `approved_by_commission` BOOLEAN COMMENT 'Whether approved by rate commission/board. Ref: Oracle CC&B.',
    `approved_date` TIMESTAMP COMMENT 'Date the rate schedule was approved by the governing body. Ref: Oracle CC&B.',
    `approved_flag` BOOLEAN COMMENT 'The approved flag value recorded for each service rate schedule in the service domain.',
    `base_charge` DECIMAL(18,2) COMMENT 'The base charge value recorded for each service rate schedule in the service domain.',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Fixed base or minimum charge amount per billing period. Ref: Oracle CC&B.',
    `base_charge_monthly` DECIMAL(18,2) COMMENT 'Monthly base/fixed charge. Ref: Oracle CC&B.',
    `base_charge_usd` DECIMAL(18,2) COMMENT 'The base charge usd value recorded for each service rate schedule in the service domain.',
    `billing_frequency` STRING COMMENT 'Billing frequency: Monthly, Bi-Monthly, Quarterly. Ref: Oracle CC&B.',
    `billing_period_type` STRING COMMENT 'Monthly, bi-monthly, quarterly. Ref: Oracle CC&B.',
    `billing_unit` STRING COMMENT 'Unit of measure for volumetric billing (CCF, 1000_gallons, cubic_meter). Ref: Oracle CC&B.',
    `service_rate_schedule_category` STRING COMMENT 'The service rate schedule category value recorded for each service rate schedule in the service domain.',
    `classification` STRING COMMENT 'The classification value recorded for each service rate schedule in the service domain.',
    `service_rate_schedule_code` STRING COMMENT 'The service rate schedule code value recorded for each service rate schedule in the service domain.',
    `comments` STRING COMMENT 'The comments value recorded for each service rate schedule in the service domain.',
    `commodity_charge_description` DECIMAL(18,2) COMMENT 'Description of commodity charge structure. Ref: Oracle CC&B.',
    `commodity_rate_per_ccf` DECIMAL(18,2) COMMENT 'Commodity rate per CCF. Ref: Oracle CC&B.',
    `commodity_rate_per_gallon` DECIMAL(18,2) COMMENT 'Commodity rate per gallon. Ref: Oracle CC&B.',
    `commodity_rate_per_unit` DECIMAL(18,2) COMMENT 'Commodity rate per unit of consumption. Ref: Oracle CC&B.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each service rate schedule in the service domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code (USD, EUR, GBP)',
    `customer_class` STRING COMMENT 'Customer class (residential, commercial, industrial, wholesale). Ref: Oracle CC&B.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each service rate schedule in the service domain.',
    `demand_charge_rate` DECIMAL(18,2) COMMENT 'Demand charge rate per unit of peak demand. Ref: Oracle CC&B.',
    `service_rate_schedule_description` STRING COMMENT 'Narrative description of the rate schedule and its applicability. Ref: Oracle CC&B.',
    `effective_date` TIMESTAMP COMMENT 'Date schedule becomes effective. Ref: Oracle CC&B.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Oracle CC&B.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Oracle CC&B.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each service rate schedule record in the service domain.',
    `expiration_date` TIMESTAMP COMMENT 'Date schedule expires. Ref: Oracle CC&B.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: Oracle CC&B.',
    `includes_recycled_water` BOOLEAN COMMENT 'Whether schedule includes recycled water charges. Ref: Oracle CC&B.',
    `includes_stormwater` BOOLEAN COMMENT 'Whether schedule includes stormwater charges. Ref: Oracle CC&B.',
    `includes_wastewater` BOOLEAN COMMENT 'Whether schedule includes wastewater charges. Ref: Oracle CC&B.',
    `infrastructure_access_charge` DECIMAL(18,2) COMMENT 'Infrastructure access charge per billing period. Ref: Oracle CC&B.',
    `infrastructure_charge` DECIMAL(18,2) COMMENT 'Infrastructure/system charge per billing period. Ref: Oracle CC&B.',
    `is_active` BOOLEAN COMMENT 'Whether schedule is currently active. Ref: Oracle CC&B.',
    `is_conservation_rate` DECIMAL(18,2) COMMENT 'Whether this rate schedule incorporates conservation pricing signals. Ref: Oracle CC&B.',
    `is_current` BOOLEAN COMMENT 'Flag indicating this is the currently active rate schedule. Ref: Oracle CC&B.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction. Ref: Oracle CC&B.',
    `low_income_discount_pct` DECIMAL(18,2) COMMENT 'Discount percentage for low-income customers. Ref: Oracle CC&B.',
    `minimum_bill_amount` DECIMAL(18,2) COMMENT 'Minimum bill amount. Ref: Oracle CC&B.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge per billing period. Ref: Oracle CC&B.',
    `service_rate_schedule_name` STRING COMMENT 'The service rate schedule name used to identify each service rate schedule record in the service domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Oracle CC&B.',
    `number_of_tiers` STRING COMMENT 'Number of rate tiers. Ref: Oracle CC&B.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each service rate schedule in the service domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each service rate schedule in the service domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each service rate schedule in the service domain.',
    `rate_case_reference` STRING COMMENT 'Reference to rate case that established schedule. Ref: Oracle CC&B.',
    `rate_class` STRING COMMENT 'The rate class value recorded for each service rate schedule in the service domain.',
    `rate_schedule_code` DECIMAL(18,2) COMMENT 'The rate schedule code value recorded for each service rate schedule in the service domain.',
    `rate_schedule_name` DECIMAL(18,2) COMMENT 'The rate schedule name used to identify each service rate schedule record in the service domain.',
    `rate_schedule_status` DECIMAL(18,2) COMMENT 'The rate schedule status value recorded for each service rate schedule in the service domain.',
    `rate_schedule_type` DECIMAL(18,2) COMMENT 'Volumetric, flat, tiered, seasonal. Ref: Oracle CC&B.',
    `rate_structure_type` STRING COMMENT 'Structure (uniform, inclining_block, declining_block, seasonal, budget_based). Ref: Oracle CC&B.',
    `rate_type` DECIMAL(18,2) COMMENT 'The rate type value recorded for each service rate schedule in the service domain.',
    `rate_unit` DECIMAL(18,2) COMMENT 'Per gallon, per CCF, per cubic meter. Ref: Oracle CC&B.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Oracle CC&B.',
    `record_status` STRING COMMENT 'The record status value recorded for each service rate schedule in the service domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each service rate schedule in the service domain.',
    `regulatory_approval_date` TIMESTAMP COMMENT 'Date the rate schedule was approved by the regulatory authority. Ref: Oracle CC&B.',
    `regulatory_docket_number` STRING COMMENT 'Regulatory docket or case number for rate approval. Ref: Oracle CC&B.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each service rate schedule in the service domain.',
    `regulatory_surcharge` DECIMAL(18,2) COMMENT 'Regulatory compliance surcharge. Ref: Oracle CC&B.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each service rate schedule record in the service domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each service rate schedule in the service domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each service rate schedule in the service domain.',
    `schedule_code` STRING COMMENT 'Unique rate schedule code. Ref: Oracle CC&B.',
    `schedule_name` STRING COMMENT 'Descriptive name of rate schedule. Ref: Oracle CC&B.',
    `schedule_number` STRING COMMENT 'The schedule number value recorded for each service rate schedule in the service domain.',
    `schedule_status` STRING COMMENT 'The schedule status value recorded for each service rate schedule in the service domain.',
    `schedule_type` STRING COMMENT 'Volumetric, flat rate, tiered, inclining block, declining block, seasonal. Ref: Oracle CC&B.',
    `service_canonical_billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Reference FK to canonical SSOT billing.billing_rate_schedule. Ref: Oracle CC&B.',
    `service_rate_schedule_number` STRING COMMENT 'The service rate schedule number value recorded for each service rate schedule in the service domain.',
    `service_rate_schedule_type` STRING COMMENT 'The service rate schedule type value recorded for each service rate schedule in the service domain.',
    `service_type` STRING COMMENT 'Service type (water, sewer, reclaimed, stormwater). Ref: Oracle CC&B.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: Oracle CC&B.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each service rate schedule record in the service domain.',
    `service_rate_schedule_status` STRING COMMENT 'Lifecycle status of the record. Ref: Oracle CC&B.',
    `tier_count` STRING COMMENT 'The tier count value recorded for each service rate schedule in the service domain.',
    `tier_structure` STRING COMMENT 'Tier structure type: Flat, Inclining Block, Declining Block, Seasonal. Ref: Oracle CC&B.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each service rate schedule in the service domain.',
    `units_of_measure` STRING COMMENT 'Units of measure for consumption billing: CCF, HCF, Gallons, Cubic Feet. Ref: Oracle CC&B.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Oracle CC&B.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: Oracle CC&B.',
    `volume_unit` STRING COMMENT 'Unit for volumetric rate: CCF, gallon, cubic metre. Ref: Oracle CC&B.',
    `volumetric_rate` DECIMAL(18,2) COMMENT 'The volumetric rate value recorded for each service rate schedule in the service domain.',
    `volumetric_rate_per_kgal` STRING COMMENT 'Volumetric rate per 1000 gallons. Ref: Oracle CC&B.',
    `volumetric_rate_per_unit` DECIMAL(18,2) COMMENT 'Default volumetric rate per unit of consumption (e.g., per 1000 gallons or per CCF). Ref: Oracle CC&B.',
    `volumetric_rate_usd` DECIMAL(18,2) COMMENT 'The volumetric rate usd value recorded for each service rate schedule in the service domain.',
    CONSTRAINT pk_service_rate_schedule PRIMARY KEY(`service_rate_schedule_id`)
) COMMENT 'Defines the approved tariff rate structures for each service offering, including tiered volumetric rates (with tier thresholds, unit prices, and tier sequences), flat fees, demand charges, seasonal rate adjustments, and minimum charges. Captures the rate case approval date, effective and expiration dates, regulatory authority, rate code, applicable customer class, and billing unit of measure. Tier definitions (inclining block, declining block, uniform) are maintained as structured components within each schedule. Supports rate case modeling and regulatory tariff compliance. Aligned with Oracle CC&B rate schedule configuration. [SSOT: reference view of canonical billing.billing_rate_schedule] SSOT master for rate schedules. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key. Ref: AWWA.',
    `acquisition_date` DATE COMMENT 'Date when the utility acquired this service territory through purchase, merger, or regulatory transfer from another provider. Ref: AWWA.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the service territory measured in square miles. Ref: AWWA.',
    `average_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Average daily water demand for the territory measured in million gallons per day, used for capacity planning and regulatory reporting. Ref: AWWA.',
    `boundary_description` STRING COMMENT 'Textual description of the territory boundary using legal descriptions, street names, or geographic landmarks. Ref: AWWA.',
    `territory_code` STRING COMMENT 'Externally-known unique code identifying the service territory, used in regulatory filings and franchise agreements. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `commercial_customer_count` STRING COMMENT 'Number of commercial customer accounts within the territory. Ref: AWWA.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the territory is located (e.g., USA).. Valid values are `^[A-Z]{3}$`',
    `county_name` STRING COMMENT 'Primary county in which the service territory is located, used for regulatory reporting and jurisdictional analysis. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was first created in the system. Ref: AWWA.',
    `customer_count` STRING COMMENT 'Total number of active customer accounts (service connections) within the territory. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when the utilitys authorization to serve this territory expires or was terminated. Null for active territories with no expiration. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when the utility began providing service in this territory or when the current franchise agreement became effective. Ref: AWWA.',
    `emergency_contact_phone` STRING COMMENT 'Primary emergency contact phone number for service issues or outages in this territory, published to customers and regulatory agencies. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `franchise_agreement_number` STRING COMMENT 'Identifier of the regulatory franchise agreement or certificate of public convenience and necessity (CPCN) authorizing service in this territory. Ref: AWWA.',
    `franchise_expiration_date` DATE COMMENT 'Date when the current franchise agreement or certificate expires and requires renewal or renegotiation. Ref: AWWA.',
    `gis_boundary_reference` BOOLEAN COMMENT 'Reference identifier or feature class name in Esri ArcGIS for the polygon geometry defining the territory boundary. Ref: AWWA.',
    `industrial_customer_count` STRING COMMENT 'Number of industrial customer accounts within the territory. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was last updated in the system. Ref: AWWA.',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory (e.g., Downtown District, North County Service Area). Ref: AWWA.',
    `notes` STRING COMMENT 'Free-form notes capturing special conditions, historical context, or operational considerations for this service territory. Ref: AWWA.',
    `npdes_permit_jurisdiction` STRING COMMENT 'Regulatory authority responsible for wastewater discharge permits under the Clean Water Act (CWA) in this territory. Ref: AWWA.',
    `operating_division_code` STRING COMMENT 'Internal code identifying the utilitys operating division or business unit responsible for service delivery in this territory. Ref: AWWA.',
    `peak_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Peak daily water demand for the territory measured in million gallons per day, used for infrastructure sizing and emergency planning. Ref: AWWA.',
    `population_served` STRING COMMENT 'Estimated total population residing within the service territory, used for regulatory reporting and capacity planning. Ref: AWWA.',
    `potable_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides potable (drinking) water service within this territory. Ref: AWWA.',
    `predecessor_utility_name` STRING COMMENT 'Name of the previous utility that served this territory before acquisition or transfer, used for historical data lineage. Ref: AWWA.',
    `primacy_agency_jurisdiction` STRING COMMENT 'State or federal agency with primary regulatory authority over drinking water quality in this territory (e.g., California State Water Resources Control Board). Ref: AWWA.',
    `rate_zone_code` STRING COMMENT 'Code identifying the rate zone or pricing district applicable to customers in this territory. Ref: AWWA.',
    `recycled_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides recycled (reclaimed) water service for non-potable uses within this territory. Ref: AWWA.',
    `regulatory_authority_name` STRING COMMENT 'Name of the state or local regulatory body with jurisdiction over rates and service quality in this territory (e.g., California Public Utilities Commission). Ref: AWWA.',
    `residential_customer_count` STRING COMMENT 'Number of residential customer accounts within the territory. Ref: AWWA.',
    `service_center_location` STRING COMMENT 'Name or identifier of the primary service center or operations facility serving this territory. Ref: AWWA.',
    `service_classification` STRING COMMENT 'Geographic and demographic classification of the territory, used for rate design and infrastructure planning. Ref: AWWA.. Valid values are `urban|suburban|rural|mixed`',
    `state_code` STRING COMMENT 'Two-letter U.S. state code where the territory is located (e.g., CA, TX, NY). Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `stormwater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides stormwater management service within this territory. Ref: AWWA.',
    `tariff_schedule_reference` STRING COMMENT 'Reference to the applicable rate tariff schedule approved by the regulatory authority for this territory. Ref: AWWA.',
    `territory_status` STRING COMMENT 'Current operational status of the service territory in the utilitys service portfolio. Ref: AWWA.. Valid values are `active|inactive|pending|suspended|retired|transferred`',
    `territory_type` STRING COMMENT 'Classification of the service territory based on regulatory authorization and service delivery model. Ref: AWWA.. Valid values are `franchise|certificated|contract|wholesale|retail|combined`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/Los_Angeles), used for operational scheduling and SCADA data timestamping. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    `wastewater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides wastewater collection and treatment service within this territory. Ref: AWWA.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the geographic service territories and franchise areas within which Water Utilities is authorized to provide water and wastewater services. Includes territory boundaries (GIS polygon references via Esri ArcGIS), regulatory franchise agreement identifiers, applicable state primacy agency jurisdiction, service type coverage (potable, wastewater, recycled), and territory classification (urban, suburban, rural). Supports tariff applicability and regulatory reporting. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_class` (
    `service_class_id` BIGINT COMMENT 'Unique identifier for the service class record. Primary key. Ref: AWWA.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service classes define rate structures and customer classifications that are applied to specific offerings. The offering.customer_class field references service_class.class_code, establishing a busine. Ref: AWWA.',
    `asset_class_id` BIGINT COMMENT 'Reference to primary asset.asset_class for SSOT alignment. Ref: AWWA.',
    `service_asset_class_id` BIGINT COMMENT 'Foreign key to SSOT entity asset.asset_class. Ref: AWWA.',
    `average_monthly_consumption_gallons` DECIMAL(18,2) COMMENT 'Typical average monthly water consumption in gallons for accounts in this service class. Used for rate modeling and demand forecasting. Ref: AWWA.',
    `awwa_classification_code` STRING COMMENT 'Standard classification code from AWWA M1 Manual used for industry benchmarking and best practice alignment.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for accounts in this service class to protect the public water supply from contamination. Ref: AWWA.',
    `billing_cycle_type` STRING COMMENT 'Standard billing frequency for accounts in this service class (e.g., monthly, bimonthly, quarterly). Determines meter reading and invoice generation schedules. Ref: AWWA.. Valid values are `monthly|bimonthly|quarterly|annual|on_demand`',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service class (e.g., RSF for Residential Single-Family, COM for Commercial, IND for Industrial). Used in billing systems and regulatory reports. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_description` STRING COMMENT 'Detailed description of the service class, including eligibility criteria, typical usage characteristics, and any special conditions or restrictions. Ref: AWWA.',
    `class_name` STRING COMMENT 'Full descriptive name of the service class (e.g., Residential Single-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, Wholesale). Ref: AWWA.',
    `class_type` STRING COMMENT 'High-level category of the service class used for grouping and analysis. Aligns with regulatory reporting categories. [ENUM-REF-CANDIDATE: residential|commercial|industrial|irrigation|fire_protection|municipal|wholesale|other — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `conservation_program_eligible` BOOLEAN COMMENT 'Indicates whether accounts in this service class are eligible for water conservation programs, rebates, or incentives. Ref: AWWA.',
    `consumption_tier_structure` STRING COMMENT 'Type of rate structure applied to consumption for this class (e.g., flat rate, tiered/block rates, seasonal rates, time-of-use rates). Ref: AWWA.. Valid values are `flat|tiered|seasonal|time_of_use`',
    `contract_term_months` STRING COMMENT 'Standard contract term length in months for accounts in this service class. Applicable primarily to wholesale and large industrial customers. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was first created in the system. Ref: AWWA.',
    `deposit_requirement_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new accounts in this service class. May vary based on credit risk and consumption history. Ref: AWWA.',
    `disconnection_policy` STRING COMMENT 'Policy governing service disconnection for non-payment for this class (e.g., standard, protected for vulnerable populations, restricted for essential services). Ref: AWWA.. Valid values are `standard|protected|restricted`',
    `drought_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether drought surcharges or emergency water use restrictions apply to this service class during water shortage conditions. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when this service class definition expires or was superseded. Null for currently active classes. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when this service class definition became or will become effective for billing and account assignment. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `fire_flow_requirement_gpm` STRING COMMENT 'Minimum fire flow capacity requirement in gallons per minute (GPM) for properties served under this class. Applicable primarily to commercial, industrial, and fire protection classes. Ref: AWWA.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to overdue balances for accounts in this service class. Subject to regulatory limits. Ref: AWWA.',
    `meter_size_range` STRING COMMENT 'Typical or allowable range of meter sizes (in inches) for accounts in this service class (e.g., 5/8-inch to 1-inch for residential, 2-inch to 6-inch for commercial). Ref: AWWA.',
    `minimum_charge_applicable` DECIMAL(18,2) COMMENT 'Indicates whether a minimum monthly or periodic charge applies to accounts in this service class, regardless of consumption. Ref: AWWA.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this service class record. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was last modified. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or administrative comments regarding this service class. Ref: AWWA.',
    `peak_demand_factor` DECIMAL(18,2) COMMENT 'Multiplier representing the ratio of peak demand to average demand for this service class. Used in capacity planning and infrastructure sizing. Ref: AWWA.',
    `pressure_requirement_psi` STRING COMMENT 'Minimum service pressure requirement in pounds per square inch (PSI) for accounts in this service class. Ensures adequate pressure for intended use. Ref: AWWA.',
    `puc_approval_date` DATE COMMENT 'Date when the Public Utilities Commission approved this service class and its associated rate structure. Required for regulated utilities. Ref: AWWA.',
    `puc_filing_reference` STRING COMMENT 'Reference number or identifier of the PUC rate case filing or tariff document that established or modified this service class. Ref: AWWA.',
    `rate_schedule_group` STRING COMMENT 'Identifier of the rate schedule group applicable to this service class. Links the class to specific rate structures and tariff schedules for billing purposes. Ref: AWWA.',
    `regulatory_reporting_category` STRING COMMENT 'Classification code used for regulatory compliance reporting to state and federal agencies (e.g., EPA, PUC). Maps service class to required reporting categories. Ref: AWWA.',
    `renewal_notification_days` STRING COMMENT 'Number of days advance notice required before contract renewal or rate changes for this service class. Ref: AWWA.',
    `seasonal_rate_applicable` DECIMAL(18,2) COMMENT 'Indicates whether seasonal rate variations (e.g., higher summer rates for irrigation) apply to this service class. Ref: AWWA.',
    `service_canonical_asset_class_id` BIGINT COMMENT 'Reference FK to canonical SSOT asset.asset_class. Ref: AWWA.',
    `service_class_status` STRING COMMENT 'Current lifecycle status of the service class. Active classes are available for new account assignments; deprecated classes are phased out but may have existing accounts. Ref: AWWA.. Valid values are `active|inactive|pending_approval|deprecated|suspended`',
    `service_level_agreement_tier` STRING COMMENT 'Service level tier defining response times, service restoration priorities, and quality commitments for this class (e.g., standard, priority, premium, critical). Ref: AWWA.. Valid values are `standard|priority|premium|critical`',
    `ssot_entity_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `ssot_resolution_type` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `tariff_classification` STRING COMMENT 'Official tariff classification as filed with and approved by the Public Utilities Commission. Used for rate case modeling and tariff compliance. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    `water_quality_monitoring_frequency` STRING COMMENT 'Required frequency of water quality monitoring or testing for accounts in this service class. More stringent for industrial and high-risk classes. Ref: AWWA.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `created_by` STRING COMMENT 'User identifier or system account that created this service class record. Ref: AWWA.',
    CONSTRAINT pk_service_class PRIMARY KEY(`service_class_id`)
) COMMENT 'Reference classification of customer service classes used for rate application and regulatory reporting, such as Residential Single-Family, Residential Multi-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, and Wholesale. Each class carries a class code, description, applicable rate schedule group, billing cycle type, and regulatory reporting category. Aligned with PUC tariff classification and AWWA customer class standards. [SSOT: reference view of canonical asset.asset_class] Differentiated: service_class is customer service tier (not physical asset taxonomy). [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the service agreement. Primary key for this entity representing the contractual relationship between Water Utilities and a customer account. Ref: AWWA.',
    `asset_meter_id` BIGINT COMMENT 'Foreign key linking to asset.asset_meter. Business justification: Agreements must specify which asset meter (not just metering domain meter) is used for billing to track meter maintenance history, calibration status, and replacement schedules. Critical for revenue a. Ref: AWWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial and commercial service agreements require compliance permits (NPDES, discharge permits). Utility tracks permit governing each agreement for regulatory reporting, billing validation, and dis. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service delivery operations are cost-accounted by department/cost center for rate-making cost-of-service studies, overhead allocation, and performance analysis. Direct operational cost tracking requir. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that holds this service agreement. Links to the customer billing account in Oracle CC&B.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Service agreements generate revenue to specific utility funds (water fund, wastewater fund). Essential for fund accounting, GASB reporting, and rate case revenue tracking. Water utilities require fund. Ref: AWWA.',
    `metering_meter_id` BIGINT COMMENT 'Reference to the water or wastewater meter installed at the service point for consumption measurement. Links to AMI (Advanced Metering Infrastructure) or AMR (Automatic Meter Reading) systems. Ref: AWWA.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Each service agreement is assigned to a specific service class which determines rate schedule applicability, billing cycle, and regulatory reporting. The service_class STRING attribute should be norma. Ref: AWWA.',
    `offering_id` BIGINT COMMENT 'Reference to the specific service offering (water, wastewater, reclaimed water, stormwater) that this agreement covers. Links to the service catalog. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service agreements must specify the source WTP facility for water quality compliance tracking, billing validation, and regulatory reporting (MOR/DMR submissions require linking customer service to tre. Ref: AWWA.',
    `agreement_number` STRING COMMENT 'Externally visible unique business identifier for the service agreement. Used in customer communications, billing statements, and regulatory reporting. Ref: AWWA.. Valid values are `^SA-[0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the service agreement. Active agreements are billed and serviced; suspended agreements are temporarily halted; terminated agreements are closed. Ref: AWWA.. Valid values are `active|pending|suspended|terminated|cancelled`',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment is enabled for this service agreement. When true, invoices are automatically paid from the customers designated payment method. Ref: AWWA.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the service agreement automatically renews at the end of the contract term. When false, agreement requires explicit renewal action. Ref: AWWA.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention device installation and annual testing is required for this service agreement per SDWA (Safe Drinking Water Act) cross-connection control requirements. Ref: AWWA.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule for this agreement (e.g., monthly, bi-monthly, quarterly). Determines meter reading and invoice generation timing. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    `budget_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program, which averages annual usage into equal monthly payments to reduce seasonal bill variation. Ref: AWWA.',
    `contract_term_months` STRING COMMENT 'Duration of the service agreement contract in months. Used for minimum commitment periods and early termination fee calculations. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'Identifier of the system user or process that created this service agreement record. Used for audit and accountability purposes. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was first created in the system. Used for audit trail and data lineage tracking. Ref: AWWA.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required and held for this service agreement. Based on credit assessment and service class. Refundable upon agreement termination. Ref: AWWA.',
    `deposit_status` STRING COMMENT 'Current status of the security deposit for this agreement. Tracks whether deposit is required, currently held, waived based on credit, or refunded. Ref: AWWA.. Valid values are `required|held|waived|refunded|forfeited`',
    `dummy_attribute` STRING COMMENT 'The dummy attribute value recorded for each agreement in the service domain.',
    `end_date` DATE COMMENT 'Date when the service agreement terminates or is scheduled to terminate. Null for open-ended agreements. Used for final billing and account closure. Ref: AWWA.',
    `external_reference_code` STRING COMMENT 'External system identifier for this service agreement in legacy or third-party systems. Used for cross-system reconciliation and data migration tracking. Ref: AWWA.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes fire protection service (private fire lines, sprinkler systems), which typically carries fixed monthly charges regardless of usage. Ref: AWWA.',
    `industrial_user_permit_required` BOOLEAN COMMENT 'Indicates whether this service agreement requires an Industrial User Permit for wastewater discharge per NPDES (National Pollutant Discharge Elimination System) pretreatment program requirements. Ref: AWWA.',
    `irrigation_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes irrigation or outdoor water service, which may be billed separately or subject to seasonal rates and wastewater exemptions. Ref: AWWA.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the system user or process that last modified this service agreement record. Used for change audit and accountability. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated. Used for change tracking and data synchronization across systems. Ref: AWWA.',
    `low_income_assistance_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for low-income customer assistance programs, rate discounts, or payment plans per regulatory requirements. Ref: AWWA.',
    `minimum_usage_commitment_gallons` DECIMAL(18,2) COMMENT 'Minimum water usage volume (in gallons) that the customer commits to consume per billing period. Common for commercial and industrial agreements. Used for minimum charge calculations. Ref: AWWA.',
    `paperless_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic billing instead of paper invoices. Supports environmental sustainability initiatives. Ref: AWWA.',
    `rate_schedule_code` STRING COMMENT 'Code identifying the tariff rate schedule applied to this service agreement. Determines pricing structure, billing frequency, and charge calculations per approved rate case. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,10}$`',
    `renewal_date` DATE COMMENT 'Date when the service agreement is scheduled for renewal or renegotiation. Applicable for fixed-term contracts with renewal provisions. Ref: AWWA.',
    `senior_citizen_discount_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for senior citizen rate discounts or special programs as defined by utility tariff. Ref: AWWA.',
    `sla_response_time_hours` STRING COMMENT 'Contractually committed maximum response time in hours for service requests and emergency calls. Varies by service class and agreement type. Ref: AWWA.',
    `sla_restoration_time_hours` STRING COMMENT 'Contractually committed maximum time in hours to restore service after an outage or interruption. Critical for commercial and industrial customers. Ref: AWWA.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this service agreement data originated. Supports data lineage and multi-system integration scenarios. Ref: AWWA.. Valid values are `CCB|CIS|ERP|LEGACY`',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special contractual conditions, exceptions, or custom terms negotiated for this service agreement. Examples include seasonal rate adjustments, volume discounts, or regulatory exemptions. Ref: AWWA.',
    `start_date` DATE COMMENT 'Date when the service agreement becomes effective and service delivery begins. Used for billing proration and regulatory compliance reporting. Ref: AWWA.',
    `termination_date` DATE COMMENT 'Actual date when the service agreement was terminated. Used for final billing, deposit refund processing, and regulatory reporting. Ref: AWWA.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for service agreement termination. Examples include customer move-out, non-payment, property demolition, or service transfer. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Represents the active contractual relationship between Water Utilities and a customer account for a specific service offering at a service location. Captures agreement start and end dates, contracted service class, applicable rate schedule, minimum usage commitments, deposit requirements, special conditions, and agreement status. This is the SSOT for what service a customer account is enrolled in. Aligned with Oracle CC&B service agreement entity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`point` (
    `point_id` BIGINT COMMENT 'Unique identifier for the service point. Primary key for the service point entity representing the physical location where utility service is delivered. Ref: AWWA.',
    `agreement_id` BIGINT COMMENT 'Reference to the active service agreement contract that governs service delivery at this service point. Links the physical service point to the commercial customer relationship. Ref: AWWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service points (especially industrial discharge points) are directly tied to NPDES permits. Permits specify discharge locations; utility must map permit-to-service-point for DMR reporting, compliance. Ref: AWWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service points require DMA assignment for NRW analysis, consumption pattern tracking, leak detection planning, and zone-level service analytics. Replaces denormalized dma_code with proper FK enabling. Ref: AWWA.',
    `metering_meter_id` BIGINT COMMENT 'Reference to the metering device currently installed at this service point for consumption measurement. Links to the asset registry meter record. Ref: AWWA.',
    `premise_id` BIGINT COMMENT 'Reference to the premise (property or parcel) where this service point is located. A premise may contain multiple service points (e.g., separate water and wastewater connections). Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service points must reference pressure zones for hydraulic design validation, pressure guarantee compliance in SLAs, and service adequacy verification. Replaces denormalized pressure_zone_code with pr. Ref: AWWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service points are physical infrastructure assets (service lines, curb stops, connections) requiring maintenance tracking, condition assessment, and replacement planning. Field crews need asset histor. Ref: AWWA.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service points are classified by customer class (residential, commercial, industrial) which determines rate schedule, meter size requirements, and service level agreements. The customer_class STRING a. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service points (delivery locations) are geographically located within service territories. point has latitude, longitude, and address fields, which place it within a territory boundary. This FK establ. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service points receive water from specific treatment facilities - critical for water quality tracking (CT compliance, turbidity, chlorine residual), pressure zone management, and responding to custome. Ref: AWWA.',
    `activation_date` DATE COMMENT 'Date when service delivery was first activated at this service point, marking the beginning of billable service. May differ from installation date if there was a delay between physical installation and service turn-on. Ref: AWWA.',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether this service point is equipped with Advanced Metering Infrastructure for automated remote meter reading and real-time consumption monitoring. True if AMI meter is installed; false for manual read meters. Ref: AWWA.',
    `backflow_device_type` STRING COMMENT 'Type of backflow prevention device installed at this service point. RPZ is Reduced Pressure Zone; DCVA is Double Check Valve Assembly; PVB is Pressure Vacuum Breaker; AG is Air Gap; none indicates no device required; unknown indicates status not verified. Ref: AWWA.. Valid values are `rpz|dcva|pvb|ag|none|unknown`',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether a backflow prevention device is required at this service point based on hazard assessment and cross-connection control regulations. True if backflow prevention is mandated; false otherwise. Ref: AWWA.',
    `connection_material` STRING COMMENT 'Material composition of the service line connecting the distribution main to the customer premises. Critical for Lead and Copper Rule Revisions (LCRR) compliance and service line inventory reporting. [ENUM-REF-CANDIDATE: copper|pvc|hdpe|galvanized_steel|lead|ductile_iron|pex|unknown — 8 candidates stripped; promote to reference product]',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the service connection pipe in inches, representing the physical capacity of the service line connecting the distribution main to the customer premises. Common sizes include 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'User identifier of the person or system process that created this service point record. Used for audit trail and accountability. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was first created in the system. Used for audit trail and data lineage tracking. Ref: AWWA.',
    `curb_stop_location` STRING COMMENT 'Description of the physical location of the curb stop valve (service shutoff valve) for this service point. Used by field crews for service disconnection and emergency shutoff. Ref: AWWA.',
    `disconnection_date` DATE COMMENT 'Date when service was disconnected or terminated at this service point. Null if service is currently active. Ref: AWWA.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the service point location in feet above mean sea level. Used for hydraulic modeling to calculate static pressure and pressure zone assignment. Ref: AWWA.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Estimated average daily water demand at this service point in gallons, used for hydraulic modeling and capacity planning. Derived from historical consumption patterns or engineering estimates for new connections. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `fire_service_indicator` BOOLEAN COMMENT 'Indicates whether this service point includes fire protection service (fire sprinkler system or fire hydrant connection). True if fire service is provided; false for domestic-only service. Ref: AWWA.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique identifier linking this service point to its corresponding feature in the Esri ArcGIS utility network model. Enables spatial analysis and network tracing. Ref: AWWA.',
    `installation_date` DATE COMMENT 'Date when the service point connection was physically installed and commissioned for service delivery. Used for asset age tracking and depreciation calculations. Ref: AWWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent field inspection or verification of this service point. Used for compliance tracking and preventive maintenance scheduling. Ref: AWWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics. Ref: AWWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics. Ref: AWWA.',
    `modified_by_user` STRING COMMENT 'User identifier of the person or system process that last modified this service point record. Used for audit trail and accountability. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was last modified in the system. Used for audit trail and change tracking. Ref: AWWA.',
    `ownership_type` STRING COMMENT 'Ownership responsibility for the service line infrastructure. Utility-owned indicates the utility maintains the entire service line; customer-owned indicates customer responsibility; shared indicates split ownership at a defined point (typically property line or curb stop). Ref: AWWA.. Valid values are `utility_owned|customer_owned|shared|unknown`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous demand at this service point in gallons per minute, used for service line sizing and pressure analysis in hydraulic models. Ref: AWWA.',
    `rate_schedule_code` STRING COMMENT 'Identifier for the tariff rate schedule applied to this service point for billing purposes. Rate schedules define the pricing structure including base charges, volumetric rates, and tier thresholds. Ref: AWWA.',
    `route_code` STRING COMMENT 'Identifier for the meter reading or field service route to which this service point is assigned. Used for scheduling meter reading, field inspections, and maintenance activities. Ref: AWWA.',
    `service_address_line1` STRING COMMENT 'Primary street address line of the physical location where service is delivered. Includes street number, street name, and street type. Ref: AWWA.',
    `service_address_line2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, or other location qualifier at the service point address. Ref: AWWA.',
    `service_city` STRING COMMENT 'City or municipality name where the service point is located. Ref: AWWA.',
    `service_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the service point is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `service_point_description` STRING COMMENT 'Free-text description providing additional context about the service point location, special characteristics, or access instructions for field personnel. Ref: AWWA.',
    `service_point_number` STRING COMMENT 'Externally-known business identifier for the service point, typically displayed on customer bills and used in customer service interactions. Unique across the utility service territory. Ref: AWWA.. Valid values are `^SP[0-9]{8,12}$`',
    `service_point_status` STRING COMMENT 'Current operational status of the service point in its lifecycle. Active indicates service is being delivered; inactive indicates no current service; suspended indicates temporary service hold; pending_activation indicates awaiting turn-on; disconnected indicates service terminated; abandoned indicates permanently retired. Ref: AWWA.. Valid values are `active|inactive|suspended|pending_activation|disconnected|abandoned`',
    `service_postal_code` STRING COMMENT 'ZIP code or postal code of the service point location, supporting 5-digit or 9-digit (ZIP+4) formats. Ref: AWWA.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service point is located, following USPS state abbreviation standards. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `service_type` STRING COMMENT 'Type of utility service delivered at this service point. Potable water is drinking water distribution; wastewater is sanitary sewer collection; recycled water is reclaimed water for irrigation or industrial use; stormwater is surface water drainage; combined is combined sewer system. Ref: AWWA.. Valid values are `potable_water|wastewater|recycled_water|stormwater|combined`',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    CONSTRAINT pk_point PRIMARY KEY(`point_id`)
) COMMENT 'Represents the physical location where a utility service is delivered to a customer, corresponding to a metered connection point on the distribution or wastewater network. Captures the service point address, GIS coordinates (Esri ArcGIS), service type (potable water, wastewater, recycled water), connection size (pipe diameter in inches), pressure zone, DMA assignment, and active status. Links the commercial service agreement to the physical network infrastructure. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`connection_application` (
    `connection_application_id` BIGINT COMMENT 'Unique identifier for the connection application record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Connection applications requiring infrastructure upgrades (main extensions, pump station capacity, treatment plant expansion) trigger or are bundled into CIP projects. Applicants and customer service. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this connection application. Links to the customer master record. Ref: AWWA.',
    `connection_customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this connection application. Links to the customer master record. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Connection activities (engineering review, field inspection, installation) are cost-accounted by department for rate-making, cost recovery analysis, and connection fee justification. Essential for rat. Ref: AWWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: New connections must be assigned to DMAs for capacity planning, NRW impact assessment, metering infrastructure planning, and zone-level demand forecasting. Essential for evaluating capacity_available. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the staff member or team assigned to review and process the connection application. Ref: AWWA.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: New connection applications require infrastructure capacity assessment at specific asset locations (pump stations, pressure zones, treatment facilities). Engineering reviews check available capacity,. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Connection applications specify required materials (meter size/type, service line diameter, backflow device model) that must be validated against material master for availability, lead time, NSF/AWWA ',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Connection applications specify required meter size based on estimated demand (GPM). Engineering review validates sizing against meter_size_type specifications (max flow, pressure rating, accuracy cla. Ref: AWWA.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Connection applications request a specific service offering from the catalog. connection_application currently has requested_service_type as a STRING field, which should be normalized to reference the. Ref: AWWA.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Connection applications require upfront fee payment (application fee, connection fee, capacity charge) before approval. New service application processing depends on verifying payment receipt and clea. Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New connection applications require pressure zone assignment for hydraulic capacity verification, infrastructure adequacy assessment, and pressure guarantee feasibility before approval. Critical for c. Ref: AWWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: New connection applications must comply with regulatory requirements (backflow prevention, cross-connection control, capacity standards, water quality). Application review process validates against ap. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Connection applications are submitted for service within a specific franchise territory. The service_address fields are application-specific and should be retained, but a FK to service_territory is ne. Ref: AWWA.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order created to execute the physical connection installation. Links to the work order management system. Ref: AWWA.',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether the connection will be equipped with Advanced Metering Infrastructure (AMI) for automated meter reading and real-time monitoring. Ref: AWWA.',
    `applicant_email` STRING COMMENT 'Primary email address of the applicant for correspondence and notifications regarding the connection application. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_name` STRING COMMENT 'Full legal name of the individual or organization applying for the service connection. Ref: AWWA.',
    `applicant_phone` STRING COMMENT 'Primary contact phone number of the applicant for communication regarding the connection application. Ref: AWWA.. Valid values are `^+?[1-9]d{1,14}$`',
    `application_date` DATE COMMENT 'Date when the connection application was formally submitted by the applicant. Ref: AWWA.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for processing the connection application, in USD. Ref: AWWA.',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned to the connection request. Format: CA-YYYYNNNN. Ref: AWWA.. Valid values are `^CA-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the connection application in the approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|completed|cancelled — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `application_type` STRING COMMENT 'Type of service connection application: new connection, service upgrade, disconnection, transfer of service, reconnection, or temporary service. Ref: AWWA.. Valid values are `new_connection|service_upgrade|disconnection|transfer|reconnection|temporary_service`',
    `approval_date` DATE COMMENT 'Date when the connection application was officially approved by the utility. Ref: AWWA.',
    `capacity_available` BOOLEAN COMMENT 'Indicates whether sufficient system capacity (pressure, flow, treatment capacity) is available to serve the requested connection without infrastructure upgrades. Ref: AWWA.',
    `capacity_charge_amount` DECIMAL(18,2) COMMENT 'System development or capacity charge assessed to fund infrastructure expansion to serve the new connection, in USD. Ref: AWWA.',
    `completion_date` DATE COMMENT 'Date when the physical service connection was completed and the service was activated. Ref: AWWA.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or tap fee assessed for establishing the new service connection, in USD. Ref: AWWA.',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the requested service connection in inches (e.g., 0.75, 1.0, 1.5, 2.0). Critical for capacity planning and meter sizing. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was first created in the system. Ref: AWWA.',
    `estimated_flow_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak flow demand in gallons per minute (GPM) for the requested service connection. Used for hydraulic modeling and capacity verification. Ref: AWWA.',
    `infrastructure_upgrade_required` BOOLEAN COMMENT 'Indicates whether main extensions, pump station upgrades, or other infrastructure improvements are required to serve the connection. Ref: AWWA.',
    `meter_type_requested` STRING COMMENT 'Type or model of water meter requested or recommended for the connection (e.g., positive displacement, turbine, compound, electromagnetic). Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was last modified or updated. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the connection application, including special requirements, site conditions, or coordination details. Ref: AWWA.',
    `number_of_units` STRING COMMENT 'Number of dwelling units, commercial units, or service points at the property (e.g., apartments in a multi-family building). Ref: AWWA.',
    `payment_status` STRING COMMENT 'Status of fee payment for the connection application: unpaid, partially paid, fully paid, waived, or refunded. Ref: AWWA.. Valid values are `unpaid|partial|paid|waived|refunded`',
    `property_type` STRING COMMENT 'Classification of the property requesting service: residential, commercial, industrial, institutional, agricultural, or mixed-use. Ref: AWWA.. Valid values are `residential|commercial|industrial|institutional|agricultural|mixed_use`',
    `rejection_date` DATE COMMENT 'Date when the connection application was rejected or denied by the utility. Ref: AWWA.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the connection application was rejected (e.g., insufficient capacity, incomplete documentation, non-compliance with standards). Ref: AWWA.',
    `requested_service_date` DATE COMMENT 'Date by which the applicant requests the service connection to be activated or completed. Ref: AWWA.',
    `service_address_line1` STRING COMMENT 'Primary street address line where the water or wastewater service connection is requested. Ref: AWWA.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the service location. Ref: AWWA.',
    `service_city` STRING COMMENT 'City or municipality where the service connection is requested. Ref: AWWA.',
    `service_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service connection location for GIS mapping and network planning. Ref: AWWA.',
    `service_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service connection location for GIS mapping and network planning. Ref: AWWA.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code for the service address. Ref: AWWA.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service connection is requested. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `technical_review_date` DATE COMMENT 'Date when the technical feasibility and capacity review of the connection application was completed. Ref: AWWA.',
    `total_fees_assessed` DECIMAL(18,2) COMMENT 'Total of all fees assessed for the connection application (application fee, connection fee, capacity charge, and any other charges), in USD. Ref: AWWA.',
    CONSTRAINT pk_connection_application PRIMARY KEY(`connection_application_id`)
) COMMENT 'Tracks customer applications for new service connections, service upgrades, disconnections, and transfers. Captures application date, requested service type, service address, applicant details, connection size requested, estimated flow demand (GPM), application status, review milestones, fees assessed, and approval or rejection details. Supports the new service onboarding workflow and capacity planning. Aligned with Microsoft Dynamics 365 field service request intake.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`order` (
    `order_id` BIGINT COMMENT 'Unique identifier for the service order. Primary key for the service order entity. Ref: AWWA.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Service orders (turn-on, turn-off, meter change, maintenance) are performed in the context of a service agreement. Adding service_agreement_id FK establishes the agreement context for the service orde. Ref: AWWA.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or work team assigned to perform the service order. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service orders for new connections or upgrades may be contingent on CIP project completion (e.g., service available after main extension project completes). Customer service and field operations need. Ref: AWWA.',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: Service orders are often generated from approved connection applications (new service installations, upgrades). Adding connection_application_id FK tracks the originating application that triggered th. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field service operations (meter reads, turn-ons, repairs) are tracked by cost center for labor cost allocation, overhead rate calculation, and rate case cost-of-service studies. Direct operational cos. Ref: AWWA.',
    `created_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or process that created the service order record. Ref: AWWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service orders require DMA assignment for operational planning, NRW event correlation (service work causing leaks), zone-based work scheduling, and DMA-level service activity tracking. Essential for c. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Reference to the individual field technician assigned to perform the service order. Ref: AWWA.',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Field service orders (meter replacements, service line repairs, new connections) trigger material requisitions to pull inventory from warehouse. Critical for work order planning, inventory allocation,. Ref: AWWA.',
    `modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or process that last modified the service order record. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this service order. Ref: AWWA.',
    `point_id` BIGINT COMMENT 'Reference to the physical service delivery point (meter location) where the field activity will be performed. Ref: AWWA.',
    `premise_id` BIGINT COMMENT 'Reference to the premise (property/location) where the service order activity will occur. Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service orders (connect/disconnect/repair) need pressure zone context for crew routing optimization, pressure impact assessment during isolation events, service restoration verification, and zone-base',
    `primary_order_created_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or process that created the service order record. Ref: AWWA.',
    `metering_meter_id` BIGINT COMMENT 'Serial number or identifier of the meter removed during a meter exchange service order. Ref: AWWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service orders (meter installation, valve operation, service line repair) target specific assets requiring maintenance history, condition data, and warranty information. Field technicians need asset s. Ref: AWWA.',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service orders are executed according to defined SLA standards. order currently has sla_target_hours, sla_actual_hours, and sla_met_flag. The target hours should be derived from sla_definition rather. Ref: AWWA.',
    `tertiary_order_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or process that last modified the service order record. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service orders (new connections, reconnections) require verification that source facility can meet pressure/flow requirements and that water quality meets standards at time of service. Operations team. Ref: AWWA.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the field crew completed the service order activity. Ref: AWWA.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the field crew began performing the service order activity. Ref: AWWA.',
    `appointment_window_end` TIMESTAMP COMMENT 'End of the time window communicated to the customer for the service order appointment. Ref: AWWA.',
    `appointment_window_start` TIMESTAMP COMMENT 'Beginning of the time window communicated to the customer for the service order appointment. Ref: AWWA.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the service order activity is billable to the customer account. Ref: AWWA.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the service order was cancelled, if applicable. Ref: AWWA.',
    `completion_date` DATE COMMENT 'Date when the service order was marked as completed in the system. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was first created in the system. Ref: AWWA.',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact person for this service order, used for appointment confirmation and access coordination. Ref: AWWA.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact person for appointment confirmation and field crew communication. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service location, used for crew dispatch and asset tracking. Ref: AWWA.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service location, used for crew dispatch and asset tracking. Ref: AWWA.',
    `meter_reading_unit` STRING COMMENT 'Unit of measure for the meter reading value captured during the service order. Ref: AWWA.. Valid values are `gallons|cubic_meters|cubic_feet|liters`',
    `meter_reading_value` DECIMAL(18,2) COMMENT 'Final meter reading captured during the service order activity, measured in appropriate units (gallons, cubic meters, etc.). Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was last modified in the system. Ref: AWWA.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the service order, used for customer communication and field crew reference. Ref: AWWA.. Valid values are `^SO-[0-9]{8}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the service order in the field service workflow. [ENUM-REF-CANDIDATE: draft|scheduled|dispatched|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `order_type` STRING COMMENT 'Classification of the service order activity. Defines the nature of field work to be performed. [ENUM-REF-CANDIDATE: turn_on|turn_off|reconnection|meter_set|meter_exchange|service_upgrade|final_read|leak_investigation — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `outcome_code` STRING COMMENT 'Standardized code indicating the final outcome or result of the service order execution. Ref: AWWA.. Valid values are `completed_as_planned|partial_completion|unable_to_complete|customer_not_available|access_denied|equipment_failure`',
    `priority` STRING COMMENT 'Priority level assigned to the service order, determining dispatch sequence and response time requirements. Ref: AWWA.. Valid values are `emergency|urgent|standard|low`',
    `requested_date` DATE COMMENT 'Date when the customer or system requested the service order to be performed. Ref: AWWA.',
    `scheduled_date` DATE COMMENT 'Date when the field crew is scheduled to perform the service order activity. Ref: AWWA.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned date and time when the field crew is expected to complete the service order activity. Ref: AWWA.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the field crew is scheduled to begin the service order activity. Ref: AWWA.',
    `service_address` STRING COMMENT 'Full street address where the field service activity will be performed. Used for crew dispatch and navigation. Ref: AWWA.',
    `service_fee_amount` DECIMAL(18,2) COMMENT 'Monetary charge assessed to the customer for the service order activity, in US dollars. Ref: AWWA.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours elapsed from order creation to completion, used for SLA compliance tracking. Ref: AWWA.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the service order was completed within the target SLA timeframe. Ref: AWWA.',
    `special_instructions` STRING COMMENT 'Additional instructions or notes for the field crew regarding access, safety, or customer requirements. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    `work_performed_description` STRING COMMENT 'Detailed narrative description of the work actually performed by the field crew, including any findings or issues encountered. Ref: AWWA.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Operational work orders issued to field crews for service-related activities including new service turn-ons, turn-offs, reconnections after non-payment, meter sets, service upgrades, and final reads. Captures order type, scheduled date, completion date, assigned crew, service point reference, work performed, and outcome status. Distinct from asset maintenance work orders (owned by asset domain). Aligned with Oracle CC&B field activity and Microsoft Dynamics 365 field service. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` (
    `sla_definition_id` BIGINT COMMENT 'Unique identifier for the service level agreement definition record. Ref: AWWA.',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Service level agreements define performance commitments that may be tied to premium rate schedules (guaranteed pressure, priority response). Tiered service pricing requires linking SLA definitions to. Ref: AWWA.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service level agreements vary by customer service class, with different response time targets and compliance requirements for residential vs. commercial vs. industrial customers. The service_class STR. Ref: AWWA.',
    `offering_id` BIGINT COMMENT 'Reference to the service offering or service class to which this SLA applies. Ref: AWWA.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: SLA definitions are documented in tariff filings and are subject to regulatory approval. The tariff_reference STRING attribute should be normalized to a FK to tariff, allowing JOIN to retrieve tariff_. Ref: AWWA.',
    `approval_authority` STRING COMMENT 'Regulatory body or internal authority that approved this SLA definition, such as Public Utilities Commission, State Primacy Agency, or internal executive committee. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date on which this SLA definition was approved by the Public Utilities Commission or internal governance authority. Ref: AWWA.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Required percentage of time or occurrences that the SLA target must be met to maintain compliance, expressed as a percentage (e.g., 99.5% for high-availability commitments). Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was first created in the system. Ref: AWWA.',
    `sla_definition_description` STRING COMMENT 'Detailed description of the SLA commitment, including the business purpose, customer benefit, and operational context. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date on which this SLA definition expires or is superseded by a new version. Null indicates the SLA is currently active with no defined end date. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date on which this SLA definition becomes effective and enforceable, typically aligned with rate case approval or tariff filing effective date. Ref: AWWA.',
    `escalation_procedure` STRING COMMENT 'Defined escalation path or procedure to be followed when the SLA is breached, including management notification, regulatory reporting, and customer communication steps. Ref: AWWA.',
    `exclusion_conditions` STRING COMMENT 'Conditions or circumstances under which the SLA does not apply or is temporarily suspended, such as force majeure events, natural disasters, regulatory-mandated shutdowns, or customer-requested service interruptions. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `geographic_scope` STRING COMMENT 'Geographic area or service territory to which this SLA applies: system-wide across all service areas, specific district, pressure zone, District Metered Area (DMA), or specific customer location. Ref: AWWA.. Valid values are `system_wide|district|zone|dma|specific_location`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was last updated or modified. Ref: AWWA.',
    `maximum_value` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the SLA metric, above which the SLA is considered breached. Applicable for metrics with upper bounds such as Maximum Contaminant Level (MCL), turbidity (NTU), or response time. Ref: AWWA.',
    `measurement_frequency` STRING COMMENT 'Frequency at which the SLA metric is measured or evaluated: continuous monitoring via SCADA, periodic sampling, or event-based measurement triggered by specific conditions. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `metric_name` STRING COMMENT 'Specific metric or parameter being measured for this SLA, such as Outage Response Time, Service Restoration Time, Minimum Water Pressure (PSI), Maximum Turbidity (NTU), pH Range, Maximum Contaminant Level (MCL), or Notification Time. Ref: AWWA.',
    `minimum_value` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the SLA metric, below which the SLA is considered breached. Applicable for metrics with lower bounds such as minimum water pressure (PSI) or minimum pH. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications regarding the SLA definition, including historical context, implementation guidance, or special considerations. Ref: AWWA.',
    `notification_method` STRING COMMENT 'Communication channels required for customer or regulatory notification, such as email, SMS, phone call, postal mail, public notice, website posting, or media announcement. Multiple methods may be specified. Ref: AWWA.',
    `notification_requirement` STRING COMMENT 'Timeframe within which customers or regulatory agencies must be notified of an SLA breach or service issue, such as immediate notification for water quality violations or 24-hour notice for planned outages. Ref: AWWA.. Valid values are `immediate|within_24_hours|within_48_hours|within_7_days|monthly|none`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of the penalty, credit, or rebate applied per SLA breach, expressed in the utilitys operating currency. Ref: AWWA.',
    `penalty_calculation_method` STRING COMMENT 'Method used to calculate the penalty or credit: fixed amount per breach, per occurrence, per hour of non-compliance, per day, percentage of customer bill, or tiered based on severity or duration. Ref: AWWA.. Valid values are `fixed|per_occurrence|per_hour|per_day|percentage_of_bill|tiered`',
    `penalty_type` STRING COMMENT 'Type of penalty or consequence applied when the SLA is breached: customer credit, service rebate, regulatory fine, escalation to management, or no penalty. Ref: AWWA.. Valid values are `credit|rebate|fine|none|escalation`',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory framework that mandates or informs this SLA commitment, such as Safe Drinking Water Act (SDWA), state primacy agency rules, Public Utilities Commission orders, or American Water Works Association (AWWA) standards.',
    `reporting_requirement` STRING COMMENT 'Frequency and type of reporting required for SLA compliance monitoring, such as monthly performance reports to the Public Utilities Commission, quarterly customer reports, or annual Consumer Confidence Report (CCR) inclusion. Ref: AWWA.. Valid values are `monthly|quarterly|annual|event_based|none`',
    `sla_code` STRING COMMENT 'Business identifier code for the SLA definition, used for external reference and regulatory tariff filings. Ref: AWWA.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `sla_definition_status` STRING COMMENT 'Current lifecycle status of the SLA definition: active and enforceable, inactive, pending regulatory approval, superseded by a newer version, or temporarily suspended. Ref: AWWA.. Valid values are `active|inactive|pending_approval|superseded|suspended`',
    `sla_name` STRING COMMENT 'Human-readable name of the SLA definition, describing the commitment or guarantee. Ref: AWWA.',
    `sla_type` STRING COMMENT 'Category of SLA commitment: response time for outage acknowledgment, restoration time for service recovery, water quality guarantee parameters, pressure guarantee thresholds, customer notification requirements, or system availability targets. Ref: AWWA.. Valid values are `response_time|restoration_time|water_quality|pressure_guarantee|notification|availability`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target or threshold value for the SLA metric, representing the committed performance level or guarantee. Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the SLA metric, such as minutes, hours, PSI (Pounds per Square Inch), NTU (Nephelometric Turbidity Units), mg/L, pH units, or percent. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    CONSTRAINT pk_sla_definition PRIMARY KEY(`sla_definition_id`)
) COMMENT 'Defines the service level agreements applicable to each service offering or service class, including response time commitments for outages, restoration time targets, water quality guarantee parameters, pressure guarantee thresholds (PSI), and customer notification requirements. Captures SLA type, metric name, target value, measurement unit, regulatory basis (SDWA, state rules), and penalty or credit terms for non-compliance. Supports regulatory tariff compliance and customer service commitments. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`tariff` (
    `tariff_id` BIGINT COMMENT 'Unique identifier for the regulatory tariff filing record. Primary key. Ref: AWWA.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.rate_case. Business justification: Tariffs are the direct regulatory output of rate case proceedings. Every tariff must reference the rate case docket that established it. Core regulatory compliance relationship for PUC/PSC reporting a. Ref: AWWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tariffs must comply with regulatory requirements (rate structure mandates, affordability requirements, conservation pricing rules). Tariff filings reference compliance with state/federal mandates. Lin. Ref: AWWA.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Tariff filings are class-specific, with separate rate schedules and regulatory approvals for each customer class. The customer_class STRING attribute should be normalized to a FK to service_class, all. Ref: AWWA.',
    `superseded_tariff_id` BIGINT COMMENT 'Reference to the prior tariff that this tariff replaces. Establishes the lineage of rate changes and enables historical rate analysis. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Tariffs apply to specific service territories and franchise areas. Currently service_territory is a STRING field describing where the tariff applies. Should be FK to service_territory for referential. Ref: AWWA.',
    `adjustment_clause_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes automatic adjustment clauses or riders that allow for rate changes without a full rate case. Common adjustment clauses include purchased water adjustment clauses (PWAC), infrastructure surcharges, and cost recovery mechanisms for specific capital programs. Ref: AWWA.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority formally approved the tariff filing. This date may differ from the effective date due to statutory notice periods or phased implementation. Ref: AWWA.',
    `approval_order_number` STRING COMMENT 'The official order or docket number issued by the regulatory authority approving this tariff. This reference links the tariff to the formal regulatory decision and provides traceability to the rate case proceeding. Ref: AWWA.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'The foundational rate component approved by the regulatory authority, typically expressed as a fixed monthly charge or per-unit volumetric rate. This is the core revenue component before adjustments, surcharges, or riders. Ref: AWWA.',
    `billing_frequency` STRING COMMENT 'The standard billing cycle for customers under this tariff. Defines how often charges are calculated and invoices are issued. Ref: AWWA.. Valid values are `monthly|bimonthly|quarterly|annual`',
    `conservation_rate_flag` DECIMAL(18,2) COMMENT 'Indicates whether the tariff incorporates conservation-oriented rate design features such as increasing block rates, seasonal pricing, or water budget-based rates intended to promote efficient water use. Ref: AWWA.',
    `cost_of_service_study_reference` STRING COMMENT 'Reference to the cost-of-service study or rate design analysis that supports the tariff rates. This study allocates utility costs to customer classes and justifies the rate structure to the regulatory authority. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was first created in the system. Supports audit trail and data lineage tracking. Ref: AWWA.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which tariff rates and charges are denominated. For U.S. water utilities, this is typically USD.. Valid values are `USD`',
    `tariff_description` STRING COMMENT 'A detailed narrative description of the tariff, including its purpose, scope, applicability, and key terms. This field captures the regulatory intent and business context of the tariff. Ref: AWWA.',
    `document_url` STRING COMMENT 'The web address or document management system link to the official tariff filing document, including all schedules, exhibits, and supporting materials. Provides direct access to the complete regulatory record. Ref: AWWA.',
    `effective_date` DATE COMMENT 'The date on which the tariff becomes binding and enforceable. Rates and terms specified in the tariff apply to all qualifying service from this date forward. Ref: AWWA.',
    `expiration_date` DATE COMMENT 'The date on which the tariff ceases to be in force, if applicable. Null for tariffs that remain active until superseded by a subsequent filing. Ref: AWWA.',
    `filing_date` DATE COMMENT 'The date on which the tariff was officially filed with the Public Utilities Commission or state regulatory authority. This date triggers statutory review periods and notice requirements. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `hearing_date` DATE COMMENT 'The date of the public hearing or evidentiary proceeding held by the regulatory authority to review the tariff filing. Null if no hearing was required or held. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was most recently updated. Supports change tracking and audit compliance. Ref: AWWA.',
    `low_income_assistance_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes provisions for low-income customer assistance programs, such as lifeline rates, bill discounts, or affordability programs mandated or approved by the regulatory authority. Ref: AWWA.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'The minimum monthly or periodic charge that applies regardless of consumption. Ensures cost recovery for fixed infrastructure and customer service costs. Ref: AWWA.',
    `tariff_name` STRING COMMENT 'The official name or title of the tariff as it appears in regulatory filings and customer communications. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-form text field for additional context, clarifications, or special conditions related to the tariff. May include notes on implementation, transition provisions, or regulatory stipulations. Ref: AWWA.',
    `public_notice_date` DATE COMMENT 'The date on which public notice of the tariff filing was provided to customers and stakeholders, as required by regulatory statute. Public notice periods allow for customer comment and intervention in rate proceedings. Ref: AWWA.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'The net investment in utility plant and working capital upon which the utility is allowed to earn a return. Rate base is calculated as gross plant in service less accumulated depreciation plus working capital allowances. Ref: AWWA.',
    `rate_of_return_percent` DECIMAL(18,2) COMMENT 'The allowed rate of return on rate base approved by the regulatory authority. Expressed as a decimal percentage (e.g., 0.0725 for 7.25%). This is the weighted average cost of capital (WACC) the utility is permitted to earn. Ref: AWWA.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the detailed rate schedule document or section number within the tariff filing that specifies the complete pricing structure, including block tiers, surcharges, and adjustments. Ref: AWWA.',
    `rate_structure_type` STRING COMMENT 'The pricing methodology employed by the tariff. Flat rates charge a fixed amount regardless of usage, uniform rates charge a constant per-unit price, declining block rates decrease with higher usage tiers, increasing block rates increase with higher usage tiers to promote conservation, seasonal rates vary by time of year, and time-of-use rates vary by time of day or demand period. Ref: AWWA.. Valid values are `flat|uniform|declining_block|increasing_block|seasonal|time_of_use`',
    `regulatory_authority` STRING COMMENT 'The name of the Public Utilities Commission, state regulatory agency, or other governing body that has jurisdiction over this tariff filing. Examples include State Public Service Commission, Public Utilities Commission, or Department of Public Utilities. Ref: AWWA.',
    `revenue_requirement_amount` DECIMAL(18,2) COMMENT 'The total annual revenue requirement approved by the regulatory authority for the utility under this tariff. This is the aggregate revenue the utility is authorized to collect to cover operating expenses, capital costs, and allowed return on investment. Ref: AWWA.',
    `service_rules_reference` STRING COMMENT 'Reference to the service rules, terms, and conditions document or section number within the tariff filing that governs service delivery, customer obligations, disconnection policies, and dispute resolution procedures. Ref: AWWA.',
    `tariff_number` STRING COMMENT 'The official regulatory tariff number assigned by the Public Utilities Commission or state regulatory authority. This is the externally-known identifier used in all regulatory filings and rate case proceedings. Ref: AWWA.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `tariff_status` STRING COMMENT 'Current lifecycle status of the tariff filing. Draft indicates internal preparation, filed means submitted to the regulator, pending approval is under regulatory review, approved means accepted by the commission, active is currently in force, suspended is temporarily halted, superseded is replaced by a newer tariff, and withdrawn is retracted before approval. [ENUM-REF-CANDIDATE: draft|filed|pending_approval|approved|active|suspended|superseded|withdrawn — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `tariff_type` STRING COMMENT 'Classification of the tariff based on the customer segment and service arrangement it governs. General service tariffs apply to standard retail customers, special contracts cover negotiated agreements with large users, wholesale tariffs govern bulk water sales to other utilities, and industrial/municipal/residential/commercial designate specific customer classes. [ENUM-REF-CANDIDATE: general_service|special_contract|wholesale|industrial|municipal|residential|commercial — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    CONSTRAINT pk_tariff PRIMARY KEY(`tariff_id`)
) COMMENT 'Master record of regulatory tariff filings and associated rate case proceedings with the Public Utilities Commission or state regulatory authority. Captures the full lifecycle from rate case filing (test year, requested revenue requirement, hearing dates, intervenor parties) through approval (final order, approved revenue requirement) to the effective tariff (tariff number, effective date, tariff type, incorporated rate schedules and service rules). This is the regulatory anchor for all rate and service term compliance, linking rate case proceedings to their resulting approved pricing structures. Supports financial planning, regulatory compliance, and rate modeling. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` (
    `service_rate_case_id` DECIMAL(18,2) COMMENT 'Unique identifier for the service_rate_case data product (auto-inserted pre-linking). Ref: Oracle CC&B.',
    `document_id` BIGINT COMMENT 'Unique identifier for the rate case document referenced by each service rate case record in the service domain.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency referenced by each service rate case record in the service domain.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Rate case proceedings can be class-specific (e.g., residential rate case, industrial rate case) or apply to all classes. This FK allows rate cases to be scoped to specific customer service classes whe. Ref: Oracle CC&B.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the service created by employee referenced by each service rate case record in the service domain.',
    `service_lead_attorney_employee_id` BIGINT COMMENT 'Lead attorney or representative for the rate case. Ref: Oracle CC&B.',
    `service_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the service responsible employee referenced by each service rate case record in the service domain.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Rate case proceedings can be territory-specific or system-wide. Water utilities often file rate cases for specific franchise areas or service territories. This FK allows rate cases to be scoped to the. Ref: Oracle CC&B.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Reference to primary finance.finance_rate_case for SSOT alignment. Ref: Oracle CC&B.',
    `service_canonical_finance_rate_case_id` DECIMAL(18,2) COMMENT 'Reference FK to canonical SSOT finance.finance_rate_case. Ref: Oracle CC&B.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each service rate case in the service domain.',
    `approved_effective_date` TIMESTAMP COMMENT 'Approved effective date for new rates. Ref: Oracle CC&B.',
    `approved_increase_pct` DECIMAL(18,2) COMMENT 'The approved increase pct value recorded for each service rate case in the service domain.',
    `approved_rate_increase_pct` DECIMAL(18,2) COMMENT 'The approved rate increase pct value recorded for each service rate case in the service domain.',
    `approved_rate_of_return_pct` DECIMAL(18,2) COMMENT 'Rate of return approved. Ref: Oracle CC&B.',
    `approved_revenue_amount` DECIMAL(18,2) COMMENT 'Approved additional revenue amount. Ref: Oracle CC&B.',
    `approved_revenue_increase` DECIMAL(18,2) COMMENT 'The approved revenue increase value recorded for each service rate case in the service domain.',
    `approved_revenue_increase_pct` DECIMAL(18,2) COMMENT 'Approved revenue increase percentage. Ref: Oracle CC&B.',
    `approved_revenue_increase_usd` DECIMAL(18,2) COMMENT 'The approved revenue increase usd value recorded for each service rate case in the service domain.',
    `approved_revenue_requirement` DECIMAL(18,2) COMMENT 'Total revenue requirement approved. Ref: Oracle CC&B.',
    `average_residential_bill_impact_usd` DECIMAL(18,2) COMMENT 'Average monthly bill impact for residential customers. Ref: Oracle CC&B.',
    `case_name` STRING COMMENT 'Descriptive name of the rate case. Ref: Oracle CC&B.',
    `case_number` STRING COMMENT 'Unique rate case docket/reference number. Ref: Oracle CC&B.',
    `case_status` STRING COMMENT 'Status (filed, under_review, hearing, approved, denied, withdrawn). Ref: Oracle CC&B.',
    `case_type` STRING COMMENT 'Type (general_rate_increase, surcharge, pass_through, index). Ref: Oracle CC&B.',
    `service_rate_case_category` STRING COMMENT 'The service rate case category value recorded for each service rate case in the service domain.',
    `classification` STRING COMMENT 'The classification value recorded for each service rate case in the service domain.',
    `service_rate_case_code` STRING COMMENT 'The service rate case code value recorded for each service rate case in the service domain.',
    `comments` STRING COMMENT 'Additional notes. Ref: Oracle CC&B.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each service rate case in the service domain.',
    `cost_of_capital_pct` DECIMAL(18,2) COMMENT 'Weighted average cost of capital. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Oracle CC&B.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each service rate case in the service domain.',
    `decision_date` TIMESTAMP COMMENT 'Date of regulatory decision. Ref: Oracle CC&B.',
    `decision_flag` BOOLEAN COMMENT 'The decision flag value recorded for each service rate case in the service domain.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each service rate case in the service domain.',
    `service_rate_case_description` STRING COMMENT 'The service rate case description value recorded for each service rate case in the service domain.',
    `docket_number` STRING COMMENT 'Regulatory commission docket number. Ref: Oracle CC&B.',
    `effective_date` TIMESTAMP COMMENT 'Effective date of approved rates. Ref: Oracle CC&B.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Oracle CC&B.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Oracle CC&B.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each service rate case record in the service domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each service rate case record in the service domain.',
    `filed_date` TIMESTAMP COMMENT 'The filed date associated with each service rate case record in the service domain.',
    `filing_date` TIMESTAMP COMMENT 'Date case was filed. Ref: Oracle CC&B.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: Oracle CC&B.',
    `hearing_date` TIMESTAMP COMMENT 'The hearing date associated with each service rate case record in the service domain.',
    `interim_effective_date` TIMESTAMP COMMENT 'Date interim rates became effective. Ref: Oracle CC&B.',
    `intervenors` STRING COMMENT 'Comma-separated list of intervenors. Ref: Oracle CC&B.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Oracle CC&B.',
    `is_contested` BOOLEAN COMMENT 'Flag indicating the rate case is contested by intervenors. Ref: Oracle CC&B.',
    `is_interim_rates_granted` DECIMAL(18,2) COMMENT 'Whether interim/temporary rates were granted pending final decision. Ref: Oracle CC&B.',
    `is_settled` BOOLEAN COMMENT 'Whether case was settled vs litigated. Ref: Oracle CC&B.',
    `lead_attorney` STRING COMMENT 'Lead attorney for utility. Ref: Oracle CC&B.',
    `lead_attorney_name` STRING COMMENT 'Name of lead attorney for the case. Ref: Oracle CC&B.',
    `service_rate_case_name` STRING COMMENT 'The service rate case name used to identify each service rate case record in the service domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Oracle CC&B.',
    `number_of_customers_affected` STRING COMMENT 'Number of customers affected by the rate change. Ref: Oracle CC&B.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each service rate case in the service domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each service rate case in the service domain.',
    `proposed_effective_date` TIMESTAMP COMMENT 'Proposed effective date for new rates. Ref: Oracle CC&B.',
    `public_comments_received` STRING COMMENT 'Number of public comments received. Ref: Oracle CC&B.',
    `public_hearing_date` TIMESTAMP COMMENT 'Date of public hearing. Ref: Oracle CC&B.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each service rate case in the service domain.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'Rate base amount. Ref: Oracle CC&B.',
    `rate_base_usd` DECIMAL(18,2) COMMENT 'Utility rate base used in determination. Ref: Oracle CC&B.',
    `rate_case_name` DECIMAL(18,2) COMMENT 'The rate case name used to identify each service rate case record in the service domain.',
    `rate_case_number` DECIMAL(18,2) COMMENT 'The rate case number value recorded for each service rate case in the service domain.',
    `rate_case_status` DECIMAL(18,2) COMMENT 'The rate case status value recorded for each service rate case in the service domain.',
    `rate_case_type` DECIMAL(18,2) COMMENT 'General rate increase, cost of service, formula rate. Ref: Oracle CC&B.',
    `rate_of_return_approved` DECIMAL(18,2) COMMENT 'Rate of return on rate base approved. Ref: Oracle CC&B.',
    `rate_of_return_pct` DECIMAL(18,2) COMMENT 'Approved rate of return percentage. Ref: Oracle CC&B.',
    `rate_of_return_requested` DECIMAL(18,2) COMMENT 'Rate of return on rate base requested. Ref: Oracle CC&B.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Oracle CC&B.',
    `record_status` STRING COMMENT 'The record status value recorded for each service rate case in the service domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each service rate case in the service domain.',
    `regulatory_authority` STRING COMMENT 'The regulatory authority value recorded for each service rate case in the service domain.',
    `regulatory_body` STRING COMMENT 'Regulatory body (PUC, PSC, city_council, board). Ref: Oracle CC&B.',
    `regulatory_commission` STRING COMMENT 'Name of the regulatory commission or governing body. Ref: Oracle CC&B.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each service rate case in the service domain.',
    `requested_increase_pct` DECIMAL(18,2) COMMENT 'The requested increase pct value recorded for each service rate case in the service domain.',
    `requested_rate_increase_pct` DECIMAL(18,2) COMMENT 'The requested rate increase pct value recorded for each service rate case in the service domain.',
    `requested_rate_of_return_pct` DECIMAL(18,2) COMMENT 'Rate of return requested. Ref: Oracle CC&B.',
    `requested_revenue_amount` DECIMAL(18,2) COMMENT 'Requested additional revenue amount. Ref: Oracle CC&B.',
    `requested_revenue_increase` DECIMAL(18,2) COMMENT 'The requested revenue increase value recorded for each service rate case in the service domain.',
    `requested_revenue_increase_pct` DECIMAL(18,2) COMMENT 'Requested revenue increase percentage. Ref: Oracle CC&B.',
    `requested_revenue_increase_usd` DECIMAL(18,2) COMMENT 'The requested revenue increase usd value recorded for each service rate case in the service domain.',
    `requested_revenue_requirement` DECIMAL(18,2) COMMENT 'Total revenue requirement requested. Ref: Oracle CC&B.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each service rate case record in the service domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each service rate case in the service domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each service rate case in the service domain.',
    `return_on_equity_pct` DECIMAL(18,2) COMMENT 'Authorized return on equity. Ref: Oracle CC&B.',
    `revenue_requirement_amount` DECIMAL(18,2) COMMENT 'Approved revenue requirement. Ref: Oracle CC&B.',
    `revenue_requirement_usd` DECIMAL(18,2) COMMENT 'The revenue requirement usd value recorded for each service rate case in the service domain.',
    `service_finance_rate_case_id` DECIMAL(18,2) COMMENT 'Unique identifier for the service finance rate case referenced by each service rate case record in the service domain.',
    `service_rate_case_number` STRING COMMENT 'The service rate case number value recorded for each service rate case in the service domain.',
    `service_rate_case_type` STRING COMMENT 'The service rate case type value recorded for each service rate case in the service domain.',
    `settlement_description` STRING COMMENT 'Description of settlement terms. Ref: Oracle CC&B.',
    `settlement_reached` BOOLEAN COMMENT 'Whether case was resolved by settlement. Ref: Oracle CC&B.',
    `ssot_resolution_type` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: Oracle CC&B.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'SSOT cross-domain reconciliation link. Ref: Oracle CC&B.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each service rate case record in the service domain.',
    `service_rate_case_status` STRING COMMENT 'Lifecycle status of the record. Ref: Oracle CC&B.',
    `test_year_end` STRING COMMENT 'Test year end date. Ref: Oracle CC&B.',
    `test_year_end_date` TIMESTAMP COMMENT 'End of the test year. Ref: Oracle CC&B.',
    `test_year_start` STRING COMMENT 'Test year start date. Ref: Oracle CC&B.',
    `test_year_start_date` TIMESTAMP COMMENT 'Start of the test year used for rate determination. Ref: Oracle CC&B.',
    `test_year_type` STRING COMMENT 'Type of test year used (historical, future, hybrid). Ref: Oracle CC&B.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each service rate case in the service domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Oracle CC&B.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: Oracle CC&B.',
    CONSTRAINT pk_service_rate_case PRIMARY KEY(`service_rate_case_id`)
) COMMENT 'Tracks the lifecycle of regulatory rate case proceedings filed with the Public Utilities Commission or state regulatory authority to adjust water and wastewater service rates. Captures filing date, test year, requested revenue requirement, approved revenue requirement, rate case status, hearing dates, intervenor parties, final order date, and the resulting approved tariff reference. Supports financial planning, regulatory compliance, and rate modeling. [SSOT delegates to finance.finance_rate_case] [SSOT: reference view of canonical finance.finance_rate_case] Consolidated: finance.finance_rate_case is SSOT; this table references it. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`special_contract` (
    `special_contract_id` BIGINT COMMENT 'Unique identifier for the special contract record. Primary key. Ref: AWWA.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Special contracts are negotiated agreements that extend or modify standard service agreements. Currently has customer_account_id but missing the service_agreement link. Special contracts should refere. Ref: AWWA.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Special contracts (large industrial users, negotiated rates) require dedicated billing accounts with custom rate structures. Contract billing administration depends on linking the contract to the bill. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Large industrial or municipal customers under special contracts often have dedicated infrastructure projects (dedicated treatment capacity, private mains, interconnections). Contract compliance, capit. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the large industrial, municipal, or wholesale customer party under this special contract. Ref: AWWA.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.rate_case. Business justification: Special contracts require rate case approval or tariff deviation justification. Links negotiated rates to regulatory proceedings for PUC compliance, cost-of-service justification, and audit trails. Re. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Special contracts (large industrial users) require dedicated fund accounting for revenue tracking, regulatory reporting, and rate case revenue requirement analysis. Essential for wholesale/industrial. Ref: AWWA.',
    `pretreatment_iup_id` BIGINT COMMENT 'Foreign key linking to compliance.pretreatment_iup. Business justification: Special contracts for industrial users reference their IUP (Industrial User Permit). Contract terms (volume, discharge limits, pricing) must align with pretreatment permit conditions. Links billing, s. Ref: AWWA.',
    `amendment_count` STRING COMMENT 'Total number of amendments or modifications made to the original contract. Ref: AWWA.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term unless either party provides notice of termination. Ref: AWWA.',
    `base_rate_per_unit` DECIMAL(18,2) COMMENT 'Negotiated base rate per unit of water (typically per thousand gallons or per cubic meter) under the special contract. Ref: AWWA.',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer is billed under the special contract: monthly, quarterly, annual, or custom. Ref: AWWA.. Valid values are `monthly|quarterly|annual|custom`',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed contract document stored in the document management system. Ref: AWWA.',
    `contract_duration_months` STRING COMMENT 'Total duration of the contract term expressed in months, used for renewal planning and rate case modeling. Ref: AWWA.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the special contract for business reference and reporting. Ref: AWWA.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the special contract, used in regulatory filings and customer correspondence. Ref: AWWA.',
    `contract_signed_date` DATE COMMENT 'Date when the contract was executed and signed by all parties. Ref: AWWA.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the special contract indicating its operational state and regulatory approval status. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `contract_type` STRING COMMENT 'Classification of the special contract indicating the nature of the agreement: industrial user, wholesale, intergovernmental, municipal, bulk supply, or special rate. Ref: AWWA.. Valid values are `industrial_user|wholesale|intergovernmental|municipal|bulk_supply|special_rate`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the contract over its full term, used for financial planning and revenue forecasting. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this special contract record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `demand_charge_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic demand charge assessed to reserve capacity for the customer, independent of actual consumption. Ref: AWWA.',
    `discharge_limit_bod_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum allowable BOD concentration in wastewater discharge under the special contract, measured in mg/L. Ref: AWWA.',
    `discharge_limit_tss_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum allowable TSS concentration in wastewater discharge under the special contract, measured in mg/L. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when the special contract terms expire or terminate. Nullable for open-ended contracts subject to renewal. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when the special contract terms become binding and enforceable. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `iup_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether the customer is required to maintain an Industrial User Permit (IUP) and comply with pretreatment requirements as a condition of the contract. Ref: AWWA.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this special contract record was last updated in the system. Ref: AWWA.',
    `maximum_volume_limit_mgd` DECIMAL(18,2) COMMENT 'Maximum daily water volume (in MGD) that the utility agrees to supply under the contract, defining capacity allocation limits. Ref: AWWA.',
    `minimum_volume_commitment_mgd` DECIMAL(18,2) COMMENT 'Minimum daily water volume (in MGD) that the customer commits to purchase under the contract, used for capacity planning and revenue forecasting. Ref: AWWA.',
    `negotiated_rate_structure` DECIMAL(18,2) COMMENT 'Type of rate structure negotiated in the special contract: flat rate, tiered volume, demand charge, time-of-use, seasonal, or custom. Ref: AWWA.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or modify the contract. Ref: AWWA.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due under the contract terms. Ref: AWWA.',
    `penalty_for_over_consumption` DECIMAL(18,2) COMMENT 'Financial penalty or surcharge assessed if the customer exceeds the maximum volume limit, typically expressed as a per-unit overage charge. Ref: AWWA.',
    `penalty_for_under_consumption` DECIMAL(18,2) COMMENT 'Financial penalty assessed if the customer fails to meet the minimum volume commitment, typically expressed as a fixed amount or per-unit shortfall charge. Ref: AWWA.',
    `pretreatment_requirements` STRING COMMENT 'Detailed description of wastewater pretreatment requirements the customer must meet, including discharge limits for BOD, COD, TSS, TDS, pH, FOG, and other pollutants. Ref: AWWA.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory authority approved the special contract for execution. Ref: AWWA.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval from the Public Utilities Commission or other governing body for this special contract. Ref: AWWA.. Valid values are `pending|approved|rejected|conditional|exempt`',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or docket number assigned by the regulatory authority for the special contract filing. Ref: AWWA.',
    `renewal_terms` STRING COMMENT 'Textual description of contract renewal terms, including automatic renewal provisions, notice periods, and renegotiation conditions. Ref: AWWA.',
    `signatory_name` STRING COMMENT 'Name of the authorized representative who signed the contract on behalf of the customer. Ref: AWWA.',
    `signatory_title` STRING COMMENT 'Job title or position of the authorized representative who signed the contract on behalf of the customer. Ref: AWWA.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours guaranteed under the SLA for service requests or outage notifications. Ref: AWWA.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed service uptime percentage under the SLA, typically expressed as a percentage (e.g., 99.50 for 99.5% uptime). Ref: AWWA.',
    `special_conditions` STRING COMMENT 'Free-text field capturing any additional special conditions, covenants, or obligations unique to this contract, such as infrastructure contributions, service level guarantees, or operational constraints. Ref: AWWA.',
    `tariff_deviation_justification` STRING COMMENT 'Business and regulatory justification for deviating from standard published tariff terms, required for regulatory approval. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    CONSTRAINT pk_special_contract PRIMARY KEY(`special_contract_id`)
) COMMENT 'Records negotiated special service contracts with large industrial, municipal, or wholesale customers that deviate from standard tariff terms. Captures contract type (industrial user, wholesale, intergovernmental), negotiated rate terms, minimum volume commitments (MGD), demand charge structure, contract duration, renewal terms, special conditions (IUP compliance, pretreatment requirements), and regulatory approval status. Distinct from standard service agreements governed by published tariffs. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` (
    `conservation_program_id` BIGINT COMMENT 'Unique identifier for the water conservation program record. Primary key. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Conservation programs are funded by designated utility funds (often rate-funded conservation funds or restricted funds). Essential for budget tracking, expenditure authorization, and regulatory report. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Many conservation programs are grant-funded (state/federal water efficiency grants, EPA WaterSense). Grant expenditure tracking required for compliance, drawdown requests, and single audit reporting.. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Conservation programs in water utilities have designated employee program managers responsible for execution, budget, enrollment, and regulatory reporting. Links employee accountability to program per. Ref: AWWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Conservation programs are often mandated by regulatory requirements (drought response orders, demand management mandates, water use efficiency standards). Program design, targets, and reporting tied t. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Conservation programs are often territory-specific with territory-level water savings targets and regulatory mandates. Adding this link enables territory-based program management and reporting. Ref: AWWA.',
    `actual_participant_count` STRING COMMENT 'Current count of customers or accounts enrolled and participating in the conservation program. Ref: AWWA.',
    `actual_water_savings_gallons` BIGINT COMMENT 'Measured or estimated cumulative water savings achieved by the program to date, in gallons. Ref: AWWA.',
    `actual_water_savings_mgd` DECIMAL(18,2) COMMENT 'The actual water savings mgd value recorded for each conservation program in the service domain.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount value recorded for each conservation program in the service domain.',
    `budget_expended_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of program budget spent as of the last reporting period, in US dollars. Ref: AWWA.',
    `contact_email` STRING COMMENT 'Primary email address for customer inquiries and program communications. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for customer inquiries and program support. Ref: AWWA.. Valid values are `^+?[0-9]{10,15}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the conservation program record. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was first created in the system. Ref: AWWA.',
    `customer_class_applicability` STRING COMMENT 'Customer class segments eligible to participate in this conservation program. Ref: AWWA.. Valid values are `residential|commercial|industrial|agricultural|municipal|all`',
    `effective_start_date` TIMESTAMP COMMENT 'The effective start date associated with each conservation program record in the service domain.',
    `eligibility_criteria` STRING COMMENT 'Detailed requirements and conditions that customers must meet to participate in the conservation program, including customer class, service type, meter size, and usage thresholds. Ref: AWWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each conservation program record in the service domain.',
    `enrollment_end_date` DATE COMMENT 'Date when customer enrollment or application for the program closes. Null for open enrollment programs. Ref: AWWA.',
    `enrollment_start_date` DATE COMMENT 'Date when customer enrollment or application for the program opens. Ref: AWWA.',
    `funding_source` STRING COMMENT 'Source of funds supporting the conservation program, such as operating budget, capital improvement program, state grants, or federal funding. Ref: AWWA.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the incentive provided per qualifying customer or installation, in US dollars. Ref: AWWA.',
    `incentive_type` STRING COMMENT 'Type of financial or non-financial incentive offered to customers participating in the program. Ref: AWWA.. Valid values are `rebate|discount|credit|grant|free_equipment|rate_reduction`',
    `incentive_unit` STRING COMMENT 'Unit of measure for calculating and distributing the incentive to program participants. Ref: AWWA.. Valid values are `per_fixture|per_device|per_audit|per_gallon_saved|per_account|lump_sum`',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the conservation program record. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was last updated. Ref: AWWA.',
    `last_reported_date` DATE COMMENT 'Date of the most recent performance report submitted for this conservation program. Ref: AWWA.',
    `marketing_campaign_code` STRING COMMENT 'Code linking the conservation program to specific marketing and outreach campaigns for tracking effectiveness. Ref: AWWA.',
    `maximum_incentive_per_customer` DECIMAL(18,2) COMMENT 'Cap on the total incentive amount a single customer can receive under this program during the program period, in US dollars. Ref: AWWA.',
    `performance_metric_definition` STRING COMMENT 'Description of the key performance indicators (KPIs) used to measure program success, such as gallons saved per dollar spent or participation rate. Ref: AWWA.',
    `program_category` STRING COMMENT 'Target sector or application area for the conservation program. Ref: AWWA.. Valid values are `indoor|outdoor|commercial|industrial|agricultural|residential`',
    `program_code` STRING COMMENT 'Unique business identifier code for the conservation program, used for external reference and reporting. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_description` STRING COMMENT 'Detailed description of the conservation program objectives, activities, and benefits to customers and the utility. Ref: AWWA.',
    `program_end_date` DATE COMMENT 'Date when the conservation program concludes and no new participants are accepted. Null for ongoing programs. Ref: AWWA.',
    `program_name` STRING COMMENT 'Full descriptive name of the conservation program as presented to customers and in regulatory filings. Ref: AWWA.',
    `program_notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the conservation program administration and operations. Ref: AWWA.',
    `program_start_date` DATE COMMENT 'Date when the conservation program becomes active and customers can begin participating. Ref: AWWA.',
    `program_status` STRING COMMENT 'Current lifecycle status of the conservation program. Ref: AWWA.. Valid values are `draft|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the conservation program by delivery mechanism and approach. [ENUM-REF-CANDIDATE: rebate|tiered_pricing|water_audit|drought_surcharge|education|restriction|incentive — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `program_website_url` STRING COMMENT 'Web address where customers can find detailed program information, eligibility requirements, and application forms. Ref: AWWA.',
    `rebate_amount_per_unit` DECIMAL(18,2) COMMENT 'The rebate amount per unit value recorded for each conservation program in the service domain.',
    `regulatory_approval_date` DATE COMMENT 'Date when the conservation program received regulatory approval from the governing authority. Ref: AWWA.',
    `regulatory_approval_number` STRING COMMENT 'Approval or permit number issued by the state Public Utilities Commission or environmental agency authorizing the program. Ref: AWWA.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the conservation program is required by state or federal regulation (True) or is voluntary (False). Ref: AWWA.',
    `regulatory_mandate_reference` STRING COMMENT 'Citation or reference to the specific regulation, statute, or executive order requiring or authorizing the conservation program. Ref: AWWA.',
    `reporting_frequency` STRING COMMENT 'Frequency at which program performance and results are reported to regulatory agencies and utility management. Ref: AWWA.. Valid values are `monthly|quarterly|annually|on_demand`',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each conservation program record in the service domain.',
    `target_participant_count` STRING COMMENT 'Goal for the number of customers or accounts participating in the conservation program. Ref: AWWA.',
    `target_water_savings_gallons` BIGINT COMMENT 'Projected total water savings goal for the program over its duration, measured in gallons. Ref: AWWA.',
    `target_water_savings_mgd` DECIMAL(18,2) COMMENT 'The target water savings mgd value recorded for each conservation program in the service domain.',
    `tariff_reference` STRING COMMENT 'Reference to the utility tariff schedule or rate case filing that includes this conservation program. Ref: AWWA.',
    `total_program_budget` DECIMAL(18,2) COMMENT 'Total allocated budget for the conservation program over its entire duration, in US dollars. Ref: AWWA.',
    `total_rebates_paid` DECIMAL(18,2) COMMENT 'The total rebates paid value recorded for each conservation program in the service domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each conservation program record in the service domain.',
    CONSTRAINT pk_conservation_program PRIMARY KEY(`conservation_program_id`)
) COMMENT 'Master catalog of customer programs including water conservation programs (rebates, tiered pricing incentives, water audits, drought surcharges), demand management programs, and customer affordability/assistance programs (lifeline rates, PIPP, bill discounts, emergency assistance). Captures program name, program type, eligibility criteria (including income thresholds for affordability programs), incentive or benefit structure, funding source, program period, target outcomes, enrollment tracking, and regulatory mandate reference. Supports AWWA water efficiency goals, state conservation mandates, and regulatory affordability requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` (
    `affordability_plan_id` BIGINT COMMENT 'Unique identifier for the affordability plan. Primary key. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Low-income assistance programs are funded by designated funds (rate-funded assistance funds or restricted funds). Essential for subsidy accounting, budget tracking, and regulatory reporting of afforda. Ref: AWWA.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Affordability plans apply to specific customer service classes. Currently customer_class_applicability is a STRING, but this should be a FK to service_class for referential integrity and to enable cla. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Affordability and low-income assistance programs can be territory-specific, as different jurisdictions may have different regulatory mandates, funding sources, or eligibility criteria. This FK allows. Ref: AWWA.',
    `application_process_description` STRING COMMENT 'Description of the process customers must follow to apply for enrollment in this affordability plan, including required documentation and submission channels. Ref: AWWA.',
    `auto_enrollment_flag` BOOLEAN COMMENT 'Indicates whether eligible customers are automatically enrolled in this affordability plan based on participation in other assistance programs (e.g., SNAP, Medicaid, LIHEAP). True if auto-enrollment is enabled, false if customers must apply. Ref: AWWA.',
    `contact_email` STRING COMMENT 'Email address customers can use to request information about this affordability plan or submit application inquiries. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number customers can call for information about this affordability plan, application assistance, or enrollment status inquiries. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this affordability plan record. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this affordability plan record was first created in the system. Ref: AWWA.',
    `current_enrollment_count` STRING COMMENT 'Current number of customers actively enrolled in this affordability plan. Updated periodically to reflect enrollment changes. Ref: AWWA.',
    `discount_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed dollar credit amount applied to the customers bill per billing cycle when the discount type is fixed amount. Null if discount type is not fixed amount. Ref: AWWA.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percent value recorded for each affordability plan in the service domain.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the customers water and/or wastewater bill when the discount type is percentage-based. Null if discount type is not percentage. Ref: AWWA.',
    `discount_type` STRING COMMENT 'The mechanism by which the affordability benefit is applied: percentage (percent off total bill), fixed amount (dollar credit per billing cycle), rate reduction (lower volumetric or base rate), bill cap (maximum bill amount), or usage credit (free gallons or cubic meters). Ref: AWWA.. Valid values are `percentage|fixed_amount|rate_reduction|bill_cap|usage_credit`',
    `effective_end_date` DATE COMMENT 'Date on which this affordability plan expires or is discontinued. Null if the plan has no scheduled end date. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date on which this affordability plan becomes active and available for customer enrollment. Ref: AWWA.',
    `eligibility_criteria` STRING COMMENT 'The eligibility criteria value recorded for each affordability plan in the service domain.',
    `eligibility_income_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum annual household income amount (in local currency) that qualifies a customer for enrollment in this affordability plan. Typically expressed as a percentage of Federal Poverty Level (FPL) or Area Median Income (AMI). Ref: AWWA.',
    `eligibility_income_threshold_basis` STRING COMMENT 'The reference standard used to determine income eligibility: federal poverty level (FPL percentage), area median income (AMI percentage), state median income (SMI percentage), or fixed amount (absolute dollar threshold). Ref: AWWA.. Valid values are `federal_poverty_level|area_median_income|state_median_income|fixed_amount`',
    `eligibility_income_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage of the income threshold basis (e.g., 150% of FPL, 80% of AMI) used to determine customer eligibility for the affordability plan. Ref: AWWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each affordability plan record in the service domain.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of customers who can be enrolled in this affordability plan at any given time. Null if no enrollment cap applies. Ref: AWWA.',
    `enrollment_count` STRING COMMENT 'The enrollment count value recorded for each affordability plan in the service domain.',
    `funding_source` STRING COMMENT 'Primary source of funding for the affordability plan: utility revenue (general operating funds), rate surcharge (dedicated customer charge), municipal subsidy (city/county budget), state grant, federal grant, private donation, or cross subsidy (higher-income customer rates). [ENUM-REF-CANDIDATE: utility_revenue|rate_surcharge|municipal_subsidy|state_grant|federal_grant|private_donation|cross_subsidy — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `income_eligibility_threshold` DECIMAL(18,2) COMMENT 'The income eligibility threshold value recorded for each affordability plan in the service domain.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this affordability plan record. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this affordability plan record was last updated in the system. Ref: AWWA.',
    `max_annual_benefit_amount` DECIMAL(18,2) COMMENT 'The max annual benefit amount value recorded for each affordability plan in the service domain.',
    `maximum_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum total dollar benefit a customer can receive per billing cycle or per enrollment period under this affordability plan. Null if no cap applies. Ref: AWWA.',
    `maximum_benefit_duration_months` STRING COMMENT 'Maximum number of months a customer can remain enrolled in this affordability plan before re-certification or plan expiration. Null if no duration limit applies. Ref: AWWA.',
    `monthly_credit_amount` DECIMAL(18,2) COMMENT 'The monthly credit amount value recorded for each affordability plan in the service domain.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this affordability plan, including program changes, temporary modifications, or administrative remarks. Ref: AWWA.',
    `partner_program_name` STRING COMMENT 'Name of external assistance program(s) used for auto-enrollment eligibility verification (e.g., SNAP, Medicaid, LIHEAP, TANF). Null if auto-enrollment is not enabled. Ref: AWWA.',
    `plan_code` STRING COMMENT 'Unique business identifier code for the affordability plan, used for external reference and reporting. Ref: AWWA.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the affordability plan, including objectives, benefits, and terms of assistance provided to eligible customers. Ref: AWWA.',
    `plan_name` STRING COMMENT 'Full descriptive name of the affordability plan (e.g., Lifeline Rate Program, Low-Income Assistance Plan, Percentage of Income Payment Plan). Ref: AWWA.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the affordability plan: active (accepting enrollments), inactive (not currently offered), suspended (temporarily paused), pending approval (awaiting regulatory approval), expired (past end date), or discontinued (permanently retired). Ref: AWWA.. Valid values are `active|inactive|suspended|pending_approval|expired|discontinued`',
    `plan_type` STRING COMMENT 'Classification of the affordability plan structure: lifeline rate (reduced base rate), percentage of income (PIPP - bill capped at income percentage), fixed discount (flat dollar or percentage reduction), tiered discount (graduated by income level), emergency assistance (one-time aid), or crisis voucher (short-term relief). Ref: AWWA.. Valid values are `lifeline_rate|percentage_of_income|fixed_discount|tiered_discount|emergency_assistance|crisis_voucher`',
    `program_website_url` STRING COMMENT 'Web address where customers can find detailed information about this affordability plan, download application forms, and access eligibility guidelines. Ref: AWWA.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification events for customers enrolled in this affordability plan. Null if recertification is not required. Ref: AWWA.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must periodically recertify their eligibility to continue receiving benefits under this affordability plan. True if recertification is required, false otherwise. Ref: AWWA.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved this affordability plan for implementation. Null if not applicable. Ref: AWWA.',
    `regulatory_approval_number` STRING COMMENT 'Official approval or docket number issued by the regulatory authority authorizing this affordability plan. Null if not applicable. Ref: AWWA.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or legislative authority that mandates or oversees this affordability plan (e.g., State Public Utilities Commission, City Council Ordinance). Null if plan is voluntary. Ref: AWWA.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis value recorded for each affordability plan in the service domain.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this affordability plan is mandated by state or local regulation, or is a voluntary utility program. True if mandated, false if voluntary. Ref: AWWA.',
    `required_documentation` STRING COMMENT 'List of documents customers must provide to verify eligibility for this affordability plan (e.g., proof of income, tax returns, benefit award letters, utility bills). Ref: AWWA.',
    `service_type_applicability` STRING COMMENT 'Specifies which utility services are covered by this affordability plan: water only, wastewater only, water and wastewater combined, stormwater, or all services. Ref: AWWA.. Valid values are `water_only|wastewater_only|water_and_wastewater|stormwater|all_services`',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each affordability plan record in the service domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each affordability plan record in the service domain.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is maintained for customers when enrollment capacity is reached. True if waitlist is enabled, false otherwise. Ref: AWWA.',
    CONSTRAINT pk_affordability_plan PRIMARY KEY(`affordability_plan_id`)
) COMMENT 'Defines the low-income customer assistance and affordability programs available, including lifeline rates, percentage-of-income payment plans (PIPP), bill discount programs, and emergency assistance funds. Captures plan name, eligibility income thresholds, discount percentage or fixed credit amount, maximum benefit duration, funding source, regulatory mandate, and enrollment capacity. Supports equitable access to essential water services and regulatory affordability requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` (
    `bulk_water_agreement_id` BIGINT COMMENT 'Unique identifier for the bulk water supply agreement. Primary key for the bulk water agreement entity. Ref: AWWA.',
    `agreement_id` BIGINT COMMENT 'Unique identifier for the agreement referenced by each bulk water agreement record in the service domain.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Bulk water agreements (wholesale customers, neighboring utilities) require billing accounts for invoicing contracted volumes. Wholesale billing operations depend on linking the agreement to the accoun. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Bulk water agreements (wholesale supply to neighboring utilities) often require dedicated infrastructure projects (interconnections, booster stations, dedicated pipelines). Contract performance monito. Ref: AWWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Bulk water agreements require water withdrawal permits or inter-jurisdictional transfer permits. Utility tracks regulatory approval for wholesale water transactions, ensuring compliance with permitted. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each bulk water agreement record in the service domain.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Wholesale delivery points are physical assets (interconnection vaults, master meters, pressure control stations) requiring maintenance, inspection, and emergency response planning. Operations teams ne. Ref: AWWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Bulk water delivery points need DMA assignment for wholesale flow monitoring, NRW accounting (separating wholesale from retail losses), zone-level demand forecasting, and contracted_volume_mgd verific. Ref: AWWA.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.rate_case. Business justification: Bulk water rates are established through rate case proceedings. Regulatory approval required for wholesale pricing. Links wholesale rate structure to rate case docket for PUC compliance and cost-of-se. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Bulk water sales revenue flows to specific utility funds. Essential for wholesale revenue accounting, interfund transfers, and GASB reporting. Water utilities track wholesale vs. retail revenue by fun. Ref: AWWA.',
    `metering_meter_id` BIGINT COMMENT 'Unique identifier of the meter installed at the delivery point to measure bulk water volumes for billing and compliance purposes. Links to asset management system. Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Bulk delivery points must reference pressure zones for hydraulic capacity verification, delivery_pressure_psi guarantee compliance, system impact analysis, and zone-level demand accounting. Critical f. Ref: AWWA.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Bulk water sale agreements to neighboring utilities often have associated procurement contracts for treatment chemicals, power, or infrastructure maintenance that are cost-allocated to the bulk water. Ref: AWWA.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Bulk water agreements are delivered within specific service territories. The delivery_point_description and coordinates indicate a geographic location that should be tied to a service territory for fr. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Wholesale water agreements specify which treatment facility supplies the bulk water - essential for capacity planning, contract compliance verification (volume/quality commitments), and cost allocatio. Ref: AWWA.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the bulk water agreement: draft (under negotiation), pending approval (awaiting regulatory or board approval), active (in force), suspended (temporarily halted), terminated (ended before expiration), or expired (reached end date). Ref: AWWA.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the bulk water agreement based on the nature of service: wholesale supply (ongoing large-volume delivery), bulk purchase (one-time or periodic large purchases), emergency interconnection (backup supply during outages), seasonal supply (peak demand periods), treatment services (wastewater treatment for another utility), or wastewater discharge (acceptance of wastewater flows). Ref: AWWA.. Valid values are `wholesale_supply|bulk_purchase|emergency_interconnection|seasonal_supply|treatment_services|wastewater_discharge`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the contract term unless either party provides termination notice. True if auto-renewal applies, False otherwise. Ref: AWWA.',
    `base_rate_per_thousand_gallons` DECIMAL(18,2) COMMENT 'Base volumetric rate charged per thousand gallons of water delivered or wastewater treated under the agreement. Null if pricing is not volumetric. Ref: AWWA.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are issued to the counterparty for bulk water supply or treatment services: monthly, quarterly, or annual. Ref: AWWA.. Valid values are `monthly|quarterly|annual`',
    `capacity_charge_annual` DECIMAL(18,2) COMMENT 'Annual capacity reservation charge paid by the purchasing party to reserve a specific volume of supply or treatment capacity, independent of actual usage. Null if no capacity charge applies. Ref: AWWA.',
    `contract_term_years` STRING COMMENT 'Duration of the agreement in years from effective start date to effective end date. Null for open-ended agreements. Ref: AWWA.',
    `contracted_volume_mgd` DECIMAL(18,2) COMMENT 'The contracted daily volume of water supply or wastewater treatment capacity in Million Gallons per Day (MGD). Represents the baseline or maximum daily volume agreed upon in the contract. Ref: AWWA.',
    `counterparty_contact_email` STRING COMMENT 'Primary email address for the counterparty contact person for agreement communications and notifications. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `counterparty_contact_name` STRING COMMENT 'Primary contact person name at the counterparty organization for agreement administration and operational coordination. Ref: AWWA.',
    `counterparty_contact_phone` STRING COMMENT 'Primary phone number for the counterparty contact person for operational coordination and emergency notifications. Ref: AWWA.',
    `counterparty_name` STRING COMMENT 'Legal name of the wholesale customer or supplying utility party to the agreement (e.g., neighboring municipality, regional water authority, industrial facility). Ref: AWWA.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty organization: municipality, water district, industrial customer, commercial customer, government agency, or neighboring utility. Ref: AWWA.. Valid values are `municipality|water_district|industrial|commercial|government_agency|neighboring_utility`',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created the bulk water agreement record in the system. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk water agreement record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'The currency code value recorded for each bulk water agreement in the service domain.',
    `delivery_point_description` STRING COMMENT 'Textual description of the physical location where water is delivered or wastewater is received, including interconnection point, meter location, or facility name. Ref: AWWA.',
    `delivery_point_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery or acceptance point for GIS mapping and asset management integration. Ref: AWWA.',
    `delivery_point_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery or acceptance point for GIS mapping and asset management integration. Ref: AWWA.',
    `delivery_pressure_psi_max` DECIMAL(18,2) COMMENT 'Maximum allowable delivery pressure in Pounds per Square Inch (PSI) at the interconnection point to prevent damage to the receiving utilitys infrastructure. Ref: AWWA.',
    `delivery_pressure_psi_min` DECIMAL(18,2) COMMENT 'Minimum required delivery pressure in Pounds per Square Inch (PSI) at the interconnection point to meet the purchasing utilitys distribution system requirements. Ref: AWWA.',
    `demand_charge_amount` DECIMAL(18,2) COMMENT 'The demand charge amount value recorded for each bulk water agreement in the service domain.',
    `effective_end_date` DATE COMMENT 'Date when the bulk water agreement expires or terminates. Null for open-ended agreements or those with automatic renewal provisions. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when the bulk water agreement becomes legally binding and service delivery or acceptance obligations commence. Ref: AWWA.',
    `emergency_supply_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions for emergency water supply during outages, droughts, or infrastructure failures. True if emergency provisions exist, False otherwise. Ref: AWWA.',
    `emergency_supply_terms` STRING COMMENT 'Detailed description of emergency supply terms, including trigger conditions, maximum emergency volume, duration limits, and emergency pricing. Null if no emergency provisions exist. Ref: AWWA.',
    `intergovernmental_agreement_flag` BOOLEAN COMMENT 'Indicates whether this is an intergovernmental agreement between two public entities (municipalities, water districts, government agencies), which may have special legal status and exemptions. True if intergovernmental, False otherwise. Ref: AWWA.',
    `late_payment_penalty_percent` DECIMAL(18,2) COMMENT 'Percentage penalty applied to overdue balances for late payment, expressed as an annual percentage rate or per-period rate as specified in the agreement. Ref: AWWA.',
    `metering_responsibility` STRING COMMENT 'Party responsible for installation, maintenance, and calibration of metering equipment at the delivery point: supplier, purchaser, or shared responsibility. Ref: AWWA.. Valid values are `supplier|purchaser|shared`',
    `minimum_take_or_pay_mgd` DECIMAL(18,2) COMMENT 'The minimum take or pay mgd value recorded for each bulk water agreement in the service domain.',
    `minimum_take_volume_mgd` DECIMAL(18,2) COMMENT 'Minimum daily volume in Million Gallons per Day (MGD) that the purchasing party is obligated to take or pay for under take-or-pay provisions. Null if no minimum take obligation exists. Ref: AWWA.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified the bulk water agreement record in the system. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk water agreement record was last modified in the system. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, historical context, or operational considerations related to the bulk water agreement. Ref: AWWA.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due from the counterparty. Ref: AWWA.',
    `peak_delivery_rate_mgd` DECIMAL(18,2) COMMENT 'The peak delivery rate mgd value recorded for each bulk water agreement in the service domain.',
    `peak_volume_mgd` DECIMAL(18,2) COMMENT 'Maximum allowable daily volume in Million Gallons per Day (MGD) that can be delivered or accepted under the agreement, representing peak capacity limits. Ref: AWWA.',
    `pricing_structure_type` STRING COMMENT 'Type of pricing mechanism used in the agreement: flat rate (fixed monthly/annual charge), volumetric (per-gallon charge), tiered (volume-based tiers), demand charge (capacity reservation fee), take-or-pay (minimum volume commitment), or cost-plus (cost recovery plus margin). Ref: AWWA.. Valid values are `flat_rate|volumetric|tiered|demand_charge|take_or_pay|cost_plus`',
    `rate_escalation_clause` STRING COMMENT 'Description of the rate escalation mechanism in the agreement, such as annual CPI adjustment, fixed percentage increase, or cost-of-service pass-through provisions. Ref: AWWA.',
    `rate_per_kgal` DECIMAL(18,2) COMMENT 'The rate per kgal value recorded for each bulk water agreement in the service domain.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory authority formally approved the bulk water agreement and its terms. Ref: AWWA.',
    `regulatory_approval_number` STRING COMMENT 'Unique identifier or docket number assigned by the regulatory authority when approving the bulk water agreement and its rate structure. Ref: AWWA.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or Public Utilities Commission that has jurisdiction over the agreement and must approve rates and terms (e.g., state PUC, EPA regional office, primacy agency). Ref: AWWA.',
    `renewal_term_years` STRING COMMENT 'Duration in years of each automatic renewal period if auto-renewal provisions apply. Null if no auto-renewal. Ref: AWWA.',
    `signed_date` TIMESTAMP COMMENT 'The signed date associated with each bulk water agreement record in the service domain.',
    `take_or_pay_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a take-or-pay provision requiring the purchasing party to pay for a minimum volume regardless of actual usage. True if take-or-pay applies, False otherwise. Ref: AWWA.',
    `term_years` STRING COMMENT 'The term years value recorded for each bulk water agreement in the service domain.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or not renew the agreement. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each bulk water agreement record in the service domain.',
    `water_quality_standard` STRING COMMENT 'Reference to the water quality specifications that delivered water must meet, typically citing EPA Safe Drinking Water Act (SDWA) standards, state primacy agency requirements, or specific contractual quality parameters (e.g., turbidity NTU limits, disinfectant residual, MCL compliance). Ref: AWWA.',
    `wholesale_customer_name` STRING COMMENT 'The wholesale customer name used to identify each bulk water agreement record in the service domain.',
    `wholesale_rate_per_kgal` DECIMAL(18,2) COMMENT 'The wholesale rate per kgal value recorded for each bulk water agreement in the service domain.',
    CONSTRAINT pk_bulk_water_agreement PRIMARY KEY(`bulk_water_agreement_id`)
) COMMENT 'Records negotiated special service agreements with large industrial, municipal, wholesale, or intergovernmental customers that deviate from standard published tariff terms. Covers wholesale bulk water supply, industrial user contracts, intergovernmental agreements, and special pricing arrangements. Captures agreement parties, contract type, negotiated rate terms, volume commitments (MGD), demand charge structure, delivery specifications (pressure, quality), take-or-pay provisions, contract duration, renewal terms, special conditions (IUP compliance, pretreatment requirements), emergency supply terms, and regulatory approval status. Distinct from standard retail service agreements governed by published tariffs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` (
    `offering_territory_availability_id` BIGINT COMMENT 'Unique identifier for this offering-territory availability record. Primary key. Ref: LabWare LIMS.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the service offering being made available in this territory. Ref: LabWare LIMS.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to the service territory where this offering is available. Ref: LabWare LIMS.',
    `availability_end_date` TIMESTAMP COMMENT 'The availability end date associated with each offering territory availability record in the service domain.',
    `availability_start_date` TIMESTAMP COMMENT 'The availability start date associated with each offering territory availability record in the service domain.',
    `availability_status` STRING COMMENT 'Current operational status of this offering within this territory. Available = open for new enrollments; Suspended = temporarily unavailable due to capacity or regulatory issues; Pending_Approval = awaiting regulatory authorization; Discontinued = no longer offered; Restricted = available only to specific customer classes. Ref: LabWare LIMS.',
    `capacity_constraint_flag` BOOLEAN COMMENT 'The capacity constraint flag value recorded for each offering territory availability in the service domain.',
    `capacity_reserved_mgd` DECIMAL(18,2) COMMENT 'Amount of system capacity in million gallons per day reserved or allocated for this offering within this territory. Used for capacity planning and to ensure infrastructure can support the offerings demand. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was created in the system. Ref: LabWare LIMS.',
    `effective_end_date` DATE COMMENT 'Date when this offering was discontinued or became unavailable in this specific territory. Null indicates ongoing availability. Territory-specific discontinuation may occur due to franchise agreement changes or regulatory decisions. Ref: LabWare LIMS.',
    `effective_start_date` DATE COMMENT 'Date when this offering became available for customer enrollment within this specific territory. This is territory-specific and may differ from the offerings global effective_start_date due to phased rollouts or territory-specific regulatory approvals. Ref: LabWare LIMS.',
    `franchise_authorization_date` DATE COMMENT 'Date when the regulatory authority or franchise agreement authorized the utility to provide this specific offering within this territory. Critical for regulatory compliance and audit trails. Ref: LabWare LIMS.',
    `is_available` BOOLEAN COMMENT 'Boolean flag indicating whether the is available condition applies to the offering territory availability record.',
    `marketing_launch_date` DATE COMMENT 'Date when marketing and customer outreach for this offering began in this territory. May differ from effective_start_date due to phased rollout strategies. Ref: LabWare LIMS.',
    `priority_service_flag` BOOLEAN COMMENT 'Indicates whether this offering receives priority deployment or enhanced service levels in this territory, often due to regulatory mandates, environmental justice requirements, or infrastructure investment priorities. Ref: LabWare LIMS.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the territory-specific regulatory approval, rate case docket, or Public Utilities Commission order authorizing this offering in this territory. May differ from the offerings global tariff_reference when territory-specific approvals are required. Ref: LabWare LIMS.',
    `regulatory_approval_required` BOOLEAN COMMENT 'The regulatory approval required value recorded for each offering territory availability in the service domain.',
    `restriction_notes` STRING COMMENT 'The restriction notes value recorded for each offering territory availability in the service domain.',
    `territory_specific_rate_adjustment` DECIMAL(18,2) COMMENT 'Multiplier or adjustment factor applied to the offerings base rates for this specific territory. Used when regulatory authorities approve territory-specific rate variations due to infrastructure costs, population density, or other geographic factors. 1.0 = no adjustment. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was last modified. Ref: LabWare LIMS.',
    CONSTRAINT pk_offering_territory_availability PRIMARY KEY(`offering_territory_availability_id`)
) COMMENT 'This association product represents the availability and authorization of specific water and wastewater service offerings within defined geographic service territories. It captures the regulatory approval, rate adjustments, and lifecycle management of which offerings are available in which territories. Each record links one offering to one service_territory with attributes that exist only in the context of this territory-specific availability, including territory-specific rate adjustments, franchise authorization dates, and availability status that cannot be stored on either the offering or territory alone.. Existence Justification: Water utilities operate service offerings across multiple geographic territories, each with distinct franchise agreements, regulatory approvals, and rate structures. A single offering (e.g., potable water supply) is made available in multiple territories (Downtown District, North County, etc.), and each territory offers multiple service types (potable, wastewater, recycled water). The utility actively manages which offerings are available in which territories, with territory-specific rate adjustments, regulatory authorizations, and lifecycle states that cannot be stored on either the offering or territory entity alone.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` (
    `service_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the program enrollment record. Primary key. Ref: AWWA.',
    `affordability_plan_id` BIGINT COMMENT 'Unique identifier for the affordability plan referenced by each service program enrollment record in the service domain.',
    `agreement_id` BIGINT COMMENT 'Reference to the service agreement associated with this enrollment. Ref: AWWA.',
    `billing_account_id` BIGINT COMMENT 'Foreign key to billing_account. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each service program enrollment record in the service domain.',
    `conservation_program_id` BIGINT COMMENT 'Reference to the conservation, assistance, or demand management program. Ref: AWWA.',
    `service_account_billing_account_id` BIGINT COMMENT 'Foreign key linking to the billing account enrolled in the conservation program. Ref: AWWA.',
    `service_conservation_program_id` BIGINT COMMENT 'Unique identifier for the service conservation program referenced by each service program enrollment record in the service domain.',
    `customer_program_enrollment_id` BIGINT COMMENT 'Reference to primary customer.customer_program_enrollment for SSOT alignment. Ref: AWWA.',
    `service_canonical_customer_program_enrollment_id` BIGINT COMMENT 'Reference FK to canonical SSOT customer.customer_program_enrollment. Ref: AWWA.',
    `application_date` DATE COMMENT 'Date when the customer submitted their application to enroll in this conservation program. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date when the enrollment application was approved by program administrators. Ref: AWWA.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the enrollment automatically renews at the end of the term. Ref: AWWA.',
    `baseline_consumption_gallons` DECIMAL(18,2) COMMENT 'Customer water consumption baseline measured in gallons prior to program enrollment. Used to calculate savings. Ref: AWWA.',
    `baseline_period_end_date` DATE COMMENT 'End date of the baseline measurement period used to establish pre-program consumption. Ref: AWWA.',
    `baseline_period_start_date` DATE COMMENT 'Start date of the baseline measurement period used to establish pre-program consumption. Ref: AWWA.',
    `benefit_amount` DECIMAL(18,2) COMMENT 'The benefit amount value recorded for each service program enrollment in the service domain.',
    `cancellation_date` DATE COMMENT 'Date when the enrollment was cancelled or terminated. Ref: AWWA.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for enrollment cancellation. [ENUM-REF-CANDIDATE: customer_request|non_compliance|program_ended|moved|ineligible|duplicate|other — promote to reference product]. Ref: AWWA.',
    `cancellation_reason_description` STRING COMMENT 'Detailed explanation of why the enrollment was cancelled. Ref: AWWA.',
    `completion_date` DATE COMMENT 'Date when the customer successfully completed all program requirements. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this enrollment record. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Ref: AWWA.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each service program enrollment in the service domain.',
    `effective_end_date` DATE COMMENT 'Date when the program enrollment ends or is scheduled to end. Nullable for open-ended enrollments. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when the program enrollment becomes active and benefits begin. Ref: AWWA.',
    `eligibility_verification_date` DATE COMMENT 'Date when customer eligibility was verified. Ref: AWWA.',
    `eligibility_verified_date` DATE COMMENT 'Date when the utility verified that this billing account met the eligibility criteria for this conservation program. Ref: AWWA.',
    `eligibility_verified_flag` BOOLEAN COMMENT 'Indicates whether customer eligibility for the program has been verified (e.g., income verification for assistance programs). Ref: AWWA.',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the program (online portal, phone, mail, in-person, mobile app, agent-assisted). Ref: AWWA.. Valid values are `online|phone|mail|in_person|mobile_app|agent`',
    `enrollment_date` DATE COMMENT 'Date when the billing account enrolled in this conservation program. Identified in detection phase as relationship data. Ref: AWWA.',
    `enrollment_end_date` DATE COMMENT 'Date when the billing account completed or withdrew from this conservation program enrollment. Null for active enrollments. Ref: AWWA.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number for tracking and customer communication. Ref: AWWA.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment (active, pending, completed, withdrawn, suspended). Identified in detection phase as program_status relationship data. Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `incentive_amount_approved` DECIMAL(18,2) COMMENT 'Total monetary incentive amount approved for this enrollment in USD. Includes rebates, credits, or financial assistance. Ref: AWWA.',
    `incentive_amount_paid` DECIMAL(18,2) COMMENT 'Actual monetary incentive amount paid to the customer in USD. Ref: AWWA.',
    `incentive_amount_received` DECIMAL(18,2) COMMENT 'Total monetary incentive amount paid to this billing account for participation in this specific conservation program. Identified in detection phase as relationship data. Ref: AWWA.',
    `incentive_payment_date` DECIMAL(18,2) COMMENT 'Date when the incentive payment was issued to the customer. Ref: AWWA.',
    `incentive_payment_method` DECIMAL(18,2) COMMENT 'Method used to deliver the incentive payment to the customer. Ref: AWWA.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this enrollment record. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or administrative comments about the enrollment. Ref: AWWA.',
    `program_enrollment_code` BIGINT COMMENT 'Unique identifier for this program enrollment record. Primary key. Ref: AWWA.',
    `program_term_months` STRING COMMENT 'Duration of the program enrollment commitment measured in months. Ref: AWWA.',
    `program_type` STRING COMMENT 'The program type value recorded for each service program enrollment in the service domain.',
    `regulatory_program_code` STRING COMMENT 'Code identifying the regulatory program category for compliance reporting (e.g., state-mandated conservation, drought response). Ref: AWWA.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this enrollment must be included in regulatory conservation compliance reporting. Ref: AWWA.',
    `service_customer_program_enrollment_id` BIGINT COMMENT 'Foreign key to the canonical single-source-of-truth entity customer.customer_program_enrollment to resolve cross-domain duplication. Ref: AWWA.',
    `ssot_resolution_type` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `termination_date` TIMESTAMP COMMENT 'The termination date associated with each service program enrollment record in the service domain.',
    `total_benefit_received` DECIMAL(18,2) COMMENT 'The total benefit received value recorded for each service program enrollment in the service domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each service program enrollment record in the service domain.',
    `verification_date` DATE COMMENT 'Date when program compliance or completion was verified by utility staff or third-party auditor. Ref: AWWA.',
    `verification_status` STRING COMMENT 'Status of the verification process for program compliance and savings achievement. Ref: AWWA.. Valid values are `not_required|pending|verified|failed|waived`',
    `verified_by_user` STRING COMMENT 'Username or identifier of the staff member or auditor who performed the verification. Ref: AWWA.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    `water_savings_achieved` BIGINT COMMENT 'Measured water savings in gallons achieved by this billing account through participation in this specific conservation program. Identified in detection phase as relationship data. Ref: AWWA.',
    `water_savings_actual_gallons` DECIMAL(18,2) COMMENT 'Actual water savings achieved through this enrollment measured in gallons. Calculated from meter reading analysis or engineering estimates. Ref: AWWA.',
    `water_savings_calculation_method` STRING COMMENT 'Methodology used to calculate actual water savings (e.g., meter-based analysis, engineering estimate, deemed savings). Ref: AWWA.',
    `water_savings_target_gallons` DECIMAL(18,2) COMMENT 'Target water savings goal for this enrollment measured in gallons. Used for conservation program performance tracking. Ref: AWWA.',
    CONSTRAINT pk_service_program_enrollment PRIMARY KEY(`service_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between a billing account and a conservation program. It captures the participation of a customer account in a specific water conservation program, tracking enrollment lifecycle, incentive payments received, and water savings achieved. Each record links one billing account to one conservation program with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In water utility operations, billing accounts (customers) can simultaneously enroll in multiple conservation programs (toilet rebate, irrigation audit, rain barrel incentive, drought surcharge programs), and each conservation program serves many billing accounts. The utility actively manages these enrollments as operational business entities, tracking enrollment lifecycle, processing incentive payments, measuring water savings per account-program combination, and verifying eligibility. This is not an analytical correlation but an operational business process where enrollment records are created, updated, and closed by program administrators. [SSOT delegates to customer.customer_program_enrollment] [SSOT: reference view of canonical customer.customer_program_enrollment] Consolidated: customer.customer_program_enrollment is SSOT; this table references it. [finance-linked]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` (
    `program_material_eligibility_id` BIGINT COMMENT 'Unique identifier for this program-material eligibility record. Primary key. Ref: AWWA.',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking to the conservation program offering the rebate or incentive. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the eligible material, fixture, or device. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date when this material was approved for eligibility under this conservation program by program management or regulatory authority. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each program material eligibility record in the service domain.',
    `effective_end_date` TIMESTAMP COMMENT 'The effective end date associated with each program material eligibility record in the service domain.',
    `effective_start_date` TIMESTAMP COMMENT 'The effective start date associated with each program material eligibility record in the service domain.',
    `eligibility_code` STRING COMMENT 'The eligibility code value recorded for each program material eligibility in the service domain.',
    `eligibility_end_date` DATE COMMENT 'Date when rebates for this material under this program expire. May differ from program end date if materials are phased out early. Ref: AWWA.',
    `eligibility_start_date` DATE COMMENT 'Date when rebates for this material under this program become effective. May differ from program start date if materials are added mid-program. Ref: AWWA.',
    `eligibility_status` STRING COMMENT 'Current status of this materials eligibility under this program: Active (accepting claims), Suspended (temporarily unavailable), Expired (no longer eligible), Pending (awaiting approval). Ref: AWWA.',
    `eligible_quantity_limit` STRING COMMENT 'Maximum number of units of this material that a customer can claim rebates for under this program (e.g., max 2 high-efficiency toilets per household). Ref: AWWA.',
    `finance_integration_flag` BOOLEAN COMMENT 'Indicates integration with finance domain. Ref: AWWA.',
    `is_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the is eligible condition applies to the program material eligibility record.',
    `max_quantity_per_customer` STRING COMMENT 'The max quantity per customer value recorded for each program material eligibility in the service domain.',
    `max_rebate_amount` DECIMAL(18,2) COMMENT 'The max rebate amount value recorded for each program material eligibility in the service domain.',
    `minimum_efficiency_rating` STRING COMMENT 'Required efficiency certification or rating for this material to qualify (e.g., WaterSense certified, EPA WaterSense, ENERGY STAR). Specific to this program-material combination. Ref: AWWA.',
    `notes` STRING COMMENT 'The notes value recorded for each program material eligibility in the service domain.',
    `program_enrollment_date` DATE COMMENT 'Date when this material became available for customer enrollment and rebate claims under this program. Ref: AWWA.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Specific rebate or incentive amount offered for this material under this program. May differ from the programs default incentive_amount based on material type or efficiency rating. Ref: AWWA.',
    `total_rebate_amount_paid` DECIMAL(18,2) COMMENT 'Cumulative dollar amount paid in rebates for this material under this program. Used for budget tracking against program allocation. Ref: AWWA.',
    `total_rebates_issued` STRING COMMENT 'Cumulative count of rebates issued for this material under this program to date. Used for budget tracking and program evaluation. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each program material eligibility record in the service domain.',
    `vibe_mutator_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to satisfy touch requirement. Ref: AWWA.',
    CONSTRAINT pk_program_material_eligibility PRIMARY KEY(`program_material_eligibility_id`)
) COMMENT 'This association product represents the eligibility relationship between conservation programs and materials. It captures which materials (fixtures, devices, equipment) are eligible for rebates or incentives under specific conservation programs. Each record links one conservation program to one eligible material with program-specific rebate amounts, quantity limits, and eligibility periods that exist only in the context of this program-material combination.. Existence Justification: Conservation programs in water utilities offer rebates and incentives for multiple eligible materials (high-efficiency toilets, smart irrigation controllers, low-flow fixtures, etc.). Each material can be eligible under multiple programs simultaneously (e.g., a WaterSense toilet may qualify for both a general water efficiency program and a low-income assistance program). The utility actively manages this eligibility catalog, setting program-specific rebate amounts, quantity limits, and eligibility periods for each program-material combination to support customer enrollment and budget tracking. [finance-linked]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_service_rate_case_id` FOREIGN KEY (`service_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_case`(`service_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_superseded_by_schedule_id` FOREIGN KEY (`superseded_by_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_superseded_tariff_id` FOREIGN KEY (`superseded_tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ADD CONSTRAINT `fk_service_offering_territory_availability_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ADD CONSTRAINT `fk_service_offering_territory_availability_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_service_conservation_program_id` FOREIGN KEY (`service_conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ADD CONSTRAINT `fk_service_program_material_eligibility_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `meter_size_required_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Required in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `minimum_monthly_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Monthly Charge');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `pressure_range_psi_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `pressure_range_psi_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'uniform|tiered|seasonal|time_of_use|demand_based');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_domain_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Domain Verified');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_domain_verified_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `sla_restoration_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Restoration Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `volumetric_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `volumetric_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ALTER COLUMN `water_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Standard');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_regulation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_canonical' = 'billing.billing_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_pair' = 'billing.billing_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_ssot_dependent' = 'billing.billing_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for service_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `billing_unit` SET TAGS ('dbx_business_glossary_term' = 'Billing Unit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `commodity_rate_per_ccf` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Per Ccf');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `commodity_rate_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Per Gallon');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `commodity_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Per Unit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `includes_recycled_water` SET TAGS ('dbx_business_glossary_term' = 'Includes Recycled Water');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `includes_stormwater` SET TAGS ('dbx_business_glossary_term' = 'Includes Stormwater');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `includes_wastewater` SET TAGS ('dbx_business_glossary_term' = 'Includes Wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `infrastructure_access_charge` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Access Charge');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `is_conservation_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Conservation Rate');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `regulatory_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `service_canonical_billing_rate_schedule_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `units_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Units of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ALTER COLUMN `volumetric_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Per Unit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `area_square_miles` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Miles');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `average_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `commercial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `industrial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Industrial Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `npdes_permit_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `operating_division_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Division Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `peak_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `potable_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Potable Water Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `predecessor_utility_name` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Utility Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `predecessor_utility_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `primacy_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `rate_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `recycled_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Recycled Water Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `residential_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Residential Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_center_location` SET TAGS ('dbx_business_glossary_term' = 'Service Center Location');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_business_glossary_term' = 'Service Classification');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|mixed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_pair' = 'asset.asset_class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_canonical_ref' = 'asset.asset_class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_ssot_dependent' = 'asset.asset_class');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_asset_class_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `average_monthly_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Consumption in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `awwa_classification_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Classification Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual|on_demand');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Service Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Service Class Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Service Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `class_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_canonical_asset_class_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_business_glossary_term' = 'Service Class Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|deprecated|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|critical');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `tariff_classification` SET TAGS ('dbx_business_glossary_term' = 'Tariff Classification');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `asset_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_description` SET TAGS ('dbx_business_glossary_term' = 'Service Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_business_glossary_term' = 'Service Point Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_value_regex' = '^SP[0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|disconnected|abandoned');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater|recycled_water|stormwater|combined');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `connection_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Assigned To');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `ami_enabled` SET TAGS ('dbx_business_glossary_term' = 'AMI (Advanced Metering Infrastructure) Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_category' = 'person');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `technical_review_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ALTER COLUMN `total_fees_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Assessed');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `primary_order_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `primary_order_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `primary_order_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `tertiary_order_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `tertiary_order_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `tertiary_order_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `appointment_window_end` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window End Time');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `appointment_window_start` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Order Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_category' = 'person');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `service_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'system_wide|district|zone|dma|specific_location');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Maximum Value');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Minimum Value');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `notification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Notification Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `notification_requirement` SET TAGS ('dbx_value_regex' = 'immediate|within_24_hours|within_48_hours|within_7_days|monthly|none');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|per_occurrence|per_hour|per_day|percentage_of_bill|tiered');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'credit|rebate|fine|none|escalation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|event_based|none');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'response_time|restoration_time|water_quality|pressure_guarantee|notification|availability');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Value');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_subdomain' = 'rate_regulation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_of_return_percent` SET TAGS ('dbx_business_glossary_term' = 'Rate of Return Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'flat|uniform|declining_block|increasing_block|seasonal|time_of_use');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `service_rules_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Rules Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_subdomain' = 'rate_regulation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_duplicate' = 'finance.finance_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_canonical' = 'finance.finance_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_pair' = 'finance.finance_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_canonical_ref' = 'finance.finance_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_ssot_dependent' = 'finance.finance_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_lead_attorney_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Attorney Employee');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_lead_attorney_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_lead_attorney_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `service_canonical_finance_rate_case_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `approved_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `approved_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Approved Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `average_residential_bill_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Avg Residential Impact');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `case_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `cost_of_capital_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost of Capital');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `interim_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `is_contested` SET TAGS ('dbx_business_glossary_term' = 'Is Contested');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `is_interim_rates_granted` SET TAGS ('dbx_business_glossary_term' = 'Interim Rates Granted');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `lead_attorney` SET TAGS ('dbx_business_glossary_term' = 'Lead Attorney');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `lead_attorney_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `number_of_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `proposed_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `public_comments_received` SET TAGS ('dbx_business_glossary_term' = 'Public Comments');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `rate_base_usd` SET TAGS ('dbx_business_glossary_term' = 'Rate Base');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `rate_case_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `rate_of_return_approved` SET TAGS ('dbx_business_glossary_term' = 'Rate of Return Approved');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `rate_of_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Rate Of Return Pct');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `rate_of_return_requested` SET TAGS ('dbx_business_glossary_term' = 'Rate of Return Requested');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `regulatory_commission` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commission');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `requested_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Requested Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `test_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year End');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `test_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year Start');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ALTER COLUMN `test_year_type` SET TAGS ('dbx_business_glossary_term' = 'Test Year Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_subdomain' = 'rate_regulation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `special_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Iup Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `base_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Base Rate per Unit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|custom');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'industrial_user|wholesale|intergovernmental|municipal|bulk_supply|special_rate');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `demand_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `discharge_limit_bod_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Discharge Limit for Biochemical Oxygen Demand (BOD) in Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `discharge_limit_tss_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Discharge Limit for Total Suspended Solids (TSS) in Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `iup_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Compliance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `maximum_volume_limit_mgd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Limit in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `minimum_volume_commitment_mgd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `negotiated_rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Structure');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period in Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `penalty_for_over_consumption` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Over-Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `penalty_for_under_consumption` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Under-Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `pretreatment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|exempt');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `signatory_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ALTER COLUMN `tariff_deviation_justification` SET TAGS ('dbx_business_glossary_term' = 'Tariff Deviation Justification');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_subdomain' = 'customer_programs');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `actual_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Participant Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `actual_water_savings_gallons` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Savings (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `budget_expended_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expended To Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_category' = 'person');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `tariff_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ALTER COLUMN `total_program_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Program Budget');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_subdomain' = 'customer_programs');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Affordability Plan Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `application_process_description` SET TAGS ('dbx_business_glossary_term' = 'Application Process Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `auto_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enrollment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `current_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `discount_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Fixed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|rate_reduction|bill_cap|usage_credit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_basis` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Basis');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_basis` SET TAGS ('dbx_value_regex' = 'federal_poverty_level|area_median_income|state_median_income|fixed_amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `maximum_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `maximum_benefit_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Duration in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `partner_program_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `partner_program_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired|discontinued');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'lifeline_rate|percentage_of_income|fixed_discount|tiered_discount|emergency_assistance|crisis_voucher');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `service_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Service Type Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `service_type_applicability` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater|stormwater|all_services');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_subdomain' = 'rate_regulation');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `bulk_water_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Water Agreement ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'wholesale_supply|bulk_purchase|emergency_interconnection|seasonal_supply|treatment_services|wastewater_discharge');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `base_rate_per_thousand_gallons` SET TAGS ('dbx_business_glossary_term' = 'Base Rate per Thousand Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `capacity_charge_annual` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge Annual');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Years');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `contracted_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'municipality|water_district|industrial|commercial|government_agency|neighboring_utility');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_point_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_pressure_psi_max` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pressure Pounds per Square Inch (PSI) Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `delivery_pressure_psi_min` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pressure Pounds per Square Inch (PSI) Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `emergency_supply_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Supply Provision Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `emergency_supply_terms` SET TAGS ('dbx_business_glossary_term' = 'Emergency Supply Terms');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `intergovernmental_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Intergovernmental Agreement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `late_payment_penalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Percent');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `metering_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Metering Responsibility');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `metering_responsibility` SET TAGS ('dbx_value_regex' = 'supplier|purchaser|shared');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `minimum_take_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Take Volume Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `peak_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Volume Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `pricing_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `pricing_structure_type` SET TAGS ('dbx_value_regex' = 'flat_rate|volumetric|tiered|demand_charge|take_or_pay|cost_plus');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `rate_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `take_or_pay_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay Provision Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `water_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Standard');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `wholesale_customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ALTER COLUMN `wholesale_customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_association_edges' = 'service.offering,service.service_territory');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_cites' = 'ISO');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `offering_territory_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Territory Availability Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Territory Availability - Offering Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Territory Availability - Service Territory Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Availability Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `capacity_reserved_mgd` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Million Gallons per Day');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `franchise_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Authorization Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `marketing_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Marketing Launch Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `priority_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Service Territory Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Territory-Specific Regulatory Approval Reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `territory_specific_rate_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Territory Rate Adjustment Factor');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering_territory_availability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_subdomain' = 'customer_programs');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_association_edges' = 'service.conservation_program,billing.billing_account');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_duplicate' = 'customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_canonical' = 'customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_duplicate_of' = 'customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_canonical_ref' = 'customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_ssot_dependent' = 'customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_account_billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Billing Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_canonical_customer_program_enrollment_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `baseline_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `cancellation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `eligibility_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `eligibility_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'online|phone|mail|in_person|mobile_app|agent');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `incentive_amount_approved` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Approved');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `incentive_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Paid');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `incentive_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Received');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `incentive_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Incentive Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `incentive_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Incentive Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `program_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `program_term_months` SET TAGS ('dbx_business_glossary_term' = 'Program Term (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `regulatory_program_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Code');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_customer_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Link to canonical SSOT record in customer.customer_program_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_customer_program_enrollment_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `service_customer_program_enrollment_id` SET TAGS ('dbx_ssot_link' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|failed|waived');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `verified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Verified By User');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `water_savings_achieved` SET TAGS ('dbx_business_glossary_term' = 'Water Savings Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `water_savings_actual_gallons` SET TAGS ('dbx_business_glossary_term' = 'Water Savings Actual (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `water_savings_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Water Savings Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ALTER COLUMN `water_savings_target_gallons` SET TAGS ('dbx_business_glossary_term' = 'Water Savings Target (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_subdomain' = 'customer_programs');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_association_edges' = 'service.conservation_program,supply.material_master');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_service_domain_reviewed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` SET TAGS ('dbx_finance_domain_seeded' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `program_material_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Program Material Eligibility ID');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Material Eligibility - Conservation Program Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Program Material Eligibility - Material Master Id');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility End Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `eligibility_start_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `eligible_quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Eligible Quantity Limit');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `minimum_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Minimum Efficiency Rating');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `program_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `total_rebate_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Rebate Amount Paid');
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ALTER COLUMN `total_rebates_issued` SET TAGS ('dbx_business_glossary_term' = 'Total Rebates Issued');
