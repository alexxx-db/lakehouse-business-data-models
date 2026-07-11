-- Schema for Domain: sustainability | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 13:03:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`sustainability` COMMENT 'Owns environmental, social, and governance (ESG) data. Manages carbon footprint tracking, packaging recyclability metrics, FSC/RSPO sustainable sourcing certifications, ISO 14001 environmental compliance, water and energy consumption records, waste reduction programs, circular economy initiatives, and ESG reporting obligations for regulatory and investor disclosure.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` (
    `esg_commitment_id` BIGINT COMMENT 'Unique surrogate key for each ESG commitment record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory frameworks require ESG commitments per jurisdiction; linking ensures compliance tracking for each jurisdiction.',
    `approval_date` DATE COMMENT 'Date when the commitment received formal approval.',
    `approved_by` STRING COMMENT 'Name of the executive or authority who approved the commitment.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Measured value of the metric in the baseline year.',
    `baseline_year` STRING COMMENT 'Year used as the reference point for measuring progress.',
    `commitment_code` STRING COMMENT 'External reference code or number used in public disclosures and internal tracking.',
    `commitment_description` STRING COMMENT 'Narrative description of the ESG pledge, including scope and rationale.',
    `commitment_owner` STRING COMMENT 'Internal department or business unit responsible for the commitment.',
    `commitment_scope` STRING COMMENT 'Geographic or operational scope of the commitment.. Valid values are `global|regional|site`',
    `commitment_type` STRING COMMENT 'Category of the ESG pledge (e.g., carbon neutrality, water stewardship).. Valid values are `carbon_neutrality|net_zero|water_stewardship|zero_waste|deforestation_free|social_responsibility`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment record was first created in the system.',
    `disclosure_status` STRING COMMENT 'Whether the commitment is publicly disclosed, kept private, or confidential.. Valid values are `public|private|confidential`',
    `effective_from` DATE COMMENT 'Date when the commitment becomes binding.',
    `effective_until` DATE COMMENT 'Date when the commitment ends or is scheduled to expire (null for open‑ended).',
    `esg_commitment_status` STRING COMMENT 'Current lifecycle state of the commitment.. Valid values are `active|inactive|completed|cancelled|pending`',
    `external_reference_code` STRING COMMENT 'Identifier from external registries (e.g., CDP, RE100) linked to this commitment.',
    `governing_body` STRING COMMENT 'External framework or initiative the commitment aligns with.. Valid values are `SBTi|UN_Global_Compact|RE100|CDP|TCFD`',
    `last_progress_date` DATE COMMENT 'Date of the most recent progress update.',
    `measurement_unit` STRING COMMENT 'Unit of measure for baseline and target values.. Valid values are `metric_tons_co2e|kilograms|percent|liters|kwh`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `progress_cadence` STRING COMMENT 'Frequency at which progress against the commitment is reported.. Valid values are `annual|quarterly|monthly|biannual`',
    `reporting_framework` STRING COMMENT 'Standard framework used for ESG reporting of this commitment.. Valid values are `GRI|SASB|TCFD|CDP|UN_SDGs`',
    `target_value` DECIMAL(18,2) COMMENT 'Desired metric value to be reached by the target year.',
    `target_year` STRING COMMENT 'Calendar year by which the commitment target should be achieved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the commitment record.',
    `verification_method` STRING COMMENT 'Method used to verify the reported progress.. Valid values are `third_party_audit|self_report|sensor_data|certification|none`',
    CONSTRAINT pk_esg_commitment PRIMARY KEY(`esg_commitment_id`)
) COMMENT 'Master record for Consumer Goods formal ESG commitments, targets, and pledges. Captures commitment type (carbon neutrality, net-zero, water stewardship, zero-waste-to-landfill, deforestation-free), target year, baseline year and value, target value, measurement unit, commitment owner, governing body alignment (SBTi, UN Global Compact, RE100), public disclosure status, and progress tracking cadence. Serves as the authoritative registry linking to periodic commitment_progress records for time-series tracking. Referenced by esg_disclosure for external reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` (
    `carbon_emission_id` BIGINT COMMENT 'System-generated unique identifier for each carbon emission record.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Carbon emission records may reference a purchased/retired offset; linking to carbon_offset centralizes offset details.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link carbon_emission to esg_commitment to associate each emission record with the relevant ESG commitment.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Required for Scope 3 carbon accounting: map each shipment to its emission record for regulatory and sustainability reporting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier of the manufacturing or distribution facility where the emission originated.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line or equipment generating the emission.',
    `sku_id` BIGINT COMMENT 'Identifier of the product associated with the emission event, if applicable.',
    `supply_chain_activity_id` BIGINT COMMENT 'Identifier of the upstream or downstream activity (e.g., raw material extraction, logistics) linked to the emission.',
    `activity_type` STRING COMMENT 'Specific activity type (e.g., manufacturing, logistics, packaging) that generated the emission.',
    `auditor_name` STRING COMMENT 'Name of the person or entity that performed verification.',
    `calculation_methodology` STRING COMMENT 'Methodology used to calculate the emission (e.g., GHG Protocol, ISO 14064, or custom model).. Valid values are `GHG Protocol|ISO 14064|Custom`',
    `carbon_intensity_factor` DECIMAL(18,2) COMMENT 'Ratio of emissions to production output (e.g., tonnes CO₂e per unit produced).',
    `cdpr_reporting_flag` BOOLEAN COMMENT 'Indicates whether the emission record must be disclosed to CDP.',
    `co2e_quantity_tonnes` DECIMAL(18,2) COMMENT 'Measured or calculated greenhouse gas emissions expressed as carbon dioxide equivalent in metric tonnes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the confidence level in the emission data.',
    `data_source` STRING COMMENT 'Origin of the data: sensor reading, calculation, estimate, or reported value.. Valid values are `sensor|calculated|estimated|reported`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor applied in the calculation, expressed in CO₂e per unit of activity (e.g., kg CO₂e per kWh).',
    `emission_factor_date` DATE COMMENT 'Effective date of the emission factor applied.',
    `emission_factor_source` STRING COMMENT 'Reference or provider of the emission factor used.',
    `emission_factor_version` STRING COMMENT 'Version identifier of the emission factor dataset.',
    `emission_source_category` STRING COMMENT 'Category of emission source such as combustion, electricity use, transport, raw material processing, waste, or other.. Valid values are `combustion|electricity|transport|raw_material|waste|other`',
    `emission_timestamp` TIMESTAMP COMMENT 'Date and time when the emission measurement or calculation was recorded.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumed associated with the emission event, expressed in megawatt‑hours.',
    `external_reporting_standard` STRING COMMENT 'Standard used for external ESG reporting of this emission.. Valid values are `CDP|GRI|SASB|TCFD`',
    `geographic_location` STRING COMMENT 'Three‑letter ISO country code where the emission occurred.. Valid values are `^[A-Z]{3}$`',
    `internal_project_code` STRING COMMENT 'Code of the internal sustainability project linked to the emission.',
    `measurement_unit` STRING COMMENT 'Unit of measurement for the emission quantity; default is tonnes of CO₂e.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the emission record.',
    `offset_quantity_tonnes` DECIMAL(18,2) COMMENT 'Quantity of CO₂e offset, in metric tonnes.',
    `offset_type` STRING COMMENT 'Category of carbon offset applied.. Valid values are `renewable_energy|reforestation|methane_capture|other`',
    `record_status` STRING COMMENT 'Current lifecycle status of the record.. Valid values are `active|inactive|deleted`',
    `reporting_period` STRING COMMENT 'Specific reporting period within the year.. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `reporting_year` STRING COMMENT 'Fiscal or calendar year for which the emission is reported.',
    `scope` STRING COMMENT 'GHG accounting scope: Scope 1 (direct), Scope 2 (purchased energy), or Scope 3 (value chain).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emission record.',
    `verification_date` DATE COMMENT 'Date when the emission record was verified.',
    `verification_status` STRING COMMENT 'Status of third‑party or internal verification of the emission record.. Valid values are `verified|unverified|pending`',
    `water_consumption_m3` DECIMAL(18,2) COMMENT 'Volume of water used in the process linked to the emission, in cubic metres.',
    CONSTRAINT pk_carbon_emission PRIMARY KEY(`carbon_emission_id`)
) COMMENT 'Transactional record of greenhouse gas (GHG) emissions measured or calculated at the facility, production line, product, or supply chain activity level. Captures emission date, emission source category (Scope 1 direct combustion, Scope 2 purchased energy, Scope 3 upstream/downstream), activity type (manufacturing, logistics, raw material extraction, packaging), CO2e quantity in metric tonnes, calculation methodology (GHG Protocol, ISO 14064), emission factor applied, data quality flag, and verification status. Primary operational record for carbon footprint tracking and CDP/GRI reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'System-generated unique identifier for each energy consumption record.',
    `energy_certificate_id` BIGINT COMMENT 'Foreign key linking to sustainability.energy_certificate. Business justification: Energy consumption can be tied to a renewable energy certificate for verification and reporting.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link energy_consumption to esg_commitment to tie energy use to ESG commitments.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing facility, distribution center, or office where the energy was consumed.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Factor used to convert energy_quantity to CO₂e emissions (kg CO₂e per unit).',
    `consumption_reference` STRING COMMENT 'Business reference code for the consumption record, used in reporting and reconciliation.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Date and time when the energy consumption measurement was taken or recorded.',
    `data_quality_status` STRING COMMENT 'Assessment of the reliability of the consumption measurement.. Valid values are `good|questionable|bad`',
    `data_source_system` STRING COMMENT 'Source ERP or utility system that supplied the consumption data.. Valid values are `SAP_S4HANA|Oracle_ERP|Other`',
    `energy_consumption_status` STRING COMMENT 'Current lifecycle state of the consumption record.. Valid values are `recorded|verified|adjusted|rejected`',
    `energy_intensity_ratio` DECIMAL(18,2) COMMENT 'Energy consumption per unit of production output (e.g., MWh per ton of product).',
    `energy_quantity` DECIMAL(18,2) COMMENT 'Amount of energy consumed during the period, expressed in the unit defined by energy_unit.',
    `energy_type` STRING COMMENT 'Category of energy consumed.. Valid values are `electricity|natural_gas|steam|renewable_solar|renewable_wind|other`',
    `energy_unit` STRING COMMENT 'Unit of measure for energy_quantity (megawatt‑hours or gigajoules).. Valid values are `MWh|GJ`',
    `iso_50001_compliance_flag` BOOLEAN COMMENT 'Indicates whether the measurement complies with ISO 50001 energy management standards (True/False).',
    `measurement_source` STRING COMMENT 'Origin of the consumption data (direct meter reading, utility bill, or estimated).. Valid values are `meter|utility_bill|estimated`',
    `meter_code` STRING COMMENT 'Unique identifier of the physical meter or virtual metering point used to capture the consumption.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the consumption entry.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period for the consumption record.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period for the consumption record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumption record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consumption record.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Share of the total energy consumption that was sourced from renewable resources, expressed as a percent.',
    `reporting_quarter` STRING COMMENT 'Fiscal quarter (1‑4) associated with the consumption record.',
    `reporting_year` STRING COMMENT 'Fiscal year for which the consumption data is reported.',
    `scope` STRING COMMENT 'GHG accounting scope applicable to the consumption (Scope 1, Scope 2, or Scope 3).. Valid values are `scope1|scope2|scope3`',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Applicable cost rate for the energy type during the consumption period, expressed in local currency per unit.',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Transactional record of energy consumed across manufacturing facilities, distribution centers, and offices. Captures consumption period (daily, monthly), facility reference, energy type (natural gas, electricity, steam, renewable solar/wind), quantity in MWh or GJ, renewable energy percentage, energy intensity ratio (per unit of production), tariff rate, meter ID, and ISO 50001 compliance flag. Feeds into Scope 1 and Scope 2 carbon emission calculations and energy reduction program tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` (
    `water_consumption_id` BIGINT COMMENT 'Unique surrogate key for each water consumption record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Water consumption contributes to ESG commitments; linking enables aggregation by commitment.',
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier of the manufacturing or processing facility where water was measured.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated CO₂‑equivalent emissions associated with the water consumption, expressed in kilograms.',
    `comments` STRING COMMENT 'Additional notes or observations about the water measurement.',
    `consumption_volume_m3` DECIMAL(18,2) COMMENT 'Net volume of water actually consumed by the facility processes, measured in cubic meters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Assessment of the reliability of the recorded data.',
    `discharge_destination` STRING COMMENT 'Final destination of the discharged water.. Valid values are `sewer|waterway|treatment_plant|reused`',
    `discharge_volume_m3` DECIMAL(18,2) COMMENT 'Volume of water discharged from the facility after use, measured in cubic meters.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the water measurement event was recorded.',
    `measurement_method` STRING COMMENT 'Method used to obtain the water volume figures.. Valid values are `meter|estimate|model`',
    `measurement_period_end` DATE COMMENT 'Last calendar date of the water measurement reporting period.',
    `measurement_period_start` DATE COMMENT 'First calendar date of the water measurement reporting period.',
    `recorded_by` STRING COMMENT 'Identifier of the user or system process that entered the record.',
    `regulatory_permit_reference` STRING COMMENT 'Identifier of the water use permit or license governing the withdrawal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `water_consumption_status` STRING COMMENT 'Current processing status of the water consumption record.. Valid values are `recorded|validated|rejected`',
    `water_quality_indicator` STRING COMMENT 'Key water quality parameter recorded alongside volume data.. Valid values are `pH|turbidity|none`',
    `water_recycling_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of withdrawn water that is recycled or reused within the facility.',
    `water_source_type` STRING COMMENT 'Classification of the water source used for the facility.. Valid values are `municipal|groundwater|surface_water|recycled`',
    `water_stress_area_flag` BOOLEAN COMMENT 'Indicates whether the facility is located in a water‑stress region (True) or not (False).',
    `withdrawal_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of water withdrawn from the source during the reporting period, measured in cubic meters.',
    CONSTRAINT pk_water_consumption PRIMARY KEY(`water_consumption_id`)
) COMMENT 'Transactional record of water withdrawal, usage, and discharge at the facility or process level. Captures measurement period, facility reference, water source type (municipal, groundwater, surface water, recycled), withdrawal volume in cubic meters, consumption volume, discharge volume, discharge destination (sewer, waterway, treatment plant), water stress area flag (based on WRI Aqueduct), water recycling rate, and regulatory permit reference. Supports water stewardship commitments and CDP Water disclosure.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` (
    `waste_generation_id` BIGINT COMMENT 'Primary key for waste_generation',
    `circular_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_initiative. Business justification: Waste generation is often mitigated through circular initiatives; linking tracks which initiative addresses each waste record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link waste_generation to esg_commitment to associate waste data with ESG commitments.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing or distribution facility where waste was generated.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external contractor responsible for waste handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was first created in the system.',
    `disposal_method` STRING COMMENT 'Method used to dispose or treat the waste.. Valid values are `landfill|incineration|recycling|composting|energy_recovery`',
    `diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill (e.g., recycled or composted).',
    `epa_reportable_flag` BOOLEAN COMMENT 'True if the waste record must be reported to EPA under hazardous waste regulations.',
    `manifest_number` STRING COMMENT 'Regulatory manifest number for hazardous waste shipments.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `quantity_unit` STRING COMMENT 'Unit of measure for waste_quantity.. Valid values are `kg|tonne`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the waste handling complies with applicable EPA/ISO 14001 regulations.',
    `transaction_number` STRING COMMENT 'External business identifier assigned to the waste transaction (e.g., waste ticket or manifest number).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the waste record.',
    `waste_category_code` STRING COMMENT 'Standardized code (e.g., EPA waste code) representing the waste category.',
    `waste_date` DATE COMMENT 'Date the waste was generated or recorded at the facility.',
    `waste_generation_status` STRING COMMENT 'Current lifecycle status of the waste record.. Valid values are `recorded|verified|approved|rejected`',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Amount of waste generated.',
    `waste_stream_type` STRING COMMENT 'Category of waste material.. Valid values are `plastic|cardboard|organic|hazardous|e_waste|metal`',
    `zero_waste_to_landfill_flag` BOOLEAN COMMENT 'Indicates whether the facility aims for zero waste to landfill for this record (true/false).',
    CONSTRAINT pk_waste_generation PRIMARY KEY(`waste_generation_id`)
) COMMENT 'Transactional record of waste generated, diverted, and disposed of at manufacturing and distribution facilities. Captures waste generation date, facility reference, waste stream type (plastic, cardboard, organic, hazardous, e-waste), waste quantity in kg or tonnes, disposal method (landfill, incineration, recycling, composting, energy recovery), diversion rate, waste contractor reference, manifest number for hazardous waste, and zero-waste-to-landfill program flag. Supports circular economy KPIs and EPA/OSHA regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` (
    `packaging_profile_id` BIGINT COMMENT 'System-generated unique identifier for the packaging profile record.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Packaging profiles are linked to product LCA studies to provide lifecycle impact context.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Enables mapping packaging profiles to SKUs for sustainability reporting and material compliance.',
    `additional_certification` STRING COMMENT 'Other sustainability certifications applicable to the packaging (e.g., RSPO, ISO 14001).. Valid values are `FSC|RSPO|ISO14001|none`',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated greenhouse‑gas emissions associated with the packaging, expressed in kilograms CO₂‑equivalent.',
    `component_type` STRING COMMENT 'Classification of the packaging element (primary, secondary, or tertiary).. Valid values are `primary|secondary|tertiary`',
    `compostable` BOOLEAN COMMENT 'True if the packaging holds a recognized compostability certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the packaging profile record was first created.',
    `design_version` STRING COMMENT 'Version identifier for the packaging design (e.g., "v2.1").',
    `effective_end_date` DATE COMMENT 'Date when the packaging profile is retired or superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the packaging profile becomes active for use.',
    `end_of_life_disposal_method` STRING COMMENT 'Designated disposal route for the packaging after consumer use.. Valid values are `landfill|recycling|compost|incineration|reuse`',
    `energy_usage_kwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed to manufacture the packaging component.',
    `eu_packaging_waste_compliance_status` STRING COMMENT 'Compliance status with the EU Packaging and Packaging Waste Regulation.. Valid values are `compliant|non_compliant|pending`',
    `fsc_certified` BOOLEAN COMMENT 'True if paper‑based components are FSC certified.',
    `gtin` STRING COMMENT 'Universal product identifier associated with the packaged product.',
    `last_review_date` DATE COMMENT 'Date of the most recent sustainability review of the packaging configuration.',
    `lightweighting_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in weight compared with the previous version of the packaging.',
    `material_composition_aluminum_percent` DECIMAL(18,2) COMMENT 'Proportion of aluminum material in the packaging component.',
    `material_composition_glass_percent` DECIMAL(18,2) COMMENT 'Proportion of glass material in the packaging component.',
    `material_composition_paper_percent` DECIMAL(18,2) COMMENT 'Proportion of paper or cardboard material in the packaging component.',
    `material_composition_pcr_percent` DECIMAL(18,2) COMMENT 'Percentage of the material that is post‑consumer recycled content.',
    `material_composition_virgin_percent` DECIMAL(18,2) COMMENT 'Percentage of virgin (non‑recycled) plastic in the packaging.',
    `material_primary` STRING COMMENT 'Main material used for the packaging component.. Valid values are `plastic|glass|aluminum|paper|metal|other`',
    `material_source` STRING COMMENT 'Narrative description of the material source (e.g., "recycled PET from post‑consumer bottles").',
    `packaging_height_cm` DECIMAL(18,2) COMMENT 'External height of the packaging component in centimeters.',
    `packaging_length_cm` DECIMAL(18,2) COMMENT 'External length of the packaging component in centimeters.',
    `packaging_name` STRING COMMENT 'Human‑readable name describing the packaging configuration (e.g., "Eco‑Lite Primary Bottle").',
    `packaging_profile_status` STRING COMMENT 'Current lifecycle state of the packaging profile.. Valid values are `active|inactive|deprecated|draft`',
    `packaging_supplier` STRING COMMENT 'Name of the external supplier providing the packaging component.',
    `packaging_weight_grams` DECIMAL(18,2) COMMENT 'Total weight of the packaging component in grams.',
    `packaging_width_cm` DECIMAL(18,2) COMMENT 'External width of the packaging component in centimeters.',
    `product_sku` STRING COMMENT 'SKU of the product that uses this packaging configuration.',
    `recyclability_rating` STRING COMMENT 'Indicates whether the packaging is recyclable, non‑recyclable, or rating unknown.. Valid values are `recyclable|non_recyclable|unknown`',
    `recycled_content_percent` DECIMAL(18,2) COMMENT 'Overall percentage of recycled material present in the packaging.',
    `reusable` BOOLEAN COMMENT 'True if the packaging is designed for multiple use cycles.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Overall sustainability rating assigned by internal assessment (scale 0‑100).',
    `units_per_package` STRING COMMENT 'Number of individual product units contained in a single packaging unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the packaging profile record.',
    `water_usage_liters` DECIMAL(18,2) COMMENT 'Volume of water consumed in the production of the packaging component.',
    CONSTRAINT pk_packaging_profile PRIMARY KEY(`packaging_profile_id`)
) COMMENT 'Master record defining the sustainability attributes of a products packaging configuration. Captures SKU/GTIN reference, packaging component type (primary, secondary, tertiary), material composition (PCR plastic %, virgin plastic %, glass, aluminum, paper/cardboard), recyclability rating, compostability certification, recycled content percentage, packaging weight in grams, lightweighting reduction vs. prior version, FSC certification flag for paper-based materials, and EU Packaging and Packaging Waste Regulation compliance status. SSOT for packaging sustainability data linked to the product domain.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` (
    `sourcing_certification_id` BIGINT COMMENT 'Primary key for sourcing_certification',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Sourcing certifications support ESG commitments; linking enables commitment‑level reporting of certifications.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the certified party (supplier or internal facility).',
    `raw_material_spec_id` BIGINT COMMENT 'Unique identifier of the raw material or ingredient.',
    `annual_certified_volume` DECIMAL(18,2) COMMENT 'Annual volume of the raw material covered by the certification.',
    `audit_report_reference` STRING COMMENT 'Reference code or URL to the audit report document.',
    `audit_status` STRING COMMENT 'Current status of the certification audit.. Valid values are `pending|completed|failed|in_progress`',
    `certificate_number` STRING COMMENT 'Official certificate number issued by the certification body.',
    `certification_body` STRING COMMENT 'Organization that issued the certification.',
    `certification_scope` STRING COMMENT 'Scope of the certification (mass balance, segregated, or book-and-claim).. Valid values are `mass_balance|segregated|book_and_claim`',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|inactive|revoked`',
    `certification_type` STRING COMMENT 'Type of sustainable sourcing certification (e.g., RSPO, FSC, Fair Trade).. Valid values are `RSPO|FSC|Rainforest Alliance|Fair Trade|UTZ|Organic`',
    `certification_url` STRING COMMENT 'Web link to the certification details or public registry entry.',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance observations or actions.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the certified material.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Name of the source system that provided the certification record (e.g., SAP S/4HANA, Veeva Vault).',
    `effective_from` DATE COMMENT 'Date when the certification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the certification expires or is no longer valid.',
    `geographic_region` STRING COMMENT 'Geographic region or country code where the certification applies. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|CHN|IND|... — promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification data was last verified for accuracy.',
    `notes` STRING COMMENT 'Additional free-form notes related to the certification.',
    `raw_material_name` STRING COMMENT 'Name of the raw material or ingredient covered by the certification.',
    `renewal_notice_date` DATE COMMENT 'Date when a renewal notice was sent to the certified entity.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification is due for renewal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `volume_unit` STRING COMMENT 'Unit of measure for the certified volume (e.g., kg, ton).. Valid values are `kg|ton|lb|g|mg|lb`',
    CONSTRAINT pk_sourcing_certification PRIMARY KEY(`sourcing_certification_id`)
) COMMENT 'Master record for sustainable sourcing certifications held by Consumer Goods or its suppliers for specific raw materials or ingredients. Captures certification type (RSPO, FSC, Rainforest Alliance, Fair Trade, UTZ, organic), certified entity (supplier or internal facility), raw material or ingredient covered, certification body, certificate number, issue date, expiry date, certification scope (mass balance, segregated, book-and-claim), annual certified volume, and audit status. Supports RSPO and FSC compliance reporting and Scope 3 sustainable procurement claims.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'System-generated unique identifier for the environmental permit record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Environmental permits are required to meet ESG commitments; linking provides permit visibility per commitment.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the facility to which the permit applies.',
    `activity_description` STRING COMMENT 'Narrative description of the activity authorized by the permit (e.g., manufacturing process, waste handling).',
    `compliance_status` STRING COMMENT 'Overall compliance status of the permit based on monitoring and inspections.. Valid values are `compliant|non_compliant|conditionally_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `discharge_limit` DECIMAL(18,2) COMMENT 'Maximum allowable discharge quantity for the permitted activity.',
    `emission_limit` DECIMAL(18,2) COMMENT 'Maximum allowable emission quantity for the permitted activity.',
    `environmental_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|inactive|suspended|expired|pending`',
    `expiry_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection.. Valid values are `passed|failed|conditional|pending`',
    `iso_14001_linkage` STRING COMMENT 'Reference to the facilitys ISO 14001 Environmental Management System certification status.',
    `issue_date` DATE COMMENT 'Date the permit was originally issued.',
    `issuing_authority` STRING COMMENT 'Regulatory body that issued the permit (e.g., U.S. EPA, state agency, local agency, EU competent authority).. Valid values are `EPA|State|Local|EU`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection of the permit.',
    `limit_unit` STRING COMMENT 'Unit of measure for emission or discharge limits.. Valid values are `kg_per_year|m3_per_day|lb_per_year`',
    `monitoring_frequency` STRING COMMENT 'How often compliance monitoring is required.. Valid values are `monthly|quarterly|annually`',
    `notes` STRING COMMENT 'Free-form field for additional comments or special conditions.',
    `permit_number` STRING COMMENT 'Official permit or license number assigned by the issuing authority.',
    `permit_type` STRING COMMENT 'Category of the environmental permit (e.g., air emissions, wastewater discharge, hazardous waste storage, stormwater).. Valid values are `air|water|waste|stormwater`',
    `renewal_status` STRING COMMENT 'Renewal condition of the permit (e.g., renewed, pending renewal, overdue).. Valid values are `renewed|pending|overdue`',
    `reporting_requirements` STRING COMMENT 'Specific reporting obligations tied to the permit (e.g., format, submission deadlines).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Master record for environmental operating permits and licenses held by Consumer Goods facilities. Captures permit type (air emissions, wastewater discharge, hazardous waste storage, stormwater), issuing regulatory authority (EPA, state/local agency, EU competent authority), permit number, facility reference, permitted activity description, emission or discharge limits, permit issue date, expiry date, renewal status, and ISO 14001 EMS linkage. Serves as the authoritative registry of environmental operating authorizations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` (
    `environmental_incident_id` BIGINT COMMENT 'System-generated unique identifier for the environmental incident record.',
    `capa_id` BIGINT COMMENT 'Identifier of the corrective action plan linked to this incident.',
    `esg_audit_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_audit. Business justification: Incidents are often audited; linking to ESG audit captures audit findings related to each incident.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the facility or site where the incident took place.',
    `surveillance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.surveillance_event. Business justification: Environmental incidents must be reported to the regulatory post‑market surveillance system; FK enables incident reporting and follow‑up.',
    `city` STRING COMMENT 'City name of the incident location.',
    `closure_date` DATE COMMENT 'Date the incident record was formally closed after remediation.',
    `compliance_notes` STRING COMMENT 'Additional comments from compliance officers regarding the incident.',
    `compliance_status` STRING COMMENT 'Result of compliance review against the applicable framework.. Valid values are `compliant|noncompliant|pending`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the estimated cost.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the incident occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was created in the system.',
    `environmental_impact_assessment` STRING COMMENT 'Summary of the assessed environmental impact (e.g., area affected, ecosystem risk).',
    `environmental_incident_status` STRING COMMENT 'Current processing state of the incident record.. Valid values are `open|investigating|closed|rejected`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected financial cost to remediate the incident.',
    `incident_description` STRING COMMENT 'Free‑text description of what happened, including circumstances and immediate impacts.',
    `incident_number` STRING COMMENT 'Human‑readable reference number assigned to the incident for tracking and reporting.',
    `incident_subtype` STRING COMMENT 'More detailed classification within the incident type, free‑text for specific description.',
    `incident_timestamp` TIMESTAMP COMMENT 'Exact date and time when the incident occurred.',
    `incident_type` STRING COMMENT 'Category of the environmental incident (e.g., chemical spill, air emission exceedance).. Valid values are `chemical_spill|air_emission|wastewater_violation|soil_contamination|near_miss`',
    `is_regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the incident must be reported to a regulator (e.g., EPA, OSHA).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the incident location.',
    `location_description` STRING COMMENT 'Free‑text description of the precise location within the facility (e.g., building, zone, equipment).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the incident location.',
    `notification_date` DATE COMMENT 'Date on which the required regulatory notification was submitted.',
    `quantity_released` DECIMAL(18,2) COMMENT 'Measured amount of the substance released during the incident.',
    `remediation_end_date` DATE COMMENT 'Date remediation work was completed.',
    `remediation_start_date` DATE COMMENT 'Date remediation work began.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities for the incident.. Valid values are `not_started|in_progress|completed|failed`',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time the incident was first reported to the organization.',
    `reporting_framework` STRING COMMENT 'Regulatory or standards framework used for reporting the incident.. Valid values are `EPA|OSHA|ISO14001|Other`',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause (e.g., equipment failure, human error). [ENUM-REF-CANDIDATE: equipment_failure|human_error|process_gap|external_factor|unknown — promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause analysis findings.',
    `severity_level` STRING COMMENT 'Business‑defined severity of the incident based on impact and regulatory risk.. Valid values are `low|moderate|high|critical`',
    `state_code` STRING COMMENT 'Two‑letter state or province abbreviation (U.S. format).. Valid values are `^[A-Z]{2}$`',
    `substance_code` STRING COMMENT 'Chemical Abstracts Service (CAS) registry number identifying the substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `substance_name` STRING COMMENT 'Common name of the chemical or material released.',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity released.. Valid values are `kg|liters|gallons|cubic_meters|pounds`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident record.',
    `zip_code` STRING COMMENT 'Postal/ZIP code of the incident location.. Valid values are `^[0-9A-Z]{3,10}$`',
    CONSTRAINT pk_environmental_incident PRIMARY KEY(`environmental_incident_id`)
) COMMENT 'Transactional record of environmental incidents, spills, exceedances, and near-misses at Consumer Goods facilities or in the supply chain. Captures incident date and time, facility or location reference, incident type (chemical spill, air emission exceedance, wastewater discharge violation, soil contamination), severity classification, quantity and substance released, regulatory notification requirement flag, notification date, corrective action plan reference, root cause category, and closure date. Supports EPA/OSHA regulatory reporting and ISO 14001 nonconformance management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` (
    `esg_disclosure_id` BIGINT COMMENT 'Unique surrogate key for each ESG disclosure record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Disclosures report on ESG commitments; linking enables traceability from disclosure to the underlying commitment.',
    `materiality_assessment_id` BIGINT COMMENT 'Reference to the materiality assessment that underpins the disclosed metrics.',
    `approval_date` DATE COMMENT 'Date the ESG disclosure was approved for submission.',
    `approved_by` STRING COMMENT 'Name of the internal stakeholder who approved the ESG disclosure for submission.',
    `assurance_level` STRING COMMENT 'Level of external assurance applied to the ESG disclosure.. Valid values are `none|limited|reasonable`',
    `assurance_provider` STRING COMMENT 'Name of the third‑party assurance firm providing verification.',
    `carbon_emissions_scope1` DECIMAL(18,2) COMMENT 'Direct (Scope 1) greenhouse gas emissions, measured in metric tonnes CO₂e.',
    `carbon_emissions_scope2` DECIMAL(18,2) COMMENT 'Indirect (Scope 2) greenhouse gas emissions from purchased electricity, measured in metric tonnes CO₂e.',
    `carbon_emissions_scope3` DECIMAL(18,2) COMMENT 'Other indirect (Scope 3) greenhouse gas emissions across the value chain, measured in metric tonnes CO₂e.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ESG disclosure record was first created in the system.',
    `disclosure_reference` STRING COMMENT 'Business identifier assigned to the ESG disclosure submission (e.g., internal tracking number).',
    `energy_consumption` DECIMAL(18,2) COMMENT 'Total energy consumed, measured in megawatt‑hours (MWh).',
    `esg_disclosure_status` STRING COMMENT 'Current lifecycle status of the ESG disclosure.. Valid values are `draft|submitted|published|rejected|withdrawn`',
    `framework` STRING COMMENT 'Framework used for the ESG disclosure (e.g., GRI, CDP, TCFD, SASB, EU CSRD, SEC Climate Rule, UN SDG). [ENUM-REF-CANDIDATE: GRI|CDP|TCFD|SASB|EU_CS_RD|SEC_Climate|UN_SDG — promote to reference product]',
    `fsc_certified` BOOLEAN COMMENT 'Indicates whether the disclosed products are certified by the Forest Stewardship Council.',
    `iso_14001_compliance` BOOLEAN COMMENT 'Flag indicating compliance with ISO 14001 environmental management standards.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the ESG disclosure.',
    `packaging_recyclability_rate` DECIMAL(18,2) COMMENT 'Percentage of packaging material that is recyclable or made from recycled content.',
    `public_url` STRING COMMENT 'Web address where the published ESG disclosure can be accessed.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Share of total energy consumption sourced from renewable resources, expressed as a percent.',
    `reporting_period_end` DATE COMMENT 'End date of the ESG reporting period.',
    `reporting_period_start` DATE COMMENT 'Start date of the ESG reporting period.',
    `reporting_quarter` STRING COMMENT 'Quarter of the reporting year covered by the ESG disclosure.. Valid values are `Q1|Q2|Q3|Q4`',
    `reporting_year` STRING COMMENT 'Calendar year of the ESG reporting period.',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether the disclosed products meet Roundtable on Sustainable Palm Oil certification.',
    `submission_date` DATE COMMENT 'Date the ESG disclosure was submitted to the external framework or regulator.',
    `total_carbon_emissions` DECIMAL(18,2) COMMENT 'Aggregated total carbon emissions (Scope 1 + Scope 2 + Scope 3) for the reporting period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ESG disclosure record.',
    `waste_generated` DECIMAL(18,2) COMMENT 'Total waste produced, measured in metric tonnes.',
    `water_consumption` DECIMAL(18,2) COMMENT 'Total water used in operations during the reporting period, measured in cubic meters.',
    CONSTRAINT pk_esg_disclosure PRIMARY KEY(`esg_disclosure_id`)
) COMMENT 'Master record for formal ESG disclosure submissions made to external frameworks, regulators, and investors. Captures disclosure framework (GRI, CDP, TCFD, SASB, EU CSRD, SEC Climate Rule, UN SDG), reporting period, submission date, disclosure status (draft, submitted, published), reported metrics summary (carbon emissions, water, waste, social indicators), assurance level (limited, reasonable, none), assurance provider, public URL, and materiality assessment reference. SSOT for all external ESG reporting obligations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` (
    `circular_initiative_id` BIGINT COMMENT 'Unique system-generated identifier for the circular initiative.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link circular_initiative to esg_commitment to tie circular economy programs to ESG commitments.',
    `manufacturing_facility_id` BIGINT COMMENT 'add column manufacturing_facility_id (BIGINT) with FK to manufacturing.manufacturing_facility.manufacturing_facility_id - circular economy initiatives are implemented at specific facilities',
    `carbon_footprint_avoided_tonnes` DECIMAL(18,2) COMMENT 'Estimated tonnes of CO₂ emissions avoided due to the initiative.',
    `circular_initiative_status` STRING COMMENT 'Current lifecycle state of the initiative.. Valid values are `planned|active|completed|paused|cancelled`',
    `compliance_fsc_certified` BOOLEAN COMMENT 'True if the initiative meets Forest Stewardship Council (FSC) certification requirements.',
    `compliance_rspo_certified` BOOLEAN COMMENT 'True if the initiative meets Roundtable on Sustainable Palm Oil (RSPO) certification requirements.',
    `consumer_participation_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of target consumers who have participated in the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the initiative record was first created in the system.',
    `data_quality_status` STRING COMMENT 'Assessment of the data quality for this record.. Valid values are `good|fair|poor`',
    `energy_savings_mwh` DECIMAL(18,2) COMMENT 'Energy saved (megawatt‑hours) as a result of the initiative.',
    `external_reference_code` STRING COMMENT 'Identifier used in external sustainability reporting systems.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries covered by the initiative (free‑text or comma‑separated ISO‑3 country codes).',
    `initiative_budget_currency` STRING COMMENT 'ISO 4217 three‑letter currency code for the investment amount.. Valid values are `^[A-Z]{3}$`',
    `initiative_code` STRING COMMENT 'Business code used to reference the initiative in external systems and reports.',
    `initiative_name` STRING COMMENT 'Human‑readable name of the circular economy program.',
    `initiative_owner` STRING COMMENT 'Name of the internal business owner responsible for the initiative.',
    `initiative_owner_email` STRING COMMENT 'Email address of the initiative owner.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `investment_amount_usd` DECIMAL(18,2) COMMENT 'Capital invested in the initiative, expressed in US dollars.',
    `is_public_reportable` BOOLEAN COMMENT 'Indicates whether the initiative data may be disclosed publicly.',
    `iso_14001_compliance` BOOLEAN COMMENT 'True if the initiative complies with ISO 14001 environmental management standards.',
    `last_progress_date` DATE COMMENT 'Date of the most recent progress update.',
    `launch_date` DATE COMMENT 'Date the initiative was launched or became operational.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the initiative within its lifecycle.. Valid values are `planning|implementation|monitoring|closure`',
    `material_diverted_tonnes` DECIMAL(18,2) COMMENT 'Total tonnes of material diverted from landfill or virgin feedstock.',
    `material_recovered_tonnes` DECIMAL(18,2) COMMENT 'Total tonnes of material recovered through the initiative.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the initiative.',
    `partner_organizations` STRING COMMENT 'List of external partners (e.g., recyclers, NGOs) involved in the initiative.',
    `program_type` STRING COMMENT 'Category of circular initiative (e.g., take‑back program, refillable packaging).. Valid values are `take_back|refillable|pcr_increase|packaging_elimination|product_as_service|industrial_symbiosis`',
    `progress_status` STRING COMMENT 'Current progress indicator against defined KPIs.. Valid values are `on_track|behind|ahead|at_risk`',
    `record_source_system` STRING COMMENT 'Name of the source operational system (e.g., SAP S/4HANA, Oracle ERP) that supplied the record.',
    `reporting_framework` STRING COMMENT 'External sustainability reporting framework used for disclosure.. Valid values are `Ellen_MacArthur|GRI|SASB|CDP|UN_SDGs`',
    `stakeholder_group` STRING COMMENT 'Primary stakeholder group(s) impacted by the initiative (e.g., consumers, suppliers).',
    `target_end_date` DATE COMMENT 'Planned end or sunset date for the initiative.',
    `target_material` STRING COMMENT 'Primary material or product category the initiative aims to address.. Valid values are `plastic|paper|glass|metal|textile|other`',
    `target_material_percentage` DECIMAL(18,2) COMMENT 'Target percentage of product composition that must be recycled or contain recycled content.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the initiative record.',
    `verification_method` STRING COMMENT 'Method used to verify the initiatives reported metrics (e.g., third‑party audit, internal review).',
    `waste_reduction_tonnes` DECIMAL(18,2) COMMENT 'Tonnes of waste reduced or avoided through the program.',
    `water_savings_cubic_meters` DECIMAL(18,2) COMMENT 'Volume of water saved (in cubic meters) attributable to the initiative.',
    CONSTRAINT pk_circular_initiative PRIMARY KEY(`circular_initiative_id`)
) COMMENT 'Master record for circular economy programs managed by Consumer Goods. Captures initiative name, type (take-back program, refillable packaging, PCR content increase, packaging elimination, product-as-a-service, industrial symbiosis), target material or product category, launch date, target end date, geographic scope, material recovered/diverted in tonnes, partner organizations, investment amount, consumer participation rate, and progress status against circular economy KPIs. Supports Ellen MacArthur Foundation reporting and public sustainability communications.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` (
    `supplier_esg_eval_id` BIGINT COMMENT 'System-generated unique identifier for each ESG assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal or external assessor who performed the evaluation.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Supplier ESG evaluations are performed against ESG commitments; linking provides commitment context for each evaluation.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier being evaluated.',
    `assessment_date` DATE COMMENT 'Date the ESG assessment was performed or finalized.',
    `assessment_reference` STRING COMMENT 'External reference code assigned to the ESG assessment, used for tracking across systems.',
    `assessment_scope` STRING COMMENT 'Scope of ESG dimensions covered by the assessment.. Valid values are `environmental|social|governance|ethics|combined`',
    `assessment_type` STRING COMMENT 'Methodology used for the ESG assessment.. Valid values are `self_questionnaire|third_party_audit|ecovadis|sedex_smeta`',
    `assessment_version` STRING COMMENT 'Version identifier of the assessment questionnaire or audit protocol.',
    `carbon_emission_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers carbon emissions performance.',
    `comments` STRING COMMENT 'Free‑text field for additional observations or notes from the assessor.',
    `compliance_flags` STRING COMMENT 'Pipe‑separated list of compliance certifications or regulations applicable to the supplier.. Valid values are `iso_14001|gmp|fsc|rspo|epa|cfr`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which required corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are mandated based on findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non‑conformities identified during the assessment.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the assessment data (e.g., SAP S/4HANA, Veeva Vault).',
    `energy_consumption_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers energy efficiency and renewable energy usage.',
    `environmental_score` DECIMAL(18,2) COMMENT 'Score for the environmental pillar of the ESG assessment.',
    `epa_reportable` BOOLEAN COMMENT 'Indicates whether the suppliers activities are subject to EPA reporting requirements.',
    `ethics_score` DECIMAL(18,2) COMMENT 'Score for the ethics pillar of the ESG assessment.',
    `evidence_documentation` STRING COMMENT 'Reference (e.g., URL or document ID) to supporting evidence uploaded for the assessment.',
    `fsc_certified` BOOLEAN COMMENT 'True if the supplier holds Forest Stewardship Council certification for sustainable sourcing.',
    `governance_score` DECIMAL(18,2) COMMENT 'Score for the governance pillar of the ESG assessment.',
    `iso_14001_compliance` BOOLEAN COMMENT 'Indicates whether the supplier complies with ISO 14001 environmental management standards.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated ESG score for the supplier, typically on a 0‑100 scale.',
    `overall_score_category` STRING COMMENT 'Categorical rating derived from the overall ESG score.. Valid values are `high|medium|low|critical`',
    `rating_methodology` STRING COMMENT 'Narrative description of the methodology and weighting used to calculate scores.',
    `reassessment_date` DATE COMMENT 'Planned date for the next ESG reassessment of the supplier.',
    `rspo_certified` BOOLEAN COMMENT 'True if the supplier is certified by the Roundtable on Sustainable Palm Oil.',
    `scope_3_included` BOOLEAN COMMENT 'True if the assessment includes Scope 3 (value‑chain) emissions data.',
    `social_score` DECIMAL(18,2) COMMENT 'Score for the social pillar of the ESG assessment.',
    `supplier_esg_eval_status` STRING COMMENT 'Current lifecycle status of the ESG assessment.. Valid values are `pending|in_progress|completed|rejected`',
    `supplier_risk_level` STRING COMMENT 'Overall risk classification derived from ESG scores and findings.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    `waste_management_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers waste reduction and recycling practices.',
    `water_consumption_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers water usage and stewardship.',
    CONSTRAINT pk_supplier_esg_eval PRIMARY KEY(`supplier_esg_eval_id`)
) COMMENT 'Transactional record of sustainability assessments conducted on raw material and packaging suppliers. Captures assessment date, supplier reference, assessment type (self-assessment questionnaire, third-party audit, EcoVadis scorecard, Sedex SMETA), assessment scope (environmental, social, governance, ethics), overall sustainability score, individual pillar scores, critical findings count, corrective action required flag, corrective action due date, reassessment date, and assessor identity. Supports responsible sourcing programs and Scope 3 supply chain sustainability management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'Unique system-generated identifier for each carbon offset record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link carbon_offset to esg_commitment to relate offset purchases/retirements to commitments.',
    `alignment_type` STRING COMMENT 'Strategic alignment of the credit (temporary offset vs. permanent removal).. Valid values are `interim_offset|permanent_removal|net_zero_strategy`',
    `carbon_offset_status` STRING COMMENT 'Current lifecycle status of the offset record.. Valid values are `active|retired|cancelled|pending`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the offset complies with relevant ESG and regulatory frameworks (e.g., ISO 14064).',
    `cost_per_tonne` DECIMAL(18,2) COMMENT 'Purchase price per tonne of CO₂e in US dollars.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the project location.. Valid values are `USA|CAN|MEX|GBR|CHN|IND`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offset record was first created in the system.',
    `credit_quantity_purchased` DECIMAL(18,2) COMMENT 'Total tonnes of CO₂ equivalent purchased.',
    `credit_quantity_retired` DECIMAL(18,2) COMMENT 'Total tonnes of CO₂ equivalent retired (used for offsetting).',
    `external_reference_code` STRING COMMENT 'Any external identifier used by partners or auditors to reference this offset.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the offset transaction.',
    `project_description` STRING COMMENT 'Detailed narrative describing the offset projects objectives and activities.',
    `project_location` STRING COMMENT 'Geographic location (city, region) where the offset project is implemented.',
    `project_name` STRING COMMENT 'Descriptive name of the offset project (e.g., Amazon Rainforest Reforestation).',
    `project_type` STRING COMMENT 'Category of the offset project indicating the mitigation approach.. Valid values are `reforestation|renewable_energy|methane_capture|blue_carbon|soil_sequestration`',
    `purchase_certificate_number` STRING COMMENT 'Unique identifier of the purchase certificate issued by the registry.',
    `purchase_date` DATE COMMENT 'Date the carbon credits were purchased by Consumer Goods.',
    `registry` STRING COMMENT 'Standard registry that validates and tracks the offset credits.. Valid values are `gold_standard|verra_vcs|american_carbon_registry|climate_action_reserve`',
    `reporting_year` STRING COMMENT 'Fiscal year for which the offset is reported in CDP or ESG disclosures.',
    `retirement_certificate_number` STRING COMMENT 'Registry‑issued certificate number confirming retirement.',
    `retirement_date` DATE COMMENT 'Date the credits were officially retired.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost = cost_per_tonne × credit_quantity_purchased.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the offset record.',
    `verification_method` STRING COMMENT 'Method used to verify the offset (third‑party audit, internal audit, or none).',
    `vintage_year` STRING COMMENT 'Calendar year in which the carbon credits were generated.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Master record for carbon offset credits purchased or retired by Consumer Goods to compensate for residual GHG emissions. Captures offset project name, project type (reforestation, renewable energy, methane capture, blue carbon), project location, registry (Gold Standard, Verra VCS, American Carbon Registry), credit vintage year, quantity purchased in tCO2e, quantity retired in tCO2e, retirement date, retirement certificate number, cost per tonne, and alignment with net-zero strategy (interim offset vs. permanent removal). Supports carbon neutrality claims and CDP climate disclosure.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` (
    `product_lca_id` BIGINT COMMENT 'System-generated unique identifier for each LCA record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link product_lca to esg_commitment to associate LCA results with ESG commitments.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse‑gas emissions expressed in kilograms of CO₂ equivalent per functional unit.',
    `certification_fsc` BOOLEAN COMMENT 'Indicates whether the product’s raw material sourcing is FSC‑certified.',
    `certification_rspo` BOOLEAN COMMENT 'Indicates whether the product’s palm oil sourcing complies with RSPO standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the LCA record was first created in the lakehouse.',
    `data_quality_status` STRING COMMENT 'Overall quality rating of the LCA data after validation.. Valid values are `high|medium|low`',
    `data_source_system` STRING COMMENT 'Operational system that supplied the LCA data (e.g., SAP S/4HANA, Veeva Vault).',
    `functional_unit_quantity` DECIMAL(18,2) COMMENT 'Numeric amount defining the functional unit (e.g., 1, 100).',
    `functional_unit_uom` STRING COMMENT 'Unit of measure for the functional unit (e.g., kg, litre, unit).',
    `hotspot_stages` STRING COMMENT 'Comma‑separated list of life‑cycle stages that contribute the most to environmental impact. [ENUM-REF-CANDIDATE: raw_material|manufacturing|distribution|use|end_of_life — promote to reference product]',
    `intended_use` STRING COMMENT 'Primary business purpose for which the LCA results will be used.. Valid values are `product_labeling|rd_reformulation|regulatory_submission|marketing|internal_reporting`',
    `iso_14040_compliance_flag` BOOLEAN COMMENT 'Indicates whether the study complies with ISO 14040/14044 methodology.',
    `lca_practitioner` STRING COMMENT 'Name or identifier of the analyst or team that performed the LCA.',
    `lca_study_type` STRING COMMENT 'Scope of the LCA study indicating the system boundaries.. Valid values are `cradle-to-gate|cradle-to-grave|cradle-to-cradle`',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the analyst.',
    `peer_review_status` STRING COMMENT 'Current status of external or internal peer review of the LCA study.. Valid values are `pending|approved|rejected`',
    `product_category` STRING COMMENT 'High‑level classification of the product (e.g., personal care, household cleaning).',
    `product_lca_status` STRING COMMENT 'Lifecycle status of the LCA record within the data product.. Valid values are `draft|active|archived|retired`',
    `product_name` STRING COMMENT 'Human‑readable name of the product or product category the LCA study pertains to.',
    `region` STRING COMMENT 'Three‑letter ISO country code indicating the primary market or region for the LCA study.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the LCA meets applicable regulatory reporting requirements (e.g., EPA, FDA).',
    `sku` STRING COMMENT 'Standard inventory identifier (SKU, UPC, GTIN) for the product under assessment.',
    `study_date` DATE COMMENT 'Date when the LCA study was completed or officially recorded.',
    `system_boundary_description` STRING COMMENT 'Narrative description of the life‑cycle stages included in the assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the LCA record.',
    `water_footprint_liters` DECIMAL(18,2) COMMENT 'Total freshwater consumption per functional unit expressed in litres.',
    CONSTRAINT pk_product_lca PRIMARY KEY(`product_lca_id`)
) COMMENT 'Master record for Life Cycle Assessment (LCA) studies conducted on Consumer Goods products or product categories. Captures SKU or product category reference, LCA study type (cradle-to-gate, cradle-to-grave, cradle-to-cradle), functional unit definition, system boundary description, study date, LCA practitioner, ISO 14040/14044 compliance flag, total carbon footprint in kg CO2e per functional unit, water footprint, key hotspot life cycle stages, peer review status, and intended use (product labeling, R&D reformulation, regulatory submission). Supports product-level environmental footprint claims and eco-design decisions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` (
    `energy_certificate_id` BIGINT COMMENT 'System-generated unique identifier for the renewable energy certificate record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link energy_certificate to esg_commitment to connect renewable energy certificates with commitments.',
    `business_unit` STRING COMMENT 'Organizational unit within Consumer Goods that holds ownership of the certificate.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Emission factor (kg CO₂e per MWh) used to calculate avoided emissions.',
    `certificate_name` STRING COMMENT 'Human‑readable name or title for the certificate.',
    `certificate_number` STRING COMMENT 'External certificate number or serial assigned by the registry.',
    `certificate_type` STRING COMMENT 'Type of renewable energy certificate: Renewable Energy Certificate (REC), Guarantees of Origin (GO), or International REC (I‑REC).. Valid values are `REC|GO|I-REC`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the lakehouse.',
    `data_quality_status` STRING COMMENT 'Assessment of the data quality for this record.. Valid values are `high|medium|low`',
    `energy_certificate_status` STRING COMMENT 'Current lifecycle status of the certificate.. Valid values are `active|retired|pending|cancelled`',
    `energy_source` STRING COMMENT 'Primary energy generation source for the certificate.. Valid values are `solar|wind|hydro|biomass|geothermal|other`',
    `expiration_date` DATE COMMENT 'Date on which the certificate expires, if applicable.',
    `external_reference_code` STRING COMMENT 'Reference code linking to external documentation or contracts.',
    `generating_facility_location` STRING COMMENT 'Geographic location (city, country) of the generating facility.',
    `generating_facility_name` STRING COMMENT 'Name of the power plant or facility that generated the renewable electricity.',
    `iso_14001_compliance_flag` BOOLEAN COMMENT 'Indicates whether the certificate acquisition complies with ISO 14001 environmental management standards.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the certificate.',
    `procurement_date` DATE COMMENT 'Date on which the certificate was purchased or acquired.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Amount of renewable electricity represented by the certificate, expressed in megawatt‑hours.',
    `registry_name` STRING COMMENT 'Name of the registry that issued or tracks the certificate (e.g., GRET, APX, I‑REC Registry).',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of the certificate’s energy that is classified as renewable.',
    `reporting_quarter` STRING COMMENT 'Quarter of the reporting year (1‑4) associated with the certificate.',
    `reporting_year` STRING COMMENT 'Fiscal year for which the certificate is reported in ESG disclosures.',
    `retirement_confirmation_number` STRING COMMENT 'Reference number confirming the certificate’s retirement in the registry.',
    `retirement_date` DATE COMMENT 'Date on which the certificate was retired or applied to a Scope 2 market‑based claim.',
    `scope` STRING COMMENT 'Scope of emissions accounting the certificate supports (market‑based or location‑based).. Valid values are `market_based|location_based`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certificate record.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity of the certificate (e.g., third‑party audit, blockchain hash).',
    `vintage_end_date` DATE COMMENT 'Last day of the period covered by the certificate.',
    `vintage_start_date` DATE COMMENT 'First day of the period covered by the certificate.',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable electricity was generated.',
    CONSTRAINT pk_energy_certificate PRIMARY KEY(`energy_certificate_id`)
) COMMENT 'Master record for Renewable Energy Certificates (RECs), Guarantees of Origin (GOs), or I-RECs procured by Consumer Goods to substantiate renewable electricity claims. Captures certificate type (REC, GO, I-REC), energy source (solar, wind, hydro, biomass), generating facility name and location, certificate vintage period, quantity in MWh, registry name, certificate serial number, procurement date, retirement date, retirement confirmation number, and associated facility or business unit. Supports Scope 2 market-based accounting and RE100 commitment tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` (
    `social_impact_program_id` BIGINT COMMENT 'Unique identifier for the social impact program.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Social impact programs are part of ESG commitments; linking ties program outcomes to specific commitments.',
    `region_id` BIGINT COMMENT 'add column region_id (BIGINT) with FK to shared.region.region_id - social impact programs operate in specific geographic regions',
    `approval_date` DATE COMMENT 'Date when the program was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the program.',
    `beneficiaries_reached` BIGINT COMMENT 'Number of individuals or entities reached by the program.',
    `beneficiary_group` STRING COMMENT 'Target group of beneficiaries for the program. [ENUM-REF-CANDIDATE: children|women|youth|elderly|farmers|employees|communities|students — promote to reference product]',
    `budget_currency_code` STRING COMMENT 'Currency of the program budget.. Valid values are `USD|EUR|GBP|JPY|CNY|INR`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the program complies with relevant ESG regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for investment amount.. Valid values are `USD|EUR|GBP|JPY|CNY|INR`',
    `data_quality_status` STRING COMMENT 'Assessment of data quality for the program record.. Valid values are `high|medium|low|unknown`',
    `end_date` DATE COMMENT 'Date when the program ends or is expected to end.',
    `external_reference_code` STRING COMMENT 'External system reference code for the program.',
    `geographic_focus` STRING COMMENT 'Primary geographic region(s) where the program is implemented. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|CHN|IND|EU|AFR|APAC — promote to reference product]',
    `investment_amount` DECIMAL(18,2) COMMENT 'Total monetary investment allocated to the program.',
    `is_public` BOOLEAN COMMENT 'Indicates if program details are publicly disclosed.',
    `measured_outcome_description` STRING COMMENT 'Narrative description of the social outcomes measured.',
    `measurement_method` STRING COMMENT 'Methodology used to measure program outcomes.',
    `social_impact_program_name` STRING COMMENT 'Descriptive name of the social impact program.',
    `notes` STRING COMMENT 'Additional free-text notes about the program.',
    `outcome_metric_name` STRING COMMENT 'Name of the primary metric used to measure program impact.',
    `outcome_metric_unit` STRING COMMENT 'Unit of measure for the outcome metric.',
    `outcome_metric_value` DECIMAL(18,2) COMMENT 'Value of the primary outcome metric.',
    `partner_organizations` STRING COMMENT 'Comma-separated list of partner organizations involved.',
    `program_budget` DECIMAL(18,2) COMMENT 'Planned budget for the program.',
    `program_manager` STRING COMMENT 'Name or identifier of the manager responsible for the program.',
    `reporting_framework` STRING COMMENT 'Framework used for ESG reporting of the program.. Valid values are `GRI|SASB|B_Corp|CDP|Integrated|Other`',
    `reporting_year` STRING COMMENT 'Fiscal year for ESG reporting.',
    `social_impact_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `planned|active|completed|suspended|cancelled`',
    `social_impact_program_type` STRING COMMENT 'Category of the social impact program. [ENUM-REF-CANDIDATE: community_investment|employee_volunteering|de_i_initiative|living_wage|smallholder_support|women_empowerment|wash_access — promote to reference product]',
    `start_date` DATE COMMENT 'Date when the program starts.',
    `un_sdg_alignment` STRING COMMENT 'UN SDG numbers aligned with the program. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17 — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    CONSTRAINT pk_social_impact_program PRIMARY KEY(`social_impact_program_id`)
) COMMENT 'Master record for social responsibility and community impact programs under the ESG Social pillar. Captures program name, type (community investment, employee volunteering, DE&I initiative, living wage program, smallholder farmer support, womens economic empowerment, WASH access), geographic focus, target beneficiary group, program dates, investment amount, beneficiaries reached, UN SDG alignment, partner organizations, and measured social outcomes. Supports GRI 400-series reporting, SASB social metrics, and B Corp assessment.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` (
    `deforestation_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each deforestation risk assessment record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Deforestation assessments support ESG commitments on forest risk; linking provides commitment‑level tracking.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier or sourcing entity being assessed.',
    `assessment_approval_date` DATE COMMENT 'Date on which the assessment was formally approved.',
    `assessment_approved_by` STRING COMMENT 'User identifier of the person who approved the assessment.',
    `assessment_code` STRING COMMENT 'External reference code assigned to the assessment for tracking across systems.',
    `assessment_created_by` STRING COMMENT 'User identifier of the person who created the assessment record.',
    `assessment_date` DATE COMMENT 'Date on which the deforestation risk assessment was performed.',
    `assessment_notes` STRING COMMENT 'Free‑form comments captured by the assessor.',
    `assessment_review_date` DATE COMMENT 'Date of the most recent review of the assessment findings.',
    `assessment_status` STRING COMMENT 'Current processing state of the assessment.. Valid values are `pending|in_progress|completed|reviewed|rejected`',
    `carbon_emission_estimate_tonnes` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions (tonnes) linked to the commoditys production.',
    `certification_coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of the supply chain covered by recognized sustainability certifications.',
    `certification_type` STRING COMMENT 'Sustainability certification held by the supplier (e.g., FSC, RSPO).. Valid values are `fsc|rspo|iso14001|none`',
    `certification_valid_until` DATE COMMENT 'Expiration date of the suppliers sustainability certification.',
    `commodity_type` STRING COMMENT 'Category of the high‑risk commodity evaluated for deforestation risk.. Valid values are `palm_oil|soy|paper_pulp|cattle|cocoa`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the lakehouse.',
    `data_quality_status` STRING COMMENT 'Overall quality rating of the assessment data.. Valid values are `high|medium|low|unknown`',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the assessment data.. Valid values are `sap|oracle|salesforce|custom`',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Energy consumed (megawatt‑hours) for the commoditys processing.',
    `eudr_compliance_status` STRING COMMENT 'Compliance status with the EU Deforestation Regulation.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `eudr_regulation_reference` STRING COMMENT 'Reference identifier for the specific EU Deforestation Regulation clause applicable.',
    `forest_area_ha` DECIMAL(18,2) COMMENT 'Total forest area (in hectares) associated with the sourcing region.',
    `forest_cover_change_percent` DECIMAL(18,2) COMMENT 'Percent change in forest cover observed in the sourcing area over the assessment period.',
    `methodology` STRING COMMENT 'Analytical methodology applied to evaluate deforestation risk.. Valid values are `trase|global_forest_watch|eudr_traceability`',
    `remediation_action_description` STRING COMMENT 'Narrative description of the remediation steps to be taken.',
    `remediation_action_required` BOOLEAN COMMENT 'Indicates whether corrective remediation actions are required based on the assessment outcome.',
    `risk_assessment_document_url` STRING COMMENT 'Link to the detailed assessment report or supporting documentation.',
    `risk_assessment_methodology_version` STRING COMMENT 'Version of the risk assessment methodology used.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0‑100) representing the likelihood of deforestation associated with the commodity.',
    `risk_score_unit` STRING COMMENT 'Unit of measurement for the risk score, typically percentage.',
    `sourcing_region` STRING COMMENT 'Three‑letter ISO country code of the region where the commodity originates.. Valid values are `^[A-Z]{3}$`',
    `traceability_level` STRING COMMENT 'Depth of traceability achieved for the commodity (e.g., farm‑level, mill‑level).. Valid values are `farm|mill|trader|processor`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Volume of water (cubic metres) consumed in the production of the assessed commodity.',
    CONSTRAINT pk_deforestation_assessment PRIMARY KEY(`deforestation_assessment_id`)
) COMMENT 'Transactional record of deforestation risk assessments conducted for high-risk commodities (palm oil, soy, paper/pulp, cattle-derived ingredients, cocoa) in the Consumer Goods supply chain. Captures assessment date, commodity type, supplier or sourcing region reference, risk methodology (Trase, Global Forest Watch, EUDR traceability), deforestation risk score, forest cover change data, certification coverage percentage, traceability level (farm, mill, trader), EUDR (EU Deforestation Regulation) compliance status, and remediation action required flag. Supports EUDR compliance and zero-deforestation commitments.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` (
    `esg_audit_id` BIGINT COMMENT 'Unique system-generated identifier for the ESG audit record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link esg_audit to esg_commitment to connect audit outcomes with commitments.',
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier of the facility or site audited.',
    `audit_certification_status` STRING COMMENT 'Status of the related certification after the audit (e.g., maintained, revoked, pending).',
    `audit_date` DATE COMMENT 'Date on which the audit was performed (principal business event timestamp).',
    `audit_duration_hours` DECIMAL(18,2) COMMENT 'Total time spent on the audit, expressed in hours.',
    `audit_findings_summary` STRING COMMENT 'Narrative summary of key findings and observations.',
    `audit_location` STRING COMMENT 'City or locality where the audit was conducted.',
    `audit_method` STRING COMMENT 'Methodology used to conduct the audit.. Valid values are `on_site|remote|document_review`',
    `audit_number` STRING COMMENT 'Business identifier or reference code assigned to the audit.',
    `audit_region` STRING COMMENT 'Three‑letter ISO country code of the audit location.. Valid values are `^[A-Z]{3}$`',
    `audit_report_reference` STRING COMMENT 'Document identifier for the final audit report.',
    `audit_scope` STRING COMMENT 'Scope of the audit (e.g., plant, process, product line).',
    `audit_scope_description` STRING COMMENT 'Detailed textual description of the audit scope.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `planned|in_progress|completed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit (e.g., ISO 14001 surveillance, ISO 22716 GMP, third‑party ESG, internal EMS).. Valid values are `ISO14001_surveillance|ISO22716_GMP|third_party_ESG|internal_EMS`',
    `auditing_body` STRING COMMENT 'Organization or entity that performed the audit.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or audit team representative.',
    `carbon_emission_flag` BOOLEAN COMMENT 'Indicates whether carbon emission data were evaluated in the audit.',
    `certification_impact_flag` BOOLEAN COMMENT 'Indicates whether audit findings affect ISO certification renewal (true = impact).',
    `compliance_status` STRING COMMENT 'Overall compliance determination after the audit.. Valid values are `compliant|non_compliant|partial`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing corrective actions.',
    `corrective_action_plan_ref` STRING COMMENT 'Reference code or identifier for the corrective action plan linked to this audit.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|closed|in_progress`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `data_quality_status` STRING COMMENT 'Assessment of the quality and reliability of audit data.. Valid values are `good|questionable|poor`',
    `energy_consumption_flag` BOOLEAN COMMENT 'Indicates whether energy consumption aspects were covered.',
    `findings_major` STRING COMMENT 'Number of major non‑conformances identified.',
    `findings_minor` STRING COMMENT 'Number of minor non‑conformances identified.',
    `findings_observation` STRING COMMENT 'Number of observations (opportunities for improvement) recorded.',
    `next_audit_date` DATE COMMENT 'Planned date for the subsequent audit of the same scope.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the auditor.',
    `overall_result` STRING COMMENT 'Overall outcome of the audit after evaluating findings.. Valid values are `pass|fail|conditional`',
    `regulatory_body` STRING COMMENT 'Regulatory authority referenced in the audit (e.g., EPA, FDA).',
    `reporting_quarter` STRING COMMENT 'Quarter (1‑4) of the reporting year.',
    `reporting_year` STRING COMMENT 'Fiscal year for which the audit results are reported.',
    `risk_severity` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `waste_management_flag` BOOLEAN COMMENT 'Indicates whether waste management aspects were covered.',
    `water_usage_flag` BOOLEAN COMMENT 'Indicates whether water consumption aspects were covered.',
    CONSTRAINT pk_esg_audit PRIMARY KEY(`esg_audit_id`)
) COMMENT 'Transactional record of internal and external ESG audits and environmental management system audits conducted at Consumer Goods facilities. Captures audit date, audit type (ISO 14001 surveillance, ISO 22716 GMP environmental, third-party ESG audit, internal EMS audit), auditing body, facility or scope reference, audit findings count by severity (major nonconformance, minor nonconformance, observation), overall audit result, corrective action plan reference, next audit scheduled date, and certification renewal impact flag. Supports ISO 14001 certification maintenance and ESG assurance processes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` (
    `commitment_progress_id` BIGINT COMMENT 'Primary key for commitment_progress',
    `esg_commitment_id` BIGINT COMMENT 'Identifier of the ESG commitment to which this progress record relates.',
    `actual_value` DECIMAL(18,2) COMMENT 'Observed value achieved for the ESG metric during the reporting period.',
    `commentary` STRING COMMENT 'Free‑text notes explaining variances, challenges, or observations for the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the progress record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the metric (e.g., SAP S/4HANA, Oracle Cloud ERP, Siemens Opcenter MES, manual entry).. Valid values are `SAP S/4HANA|Oracle ERP|MES|Manual|Other`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the actual metric value was recorded.',
    `percentage_of_target` DECIMAL(18,2) COMMENT 'Actual value expressed as a percentage of the target value.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period.',
    `period_type` STRING COMMENT 'Granularity of the reporting period for the progress measurement.. Valid values are `monthly|quarterly|annual`',
    `record_status` STRING COMMENT 'Current lifecycle state of the progress record.. Valid values are `active|inactive|deleted`',
    `reporting_boundary` STRING COMMENT 'Geographic or organizational scope of the measurement (facility‑level, regional, or global).. Valid values are `facility|region|global`',
    `target_value` DECIMAL(18,2) COMMENT 'Planned or committed value for the ESG metric for the reporting period.',
    `trajectory_status` STRING COMMENT 'Overall progress status indicating whether the commitment is on‑track, at‑risk, or off‑track for the period.. Valid values are `on-track|at-risk|off-track`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the metric is expressed (e.g., kg CO₂e, cubic meters, kilowatt‑hours, percent).. Valid values are `kg_co2e|m3|kwh|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the progress record.',
    `verification_status` STRING COMMENT 'Indicates whether the reported metric has been independently verified.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_commitment_progress PRIMARY KEY(`commitment_progress_id`)
) COMMENT 'Periodic operational record tracking actual progress against each ESG commitment target. Captures ESG commitment reference, reporting period (monthly, quarterly, annual), actual metric value achieved, unit of measure, target value for the period, percentage of target achieved, trajectory status (on-track, at-risk, off-track), data source system, reporting boundary (facility, region, global), and commentary on variances. Provides the time-series progress data layer that connects raw ESG metrics to formal commitment tracking and investor reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` (
    `biodiversity_impact_id` BIGINT COMMENT 'System-generated unique identifier for each biodiversity impact assessment record.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Biodiversity impacts are measured against ESG commitments; linking enables commitment‑centric biodiversity reporting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier of the manufacturing or processing facility where the assessment took place.',
    `regulatory_region_id` BIGINT COMMENT 'Unique identifier of the geographic sourcing region associated with the assessment.',
    `approval_date` DATE COMMENT 'Date on which the assessment was formally approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the assessment outcome.',
    `assessment_date` DATE COMMENT 'Date on which the biodiversity impact assessment was performed.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `pending|completed|reviewed|rejected`',
    `assessment_version` STRING COMMENT 'Version number of the assessment methodology applied.',
    `assessor_email` STRING COMMENT 'Email address of the assessor for follow‑up or verification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessor_name` STRING COMMENT 'Full legal name of the individual who performed the assessment.',
    `biodiversity_score_method` STRING COMMENT 'Method used to calculate the net biodiversity impact score.. Valid values are `qualitative|quantitative|mixed`',
    `biodiversity_impact_category` STRING COMMENT 'Primary category describing the nature of the biodiversity impact.. Valid values are `habitat_loss|water_stress|pollution|invasive_species|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the overall data quality for the record.',
    `land_use_area_ha` DECIMAL(18,2) COMMENT 'Total area in hectares covered by the land use type within the assessment scope.',
    `land_use_type` STRING COMMENT 'Classification of the land use category for the area assessed. [ENUM-REF-CANDIDATE: agriculture|forestry|mining|urban|wetland|grassland|other — 7 candidates stripped; promote to reference product]',
    `mitigation_measures` STRING COMMENT 'Narrative description of mitigation actions implemented to address the identified impact.',
    `net_biodiversity_impact_score` DECIMAL(18,2) COMMENT 'Calculated score representing the overall net effect on biodiversity after mitigation, on a standardized scale.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the assessment.',
    `proximity_to_protected_area_km` DECIMAL(18,2) COMMENT 'Linear distance in kilometers from the facility or sourcing region to the nearest protected area or biodiversity hotspot.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the assessment must be disclosed to regulatory bodies (e.g., FDA, EPA).',
    `tnfd_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the assessment is included in TNFD disclosures.',
    `tnfd_risk_classification` STRING COMMENT 'Risk level as defined by the Taskforce on Nature-related Financial Disclosures (TNFD) framework.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    CONSTRAINT pk_biodiversity_impact PRIMARY KEY(`biodiversity_impact_id`)
) COMMENT 'Transactional record capturing biodiversity impact assessments and nature-related risk data for Consumer Goods facilities and sourcing regions. Captures assessment date, facility or sourcing region reference, proximity to protected areas or biodiversity hotspots (km), land use type and area in hectares, biodiversity impact category (habitat loss, water stress, pollution, invasive species), TNFD (Taskforce on Nature-related Financial Disclosures) risk classification, mitigation measures in place, and net biodiversity impact score. Supports TNFD disclosure and nature-positive commitments.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` (
    `supply_chain_activity_id` BIGINT COMMENT 'Primary key for supply_chain_activity',
    `employee_id` BIGINT COMMENT 'Identifier of the internal or external party accountable for the activity.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link supply_chain_activity to esg_commitment to reflect commitment impact on supply chain activities.',
    `network_node_id` BIGINT COMMENT 'Reference to the location (warehouse, plant, distribution center) where the activity is performed.',
    `upstream_supply_chain_activity_id` BIGINT COMMENT 'Self-referencing FK on supply_chain_activity (upstream_supply_chain_activity_id)',
    `activity_category` STRING COMMENT 'High‑level classification (e.g., Transportation, Production, Packaging, Waste Management).',
    `activity_code` STRING COMMENT 'Business identifier or code for the activity, used in ERP, TMS, or sustainability reporting systems.',
    `activity_name` STRING COMMENT 'Descriptive name of the supply‑chain activity (e.g., "Transportation – Truck", "Packaging – Recyclable", "Manufacturing – Mixing").',
    `activity_subcategory` STRING COMMENT 'More detailed classification within the main category (e.g., "Truck – Long Haul", "Bottle – PET", "Landfill Disposal").',
    `actual_amount` DECIMAL(18,2) COMMENT 'Observed metric for the activity in the latest reporting cycle.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'Historical or industry‑standard baseline figure for the activity, used for variance analysis.',
    `carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Quantity of greenhouse‑gas emissions attributable to the activity, expressed in kilograms of CO₂ equivalent.',
    `certification_number` STRING COMMENT 'Unique identifier for the certification record.',
    `certification_type` STRING COMMENT 'Name of sustainability certification linked to the activity (e.g., FSC, RSPO, ISO 14001).',
    `compliance_status` STRING COMMENT 'Indicates whether the activity meets applicable ESG, ISO 14001, or other sustainability standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity definition was initially entered into the system.',
    `effective_from` DATE COMMENT 'Date on which the activity definition starts to be valid for reporting.',
    `effective_until` DATE COMMENT 'Date on which the activity definition is no longer valid; null if open‑ended.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Electricity or fuel energy used by the activity, measured in kilowatt‑hours.',
    `last_reported_timestamp` TIMESTAMP COMMENT 'When the latest actual measurement for this activity was reported.',
    `measurement_unit` STRING COMMENT 'Unit used for the activitys quantitative metrics (e.g., kg, liters, kWh, km).',
    `notes` STRING COMMENT 'Additional remarks, observations, or exceptions related to the activity.',
    `recycling_rate_pct` DECIMAL(18,2) COMMENT 'Proportion of waste that is recycled, expressed as a percentage.',
    `reporting_frequency` STRING COMMENT 'How often the activity data is collected and reported.',
    `reporting_period` STRING COMMENT 'Identifier for the fiscal or calendar period to which the data belongs.',
    `supply_chain_activity_status` STRING COMMENT 'Indicates whether the activity type is currently used, being phased out, or under review.',
    `target_amount` DECIMAL(18,2) COMMENT 'Desired future value for the activity (e.g., target CO₂ emissions, water use) as part of ESG objectives.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the activity definition.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total waste produced as a result of the activity.',
    `water_usage_liters` DECIMAL(18,2) COMMENT 'Volume of water consumed during the activity.',
    CONSTRAINT pk_supply_chain_activity PRIMARY KEY(`supply_chain_activity_id`)
) COMMENT 'Master reference table for supply_chain_activity. Referenced by supply_chain_activity_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` (
    `materiality_assessment_id` BIGINT COMMENT 'Primary key for materiality_assessment',
    `employee_id` BIGINT COMMENT 'Identifier of the person who reviewed and approved the assessment.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Link materiality_assessment to esg_commitment to tie materiality results to commitments.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department owning the assessment.',
    `previous_materiality_assessment_id` BIGINT COMMENT 'Self-referencing FK on materiality_assessment (previous_materiality_assessment_id)',
    `approval_date` DATE COMMENT 'Date when the assessment was formally approved.',
    `assessment_code` STRING COMMENT 'Business identifier or code used to reference the assessment.',
    `assessment_name` STRING COMMENT 'Human‑readable name of the materiality assessment.',
    `assessment_type` STRING COMMENT 'Classification of the assessment based on its origin or purpose.',
    `assessment_year` STRING COMMENT 'Calendar year in which the assessment was performed.',
    `comments` STRING COMMENT 'Free‑form comments or observations recorded by the assessor.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality rating of the data used for the assessment.',
    `data_source` STRING COMMENT 'Origin of the data used in the assessment (e.g., surveys, financial reports).',
    `effective_date` DATE COMMENT 'Date from which the assessment results are considered effective.',
    `expiration_date` DATE COMMENT 'Date when the assessment ceases to be valid (nullable for open‑ended assessments).',
    `external_certification` STRING COMMENT 'Relevant sustainability certifications associated with the assessment.',
    `impact_category` STRING COMMENT 'Expected impact level of the material issue on the business.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the assessment is currently active.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent review of the assessment.',
    `last_updated_by` STRING COMMENT 'User name or identifier of the person who performed the last update.',
    `materiality_score` DECIMAL(18,2) COMMENT 'Quantitative score indicating the materiality level of the assessed issue.',
    `methodology` STRING COMMENT 'Description of the methodology and approach used to calculate materiality.',
    `mitigation_plan` STRING COMMENT 'Planned actions to address the material issue.',
    `notes` STRING COMMENT 'Supplementary information or observations related to the assessment.',
    `priority_level` STRING COMMENT 'Prioritization for mitigation actions based on materiality.',
    `rating` STRING COMMENT 'Categorical rating derived from the materiality score.',
    `regulatory_framework` STRING COMMENT 'Reporting framework or standard applied to the assessment.',
    `reporting_cycle` STRING COMMENT 'Frequency at which the assessment is performed and reported.',
    `risk_category` STRING COMMENT 'High‑level ESG risk category to which the material issue belongs.',
    `scope` STRING COMMENT 'Geographic or operational scope covered by the assessment.',
    `stakeholder_engagement_score` DECIMAL(18,2) COMMENT 'Score reflecting the level of stakeholder engagement in the assessment process.',
    `stakeholder_group` STRING COMMENT 'Primary stakeholder group(s) considered in the materiality analysis.',
    `materiality_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Score threshold that determines whether an issue is considered material.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assessment record.',
    `version_number` STRING COMMENT 'Version identifier for the assessment (e.g., v1.0).',
    CONSTRAINT pk_materiality_assessment PRIMARY KEY(`materiality_assessment_id`)
) COMMENT 'Master reference table for materiality_assessment. Referenced by materiality_assessment_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_supply_chain_activity_id` FOREIGN KEY (`supply_chain_activity_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity`(`supply_chain_activity_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_energy_certificate_id` FOREIGN KEY (`energy_certificate_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate`(`energy_certificate_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_circular_initiative_id` FOREIGN KEY (`circular_initiative_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative`(`circular_initiative_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ADD CONSTRAINT `fk_sustainability_packaging_profile_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_esg_audit_id` FOREIGN KEY (`esg_audit_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_audit`(`esg_audit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_materiality_assessment_id` FOREIGN KEY (`materiality_assessment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment`(`materiality_assessment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ADD CONSTRAINT `fk_sustainability_circular_initiative_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ADD CONSTRAINT `fk_sustainability_product_lca_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ADD CONSTRAINT `fk_sustainability_energy_certificate_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ADD CONSTRAINT `fk_sustainability_deforestation_assessment_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ADD CONSTRAINT `fk_sustainability_commitment_progress_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_upstream_supply_chain_activity_id` FOREIGN KEY (`upstream_supply_chain_activity_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity`(`supply_chain_activity_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_previous_materiality_assessment_id` FOREIGN KEY (`previous_materiality_assessment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment`(`materiality_assessment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`sustainability` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`sustainability` SET TAGS ('dbx_domain' = 'sustainability');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Commitment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_code` SET TAGS ('dbx_business_glossary_term' = 'ESG Commitment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Commitment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_owner` SET TAGS ('dbx_business_glossary_term' = 'Commitment Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_scope` SET TAGS ('dbx_business_glossary_term' = 'Commitment Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_scope` SET TAGS ('dbx_value_regex' = 'global|regional|site');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Commitment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'carbon_neutrality|net_zero|water_stewardship|zero_waste|deforestation_free|social_responsibility');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'public|private|confidential');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `esg_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'ESG Commitment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `esg_commitment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|cancelled|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Alignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'SBTi|UN_Global_Compact|RE100|CDP|TCFD');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `last_progress_date` SET TAGS ('dbx_business_glossary_term' = 'Last Progress Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'metric_tons_co2e|kilograms|percent|liters|kwh');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `progress_cadence` SET TAGS ('dbx_business_glossary_term' = 'Progress Cadence');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `progress_cadence` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|biannual');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'GRI|SASB|TCFD|CDP|UN_SDGs');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'third_party_audit|self_report|sensor_data|certification|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (LINE_ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PRODUCT_ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `supply_chain_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Activity Identifier (ACTIVITY_ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type (ACTIVITY_TYPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name (AUDITOR)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology (METHOD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'GHG Protocol|ISO 14064|Custom');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_intensity_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Factor (CIF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `cdpr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'CDP Reporting Flag (CDP_FLAG)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `co2e_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'CO₂e Quantity (TONNES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DQ_FLAG)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SRC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'sensor|calculated|estimated|reported');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (EF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_date` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Date (EF_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source (EF_SOURCE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_version` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Version (EF_VERSION)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category (SOURCE_CAT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_value_regex' = 'combustion|electricity|transport|raw_material|waste|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emission Timestamp (EMISSION_TIME)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWH)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `external_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Standard (REPORT_STD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `external_reporting_standard` SET TAGS ('dbx_value_regex' = 'CDP|GRI|SASB|TCFD');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location (COUNTRY_CODE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `geographic_location` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `internal_project_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Project Code (PROJECT_CODE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (UNIT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Offset Quantity (OFFSET_TONNES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Type (OFFSET_TYPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_type` SET TAGS ('dbx_value_regex' = 'renewable_energy|reforestation|methane_capture|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period (REPORT_PERIOD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (REPORT_YEAR)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope (SCOPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date (VERIF_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption (M3)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Certificate Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `carbon_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `consumption_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|Oracle_ERP|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_status` SET TAGS ('dbx_value_regex' = 'recorded|verified|adjusted|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_intensity_ratio` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity Ratio');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'electricity|natural_gas|steam|renewable_solar|renewable_wind|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_unit` SET TAGS ('dbx_value_regex' = 'MWh|GJ');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `iso_50001_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 50001 Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'meter|utility_bill|estimated');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `meter_code` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consumption Record Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Energy Tariff Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `consumption_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_value_regex' = 'sewer|waterway|treatment_plant|reused');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Discharge Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'meter|estimate|model');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `regulatory_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_consumption_status` SET TAGS ('dbx_value_regex' = 'recorded|validated|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_quality_indicator` SET TAGS ('dbx_value_regex' = 'pH|turbidity|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_recycling_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Water Recycling Rate (%)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'municipal|groundwater|surface_water|recycled');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_stress_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Stress Area Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ALTER COLUMN `withdrawal_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Volume (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `circular_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Initiative Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Contractor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling|composting|energy_recovery');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `epa_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'EPA Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|tonne');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_category_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_status` SET TAGS ('dbx_value_regex' = 'recorded|verified|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'plastic|cardboard|organic|hazardous|e_waste|metal');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ALTER COLUMN `zero_waste_to_landfill_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Waste to Landfill Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` SET TAGS ('dbx_subdomain' = 'circular_sourcing');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `additional_certification` SET TAGS ('dbx_business_glossary_term' = 'Additional Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `additional_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|ISO14001|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `compostable` SET TAGS ('dbx_business_glossary_term' = 'Compostability Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `design_version` SET TAGS ('dbx_business_glossary_term' = 'Packaging Design Version');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `end_of_life_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Disposal Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `end_of_life_disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|recycling|compost|incineration|reuse');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `energy_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Usage (kWh)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `eu_packaging_waste_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'EU Packaging Waste Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `eu_packaging_waste_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `lightweighting_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Lightweighting Reduction Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition_aluminum_percent` SET TAGS ('dbx_business_glossary_term' = 'Aluminum Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition_glass_percent` SET TAGS ('dbx_business_glossary_term' = 'Glass Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition_paper_percent` SET TAGS ('dbx_business_glossary_term' = 'Paper/Cardboard Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition_pcr_percent` SET TAGS ('dbx_business_glossary_term' = 'Post‑Consumer Recycled (PCR) Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition_virgin_percent` SET TAGS ('dbx_business_glossary_term' = 'Virgin Plastic Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_primary` SET TAGS ('dbx_value_regex' = 'plastic|glass|aluminum|paper|metal|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `material_source` SET TAGS ('dbx_business_glossary_term' = 'Material Source Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Height (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Length (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_supplier` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Packaging Weight (grams)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Width (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_value_regex' = 'recyclable|non_recyclable|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `recycled_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `reusable` SET TAGS ('dbx_business_glossary_term' = 'Reusable Packaging Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Assessment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `units_per_package` SET TAGS ('dbx_business_glossary_term' = 'Units Per Package');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ALTER COLUMN `water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (liters)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` SET TAGS ('dbx_subdomain' = 'circular_sourcing');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `sourcing_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Certification Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `raw_material_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `annual_certified_volume` SET TAGS ('dbx_business_glossary_term' = 'Annual Certified Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|in_progress');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_value_regex' = 'mass_balance|segregated|book_and_claim');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'RSPO|FSC|Rainforest Alliance|Fair Trade|UTZ|Organic');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_url` SET TAGS ('dbx_business_glossary_term' = 'Certification URL');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `raw_material_name` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'kg|ton|lb|g|mg|lb');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Permitted Activity Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditionally_compliant');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `discharge_limit` SET TAGS ('dbx_business_glossary_term' = 'Discharge Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `emission_limit` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `iso_14001_linkage` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 EMS Linkage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'EPA|State|Local|EU');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_value_regex' = 'kg_per_year|m3_per_day|lb_per_year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air|water|waste|stormwater');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'renewed|pending|overdue');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `esg_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Audit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `surveillance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Post Market Surveillance Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|noncompliant|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `environmental_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `environmental_incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_subtype` SET TAGS ('dbx_business_glossary_term' = 'Incident Sub‑type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'chemical_spill|air_emission|wastewater_violation|soil_contamination|near_miss');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `is_regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `quantity_released` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `remediation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `remediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|ISO14001|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State/Province Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `substance_code` SET TAGS ('dbx_business_glossary_term' = 'Substance Code (CAS Number)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `substance_code` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|liters|gallons|cubic_meters|pounds');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Disclosure ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `materiality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'none|limited|reasonable');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Assurance Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_emissions_scope1` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Carbon Emissions');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_emissions_scope2` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Carbon Emissions');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_emissions_scope3` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Carbon Emissions');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_reference` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `energy_consumption` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|published|rejected|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'FSC Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `iso_14001_compliance` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `packaging_recyclability_rate` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `public_url` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure URL');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'RSPO Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `total_carbon_emissions` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Emissions');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `waste_generated` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ALTER COLUMN `water_consumption` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` SET TAGS ('dbx_subdomain' = 'circular_sourcing');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `circular_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Initiative ID (CII)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `carbon_footprint_avoided_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Avoided (Tonnes) (CFA_T)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `circular_initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Circular Initiative Status (CIS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `circular_initiative_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|paused|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `compliance_fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'FSC Certification Compliance (FSC_C)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `compliance_rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'RSPO Certification Compliance (RSPO_C)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `consumer_participation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Consumer Participation Rate (Percent) (CPR_PCT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status (DQS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|fair|poor');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `energy_savings_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Savings (MWh) (ES_MWH)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID (ERI)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (GS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency (ISO 4217) (BC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Circular Initiative Code (CIC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Circular Initiative Name (CIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_owner` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner (IO)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner Email (IOE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `initiative_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `investment_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Investment Amount (USD) (IA_USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `is_public_reportable` SET TAGS ('dbx_business_glossary_term' = 'Public Reportable Flag (PRF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `iso_14001_compliance` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Compliance (ISO14001_C)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `last_progress_date` SET TAGS ('dbx_business_glossary_term' = 'Last Progress Date (LPD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date (LD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage (LS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'planning|implementation|monitoring|closure');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `material_diverted_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Material Diverted (Tonnes) (MD_T)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `material_recovered_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Material Recovered (Tonnes) (MR_T)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `partner_organizations` SET TAGS ('dbx_business_glossary_term' = 'Partner Organizations (PO)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Type (CPT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'take_back|refillable|pcr_increase|packaging_elimination|product_as_service|industrial_symbiosis');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `progress_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Status (PS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `progress_status` SET TAGS ('dbx_value_regex' = 'on_track|behind|ahead|at_risk');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework (RF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'Ellen_MacArthur|GRI|SASB|CDP|UN_SDGs');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `stakeholder_group` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Group (SG)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `target_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target End Date (TED)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `target_material` SET TAGS ('dbx_business_glossary_term' = 'Target Material (TM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `target_material` SET TAGS ('dbx_value_regex' = 'plastic|paper|glass|metal|textile|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `target_material_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Material Percentage (Percent) (TMP_PCT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (VM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `waste_reduction_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction (Tonnes) (WR_T)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ALTER COLUMN `water_savings_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Water Savings (Cubic Meters) (WS_CM3)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` SET TAGS ('dbx_subdomain' = 'circular_sourcing');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_esg_eval_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ESG Evaluation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Code (ARC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_value_regex' = 'environmental|social|governance|ethics|combined');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'self_questionnaire|third_party_audit|ecovadis|sedex_smeta');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `carbon_emission_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Score (CES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_value_regex' = 'iso_14001|gmp|fsc|rspo|epa|cfr');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag (CARF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CFC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `energy_consumption_score` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Score (ECS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental ESG Score (EES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `epa_reportable` SET TAGS ('dbx_business_glossary_term' = 'EPA Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `ethics_score` SET TAGS ('dbx_business_glossary_term' = 'Ethics ESG Score (EtES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation Reference (EDR)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'FSC Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance ESG Score (GES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `iso_14001_compliance` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Score (OES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `overall_score_category` SET TAGS ('dbx_business_glossary_term' = 'Overall Score Category (OSC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `overall_score_category` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Description (RMD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'RSPO Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `scope_3_included` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Inclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social ESG Score (SES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_esg_eval_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_esg_eval_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Supplier ESG Risk Level (SERL)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `supplier_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `waste_management_score` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Score (WMS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ALTER COLUMN `water_consumption_score` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Score (WCS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` SET TAGS ('dbx_subdomain' = 'climate_reporting');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `alignment_type` SET TAGS ('dbx_business_glossary_term' = 'Net‑Zero Alignment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `alignment_type` SET TAGS ('dbx_value_regex' = 'interim_offset|permanent_removal|net_zero_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_value_regex' = 'active|retired|cancelled|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `cost_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Cost per Tonne (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|CHN|IND');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_quantity_purchased` SET TAGS ('dbx_business_glossary_term' = 'Purchased Credit Quantity (tCO2e)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_quantity_retired` SET TAGS ('dbx_business_glossary_term' = 'Retired Credit Quantity (tCO2e)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Location');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'reforestation|renewable_energy|methane_capture|blue_carbon|soil_sequestration');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `registry` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `registry` SET TAGS ('dbx_value_regex' = 'gold_standard|verra_vcs|american_carbon_registry|climate_action_reserve');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Retirement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Cost (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Credit Vintage Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` SET TAGS ('dbx_subdomain' = 'climate_reporting');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Life Cycle Assessment (LCA) Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Footprint (kg CO₂e)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `certification_fsc` SET TAGS ('dbx_business_glossary_term' = 'FSC Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `certification_rspo` SET TAGS ('dbx_business_glossary_term' = 'RSPO Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of LCA Data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `functional_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Functional Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `functional_unit_uom` SET TAGS ('dbx_business_glossary_term' = 'Functional Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `hotspot_stages` SET TAGS ('dbx_business_glossary_term' = 'Key Hotspot Life‑Cycle Stages');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use of LCA Results');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'product_labeling|rd_reformulation|regulatory_submission|marketing|internal_reporting');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `iso_14040_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14040/14044 Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `lca_practitioner` SET TAGS ('dbx_business_glossary_term' = 'LCA Practitioner');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `lca_study_type` SET TAGS ('dbx_business_glossary_term' = 'LCA Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `lca_study_type` SET TAGS ('dbx_value_regex' = 'cradle-to-gate|cradle-to-grave|cradle-to-cradle');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'LCA Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `product_lca_status` SET TAGS ('dbx_business_glossary_term' = 'LCA Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `product_lca_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|retired');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `study_date` SET TAGS ('dbx_business_glossary_term' = 'LCA Study Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `system_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'System Boundary Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ALTER COLUMN `water_footprint_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Footprint (liters)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` SET TAGS ('dbx_subdomain' = 'climate_reporting');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Certificate ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `carbon_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `certificate_name` SET TAGS ('dbx_business_glossary_term' = 'Certificate Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'REC|GO|I-REC');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `energy_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `energy_certificate_status` SET TAGS ('dbx_value_regex' = 'active|retired|pending|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `energy_source` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|biomass|geothermal|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `generating_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Location');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `generating_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `iso_14001_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Quantity (MWh)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `retirement_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Retirement Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'market_based|location_based');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `vintage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Vintage End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `vintage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vintage Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `beneficiary_group` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Group');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|INR');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|INR');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Amount (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `measured_outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Measured Outcome Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `partner_organizations` SET TAGS ('dbx_business_glossary_term' = 'Partner Organizations');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `program_budget` SET TAGS ('dbx_business_glossary_term' = 'Program Budget (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'GRI|SASB|B_Corp|CDP|Integrated|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|suspended|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'UN Sustainable Development Goal Alignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` SET TAGS ('dbx_subdomain' = 'circular_sourcing');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `deforestation_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Deforestation Assessment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approval Date (APP_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approved By (APPROVER)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code (CODE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_created_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Created By (CREATOR)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date (DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes (NOTES)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_review_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status (STATUS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|reviewed|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `carbon_emission_estimate_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Estimate (CO2_T)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `certification_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Certification Coverage Percentage (CERT_COV)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'fsc|rspo|iso14001|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `certification_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (CERT_EXP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type (TYPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'palm_oil|soy|paper_pulp|cattle|cocoa');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (TS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status (DQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (SYSTEM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'sap|oracle|salesforce|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWH)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `eudr_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'EUDR Compliance Status (EUDR)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `eudr_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `eudr_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'EUDR Regulation Reference (EUDR_REF)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `forest_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Forest Area (HA)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `forest_cover_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Forest Cover Change Percentage (FC_CHANGE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology (METH)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'trase|global_forest_watch|eudr_traceability');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `remediation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description (DESC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `remediation_action_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Required (REMED)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `risk_assessment_document_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Document URL (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `risk_assessment_methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Methodology Version (VER)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Deforestation Risk Score (RISK)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `risk_score_unit` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Unit (UNIT)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Region (REGION)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `traceability_level` SET TAGS ('dbx_business_glossary_term' = 'Traceability Level (TRACE)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `traceability_level` SET TAGS ('dbx_value_regex' = 'farm|mill|trader|processor');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (TS)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ALTER COLUMN `water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (M³)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `esg_audit_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Audit Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|document_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_region` SET TAGS ('dbx_business_glossary_term' = 'Audit Region (Country Code)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'ISO14001_surveillance|ISO22716_GMP|third_party_ESG|internal_EMS');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `carbon_emission_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `certification_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `corrective_action_plan_ref` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|questionable|poor');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `energy_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `findings_major` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `findings_minor` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `findings_observation` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `waste_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ALTER COLUMN `water_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `commitment_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Progress Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Commitment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Progress Commentary');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP S/4HANA|Oracle ERP|MES|Manual|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `percentage_of_target` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Target Achieved');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type (Monthly, Quarterly, Annual)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `reporting_boundary` SET TAGS ('dbx_business_glossary_term' = 'Reporting Boundary');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `reporting_boundary` SET TAGS ('dbx_value_regex' = 'facility|region|global');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `trajectory_status` SET TAGS ('dbx_business_glossary_term' = 'Trajectory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `trajectory_status` SET TAGS ('dbx_value_regex' = 'on-track|at-risk|off-track');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg_co2e|m3|kwh|percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_subdomain' = 'environmental_tracking');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Impact Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `regulatory_region_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Region Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_email` SET TAGS ('dbx_business_glossary_term' = 'Assessor Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_score_method` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Score Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_score_method` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|mixed');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Impact Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_impact_category` SET TAGS ('dbx_value_regex' = 'habitat_loss|water_stress|pollution|invasive_species|other');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Land Use Area (ha)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `net_biodiversity_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Net Biodiversity Impact Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `proximity_to_protected_area_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Protected Area (km)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `tnfd_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'TNFD Disclosure Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `tnfd_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'TNFD Risk Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `tnfd_risk_classification` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` SET TAGS ('dbx_subdomain' = 'climate_reporting');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `supply_chain_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Activity Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `upstream_supply_chain_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Supply Chain Activity Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `upstream_supply_chain_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `activity_category` SET TAGS ('dbx_business_glossary_term' = 'Activity Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `activity_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Activity Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `carbon_footprint_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kwh');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `last_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `recycling_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recycling Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `supply_chain_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ALTER COLUMN `water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Liters');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` SET TAGS ('dbx_subdomain' = 'esg_governance');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `previous_materiality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Materiality Assessment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `previous_materiality_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_year` SET TAGS ('dbx_business_glossary_term' = 'Assessment Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `external_certification` SET TAGS ('dbx_business_glossary_term' = 'External Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `impact_category` SET TAGS ('dbx_business_glossary_term' = 'Impact Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_score` SET TAGS ('dbx_business_glossary_term' = 'Materiality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `reporting_cycle` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `stakeholder_engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `stakeholder_group` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Group');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
