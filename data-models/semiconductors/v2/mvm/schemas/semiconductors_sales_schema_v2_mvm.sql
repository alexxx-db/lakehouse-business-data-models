-- Schema for Domain: sales | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`sales` COMMENT 'Sales pipeline, opportunities, quotes, design-win campaigns, NRE agreements, pricing, and customer contracts. Manages sales territories, account assignments, forecast accuracy, revenue targets by product family, end market, and geography. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the sales opportunity.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account linked to the opportunity.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Opportunity Management process requires a primary contact person; linking to customer.contact enables accurate follow‑up and reporting.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: In semiconductors, sales opportunities are directly spawned from or validated by design wins. Design-win-to-opportunity conversion rate is a core semiconductor sales KPI. Pipeline reporting requires l',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Opportunity pipeline dashboards aggregate by product family to forecast revenue.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design-win tracking in semiconductor sales requires linking an opportunity to the specific IC part number selected by the customer. Revenue forecasting by part number, design-win reports, and lifecycl',
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
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the opportunity record.',
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
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: In semiconductor sales, quotes issued to customers under long-term supply contracts must reference the governing contract to apply contract-specific pricing, volume tiers, and delivery terms. A quote ',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Semiconductor quotes are frequently issued specifically for a design win engagement. Design-win-to-quote pipeline tracking and win-rate analysis require this link. Sales operations teams use it to mea',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Semiconductor quotes are priced based on the specific fab facility and technology node that will manufacture the product. Sales engineers need this link to apply correct cost structures, lead times, a',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Quote header must be tied to a product family for contract and pricing governance.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Quotes are generated based on a defined process flow; the link supports pricing, lead‑time, and qualification status.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Quotes are generated for design projects; linking enables financial forecasting of design spend.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Semiconductor quotes are generated against negotiated price agreements that govern unit price, discount, and volume tiers. Pricing compliance audits and quote approval workflows require traceability f',
    `price_list_id` BIGINT COMMENT 'FK to sales.price_list.price_list_id — Quotes reference the applicable price list for base pricing. Essential for pricing compliance and margin analysis.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Quotes are generated in the context of an opportunity. This is the core pipeline-to-commercial link. Required for quote-to-win conversion tracking.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Quotes for production volumes in semiconductors are only valid when the target process is qualified. Linking quote to process_qualification enables quote validity gating, customer approval status trac',
    `source_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Every quote is generated in context of an opportunity — this is the core pipeline-to-commercial conversion link. Engineers need this to trace quote→opportunity for pipeline reporting.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Tapeout-based quote pricing: sales quotes for a specific chip reference the tapeout to pull die size, yield estimate, mask cost, and process node for accurate pricing. A semiconductor pricing analyst ',
    `conversion_date` TIMESTAMP COMMENT 'Timestamp when the quote was converted to an order, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the quote amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Additional delivery conditions beyond Incoterms, such as FOB destination or DAP warehouse.',
    `quote_description` STRING COMMENT 'Free‑form text describing the scope, special conditions, or notes for the quote.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross amount.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the quote has been converted to a sales order.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order receipt to delivery.',
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
    `volume_tier` STRING COMMENT 'Quantity bracket that determines unit pricing.. Valid values are `1-99|100-999|1000-9999|10000+`',
    `win_loss_status` STRING COMMENT 'Outcome of the quote after the decision period.. Valid values are `won|lost|open`',
    `valid_from` DATE COMMENT 'Date from which the quoted terms become effective.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Transaction record: Commercial price quotation issued to a customer or prospect for semiconductor products including ICs, packaged devices, wafer-level products, and IP licensing. Captures quoted unit price, volume tiers, lead time, validity period, incoterms, currency, and SAP SD quotation reference. Tracks quote-to-order conversion and win/loss outcomes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line record.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Quote lines often represent IP core licensing; linking tracks IP revenue and compliance.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Quoting bare die / KGD products requires referencing the specific die_bank to confirm availability and price. Distinct from finished_good (packaged) quoting. Semiconductor companies quote die-level pr',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Enables quote‑level reporting and margin analysis by product family.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Quote line pricing and availability require linking to the specific finished good inventory record for SKU, enabling real-time stock checks during quoting.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Foundry quote lines are priced by process flow — node, metal layer count, and cycle time directly determine cost basis and lead time. A domain expert would expect each quote line to reference the spec',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Export control screening (ECCN/ITAR) and compliance checks during quoting require direct ic_catalog reference at the line level. Semiconductor sales ops must validate each quoted parts export classif',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Quote line items must reference the material master to obtain accurate part numbers, cost, and lead‑time for procurement planning, used in the Quote‑to‑Order workflow.',
    `quote_id` BIGINT COMMENT 'Identifier of the parent sales quote to which this line belongs.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Semiconductor quote lines for custom or qualified products must reference the governing quality specification (AQL, acceptance criteria, test type). Quality-spec-driven pricing and lead times are stan',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for accurate pricing, inventory and compliance tracking in quote lines.',
    `tertiary_quote_id` BIGINT COMMENT 'FK to sales.quote.quote_id — Header-detail relationship: quote_line cannot exist without its parent quote. Critical for quote value calculation and line-level pricing analysis.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the lines revenue is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quote line was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the quote (e.g., USD, EUR).',
    `customer_requested_delivery_date` DATE COMMENT 'Date the customer expects delivery of the quoted items.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the unit price.',
    `effective_date` DATE COMMENT 'Date on which the quoted terms become effective.',
    `expiration_date` DATE COMMENT 'Date after which the quoted terms are no longer valid.',
    `internal_approval_status` STRING COMMENT 'Status of internal sales or finance approval for the line.. Valid values are `pending|approved|rejected`',
    `is_custom` BOOLEAN COMMENT 'True if the quoted SKU is a custom or engineered product.',
    `is_price_locked` BOOLEAN COMMENT 'True if the quoted price is locked and cannot be changed without re‑quote.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order to shipment.',
    `line_comment` STRING COMMENT 'Free‑form comment entered by the sales rep for this line.',
    `line_number` STRING COMMENT 'Sequential number of the line within the quote for ordering.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` (
    `nre_agreement_id` BIGINT COMMENT 'Surrogate primary key for the NRE agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party for whom the NRE work is performed.',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: NRE (Non-Recurring Engineering) agreements in semiconductor custom IC/ASIC development are frequently executed under or alongside a broader customer supply contract. The sales_nre_agreement currently ',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: NRE agreements in semiconductors fund the design work associated with a specific design win. NRE milestone tracking, revenue recognition, and design-win profitability analysis all require linking the ',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: NRE agreements in semiconductors fund specific fab tool procurement or process development. Milestone payments are triggered by tool readiness events. Sales ops and finance teams track which fab tool ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: NRE agreements are allocated to product families for cost recovery and reporting.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: NRE agreements are scoped to a specific process flow; linking enables milestone tracking against that flow.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NRE agreements in semiconductor sales fund development of a specific IC part. Linking to ic_catalog enables NRE cost recovery tracking against the product lifecycle, royalty amortization reporting, an',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: Semiconductor NRE agreements are executed under a governing NDA that protects IP and design confidentiality. Legal and compliance teams require the NRE-to-NDA link for contract management, IP protecti',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — NRE agreements are commercial vehicles arising from ASIC/custom IC opportunities. Required for NRE pipeline tracking.',
    `actual_revenue_recognized` DECIMAL(18,2) COMMENT 'Revenue recognized to date according to accounting standards.',
    `agreement_number` STRING COMMENT 'Unique business identifier for the NRE agreement, used in contracts and invoicing.',
    `agreement_type` STRING COMMENT 'Classification of the NRE agreement type.. Valid values are `custom|standard|partner|internal`',
    `approval_status` STRING COMMENT 'Current approval state of the milestone deliverable.. Valid values are `pending|approved|rejected`',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if a change order has been issued for the agreement.',
    `change_order_number` STRING COMMENT 'Identifier of the change order associated with the agreement.',
    `completed_milestones` STRING COMMENT 'Number of milestones that have been completed.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the agreement content.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the NRE amount.. Valid values are `[A-Z]{3}`',
    `deliverable_type` STRING COMMENT 'Type of deliverable associated with the milestone.. Valid values are `RTL|GDS|PDK|Tapeout|Documentation`',
    `effective_end_date` DATE COMMENT 'Date when the NRE agreement ends or expires; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the NRE agreement becomes binding.',
    `exclusivity_flag` BOOLEAN COMMENT 'True if the agreement grants exclusive rights to the customer for the developed IP.',
    `forecasted_revenue` DECIMAL(18,2) COMMENT 'Projected revenue from the NRE agreement for forecasting purposes.',
    `invoice_trigger_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers an invoice generation.',
    `ip_ownership_clause` STRING COMMENT 'Specifies IP ownership rights granted by the agreement.. Valid values are `full|partial|none`',
    `last_milestone_completed_date` DATE COMMENT 'Date of the most recent milestone that has been completed.',
    `milestone_actual_date` DATE COMMENT 'Actual completion date recorded for the milestone.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Fee associated with the milestone, invoiced upon completion.',
    `milestone_name` STRING COMMENT 'Name of a specific NRE milestone (e.g., RTL Freeze, Tapeout).',
    `milestone_planned_date` DATE COMMENT 'Planned completion date for the milestone.',
    `milestone_sequence` STRING COMMENT 'Order of the milestone within the agreement schedule.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the agreement.',
    `nre_total_amount` DECIMAL(18,2) COMMENT 'Total contracted NRE fee for the agreement.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing invoicing of NRE fees.. Valid values are `net30|net45|net60|upon_delivery|milestone`',
    `risk_assessment_score` STRING COMMENT 'Internal risk rating (1‑5) for the NRE project.',
    `sales_nre_agreement_status` STRING COMMENT 'Current lifecycle status of the NRE agreement.. Valid values are `draft|active|suspended|terminated|closed`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the agreement.. Valid values are `APAC|EMEA|AMER|LATAM|JAPAC`',
    `termination_date` DATE COMMENT 'Date on which the agreement was terminated.',
    `termination_reason` STRING COMMENT 'Reason provided if the agreement is terminated before completion.',
    `total_milestones` STRING COMMENT 'Total number of milestones defined in the agreement.',
    `updated_by` STRING COMMENT 'User identifier who last modified the agreement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `created_by` STRING COMMENT 'User identifier who created the agreement record.',
    CONSTRAINT pk_nre_agreement PRIMARY KEY(`nre_agreement_id`)
) COMMENT 'Master record: Non-Recurring Engineering (NRE) agreement governing custom IC or ASIC development engagements. Captures NRE fee structure, milestone payment schedule with individual billing/delivery milestones (RTL freeze, tapeout, first silicon, qualification), deliverables (RTL, GDS, PDK, tapeout), IP ownership terms, exclusivity clauses, and SAP SD contract reference. Contains milestone detail records tracking milestone name, planned/actual completion dates, milestone amounts, invoice trigger flags, approval status, and completion workflow. Enables NRE revenue recognition scheduling and project tracking. SSOT for all NRE commercial terms and milestone execution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Price lists are defined per product family to enforce consistent pricing policies.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Foundry price lists are structured by process node/flow — 7nm, 28nm, and 65nm carry distinct pricing tiers. Linking price_list to process_flow enables node-level pricing governance and replaces the de',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Semiconductor price lists are structured at SKU level — different packages, speed grades, and temperature grades carry distinct list prices. Standard pricing master data management and price book gene',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to a newer price list that supersedes this one.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the price adjustment.',
    `adjustment_reason` STRING COMMENT 'Business reason or justification for the price adjustment.',
    `adjustment_type` STRING COMMENT 'Type of price adjustment applied to the base price.. Valid values are `rebate|discount|incentive|markdown|none`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was approved.',
    `audit_trail` STRING COMMENT 'Append-only log of changes to the price list record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was created.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.. Valid values are `[A-Z]{3}`',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the price becomes effective.',
    `effective_until` DATE COMMENT 'Date when the price expires or is superseded.',
    `end_market` STRING COMMENT 'Target market segment (e.g., automotive, mobile, data center).',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this price list is the default for its scope.',
    `price_list_name` STRING COMMENT 'Descriptive name of the price list.',
    `notes` STRING COMMENT 'Free-form notes or comments about the price list.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list.. Valid values are `active|inactive|archived|pending`',
    `price_type` STRING COMMENT 'Category of pricing defined by the list (e.g., standard list, distributor, OEM, spot).. Valid values are `list|distributor|oem|spot`',
    `pricing_condition_code` STRING COMMENT 'SAP SD pricing condition record identifier.',
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
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Semiconductor customer contracts enforce credit limits and ratings from the customers credit profile. Contract approval workflows and credit hold enforcement require this direct link. credit_limit an',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Supply contracts in semiconductors specify the approved source of supply (fab facility). This is a contractual compliance requirement — customers require that production occurs at the contracted fab, ',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Supply contracts in semiconductors specify the exact process flow for production. The existing technology_node plain-text column is a denormalization of process_flow. A proper FK enables PCN obligatio',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Customer Contract records reference the R&D project that will deliver the custom chip, required for delivery planning and cost allocation.',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: Semiconductor customer contracts operate under a governing NDA for IP and confidentiality protection. Contract management and legal compliance require knowing which NDA covers each contract, especiall',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: Long-term customer contracts in semiconductor supply agreements typically reference a specific price list that governs pricing terms for the contract duration. The customer_contract has pricing_terms ',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Long-term supply contracts often originate from won opportunities. Links contract terms back to the originating sales engagement.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Long Term Agreements (LTAs) in semiconductor supply contracts specify exact SKUs with committed pricing, volume tiers, and delivery terms. Contract compliance tracking and price deviation analysis req',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `annual_value` DECIMAL(18,2) COMMENT 'Average yearly revenue expected from the contract.',
    `arbitration_clause` BOOLEAN COMMENT 'Indicates whether disputes are resolved via arbitration.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates if the contract will auto‑renew at the end of its term.',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is present.',
    `contract_name` STRING COMMENT 'Descriptive title of the contract for easy identification.',
    `contract_number` STRING COMMENT 'External contract number assigned by the customer or sales organization.',
    `contract_type` STRING COMMENT 'Category of the contract such as supply, service, license, or NRE.. Valid values are `supply|service|license|nre`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract over its full term.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code used for all monetary amounts.',
    `customer_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|suspended|terminated|draft|pending`',
    `customer_contract_description` STRING COMMENT 'Free‑form text describing the contract purpose and special conditions.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base unit price.',
    `effective_from` DATE COMMENT 'Date when the contract becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or is terminated; null for open‑ended contracts.',
    `eol_clause` BOOLEAN COMMENT 'Indicates whether an End‑of‑Life provision is part of the contract.',
    `invoicing_frequency` STRING COMMENT 'How often invoices are issued under the contract.. Valid values are `monthly|quarterly|annually`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `ltb_provision` BOOLEAN COMMENT 'Indicates whether a Last‑Time‑Buy clause is included.',
    `max_order_quantity` BIGINT COMMENT 'Maximum quantity per order allowed under the contract.',
    `min_order_quantity` BIGINT COMMENT 'Minimum quantity per order required by the contract.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the customer.. Valid values are `net30|net45|net60|prepaid|upon_delivery`',
    `pcn_obligation` BOOLEAN COMMENT 'Specifies if the supplier must notify the customer of product changes.',
    `pricing_terms` STRING COMMENT 'Narrative description of pricing structure, discounts, and rebates.',
    `product_family` STRING COMMENT 'Family of semiconductor products covered by the contract.',
    `renewal_option` STRING COMMENT 'Specifies whether the contract renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the contract.',
    `supply_scope` STRING COMMENT 'Scope of supply coverage: exclusive, multi‑source, or global.. Valid values are `exclusive|multi_source|global`',
    `termination_date` DATE COMMENT 'Date on which the contract is formally terminated.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required before contract termination.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit of product or service covered by the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `volume_commitment` BIGINT COMMENT 'Total quantity of units the customer commits to purchase over the contract term.',
    CONSTRAINT pk_customer_contract PRIMARY KEY(`customer_contract_id`)
) COMMENT 'Master record: Long-term commercial contract with a semiconductor customer covering supply commitments, pricing agreements, volume guarantees, last-time-buy (LTB) provisions, product change notification (PCN) obligations, and end-of-life (EOL) terms. Distinct from NRE agreements — governs ongoing product supply rather than development services. Linked to SAP SD outline agreements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'System-generated unique identifier for the forecast record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the forecast is created.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Semiconductor revenue forecasts are built bottom-up from design wins. Design-win-based forecasting is a standard semiconductor sales planning process. Linking forecasts to design wins enables design-w',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Sales forecasts are allocated to specific fab facilities for capacity planning and loading. Sales operations and supply chain teams assign forecast volume by fab to drive wafer start plans, capacity r',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Forecasts are produced per product family for capacity planning and financial reporting.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: S&OP (Sales & Operations Planning) process requires demand forecasts to reference specific finished good SKUs for inventory build planning. Enables forecast-vs-stock comparison reports and finished go',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Semiconductor capacity and yield-adjusted revenue forecasting requires knowing which process flow (node, layer count, cycle time) the forecasted product runs on. Sales operations teams build node-leve',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Semiconductor demand planning requires part-level (ic_catalog) forecasts to drive wafer start decisions and capacity allocation. Family-level forecasts are insufficient for fab scheduling; part-number',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: New product introduction (NPI) revenue forecasting: sales forecasts for new chips are anchored to the design project to track design-to-revenue pipeline, NPI readiness gating, and forecast accuracy ag',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: In semiconductor sales, demand forecasts are directly tied to design-win opportunities in the pipeline. A sales forecast for a specific product family and account is most meaningfully anchored to the ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Finished goods inventory planning and OSAT scheduling require SKU-level forecasts (specific package/speed/temp variants). Semiconductor supply chain teams run SKU-level forecast accuracy (MAPE) report',
    `approval_date` DATE COMMENT 'Date the forecast was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the forecast.',
    `bias` DECIMAL(18,2) COMMENT 'Average signed deviation of forecast from actuals.',
    `forecast_category` STRING COMMENT 'High‑level category of the forecast (demand, supply, or capacity).. Valid values are `demand|supply|capacity`',
    `confidence_level` STRING COMMENT 'Confidence rating assigned to the forecast.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `effective_end` DATE COMMENT 'Last day of the period the forecast covers.',
    `effective_start` DATE COMMENT 'First day of the period the forecast covers.',
    `end_market` STRING COMMENT 'Target market segment of the forecast.. Valid values are `Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace`',
    `fiscal_period` STRING COMMENT 'Fiscal period identifier (e.g., FY2025Q1).. Valid values are `^FYd{4}Q[1-4]$`',
    `forecast_number` STRING COMMENT 'Business identifier assigned to the forecast (e.g., F2025Q1-001).',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast.. Valid values are `draft|submitted|approved|rejected`',
    `forecast_type` STRING COMMENT 'Classification of the forecast scenario (commit, upside, or best‑case).. Valid values are `commit|upside|best_case`',
    `geography` STRING COMMENT 'Three‑letter ISO country code representing the forecast geography.. Valid values are `^[A-Z]{3}$`',
    `horizon_months` STRING COMMENT 'Length of the forecast horizon expressed in months.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the forecast is locked from further edits.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the forecast.',
    `last_reviewer` STRING COMMENT 'User identifier who performed the last review.',
    `mape` DECIMAL(18,2) COMMENT 'Statistical measure of forecast accuracy.',
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
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Transaction record: Sales demand forecast capturing expected unit volume and revenue by product family, customer, end market, geography, and fiscal period. Supports rolling 12-month and 18-month forecast horizons used in semiconductor S&OP and wafer-start authorization processes. Tracks forecast version (commit, upside, best-case), submission date, confidence level, and variance against actuals. Integrates with SAP APO/IBP demand planning. Enables forecast accuracy KPI tracking (MAPE, bias) critical for fab capacity planning decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`booking` (
    `booking_id` BIGINT COMMENT 'System-generated unique identifier for the booking record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the booking.',
    `address_id` BIGINT COMMENT 'Identifier of the destination location for shipment.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings represent the commercial commitment arising from won opportunities. Essential for opportunity-to-revenue traceability.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Semiconductor order bookings require real-time credit hold checks against the customer credit profile before acceptance. Revenue recognition and order management depend on knowing the credit status at',
    `customer_contract_id` BIGINT COMMENT 'Reference to the governing sales contract or NRE agreement.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Design-win-to-revenue conversion is a primary semiconductor sales metric. Bookings must be attributed to design wins for revenue recognition reporting. booking.design_win_fk is a denormalized plain co',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Bookings are assigned to specific fab facilities for production scheduling and delivery commitment management. Order management teams allocate booked orders to fabs based on capacity, technology node ',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: ATP (Available-to-Promise) and shipment allocation require a booking to reference the specific finished good being committed. Drives revenue recognition reconciliation and outbound logistics. A semico',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Bookings are fulfilled using a defined process flow; the link drives production scheduling and yield tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Booking must reference the exact IC catalog entry to drive manufacturing and compliance checks.',
    `primary_booking_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings fulfill opportunities. This link closes the pipeline-to-revenue loop essential for forecast accuracy measurement.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: A confirmed booking (firm customer PO commitment) in semiconductor sales is typically the result of a customer accepting a specific quote. The quote-to-booking conversion rate is a critical sales KPI.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Semiconductor order bookings are placed against specific orderable SKUs (package/speed/temp variants), not just the die-level ic_catalog entry. Revenue recognition, finished goods inventory allocation',
    `backlog_flag` BOOLEAN COMMENT 'True if the booking is currently in backlog (unfulfilled).',
    `booked_quantity` BIGINT COMMENT 'Number of units (dies) committed in the booking.',
    `booked_revenue_gross` DECIMAL(18,2) COMMENT 'Total revenue amount before discounts and taxes, in the booking currency.',
    `booked_revenue_net` DECIMAL(18,2) COMMENT 'Revenue after discounts and before tax.',
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
    `order_type` STRING COMMENT 'Classification of the booking (e.g., standard sale, NRE, design‑win).. Valid values are `standard|nre|design_win|service|maintenance`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer.. Valid values are `net30|net45|net60|cash`',
    `pricing_model` STRING COMMENT 'Pricing approach applied to the booking.. Valid values are `list|contract|discounted|custom`',
    `priority_level` STRING COMMENT 'Business priority assigned to the booking.. Valid values are `high|medium|low`',
    `product_family` STRING COMMENT 'High‑level product family (e.g., ASIC, FPGA, SoC) for the booked part.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the booking must be reported under specific regulatory frameworks (e.g., CHIPS Act).',
    `requested_delivery_date` DATE COMMENT 'Date the customer expects the shipment to be delivered.',
    `revenue_recognition_date` DATE COMMENT 'Date when the booked revenue is recognized for accounting.',
    `sales_region` STRING COMMENT 'Geographic sales region for the booking.. Valid values are `APAC|EMEA|AMER`',
    `ship_to_country` STRING COMMENT 'Three‑letter country code of the ship‑to location.. Valid values are `^[A-Z]{3}$`',
    `source` STRING COMMENT 'Origin system that created the booking record.. Valid values are `salesforce|sap|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the net revenue.',
    `total_tax_code` STRING COMMENT 'Tax code used for calculating tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the booking record.',
    `warranty_period_months` STRING COMMENT 'Warranty duration provided to the customer, in months.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Transaction record: Confirmed sales booking representing a firm customer purchase order commitment for semiconductor devices. Captures booking date, booked revenue, booked units, device part number, customer account, ship-to location, requested delivery date, backlog status, and SAP SD sales order reference. Represents the commercial booking event — distinct from shipment or invoice. SSOT for bookings-to-billings (B2B) ratio, book-to-ship analysis, and revenue waterfall reporting critical to semiconductor quarterly earnings.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_source_opportunity_id` FOREIGN KEY (`source_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_tertiary_quote_id` FOREIGN KEY (`tertiary_quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ADD CONSTRAINT `fk_sales_nre_agreement_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ADD CONSTRAINT `fk_sales_nre_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_primary_booking_opportunity_id` FOREIGN KEY (`primary_booking_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `source_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_description` SET TAGS ('dbx_business_glossary_term' = 'Quote Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = '1-99|100-999|1000-9999|10000+');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Win/Loss Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|open');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tertiary_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Quote Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `customer_requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Custom Product Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_comment` SET TAGS ('dbx_business_glossary_term' = 'Line Comment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_business_glossary_term' = 'Actual Recognized Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'custom|standard|partner|internal');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `completed_milestones` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestones');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_value_regex' = 'RTL|GDS|PDK|Tapeout|Documentation');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `invoice_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Trigger Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Clause');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `last_milestone_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Planned Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NRE Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_delivery|milestone');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|LATAM|JAPAC');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `total_milestones` SET TAGS ('dbx_business_glossary_term' = 'Total Milestones');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`nre_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID (SBPLID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ATYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|incentive|markdown|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (ATRL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description (PLD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market (EM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Price List (IDPL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name (PLN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status (PLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|distributor|oem|spot');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `pricing_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Code (PCC)');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Identifier (CCI)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (ACNT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `annual_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Flag (ACF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag (ARF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag (CCF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Title (CT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CTYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'supply|service|license|nre');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CUR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status (CLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|draft|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (DR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `eol_clause` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Clause (EOL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency (INV_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `ltb_provision` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Provision (LTB)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAXQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_T)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid|upon_delivery');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pcn_obligation` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Obligation (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_business_glossary_term' = 'Supply Scope (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_value_regex' = 'exclusive|multi_source|global');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TNP_D)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment (VC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'demand|supply|capacity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `effective_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `effective_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^FYd{4}Q[1-4]$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'commit|upside|best_case');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography (Country Code)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Forecast Locked Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `last_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_value_regex' = 'Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|pcs|die|wafer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `variance_to_actual` SET TAGS ('dbx_business_glossary_term' = 'Variance to Actual (%)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier (BKID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Location Identifier (SHIP_LOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `primary_booking_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Indicator (IS_BACKLOG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Booked Quantity (BK_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Booked Revenue (BK_REVENUE_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Net Booked Revenue (BK_REVENUE_NET)');
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
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORDER_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|nre|design_win|service|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|contract|discounted|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Booking Priority Level (PRIORITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PFAM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REV_RECOG_DATE)');
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
