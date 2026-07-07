-- Schema for Domain: logistics | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`logistics` COMMENT 'Owns transportation management, freight optimization, and delivery execution across inbound and outbound networks. Manages carrier contracts, shipment planning, route optimization, freight audit, track-and-trace, 3PL coordination, proof of delivery, cold-chain compliance, and transportation cost tracking. Distinct from distribution (warehouse-focused) — logistics covers inter-facility and last-mile movement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique surrogate identifier for the transportation carrier record in the Consumer Goods logistics master data. Primary key for all carrier-related references across shipments, freight orders, contracts, and invoices.',
    `supplier_id` BIGINT COMMENT 'Reference to the corresponding vendor/supplier master record in the ERP system (SAP S/4HANA or Oracle Cloud ERP) for this carrier. Links the carrier master to the procurement and accounts payable vendor record for freight invoice processing and payment.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the carrier record',
    `api_tracking_capable` BOOLEAN COMMENT 'Indicates whether the carrier provides a real-time shipment tracking API for track-and-trace integration. Enables automated shipment status updates in the TMS without manual EDI 214 processing. Used in carrier technology capability assessment.',
    `carbon_intensity_g_per_tkm` DECIMAL(18,2) COMMENT 'The carbon intensity g per tkm of the carrier record',
    `carrier_status` STRING COMMENT 'Current lifecycle status of the carrier in the Consumer Goods approved carrier program. Active carriers are eligible for shipment tendering. Suspended carriers are temporarily blocked pending compliance review. Blacklisted carriers are permanently disqualified. Drives carrier selection eligibility in TMS routing.. Valid values are `active|inactive|suspended|pending_approval|blacklisted`',
    `carrier_type` STRING COMMENT 'Primary transportation mode classification of the carrier. Drives rate card selection, shipment planning rules, and EDI transaction sets. TL (Truckload), LTL (Less-Than-Truckload), parcel, rail, ocean, air, intermodal, and courier are the standard classifications in consumer goods logistics. [ENUM-REF-CANDIDATE: truckload|less_than_truckload|parcel|rail|ocean|air|intermodal|courier — promote to reference product]',
    `co2_emission_rating` STRING COMMENT 'The co2 emission rating of the carrier record',
    `carrier_code` STRING COMMENT 'The carrier code of the carrier record',
    `cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the carrier has certified temperature-controlled transportation capability (refrigerated or frozen) for cold-chain compliant shipments of health, hygiene, and personal care products requiring temperature management. Critical for product safety and regulatory compliance.',
    `contact_email` STRING COMMENT 'The contact email of the carrier record',
    `contact_name` STRING COMMENT 'The contact name of the carrier record',
    `contact_phone` STRING COMMENT 'The contact phone of the carrier record',
    `contract_end_date` DATE COMMENT 'Expiry date of the current master transportation services agreement. Triggers contract renewal workflows and rate renegotiation processes. Shipment tendering to the carrier may be restricted after this date if no renewal is in place.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master transportation services agreement between Consumer Goods and the carrier. Defines the period during which contracted rates and service commitments are valid.',
    `contract_status` STRING COMMENT 'The contract status of the carrier record',
    `country_code` STRING COMMENT 'The country code of the carrier record',
    `country_of_registration` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the carrier is legally registered and incorporated. Used for cross-border compliance checks, customs documentation, and carrier eligibility for specific trade lanes.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was first created in the Consumer Goods logistics data platform. Provides audit trail for record provenance and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which freight rates and invoices are denominated for this carrier. Used in multi-currency freight cost management, FX conversion, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `carrier_description` STRING COMMENT 'The carrier description of the carrier record',
    `dot_number` STRING COMMENT 'Unique identifier assigned by the U.S. Federal Motor Carrier Safety Administration (FMCSA) to commercial motor carriers operating in interstate commerce. Required for regulatory compliance verification and safety rating lookup. Mandatory for US-based trucking carriers.. Valid values are `^[0-9]{1,8}$`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) number uniquely identifying the carriers business entity globally. Used for supplier risk assessment, credit verification, and EDI trading partner identification.. Valid values are `^[0-9]{9}$`',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the carrier supports Electronic Data Interchange (EDI) for automated exchange of shipment tenders (204), load tenders (990), shipment status (214), and freight invoices (210). EDI-capable carriers are preferred for high-volume automated tendering in the TMS.',
    `edi_code` STRING COMMENT 'Carriers EDI interchange identifier used in the ISA segment of X12 EDI transactions. Combined with the EDI qualifier, this uniquely identifies the carrier as an EDI trading partner. Required for automated tender and status message routing.',
    `edi_qualifier` STRING COMMENT 'Two-digit qualifier code identifying the type of EDI sender/receiver identifier used in ISA segment of X12 EDI transactions (e.g., 02 = DUNS, 08 = UCC/EAN, ZZ = Mutually Defined). Required for EDI trading partner setup and message routing.. Valid values are `^[0-9]{2}$`',
    `effective_from` DATE COMMENT 'The effective from of the carrier record',
    `effective_until` DATE COMMENT 'The effective until of the carrier record',
    `fmcsa_rating_date` DATE COMMENT 'Date on which the current FMCSA safety rating was issued or last updated. Used to assess rating currency and trigger re-evaluation workflows when ratings are older than the compliance review threshold.',
    `fmcsa_safety_rating` STRING COMMENT 'Official safety fitness rating assigned by the FMCSA to motor carriers based on compliance reviews and safety audits. Satisfactory rating is required for carrier approval in Consumer Goods carrier program. Conditional or Unsatisfactory ratings trigger carrier review or suspension. Mandatory compliance field for US trucking carriers.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `geographic_coverage` STRING COMMENT 'Description of the carriers operational geographic coverage scope, including regions, countries, or trade lanes served. Used in TMS routing logic to filter eligible carriers by origin-destination pair. Examples: Continental US, US-Canada cross-border, Trans-Pacific, EU domestic.',
    `hazmat_cert_expiry_date` DATE COMMENT 'Expiry date of the carriers hazardous materials transportation certification. Triggers compliance alerts and blocks HAZMAT shipment tendering to the carrier if certification has lapsed.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds valid certification to transport hazardous materials (HAZMAT) as defined by DOT 49 CFR. Required for shipments of aerosols, flammable products, and chemical-based consumer goods. Validated against DOT HAZMAT registration database.',
    `headquarters_address` STRING COMMENT 'Full street address of the carriers principal place of business or corporate headquarters. Used for legal correspondence, contract execution, and regulatory filings. Includes street, city, state/province, postal code, and country.',
    `iata_code` STRING COMMENT '2-3 character alphanumeric code assigned by IATA to identify air freight carriers. Used for air waybill generation, air freight booking, and international air cargo tracking. Applicable only to air freight carriers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `insurance_cargo_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount (in USD) of the carriers cargo insurance policy covering loss or damage to goods in transit. Consumer Goods mandates minimum cargo insurance thresholds based on shipment value profiles. Critical for high-value CPG product shipments.',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the carriers current certificate of insurance (COI) on file with Consumer Goods. Used for insurance verification, claims processing, and audit trail of carrier compliance documentation.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the carriers insurance certificate expires. Triggers automated renewal reminder workflows and carrier status suspension if insurance lapses. Critical compliance field for carrier program management.',
    `insurance_liability_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount (in USD) of the carriers general liability insurance policy. Consumer Goods requires minimum liability coverage thresholds as a condition of carrier approval. Validated during carrier onboarding and annual renewal.',
    `insurance_provider` STRING COMMENT 'The insurance provider of the carrier record',
    `is_cold_chain_capable` BOOLEAN COMMENT 'The is cold chain capable of the carrier record',
    `is_hazmat_certified` BOOLEAN COMMENT 'The is hazmat certified of the carrier record',
    `is_preferred_carrier` BOOLEAN COMMENT 'The is preferred carrier of the carrier record',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review conducted for this carrier, covering safety ratings, insurance certificates, HAZMAT certifications, and contractual obligations. Used to schedule periodic re-evaluations and flag overdue reviews.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the carrier record',
    `legal_name` STRING COMMENT 'Full legal registered business name of the transportation carrier as filed with regulatory authorities (FMCSA, state business registry). Used in contracts, freight invoices, and regulatory filings. Must match the name on the carriers operating authority.',
    `liability_coverage_amount` DECIMAL(18,2) COMMENT 'The liability coverage amount of the carrier record',
    `max_payload_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity in kilograms that the carriers standard equipment can transport per shipment. Used in load planning, shipment consolidation, and carrier eligibility checks to prevent overweight violations.',
    `mc_number` STRING COMMENT 'Operating authority number issued by the FMCSA to for-hire motor carriers transporting regulated commodities in interstate commerce. Distinct from DOT number — MC number grants operating authority while DOT number is for safety registration. Used in carrier compliance validation.. Valid values are `^MC-[0-9]{1,7}$`',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the carrier record',
    `carrier_name` STRING COMMENT 'The carrier name of the carrier record',
    `notes` STRING COMMENT 'The notes of the carrier record',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'The on time delivery pct of the carrier record',
    `onboarding_date` DATE COMMENT 'Date on which the carrier was formally approved and onboarded into Consumer Goods carrier program, completing all compliance checks, insurance verification, and EDI/API setup. Marks the start of the carriers operational eligibility.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the carrier for freight invoice settlement. Drives accounts payable scheduling and cash flow planning. Standard terms in consumer goods logistics range from Net 15 to Net 60 days.. Valid values are `net_15|net_30|net_45|net_60|immediate`',
    `preferred_carrier` BOOLEAN COMMENT 'Indicates whether the carrier has been designated as a preferred carrier in Consumer Goods carrier program, typically based on negotiated rates, service performance, and strategic partnership status. Preferred carriers receive priority in TMS automated tendering sequences.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary carrier contact for operational communications, tender notifications, and account management. Used in EDI onboarding and carrier portal access provisioning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the carrier organization responsible for account management, contract negotiations, and escalation handling. Used in carrier relationship management and communication workflows.',
    `primary_contact_phone` STRING COMMENT 'Primary business telephone number for the carrier contact, used for operational coordination, shipment tracking inquiries, and exception management. Formatted per E.164 international standard.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the carrier record',
    `region_coverage` STRING COMMENT 'The region coverage of the carrier record',
    `scac_code` STRING COMMENT 'Unique 2-4 character alpha code assigned by the National Motor Freight Traffic Association (NMFTA) to identify transportation carriers in North America. Used in EDI transactions (204, 214, 990) and freight billing. Mandatory for motor carriers operating in the US.. Valid values are `^[A-Z]{2,4}$`',
    `service_area_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the countries in which the carrier provides transportation services. Used for international shipment routing, customs compliance validation, and carrier eligibility filtering in cross-border logistics.',
    `service_level_offered` STRING COMMENT 'The service level offered of the carrier record',
    `service_mode` STRING COMMENT 'Service level classification offered by the carrier indicating transit speed and handling commitment. Drives SLA assignment, freight cost tier selection, and shipment routing logic in the TMS. Used in OTIF (On Time In Full) performance measurement.. Valid values are `standard|expedited|overnight|same_day|deferred|white_glove`',
    `source_system_code` STRING COMMENT 'The source system code of the carrier record',
    `tax_number` STRING COMMENT 'Federal tax identification number (EIN/TIN) or VAT registration number of the carrier, used for tax compliance, 1099 reporting, and cross-border customs documentation. Required for freight invoice processing and IRS reporting.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in degrees Celsius) that the carriers cold-chain equipment can maintain during transit. Combined with the minimum temperature range, defines the carriers certified temperature corridor for cold-chain shipments.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature (in degrees Celsius) that the carriers cold-chain equipment can maintain during transit. Used to validate carrier eligibility for temperature-sensitive product shipments and cold-chain compliance verification.',
    `tracking_url_template` STRING COMMENT 'URL template for the carriers web-based shipment tracking portal, with a placeholder (e.g., {tracking_number}) for dynamic substitution. Used to generate direct tracking links in shipment notifications, customer portals, and internal TMS dashboards.',
    `trade_name` STRING COMMENT 'Doing-business-as (DBA) or trade name used by the carrier in commercial operations, which may differ from the legal registered name. Used in operational communications, carrier portals, and reporting where the trade name is more recognizable.',
    `uom` STRING COMMENT 'The uom of the carrier record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the carrier record',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all transportation carriers (trucking, rail, ocean, air, parcel) contracted by Consumer Goods. Captures carrier identity, SCAC/IATA codes, carrier type, service modes, geographic coverage, insurance certificates, safety ratings (FMCSA/DOT), EDI capability flags, and contractual status. SSOT for carrier identity referenced by shipments, freight orders, contracts, and invoices across inbound and outbound networks.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the carrier contract record in the logistics data platform. Primary key for the carrier_contract entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (transportation service provider) party who is the counterparty to this freight contract. Links to the carrier master record.',
    `supplier_contract_id` BIGINT COMMENT 'The supplier contract id of the carrier contract record',
    `accessorial_schedule_code` STRING COMMENT 'Reference code identifying the accessorial charge schedule applicable to this contract. Accessorial charges include liftgate, residential delivery, inside delivery, detention, layover, hazmat handling, and temperature-controlled surcharges. Links to the accessorial rate table for freight audit and cost estimation.',
    `accessorial_terms` STRING COMMENT 'The accessorial terms of the carrier contract record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the carrier contract record',
    `approval_date` DATE COMMENT 'Date on which the carrier contract was formally approved by the authorized approver. Used in contract governance, SOX audit trails, and procurement compliance reporting.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorized approver who signed off on this carrier contract. Required for SOX financial controls compliance and procurement governance. Supports audit trail for contract authorization.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the carrier contract record',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether this carrier contract automatically renews at expiry unless terminated with advance notice. When true, the renewal_notice_days field defines the required notice period. Supports contract lifecycle management and procurement planning.',
    `base_rate` DECIMAL(18,2) COMMENT 'The primary negotiated freight rate under this contract before surcharges and accessorial charges are applied. The unit of measure for this rate is defined by the rate_type field (e.g., per mile, per CWT, per pallet, flat). Used as the foundation for freight cost estimation and freight audit rate lookup.',
    `billing_frequency` STRING COMMENT 'Frequency at which the carrier submits freight invoices under this contract. Per-shipment billing generates an invoice for each delivery; weekly/bi-weekly/monthly billing consolidates charges into periodic invoices. Impacts freight audit workflow and accounts payable processing.. Valid values are `per_shipment|weekly|bi_weekly|monthly`',
    `carrier_contract_status` STRING COMMENT 'The carrier contract status of the carrier contract record',
    `carrier_contract_code` STRING COMMENT 'The carrier contract code of the carrier contract record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this contract covers temperature-controlled (cold chain) shipments requiring refrigerated or frozen transport. When true, cold chain compliance monitoring, temperature logging, and FEFO inventory management protocols apply. Relevant for health, hygiene, and perishable consumer goods.',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the procurement or logistics team. Used in EDI communications, freight audit, and carrier correspondence. Aligns with SAP S/4HANA MM contract document number.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the carrier contract. Draft indicates contract is being authored; pending_approval is awaiting sign-off; active means the contract is in force; suspended means temporarily halted; expired means the term has lapsed; terminated means the contract was ended before expiry.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `contract_type` STRING COMMENT 'Classification of the freight contract by commercial arrangement type. Spot contracts cover single-shipment rates; committed contracts lock volume at negotiated rates; preferred carrier agreements define priority tender; dedicated contracts reserve capacity; intermodal covers multi-mode arrangements; 3PL master covers third-party logistics umbrella agreements.. Valid values are `spot|committed|preferred|dedicated|intermodal|3pl_master`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was first created in the logistics data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all rates, charges, and financial commitments under this contract are denominated (e.g., USD, EUR, GBP). Required for multi-currency freight cost management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `carrier_contract_description` STRING COMMENT 'The carrier contract description of the carrier contract record',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the destination country covered by this contract. Used for cross-border freight classification, customs compliance, and international rate applicability.. Valid values are `^[A-Z]{3}$`',
    `destination_region` STRING COMMENT 'Geographic destination zone or region covered by this contract for lane-level rate applicability. May represent a state, ZIP zone, city cluster, or carrier-defined zone code. Used in freight cost estimation and tender evaluation.',
    `detention_free_time_hours` STRING COMMENT 'Number of hours the carriers equipment (trailer/container) may remain at a Consumer Goods facility for loading or unloading without incurring detention charges. Exceeding this threshold triggers accessorial detention fees per the contract rate schedule.',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI (Electronic Data Interchange) for automated tender, shipment status, and invoice exchange under this contract. EDI-capable carriers enable automated load tendering (EDI 204), shipment status updates (EDI 214), and freight invoice processing (EDI 210).',
    `effective_date` DATE COMMENT 'The date on which the carrier contract becomes legally binding and rates become applicable for freight tendering and cost estimation. Aligns with SAP S/4HANA MM contract validity start date.',
    `effective_from` DATE COMMENT 'The effective from of the carrier contract record',
    `effective_until` DATE COMMENT 'The effective until of the carrier contract record',
    `end_date` DATE COMMENT 'The end date of the carrier contract record',
    `expiry_date` DATE COMMENT 'The date on which the carrier contract ceases to be valid and rates are no longer applicable. Nullable for evergreen contracts with no fixed end date. Aligns with SAP S/4HANA MM contract validity end date.',
    `fuel_surcharge_basis` STRING COMMENT 'Defines how the fuel surcharge is calculated and applied: as a percentage of the base freight rate, a flat amount per mile, a flat amount per shipment, or dynamically linked to the DOE diesel fuel price index. Determines the fuel surcharge computation method in freight audit.. Valid values are `percentage_of_base|flat_per_mile|flat_per_shipment|doe_index_linked`',
    `fuel_surcharge_pct` DECIMAL(18,2) COMMENT 'The fuel surcharge pct of the carrier contract record',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Contracted fuel surcharge rate expressed as a percentage of the base rate or as a fixed amount per unit, applied on top of the base freight rate to account for fuel cost variability. Linked to a fuel index table or DOE diesel price index. Critical for freight cost estimation and audit.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carrier is certified and authorized under this contract to transport hazardous materials (hazmat) including flammable, corrosive, or toxic consumer goods ingredients. When true, DOT/IATA hazmat compliance documentation is required.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum cargo insurance coverage amount provided by the carrier under this contract, expressed in the contract currency. Defines the financial liability limit for cargo loss or damage claims. Used in risk management and claims processing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the carrier contract record',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'The liability limit amount of the carrier contract record',
    `liability_limit_per_kg` DECIMAL(18,2) COMMENT 'Contractual carrier liability limit per kilogram of cargo for loss or damage claims, expressed in the contract currency. Used in freight claims management to calculate maximum recoverable amounts for damaged or lost shipments.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms at which this contract rate applies. Defines the upper bound of the weight break tier. Null indicates no upper limit (applies to all weights above the minimum). Used in freight cost estimation and audit.',
    `min_weight_kg` DECIMAL(18,2) COMMENT 'Minimum shipment weight in kilograms at which this contract rate applies. Defines the lower bound of the weight break tier for rate applicability. Used in freight cost estimation and audit to validate correct rate application.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'The minimum volume commitment of the carrier contract record',
    `carrier_contract_name` STRING COMMENT 'The carrier contract name of the carrier contract record',
    `notes` STRING COMMENT 'The notes of the carrier contract record',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the origin country covered by this contract. Used for cross-border freight classification, customs compliance, and international rate applicability.. Valid values are `^[A-Z]{3}$`',
    `origin_region` STRING COMMENT 'Geographic origin zone or region covered by this contract for lane-level rate applicability. May represent a state, ZIP zone, city cluster, or carrier-defined zone code. Used in freight cost estimation and tender evaluation.',
    `otif_penalty_rate` DECIMAL(18,2) COMMENT 'Contractual penalty rate applied to the carrier for OTIF (On Time In Full) failures, expressed as a percentage of the invoice value or a fixed amount per incident. OTIF is a key KPI in consumer goods supply chain performance management. Supports carrier performance management and deduction processing.',
    `otif_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum OTIF performance percentage the carrier must achieve to avoid penalty charges under this contract. Expressed as a percentage (e.g., 98.5 means 98.5% OTIF compliance required). Below this threshold, the otif_penalty_rate is triggered.',
    `payment_terms` STRING COMMENT 'Contractual payment terms defining when freight invoices must be settled after receipt. Net_30 means payment due within 30 days of invoice date. 2/10 Net 30 means a 2% discount if paid within 10 days. Drives accounts payable scheduling and freight audit payment processing.. Valid values are `net_15|net_30|net_45|net_60|immediate|2_10_net_30`',
    `penalty_clause` STRING COMMENT 'The penalty clause of the carrier contract record',
    `pickup_lead_time_hours` STRING COMMENT 'Contracted lead time in hours from tender acceptance to carrier pickup at the origin facility. Used in shipment planning, load scheduling, and Blue Yonder WMS labor planning for dock door assignment.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the carrier contract record',
    `rate_basis` STRING COMMENT 'The rate basis of the carrier contract record',
    `rate_type` STRING COMMENT 'Defines the unit basis on which the base_rate is charged. Per-mile rates apply to distance-based pricing; per-CWT (hundredweight) applies to weight-based LTL pricing; per-pallet applies to unit-load pricing; flat rate is a fixed charge per shipment regardless of weight or distance; per-kg and per-lb are weight-based variants used in air and parcel freight. [ENUM-REF-CANDIDATE: per_mile|per_cwt|per_pallet|per_shipment|flat|per_kg|per_lb — 7 candidates stripped; promote to reference product]',
    `renewal_date` DATE COMMENT 'The renewal date of the carrier contract record',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days advance notice required to terminate or renegotiate this contract before auto-renewal. Applicable only when auto_renewal is true. Used in contract lifecycle management to trigger procurement review workflows.',
    `service_level` STRING COMMENT 'Contracted service level defining the speed and handling tier for shipments under this agreement. Drives SLA commitments, OTIF measurement thresholds, and rate applicability. Examples: standard ground, expedited, overnight, two-day, deferred, white-glove.. Valid values are `standard|expedited|overnight|two_day|deferred|white_glove`',
    `service_level_agreement` STRING COMMENT 'The service level agreement of the carrier contract record',
    `signed_by` STRING COMMENT 'The signed by of the carrier contract record',
    `signed_date` DATE COMMENT 'The signed date of the carrier contract record',
    `source_system_code` STRING COMMENT 'The source system code of the carrier contract record',
    `start_date` DATE COMMENT 'The start date of the carrier contract record',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius that must be maintained throughout transit for cold chain shipments under this contract. Applicable only when cold_chain_required is true. Exceedance triggers non-conformance reporting and potential product rejection.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius that must be maintained throughout transit for cold chain shipments under this contract. Applicable only when cold_chain_required is true. Used for cold chain compliance monitoring and carrier performance audits.',
    `track_trace_method` STRING COMMENT 'Method by which shipment tracking and status updates are provided by the carrier under this contract. EDI 214 is the standard electronic shipment status transaction; API enables real-time integration; portal requires manual check-in; email is manual notification. Drives track-and-trace capability in logistics operations.. Valid values are `edi_214|api|portal|email|none`',
    `transit_time_days` STRING COMMENT 'Contracted standard transit time in calendar days from pickup to delivery for shipments under this contract and lane. Used as the SLA baseline for OTIF measurement, delivery promise, and ATP/CTP calculations in demand planning.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation covered by this contract. TL (Truckload), LTL (Less-than-Truckload), intermodal, rail, ocean freight, air freight, parcel/small package, or drayage (port/terminal moves). Drives rate table applicability and freight audit logic. [ENUM-REF-CANDIDATE: truckload|ltl|intermodal|rail|ocean|air|parcel|drayage — 8 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the carrier contract record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was most recently modified in the logistics data platform. Follows ISO 8601 format. Used for change data capture (CDC), data lineage, and audit trail in the Databricks Silver layer.',
    `volume_commitment_units` DECIMAL(18,2) COMMENT 'Contracted minimum volume commitment by Consumer Goods to the carrier over the contract term, expressed in the unit defined by volume_commitment_uom (e.g., shipments, pallets, CWT, revenue miles). Failure to meet this commitment may trigger shortfall penalties or rate renegotiation.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the volume_commitment_units field. Defines whether the volume commitment is expressed in number of shipments, pallets, hundredweight (CWT), revenue miles, kilograms, or truckloads.. Valid values are `shipments|pallets|cwt|revenue_miles|kg|loads`',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Freight contract, rate agreement, and granular rate schedule between Consumer Goods and a carrier. Captures contract term dates, lane coverage, mode of transport, negotiated base rates, fuel surcharge tables, accessorial charge schedules, volume commitments, OTIF penalty clauses, contract status, and detailed rate records including rate type (per-mile/per-cwt/per-pallet/flat), origin/destination zones, weight breaks, effective/expiry dates, and currency. Supports freight cost estimation, tender evaluation, freight audit rate lookup, and carrier performance management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` (
    `lane_id` BIGINT COMMENT 'Unique system-generated identifier for the transportation lane record. Primary key for the lane entity in the logistics domain.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract or rate agreement governing freight pricing and service terms on this lane. Links to the carrier contract master in the logistics domain.',
    `network_node_id` BIGINT COMMENT 'Reference to the destination facility, distribution center, retail store, or customer location where freight is delivered on this lane. Links to the location master in the logistics domain.',
    `carrier_id` BIGINT COMMENT 'The lane operating carrier id of the lane record',
    `primary_lane_backup_carrier_id` BIGINT COMMENT 'Reference to the secondary/backup carrier for this lane, used when the preferred carrier declines the tender or is unavailable. Represents the second position in the routing guide.',
    `primary_lane_supply_network_node_id` BIGINT COMMENT 'Reference to the origin facility, distribution center, plant, or supplier location from which freight departs on this lane. Links to the location master in the logistics domain.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the lane record',
    `annual_volume_loads` STRING COMMENT 'Historical or planned annual shipment volume on this lane expressed in number of loads (truckloads, containers, or equivalent units). Used for carrier contract negotiations, network design, and freight spend forecasting.',
    `annual_volume_weight_kg` DECIMAL(18,2) COMMENT 'Historical or planned annual freight weight moved on this lane in kilograms. Used for carrier contract negotiations, modal optimization, and carbon emissions intensity calculations per ISO 14001.',
    `avg_transit_time_hours` DECIMAL(18,2) COMMENT 'The avg transit time hours of the lane record',
    `benchmark_rate_flat` DECIMAL(18,2) COMMENT 'Lane-level flat cost benchmark (all-in rate per load/shipment) in the operating currency. Used for truckload lanes where per-km pricing is not applicable. Supports freight audit and carrier contract negotiation.',
    `benchmark_rate_per_km` DECIMAL(18,2) COMMENT 'Lane-level cost benchmark expressed as rate per kilometer in the operating currency. Used for freight audit, carrier performance benchmarking, and transportation cost variance analysis. Confidential as it reflects negotiated contract intelligence.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Lane-level carbon emission intensity factor expressed as kilograms of CO2 equivalent per kilometer, based on transport mode and equipment type. Used for Scope 3 emissions reporting, sustainability KPIs, and ESG disclosures per ISO 14001 and EPA Greenhouse Gas Reporting Program.',
    `classification` STRING COMMENT 'Directional and functional classification of the lane within the supply chain network. Inbound covers supplier-to-plant/DC movements; outbound covers DC-to-customer/retailer; inter-facility covers plant-to-DC or DC-to-DC; last-mile covers final delivery to end consumer or store; reverse covers returns flow.. Valid values are `inbound|outbound|inter_facility|last_mile|reverse`',
    `co2_per_shipment_kg` DECIMAL(18,2) COMMENT 'The co2 per shipment kg of the lane record',
    `lane_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the transportation lane, used in carrier contracts, freight tenders, and TMS systems. Typically formatted as ORIGIN-DEST-MODE (e.g., CHI-NYC-TL). Aligns with SAP TM lane master data.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this lane requires temperature-controlled transportation to maintain product integrity. When true, cold-chain compliance monitoring, temperature logging, and qualified carrier requirements apply. Critical for health, hygiene, and perishable consumer goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was first created in the system. Used for data lineage, audit trail, and record lifecycle management. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `cross_border` BOOLEAN COMMENT 'Indicates whether this lane crosses an international border, requiring customs documentation, import/export compliance, and potentially additional transit time for border clearance. Drives customs broker assignment and trade compliance workflows.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the lane benchmark rates and cost data (e.g., USD, EUR, GBP). Required for multi-currency freight cost consolidation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `customs_trade_zone` STRING COMMENT 'Trade zone or customs agreement applicable to this cross-border lane (e.g., USMCA, EU Single Market, ASEAN). Determines duty rates, documentation requirements, and customs clearance procedures. Populated only for cross-border lanes.',
    `lane_description` STRING COMMENT 'The lane description of the lane record',
    `destination_city` STRING COMMENT 'City name of the lane destination point. Used for geographic lane analysis, carrier rate zone determination, and network design reporting.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the lane destination. Required for cross-border lane classification, customs documentation, and international freight rate benchmarking.. Valid values are `^[A-Z]{3}$`',
    `destination_location` STRING COMMENT 'The destination location of the lane record',
    `destination_location_code` STRING COMMENT 'Business-facing code for the destination location (e.g., customer DC code, store code, or GS1 Global Location Number). Used in EDI transactions, carrier communications, and freight audit matching.',
    `destination_state_province` STRING COMMENT 'ISO 3166-2 state or province code for the lane destination. Used in carrier rate zone mapping and freight cost benchmarking.. Valid values are `^[A-Z]{2,3}$`',
    `distance_km` DECIMAL(18,2) COMMENT 'Measured or calculated road/route distance between origin and destination in kilometers. Used for transit time estimation, fuel surcharge calculation, carrier rate benchmarking, and carbon emissions reporting per ISO 14001 and EPA guidelines.',
    `dsd_eligible` BOOLEAN COMMENT 'Indicates whether this lane supports Direct Store Delivery (DSD), where product is delivered directly from the manufacturer or distributor to the retail store, bypassing the retailers distribution center. Relevant for high-velocity CPG categories.',
    `effective_date` DATE COMMENT 'Date from which this lane definition becomes active and available for freight planning, carrier assignment, and cost benchmarking. Used to manage lane versioning and contract period alignment.',
    `effective_from` DATE COMMENT 'The effective from of the lane record',
    `effective_until` DATE COMMENT 'The effective until of the lane record',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this lane. Refrigerated (reefer) equipment is critical for cold-chain compliance in temperature-sensitive consumer goods. Drives carrier qualification and cost benchmarking. [ENUM-REF-CANDIDATE: dry_van|refrigerated|flatbed|tanker|container_20ft|container_40ft|container_45ft|parcel|bulk — promote to reference product]',
    `expiry_date` DATE COMMENT 'Date after which this lane definition is no longer valid for freight planning. Nullable for open-ended lanes. Used to manage contract renewals, network redesigns, and lane decommissioning.',
    `hazmat_required` BOOLEAN COMMENT 'Indicates whether this lane requires carriers certified for hazardous materials (HAZMAT) transport. Applicable for lanes carrying chemical, aerosol, or regulated consumer goods. Triggers carrier qualification checks and regulatory documentation requirements per DOT/EPA/OSHA.',
    `is_active` BOOLEAN COMMENT 'The is active of the lane record',
    `lane_status` STRING COMMENT 'Current lifecycle status of the transportation lane. Active lanes are available for freight tendering and route optimization. Inactive or suspended lanes are excluded from planning runs.. Valid values are `active|inactive|suspended|pending_approval`',
    `lane_type` STRING COMMENT 'The lane type of the lane record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the lane record',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the lane record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was last updated. Used for change tracking, data freshness monitoring, and incremental ETL processing in the Databricks Silver Layer.',
    `lane_name` STRING COMMENT 'Human-readable descriptive name for the transportation lane, typically combining origin and destination location names and transport mode (e.g., Chicago DC to New York RDC - Truckload). Used in reporting and carrier communication.',
    `network_region` STRING COMMENT 'Geographic or operational network region to which this lane belongs (e.g., Northeast, Southeast, Midwest, West Coast, EMEA, APAC). Used for network design segmentation, regional freight cost analysis, and carrier portfolio management.',
    `notes` STRING COMMENT 'The notes of the lane record',
    `origin_city` STRING COMMENT 'City name of the lane origin point. Used for geographic lane analysis, carrier rate zone determination, and network design reporting.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the lane origin. Required for cross-border lane classification, customs documentation, and international freight rate benchmarking.. Valid values are `^[A-Z]{3}$`',
    `origin_location` STRING COMMENT 'The origin location of the lane record',
    `origin_location_code` STRING COMMENT 'Business-facing code for the origin location (e.g., plant code, DC code, or GS1 Global Location Number). Used in EDI transactions, carrier communications, and freight audit matching.',
    `origin_state_province` STRING COMMENT 'ISO 3166-2 state or province code for the lane origin. Used in carrier rate zone mapping, regulatory compliance (e.g., CARB emissions zones), and freight cost benchmarking.. Valid values are `^[A-Z]{2,3}$`',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Target OTIF (On Time In Full) performance percentage for this lane, representing the contractual or operational delivery reliability goal. Used as the KPI baseline for carrier performance scorecards and SLA compliance reporting.',
    `preferred_mode` STRING COMMENT 'The preferred mode of the lane record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the lane record',
    `routing_guide_rank` STRING COMMENT 'Numeric rank of the preferred carrier in the lane routing guide sequence. Rank 1 is the primary carrier; higher ranks are fallback options. Used in automated freight tendering workflows to determine tender sequence.',
    `service_level` STRING COMMENT 'Contracted service level for this lane defining the speed and priority of freight movement. Standard is regular scheduled service; expedited is premium fast transit; economy is cost-optimized slower service; dedicated is exclusive carrier capacity; spot is ad-hoc market rate.. Valid values are `standard|expedited|economy|dedicated|spot`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this lane record originated (e.g., SAP Transportation Management, Blue Yonder WMS). Used for data lineage tracking and reconciliation in the Databricks Silver Layer.. Valid values are `SAP_TM|BLUE_YONDER|ORACLE_TMS|MANUAL`',
    `standard_transit_days` STRING COMMENT 'Contractually agreed or operationally standard number of calendar days for freight to travel from origin to destination on this lane. Used as the baseline for OTIF (On Time In Full) measurement, delivery promise, and ATP/CTP calculations in SAP IBP.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain lanes. Freight must be maintained at or below this threshold throughout transit. Used for carrier qualification, SLA monitoring, and regulatory compliance under FDA and GMP guidelines.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain lanes. Freight must be maintained at or above this threshold throughout transit. Used for carrier qualification, SLA monitoring, and regulatory compliance under FDA and GMP guidelines.',
    `transit_time_days` DECIMAL(18,2) COMMENT 'The transit time days of the lane record',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used on this lane. Determines carrier pool, equipment type, transit time standards, and freight cost benchmarks. Truckload (TL) and Less-than-Truckload (LTL) are most common in CPG domestic networks. [ENUM-REF-CANDIDATE: truckload|less_than_truckload|intermodal|rail|air|ocean|parcel|courier|drayage — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the lane record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the lane record',
    CONSTRAINT pk_lane PRIMARY KEY(`lane_id`)
) COMMENT 'Defined origin-to-destination transportation lane used for freight planning, carrier assignment, and cost benchmarking. Captures origin and destination location codes, transport mode, distance, transit time standard, lane classification (inbound/outbound/inter-facility/last-mile), preferred carrier assignments, volume history, and lane-level cost benchmarks. Foundational reference for route optimization, freight tendering, and network design.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` (
    `logistics_shipment_id` BIGINT COMMENT 'Unique surrogate identifier for the logistics shipment record in the lakehouse Silver layer. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the contracted carrier (trucking company, ocean liner, air freight provider, parcel carrier) responsible for executing this shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Logistics shipments incur freight costs allocated to cost centers for P&L and budget reporting. In consumer goods, shipments (including DSD and inter-facility transfers) are directly assigned to cost ',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the facility (distribution center, retail store, customer location, or 3PL node) to which the shipment is consigned.',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Required for OTIF reporting: links each logistics shipment to its originating distribution shipment for status tracking.',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order or transportation order that authorized and planned this shipment movement.',
    `lane_id` BIGINT COMMENT 'Reference to the contracted transportation lane (origin-destination pair) governing rate, transit time, and carrier assignment for this shipment.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Traceability: link each shipment to its originating manufacturing facility for cost allocation and regulatory reporting.',
    `origin_distribution_facility_id` BIGINT COMMENT 'The origin distribution facility id of the logistics shipment record',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Shipment origin account is needed for cost attribution, SLA reporting, and regulatory shipment origin documentation.',
    `primary_logistics_distribution_facility_id` BIGINT COMMENT 'Reference to the facility (plant, distribution center, warehouse, or supplier location) from which the shipment departs.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipment costs are attributed to profit centers for brand/channel profitability analysis in consumer goods. Logistics costs by profit center are required for segment reporting and trade spend analysis',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Shipment tracking must reference the originating sales order for fulfillment status and revenue reconciliation.',
    `actual_delivery_date` DATE COMMENT 'The actual date the shipment was received and confirmed at the destination facility. Used for OTIF (On Time In Full) KPI calculation and carrier performance scorecarding.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment was delivered and signed for at the destination, as captured by the carriers POD (Proof of Delivery) system or electronic signature device. Enables time-window compliance measurement.',
    `actual_pickup_date` DATE COMMENT 'The actual pickup date of the logistics shipment record',
    `actual_ship_date` DATE COMMENT 'The actual date the shipment physically departed from the origin facility, as confirmed by the WMS or carrier. Used for OTIF (On Time In Full) measurement and freight audit.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the logistics shipment record',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number of the logistics shipment record',
    `bol_number` STRING COMMENT 'Bill of Lading number issued by the carrier as the legal contract of carriage and receipt of goods. Required for freight audit, customs clearance, and proof of delivery. Key document in SAP S/4HANA SD and Blue Yonder WMS.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `logistics_shipment_code` STRING COMMENT 'The logistics shipment code of the logistics shipment record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled cold chain handling throughout transit. Triggers cold chain compliance monitoring, reefer equipment assignment, and regulatory documentation for applicable product categories (e.g., perishables, pharmaceuticals).',
    `container_number` STRING COMMENT 'ISO 6346 standardized container identification number for ocean freight shipments (e.g., MSCU1234567). Used for port tracking, customs clearance, and demurrage/detention management.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the source system (TMS/ERP/WMS). Used for audit trail, data lineage, and SLA measurement from order-to-ship cycle time analysis.',
    `currency_code` STRING COMMENT 'The currency code of the logistics shipment record',
    `logistics_shipment_description` STRING COMMENT 'The logistics shipment description of the logistics shipment record',
    `destination_address` STRING COMMENT 'The destination address of the logistics shipment record',
    `direction` STRING COMMENT 'Indicates the direction of the shipment relative to the enterprise network: inbound (from supplier), outbound (to customer/retailer), interplant (between internal facilities), or return (reverse logistics).. Valid values are `inbound|outbound|interplant|return`',
    `effective_from` DATE COMMENT 'The effective from of the logistics shipment record',
    `effective_until` DATE COMMENT 'The effective until of the logistics shipment record',
    `exception_code` STRING COMMENT 'Standardized code identifying the reason for a shipment exception or delay (e.g., weather delay, carrier capacity, customs hold, address correction, damaged goods). Used for root cause analysis and carrier performance management. [ENUM-REF-CANDIDATE: weather_delay|carrier_capacity|customs_hold|address_correction|damaged_goods|mechanical_failure|other — promote to reference product]',
    `expected_delivery_date` DATE COMMENT 'The expected delivery date of the logistics shipment record',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total contracted or invoiced freight cost for this shipment in the transaction currency. Used for freight cost allocation to COGS (Cost of Goods Sold), carrier spend analytics, and freight audit reconciliation.',
    `freight_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount (e.g., USD, EUR, GBP). Required for multi-currency freight spend reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `freight_terms` STRING COMMENT 'Freight payment terms indicating who bears the freight cost: prepaid (shipper pays), collect (consignee pays), or third_party (a designated third party pays). Drives freight invoice routing and cost allocation.. Valid values are `prepaid|collect|third_party`',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Carrier-applied fuel surcharge amount for this shipment, separate from the base freight rate. Used for freight audit, cost variance analysis, and carrier contract compliance.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, labeling, and documentation per DOT/IATA/IMDG regulations. Triggers HAZMAT compliance workflow and carrier notification.',
    `incoterm` STRING COMMENT 'The incoterm of the logistics shipment record',
    `incoterms` STRING COMMENT 'The incoterms of the logistics shipment record',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the transfer of risk, cost responsibility, and delivery obligations between shipper and consignee. Governs freight cost allocation and insurance requirements. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `is_cold_chain` BOOLEAN COMMENT 'The is cold chain of the logistics shipment record',
    `is_hazmat` BOOLEAN COMMENT 'The is hazmat of the logistics shipment record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the logistics shipment record',
    `logistics_shipment_status` STRING COMMENT 'The logistics shipment status of the logistics shipment record',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the logistics shipment record',
    `logistics_shipment_name` STRING COMMENT 'The logistics shipment name of the logistics shipment record',
    `notes` STRING COMMENT 'The notes of the logistics shipment record',
    `origin_address` STRING COMMENT 'The origin address of the logistics shipment record',
    `otif_in_full` BOOLEAN COMMENT 'Indicates whether the shipment was delivered with the complete ordered quantity, contributing to the OTIF (On Time In Full) KPI. Supports retailer compliance scorecarding and deduction management.',
    `otif_on_time` BOOLEAN COMMENT 'Indicates whether the shipment was delivered on or before the planned delivery date, contributing to the OTIF (On Time In Full) KPI. Derived from planned vs. actual delivery date comparison and stored for reporting efficiency.',
    `planned_delivery_date` DATE COMMENT 'The date on which the shipment is expected to arrive at the destination facility, based on contracted transit time and lane performance.',
    `planned_pickup_date` DATE COMMENT 'The planned pickup date of the logistics shipment record',
    `planned_ship_date` DATE COMMENT 'The date on which the shipment is scheduled to depart from the origin facility, as determined by the transportation plan or S&OP (Sales and Operations Planning) process.',
    `pod_received` BOOLEAN COMMENT 'Indicates whether a signed Proof of Delivery (POD) document has been received and validated for this shipment. Required for freight invoice payment release and dispute resolution.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time the Proof of Delivery (POD) was electronically captured or received, as recorded by the carriers mobile device or ePOD system. Used for freight audit and dispute resolution timelines.',
    `priority_level` STRING COMMENT 'The priority level of the logistics shipment record',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used to track LTL (Less-Than-Truckload) shipments through the carriers network. Essential for freight audit and claims management.. Valid values are `^[A-Z0-9-]{4,25}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the logistics shipment record',
    `service_level` STRING COMMENT 'Contracted carrier service level for this shipment, determining transit time commitment and freight rate tier. Drives SLA (Service Level Agreement) compliance measurement.. Valid values are `standard|expedited|overnight|same_day|economy`',
    `ship_date` DATE COMMENT 'The ship date of the logistics shipment record',
    `ship_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment departed the origin facility, as recorded by the WMS or gate system. Used for transit time calculation and carrier SLA compliance.',
    `shipment_number` STRING COMMENT 'Externally-known business identifier for the shipment, typically generated by the TMS or ERP (e.g., SAP outbound delivery number or transportation order number). Used for track-and-trace and carrier communication.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment. Drives OTIF (On Time In Full) measurement, exception management, and track-and-trace visibility. [ENUM-REF-CANDIDATE: planned|tendered|confirmed|in_transit|out_for_delivery|delivered|cancelled|exception — promote to reference product]',
    `shipment_type` STRING COMMENT 'The shipment type of the logistics shipment record',
    `source_system_code` STRING COMMENT 'The source system code of the logistics shipment record',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold chain shipments. Exceedances trigger quality holds, product disposition reviews, and regulatory notifications.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold chain shipments. Used for reefer equipment configuration, carrier instructions, and cold chain compliance auditing.',
    `temperature_range` STRING COMMENT 'The temperature range of the logistics shipment record',
    `three_pl_reference` STRING COMMENT 'Reference number assigned by the 3PL (Third-Party Logistics) provider for this shipment in their WMS or TMS. Enables cross-system reconciliation and 3PL billing validation.. Valid values are `^[A-Z0-9-]{4,40}$`',
    `total_cases` STRING COMMENT 'Total number of cases (cartons) included in the shipment. Used for pick/pack verification, receiving reconciliation, and OTIF (On Time In Full) quantity compliance.',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'The total freight cost of the logistics shipment record',
    `total_pallets` STRING COMMENT 'Total number of pallets included in the shipment. Used for dock scheduling, trailer loading planning, and carrier billing for LTL shipments.',
    `total_pieces` STRING COMMENT 'The total pieces of the logistics shipment record',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'The total volume cbm of the logistics shipment record',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic meters. Used for dimensional weight calculation, trailer utilization, and freight cost optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging and pallets. Used for freight rate calculation, carrier billing, and compliance with road weight limits.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for parcel or express shipments (e.g., UPS, FedEx, DHL tracking number). Enables real-time track-and-trace via carrier APIs and customer-facing shipment visibility portals.. Valid values are `^[A-Z0-9]{8,35}$`',
    `transport_mode` STRING COMMENT 'Mode of transportation used for this shipment. TL = Truckload, LTL = Less-Than-Truckload, parcel = small package carrier, ocean = sea freight, air = air freight, rail = rail freight. Drives freight cost allocation and transit time expectations.. Valid values are `TL|LTL|parcel|ocean|air|rail`',
    `uom` STRING COMMENT 'The uom of the logistics shipment record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record in the source system. Used for incremental data loading, change detection, and audit trail in the Silver layer lakehouse.',
    CONSTRAINT pk_logistics_shipment PRIMARY KEY(`logistics_shipment_id`)
) COMMENT 'Core transactional record representing a physical movement of goods from origin to destination. Captures shipment number, BOL (Bill of Lading), PRO number, carrier assignment, mode of transport (TL/LTL/parcel/ocean/air/rail), origin and destination facility, planned and actual ship/delivery dates, total weight and volume, freight terms (prepaid/collect/third-party), shipment status lifecycle, incoterms, cold-chain flag, and consolidation references. Central entity for track-and-trace, OTIF measurement, and freight cost allocation. References carrier, lane, and freight order. [SSOT] Superseded by authoritative table distribution.distribution_shipment for concept shipment. SSOT: canonical table is distribution.distribution_shipment. [SSOT for concept shipment.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` (
    `shipment_leg_id` BIGINT COMMENT 'Unique system-generated identifier for each individual shipment leg record within the logistics network. Serves as the primary key for the shipment_leg entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (3PL, freight forwarder, or internal fleet) responsible for executing this specific leg of the shipment. Supports carrier performance analytics and freight cost allocation.',
    `network_node_id` BIGINT COMMENT 'Reference to the logistics node (warehouse, plant, port, cross-dock, or distribution center) at which this leg arrives. Used for route optimization and delivery confirmation.',
    `lane_id` BIGINT COMMENT 'The lane id of the shipment leg record',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: DC-level lane performance reporting: consumer goods logistics teams measure transit time and cost by originating DC. shipment_leg.origin_location_code is a denormalized text field; a proper FK to dist',
    `primary_shipment_network_node_id` BIGINT COMMENT 'Reference to the logistics node (warehouse, plant, port, cross-dock, or distribution center) from which this leg departs. Used for route optimization and network analysis.',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Additional carrier charges beyond the base freight rate for this leg, including fuel surcharges, detention, liftgate, residential delivery, or hazmat fees. Used in freight audit and total landed cost analysis.',
    `actual_arrival` TIMESTAMP COMMENT 'The actual arrival of the shipment leg record',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time at which the shipment leg arrived at the destination node as confirmed by the receiving facility or carrier. Used for OTIF measurement, dwell time analysis, and freight audit.',
    `actual_departure` TIMESTAMP COMMENT 'The actual departure of the shipment leg record',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time at which the shipment leg departed from the origin node as recorded by the carrier or warehouse management system. Used for OTIF performance measurement and delay root-cause analysis.',
    `actual_transit_hours` DECIMAL(18,2) COMMENT 'Actual elapsed transit time in hours for this leg, calculated from actual departure to actual arrival timestamps. Used for carrier performance benchmarking and OTIF analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the shipment leg record',
    `bill_of_lading_number` STRING COMMENT 'Unique Bill of Lading (BOL) number issued for this shipment leg. Serves as the legal contract between shipper and carrier and is required for customs clearance, freight audit, and proof of delivery.',
    `carbon_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide equivalent (CO₂e) emissions in kilograms for this shipment leg, calculated based on transport mode, distance, and cargo weight. Supports sustainability reporting under ISO 14001 and ESG commitments.',
    `carrier_pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number or tracking number for this leg. Used for carrier track-and-trace, freight bill matching, and proof of delivery retrieval.',
    `shipment_leg_code` STRING COMMENT 'The shipment leg code of the shipment leg record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment leg record was first created in the system. Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'The currency code of the shipment leg record',
    `customs_clearance_required` BOOLEAN COMMENT 'Indicates whether this leg crosses an international border and requires customs clearance (True). Triggers customs documentation workflows and compliance checks under applicable trade regulations.',
    `customs_entry_number` STRING COMMENT 'Official customs entry or declaration number assigned by the customs authority for this leg. Required for cross-border shipments and regulatory compliance documentation.',
    `delay_reason_code` STRING COMMENT 'Standardized code identifying the root cause of any departure or arrival delay on this leg (e.g., weather, customs hold, carrier capacity, traffic, mechanical failure). Used for OTIF root-cause analysis and carrier performance management. [ENUM-REF-CANDIDATE: weather|customs_hold|carrier_capacity|traffic|mechanical_failure|port_congestion|documentation — promote to reference product]',
    `shipment_leg_description` STRING COMMENT 'The shipment leg description of the shipment leg record',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination node for this leg (e.g., USA, DEU, GBR). Used for customs compliance, trade lane analysis, and carbon footprint reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_location` STRING COMMENT 'The destination location of the shipment leg record',
    `destination_location_code` STRING COMMENT 'The destination location code of the shipment leg record',
    `distance_km` DECIMAL(18,2) COMMENT 'The distance km of the shipment leg record',
    `effective_from` DATE COMMENT 'The effective from of the shipment leg record',
    `effective_until` DATE COMMENT 'The effective until of the shipment leg record',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Most recent carrier-provided or system-calculated Estimated Time of Arrival (ETA) for this leg. Updated dynamically during transit to reflect real-time conditions. Distinct from planned arrival (static) and actual arrival (confirmed).',
    `freight_audit_status` STRING COMMENT 'Current status of the freight invoice audit process for this leg. Tracks whether the carrier invoice has been validated, approved for payment, or is under dispute. Supports freight audit and payment workflows.. Valid values are `pending|approved|disputed|paid|written_off`',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Gross freight cost charged by the carrier for this specific leg, expressed in the transaction currency. Used for freight cost allocation, COGS calculation, and carrier contract compliance auditing.',
    `freight_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount on this leg (e.g., USD, EUR, GBP). Required for multi-currency freight cost consolidation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight in kilograms of the cargo on this leg, including packaging and pallets. Used for freight rate calculation, vehicle load compliance, and carrier billing validation.',
    `incoterms_code` STRING COMMENT 'INCOTERMS 2020 code defining the transfer of risk and responsibility between shipper and carrier/buyer for this leg (e.g., FOB, CIF, DAP). Determines freight cost ownership and insurance obligations. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this leg requires temperature-controlled cold chain handling (True) for perishable or temperature-sensitive consumer goods (e.g., health, hygiene, or food products). Triggers cold chain monitoring and compliance checks.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this leg involves the transport of hazardous materials (True) as classified under DOT, IATA, or IMDG regulations. Triggers special handling, documentation (SDS), and carrier compliance requirements.',
    `is_transshipment_point` BOOLEAN COMMENT 'Indicates whether the destination node of this leg is an intermediate transshipment point (True) rather than the final delivery destination (False). Used to identify relay legs in intermodal routing and cost allocation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment leg record was most recently modified. Used for incremental data loading, change detection, and audit trail in the Databricks Silver layer.',
    `leg_cost_amount` DECIMAL(18,2) COMMENT 'The leg cost amount of the shipment leg record',
    `leg_distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers for this shipment leg from origin node to destination node. Used for freight cost calculation, carbon emissions estimation, and route optimization analytics.',
    `leg_number` STRING COMMENT 'Sequential integer indicating the order of this leg within the parent shipment (e.g., 1 = first leg, 2 = second leg). Enables reconstruction of the full shipment route in correct order.',
    `leg_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for this shipment leg, often assigned by the carrier or freight forwarder (e.g., waybill number, booking reference). Used for carrier communication and freight audit.',
    `leg_sequence` STRING COMMENT 'The leg sequence of the shipment leg record',
    `leg_status` STRING COMMENT 'Current lifecycle status of the shipment leg reflecting its operational state. Drives track-and-trace visibility and exception management workflows. [ENUM-REF-CANDIDATE: planned|in_transit|arrived|completed|cancelled|delayed — promote to reference product if additional statuses are required]. Valid values are `planned|in_transit|arrived|completed|cancelled|delayed`',
    `leg_type` STRING COMMENT 'The leg type of the shipment leg record',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the shipment leg record',
    `shipment_leg_name` STRING COMMENT 'The shipment leg name of the shipment leg record',
    `notes` STRING COMMENT 'The notes of the shipment leg record',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the origin node for this leg (e.g., USA, DEU, GBR). Used for customs compliance, trade lane analysis, and carbon footprint reporting.. Valid values are `^[A-Z]{3}$`',
    `pallet_count` STRING COMMENT 'Number of pallets included in this shipment leg. Used for dock scheduling, vehicle load planning, and carrier billing reconciliation in consumer goods distribution.',
    `planned_arrival` TIMESTAMP COMMENT 'The planned arrival of the shipment leg record',
    `planned_arrival_timestamp` TIMESTAMP COMMENT 'Scheduled date and time at which the shipment leg is expected to arrive at the destination node. Used for receiving planning, dock scheduling, and OTIF target setting.',
    `planned_departure` TIMESTAMP COMMENT 'The planned departure of the shipment leg record',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'Scheduled date and time at which the shipment leg is planned to depart from the origin node. Used for transportation planning, carrier booking, and On Time In Full (OTIF) baseline measurement.',
    `planned_transit_hours` DECIMAL(18,2) COMMENT 'Expected transit duration in hours for this leg as defined in the carrier contract or transportation plan. Used as the baseline for on-time performance measurement and SLA compliance.',
    `proof_of_delivery_status` STRING COMMENT 'Status of the Proof of Delivery (POD) document for this leg. Tracks whether POD has been received, is pending, or is under dispute. Required for freight audit, accounts payable, and customer dispute resolution.. Valid values are `not_required|pending|received|rejected|disputed`',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the Proof of Delivery (POD) was confirmed or received for this leg. Used for OTIF measurement, freight audit closure, and customer service resolution.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the shipment leg record',
    `shipment_leg_status` STRING COMMENT 'The shipment leg status of the shipment leg record',
    `source_system_code` STRING COMMENT 'The source system code of the shipment leg record',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold chain compliance during this leg. Applicable to temperature-sensitive consumer goods. Used for cold chain monitoring and regulatory compliance reporting.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold chain compliance during this leg. Applicable to temperature-sensitive consumer goods. Used for cold chain monitoring and regulatory compliance reporting.',
    `transit_time_hours` DECIMAL(18,2) COMMENT 'The transit time hours of the shipment leg record',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this leg (e.g., road, rail, air, ocean, intermodal, courier). Determines applicable freight rates, transit time benchmarks, and regulatory requirements. Aligns with GS1 and INCOTERMS classification.. Valid values are `road|rail|air|ocean|intermodal|courier`',
    `transport_service_type` STRING COMMENT 'Service level classification for this leg (e.g., Full Truckload (FTL), Less-than-Truckload (LTL), parcel, express, standard, bulk). Impacts freight cost calculation and carrier selection logic.. Valid values are `full_truckload|less_than_truckload|parcel|express|standard|bulk`',
    `uom` STRING COMMENT 'The uom of the shipment leg record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the shipment leg record',
    `vehicle_code` STRING COMMENT 'Identifier of the vehicle, vessel, aircraft, or rail car assigned to execute this leg (e.g., truck license plate, vessel IMO number, flight number, rail car ID). Used for asset tracking and carrier compliance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total cargo volume in cubic meters (CBM) for this leg. Used for volumetric freight rate calculation, container utilization analysis, and load planning optimization.',
    CONSTRAINT pk_shipment_leg PRIMARY KEY(`shipment_leg_id`)
) COMMENT 'Individual movement segment within a multi-leg shipment. Captures leg sequence, origin and destination nodes, carrier for the leg, mode of transport, planned and actual departure/arrival timestamps, leg distance, leg freight cost, transshipment point flag, and leg status. Enables granular track-and-trace and cost allocation across intermodal movements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` (
    `shipment_item_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment line item record in the logistics data platform. Primary key for the shipment_item entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Lot traceability and recall management: consumer goods regulations (FDA, CPSC) require knowing exactly which manufactured batch is in each shipment item. Enables batch-level recall execution and cold-',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: Each shipment item in consumer goods (food, personal care, pharma) must be accompanied by a CoA for customs clearance, retailer compliance, and cold-chain verification. Linking shipment_item to certif',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which this item was picked and dispatched. Used for inventory depletion tracking, warehouse performance analytics, and DRP (Distribution Requirements Planning).',
    `dtc_order_line_id` BIGINT COMMENT 'Foreign key linking to consumer.dtc_order_line. Business justification: Line-level DTC fulfillment traceability — which shipment item fulfills which DTC order line — is required for partial shipment analysis, line-level OTIF, and returns processing. Currently dtc_order_li',
    `inbound_receipt_line_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt_line. Business justification: Inbound ASN-to-receipt reconciliation: consumer goods supplier compliance and freight audit processes match shipment items against receipt lines to identify discrepancies, short deliveries, and damage',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Required for lot traceability report linking inspected lots to shipped items, enabling recall and compliance verification.',
    `label_spec_id` BIGINT COMMENT 'Foreign key linking to product.label_spec. Business justification: Regulatory compliance and recall management: shipment_item must record which label_spec version was applied for the destination market. Consumer goods regulators require traceability of label versions',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment header record. Establishes the header-to-line relationship for all items within a single shipment dispatch event. Aligns with SAP SD delivery document header.',
    `outbound_order_line_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order_line. Business justification: Order-to-shipment reconciliation: consumer goods OTIF reporting and short-ship analysis require matching each shipment item to the originating outbound order line. Logistics analysts and DC managers u',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Inbound shipment-to-PO-line matching: consumer goods receiving operations match each shipped item to a specific PO line for quantity variance detection, over/under delivery tolerance checks, and goods',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Inbound shipment OTIF tracking and receiving reconciliation: each shipment item must be traced to its originating PO for quantity confirmation, OTIF compliance reporting, and supplier performance meas',
    `return_order_id` BIGINT COMMENT 'Foreign key linking to sales.return_order. Business justification: Return shipment items must reference the authorizing return order (RMA) for reverse logistics tracking, credit memo processing, and quality inspection routing. Consumer goods reverse logistics teams m',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Shipment item is the line-level fulfillment entity mapped to a sales order for OTIF reporting, order fill-rate analysis, and shipment-to-order reconciliation. sales_order_number is a denormalized text',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for shipping manifest and inventory reconciliation; each shipment line must reference the master SKU to enable traceability, OTIF reporting, and regulatory compliance.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the shipment item record',
    `batch_number` STRING COMMENT 'The batch number of the shipment item record',
    `shipment_item_code` STRING COMMENT 'The shipment item code of the shipment item record',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed as received by the consignee at the delivery destination, captured from proof of delivery (POD) or EDI 214 acknowledgment. Used for invoice reconciliation and OTIF final measurement.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the product was manufactured or substantially transformed. Required for customs declarations, import duty determination, and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment item record was first created in the data platform, in ISO 8601 format with timezone offset. Used for data lineage, audit trail, and SLA measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which unit_cost and line_value are expressed. Enables multi-currency financial consolidation and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `declared_value` DECIMAL(18,2) COMMENT 'The declared value of the shipment item record',
    `delivery_document_number` STRING COMMENT 'ERP delivery document number (e.g., SAP outbound delivery number) associated with this shipment line. Serves as the primary cross-reference between the logistics execution system and the financial/order management system.',
    `shipment_item_description` STRING COMMENT 'The shipment item description of the shipment item record',
    `effective_from` DATE COMMENT 'The effective from of the shipment item record',
    `effective_until` DATE COMMENT 'The effective until of the shipment item record',
    `expiry_date` DATE COMMENT 'Expiration date of the product lot being shipped, used to enforce FEFO (First Expired First Out) inventory rotation, ensure shelf-life compliance at retail, and prevent shipment of expired goods.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of this shipment line item in kilograms, including product, inner packaging, and outer packaging. Used for freight cost calculation, carrier capacity planning, and customs declarations.',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System (HS) tariff classification code for the product, used for customs clearance, import duty calculation, and international trade compliance. Typically 6-10 digits per WCO HS nomenclature.. Valid values are `^[0-9]{6,10}$`',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether this item contains a controlled substance subject to DEA scheduling, FDA drug regulations, or equivalent international narcotics controls. Triggers enhanced chain-of-custody documentation requirements.',
    `is_dsd` BOOLEAN COMMENT 'Indicates whether this item is fulfilled via Direct Store Delivery (DSD) channel, bypassing the retailers distribution center and delivering directly to the store. Impacts route planning, SFA integration, and trade promotion settlement.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this shipment item is classified as a hazardous material requiring special handling, labeling, and transport documentation per DOT, IATA, or IMDG regulations. Triggers mandatory SDS (Safety Data Sheet) attachment.',
    `is_temperature_sensitive` BOOLEAN COMMENT 'Indicates whether this item requires temperature-controlled handling and transport (cold chain). When true, temperature range requirements and cold-chain compliance monitoring are enforced throughout the shipment lifecycle.',
    `item_description` STRING COMMENT 'Human-readable description of the product being shipped, including product name, variant, and pack size. Used on shipping documents, proof of delivery, and freight audit records.',
    `item_status` STRING COMMENT 'Current lifecycle status of this shipment line item. Tracks progression from warehouse picking through delivery confirmation. [ENUM-REF-CANDIDATE: planned|picked|loaded|in_transit|delivered|short_shipped|cancelled — promote to reference product]',
    `line_number` STRING COMMENT 'Sequential line number of this item within the parent shipment, used for ordering and referencing individual line items. Corresponds to SAP SD delivery item position number.',
    `line_value` DECIMAL(18,2) COMMENT 'Total declared value of this shipment line item (shipped_quantity × unit_cost), used for customs valuation, cargo insurance, and financial reporting. Expressed in the shipment currency.',
    `lot_number` STRING COMMENT 'The lot number of the shipment item record',
    `manufacture_date` DATE COMMENT 'Date on which the product lot was manufactured. Used in conjunction with expiry date to calculate remaining shelf life at time of shipment and validate minimum remaining shelf life (MRSL) requirements.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for storage and transport of this item. Applicable when is_temperature_sensitive is true. Exceedances trigger quality holds and non-conformance reporting.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for storage and transport of this item. Applicable when is_temperature_sensitive is true. Used to configure cold-chain monitoring alerts and carrier SLA requirements.',
    `shipment_item_name` STRING COMMENT 'The shipment item name of the shipment item record',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content only in kilograms, excluding all packaging materials. Required for regulatory labeling compliance, customs documentation, and COGS (Cost of Goods Sold) reporting.',
    `notes` STRING COMMENT 'The notes of the shipment item record',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of this item originally ordered by the customer or requested in the purchase order. Used for OTIF (On Time In Full) calculation and order fulfillment rate reporting.',
    `package_count` STRING COMMENT 'The package count of the shipment item record',
    `packaging_type` STRING COMMENT 'Type of packaging unit in which the item is shipped. Determines handling requirements, stacking rules, and warehouse slotting. Aligns with GS1 packaging hierarchy levels.. Valid values are `each|inner_pack|case|display|pallet|bulk`',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether this shipment line item has been placed on a quality hold due to a failed QC inspection, temperature exceedance, or regulatory non-conformance. Items on hold must not be delivered until released by QA.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the shipment item record',
    `quantity_uom` STRING COMMENT 'The quantity uom of the shipment item record',
    `regulatory_approval_number` STRING COMMENT 'Product registration or regulatory approval number required for cross-border shipments of regulated consumer goods (e.g., FDA registration, EPA registration, EU REACH authorization). Stored for customs and import compliance documentation.',
    `rejection_reason` STRING COMMENT 'Reason code or description for any quantity rejected or short-shipped on this line item, such as OOS (Out of Stock), quality hold, weight discrepancy, or carrier refusal. Used for root cause analysis and OTIF exception reporting.',
    `sales_order_line` STRING COMMENT 'Line item number within the originating sales order corresponding to this shipment item. Used for precise order-to-shipment reconciliation and partial fulfillment tracking.',
    `serial_number` STRING COMMENT 'Unique serial number assigned to an individual product unit, applicable for serialized items requiring unit-level traceability (e.g., high-value consumer electronics, regulated health products). Null for non-serialized bulk items.',
    `shipment_item_status` STRING COMMENT 'The shipment item status of the shipment item record',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of this item loaded and dispatched in the shipment. May differ from ordered quantity due to partial fulfillment, OOS (Out of Stock) conditions, or substitution. Core metric for OTIF compliance.',
    `source_system_code` STRING COMMENT 'The source system code of the shipment item record',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code (SSCC) — an 18-digit identifier assigned to the logistic unit (pallet, case) containing this item. Enables pallet-level traceability and EDI 856 ASN compliance with retail trading partners.. Valid values are `^[0-9]{18}$`',
    `storage_location` STRING COMMENT 'Specific storage location or bin within the warehouse from which this item was picked, as recorded in the WMS. Used for warehouse slotting optimization and pick path efficiency analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for this item at time of shipment, used for COGS (Cost of Goods Sold) calculation, inventory valuation, and freight cost allocation. Sourced from SAP S/4HANA CO standard cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure in which the shipped quantity is expressed. Common values include EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (litre), GAL (gallon). Aligns with GS1 UOM codes. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the shipment item record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this shipment item record, in ISO 8601 format with timezone offset. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'The volume cbm of the shipment item record',
    `volume_m3` DECIMAL(18,2) COMMENT 'Cubic volume of this shipment line item in cubic metres, used for truck load planning, container utilization optimization, and freight rate calculation based on dimensional weight.',
    `weight_kg` DECIMAL(18,2) COMMENT 'The weight kg of the shipment item record',
    CONSTRAINT pk_shipment_item PRIMARY KEY(`shipment_item_id`)
) COMMENT 'Line-item detail of goods included in a shipment. Captures SKU/GTIN, product description, ordered quantity, shipped quantity, unit of measure, gross weight, net weight, volume, hazmat flag, temperature-sensitive flag, lot/batch number, expiry date (FEFO compliance), and packaging type. Enables item-level traceability and cold-chain compliance tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Unique surrogate identifier for each delivery execution record in the Silver layer lakehouse. Primary key for the delivery data product.',
    `address_id` BIGINT COMMENT 'Foreign key linking to consumer.address. Business justification: DTC address deliverability analytics and address validation reporting require linking delivery records to the canonical consumer address. Eliminates denormalized address fields on delivery; enables de',
    `carrier_id` BIGINT COMMENT 'The carrier id of the delivery record',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_leg. Business justification: A delivery is the execution result of the final shipment leg in a multi-leg movement. shipment_leg captures leg sequence, origin/destination, actual arrival/departure timestamps, and leg-level freight',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A delivery record represents the execution outcome of a freight order — the freight_order is the transportation planning and tendering record that authorizes the physical movement, while delivery capt',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: Delivery completion triggers invoice payment processing and AR reconciliation. Billing teams match confirmed deliveries to sales invoices for dispute resolution and DSO management. A consumer goods AR',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: DC delivery performance KPIs: consumer goods supply chain teams track on-time delivery rates by originating distribution facility to identify DC-level execution issues. This link enables facility-leve',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: In DSD (Direct Store Delivery) operations, deliveries are made to specific retail stores. Store-level OTIF tracking, planogram compliance verification, and route optimization all require knowing which',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Delivery execution is tied to a specific sales order; the link supports delivery confirmation and invoicing workflows.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to consumer.shopper. Business justification: DTC last-mile personalization (delivery time preferences, access instructions) and consumer identity verification at doorstep require knowing the end shopper on the delivery record. Enables carrier-fa',
    `trade_account_id` BIGINT COMMENT 'Reference to the consignee (receiving party) account — typically a retail store, distribution center, or wholesale customer — to whom the goods are delivered.',
    `actual_delivery_date` DATE COMMENT 'The actual delivery date of the delivery record',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time the delivery was completed at the consignee location, as recorded by the driver via DSD handheld, e-POD app, or paper scan. Principal business event timestamp for OTIF calculation and dispute resolution.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual temperature in degrees Celsius recorded during delivery, captured by IoT sensor or driver log. Used to verify cold-chain compliance and support FDA/EU GDP regulatory reporting for temperature-sensitive goods.',
    `address` STRING COMMENT 'The address of the delivery record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the delivery record',
    `carrier_tracking_number` STRING COMMENT 'External tracking number assigned by the carrier for track-and-trace visibility. Enables real-time shipment monitoring and customer-facing delivery status updates.',
    `delivery_code` STRING COMMENT 'The delivery code of the delivery record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this delivery requires temperature-controlled cold-chain logistics (True) — applicable for perishable food, pharmaceutical, or temperature-sensitive consumer goods. Drives vehicle assignment and compliance monitoring.',
    `consignee_name` STRING COMMENT 'Legal or trading name of the receiving party (store, warehouse, or customer) at the delivery destination. Used for POD (Proof of Delivery) documentation and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the source system (SAP S/4HANA SD outbound delivery creation). Audit trail field for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount (e.g., USD, EUR, GBP). Required for multi-currency freight cost reporting and financial consolidation.. Valid values are `[A-Z]{3}`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of goods physically delivered and accepted at the consignee location. Core metric for OTIF (On Time In Full) in-full measurement, fill rate KPI, and invoice reconciliation.',
    `delivery_number` STRING COMMENT 'Externally-known business identifier for the delivery, typically sourced from SAP S/4HANA SD outbound delivery document (e.g., 80XXXXXXXX). Used in EDI communications, carrier coordination, and customer-facing tracking.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery execution. full = all ordered quantities delivered; partial = some quantities delivered; failed = delivery attempt unsuccessful; refused = consignee rejected delivery; pending = delivery not yet attempted. Core field for OTIF (On Time In Full) calculation.. Valid values are `full|partial|failed|refused|pending`',
    `delivery_type` STRING COMMENT 'Classification of the delivery method. DSD (Direct Store Delivery) = manufacturer delivers directly to retail shelf; warehouse = delivery to distribution center; cross_dock = transit without storage; drop_ship = vendor ships directly to consignee; returns = reverse logistics delivery. [ENUM-REF-CANDIDATE: DSD|warehouse|cross_dock|drop_ship|returns — promote to reference product]. Valid values are `DSD|warehouse|cross_dock|drop_ship|returns`',
    `delivery_description` STRING COMMENT 'The delivery description of the delivery record',
    `effective_from` DATE COMMENT 'The effective from of the delivery record',
    `effective_until` DATE COMMENT 'The effective until of the delivery record',
    `electronic_signature_flag` BOOLEAN COMMENT 'Indicates whether the POD (Proof of Delivery) signature was captured electronically (True) via e-POD app or DSD handheld, or obtained on paper (False). Determines evidentiary strength for dispute resolution.',
    `exception_code` STRING COMMENT 'Standardized exception code identifying the reason for delivery failure, partial delivery, or refusal (e.g., CONSIGNEE_CLOSED, ADDRESS_NOT_FOUND, CAPACITY_EXCEEDED, REFUSED_QUALITY). Sourced from carrier or DSD system exception taxonomy. [ENUM-REF-CANDIDATE: promote to reference product]',
    `exception_notes` STRING COMMENT 'Free-text notes describing delivery discrepancies, exceptions, or special circumstances recorded by the driver or dispatcher. Supplements the structured exception code for dispute resolution and root cause analysis.',
    `first_attempt_timestamp` TIMESTAMP COMMENT 'Date and time of the first delivery attempt at the consignee location. Relevant when the delivery required multiple attempts (e.g., failed first attempt followed by successful re-delivery). Supports carrier performance analytics.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost incurred for this delivery in the transaction currency. Used for freight audit, carrier invoice reconciliation, COGS (Cost of Goods Sold) allocation, and logistics cost-to-serve analytics.',
    `goods_condition_code` STRING COMMENT 'Condition of goods as assessed at point of delivery receipt. good = acceptable; damaged = physical damage observed; partial_damage = some units damaged; temperature_breach = cold-chain violation detected; contaminated = product integrity compromised. Triggers quality investigation and regulatory reporting. [ENUM-REF-CANDIDATE: good|damaged|partial_damage|temperature_breach|contaminated — promote to reference product]. Valid values are `good|damaged|partial_damage|temperature_breach|contaminated`',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the full ordered quantity was delivered (True). Component of the OTIF (On Time In Full) KPI, enabling separate on-time vs. in-full root cause analysis and fill rate reporting.',
    `is_complete` BOOLEAN COMMENT 'The is complete of the delivery record',
    `is_in_full` BOOLEAN COMMENT 'The is in full of the delivery record',
    `is_on_time` BOOLEAN COMMENT 'The is on time of the delivery record',
    `delivery_name` STRING COMMENT 'The delivery name of the delivery record',
    `notes` STRING COMMENT 'The notes of the delivery record',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the delivery was completed on or before the scheduled delivery date/time (True). Component of the OTIF (On Time In Full) KPI, enabling separate on-time vs. in-full root cause analysis.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods ordered for this delivery as per the originating sales order. Baseline for OTIF (On Time In Full) in-full calculation and delivery fill rate measurement.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this delivery met the OTIF (On Time In Full) KPI criteria — True if delivered on or before the scheduled date AND at 100% of ordered quantity. Core retail compliance metric for major retailers (e.g., Walmart OTIF penalty program).',
    `photo_attachment_reference` STRING COMMENT 'Storage reference or URL to photo evidence captured at delivery (e.g., goods condition, placement, damaged packaging). Supports POD (Proof of Delivery) documentation and insurance claims.',
    `planned_delivery_date` DATE COMMENT 'The planned delivery date of the delivery record',
    `pod_source` STRING COMMENT 'System or method used to capture the POD (Proof of Delivery). DSD_handheld = Direct Store Delivery device; epod_app = electronic POD mobile application; paper_scan = digitized paper document; EDI = Electronic Data Interchange confirmation; manual = manually entered. Determines data quality and evidentiary weight.. Valid values are `DSD_handheld|epod_app|paper_scan|EDI|manual`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the delivery record',
    `quantity_uom` STRING COMMENT 'Unit of measure for ordered and delivered quantities (e.g., EA=each, CS=case, PAL=pallet, KG=kilogram). Aligns with GS1 unit of measure codes and SAP base unit of measure configuration. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `recipient_name` STRING COMMENT 'Full name of the individual who physically received and signed for the delivery at the consignee location. Core POD (Proof of Delivery) field for dispute resolution and legal evidence.',
    `refused_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods refused or rejected by the consignee at point of delivery. Triggers reverse logistics, credit memo processing, and quality investigation workflows.',
    `rejection_quantity` DECIMAL(18,2) COMMENT 'The rejection quantity of the delivery record',
    `rejection_reason` STRING COMMENT 'The rejection reason of the delivery record',
    `scheduled_delivery_date` DATE COMMENT 'The planned calendar date on which the delivery was scheduled to arrive at the consignee location. Used as the baseline for OTIF (On Time In Full) on-time measurement and SLA compliance.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'The precise planned date and time window start for delivery at the consignee location. Supports time-window compliance measurement and carrier SLA (Service Level Agreement) tracking.',
    `signature_captured` BOOLEAN COMMENT 'The signature captured of the delivery record',
    `signature_reference` STRING COMMENT 'Storage reference or URL pointing to the captured electronic or scanned signature image for this delivery. Used as legal evidence in POD (Proof of Delivery) dispute resolution.',
    `source_system_code` STRING COMMENT 'The source system code of the delivery record',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code (SSCC) — 18-digit identifier assigned to the shipping unit (pallet, case, or container) for this delivery. Enables end-to-end supply chain traceability per GS1 standards.. Valid values are `^d{18}$`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain delivery compliance. Compared against actual recorded temperature to detect cold-chain breaches and trigger regulatory reporting.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain delivery compliance. Compared against actual recorded temperature to detect cold-chain breaches and trigger regulatory reporting.',
    `uom` STRING COMMENT 'The uom of the delivery record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delivery record in the source system. Supports incremental data loading, audit trails, and change detection in the Silver layer.',
    `window_end` TIMESTAMP COMMENT 'The window end of the delivery record',
    `window_start` TIMESTAMP COMMENT 'The window start of the delivery record',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Record of final delivery execution and proof of delivery (POD) at the consignee location. Captures delivery number, shipment reference, consignee account, delivery address, scheduled and actual delivery timestamps, delivered quantity, delivery status (full/partial/failed/refused), recipient name and signature, electronic signature flag, condition of goods at receipt, photo attachment references, discrepancy notes, POD source (DSD handheld, e-POD app, paper scan), driver/vehicle reference, and exception codes. SSOT for last-mile delivery outcomes, OTIF calculation, and dispute resolution evidence.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Unique system-generated identifier for the proof of delivery record. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or 3PL responsible for executing the delivery. Used for freight audit, carrier performance tracking, and dispute resolution.',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery order (SAP outbound delivery document) associated with this POD. Enables traceability from POD back to the originating delivery instruction.',
    `dtc_order_id` BIGINT COMMENT 'Foreign key linking to consumer.dtc_order. Business justification: DTC consumer dispute resolution and returns authorization requires direct POD-to-DTC-order linkage. Customer service teams need to pull POD evidence against a specific DTC order without traversing shi',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: POD documents are primary evidence in invoice dispute resolution processes. When a customer disputes a sales invoice, the AR team retrieves the POD to confirm delivery. Consumer goods companies requir',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment for which this proof of delivery was captured. Links POD to the outbound or inbound shipment record.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to consumer.shopper. Business justification: Age-restricted product delivery (alcohol, tobacco) requires identity verification at doorstep tied to the specific shopper record. POD must reference the shopper for regulatory compliance (age verific',
    `trade_account_id` BIGINT COMMENT 'Reference to the consignee (retail customer, distributor, or DC) who received the goods. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the proof of delivery record',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number issued by the carrier for this shipment. Serves as the primary legal transport document reference and is used in freight audit, customs compliance, and dispute resolution.',
    `captured_by` STRING COMMENT 'The captured by of the proof of delivery record',
    `captured_device` STRING COMMENT 'The captured device of the proof of delivery record',
    `carrier_scan_timestamp` TIMESTAMP COMMENT 'Timestamp of the carriers own barcode or RFID scan event at the point of delivery, as transmitted via EDI or carrier portal. May differ from receipt_timestamp if there is a lag between physical delivery and system capture.',
    `proof_of_delivery_code` STRING COMMENT 'The proof of delivery code of the proof of delivery record',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the delivery maintained required cold-chain temperature conditions throughout transit (True = compliant). Critical for temperature-sensitive consumer goods (e.g., dairy, frozen, pharmaceutical). Supports FDA and ISO 22716 compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POD record was first created in the system, either by a DSD handheld, e-POD app, or paper scan ingestion process. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The currency code of the proof of delivery record',
    `customer_reference_number` STRING COMMENT 'The consignees own purchase order or reference number for this delivery. Enables cross-referencing between the suppliers POD and the customers receiving records for EDI reconciliation and dispute resolution.',
    `damage_description` STRING COMMENT 'The damage description of the proof of delivery record',
    `damage_noted` BOOLEAN COMMENT 'The damage noted of the proof of delivery record',
    `damage_notes` STRING COMMENT 'The damage notes of the proof of delivery record',
    `damage_reported` BOOLEAN COMMENT 'The damage reported of the proof of delivery record',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of goods confirmed as received by the consignee at the time of delivery. Used to calculate OTIF (On Time In Full) fill rate and identify quantity discrepancies against the ordered quantity.',
    `delivery_condition` STRING COMMENT 'The delivery condition of the proof of delivery record',
    `delivery_location_gln` STRING COMMENT 'GS1 Global Location Number (GLN) of the delivery destination. Provides a globally unique, standardized identifier for the consignee location, enabling interoperability with trading partners and EDI systems.. Valid values are `^[0-9]{13}$`',
    `delivery_location_name` STRING COMMENT 'Name of the physical delivery location (e.g., store name, distribution center name, warehouse name). Provides human-readable identification of the delivery destination for reporting and operations.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery event. Drives freight audit workflows, OTIF (On Time In Full) reporting, and dispute resolution processes. [ENUM-REF-CANDIDATE: pending|delivered|partially_delivered|failed|disputed|cancelled — promote to reference product if additional statuses are required]. Valid values are `pending|delivered|partially_delivered|failed|disputed|cancelled`',
    `delivery_temperature_c` DECIMAL(18,2) COMMENT 'Recorded temperature in degrees Celsius at the point of delivery for temperature-sensitive goods. Used to verify cold-chain compliance and support FDA regulatory reporting for perishable or pharmaceutical consumer goods.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the proof of delivery record',
    `proof_of_delivery_description` STRING COMMENT 'The proof of delivery description of the proof of delivery record',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified at the time of delivery (True = discrepancy exists). Triggers downstream dispute resolution, freight audit, and claims workflows.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of any discrepancy observed at delivery, such as quantity shortages, damaged packaging, wrong items, or temperature excursions. Used in dispute resolution and freight audit processes.',
    `discrepancy_type` STRING COMMENT 'Categorical classification of the type of discrepancy identified at delivery. Enables structured reporting and root cause analysis across the logistics network. [ENUM-REF-CANDIDATE: quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation — promote to reference product]. Valid values are `quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation`',
    `dispute_resolution_date` DATE COMMENT 'The date on which a delivery dispute was formally resolved. Used to measure dispute resolution cycle time and SLA compliance for freight audit and carrier management.',
    `dispute_status` STRING COMMENT 'Current status of any freight or delivery dispute associated with this POD. Tracks the lifecycle of dispute resolution from identification through closure. Supports freight audit and carrier claims management.. Valid values are `no_dispute|open|under_review|resolved|escalated`',
    `dsd_route_stop_sequence` STRING COMMENT 'The sequential stop number of this delivery within the DSD route. Used for route optimization analysis, driver performance measurement, and DSD compliance reporting in Salesforce Consumer Goods Cloud.',
    `effective_from` DATE COMMENT 'The effective from of the proof of delivery record',
    `effective_until` DATE COMMENT 'The effective until of the proof of delivery record',
    `electronic_signature_flag` BOOLEAN COMMENT 'Indicates whether the POD was captured via electronic signature (True) or via paper-based signature (False). Drives e-POD compliance reporting and DSD handheld audit workflows.',
    `exception_flag` BOOLEAN COMMENT 'The exception flag of the proof of delivery record',
    `freight_bill_number` STRING COMMENT 'The carrier-issued freight bill or bill of lading (BOL) number associated with this delivery. Used to match POD records to freight invoices during freight audit and payment processes.',
    `geofence_validated_flag` BOOLEAN COMMENT 'Indicates whether the GPS coordinates captured at delivery were within the expected geofence boundary of the consignee location (True = within geofence). Used to detect fraudulent or erroneous POD captures in DSD operations.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured at the time of delivery confirmation. Used for geofencing validation, proof of delivery location verification, and DSD compliance auditing.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured at the time of delivery confirmation. Used alongside latitude for geofencing validation, delivery location verification, and DSD compliance auditing.',
    `goods_condition` STRING COMMENT 'Condition of the goods as assessed at the point of delivery by the recipient. Drives claims processing, carrier liability assessment, and quality incident reporting. [ENUM-REF-CANDIDATE: intact|damaged|partial_damage|refused|short_delivered — promote to reference product if additional conditions are required]. Valid values are `intact|damaged|partial_damage|refused|short_delivered`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'The gps latitude of the proof of delivery record',
    `gps_longitude` DECIMAL(18,2) COMMENT 'The gps longitude of the proof of delivery record',
    `proof_of_delivery_name` STRING COMMENT 'The proof of delivery name of the proof of delivery record',
    `notes` STRING COMMENT 'The notes of the proof of delivery record',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that was originally ordered and expected to be delivered. Compared against delivered_quantity to compute fill rate and identify shortages or overages for OTIF reporting.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this delivery met the OTIF (On Time In Full) criteria — delivered on or before the scheduled date and at the full ordered quantity (True = OTIF achieved). Core KPI for supply chain performance reporting.',
    `photo_attachment_count` STRING COMMENT 'Number of photo attachments captured and associated with this POD record. Indicates the volume of photographic evidence available for dispute resolution and claims processing.',
    `photo_attachment_urls` STRING COMMENT 'Comma-separated list of URL or file path references to photo images captured at delivery (e.g., photos of damaged goods, delivery location, pallet condition). Stored in secure document repository and referenced for dispute resolution.',
    `photo_reference` STRING COMMENT 'The photo reference of the proof of delivery record',
    `pod_confirmation_method` STRING COMMENT 'The method used to confirm delivery receipt (e.g., signature, PIN code, photo-only, verbal confirmation, unattended drop). Supports compliance with carrier SLA requirements and DSD operational standards.. Valid values are `signature|pin_code|photo_only|verbal_confirmation|unattended`',
    `pod_image_reference` STRING COMMENT 'The pod image reference of the proof of delivery record',
    `pod_number` STRING COMMENT 'Externally-known business reference number for this POD document. Used in freight audit, dispute resolution, and EDI acknowledgement exchanges with carriers and customers.. Valid values are `^POD-[A-Z0-9]{6,20}$`',
    `pod_reference` STRING COMMENT 'The pod reference of the proof of delivery record',
    `pod_source` STRING COMMENT 'The channel or method through which the POD was captured. Distinguishes between DSD (Direct Store Delivery) handheld devices, e-POD mobile applications, scanned paper documents, EDI transmissions, or carrier portal uploads. Critical for DSD compliance and data quality assessment.. Valid values are `dsd_handheld|epod_app|paper_scan|edi|carrier_portal`',
    `pod_status` STRING COMMENT 'The pod status of the proof of delivery record',
    `pod_type` STRING COMMENT 'The pod type of the proof of delivery record',
    `proof_of_delivery_status` STRING COMMENT 'The proof of delivery status of the proof of delivery record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the proof of delivery record',
    `quantity_uom` STRING COMMENT 'Unit of measure for the delivered and ordered quantities (e.g., EA = Each, CS = Case, PAL = Pallet, KG = Kilogram). Ensures consistent quantity comparison across SKUs and delivery types. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `receipt_timestamp` TIMESTAMP COMMENT 'The exact date and time at which the consignee acknowledged receipt of the goods. This is the principal business event timestamp for the POD and is the authoritative time used for OTIF measurement and freight audit.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the proof of delivery record',
    `recipient_name` STRING COMMENT 'Full name of the individual at the consignee location who physically received and signed for the goods. Required for legal proof of delivery and dispute resolution.',
    `recipient_signature_ref` STRING COMMENT 'The recipient signature ref of the proof of delivery record',
    `recipient_title` STRING COMMENT 'Job title or role of the individual who received the goods (e.g., Receiving Manager, Store Associate, Warehouse Clerk). Provides context for authorization level of the signatory.',
    `scheduled_delivery_date` DATE COMMENT 'The planned delivery date as agreed in the delivery order or carrier SLA. Used to calculate on-time performance against the OTIF (On Time In Full) KPI.',
    `signature_image_url` STRING COMMENT 'URL or file path reference to the stored digital image of the recipients signature. Used as legal evidence in freight disputes and customer claims. Stored in secure document repository.',
    `signature_timestamp` TIMESTAMP COMMENT 'The signature timestamp of the proof of delivery record',
    `signed_by` STRING COMMENT 'The signed by of the proof of delivery record',
    `source_system_code` STRING COMMENT 'The source system code of the proof of delivery record',
    `uom` STRING COMMENT 'The uom of the proof of delivery record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this POD record, such as status updates, discrepancy note additions, or signature capture. Supports audit trail and dispute resolution.',
    `vehicle_code` STRING COMMENT 'Identifier of the vehicle or transport unit used for the delivery (e.g., truck registration number, fleet asset ID). Used for route optimization analysis, cold-chain compliance, and carrier audit.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Formal POD record capturing evidence of successful goods receipt at the consignee. Captures delivery reference, recipient name and signature, timestamp of receipt, condition of goods at delivery (intact/damaged), photo attachment references, electronic signature flag, discrepancy notes, and POD source (DSD handheld, e-POD app, paper scan). Critical for dispute resolution, freight audit, and DSD compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique surrogate identifier for the freight order record in the lakehouse silver layer. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Outbound finished-goods freight planning: in consumer goods, a freight order for factory pickup must reference the specific batch/lot being collected for GMP compliance, cold-chain documentation, and ',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate agreement or contract under which this freight order is priced. Null for spot-tendered orders without a pre-negotiated contract.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, parcel carrier, or 3PL) assigned to execute this freight order. Links to the carrier master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns internal cost center to freight orders for budgeting and chargeback of transportation expenses.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Freight orders require GL account assignment for freight cost accruals posted before invoice receipt. In consumer goods, month-end accrual accounting requires freight orders to reference the GL accoun',
    `lane_id` BIGINT COMMENT 'The lane id of the freight order record',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Freight cost allocation by DC: consumer goods finance and logistics teams allocate freight spend to originating distribution facilities. freight_order.origin_location_code is denormalized text; a prop',
    `network_node_id` BIGINT COMMENT 'Reference to the delivery/destination location (retailer DC, customer warehouse, store, or end-consumer address) to which the freight order is directed.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight orders must be attributed to profit centers for logistics cost P&L reporting by brand or channel. freight_order already has cost_center_id but lacks profit_center_id. In consumer goods, freigh',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Freight order creation is driven by a sales order; linking enables transport planning and order‑to‑shipment reporting.',
    `trade_account_id` BIGINT COMMENT 'Reference to the internal business unit or facility acting as the shipper/consignor for this freight order.',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total accessorial charges (e.g., liftgate, detention, residential delivery, inside delivery, hazmat handling) applied to this freight order beyond the base rate and fuel surcharge.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost amount of the freight order record',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time the carrier completed delivery at the destination location. Core field for OTIF (On Time In Full) measurement, carrier scorecard, and proof-of-delivery reconciliation.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'The actual date and time the carrier picked up the freight at the origin location. Compared against the pickup window to determine on-time pickup performance for OTIF reporting.',
    `agreed_freight_rate` DECIMAL(18,2) COMMENT 'The negotiated or spot-quoted rate agreed with the carrier for executing this freight order, expressed in the transaction currency. Used for freight cost accrual, freight audit, and carrier rate benchmarking.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the freight order record',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading (BOL) number serving as the legal contract of carriage between the shipper and carrier. Required for freight claims, customs clearance, and proof-of-delivery documentation.',
    `carrier_invoice_number` STRING COMMENT 'Invoice number issued by the carrier for this freight order. Used for freight audit and payment matching in accounts payable. Populated upon receipt of carrier invoice.',
    `freight_order_code` STRING COMMENT 'The freight order code of the freight order record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight order record was first created in the source TMS system. Used for audit trail, data lineage, and SLA measurement from order creation to carrier acceptance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the agreed freight rate and all monetary amounts on this freight order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the agreed delivery time window at the destination location. Defines the latest acceptable delivery time per retailer or customer SLA.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start of the agreed delivery time window at the destination location. Defines the earliest acceptable delivery time per retailer or customer SLA.',
    `freight_order_description` STRING COMMENT 'The freight order description of the freight order record',
    `destination_location` STRING COMMENT 'The destination location of the freight order record',
    `destination_location_code` STRING COMMENT 'The destination location code of the freight order record',
    `direction` STRING COMMENT 'Indicates the direction of the freight movement relative to the companys network: inbound (from supplier to plant/DC), outbound (from plant/DC to customer/retailer), or interplant (between internal facilities).. Valid values are `inbound|outbound|interplant`',
    `effective_from` DATE COMMENT 'The effective from of the freight order record',
    `effective_until` DATE COMMENT 'The effective until of the freight order record',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this freight order (e.g., dry van, refrigerated/reefer, flatbed, tanker, intermodal container). Critical for cold-chain compliance for temperature-sensitive consumer goods. [ENUM-REF-CANDIDATE: dry_van|reefer|flatbed|tanker|intermodal|curtainsider|box_truck — promote to reference product]',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'The estimated cost amount of the freight order record',
    `freight_audit_status` STRING COMMENT 'Status of the freight invoice audit process for this freight order. Tracks whether the carrier invoice has been received, validated against the agreed rate, approved for payment, or disputed due to discrepancies.. Valid values are `pending|approved|disputed|paid|written_off`',
    `freight_order_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the freight order as issued by the Transportation Management System (TMS). Used in carrier communications, EDI transactions, and proof-of-delivery documents.. Valid values are `^FO-[0-9]{10}$`',
    `freight_order_status` STRING COMMENT 'The freight order status of the freight order record',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Fuel surcharge applied to this freight order by the carrier, expressed in the transaction currency. Fuel surcharges are typically indexed to DOE diesel fuel price indices and are a standard component of carrier invoicing.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including product, packaging, and pallet weight. Used for carrier rate calculation, weight-based freight billing, and regulatory compliance for road transport weight limits.',
    `incoterms` STRING COMMENT 'The incoterms of the freight order record',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the transfer of risk, cost responsibility, and delivery obligations between buyer and seller for this freight order. Governs freight cost ownership and insurance responsibility. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this freight order requires temperature-controlled cold-chain transportation (e.g., refrigerated or frozen consumer goods). Triggers reefer equipment assignment and temperature monitoring requirements.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this freight order contains hazardous materials (hazmat) requiring special handling, placarding, and regulatory documentation per DOT 49 CFR and IATA/IMDG regulations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight order record was last modified in the source TMS system. Used for incremental data loading, change detection, and audit trail in the lakehouse silver layer.',
    `load_type` STRING COMMENT 'Classification of the shipment load mode. FTL (Full Truckload) indicates the carriers entire trailer is dedicated to this shipment; LTL (Less-than-Truckload) indicates shared trailer space; parcel indicates small-package carrier service; intermodal indicates multi-modal container movement; rail indicates rail freight.. Valid values are `FTL|LTL|parcel|intermodal|rail`',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the freight order record',
    `freight_order_name` STRING COMMENT 'The freight order name of the freight order record',
    `notes` STRING COMMENT 'The notes of the freight order record',
    `order_status` STRING COMMENT 'Current lifecycle state of the freight order. Tracks progression from tendering to carrier through acceptance, in-transit movement, and final delivery or cancellation. [ENUM-REF-CANDIDATE: tendered|accepted|rejected|in_transit|delivered|cancelled — promote to reference product]. Valid values are `tendered|accepted|rejected|in_transit|delivered|cancelled`',
    `order_type` STRING COMMENT 'The order type of the freight order record',
    `pallet_count` STRING COMMENT 'Number of pallets included in this freight order. Used for dock scheduling, trailer space planning, and carrier rate calculation for pallet-based pricing agreements.',
    `pickup_window_end` TIMESTAMP COMMENT 'End of the agreed pickup time window at the origin location. Defines the latest time the carrier may arrive for loading without incurring a late pickup penalty.',
    `pickup_window_start` TIMESTAMP COMMENT 'Start of the agreed pickup time window at the origin location. Defines the earliest time the carrier may arrive for loading. Used for dock scheduling and carrier compliance measurement.',
    `pod_received` BOOLEAN COMMENT 'Indicates whether a signed Proof of Delivery (POD) document has been received and recorded for this freight order. Required for freight payment release, dispute resolution, and retailer compliance.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time the Proof of Delivery (POD) was received and confirmed. Used for delivery confirmation, OTIF (On Time In Full) final measurement, and freight payment processing.',
    `priority_level` STRING COMMENT 'The priority level of the freight order record',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used as the primary tracking identifier for LTL (Less-than-Truckload) shipments. Issued by the carrier upon freight pickup and used for track-and-trace and freight claims.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the freight order record',
    `requested_delivery_date` DATE COMMENT 'The date on which the shipper requests delivery at the destination location. Core input for OTIF (On Time In Full) performance measurement and retailer compliance scoring.',
    `requested_pickup_date` DATE COMMENT 'The date on which the shipper requests the carrier to pick up the freight at the origin location. Used for OTIF (On Time In Full) measurement and carrier performance tracking.',
    `service_level` STRING COMMENT 'Contracted service level for this freight order defining the expected transit time commitment (e.g., standard ground, expedited 2-day, overnight, same-day). Drives carrier selection and freight cost.. Valid values are `standard|expedited|overnight|same_day|economy`',
    `shipment_reference_number` STRING COMMENT 'External reference number used by the carrier or 3PL to identify this shipment in their system. Enables cross-system track-and-trace and carrier invoice reconciliation via EDI (Electronic Data Interchange).',
    `source_system_code` STRING COMMENT 'The source system code of the freight order record',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain shipments. Applicable when is_cold_chain is True. Exceedance triggers a quality hold and potential product rejection per GMP (Good Manufacturing Practice) standards.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain shipments. Applicable when is_cold_chain is True. Used for carrier compliance verification and cold-chain excursion detection.',
    `tender_date` TIMESTAMP COMMENT 'The tender date of the freight order record',
    `tender_status` STRING COMMENT 'The tender status of the freight order record',
    `tendering_method` STRING COMMENT 'Method used to tender the freight order to a carrier. Contract indicates a pre-negotiated rate agreement; spot indicates a one-time market rate; load_board indicates posting to a freight exchange; dedicated indicates a committed fleet arrangement; auction indicates a competitive bidding process.. Valid values are `spot|contract|load_board|dedicated|auction`',
    `tms_source_system` STRING COMMENT 'Identifies the source Transportation Management System (TMS) from which this freight order record was ingested into the lakehouse. Supports data lineage, reconciliation, and multi-system integration auditing.. Valid values are `SAP_TM|Blue_Yonder_TMS|Oracle_TMS|manual`',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the freight order record',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total cost of this freight order including base rate, fuel surcharge, and all accessorial charges. Used for COGS (Cost of Goods Sold) allocation, freight budget vs. actuals reporting, and carrier invoice audit.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'The total volume m3 of the freight order record',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total weight kg of the freight order record',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this freight order. Drives regulatory requirements, transit time expectations, and carbon emissions calculation for sustainability reporting.. Valid values are `road|rail|ocean|air|intermodal`',
    `uom` STRING COMMENT 'The uom of the freight order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the freight order record',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic meters. Used for LTL (Less-than-Truckload) dimensional weight calculation, trailer utilization analysis, and freight cost optimization.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Transportation planning and tendering record issued to a carrier for a specific shipment movement. Captures freight order number, tendering method (spot/contract/load board), carrier assignment, load type (FTL/LTL/parcel), pickup and delivery locations, requested pickup window, freight order status (tendered/accepted/rejected/in-transit/delivered), agreed rate, and equipment type required. Sourced from SAP TM / Blue Yonder TMS.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the freight invoice record in the Consumer Goods lakehouse silver layer. Primary key for this entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Freight invoices from carriers are processed through Accounts Payable. In consumer goods, freight audit and payment reconciliation requires linking the carriers freight invoice to the corresponding A',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate contract against which this invoice is audited. Used in freight audit and pay (FAP) to validate invoiced charges against contracted rates.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (transportation service provider) who issued this freight invoice. Links to the carrier master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed to allocate freight invoice expense to the appropriate cost center for internal cost tracking and budgeting.',
    `freight_order_id` BIGINT COMMENT 'The freight order id of the freight invoice record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting freight invoices to the general ledger; finance GL accounts are used for financial reporting of freight costs.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Freight invoice posting generates a journal entry for freight cost accounting. In consumer goods, the GL posting of freight costs must be traceable to the originating freight invoice for audit complia',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this freight invoice. Enables reconciliation between transportation execution and billing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Allows assignment of freight invoice expense to profit center for profitability analysis of logistics services.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight invoice 3-way match process: AP teams reconcile freight invoices against the originating PO for inbound freight cost allocation and accrual. Consumer goods finance requires PO-level freight co',
    `accessorial_amount` DECIMAL(18,2) COMMENT 'Total amount of accessorial charges on the invoice, including but not limited to liftgate, residential delivery, inside delivery, detention, redelivery, and hazmat fees. Audited against contracted accessorial schedules.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the freight invoice record',
    `approved_amount` DECIMAL(18,2) COMMENT 'Amount approved for payment to the carrier after freight audit review and any adjustments. May differ from invoiced total if disputes or corrections were applied. This is the amount that flows to accounts payable for payment.',
    `audit_completed_timestamp` TIMESTAMP COMMENT 'Date and time the freight audit review was completed for this invoice. Marks the transition from under_audit to approved or disputed status in the freight audit and pay (FAP) workflow.',
    `audit_status` STRING COMMENT 'The audit status of the freight invoice record',
    `base_freight_amount` DECIMAL(18,2) COMMENT 'The base freight amount of the freight invoice record',
    `bol_number` STRING COMMENT 'Bill of Lading number issued by the carrier for the associated shipment. Key cross-reference document linking the freight invoice to the physical shipment and proof of delivery.',
    `freight_invoice_code` STRING COMMENT 'The freight invoice code of the freight invoice record',
    `contracted_amount` DECIMAL(18,2) COMMENT 'Expected freight charge calculated from the applicable carrier contract rate for this lane, mode, and service level. Used as the benchmark in freight audit to identify billing variances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight invoice record was first created in the Consumer Goods data platform. Supports audit trail, data lineage, and SLA tracking for invoice processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this freight invoice (e.g., USD, EUR, GBP). Required for multi-currency freight operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `freight_invoice_description` STRING COMMENT 'The freight invoice description of the freight invoice record',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment destination. Required for cross-border freight, customs compliance, and international freight cost reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the shipment destination facility (customer DC, retail store, or consumer address) to which the freight was delivered. Used for lane-level freight cost analysis.',
    `dispute_flag` BOOLEAN COMMENT 'The dispute flag of the freight invoice record',
    `dispute_notes` STRING COMMENT 'Free-text notes describing the reason for disputing the freight invoice, including specific discrepancies identified during freight audit. Supports carrier communication and dispute resolution.',
    `dispute_reason_code` STRING COMMENT 'Standardized code indicating the reason for disputing the freight invoice (e.g., rate discrepancy, duplicate invoice, service failure, unauthorized accessorial). Populated when invoice_status is disputed. [ENUM-REF-CANDIDATE: rate_discrepancy|duplicate_invoice|service_failure|unauthorized_accessorial|weight_discrepancy|missing_bol — promote to reference product]',
    `due_date` DATE COMMENT 'The due date of the freight invoice record',
    `edi_transaction_code` STRING COMMENT 'EDI (Electronic Data Interchange) transaction set identifier for invoices received electronically via EDI 210 (Motor Carrier Freight Invoice) or equivalent. Enables traceability of electronic invoice transmission.',
    `effective_from` DATE COMMENT 'The effective from of the freight invoice record',
    `effective_until` DATE COMMENT 'The effective until of the freight invoice record',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) freight class assigned to the shipment (e.g., 50, 70, 100, 150). Determines LTL (Less-Than-Truckload) base rates and is a key audit point for freight invoice validation.',
    `freight_invoice_status` STRING COMMENT 'The freight invoice status of the freight invoice record',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Carrier-applied fuel surcharge amount added to the base line-haul charge. Typically calculated as a percentage of line-haul based on the DOE (Department of Energy) fuel index. Key component for freight cost variance analysis.',
    `invoice_currency_code` STRING COMMENT 'The invoice currency code of the freight invoice record',
    `invoice_date` DATE COMMENT 'Date the carrier issued the freight invoice. Used to calculate payment due date, aging, and Days Sales Outstanding (DSO) metrics in freight payables.',
    `invoice_number` STRING COMMENT 'Carrier-assigned invoice number as printed on the freight invoice document. Externally known identifier used for carrier communication, dispute resolution, and payment remittance.',
    `invoice_source` STRING COMMENT 'Channel through which the freight invoice was received by Consumer Goods. Used to track EDI adoption rates and identify manual processing inefficiencies.. Valid values are `edi|carrier_portal|email|paper|api`',
    `invoice_status` STRING COMMENT 'Current workflow status of the freight invoice within the freight audit and pay (FAP) process. Drives processing actions and reporting.. Valid values are `received|under_audit|approved|disputed|paid|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the freight invoice by document type. Distinguishes standard carrier invoices from credit memos, debit memos, rebills, and adjustments for accurate financial processing.. Valid values are `standard|credit_memo|debit_memo|rebill|adjustment`',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'The invoiced amount of the freight invoice record',
    `invoiced_total_amount` DECIMAL(18,2) COMMENT 'Total gross amount invoiced by the carrier, inclusive of line-haul, fuel surcharge, accessorials, and taxes. This is the amount the carrier is requesting for payment before audit adjustments.',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this freight invoice covers a temperature-controlled (cold chain) shipment requiring refrigerated or frozen transport. Relevant for Consumer Goods products with cold-chain compliance requirements.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether the shipment covered by this invoice contains hazardous materials requiring special handling, labeling, and regulatory compliance. Triggers validation of hazmat accessorial charges.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the freight invoice record',
    `line_haul_amount` DECIMAL(18,2) COMMENT 'Base transportation charge for moving freight from origin to destination, excluding surcharges and accessorials. Core component of the freight invoice monetary triplet.',
    `freight_invoice_name` STRING COMMENT 'The freight invoice name of the freight invoice record',
    `notes` STRING COMMENT 'The notes of the freight invoice record',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment origin. Required for cross-border freight, customs compliance, and international freight cost reporting.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'Code identifying the shipment origin facility (plant, warehouse, or distribution center) from which the freight movement originated. Used for lane-level freight cost analysis and carrier performance reporting.',
    `paid_date` DATE COMMENT 'Date the payment was issued to the carrier for this freight invoice. Used to calculate Days Sales Outstanding (DSO), confirm on-time payment, and support carrier relationship management.',
    `payment_date` DATE COMMENT 'The payment date of the freight invoice record',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the carrier per the contracted payment terms. Critical for cash flow management and avoiding late payment penalties.',
    `payment_reference` STRING COMMENT 'Internal payment document or check/ACH reference number assigned when the invoice was paid. Used to reconcile freight invoices against bank statements and carrier remittance advice.',
    `payment_status` STRING COMMENT 'The payment status of the freight invoice record',
    `payment_terms` STRING COMMENT 'The payment terms of the freight invoice record',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the carrier (e.g., Net30, Net45, 2/10Net30). Determines the payment due date and any early payment discount eligibility.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used to track the shipment within the carriers system. Standard identifier in LTL and TL freight for track-and-trace and invoice matching.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the freight invoice record',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time the freight invoice was received by Consumer Goods from the carrier, either via EDI (Electronic Data Interchange), email, or carrier portal. Marks the start of the freight audit and pay (FAP) cycle.',
    `service_date` DATE COMMENT 'Date the transportation service was rendered (pickup or delivery date). Used to match the invoice to the correct accounting period and validate service delivery.',
    `service_level` STRING COMMENT 'Carrier service level or product code for the transportation service rendered (e.g., standard ground, expedited, next-day, two-day). Used to validate that the invoiced service matches the contracted service level agreement (SLA).',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'Actual or billed shipment weight in kilograms as stated on the freight invoice. Used to validate weight-based freight charges against contracted rates and detect weight discrepancies.',
    `source_system_code` STRING COMMENT 'The source system code of the freight invoice record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the freight invoice, including applicable federal, state, and local taxes on transportation services. Required for accurate financial reporting and tax compliance.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the freight invoice record',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment covered by this invoice. [ENUM-REF-CANDIDATE: TL|LTL|parcel|intermodal|air|ocean|rail — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the freight invoice record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight invoice record was last modified in the Consumer Goods data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between the invoiced total amount and the contracted rate amount (invoiced_total_amount minus contracted_amount). Positive value indicates overbilling by carrier; negative indicates underbilling. Central metric in the freight audit and pay (FAP) process.',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Carrier-issued freight invoice submitted to Consumer Goods for transportation services rendered. Captures invoice number, carrier reference, invoice date, payment due date, shipment/BOL references, invoiced charges (line-haul, fuel surcharge, accessorials), currency, invoice status (received/under-audit/approved/disputed/paid), and variance amount vs. contracted rate. Central to freight audit and pay (FAP) process.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` (
    `carrier_performance_id` BIGINT COMMENT 'Unique surrogate identifier for each carrier performance scorecard record in the Silver Layer lakehouse.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: A carrier performance scorecard is measured against the terms of a specific carrier contract — the contract defines OTIF thresholds (otif_threshold_pct), penalty rates (otif_penalty_rate), and service',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier master record for which this performance scorecard is being measured.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Facility-level carrier scorecarding: in consumer goods, carrier OTIF and damage rates vary significantly by originating DC. Logistics and DC managers require carrier performance scorecards scoped to s',
    `lane_id` BIGINT COMMENT 'The lane id of the carrier performance record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the carrier performance record',
    `average_cost_per_shipment` DECIMAL(18,2) COMMENT 'The average cost per shipment of the carrier performance record',
    `avg_transit_days` DECIMAL(18,2) COMMENT 'Average number of calendar days from actual pickup to actual delivery across all shipments in the measurement period. Compared against standard transit days to assess transit time performance.',
    `carrier_contact_name` STRING COMMENT 'Name of the carriers primary account representative or performance manager who receives and acknowledges this scorecard.',
    `carrier_performance_status` STRING COMMENT 'The carrier performance status of the carrier performance record',
    `claim_count` STRING COMMENT 'The claim count of the carrier performance record',
    `claim_rate_pct` DECIMAL(18,2) COMMENT 'The claim rate pct of the carrier performance record',
    `claims_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total_claims_amount field (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `claims_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments resulting in a freight claim (loss, damage, or shortage) during the measurement period. Key indicator of cargo handling quality.',
    `carrier_performance_code` STRING COMMENT 'The carrier performance code of the carrier performance record',
    `composite_score` DECIMAL(18,2) COMMENT 'Weighted composite score (0–100) summarizing the carriers overall performance across all measured KPIs for the period. Drives performance tier assignment and contract renewal decisions.',
    `cost_per_shipment` DECIMAL(18,2) COMMENT 'The cost per shipment of the carrier performance record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier performance scorecard record was first created in the Silver Layer lakehouse. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the carrier performance record',
    `damage_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments with reported product damage upon delivery during the measurement period. Distinct from claims rate as it isolates physical damage from loss/shortage events.',
    `data_source_system` STRING COMMENT 'Operational system of record from which the KPI data for this scorecard was sourced (e.g., SAP TM, Blue Yonder WMS, TradeEdge). Supports data lineage and audit traceability in the Silver Layer.. Valid values are `SAP_TM|Blue_Yonder|TradeEdge|Oracle_TMS|manual`',
    `carrier_performance_description` STRING COMMENT 'The carrier performance description of the carrier performance record',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the carrier has formally disputed the KPI results in this scorecard. True = dispute raised; False = no dispute. Triggers a review workflow when True.',
    `dispute_reason` STRING COMMENT 'Free-text description of the carriers stated reason for disputing the scorecard results. Populated only when dispute_flag is True.',
    `edi_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments for which the carrier transmitted all required EDI transaction sets (e.g., 214 shipment status, 210 freight invoice) accurately and on time during the measurement period.',
    `effective_from` DATE COMMENT 'The effective from of the carrier performance record',
    `effective_until` DATE COMMENT 'The effective until of the carrier performance record',
    `evaluation_period_end` DATE COMMENT 'The evaluation period end of the carrier performance record',
    `evaluation_period_start` DATE COMMENT 'The evaluation period start of the carrier performance record',
    `freight_spend_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total_freight_spend field (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `improvement_plan_flag` BOOLEAN COMMENT 'Indicates whether a formal Carrier Improvement Plan (CIP) is active for this carrier as of this measurement period. True = improvement plan in effect; False = no active plan.',
    `in_full_delivery_pct` DECIMAL(18,2) COMMENT 'The in full delivery pct of the carrier performance record',
    `in_full_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments delivered with the complete ordered quantity, without short-shipment or partial delivery, during the measurement period.',
    `invoice_accuracy_pct` DECIMAL(18,2) COMMENT 'The invoice accuracy pct of the carrier performance record',
    `invoice_accuracy_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of carrier freight invoices that matched the contracted rate without requiring correction or dispute during the measurement period. Supports freight audit and pay processes.',
    `measurement_period` STRING COMMENT 'The measurement period of the carrier performance record',
    `measurement_period_type` STRING COMMENT 'Granularity of the performance measurement window — weekly, monthly, quarterly, or annual. Determines the cadence at which KPIs are aggregated and reviewed.. Valid values are `weekly|monthly|quarterly|annual`',
    `carrier_performance_name` STRING COMMENT 'The carrier performance name of the carrier performance record',
    `network_region` STRING COMMENT 'Geographic network region covered by this scorecard (e.g., Northeast US, Western Europe, APAC). Enables regional performance benchmarking across the carrier network.',
    `notes` STRING COMMENT 'The notes of the carrier performance record',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'The on time delivery pct of the carrier performance record',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments delivered to the destination within the committed delivery window during the measurement period. Distinct from OTIF as it excludes the in-full dimension.',
    `on_time_pickup_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments where the carrier arrived at the origin facility within the scheduled pickup window during the measurement period.',
    `otif_pct` DECIMAL(18,2) COMMENT 'The otif pct of the carrier performance record',
    `otif_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments delivered both on time and in full during the measurement period. Core OTIF KPI used in carrier scorecards and contract compliance reviews. Calculated as (OTIF shipments / total shipments) × 100.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Contracted OTIF target percentage for this carrier and service level during the measurement period. Used to calculate variance against actual OTIF performance.',
    `performance_score` DECIMAL(18,2) COMMENT 'The performance score of the carrier performance record',
    `performance_tier` STRING COMMENT 'Overall performance classification assigned to the carrier for this measurement period based on composite KPI scoring. Preferred = top-tier; Approved = meets standards; Probation = below threshold with improvement plan; Suspended = removed from routing guide pending review.. Valid values are `preferred|approved|probation|suspended`',
    `period_end_date` DATE COMMENT 'Last calendar date of the measurement period covered by this scorecard record.',
    `period_start_date` DATE COMMENT 'First calendar date of the measurement period covered by this scorecard record.',
    `period_type` STRING COMMENT 'The period type of the carrier performance record',
    `pod_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments for which a valid Proof of Delivery (POD) document was received within the contractually required timeframe during the measurement period.',
    `prior_period_composite_score` DECIMAL(18,2) COMMENT 'Composite performance score from the immediately preceding measurement period. Enables trend analysis and period-over-period performance comparison without requiring a self-join.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the carrier performance record',
    `scorecard_finalized_date` DATE COMMENT 'Calendar date on which the scorecard was locked as final after the dispute resolution window closed. Null if scorecard is not yet finalized.',
    `scorecard_notes` STRING COMMENT 'Free-text field for logistics team commentary on the scorecard, including context for performance anomalies, weather events, or force majeure conditions that impacted KPIs.',
    `scorecard_number` STRING COMMENT 'Externally-known business identifier for this scorecard record, used in carrier communications and contract review meetings. Format: CPSC-YYYY-MM-XXXXXX.. Valid values are `^CPSC-[0-9]{4}-[0-9]{2}-[A-Z0-9]{6}$`',
    `scorecard_published_date` DATE COMMENT 'Calendar date on which the scorecard was formally published and shared with the carrier for review. Marks the start of the carriers dispute window.',
    `scorecard_rating` STRING COMMENT 'The scorecard rating of the carrier performance record',
    `scorecard_reference` STRING COMMENT 'The scorecard reference of the carrier performance record',
    `scorecard_status` STRING COMMENT 'Current lifecycle state of the scorecard record. Draft = under calculation; Published = shared with carrier; Disputed = carrier has raised a challenge; Finalized = agreed and locked; Archived = historical.. Valid values are `draft|published|disputed|finalized|archived`',
    `service_level` STRING COMMENT 'Service tier under which the carrier operated during this measurement period, enabling performance comparison within the same contracted service commitment.. Valid values are `standard|expedited|same_day|next_day|deferred`',
    `source_system_code` STRING COMMENT 'The source system code of the carrier performance record',
    `tender_acceptance_pct` DECIMAL(18,2) COMMENT 'The tender acceptance pct of the carrier performance record',
    `tender_acceptance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of load tenders accepted by the carrier on first offer during the measurement period. Low acceptance rates indicate capacity reliability issues and routing guide compliance failures.',
    `tender_acceptance_target_pct` DECIMAL(18,2) COMMENT 'Contracted minimum tender acceptance rate for this carrier during the measurement period. Compared against actual tender acceptance rate to assess routing guide compliance.',
    `total_claims_amount` DECIMAL(18,2) COMMENT 'Total monetary value of freight claims filed against the carrier during the measurement period, expressed in the reporting currency. Used for financial recovery tracking and carrier liability assessment.',
    `total_freight_spend` DECIMAL(18,2) COMMENT 'Total freight cost paid to the carrier during the measurement period, including base freight, fuel surcharges, and accessorial charges. Used for spend analytics and contract benchmarking.',
    `total_shipments` STRING COMMENT 'Total number of shipments tendered to the carrier during the measurement period. Serves as the denominator for rate-based KPI calculations.',
    `total_tenders` STRING COMMENT 'Total number of load tenders issued to the carrier during the measurement period, including both accepted and rejected tenders.',
    `transport_mode` STRING COMMENT 'Mode of transportation for which this scorecard applies. Allows segmented performance analysis by mode (e.g., Truckload vs. Less-than-Truckload vs. Parcel). [ENUM-REF-CANDIDATE: TL|LTL|parcel|intermodal|ocean|air|rail — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the carrier performance record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this carrier performance scorecard record. Used for incremental load detection and change data capture in the lakehouse pipeline.',
    CONSTRAINT pk_carrier_performance PRIMARY KEY(`carrier_performance_id`)
) COMMENT 'Periodic carrier performance scorecard record capturing measured KPIs for a carrier over a defined period. Captures carrier reference, measurement period (week/month/quarter), OTIF rate, on-time pickup rate, on-time delivery rate, tender acceptance rate, claims rate, damage rate, EDI compliance rate, and overall performance tier (preferred/approved/probation/suspended). Supports carrier relationship management and contract renewal decisions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_primary_lane_backup_carrier_id` FOREIGN KEY (`primary_lane_backup_carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `api_tracking_capable` SET TAGS ('dbx_business_glossary_term' = 'API Tracking Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carbon_intensity_g_per_tkm` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity G Per Tkm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blacklisted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `co2_emission_rating` SET TAGS ('dbx_business_glossary_term' = 'Co2 Emission Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Registration');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `edi_code` SET TAGS ('dbx_business_glossary_term' = 'EDI Interchange ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Interchange Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `fmcsa_rating_date` SET TAGS ('dbx_business_glossary_term' = 'FMCSA Safety Rating Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `fmcsa_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Safety Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `fmcsa_safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Carrier Geographic Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `hazmat_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'HAZMAT Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Carrier Headquarters Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cargo Insurance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Liability Insurance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `is_cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Is Cold Chain Capable');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `is_hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Hazmat Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `is_preferred_carrier` SET TAGS ('dbx_business_glossary_term' = 'Is Preferred Carrier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `liability_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Coverage Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `max_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Capacity (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^MC-[0-9]{1,7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `on_time_delivery_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Onboarding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|immediate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `preferred_carrier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `region_coverage` SET TAGS ('dbx_business_glossary_term' = 'Region Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `service_area_countries` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Area Countries');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `service_level_offered` SET TAGS ('dbx_business_glossary_term' = 'Service Level Offered');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|deferred|white_glove');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking URL Template');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Trade Name (DBA)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `accessorial_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Schedule Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `accessorial_terms` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Contract Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Base Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Freight Billing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_shipment|weekly|bi_weekly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Required');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'spot|committed|preferred|dedicated|intermodal|3pl_master');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Contract Destination Region / Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `detention_free_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Detention Free Time (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_value_regex' = 'percentage_of_base|flat_per_mile|flat_per_shipment|doe_index_linked');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Coverage Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `liability_limit_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Carrier Liability Limit per Kilogram');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `liability_limit_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Break (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `min_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight Break (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Contract Origin Region / Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `otif_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Penalty Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `otif_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `otif_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|immediate|2_10_net_30');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `pickup_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Pickup Lead Time (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|two_day|deferred|white_glove');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `track_trace_method` SET TAGS ('dbx_business_glossary_term' = 'Track and Trace Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `track_trace_method` SET TAGS ('dbx_value_regex' = 'edi_214|api|portal|email|none');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Contracted Transit Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_units` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Units');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_value_regex' = 'shipments|pallets|cwt|revenue_miles|kg|loads');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `primary_lane_backup_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `primary_lane_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `annual_volume_loads` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume (Loads)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `annual_volume_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `avg_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Avg Transit Time Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Flat Lane Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_per_km` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Freight Rate per Kilometer');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_per_km` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `carbon_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor (kg CO2e per km)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Lane Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'inbound|outbound|inter_facility|last_mile|reverse');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `co2_per_shipment_kg` SET TAGS ('dbx_business_glossary_term' = 'Co2 Per Shipment Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Lane Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `customs_trade_zone` SET TAGS ('dbx_business_glossary_term' = 'Customs Trade Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_description` SET TAGS ('dbx_business_glossary_term' = 'Lane Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Lane Distance (Kilometers)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `dsd_eligible` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lane Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lane Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `hazmat_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Handling Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `network_region` SET TAGS ('dbx_business_glossary_term' = 'Network Region');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_city` SET TAGS ('dbx_business_glossary_term' = 'Origin City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_business_glossary_term' = 'Origin State or Province Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `preferred_mode` SET TAGS ('dbx_business_glossary_term' = 'Preferred Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `routing_guide_rank` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|economy|dedicated|spot');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|BLUE_YONDER|ORACLE_TMS|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `standard_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `primary_logistics_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_code` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Ocean Container Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_description` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|interplant|return');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Is Cold Chain');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazmat');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_name` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_business_glossary_term' = 'Origin Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `otif_in_full` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) - In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `otif_on_time` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) - On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `planned_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Pickup Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `pod_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,25}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|economy');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `three_pl_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `three_pl_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,40}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_cases` SET TAGS ('dbx_business_glossary_term' = 'Total Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_pieces` SET TAGS ('dbx_business_glossary_term' = 'Total Pieces');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cbm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,35}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'TL|LTL|parcel|ocean|air|rail');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `primary_shipment_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_arrival` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_departure` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Transit Time (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carbon_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions (kg CO₂e)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_pro_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `customs_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_description` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|paid|written_off');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Leg Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `is_transshipment_point` SET TAGS ('dbx_business_glossary_term' = 'Transshipment Point Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Leg Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Leg Distance (km)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_sequence` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|arrived|completed|cancelled|delayed');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_business_glossary_term' = 'Leg Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_name` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `planned_arrival` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `planned_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `planned_departure` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `planned_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Transit Time (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|received|rejected|disputed');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|intermodal|courier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_service_type` SET TAGS ('dbx_business_glossary_term' = 'Transport Service Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_service_type` SET TAGS ('dbx_value_regex' = 'full_truckload|less_than_truckload|parcel|express|standard|bulk');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle / Conveyance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume (CBM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `dtc_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_description` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `is_dsd` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `is_temperature_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Temperature Sensitive Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Value');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_name` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|display|pallet|bulk');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Item Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sales_order_line` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Product Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cbm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_subdomain' = 'freight_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Final Shipment Leg Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Recorded Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'full|partial|failed|refused|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'DSD|warehouse|cross_dock|drop_ship|returns');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `first_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Delivery Attempt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `goods_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Goods Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `goods_condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|partial_damage|temperature_breach|contaminated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Delivery Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `is_complete` SET TAGS ('dbx_business_glossary_term' = 'Is Complete');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `is_in_full` SET TAGS ('dbx_business_glossary_term' = 'Is In Full');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `is_on_time` SET TAGS ('dbx_business_glossary_term' = 'Is On Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `photo_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'DSD_handheld|epod_app|paper_scan|EDI|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `refused_quantity` SET TAGS ('dbx_business_glossary_term' = 'Refused Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `rejection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejection Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^d{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Window End');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Window Start');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'freight_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `captured_by` SET TAGS ('dbx_business_glossary_term' = 'Captured By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `captured_device` SET TAGS ('dbx_business_glossary_term' = 'Captured Device');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `carrier_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Scan Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_code` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `damage_noted` SET TAGS ('dbx_business_glossary_term' = 'Damage Noted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `damage_notes` SET TAGS ('dbx_business_glossary_term' = 'Damage Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `damage_reported` SET TAGS ('dbx_business_glossary_term' = 'Damage Reported');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_gln` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|partially_delivered|failed|disputed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_description` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|open|under_review|resolved|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `dsd_route_stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Stop Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `freight_bill_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Bill Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geofence_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Geofence Validation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geofence_validated_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geofence_validated_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Geolocation Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Geolocation Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `goods_condition` SET TAGS ('dbx_business_glossary_term' = 'Goods Condition at Delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `goods_condition` SET TAGS ('dbx_value_regex' = 'intact|damaged|partial_damage|refused|short_delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_name` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `photo_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `photo_attachment_urls` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment URLs');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'POD Confirmation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_confirmation_method` SET TAGS ('dbx_value_regex' = 'signature|pin_code|photo_only|verbal_confirmation|unattended');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Pod Image Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_value_regex' = '^POD-[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_reference` SET TAGS ('dbx_business_glossary_term' = 'Pod Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'dsd_handheld|epod_app|paper_scan|edi|carrier_portal');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_status` SET TAGS ('dbx_business_glossary_term' = 'Pod Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_type` SET TAGS ('dbx_business_glossary_term' = 'Pod Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_signature_ref` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signature Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_title` SET TAGS ('dbx_business_glossary_term' = 'Recipient Job Title');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image URL');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `actual_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `agreed_freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Freight Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `agreed_freight_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Freight Direction');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|interplant');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|paid|written_off');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_value_regex' = '^FO-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FTL|LTL|parcel|intermodal|rail');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'tendered|accepted|rejected|in_transit|delivered|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_end` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_start` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pod_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `requested_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Pickup Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|economy');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tender_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tender_status` SET TAGS ('dbx_business_glossary_term' = 'Tender Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tendering_method` SET TAGS ('dbx_business_glossary_term' = 'Tendering Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tendering_method` SET TAGS ('dbx_value_regex' = 'spot|contract|load_board|dedicated|auction');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tms_source_system` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `tms_source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|Blue_Yonder_TMS|Oracle_TMS|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume M3');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|ocean|air|intermodal');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'freight_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Payment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `audit_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `base_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `edi_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_source` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_source` SET TAGS ('dbx_value_regex' = 'edi|carrier_portal|email|paper|api');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'received|under_audit|approved|disputed|paid|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|rebill|adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Shipment Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `line_haul_amount` SET TAGS ('dbx_business_glossary_term' = 'Line-Haul Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `line_haul_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `average_cost_per_shipment` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `avg_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `claim_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `claim_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Claim Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `claims_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claims Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `claims_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `claims_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Freight Claims Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Performance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `cost_per_shipment` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `damage_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Cargo Damage Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|Blue_Yonder|TradeEdge|Oracle_TMS|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `edi_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Compliance Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `freight_spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Spend Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `freight_spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Improvement Plan Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `in_full_delivery_pct` SET TAGS ('dbx_business_glossary_term' = 'In Full Delivery Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `in_full_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'In-Full Delivery Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `invoice_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `invoice_accuracy_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Accuracy Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `network_region` SET TAGS ('dbx_business_glossary_term' = 'Network Region');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `on_time_delivery_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `on_time_pickup_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Pickup Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `otif_pct` SET TAGS ('dbx_business_glossary_term' = 'Otif Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `otif_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|probation|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `pod_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Compliance Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `prior_period_composite_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Composite Performance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_finalized_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Finalized Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_notes` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Scorecard Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^CPSC-[0-9]{4}-[0-9]{2}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_published_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Published Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_reference` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|disputed|finalized|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|same_day|next_day|deferred');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `tender_acceptance_pct` SET TAGS ('dbx_business_glossary_term' = 'Tender Acceptance Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `tender_acceptance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Tender Acceptance Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `tender_acceptance_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Tender Acceptance Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Claims Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_claims_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_freight_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_freight_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_shipments` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `total_tenders` SET TAGS ('dbx_business_glossary_term' = 'Total Tenders');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
