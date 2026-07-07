-- Schema for Domain: sustainability | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:10:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`sustainability` COMMENT 'Environmental sustainability and ESG (Environmental Social Governance) domain managing carbon footprint tracking, waste diversion metrics, sustainable material sourcing, green building certifications beyond LEED, climate risk assessments, and ESG reporting frameworks';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`esg_report` (
    `esg_report_id` BIGINT COMMENT 'Unique system-generated identifier for the ESG report record.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: ESG report ownership requires linking the report to the employee who prepares it; standard ESG reporting process mandates a responsible preparer.',
    `prior_esg_report_id` BIGINT COMMENT 'Self-referencing FK on esg_report (prior_esg_report_id)',
    `assurance_level` STRING COMMENT 'Level of external assurance applied to the report (Limited, Reasonable, or None).. Valid values are `Limited|Reasonable|None`',
    `auditor_report_url` STRING COMMENT 'Link to the detailed auditor verification report.',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Carbon emissions per unit of revenue (tons CO₂e per million USD).',
    `climate_risk_assessment_summary` STRING COMMENT 'Brief summary of climate‑related risk analysis included in the report.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ESG report record was first created in the system.',
    `data_quality_assessment` STRING COMMENT 'Result of the data quality review for the ESG report.. Valid values are `Pass|Fail|Conditional`',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the ESG data (e.g., SAP S/4HANA, Intelex).',
    `emission_reduction_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage reduction in emissions relative to a baseline year.',
    `emission_reduction_target_year` STRING COMMENT 'Year by which the emission reduction target is to be achieved.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumed (megawatt‑hours) during the reporting period.',
    `energy_intensity` DECIMAL(18,2) COMMENT 'Energy consumption per unit of production or revenue.',
    `external_verifier` STRING COMMENT 'Name of the third‑party organization that performed the assurance.',
    `green_building_certifications` STRING COMMENT 'List of green building certifications (e.g., LEED, BREEAM) referenced in the report.',
    `net_zero_commitment_status` STRING COMMENT 'Current status of the net‑zero commitment.. Valid values are `Committed|InProgress|Achieved|NotCommitted`',
    `net_zero_target_year` STRING COMMENT 'Calendar year by which the organization aims to achieve net‑zero emissions.',
    `notes` STRING COMMENT 'Free‑text field for any supplemental information or comments.',
    `publication_date` DATE COMMENT 'Date the ESG report was publicly released or posted.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the ESG report.. Valid values are `Draft|Submitted|Published|Withdrawn`',
    `regulatory_reporting_requirement` STRING COMMENT 'Specific regulatory or statutory requirement that the ESG report satisfies.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Share of total energy consumption sourced from renewable resources, expressed as a percentage.',
    `report_number` STRING COMMENT 'External reference number or code assigned to the ESG report by the organization.',
    `report_title` STRING COMMENT 'Descriptive title of the ESG report as published.',
    `report_url` STRING COMMENT 'Web address where the ESG report can be accessed.',
    `report_version` STRING COMMENT 'Version identifier for the ESG report (e.g., v1.0, v2.1).',
    `reporting_framework` STRING COMMENT 'Framework or standard used for the ESG disclosure (e.g., GRI, TCFD, SASB, CDP, UN SDGs).. Valid values are `GRI|TCFD|SASB|CDP|UN_SDGS|Other`',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period covered by the ESG report.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period covered by the ESG report.',
    `scope_boundary` STRING COMMENT 'Boundary of emissions and sustainability data (Corporate, Project, or Both).. Valid values are `Corporate|Project|Both`',
    `submission_date` DATE COMMENT 'Date the ESG report was submitted to the regulator or stakeholder.',
    `sustainability_goals_aligned` BOOLEAN COMMENT 'Indicates whether the report aligns with the companys defined sustainability goals.',
    `total_emissions_scope1` DECIMAL(18,2) COMMENT 'Direct greenhouse‑gas emissions (Scope 1) in metric tons CO₂e.',
    `total_emissions_scope2` DECIMAL(18,2) COMMENT 'Indirect emissions from purchased electricity, heat, or steam (Scope 2) in metric tons CO₂e.',
    `total_emissions_scope3` DECIMAL(18,2) COMMENT 'Other indirect emissions (Scope 3) in metric tons CO₂e.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ESG report record.',
    `verification_date` DATE COMMENT 'Date the external verifier completed the assurance process.',
    `waste_diverted_percentage` DECIMAL(18,2) COMMENT 'Percentage of total waste that was recycled, composted, or otherwise diverted.',
    `waste_diverted_tons` DECIMAL(18,2) COMMENT 'Total waste diverted from landfill (tons).',
    `water_intensity` DECIMAL(18,2) COMMENT 'Water usage per unit of production or revenue.',
    `water_usage_cubic_meters` DECIMAL(18,2) COMMENT 'Total water consumption during the reporting period (cubic meters).',
    CONSTRAINT pk_esg_report PRIMARY KEY(`esg_report_id`)
) COMMENT 'Master record for each formal ESG (Environmental, Social, Governance) report published or submitted by the construction enterprise. Captures reporting framework (GRI, TCFD, SASB, CDP, UN SDGs), reporting period, scope boundaries (corporate vs. project-level), assurance level (limited/reasonable), external verifier, submission date, and publication status. SSOT for ESG disclosure obligations and stakeholder reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` (
    `esg_disclosure_item_id` BIGINT COMMENT 'Unique surrogate key for the ESG disclosure line item.',
    `asset_id` BIGINT COMMENT 'Identifier of the asset (e.g., equipment, building) associated with the metric.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: ESG disclosures must cite specific environmental permits and their status for regulatory compliance reporting.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Each disclosed ESG metric is owned by a staff member responsible for data collection and verification; linking provides audit traceability.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Each ESG disclosure item belongs to a single ESG report; adding esg_report_id creates the parent‑child hierarchy and removes the need for separate report lookup fields.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project linked to this ESG disclosure.',
    `restated_esg_disclosure_item_id` BIGINT COMMENT 'Self-referencing FK on esg_disclosure_item (restated_esg_disclosure_item_id)',
    `approval_date` DATE COMMENT 'Date when the disclosure item was approved for reporting.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the disclosure.',
    `assurance_level` STRING COMMENT 'Level of assurance applied to the ESG data (e.g., limited assurance).. Valid values are `limited|reasonable|none`',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the reported value.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the reported value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disclosure record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code if the metric is monetary.',
    `data_collection_method` STRING COMMENT 'How the data was obtained (e.g., direct measurement, estimate).. Valid values are `direct_measurement|estimate|model|survey`',
    `data_quality_flag` STRING COMMENT 'Assessment of the data quality for the disclosed metric.. Valid values are `high|medium|low|not_applicable`',
    `data_source` STRING COMMENT 'Origin of the data relative to the organization.. Valid values are `internal|external|third_party`',
    `emission_scope` STRING COMMENT 'Scope of greenhouse‑gas emissions covered by the metric.. Valid values are `Scope 1|Scope 2|Scope 3`',
    `energy_source` STRING COMMENT 'Primary energy source associated with the metric.. Valid values are `renewable|non_renewable|mixed`',
    `esg_disclosure_item_status` STRING COMMENT 'Current lifecycle status of the disclosure item.. Valid values are `draft|submitted|approved|rejected`',
    `framework` STRING COMMENT 'The ESG reporting framework to which the indicator belongs.. Valid values are `GRI|SASB|TCFD|CDP|ISSB`',
    `indicator_code` STRING COMMENT 'Standardized code of the ESG indicator as defined by the reporting framework.',
    `indicator_name` STRING COMMENT 'Descriptive name of the ESG indicator.',
    `is_key_metric` BOOLEAN COMMENT 'True if the disclosure item is considered a key performance indicator for ESG reporting.',
    `methodology` STRING COMMENT 'Description of the calculation or measurement methodology used.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Monetary amount associated with the ESG metric, if applicable.',
    `narrative_commentary` STRING COMMENT 'Free‑text explanation or context for the disclosed metric.',
    `notes` STRING COMMENT 'Free‑form field for any extra information relevant to the disclosure.',
    `reported_value` DECIMAL(18,2) COMMENT 'Numeric value reported for the ESG indicator.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the disclosure.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the disclosure.',
    `reporting_year` STRING COMMENT 'Calendar year for which the ESG data is reported.',
    `responsible_party` STRING COMMENT 'Name of the department or team accountable for the metric.',
    `restated` BOOLEAN COMMENT 'True if the disclosed value has been restated from a prior reporting period.',
    `unit_of_measure` STRING COMMENT 'Unit in which the reported value is expressed (e.g., tCO2e, kg, m3).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disclosure record.',
    `verification_status` STRING COMMENT 'Indicates whether the disclosed data has been externally verified.. Valid values are `verified|unverified|pending`',
    `waste_type` STRING COMMENT 'Category of waste measured (if applicable).. Valid values are `hazardous|non_hazardous|recyclable|landfill`',
    `water_source` STRING COMMENT 'Source of water consumption reported (e.g., municipal, well).',
    CONSTRAINT pk_esg_disclosure_item PRIMARY KEY(`esg_disclosure_item_id`)
) COMMENT 'Individual disclosure line item within an ESG report, mapping to a specific framework indicator or metric (e.g., GRI 305-1 Scope 1 emissions, GRI 306-3 waste generated). Captures indicator code, indicator name, reported value, unit of measure, data quality flag, restatement indicator, and narrative commentary. Enables granular traceability from ESG report to underlying data.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` (
    `carbon_emission_id` BIGINT COMMENT 'Unique surrogate key for each greenhouse gas emission measurement record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients require consolidated carbon‑footprint statements; associating emissions with the client account supports client‑level carbon accounting.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Carbon Emission Reporting requires mapping each emission record to the specific scheduled activity that generated it, enabling ESG reports and regulatory compliance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Regulatory GHG inventory requires attributing each emission record to the specific equipment that generated it for accurate reporting and optimization.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Carbon emissions are measured against a specific reduction target; linking each emission to its carbon_target enables roll‑up of actual vs. target emissions.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the emission belongs.',
    `corrected_carbon_emission_id` BIGINT COMMENT 'Self-referencing FK on carbon_emission (corrected_carbon_emission_id)',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Labor‑related carbon accounting attributes emissions to the individual worker operating equipment, required for detailed GHG reporting.',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Carbon emission records use a standard emission factor; linking to the emission_factor master eliminates duplicated factor values and source strings.',
    `emission_source_id` BIGINT COMMENT 'Reference to the master record describing the specific emission source (e.g., a generator, vehicle, or process).',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Carbon emission logs are entered by a designated emissions officer; the employee ID ties the record to the responsible staff for compliance reporting.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Emission tracking is required to verify adherence to permit‑condition limits imposed by regulators.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Scope 3 carbon accounting requires linking each emission record to the specific purchase order that sourced the material, enabling accurate emissions attribution per procurement transaction.',
    `site_mobilization_id` BIGINT COMMENT 'Foreign key linking to site.site_mobilization. Business justification: Regulatory ESG reporting requires associating each carbon emission record with the specific construction site (mobilization) for accurate site‑level carbon accounting.',
    `activity_quantity` DECIMAL(18,2) COMMENT 'Measured amount of the activity (e.g., liters of fuel, kWh of electricity, tonnes of material).',
    `activity_unit` STRING COMMENT 'Unit associated with the activity_quantity.. Valid values are `liter|kwh|tonne|km|kg`',
    `co2e_tonnes` DECIMAL(18,2) COMMENT 'Calculated carbon dioxide equivalent emissions for the record, expressed in metric tonnes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'True if the emission data passed all quality checks; otherwise false.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the emission measurement was recorded on site.',
    `measurement_method` STRING COMMENT 'Method used to obtain the activity data and emission factor.. Valid values are `direct_measurement|estimation|modeling`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the emission measurement.',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period to which this emission belongs.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period to which this emission belongs.',
    `scope` STRING COMMENT 'GHG accounting scope: Scope 1 (direct), Scope 2 (indirect electricity), Scope 3 (value chain).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `source_category` STRING COMMENT 'High‑level category of the emission source aligned with GHG Protocol definitions.. Valid values are `direct_combustion|purchased_electricity|supply_chain|waste|transport`',
    `source_type` STRING COMMENT 'Specific type of activity or equipment generating the emission.. Valid values are `diesel_generator|concrete_batching|fleet_vehicle|grid_electricity|material_transport|equipment_operation`',
    `updated_by` STRING COMMENT 'User identifier who last modified the emission record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emission record.',
    `verification_date` DATE COMMENT 'Date when the emission record was verified.',
    `verification_status` STRING COMMENT 'Indicates whether the emission record has been reviewed and approved.. Valid values are `unverified|verified|rejected`',
    `verified_by` STRING COMMENT 'Name or identifier of the person/department that verified the emission record.',
    `created_by` STRING COMMENT 'User identifier who created the emission record.',
    CONSTRAINT pk_carbon_emission PRIMARY KEY(`carbon_emission_id`)
) COMMENT 'Transactional record of a greenhouse gas (GHG) emission measurement event for a construction project, site, or corporate entity. Captures emission source category (Scope 1 direct combustion, Scope 2 purchased electricity, Scope 3 supply chain/transport/waste), emission source type (diesel generator, concrete batching, fleet vehicle, grid electricity), activity data quantity, emission factor applied, calculated CO2e tonnes, and reporting period. Aligned with GHG Protocol and ISO 14064.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` (
    `emission_factor_id` BIGINT COMMENT 'Unique surrogate key for the emission factor.',
    `regulatory_authority_id` BIGINT COMMENT 'add column regulatory_authority_id (BIGINT) with FK to compliance.regulatory_authority.regulatory_authority_id - emission factors are published by regulatory bodies',
    `superseded_emission_factor_id` BIGINT COMMENT 'Self-referencing FK on emission_factor (superseded_emission_factor_id)',
    `applicable_fuel_category` STRING COMMENT 'Category of fuel the factor applies to.. Valid values are `liquid|gas|solid|electric|bio`',
    `applicable_project_type` STRING COMMENT 'Project categories where the factor is applicable.. Valid values are `infrastructure|residential|commercial|industrial|energy|transport`',
    `applicable_sector` STRING COMMENT 'Industry sector where the factor is relevant.. Valid values are `construction|energy|manufacturing|transport|agriculture`',
    `confidence_level` STRING COMMENT 'Confidence level of the factors accuracy.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the factor record was created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating confidence in factor data (0‑100).',
    `effective_from` DATE COMMENT 'Date from which the factor is valid.',
    `effective_until` DATE COMMENT 'Date until which the factor is valid; null if indefinite.',
    `expiration_reason` STRING COMMENT 'Reason why the factor expired or was deprecated.',
    `factor_name` STRING COMMENT 'Descriptive name of the emission factor, e.g., Diesel Fuel CO2e Factor.',
    `factor_precision` STRING COMMENT 'Description of precision (e.g., number of significant digits).',
    `factor_value` DECIMAL(18,2) COMMENT 'Numeric value of the emission factor.',
    `fuel_type` STRING COMMENT 'Type of fuel or material the factor applies to. [ENUM-REF-CANDIDATE: diesel|gasoline|natural_gas|electricity|coal|biofuel|hydrogen — 7 candidates stripped; promote to reference product]',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the factor.. Valid values are `global|regional|country|state|city`',
    `gwp_basis` STRING COMMENT 'GWP assessment basis used for the factor.. Valid values are `AR4|AR5|AR6`',
    `is_active` BOOLEAN COMMENT 'Indicates if the factor is currently active for use.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates if the factor is deprecated.',
    `last_reviewed_date` DATE COMMENT 'Date when the factor was last reviewed for accuracy.',
    `measurement_method` STRING COMMENT 'Method used to derive the factor.. Valid values are `direct|modelled|default|estimated`',
    `notes` STRING COMMENT 'Free‑text notes or comments about the factor.',
    `region_code` STRING COMMENT 'ISO 3166-1 alpha-3 country or region identifier.',
    `regulatory_standard` STRING COMMENT 'Regulation or standard that mandates use of this factor.',
    `source` STRING COMMENT 'Originating standard or organization providing the factor.. Valid values are `IPCC|DEFRA|EPA|National Grid`',
    `source_document_reference` STRING COMMENT 'Reference to the document or publication containing the factor.',
    `unit_of_measure` STRING COMMENT 'Unit in which the factor value is expressed.. Valid values are `kg_co2e_per_litre|kg_co2e_per_kwh|kg_co2e_per_tonne`',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the factor.',
    `version_number` STRING COMMENT 'Version identifier for the factor record.',
    `created_by` STRING COMMENT 'User or system that created the record.',
    CONSTRAINT pk_emission_factor PRIMARY KEY(`emission_factor_id`)
) COMMENT 'Reference master of GHG emission factors used to convert activity data into CO2e tonnes. Captures emission factor source (IPCC, DEFRA, EPA, national grid), fuel or material type, emission factor value, unit (kg CO2e per litre, per kWh, per tonne), global warming potential (GWP) basis (AR4/AR5/AR6), effective date range, and geographic applicability. Enables consistent and auditable carbon calculation across all projects.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` (
    `carbon_target_id` BIGINT COMMENT 'Unique system-generated identifier for the carbon reduction target record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients set corporate carbon‑reduction targets; the target entity must be tied to the client account for performance tracking.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Construction firms set asset‑level carbon reduction targets for heavy equipment to meet project net‑zero commitments.',
    `superseded_carbon_target_id` BIGINT COMMENT 'Self-referencing FK on carbon_target (superseded_carbon_target_id)',
    `alignment_paris_pathway` STRING COMMENT 'Alignment of the target with the 1.5 °C, 2 °C, or Net‑Zero pathways of the Paris Agreement.. Valid values are `1.5C|2C|net_zero_pathway`',
    `approval_date` DATE COMMENT 'Date on which the target was formally approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee that approved the target.',
    `baseline_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total greenhouse‑gas emissions in metric tonnes CO₂‑equivalent for the baseline year.',
    `baseline_year` STRING COMMENT 'Calendar year used as the reference point for emissions calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon target record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the carbon target becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the carbon target expires or is superseded (null for open‑ended).',
    `interim_milestones` STRING COMMENT 'JSON‑encoded list of intermediate milestones (year and reduction %) leading to the final target.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the target record.. Valid values are `draft|active|suspended|completed|retired`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the target.',
    `sbti_validation_status` STRING COMMENT 'Status of validation by the Science‑Based Targets initiative.. Valid values are `validated|pending|rejected`',
    `target_code` STRING COMMENT 'Human‑readable code or number used to reference the carbon target in reports and contracts.',
    `target_description` STRING COMMENT 'Narrative description of the carbon reduction commitment and its strategic context.',
    `target_intensity_unit` STRING COMMENT 'Unit of measure for the intensity‑based target.. Valid values are `tco2e_per_mwh|tco2e_per_ton|tco2e_per_sqft`',
    `target_intensity_value` DECIMAL(18,2) COMMENT 'Emissions intensity target (e.g., tCO₂e per unit of production) for intensity‑based targets.',
    `target_reduction_pct` DECIMAL(18,2) COMMENT 'Desired percentage reduction of emissions relative to the baseline.',
    `target_scope` STRING COMMENT 'GHG accounting scope(s) covered by the target (Scope 1, 2, 3, or combinations).. Valid values are `scope1|scope2|scope3|scope1_2|scope1_2_3`',
    `target_type` STRING COMMENT 'Category of the carbon reduction commitment (e.g., absolute reduction, intensity‑based, net‑zero, or Science‑Based Target).. Valid values are `absolute_reduction|intensity_based|net_zero|science_based_target`',
    `target_units` STRING COMMENT 'Unit of measure for the target value (e.g., tCO₂e).',
    `target_value_tco2e` DECIMAL(18,2) COMMENT 'Absolute emissions level to be reached by the target year, expressed in metric tonnes CO₂‑equivalent.',
    `target_year` STRING COMMENT 'Calendar year by which the reduction target must be achieved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the carbon target record.',
    CONSTRAINT pk_carbon_target PRIMARY KEY(`carbon_target_id`)
) COMMENT 'Master record defining the organizations or a projects GHG reduction targets and net-zero commitments. Captures target type (absolute reduction, intensity-based, net-zero, science-based target), baseline year, baseline emissions (tCO2e), target year, target reduction percentage, SBTi validation status, interim milestones, and alignment with Paris Agreement pathways. SSOT for decarbonization commitments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'System-generated unique identifier for each carbon offset transaction record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients purchase carbon offsets to meet net‑zero commitments; linking offsets to the client account records procurement per client.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Carbon offsets are applied to a reduction target; the FK allows tracking which offsets contribute to which target.',
    `retired_carbon_offset_id` BIGINT COMMENT 'Self-referencing FK on carbon_offset (retired_carbon_offset_id)',
    `carbon_offset_status` STRING COMMENT 'Current lifecycle status of the offset transaction.. Valid values are `pending|active|retired|cancelled`',
    `compliance_status` STRING COMMENT 'Current compliance status of the offset transaction with ESG reporting requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon offset record was first created in the system.',
    `credit_type` STRING COMMENT 'Category of emission reduction activity represented by the credit.. Valid values are `reforestation|renewable_energy|methane_capture|soil_sequestration|energy_efficiency`',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code of the purchase price.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `esg_report_period` STRING COMMENT 'Reporting period identifier (e.g., FY2023Q4) for which the offset is disclosed.',
    `is_retired` BOOLEAN COMMENT 'Indicates whether the offset credits have been retired (true) or are still active (false).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the offset transaction.',
    `offset_reference` STRING COMMENT 'External reference number or code assigned to the carbon offset transaction by the issuing registry or internal system.',
    `offset_standard` STRING COMMENT 'Certification standard under which the offset credit is issued.. Valid values are `Gold Standard|VCS|Verra|ACR`',
    `project_country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the offset project is located.. Valid values are `^[A-Z]{3}$`',
    `project_name` STRING COMMENT 'Name of the project that generated the offset credits.',
    `project_region` STRING COMMENT 'State, province, or region within the project country.',
    `purchase_price_usd` DECIMAL(18,2) COMMENT 'Monetary amount paid for the offset credits, expressed in US dollars.',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Number of metric tonnes of CO₂ equivalent that were offset.',
    `registry_name` STRING COMMENT 'Name of the registry where the offset credit is recorded (e.g., Verra Registry).',
    `registry_serial_number` STRING COMMENT 'Unique serial number assigned by the registry to the specific offset credit.',
    `retirement_date` DATE COMMENT 'Date on which the offset credits were officially retired or applied.',
    `retirement_reason` STRING COMMENT 'Reason why the offset credits were retired.. Valid values are `voluntary|regulatory|contractual`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the offset purchase or retirement was executed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the carbon offset record.',
    `verification_body` STRING COMMENT 'Organization that performed the verification of the offset credit.',
    `verification_date` DATE COMMENT 'Date on which the offset credit was independently verified.',
    `vintage_year` STRING COMMENT 'Calendar year in which the offset project generated the credited emissions reductions.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Transactional record of carbon offset credits purchased or retired by the construction enterprise to compensate for residual GHG emissions. Captures offset project name, offset standard (Gold Standard, VCS/Verra, ACR), credit type (reforestation, renewable energy, methane capture), vintage year, quantity (tCO2e), registry serial numbers, retirement date, and associated ESG report period. Supports net-zero accounting and disclosure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`waste_record` (
    `waste_record_id` BIGINT COMMENT 'System-generated unique identifier for the waste record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory waste‑diversion reports are filed per client; linking waste records to the client account provides client‑wide waste compliance.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Waste Management process tracks waste generated by each construction activity, needed for waste diversion reporting and compliance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Waste generated by specific equipment (e.g., demolition) is recorded for waste diversion reporting and cost allocation.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the waste.',
    `corrected_waste_record_id` BIGINT COMMENT 'Self-referencing FK on waste_record (corrected_waste_record_id)',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Waste tracking reports assign waste generation to the crew that produced it, enabling crew‑level waste accountability.',
    `disposal_facility_id` BIGINT COMMENT 'System identifier of the disposal facility.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Waste tracking requires the site supervisor who records the waste event; linking enables waste audit and accountability.',
    `site_mobilization_id` BIGINT COMMENT 'Foreign key linking to site.site_mobilization. Business justification: Waste tracking per site is needed for environmental permits and waste diversion targets; linking to site_mobilization provides the required site context.',
    `waste_carrier_id` BIGINT COMMENT 'System identifier of the waste carrier.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for waste disposal or processing.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier used for financial allocation of waste disposal costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the disposal cost.',
    `disposal_route` STRING COMMENT 'Destination method for the waste after generation.. Valid values are `landfill|recycling|reuse|energy_recovery|incineration`',
    `diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill to recycling/reuse.',
    `epa_waste_code` STRING COMMENT 'Regulatory code assigned by the EPA for the waste type.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the waste was generated or recorded at the site.',
    `hazardous_flag` BOOLEAN COMMENT 'Indicates whether the waste is classified as hazardous.',
    `invoice_date` DATE COMMENT 'Date on which the waste disposal invoice was issued.',
    `invoice_number` STRING COMMENT 'Reference number of the invoice issued for waste disposal services.',
    `notes` STRING COMMENT 'Additional remarks or comments related to the waste record.',
    `quantity` DECIMAL(18,2) COMMENT 'Measured amount of waste generated, expressed in the unit specified by unit_of_measure.',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period for which waste is recorded.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period for which waste is recorded.',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity field (tonnes or cubic meters).. Valid values are `tonnes|cubic_meters`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the waste record.',
    `verification_date` DATE COMMENT 'Date when the waste record was verified for accuracy.',
    `verified_by` STRING COMMENT 'Name of the employee or authority who verified the waste record.',
    `waste_category` STRING COMMENT 'Regulatory classification of the waste for handling and reporting.. Valid values are `inert|non_inert|hazardous|recyclable|organic`',
    `waste_description` STRING COMMENT 'Free‑text description providing additional details about the waste.',
    `waste_record_number` STRING COMMENT 'Human‑readable business identifier assigned to the waste record for tracking and reporting.',
    `waste_record_status` STRING COMMENT 'Current lifecycle state of the waste record.. Valid values are `recorded|verified|billed|closed|rejected`',
    `waste_source` STRING COMMENT 'Origin activity that produced the waste.. Valid values are `demolition|construction|renovation|maintenance|other`',
    `waste_stream_type` STRING COMMENT 'Category of waste material (e.g., concrete rubble, steel scrap).. Valid values are `concrete|steel|timber|hazardous|packaging|other`',
    CONSTRAINT pk_waste_record PRIMARY KEY(`waste_record_id`)
) COMMENT 'Transactional record capturing construction and demolition (C&D) waste generated at a project site during a reporting period. Captures waste stream type (concrete rubble, steel scrap, timber offcuts, hazardous waste, packaging), waste quantity (tonnes or m³), disposal route (landfill, recycling, reuse, energy recovery, incineration), waste carrier details, disposal facility, diversion rate achieved, and cost of disposal. Supports waste diversion KPI tracking and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`waste_target` (
    `waste_target_id` BIGINT COMMENT 'Unique identifier for the waste target record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the waste target applies.',
    `superseded_waste_target_id` BIGINT COMMENT 'Self-referencing FK on waste_target (superseded_waste_target_id)',
    `actual_diversion_rate_pct` DECIMAL(18,2) COMMENT 'Measured waste diversion rate achieved to date, expressed as a percentage.',
    `actual_landfill_diversion_tonnes` DECIMAL(18,2) COMMENT 'Measured amount of waste actually diverted from landfill, in tonnes.',
    `actual_waste_intensity_kg_per_million_revenue` DECIMAL(18,2) COMMENT 'Current waste intensity measured in kilograms per million pounds of revenue.',
    `actual_waste_intensity_kg_per_sqm` DECIMAL(18,2) COMMENT 'Current waste intensity measured in kilograms per square meter.',
    `approved_by` STRING COMMENT 'User identifier who approved the waste target.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste target was approved for execution.',
    `baseline_waste_intensity_kg_per_million_revenue` DECIMAL(18,2) COMMENT 'Current waste generation intensity baseline measured in kilograms per million pounds of revenue.',
    `baseline_waste_intensity_kg_per_sqm` DECIMAL(18,2) COMMENT 'Current waste generation intensity baseline measured in kilograms per square meter of built area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste target record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for any monetary amounts associated with the target.. Valid values are `[A-Z]{3}`',
    `end_date` DATE COMMENT 'Date when the waste target expires or is completed; nullable for open‑ended targets.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the waste target is publicly disclosed.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the waste target.',
    `progress_status` STRING COMMENT 'Current progress indicator relative to the waste target.. Valid values are `on_track|behind|ahead|not_started`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic region of the target.. Valid values are `[A-Z]{3}`',
    `reporting_frequency` STRING COMMENT 'How often waste performance against the target is reported.. Valid values are `monthly|quarterly|annually`',
    `start_date` DATE COMMENT 'Date when the waste target becomes effective.',
    `target_budget_amount` DECIMAL(18,2) COMMENT 'Financial budget allocated to achieve the waste target.',
    `target_code` STRING COMMENT 'Business identifier code for the waste reduction target.',
    `target_diversion_rate_pct` DECIMAL(18,2) COMMENT 'Committed waste diversion rate expressed as a percentage of total waste.',
    `target_landfill_diversion_tonnes` DECIMAL(18,2) COMMENT 'Target amount of waste to be diverted from landfill, measured in tonnes.',
    `target_period_years` STRING COMMENT 'Number of years over which the waste target is planned to be achieved.',
    `target_type` STRING COMMENT 'Classification of the waste target strategy type.. Valid values are `zero_waste|circular_economy|reduction|diversion`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the waste target record.',
    `waste_management_strategy` STRING COMMENT 'Strategic approach selected for achieving the waste target.. Valid values are `zero_waste_to_landfill|circular_economy|recycling_first|composting`',
    `waste_target_status` STRING COMMENT 'Current lifecycle status of the waste target.. Valid values are `draft|active|completed|cancelled|expired`',
    `created_by` STRING COMMENT 'User identifier who initially created the waste target.',
    CONSTRAINT pk_waste_target PRIMARY KEY(`waste_target_id`)
) COMMENT 'Master record defining project-level or corporate waste reduction and diversion targets. Captures target diversion rate (%), target landfill diversion (tonnes), baseline waste intensity (kg per m² or per £M revenue), target period, waste management strategy type (zero waste to landfill, circular economy), and progress tracking status. Enables benchmarking of actual waste performance against commitments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`green_certification` (
    `green_certification_id` BIGINT COMMENT 'System-generated unique identifier for the green certification record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients obtain green building certifications; linking certifications to the client account aggregates certifications per client.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this certification.',
    `superseded_green_certification_id` BIGINT COMMENT 'Self-referencing FK on green_certification (superseded_green_certification_id)',
    `achieved_rating` STRING COMMENT 'Rating actually awarded after assessment.',
    `assessor_email` STRING COMMENT 'Email address of the assessor for follow‑up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessor_name` STRING COMMENT 'Full name of the individual or organization that performed the assessment.',
    `carbon_reduction_amount` DECIMAL(18,2) COMMENT 'Quantified carbon emissions reduction attributed to the certification (in metric tonnes CO₂e).',
    `carbon_reduction_unit` STRING COMMENT 'Unit of measure for carbon reduction (e.g., tCO2e).. Valid values are `tCO2e`',
    `certificate_number` STRING COMMENT 'Official number assigned by the certification body to this certification.',
    `certification_body` STRING COMMENT 'Organization that issues the certification (e.g., USGBC for LEED).',
    `certification_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred to obtain the certification.',
    `certification_scheme` STRING COMMENT 'Name of the green building certification scheme (e.g., LEED, BREEAM, WELL, Envision, CEEQUAL, Green Star, EDGE, SITES).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `pending|active|expired|revoked`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the certification cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the digital copy of the certification documentation.',
    `expiry_date` DATE COMMENT 'Date the certification expires and must be renewed.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the certification.',
    `rating_date` DATE COMMENT 'Date on which the certification rating was granted.',
    `registered_date` DATE COMMENT 'Date the certification was officially registered with the certifying body.',
    `sustainable_material_pct` DECIMAL(18,2) COMMENT 'Proportion of total material volume that is certified sustainable or recycled.',
    `target_rating_level` STRING COMMENT 'Desired rating level sought in the certification scheme (e.g., LEED Platinum, BREEAM Outstanding).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `waste_diversion_pct` DECIMAL(18,2) COMMENT 'Percentage of construction waste diverted from landfill as a result of sustainable practices.',
    CONSTRAINT pk_green_certification PRIMARY KEY(`green_certification_id`)
) COMMENT 'Master record tracking green building and infrastructure certification pursuits and awards for construction projects. Covers certifications beyond LEED including BREEAM, WELL Building Standard, LEED v4.1, Envision (infrastructure), CEEQUAL, Green Star, EDGE, and SITES. Captures certification scheme, target rating level (e.g., BREEAM Outstanding, LEED Platinum), registered date, assessor details, achieved rating, certificate number, and expiry date.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`green_credit` (
    `green_credit_id` BIGINT COMMENT 'Unique identifier for the green credit record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this credit belongs.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the user who performed the last review.',
    `parent_green_credit_id` BIGINT COMMENT 'Self-referencing FK on green_credit (parent_green_credit_id)',
    `assessment_date` DATE COMMENT 'Date the credit was assessed.',
    `assessor_comment` STRING COMMENT 'Comments provided by the assessor during evaluation.',
    `award_date` DATE COMMENT 'Date the credit was officially awarded.',
    `certification_program` STRING COMMENT 'Green building certification program under which the credit is evaluated.. Valid values are `LEED|BREEAM|WELL|DGNB`',
    `certification_version` STRING COMMENT 'Version of the certification program (e.g., "v4.1").',
    `compliance_status` STRING COMMENT 'Current compliance outcome for the credit.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the green credit record was first created.',
    `credit_category` STRING COMMENT 'Category of the credit within the sustainability assessment.. Valid values are `energy|water|materials|transport|ecology|innovation`',
    `credit_code` STRING COMMENT 'Business code or identifier for the credit (e.g., "EC‑01").',
    `credit_name` STRING COMMENT 'Human‑readable name of the green credit (e.g., "Optimized Energy Performance").',
    `data_source_record_reference` STRING COMMENT 'Identifier of the source record in the originating system.',
    `data_source_system` STRING COMMENT 'Operational system where the original credit data originated.. Valid values are `Procore|BIM360|SAP|Viewpoint|HCSS|Aconex`',
    `evidence_reference` STRING COMMENT 'Identifier or URL of the supporting evidence submitted for the credit.',
    `expiration_date` DATE COMMENT 'Date after which the credit may no longer be valid (if applicable).',
    `green_credit_status` STRING COMMENT 'Current lifecycle status of the credit.. Valid values are `targeted|submitted|awarded|not_pursued|rejected`',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the credit has been verified by an authorized party.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the credit record.',
    `notes` STRING COMMENT 'Free‑form notes related to the credit.',
    `points_achieved` DECIMAL(18,2) COMMENT 'Points actually earned after assessment.',
    `points_max` DECIMAL(18,2) COMMENT 'Maximum points that can be earned for this credit.',
    `points_targeted` DECIMAL(18,2) COMMENT 'Points the project aims to achieve for this credit.',
    `region` STRING COMMENT 'Three‑letter country code indicating the region of the project.. Valid values are `[A-Z]{3}`',
    `risk_level` STRING COMMENT 'Risk assessment associated with achieving the credit.. Valid values are `low|medium|high`',
    `submission_date` DATE COMMENT 'Date the credit documentation was submitted to the certifying body.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `verification_method` STRING COMMENT 'Method used to verify the credit evidence.. Valid values are `document|site_visit|third_party|self`',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_green_credit PRIMARY KEY(`green_credit_id`)
) COMMENT 'Individual credit or category score record within a green building certification assessment. Captures credit category (energy, water, materials, transport, ecology, innovation), credit name, maximum available points, points targeted, points achieved, evidence reference, assessor comment, and credit status (targeted, submitted, awarded, not pursued). Enables granular tracking of certification credit attainment strategy.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` (
    `sustainable_material_id` BIGINT COMMENT 'Unique system-generated identifier for the sustainable material record.',
    `document_register_id` BIGINT COMMENT 'Identifier of the Environmental Product Declaration document for the material.',
    `superseded_sustainable_material_id` BIGINT COMMENT 'Self-referencing FK on sustainable_material (superseded_sustainable_material_id)',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier in the enterprise master data.',
    `applicable_project_type` STRING COMMENT 'Project categories for which the material is deemed suitable.. Valid values are `residential|commercial|infrastructure|industrial|energy|other`',
    `certification_reference` STRING COMMENT 'Reference identifier or URL to the certification document or registry entry.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the material with relevant environmental regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of the material per unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sustainable material record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost values.. Valid values are `USD|EUR|GBP|JPY|CNY|Other`',
    `date_approved` DATE COMMENT 'Date when the material was approved for sustainable use.',
    `date_deprecated` DATE COMMENT 'Date when the material was removed from the sustainable material list.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Physical density of the material, used for volume‑to‑weight conversions.',
    `sustainable_material_description` STRING COMMENT 'Free‑form description of the material, including typical applications and key properties.',
    `embodied_carbon_kg_per_kg` DECIMAL(18,2) COMMENT 'Carbon emissions associated with producing one kilogram of the material.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Composite score summarizing the materials overall environmental impact.',
    `epd_url` STRING COMMENT 'Web link to the EPD document providing detailed lifecycle data.',
    `health_safety_rating` STRING COMMENT 'Rating reflecting health and safety considerations of handling the material.. Valid values are `A|B|C|D|E|F`',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the material is currently approved for sustainable sourcing.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date and time when the materials sustainability data was last validated.',
    `lead_time_days` STRING COMMENT 'Average procurement lead time for the material from order to delivery.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the material record within the sustainability program.. Valid values are `active|inactive|deprecated|pending`',
    `material_category` STRING COMMENT 'Classification of the material based on sustainability characteristics.. Valid values are `recycled|renewable|virgin|low_carbon|bio_based|other`',
    `material_code` STRING COMMENT 'Business identifier or catalogue code assigned to the material by the organization.',
    `material_name` STRING COMMENT 'Human‑readable name of the material as used in project specifications and procurement.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments about the material.',
    `recycled_content_percent` DECIMAL(18,2) COMMENT 'Percentage of the material that consists of recycled content by weight.',
    `regulatory_approval_number` STRING COMMENT 'Official approval number issued by a governing body for the material.',
    `renewable_energy_content_percent` DECIMAL(18,2) COMMENT 'Share of renewable energy used in the materials production process.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating associated with sourcing or using the material.',
    `source_of_material` STRING COMMENT 'Origin of the material in terms of raw or reclaimed content.. Valid values are `virgin|reclaimed|recycled|bio_based|other`',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for the material (e.g., temperature, humidity).',
    `supplier_country_code` STRING COMMENT 'Three‑letter ISO country code of the suppliers primary location.. Valid values are `^[A-Z]{3}$`',
    `supplier_name` STRING COMMENT 'Name of the supplier providing the sustainable material.',
    `sustainable_certification` STRING COMMENT 'Certification indicating responsible sourcing or low‑carbon status.. Valid values are `FSC|PEFC|BES6001|ISO14001|LEED|None`',
    `total_embodied_carbon_kg` DECIMAL(18,2) COMMENT 'Total embodied carbon for the material quantity specified in the record.',
    `transport_distance_km` DECIMAL(18,2) COMMENT 'Estimated distance the material travels from supplier to project site.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for delivering the material.. Valid values are `truck|rail|ship|air|pipeline|other`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for ordering and reporting the material quantity.. Valid values are `kg|m3|lb|ft3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the sustainable material record.',
    `version_number` STRING COMMENT 'Version of the record to support change management and audit.',
    `waste_diversion_percent` DECIMAL(18,2) COMMENT 'Portion of waste avoided by using this material instead of conventional alternatives.',
    CONSTRAINT pk_sustainable_material PRIMARY KEY(`sustainable_material_id`)
) COMMENT 'Master record for materials designated as sustainable or low-carbon within the approved material sourcing program. Captures material type, sustainability attribute (recycled content %, embodied carbon (kgCO2e/kg), responsibly sourced certification (FSC, PEFC, BES 6001), EPD (Environmental Product Declaration) reference, supplier origin, transport distance, and approved project applicability. SSOT for sustainable material sourcing decisions.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` (
    `embodied_carbon_assessment_id` BIGINT COMMENT 'System-generated unique identifier for each embodied carbon assessment record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the assessment applies.',
    `prior_embodied_carbon_assessment_id` BIGINT COMMENT 'Self-referencing FK on embodied_carbon_assessment (prior_embodied_carbon_assessment_id)',
    `assessment_approval_date` DATE COMMENT 'Date on which the assessment was formally approved.',
    `assessment_approved_by` STRING COMMENT 'Name of the person who approved the assessment results.',
    `assessment_author` STRING COMMENT 'Name of the individual or team that performed the assessment.',
    `assessment_code` STRING COMMENT 'External reference code assigned to the assessment for tracking and reporting.',
    `assessment_notes` STRING COMMENT 'Free‑form comments or observations recorded by the assessor.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `draft|in_review|approved|rejected`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the embodied carbon assessment was performed.',
    `assessment_tool` STRING COMMENT 'Software tool employed to calculate embodied carbon.. Valid values are `One_Click_LCA|Tally|EC3|SimaPro|GaBi`',
    `assessment_version` STRING COMMENT 'Version identifier of the assessment methodology or data set.',
    `benchmark_comparison` STRING COMMENT 'Result of comparing the assessments total carbon to the selected benchmark.. Valid values are `above|below|equal|not_applicable`',
    `benchmark_reference` STRING COMMENT 'Reference identifier for the benchmark against which the assessment is compared.',
    `biogenic_carbon_tco2e` DECIMAL(18,2) COMMENT 'Carbon sequestered or emitted from biogenic materials, expressed in tCO2e.',
    `carbon_boundary` STRING COMMENT 'Scope of carbon accounting (e.g., cradle‑to‑gate).. Valid values are `cradle_to_gate|cradle_to_grave|cradle_to_care`',
    `carbon_intensity_kg_per_m3` DECIMAL(18,2) COMMENT 'Carbon intensity per cubic metre of material, expressed in kilograms CO2e.',
    `carbon_offset_used` BOOLEAN COMMENT 'Indicates whether carbon offsets were applied to the assessment.',
    `confidence_level` STRING COMMENT 'Assessor’s confidence in the accuracy of the reported carbon values.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the assessment data.. Valid values are `SAP_S4HANA|Procore|BIM_360|Custom`',
    `end_of_life_carbon_tco2e` DECIMAL(18,2) COMMENT 'Embodied carbon for end‑of‑life stages (C1‑C4) of the life‑cycle.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the assessment has been independently verified.',
    `methodology` STRING COMMENT 'Standard or custom methodology used for the carbon assessment.. Valid values are `EN_15978|RICS_WLCA|ISO_14064|custom`',
    `offset_provider` STRING COMMENT 'Name of the organization providing the carbon offsets.',
    `offset_quantity_tco2e` DECIMAL(18,2) COMMENT 'Quantity of carbon offsets purchased, expressed in tCO2e.',
    `operational_carbon_tco2e` DECIMAL(18,2) COMMENT 'Embodied carbon attributed to the operational phase (B6) of the life‑cycle.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the assessment is included in mandatory ESG or regulatory reporting.',
    `related_project_phase` STRING COMMENT 'Project phase to which the assessment is most relevant.. Valid values are `design|construction|operation|maintenance`',
    `renewable_material_percentage` DECIMAL(18,2) COMMENT 'Proportion of materials sourced from renewable resources.',
    `riba_stage` STRING COMMENT 'RIBA stage of the project at which the assessment was conducted.. Valid values are `stage_2|stage_3|stage_4|stage_5|stage_6|stage_7`',
    `scope` STRING COMMENT 'Greenhouse‑gas scope classification for the assessment.. Valid values are `scope_1|scope_2|scope_3`',
    `total_embodied_carbon_tco2e` DECIMAL(18,2) COMMENT 'Aggregate embodied carbon for the project, expressed in metric tonnes of CO2 equivalent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `upfront_carbon_tco2e` DECIMAL(18,2) COMMENT 'Embodied carbon associated with product stage (A1‑A5) of the life‑cycle.',
    `verification_body` STRING COMMENT 'Organization that performed the verification.',
    `verification_date` DATE COMMENT 'Date on which verification was completed.',
    `waste_diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of construction waste diverted from landfill.',
    CONSTRAINT pk_embodied_carbon_assessment PRIMARY KEY(`embodied_carbon_assessment_id`)
) COMMENT 'Transactional record of an embodied carbon assessment conducted for a construction project or design package. Captures assessment stage (RIBA Stage 2/3/4/5/6/7 per RICS Whole Life Carbon Assessment), total embodied carbon (tCO2e), upfront carbon (A1-A5), operational carbon (B6), end-of-life carbon (C1-C4), biogenic carbon, assessment methodology (EN 15978, RICS WLCA), tool used (One Click LCA, Tally, EC3), and benchmark comparison.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'System-generated unique identifier for each energy consumption record.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Energy Consumption reporting ties energy use to scheduled activities to calculate activity‑level carbon intensity for ESG metrics.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Energy (fuel) consumption is tracked per piece of equipment to calculate emissions intensity and improve efficiency.',
    `construction_project_id` BIGINT COMMENT 'Unique identifier of the project associated with the energy consumption.',
    `corrected_energy_consumption_id` BIGINT COMMENT 'Self-referencing FK on energy_consumption (corrected_energy_consumption_id)',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Energy consumption data is entered by a facilities manager; linking provides traceability for energy‑efficiency initiatives.',
    `site_mobilization_id` BIGINT COMMENT 'Foreign key linking to site.site_mobilization. Business justification: Energy consumption reporting is performed at the site level to meet sustainability KPIs and utility billing reconciliation.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Factor used to convert energy consumption to CO₂e emissions (kg CO₂e per unit).',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Calculated carbon emissions for the consumption record in kilograms of CO₂e.',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'Measured amount of energy consumed during the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumption record was first created in the system.',
    `energy_consumption_status` STRING COMMENT 'Current processing status of the consumption record.. Valid values are `recorded|estimated|corrected|rejected`',
    `energy_intensity` DECIMAL(18,2) COMMENT 'Energy consumption per unit of output (e.g., kWh per square meter) for benchmarking.',
    `energy_type` STRING COMMENT 'Category of energy consumed (e.g., diesel, electricity, natural gas, LPG, renewable, other).. Valid values are `diesel|electricity|natural_gas|lpg|renewable|other`',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the consumption value is an estimate (true) or a measured value (false).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the energy consumption measurement was recorded.',
    `meter_number` BIGINT COMMENT 'Unique identifier of the meter or measurement device that captured the consumption.',
    `metering_source` STRING COMMENT 'Origin of the measurement data: smart meter, fuel dip, invoice, or manual entry.. Valid values are `smart_meter|fuel_dip|invoice|manual_entry`',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or comments about the consumption entry.',
    `period_end_date` DATE COMMENT 'Last day of the reporting period for which consumption is aggregated.',
    `period_start_date` DATE COMMENT 'First day of the reporting period for which consumption is aggregated.',
    `recorded_by` BIGINT COMMENT 'Identifier of the user or system that entered the consumption record.',
    `unit_of_measure` STRING COMMENT 'Unit in which the consumption quantity is expressed (e.g., kWh, MWh, GJ, litre).. Valid values are `kWh|MWh|GJ|litre|kg|BTU`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consumption record.',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Transactional record of energy consumption measured at a construction site, office, or plant facility during a reporting period. Captures energy type (diesel, grid electricity, natural gas, LPG, renewable on-site generation), consumption quantity, unit (litres, kWh, GJ), metering source (smart meter, fuel dip, invoice), site or facility reference, and reporting period. Feeds Scope 1 and Scope 2 carbon calculations and energy intensity benchmarking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` (
    `water_consumption_id` BIGINT COMMENT 'System-generated unique identifier for each water consumption record.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Water usage is monitored per construction activity to satisfy environmental permits and sustainability reporting.',
    `construction_project_id` BIGINT COMMENT 'Unique identifier of the construction project associated with the water consumption.',
    `corrected_water_consumption_id` BIGINT COMMENT 'Self-referencing FK on water_consumption (corrected_water_consumption_id)',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Water usage readings are logged by a field engineer; associating the employee supports regulatory water‑use reporting.',
    `carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Estimated greenhouse‑gas emissions associated with the water consumption, expressed in kilograms of CO₂ equivalent.',
    `comments` STRING COMMENT 'Free‑text field for additional notes or observations about the measurement.',
    `compliance_status` STRING COMMENT 'Indicates whether the water usage complies with applicable ESG or regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `consumption_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of water consumed during the reporting period, measured in cubic metres.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water consumption record was first created in the system.',
    `discharge_destination` STRING COMMENT 'Where the discharged water is sent (e.g., municipal sewer, natural watercourse, on‑site treatment, reuse).. Valid values are `sewer|watercourse|on_site_treatment|reused`',
    `discharge_volume_m3` DECIMAL(18,2) COMMENT 'Volume of water discharged from the site after use, measured in cubic metres.',
    `metering_method` STRING COMMENT 'Method used to capture the water consumption reading.. Valid values are `manual|automated|estimated`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the water consumption measurement was recorded.',
    `recorded_by` STRING COMMENT 'Identifier of the employee or system that recorded the water consumption measurement.',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period for which consumption is measured.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period for which consumption is measured.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the water consumption record.',
    `water_source_type` STRING COMMENT 'Classification of the water source used (e.g., mains supply, borehole, recycled/harvested rainwater, grey water reuse).. Valid values are `mains|borehole|recycled|rainwater|greywater`',
    `water_stress_area_classification` STRING COMMENT 'Classification of the geographic area based on water scarcity risk.. Valid values are `low|moderate|high|critical`',
    CONSTRAINT pk_water_consumption PRIMARY KEY(`water_consumption_id`)
) COMMENT 'Transactional record of water consumption at a construction site or facility during a reporting period. Captures water source type (mains supply, borehole, recycled/harvested rainwater, grey water reuse), consumption volume (m³), metering method, discharge volume, discharge destination (sewer, watercourse, on-site treatment), and water stress area classification. Supports water stewardship reporting and CDP Water disclosure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` (
    `climate_risk_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for the climate risk assessment record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the assessment applies.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal team or external stakeholder accountable for the assessment.',
    `prior_climate_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on climate_risk_assessment (prior_climate_risk_assessment_id)',
    `adaptation_measure` STRING COMMENT 'Planned actions to reduce exposure or vulnerability to the identified climate risk.',
    `assessment_code` STRING COMMENT 'External reference code used in reporting and regulatory filings.',
    `assessment_date` DATE COMMENT 'Date on which the climate risk assessment was formally completed.',
    `assessment_name` STRING COMMENT 'Human‑readable name or title of the climate risk assessment.',
    `assessment_type` STRING COMMENT 'Category of climate risk assessment: physical risk, transition risk, or opportunity.. Valid values are `physical|transition|opportunity`',
    `climate_risk_assessment_status` STRING COMMENT 'Current workflow state of the assessment.. Valid values are `draft|in_review|approved|rejected|closed`',
    `climate_scenario` STRING COMMENT 'Climate scenario applied in the assessment, based on IPCC RCP pathways or IEA Net‑Zero Emissions scenario.. Valid values are `rcp_2_6|rcp_4_5|rcp_8_5|iea_nze`',
    `confidence_level` STRING COMMENT 'Qualitative confidence in the underlying data and assumptions.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for the financial impact estimate.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Origin of the data used in the assessment.. Valid values are `internal_model|external_report|regulatory_data`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Estimated CO₂e emission factor (tCO₂e per unit) used in scenario calculations.',
    `expiration_date` DATE COMMENT 'Date after which the assessment is considered outdated and must be refreshed.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Monetary estimate of the potential loss or cost associated with the risk, expressed in the reporting currency.',
    `is_strategic_priority` BOOLEAN COMMENT 'True if the assessed risk is identified as a strategic priority for the organization.',
    `likelihood` STRING COMMENT 'Estimated probability of the risk materialising, expressed on a qualitative scale.. Valid values are `very_low|low|moderate|high|very_high`',
    `mitigation_action` STRING COMMENT 'Initiatives aimed at lowering greenhouse‑gas emissions or aligning with transition pathways.',
    `notes` STRING COMMENT 'Free‑form comments, observations, or caveats from the assessor.',
    `portfolio_code` BIGINT COMMENT 'Identifier of the portfolio grouping multiple projects for aggregated risk analysis.',
    `region` STRING COMMENT 'Three‑letter ISO country/region code where the assessed asset is located.. Valid values are `^[A-Z]{3}$`',
    `regulatory_change_indicator` BOOLEAN COMMENT 'Flag indicating whether emerging regulations materially affect the assessed risk.',
    `review_date` DATE COMMENT 'Planned date for the next periodic review of the assessment.',
    `risk_category` STRING COMMENT 'Primary climate‑related risk category evaluated in the assessment.. Valid values are `flooding|extreme_heat|water_scarcity|carbon_pricing|stranded_assets|regulatory_change`',
    `risk_subcategory` STRING COMMENT 'More detailed classification within the main risk category (e.g., riverine flooding, coastal flooding).',
    `sea_level_rise_estimate` DECIMAL(18,2) COMMENT 'Projected sea‑level increase (meters) relevant to flood risk calculations.',
    `temperature_increase_estimate` DECIMAL(18,2) COMMENT 'Projected average temperature rise (°C) over the selected time horizon.',
    `time_horizon` STRING COMMENT 'Planning horizon for the assessment: short (0‑5 years), medium (5‑15 years), or long term (15+ years).. Valid values are `short_term|medium_term|long_term`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assessment record.',
    CONSTRAINT pk_climate_risk_assessment PRIMARY KEY(`climate_risk_assessment_id`)
) COMMENT 'Master record for a formal climate-related risk and opportunity assessment conducted at project, portfolio, or corporate level. Captures assessment type (physical risk, transition risk, opportunity), climate scenario used (IPCC RCP 2.6/4.5/8.5, IEA NZE), time horizon (short/medium/long-term), risk category (flooding, extreme heat, water scarcity, carbon pricing, stranded assets, regulatory change), likelihood, financial impact estimate, and adaptation measures. Aligned with TCFD recommendations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` (
    `climate_risk_item_id` BIGINT COMMENT 'System-generated unique identifier for the climate risk or opportunity line item.',
    `asset_id` BIGINT COMMENT 'Identifier of the physical or digital asset impacted by the climate risk.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the risk materializes.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal party responsible for managing the risk.',
    `parent_climate_risk_item_id` BIGINT COMMENT 'Self-referencing FK on climate_risk_item (parent_climate_risk_item_id)',
    `assessment_date` DATE COMMENT 'Date on which the risk was initially evaluated.',
    `climate_risk_item_status` STRING COMMENT 'Overall lifecycle status of the climate risk item.. Valid values are `identified|assessed|mitigated|closed`',
    `climate_scenario` STRING COMMENT 'TCFD scenario used for the risk analysis: baseline, adverse, or severe.. Valid values are `baseline|adverse|severe`',
    `climate_year` STRING COMMENT 'Target year for the climate scenario (e.g., 2025, 2030).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk item record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the risk assessment is considered valid.',
    `expiry_date` DATE COMMENT 'Date after which the risk assessment is no longer applicable (nullable).',
    `exposure_level` STRING COMMENT 'Overall magnitude classification of the financial exposure.. Valid values are `low|medium|high`',
    `financial_exposure_amount` DECIMAL(18,2) COMMENT 'Monetary value of the potential loss or gain associated with the risk, in the specified currency.',
    `financial_exposure_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the financial exposure amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|CHF|CNY|INR|BRL|ZAR|KRW — promote to reference product]',
    `mitigation_action` STRING COMMENT 'Planned or executed action(s) to reduce the likelihood or impact of the risk.',
    `mitigation_status` STRING COMMENT 'Current state of the mitigation effort.. Valid values are `not_started|planned|in_progress|completed`',
    `probability_rating` STRING COMMENT 'Likelihood of the risk occurring, expressed on a qualitative scale.. Valid values are `very_low|low|medium|high|very_high`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the risk must be disclosed in regulatory or ESG reports.',
    `residual_risk_rating` STRING COMMENT 'Risk rating after planned mitigation actions have been applied.. Valid values are `very_low|low|medium|high|very_high`',
    `risk_assessment_methodology` STRING COMMENT 'Name or reference of the methodology used to assess the climate risk (e.g., TCFD, ISO 14064).',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature, cause, and potential impact of the climate risk or opportunity.',
    `risk_name` STRING COMMENT 'Short descriptive name of the climate risk or opportunity.',
    `risk_type` STRING COMMENT 'Indicates whether the line item represents a risk (negative) or an opportunity (positive).. Valid values are `risk|opportunity`',
    `tcfd_category` STRING COMMENT 'TCFD classification of the risk: physical acute, physical chronic, transition policy, transition market, or transition technology.. Valid values are `physical_acute|physical_chronic|transition_policy|transition_market|transition_technology`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk item record.',
    CONSTRAINT pk_climate_risk_item PRIMARY KEY(`climate_risk_item_id`)
) COMMENT 'Individual climate risk or opportunity line item within a climate risk assessment. Captures risk/opportunity identifier, TCFD category (physical acute, physical chronic, transition policy, transition market, transition technology), description, affected asset or project, probability rating, financial exposure (low/medium/high or quantified £), residual risk after adaptation, and owner. Enables granular TCFD scenario analysis disclosure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` (
    `sustainability_plan_id` BIGINT COMMENT 'Unique identifier for the sustainability plan.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients develop corporate sustainability plans; the FK ties each plan to the owning client account.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_assessment. Business justification: Plans are drafted based on findings of compliance assessments to address identified gaps.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Each sustainability plan is owned by a designated manager; the manager employee ID replaces the free‑text manager field for governance.',
    `superseded_sustainability_plan_id` BIGINT COMMENT 'Self-referencing FK on sustainability_plan (superseded_sustainability_plan_id)',
    `applicable_standards` STRING COMMENT 'Standards and frameworks applicable to the plan. [ENUM-REF-CANDIDATE: ISO 14001|ISO 26000|ISO 50001|ISO 45001|LEED|GRESB — promote to reference product]',
    `approval_status` STRING COMMENT 'Approval workflow status of the plan.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the individual or authority who approved the plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the plan was approved.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for sustainability initiatives under the plan.',
    `carbon_reduction_target_tonnes` DECIMAL(18,2) COMMENT 'Target amount of CO2 equivalent emissions reduction.',
    `comments` STRING COMMENT 'Additional free-text comments or notes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for budget amounts.. Valid values are `[A-Z]{3}`',
    `data_source` STRING COMMENT 'Origin of data used for plan metrics.. Valid values are `internal|external|sensor|third_party`',
    `document_url` STRING COMMENT 'Link to the stored plan document.',
    `effective_from` DATE COMMENT 'Date when the sustainability plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the sustainability plan expires or is superseded.',
    `funding_source` STRING COMMENT 'Source of funding for the sustainability plan.. Valid values are `internal|grant|loan|equity|partner`',
    `green_building_certifications` STRING COMMENT 'List of green building certifications pursued or achieved. [ENUM-REF-CANDIDATE: LEED|BREEAM|WELL|Living Building Challenge|DGNB|HQE — promote to reference product]',
    `is_public` BOOLEAN COMMENT 'Indicates whether the plan is publicly disclosed.',
    `mitigation_measures` STRING COMMENT 'Planned actions to mitigate identified risks.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which sustainability metrics are monitored.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next plan review.',
    `plan_category` STRING COMMENT 'Higher-level classification of the plan scope.. Valid values are `project|corporate|regional|global`',
    `plan_code` STRING COMMENT 'External reference code for the sustainability plan as used in contracts and reporting.',
    `plan_name` STRING COMMENT 'Descriptive name of the sustainability plan.',
    `plan_type` STRING COMMENT 'Category of the sustainability plan indicating its primary focus.. Valid values are `project_sustainability|environmental_management|social_value`',
    `renewable_energy_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of energy sourced from renewable sources.',
    `reporting_frequency` STRING COMMENT 'Frequency of formal sustainability reporting.. Valid values are `monthly|quarterly|annually|ad_hoc`',
    `responsible_department` STRING COMMENT 'Department overseeing the sustainability plan.',
    `review_frequency` STRING COMMENT 'How often the plan is reviewed for relevance and compliance.. Valid values are `annual|biannual|quarterly|monthly`',
    `risk_assessment` STRING COMMENT 'Summary of identified risks related to plan implementation.',
    `stakeholder_engagement_plan` STRING COMMENT 'Description of how stakeholders will be engaged and consulted.',
    `sustainability_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `draft|active|suspended|closed|archived`',
    `target_year` STRING COMMENT 'Fiscal or calendar year for which the plans targets are set.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `verification_date` DATE COMMENT 'Date when verification was completed.',
    `verification_status` STRING COMMENT 'Status of third-party verification of plan metrics.. Valid values are `not_verified|verified|pending`',
    `verified_by` STRING COMMENT 'Entity or auditor that performed verification.',
    `version` STRING COMMENT 'Version number of the sustainability plan document.',
    `waste_diversion_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill.',
    `water_use_reduction_target_percent` DECIMAL(18,2) COMMENT 'Target percentage reduction in water consumption.',
    CONSTRAINT pk_sustainability_plan PRIMARY KEY(`sustainability_plan_id`)
) COMMENT 'Master record for a project-level or corporate sustainability management plan defining the environmental and social commitments, targets, and management measures for a construction project. Captures plan type (project sustainability plan, environmental management plan, social value plan), applicable standards (ISO 14001, ISO 26000), key commitments, responsible manager, approval status, and review schedule. SSOT for project sustainability governance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` (
    `sustainability_action_id` BIGINT COMMENT 'System-generated unique identifier for the sustainability action record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients execute sustainability actions (e.g., energy retrofits); linking actions to the client account records actions per client.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Sustainability actions (e.g., waste reduction) are assigned to specific scheduled activities for execution tracking and impact measurement.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Actions such as retrofitting or low‑emission upgrades are tied to the equipment being modified for traceability.',
    `remediation_action_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_action. Business justification: Sustainability actions frequently originate from corrective compliance actions; the link tracks that lineage.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal or external party accountable for executing the action.',
    `parent_sustainability_action_id` BIGINT COMMENT 'Self-referencing FK on sustainability_action (parent_sustainability_action_id)',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the regulatory or internal compliance requirement that drives the action.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the action.',
    `sustainability_plan_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_plan. Business justification: Sustainability actions are defined within a sustainability plan; linking actions to their plan provides hierarchy and enables plan‑level reporting.',
    `action_code` STRING COMMENT 'External business identifier or code assigned to the sustainability action.',
    `action_timestamp` TIMESTAMP COMMENT 'Date‑time when the sustainability action was initially recorded or logged.',
    `actual_completion_date` DATE COMMENT 'Date when the action was actually finished.',
    `actual_start_date` DATE COMMENT 'Date when the action actually began.',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Carbon intensity metric associated with the action, if applicable.',
    `carbon_reduction_tonnes` DECIMAL(18,2) COMMENT 'Estimated or measured amount of CO2e reduced as a result of the action.',
    `sustainability_action_category` STRING COMMENT 'Classification of the sustainability action into a primary focus area.. Valid values are `carbon_reduction|waste_diversion|biodiversity|social_value|energy_efficiency`',
    `cost_saving_amount` DECIMAL(18,2) COMMENT 'Monetary cost savings achieved by the action.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost saving amount.. Valid values are `^[A-Z]{3}$`',
    `sustainability_action_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and expected outcomes of the action.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Energy consumption impact (reduction or increase) associated with the action.',
    `evidence_url` STRING COMMENT 'Link to documentation, photos, or reports that verify completion of the action.',
    `is_regulatory` BOOLEAN COMMENT 'Indicates whether the action is mandated by a regulation (true) or voluntary (false).',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the action.',
    `origin` STRING COMMENT 'Source that triggered the creation of the sustainability action.. Valid values are `audit|assessment|regulatory|strategic`',
    `planned_completion_date` DATE COMMENT 'Target date by which the action should be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the action to commence.',
    `priority` STRING COMMENT 'Business priority assigned to the action.. Valid values are `low|medium|high|critical`',
    `regulatory_body` STRING COMMENT 'Governing authority or standard that requires the action.. Valid values are `OSHA|EPA|ISO9001|ISO14001|ISO45001|LEED`',
    `responsible_party_role` STRING COMMENT 'Role or function of the responsible party within the organization.. Valid values are `project_manager|site_supervisor|environment_officer|safety_officer`',
    `risk_assessment` STRING COMMENT 'Risk level assigned to the action based on potential impact or failure.. Valid values are `low|medium|high|critical`',
    `sustainability_action_status` STRING COMMENT 'Current lifecycle status of the sustainability action.. Valid values are `open|in_progress|closed|overdue|cancelled`',
    `title` STRING COMMENT 'Short descriptive title of the sustainability initiative or corrective action.',
    `waste_diverted_tons` DECIMAL(18,2) COMMENT 'Quantity of waste material diverted from landfill as a result of the action.',
    `water_usage_cubic_meters` DECIMAL(18,2) COMMENT 'Volume of water saved or consumed due to the action.',
    CONSTRAINT pk_sustainability_action PRIMARY KEY(`sustainability_action_id`)
) COMMENT 'Transactional record of a specific sustainability initiative or corrective action committed to within a sustainability plan or arising from an audit, assessment, or regulatory obligation. Captures action title, action category (carbon reduction, waste diversion, biodiversity, social value, energy efficiency), responsible party, planned completion date, actual completion date, status (open/in-progress/closed/overdue), evidence of completion, and carbon/cost saving achieved. [SSOT: distinct source of truth for sustainability domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` (
    `biodiversity_assessment_id` BIGINT COMMENT 'Unique identifier for each biodiversity assessment record.',
    `baseline_biodiversity_assessment_id` BIGINT COMMENT 'Self-referencing FK on biodiversity_assessment (baseline_biodiversity_assessment_id)',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the assessment.',
    `approval_date` DATE COMMENT 'Date when statutory approval was granted.',
    `approved_by` STRING COMMENT 'Name of the authority or person who approved the assessment.',
    `assessment_date` DATE COMMENT 'Date when the assessment was conducted.',
    `assessment_status` STRING COMMENT 'Current workflow status of the assessment.. Valid values are `draft|submitted|approved|rejected|closed`',
    `assessment_type` STRING COMMENT 'The type of biodiversity assessment performed.. Valid values are `Biodiversity Net Gain|Ecological Impact Assessment|Habitat Survey`',
    `baseline_habitat_condition` STRING COMMENT 'Description of habitat condition before construction.',
    `biodiversity_units_gained` DECIMAL(18,2) COMMENT 'Number of biodiversity units gained as a result of mitigation.',
    `biodiversity_units_lost` DECIMAL(18,2) COMMENT 'Number of biodiversity units lost due to project impacts.',
    `biodiversity_units_per_ha` DECIMAL(18,2) COMMENT 'Biodiversity units calculated per hectare of habitat.',
    `climate_risk_assessment` BOOLEAN COMMENT 'Indicates whether a climate risk assessment was performed.',
    `compliance_requirements_met` STRING COMMENT 'Whether all statutory biodiversity compliance requirements were met.. Valid values are `yes|no|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall data quality for this assessment.. Valid values are `high|medium|low|unknown`',
    `data_source` STRING COMMENT 'System or organization that provided the raw assessment data.',
    `external_reference_code` STRING COMMENT 'Identifier linking to external regulatory or reporting system.',
    `green_building_certification` STRING COMMENT 'Applicable green building certification(s) for the project.. Valid values are `LEED|BREEAM|HQE|None`',
    `habitat_area_ha` DECIMAL(18,2) COMMENT 'Total area of the habitat in hectares.',
    `habitat_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing habitat quality (e.g., 0‑1 scale).',
    `measurement_method` STRING COMMENT 'Methodology or protocol used to quantify biodiversity units.',
    `metric_framework` STRING COMMENT 'Framework used for calculating biodiversity units.. Valid values are `UK BNG|TNFD|Other`',
    `mitigation_hierarchy_applied` STRING COMMENT 'Description of mitigation steps applied (avoid, minimise, restore, offset).',
    `monitoring_end_date` DATE COMMENT 'Planned end date for biodiversity monitoring.',
    `monitoring_plan_required` BOOLEAN COMMENT 'Indicates if a post‑construction biodiversity monitoring plan is required.',
    `monitoring_start_date` DATE COMMENT 'Planned start date for biodiversity monitoring.',
    `monitoring_status` STRING COMMENT 'Current status of the biodiversity monitoring program.. Valid values are `not_started|in_progress|completed|deferred`',
    `net_biodiversity_units` DECIMAL(18,2) COMMENT 'Net biodiversity units (gained minus lost).',
    `notes` STRING COMMENT 'Additional comments or observations.',
    `post_construction_habitat_condition` STRING COMMENT 'Description of habitat condition after construction.',
    `protected_species_identified` STRING COMMENT 'Comma‑separated list of protected species found on site.',
    `review_date` DATE COMMENT 'Date of the most recent internal review.',
    `reviewer` STRING COMMENT 'Name of the person who performed the latest review.',
    `risk_assessment_summary` STRING COMMENT 'Brief summary of identified environmental risks.',
    `statutory_approval_status` STRING COMMENT 'Regulatory approval status for the assessment.. Valid values are `pending|approved|rejected|not_required`',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `verification_date` DATE COMMENT 'Date when verification was completed.',
    `verification_status` STRING COMMENT 'Whether the assessment data has been independently verified.. Valid values are `verified|unverified|pending`',
    `created_by` STRING COMMENT 'User or system that created the record.',
    CONSTRAINT pk_biodiversity_assessment PRIMARY KEY(`biodiversity_assessment_id`)
) COMMENT 'Master record for a biodiversity net gain (BNG) or ecological impact assessment conducted for a construction project. Captures assessment type (Biodiversity Net Gain, Ecological Impact Assessment, Habitat Survey), baseline habitat condition (pre-construction), post-construction habitat condition, biodiversity units gained or lost (per UK BNG metric or TNFD framework), protected species identified, mitigation hierarchy applied, and statutory approval status.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` (
    `social_value_record_id` BIGINT COMMENT 'Unique surrogate key for the social value record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this social value outcome.',
    `corrected_social_value_record_id` BIGINT COMMENT 'Self-referencing FK on social_value_record (corrected_social_value_record_id)',
    `social_value_record_category` STRING COMMENT 'Classification of the social value outcome (e.g., local employment, apprenticeships, SME spend, community investment, skills training, supply chain diversity).. Valid values are `local_employment|apprenticeships|sme_spend|community_investment|skills_training|supply_chain_diversity`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the social value record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetised value.. Valid values are `GBP|USD|EUR|JPY|AUD|CAD`',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall data quality assessment for this record.. Valid values are `high|medium|low`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the quantity delivered (e.g., people, hours, dollars, percent, units).. Valid values are `people|hours|dollars|percent|units`',
    `monetised_value` DECIMAL(18,2) COMMENT 'Monetary valuation of the social value outcome expressed in the specified currency.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the social value record.',
    `outcome_description` STRING COMMENT 'Narrative description of the social value outcome delivered.',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'Numeric amount of the social value delivered expressed in the measurement unit.',
    `record_code` STRING COMMENT 'Human‑readable business identifier for the social value record, used in reporting and client communications.. Valid values are `^SVR-d{4}-d{3}$`',
    `recorded_timestamp` TIMESTAMP COMMENT 'Date‑time when the social value outcome was recorded or observed.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for which the social value is measured.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for which the social value is measured.',
    `social_value_record_status` STRING COMMENT 'Current lifecycle status of the social value record.. Valid values are `draft|submitted|approved|rejected|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the social value record.',
    `verification_date` DATE COMMENT 'Date on which verification of the social value outcome was completed.',
    `verification_status` STRING COMMENT 'Indicates whether the social value outcome has been verified, and its verification state.. Valid values are `unverified|verified|pending`',
    `verified_by` STRING COMMENT 'Name or identifier of the person or entity that performed verification.',
    CONSTRAINT pk_social_value_record PRIMARY KEY(`social_value_record_id`)
) COMMENT 'Transactional record capturing social value outcomes delivered by a construction project or corporate program. Captures social value category (local employment, apprenticeships, SME spend, community investment, skills training, supply chain diversity), outcome description, measurement unit, quantity delivered, monetised social value (£ using TOMS or HACT framework), reporting period, and project reference. Supports PPN 06/20 social value reporting and client commitments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` (
    `supply_chain_carbon_id` BIGINT COMMENT 'Unique identifier for the supply chain carbon record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Supply‑chain Scope 3 emissions are reported at the client level; the FK ties emissions data to the owning client account.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract under which the supplier activity was performed.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the carbon data.',
    `corrected_supply_chain_carbon_id` BIGINT COMMENT 'Self-referencing FK on supply_chain_carbon (corrected_supply_chain_carbon_id)',
    `vendor_id` BIGINT COMMENT 'System identifier for the supplier entity.',
    `activity_quantity` DECIMAL(18,2) COMMENT 'Quantity of the activity (e.g., tonnes of material, kilometres travelled, kWh consumed).',
    `activity_unit` STRING COMMENT 'Unit of measure for the activity quantity.. Valid values are `tonne|km|kWh|m3|MJ`',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Calculated carbon intensity expressed as tonnes CO₂e per monetary unit of spend.',
    `collection_method` STRING COMMENT 'Method used to collect the carbon data from the supplier.. Valid values are `supplier_questionnaire|EPD|spend_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the spend amount.. Valid values are `^[A-Z]{3}$`',
    `data_quality_tier` STRING COMMENT 'Quality tier of the carbon data (primary measured, secondary spend‑based, or industry average).. Valid values are `primary|secondary|industry_average`',
    `data_source_system` STRING COMMENT 'Operational system that supplied the carbon data.. Valid values are `SAP_S4HANA|Procore|Custom`',
    `emission_factor` DECIMAL(18,2) COMMENT 'GHG emission factor applied to the activity (tCO2e per unit).',
    `emission_factor_source` STRING COMMENT 'Source of the emission factor (e.g., EPA, IPCC, GHG Protocol, or custom).. Valid values are `EPA|IPCC|GHG_Protocol|Custom`',
    `emission_factor_version` STRING COMMENT 'Version identifier of the emission factor used for calculation.',
    `geographic_region` STRING COMMENT 'Three‑letter country code representing the region where the activity occurred.. Valid values are `^[A-Z]{3}$`',
    `material_category` STRING COMMENT 'Classification of the material or service (e.g., steel, concrete, transport).',
    `measurement_method` STRING COMMENT 'Method used to obtain activity data (direct measurement, estimate, or model).. Valid values are `direct_measurement|estimated|modelled`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the carbon data.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for the carbon data.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for the carbon data.',
    `reporting_year` STRING COMMENT 'Calendar year in which the reporting period falls.',
    `scope3_tco2e` DECIMAL(18,2) COMMENT 'Calculated Scope 3 greenhouse gas emissions in metric tonnes of CO₂e for the record.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend with the supplier for the reported period, in the transaction currency.',
    `supplier_name` STRING COMMENT 'Legal name of the supplier providing the material or service.',
    `supply_chain_carbon_status` STRING COMMENT 'Current lifecycle status of the carbon record.. Valid values are `active|inactive|archived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `verification_date` DATE COMMENT 'Date on which verification was completed.',
    `verification_status` STRING COMMENT 'Status of third‑party verification of the carbon data.. Valid values are `verified|unverified|pending`',
    `verified_by` STRING COMMENT 'Name of the individual or organization that performed verification.',
    CONSTRAINT pk_supply_chain_carbon PRIMARY KEY(`supply_chain_carbon_id`)
) COMMENT 'Transactional record capturing Scope 3 supply chain carbon data collected from vendors, subcontractors, and material suppliers. Captures supplier name, material or service category, spend (£), activity data (tonnes, km, kWh), emission factor source, calculated Scope 3 tCO2e, data quality tier (primary measured, secondary spend-based, industry average), collection method (supplier questionnaire, EPD, spend-based), and reporting period. Supports GHG Protocol Scope 3 Category 1 and 4 disclosure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` (
    `sustainability_audit_id` BIGINT COMMENT 'Unique system-generated identifier for the sustainability audit record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients undergo sustainability audits; associating the audit record with the client account enables audit history per client.',
    `hr_employee_id` BIGINT COMMENT 'System identifier of the auditor or audit firm responsible for the audit.',
    `follow_up_sustainability_audit_id` BIGINT COMMENT 'Self-referencing FK on sustainability_audit (follow_up_sustainability_audit_id)',
    `iso_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.iso_audit. Business justification: Sustainability audits reference ISO audit outcomes to verify integrated management system compliance.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the audit applies.',
    `sustainability_site_construction_project_id` BIGINT COMMENT 'Identifier of the physical site or location covered by the audit.',
    `audit_date` DATE COMMENT 'Calendar date on which the audit was conducted or formally closed.',
    `audit_number` STRING COMMENT 'External audit reference number assigned by the audit management system.',
    `audit_scope` STRING COMMENT 'Narrative description of the audits functional, geographic, and project scope.',
    `audit_type` STRING COMMENT 'Indicates whether the audit is performed internally, by an external party, for a client, or by a third‑party auditor.. Valid values are `internal|external|client|third_party`',
    `auditor_contact_email` STRING COMMENT 'Primary email address for the auditor.',
    `auditor_name` STRING COMMENT 'Full legal name of the auditor or audit firm.',
    `auditor_organization` STRING COMMENT 'Name of the organization or firm performing the audit.',
    `carbon_emission_tonnes` DECIMAL(18,2) COMMENT 'Total greenhouse‑gas emissions measured in carbon‑dioxide‑equivalent tonnes.',
    `certification_reference` STRING COMMENT 'Reference to any ISO 14001 or other sustainability certification linked to the audit.',
    `climate_risk_assessment_summary` STRING COMMENT 'Brief summary of climate‑related risk findings identified during the audit.',
    `compliance_rating` STRING COMMENT 'Overall compliance assessment result of the audit.. Valid values are `compliant|non_compliant|partial`',
    `corrective_action_plan_reference` STRING COMMENT 'Reference code or identifier for the corrective action plan linked to this audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicates the assessed quality of the audit data.. Valid values are `high|medium|low`',
    `end_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the audit fieldwork concluded.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity or fuel energy consumed, expressed in megawatt‑hours.',
    `findings_major` STRING COMMENT 'Count of findings classified as major non‑conformities.',
    `findings_minor` STRING COMMENT 'Count of findings classified as minor non‑conformities.',
    `findings_observation` STRING COMMENT 'Count of observations (non‑conformities without corrective requirement).',
    `findings_opportunity` STRING COMMENT 'Count of improvement opportunities identified during the audit.',
    `findings_total` STRING COMMENT 'Total number of audit findings recorded.',
    `green_building_certification` STRING COMMENT 'Indicates any green building certification achieved for the project.. Valid values are `LEED|BREEAM|None`',
    `net_zero_commitment_status` STRING COMMENT 'Current status of the entitys net‑zero emissions commitment.. Valid values are `committed|in_progress|achieved|not_committed`',
    `net_zero_target_year` STRING COMMENT 'Calendar year by which net‑zero emissions are targeted.',
    `notes` STRING COMMENT 'Free‑form notes captured by the auditor.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) summarising overall compliance performance.',
    `regulatory_reporting_requirement` STRING COMMENT 'Regulatory reporting obligations applicable to the audit (e.g., OSHA, EPA).',
    `review_date` DATE COMMENT 'Date on which the audit findings were formally reviewed.',
    `reviewed_by` STRING COMMENT 'Name of the internal reviewer who validated the audit outcomes.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the audit fieldwork began.',
    `sustainability_audit_status` STRING COMMENT 'Current lifecycle state of the audit record.. Valid values are `pending|in_progress|completed|closed`',
    `sustainability_goals_aligned` BOOLEAN COMMENT 'Indicates whether the audited entity aligns with corporate sustainability goals.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `verification_date` DATE COMMENT 'Date on which the audit was externally verified.',
    `verification_status` STRING COMMENT 'Status of external verification of the audit results.. Valid values are `verified|unverified|pending`',
    `version` STRING COMMENT 'Version number of the audit record, incremented on each revision.',
    `waste_diversion_percentage` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill during the audit period.',
    `water_usage_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of water consumed on the audited site.',
    CONSTRAINT pk_sustainability_audit PRIMARY KEY(`sustainability_audit_id`)
) COMMENT 'Formal sustainability audit record assessing a projects or corporate entitys compliance with its sustainability plan, ISO 14001 EMS, and contractual sustainability commitments. Captures audit type (internal, external, client, third-party), audit scope, auditor details, audit date, findings count by severity (major NC, minor NC, observation, opportunity), overall compliance rating, and corrective action plan reference. Distinct from quality and safety audits.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`env_incident` (
    `env_incident_id` BIGINT COMMENT 'System-generated unique identifier for the environmental incident record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Environmental incidents are reported to regulators per client; linking incidents to the client account supports incident tracking per client.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Environmental incidents are often triggered by permit breaches; linking enables root‑cause analysis and reporting.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the incident.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Required for HSE incident reports to record the worker responsible for the incident, a standard safety investigation practice.',
    `root_cause_env_incident_id` BIGINT COMMENT 'Self-referencing FK on env_incident (root_cause_env_incident_id)',
    `site_mobilization_id` BIGINT COMMENT 'Foreign key linking to site.site_mobilization. Business justification: Environmental incident logs are required to reference the exact site where the incident occurred for regulatory notification and corrective action.',
    `closure_date` DATE COMMENT 'Date when the incident was formally closed after all actions completed.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `env_incident_description` STRING COMMENT 'Narrative description of what happened, including context and observations.',
    `env_incident_status` STRING COMMENT 'Current lifecycle status of the incident record.. Valid values are `open|investigating|closed|rejected`',
    `estimated_impact_amount` DECIMAL(18,2) COMMENT 'Quantified estimate of environmental impact (e.g., volume spilled).',
    `follow_up_actions` STRING COMMENT 'Planned follow‑up activities after initial response.',
    `immediate_response_actions` STRING COMMENT 'Actions taken immediately after the incident to contain or mitigate impact.',
    `impact_currency` STRING COMMENT 'Three‑letter ISO currency code for monetary impact, if applicable.. Valid values are `^[A-Z]{3}$`',
    `impact_unit` STRING COMMENT 'Unit of measure for the estimated impact amount.. Valid values are `kg_co2e|liters|cubic_meters|dB|count`',
    `incident_number` STRING COMMENT 'Business-visible identifier or ticket number assigned to the incident.',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the incident occurred.',
    `incident_type` STRING COMMENT 'Category of environmental incident (e.g., spill, pollution, dust exceedance).. Valid values are `spill|pollution|dust_exceedance|noise_complaint|species_disturbance|unauthorized_discharge`',
    `is_near_miss` BOOLEAN COMMENT 'True if the event was a near‑miss (no actual impact) but could have caused an incident.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the incident location.',
    `lessons_learned` STRING COMMENT 'Key learnings captured from the incident handling process.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the incident location.',
    `media_affected` STRING COMMENT 'Environmental media impacted by the incident.. Valid values are `land|water|air|soil`',
    `mitigation_status` STRING COMMENT 'Current status of mitigation actions for the incident.. Valid values are `planned|in_progress|completed|not_applicable`',
    `notification_date` DATE COMMENT 'Date when the regulatory authority was notified.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body notified (e.g., EPA, OSHA).',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the incident must be reported to a regulatory authority.',
    `reported_by_contact` STRING COMMENT 'Email address of the reporter for follow‑up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reported_by_name` STRING COMMENT 'Full name of the person who reported the incident.',
    `root_cause` STRING COMMENT 'Underlying cause identified for the incident.',
    `severity_category` STRING COMMENT 'Severity classification of the incident on a scale of 1 (most severe) to 4 (least severe).. Valid values are `category_1|category_2|category_3|category_4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_env_incident PRIMARY KEY(`env_incident_id`)
) COMMENT 'Transactional record of an environmental incident or near-miss event occurring on a construction site or at a corporate facility. Captures incident type (spill, pollution, dust exceedance, noise complaint, protected species disturbance, unauthorized discharge), severity classification (Category 1-4), affected media (land, water, air), regulatory notification requirement, immediate response actions taken, root cause, and regulatory authority notified. Distinct from safety.incident which covers HSE personal safety events.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` (
    `carbon_reduction_initiative_id` BIGINT COMMENT 'System-generated unique identifier for each carbon reduction initiative.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Clients sponsor carbon‑reduction initiatives; the FK captures which client is responsible for each initiative.',
    `asset_id` BIGINT COMMENT 'Identifier of a major asset (e.g., equipment, building) impacted by the initiative.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Carbon reduction initiatives are created to achieve a specific carbon reduction target; adding carbon_target_id creates a direct parent relationship and eliminates the need for ad‑hoc lookups.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the party (person or team) accountable for delivering the initiative.',
    `parent_carbon_reduction_initiative_id` BIGINT COMMENT 'Self-referencing FK on carbon_reduction_initiative (parent_carbon_reduction_initiative_id)',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the initiative is linked.',
    `actual_co2e_saving` DECIMAL(18,2) COMMENT 'Measured annual carbon dioxide equivalent reduction achieved, expressed in metric tonnes.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual amount spent to implement the initiative.',
    `actual_cost_currency` STRING COMMENT 'Currency of the actual cost amount.. Valid values are `USD|GBP|EUR|JPY|CAD|AUD`',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the initiative.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the initiative received formal approval.',
    `carbon_reduction_initiative_status` STRING COMMENT 'Current lifecycle status of the initiative.. Valid values are `proposed|approved|in_progress|completed|cancelled`',
    `carbon_reduction_methodology` STRING COMMENT 'Methodology or standard used to calculate carbon reductions (e.g., PAS 2080, ISO 14064).',
    `climate_risk_category` STRING COMMENT 'Categorisation of climate‑related risk exposure for the initiative.. Valid values are `low|medium|high|critical`',
    `compliance_standard` STRING COMMENT 'Applicable environmental or sustainability standard governing the initiative.. Valid values are `ISO_14001|PAS_2080|LEED|ISO_50001|ISO_14064|GHG_Protocol`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the implementation cost.. Valid values are `USD|GBP|EUR|JPY|CAD|AUD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the initiative record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the confidence level in the reported data.. Valid values are `high|medium|low|unknown`',
    `carbon_reduction_initiative_description` STRING COMMENT 'Detailed free‑text description of the initiatives objectives, scope, and approach.',
    `end_date` DATE COMMENT 'Planned or actual completion date of the initiative.',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total amount of funding allocated to the initiative.',
    `funding_currency` STRING COMMENT 'Currency of the funding amount.. Valid values are `USD|GBP|EUR|JPY|CAD|AUD`',
    `funding_source` STRING COMMENT 'Origin of the funds used for the initiative.. Valid values are `internal|external|grant|loan`',
    `implementation_cost` DECIMAL(18,2) COMMENT 'Capital cost required to implement the initiative.',
    `initiative_type` STRING COMMENT 'Category of the initiative, e.g., fuel switching, electrification, renewable energy procurement, low‑carbon concrete mix, modal shift in logistics, or building fabric improvement.. Valid values are `fuel_switching|electrification|renewable_energy|low_carbon_concrete|modal_shift|building_fabric_improvement`',
    `measurement_method` STRING COMMENT 'Method used to obtain carbon reduction figures.. Valid values are `direct|estimated|modelled`',
    `carbon_reduction_initiative_name` STRING COMMENT 'Descriptive name of the carbon reduction initiative.',
    `notes` STRING COMMENT 'Free‑form field for any supplementary information or comments.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated number of years required for the initiative to recoup its implementation cost through carbon savings.',
    `projected_annual_co2e_saving` DECIMAL(18,2) COMMENT 'Estimated annual carbon dioxide equivalent reduction expected from the initiative, expressed in metric tonnes.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for which savings are calculated.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for which savings are calculated.',
    `risk_assessment` STRING COMMENT 'Brief summary of identified risks and mitigation measures for the initiative.',
    `sponsor` STRING COMMENT 'Name of the internal business unit or executive champion sponsoring the initiative.',
    `start_date` DATE COMMENT 'Planned or actual start date of the initiative.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the initiative record.',
    `verification_date` DATE COMMENT 'Date on which verification was completed.',
    `verification_status` STRING COMMENT 'Status of third‑party verification of the reported savings.. Valid values are `verified|pending|rejected`',
    `verified_by` STRING COMMENT 'Name of the organization or auditor that performed verification.',
    CONSTRAINT pk_carbon_reduction_initiative PRIMARY KEY(`carbon_reduction_initiative_id`)
) COMMENT 'Master record for a discrete carbon reduction initiative or decarbonization project being implemented at project or corporate level. Captures initiative name, initiative type (fuel switching, electrification of plant, renewable energy procurement, low-carbon concrete mix, modal shift in logistics, building fabric improvement), projected annual CO2e saving (tCO2e), implementation cost (£), payback period, status (proposed/approved/in-progress/completed), and actual CO2e saving achieved. Supports PAS 2080 carbon management in infrastructure.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Primary key for emission_source',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - emission sources are typically project-scoped',
    `parent_emission_source_id` BIGINT COMMENT 'Self-referencing FK on emission_source (parent_emission_source_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `data_source_system` STRING COMMENT 'Originating operational system of record for the emission source data.',
    `default_emission_factor` DECIMAL(18,2) COMMENT 'Default emission factor (kg CO2e per unit activity) used when a specific factor is not provided.',
    `effective_from` DATE COMMENT 'Date when the emission source record becomes effective.',
    `effective_until` DATE COMMENT 'Date when the emission source record is no longer effective (if applicable).',
    `emission_source_status` STRING COMMENT 'Current lifecycle status of the emission source.',
    `greenhouse_gas` STRING COMMENT 'Primary greenhouse gas emitted by the source. [ENUM-REF-CANDIDATE: CO2|CH4|N2O|SF6|HFCs|PFCs|Other — promote to reference product]',
    `is_regulated` BOOLEAN COMMENT 'Indicates whether the emission source is subject to regulatory reporting requirements.',
    `emission_source_name` STRING COMMENT 'Human‑readable name of the emission source (e.g., Diesel Generator, Concrete Mix).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the emission source.',
    `region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the emission source is located.',
    `regulatory_framework` STRING COMMENT 'Regulatory regime governing reporting for this emission source.',
    `scope` STRING COMMENT 'GHG accounting scope applicable to the emission source.',
    `source_category` STRING COMMENT 'Classification of the emission source by activity type.',
    `source_code` STRING COMMENT 'External or industry code identifying the emission source.',
    `unit_of_measure` STRING COMMENT 'Measurement unit associated with the emission factor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_emission_source PRIMARY KEY(`emission_source_id`)
) COMMENT 'Master reference table for emission_source. Referenced by emission_source_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` (
    `waste_carrier_id` BIGINT COMMENT 'Primary key for waste_carrier',
    `account_id` BIGINT COMMENT 'add column account_id (BIGINT) with FK to client.account.account_id - waste carriers are external organizations',
    `parent_waste_carrier_id` BIGINT COMMENT 'Self-referencing FK on waste_carrier (parent_waste_carrier_id)',
    `address_line1` STRING COMMENT 'First line of the carriers street address.',
    `address_line2` STRING COMMENT 'Second line of the carriers street address (optional).',
    `audit_score` DECIMAL(18,2) COMMENT 'Numeric score resulting from the latest compliance audit (0‑100).',
    `average_response_time_minutes` STRING COMMENT 'Typical time from service request to carrier dispatch, in minutes.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for invoicing.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (optional).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country_code` STRING COMMENT 'Three‑letter ISO country code for the billing address.',
    `billing_postal_code` STRING COMMENT 'ZIP/postal code for the billing address.',
    `billing_state` STRING COMMENT 'State or province component of the billing address.',
    `capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Maximum amount of waste the carrier can move per day, expressed in metric tons.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions per ton of waste transported (kg CO₂/ton).',
    `carrier_type` STRING COMMENT 'Classification of the carrier based on ownership and business model.',
    `city` STRING COMMENT 'City where the carrier is located.',
    `compliance_status` STRING COMMENT 'Current compliance standing with environmental regulations.',
    `contract_end_date` DATE COMMENT 'Date when the service contract with the carrier expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'Date when the service contract with the carrier becomes effective.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the carriers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier record was first created.',
    `fleet_size` STRING COMMENT 'Number of vehicles owned or contracted for waste transport.',
    `insurance_expiry_date` DATE COMMENT 'Date when the carriers liability insurance expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number for liability insurance covering waste transport.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `license_number` STRING COMMENT 'Government‑issued license identifier authorizing waste transport.',
    `waste_carrier_name` STRING COMMENT 'Legal name of the waste carrier organization.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the carrier.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the carrier.',
    `permit_number` STRING COMMENT 'Regulatory permit number for handling specific waste categories.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the carriers primary address.',
    `primary_contact_email` STRING COMMENT 'Email address for the carriers primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the main point of contact for the carrier.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the carriers primary contact.',
    `rating_date` DATE COMMENT 'Date when the most recent rating was recorded.',
    `rating_score` DECIMAL(18,2) COMMENT 'Overall performance rating assigned by the organization (0‑5).',
    `region_served` STRING COMMENT 'Geographic region(s) where the carrier provides services.',
    `state` STRING COMMENT 'State or province of the carriers primary address.',
    `tax_number` STRING COMMENT 'Government tax identification number for the carrier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the carrier record.',
    `vehicle_type` STRING COMMENT 'Primary type of vehicles used by the carrier.',
    `waste_carrier_status` STRING COMMENT 'Current operational status of the carrier.',
    `waste_type_allowed` STRING COMMENT 'Comma‑separated list of waste categories the carrier is authorized to transport. [ENUM-REF-CANDIDATE: hazardous|medical|industrial|construction|organic|radioactive|e‑waste|asbestos — promote to reference product]',
    CONSTRAINT pk_waste_carrier PRIMARY KEY(`waste_carrier_id`)
) COMMENT 'Master reference table for waste_carrier. Referenced by carrier_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` (
    `disposal_facility_id` BIGINT COMMENT 'Primary key for disposal_facility',
    `account_id` BIGINT COMMENT 'add column account_id (BIGINT) with FK to client.account.account_id - disposal facilities are external organizations',
    `parent_disposal_facility_id` BIGINT COMMENT 'Self-referencing FK on disposal_facility (parent_disposal_facility_id)',
    `address_line1` STRING COMMENT 'First line of the facilitys street address.',
    `address_line2` STRING COMMENT 'Second line of the facilitys street address, if applicable.',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Maximum waste volume the facility can accept, expressed in metric tons.',
    `carbon_emission_kg_per_year` DECIMAL(18,2) COMMENT 'Total CO₂ equivalent emissions generated by the facility each year.',
    `certification` STRING COMMENT 'Environmental management certification held by the facility.',
    `certification_date` DATE COMMENT 'Date when the current certification was awarded.',
    `city` STRING COMMENT 'City where the facility is located.',
    `contact_email` STRING COMMENT 'Email address of the primary facility contact.',
    `contact_name` STRING COMMENT 'Name of the primary person responsible for facility communications.',
    `contact_phone` STRING COMMENT 'Phone number of the primary facility contact.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the facility resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the facility record was first created in the system.',
    `current_utilization_percent` DECIMAL(18,2) COMMENT 'Current usage of the facilitys capacity as a percentage.',
    `disposal_facility_description` STRING COMMENT 'Free‑text description of the facilitys capabilities and characteristics.',
    `disposal_facility_status` STRING COMMENT 'Current operational status of the disposal facility.',
    `effective_from` DATE COMMENT 'Date when the facility became operational or the record became effective.',
    `effective_until` DATE COMMENT 'Date when the facility ceased operation or the record is no longer effective (nullable).',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of an emergency at the facility.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `facility_code` STRING COMMENT 'External business code used to reference the facility in contracts and reports.',
    `facility_type` STRING COMMENT 'Category describing the primary waste handling capability of the facility.',
    `hazardous_material_handling` BOOLEAN COMMENT 'True if the facility is equipped and permitted to handle hazardous waste.',
    `landfill_gas_capture` BOOLEAN COMMENT 'Indicates whether the facility captures landfill gas for energy or flaring.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the facility (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the facility (decimal degrees).',
    `disposal_facility_name` STRING COMMENT 'Human‑readable name of the disposal facility.',
    `operating_hours` STRING COMMENT 'Standard daily operating hours (e.g., "08:00-17:00").',
    `owner_organization` STRING COMMENT 'Name of the organization that owns or operates the facility.',
    `permit_expiry_date` DATE COMMENT 'Date on which the primary permit expires.',
    `permit_number` STRING COMMENT 'Identifier of the primary operating permit.',
    `permits_required` STRING COMMENT 'List of regulatory permits the facility must maintain.',
    `postal_code` STRING COMMENT 'Postal code for the facility address.',
    `public_accessible` BOOLEAN COMMENT 'True if the facility allows public drop‑off of waste.',
    `regulatory_agency` STRING COMMENT 'Primary government agency overseeing the facilitys compliance.',
    `safety_incident_reporting` BOOLEAN COMMENT 'Indicates whether the facility reports safety incidents to regulatory bodies.',
    `state` STRING COMMENT 'State or province of the facility location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the facility record.',
    `waste_diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of incoming waste diverted from landfill to recycling or reuse.',
    `waste_processed_tons_year` DECIMAL(18,2) COMMENT 'Total amount of waste processed by the facility in a calendar year.',
    `waste_type_accepted` STRING COMMENT 'Categories of waste the facility is authorized to receive.',
    CONSTRAINT pk_disposal_facility PRIMARY KEY(`disposal_facility_id`)
) COMMENT 'Master reference table for disposal_facility. Referenced by disposal_facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_prior_esg_report_id` FOREIGN KEY (`prior_esg_report_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_restated_esg_disclosure_item_id` FOREIGN KEY (`restated_esg_disclosure_item_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`esg_disclosure_item`(`esg_disclosure_item_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_corrected_carbon_emission_id` FOREIGN KEY (`corrected_carbon_emission_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ADD CONSTRAINT `fk_sustainability_emission_factor_superseded_emission_factor_id` FOREIGN KEY (`superseded_emission_factor_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_superseded_carbon_target_id` FOREIGN KEY (`superseded_carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_retired_carbon_offset_id` FOREIGN KEY (`retired_carbon_offset_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_corrected_waste_record_id` FOREIGN KEY (`corrected_waste_record_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_disposal_facility_id` FOREIGN KEY (`disposal_facility_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`disposal_facility`(`disposal_facility_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_waste_carrier_id` FOREIGN KEY (`waste_carrier_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`waste_carrier`(`waste_carrier_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ADD CONSTRAINT `fk_sustainability_waste_target_superseded_waste_target_id` FOREIGN KEY (`superseded_waste_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`waste_target`(`waste_target_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ADD CONSTRAINT `fk_sustainability_green_certification_superseded_green_certification_id` FOREIGN KEY (`superseded_green_certification_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`green_certification`(`green_certification_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ADD CONSTRAINT `fk_sustainability_green_credit_parent_green_credit_id` FOREIGN KEY (`parent_green_credit_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`green_credit`(`green_credit_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_superseded_sustainable_material_id` FOREIGN KEY (`superseded_sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ADD CONSTRAINT `fk_sustainability_embodied_carbon_assessment_prior_embodied_carbon_assessment_id` FOREIGN KEY (`prior_embodied_carbon_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`(`embodied_carbon_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_corrected_energy_consumption_id` FOREIGN KEY (`corrected_energy_consumption_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`energy_consumption`(`energy_consumption_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_corrected_water_consumption_id` FOREIGN KEY (`corrected_water_consumption_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`water_consumption`(`water_consumption_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_prior_climate_risk_assessment_id` FOREIGN KEY (`prior_climate_risk_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_parent_climate_risk_item_id` FOREIGN KEY (`parent_climate_risk_item_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`climate_risk_item`(`climate_risk_item_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_superseded_sustainability_plan_id` FOREIGN KEY (`superseded_sustainability_plan_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_parent_sustainability_action_id` FOREIGN KEY (`parent_sustainability_action_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_action`(`sustainability_action_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_baseline_biodiversity_assessment_id` FOREIGN KEY (`baseline_biodiversity_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`biodiversity_assessment`(`biodiversity_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ADD CONSTRAINT `fk_sustainability_social_value_record_corrected_social_value_record_id` FOREIGN KEY (`corrected_social_value_record_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`social_value_record`(`social_value_record_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_corrected_supply_chain_carbon_id` FOREIGN KEY (`corrected_supply_chain_carbon_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`supply_chain_carbon`(`supply_chain_carbon_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_follow_up_sustainability_audit_id` FOREIGN KEY (`follow_up_sustainability_audit_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_audit`(`sustainability_audit_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_root_cause_env_incident_id` FOREIGN KEY (`root_cause_env_incident_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`env_incident`(`env_incident_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_parent_carbon_reduction_initiative_id` FOREIGN KEY (`parent_carbon_reduction_initiative_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative`(`carbon_reduction_initiative_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_parent_emission_source_id` FOREIGN KEY (`parent_emission_source_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ADD CONSTRAINT `fk_sustainability_waste_carrier_parent_waste_carrier_id` FOREIGN KEY (`parent_waste_carrier_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`waste_carrier`(`waste_carrier_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ADD CONSTRAINT `fk_sustainability_disposal_facility_parent_disposal_facility_id` FOREIGN KEY (`parent_disposal_facility_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`disposal_facility`(`disposal_facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`sustainability` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_construction_v1`.`sustainability` SET TAGS ('pii_domain' = 'sustainability');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` SET TAGS ('pii_subdomain' = 'esg_reporting');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `esg_report_id` SET TAGS ('pii_business_glossary_term' = 'ESG Report Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `prior_esg_report_id` SET TAGS ('pii_business_glossary_term' = 'Prior Esg Report Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `prior_esg_report_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `assurance_level` SET TAGS ('pii_business_glossary_term' = 'Assurance Level (ASSURANCE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `assurance_level` SET TAGS ('pii_value_regex' = 'Limited|Reasonable|None');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `auditor_report_url` SET TAGS ('pii_business_glossary_term' = 'Auditor Report URL (AUDITOR_URL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `carbon_intensity` SET TAGS ('pii_business_glossary_term' = 'Carbon Intensity (CARB_INTENSITY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `climate_risk_assessment_summary` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment Summary (CLIMATE_RISK)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `data_quality_assessment` SET TAGS ('pii_business_glossary_term' = 'Data Quality Assessment (DATA_QUALITY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `data_quality_assessment` SET TAGS ('pii_value_regex' = 'Pass|Fail|Conditional');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System (SOURCE_SYSTEM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `emission_reduction_target_percentage` SET TAGS ('pii_business_glossary_term' = 'Emission Reduction Target Percentage (REDUCTION_PCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `emission_reduction_target_year` SET TAGS ('pii_business_glossary_term' = 'Emission Reduction Target Year (REDUCTION_YEAR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('pii_business_glossary_term' = 'Energy Consumption (ENERGY_MWH)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `energy_intensity` SET TAGS ('pii_business_glossary_term' = 'Energy Intensity (ENERGY_INTENSITY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `external_verifier` SET TAGS ('pii_business_glossary_term' = 'External Verifier (VERIFIER)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `green_building_certifications` SET TAGS ('pii_business_glossary_term' = 'Green Building Certifications (GREEN_CERT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `net_zero_commitment_status` SET TAGS ('pii_business_glossary_term' = 'Net‑Zero Commitment Status (NET_ZERO_STATUS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `net_zero_commitment_status` SET TAGS ('pii_value_regex' = 'Committed|InProgress|Achieved|NotCommitted');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `net_zero_target_year` SET TAGS ('pii_business_glossary_term' = 'Net‑Zero Target Year (NET_ZERO_YEAR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date (PUB_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `publication_status` SET TAGS ('pii_business_glossary_term' = 'Publication Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `publication_status` SET TAGS ('pii_value_regex' = 'Draft|Submitted|Published|Withdrawn');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Requirement (REG_REQUIREMENT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('pii_business_glossary_term' = 'Renewable Energy Percentage (RENEWABLE_PCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Report Number (NUMBER)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `report_title` SET TAGS ('pii_business_glossary_term' = 'Report Title (TITLE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report URL (URL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `report_version` SET TAGS ('pii_business_glossary_term' = 'Report Version (VERSION)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `reporting_framework` SET TAGS ('pii_business_glossary_term' = 'Reporting Framework (FRAMEWORK)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `reporting_framework` SET TAGS ('pii_value_regex' = 'GRI|TCFD|SASB|CDP|UN_SDGS|Other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date (END_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date (START_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `scope_boundary` SET TAGS ('pii_business_glossary_term' = 'Scope Boundary (SCOPE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `scope_boundary` SET TAGS ('pii_value_regex' = 'Corporate|Project|Both');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date (SUBMIT_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `sustainability_goals_aligned` SET TAGS ('pii_business_glossary_term' = 'Sustainability Goals Aligned (GOALS_ALIGNED)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `total_emissions_scope1` SET TAGS ('pii_business_glossary_term' = 'Total Scope 1 Emissions (S1_EMISSIONS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `total_emissions_scope2` SET TAGS ('pii_business_glossary_term' = 'Total Scope 2 Emissions (S2_EMISSIONS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `total_emissions_scope3` SET TAGS ('pii_business_glossary_term' = 'Total Scope 3 Emissions (S3_EMISSIONS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date (VERIFY_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `waste_diverted_percentage` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Percentage (WASTE_DIVERTED_PCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `waste_diverted_tons` SET TAGS ('pii_business_glossary_term' = 'Waste Diverted (WASTE_DIVERTED)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `water_intensity` SET TAGS ('pii_business_glossary_term' = 'Water Intensity (WATER_INTENSITY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ALTER COLUMN `water_usage_cubic_meters` SET TAGS ('pii_business_glossary_term' = 'Water Usage (WATER_USAGE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` SET TAGS ('pii_subdomain' = 'esg_reporting');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `esg_disclosure_item_id` SET TAGS ('pii_business_glossary_term' = 'ESG Disclosure Item ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Related Asset ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `esg_report_id` SET TAGS ('pii_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `restated_esg_disclosure_item_id` SET TAGS ('pii_business_glossary_term' = 'Restated Esg Disclosure Item Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `restated_esg_disclosure_item_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `assurance_level` SET TAGS ('pii_business_glossary_term' = 'Assurance Level');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `assurance_level` SET TAGS ('pii_value_regex' = 'limited|reasonable|none');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `confidence_interval_high` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval High');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `confidence_interval_low` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval Low');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_collection_method` SET TAGS ('pii_value_regex' = 'direct_measurement|estimate|model|survey');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'high|medium|low|not_applicable');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `data_source` SET TAGS ('pii_value_regex' = 'internal|external|third_party');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `emission_scope` SET TAGS ('pii_business_glossary_term' = 'Emission Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `emission_scope` SET TAGS ('pii_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `energy_source` SET TAGS ('pii_business_glossary_term' = 'Energy Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `energy_source` SET TAGS ('pii_value_regex' = 'renewable|non_renewable|mixed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `esg_disclosure_item_status` SET TAGS ('pii_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `esg_disclosure_item_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `framework` SET TAGS ('pii_business_glossary_term' = 'Reporting Framework (e.g., GRI, SASB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `framework` SET TAGS ('pii_value_regex' = 'GRI|SASB|TCFD|CDP|ISSB');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `indicator_code` SET TAGS ('pii_business_glossary_term' = 'Indicator Code (e.g., GRI 305-1)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `indicator_name` SET TAGS ('pii_business_glossary_term' = 'Indicator Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `is_key_metric` SET TAGS ('pii_business_glossary_term' = 'Key Metric Indicator');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Methodology Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `monetary_value` SET TAGS ('pii_business_glossary_term' = 'Monetary Value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `narrative_commentary` SET TAGS ('pii_business_glossary_term' = 'Narrative Commentary');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `reported_value` SET TAGS ('pii_business_glossary_term' = 'Reported Value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `reporting_year` SET TAGS ('pii_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `restated` SET TAGS ('pii_business_glossary_term' = 'Restated Indicator');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `waste_type` SET TAGS ('pii_business_glossary_term' = 'Waste Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `waste_type` SET TAGS ('pii_value_regex' = 'hazardous|non_hazardous|recyclable|landfill');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ALTER COLUMN `water_source` SET TAGS ('pii_business_glossary_term' = 'Water Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_emission_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `corrected_carbon_emission_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Carbon Emission Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `corrected_carbon_emission_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_id` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_id` SET TAGS ('pii_business_glossary_term' = 'Emission Source Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `site_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Site Mobilization Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_quantity` SET TAGS ('pii_business_glossary_term' = 'Activity Quantity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_unit` SET TAGS ('pii_business_glossary_term' = 'Activity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_unit` SET TAGS ('pii_value_regex' = 'liter|kwh|tonne|km|kg');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `co2e_tonnes` SET TAGS ('pii_business_glossary_term' = 'CO₂e Emissions (tonnes)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Emission Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'direct_measurement|estimation|modeling');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Emission Record Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Emission Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `scope` SET TAGS ('pii_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `source_category` SET TAGS ('pii_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `source_category` SET TAGS ('pii_value_regex' = 'direct_combustion|purchased_electricity|supply_chain|waste|transport');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `source_type` SET TAGS ('pii_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `source_type` SET TAGS ('pii_value_regex' = 'diesel_generator|concrete_batching|fleet_vehicle|grid_electricity|material_transport|equipment_operation');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'unverified|verified|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `emission_factor_id` SET TAGS ('pii_business_glossary_term' = 'Emission Factor ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `superseded_emission_factor_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Emission Factor Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `superseded_emission_factor_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_fuel_category` SET TAGS ('pii_business_glossary_term' = 'Applicable Fuel Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_fuel_category` SET TAGS ('pii_value_regex' = 'liquid|gas|solid|electric|bio');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Project Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_value_regex' = 'infrastructure|residential|commercial|industrial|energy|transport');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_sector` SET TAGS ('pii_business_glossary_term' = 'Applicable Sector');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `applicable_sector` SET TAGS ('pii_value_regex' = 'construction|energy|manufacturing|transport|agriculture');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `confidence_level` SET TAGS ('pii_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `confidence_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `expiration_reason` SET TAGS ('pii_business_glossary_term' = 'Expiration Reason');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `factor_name` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `factor_precision` SET TAGS ('pii_business_glossary_term' = 'Factor Precision');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `factor_value` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `fuel_type` SET TAGS ('pii_business_glossary_term' = 'Fuel or Material Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = 'global|regional|country|state|city');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `gwp_basis` SET TAGS ('pii_business_glossary_term' = 'Global Warming Potential Basis');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `gwp_basis` SET TAGS ('pii_value_regex' = 'AR4|AR5|AR6');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `is_deprecated` SET TAGS ('pii_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'direct|modelled|default|estimated');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `regulatory_standard` SET TAGS ('pii_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'IPCC|DEFRA|EPA|National Grid');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `source_document_reference` SET TAGS ('pii_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg_co2e_per_litre|kg_co2e_per_kwh|kg_co2e_per_tonne');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `superseded_carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Carbon Target Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `superseded_carbon_target_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `alignment_paris_pathway` SET TAGS ('pii_business_glossary_term' = 'Paris Agreement Alignment Pathway');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `alignment_paris_pathway` SET TAGS ('pii_value_regex' = '1.5C|2C|net_zero_pathway');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `baseline_emissions_tco2e` SET TAGS ('pii_business_glossary_term' = 'Baseline Emissions (tCO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `baseline_year` SET TAGS ('pii_business_glossary_term' = 'Baseline Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `interim_milestones` SET TAGS ('pii_business_glossary_term' = 'Interim Milestones');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|completed|retired');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_validation_status` SET TAGS ('pii_business_glossary_term' = 'Science‑Based Targets initiative Validation Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_validation_status` SET TAGS ('pii_value_regex' = 'validated|pending|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_code` SET TAGS ('pii_business_glossary_term' = 'Target Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_description` SET TAGS ('pii_business_glossary_term' = 'Target Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_intensity_unit` SET TAGS ('pii_business_glossary_term' = 'Target Intensity Unit');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_intensity_unit` SET TAGS ('pii_value_regex' = 'tco2e_per_mwh|tco2e_per_ton|tco2e_per_sqft');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_intensity_value` SET TAGS ('pii_business_glossary_term' = 'Target Intensity Value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_reduction_pct` SET TAGS ('pii_business_glossary_term' = 'Target Reduction Percentage');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_scope` SET TAGS ('pii_business_glossary_term' = 'Target Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_scope` SET TAGS ('pii_value_regex' = 'scope1|scope2|scope3|scope1_2|scope1_2_3');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_type` SET TAGS ('pii_business_glossary_term' = 'Target Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_type` SET TAGS ('pii_value_regex' = 'absolute_reduction|intensity_based|net_zero|science_based_target');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_units` SET TAGS ('pii_business_glossary_term' = 'Target Units');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_value_tco2e` SET TAGS ('pii_business_glossary_term' = 'Target Emissions Value (tCO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `target_year` SET TAGS ('pii_business_glossary_term' = 'Target Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Transaction ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retired_carbon_offset_id` SET TAGS ('pii_business_glossary_term' = 'Retired Carbon Offset Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retired_carbon_offset_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Transaction Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('pii_value_regex' = 'pending|active|retired|cancelled');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_type` SET TAGS ('pii_business_glossary_term' = 'Carbon Credit Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_type` SET TAGS ('pii_value_regex' = 'reforestation|renewable_energy|methane_capture|soil_sequestration|energy_efficiency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `esg_report_period` SET TAGS ('pii_business_glossary_term' = 'ESG Report Period');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `is_retired` SET TAGS ('pii_business_glossary_term' = 'Is Retired Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_reference` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Transaction Reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_standard` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Standard');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_standard` SET TAGS ('pii_value_regex' = 'Gold Standard|VCS|Verra|ACR');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('pii_business_glossary_term' = 'Project Country Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_name` SET TAGS ('pii_business_glossary_term' = 'Offset Project Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `project_region` SET TAGS ('pii_business_glossary_term' = 'Project Region');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_price_usd` SET TAGS ('pii_business_glossary_term' = 'Purchase Price (USD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `quantity_tco2e` SET TAGS ('pii_business_glossary_term' = 'Quantity of CO2e (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `registry_name` SET TAGS ('pii_business_glossary_term' = 'Registry Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `registry_serial_number` SET TAGS ('pii_business_glossary_term' = 'Registry Serial Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('pii_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('pii_value_regex' = 'voluntary|regulatory|contractual');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `transaction_timestamp` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Transaction Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_body` SET TAGS ('pii_business_glossary_term' = 'Verification Body');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('pii_business_glossary_term' = 'Vintage Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` SET TAGS ('pii_subdomain' = 'waste_environmental');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_id` SET TAGS ('pii_business_glossary_term' = 'Waste Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `corrected_waste_record_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Waste Record Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `corrected_waste_record_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `disposal_facility_id` SET TAGS ('pii_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `site_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Site Mobilization Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_carrier_id` SET TAGS ('pii_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Disposal Cost Amount');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `disposal_route` SET TAGS ('pii_business_glossary_term' = 'Disposal Route');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `disposal_route` SET TAGS ('pii_value_regex' = 'landfill|recycling|reuse|energy_recovery|incineration');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `diversion_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Diversion Rate Percent');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `epa_waste_code` SET TAGS ('pii_business_glossary_term' = 'EPA Waste Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Waste Generation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `hazardous_flag` SET TAGS ('pii_business_glossary_term' = 'Hazardous Waste Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Waste Record Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'tonnes|cubic_meters');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_category` SET TAGS ('pii_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_category` SET TAGS ('pii_value_regex' = 'inert|non_inert|hazardous|recyclable|organic');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_description` SET TAGS ('pii_business_glossary_term' = 'Waste Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_number` SET TAGS ('pii_business_glossary_term' = 'Waste Record Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_status` SET TAGS ('pii_business_glossary_term' = 'Waste Record Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_status` SET TAGS ('pii_value_regex' = 'recorded|verified|billed|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_source` SET TAGS ('pii_business_glossary_term' = 'Waste Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_source` SET TAGS ('pii_value_regex' = 'demolition|construction|renovation|maintenance|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_type` SET TAGS ('pii_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_type` SET TAGS ('pii_value_regex' = 'concrete|steel|timber|hazardous|packaging|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` SET TAGS ('pii_subdomain' = 'waste_environmental');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `waste_target_id` SET TAGS ('pii_business_glossary_term' = 'Waste Target ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Associated Project ID (PID)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `superseded_waste_target_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Waste Target Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `superseded_waste_target_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `actual_diversion_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Actual Waste Diversion Rate Percentage (AWDR%)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `actual_landfill_diversion_tonnes` SET TAGS ('pii_business_glossary_term' = 'Actual Landfill Diversion (Tonnes) (ALD_T)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `actual_waste_intensity_kg_per_million_revenue` SET TAGS ('pii_business_glossary_term' = 'Actual Waste Intensity per Million Revenue (kg/£M) (AWI_MR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `actual_waste_intensity_kg_per_sqm` SET TAGS ('pii_business_glossary_term' = 'Actual Waste Intensity per Square Meter (kg/m²) (AWI_SQM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By User (ABU)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `baseline_waste_intensity_kg_per_million_revenue` SET TAGS ('pii_business_glossary_term' = 'Baseline Waste Intensity per Million Revenue (kg/£M) (BWI_MR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `baseline_waste_intensity_kg_per_sqm` SET TAGS ('pii_business_glossary_term' = 'Baseline Waste Intensity per Square Meter (kg/m²) (BWI_SQM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency ISO Code (CIC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Target End Date (TED)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `is_public` SET TAGS ('pii_business_glossary_term' = 'Public Visibility Flag (PVF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `progress_status` SET TAGS ('pii_business_glossary_term' = 'Progress Tracking Status (PTS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `progress_status` SET TAGS ('pii_value_regex' = 'on_track|behind|ahead|not_started');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region ISO Country Code (RIC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `region_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency (RF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Target Start Date (TSD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Target Budget Amount (TBA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_code` SET TAGS ('pii_business_glossary_term' = 'Target Code (TC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_diversion_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Target Waste Diversion Rate Percentage (TWDR%)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_landfill_diversion_tonnes` SET TAGS ('pii_business_glossary_term' = 'Target Landfill Diversion (Tonnes) (TLD_T)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_period_years` SET TAGS ('pii_business_glossary_term' = 'Target Period (Years) (TPY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_type` SET TAGS ('pii_business_glossary_term' = 'Target Type (TT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `target_type` SET TAGS ('pii_value_regex' = 'zero_waste|circular_economy|reduction|diversion');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `waste_management_strategy` SET TAGS ('pii_business_glossary_term' = 'Waste Management Strategy Type (WMST)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `waste_management_strategy` SET TAGS ('pii_value_regex' = 'zero_waste_to_landfill|circular_economy|recycling_first|composting');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `waste_target_status` SET TAGS ('pii_business_glossary_term' = 'Target Lifecycle Status (TLS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `waste_target_status` SET TAGS ('pii_value_regex' = 'draft|active|completed|cancelled|expired');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User (CBU)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `green_certification_id` SET TAGS ('pii_business_glossary_term' = 'Green Certification ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID (PROJECT_ID)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `superseded_green_certification_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Green Certification Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `superseded_green_certification_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `achieved_rating` SET TAGS ('pii_business_glossary_term' = 'Achieved Rating (ACHIEVED_RATING)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_email` SET TAGS ('pii_business_glossary_term' = 'Assessor Email (ASSESSOR_EMAIL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Name (ASSESSOR_NAME)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `assessor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `carbon_reduction_amount` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Amount (CARB_REDUC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `carbon_reduction_unit` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Unit (CARB_UNIT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `carbon_reduction_unit` SET TAGS ('pii_value_regex' = 'tCO2e');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number (CERT_NO)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certification_body` SET TAGS ('pii_business_glossary_term' = 'Certification Body (BODY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certification_cost` SET TAGS ('pii_business_glossary_term' = 'Certification Cost (COST)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certification_scheme` SET TAGS ('pii_business_glossary_term' = 'Certification Scheme (SCHEME)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `certification_status` SET TAGS ('pii_value_regex' = 'pending|active|expired|revoked');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `cost_currency` SET TAGS ('pii_business_glossary_term' = 'Cost Currency (CURRENCY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `cost_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `documentation_url` SET TAGS ('pii_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date (EXPIRY_DT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `rating_date` SET TAGS ('pii_business_glossary_term' = 'Rating Date (RATING_DT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `registered_date` SET TAGS ('pii_business_glossary_term' = 'Registered Date (REG_DT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `sustainable_material_pct` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Percentage (SUST_MAT_PCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `target_rating_level` SET TAGS ('pii_business_glossary_term' = 'Target Rating Level (TARGET_RATING)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ALTER COLUMN `waste_diversion_pct` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Percentage (WASTE_DIV_PCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `green_credit_id` SET TAGS ('pii_business_glossary_term' = 'Green Credit ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Associated Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer User Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `parent_green_credit_id` SET TAGS ('pii_business_glossary_term' = 'Parent Green Credit Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `parent_green_credit_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `assessor_comment` SET TAGS ('pii_business_glossary_term' = 'Assessor Comment');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `certification_program` SET TAGS ('pii_business_glossary_term' = 'Certification Program (LEED, BREEAM, WELL, DGNB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `certification_program` SET TAGS ('pii_value_regex' = 'LEED|BREEAM|WELL|DGNB');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `certification_version` SET TAGS ('pii_business_glossary_term' = 'Certification Version');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status (Compliant, Non‑Compliant, Pending)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `credit_category` SET TAGS ('pii_business_glossary_term' = 'Green Credit Category (Energy, Water, Materials, Transport, Ecology, Innovation)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `credit_category` SET TAGS ('pii_value_regex' = 'energy|water|materials|transport|ecology|innovation');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `credit_code` SET TAGS ('pii_business_glossary_term' = 'Green Credit Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `credit_name` SET TAGS ('pii_business_glossary_term' = 'Green Credit Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `data_source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Source System of Record');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `data_source_system` SET TAGS ('pii_value_regex' = 'Procore|BIM360|SAP|Viewpoint|HCSS|Aconex');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Reference Document Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `green_credit_status` SET TAGS ('pii_business_glossary_term' = 'Green Credit Status (Targeted, Submitted, Awarded, Not Pursued, Rejected)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `green_credit_status` SET TAGS ('pii_value_regex' = 'targeted|submitted|awarded|not_pursued|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `is_verified` SET TAGS ('pii_business_glossary_term' = 'Verification Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `points_achieved` SET TAGS ('pii_business_glossary_term' = 'Achieved Points (ACHIEVED_PTS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `points_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Available Points (MAX_PTS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `points_targeted` SET TAGS ('pii_business_glossary_term' = 'Targeted Points (TARGET_PTS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region ISO 3166‑1 Alpha‑3 Country Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `region` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level (Low, Medium, High)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By User Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method (Document, Site Visit, Third Party, Self)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'document|site_visit|third_party|self');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'EPD Document ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `superseded_sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Sustainable Material Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `superseded_sustainable_material_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Project Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_value_regex' = 'residential|commercial|infrastructure|industrial|energy|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `certification_reference` SET TAGS ('pii_business_glossary_term' = 'Certification Reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CNY|Other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `date_approved` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `date_deprecated` SET TAGS ('pii_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `density_kg_per_m3` SET TAGS ('pii_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainable_material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `embodied_carbon_kg_per_kg` SET TAGS ('pii_business_glossary_term' = 'Embodied Carbon (kg CO₂e/kg)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `environmental_impact_score` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `epd_url` SET TAGS ('pii_business_glossary_term' = 'EPD URL');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `health_safety_rating` SET TAGS ('pii_business_glossary_term' = 'Health & Safety Rating');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `health_safety_rating` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `health_safety_rating` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `health_safety_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `is_approved` SET TAGS ('pii_business_glossary_term' = 'Is Approved Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `last_verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `material_category` SET TAGS ('pii_value_regex' = 'recycled|renewable|virgin|low_carbon|bio_based|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `material_name` SET TAGS ('pii_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `recycled_content_percent` SET TAGS ('pii_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `regulatory_approval_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `renewable_energy_content_percent` SET TAGS ('pii_business_glossary_term' = 'Renewable Energy Content Percentage');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `source_of_material` SET TAGS ('pii_business_glossary_term' = 'Source of Material');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `source_of_material` SET TAGS ('pii_value_regex' = 'virgin|reclaimed|recycled|bio_based|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `supplier_country_code` SET TAGS ('pii_business_glossary_term' = 'Supplier Country Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `supplier_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainable_certification` SET TAGS ('pii_business_glossary_term' = 'Sustainable Certification');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainable_certification` SET TAGS ('pii_value_regex' = 'FSC|PEFC|BES6001|ISO14001|LEED|None');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `total_embodied_carbon_kg` SET TAGS ('pii_business_glossary_term' = 'Total Embodied Carbon (kg CO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `transport_distance_km` SET TAGS ('pii_business_glossary_term' = 'Transport Distance (km)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'truck|rail|ship|air|pipeline|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|lb|ft3');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ALTER COLUMN `waste_diversion_percent` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Percentage');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `embodied_carbon_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Embodied Carbon Assessment ID (ECA_ID)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID (PID)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `prior_embodied_carbon_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Embodied Carbon Assessment Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `prior_embodied_carbon_assessment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_approval_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Approval Date (APP_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_approved_by` SET TAGS ('pii_business_glossary_term' = 'Assessment Approved By (APP_BY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_author` SET TAGS ('pii_business_glossary_term' = 'Assessment Author (AAUTH)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code (ACODE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('pii_business_glossary_term' = 'Assessment Notes (ANOTES)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status (ASTATUS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'draft|in_review|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assessment Timestamp (ATIME)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_tool` SET TAGS ('pii_business_glossary_term' = 'Assessment Tool (TOOL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_tool` SET TAGS ('pii_value_regex' = 'One_Click_LCA|Tally|EC3|SimaPro|GaBi');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `assessment_version` SET TAGS ('pii_business_glossary_term' = 'Assessment Version (AV)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `benchmark_comparison` SET TAGS ('pii_business_glossary_term' = 'Benchmark Comparison (BENCH_CMP)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `benchmark_comparison` SET TAGS ('pii_value_regex' = 'above|below|equal|not_applicable');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `benchmark_reference` SET TAGS ('pii_business_glossary_term' = 'Benchmark Reference (BENCH_REF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `biogenic_carbon_tco2e` SET TAGS ('pii_business_glossary_term' = 'Biogenic Carbon (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `carbon_boundary` SET TAGS ('pii_business_glossary_term' = 'Carbon Boundary (CB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `carbon_boundary` SET TAGS ('pii_value_regex' = 'cradle_to_gate|cradle_to_grave|cradle_to_care');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `carbon_intensity_kg_per_m3` SET TAGS ('pii_business_glossary_term' = 'Carbon Intensity (kgCO2e/m³) (CI)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `carbon_offset_used` SET TAGS ('pii_business_glossary_term' = 'Carbon Offset Used (OFFSET)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `confidence_level` SET TAGS ('pii_business_glossary_term' = 'Confidence Level (CONF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `confidence_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System (DSS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `data_source_system` SET TAGS ('pii_value_regex' = 'SAP_S4HANA|Procore|BIM_360|Custom');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `end_of_life_carbon_tco2e` SET TAGS ('pii_business_glossary_term' = 'End‑of‑Life Carbon (C1‑C4) (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `is_verified` SET TAGS ('pii_business_glossary_term' = 'Verification Flag (VERIFIED)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Assessment Methodology (METH)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `methodology` SET TAGS ('pii_value_regex' = 'EN_15978|RICS_WLCA|ISO_14064|custom');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `offset_provider` SET TAGS ('pii_business_glossary_term' = 'Offset Provider (OFFSET_PROV)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `offset_quantity_tco2e` SET TAGS ('pii_business_glossary_term' = 'Offset Quantity (tCO2e) (OFFSET_QTY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `operational_carbon_tco2e` SET TAGS ('pii_business_glossary_term' = 'Operational Carbon (B6) (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (REG_FLAG)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `related_project_phase` SET TAGS ('pii_business_glossary_term' = 'Related Project Phase (PROJ_PHASE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `related_project_phase` SET TAGS ('pii_value_regex' = 'design|construction|operation|maintenance');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `renewable_material_percentage` SET TAGS ('pii_business_glossary_term' = 'Renewable Material Percentage (%) (RMP)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `riba_stage` SET TAGS ('pii_business_glossary_term' = 'RIBA Stage (RIBA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `riba_stage` SET TAGS ('pii_value_regex' = 'stage_2|stage_3|stage_4|stage_5|stage_6|stage_7');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Carbon Scope (CSCOPE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `scope` SET TAGS ('pii_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `total_embodied_carbon_tco2e` SET TAGS ('pii_business_glossary_term' = 'Total Embodied Carbon (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `upfront_carbon_tco2e` SET TAGS ('pii_business_glossary_term' = 'Up‑Front Carbon (A1‑A5) (tCO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `verification_body` SET TAGS ('pii_business_glossary_term' = 'Verification Body (VER_BODY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date (VER_DATE)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ALTER COLUMN `waste_diversion_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Rate (%) (WDR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('pii_business_glossary_term' = 'Energy Consumption Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `corrected_energy_consumption_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Energy Consumption Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `corrected_energy_consumption_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `site_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Site Mobilization Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `carbon_emission_factor` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Factor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `carbon_emission_kg` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission (kg)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `consumption_quantity` SET TAGS ('pii_business_glossary_term' = 'Energy Consumption Quantity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_status` SET TAGS ('pii_value_regex' = 'recorded|estimated|corrected|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_intensity` SET TAGS ('pii_business_glossary_term' = 'Energy Intensity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_type` SET TAGS ('pii_business_glossary_term' = 'Energy Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_type` SET TAGS ('pii_value_regex' = 'diesel|electricity|natural_gas|lpg|renewable|other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `is_estimated` SET TAGS ('pii_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_timestamp` SET TAGS ('pii_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `meter_number` SET TAGS ('pii_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `metering_source` SET TAGS ('pii_business_glossary_term' = 'Metering Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `metering_source` SET TAGS ('pii_value_regex' = 'smart_meter|fuel_dip|invoice|manual_entry');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `recorded_by` SET TAGS ('pii_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kWh|MWh|GJ|litre|kg|BTU');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_consumption_id` SET TAGS ('pii_business_glossary_term' = 'Water Consumption Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `corrected_water_consumption_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Water Consumption Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `corrected_water_consumption_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `carbon_footprint_kg` SET TAGS ('pii_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `consumption_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Consumption Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_destination` SET TAGS ('pii_business_glossary_term' = 'Discharge Destination');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_destination` SET TAGS ('pii_value_regex' = 'sewer|watercourse|on_site_treatment|reused');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `discharge_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Discharge Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `metering_method` SET TAGS ('pii_business_glossary_term' = 'Metering Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `metering_method` SET TAGS ('pii_value_regex' = 'manual|automated|estimated');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `reading_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `recorded_by` SET TAGS ('pii_business_glossary_term' = 'Recorded By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_source_type` SET TAGS ('pii_business_glossary_term' = 'Water Source Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_source_type` SET TAGS ('pii_value_regex' = 'mains|borehole|recycled|rainwater|greywater');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_stress_area_classification` SET TAGS ('pii_business_glossary_term' = 'Water Stress Area Classification');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ALTER COLUMN `water_stress_area_classification` SET TAGS ('pii_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `climate_risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `prior_climate_risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Climate Risk Assessment Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `prior_climate_risk_assessment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `adaptation_measure` SET TAGS ('pii_business_glossary_term' = 'Adaptation Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `assessment_name` SET TAGS ('pii_business_glossary_term' = 'Assessment Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'physical|transition|opportunity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `climate_risk_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `climate_risk_assessment_status` SET TAGS ('pii_value_regex' = 'draft|in_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `climate_scenario` SET TAGS ('pii_business_glossary_term' = 'Climate Scenario');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `climate_scenario` SET TAGS ('pii_value_regex' = 'rcp_2_6|rcp_4_5|rcp_8_5|iea_nze');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `confidence_level` SET TAGS ('pii_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `confidence_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `data_source` SET TAGS ('pii_value_regex' = 'internal_model|external_report|regulatory_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `emission_factor` SET TAGS ('pii_business_glossary_term' = 'Emission Factor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `financial_impact_estimate` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `is_strategic_priority` SET TAGS ('pii_business_glossary_term' = 'Strategic Priority Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `likelihood` SET TAGS ('pii_business_glossary_term' = 'Likelihood');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `likelihood` SET TAGS ('pii_value_regex' = 'very_low|low|moderate|high|very_high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `mitigation_action` SET TAGS ('pii_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `portfolio_code` SET TAGS ('pii_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region (ISO 3166‑3)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `region` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `regulatory_change_indicator` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Indicator');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'flooding|extreme_heat|water_scarcity|carbon_pricing|stranded_assets|regulatory_change');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `risk_subcategory` SET TAGS ('pii_business_glossary_term' = 'Risk Sub‑Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `sea_level_rise_estimate` SET TAGS ('pii_business_glossary_term' = 'Sea Level Rise Estimate');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `temperature_increase_estimate` SET TAGS ('pii_business_glossary_term' = 'Temperature Increase Estimate');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `time_horizon` SET TAGS ('pii_business_glossary_term' = 'Time Horizon');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `time_horizon` SET TAGS ('pii_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_risk_item_id` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Item ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Affected Asset ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Affected Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Risk Owner ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `parent_climate_risk_item_id` SET TAGS ('pii_business_glossary_term' = 'Parent Climate Risk Item Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `parent_climate_risk_item_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_risk_item_status` SET TAGS ('pii_business_glossary_term' = 'Risk Item Status (RIS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_risk_item_status` SET TAGS ('pii_value_regex' = 'identified|assessed|mitigated|closed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_scenario` SET TAGS ('pii_business_glossary_term' = 'Climate Scenario (CS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_scenario` SET TAGS ('pii_value_regex' = 'baseline|adverse|severe');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `climate_year` SET TAGS ('pii_business_glossary_term' = 'Climate Scenario Year (CY)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `exposure_level` SET TAGS ('pii_business_glossary_term' = 'Exposure Level (EL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `exposure_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `financial_exposure_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Exposure Amount (FEA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `financial_exposure_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Exposure Currency (FEC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `mitigation_action` SET TAGS ('pii_business_glossary_term' = 'Mitigation Action (MA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `mitigation_status` SET TAGS ('pii_business_glossary_term' = 'Mitigation Status (MS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `mitigation_status` SET TAGS ('pii_value_regex' = 'not_started|planned|in_progress|completed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `probability_rating` SET TAGS ('pii_business_glossary_term' = 'Probability Rating (PR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `probability_rating` SET TAGS ('pii_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (RRF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Rating (RRR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `risk_assessment_methodology` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Methodology (RAM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `risk_name` SET TAGS ('pii_business_glossary_term' = 'Risk Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `risk_type` SET TAGS ('pii_business_glossary_term' = 'Risk Type (RT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `risk_type` SET TAGS ('pii_value_regex' = 'risk|opportunity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `tcfd_category` SET TAGS ('pii_business_glossary_term' = 'TCFD Category (TCFD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `tcfd_category` SET TAGS ('pii_value_regex' = 'physical_acute|physical_chronic|transition_policy|transition_market|transition_technology');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `assessment_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `superseded_sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Sustainability Plan Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `superseded_sustainability_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `applicable_standards` SET TAGS ('pii_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `carbon_reduction_target_tonnes` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Target (tonnes CO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `data_source` SET TAGS ('pii_value_regex' = 'internal|external|sensor|third_party');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Plan Document URL');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `funding_source` SET TAGS ('pii_value_regex' = 'internal|grant|loan|equity|partner');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `green_building_certifications` SET TAGS ('pii_business_glossary_term' = 'Green Building Certifications');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `is_public` SET TAGS ('pii_business_glossary_term' = 'Is Public');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_category` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_category` SET TAGS ('pii_value_regex' = 'project|corporate|regional|global');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Type (Project Sustainability|Environmental Management|Social Value)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'project_sustainability|environmental_management|social_value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `renewable_energy_target_percent` SET TAGS ('pii_business_glossary_term' = 'Renewable Energy Target (%)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually|ad_hoc');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `review_frequency` SET TAGS ('pii_value_regex' = 'annual|biannual|quarterly|monthly');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `stakeholder_engagement_plan` SET TAGS ('pii_business_glossary_term' = 'Stakeholder Engagement Plan');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `sustainability_plan_status` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `sustainability_plan_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|closed|archived');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `target_year` SET TAGS ('pii_business_glossary_term' = 'Target Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'not_verified|verified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `waste_diversion_target_percent` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Target (%)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ALTER COLUMN `water_use_reduction_target_percent` SET TAGS ('pii_business_glossary_term' = 'Water Use Reduction Target (%)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_master' = 'compliance.compliance_action');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot' = 'sustainability.sustainability_action');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_scope' = 'sustainability');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_counterpart' = 'compliance.compliance_action');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Action ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `remediation_action_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Action Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `remediation_action_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `remediation_action_id` SET TAGS ('pii_ssot' = 'compliance.compliance_action');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `parent_sustainability_action_id` SET TAGS ('pii_business_glossary_term' = 'Parent Sustainability Action Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `parent_sustainability_action_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `action_code` SET TAGS ('pii_business_glossary_term' = 'Action Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `action_timestamp` SET TAGS ('pii_business_glossary_term' = 'Action Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `carbon_intensity` SET TAGS ('pii_business_glossary_term' = 'Carbon Intensity (tonnes CO2e per unit)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `carbon_reduction_tonnes` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction (tonnes CO2e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_category` SET TAGS ('pii_business_glossary_term' = 'Action Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_category` SET TAGS ('pii_value_regex' = 'carbon_reduction|waste_diversion|biodiversity|social_value|energy_efficiency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `cost_saving_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Saving Amount');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_description` SET TAGS ('pii_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('pii_business_glossary_term' = 'Energy Consumption (MWh)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `evidence_url` SET TAGS ('pii_business_glossary_term' = 'Evidence URL');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `is_regulatory` SET TAGS ('pii_business_glossary_term' = 'Regulatory Driven Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Action Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `origin` SET TAGS ('pii_business_glossary_term' = 'Action Origin');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `origin` SET TAGS ('pii_value_regex' = 'audit|assessment|regulatory|strategic');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `planned_completion_date` SET TAGS ('pii_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Action Priority');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'OSHA|EPA|ISO9001|ISO14001|ISO45001|LEED');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `responsible_party_role` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `responsible_party_role` SET TAGS ('pii_value_regex' = 'project_manager|site_supervisor|environment_officer|safety_officer');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `risk_assessment` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_status` SET TAGS ('pii_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `sustainability_action_status` SET TAGS ('pii_value_regex' = 'open|in_progress|closed|overdue|cancelled');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Action Title');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `waste_diverted_tons` SET TAGS ('pii_business_glossary_term' = 'Waste Diverted (tonnes)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ALTER COLUMN `water_usage_cubic_meters` SET TAGS ('pii_business_glossary_term' = 'Water Usage (cubic meters)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` SET TAGS ('pii_subdomain' = 'resource_stewardship');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `biodiversity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Biodiversity Assessment Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `baseline_biodiversity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Baseline Biodiversity Assessment Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `baseline_biodiversity_assessment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date (AD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status (AS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type (AT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'Biodiversity Net Gain|Ecological Impact Assessment|Habitat Survey');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `baseline_habitat_condition` SET TAGS ('pii_business_glossary_term' = 'Baseline Habitat Condition (BHC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `biodiversity_units_gained` SET TAGS ('pii_business_glossary_term' = 'Biodiversity Units Gained (BUG)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `biodiversity_units_lost` SET TAGS ('pii_business_glossary_term' = 'Biodiversity Units Lost (BUL)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `biodiversity_units_per_ha` SET TAGS ('pii_business_glossary_term' = 'Biodiversity Units per Hectare (BUPH)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `climate_risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment (CRA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met (CRM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_value_regex' = 'yes|no|partial');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag (DQF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source (DS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference ID (ERI)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `green_building_certification` SET TAGS ('pii_business_glossary_term' = 'Green Building Certification (GBC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `green_building_certification` SET TAGS ('pii_value_regex' = 'LEED|BREEAM|HQE|None');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `habitat_area_ha` SET TAGS ('pii_business_glossary_term' = 'Habitat Area (HA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `habitat_quality_score` SET TAGS ('pii_business_glossary_term' = 'Habitat Quality Score (HQS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method (MM)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `metric_framework` SET TAGS ('pii_business_glossary_term' = 'Metric Framework (MF)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `metric_framework` SET TAGS ('pii_value_regex' = 'UK BNG|TNFD|Other');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `mitigation_hierarchy_applied` SET TAGS ('pii_business_glossary_term' = 'Mitigation Hierarchy Applied (MHA)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `monitoring_end_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring End Date (MED)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `monitoring_plan_required` SET TAGS ('pii_business_glossary_term' = 'Monitoring Plan Required (MPR)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `monitoring_start_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring Start Date (MSD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `monitoring_status` SET TAGS ('pii_business_glossary_term' = 'Monitoring Status (MST)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `monitoring_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `net_biodiversity_units` SET TAGS ('pii_business_glossary_term' = 'Net Biodiversity Units (NBU)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (NT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `post_construction_habitat_condition` SET TAGS ('pii_business_glossary_term' = 'Post‑Construction Habitat Condition (PCHC)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `protected_species_identified` SET TAGS ('pii_business_glossary_term' = 'Protected Species Identified (PSI)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date (RD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `reviewer` SET TAGS ('pii_business_glossary_term' = 'Reviewer (RV)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `risk_assessment_summary` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Summary (RAS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `statutory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Statutory Approval Status (SAS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `statutory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By (UB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date (VD)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status (VS)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `social_value_record_id` SET TAGS ('pii_business_glossary_term' = 'Social Value Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `corrected_social_value_record_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Social Value Record Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `corrected_social_value_record_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `social_value_record_category` SET TAGS ('pii_business_glossary_term' = 'Social Value Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `social_value_record_category` SET TAGS ('pii_value_regex' = 'local_employment|apprenticeships|sme_spend|community_investment|skills_training|supply_chain_diversity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'GBP|USD|EUR|JPY|AUD|CAD');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `measurement_unit` SET TAGS ('pii_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `measurement_unit` SET TAGS ('pii_value_regex' = 'people|hours|dollars|percent|units');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `monetised_value` SET TAGS ('pii_business_glossary_term' = 'Monetised Value');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `outcome_description` SET TAGS ('pii_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `quantity_delivered` SET TAGS ('pii_business_glossary_term' = 'Quantity Delivered');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `record_code` SET TAGS ('pii_business_glossary_term' = 'Social Value Record Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `record_code` SET TAGS ('pii_value_regex' = '^SVR-d{4}-d{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `recorded_timestamp` SET TAGS ('pii_business_glossary_term' = 'Social Value Recorded Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `social_value_record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `social_value_record_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'unverified|verified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `supply_chain_carbon_id` SET TAGS ('pii_business_glossary_term' = 'Supply Chain Carbon Record ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `corrected_supply_chain_carbon_id` SET TAGS ('pii_business_glossary_term' = 'Corrected Supply Chain Carbon Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `corrected_supply_chain_carbon_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `activity_quantity` SET TAGS ('pii_business_glossary_term' = 'Activity Quantity');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `activity_unit` SET TAGS ('pii_business_glossary_term' = 'Activity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `activity_unit` SET TAGS ('pii_value_regex' = 'tonne|km|kWh|m3|MJ');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `carbon_intensity` SET TAGS ('pii_business_glossary_term' = 'Carbon Intensity (tCO2e per Currency Unit)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `collection_method` SET TAGS ('pii_value_regex' = 'supplier_questionnaire|EPD|spend_based');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `data_quality_tier` SET TAGS ('pii_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `data_quality_tier` SET TAGS ('pii_value_regex' = 'primary|secondary|industry_average');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Source System of Record');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `data_source_system` SET TAGS ('pii_value_regex' = 'SAP_S4HANA|Procore|Custom');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `emission_factor` SET TAGS ('pii_business_glossary_term' = 'Emission Factor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `emission_factor_source` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `emission_factor_source` SET TAGS ('pii_value_regex' = 'EPA|IPCC|GHG_Protocol|Custom');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `emission_factor_version` SET TAGS ('pii_business_glossary_term' = 'Emission Factor Version');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `geographic_region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `geographic_region` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material or Service Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'direct_measurement|estimated|modelled');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `reporting_year` SET TAGS ('pii_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `scope3_tco2e` SET TAGS ('pii_business_glossary_term' = 'Scope 3 CO2e Emissions');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `spend_amount` SET TAGS ('pii_business_glossary_term' = 'Spend Amount (Monetary)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `supply_chain_carbon_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `supply_chain_carbon_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By (Person)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verified_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ALTER COLUMN `verified_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` SET TAGS ('pii_subdomain' = 'social_impact');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `sustainability_audit_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Audit ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `follow_up_sustainability_audit_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Sustainability Audit Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `follow_up_sustainability_audit_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `iso_audit_id` SET TAGS ('pii_business_glossary_term' = 'Iso Audit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `sustainability_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'internal|external|client|third_party');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_business_glossary_term' = 'Auditor Contact Email');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `auditor_organization` SET TAGS ('pii_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `carbon_emission_tonnes` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission (tonnes CO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `certification_reference` SET TAGS ('pii_business_glossary_term' = 'Certification Reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `climate_risk_assessment_summary` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Assessment Summary');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `compliance_rating` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('pii_business_glossary_term' = 'Energy Consumption (MWh)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `findings_major` SET TAGS ('pii_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `findings_minor` SET TAGS ('pii_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `findings_observation` SET TAGS ('pii_business_glossary_term' = 'Observation Findings Count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `findings_opportunity` SET TAGS ('pii_business_glossary_term' = 'Opportunity Findings Count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `findings_total` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `green_building_certification` SET TAGS ('pii_business_glossary_term' = 'Green Building Certification');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `green_building_certification` SET TAGS ('pii_value_regex' = 'LEED|BREEAM|None');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `net_zero_commitment_status` SET TAGS ('pii_business_glossary_term' = 'Net Zero Commitment Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `net_zero_commitment_status` SET TAGS ('pii_value_regex' = 'committed|in_progress|achieved|not_committed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `net_zero_target_year` SET TAGS ('pii_business_glossary_term' = 'Net Zero Target Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `reviewed_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `reviewed_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `sustainability_audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `sustainability_audit_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `sustainability_goals_aligned` SET TAGS ('pii_business_glossary_term' = 'Sustainability Goals Aligned');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Audit Version');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `waste_diversion_percentage` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Percentage');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ALTER COLUMN `water_usage_cubic_meters` SET TAGS ('pii_business_glossary_term' = 'Water Usage (cubic meters)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` SET TAGS ('pii_subdomain' = 'waste_environmental');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `env_incident_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Incident ID');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `root_cause_env_incident_id` SET TAGS ('pii_business_glossary_term' = 'Root Cause Env Incident Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `root_cause_env_incident_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `site_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Site Mobilization Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `corrective_action_plan` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `env_incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `env_incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `env_incident_status` SET TAGS ('pii_value_regex' = 'open|investigating|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `estimated_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Impact Amount');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `follow_up_actions` SET TAGS ('pii_business_glossary_term' = 'Follow‑Up Actions');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('pii_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `impact_currency` SET TAGS ('pii_business_glossary_term' = 'Impact Currency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `impact_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `impact_unit` SET TAGS ('pii_business_glossary_term' = 'Impact Unit');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `impact_unit` SET TAGS ('pii_value_regex' = 'kg_co2e|liters|cubic_meters|dB|count');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('pii_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `incident_type` SET TAGS ('pii_value_regex' = 'spill|pollution|dust_exceedance|noise_complaint|species_disturbance|unauthorized_discharge');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `is_near_miss` SET TAGS ('pii_business_glossary_term' = 'Near Miss Indicator');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `media_affected` SET TAGS ('pii_business_glossary_term' = 'Media Affected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `media_affected` SET TAGS ('pii_value_regex' = 'land|water|air|soil');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `mitigation_status` SET TAGS ('pii_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `mitigation_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|not_applicable');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_contact` SET TAGS ('pii_business_glossary_term' = 'Reporter Contact Email');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_contact` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_contact` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_contact` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_business_glossary_term' = 'Reporter Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `severity_category` SET TAGS ('pii_business_glossary_term' = 'Severity Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `severity_category` SET TAGS ('pii_value_regex' = 'category_1|category_2|category_3|category_4');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Initiative Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Related Asset Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_target_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `parent_carbon_reduction_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Parent Carbon Reduction Initiative Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `parent_carbon_reduction_initiative_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `actual_co2e_saving` SET TAGS ('pii_business_glossary_term' = 'Actual Annual CO₂e Saving (tCO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `actual_cost_currency` SET TAGS ('pii_business_glossary_term' = 'Actual Cost Currency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `actual_cost_currency` SET TAGS ('pii_value_regex' = 'USD|GBP|EUR|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_initiative_status` SET TAGS ('pii_business_glossary_term' = 'Initiative Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_initiative_status` SET TAGS ('pii_value_regex' = 'proposed|approved|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_methodology` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Methodology');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `climate_risk_category` SET TAGS ('pii_business_glossary_term' = 'Climate Risk Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `climate_risk_category` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `compliance_standard` SET TAGS ('pii_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `compliance_standard` SET TAGS ('pii_value_regex' = 'ISO_14001|PAS_2080|LEED|ISO_50001|ISO_14064|GHG_Protocol');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `cost_currency` SET TAGS ('pii_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `cost_currency` SET TAGS ('pii_value_regex' = 'USD|GBP|EUR|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_initiative_description` SET TAGS ('pii_business_glossary_term' = 'Initiative Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Initiative End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `funding_amount` SET TAGS ('pii_business_glossary_term' = 'Funding Amount');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `funding_currency` SET TAGS ('pii_business_glossary_term' = 'Funding Currency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `funding_currency` SET TAGS ('pii_value_regex' = 'USD|GBP|EUR|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `funding_source` SET TAGS ('pii_value_regex' = 'internal|external|grant|loan');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `implementation_cost` SET TAGS ('pii_business_glossary_term' = 'Implementation Cost');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `initiative_type` SET TAGS ('pii_business_glossary_term' = 'Initiative Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `initiative_type` SET TAGS ('pii_value_regex' = 'fuel_switching|electrification|renewable_energy|low_carbon_concrete|modal_shift|building_fabric_improvement');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'direct|estimated|modelled');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `carbon_reduction_initiative_name` SET TAGS ('pii_business_glossary_term' = 'Initiative Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `payback_period_years` SET TAGS ('pii_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `projected_annual_co2e_saving` SET TAGS ('pii_business_glossary_term' = 'Projected Annual CO₂e Saving (tCO₂e)');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `risk_assessment` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `sponsor` SET TAGS ('pii_business_glossary_term' = 'Initiative Sponsor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Initiative Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|pending|rejected');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` SET TAGS ('pii_subdomain' = 'carbon_management');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('pii_business_glossary_term' = 'Emission Source Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `parent_emission_source_id` SET TAGS ('pii_business_glossary_term' = 'Parent Emission Source Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `parent_emission_source_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `default_emission_factor` SET TAGS ('pii_business_glossary_term' = 'Default Emission Factor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `emission_source_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `greenhouse_gas` SET TAGS ('pii_business_glossary_term' = 'Greenhouse Gas');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `is_regulated` SET TAGS ('pii_business_glossary_term' = 'Is Regulated');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `emission_source_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `regulatory_framework` SET TAGS ('pii_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `source_category` SET TAGS ('pii_business_glossary_term' = 'Source Category');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `source_code` SET TAGS ('pii_business_glossary_term' = 'Source Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` SET TAGS ('pii_subdomain' = 'waste_environmental');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `waste_carrier_id` SET TAGS ('pii_business_glossary_term' = 'Waste Carrier Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `parent_waste_carrier_id` SET TAGS ('pii_business_glossary_term' = 'Parent Waste Carrier Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `parent_waste_carrier_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `audit_score` SET TAGS ('pii_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `average_response_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Average Response Time Minutes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line1');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_city` SET TAGS ('pii_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_country_code` SET TAGS ('pii_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `billing_state` SET TAGS ('pii_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `capacity_tons_per_day` SET TAGS ('pii_business_glossary_term' = 'Capacity Tons Per Day');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `carbon_emission_factor` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Factor');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `carrier_type` SET TAGS ('pii_business_glossary_term' = 'Carrier Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `contract_start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `fleet_size` SET TAGS ('pii_business_glossary_term' = 'Fleet Size');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `waste_carrier_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `rating_date` SET TAGS ('pii_business_glossary_term' = 'Rating Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `rating_score` SET TAGS ('pii_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `region_served` SET TAGS ('pii_business_glossary_term' = 'Region Served');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `vehicle_type` SET TAGS ('pii_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `waste_carrier_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ALTER COLUMN `waste_type_allowed` SET TAGS ('pii_business_glossary_term' = 'Waste Type Allowed');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` SET TAGS ('pii_subdomain' = 'waste_environmental');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `disposal_facility_id` SET TAGS ('pii_business_glossary_term' = 'Disposal Facility Identifier');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `parent_disposal_facility_id` SET TAGS ('pii_business_glossary_term' = 'Parent Disposal Facility Id');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `parent_disposal_facility_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `capacity_tons` SET TAGS ('pii_business_glossary_term' = 'Capacity Tons');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `carbon_emission_kg_per_year` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission Kg Per Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `certification` SET TAGS ('pii_business_glossary_term' = 'Certification');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `country` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `current_utilization_percent` SET TAGS ('pii_business_glossary_term' = 'Current Utilization Percent');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `disposal_facility_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `disposal_facility_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `facility_code` SET TAGS ('pii_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `hazardous_material_handling` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Handling');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `landfill_gas_capture` SET TAGS ('pii_business_glossary_term' = 'Landfill Gas Capture');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `disposal_facility_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `owner_organization` SET TAGS ('pii_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `permit_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `permits_required` SET TAGS ('pii_business_glossary_term' = 'Permits Required');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `public_accessible` SET TAGS ('pii_business_glossary_term' = 'Public Accessible');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `regulatory_agency` SET TAGS ('pii_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `safety_incident_reporting` SET TAGS ('pii_business_glossary_term' = 'Safety Incident Reporting');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `waste_diversion_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Waste Diversion Rate Percent');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `waste_processed_tons_year` SET TAGS ('pii_business_glossary_term' = 'Waste Processed Tons Year');
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ALTER COLUMN `waste_type_accepted` SET TAGS ('pii_business_glossary_term' = 'Waste Type Accepted');
