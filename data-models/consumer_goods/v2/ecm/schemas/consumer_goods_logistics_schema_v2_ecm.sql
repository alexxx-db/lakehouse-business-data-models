-- Schema for Domain: logistics | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`logistics` COMMENT 'Owns transportation management, freight optimization, and delivery execution across inbound and outbound networks. Manages carrier contracts, shipment planning, route optimization, freight audit, track-and-trace, 3PL coordination, proof of delivery, cold-chain compliance, and transportation cost tracking. Distinct from distribution (warehouse-focused) — logistics covers inter-facility and last-mile movement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique surrogate identifier for the transportation carrier record in the Consumer Goods logistics master data. Primary key for all carrier-related references across shipments, freight orders, contracts, and invoices.',
    `supplier_id` BIGINT COMMENT 'Reference to the corresponding vendor/supplier master record in the ERP system (SAP S/4HANA or Oracle Cloud ERP) for this carrier. Links the carrier master to the procurement and accounts payable vendor record for freight invoice processing and payment.',
    `third_party_provider_id` BIGINT COMMENT 'The third party provider id of the carrier record',
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
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the logistics or procurement team member responsible for managing and maintaining this carrier contract. Used for contract governance, renewal notifications, and escalation routing.',
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
    `region_id` BIGINT COMMENT 'The destination region id of the lane record',
    `carrier_id` BIGINT COMMENT 'The lane operating carrier id of the lane record',
    `origin_region_id` BIGINT COMMENT 'The origin region id of the lane record',
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
    `consolidation_id` BIGINT COMMENT 'Identifier linking this shipment to a consolidation group (e.g., a multi-stop truckload or ocean container consolidation). Enables freight cost allocation across consolidated shipments and container-level tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the facility (distribution center, retail store, customer location, or 3PL node) to which the shipment is consigned.',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order or transportation order that authorized and planned this shipment movement.',
    `lane_id` BIGINT COMMENT 'Reference to the contracted transportation lane (origin-destination pair) governing rate, transit time, and carrier assignment for this shipment.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Traceability: link each shipment to its originating manufacturing facility for cost allocation and regulatory reporting.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Enables brand‑level logistics KPI aggregation (OTIF, cost) by associating every shipment with the owning brand of the shipped SKU.',
    `origin_distribution_facility_id` BIGINT COMMENT 'The origin distribution facility id of the logistics shipment record',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Shipment origin account is needed for cost attribution, SLA reporting, and regulatory shipment origin documentation.',
    `primary_logistics_distribution_facility_id` BIGINT COMMENT 'Reference to the facility (plant, distribution center, warehouse, or supplier location) from which the shipment departs.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Order fulfillment: associate shipments with the production order that generated the goods for fulfillment and performance reporting.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Required for Promotion Execution Report linking shipments to promotion events for spend attribution and compliance.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Required for R&D Sample Shipment Tracking report linking each shipment to its originating RD project for status, cost allocation, and regulatory compliance.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Required for shipment compliance verification: each shipment must reference the products regulatory registration to confirm valid registration at shipping time.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Shipment tracking must reference the originating sales order for fulfillment status and revenue reconciliation.',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Required for OTIF reporting: links each logistics shipment to its originating distribution shipment for status tracking.',
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
    `employee_id` BIGINT COMMENT 'Carrier-assigned identifier for the driver or operator responsible for this leg. Used for compliance tracking, proof of delivery validation, and carrier SLA management. Not a personal identifier in the consumer goods context.',
    `lane_id` BIGINT COMMENT 'The lane id of the shipment leg record',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record to which this leg belongs. Enables grouping of all legs within a multi-leg intermodal shipment for end-to-end track-and-trace.',
    `shipment_network_node_id` BIGINT COMMENT 'Reference to the logistics node (warehouse, plant, port, cross-dock, or distribution center) from which this leg departs. Used for route optimization and network analysis.',
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
    `origin_location` STRING COMMENT 'The origin location of the shipment leg record',
    `origin_location_code` STRING COMMENT 'The origin location code of the shipment leg record',
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
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which this item was picked and dispatched. Used for inventory depletion tracking, warehouse performance analytics, and DRP (Distribution Requirements Planning).',
    `event_sku_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event_sku. Business justification: Needed for Promotional SKU shipment reconciliation to calculate allocated vs actual promotional volume per shipment.',
    `handling_unit_id` BIGINT COMMENT 'Identifier for the physical handling unit (pallet, carton, tote) in which this item is packed for shipment. Used for load planning, dock management, and proof of delivery reconciliation in the WMS.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Required for lot traceability report linking inspected lots to shipped items, enabling recall and compliance verification.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment header record. Establishes the header-to-line relationship for all items within a single shipment dispatch event. Aligns with SAP SD delivery document header.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Needed for packaging sustainability reports: associate each shipped SKU with its packaging profile to calculate recyclability and carbon footprint.',
    `prototype_id` BIGINT COMMENT 'Foreign key linking to research.prototype. Business justification: Needed to associate shipped items with the specific prototype they contain, enabling prototype test result traceability in the Prototype Test Management process.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Needed for item‑level compliance reporting; links each shipped item to its regulatory registration for traceability and audit.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for shipping manifest and inventory reconciliation; each shipment line must reference the master SKU to enable traceability, OTIF reporting, and regulatory compliance.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Needed for Pick Allocation process linking each shipment item to the specific stock position it was sourced from, supporting inventory reservation and traceability.',
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
    `purchase_order_number` STRING COMMENT 'Customer or retailer purchase order number associated with this shipment line. Required for EDI 856 ASN (Advance Ship Notice) transmission and retailer compliance programs.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether this shipment line item has been placed on a quality hold due to a failed QC inspection, temperature exceedance, or regulatory non-conformance. Items on hold must not be delivered until released by QA.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the shipment item record',
    `quantity_uom` STRING COMMENT 'The quantity uom of the shipment item record',
    `regulatory_approval_number` STRING COMMENT 'Product registration or regulatory approval number required for cross-border shipments of regulated consumer goods (e.g., FDA registration, EPA registration, EU REACH authorization). Stored for customs and import compliance documentation.',
    `rejection_reason` STRING COMMENT 'Reason code or description for any quantity rejected or short-shipped on this line item, such as OOS (Out of Stock), quality hold, weight discrepancy, or carrier refusal. Used for root cause analysis and OTIF exception reporting.',
    `sales_order_line` STRING COMMENT 'Line item number within the originating sales order corresponding to this shipment item. Used for precise order-to-shipment reconciliation and partial fulfillment tracking.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order number from the ERP system (SAP SD) that triggered this shipment line. Enables order-to-delivery traceability and OTIF measurement at the order line level.',
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
    `carrier_id` BIGINT COMMENT 'The carrier id of the delivery record',
    `employee_id` BIGINT COMMENT 'Reference to the driver or delivery agent responsible for executing the last-mile delivery. Used for performance tracking and dispute resolution.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record from which this delivery was dispatched. Links delivery execution back to the shipment planning record.',
    `route_id` BIGINT COMMENT 'Reference to the planned delivery route assigned to this delivery. Enables route optimization analysis and OTIF (On Time In Full) performance measurement.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Delivery execution is tied to a specific sales order; the link supports delivery confirmation and invoicing workflows.',
    `trade_account_id` BIGINT COMMENT 'Reference to the consignee (receiving party) account — typically a retail store, distribution center, or wholesale customer — to whom the goods are delivered.',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle or transport unit used for this delivery. Supports fleet management, cold-chain compliance, and route analytics.',
    `actual_delivery_date` DATE COMMENT 'The actual delivery date of the delivery record',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time the delivery was completed at the consignee location, as recorded by the driver via DSD handheld, e-POD app, or paper scan. Principal business event timestamp for OTIF calculation and dispute resolution.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual temperature in degrees Celsius recorded during delivery, captured by IoT sensor or driver log. Used to verify cold-chain compliance and support FDA/EU GDP regulatory reporting for temperature-sensitive goods.',
    `address` STRING COMMENT 'The address of the delivery record',
    `address_line1` STRING COMMENT 'Primary street address line of the delivery destination. Captured at time of delivery for POD (Proof of Delivery) and audit purposes, independent of master address data.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the delivery record',
    `carrier_tracking_number` STRING COMMENT 'External tracking number assigned by the carrier for track-and-trace visibility. Enables real-time shipment monitoring and customer-facing delivery status updates.',
    `city` STRING COMMENT 'City of the delivery destination address. Used for geographic delivery performance analysis, route optimization, and regional OTIF (On Time In Full) reporting.',
    `delivery_code` STRING COMMENT 'The delivery code of the delivery record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this delivery requires temperature-controlled cold-chain logistics (True) — applicable for perishable food, pharmaceutical, or temperature-sensitive consumer goods. Drives vehicle assignment and compliance monitoring.',
    `consignee_name` STRING COMMENT 'Legal or trading name of the receiving party (store, warehouse, or customer) at the delivery destination. Used for POD (Proof of Delivery) documentation and dispute resolution.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the delivery destination (e.g., USA, GBR, DEU). Required for cross-border regulatory compliance, customs documentation, and international freight management.. Valid values are `[A-Z]{3}`',
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
    `postal_code` STRING COMMENT 'Postal or ZIP code of the delivery destination. Supports geographic clustering, last-mile zone analysis, and carrier zone-based freight cost allocation.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the driver or delivery agent who executed the delivery. Used for DSD compliance, driver performance tracking, and dispute resolution. May reference an internal employee ID or carrier-assigned driver code.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment for which this proof of delivery was captured. Links POD to the outbound or inbound shipment record.',
    `route_id` BIGINT COMMENT 'Reference to the planned delivery route on which this POD was captured. Enables route-level performance analysis, stop sequencing, and DSD route compliance reporting.',
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
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate agreement or contract under which this freight order is priced. Null for spot-tendered orders without a pre-negotiated contract.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, parcel carrier, or 3PL) assigned to execute this freight order. Links to the carrier master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns internal cost center to freight orders for budgeting and chargeback of transportation expenses.',
    `network_node_id` BIGINT COMMENT 'Reference to the delivery/destination location (retailer DC, customer warehouse, store, or end-consumer address) to which the freight order is directed.',
    `freight_supply_network_node_id` BIGINT COMMENT 'Reference to the pickup/origin location (plant, warehouse, distribution center, or supplier facility) from which the freight order originates.',
    `lane_id` BIGINT COMMENT 'The lane id of the freight order record',
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
    `origin_location` STRING COMMENT 'The origin location of the freight order record',
    `origin_location_code` STRING COMMENT 'The origin location code of the freight order record',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`route` (
    `route_id` BIGINT COMMENT 'Unique system-generated identifier for the delivery route plan. Primary key for the route entity in the logistics domain.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or 3PL partner responsible for executing this route. Relevant for outsourced last-mile and DSD operations.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the originating depot, distribution center, or warehouse from which this route departs. Links to the facility/location master.',
    `employee_id` BIGINT COMMENT 'Reference to the driver assigned to execute this route. Links to the workforce/driver master record.',
    `vehicle_id` BIGINT COMMENT 'The vehicle id of the route record',
    `actual_departure` TIMESTAMP COMMENT 'The actual departure of the route record',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual timestamp at which the vehicle departed the depot. Compared against planned_departure_time to measure on-time departure performance and identify dispatch delays.',
    `actual_distance_km` DECIMAL(18,2) COMMENT 'Actual driving distance recorded for the route in kilometers, typically captured via telematics or GPS. Compared against planned distance for route efficiency analysis.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'The actual duration hours of the route record',
    `actual_duration_min` STRING COMMENT 'Actual total route duration in minutes from depot departure to return. Used to measure route execution efficiency and identify deviations from plan.',
    `actual_return_time` TIMESTAMP COMMENT 'Actual timestamp at which the vehicle returned to the depot. Used to calculate total route duration, driver overtime, and vehicle utilization.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the route record',
    `capacity_utilization_pct` DECIMAL(18,2) COMMENT 'The capacity utilization pct of the route record',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms for this route, calculated from fuel consumption and vehicle type. Supports sustainability reporting, ESG disclosures, and ISO 14001 environmental management.',
    `route_code` STRING COMMENT 'The route code of the route record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system, typically when the route plan was generated by the optimization engine or manually by a dispatcher.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the freight_cost field (e.g., USD, EUR, GBP). Supports multi-currency operations across global distribution networks.. Valid values are `^[A-Z]{3}$`',
    `route_description` STRING COMMENT 'The route description of the route record',
    `destination_location` STRING COMMENT 'The destination location of the route record',
    `driver_name` STRING COMMENT 'The driver name of the route record',
    `effective_from` DATE COMMENT 'The effective from of the route record',
    `effective_until` DATE COMMENT 'The effective until of the route record',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated duration hours of the route record',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total planned or actual freight cost for this route in the operating currency. Used for transportation cost tracking, carrier invoice reconciliation, and freight audit processes.',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Estimated or actual fuel consumed in liters for this route. Used for fleet cost management, carbon emissions calculation, and sustainability reporting under ISO 14001.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether this route carries hazardous materials (e.g., aerosols, flammable cleaning products) requiring special handling, placarding, and regulatory compliance under DOT and EPA regulations.',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this route requires cold-chain compliance (temperature-controlled vehicle and handling). Critical for perishable consumer goods, dairy, frozen foods, and pharmaceutical products subject to FDA and GMP requirements.',
    `is_dsd` BOOLEAN COMMENT 'Indicates whether this route is a Direct Store Delivery (DSD) route, where the manufacturer delivers directly to retail store shelves bypassing the retailers distribution center. Drives specific execution workflows in Salesforce Consumer Goods Cloud.',
    `route_name` STRING COMMENT 'Human-readable descriptive name for the route, typically reflecting the geographic territory or customer cluster served (e.g., Northeast Metro DSD Run).',
    `notes` STRING COMMENT 'Free-text operational notes or instructions for the route, such as special handling requirements, access restrictions, or dispatcher comments. Visible to drivers via mobile dispatch applications.',
    `optimization_algorithm` STRING COMMENT 'Name or identifier of the route optimization algorithm or engine used to generate this route plan (e.g., VRP-TW, Clarke-Wright, Blue Yonder Optimizer v4.2). Supports algorithm performance benchmarking and audit.',
    `optimization_method` STRING COMMENT 'The optimization method of the route record',
    `optimization_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the route optimization algorithm was executed to generate this route plan. Used to track plan freshness and identify routes built on stale demand data.',
    `origin_location` STRING COMMENT 'The origin location of the route record',
    `origin_location_code` STRING COMMENT 'The origin location code of the route record',
    `otif_compliant` BOOLEAN COMMENT 'Indicates whether this route achieved full OTIF (On Time In Full) compliance — all stops were serviced within the agreed time windows and all ordered quantities were delivered. Key KPI for retailer scorecards.',
    `planned_date` DATE COMMENT 'The planned date of the route record',
    `planned_departure` TIMESTAMP COMMENT 'The planned departure of the route record',
    `planned_departure_time` TIMESTAMP COMMENT 'Scheduled timestamp at which the vehicle is planned to depart the depot for this route. Used for driver scheduling, dock door allocation, and on-time departure KPI tracking.',
    `planned_distance_km` DECIMAL(18,2) COMMENT 'Total planned driving distance for the route in kilometers, as calculated by the route optimization algorithm. Used for fuel cost estimation, carbon footprint calculation, and driver pay.',
    `planned_duration_min` STRING COMMENT 'Total planned route duration in minutes, including drive time and estimated stop dwell times. Used for driver scheduling and OTIF planning.',
    `planned_return_time` TIMESTAMP COMMENT 'Scheduled timestamp at which the vehicle is expected to return to the depot after completing all stops. Used for driver hours-of-service compliance and dock planning.',
    `proof_of_delivery_required` BOOLEAN COMMENT 'Indicates whether electronic or physical proof of delivery (POD) must be captured at each stop on this route. Drives mobile app workflows for drivers and supports dispute resolution.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the route record',
    `route_date` DATE COMMENT 'The calendar date on which this route is planned to be executed. Used for daily route scheduling, driver dispatch, and OTIF performance tracking.',
    `route_number` STRING COMMENT 'Externally-known business identifier for the route, used in operational communications, driver manifests, and carrier EDI exchanges. May align with SAP Transportation Management route codes.',
    `route_status` STRING COMMENT 'Current lifecycle state of the route. Tracks progression from planning through dispatch, active execution, and completion or cancellation. Supports real-time track-and-trace and operational dashboards.. Valid values are `planned|dispatched|in_progress|completed|cancelled`',
    `route_type` STRING COMMENT 'Classification of the route by operational purpose. DSD (Direct Store Delivery) routes serve retail outlets directly; mixed routes combine deliveries and pickups; cross-dock routes transfer goods between facilities. [ENUM-REF-CANDIDATE: delivery|pickup|mixed|cross_dock|dsd|milk_run — promote to reference product if additional types are needed]. Valid values are `delivery|pickup|mixed|cross_dock|dsd`',
    `service_time_window_end` TIMESTAMP COMMENT 'Latest allowable timestamp for the route to complete servicing stops. Breaching this window results in OTIF failures and potential retailer chargebacks.',
    `service_time_window_start` TIMESTAMP COMMENT 'Earliest allowable timestamp for the route to begin servicing stops, as defined by customer or retailer receiving window constraints. Used as an input constraint in the route optimization algorithm.',
    `source_system_code` STRING COMMENT 'The source system code of the route record',
    `stop_count` STRING COMMENT 'The stop count of the route record',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable cargo temperature in degrees Celsius for cold-chain routes. Breaches trigger non-conformance events and potential product quarantine per GMP and FDA requirements.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable cargo temperature in degrees Celsius for cold-chain routes. Enforced during transit to maintain product integrity and regulatory compliance.',
    `total_cases_delivered` STRING COMMENT 'Actual number of cases delivered across all stops on this route. Compared against total_cases_planned to compute fill rate and identify short-shipments.',
    `total_cases_planned` STRING COMMENT 'Total number of cases (selling units) planned for delivery across all stops on this route. Used for vehicle load planning and OTIF measurement.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'The total distance km of the route record',
    `total_pallets_planned` STRING COMMENT 'Total number of pallets planned for loading on this route. Used for vehicle capacity utilization and dock door planning.',
    `total_stops` STRING COMMENT 'The total stops of the route record',
    `total_stops_completed` STRING COMMENT 'Actual number of stops successfully completed during route execution. Compared against total_stops_planned to measure route completion rate and identify failed deliveries.',
    `total_stops_planned` STRING COMMENT 'Total number of delivery or pickup stops planned for this route. Used for workload balancing, route complexity scoring, and driver capacity planning.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total planned cargo volume in cubic meters for the route. Used alongside total_weight_kg to assess vehicle cube utilization and prevent overloading.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total planned payload weight in kilograms for the route. Used to verify compliance with vehicle gross vehicle weight (GVW) regulations and optimize load efficiency.',
    `uom` STRING COMMENT 'The uom of the route record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this route record, such as stop additions, driver reassignments, or status updates. Supports audit trail and data lineage requirements.',
    `vehicle_capacity_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the vehicles rated payload capacity utilized by the planned load on this route. Key metric for fleet efficiency and freight cost optimization.',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Optimized delivery route plan for a vehicle or driver covering multiple sequential stops. Captures route ID, route date, vehicle/trailer assignment, driver reference, total planned distance and duration, planned departure time, route optimization algorithm used, route status (planned/dispatched/in-progress/completed), and ordered stop details including stop sequence, consignee reference, delivery address, planned/actual arrival and departure times, stop type (delivery/pickup/cross-dock), cases/pallets to deliver, stop status, and dwell time. Supports last-mile route optimization, DSD execution, and stop-level performance tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` (
    `route_stop_id` BIGINT COMMENT 'Unique surrogate identifier for each individual stop on a planned delivery route. Primary key for the route_stop entity in the Silver Layer lakehouse.',
    `carrier_id` BIGINT COMMENT 'Reference to the third-party logistics (3PL) carrier or internal fleet entity responsible for executing this stop. Used for carrier performance measurement, freight audit, and contract compliance.',
    `delivery_id` BIGINT COMMENT 'The delivery id of the route stop record',
    `employee_id` BIGINT COMMENT 'Reference to the driver assigned to execute this route stop. Links to the workforce or driver master record for performance tracking, compliance, and payroll purposes.',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: Required for Stop Execution Report to map each route stop to the exact warehouse storage location for picking/delivery, enabling OTIF compliance tracking.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the outbound shipment or delivery order associated with this stop. Links stop-level execution to the shipment document in SAP S/4HANA SD or Blue Yonder WMS.',
    `route_id` BIGINT COMMENT 'Reference to the parent delivery route to which this stop belongs. Links the stop to its planned route header for route-level aggregation and performance tracking.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distribution center, or customer location that is the consignee for this stop. Aligns with the customer/account master in SAP S/4HANA SD and Salesforce Consumer Goods Cloud.',
    `actual_arrival` TIMESTAMP COMMENT 'The actual arrival of the route stop record',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual date and time the driver arrived at this stop, captured via mobile device, GPS telemetry, or driver confirmation. Used for OTIF measurement, dwell time calculation, and route adherence analysis.',
    `actual_cases` STRING COMMENT 'Actual number of cases delivered or picked up at this stop as confirmed by the driver or proof of delivery (POD) scan. Used for OTIF fill rate calculation and short-shipment identification.',
    `actual_departure` TIMESTAMP COMMENT 'The actual departure of the route stop record',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual date and time the driver departed this stop after completing the delivery or pickup activity. Used for dwell time calculation, route performance analysis, and carrier SLA reporting.',
    `actual_pallets` STRING COMMENT 'Actual number of pallets delivered or picked up at this stop as confirmed at execution. Used for OTIF measurement, pallet reconciliation, and carrier billing verification.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight in kilograms of goods delivered or picked up at this stop as confirmed at execution. Used for freight audit, carrier billing reconciliation, and OTIF measurement.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the route stop record',
    `arrival_variance_minutes` STRING COMMENT 'Difference in minutes between actual arrival time and planned arrival time. Positive values indicate late arrival; negative values indicate early arrival. Core metric for OTIF and route adherence KPI reporting.',
    `route_stop_code` STRING COMMENT 'The route stop code of the route stop record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this stop requires temperature-controlled cold chain handling during delivery. Triggers cold chain compliance monitoring and temperature logging requirements for perishable or temperature-sensitive consumer goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this route stop record was first created in the system, typically when the route was planned and stops were generated. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The currency code of the route stop record',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The delivered quantity of the route stop record',
    `delivery_address_line1` STRING COMMENT 'Primary street address line of the delivery location for this stop. Used for driver navigation, proof of delivery, and logistics compliance documentation.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line for the delivery location (suite, unit, dock number, building identifier). Supplements the primary address for precise delivery execution.',
    `delivery_city` STRING COMMENT 'City of the delivery location for this stop. Used for geographic segmentation of delivery performance and freight cost analysis.',
    `delivery_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the delivery location (e.g., USA, GBR, DEU). Used for cross-border logistics compliance and international freight management.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery location. Used for route optimization, freight zone determination, and last-mile delivery analytics.',
    `delivery_state_province` STRING COMMENT 'State or province of the delivery location. Used for regulatory compliance, freight lane analysis, and geographic reporting.',
    `delivery_window_end` TIMESTAMP COMMENT 'Latest acceptable arrival time at this stop as agreed with the consignee or retailer. Defines the end of the customer-committed delivery time window for SLA compliance measurement.',
    `delivery_window_start` TIMESTAMP COMMENT 'Earliest acceptable arrival time at this stop as agreed with the consignee or retailer. Defines the start of the customer-committed delivery time window for SLA compliance measurement.',
    `route_stop_description` STRING COMMENT 'The route stop description of the route stop record',
    `distance_from_prev_km` DECIMAL(18,2) COMMENT 'The distance from prev km of the route stop record',
    `dwell_time_minutes` STRING COMMENT 'Total time in minutes the driver spent at this stop, calculated as the difference between actual departure and actual arrival times. Key KPI for stop-level efficiency, driver productivity, and route optimization.',
    `effective_from` DATE COMMENT 'The effective from of the route stop record',
    `effective_until` DATE COMMENT 'The effective until of the route stop record',
    `failure_reason` STRING COMMENT 'Reason code or description explaining why a delivery stop was not completed successfully (e.g., consignee closed, refused delivery, access denied, vehicle breakdown). Required for failed or skipped stop status. [ENUM-REF-CANDIDATE: consignee_closed|refused_delivery|access_denied|vehicle_breakdown|incorrect_address|no_dock_available|weather — promote to reference product]',
    `gps_latitude` DECIMAL(18,2) COMMENT 'The gps latitude of the route stop record',
    `gps_longitude` DECIMAL(18,2) COMMENT 'The gps longitude of the route stop record',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery stop location in decimal degrees. Used for route optimization, geofencing, and real-time track-and-trace in transportation management systems.',
    `location_code` STRING COMMENT 'The location code of the route stop record',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery stop location in decimal degrees. Used alongside latitude for route optimization, geofencing, and real-time track-and-trace.',
    `route_stop_name` STRING COMMENT 'The route stop name of the route stop record',
    `notes` STRING COMMENT 'The notes of the route stop record',
    `otif_compliant` BOOLEAN COMMENT 'Indicates whether this stop met the On Time In Full (OTIF) delivery standard — i.e., arrived within the committed delivery window and delivered the full planned quantity. Core KPI for retail customer compliance and supply chain performance.',
    `planned_arrival` TIMESTAMP COMMENT 'The planned arrival of the route stop record',
    `planned_arrival_time` TIMESTAMP COMMENT 'Scheduled date and time the driver is expected to arrive at this stop, as determined by the route planning system. Used as the baseline for On Time In Full (OTIF) measurement and service level agreement (SLA) compliance.',
    `planned_cases` STRING COMMENT 'Number of cases (standard shipping units) planned to be delivered or picked up at this stop as per the delivery order. Used for load planning, vehicle capacity utilization, and OTIF measurement.',
    `planned_departure` TIMESTAMP COMMENT 'The planned departure of the route stop record',
    `planned_departure_time` TIMESTAMP COMMENT 'Scheduled date and time the driver is expected to depart this stop after completing the delivery or pickup activity. Used for route schedule adherence and dwell time planning.',
    `planned_pallets` STRING COMMENT 'Number of pallets planned to be delivered or picked up at this stop. Used for vehicle load planning, dock scheduling, and warehouse labor planning.',
    `planned_weight_kg` DECIMAL(18,2) COMMENT 'Total planned weight in kilograms of goods to be delivered or picked up at this stop. Used for vehicle load compliance, freight cost calculation, and carrier billing.',
    `pod_captured` BOOLEAN COMMENT 'Indicates whether a proof of delivery (POD) was successfully captured at this stop (e.g., electronic signature, barcode scan, photo). Required for invoice settlement, dispute resolution, and regulatory compliance.',
    `pod_method` STRING COMMENT 'Method used to capture proof of delivery at this stop. Electronic_signature indicates digital sign-off; barcode_scan indicates GS1 scan confirmation; photo indicates photographic evidence; paper indicates manual paper POD; none indicates no POD captured.. Valid values are `electronic_signature|barcode_scan|photo|paper|none`',
    `pod_signatory_name` STRING COMMENT 'Name of the individual who signed or confirmed receipt of the delivery at this stop. Used for delivery verification, dispute resolution, and compliance documentation.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time when proof of delivery was captured at this stop. Used for delivery confirmation audit trail, invoice trigger, and dispute resolution.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the route stop record',
    `route_stop_status` STRING COMMENT 'The route stop status of the route stop record',
    `service_time_minutes` DECIMAL(18,2) COMMENT 'The service time minutes of the route stop record',
    `source_system_code` STRING COMMENT 'The source system code of the route stop record',
    `stop_address` STRING COMMENT 'The stop address of the route stop record',
    `stop_location` STRING COMMENT 'The stop location of the route stop record',
    `stop_name` STRING COMMENT 'Human-readable name or label for the stop location, typically the retail store name, distribution center name, or customer site name. Used for driver manifests and operational reporting.',
    `stop_number` STRING COMMENT 'Sequential position of this stop within the planned delivery route. Determines the order in which the driver visits consignees. Used for route adherence analysis and optimization.',
    `stop_sequence` STRING COMMENT 'The stop sequence of the route stop record',
    `stop_status` STRING COMMENT 'Current execution status of this route stop within its lifecycle. Planned indicates not yet visited; in_transit indicates driver en route; arrived indicates driver on-site; completed indicates delivery confirmed; skipped indicates stop bypassed; failed indicates delivery attempt unsuccessful.. Valid values are `planned|in_transit|arrived|completed|skipped|failed`',
    `stop_type` STRING COMMENT 'Classification of the activity performed at this stop. Delivery indicates outbound drop-off; pickup indicates inbound collection; cross_dock indicates transfer without storage; return indicates reverse logistics collection; service indicates a non-product visit.. Valid values are `delivery|pickup|cross_dock|return|service`',
    `temperature_exceedance` BOOLEAN COMMENT 'Indicates whether a temperature exceedance event was recorded during transit to or at this stop. Triggers quality hold, product disposition review, and regulatory notification processes.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in degrees Celsius for cold chain compliance at this stop. Used to validate temperature logs against product storage requirements and regulatory standards.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in degrees Celsius for cold chain compliance at this stop. Used to validate temperature logs against product storage requirements and regulatory standards.',
    `uom` STRING COMMENT 'The uom of the route stop record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this route stop record was last modified, such as when actual times were recorded, status was updated, or POD was captured. Used for change tracking and audit compliance.',
    `vehicle_code` BIGINT COMMENT 'Reference to the vehicle or truck assigned to execute this route stop. Used for fleet utilization tracking, maintenance scheduling, and cold chain compliance verification.',
    CONSTRAINT pk_route_stop PRIMARY KEY(`route_stop_id`)
) COMMENT 'Individual stop on a planned delivery route. Captures stop sequence number, consignee account reference, delivery address, planned arrival and departure times, actual arrival and departure times, stop type (delivery/pickup/cross-dock), number of cases/pallets to deliver, stop status, and dwell time. Enables stop-level performance tracking and route adherence measurement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the freight invoice record in the Consumer Goods lakehouse silver layer. Primary key for this entity.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate contract against which this invoice is audited. Used in freight audit and pay (FAP) to validate invoiced charges against contracted rates.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (transportation service provider) who issued this freight invoice. Links to the carrier master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed to allocate freight invoice expense to the appropriate cost center for internal cost tracking and budgeting.',
    `freight_order_id` BIGINT COMMENT 'The freight order id of the freight invoice record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting freight invoices to the general ledger; finance GL accounts are used for financial reporting of freight costs.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this freight invoice. Enables reconciliation between transportation execution and billing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Allows assignment of freight invoice expense to profit center for profitability analysis of logistics services.',
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
    `purchase_order_number` STRING COMMENT 'Consumer Goods internal purchase order number associated with the freight services procured. Used for three-way match in accounts payable and freight audit.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` (
    `freight_audit_result_id` BIGINT COMMENT 'Unique surrogate identifier for each freight audit result record. Primary key for the freight_audit_result data product in the Databricks Silver Layer.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate contract or transportation agreement under which the contracted freight rate was applied during audit. Ensures rate validation is traceable to the governing agreement.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, freight forwarder, or parcel carrier) that executed the shipment and issued the freight invoice being audited.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which the audited freight cost is allocated. Supports logistics cost-to-serve analysis and COGS freight component reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or third-party freight audit service provider who performed the audit. Supports audit trail, quality review, and auditor performance tracking.',
    `freight_invoice_id` BIGINT COMMENT 'The freight invoice id of the freight audit result record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Provides GL account reference for audit results, ensuring freight audit adjustments are posted to correct ledger accounts.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent logistics shipment record against which this freight audit result was generated. Links audit outcome to the shipments BOL, carrier, and lane details.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Amount accrued in the general ledger for this freight cost prior to invoice receipt and audit. Used to reconcile accrual vs. actual freight cost and manage period-end close accuracy.',
    `accrual_status` STRING COMMENT 'Status of the freight cost accrual in the general ledger. accrued means the cost has been accrued in the period; reversed means the accrual was reversed upon invoice receipt; posted means the actual invoice has been posted; pending means accrual is awaiting approval; not_required means no accrual was needed.. Valid values are `accrued|reversed|posted|pending|not_required`',
    `actual_vs_standard_variance` DECIMAL(18,2) COMMENT 'Difference between the audited freight amount and the standard freight cost (audited_amount minus standard_cost_amount). Positive value indicates actual cost exceeded standard; negative indicates favorable variance. Key input to COGS freight component and logistics P&L.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the freight audit result record',
    `audit_date` DATE COMMENT 'The calendar date on which the freight invoice was audited against contracted rates and shipment data. Principal business event date for the audit lifecycle.',
    `audit_number` STRING COMMENT 'The audit number of the freight audit result record',
    `audit_source` STRING COMMENT 'Indicates whether the freight audit was performed by an internal team, a third-party freight audit provider, or an automated audit system. Supports audit quality governance and cost-to-audit tracking.. Valid values are `internal|third_party_auditor|automated_system`',
    `audit_status` STRING COMMENT 'Current workflow status of the freight audit result. approved means invoiced amount matches contracted rate; disputed means a formal dispute has been raised with the carrier; short_paid means payment was issued for the audited (lower) amount; pending means audit is in progress; voided means the audit record was cancelled; escalated means the dispute has been escalated for resolution. [ENUM-REF-CANDIDATE: approved|disputed|short_paid|pending|voided|escalated — promote to reference product]. Valid values are `approved|disputed|short_paid|pending|voided|escalated`',
    `audit_type` STRING COMMENT 'The audit type of the freight audit result record',
    `audited_amount` DECIMAL(18,2) COMMENT 'Final freight amount determined by the audit process as the correct payable amount. May equal the contracted rate amount or reflect adjustments for accessorials, corrections, or negotiated settlements.',
    `auditor` STRING COMMENT 'The auditor of the freight audit result record',
    `auditor_name` STRING COMMENT 'The auditor name of the freight audit result record',
    `auditor_system` STRING COMMENT 'The auditor system of the freight audit result record',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the shipment being audited. Used to cross-reference shipment documentation and validate carrier charges against actual freight moved.',
    `freight_audit_result_code` STRING COMMENT 'The freight audit result code of the freight audit result record',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'Freight amount calculated by applying the contracted carrier rate to the actual shipment characteristics (weight, volume, lane). Represents the expected charge per the governing carrier contract.',
    `cost_allocation_basis` STRING COMMENT 'Basis used to allocate the audited freight cost across cost centers, products, or business units. weight allocates by shipment weight (kg); volume by cubic meters; value by declared goods value; units by case/pallet count; equal_split divides equally.. Valid values are `weight|volume|value|units|equal_split`',
    `cost_category` STRING COMMENT 'Classification of the freight cost component being audited. line_haul is the base transportation charge; fuel_surcharge is the fuel adjustment; accessorial covers additional services (liftgate, residential delivery, etc.); duty covers customs/import duties; insurance covers cargo insurance; detention covers carrier wait-time charges. [ENUM-REF-CANDIDATE: line_haul|fuel_surcharge|accessorial|duty|insurance|detention — promote to reference product]. Valid values are `line_haul|fuel_surcharge|accessorial|duty|insurance|detention`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight audit result record was first created in the system. Supports audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'The currency code of the freight audit result record',
    `freight_audit_result_description` STRING COMMENT 'The freight audit result description of the freight audit result record',
    `discrepancy_category` STRING COMMENT 'The discrepancy category of the freight audit result record',
    `dispute_filed` BOOLEAN COMMENT 'The dispute filed of the freight audit result record',
    `dispute_flag` BOOLEAN COMMENT 'The dispute flag of the freight audit result record',
    `dispute_raised_date` DATE COMMENT 'Date on which a formal dispute was raised with the carrier for the identified freight charge variance. Used to track dispute aging and carrier SLA compliance for dispute resolution.',
    `dispute_reference_number` STRING COMMENT 'Carrier-assigned or internally-assigned reference number for a formal freight charge dispute. Populated when audit_status is disputed or escalated. Used to track dispute resolution progress and recovery.',
    `dispute_resolved_date` DATE COMMENT 'Date on which the carrier dispute was formally resolved (credit issued, short-payment accepted, or dispute closed). Used to measure dispute resolution cycle time and carrier performance.',
    `effective_from` DATE COMMENT 'The effective from of the freight audit result record',
    `effective_until` DATE COMMENT 'The effective until of the freight audit result record',
    `expected_amount` DECIMAL(18,2) COMMENT 'The expected amount of the freight audit result record',
    `fiscal_period` STRING COMMENT 'Fiscal year and month (YYYY-MM) in which the freight cost is recognized for financial reporting purposes. Used for period-end close, COGS freight accrual reconciliation, and logistics cost-to-serve reporting.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `freight_audit_result_status` STRING COMMENT 'The freight audit result status of the freight audit result record',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert invoice currency amounts to reporting currency at the time of audit. Sourced from SAP FI or Oracle Cloud Financials daily rate tables.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code governing freight cost responsibility between buyer and seller for this shipment. Determines which party bears the audited freight cost. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `invoice_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the carriers freight invoice (e.g., USD, EUR, GBP). Required for multi-currency freight cost consolidation and FX translation to reporting currency.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'Date the carrier issued the freight invoice. Used to calculate invoice aging, payment terms compliance, and Days Sales Outstanding (DSO) for carrier payables.',
    `invoice_received_date` DATE COMMENT 'Date the freight invoice was received by the companys accounts payable or freight audit team. Used to measure invoice processing cycle time and payment terms compliance.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Gross freight amount as billed by the carrier on the invoice, in the invoice currency. Represents the carriers claimed charge before audit validation.',
    `freight_audit_result_name` STRING COMMENT 'The freight audit result name of the freight audit result record',
    `notes` STRING COMMENT 'The notes of the freight audit result record',
    `payment_date` DATE COMMENT 'Date on which payment was issued to the carrier for the audited freight invoice. Used for cash flow management, payment terms compliance, and carrier relationship management.',
    `payment_due_date` DATE COMMENT 'Date by which the audited freight invoice must be paid per carrier contract payment terms. Drives accounts payable scheduling and early payment discount capture.',
    `payment_reference_number` STRING COMMENT 'Accounts payable payment reference number (check number, ACH transaction ID, or EFT reference) issued for the audited freight invoice. Confirms payment execution and enables AP reconciliation.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used to track the shipment within the carriers system. Key identifier for carrier dispute resolution and track-and-trace reconciliation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the freight audit result record',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount actually recovered from the carrier through short-payment, credit memo, or dispute resolution. May differ from variance_amount if only partial recovery was achieved.',
    `reporting_currency` STRING COMMENT 'ISO 4217 three-letter currency code used for internal financial reporting and COGS freight component allocation (e.g., USD as functional currency). Enables consistent cross-currency logistics cost-to-serve analysis.. Valid values are `^[A-Z]{3}$`',
    `resolution_status` STRING COMMENT 'The resolution status of the freight audit result record',
    `source_system_code` STRING COMMENT 'The source system code of the freight audit result record',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Pre-established standard freight cost for this lane and transport mode, used as the benchmark for actual vs. standard cost variance analysis. Feeds COGS standard costing and logistics cost-to-serve reporting.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment (e.g., Truckload (TL), Less-than-Truckload (LTL), parcel, intermodal, air, ocean, rail). Determines applicable rate structures and audit rules. [ENUM-REF-CANDIDATE: TL|LTL|parcel|intermodal|air|ocean|rail — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the freight audit result record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight audit result record was last modified. Tracks audit status changes, dispute updates, and payment postings for data lineage and change management.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the invoiced amount and the audited amount (invoiced_amount minus audited_amount). Positive value indicates overcharge by carrier; negative value indicates undercharge. Core metric for carrier dispute management and freight cost savings tracking.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The variance pct of the freight audit result record',
    `variance_reason` STRING COMMENT 'The variance reason of the freight audit result record',
    `variance_reason_code` STRING COMMENT 'Standardized code identifying the root cause of the variance between invoiced and audited amounts (e.g., RATE_MISMATCH, WEIGHT_DISCREPANCY, DUPLICATE_INVOICE, ACCESSORIAL_NOT_CONTRACTED, FUEL_SURCHARGE_ERROR). [ENUM-REF-CANDIDATE: RATE_MISMATCH|WEIGHT_DISCREPANCY|DUPLICATE_INVOICE|ACCESSORIAL_NOT_CONTRACTED|FUEL_SURCHARGE_ERROR|LANE_MISMATCH|BILLING_ERROR — promote to reference product]',
    `variance_reason_description` STRING COMMENT 'Free-text narrative explanation of the variance reason, providing additional context beyond the variance_reason_code. Used by freight audit analysts and carrier dispute managers.',
    `weight_actual_kg` DECIMAL(18,2) COMMENT 'Actual verified shipment weight (in kilograms) as recorded at origin or confirmed by weigh-in-motion data. Used to validate carrier billed weight and identify weight discrepancy variances.',
    `weight_billed_kg` DECIMAL(18,2) COMMENT 'Shipment weight (in kilograms) as billed by the carrier on the freight invoice. Compared against actual/verified weight to identify weight-based billing discrepancies.',
    CONSTRAINT pk_freight_audit_result PRIMARY KEY(`freight_audit_result_id`)
) COMMENT 'Consolidated freight cost and audit record representing the audited, allocated, and accrued transportation cost at shipment or leg level. Captures audit date, freight invoice reference, audited line items, contracted rate applied, invoiced vs. audited amounts, variance amount and reason code, audit outcome (approved/disputed/short-paid), recovery amount, cost category (line-haul/fuel/accessorial/duty/insurance), cost allocation basis (weight/volume/value), cost center allocation, accrual status, and actual vs. standard cost variance. SSOT for freight cost truth — feeds COGS freight component, logistics cost-to-serve analysis, and carrier dispute management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` (
    `tracking_event_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment tracking event record in the silver layer lakehouse. Primary key for the tracking_event data product.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, parcel carrier, ocean liner, air freight provider) that generated or reported this tracking event.',
    `employee_id` BIGINT COMMENT 'The carrier-assigned identifier for the driver or operator responsible for the shipment at the time of this tracking event. Used for driver performance analysis, proof-of-delivery attribution, and exception accountability. Not a personal identifier in the consumer goods context — represents a carrier operational reference.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane on which this tracking event occurred, enabling lane-level performance and exception analysis.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record to which this tracking event belongs. Links the event to the full shipment context including origin, destination, carrier, and BOL details.',
    `shipment_leg_id` BIGINT COMMENT 'The shipment leg id of the tracking event record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the tracking event record',
    `carrier_event_code` STRING COMMENT 'The carriers native status or event code as transmitted via EDI 214/990 or carrier API (e.g., X1, D1, AF, OFD). Preserves the source system code for carrier-specific reporting and reconciliation against carrier invoices and SLA commitments.',
    `carrier_sla_met` BOOLEAN COMMENT 'Indicates whether the carrier met the contracted Service Level Agreement (SLA) milestone at this event (e.g., on-time pickup, on-time delivery). Derived from comparison of event_timestamp against planned_event_timestamp and carrier contract terms. Feeds carrier performance scorecards and SLA penalty/incentive calculations.',
    `tracking_event_code` STRING COMMENT 'The tracking event code of the tracking event record',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tracking event record was first ingested and created in the silver layer lakehouse. Distinct from event_timestamp (when the event occurred in the real world). Used for data latency monitoring and SLA measurement of carrier EDI/API feed timeliness.',
    `currency_code` STRING COMMENT 'The currency code of the tracking event record',
    `customs_status` STRING COMMENT 'The customs clearance status of the shipment at the time of this tracking event, applicable to cross-border shipments. Indicates whether the shipment has cleared customs, is held for inspection, pending documentation, released after hold, or seized. Critical for international supply chain visibility and compliance.. Valid values are `cleared|held|pending|released|seized`',
    `data_source` STRING COMMENT 'The originating system or channel that generated this tracking event. Distinguishes between carrier EDI transmissions (214/990), GPS telematics feeds, IoT sensor readings, carrier API webhooks, WMS scan events, and manual entries. Critical for data lineage and source reliability scoring. [ENUM-REF-CANDIDATE: edi_214|edi_990|gps_telematics|iot_sensor|carrier_api|manual_entry|wms_scan — promote to reference product]',
    `tracking_event_description` STRING COMMENT 'The tracking event description of the tracking event record',
    `dwell_time_minutes` STRING COMMENT 'The number of minutes the shipment or vehicle dwelled at the event location (e.g., carrier terminal, cross-dock, customer dock) before the next movement event. Supports carrier performance analysis, dock scheduling optimization, and detention charge identification.',
    `edi_interchange_control_number` STRING COMMENT 'The unique interchange control number from the EDI envelope (ISA segment) of the source EDI transmission that generated this tracking event. Enables end-to-end EDI message traceability and duplicate detection.',
    `edi_transaction_set` STRING COMMENT 'The ANSI X12 EDI transaction set number associated with the source message that generated this tracking event (e.g., 214 = Transportation Carrier Shipment Status, 990 = Response to a Load Tender). Supports EDI audit trail and carrier integration troubleshooting.. Valid values are `214|990|204|210|997`',
    `effective_from` DATE COMMENT 'The effective from of the tracking event record',
    `effective_until` DATE COMMENT 'The effective until of the tracking event record',
    `equipment_code` STRING COMMENT 'The identifier of the transportation equipment (trailer number, container number, railcar number, vessel IMO number) associated with this tracking event. Enables equipment-level tracking, utilization analysis, and cross-referencing with carrier equipment records.',
    `estimated_delivery_update` TIMESTAMP COMMENT 'The estimated delivery update of the tracking event record',
    `event_city` STRING COMMENT 'The city where the tracking event occurred, as reported by the carrier or GPS system. Used for geographic visualization of shipment progress and lane-level exception analysis.',
    `event_code` STRING COMMENT 'The event code of the tracking event record',
    `event_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the tracking event occurred (e.g., USA, CAN, MEX). Required for cross-border shipment tracking and customs compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `event_description` STRING COMMENT 'The event description of the tracking event record',
    `event_location` STRING COMMENT 'The event location of the tracking event record',
    `event_location_code` STRING COMMENT 'The event location code of the tracking event record',
    `event_state_province` STRING COMMENT 'The state or province where the tracking event occurred, using standard postal abbreviations (e.g., CA, TX, ON). Supports regional performance reporting and regulatory compliance tracking.',
    `event_status` STRING COMMENT 'Lifecycle status of this tracking event record indicating whether it is the current authoritative event (active), has been superseded by a correction, cancelled, or identified as a duplicate. Supports data quality management in the silver layer.. Valid values are `active|superseded|cancelled|duplicate`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time (in ISO 8601 format with timezone offset) at which the tracking event occurred in the real world, as reported by the carrier, GPS telematics system, or IoT sensor. This is the principal business event time, distinct from record ingestion timestamps.',
    `event_type` STRING COMMENT 'Standardized classification of the shipment tracking event representing the current milestone or status change in the shipment lifecycle. Drives track-and-trace visibility and exception management workflows. [ENUM-REF-CANDIDATE: picked_up|in_transit|out_for_delivery|delivered|exception|delay|damage|refused — promote to reference product]',
    `exception_description` STRING COMMENT 'Free-text narrative description of the exception condition, providing additional context beyond the root cause code. May include carrier notes, driver comments, or system-generated messages explaining the nature of the delay, damage, or refusal.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator that this tracking event represents or triggered a shipment exception condition (e.g., delay, damage, refused delivery, missed pickup, temperature breach). Drives exception management workflows and carrier performance scorecards.',
    `exception_root_cause_code` STRING COMMENT 'Standardized root cause code categorizing the reason for a shipment exception (e.g., WEATHER, CARRIER_DELAY, CUSTOMS_HOLD, MECHANICAL_FAILURE, INCORRECT_ADDRESS, REFUSED_BY_CONSIGNEE, DAMAGED_IN_TRANSIT). Used for exception trend analysis and carrier performance management. [ENUM-REF-CANDIDATE: WEATHER|CARRIER_DELAY|CUSTOMS_HOLD|MECHANICAL_FAILURE|INCORRECT_ADDRESS|REFUSED_BY_CONSIGNEE|DAMAGED_IN_TRANSIT — promote to reference product]',
    `facility_code` STRING COMMENT 'The code identifying the carrier terminal, cross-dock, distribution center, port, or customer facility where the tracking event occurred (e.g., carrier hub code, GLN). Supports facility-level dwell time and throughput analysis.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the financial impact associated with this tracking event exception (e.g., cost of delay, damage claim value, re-delivery cost, expedite surcharge). Used for freight cost variance analysis and carrier chargeback management. Expressed in the currency defined by financial_impact_currency.',
    `financial_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount (e.g., USD, EUR, GBP). Required for multi-currency operations across global consumer goods distribution networks.. Valid values are `^[A-Z]{3}$`',
    `geofence_zone` STRING COMMENT 'The named geofence zone or virtual boundary that triggered this tracking event (e.g., CUSTOMER_DC_INBOUND, CARRIER_TERMINAL_CHICAGO, PORT_OF_LA_GATE). Populated for GPS telematics events generated by geofence entry/exit triggers. Supports automated milestone detection without manual carrier check-ins.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'The gps latitude of the tracking event record',
    `gps_longitude` DECIMAL(18,2) COMMENT 'The gps longitude of the tracking event record',
    `humidity_pct` DECIMAL(18,2) COMMENT 'Relative humidity percentage reading captured at the time of the tracking event by an IoT sensor. Relevant for moisture-sensitive consumer goods (e.g., hygiene products, paper-based packaging). Null for shipments without humidity monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84 datum) of the location where the tracking event was recorded by GPS telematics or IoT sensor. Enables precise geospatial mapping of shipment progress and route deviation detection.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84 datum) of the location where the tracking event was recorded by GPS telematics or IoT sensor. Paired with latitude for precise geospatial analysis.',
    `tracking_event_name` STRING COMMENT 'The tracking event name of the tracking event record',
    `notes` STRING COMMENT 'The notes of the tracking event record',
    `planned_event_timestamp` TIMESTAMP COMMENT 'The originally scheduled or planned date and time for this event milestone (e.g., planned pickup time, planned delivery window). Compared against event_timestamp to calculate schedule adherence and On-Time In-Full (OTIF) performance at the event level.',
    `pod_method` STRING COMMENT 'The method by which Proof of Delivery (POD) was captured for a delivered event (electronic signature, paper signature, photo confirmation, or no-signature-required). Supports POD compliance tracking and carrier contract enforcement.. Valid values are `electronic|paper|photo|no_signature_required`',
    `pod_signature_name` STRING COMMENT 'The name of the individual who signed for the delivery at the consignee location, as captured on the Proof of Delivery (POD) document. Populated only for delivered event types. Supports dispute resolution and delivery confirmation.',
    `pro_number` STRING COMMENT 'The carrier-assigned Progressive (PRO) number used to identify and track a freight shipment within the carriers system. Serves as the primary external reference for LTL and TL carrier tracking and freight audit reconciliation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the tracking event record',
    `resolution_action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the exception associated with this tracking event (e.g., REROUTED, REDELIVERY_SCHEDULED, CLAIM_FILED, PRODUCT_QUARANTINED, CARRIER_NOTIFIED, EXPEDITED). Supports exception resolution tracking and SLA compliance measurement. [ENUM-REF-CANDIDATE: REROUTED|REDELIVERY_SCHEDULED|CLAIM_FILED|PRODUCT_QUARANTINED|CARRIER_NOTIFIED|EXPEDITED — promote to reference product]',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time at which the exception associated with this tracking event was resolved or closed. Used to calculate exception resolution cycle time and measure carrier SLA compliance for exception handling.',
    `source_system_code` STRING COMMENT 'The source system code of the tracking event record',
    `speed_kmh` DECIMAL(18,2) COMMENT 'The speed of the transport vehicle in kilometers per hour at the time of the GPS telematics event. Used for route compliance monitoring, driver safety analytics, and detection of unauthorized stops or route deviations. Null for non-GPS-sourced events.',
    `status_category` STRING COMMENT 'The status category of the tracking event record',
    `temperature_breach` BOOLEAN COMMENT 'Indicates whether the temperature reading at this event exceeded the shipments defined cold-chain temperature range (temperature_min_c to temperature_max_c as defined on the parent shipment). True signals a cold-chain compliance violation requiring exception management and potential product quarantine.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient or product temperature reading in degrees Celsius captured at the time of the tracking event by an IoT sensor or cold-chain monitoring device. Critical for cold-chain compliance monitoring of temperature-sensitive consumer goods (e.g., personal care, food, pharmaceutical products). Null for non-cold-chain shipments.',
    `tracking_event_status` STRING COMMENT 'The tracking event status of the tracking event record',
    `tracking_number` STRING COMMENT 'The carrier-issued parcel or shipment tracking number (e.g., UPS, FedEx, USPS tracking number) used for consumer-facing and operational track-and-trace. Distinct from PRO number which is used for freight/LTL.',
    `transport_mode` STRING COMMENT 'The mode of transportation active at the time of this tracking event. Relevant for multi-modal shipments where the mode may change between legs (e.g., ocean to rail to truckload). Drives mode-specific SLA and performance benchmarking. [ENUM-REF-CANDIDATE: truckload|ltl|parcel|rail|ocean|air|intermodal — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the tracking event record',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tracking event record was last modified in the silver layer lakehouse (e.g., due to a carrier correction, status update, or exception resolution). Supports data lineage, audit trail, and change detection for downstream consumers.',
    CONSTRAINT pk_tracking_event PRIMARY KEY(`tracking_event_id`)
) COMMENT 'Real-time or near-real-time shipment tracking event captured from carrier EDI (214/990), GPS telematics, or IoT sensors. Captures event timestamp, shipment/leg reference, event type (picked-up, in-transit, out-for-delivery, delivered, exception, delay, damage, refused), location (city/state/GPS coordinates), carrier event code, temperature reading (cold-chain), exception root cause code, financial impact estimate, resolution action and timestamp, and data source. Powers track-and-trace visibility, cold-chain compliance monitoring, exception management, and carrier performance measurement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` (
    `cold_chain_log_id` BIGINT COMMENT 'Unique surrogate identifier for each cold chain monitoring log record. Primary key for the cold_chain_log data product in the Databricks Silver Layer.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for the transport unit during this monitoring session. Used to attribute excursions to specific carriers for performance management and contract compliance.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the facility to which the cold chain shipment is destined. Used to assess whether excursions occurred in transit versus at origin or destination.',
    `employee_id` BIGINT COMMENT 'Name or user identifier of the person who acknowledged the excursion alert. Required for FDA audit trail and CAPA documentation to establish accountability.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent logistics shipment record for which this cold chain reading was captured. Links the monitoring log to the shipments Bill of Lading, carrier, and route context.',
    `primary_cold_distribution_facility_id` BIGINT COMMENT 'Reference to the facility from which the cold chain shipment originated. Used to correlate excursions with origin facility loading conditions and cold storage practices.',
    `shipment_item_id` BIGINT COMMENT 'The shipment item id of the cold chain log record',
    `shipment_leg_id` BIGINT COMMENT 'Reference to the specific shipment leg or segment within a multi-leg journey during which this sensor reading was recorded. Enables excursion attribution to a specific carrier or transit segment.',
    `transport_unit_id` BIGINT COMMENT 'Identifier of the transport unit (trailer, container, refrigerated truck, or intermodal container) in which the sensor is installed. Used to correlate readings with equipment maintenance records and carrier performance.',
    `alert_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the triggered alert was acknowledged by a responsible party (logistics manager, QA officer, or 3PL coordinator). Used to measure alert response time and compliance with excursion management SLAs.',
    `alert_triggered` BOOLEAN COMMENT 'Indicates whether this reading triggered an automated alert notification to logistics, quality, or operations teams. True = alert was sent. Used to audit alert responsiveness and SLA compliance.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the cold chain log record',
    `cold_chain_log_code` STRING COMMENT 'The cold chain log code of the cold chain log record',
    `cold_chain_log_status` STRING COMMENT 'The cold chain log status of the cold chain log record',
    `corrective_action` STRING COMMENT 'The corrective action of the cold chain log record',
    `corrective_action_taken` STRING COMMENT 'Free-text description of the corrective action taken in response to a detected excursion (e.g., Refrigeration unit reset and temperature restored, Shipment quarantined pending QA review, Product returned to cold storage). Required for FDA compliance documentation and CAPA (Corrective and Preventive Action) records.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action was initiated or completed in response to an excursion. Used to calculate response time and assess compliance with SLA and regulatory requirements for excursion management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cold chain log record was first ingested into the Databricks Silver Layer. Used for data lineage, audit trail, and ETL pipeline monitoring.',
    `currency_code` STRING COMMENT 'The currency code of the cold chain log record',
    `data_logger_report_code` STRING COMMENT 'Unique identifier of the data logger report or download session from which this reading was extracted. Enables traceability back to the original device report file for audit and regulatory submission purposes.',
    `cold_chain_log_description` STRING COMMENT 'The cold chain log description of the cold chain log record',
    `device_type` STRING COMMENT 'The device type of the cold chain log record',
    `effective_from` DATE COMMENT 'The effective from of the cold chain log record',
    `effective_until` DATE COMMENT 'The effective until of the cold chain log record',
    `excursion_duration_minutes` STRING COMMENT 'Cumulative duration in minutes that the shipment has been in an excursion state up to and including this reading. Used to assess product safety impact, Mean Kinetic Temperature (MKT) calculations, and regulatory disposition decisions.',
    `excursion_flag` BOOLEAN COMMENT 'Indicates whether this reading represents a temperature or humidity excursion — i.e., the observed value fell outside the defined min/max thresholds. True = excursion detected. Used to trigger alerts, corrective actions, and FDA compliance documentation.',
    `excursion_severity` STRING COMMENT 'Severity classification of the excursion based on the magnitude of deviation from threshold and duration. Critical = immediate product safety risk; Major = significant deviation requiring QA review; Minor = within acceptable tolerance band; None = no excursion. Drives escalation and corrective action workflows.. Valid values are `critical|major|minor|none`',
    `excursion_type` STRING COMMENT 'Classifies the type of excursion detected at this reading: temperature above maximum threshold (temperature_high), temperature below minimum threshold (temperature_low), humidity above maximum (humidity_high), humidity below minimum (humidity_low), or no excursion (none). Supports root cause analysis and regulatory reporting.. Valid values are `temperature_high|temperature_low|humidity_high|humidity_low|none`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84) of the transport unit at the time of this sensor reading. Enables geospatial mapping of excursion events to identify problematic routes, regions, or transit points.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84) of the transport unit at the time of this sensor reading. Used in conjunction with GPS latitude for geospatial excursion analysis.',
    `humidity_max_threshold_pct` DECIMAL(18,2) COMMENT 'The upper bound relative humidity threshold percentage defined for this shipment or product category. A reading above this value may indicate a humidity excursion risk.',
    `humidity_min_threshold_pct` DECIMAL(18,2) COMMENT 'The lower bound relative humidity threshold percentage defined for this shipment or product category. A reading below this value may indicate a humidity excursion risk.',
    `humidity_pct` DECIMAL(18,2) COMMENT 'Observed relative humidity percentage recorded by the sensor at the reading timestamp. Critical for products sensitive to moisture (e.g., personal care, health products). Used alongside temperature to assess storage condition compliance.',
    `location` STRING COMMENT 'The location of the cold chain log record',
    `log_sequence_number` STRING COMMENT 'Sequential integer representing the order of this reading within the shipments cold chain monitoring session. Enables chronological reconstruction of the temperature/humidity profile for a shipment and detection of data gaps.',
    `log_timestamp` TIMESTAMP COMMENT 'The log timestamp of the cold chain log record',
    `max_threshold_c` DECIMAL(18,2) COMMENT 'The max threshold c of the cold chain log record',
    `max_threshold_celsius` DECIMAL(18,2) COMMENT 'The max threshold celsius of the cold chain log record',
    `mean_kinetic_temp_c` DECIMAL(18,2) COMMENT 'Calculated Mean Kinetic Temperature in degrees Celsius for the shipment up to this reading point. MKT is the single calculated temperature that, if maintained over the storage period, would produce the same thermal challenge as the actual temperature variations. Used for product stability and regulatory disposition decisions.',
    `min_threshold_c` DECIMAL(18,2) COMMENT 'The min threshold c of the cold chain log record',
    `min_threshold_celsius` DECIMAL(18,2) COMMENT 'The min threshold celsius of the cold chain log record',
    `monitoring_session_code` STRING COMMENT 'Identifier grouping all sensor readings belonging to a single continuous monitoring session (from sensor activation to deactivation). Used to reconstruct the complete temperature profile for a shipment and detect session gaps.',
    `cold_chain_log_name` STRING COMMENT 'The cold chain log name of the cold chain log record',
    `notes` STRING COMMENT 'The notes of the cold chain log record',
    `product_temperature_class` STRING COMMENT 'Temperature storage classification of the product(s) in this shipment as defined by product specifications or regulatory requirements. Frozen = below -18°C; Refrigerated = 2–8°C; Controlled Room Temp = 15–25°C; Cool = 8–15°C. Determines applicable thresholds.. Valid values are `frozen|refrigerated|controlled_room_temp|cool`',
    `qa_disposition` STRING COMMENT 'Quality disposition decision made by the QA team for the affected product lot following excursion review. Approved = product released; Rejected = product destroyed or returned; Quarantined = held pending further investigation; Pending Review = awaiting QA decision; Conditionally Approved = released with conditions. Populated only when excursion_flag is True.. Valid values are `approved|rejected|quarantined|pending_review|conditionally_approved`',
    `qa_review_timestamp` TIMESTAMP COMMENT 'Date and time when the QA team completed their review and issued a disposition decision for the excursion event. Used to measure QA response time and compliance with regulatory timelines.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the cold chain log record',
    `reading_interval_seconds` STRING COMMENT 'Configured interval in seconds between consecutive sensor readings for this monitoring session. Typical values range from 60 (1 minute) to 900 (15 minutes). Used to validate data completeness and detect missing readings.',
    `reading_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone offset) at which the sensor captured the temperature and humidity measurement. This is the principal event timestamp for the log record and is critical for FDA cold-chain compliance documentation.',
    `regulatory_report_required` BOOLEAN COMMENT 'Indicates whether this excursion event requires formal regulatory reporting to the FDA or other governing body based on product type, excursion severity, and applicable regulations. True = regulatory report must be filed.',
    `sensor_battery_pct` DECIMAL(18,2) COMMENT 'Remaining battery level of the sensor device at the time of this reading, expressed as a percentage. Used to predict sensor failure risk and ensure data continuity for compliance documentation.',
    `sensor_calibration_date` DATE COMMENT 'Date on which the sensor device was last calibrated. Required for FDA and GMP compliance to ensure measurement accuracy. Readings from uncalibrated or expired-calibration sensors may be flagged for review.',
    `sensor_calibration_due_date` DATE COMMENT 'Date by which the sensor device must next be calibrated to remain compliant. Readings captured after this date may be flagged as non-compliant in regulatory submissions.',
    `sensor_code` STRING COMMENT 'The sensor code of the cold chain log record',
    `sensor_device_code` STRING COMMENT 'Unique identifier of the IoT temperature/humidity sensor device that captured this reading. Used for device traceability, calibration audit, and excursion investigation. Sourced from the sensor manufacturers serial number or asset tag.',
    `sensor_model` STRING COMMENT 'Manufacturer model designation of the sensor device (e.g., Sensitech TempTale 4, Emerson DL8000). Used for device management, calibration scheduling, and accuracy benchmarking.',
    `sensor_placement` STRING COMMENT 'Physical placement location of the sensor within the transport unit (e.g., ambient air, product contact, door panel, floor, ceiling, center load, return air). Affects interpretation of readings and excursion impact assessment. [ENUM-REF-CANDIDATE: ambient|product_contact|door_panel|floor|ceiling|center_load|return_air|none — promote to reference product]',
    `source_system_code` STRING COMMENT 'The source system code of the cold chain log record',
    `temperature_c` DECIMAL(18,2) COMMENT 'Observed temperature value in degrees Celsius recorded by the sensor at the reading timestamp. The principal quantitative measurement for cold-chain compliance monitoring. Used to detect excursions against defined min/max thresholds.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'The temperature celsius of the cold chain log record',
    `temperature_max_threshold_c` DECIMAL(18,2) COMMENT 'The upper bound temperature threshold in degrees Celsius defined for this shipment or product category. A reading above this value triggers a heat excursion flag. Sourced from product specification or regulatory requirement.',
    `temperature_min_threshold_c` DECIMAL(18,2) COMMENT 'The lower bound temperature threshold in degrees Celsius defined for this shipment or product category. A reading below this value triggers a cold excursion flag. Sourced from product specification or regulatory requirement.',
    `transport_unit_type` STRING COMMENT 'Classification of the transport unit used for this cold chain shipment leg. Determines expected temperature maintenance capability and regulatory documentation requirements.. Valid values are `refrigerated_trailer|frozen_trailer|reefer_container|insulated_van|ambient_trailer`',
    `uom` STRING COMMENT 'The uom of the cold chain log record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cold chain log record was last modified (e.g., QA disposition updated, corrective action recorded). Used for change tracking and audit compliance.',
    `veeva_document_reference` STRING COMMENT 'Reference identifier of the associated quality or regulatory document stored in Veeva Vault (e.g., excursion investigation report, CAPA record, regulatory submission). Enables traceability between cold chain log records and formal quality documentation.',
    CONSTRAINT pk_cold_chain_log PRIMARY KEY(`cold_chain_log_id`)
) COMMENT 'Continuous temperature and humidity monitoring log for cold-chain shipments of temperature-sensitive consumer goods (e.g., refrigerated/frozen personal care, health products). Captures shipment/leg reference, sensor device ID, reading timestamp, temperature value, humidity value, min/max thresholds, excursion flag, excursion duration, and corrective action taken. Supports FDA cold-chain compliance and product safety documentation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` (
    `transport_exception_id` BIGINT COMMENT 'Unique surrogate identifier for each transportation exception or disruption event record in the Silver Layer lakehouse. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for the shipment at the time the exception occurred. Used to attribute exceptions to specific carriers for performance scorecard analysis.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Transport exceptions (e.g., hazmat breach) trigger specific compliance obligations; linking enables tracking and reporting of required corrective actions.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane on which the exception occurred. Enables lane-level exception frequency analysis and routing guide optimization.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the logistics shipment record impacted by this exception. Links the exception to the parent shipment for OTIF root-cause analysis and carrier performance scorecards.',
    `source_transport_exception_id` BIGINT COMMENT 'Original exception identifier from the source operational system (SAP S/4HANA, Blue Yonder WMS, or carrier EDI). Preserved for data lineage, reconciliation, and cross-system traceability in the Silver Layer.',
    `tracking_event_id` BIGINT COMMENT 'The tracking event id of the transport exception record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the transport exception record',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the impacted shipment, denormalized for freight audit and carrier claims processing. The BOL is the primary legal document governing the carriers responsibility for the goods.',
    `carrier_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier was formally notified of the exception. Populated when carrier_notified_flag is True. Used to measure carrier response time and SLA compliance.',
    `carrier_notified_flag` BOOLEAN COMMENT 'Indicates whether the carrier has been formally notified of the exception and required resolution actions. True=carrier notification sent. Tracks communication compliance in carrier management processes.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Monetary amount formally claimed against the carrier for the exception event (damage, loss, or delay penalty). May differ from financial_impact_amount if only a portion is recoverable under the carrier contract.',
    `claim_reference_number` STRING COMMENT 'Carrier-assigned or internal reference number for the freight claim associated with this exception. Used to track claim status in freight audit and payment systems.',
    `claim_status` STRING COMMENT 'Current status of the freight claim filed against the carrier for this exception. not_filed=no claim initiated, filed=claim submitted to carrier, under_review=carrier reviewing, approved=carrier accepted liability, rejected=carrier denied claim, settled=financial settlement completed.. Valid values are `not_filed|filed|under_review|approved|rejected|settled`',
    `transport_exception_code` STRING COMMENT 'The transport exception code of the transport exception record',
    `cold_chain_breach_flag` BOOLEAN COMMENT 'Indicates whether the exception involved a breach of cold-chain temperature requirements. True=temperature excursion or cold-chain protocol violation occurred. Triggers regulatory notification and product disposition review per FDA and GMP requirements.',
    `corrective_action` STRING COMMENT 'The corrective action of the transport exception record',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'The cost impact amount of the transport exception record',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this transport exception record was first created in the system. Distinct from exception_timestamp (when the event occurred) and reported_timestamp (when it was reported).',
    `currency_code` STRING COMMENT 'The currency code of the transport exception record',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Estimated or actual duration of the delay in hours caused by the exception. Applicable primarily to delay-type exceptions. Used to calculate OTIF impact and carrier SLA breach severity.',
    `delay_hours` DECIMAL(18,2) COMMENT 'The delay hours of the transport exception record',
    `transport_exception_description` STRING COMMENT 'The transport exception description of the transport exception record',
    `effective_from` DATE COMMENT 'The effective from of the transport exception record',
    `effective_until` DATE COMMENT 'The effective until of the transport exception record',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this exception has been escalated to management or carrier leadership due to severity, financial impact, or SLA breach. True=exception is escalated. Drives priority queue routing in exception management workflows.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception was escalated to management or carrier leadership. Populated only when escalation_flag is True. Used to measure escalation response time.',
    `exception_category` STRING COMMENT 'The exception category of the transport exception record',
    `exception_code` STRING COMMENT 'The exception code of the transport exception record',
    `exception_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the transportation exception occurred. Used for cross-border exception analysis and regulatory compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `exception_description` STRING COMMENT 'The exception description of the transport exception record',
    `exception_location` STRING COMMENT 'Geographic location (city, facility, port, or GPS coordinate description) where the transportation exception was identified or occurred. Critical for route-level exception analysis and cold-chain compliance investigations.',
    `exception_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the transportation exception event. Used in carrier communications, freight audit correspondence, and claims processing. Format: EXC- followed by 10 digits.. Valid values are `^EXC-[0-9]{10}$`',
    `exception_severity` STRING COMMENT 'The exception severity of the transport exception record',
    `exception_status` STRING COMMENT 'Current lifecycle state of the transportation exception record. Drives workflow routing and SLA tracking. open=newly identified, in_progress=resolution underway, resolved=corrective action taken, closed=fully closed with no further action, escalated=elevated to management or carrier leadership.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `exception_subtype` STRING COMMENT 'Secondary classification providing granular detail within the exception type (e.g., partial_damage, temperature_excursion, missed_pickup, customs_hold, driver_no_show, equipment_failure). [ENUM-REF-CANDIDATE: partial_damage|temperature_excursion|missed_pickup|customs_hold|driver_no_show|equipment_failure|address_error|capacity_constraint — promote to reference product]',
    `exception_timestamp` TIMESTAMP COMMENT 'The principal real-world timestamp when the transportation exception was first identified or occurred. This is the business event time, distinct from the record creation audit timestamp. Used as the primary time dimension for OTIF root-cause analysis.',
    `exception_type` STRING COMMENT 'Primary classification of the transportation exception. Drives routing to resolution workflows and feeds OTIF root-cause analysis. Values: delay (shipment not delivered on time), damage (goods damaged in transit), lost (shipment cannot be located), refused (delivery refused by consignee), weather (weather-related disruption), carrier_failure (carrier operational failure).. Valid values are `delay|damage|lost|refused|weather|carrier_failure`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or confirmed financial impact of the transportation exception in the stated currency. Includes freight cost premiums, expediting costs, product loss value, and customer penalty exposure. Used for carrier claims and cost-to-serve analysis.',
    `financial_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the financial_impact_amount (e.g., USD, EUR, GBP). Required for multi-currency financial consolidation and reporting.. Valid values are `^[A-Z]{3}$`',
    `hazmat_involved_flag` BOOLEAN COMMENT 'Indicates whether the exception involved a shipment containing hazardous materials. True=hazmat goods were part of the impacted shipment. Triggers mandatory regulatory incident reporting to EPA, DOT, and OSHA.',
    `impact_description` STRING COMMENT 'The impact description of the transport exception record',
    `transport_exception_name` STRING COMMENT 'The transport exception name of the transport exception record',
    `notes` STRING COMMENT 'The notes of the transport exception record',
    `otif_impact_flag` BOOLEAN COMMENT 'Indicates whether this exception caused a breach of the On Time In Full (OTIF) delivery commitment for the associated shipment. True=OTIF KPI was negatively impacted; False=exception resolved without OTIF breach. Feeds OTIF root-cause analysis dashboards.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number for the shipment, used to track the exception with the carriers own systems during claims and resolution communications.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the transport exception record',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this exception requires formal notification to a regulatory authority (FDA, EPA, CPSC, DOT, etc.). True=regulatory notification must be filed. Driven by hazmat_involved_flag, cold_chain_breach_flag, or product safety classification.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the required regulatory notification was submitted to the relevant authority. Populated only when regulatory_notification_required is True. Used for compliance audit trails.',
    `reported_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception was formally reported into the transportation management system by the carrier, driver, or logistics coordinator. May differ from exception_timestamp if there is a reporting lag.',
    `resolution_action_code` STRING COMMENT 'Standardized code for the corrective action taken to resolve the exception (e.g., RA001=rerouted shipment, RA002=replacement shipment dispatched, RA003=carrier claim filed, RA004=delivery rescheduled, RA005=goods returned to origin). [ENUM-REF-CANDIDATE: RA001|RA002|RA003|RA004|RA005|RA006|RA007 — promote to reference product]',
    `resolution_action_notes` STRING COMMENT 'Free-text description of the specific corrective action taken to resolve the transportation exception. Supplements the resolution_action_code with operational detail for audit and continuous improvement purposes.',
    `resolution_status` STRING COMMENT 'The resolution status of the transport exception record',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the transportation exception was resolved and corrective action was confirmed complete. Used to calculate exception resolution cycle time and carrier SLA compliance.',
    `resolved_timestamp` TIMESTAMP COMMENT 'The resolved timestamp of the transport exception record',
    `responsible_party` STRING COMMENT 'The responsible party of the transport exception record',
    `root_cause` STRING COMMENT 'The root cause of the transport exception record',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the transportation exception as determined during investigation. Used for systemic trend analysis and carrier performance scorecards. Examples: RC001=carrier capacity, RC002=weather event, RC003=customs delay, RC004=equipment breakdown, RC005=incorrect address. [ENUM-REF-CANDIDATE: RC001|RC002|RC003|RC004|RC005|RC006|RC007|RC008 — promote to reference product]',
    `root_cause_description` STRING COMMENT 'Free-text narrative description of the root cause of the transportation exception, providing context beyond the standardized root_cause_code. Captured by the logistics coordinator or carrier representative during investigation.',
    `severity` STRING COMMENT 'The severity of the transport exception record',
    `severity_level` STRING COMMENT 'Business-assessed severity of the exception based on financial impact, customer impact, and regulatory risk. critical=immediate executive escalation required, high=same-day resolution required, medium=resolution within SLA window, low=informational tracking only.. Valid values are `critical|high|medium|low`',
    `shipment_number` STRING COMMENT 'Human-readable shipment reference number from the transportation management system (TMS) or ERP, denormalized here for operational convenience in exception reporting and carrier communications without requiring a join to the shipment table.',
    `source_system_code` STRING COMMENT 'The source system code of the transport exception record',
    `temperature_excursion_max_c` DECIMAL(18,2) COMMENT 'Maximum recorded temperature in Celsius during the cold-chain breach event. Populated only when cold_chain_breach_flag is True. Used alongside temperature_excursion_min_c for product disposition and regulatory reporting.',
    `temperature_excursion_min_c` DECIMAL(18,2) COMMENT 'Minimum recorded temperature in Celsius during the cold-chain breach event. Populated only when cold_chain_breach_flag is True. Used for product disposition decisions and regulatory reporting.',
    `transport_exception_status` STRING COMMENT 'The transport exception status of the transport exception record',
    `transport_mode` STRING COMMENT 'Mode of transportation on which the exception occurred. Denormalized from the shipment for exception frequency analysis by mode. road=truck/LTL/FTL, rail=rail freight, ocean=sea freight, air=air freight, intermodal=multi-mode, parcel=small parcel/courier.. Valid values are `road|rail|ocean|air|intermodal|parcel`',
    `uom` STRING COMMENT 'The uom of the transport exception record',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this transport exception record was last modified. Tracks the most recent update to status, resolution details, or financial impact estimates.',
    CONSTRAINT pk_transport_exception PRIMARY KEY(`transport_exception_id`)
) COMMENT 'Record of a transportation exception or disruption event impacting a shipment or delivery. Captures exception type (delay, damage, lost, refused, weather, carrier failure), exception timestamp, shipment/delivery reference, root cause code, financial impact estimate, resolution action taken, resolution timestamp, and exception status. Feeds OTIF root-cause analysis and carrier performance scorecards.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` (
    `carrier_performance_id` BIGINT COMMENT 'Unique surrogate identifier for each carrier performance scorecard record in the Silver Layer lakehouse.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier master record for which this performance scorecard is being measured.',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the logistics analyst or manager who reviewed and approved this scorecard before publication.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` (
    `third_party_provider_id` BIGINT COMMENT 'Primary key for third_party_provider',
    `supplier_id` BIGINT COMMENT 'Vendor account number assigned to the 3PL provider in the ERP system (SAP S/4HANA MM Vendor Master or Oracle Cloud Supplier). Used to link logistics provider records to financial transactions, purchase orders, and invoice processing workflows.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the third party provider record',
    `api_endpoint_url` STRING COMMENT 'Base URL of the 3PL providers API endpoint used for real-time track-and-trace, shipment status updates, and capacity queries. Applicable when integration_method is API. Stored securely; used by Consumer Goods integration middleware for automated data exchange.',
    `certification_level` STRING COMMENT 'The certification level of the third party provider record',
    `claims_resolution_sla_days` STRING COMMENT 'Maximum number of calendar days within which the 3PL provider is contractually obligated to resolve freight damage or loss claims. Used for claims management SLA tracking and financial recovery monitoring.',
    `third_party_provider_code` STRING COMMENT 'The third party provider code of the third party provider record',
    `cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the 3PL provider is certified and operationally equipped to handle temperature-controlled (cold chain) shipments. True = cold chain capable; False = ambient/dry only. Critical for routing perishable consumer goods, health, and personal care products requiring temperature integrity.',
    `contact_email` STRING COMMENT 'The contact email of the third party provider record',
    `contact_name` STRING COMMENT 'The contact name of the third party provider record',
    `contact_phone` STRING COMMENT 'The contact phone of the third party provider record',
    `contract_end_date` DATE COMMENT 'Date on which the master service agreement with the 3PL provider expires. Null indicates an open-ended evergreen contract. Used to trigger renewal workflows, renegotiation alerts, and provider transition planning.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the master service agreement (MSA) or logistics services contract governing the 3PL relationship. Links to the contract management system (SAP CLM or Oracle Procurement Contracts) for terms, pricing schedules, and SLA annexures.',
    `contract_start_date` DATE COMMENT 'Date on which the master service agreement with the 3PL provider becomes effective and services may commence. Used for contract lifecycle management, renewal tracking, and SLA enforcement windows.',
    `contract_status` STRING COMMENT 'The contract status of the third party provider record',
    `country_code` STRING COMMENT 'The country code of the third party provider record',
    `country_of_registration` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the 3PL provider is legally incorporated or registered. Used for regulatory compliance, trade compliance screening, and financial reporting (e.g., withholding tax determination).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the 3PL provider master record was first created in the Consumer Goods data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and record lifecycle management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which freight charges and financial settlements with this 3PL provider are denominated (e.g., USD, EUR, GBP). Used for multi-currency freight cost reporting and FX exposure management.. Valid values are `^[A-Z]{3}$`',
    `third_party_provider_description` STRING COMMENT 'The third party provider description of the third party provider record',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) number uniquely identifying the 3PL providers legal entity globally. Used for financial due diligence, credit risk assessment, and supplier onboarding validation in Oracle Cloud Procurement.. Valid values are `^[0-9]{9}$`',
    `edi_code` STRING COMMENT 'EDI partner identifier used in ISA segment of EDI transmissions to uniquely identify the 3PL as a trading partner. Combined with edi_qualifier to form the complete EDI address. Required for automated shipment tendering, status updates, and freight invoice processing.',
    `edi_qualifier` STRING COMMENT 'EDI interchange qualifier code identifying the 3PL in EDI transmissions (e.g., 01 for DUNS, 02 for SCAC, ZZ for mutually defined). Required for EDI 204 (Motor Carrier Load Tender), 214 (Shipment Status), and 210 (Freight Invoice) message routing.',
    `effective_from` DATE COMMENT 'The effective from of the third party provider record',
    `effective_until` DATE COMMENT 'The effective until of the third party provider record',
    `escalation_contact_email` STRING COMMENT 'Email address of the senior escalation contact (e.g., account manager or operations director) at the 3PL provider. Used when primary contact is unresponsive or for critical SLA breach escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `geographic_coverage` STRING COMMENT 'Description of the geographic regions, countries, or trade lanes covered by this 3PL provider (e.g., North America, EU + UK, APAC excluding China). Used for lane assignment, network design, and provider selection in logistics planning. Free-text to accommodate complex multi-region scopes.',
    `hazmat_cert_expiry_date` DATE COMMENT 'Expiry date of the 3PL providers hazardous materials handling certification. Null if hazmat_certified is False. Used to trigger recertification alerts and prevent routing of hazmat shipments to providers with lapsed certifications.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the 3PL provider holds valid certification to handle, transport, and store hazardous materials (e.g., flammable aerosols, chemical cleaning agents). True = hazmat certified; False = not certified. Required for routing consumer goods products classified as dangerous goods.',
    `headquarters_city` STRING COMMENT 'City where the 3PL providers global or regional headquarters is located. Used for geographic segmentation, time-zone-aware SLA management, and regulatory jurisdiction determination.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the 3PL providers headquarters is located. Used for sanctions screening, trade compliance, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `insurance_cargo_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount of the 3PL providers cargo/freight insurance policy in the contract currency. Determines the maximum recoverable value for lost or damaged shipments. Used in freight claims processing and risk exposure analysis.',
    `insurance_expiry_date` DATE COMMENT 'Expiry date of the 3PL providers insurance coverage (both liability and cargo). Used to trigger renewal alerts and enforce the contractual requirement that valid insurance is maintained throughout the service period.',
    `insurance_liability_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount of the 3PL providers general liability insurance policy in the contract currency. Used for risk assessment, contract compliance validation, and claims recovery ceiling determination.',
    `integration_method` STRING COMMENT 'Primary method used for electronic data interchange between Consumer Goods systems and the 3PL provider. EDI: ANSI X12 or EDIFACT message sets; API: REST/SOAP web services; portal: manual web portal entry; email: unstructured email exchange; ftp: file-based batch transfer. Drives integration architecture and operational SLA for data latency.. Valid values are `EDI|API|portal|email|ftp`',
    `is_preferred` BOOLEAN COMMENT 'The is preferred of the third party provider record',
    `legal_name` STRING COMMENT 'Full legal registered name of the 3PL provider as recorded in official business registration documents. Used for contract execution, regulatory filings, and financial settlement. Must match the name on the master service agreement.',
    `third_party_provider_name` STRING COMMENT 'The third party provider name of the third party provider record',
    `network_region` STRING COMMENT 'Primary geographic network region in which this 3PL provider operates for Consumer Goods. Used for regional logistics cost allocation, network design analytics, and regional SLA benchmarking in SAP IBP and supply chain planning tools.. Valid values are `north_america|europe|asia_pacific|latin_america|middle_east_africa|global`',
    `notes` STRING COMMENT 'The notes of the third party provider record',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Contractually committed OTIF delivery performance target for this 3PL provider, expressed as a percentage (e.g., 98.50 = 98.5%). OTIF measures the percentage of shipments delivered on time and in full quantity. Used as the baseline for SLA compliance monitoring and penalty/incentive calculations.',
    `payment_terms` STRING COMMENT 'Contractually agreed payment terms for freight invoices submitted by the 3PL provider (e.g., NET30 = payment due 30 days from invoice date). Used in accounts payable processing, cash flow planning, and DSO management in Oracle Cloud Financials.. Valid values are `NET30|NET45|NET60|NET90|immediate`',
    `performance_rating` STRING COMMENT 'The performance rating of the third party provider record',
    `performance_tier` STRING COMMENT 'Operational performance classification assigned to the 3PL based on SLA attainment, OTIF scores, and audit results. preferred: top-tier, first-choice allocation; approved: standard eligible provider; conditional: eligible with restrictions; probationary: under performance improvement plan. Drives routing guide prioritization.. Valid values are `preferred|approved|conditional|probationary`',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary operational contact at the 3PL provider. Used for shipment notifications, exception alerts, and SLA reporting communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the 3PL provider responsible for day-to-day operational coordination with Consumer Goods logistics teams. Used for escalation routing and relationship management.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary operational contact at the 3PL provider. Used for urgent operational escalations, exception management, and after-hours incident response.',
    `provider_code` STRING COMMENT 'Internally assigned alphanumeric code uniquely identifying the 3PL provider across Consumer Goods systems (SAP S/4HANA vendor master, Oracle Cloud Procurement). Used as the business key for cross-system reconciliation and EDI partner identification.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `provider_name` STRING COMMENT 'The provider name of the third party provider record',
    `provider_status` STRING COMMENT 'Current lifecycle status of the 3PL provider relationship. active: fully operational and eligible for shipment assignment; onboarding: in setup/qualification phase; suspended: temporarily blocked (e.g., SLA breach, compliance issue); terminated: contract ended; inactive: not currently engaged.. Valid values are `active|inactive|onboarding|suspended|terminated`',
    `provider_type` STRING COMMENT 'Classification of the logistics provider by operational model. 3PL: outsourced logistics services; 4PL: manages other 3PLs on behalf of Consumer Goods; lead_logistics: single-point orchestrator; freight_broker: arranges carrier capacity; customs_broker: specializes in import/export clearance.. Valid values are `3PL|4PL|lead_logistics|freight_broker|customs_broker`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the third party provider record',
    `region_coverage` STRING COMMENT 'The region coverage of the third party provider record',
    `service_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing countries where this 3PL is operationally active (e.g., USA,CAN,MEX). Used for automated lane-to-provider matching, cross-border compliance checks, and network coverage analytics.',
    `service_scope` STRING COMMENT 'Pipe-delimited list of logistics service categories provided by this 3PL (e.g., transportation|warehousing|customs|last_mile|value_added_services|cold_chain|reverse_logistics). Drives service assignment logic in Blue Yonder WMS and SAP TM. [ENUM-REF-CANDIDATE: transportation|warehousing|customs|last_mile|value_added_services|cold_chain|reverse_logistics|cross_docking|freight_forwarding — promote to reference product]',
    `services_offered` STRING COMMENT 'The services offered of the third party provider record',
    `source_system_code` STRING COMMENT 'The source system code of the third party provider record',
    `tax_number` STRING COMMENT 'Government-issued tax identification number (EIN/TIN/VAT number) for the 3PL providers legal entity. Required for accounts payable processing, 1099/tax reporting, and regulatory compliance. Format varies by country of registration.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius that the 3PL provider can maintain across its cold chain network (e.g., 8.00 for refrigerated). Null if cold_chain_capable is False. Used for product-to-provider matching for temperature-sensitive SKUs.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius that the 3PL provider can maintain across its cold chain network (e.g., -25.00 for frozen). Null if cold_chain_capable is False. Used for product-to-provider matching for temperature-sensitive SKUs.',
    `third_party_provider_status` STRING COMMENT 'The third party provider status of the third party provider record',
    `tracking_url_template` STRING COMMENT 'URL template for the 3PLs public or partner-facing shipment tracking portal. Contains a placeholder (e.g., {tracking_number}) that is substituted at runtime to generate a direct tracking link. Used in customer-facing notifications and internal track-and-trace dashboards.',
    `trade_name` STRING COMMENT 'Operating or brand name of the 3PL provider as commonly known in the market (e.g., XYZ Logistics vs. legal entity XYZ Global Supply Chain Solutions Inc.). Used in operational communications, reporting dashboards, and carrier/partner directories.',
    `transport_modes` STRING COMMENT 'Pipe-delimited list of transport modes the 3PL is certified and operationally capable of managing (e.g., road|rail|ocean|air|intermodal|last_mile). Used for multi-modal shipment planning and carrier/3PL selection in SAP TM and Blue Yonder. [ENUM-REF-CANDIDATE: road|rail|ocean|air|intermodal|last_mile|barge|pipeline — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the third party provider record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the 3PL provider master record. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), data freshness monitoring, and audit compliance.',
    CONSTRAINT pk_third_party_provider PRIMARY KEY(`third_party_provider_id`)
) COMMENT 'Master record for 3PL (Third-Party Logistics) providers engaged by Consumer Goods for outsourced transportation, warehousing, or value-added logistics services. Captures 3PL provider name, service scope (transport/warehousing/customs/last-mile), geographic coverage, contract reference, SLA commitments, system integration method (EDI/API), performance tier, and operational status. Distinct from individual carriers — 3PLs manage multi-modal networks on behalf of Consumer Goods.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique surrogate identifier for the customs declaration record in the lakehouse silver layer. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'The carrier id of the customs declaration record',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the customs declaration record',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the logistics shipment record associated with this customs declaration. Links the declaration to the physical cross-border movement.',
    `third_party_provider_id` BIGINT COMMENT 'Reference to the licensed customs broker or freight forwarder party responsible for preparing and filing this declaration on behalf of the importer/exporter.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the customs declaration record',
    `ams_reference_number` STRING COMMENT 'Reference number from the U.S. CBP Automated Manifest System (AMS) or equivalent advance cargo notification system (e.g., EU ICS2). Required for pre-arrival security filing for ocean and air shipments.',
    `anti_dumping_case_number` STRING COMMENT 'Reference number for an applicable anti-dumping or countervailing duty (ADD/CVD) order affecting the declared goods. Triggers additional duty assessment beyond standard tariff rates.',
    `bond_number` STRING COMMENT 'Reference number of the customs bond (surety bond) guaranteeing payment of duties and taxes. Required for U.S. formal entries and other jurisdictions requiring financial security for customs obligations.',
    `broker_name` STRING COMMENT 'The broker name of the customs declaration record',
    `broker_reference_number` STRING COMMENT 'The customs brokers own internal reference number for this declaration filing. Used for reconciliation with broker invoices and correspondence.',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the Certificate of Origin document supporting preferential duty treatment claims under a trade agreement. Required when trade_agreement_code is populated.',
    `clearance_date` DATE COMMENT 'The clearance date of the customs declaration record',
    `clearance_timestamp` TIMESTAMP COMMENT 'Date and time when the customs authority officially cleared and released the shipment. Null if clearance has not yet occurred. Critical for OTIF tracking and logistics planning.',
    `customs_declaration_code` STRING COMMENT 'The customs declaration code of the customs declaration record',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the goods were manufactured or substantially transformed. May differ from origin_country_code (country of export). Determines preferential duty treatment and trade agreement applicability.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this customs declaration record was first created in the system. Used for data lineage and audit trail compliance.',
    `currency_code` STRING COMMENT 'The currency code of the customs declaration record',
    `customs_broker` STRING COMMENT 'The customs broker of the customs declaration record',
    `customs_declaration_status` STRING COMMENT 'The customs declaration status of the customs declaration record',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'The customs value amount of the customs declaration record',
    `declaration_date` DATE COMMENT 'The declaration date of the customs declaration record',
    `declaration_number` STRING COMMENT 'Externally-known official customs declaration number assigned by the customs authority or filing system (e.g., Entry Number in US CBP, MRN in EU). This is the primary business identifier used in regulatory correspondence and audit trails.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the customs declaration as reported by the customs authority or broker. Drives operational actions such as release of goods, duty payment, or compliance escalation. [ENUM-REF-CANDIDATE: draft|filed|accepted|held|cleared|released|rejected — promote to reference product]',
    `declaration_type` STRING COMMENT 'Classification of the customs declaration indicating the direction and nature of the cross-border movement. Drives applicable regulatory requirements and duty calculations.. Valid values are `import|export|transit|re-export|re-import`',
    `declared_value` DECIMAL(18,2) COMMENT 'The declared value of the customs declaration record',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'The gross declared value of the goods as submitted to customs authorities, used as the basis for ad valorem duty and tax calculations. Expressed in the declared currency. Must comply with WCO Transaction Value method.',
    `declared_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the declared customs value amount (e.g., USD, EUR, GBP). Required for duty calculation and currency conversion by customs authorities.. Valid values are `^[A-Z]{3}$`',
    `customs_declaration_description` STRING COMMENT 'The customs declaration description of the customs declaration record',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country into which the goods are being imported or delivered. Determines applicable customs regime, duty rates, and import restrictions.. Valid values are `^[A-Z]{3}$`',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total import or export duty assessed by the customs authority on the declared goods. Expressed in the duty currency. Includes ad valorem and specific duties as applicable.',
    `duty_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which duty and tax amounts are assessed and payable to the customs authority.. Valid values are `^[A-Z]{3}$`',
    `duty_rate_pct` DECIMAL(18,2) COMMENT 'The applicable ad valorem duty rate percentage applied to the declared value to calculate the duty amount. Sourced from the applicable tariff schedule for the HS code and country pair.',
    `effective_from` DATE COMMENT 'The effective from of the customs declaration record',
    `effective_until` DATE COMMENT 'The effective until of the customs declaration record',
    `examination_type` STRING COMMENT 'Type of customs examination applied to the shipment (e.g., document review, physical inspection, laboratory testing). Drives expected clearance delay and compliance action requirements.. Valid values are `none|document|physical|laboratory|intensive`',
    `export_country_code` STRING COMMENT 'The export country code of the customs declaration record',
    `export_license_number` STRING COMMENT 'Government-issued export license or authorization number required for controlled goods subject to export regulations. Required for dual-use goods, hazardous materials, or goods subject to trade sanctions.',
    `exporter_of_record` STRING COMMENT 'Legal name of the entity designated as the Exporter of Record (EOR) responsible for export compliance, filing export declarations, and maintaining export records.',
    `filed_timestamp` TIMESTAMP COMMENT 'The principal business event timestamp recording when the customs declaration was officially submitted to the customs authority. Used for regulatory compliance tracking and SLA measurement.',
    `free_trade_zone_flag` BOOLEAN COMMENT 'Indicates whether the goods are entering or exiting a Free Trade Zone (FTZ) or Special Economic Zone (SEZ), which may affect duty suspension, deferral, or exemption treatment.',
    `goods_description` STRING COMMENT 'Official textual description of the goods as declared to customs authorities. Must accurately describe the nature, composition, and intended use of the products. Used for HS code validation and customs examination.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the declared goods including packaging, expressed in kilograms. Required field on customs declarations for duty calculation and transport documentation.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the declared goods are classified as hazardous materials requiring special customs handling, documentation (e.g., SDS), and regulatory compliance under IATA DGR, IMDG, or ADR regulations.',
    `hs_code` STRING COMMENT 'The primary Harmonized System (HS) tariff classification code assigned to the goods in this declaration. A 6-10 digit code per WCO Harmonized System nomenclature used to determine applicable duty rates, import restrictions, and trade statistics. For multi-line declarations, this represents the primary or header-level HS code.. Valid values are `^[0-9]{6,10}$`',
    `import_country_code` STRING COMMENT 'The import country code of the customs declaration record',
    `import_license_number` STRING COMMENT 'Government-issued import license or permit number required for regulated goods (e.g., FDA-regulated consumer products, EPA-regulated chemicals, CPSC-regulated items). Required for customs clearance of controlled product categories.',
    `importer_of_record` STRING COMMENT 'Legal name of the entity designated as the Importer of Record (IOR) responsible for ensuring goods comply with all import laws and regulations and for paying applicable duties and taxes.',
    `incoterms` STRING COMMENT 'The incoterms of the customs declaration record',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the allocation of costs, risks, and responsibilities between buyer and seller for the shipment. Determines the customs value basis (e.g., CIF vs FOB) used for duty calculation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_required` BOOLEAN COMMENT 'The inspection required of the customs declaration record',
    `inspection_status` STRING COMMENT 'The inspection status of the customs declaration record',
    `customs_declaration_name` STRING COMMENT 'The customs declaration name of the customs declaration record',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the declared goods excluding packaging, expressed in kilograms. Used for specific duty calculations, statistical reporting, and product compliance verification.',
    `notes` STRING COMMENT 'The notes of the customs declaration record',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country from which the goods originate or are exported. Used for duty rate determination, trade agreement eligibility, and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `port_of_entry` STRING COMMENT 'The port of entry of the customs declaration record',
    `port_of_entry_code` STRING COMMENT 'Official code of the customs port or border crossing point where the goods enter the destination country (e.g., UN/LOCODE, U.S. CBP Port Code). Used for routing, examination scheduling, and regulatory reporting.',
    `port_of_export_code` STRING COMMENT 'Official code of the customs port or border crossing point from which the goods are exported from the origin country (e.g., UN/LOCODE). Used for export declaration filing and trade statistics.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the customs declaration record',
    `quantity_declared` DECIMAL(18,2) COMMENT 'Quantity of goods declared to customs in the applicable unit of measure (e.g., units, liters, kilograms). Used for specific duty calculations and statistical reporting.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the declared quantity (e.g., EA=Each, KG=Kilogram, L=Liter). Must align with the WCO supplementary unit for the declared HS code. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|DZ|GR — 8 candidates stripped; promote to reference product]',
    `regulatory_hold_reason` STRING COMMENT 'Description of the reason for a customs hold or examination, such as FDA import alert, CPSC safety review, missing documentation, or random inspection. Populated when declaration_status is held.',
    `source_system_code` STRING COMMENT 'The source system code of the customs declaration record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes assessed at the border in addition to customs duties, such as VAT, GST, excise tax, or other import levies. Expressed in the duty currency.',
    `trade_agreement_code` STRING COMMENT 'Code identifying the preferential trade agreement under which reduced or zero duty rates are claimed (e.g., USMCA, EU-UK TCA, CPTPP, RCEP). Null if no preferential treatment is claimed.',
    `transport_mode` STRING COMMENT 'Mode of transport used for the cross-border shipment as declared to customs. Determines applicable customs procedures, documentation requirements, and transit time expectations.. Valid values are `air|ocean|road|rail|multimodal`',
    `uom` STRING COMMENT 'The uom of the customs declaration record',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this customs declaration record was last modified. Used for change tracking, data lineage, and audit compliance.',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'International customs and trade compliance declaration record for cross-border shipments. Captures declaration number, shipment reference, origin and destination countries, HS (Harmonized System) codes, declared value, currency, incoterms, customs broker reference, import/export license numbers, duty and tax amounts, customs status (filed/cleared/held/released), and clearance timestamp. Supports regulatory compliance for international logistics.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` (
    `freight_cost_id` BIGINT COMMENT 'Unique surrogate identifier for each freight cost record at the shipment or shipment-leg level. Primary key for the freight_cost data product.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract under which this freight cost was incurred. Enables rate compliance validation and contract utilization tracking.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for executing the freight movement associated with this cost record. Used for carrier cost benchmarking and contract compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Enables cost center allocation of freight costs for internal cost control and reporting.',
    `freight_order_id` BIGINT COMMENT 'The freight order id of the freight cost record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links freight cost records to GL account for accurate financial consolidation of transportation expenses.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane associated with this freight cost. Supports lane-level cost benchmarking against standard rates.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent logistics shipment record to which this freight cost is attributed. Links cost to the shipment header for COGS freight component analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit center attribution of freight costs to assess logistics impact on product line profitability.',
    `accrual_flag` BOOLEAN COMMENT 'Indicates whether this freight cost record represents an accrued (estimated) cost rather than an actual invoiced amount. True = accrual entry; False = actual invoiced cost. Critical for COGS freight component accuracy in period-end close.',
    `allocated_to` STRING COMMENT 'The allocated to of the freight cost record',
    `allocation_basis` STRING COMMENT 'Method used to allocate or apportion this freight cost across shipment lines or cost centers. Weight = allocated by gross weight (kg); Volume = allocated by cubic volume (m3); Value = allocated by declared goods value; Units = allocated by case/unit count; Flat = fixed charge not allocated; Distance = allocated by route distance (km).. Valid values are `weight|volume|value|units|flat|distance`',
    `allocation_method` STRING COMMENT 'The allocation method of the freight cost record',
    `allocation_quantity` DECIMAL(18,2) COMMENT 'The quantity value used as the basis for cost allocation (e.g., weight in kg, volume in m3, declared value in currency, number of cases). Paired with allocation_basis and allocation_uom to fully describe the allocation driver.',
    `allocation_uom` STRING COMMENT 'Unit of measure corresponding to the allocation_quantity field. KG = kilograms (weight basis); M3 = cubic meters (volume basis); USD = US Dollars (value basis); EA = each/cases (unit basis); KM = kilometers (distance basis); PCT = percentage (proportional basis).. Valid values are `KG|M3|USD|EA|KM|PCT`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the freight cost record',
    `audit_discrepancy_amount` DECIMAL(18,2) COMMENT 'Monetary difference identified during freight audit between the carrier-invoiced amount and the expected contractual amount. Positive = carrier overcharged; Negative = carrier undercharged. Drives dispute and recovery actions.',
    `billing_period` STRING COMMENT 'Accounting period (YYYY-MM) in which this freight cost is recognized for financial reporting. Used for period-end accrual matching and monthly freight cost trend analysis.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The weight used by the carrier for billing purposes, which is the greater of actual gross weight and dimensional (volumetric) weight. Critical for air and parcel freight rate validation and audit.',
    `freight_cost_code` STRING COMMENT 'The freight cost code of the freight cost record',
    `cold_chain_premium_amount` DECIMAL(18,2) COMMENT 'Additional freight cost premium charged for temperature-controlled (cold chain) transportation. Applicable for perishable consumer goods, health, and personal care products requiring refrigerated or frozen transport.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Gross freight cost amount in the transaction currency for this cost category and shipment. Represents the base charge before any adjustments or credits. Core monetary field for logistics cost-to-serve analysis.',
    `cost_amount_usd` DECIMAL(18,2) COMMENT 'Freight cost amount converted to US Dollars using the exchange rate at the time of cost recognition. Enables global freight cost consolidation and cross-currency benchmarking.',
    `cost_basis` STRING COMMENT 'The cost basis of the freight cost record',
    `cost_category` STRING COMMENT 'Classification of the freight cost type. Line-haul covers base transportation; fuel surcharge is the carrier fuel adjustment; accessorial covers detention, liftgate, residential delivery; customs duty covers import/export tariffs; insurance covers cargo coverage premiums. [ENUM-REF-CANDIDATE: line_haul|fuel_surcharge|accessorial|customs_duty|insurance|other — promote to reference product if additional categories are needed]. Valid values are `line_haul|fuel_surcharge|accessorial|customs_duty|insurance|other`',
    `cost_currency_code` STRING COMMENT 'The cost currency code of the freight cost record',
    `cost_document_number` STRING COMMENT 'Externally-known business identifier for this freight cost record, typically sourced from the freight audit or ERP system (e.g., SAP FI document number or freight invoice reference). Used for reconciliation and audit trail.',
    `cost_recognition_date` DATE COMMENT 'The principal business event date on which this freight cost is recognized in the financial system. For accruals, this is the estimated service completion date; for actuals, this is the invoice posting date.',
    `cost_status` STRING COMMENT 'Current lifecycle status of the freight cost record. Accrued = estimated cost booked before invoice; Invoiced = carrier invoice received; Approved = freight audit approved for payment; Disputed = charge under dispute; Paid = payment issued; Reversed = cost entry reversed or cancelled.. Valid values are `accrued|invoiced|approved|disputed|paid|reversed`',
    `cost_sub_category` STRING COMMENT 'Granular classification within the cost category (e.g., detention, liftgate, residential delivery, hazmat surcharge, cold-chain premium, oversize, re-delivery). Enables detailed cost-to-serve analysis by accessorial type.',
    `cost_type` STRING COMMENT 'The cost type of the freight cost record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight cost record was first created in the system. Used for audit trail, data lineage, and period-end accrual timing validation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_amount, standard_cost_amount, and variance_amount fields (e.g., USD, EUR, GBP). Enables multi-currency freight cost consolidation.. Valid values are `^[A-Z]{3}$`',
    `freight_cost_description` STRING COMMENT 'The freight cost description of the freight cost record',
    `dispute_reference` STRING COMMENT 'Reference number for a formal freight cost dispute raised with the carrier. Populated when freight_audit_status = disputed. Used to track dispute resolution and recovery amounts.',
    `effective_from` DATE COMMENT 'The effective from of the freight cost record',
    `effective_until` DATE COMMENT 'The effective until of the freight cost record',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert cost_amount from transaction currency to USD at the time of cost recognition. Sourced from the ERP FX rate table.',
    `freight_audit_status` STRING COMMENT 'Status of the freight audit process for this cost record. Pending = awaiting audit review; Passed = audit confirmed charge is correct; Failed = audit identified discrepancy; Disputed = formal dispute raised with carrier; Waived = audit waived per policy threshold.. Valid values are `pending|passed|failed|disputed|waived`',
    `freight_cost_status` STRING COMMENT 'The freight cost status of the freight cost record',
    `freight_invoice_number` STRING COMMENT 'Carrier-issued invoice number associated with this freight cost charge. Used for freight audit, payment matching, and dispute resolution.',
    `hazmat_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional freight cost surcharge for transportation of hazardous materials (e.g., aerosols, flammable products, chemical ingredients). Applicable per DOT/IATA/IMDG hazmat regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the point at which freight cost responsibility transfers between buyer and seller. Determines whether freight cost is a COGS component or a selling expense. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number used for project-based or campaign-based freight cost tracking (e.g., new product launch logistics, trade promotion delivery costs). Enables granular cost attribution beyond standard cost center allocation.',
    `invoice_date` DATE COMMENT 'Date on the carrier-issued freight invoice. Used for payment terms calculation, freight audit aging, and dispute management.',
    `is_accessorial` BOOLEAN COMMENT 'The is accessorial of the freight cost record',
    `is_billable` BOOLEAN COMMENT 'The is billable of the freight cost record',
    `freight_cost_name` STRING COMMENT 'The freight cost name of the freight cost record',
    `notes` STRING COMMENT 'The notes of the freight cost record',
    `payment_date` DATE COMMENT 'Actual date on which payment was issued to the carrier for this freight cost. Used for Days Payable Outstanding (DPO) calculation and carrier payment performance tracking.',
    `payment_due_date` DATE COMMENT 'Date by which the freight invoice must be paid to the carrier per contracted payment terms. Used for cash flow planning and early payment discount capture.',
    `posting_date` DATE COMMENT 'The posting date of the freight cost record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the freight cost record',
    `rate_per_kg` DECIMAL(18,2) COMMENT 'Applied freight rate per kilogram in the transaction currency. Used for rate compliance validation against contracted tariff and for cost-per-unit-weight benchmarking.',
    `rate_per_km` DECIMAL(18,2) COMMENT 'Applied freight rate per kilometer in the transaction currency for distance-based pricing models. Used for road freight rate compliance validation and lane cost benchmarking.',
    `service_level` STRING COMMENT 'Contracted or requested service level for the freight movement. Drives rate tier selection and cost benchmarking. Expedited and overnight services carry premium cost premiums tracked separately for exception analysis.. Valid values are `standard|expedited|overnight|economy|dedicated`',
    `shipment_direction` STRING COMMENT 'Direction of the freight movement: Inbound = supplier to facility; Outbound = facility to customer/retailer; Interplant = between internal facilities; Return = reverse logistics. Enables inbound vs. outbound freight cost split for COGS and logistics P&L.. Valid values are `inbound|outbound|interplant|return`',
    `source_system_code` STRING COMMENT 'The source system code of the freight cost record',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Expected or budgeted freight cost amount based on the contracted rate or benchmark rate for this lane and cost category. Used to compute actual vs. standard cost variance for freight performance management.',
    `transport_mode` STRING COMMENT 'Mode of transportation for the freight movement associated with this cost. Road = truck/FTL/LTL; Rail = rail freight; Ocean = sea freight; Air = air freight; Intermodal = multi-modal; Parcel = small parcel/courier. Used for modal cost benchmarking.. Valid values are `road|rail|ocean|air|intermodal|parcel`',
    `uom` STRING COMMENT 'The uom of the freight cost record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight cost record was last modified. Tracks changes to cost amounts, status transitions, and audit adjustments for data lineage and SOX compliance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual cost_amount and standard_cost_amount (actual minus standard). Positive variance indicates cost overrun; negative indicates savings. Feeds logistics cost variance reporting and COGS analysis.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Cubic volume in cubic meters of the freight associated with this cost record. Used as the allocation driver when allocation_basis = volume and for dimensional weight rate validation.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight in kilograms of the freight associated with this cost record. Used as the allocation driver when allocation_basis = weight and for rate validation against weight-break tariffs.',
    CONSTRAINT pk_freight_cost PRIMARY KEY(`freight_cost_id`)
) COMMENT 'Allocated and accrued freight cost record at the shipment or shipment-leg level. Captures shipment reference, cost category (line-haul, fuel surcharge, accessorial, customs duty, insurance), cost amount, currency, cost allocation basis (weight/volume/value), cost center allocation, accrual status, and actual vs. standard cost variance. Feeds COGS freight component and logistics cost-to-serve analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Unique system-generated identifier for a freight rate record. Primary key for the freight_rate data product.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract under which this freight rate is established. Links rate to the governing contractual agreement.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier associated with this freight rate. Links to the carrier master for contract and service details.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane (origin-destination pair) to which this freight rate applies.',
    `accessorial_schedule_code` STRING COMMENT 'Reference code identifying the accessorial charge schedule applicable to this freight rate. Accessorials include liftgate, inside delivery, residential delivery, detention, and other ancillary charges defined in the carrier tariff.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the freight rate record',
    `base_rate` DECIMAL(18,2) COMMENT 'The core freight rate amount per unit as defined by the rate_type (e.g., cost per mile, cost per CWT, cost per pallet, or flat amount). This is the primary rate value used in freight cost estimation before surcharges and accessorials are applied.',
    `freight_rate_code` STRING COMMENT 'The freight rate code of the freight rate record',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this freight rate applies to cold-chain (temperature-controlled) shipments. Critical for consumer goods categories such as perishable food, beverages, and pharmaceutical products requiring refrigerated transport.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was first created in the system. Used for audit trail, data lineage, and rate history tracking.',
    `cross_border` BOOLEAN COMMENT 'Indicates whether this freight rate applies to cross-border (international) shipments. Cross-border rates include additional cost components for customs, duties, and border crossing fees not present in domestic rates.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the freight rate is denominated (e.g., USD, EUR, GBP). Required for multi-currency freight cost management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `freight_rate_description` STRING COMMENT 'The freight rate description of the freight rate record',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination of the freight lane. Required for cross-border rate determination and import/export compliance.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code_from` STRING COMMENT 'Starting postal code of the destination zone range for this freight rate. Used for zone-based rate determination when the rate applies to a range of destination postal codes.',
    `destination_postal_code_to` STRING COMMENT 'Ending postal code of the destination zone range for this freight rate. Together with destination_postal_code_from, defines the geographic destination band to which this rate applies.',
    `destination_zone_code` STRING COMMENT 'Carrier-defined zone code for the destination geography. Used in conjunction with origin_zone_code for zone-pair rate determination in carrier tariff structures.',
    `distance_km` DECIMAL(18,2) COMMENT 'Standard distance in kilometers for the origin-to-destination lane associated with this rate. Used in per-mile/per-km rate calculations and freight cost benchmarking.',
    `effective_date` DATE COMMENT 'Date from which this freight rate becomes valid and applicable for shipment cost estimation. Rates with effective_date in the future are pre-loaded for upcoming contract periods.',
    `effective_from` DATE COMMENT 'The effective from of the freight rate record',
    `effective_until` DATE COMMENT 'The effective until of the freight rate record',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this rate. Reefer (refrigerated) equipment is critical for cold-chain compliance in consumer goods. Drives rate differentiation and carrier selection.. Valid values are `dry_van|reefer|flatbed|tanker|container|intermodal`',
    `expiry_date` DATE COMMENT 'Date after which this freight rate is no longer valid. Null indicates an open-ended rate with no defined expiration. Used to enforce rate validity windows in freight cost estimation and carrier contract management.',
    `freight_rate_status` STRING COMMENT 'The freight rate status of the freight rate record',
    `fuel_surcharge_basis` STRING COMMENT 'Method by which the fuel surcharge is calculated and applied: as a percentage of the base rate, a flat amount per mile, or a flat amount per shipment. Determines how fuel_surcharge_rate is interpreted in cost computation.. Valid values are `percentage|flat_per_mile|flat_per_shipment`',
    `fuel_surcharge_pct` DECIMAL(18,2) COMMENT 'The fuel surcharge pct of the freight rate record',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Fuel surcharge rate expressed as a percentage or fixed amount applied on top of the base freight rate. Reflects carrier fuel cost pass-through and is typically indexed to a published fuel price index (e.g., DOE weekly diesel).',
    `hazmat_applicable` BOOLEAN COMMENT 'Indicates whether this freight rate applies to hazardous materials (hazmat) shipments. Consumer goods with hazmat classification (e.g., aerosols, flammable products) require specialized rates and carrier certifications per DOT and EPA regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the allocation of freight costs, risks, and responsibilities between shipper and consignee under this rate. Governs which party bears the freight cost represented by this rate. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_spot_rate` BOOLEAN COMMENT 'The is spot rate of the freight rate record',
    `max_charge` DECIMAL(18,2) COMMENT 'Maximum charge amount that applies as a cap for this rate, regardless of shipment weight or distance. Null indicates no cap. Used in negotiated contract rates to protect shippers from excessive charges on large shipments.',
    `min_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies regardless of shipment weight or distance. Ensures the carrier recovers a floor cost for any shipment under this rate. Used in freight cost estimation to enforce rate floor.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'The minimum charge of the freight rate record',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the freight rate record',
    `freight_rate_name` STRING COMMENT 'The freight rate name of the freight rate record',
    `notes` STRING COMMENT 'The notes of the freight rate record',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the origin of the freight lane. Required for cross-border rate determination and customs/regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `origin_postal_code_from` STRING COMMENT 'Starting postal code of the origin zone range for this freight rate. Used for zone-based rate determination when the rate applies to a range of origin postal codes rather than a single location.',
    `origin_postal_code_to` STRING COMMENT 'Ending postal code of the origin zone range for this freight rate. Together with origin_postal_code_from, defines the geographic origin band to which this rate applies.',
    `origin_zone_code` STRING COMMENT 'Carrier-defined zone code for the origin geography. Zone codes are used in carrier tariff structures to group postal codes into pricing zones for simplified rate lookup.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the freight rate record',
    `rate_basis` STRING COMMENT 'The rate basis of the freight rate record',
    `rate_basis_uom` STRING COMMENT 'Unit of measure that defines the denominator for the base_rate. Specifies what one unit of the rate_type represents (e.g., KG for per-kilogram rates, CWT for hundredweight, PALLET for per-pallet rates). Essential for correct freight cost computation. [ENUM-REF-CANDIDATE: KG|CWT|PALLET|MILE|KM|UNIT|SHIPMENT|CONTAINER — 8 candidates stripped; promote to reference product]',
    `rate_code` STRING COMMENT 'The rate code of the freight rate record',
    `rate_currency_code` STRING COMMENT 'The rate currency code of the freight rate record',
    `rate_effective_date` DATE COMMENT 'The rate effective date of the freight rate record',
    `rate_expiry_date` DATE COMMENT 'The rate expiry date of the freight rate record',
    `rate_number` STRING COMMENT 'Externally-known business identifier for this freight rate record, used in carrier communications, freight audit, and cost estimation workflows. Typically sourced from the carrier tariff or contract schedule.',
    `rate_per_unit` DECIMAL(18,2) COMMENT 'The rate per unit of the freight rate record',
    `rate_source` STRING COMMENT 'Origin of the freight rate — whether derived from a negotiated carrier contract, spot market quote, published tariff, or benchmark rate. Used to distinguish contracted rates from market rates in freight cost analysis.. Valid values are `contract|spot_market|tariff|benchmark|spot_quote`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the freight rate record. Indicates whether the rate is currently applicable for freight cost estimation and shipment planning.. Valid values are `active|pending|expired|suspended|cancelled`',
    `rate_type` STRING COMMENT 'Classification of how the freight rate is calculated and applied. Determines the unit basis for cost computation: per-mile (distance-based), per-CWT (hundredweight), per-pallet (handling unit), per-kg (weight-based), flat (fixed regardless of volume), or per-unit. [ENUM-REF-CANDIDATE: per_mile|per_cwt|per_pallet|per_kg|flat|per_unit|per_container|per_shipment — promote to reference product]. Valid values are `per_mile|per_cwt|per_pallet|per_kg|flat|per_unit`',
    `rate_unit` STRING COMMENT 'The rate unit of the freight rate record',
    `rate_uom` STRING COMMENT 'The rate uom of the freight rate record',
    `service_level` STRING COMMENT 'Carrier service level associated with this freight rate, defining the speed and priority of delivery. Impacts rate amount and transit time commitments.. Valid values are `standard|expedited|overnight|economy|same_day`',
    `source_system_code` STRING COMMENT 'The source system code of the freight rate record',
    `spot_quote_reference` STRING COMMENT 'Reference number for the spot market quote when rate_source is spot_market or spot_quote. Enables traceability back to the original carrier quote for audit and freight cost reconciliation purposes.',
    `tariff_name` STRING COMMENT 'Name or identifier of the carriers published tariff schedule from which this rate is derived. Used when rate_source is tariff to reference the specific tariff document governing the rate.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain shipments under this rate. Applicable when cold_chain_required is true. Defines the upper bound of the acceptable temperature range for product integrity.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum required temperature in degrees Celsius for cold-chain shipments under this rate. Applicable when cold_chain_required is true. Used for reefer equipment specification and cold-chain compliance monitoring.',
    `transit_days` STRING COMMENT 'Standard number of business days for transit from origin to destination under this rate and service level. Used in delivery date estimation, OTIF (On Time In Full) planning, and S&OP (Sales and Operations Planning).',
    `transport_mode` STRING COMMENT 'Mode of transportation to which this freight rate applies. TL = Truckload, LTL = Less-than-Truckload. Determines applicable rate structure and carrier service type. [ENUM-REF-CANDIDATE: TL|LTL|parcel|rail|ocean|air|intermodal — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the freight rate record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was last modified. Used for change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    `weight_break_from` DECIMAL(18,2) COMMENT 'The weight break from of the freight rate record',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms for this rate to apply. Defines the upper bound of the weight break tier. Null indicates no upper limit (applies to all weights above the minimum).',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum shipment weight in kilograms for this rate to apply. Defines the lower bound of the weight break tier. Used in LTL and CWT-based rate structures to determine applicable rate.',
    `weight_break_to` DECIMAL(18,2) COMMENT 'The weight break to of the freight rate record',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Granular freight rate record defining the cost per unit of transport for a specific lane, carrier, mode, and shipment characteristic. Captures rate type (per-mile, per-cwt, per-pallet, flat), origin/destination zone or postal code range, weight break, effective and expiry dates, base rate, fuel surcharge rate, accessorial rate schedule reference, and currency. Sourced from carrier contracts and spot market quotes for freight cost estimation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` (
    `transport_unit_id` BIGINT COMMENT 'Primary key for transport_unit',
    `carrier_id` BIGINT COMMENT 'Carrier operating this transport unit.',
    `parent_transport_unit_id` BIGINT COMMENT 'Self-referencing FK on transport_unit (parent_transport_unit_id)',
    `vehicle_id` BIGINT COMMENT 'The vehicle id of the transport unit record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the transport unit record',
    `capacity_volume_cbm` DECIMAL(18,2) COMMENT 'The capacity volume cbm of the transport unit record',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum cargo volume the unit can hold, expressed in cubic metres.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum cargo weight the unit can safely transport, expressed in kilograms.',
    `transport_unit_code` STRING COMMENT 'External business code used to reference the transport unit in contracts and operational systems.',
    `container_number` STRING COMMENT 'The container number of the transport unit record',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original acquisition cost of the transport unit.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the transport unit record',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost_basis.',
    `current_location` STRING COMMENT 'Logical location code or depot where the unit is presently stationed.',
    `current_location_code` STRING COMMENT 'The current location code of the transport unit record',
    `depreciation_end_date` DATE COMMENT 'Date depreciation of the unit is scheduled to end; null if ongoing.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the transport unit.',
    `depreciation_start_date` DATE COMMENT 'Date depreciation of the unit began.',
    `transport_unit_description` STRING COMMENT 'The transport unit description of the transport unit record',
    `effective_from` DATE COMMENT 'The effective from of the transport unit record',
    `effective_until` DATE COMMENT 'The effective until of the transport unit record',
    `equipment_class` STRING COMMENT 'The equipment class of the transport unit record',
    `fuel_type` STRING COMMENT 'Primary fuel used by the transport unit.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Most recent latitude coordinate of the unit (WGS84).',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Most recent longitude coordinate of the unit (WGS84).',
    `height_m` DECIMAL(18,2) COMMENT 'Physical height of the transport unit in metres.',
    `is_refrigerated` BOOLEAN COMMENT 'The is refrigerated of the transport unit record',
    `last_inspection_date` DATE COMMENT 'The last inspection date of the transport unit record',
    `last_maintenance_date` DATE COMMENT 'Date the transport unit most recently underwent scheduled maintenance.',
    `length_m` DECIMAL(18,2) COMMENT 'Physical length of the transport unit in metres.',
    `license_plate` STRING COMMENT 'License plate identifier displayed on the transport unit.',
    `maintenance_interval_days` STRING COMMENT 'Number of days between required maintenance events.',
    `manufacturer` STRING COMMENT 'Company that built the transport unit.',
    `max_speed_kmh` STRING COMMENT 'Design speed limit of the transport unit in kilometres per hour.',
    `transport_unit_name` STRING COMMENT 'Human‑readable name or designation of the transport unit.',
    `notes` STRING COMMENT 'The notes of the transport unit record',
    `owner_company` STRING COMMENT 'Legal entity within the enterprise that owns the transport unit.',
    `ownership_type` STRING COMMENT 'The ownership type of the transport unit record',
    `purchase_date` DATE COMMENT 'Date the transport unit was acquired by the company.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the transport unit record',
    `registration_number` STRING COMMENT 'Official registration number assigned by the transport authority.',
    `seal_number` STRING COMMENT 'The seal number of the transport unit record',
    `service_end_date` DATE COMMENT 'Date the transport unit was retired or taken out of service; null if still active.',
    `service_start_date` DATE COMMENT 'Date the transport unit entered active service.',
    `source_system_code` STRING COMMENT 'The source system code of the transport unit record',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'The tare weight kg of the transport unit record',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the unit is equipped for temperature‑controlled transport.',
    `temperature_range_c` STRING COMMENT 'Operational temperature range in Celsius (e.g., "2-8").',
    `temperature_setpoint_celsius` DECIMAL(18,2) COMMENT 'The temperature setpoint celsius of the transport unit record',
    `trailer_number` STRING COMMENT 'The trailer number of the transport unit record',
    `transport_unit_status` STRING COMMENT 'Current operational status of the transport unit within its lifecycle.',
    `transport_unit_type` STRING COMMENT 'Category of the transport unit indicating its physical form and primary use.',
    `unit_code` STRING COMMENT 'The unit code of the transport unit record',
    `unit_number` STRING COMMENT 'The unit number of the transport unit record',
    `unit_status` STRING COMMENT 'The unit status of the transport unit record',
    `unit_type` STRING COMMENT 'The unit type of the transport unit record',
    `uom` STRING COMMENT 'The uom of the transport unit record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the transport unit record',
    `width_m` DECIMAL(18,2) COMMENT 'Physical width of the transport unit in metres.',
    `year_of_manufacture` STRING COMMENT 'Calendar year the transport unit was manufactured.',
    CONSTRAINT pk_transport_unit PRIMARY KEY(`transport_unit_id`)
) COMMENT 'Master reference table for transport_unit. Referenced by transport_unit_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `carrier_id` BIGINT COMMENT 'Carrier operating this vehicle.',
    `towing_vehicle_id` BIGINT COMMENT 'Self-referencing FK on vehicle (towing_vehicle_id)',
    `acquisition_date` DATE COMMENT 'Date the vehicle was purchased or otherwise acquired.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the vehicle record',
    `assigned_driver_name` STRING COMMENT 'The assigned driver name of the vehicle record',
    `capacity_volume_cbm` DECIMAL(18,2) COMMENT 'The capacity volume cbm of the vehicle record',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'The capacity volume m3 of the vehicle record',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'The capacity weight kg of the vehicle record',
    `co2_emission_g_per_km` DECIMAL(18,2) COMMENT 'The co2 emission g per km of the vehicle record',
    `vehicle_code` STRING COMMENT 'The vehicle code of the vehicle record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle record was first created in the data lake.',
    `currency_code` STRING COMMENT 'The currency code of the vehicle record',
    `current_fuel_level_liters` DECIMAL(18,2) COMMENT 'Fuel volume currently in the tank, measured during last reading.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the vehicles value over time.',
    `depreciation_value` DECIMAL(18,2) COMMENT 'Total depreciation amount recorded to date.',
    `vehicle_description` STRING COMMENT 'The vehicle description of the vehicle record',
    `effective_from` DATE COMMENT 'The effective from of the vehicle record',
    `effective_until` DATE COMMENT 'The effective until of the vehicle record',
    `emission_standard` STRING COMMENT 'The emission standard of the vehicle record',
    `emissions_standard` STRING COMMENT 'Regulatory emissions compliance level applicable to the vehicle.',
    `fuel_capacity_liters` DECIMAL(18,2) COMMENT 'Maximum volume of fuel the vehicles tank can hold.',
    `fuel_type` STRING COMMENT 'Primary energy source used by the vehicle.',
    `gps_device_code` STRING COMMENT 'Unique identifier of the GPS tracking unit installed on the vehicle.',
    `gps_last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent location report from the GPS device.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the current insurance coverage ends.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the active insurance policy covering the vehicle.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the vehicle record is currently active in the system.',
    `is_refrigerated` BOOLEAN COMMENT 'The is refrigerated of the vehicle record',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which scheduled maintenance was performed.',
    `lease_end_date` DATE COMMENT 'Date when the lease term expires and the vehicle must be returned.',
    `lease_flag` BOOLEAN COMMENT 'True if the vehicle is obtained under a lease agreement.',
    `license_plate` STRING COMMENT 'Alphanumeric plate identifier displayed on the vehicle.',
    `make` STRING COMMENT 'The make of the vehicle record',
    `model` STRING COMMENT 'The model of the vehicle record',
    `model_year` STRING COMMENT 'The model year of the vehicle record',
    `vehicle_name` STRING COMMENT 'Human‑readable name or label assigned to the vehicle for easy reference.',
    `next_maintenance_date` DATE COMMENT 'The next maintenance date of the vehicle record',
    `next_service_date` DATE COMMENT 'Planned date for the next preventive maintenance activity.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or operational comments.',
    `odometer_km` DECIMAL(18,2) COMMENT 'The odometer km of the vehicle record',
    `odometer_reading_km` BIGINT COMMENT 'Cumulative distance traveled by the vehicle, recorded by the odometer.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the vehicle within logistics operations.',
    `owner_company` STRING COMMENT 'Legal entity that owns the vehicle (useful for multi‑entity groups).',
    `ownership_type` STRING COMMENT 'The ownership type of the vehicle record',
    `payload_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight the vehicle can safely carry.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Original acquisition cost of the vehicle.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the vehicle record',
    `refrigerated_flag` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped for temperature‑controlled transport.',
    `registration_number` STRING COMMENT 'Official registration number issued by the transport authority.',
    `retirement_date` DATE COMMENT 'Date the vehicle was removed from active service or disposed of.',
    `service_interval_km` STRING COMMENT 'Mileage interval after which the vehicle must undergo service.',
    `source_system_code` STRING COMMENT 'The source system code of the vehicle record',
    `temperature_controlled` BOOLEAN COMMENT 'The temperature controlled of the vehicle record',
    `temperature_range_c` STRING COMMENT 'Allowed temperature range for refrigerated cargo, expressed as "min‑max".',
    `uom` STRING COMMENT 'The uom of the vehicle record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle record.',
    `vehicle_number` STRING COMMENT 'The vehicle number of the vehicle record',
    `vehicle_status` STRING COMMENT 'The vehicle status of the vehicle record',
    `vehicle_type` STRING COMMENT 'Category of the vehicle based on body style and purpose.',
    `vin` STRING COMMENT 'Globally unique 17‑character identifier assigned by the manufacturer.',
    `year` STRING COMMENT 'The year of the vehicle record',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master reference table for vehicle. Referenced by vehicle_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` (
    `consolidation_id` BIGINT COMMENT 'Primary key for consolidation',
    `carrier_id` BIGINT COMMENT 'The carrier id of the consolidation record',
    `distribution_facility_id` BIGINT COMMENT 'Facility where consolidation occurs.',
    `freight_order_id` BIGINT COMMENT 'The freight order id of the consolidation record',
    `parent_consolidation_id` BIGINT COMMENT 'Self-referencing FK on consolidation (parent_consolidation_id)',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Real‑time timestamp when the consolidated load actually arrived.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Real‑time timestamp when the consolidated load actually departed.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consolidation record',
    `capacity_utilization_pct` DECIMAL(18,2) COMMENT 'The capacity utilization pct of the consolidation record',
    `consolidation_code` STRING COMMENT 'Business identifier used externally and in operational systems to reference the consolidation.',
    `compliance_certification` STRING COMMENT 'Applicable quality or regulatory certification(s) associated with the consolidation.',
    `consolidation_date` DATE COMMENT 'The consolidation date of the consolidation record',
    `consolidation_number` STRING COMMENT 'The consolidation number of the consolidation record',
    `consolidation_status` STRING COMMENT 'Current lifecycle state of the consolidation.',
    `consolidation_type` STRING COMMENT 'Category of consolidation based on loading strategy and routing.',
    `cost_savings_amount` DECIMAL(18,2) COMMENT 'The cost savings amount of the consolidation record',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total freight cost incurred for the consolidation, expressed in US dollars.',
    `created_by_user` STRING COMMENT 'Business user identifier who created the consolidation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost reporting.',
    `consolidation_description` STRING COMMENT 'The consolidation description of the consolidation record',
    `destination_location` STRING COMMENT 'The destination location of the consolidation record',
    `destination_location_code` STRING COMMENT 'Standardized code identifying the destination facility or hub for the consolidation.',
    `effective_from` DATE COMMENT 'Date on which the consolidation becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date on which the consolidation ceases to be effective; null if open‑ended.',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether the consolidation requires temperature‑controlled handling.',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the consolidation record',
    `consolidation_name` STRING COMMENT 'Human‑readable name describing the consolidation batch (e.g., "North America Q2 Consolidation").',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or special handling instructions.',
    `number_of_shipments` STRING COMMENT 'Count of individual shipment records that are part of this consolidation.',
    `optimization_method` STRING COMMENT 'The optimization method of the consolidation record',
    `origin_location` STRING COMMENT 'The origin location of the consolidation record',
    `origin_location_code` STRING COMMENT 'Standardized code identifying the origin facility or hub for the consolidation.',
    `planned_arrival_date` DATE COMMENT 'Scheduled date for the consolidated load to arrive at the destination.',
    `planned_departure_date` DATE COMMENT 'Scheduled date for the consolidated load to leave the origin location.',
    `planned_dispatch_date` DATE COMMENT 'The planned dispatch date of the consolidation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consolidation record',
    `shipment_count` STRING COMMENT 'The shipment count of the consolidation record',
    `source_system_code` STRING COMMENT 'The source system code of the consolidation record',
    `temperature_control_range_c` STRING COMMENT 'Allowed temperature range for cold‑chain shipments, expressed in degrees Celsius (e.g., "2-8").',
    `total_shipments` STRING COMMENT 'The total shipments of the consolidation record',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Aggregate volume of all shipments in the consolidation, measured in cubic meters.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'The total volume m3 of the consolidation record',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all shipments included in the consolidation, measured in kilograms.',
    `uom` STRING COMMENT 'The uom of the consolidation record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the consolidation record.',
    CONSTRAINT pk_consolidation PRIMARY KEY(`consolidation_id`)
) COMMENT 'Master reference table for consolidation. Referenced by consolidation_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` (
    `handling_unit_id` BIGINT COMMENT 'Primary key for handling_unit',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `logistics_shipment_id` BIGINT COMMENT 'Shipment this handling unit belongs to.',
    `parent_handling_unit_id` BIGINT COMMENT 'Self-referencing FK on handling_unit (parent_handling_unit_id)',
    `transport_unit_id` BIGINT COMMENT 'The transport unit id of the handling unit record',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when the handling unit actually arrived.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Timestamp when the handling unit actually departed.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the handling unit record',
    `handling_unit_code` STRING COMMENT 'External code or barcode that uniquely identifies the handling unit in logistics operations.',
    `cold_chain_compliance` BOOLEAN COMMENT 'True if the handling unit meets cold‑chain regulatory requirements.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the handling unit.',
    `cost_currency` STRING COMMENT 'Currency of the freight cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the handling unit record was first created.',
    `currency_code` STRING COMMENT 'The currency code of the handling unit record',
    `handling_unit_description` STRING COMMENT 'The handling unit description of the handling unit record',
    `destination_location_code` STRING COMMENT 'Code of the intended destination location for the handling unit.',
    `effective_from` DATE COMMENT 'The effective from of the handling unit record',
    `effective_until` DATE COMMENT 'The effective until of the handling unit record',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total freight cost associated with moving the handling unit.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'The gross weight kg of the handling unit record',
    `handling_instructions` STRING COMMENT 'Special handling instructions or notes for the unit.',
    `handling_unit_status` STRING COMMENT 'Current lifecycle status of the handling unit.',
    `hazardous_class_code` STRING COMMENT 'Regulatory classification code for hazardous material, if applicable.',
    `hazardous_material` BOOLEAN COMMENT 'True if the handling unit contains hazardous material.',
    `height_cm` STRING COMMENT 'Height of the handling unit in centimeters.',
    `hu_code` STRING COMMENT 'The hu code of the handling unit record',
    `hu_number` STRING COMMENT 'The hu number of the handling unit record',
    `hu_status` STRING COMMENT 'The hu status of the handling unit record',
    `hu_type` STRING COMMENT 'The hu type of the handling unit record',
    `internal_reference_number` STRING COMMENT 'Internal reference used for cross‑system identification.',
    `is_fragile` BOOLEAN COMMENT 'Indicates whether the contents are fragile.',
    `is_oversized` BOOLEAN COMMENT 'True if the handling unit exceeds standard size limits.',
    `item_count` STRING COMMENT 'The item count of the handling unit record',
    `last_scanned_location_code` STRING COMMENT 'Location code of the most recent scan event for the handling unit.',
    `last_scanned_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent scan event.',
    `length_cm` STRING COMMENT 'Length of the handling unit in centimeters.',
    `material` STRING COMMENT 'Primary material composition of the handling unit.',
    `handling_unit_name` STRING COMMENT 'Human‑readable name or label for the handling unit.',
    `nested_unit_count` STRING COMMENT 'The nested unit count of the handling unit record',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'The net weight kg of the handling unit record',
    `notes` STRING COMMENT 'The notes of the handling unit record',
    `origin_location_code` STRING COMMENT 'Code of the location where the handling unit originated.',
    `owner_department` STRING COMMENT 'Internal department responsible for the handling unit.',
    `packaging_material` STRING COMMENT 'The packaging material of the handling unit record',
    `packaging_type` STRING COMMENT 'The packaging type of the handling unit record',
    `parent_hu_code` STRING COMMENT 'The parent hu code of the handling unit record',
    `planned_arrival_date` DATE COMMENT 'Scheduled date for the handling unit to arrive at destination.',
    `planned_departure_date` DATE COMMENT 'Scheduled date for the handling unit to leave the origin.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the handling unit record',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the handling unit.',
    `source_system_code` STRING COMMENT 'The source system code of the handling unit record',
    `sscc` STRING COMMENT 'The sscc of the handling unit record',
    `sscc_number` STRING COMMENT 'The sscc number of the handling unit record',
    `stackable_flag` BOOLEAN COMMENT 'The stackable flag of the handling unit record',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'The tare weight kg of the handling unit record',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the handling unit is equipped for temperature control.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the handling unit when temperature controlled.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the handling unit when temperature controlled.',
    `tracking_number` STRING COMMENT 'External tracking identifier assigned by the carrier.',
    `unit_type` STRING COMMENT 'Category of the handling unit, such as pallet, case, tote, etc.',
    `uom` STRING COMMENT 'The uom of the handling unit record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the handling unit record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume of the handling unit in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the handling unit in kilograms.',
    `width_cm` STRING COMMENT 'Width of the handling unit in centimeters.',
    CONSTRAINT pk_handling_unit PRIMARY KEY(`handling_unit_id`)
) COMMENT 'Master reference table for handling_unit. Referenced by handling_unit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_third_party_provider_id` FOREIGN KEY (`third_party_provider_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`third_party_provider`(`third_party_provider_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_primary_lane_backup_carrier_id` FOREIGN KEY (`primary_lane_backup_carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`consolidation`(`consolidation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_shipment_item_id` FOREIGN KEY (`shipment_item_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`shipment_item`(`shipment_item_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_transport_unit_id` FOREIGN KEY (`transport_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`transport_unit`(`transport_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_source_transport_exception_id` FOREIGN KEY (`source_transport_exception_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`transport_exception`(`transport_exception_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_tracking_event_id` FOREIGN KEY (`tracking_event_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`tracking_event`(`tracking_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_third_party_provider_id` FOREIGN KEY (`third_party_provider_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`third_party_provider`(`third_party_provider_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ADD CONSTRAINT `fk_logistics_transport_unit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ADD CONSTRAINT `fk_logistics_transport_unit_parent_transport_unit_id` FOREIGN KEY (`parent_transport_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`transport_unit`(`transport_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ADD CONSTRAINT `fk_logistics_transport_unit_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_towing_vehicle_id` FOREIGN KEY (`towing_vehicle_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ADD CONSTRAINT `fk_logistics_consolidation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ADD CONSTRAINT `fk_logistics_consolidation_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ADD CONSTRAINT `fk_logistics_consolidation_parent_consolidation_id` FOREIGN KEY (`parent_consolidation_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`consolidation`(`consolidation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ADD CONSTRAINT `fk_logistics_handling_unit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ADD CONSTRAINT `fk_logistics_handling_unit_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ADD CONSTRAINT `fk_logistics_handling_unit_parent_handling_unit_id` FOREIGN KEY (`parent_handling_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ADD CONSTRAINT `fk_logistics_handling_unit_transport_unit_id` FOREIGN KEY (`transport_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`transport_unit`(`transport_unit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Id');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ALTER COLUMN `origin_region_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Id');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_concept' = 'shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `origin_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `primary_logistics_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver / Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `handling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `prototype_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Item Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sales_order_line` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Recorded Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `delivery_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_departure` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance (km)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `actual_return_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emissions (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Route Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `is_dsd` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `optimization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Algorithm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Optimization Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `optimization_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `otif_compliant` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_departure` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Planned Distance (km)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `planned_return_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Return Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `proof_of_delivery_required` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Required Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_date` SET TAGS ('dbx_business_glossary_term' = 'Route Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'planned|dispatched|in_progress|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'delivery|pickup|mixed|cross_dock|dsd');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `service_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Service Time Window End');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `service_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Service Time Window Start');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `stop_count` SET TAGS ('dbx_business_glossary_term' = 'Stop Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_cases_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Distance Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_pallets_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Pallets');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Stops');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_stops_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Completed Stops');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_stops_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Stops');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Route Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Route Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `vehicle_capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity Utilization Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `vehicle_capacity_utilization_pct` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ALTER COLUMN `vehicle_capacity_utilization_pct` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Route Stop ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_arrival` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_cases` SET TAGS ('dbx_business_glossary_term' = 'Actual Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_departure` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_pallets` SET TAGS ('dbx_business_glossary_term' = 'Actual Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `arrival_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Arrival Variance (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_stop_code` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_stop_description` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `distance_from_prev_km` SET TAGS ('dbx_business_glossary_term' = 'Distance From Prev Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Stop Failure Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_stop_name` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `otif_compliant` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_arrival` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_cases` SET TAGS ('dbx_business_glossary_term' = 'Planned Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_departure` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_pallets` SET TAGS ('dbx_business_glossary_term' = 'Planned Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `planned_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_captured` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Captured');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|barcode_scan|photo|paper|none');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `route_stop_status` SET TAGS ('dbx_business_glossary_term' = 'Route Stop Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `service_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Time Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_address` SET TAGS ('dbx_business_glossary_term' = 'Stop Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_location` SET TAGS ('dbx_business_glossary_term' = 'Stop Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_name` SET TAGS ('dbx_business_glossary_term' = 'Stop Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_business_glossary_term' = 'Stop Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|arrived|completed|skipped|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_value_regex' = 'delivery|pickup|cross_dock|return|service');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `temperature_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Temperature Exceedance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'freight_costing');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` SET TAGS ('dbx_subdomain' = 'freight_costing');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_audit_result_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Auditor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Accrual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Accrual Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'accrued|reversed|posted|pending|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `actual_vs_standard_variance` SET TAGS ('dbx_business_glossary_term' = 'Actual vs. Standard Freight Cost Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `actual_vs_standard_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_source` SET TAGS ('dbx_value_regex' = 'internal|third_party_auditor|automated_system');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'approved|disputed|short_paid|pending|voided|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audited_amount` SET TAGS ('dbx_business_glossary_term' = 'Audited Freight Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `audited_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `auditor` SET TAGS ('dbx_business_glossary_term' = 'Auditor');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `auditor_system` SET TAGS ('dbx_business_glossary_term' = 'Auditor System');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_audit_result_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Result Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `cost_allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Allocation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `cost_allocation_basis` SET TAGS ('dbx_value_regex' = 'weight|volume|value|units|equal_split');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'line_haul|fuel_surcharge|accessorial|duty|insurance|detention');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_audit_result_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Result Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `discrepancy_category` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `dispute_filed` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filed');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Dispute Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `dispute_resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `expected_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_audit_result_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Result Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoice_currency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoice_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Freight Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `freight_audit_result_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Result Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Recovery Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Variance Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `variance_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Variance Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `weight_actual_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Verified Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ALTER COLUMN `weight_billed_kg` SET TAGS ('dbx_business_glossary_term' = 'Billed Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `carrier_event_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `carrier_sla_met` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_value_regex' = 'cleared|held|pending|released|seized');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_description` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `edi_interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Interchange Control Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_value_regex' = '214|990|204|210|997');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `estimated_delivery_update` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Update');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_city` SET TAGS ('dbx_business_glossary_term' = 'Event City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_business_glossary_term' = 'Event Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_location` SET TAGS ('dbx_business_glossary_term' = 'Event Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_location_code` SET TAGS ('dbx_business_glossary_term' = 'Event Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_state_province` SET TAGS ('dbx_business_glossary_term' = 'Event State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `exception_root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Root Cause Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `geofence_zone` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `geofence_zone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `geofence_zone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_name` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `planned_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `pod_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `pod_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|photo|no_signature_required');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signatory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO Number)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed (km/h)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `status_category` SET TAGS ('dbx_business_glossary_term' = 'Status Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `temperature_breach` SET TAGS ('dbx_business_glossary_term' = 'Temperature Breach Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_status` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `cold_chain_log_id` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `primary_cold_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `transport_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `alert_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Acknowledged Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `cold_chain_log_code` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `cold_chain_log_status` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `corrective_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `data_logger_report_code` SET TAGS ('dbx_business_glossary_term' = 'Data Logger Report ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `cold_chain_log_description` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Excursion Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Excursion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_business_glossary_term' = 'Excursion Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_type` SET TAGS ('dbx_business_glossary_term' = 'Excursion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `excursion_type` SET TAGS ('dbx_value_regex' = 'temperature_high|temperature_low|humidity_high|humidity_low|none');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `humidity_max_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Humidity Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `humidity_min_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Humidity Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `log_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Log Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `log_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Log Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `max_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Max Threshold C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `max_threshold_celsius` SET TAGS ('dbx_business_glossary_term' = 'Max Threshold Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `mean_kinetic_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Mean Kinetic Temperature (MKT) (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `min_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Min Threshold C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `min_threshold_celsius` SET TAGS ('dbx_business_glossary_term' = 'Min Threshold Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `monitoring_session_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Session ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `cold_chain_log_name` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `product_temperature_class` SET TAGS ('dbx_business_glossary_term' = 'Product Temperature Class');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `product_temperature_class` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|controlled_room_temp|cool');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `qa_disposition` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Disposition');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `qa_disposition` SET TAGS ('dbx_value_regex' = 'approved|rejected|quarantined|pending_review|conditionally_approved');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `qa_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `reading_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Reading Interval (Seconds)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_battery_pct` SET TAGS ('dbx_business_glossary_term' = 'Sensor Battery Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Sensor Calibration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Sensor Calibration Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Device ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_model` SET TAGS ('dbx_business_glossary_term' = 'Sensor Model');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `sensor_placement` SET TAGS ('dbx_business_glossary_term' = 'Sensor Placement Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `temperature_max_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Threshold (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `temperature_min_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Threshold (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `transport_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `transport_unit_type` SET TAGS ('dbx_value_regex' = 'refrigerated_trailer|frozen_trailer|reefer_container|insulated_van|ambient_trailer');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `source_transport_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Exception ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `carrier_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `carrier_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Claim Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Claim Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Claim Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|under_review|approved|rejected|settled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `cold_chain_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Breach Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_exception_description` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_country_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_location` SET TAGS ('dbx_business_glossary_term' = 'Exception Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_subtype` SET TAGS ('dbx_business_glossary_term' = 'Exception Sub-Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'delay|damage|lost|refused|weather|carrier_failure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `hazmat_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Involved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_exception_name` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `otif_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `resolution_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `temperature_excursion_max_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Maximum (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `temperature_excursion_min_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Minimum (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Transport Exception Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|ocean|air|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Reviewed By');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'ERP Vendor Master ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = '3PL API Integration Endpoint URL');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `claims_resolution_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Freight Claims Resolution Service Level Agreement (SLA) Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `claims_resolution_sla_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `third_party_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contact_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Contract Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Legal Registration');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `third_party_provider_description` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `edi_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = '3PL Escalation Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = '3PL Geographic Coverage Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `hazmat_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = '3PL Headquarters City');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = '3PL Headquarters Country');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_business_glossary_term' = 'Cargo Insurance Coverage Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'General Liability Insurance Coverage Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `integration_method` SET TAGS ('dbx_business_glossary_term' = 'System Integration Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `integration_method` SET TAGS ('dbx_value_regex' = 'EDI|API|portal|email|ftp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `is_preferred` SET TAGS ('dbx_business_glossary_term' = 'Is Preferred');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `third_party_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `network_region` SET TAGS ('dbx_business_glossary_term' = 'Logistics Network Region');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `network_region` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|latin_america|middle_east_africa|global');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60|NET90|immediate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Performance Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probationary');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = '3PL Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = '3PL Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = '3PL Primary Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_status` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_status` SET TAGS ('dbx_value_regex' = 'active|inactive|onboarding|suspended|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = '3PL|4PL|lead_logistics|freight_broker|customs_broker');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `region_coverage` SET TAGS ('dbx_business_glossary_term' = 'Region Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `service_countries` SET TAGS ('dbx_business_glossary_term' = '3PL Service Country Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = '3PL Service Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `services_offered` SET TAGS ('dbx_business_glossary_term' = 'Services Offered');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Supported Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Supported Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `third_party_provider_status` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = '3PL Shipment Tracking URL Template');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = '3PL Provider Trade Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `transport_modes` SET TAGS ('dbx_business_glossary_term' = '3PL Supported Transport Modes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `ams_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Manifest System (AMS) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `anti_dumping_case_number` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `broker_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_broker` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|re-export|re-import');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Customs Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_description` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_currency` SET TAGS ('dbx_business_glossary_term' = 'Duty and Tax Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Examination Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'none|document|physical|laboratory|intensive');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `export_country_code` SET TAGS ('dbx_business_glossary_term' = 'Export Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `exporter_of_record` SET TAGS ('dbx_business_glossary_term' = 'Exporter of Record');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `exporter_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration Filed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `free_trade_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `import_country_code` SET TAGS ('dbx_business_glossary_term' = 'Import Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `import_license_number` SET TAGS ('dbx_business_glossary_term' = 'Import License Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_name` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `port_of_entry` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `port_of_export_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Export Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `quantity_declared` SET TAGS ('dbx_business_glossary_term' = 'Declared Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` SET TAGS ('dbx_subdomain' = 'freight_costing');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocated_to` SET TAGS ('dbx_business_glossary_term' = 'Allocated To');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'weight|volume|value|units|flat|distance');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_uom` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `allocation_uom` SET TAGS ('dbx_value_regex' = 'KG|M3|USD|EA|KM|PCT');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `audit_discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Discrepancy Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `audit_discrepancy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `billing_period` SET TAGS ('dbx_business_glossary_term' = 'Billing Period');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `billing_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_cost_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cold_chain_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Premium Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cold_chain_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'line_haul|fuel_surcharge|accessorial|customs_duty|insurance|other');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_document_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Recognition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'accrued|invoiced|approved|disputed|paid|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Sub-Category');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_cost_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Freight Dispute Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|disputed|waived');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `hazmat_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Surcharge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `hazmat_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `is_accessorial` SET TAGS ('dbx_business_glossary_term' = 'Is Accessorial');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `freight_cost_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Freight Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Per Kilogram');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `rate_per_km` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Per Kilometer');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `rate_per_km` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|economy|dedicated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `shipment_direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `shipment_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|interplant|return');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|ocean|air|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (M3)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `accessorial_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Schedule Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Rate Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Lane Distance (km)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'dry_van|reefer|flatbed|tanker|container|intermodal');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_value_regex' = 'percentage|flat_per_mile|flat_per_shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `hazmat_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Applicable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `is_spot_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Spot Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `max_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Freight Charge');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `max_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `min_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Freight Charge');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `min_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_basis_uom` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Source');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'contract|spot_market|tariff|benchmark|spot_quote');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'per_mile|per_cwt|per_pallet|per_kg|flat|per_unit');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Rate Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|economy|same_day');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `spot_quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tariff Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_from` SET TAGS ('dbx_business_glossary_term' = 'Weight Break From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_to` SET TAGS ('dbx_business_glossary_term' = 'Weight Break To');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `parent_transport_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Transport Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `parent_transport_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume Cbm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume M3');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `current_location` SET TAGS ('dbx_business_glossary_term' = 'Current Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `current_location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Gps Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `height_m` SET TAGS ('dbx_business_glossary_term' = 'Height M');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `is_refrigerated` SET TAGS ('dbx_business_glossary_term' = 'Is Refrigerated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `length_m` SET TAGS ('dbx_business_glossary_term' = 'Length M');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `license_plate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `license_plate` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Days');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `max_speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Max Speed Kmh');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `owner_company` SET TAGS ('dbx_business_glossary_term' = 'Owner Company');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `temperature_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `transport_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `width_m` SET TAGS ('dbx_business_glossary_term' = 'Width M');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year Of Manufacture');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `towing_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Towing Vehicle Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `towing_vehicle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `assigned_driver_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `assigned_driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `assigned_driver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume Cbm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_cbm` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume M3');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `co2_emission_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'Co2 Emission G Per Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `current_fuel_level_liters` SET TAGS ('dbx_business_glossary_term' = 'Current Fuel Level Liters');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `depreciation_value` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Value');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_description` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `fuel_capacity_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Capacity Liters');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `fuel_capacity_liters` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `fuel_capacity_liters` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_business_glossary_term' = 'Gps Device Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gps Last Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_last_update_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `gps_last_update_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `is_refrigerated` SET TAGS ('dbx_business_glossary_term' = 'Is Refrigerated');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `lease_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Make');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `next_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Service Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `odometer_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `odometer_reading_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `owner_company` SET TAGS ('dbx_business_glossary_term' = 'Owner Company');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `payload_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `payload_capacity_kg` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `payload_capacity_kg` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `refrigerated_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `service_interval_km` SET TAGS ('dbx_business_glossary_term' = 'Service Interval Km');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vin');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `parent_consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consolidation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `parent_consolidation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `capacity_utilization_pct` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `cost_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Usd');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_description` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Is Cold Chain');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `consolidation_name` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `number_of_shipments` SET TAGS ('dbx_business_glossary_term' = 'Number Of Shipments');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Optimization Method');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `planned_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `planned_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `planned_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Dispatch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `temperature_control_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Range C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `total_shipments` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cbm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume M3');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `parent_handling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Handling Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `parent_handling_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `transport_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `cold_chain_compliance` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Description');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hazardous_class_code` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Class Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height Cm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hu_code` SET TAGS ('dbx_business_glossary_term' = 'Hu Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hu_number` SET TAGS ('dbx_business_glossary_term' = 'Hu Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hu_status` SET TAGS ('dbx_business_glossary_term' = 'Hu Status');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `hu_type` SET TAGS ('dbx_business_glossary_term' = 'Hu Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `internal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `is_fragile` SET TAGS ('dbx_business_glossary_term' = 'Is Fragile');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `is_oversized` SET TAGS ('dbx_business_glossary_term' = 'Is Oversized');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `last_scanned_location_code` SET TAGS ('dbx_business_glossary_term' = 'Last Scanned Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `last_scanned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scanned Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length Cm');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `handling_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Name');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `nested_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Nested Unit Count');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `parent_hu_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Hu Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `planned_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `planned_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Sscc');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `sscc_number` SET TAGS ('dbx_business_glossary_term' = 'Sscc Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Max C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Min C');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume M3');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width Cm');
