-- Schema for Domain: sales | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`sales` COMMENT 'Sales pipeline, opportunities, quotes, design-win campaigns, NRE agreements, pricing, and customer contracts. Manages sales territories, account assignments, forecast accuracy, revenue targets by product family, end market, and geography. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the sales opportunity.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account linked to the opportunity.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing or design‑win campaign linked to the opportunity.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Opportunity Management process requires a primary contact person; linking to customer.contact enables accurate follow‑up and reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative owning the opportunity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - opportunities target specific technology nodes',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Opportunity pipeline dashboards aggregate by product family to forecast revenue.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Opportunity tracking for a specific chip design project is required for pipeline reporting and resource planning.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Opportunities are owned within a sales territory; FK replaces free‑text field for data integrity.',
    `competitive_landscape` STRING COMMENT 'Free‑text description of key competitors and market positioning for the opportunity.',
    `contract_end_date` DATE COMMENT 'Planned end or expiration date of the contract; nullable for open‑ended agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contract if the opportunity is won.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|pending|expired|terminated`',
    `contract_type` STRING COMMENT 'Nature of the contractual agreement associated with the opportunity.. Valid values are `nre|license|royalty|subscription`',
    `country_code` STRING COMMENT 'Three‑letter country code of the primary customer location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts (e.g., USD, EUR).',
    `end_market` STRING COMMENT 'Primary market segment the opportunity addresses.. Valid values are `automotive|mobile|ai|iot|computing|telecom`',
    `expected_close_date` DATE COMMENT 'Projected date when the opportunity is expected to be closed (won or lost).',
    `expected_discount_amount` DECIMAL(18,2) COMMENT 'Estimated discount or rebate amount applied to the gross revenue.',
    `expected_gross_amount` DECIMAL(18,2) COMMENT 'Projected gross revenue before discounts, taxes, or adjustments.',
    `expected_net_amount` DECIMAL(18,2) COMMENT 'Projected net revenue after discounts and adjustments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the opportunity record in the sales domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the opportunity record.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the opportunity, often reflecting the target product or project.',
    `nre_amount` DECIMAL(18,2) COMMENT 'Potential NRE revenue associated with custom design or engineering services.',
    `opportunity_number` STRING COMMENT 'Human‑readable business identifier assigned to the opportunity (e.g., OPP‑2024‑00123).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price used for revenue calculations, expressed in the selected currency.',
    `pricing_model` STRING COMMENT 'Pricing structure applied to the opportunity.. Valid values are `fixed|tiered|volume|subscription`',
    `probability_percent` STRING COMMENT 'Estimated probability (0‑100) that the opportunity will be won, based on stage and historical data.',
    `region` STRING COMMENT 'Broad geographic region for the opportunity.. Valid values are `americas|emea|apac`',
    `sales_channel` STRING COMMENT 'Channel through which the sale is pursued.. Valid values are `direct|distributor|partner`',
    `stage` STRING COMMENT 'Current pipeline stage of the opportunity.. Valid values are `prospecting|design_in|design_win|production_ramp|won|lost`',
    `stage_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity last moved to its current stage.',
    `target_application` STRING COMMENT 'Intended end‑use or application for the product (e.g., automotive ADAS, AI accelerator).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., units, chips).. Valid values are `units|chips|dies|wafers`',
    `win_loss_date` DATE COMMENT 'Date on which the opportunity outcome (win or loss) was recorded.',
    `win_loss_reason` STRING COMMENT 'Narrative reason why the opportunity was won or lost.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Master record: Core sales opportunity tracking design-win campaigns, pipeline stages (Prospecting→Design-In→Design-Win→Production Ramp→Won/Lost), probability, and expected revenue for semiconductor IC, SoC, ASIC, and FPGA engagements. Sourced from Salesforce CRM Opportunity object. Captures end market (automotive, mobile, AI, IoT, computing), product family, target application, competitive landscape, NRE potential, design-win status, campaign grouping (campaign type, target segment, effectiveness metrics), and stage transition history for pipeline velocity analysis. SSOT for all sales pipeline activity including campaign-level aggregation for design-in programs, product launches, and competitive displacement initiatives.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique system-generated identifier for the quote record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or prospect receiving the quote.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quote generation must record the exact customer contact authorizing the quote; this FK supports compliance and audit trails.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales rep who created the quote.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - quotes specify technology node requirements',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Quote header must be tied to a product family for contract and pricing governance.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Quotes are generated for design projects; linking enables financial forecasting of design spend.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Every quote is generated in context of an opportunity — this is the core pipeline-to-commercial conversion link. Engineers need this to trace quote→opportunity for pipeline reporting.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Quote generation requires selecting a package type; linking ensures accurate pricing, compliance, and production planning.',
    `price_list_id` BIGINT COMMENT 'FK to sales.price_list.price_list_id — Quotes reference the applicable price list for base pricing. Essential for pricing compliance and margin analysis.',
    `primary_quote_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Quotes are generated in the context of an opportunity. This is the core pipeline-to-commercial link. Required for quote-to-win conversion tracking.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Quotes are generated based on a defined process flow; the link supports pricing, lead‑time, and qualification status.',
    `conversion_date` TIMESTAMP COMMENT 'Timestamp when the quote was converted to an order, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the quote amounts.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the quote sales record.',
    `delivery_terms` STRING COMMENT 'Additional delivery conditions beyond Incoterms, such as FOB destination or DAP warehouse.',
    `quote_description` STRING COMMENT 'Free‑form text describing the scope, special conditions, or notes for the quote.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross amount.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the quote has been converted to a sales order.',
    `issue_date` DATE COMMENT 'The issue date associated with the quote sales record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the quote record in the sales domain.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order receipt to delivery.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discount and tax.',
    `payment_terms` STRING COMMENT 'Standard payment condition attached to the quote.. Valid values are `net30|net45|net60|prepay|cash`',
    `product_code` STRING COMMENT 'Catalog or part number of the quoted product.',
    `quote_date` TIMESTAMP COMMENT 'Timestamp when the quote was issued to the customer.',
    `quote_number` STRING COMMENT 'Human‑readable business identifier for the quotation, often used in communications and tracking.',
    `quote_status` STRING COMMENT 'Current lifecycle state of the quote.. Valid values are `draft|submitted|approved|rejected|expired|converted`',
    `reason_lost` STRING COMMENT 'Textual reason provided when a quote is marked as lost.',
    `sales_region` STRING COMMENT 'Three‑letter country code representing the primary sales region for the quote.. Valid values are `^[A-Z]{3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated on the gross amount after discount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total quoted amount before discounts, taxes, or adjustments.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per individual unit for the quoted product at the selected volume tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    `valid_until` DATE COMMENT 'Date after which the quote is no longer valid.',
    `valid_until_date` DATE COMMENT 'The valid until date associated with the quote sales record.',
    `volume_tier` STRING COMMENT 'Quantity bracket that determines unit pricing.. Valid values are `1-99|100-999|1000-9999|10000+`',
    `win_loss_status` STRING COMMENT 'Outcome of the quote after the decision period.. Valid values are `won|lost|open`',
    `valid_from` DATE COMMENT 'Date from which the quoted terms become effective.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Transaction record: Commercial price quotation issued to a customer or prospect for semiconductor products including ICs, packaged devices, wafer-level products, and IP licensing. Captures quoted unit price, volume tiers, lead time, validity period, incoterms, currency, and SAP SD quotation reference. Tracks quote-to-order conversion and win/loss outcomes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Quote lines must reference specific certifications (e.g., RoHS, ITAR) required by the customer; enables automated compliance checks during quoting.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Quote lines often represent IP core licensing; linking tracks IP revenue and compliance.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Enables quote‑level reporting and margin analysis by product family.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Quote line pricing and availability require linking to the specific finished good inventory record for SKU, enabling real-time stock checks during quoting.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the quote line sales entity.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Quote line items must reference the material master to obtain accurate part numbers, cost, and lead‑time for procurement planning, used in the Quote‑to‑Order workflow.',
    `quote_id` BIGINT COMMENT 'Identifier of the parent sales quote to which this line belongs.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for accurate pricing, inventory and compliance tracking in quote lines.',
    `tertiary_quote_id` BIGINT COMMENT 'FK to sales.quote.quote_id — Header-detail relationship: quote_line cannot exist without its parent quote. Critical for quote value calculation and line-level pricing analysis.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the lines revenue is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quote line was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the quote (e.g., USD, EUR).',
    `customer_requested_delivery_date` DATE COMMENT 'Date the customer expects delivery of the quoted items.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the unit price.',
    `effective_date` DATE COMMENT 'Date on which the quoted terms become effective.',
    `expiration_date` DATE COMMENT 'Date after which the quoted terms are no longer valid.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The extended amount of the quote line record in the sales domain.',
    `internal_approval_status` STRING COMMENT 'Status of internal sales or finance approval for the line.. Valid values are `pending|approved|rejected`',
    `is_custom` BOOLEAN COMMENT 'True if the quoted SKU is a custom or engineered product.',
    `is_price_locked` BOOLEAN COMMENT 'True if the quoted price is locked and cannot be changed without re‑quote.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the quote line record in the sales domain.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order to shipment.',
    `lead_time_weeks` STRING COMMENT 'The lead time weeks of the quote line record in the sales domain.',
    `line_comment` STRING COMMENT 'Free‑form comment entered by the sales rep for this line.',
    `line_number` STRING COMMENT 'Sequential number of the line within the quote for ordering.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `net_price` DECIMAL(18,2) COMMENT 'Unit price after discount, before tax.',
    `package_type` STRING COMMENT 'Physical packaging of the die (e.g., BGA, QFN, WLCSP).',
    `pricing_tier` STRING COMMENT 'Pricing tier classification that determines discount levels.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `quantity` BIGINT COMMENT 'Number of units of the product requested in this line.',
    `quote_line_status` STRING COMMENT 'Current lifecycle status of the quote line.. Valid values are `draft|sent|accepted|rejected|expired`',
    `sales_channel` STRING COMMENT 'Channel through which the sale is pursued.. Valid values are `direct|distributor|online|partner|reseller|OEM`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the quote.. Valid values are `APAC|EMEA|AMER|APJ|LATAM|CHINA`',
    `special_handling_instructions` STRING COMMENT 'Any customer‑specific handling, packaging, or shipping notes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax calculated for this line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `total_price` DECIMAL(18,2) COMMENT 'Gross amount for the line (unit_price * quantity) before tax.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit before discounts, in the quote currency.',
    `uom` STRING COMMENT 'Measurement unit for quantity, typically pcs for pieces.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the quote line.',
    `warranty_years` STRING COMMENT 'Number of years of warranty offered for the product.',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Detail record: Individual line item within a sales quotation specifying a single semiconductor SKU, die, or IP core with its quoted quantity, unit price, discount, package type, lead time, and applicable pricing tier. Supports multi-line quotes covering mixed product families and end-market configurations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` (
    `sales_design_win_id` BIGINT COMMENT 'Unique identifier for the design win record.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the sales design win sales entity.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — A design win is the successful outcome of an opportunity. This link is critical for pipeline conversion metrics and is the most important FK in semiconductor sales.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who selected the semiconductor device.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the record.',
    `sku_id` BIGINT COMMENT 'Identifier of the semiconductor device that won the design.',
    `quote_id` BIGINT COMMENT 'Identifier of the sales quote associated with the design win.',
    `sales_account_id` BIGINT COMMENT 'Unique identifier for the sales account record within the sales design win sales entity.',
    `customer_design_win_id` BIGINT COMMENT 'Unique identifier for the sales authoritative customer design win record within the sales design win sales entity.',
    `sales_customer_design_win_id` BIGINT COMMENT 'Cross-domain SSOT reference to authoritative owner customer.customer_design_win.customer_design_win_id',
    `sales_employee_id` BIGINT COMMENT 'Unique identifier for the sales employee record within the sales design win sales entity.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Identifier of the Non-Recurring Engineering agreement linked to the design win.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Design‑win record must capture the test program that validated the winning design for warranty and support purposes.',
    `competitor_displaced` STRING COMMENT 'The competitor displaced of the sales design win record in the sales domain.',
    `competitor_displacement_score` DECIMAL(18,2) COMMENT 'Score (0-100) representing the impact of displacing the competitor.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to the design win. [ENUM-REF-CANDIDATE: ITAR|EAR|RoHS|REACH|ISO9001|ISO14001|ISO45001 — 7 candidates stripped; promote to reference product]',
    `confidentiality_level` STRING COMMENT 'Data classification level for the design win record.. Valid values are `public|internal|confidential|restricted`',
    `contract_end_date` DATE COMMENT 'The contract end date associated with the sales design win sales record.',
    `contract_start_date` DATE COMMENT 'The contract start date associated with the sales design win sales record.',
    `contract_term_months` STRING COMMENT 'Length of the contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for revenue amounts.. Valid values are `^[A-Z]{3}$`',
    `design_win_name` STRING COMMENT 'The design win name of the sales design win record in the sales domain.',
    `design_win_number` STRING COMMENT 'Unique business identifier for the design win record.',
    `design_win_status` STRING COMMENT 'The design win status of the sales design win record in the sales domain.',
    `displaced_competitor_code` BIGINT COMMENT 'Identifier of the competitor whose device was displaced.',
    `displaced_device_code` BIGINT COMMENT 'Identifier of the competitors device that was displaced.',
    `displacement_reason` STRING COMMENT 'Reason why the competitors device was displaced.. Valid values are `price|performance|power|integration|availability|other`',
    `end_application` STRING COMMENT 'The end application of the sales design win record in the sales domain.',
    `estimated_annual_revenue` DECIMAL(18,2) COMMENT 'The estimated annual revenue of the sales design win record in the sales domain.',
    `estimated_annual_revenue_gross` DECIMAL(18,2) COMMENT 'Projected gross revenue per year from the design win before discounts or adjustments.',
    `estimated_annual_revenue_net` DECIMAL(18,2) COMMENT 'Projected net revenue after adjustments.',
    `estimated_annual_unit_volume` BIGINT COMMENT 'Projected number of units the customer will purchase per year.',
    `estimated_annual_volume` BIGINT COMMENT 'The estimated annual volume of the sales design win record in the sales domain.',
    `export_controlled` BOOLEAN COMMENT 'Indicates if the device is subject to export control regulations.',
    `forecast_accuracy` DECIMAL(18,2) COMMENT 'Percentage indicating forecast accuracy of the revenue estimate.',
    `forecasted_ramp_rate_per_month` DECIMAL(18,2) COMMENT 'Projected increase in unit volume per month during the ramp period.',
    `is_key_account` BOOLEAN COMMENT 'Indicates if the customer is a strategic key account.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sales design win record in the sales domain.',
    `last_review_date` DATE COMMENT 'Date when the design win was last reviewed for compliance or forecast updates.',
    `lifetime_revenue_usd` DECIMAL(18,2) COMMENT 'The lifetime revenue usd of the sales design win record in the sales domain.',
    `market_segment` STRING COMMENT 'Industry segment of the end product.. Valid values are `consumer|automotive|industrial|communications|data_center|other`',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free-text notes about the design win.',
    `pricing_model` STRING COMMENT 'Pricing approach applied to the design win.. Valid values are `list|custom|volume|subscription`',
    `production_start_date` DATE COMMENT 'The production start date associated with the sales design win sales record.',
    `region` STRING COMMENT 'Global region of the customer.. Valid values are `APAC|EMEA|NAM|LATAM`',
    `revenue_adjustment` DECIMAL(18,2) COMMENT 'Any discount, rebate, or adjustment applied to the gross revenue.',
    `revenue_ramp_end_date` DATE COMMENT 'End date of the revenue ramp period.',
    `revenue_ramp_start_date` DATE COMMENT 'Start date of the revenue ramp period.',
    `sales_design_win_status` STRING COMMENT 'Current lifecycle status of the design win.. Valid values are `pending|confirmed|closed|cancelled`',
    `sales_territory` STRING COMMENT 'Geographic or market territory responsible for the design win.',
    `target_application` STRING COMMENT 'End product or application where the winning device will be used (e.g., smartphone, automotive ECU).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the design win record.',
    `win_date` DATE COMMENT 'The win date associated with the sales design win sales record.',
    `win_source` STRING COMMENT 'System or source where the design win was recorded.. Valid values are `salesforce|sap|manual|partner`',
    `win_timestamp` TIMESTAMP COMMENT 'Date and time when the design win was officially confirmed.',
    CONSTRAINT pk_sales_design_win PRIMARY KEY(`sales_design_win_id`)
) COMMENT 'Transaction record: Confirmed design-win record capturing the moment a customer selects a semiconductor device for integration into their end product (PCB, module, or SoC platform). Records the winning device, customer design reference, target application, estimated annual unit volume (AUV), revenue ramp timeline, and competitive displacement details (displaced competitor, displaced device, displacement reason). Critical KPI for semiconductor commercial teams. Represents the key conversion event from opportunity to committed design.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` (
    `sales_nre_agreement_id` BIGINT COMMENT 'Surrogate primary key for the NRE agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party for whom the NRE work is performed.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: NRE agreements may be subject to CHIPS Act obligations; linking records the specific obligation tied to each agreement.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: NRE agreements are allocated to product families for cost recovery and reporting.',
    `ic_design_project_id` BIGINT COMMENT 'Unique identifier for the ic design project record within the sales nre agreement sales entity.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — NRE agreements are commercial vehicles arising from ASIC/custom IC opportunities. Required for NRE pipeline tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative owning the agreement.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: NRE agreements are scoped to a specific process flow; linking enables milestone tracking against that flow.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: NRE Agreement Management ties each agreement to the specific research program funding the development effort.',
    `sales_employee_id` BIGINT COMMENT 'Unique identifier for the sales employee record within the sales nre agreement sales entity.',
    `finance_nre_agreement_id` BIGINT COMMENT 'SSOT reference to authoritative owner finance.finance_nre_agreement for concept nre_agreement',
    `actual_revenue_recognized` DECIMAL(18,2) COMMENT 'Revenue recognized to date according to accounting standards.',
    `agreement_number` STRING COMMENT 'Unique business identifier for the NRE agreement, used in contracts and invoicing.',
    `agreement_status` STRING COMMENT 'The agreement status of the sales nre agreement record in the sales domain.',
    `agreement_type` STRING COMMENT 'Classification of the NRE agreement type.. Valid values are `custom|standard|partner|internal`',
    `approval_status` STRING COMMENT 'Current approval state of the milestone deliverable.. Valid values are `pending|approved|rejected`',
    `authoritative_finance_nre_agreement_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if a change order has been issued for the agreement.',
    `change_order_number` STRING COMMENT 'Identifier of the change order associated with the agreement.',
    `completed_milestones` STRING COMMENT 'Number of milestones that have been completed.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the agreement content.. Valid values are `public|internal|confidential|restricted`',
    `contract_reference` STRING COMMENT 'Reference to the related SAP SD contract number.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the NRE amount.. Valid values are `[A-Z]{3}`',
    `deliverable_type` STRING COMMENT 'Type of deliverable associated with the milestone.. Valid values are `RTL|GDS|PDK|Tapeout|Documentation`',
    `effective_date` DATE COMMENT 'The effective date associated with the sales nre agreement sales record.',
    `effective_end_date` DATE COMMENT 'Date when the NRE agreement ends or expires; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the NRE agreement becomes binding.',
    `exclusivity_flag` BOOLEAN COMMENT 'True if the agreement grants exclusive rights to the customer for the developed IP.',
    `forecasted_revenue` DECIMAL(18,2) COMMENT 'Projected revenue from the NRE agreement for forecasting purposes.',
    `invoice_trigger_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers an invoice generation.',
    `ip_ownership_clause` STRING COMMENT 'Specifies IP ownership rights granted by the agreement.. Valid values are `full|partial|none`',
    `last_milestone_completed_date` DATE COMMENT 'Date of the most recent milestone that has been completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sales nre agreement record in the sales domain.',
    `milestone_actual_date` DATE COMMENT 'Actual completion date recorded for the milestone.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Fee associated with the milestone, invoiced upon completion.',
    `milestone_count` STRING COMMENT 'The milestone count of the sales nre agreement record in the sales domain.',
    `milestone_name` STRING COMMENT 'Name of a specific NRE milestone (e.g., RTL Freeze, Tapeout).',
    `milestone_planned_date` DATE COMMENT 'Planned completion date for the milestone.',
    `milestone_sequence` STRING COMMENT 'Order of the milestone within the agreement schedule.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the agreement.',
    `nre_total_amount` DECIMAL(18,2) COMMENT 'Total contracted NRE fee for the agreement.',
    `payment_schedule` STRING COMMENT 'The payment schedule of the sales nre agreement record in the sales domain.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing invoicing of NRE fees.. Valid values are `net30|net45|net60|upon_delivery|milestone`',
    `risk_assessment_score` STRING COMMENT 'Internal risk rating (1‑5) for the NRE project.',
    `sales_nre_agreement_status` STRING COMMENT 'Current lifecycle status of the NRE agreement.. Valid values are `draft|active|suspended|terminated|closed`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the agreement.. Valid values are `APAC|EMEA|AMER|LATAM|JAPAC`',
    `signed_date` DATE COMMENT 'The signed date associated with the sales nre agreement sales record.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the nre_agreement concept (finance.finance_nre_agreement)',
    `termination_date` DATE COMMENT 'Date on which the agreement was terminated.',
    `termination_reason` STRING COMMENT 'Reason provided if the agreement is terminated before completion.',
    `total_milestones` STRING COMMENT 'Total number of milestones defined in the agreement.',
    `total_nre_amount` DECIMAL(18,2) COMMENT 'The total nre amount of the sales nre agreement record in the sales domain.',
    `updated_by` STRING COMMENT 'User identifier who last modified the agreement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `created_by` STRING COMMENT 'User identifier who created the agreement record.',
    CONSTRAINT pk_sales_nre_agreement PRIMARY KEY(`sales_nre_agreement_id`)
) COMMENT 'Master record: Non-Recurring Engineering (NRE) agreement governing custom IC or ASIC development engagements. Captures NRE fee structure, milestone payment schedule with individual billing/delivery milestones (RTL freeze, tapeout, first silicon, qualification), deliverables (RTL, GDS, PDK, tapeout), IP ownership terms, exclusivity clauses, and SAP SD contract reference. Contains milestone detail records tracking milestone name, planned/actual completion dates, milestone amounts, invoice trigger flags, approval status, and completion workflow. Enables NRE revenue recognition scheduling and project tracking. SSOT for all NRE commercial terms and milestone execution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Price lists are defined per product family to enforce consistent pricing policies.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the price list sales entity.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Price list entries are defined per package type; FK replaces denormalized package_type column for consistency and audit.',
    `price_employee_id` BIGINT COMMENT 'Identifier of the person or role that approved the price list.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Price lists are defined for specific market segments; FK to customer_segment supports pricing strategy and segment‑based pricing reports.',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to a newer price list that supersedes this one.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory record within the price list sales entity.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the price adjustment.',
    `adjustment_reason` STRING COMMENT 'Business reason or justification for the price adjustment.',
    `adjustment_type` STRING COMMENT 'Type of price adjustment applied to the base price.. Valid values are `rebate|discount|incentive|markdown|none`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was approved.',
    `audit_trail` STRING COMMENT 'Append-only log of changes to the price list record.',
    `price_list_code` STRING COMMENT 'Coded value representing the code of the price list sales record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was created.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.. Valid values are `[A-Z]{3}`',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the price list sales record.',
    `customer_segment` STRING COMMENT 'The customer segment of the price list record in the sales domain.',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose and scope.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the price list sales record.',
    `effective_from` DATE COMMENT 'Date when the price becomes effective.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the price list sales record.',
    `effective_until` DATE COMMENT 'Date when the price expires or is superseded.',
    `end_market` STRING COMMENT 'Target market segment (e.g., automotive, mobile, data center).',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this price list is the default for its scope.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the price list record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `price_list_name` STRING COMMENT 'Descriptive name of the price list.',
    `notes` STRING COMMENT 'Free-form notes or comments about the price list.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list.. Valid values are `active|inactive|archived|pending`',
    `price_type` STRING COMMENT 'Category of pricing defined by the list (e.g., standard list, distributor, OEM, spot).. Valid values are `list|distributor|oem|spot`',
    `pricing_condition_code` STRING COMMENT 'SAP SD pricing condition record identifier.',
    `product_code` STRING COMMENT 'Unique identifier of the semiconductor product (e.g., part number).',
    `region` STRING COMMENT 'Geographic region for which the price list applies.',
    `tax_code` STRING COMMENT 'Tax code applicable to the price.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit for the defined tier and product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price list record.',
    `validity_end` DATE COMMENT 'End date of the price lists validity window.',
    `validity_start` DATE COMMENT 'Start date of the price lists validity window.',
    `version` STRING COMMENT 'Version identifier for the price list.',
    `volume_tier_max` STRING COMMENT 'Maximum quantity for the volume pricing tier.',
    `volume_tier_min` STRING COMMENT 'Minimum quantity for the volume pricing tier.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master record: Master pricing repository defining standard and customer-specific pricing for semiconductor products by product family, package type, volume tier, and end market. Supports list price, distributor price, OEM price, and spot price variants. Contains price adjustment records capturing negotiated deviations, special bids, volume rebate adjustments, design-win incentives, and distributor markdowns with adjustment type, approved deviation amount, approval authority, validity windows, and SAP SD pricing condition override references. Integrates with SAP SD condition records and Salesforce CRM pricing engine. Tracks effective dates, supersession history, and full adjustment audit trail. SSOT for all semiconductor product pricing and price deviations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` (
    `customer_contract_id` BIGINT COMMENT 'Unique system-generated identifier for the customer contract.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party that holds the contract.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Contracts often stipulate mandatory product certifications; linking ensures contractual obligations are tracked against the certification registry.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Contracts are the commercial outcome of won opportunities. Traceability needed for contract-to-opportunity lineage.',
    `employee_id` BIGINT COMMENT 'Sales representative responsible for the contract.',
    `primary_customer_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Long-term supply contracts often originate from won opportunities. Links contract terms back to the originating sales engagement.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Customer Contract records reference the R&D project that will deliver the custom chip, required for delivery planning and cost allocation.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `annual_value` DECIMAL(18,2) COMMENT 'Average yearly revenue expected from the contract.',
    `arbitration_clause` BOOLEAN COMMENT 'Indicates whether disputes are resolved via arbitration.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates if the contract will auto‑renew at the end of its term.',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is present.',
    `contract_name` STRING COMMENT 'Descriptive title of the contract for easy identification.',
    `contract_number` STRING COMMENT 'External contract number assigned by the customer or sales organization.',
    `contract_status` STRING COMMENT 'The contract status of the customer contract record in the sales domain.',
    `contract_type` STRING COMMENT 'Category of the contract such as supply, service, license, or NRE.. Valid values are `supply|service|license|nre`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract over its full term.',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'The contract value usd of the customer contract record in the sales domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the customer.',
    `credit_rating` STRING COMMENT 'Internal credit rating of the customer.. Valid values are `AAA|AA|A|BBB|BB|B`',
    `currency` STRING COMMENT 'Three‑letter ISO currency code used for all monetary amounts.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the customer contract sales record.',
    `customer_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|suspended|terminated|draft|pending`',
    `customer_contract_description` STRING COMMENT 'Free‑form text describing the contract purpose and special conditions.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base unit price.',
    `effective_from` DATE COMMENT 'Date when the contract becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or is terminated; null for open‑ended contracts.',
    `end_date` DATE COMMENT 'The end date associated with the customer contract sales record.',
    `eol_clause` BOOLEAN COMMENT 'Indicates whether an End‑of‑Life provision is part of the contract.',
    `invoicing_frequency` STRING COMMENT 'How often invoices are issued under the contract.. Valid values are `monthly|quarterly|annually`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer contract record in the sales domain.',
    `ltb_provision` BOOLEAN COMMENT 'Indicates whether a Last‑Time‑Buy clause is included.',
    `max_order_quantity` BIGINT COMMENT 'Maximum quantity per order allowed under the contract.',
    `min_order_quantity` BIGINT COMMENT 'Minimum quantity per order required by the contract.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the customer.. Valid values are `net30|net45|net60|prepaid|upon_delivery`',
    `pcn_obligation` BOOLEAN COMMENT 'Specifies if the supplier must notify the customer of product changes.',
    `pricing_terms` STRING COMMENT 'Narrative description of pricing structure, discounts, and rebates.',
    `product_family` STRING COMMENT 'Family of semiconductor products covered by the contract.',
    `renewal_option` STRING COMMENT 'Specifies whether the contract renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the contract.',
    `start_date` DATE COMMENT 'The start date associated with the customer contract sales record.',
    `supply_scope` STRING COMMENT 'Scope of supply coverage: exclusive, multi‑source, or global.. Valid values are `exclusive|multi_source|global`',
    `technology_node` STRING COMMENT 'Process technology node (e.g., 7nm, 5nm) applicable to the supplied products.',
    `termination_date` DATE COMMENT 'Date on which the contract is formally terminated.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required before contract termination.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total contract value of the customer contract record in the sales domain.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit of product or service covered by the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `volume_commitment` BIGINT COMMENT 'Total quantity of units the customer commits to purchase over the contract term.',
    CONSTRAINT pk_customer_contract PRIMARY KEY(`customer_contract_id`)
) COMMENT 'Master record: Long-term commercial contract with a semiconductor customer covering supply commitments, pricing agreements, volume guarantees, last-time-buy (LTB) provisions, product change notification (PCN) obligations, and end-of-life (EOL) terms. Distinct from NRE agreements — governs ongoing product supply rather than development services. Linked to SAP SD outline agreements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique system-generated identifier for the sales territory.',
    `parent_territory_id` BIGINT COMMENT 'Identifier of the immediate parent territory in the hierarchy, if any.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary sales representative responsible for the territory.',
    `territory_manager_employee_id` BIGINT COMMENT 'Unique identifier for the manager employee record within the territory sales entity.',
    `channel_tier` STRING COMMENT 'Sales channel classification for the territory.. Valid values are `direct|distribution|partner`',
    `territory_code` STRING COMMENT 'Business code used to uniquely reference the territory in external systems.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the primary country of the territory. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|JPN|KOR|... — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system.',
    `territory_description` STRING COMMENT 'Free‑form description providing additional context about the territory.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes effective for sales activities.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the quota targets apply.',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the territory record in the sales domain.',
    `hierarchy_path` STRING COMMENT 'Delimited path representing the territorys position in the global→regional→country→district hierarchy (e.g., "Global>EMEA>Germany>Berlin").',
    `is_active` BOOLEAN COMMENT 'The is active of the territory record in the sales domain.',
    `is_overlay` BOOLEAN COMMENT 'Indicates whether the territory is an overlay (true) used for specialist coverage in addition to primary territories.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the territory record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `multi_rep_coverage` BOOLEAN COMMENT 'True if the territory is covered by multiple sales representatives or FAEs.',
    `territory_name` STRING COMMENT 'Human‑readable name of the sales territory.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the territory.',
    `region` STRING COMMENT 'The region of the territory record in the sales domain.',
    `region_code` STRING COMMENT 'Internal code representing the broader region (e.g., EMEA, APAC, AMER) to which the territory belongs.',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Fiscal period revenue quota assigned to the territory (in corporate currency).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory.. Valid values are `active|inactive|planned|retired`',
    `territory_type` STRING COMMENT 'Classification of the territory based on its purpose or focus.. Valid values are `geographic|product|strategic|customer`',
    `unit_target_quantity` STRING COMMENT 'Target number of units (e.g., die, wafers) to be sold from the territory for the fiscal period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Master record: Sales territory definition and quota management assigning geographic regions, end markets, or named accounts to sales representatives and field application engineers (FAEs). Captures territory code, region hierarchy (global→regional→country→district), assigned sales rep, FAE coverage, revenue and unit targets by fiscal period (quarterly, half-year, annual), quota amounts, stretch targets, attainment tracking, and effective dates. Includes account-to-territory assignment details with assignment type (direct, distribution, rep firm), primary/secondary coverage flags, channel tier, and multi-rep coverage models. Supports territory realignment, overlay models (product specialists, strategic account managers), quota assignment workflows, and sales performance management common in semiconductor distribution channels. Used for compensation planning and quarterly business review (QBR) reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` (
    `sales_forecast_id` BIGINT COMMENT 'System-generated unique identifier for the forecast record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the forecast is created.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the forecast.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - forecasts are technology node specific',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Forecasts are produced per product family for capacity planning and financial reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the sales forecast sales entity.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Demand forecasts are created per technology node; linking provides node‑specific capacity and yield assumptions.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Forecasts are created for a specific sales territory; replace string with FK to territory for referential integrity.',
    `approval_date` DATE COMMENT 'Date the forecast was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the forecast.',
    `bias` DECIMAL(18,2) COMMENT 'Average signed deviation of forecast from actuals.',
    `confidence_level` STRING COMMENT 'Confidence rating assigned to the forecast.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `effective_end` DATE COMMENT 'Last day of the period the forecast covers.',
    `effective_start` DATE COMMENT 'First day of the period the forecast covers.',
    `end_market` STRING COMMENT 'Target market segment of the forecast.. Valid values are `Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace`',
    `fiscal_period` STRING COMMENT 'Fiscal period identifier (e.g., FY2025Q1).. Valid values are `^FYd{4}Q[1-4]$`',
    `forecast_category` STRING COMMENT 'High‑level category of the forecast (demand, supply, or capacity).. Valid values are `demand|supply|capacity`',
    `forecast_number` STRING COMMENT 'Business identifier assigned to the forecast (e.g., F2025Q1-001).',
    `forecast_period` STRING COMMENT 'The forecast period of the sales forecast record in the sales domain.',
    `forecast_quantity` STRING COMMENT 'The forecast quantity of the sales forecast record in the sales domain.',
    `forecast_revenue` DECIMAL(18,2) COMMENT 'The forecast revenue of the sales forecast record in the sales domain.',
    `forecast_revenue_usd` DECIMAL(18,2) COMMENT 'The forecast revenue usd of the sales forecast record in the sales domain.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast.. Valid values are `draft|submitted|approved|rejected`',
    `forecast_type` STRING COMMENT 'Classification of the forecast scenario (commit, upside, or best‑case).. Valid values are `commit|upside|best_case`',
    `forecast_units` BIGINT COMMENT 'The forecast units of the sales forecast record in the sales domain.',
    `forecast_version` STRING COMMENT 'The forecast version of the sales forecast record in the sales domain.',
    `geography` STRING COMMENT 'Three‑letter ISO country code representing the forecast geography.. Valid values are `^[A-Z]{3}$`',
    `horizon_months` STRING COMMENT 'Length of the forecast horizon expressed in months.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the forecast is locked from further edits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sales forecast record in the sales domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the forecast.',
    `last_reviewer` STRING COMMENT 'User identifier who performed the last review.',
    `mape` DECIMAL(18,2) COMMENT 'Statistical measure of forecast accuracy.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the forecast.',
    `quantity` BIGINT COMMENT 'Projected unit volume for the forecast period.',
    `revenue` DECIMAL(18,2) COMMENT 'Projected revenue amount for the forecast period.',
    `scenario_name` STRING COMMENT 'Named scenario associated with the forecast.. Valid values are `Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit`',
    `submission_date` DATE COMMENT 'Date the forecast was submitted for review.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for forecast_quantity.. Valid values are `units|pcs|die|wafer`',
    `updated_by` STRING COMMENT 'User identifier who last updated the forecast.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the forecast record.',
    `variance_to_actual` DECIMAL(18,2) COMMENT 'Percentage variance between forecast and actual results.',
    `version_number` STRING COMMENT 'Sequential version identifier for the forecast record.',
    `created_by` STRING COMMENT 'User identifier who created the forecast.',
    CONSTRAINT pk_sales_forecast PRIMARY KEY(`sales_forecast_id`)
) COMMENT 'Transaction record: Sales demand forecast capturing expected unit volume and revenue by product family, customer, end market, geography, and fiscal period. Supports rolling 12-month and 18-month forecast horizons used in semiconductor S&OP and wafer-start authorization processes. Tracks forecast version (commit, upside, best-case), submission date, confidence level, and variance against actuals. Integrates with SAP APO/IBP demand planning. Enables forecast accuracy KPI tracking (MAPE, bias) critical for fab capacity planning decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`booking` (
    `booking_id` BIGINT COMMENT 'System-generated unique identifier for the booking record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the booking.',
    `address_id` BIGINT COMMENT 'Identifier of the destination location for shipment.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: REQUIRED: Booking‑to‑invoice reconciliation report; invoices are generated from bookings for order fulfillment and revenue recognition.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings represent the commercial commitment arising from won opportunities. Essential for opportunity-to-revenue traceability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting allocates each sales booking to a finance cost center to track expenses and calculate profitability.',
    `customer_contract_id` BIGINT COMMENT 'Reference to the governing sales contract or NRE agreement.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal sales representative owning the booking.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Required for export‑control compliance; each shipment (booking) must be tied to the export license covering the commodities and destination.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Booking must reference the exact IC catalog entry to drive manufacturing and compliance checks.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Booking (order fulfillment) must specify the package type to be produced; needed for manufacturing scheduling and regulatory reporting.',
    `primary_booking_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings fulfill opportunities. This link closes the pipeline-to-revenue loop essential for forecast accuracy measurement.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Bookings are fulfilled using a defined process flow; the link drives production scheduling and yield tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑and‑loss reporting ties booking revenue to a profit center for accurate profit analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Required for Order Fulfillment process: each sales booking generates a purchase order to a supplier, enabling end‑to‑end order‑to‑cash and procure‑to‑pay tracking.',
    `quote_id` BIGINT COMMENT 'Unique identifier for the quote record within the booking sales entity.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Production bookings are linked to a tapeout to schedule wafer fabrication and track yield.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Bookings are tied to a sales territory; FK enables consistent territory hierarchy and reporting.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the booking record in the sales domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd of the booking record in the sales domain.',
    `backlog_flag` BOOLEAN COMMENT 'True if the booking is currently in backlog (unfulfilled).',
    `booked_quantity` BIGINT COMMENT 'Number of units (dies) committed in the booking.',
    `booked_revenue_gross` DECIMAL(18,2) COMMENT 'Total revenue amount before discounts and taxes, in the booking currency.',
    `booked_revenue_net` DECIMAL(18,2) COMMENT 'Revenue after discounts and before tax.',
    `booking_date` DATE COMMENT 'The date associated with the booking sales record.',
    `booking_number` STRING COMMENT 'External business number assigned to the booking, used in sales and finance processes.',
    `booking_status` STRING COMMENT 'Current lifecycle state of the booking.. Valid values are `draft|confirmed|fulfilled|cancelled|backlog`',
    `booking_timestamp` TIMESTAMP COMMENT 'Timestamp when the booking was created in the source system.',
    `comments` STRING COMMENT 'Free‑form notes entered by sales or operations.',
    `compliance_status` STRING COMMENT 'Current compliance status of the booking with internal and regulatory rules.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the booking amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Preferred logistics mode for shipment.. Valid values are `air|sea|ground|pickup`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross revenue.',
    `external_order_ref` STRING COMMENT 'Reference to the original sales order in SAP SD.',
    `forecast_flag` BOOLEAN COMMENT 'True if the booking is included in the sales forecast.',
    `is_critical` BOOLEAN COMMENT 'True if the booking is deemed critical for product launch or revenue targets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the booking record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `order_type` STRING COMMENT 'Classification of the booking (e.g., standard sale, NRE, design‑win).. Valid values are `standard|nre|design_win|service|maintenance`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer.. Valid values are `net30|net45|net60|cash`',
    `pricing_model` STRING COMMENT 'Pricing approach applied to the booking.. Valid values are `list|contract|discounted|custom`',
    `priority_level` STRING COMMENT 'Business priority assigned to the booking.. Valid values are `high|medium|low`',
    `product_family` STRING COMMENT 'High‑level product family (e.g., ASIC, FPGA, SoC) for the booked part.',
    `quantity` BIGINT COMMENT 'The quantity of the booking record in the sales domain.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the booking must be reported under specific regulatory frameworks (e.g., CHIPS Act).',
    `requested_delivery_date` DATE COMMENT 'Date the customer expects the shipment to be delivered.',
    `revenue_recognition_date` DATE COMMENT 'Date when the booked revenue is recognized for accounting.',
    `revenue_recognition_period` STRING COMMENT 'The revenue recognition period of the booking record in the sales domain.',
    `sales_region` STRING COMMENT 'Geographic sales region for the booking.. Valid values are `APAC|EMEA|AMER`',
    `ship_to_country` STRING COMMENT 'Three‑letter country code of the ship‑to location.. Valid values are `^[A-Z]{3}$`',
    `source` STRING COMMENT 'Origin system that created the booking record.. Valid values are `salesforce|sap|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the net revenue.',
    `total_tax_code` STRING COMMENT 'Tax code used for calculating tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the booking record.',
    `warranty_period_months` STRING COMMENT 'Warranty duration provided to the customer, in months.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Transaction record: Confirmed sales booking representing a firm customer purchase order commitment for semiconductor devices. Captures booking date, booked revenue, booked units, device part number, customer account, ship-to location, requested delivery date, backlog status, and SAP SD sales order reference. Represents the commercial booking event — distinct from shipment or invoice. SSOT for bookings-to-billings (B2B) ratio, book-to-ship analysis, and revenue waterfall reporting critical to semiconductor quarterly earnings.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique identifier for the lead record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account associated with the lead.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the lead.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Lead qualification and routing depend on the product family of interest.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative owning the lead.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Leads convert to opportunities — this link tracks the conversion funnel. Essential for lead source ROI analysis.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the lead sales entity.',
    `primary_lead_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Leads convert to opportunities upon qualification. This FK enables lead-to-opportunity conversion funnel analysis.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Leads are qualified against a target technology node; the link supports early feasibility analysis.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Leads are assigned to a sales territory; FK provides proper linkage to territory hierarchy.',
    `city` STRING COMMENT 'City of the leads organization address.',
    `company_industry` STRING COMMENT 'Industry classification of the leads organization.',
    `company_name` STRING COMMENT 'Name of the organization associated with the lead.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the lead is subject to any regulatory compliance considerations (e.g., ITAR).',
    `contact_email` STRING COMMENT 'Primary email address of the lead contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the primary contact person for the lead.',
    `contact_phone` STRING COMMENT 'Primary phone number of the lead contact.',
    `conversion_date` DATE COMMENT 'Date when the lead was converted to an opportunity or closed.',
    `conversion_outcome` STRING COMMENT 'Result of the lead conversion attempt.. Valid values are `won|lost|no_decision`',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the leads organization.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the lead record in the sales domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the lead was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated revenue.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `data_classification` STRING COMMENT 'Classification level of the lead data as per corporate policy.. Valid values are `restricted|confidential|internal|public`',
    `device_interest` STRING COMMENT 'Specific type of semiconductor device the lead is interested in (e.g., ASIC, FPGA, SoC).',
    `estimated_quantity` BIGINT COMMENT 'Projected number of units the lead may purchase.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Projected monetary value of the lead opportunity.',
    `expected_close_date` DATE COMMENT 'Projected date by which the lead is expected to be closed.',
    `is_nre` BOOLEAN COMMENT 'Flag indicating if the lead is for a Non‑Recurring Engineering (NRE) project.',
    `itar_required` BOOLEAN COMMENT 'Flag indicating whether the lead involves technology subject to ITAR regulations.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the lead record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the lead record.',
    `lead_number` STRING COMMENT 'External reference number for the lead as used in sales systems.',
    `lead_score` STRING COMMENT 'The lead score of the lead record in the sales domain.',
    `lead_status` STRING COMMENT 'Current lifecycle status of the lead within the sales pipeline.. Valid values are `new|qualified|disqualified|converted|closed`',
    `lead_type` STRING COMMENT 'Classification of the lead based on sales process stage.. Valid values are `design_win|design_in|pre_sales|post_sales`',
    `market_segment` STRING COMMENT 'Target market segment for the lead (e.g., Consumer, Automotive, Data Center).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `lead_name` STRING COMMENT 'The name of the lead record in the sales domain.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations about the lead.',
    `priority` STRING COMMENT 'Priority level assigned to the lead for follow‑up.. Valid values are `high|medium|low`',
    `qualification_status` STRING COMMENT 'The qualification status of the lead record in the sales domain.',
    `rating` STRING COMMENT 'Qualitative rating of the leads potential.. Valid values are `A|B|C|D|E`',
    `region` STRING COMMENT 'Broad geographic region of the lead (e.g., APAC, EMEA, AMER).. Valid values are `APAC|EMEA|AMER`',
    `score` STRING COMMENT 'Numerical score representing lead quality based on qualification criteria.',
    `source` STRING COMMENT 'Origin channel through which the lead was captured.. Valid values are `web|email|event|referral|partner|campaign`',
    `target_application` STRING COMMENT 'Intended application area for the semiconductor product (e.g., mobile, automotive, AI).',
    `technology_node` STRING COMMENT 'Process technology node of interest (e.g., 7nm, 5nm).',
    `zip_code` STRING COMMENT 'Postal code of the leads organization address.',
    `created_by` STRING COMMENT 'User identifier who created the lead record.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'Transaction record: Early-stage sales lead representing an unqualified potential customer or design opportunity. Captures lead source, contact information, target application, device interest, estimated opportunity size, lead status, and conversion outcome. Sourced from Salesforce CRM Lead object. Tracks lead-to-opportunity conversion funnel for semiconductor design-in campaigns.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` (
    `channel_partner_id` BIGINT COMMENT 'System-generated unique identifier for the channel partner record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the account record within the channel partner sales entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Partner‑related operational costs are tracked in a dedicated finance cost center for cost allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the manager employee record within the channel partner sales entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Distribution agreements require linking each channel partner to its upstream supplier(s) for inventory allocation and contractual compliance.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory record within the channel partner sales entity.',
    `address_line1` STRING COMMENT 'First line of the partners primary business address.',
    `address_line2` STRING COMMENT 'Second line of the partners primary business address (optional).',
    `agreement_end_date` DATE COMMENT 'The agreement end date associated with the channel partner sales record.',
    `agreement_start_date` DATE COMMENT 'The agreement start date associated with the channel partner sales record.',
    `authorized_product_lines` STRING COMMENT 'Comma‑separated list of product families the partner may sell.',
    `channel_partner_status` STRING COMMENT 'Current operational status of the partner relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `city` STRING COMMENT 'City component of the partners primary address.',
    `contract_effective_from` DATE COMMENT 'Date on which the partner contract becomes effective.',
    `contract_effective_until` DATE COMMENT 'Date on which the partner contract expires or is scheduled to terminate (null if open‑ended).',
    `contract_number` STRING COMMENT 'Unique identifier of the master agreement governing the partner relationship.',
    `contract_status` STRING COMMENT 'Lifecycle state of the partner contract.. Valid values are `draft|active|expired|terminated|suspended`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the partners primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the channel partner record was first created in the lakehouse.',
    `external_partner_code` STRING COMMENT 'Identifier used for the partner in external systems (e.g., third‑party distributor portal).',
    `hub_consignment_level` STRING COMMENT 'Level of consignment inventory maintained at partner hubs.. Valid values are `none|low|medium|high`',
    `inventory_reporting_obligation` BOOLEAN COMMENT 'Indicates whether the partner must provide regular inventory visibility to Semiconductors.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was last reviewed for compliance or data quality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the channel partner record in the sales domain.',
    `legal_entity_name` STRING COMMENT 'Full legal entity name as registered for contracts and compliance.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form text for internal comments, observations, or special handling instructions.',
    `partner_code` STRING COMMENT 'Coded value representing the partner code of the channel partner sales record.',
    `partner_name` STRING COMMENT 'Legal or trade name of the channel partner organization.',
    `partner_status` STRING COMMENT 'The partner status of the channel partner record in the sales domain.',
    `partner_tier` STRING COMMENT 'The partner tier of the channel partner record in the sales domain.',
    `partner_type` STRING COMMENT 'Category of the partner based on its business model and relationship to Semiconductors.. Valid values are `distributor|value_added_reseller|system_integrator|rep_firm|online_marketplace`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the partners primary address.',
    `price_protection_claims_allowed` BOOLEAN COMMENT 'Indicates if the partner can submit price‑protection claims under the agreement.',
    `pricing_agreement_type` STRING COMMENT 'Pricing model governing the partners purchase terms.. Valid values are `fixed|tiered|volume_based|rebate|custom`',
    `primary_contact_email` STRING COMMENT 'Email address used for official communications with the partner.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the main business contact for the partner.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the primary partner contact.',
    `region` STRING COMMENT 'The region of the channel partner record in the sales domain.',
    `sap_partner_function_code` STRING COMMENT 'SAP SD code that classifies the partners functional role (e.g., sold‑to, ship‑to, bill‑to).',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of partner inventory sold to end customers over a defined period.',
    `state_province` STRING COMMENT 'State or province component of the partners primary address.',
    `stock_on_hand` BIGINT COMMENT 'Current quantity of semiconductor units physically held by the partner.',
    `territory_coverage` STRING COMMENT 'Geographic or market territories the partner is authorized to sell within.',
    `tier_classification` STRING COMMENT 'Strategic tier assigned to the partner reflecting level of authorization and performance expectations.. Valid values are `authorized|preferred|elite`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the channel partner record.',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Estimated number of weeks the current stock will satisfy forecasted demand.',
    CONSTRAINT pk_channel_partner PRIMARY KEY(`channel_partner_id`)
) COMMENT 'Master record: Authorized semiconductor sales channel partner including distributors (Arrow, Avnet, WPG), rep firms, value-added resellers (VARs), and system integrators. Captures partner type, authorized product lines, territory coverage, tier classification (authorized, preferred, elite), contract status, inventory reporting obligations (stock on hand, weeks of supply, sell-through, hub/consignment levels), and SAP SD partner function reference. SSOT for channel partner identity and distributor inventory visibility within the sales domain. Supports ship-from-stock-and-debit (SFSD) processing and price protection claim management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` (
    `sales_design_registration_id` BIGINT COMMENT 'Unique system-generated identifier for each design registration transaction.',
    `channel_partner_id` BIGINT COMMENT 'Identifier of the sales representative firm (partner) that is credited.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the sales design registration sales entity.',
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the opportunity record within the sales design registration sales entity.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer organization linked to the registration.',
    `primary_sales_channel_partner_id` BIGINT COMMENT 'Unique identifier of the distributor or channel partner.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the underlying IC design or IP core.',
    `sales_account_id` BIGINT COMMENT 'Unique identifier for the sales account record within the sales design registration sales entity.',
    `customer_design_registration_id` BIGINT COMMENT 'Unique identifier for the sales authoritative customer design registration record within the sales design registration sales entity.',
    `approval_comments` STRING COMMENT 'Additional remarks or justification provided by the approver.',
    `approval_date` DATE COMMENT 'Date the registration claim received approval.',
    `approved_by` STRING COMMENT 'Name of the internal stakeholder who approved the registration.',
    `audit_trail` STRING COMMENT 'JSON‑encoded history of status changes and key field modifications for compliance.',
    `claim_number` STRING COMMENT 'Unique internal identifier for the design‑win claim.',
    `compliance_iso9001` BOOLEAN COMMENT 'True if the registration adheres to ISO 9001 quality standards.',
    `compliance_itar` BOOLEAN COMMENT 'True if the registration is governed by International Traffic in Arms Regulations.',
    `compliance_rohs` BOOLEAN COMMENT 'True if the device meets Restriction of Hazardous Substances directives.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code representing the customers country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the registration record was initially entered.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the protected price.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `device_family` STRING COMMENT 'High‑level product family to which the device belongs.',
    `device_part_number` STRING COMMENT 'Manufacturer part number of the device claimed in the registration.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the list price that is part of the protected pricing terms.',
    `effective_end_date` DATE COMMENT 'End date of the protected pricing period; null if indefinite.',
    `effective_start_date` DATE COMMENT 'Start date of the protected pricing period.',
    `end_application` STRING COMMENT 'Description of the final application or market for the registered design.',
    `end_customer_name` STRING COMMENT 'The end customer name of the sales design registration record in the sales domain.',
    `estimated_annual_volume` STRING COMMENT 'Projected number of units the customer will purchase per year.',
    `estimated_volume` BIGINT COMMENT 'The estimated volume of the sales design registration record in the sales domain.',
    `expiration_reason` STRING COMMENT 'Explanation for why the registration entered the expired state.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the sales design registration sales record.',
    `is_channel_conflict` BOOLEAN COMMENT 'True if the registration was flagged for potential double‑claiming.',
    `is_price_protected` BOOLEAN COMMENT 'True if the registration includes protected pricing terms.',
    `last_modified_by` STRING COMMENT 'System user ID of the most recent editor of the registration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sales design registration record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Supplementary comments or observations related to the registration.',
    `package_type` STRING COMMENT 'Physical packaging style of the registered device.',
    `protected_price_usd` DECIMAL(18,2) COMMENT 'Unit price that is protected for the duration of the registration, expressed in US dollars.',
    `region` STRING COMMENT 'Broad geographic region for the registration claim.. Valid values are `NAM|EMEA|APAC|LATAM|AFR|CAN`',
    `registration_date` DATE COMMENT 'The registration date associated with the sales design registration sales record.',
    `registration_number` STRING COMMENT 'Business identifier assigned to the design registration claim.',
    `registration_status` STRING COMMENT 'The registration status of the sales design registration record in the sales domain.',
    `registration_type` STRING COMMENT 'Category indicating the purpose of the registration such as design win claim or price protection.. Valid values are `design_win|price_protection|other`',
    `sales_customer_design_registration_id` BIGINT COMMENT 'Cross-domain SSOT reference to authoritative owner customer.customer_design_registration.customer_design_registration_id',
    `sales_design_registration_status` STRING COMMENT 'Lifecycle status of the registration claim.. Valid values are `pending|approved|rejected|expired`',
    `sales_rep_firm_name` STRING COMMENT 'Legal name of the sales rep firm.',
    `special_pricing_flag` BOOLEAN COMMENT 'The special pricing flag of the sales design registration record in the sales domain.',
    `submission_date` DATE COMMENT 'Date the design registration was initially submitted.',
    `technology_node` STRING COMMENT 'Process technology node associated with the design.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the registration record.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafer used for the design, expressed in millimetres.',
    CONSTRAINT pk_sales_design_registration PRIMARY KEY(`sales_design_registration_id`)
) COMMENT 'Transaction record: Formal design registration submitted by a distributor or rep firm to claim sales credit and price protection for a specific customer design opportunity. Captures registered device, customer, end application, estimated annual volume, registration status (pending, approved, rejected, expired), approval date, and protected pricing terms. Prevents channel conflict and double-claiming in semiconductor distribution channels.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` (
    `rebate_program_id` BIGINT COMMENT 'System-generated unique identifier for each rebate program record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Rebate eligibility is evaluated per customer account; the link enables the Rebate Program report and financial settlement.',
    `channel_partner_id` BIGINT COMMENT 'FK to sales.channel_partner.channel_partner_id — Rebate programs are established for specific channel partners. Essential for partner incentive management and accrual calculation.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the rebate program sales entity.',
    `primary_channel_partner_id` BIGINT COMMENT 'FK to sales.channel_partner.channel_partner_id — Rebate programs are structured for specific channel partners. Partner identity determines eligibility and payout.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Rebate expense is booked against a profit center, enabling accurate profit reporting for rebate programs.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory record within the rebate program sales entity.',
    `accrual_date` DATE COMMENT 'Date on which the rebate accrual is posted to the financial ledger.',
    `accrual_method` STRING COMMENT 'Method used to accrue rebate liability (periodic, event‑based, or continuous).. Valid values are `periodic|event_based|continuous`',
    `calculation_method` STRING COMMENT 'Method used to calculate rebate amounts.. Valid values are `tiered_percentage|flat_rate|tiered_flat|custom`',
    `compliance_requirements` STRING COMMENT 'Regulatory or export‑control constraints applicable to the rebate (e.g., ITAR, EAR, RoHS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate program record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for rebate amounts.. Valid values are `^[A-Z]{3}$`',
    `rebate_program_description` STRING COMMENT 'Free‑text description of the program purpose and scope.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the rebate program sales record.',
    `effective_from` DATE COMMENT 'Date on which the rebate program becomes binding.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the rebate program sales record.',
    `effective_until` DATE COMMENT 'Date on which the rebate program expires; null for open‑ended agreements.',
    `eligibility_criteria` STRING COMMENT 'Textual definition of the conditions a partner must meet to qualify for the rebate.',
    `financial_account_code` STRING COMMENT 'General ledger account code used for rebate liability postings.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rebate program is exclusive to a single partner (true) or can be shared (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the rebate program record in the sales domain.',
    `max_payout_amount` DECIMAL(18,2) COMMENT 'Upper cap on total rebate payout for the program.',
    `measurement_period_end` DATE COMMENT 'End date of the period over which qualifying sales are measured.',
    `measurement_period_start` DATE COMMENT 'Start date of the period over which qualifying sales are measured.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Additional remarks or special conditions for the program.',
    `partner_type` STRING COMMENT 'Category of partner eligible for the rebate program.. Valid values are `distributor|customer|reseller|integrator|other`',
    `payout_schedule` STRING COMMENT 'Frequency with which accrued rebates are paid to the partner.. Valid values are `monthly|quarterly|annually|upon_settlement`',
    `program_code` STRING COMMENT 'Business identifier code assigned to the rebate program, used in contracts and reporting.',
    `program_name` STRING COMMENT 'Human‑readable name of the rebate program.',
    `program_status` STRING COMMENT 'The program status of the rebate program record in the sales domain.',
    `program_type` STRING COMMENT 'Classification of the rebate program (e.g., volume, growth, design‑win, MDF, incentive, other).. Valid values are `volume|growth|design_win|marketing_development_fund|incentive|other`',
    `rebate_percent` DECIMAL(18,2) COMMENT 'The rebate percent of the rebate program record in the sales domain.',
    `rebate_program_status` STRING COMMENT 'Current lifecycle status of the rebate program.. Valid values are `active|inactive|suspended|draft|terminated`',
    `rebate_type` STRING COMMENT 'The rebate type of the rebate program record in the sales domain.',
    `region` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code indicating the primary geographic region for the program.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the rebate payment was made to the partner.',
    `settlement_status` STRING COMMENT 'Current status of the rebate settlement process.. Valid values are `pending|settled|rejected|partial`',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The threshold amount of the rebate program record in the sales domain.',
    `tier1_rate_percent` DECIMAL(18,2) COMMENT 'Rebate percentage applied to revenue/units that fall within tier 1.',
    `tier1_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum revenue or unit volume required to reach tier 1.',
    `tier2_rate_percent` DECIMAL(18,2) COMMENT 'Rebate percentage applied to revenue/units that fall within tier 2.',
    `tier2_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum revenue or unit volume required to reach tier 2.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rebate program record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the rebate program record.',
    CONSTRAINT pk_rebate_program PRIMARY KEY(`rebate_program_id`)
) COMMENT 'Master record: Distributor or customer rebate program definition, accrual tracking, and settlement management. Specifies rebate type (volume rebate, growth rebate, design-win incentive, marketing development fund), eligibility criteria, calculation method (tiered percentage, flat rate), measurement period, payout schedule, and maximum payout cap. Contains transactional accrual records tracking earned amounts per partner per period, qualifying revenue/units, accrual dates, settlement status, and SAP FI accrual posting references. Enables accurate rebate liability reporting, cash flow forecasting, and channel incentive management for semiconductor distribution agreements. SSOT for all rebate financial obligations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`activity` (
    `activity_id` BIGINT COMMENT 'Primary key for activity',
    `account_id` BIGINT COMMENT 'Identifier of the customer account associated with the activity.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Activities (customer visits, demos, presentations) are performed in context of opportunities. Essential for engagement tracking and pipeline velocity analysis.',
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record within the activity sales entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Activity cost tracking requires linking each sales activity to a finance cost center for internal accounting.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal sales or field application engineer who performed the activity.',
    `lead_id` BIGINT COMMENT 'Unique identifier for the lead record within the activity sales entity.',
    `primary_activity_opportunity_id` BIGINT COMMENT 'Identifier of the sales opportunity linked to this activity.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sales activities (e.g., sample distribution) need a reliable link to the master SKU record.',
    `activity_date` TIMESTAMP COMMENT 'The date associated with the activity sales record.',
    `activity_status` STRING COMMENT 'Current lifecycle state of the activity.. Valid values are `planned|completed|cancelled|postponed`',
    `activity_timestamp` TIMESTAMP COMMENT 'Exact date and time when the activity occurred.',
    `activity_type` STRING COMMENT 'Category of the sales interaction such as a customer visit, technical presentation, demo evaluation, sample request, design review, or conference engagement. [ENUM-REF-CANDIDATE: customer_visit|technical_presentation|demo_evaluation|sample_request|design_review|conference_engagement|other — 7 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'Medium through which the activity was conducted.. Valid values are `in_person|virtual|phone|email`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity record was first created in the source system.',
    `due_date` DATE COMMENT 'The due date associated with the activity sales record.',
    `duration_minutes` STRING COMMENT 'Length of the activity measured in minutes.',
    `evaluation_result` STRING COMMENT 'Result of any technical evaluation performed during the activity.. Valid values are `pass|fail|partial|not_applicable`',
    `is_internal` BOOLEAN COMMENT 'Flag indicating whether the activity was performed by internal staff (true) or by an external partner (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the activity record in the sales domain.',
    `location` STRING COMMENT 'Physical or virtual location where the activity took place (e.g., customer site, conference hall, video‑call link).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `next_action_due_date` DATE COMMENT 'Planned date by which the follow‑up action identified in the activity should be completed.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the representative during or after the activity.',
    `outcome` STRING COMMENT 'Free‑text description of the result of the activity (e.g., demo successful, sample approved).',
    `priority` STRING COMMENT 'The priority of the activity record in the sales domain.',
    `sample_approval_status` STRING COMMENT 'Current approval state of the engineering sample request.. Valid values are `pending|approved|rejected`',
    `sample_quantity` STRING COMMENT 'Number of engineering samples requested in a sample‑request activity.',
    `subject` STRING COMMENT 'The subject of the activity record in the sales domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the activity record.',
    CONSTRAINT pk_activity PRIMARY KEY(`activity_id`)
) COMMENT 'Transaction record: Sales and FAE customer interaction activity including customer visits, technical presentations, demo evaluations, engineering sample requests (device samples for design evaluation/qualification with requested devices, quantities, package types, approval status, shipment tracking, and evaluation outcomes), design review meetings, and conference engagements. Captures activity type, date, participants, associated opportunity or account, outcome, and next action. Sourced from Salesforce CRM Activity/Task/Event objects. SSOT for all customer touchpoint tracking in the semiconductor design-in process including sample fulfillment lifecycle.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` (
    `partner_inventory_id` BIGINT COMMENT 'Primary key for the partner_inventory association',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to the channel partner',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to the finished good',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the partner inventory sales entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the reported by employee record within the partner inventory sales entity.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the partner inventory sales entity.',
    `aging_bucket_30_qty` STRING COMMENT 'The aging bucket 30 qty of the partner inventory record in the sales domain.',
    `aging_bucket_60_qty` STRING COMMENT 'The aging bucket 60 qty of the partner inventory record in the sales domain.',
    `aging_bucket_90_plus_qty` STRING COMMENT 'The aging bucket 90 plus qty of the partner inventory record in the sales domain.',
    `aging_days` STRING COMMENT 'The aging days of the partner inventory record in the sales domain.',
    `allocated_quantity` BIGINT COMMENT 'The allocated quantity of the partner inventory record in the sales domain.',
    `as_of_date` DATE COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `available_qty` STRING COMMENT 'The available qty of the partner inventory record in the sales domain.',
    `available_quantity` BIGINT COMMENT 'The available quantity of the partner inventory record in the sales domain.',
    `average_selling_price_usd` DECIMAL(18,2) COMMENT 'Average selling price in USD for the inventory item at the partner',
    `backorder_qty` BIGINT COMMENT 'Quantity currently on backorder from end customers',
    `consignment_flag` BOOLEAN COMMENT 'Whether this inventory is held on consignment',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the partner inventory record in the sales domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the partner inventory sales record.',
    `date_code` STRING COMMENT 'Date code on the inventory packaging',
    `days_of_supply` STRING COMMENT 'The days of supply of the partner inventory record in the sales domain.',
    `excess_flag` BOOLEAN COMMENT 'Whether this inventory is classified as excess stock',
    `forecast_demand_qty` BIGINT COMMENT 'Forecasted demand quantity for the next reporting period',
    `in_transit_qty` BIGINT COMMENT 'Enriched attribute for partner_inventory.',
    `in_transit_quantity` BIGINT COMMENT 'The in transit quantity of the partner inventory record in the sales domain.',
    `inventory_date` DATE COMMENT 'The inventory date associated with the partner inventory sales record.',
    `inventory_reporting_obligation` BOOLEAN COMMENT 'Indicates whether the partner must provide regular inventory visibility',
    `inventory_snapshot_date` DATE COMMENT 'The inventory snapshot date associated with the partner inventory sales record.',
    `inventory_status` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `inventory_turn_rate` DECIMAL(18,2) COMMENT 'Inventory turn rate (annualized) for this SKU at the partner',
    `inventory_value_usd` DECIMAL(18,2) COMMENT 'The inventory value usd of the partner inventory record in the sales domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the partner inventory record in the sales domain.',
    `last_movement_date` DATE COMMENT 'The last movement date associated with the partner inventory sales record.',
    `last_replenishment_date` DATE COMMENT 'Date of the last inventory replenishment from the manufacturer',
    `location` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `location_code` STRING COMMENT 'Enriched attribute for partner_inventory.',
    `lot_code` STRING COMMENT 'Manufacturing lot code for traceability',
    `min_stock_level` BIGINT COMMENT 'The min stock level of the partner inventory record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `next_order_date` DATE COMMENT 'Expected date of next replenishment order',
    `obsolete_flag` BOOLEAN COMMENT 'Whether this inventory is classified as obsolete',
    `on_hand_qty` BIGINT COMMENT 'Enriched attribute for partner_inventory.',
    `on_hand_quantity` BIGINT COMMENT 'The on hand quantity of the partner inventory record in the sales domain.',
    `on_order_qty` STRING COMMENT 'The on order qty of the partner inventory record in the sales domain.',
    `partner_inventory_status` STRING COMMENT 'Enriched attribute for partner_inventory.',
    `quantity_committed` BIGINT COMMENT 'The quantity committed of the partner inventory record in the sales domain.',
    `quantity_in_transit` STRING COMMENT 'The quantity in transit of the partner inventory record in the sales domain.',
    `quantity_on_hand` BIGINT COMMENT 'The quantity on hand of the partner inventory record in the sales domain.',
    `quantity_received` BIGINT COMMENT 'The quantity received of the partner inventory record in the sales domain.',
    `quantity_returned` BIGINT COMMENT 'The quantity returned of the partner inventory record in the sales domain.',
    `quantity_sold` BIGINT COMMENT 'The quantity sold of the partner inventory record in the sales domain.',
    `quantity_sold_through` STRING COMMENT 'The quantity sold through of the partner inventory record in the sales domain.',
    `reorder_point` BIGINT COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `reorder_qty` STRING COMMENT 'The reorder qty of the partner inventory record in the sales domain.',
    `report_date` DATE COMMENT 'The report date associated with the partner inventory sales record.',
    `report_period` STRING COMMENT 'The report period of the partner inventory record in the sales domain.',
    `report_source` STRING COMMENT 'The report source of the partner inventory record in the sales domain.',
    `reported_date` DATE COMMENT 'Enriched attribute for partner_inventory.',
    `reporting_period` STRING COMMENT 'The reporting period of the partner inventory record in the sales domain.',
    `reserved_qty` BIGINT COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `reserved_quantity` BIGINT COMMENT 'The reserved quantity of the partner inventory record in the sales domain.',
    `sell_through_quantity` BIGINT COMMENT 'The sell through quantity of the partner inventory record in the sales domain.',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of partner inventory sold to end customers over a defined period',
    `shelf_life_remaining_days` STRING COMMENT 'Remaining shelf life in days for moisture-sensitive components',
    `stock_in_transit` BIGINT COMMENT 'The stock in transit of the partner inventory record in the sales domain.',
    `stock_on_hand` BIGINT COMMENT 'Current quantity of the finished good held by the partner',
    `units_received_in_period` BIGINT COMMENT 'The units received in period of the partner inventory record in the sales domain.',
    `units_sold_in_period` BIGINT COMMENT 'The units sold in period of the partner inventory record in the sales domain.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `valuation_method` STRING COMMENT 'The valuation method of the partner inventory record in the sales domain.',
    `warehouse_location` STRING COMMENT 'The warehouse location of the partner inventory record in the sales domain.',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Estimated weeks of supply the partners stock will satisfy demand',
    CONSTRAINT pk_partner_inventory PRIMARY KEY(`partner_inventory_id`)
) COMMENT 'Association product representing the inventory allocation relationship between a sales channel partner and a finished good. Each record captures the partners stock level, supply metrics, and reporting obligations for a specific finished good.. Existence Justification: Channel partners actively manage inventory for multiple finished goods, and each finished good can be stocked by multiple channel partners. The business records per‑partner‑product metrics such as stock on hand, weeks of supply, sell‑through rate, and reporting obligations, which are updated and maintained as part of the partner‑inventory management process.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` (
    `opportunity_project_assignment_id` BIGINT COMMENT 'Primary key',
    `ic_design_project_id` BIGINT COMMENT 'FK to IC design project',
    `employee_id` BIGINT COMMENT 'Unique identifier for the opportunity approved by employee record within the opportunity project assignment sales entity.',
    `opportunity_assigned_by_employee_id` BIGINT COMMENT 'FK to assigning employee',
    `opportunity_employee_id` BIGINT COMMENT 'Unique identifier for the opportunity employee record within the opportunity project assignment sales entity.',
    `opportunity_id` BIGINT COMMENT 'FK to opportunity',
    `project_id` BIGINT COMMENT 'FK to research project',
    `allocation_pct` DECIMAL(18,2) COMMENT 'Allocation percentage',
    `allocation_percent` DECIMAL(18,2) COMMENT 'The allocation percent of the opportunity project assignment record in the sales domain.',
    `approved_date` DATE COMMENT 'The approved date associated with the opportunity project assignment sales record.',
    `assigned_by` STRING COMMENT 'The assigned by of the opportunity project assignment record in the sales domain.',
    `assigned_date` DATE COMMENT 'The assigned date associated with the opportunity project assignment sales record.',
    `assignment_date` DATE COMMENT 'The assignment date associated with the opportunity project assignment sales record.',
    `assignment_end_date` DATE COMMENT 'The assignment end date associated with the opportunity project assignment sales record.',
    `assignment_notes` STRING COMMENT 'The assignment notes of the opportunity project assignment record in the sales domain.',
    `assignment_priority` STRING COMMENT 'The assignment priority of the opportunity project assignment record in the sales domain.',
    `assignment_role` STRING COMMENT 'The assignment role of the opportunity project assignment record in the sales domain.',
    `assignment_start_date` DATE COMMENT 'The assignment start date associated with the opportunity project assignment sales record.',
    `assignment_status` STRING COMMENT 'The assignment status of the opportunity project assignment record in the sales domain.',
    `billing_rate_usd` DECIMAL(18,2) COMMENT 'The billing rate usd of the opportunity project assignment record in the sales domain.',
    `created_at` TIMESTAMP COMMENT 'The created at of the opportunity project assignment record in the sales domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the opportunity project assignment record in the sales domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the opportunity project assignment sales record.',
    `design_win_probability` DECIMAL(18,2) COMMENT 'The design win probability of the opportunity project assignment record in the sales domain.',
    `effort_allocation_pct` DECIMAL(18,2) COMMENT 'Effort allocation percentage',
    `end_date` DATE COMMENT 'The end date associated with the opportunity project assignment sales record.',
    `estimated_contribution` DECIMAL(18,2) COMMENT 'The estimated contribution of the opportunity project assignment record in the sales domain.',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value of the opportunity project assignment record in the sales domain.',
    `expected_close_date` DATE COMMENT 'The expected close date associated with the opportunity project assignment sales record.',
    `expected_end_date` DATE COMMENT 'The expected end date associated with the opportunity project assignment sales record.',
    `expected_revenue` DECIMAL(18,2) COMMENT 'The expected revenue of the opportunity project assignment record in the sales domain.',
    `expected_revenue_impact` DECIMAL(18,2) COMMENT 'The expected revenue impact of the opportunity project assignment record in the sales domain.',
    `expected_revenue_share_pct` DECIMAL(18,2) COMMENT 'Expected revenue share percentage',
    `expected_start_date` DATE COMMENT 'The expected start date associated with the opportunity project assignment sales record.',
    `expected_volume_units` BIGINT COMMENT 'The expected volume units of the opportunity project assignment record in the sales domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the opportunity project assignment record in the sales domain.',
    `milestone_alignment` STRING COMMENT 'Milestone alignment description',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the opportunity project assignment record in the sales domain.',
    `notes` STRING COMMENT 'The notes of the opportunity project assignment record in the sales domain.',
    `opportunity_project_assignment_status` STRING COMMENT 'The status of the opportunity project assignment record in the sales domain.',
    `opportunity_role` STRING COMMENT 'Role of opportunity in project',
    `primary_contact_flag` BOOLEAN COMMENT 'The primary contact flag of the opportunity project assignment record in the sales domain.',
    `priority` STRING COMMENT 'The priority of the opportunity project assignment record in the sales domain.',
    `resource_type` STRING COMMENT 'The resource type of the opportunity project assignment record in the sales domain.',
    `skill_requirements` STRING COMMENT 'The skill requirements of the opportunity project assignment record in the sales domain.',
    `updated_at` TIMESTAMP COMMENT 'The updated at of the opportunity project assignment record in the sales domain.',
    CONSTRAINT pk_opportunity_project_assignment PRIMARY KEY(`opportunity_project_assignment_id`)
) COMMENT 'This association captures the operational relationship between a sales opportunity and an R&D project. Each record links one opportunity to one project and stores attributes that belong only to the partnership, such as the projects role in the opportunity and the estimated revenue contribution.. Existence Justification: In the semiconductor business, a sales opportunity can be supported by multiple R&D projects, and a single R&D project can provide value to many different opportunities. The link is actively managed by sales and research teams, who record the role of the project and its estimated revenue contribution for each opportunity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` (
    `lead_program_interest_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `employee_id` BIGINT COMMENT 'FK to capturing employee',
    `family_id` BIGINT COMMENT 'FK to product family',
    `lead_id` BIGINT COMMENT 'FK to lead',
    `research_program_id` BIGINT COMMENT 'FK to research program',
    `application_segment` STRING COMMENT 'The application segment of the lead program interest record in the sales domain.',
    `commercial_fit_score` STRING COMMENT 'The commercial fit score of the lead program interest record in the sales domain.',
    `competitive_incumbent` STRING COMMENT 'The competitive incumbent of the lead program interest record in the sales domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the lead program interest record in the sales domain.',
    `decision_timeline_months` STRING COMMENT 'The decision timeline months of the lead program interest record in the sales domain.',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value of the lead program interest record in the sales domain.',
    `estimated_volume` BIGINT COMMENT 'The estimated volume of the lead program interest record in the sales domain.',
    `estimated_volume_units` BIGINT COMMENT 'The estimated volume units of the lead program interest record in the sales domain.',
    `expressed_date` DATE COMMENT 'Date interest was expressed',
    `follow_up_date` DATE COMMENT 'The follow up date associated with the lead program interest sales record.',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the lead program interest record in the sales domain.',
    `follow_up_status` STRING COMMENT 'The follow up status of the lead program interest record in the sales domain.',
    `interest_area` STRING COMMENT 'The interest area of the lead program interest record in the sales domain.',
    `interest_category` STRING COMMENT 'The interest category of the lead program interest record in the sales domain.',
    `interest_date` DATE COMMENT 'The interest date associated with the lead program interest sales record.',
    `interest_level` STRING COMMENT 'The interest level of the lead program interest record in the sales domain.',
    `interest_notes` STRING COMMENT 'The interest notes of the lead program interest record in the sales domain.',
    `interest_recorded_date` DATE COMMENT 'The interest recorded date associated with the lead program interest sales record.',
    `interest_source` STRING COMMENT 'Source of interest',
    `interest_status` STRING COMMENT 'The interest status of the lead program interest record in the sales domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the lead program interest record in the sales domain.',
    `lead_interest_score` DECIMAL(18,2) COMMENT 'The lead interest score of the lead program interest record in the sales domain.',
    `lead_program_interest_status` STRING COMMENT 'The status of the lead program interest record in the sales domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the lead program interest record in the sales domain.',
    `notes` STRING COMMENT 'The notes of the lead program interest record in the sales domain.',
    `product_family_of_interest` STRING COMMENT 'The product family of interest of the lead program interest record in the sales domain.',
    `program_category` STRING COMMENT 'The program category of the lead program interest record in the sales domain.',
    `program_fit_rating` STRING COMMENT 'The program fit rating of the lead program interest record in the sales domain.',
    `qualification_status` STRING COMMENT 'The qualification status of the lead program interest record in the sales domain.',
    `registered_date` DATE COMMENT 'The registered date associated with the lead program interest sales record.',
    `source_channel` STRING COMMENT 'The source channel of the lead program interest record in the sales domain.',
    `target_application` STRING COMMENT 'The target application of the lead program interest record in the sales domain.',
    `target_node` STRING COMMENT 'Target technology node',
    `target_price_point_usd` DECIMAL(18,2) COMMENT 'The target price point usd of the lead program interest record in the sales domain.',
    `technical_fit_score` STRING COMMENT 'The technical fit score of the lead program interest record in the sales domain.',
    `volume_estimate_qty` STRING COMMENT 'The volume estimate qty of the lead program interest record in the sales domain.',
    `volume_estimate_units` STRING COMMENT 'The volume estimate units of the lead program interest record in the sales domain.',
    CONSTRAINT pk_lead_program_interest PRIMARY KEY(`lead_program_interest_id`)
) COMMENT 'This association captures the interest relationship between sales leads and R&D programs. Each record links one lead to one program and stores attributes that describe the strength of interest and fit, which are not appropriate to store on either the lead or the program entity alone.. Existence Justification: A sales lead can express interest in multiple R&D programs, and each R&D program can receive interest from many leads. The relationship is actively managed by marketing and R&D teams to track fit and prioritize outreach. The mapping carries its own attributes (interest score, fit rating) that belong to the relationship itself.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user responsible for the campaign.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the campaign sales entity.',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory record within the campaign sales entity.',
    `actual_leads` STRING COMMENT 'The actual leads of the campaign record in the sales domain.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total spend recorded against the campaign to date.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the user who approved the campaign budget and plan.',
    `audience_segment` STRING COMMENT 'Defined audience segment or persona targeted by the campaign.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget allocated for the campaign.',
    `budget_usd` DECIMAL(18,2) COMMENT 'The budget usd of the campaign record in the sales domain.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.',
    `campaign_type` STRING COMMENT 'Category of the campaign indicating its primary purpose.',
    `channel` STRING COMMENT 'Primary marketing channel used to deliver the campaign.',
    `campaign_code` STRING COMMENT 'External or legacy code used to reference the campaign in marketing systems.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign complies with internal and external regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the campaign sales record.',
    `campaign_description` STRING COMMENT 'Detailed free‑text description of the campaign objectives and scope.',
    `end_date` DATE COMMENT 'Planned or actual end date of the campaign.',
    `expected_leads` STRING COMMENT 'The expected leads of the campaign record in the sales domain.',
    `external_campaign_code` STRING COMMENT 'Identifier of the campaign in an external marketing platform (e.g., Salesforce, Marketo).',
    `kpi_actual` STRING COMMENT 'Actual measured value for the primary KPI of the campaign.',
    `kpi_target` STRING COMMENT 'Target value for the primary KPI of the campaign (e.g., leads, pipeline value).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the campaign record in the sales domain.',
    `marketing_platform` STRING COMMENT 'Marketing automation platform used to execute the campaign.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the marketing campaign.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by campaign managers.',
    `objective` STRING COMMENT 'High‑level business objective the campaign aims to achieve (e.g., lead generation, brand awareness).',
    `priority` STRING COMMENT 'Business priority level assigned to the campaign.',
    `region` STRING COMMENT 'Primary geographic region for campaign execution.',
    `risk_level` STRING COMMENT 'Assessed risk level for the campaign execution.',
    `roi_estimate` DECIMAL(18,2) COMMENT 'Projected return on investment for the campaign, expressed as a percentage.',
    `start_date` DATE COMMENT 'Planned or actual start date of the campaign.',
    `target_market` STRING COMMENT 'Geographic or industry market segment the campaign is aimed at.',
    `target_product_family` STRING COMMENT 'Product family or portfolio the campaign promotes.',
    `target_segment` STRING COMMENT 'The target segment of the campaign record in the sales domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_primary_quote_opportunity_id` FOREIGN KEY (`primary_quote_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_tertiary_quote_id` FOREIGN KEY (`tertiary_quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_primary_customer_opportunity_id` FOREIGN KEY (`primary_customer_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_primary_booking_opportunity_id` FOREIGN KEY (`primary_booking_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_primary_lead_opportunity_id` FOREIGN KEY (`primary_lead_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_primary_sales_channel_partner_id` FOREIGN KEY (`primary_sales_channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_primary_channel_partner_id` FOREIGN KEY (`primary_channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`lead`(`lead_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_primary_activity_opportunity_id` FOREIGN KEY (`primary_activity_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ADD CONSTRAINT `fk_sales_partner_inventory_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ADD CONSTRAINT `fk_sales_lead_program_interest_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ADD CONSTRAINT `fk_sales_lead_program_interest_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`lead`(`lead_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_landscape` SET TAGS ('dbx_business_glossary_term' = 'Competitive Landscape Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'nre|license|royalty|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'automotive|mobile|ai|iot|computing|telecom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Gross Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Net Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'americas|emea|apac');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|partner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|design_in|design_win|production_ramp|won|lost');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|chips|dies|wafers');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `win_loss_date` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Reason');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `primary_quote_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_description` SET TAGS ('dbx_business_glossary_term' = 'Quote Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Quote Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepay|cash');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|expired|converted');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `reason_lost` SET TAGS ('dbx_business_glossary_term' = 'Reason for Quote Loss');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Quote Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = '1-99|100-999|1000-9999|10000+');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Win/Loss Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|open');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tertiary_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Quote Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `customer_requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Custom Product Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Weeks');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_comment` SET TAGS ('dbx_business_glossary_term' = 'Line Comment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_value_regex' = 'draft|sent|accepted|rejected|expired');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner|reseller|OEM');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|APJ|LATAM|CHINA');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Line Total Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `warranty_years` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` SET TAGS ('dbx_ssot_owner' = 'design_win');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` SET TAGS ('dbx_ssot_counterpart' = 'customer.customer_design_win');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Device ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Customer Design Win Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `competitor_displaced` SET TAGS ('dbx_business_glossary_term' = 'Competitor Displaced');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `competitor_displacement_score` SET TAGS ('dbx_business_glossary_term' = 'Competitor Displacement Score (DISP_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (REG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `design_win_name` SET TAGS ('dbx_business_glossary_term' = 'Design Win Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `design_win_number` SET TAGS ('dbx_business_glossary_term' = 'Design Win Number (DWN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `design_win_status` SET TAGS ('dbx_business_glossary_term' = 'Design Win Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displaced_competitor_code` SET TAGS ('dbx_business_glossary_term' = 'Displaced Competitor ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_business_glossary_term' = 'Displaced Device ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Displacement Reason (DISP_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `displacement_reason` SET TAGS ('dbx_value_regex' = 'price|performance|power|integration|availability|other');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `end_application` SET TAGS ('dbx_business_glossary_term' = 'End Application');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Gross Revenue (EAGR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Net Revenue (EANR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Unit Volume (AUV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Volume');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `export_controlled` SET TAGS ('dbx_business_glossary_term' = 'Export Controlled Flag (EXPORT_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `forecast_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy (FCST_ACC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `forecasted_ramp_rate_per_month` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Ramp Rate Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `is_key_account` SET TAGS ('dbx_business_glossary_term' = 'Key Account Flag (KEY_ACCOUNT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `lifetime_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Revenue Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (SEGMENT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'consumer|automotive|industrial|communications|data_center|other');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Design Win Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|custom|volume|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|NAM|LATAM');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment (REV_ADJ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `revenue_ramp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ramp End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `revenue_ramp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ramp Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_status` SET TAGS ('dbx_business_glossary_term' = 'Design Win Status (DWS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `sales_territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory (TERRITORY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (APP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `win_date` SET TAGS ('dbx_business_glossary_term' = 'Win Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `win_source` SET TAGS ('dbx_business_glossary_term' = 'Design Win Source (WIN_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `win_source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|manual|partner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ALTER COLUMN `win_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Timestamp (DWT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` SET TAGS ('dbx_ssot_owner' = 'finance.finance_nre_agreement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Nre Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_business_glossary_term' = 'Actual Recognized Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'custom|standard|partner|internal');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `authoritative_finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Finance Nre Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `completed_milestones` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestones');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Reference');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_value_regex' = 'RTL|GDS|PDK|Tapeout|Documentation');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `invoice_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Trigger Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Clause');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `last_milestone_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Planned Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NRE Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_delivery|milestone');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|LATAM|JAPAC');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `total_milestones` SET TAGS ('dbx_business_glossary_term' = 'Total Milestones');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `total_nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Nre Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID (SBPLID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ATYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|incentive|markdown|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (ATRL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description (PLD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market (EM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Price List (IDPL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name (PLN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status (PLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|distributor|oem|spot');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `pricing_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Code (PCC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (PC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `validity_end` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `validity_start` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VSD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price List Version (PLV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `volume_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Tier (VTX)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `volume_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Tier (VTM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Identifier (CCI)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Identifier (COI)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `primary_customer_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (ACNT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `annual_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Flag (ACF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag (ARF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag (CCF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Title (CT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CTYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'supply|service|license|nre');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (CR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'AAA|AA|A|BBB|BB|B');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CUR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status (CLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|draft|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (DR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `eol_clause` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Clause (EOL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency (INV_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `ltb_provision` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Provision (LTB)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAXQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_T)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid|upon_delivery');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pcn_obligation` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Obligation (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_business_glossary_term' = 'Supply Scope (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_value_regex' = 'exclusive|multi_source|global');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (TN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TNP_D)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment (VC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `channel_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `channel_tier` SET TAGS ('dbx_value_regex' = 'direct|distribution|partner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Territory Hierarchy Path');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `is_overlay` SET TAGS ('dbx_business_glossary_term' = 'Overlay Territory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `multi_rep_coverage` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Representative Coverage Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|product|strategic|customer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `unit_target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Target Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `sales_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `effective_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `effective_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^FYd{4}Q[1-4]$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'demand|supply|capacity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'commit|upside|best_case');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Units');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography (Country Code)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Forecast Locked Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `last_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_value_regex' = 'Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|pcs|die|wafer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `variance_to_actual` SET TAGS ('dbx_business_glossary_term' = 'Variance to Actual (%)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier (BKID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Location Identifier (SHIP_LOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (SR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `primary_booking_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Indicator (IS_BACKLOG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Booked Quantity (BK_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Booked Revenue (BK_REVENUE_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Net Booked Revenue (BK_REVENUE_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Number (BKNO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status (BK_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|fulfilled|cancelled|backlog');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Event Timestamp (BK_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Booking Comments (BK_COMMENTS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode (DELIVERY_MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'air|sea|ground|pickup');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `external_order_ref` SET TAGS ('dbx_business_glossary_term' = 'External Order Reference (EXT_ORDER_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `forecast_flag` SET TAGS ('dbx_business_glossary_term' = 'Forecast Inclusion Flag (IN_FORECAST)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Booking Indicator (IS_CRITICAL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORDER_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|nre|design_win|service|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|contract|discounted|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Booking Priority Level (PRIORITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PFAM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REV_RECOG_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SALES_REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Country Code (SHIP_COUNTRY_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source System (BK_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|manual');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `total_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months) (WARRANTY_MTHS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID (ACCOUNT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID (CAMPAIGN_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Owner ID (LEAD_OWNER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `primary_lead_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `company_industry` SET TAGS ('dbx_business_glossary_term' = 'Company Industry (COMPANY_INDUSTRY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name (COMPANY_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (CONTACT_EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (CONTACT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (CONTACT_PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date (CONVERSION_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Conversion Outcome (CONVERSION_OUTCOME)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|no_decision');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Creation Timestamp (LEAD_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DATA_CLASSIFICATION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `device_interest` SET TAGS ('dbx_business_glossary_term' = 'Device Interest (DEVICE_INTEREST)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity (EST_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue (EST_REVENUE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date (EXPECTED_CLOSE_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `is_nre` SET TAGS ('dbx_business_glossary_term' = 'Is NRE Lead (IS_NRE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `itar_required` SET TAGS ('dbx_business_glossary_term' = 'ITAR Required (ITAR_REQUIRED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MODIFIED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Last Modified Timestamp (LEAD_MODIFIED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_business_glossary_term' = 'Lead Number (LEAD_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status (LEAD_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'new|qualified|disqualified|converted|closed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type (LEAD_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'design_win|design_in|pre_sales|post_sales');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEGMENT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `lead_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lead Notes (LEAD_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Lead Priority (LEAD_PRIORITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Lead Rating (LEAD_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score (LEAD_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source (LEAD_SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'web|email|event|referral|partner|campaign');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (TARGET_APP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (TECH_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` SET TAGS ('dbx_subdomain' = 'partner_enablement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `authorized_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Lines');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|suspended');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `external_partner_code` SET TAGS ('dbx_business_glossary_term' = 'External Partner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_business_glossary_term' = 'Consignment Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `inventory_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reporting Obligation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (LE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'distributor|value_added_reseller|system_integrator|rep_firm|online_marketplace');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `price_protection_claims_allowed` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Claims Allowed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume_based|rebate|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `sap_partner_function_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Partner Function Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell‑Through Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `stock_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Stock On Hand (Units)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Classification');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'authorized|preferred|elite');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` SET TAGS ('dbx_subdomain' = 'partner_enablement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` SET TAGS ('dbx_ssot_owner' = 'design_registration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` SET TAGS ('dbx_ssot_counterpart' = 'customer.customer_design_registration');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Registration Identifier (SDR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Firm Identifier (SRF_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `primary_sales_channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Identifier (DIST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (DESIGN_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Customer Design Registration Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments (APPROVAL_CMTS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AUDIT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number (CLAIM_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag (ISO9001_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_itar` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Flag (ITAR_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_rohs` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `device_family` SET TAGS ('dbx_business_glossary_term' = 'Device Family (DEV_FAM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `device_part_number` SET TAGS ('dbx_business_glossary_term' = 'Device Part Number (DEV_PN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (DISC_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `end_application` SET TAGS ('dbx_business_glossary_term' = 'End Application (END_APP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_business_glossary_term' = 'End Customer Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `estimated_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Volume (EST_VOL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Expiration Reason (EXP_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `is_channel_conflict` SET TAGS ('dbx_business_glossary_term' = 'Channel Conflict Flag (CHANNEL_CONF_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `is_price_protected` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag (PRICE_PROT_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `protected_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Protected Price (USD) (PROT_PRICE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NAM|EMEA|APAC|LATAM|AFR|CAN');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number (REG_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type (REG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'design_win|price_protection|other');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `sales_rep_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Firm Name (SRF_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `special_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Pricing Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUBMIT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (TECH_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (MM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` SET TAGS ('dbx_subdomain' = 'partner_enablement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `primary_channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Partner Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'periodic|event_based|continuous');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Rebate Calculation Method');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'tiered_percentage|flat_rate|tiered_flat|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_program_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `financial_account_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Account Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `financial_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `financial_account_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Program Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `max_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payout Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'distributor|customer|reseller|integrator|other');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `payout_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payout Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `payout_schedule` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|upon_settlement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'volume|growth|design_win|marketing_development_fund|incentive|other');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_program_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Program Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|rejected|partial');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `tier1_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Rebate Rate');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `tier1_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `tier2_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Rebate Rate');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `tier2_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `primary_activity_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|postponed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp (ACTIVITY_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type (ACTIVITY_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel (CHANNEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|virtual|phone|email');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Activity Duration (DURATION_MINUTES)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Result (EVALUATION_RESULT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `is_internal` SET TAGS ('dbx_business_glossary_term' = 'Is Internal Activity (IS_INTERNAL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location (LOCATION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date (NEXT_ACTION_DUE_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome (OUTCOME)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `sample_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Approval Status (SAMPLE_APPROVAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `sample_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity (SAMPLE_QUANTITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Subject');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` SET TAGS ('dbx_subdomain' = 'partner_enablement');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` SET TAGS ('dbx_association_edges' = 'sales.channel_partner,inventory.finished_good');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `partner_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Inventory - Partner Inventory Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Inventory - Channel Partner Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Inventory - Finished Good Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `as_of_date` SET TAGS ('dbx_business_glossary_term' = 'As Of Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `backorder_qty` SET TAGS ('dbx_business_glossary_term' = 'Backorder Qty');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `consignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Of Supply');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `excess_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `forecast_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Qty');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `in_transit_qty` SET TAGS ('dbx_business_glossary_term' = 'In Transit Qty');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In Transit Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `inventory_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reporting Obligation');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `inventory_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Snapshot Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `inventory_turn_rate` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turn Rate');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `inventory_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `lot_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `next_order_date` SET TAGS ('dbx_business_glossary_term' = 'Next Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `obsolete_flag` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'On Hand Qty');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `partner_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Inventory Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_committed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Committed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `quantity_sold_through` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold Through');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `report_period` SET TAGS ('dbx_business_glossary_term' = 'Report Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `report_source` SET TAGS ('dbx_business_glossary_term' = 'Report Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `reserved_qty` SET TAGS ('dbx_business_glossary_term' = 'Reserved Qty');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `sell_through_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sell Through Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Partner Sell‑Through Rate');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `stock_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Stock In Transit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `stock_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Partner Stock On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `units_received_in_period` SET TAGS ('dbx_business_glossary_term' = 'Units Received In Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `units_sold_in_period` SET TAGS ('dbx_business_glossary_term' = 'Units Sold In Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Partner Weeks of Supply');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` SET TAGS ('dbx_association_edges' = 'sales.opportunity,research.project');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Project Assignment Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `design_win_probability` SET TAGS ('dbx_business_glossary_term' = 'Design Win Probability');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `effort_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Effort Allocation Pct');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `estimated_contribution` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contribution');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `expected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `expected_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue Impact');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `expected_revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue Share Pct');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `expected_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Expected Volume Units');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `milestone_alignment` SET TAGS ('dbx_business_glossary_term' = 'Milestone Alignment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_project_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Project Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `opportunity_role` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Role');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` SET TAGS ('dbx_association_edges' = 'sales.lead,research.program');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `lead_program_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Program Interest Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Captured By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `application_segment` SET TAGS ('dbx_business_glossary_term' = 'Application Segment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `estimated_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Units');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `expressed_date` SET TAGS ('dbx_business_glossary_term' = 'Expressed Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_area` SET TAGS ('dbx_business_glossary_term' = 'Interest Area');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_category` SET TAGS ('dbx_business_glossary_term' = 'Interest Category');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_level` SET TAGS ('dbx_business_glossary_term' = 'Interest Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Recorded Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_source` SET TAGS ('dbx_business_glossary_term' = 'Interest Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `lead_interest_score` SET TAGS ('dbx_business_glossary_term' = 'Lead Interest Score');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `lead_program_interest_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Program Interest Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `product_family_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Product Family Of Interest');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `program_fit_rating` SET TAGS ('dbx_business_glossary_term' = 'Program Fit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `registered_date` SET TAGS ('dbx_business_glossary_term' = 'Registered Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ALTER COLUMN `target_node` SET TAGS ('dbx_business_glossary_term' = 'Target Node');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `actual_leads` SET TAGS ('dbx_business_glossary_term' = 'Actual Leads');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Usd');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `expected_leads` SET TAGS ('dbx_business_glossary_term' = 'Expected Leads');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `external_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'External Campaign Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `kpi_actual` SET TAGS ('dbx_business_glossary_term' = 'Kpi Actual');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `kpi_target` SET TAGS ('dbx_business_glossary_term' = 'Kpi Target');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `marketing_platform` SET TAGS ('dbx_business_glossary_term' = 'Marketing Platform');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `roi_estimate` SET TAGS ('dbx_business_glossary_term' = 'Roi Estimate');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `target_product_family` SET TAGS ('dbx_business_glossary_term' = 'Target Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
