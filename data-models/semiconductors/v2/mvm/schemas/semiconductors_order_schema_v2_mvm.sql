-- Schema for Domain: order | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`order` COMMENT 'Customer orders, order fulfillment, delivery schedules, and shipment tracking. SSOT for order-to-cash lifecycle including order entry, wafer start authorizations, die bank orders, allocation, backlog management, and delivery confirmation. Manages MPW orders and production lot assignments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order` (
    `order_id` BIGINT COMMENT 'Primary key for order',
    `account_id` BIGINT COMMENT 'Reference to the customer who placed the sales order. Links to the customer master data product.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order Management requires a primary sales contact for each order; the Order Confirmation Report pulls contact details, making this link essential.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Order booking in semiconductor order-to-cash validates the order against the customers credit profile before acceptance. A direct FK from order to credit_profile supports credit exposure tracking per',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Orders in semiconductors are placed under Long Term Agreements (LTAs) / customer contracts governing pricing, volume commitments, and supply terms. Order-to-contract linkage is required for contract c',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order creation originates from a closed‑won opportunity; linking enables opportunity‑to‑order conversion reporting.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: Required for order processing: each order references a centrally defined payment term for financial reporting and compliance with contract terms.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Pricing Governance applies a specific price agreement to an order; the Pricing Audit Report and revenue recognition rely on this relationship.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping Execution process stores the exact customer address for each order; the Shipping Manifest and compliance checks depend on this link.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Every order must be attributed to a sales territory for revenue reporting, quota attainment tracking, and sales rep commission calculation. Territory-level order revenue is a standard semiconductor sa',
    `actual_delivery_date` DATE COMMENT 'The actual date on which the ordered products were delivered to the customer or ship-to location. Used for on-time delivery (OTD) performance analysis and customer satisfaction reporting.',
    `allocation_status` STRING COMMENT 'Current inventory or production capacity allocation status of the order. Indicates whether sufficient die, wafer, or finished goods inventory has been reserved to fulfill the order. Critical for backlog management and supply-demand balancing.. Valid values are `UNALLOCATED|PARTIALLY_ALLOCATED|FULLY_ALLOCATED|OVER_ALLOCATED`',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this order is currently included in the active order backlog. True when the order is open and not yet fully shipped or invoiced. Used for backlog valuation, revenue forecasting, and capacity planning.',
    `cancellation_reason` STRING COMMENT 'Business reason code or description for order cancellation. Populated only when order_status is CANCELLED. Used for lost revenue analysis, demand forecasting accuracy, and customer relationship management.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this order is associated with products or programs eligible for US CHIPS and Science Act incentives or reporting requirements. Used for government reporting and subsidy tracking.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the semiconductor manufacturer based on production capacity, wafer fab scheduling, and logistics. May differ from the requested delivery date. Used for backlog management and customer commitment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales order record was first created in the source system (SAP S/4HANA SD). Used for audit trail, data lineage, and order entry performance measurement. Corresponds to SAP VBAK.ERDAT + VBAK.ERZET.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order transaction (e.g., USD, EUR, JPY, TWD, KRW). Defines the currency in which order values, pricing, and invoicing are denominated. Corresponds to SAP VBAK.WAERK.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'The purchase order number provided by the customer at the time of order placement. Used for cross-referencing with the customers procurement system and required for invoice matching. Corresponds to SAP VBAK.BSTNK.',
    `distribution_channel` STRING COMMENT 'The sales channel through which the order was placed. Determines pricing tiers, commission structures, and revenue reporting by channel. Corresponds to SAP VBAK.VTWEG.. Valid values are `DIRECT|DISTRIBUTOR|REPRESENTATIVE|ONLINE|OEM`',
    `end_market_segment` STRING COMMENT 'The end-market application segment for which the ordered semiconductor products are destined. Used for market segmentation analysis, revenue reporting by vertical, and strategic planning. [ENUM-REF-CANDIDATE: COMPUTING|MOBILE|AUTOMOTIVE|AI_ML|IOT|INDUSTRIAL|NETWORKING|CONSUMER|DEFENSE|MEDICAL — promote to reference product]',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required for this order based on the destination country, end-user, and product ECCN classification. True triggers export compliance review workflow before shipment authorization.',
    `gross_order_value` DECIMAL(18,2) COMMENT 'Total gross value of the sales order before application of discounts, taxes, or surcharges, expressed in the order currency. Represents the sum of all line item gross values. Used for revenue forecasting and backlog valuation.',
    `hold_reason` STRING COMMENT 'Reason code or description for placing the order on hold. Populated when order_status is ON_HOLD. Common reasons include credit hold, export compliance review, customer request, or supply shortage.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities of buyer and seller for delivery, risk transfer, and cost allocation. Corresponds to SAP VBAK.INCO1. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code, specifying where risk and cost transfer between buyer and seller (e.g., Shanghai Port, Customer Dock). Corresponds to SAP VBAK.INCO2.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether any products in this order are subject to ITAR (International Traffic in Arms Regulations) controls. When True, additional export authorization and end-use certification requirements apply before shipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the order record in the order domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sales order record in the source system. Used for change tracking, audit compliance, and incremental data pipeline processing. Corresponds to SAP VBAK.AEDAT.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the order record in the order domain.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net value of the sales order after application of all discounts and pricing conditions but before tax. Represents the contractually agreed revenue amount. Corresponds to SAP VBAK.NETWR. Used for revenue recognition and financial reporting.',
    `notes` STRING COMMENT 'Free-text notes or special instructions associated with the sales order, capturing customer-specific requirements, handling instructions, or internal processing notes. Corresponds to SAP order header text.',
    `nre_amount` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering (NRE) charges associated with this order, covering one-time design, mask set, and process development costs. Applicable for ASIC, custom IC, and MPW order types. Reported separately from unit product revenue.',
    `number` STRING COMMENT 'The number of the order record in the order domain.',
    `order_date` DATE COMMENT 'The calendar date on which the customer placed the sales order. Represents the principal business event date for the order-to-cash lifecycle. Corresponds to SAP VBAK.AUDAT.',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order within the order-to-cash process. Drives workflow routing, backlog reporting, and revenue recognition. [ENUM-REF-CANDIDATE: DRAFT|OPEN|IN_FULFILLMENT|SHIPPED|DELIVERED|CLOSED|CANCELLED|ON_HOLD — promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the sales order by product or engagement type. Determines order processing rules, pricing, and fulfillment workflow. Values include: STANDARD_IC (standard integrated circuit), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array), MPW (Multi-Project Wafer), NRE (Non-Recurring Engineering), DIE_BANK (die bank pull order), WAFER_START (wafer start authorization). [ENUM-REF-CANDIDATE: STANDARD_IC|ASIC|FPGA|MPW|NRE|DIE_BANK|WAFER_START — promote to reference product]',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key defining the payment due date, early payment discount conditions, and cash discount percentages applicable to this order. Corresponds to SAP VBAK.ZTERM (e.g., NT30, NT60, 2/10NET30).. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Business priority level assigned to the order, influencing production scheduling, wafer start queue position, and allocation decisions. Critical orders may trigger expedite fees or override standard allocation rules.. Valid values are `CRITICAL|HIGH|STANDARD|LOW`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the products ordered comply with the EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) Regulation. Required for EU market access and supply chain chemical safety reporting.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer has requested delivery of the ordered products. Used for delivery scheduling, wafer start planning, and on-time delivery (OTD) performance measurement. Corresponds to SAP VBAK.VDATU.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the products ordered comply with the EU RoHS (Restriction of Hazardous Substances) Directive, restricting the use of specific hazardous materials in electronic equipment. Required for EU market access and customer compliance declarations.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for shipment. Critical for export compliance screening (EAR/ITAR/BIS), trade sanctions checks, and logistics routing. Corresponds to SAP ship-to party country.. Valid values are `^[A-Z]{3}$`',
    `so_number` STRING COMMENT 'Externally visible sales order number as assigned by SAP S/4HANA SD module. Used in all customer-facing communications, shipping documents, and invoices. Corresponds to the VBELN field in SAP VBAK table.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `source` STRING COMMENT 'The channel or system through which the customer order was received and entered. Used for order entry efficiency analysis and digital transformation tracking.. Valid values are `EDI|PORTAL|EMAIL|PHONE|SALESFORCE|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the sales order, including VAT, GST, or other applicable taxes, expressed in the order currency. Required for tax reporting and financial compliance.',
    `total_quantity` STRING COMMENT 'The total quantity of the order record in the order domain.',
    `wafer_start_authorization` BOOLEAN COMMENT 'Indicates whether this order has triggered a wafer start authorization in the fabrication facility (FAB). When True, the MES (Manufacturing Execution System) has been instructed to initiate wafer lot processing for this order.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Master record for all customer sales orders in the semiconductor order-to-cash lifecycle. Captures order header information including customer identity, order type (standard IC, ASIC, FPGA, MPW, NRE), order date, requested delivery date, priority, incoterms, payment terms, currency, total order value, and order status. SSOT for all customer-placed orders including wafer start authorizations, die bank orders, and production lot assignments. Sourced from SAP S/4HANA SD module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique surrogate identifier for each order line item within the Databricks Silver Layer. Serves as the primary key for the order_line data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer placing the order. Used for line-level customer attribution in multi-ship-to or multi-sold-to scenarios. Corresponds to SAP S/4HANA SD KUNNR (Customer Number).',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Design-win-to-revenue conversion is a core semiconductor KPI. Order lines for production ramp parts must be traceable to the originating design win for revenue realization reporting, design win ROI an',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the order line order entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: REQUIRED: Order fulfillment report needs to know which wafer lot supplies each order line; linking enables traceability from line to physical wafer lot.',
    `order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Fundamental header-to-line relationship. Every order line must belong to exactly one sales order. This is the most critical FK in the domain — without it, order lines are orphaned.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Needed for Packaging Planning; order line specifies requested package type, linking to package_type enables yield, cost, and compliance analysis per packaging family.',
    `price_agreement_id` BIGINT COMMENT 'Unique identifier for the price agreement record within the order line order entity.',
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record within the order line order entity.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Die bank and wafer start order lines in semiconductor fabs are explicitly tied to a process node for fab scheduling and capacity allocation. Wafer start authorization on order_line requires node ident',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Each order line is derived from a quote line; needed for line‑level margin and fulfillment analysis.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: CHAMBER_TRACEABILITY: Link order line to specific tool chamber used, enabling yield analysis and compliance reporting.',
    `actual_ship_date` DATE COMMENT 'The date on which the semiconductor units for this order line were physically shipped from the warehouse or OSAT facility. Populated upon goods issue posting in SAP S/4HANA. Used for on-time delivery (OTD) performance measurement.',
    `allocation_type` STRING COMMENT 'Classification of the supply allocation method applied to this order line. Standard = normal backlog allocation; Priority = customer-priority or design-win protected allocation; Strategic = long-term agreement allocation; Spot = spot market fulfillment; Buffer = safety stock draw.. Valid values are `standard|priority|strategic|spot|buffer`',
    `cancellation_reason` STRING COMMENT 'Reason code for cancellation of this order line when line_status is cancelled. Supports backlog analysis, demand planning accuracy, and customer relationship management. Populated only for cancelled lines. [ENUM-REF-CANDIDATE: customer_request|supply_constraint|end_of_life|duplicate|pricing_dispute|export_hold|other — 7 candidates stripped; promote to reference product]',
    `confirmed_delivery_date` DATE COMMENT 'The confirmed delivery date associated with the order line order record.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units confirmed by supply chain for delivery on this order line, reflecting available inventory, wafer start authorizations, and die bank allocations. May differ from ordered quantity due to allocation constraints.',
    `confirmed_ship_date` DATE COMMENT 'The date confirmed by supply chain and manufacturing for shipment of this order line, based on available inventory, die bank status, and OSAT packaging capacity. May differ from requested ship date due to supply constraints.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the semiconductor product was manufactured (FAB location). Required for customs declarations, trade compliance, tariff classification, and CHIPS Act domestic content reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order line record was first created in the data platform. Used for audit trail, data lineage, and Silver Layer ingestion tracking. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency of this order line (e.g., USD, EUR, JPY, KRW, TWD). Semiconductor industry commonly transacts in USD but supports multi-currency for global customers.. Valid values are `^[A-Z]{3}$`',
    `customer_part_number` STRING COMMENT 'The customers own internal part number or cross-reference number for the ordered semiconductor product. Critical for design-win tracking, customer portal integration, and order acknowledgment matching. Sourced from Salesforce CRM design-win records.',
    `date_entered` DATE COMMENT 'The business date on which this order line was entered into the SAP S/4HANA SD system. Represents the commercial event date for backlog aging calculations and order-to-cash cycle time measurement.',
    `die_bank_order` BOOLEAN COMMENT 'Indicates whether this order line is to be fulfilled from the die bank (inventory of known good dies (KGD) awaiting packaging) rather than from finished goods or new wafer starts. True = die bank fulfillment; False = standard finished goods or new production.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percent of the order line record in the order domain.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) for the semiconductor product on this order line (e.g., 3A001 for advanced ICs). Required for export compliance screening, license determination, and ITAR/EAR regulatory reporting.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The extended amount of the order line record in the order domain.',
    `extended_price_usd` DECIMAL(18,2) COMMENT 'The extended price usd of the order line record in the order domain.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between the semiconductor company and the customer for this order line (e.g., FOB, DDP, EXW). Corresponds to SAP S/4HANA SD INCO1. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `item_category` STRING COMMENT 'SAP SD item category classification for this order line, indicating the business nature of the line (e.g., standard product sale, consignment fill-up, customer return, engineering sample, NRE charge, MPW service, evaluation unit). Drives pricing, delivery, and billing behavior. [ENUM-REF-CANDIDATE: standard|consignment|returns|sample|nre|mpw|evaluation — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the order line record in the order domain.',
    `line_number` STRING COMMENT 'Sequential position number of this line item within the parent sales order. Used for ordering, display, and reference in customer-facing documents. Corresponds to SAP S/4HANA SD POSNR (Item Number of the SD Document).',
    `line_status` STRING COMMENT 'Current workflow status of this order line item within the order-to-cash lifecycle. Drives backlog management, allocation decisions, and revenue recognition. Corresponds to SAP S/4HANA SD overall delivery status at item level.. Valid values are `open|confirmed|allocated|shipped|invoiced|cancelled`',
    `lot_number` STRING COMMENT 'The manufacturing lot number assigned to the production batch fulfilling this order line. Enables traceability from customer order back to wafer fabrication lot, die bank lot, and OSAT packaging lot. Sourced from Camstar MES lot tracking.',
    `material_number` STRING COMMENT 'SAP material number (MATNR) identifying the specific semiconductor product SKU ordered on this line. Includes full part number with package, speed grade, and temperature range encoded per internal part numbering convention.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the order line record in the order domain.',
    `mpw_order` BOOLEAN COMMENT 'Indicates whether this order line is associated with a Multi-Project Wafer (MPW) run, where multiple customer designs share a single wafer to reduce NRE costs. True = MPW order; False = dedicated production lot order.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value of this order line calculated as confirmed quantity multiplied by unit price in the transaction currency. Used for backlog reporting, revenue forecasting, and SOX-compliant revenue recognition. Corresponds to SAP S/4HANA SD NETWR (Net Value of the Order Item).',
    `open_quantity` STRING COMMENT 'The open quantity of the order line record in the order domain.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units (dies, packaged ICs, wafers, or reels) requested by the customer on this order line. Expressed in the sales unit of measure (e.g., pieces, wafers, reels). Corresponds to SAP S/4HANA SD KWMENG (Cumulative Order Quantity).',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether the customer permits partial shipments against this order line. True = partial shipments accepted; False = complete order line quantity must ship together. Drives delivery scheduling and backlog management decisions.',
    `product_revision` STRING COMMENT 'The silicon revision or stepping of the ordered semiconductor product (e.g., A0, B1, C2). Critical for tracking product change notifications (PCNs), errata management, and ensuring customers receive the correct silicon revision per their qualification.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the semiconductor product on this order line is compliant with the EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals). Required for EU chemical safety compliance and customer material declarations.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer requires receipt of the semiconductor units at their facility. Distinct from requested ship date; accounts for transit time. Used for customer SLA compliance tracking.',
    `requested_ship_date` DATE COMMENT 'The date on which the customer has requested shipment of this order line. Drives production scheduling, wafer start authorization timelines, and OSAT packaging commitments. Corresponds to SAP S/4HANA SD WUNSK (Customers Requested Delivery Date at Item Level).',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the semiconductor product on this order line is compliant with the EU Restriction of Hazardous Substances (RoHS) Directive, restricting use of lead, mercury, cadmium, and other hazardous materials. Required for EU market access.',
    `sap_line_item_number` STRING COMMENT 'The native SAP S/4HANA SD six-digit item number (POSNR) for this order line, used for traceability back to the system of record and for EDI/customer portal reconciliation.. Valid values are `^[0-9]{6}$`',
    `ship_to_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination country of this order line shipment. Used for export control screening, customs documentation, tariff determination, and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of semiconductor units actually shipped against this order line across all partial shipments. Used for backlog calculation and revenue recognition. Sourced from SAP S/4HANA SD delivery documents.',
    `special_handling_code` STRING COMMENT 'Code indicating special handling, storage, or shipping requirements for this order line (e.g., ESD-sensitive, moisture-sensitive level (MSL), controlled humidity, ITAR-controlled, hazmat). Drives warehouse and logistics instructions. [ENUM-REF-CANDIDATE: ESD|MSL1|MSL2|MSL3|ITAR|HAZMAT|CONTROLLED_TEMP|FRAGILE — promote to reference product]',
    `speed_grade` STRING COMMENT 'The speed or performance grade of the ordered semiconductor product, indicating the maximum operating frequency or timing specification (e.g., -1, -2, -3 for FPGAs; 3200MHz, 4800MHz for memory). Differentiates SKUs within the same product family.',
    `temperature_grade` STRING COMMENT 'Operating temperature range classification for the ordered semiconductor product. Commercial (0°C to 70°C), Industrial (-40°C to 85°C), Automotive (-40°C to 125°C, AEC-Q100), Military (-55°C to 125°C). Determines qualification standard and pricing tier.. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_of_measure` STRING COMMENT 'Sales unit of measure for the ordered semiconductor product. EA = Each (individual packaged IC), WFR = Wafer, REEL = Tape-and-reel packaging, TRAY = JEDEC tray, TUBE = Tube packaging. Corresponds to SAP S/4HANA SD VRKME (Sales Unit).. Valid values are `EA|WFR|REEL|TRAY|TUBE`',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed net unit selling price for the semiconductor product on this order line, expressed in the transaction currency. Reflects negotiated pricing, volume discounts, and design-win pricing agreements. Corresponds to SAP S/4HANA SD NETPR (Net Price).',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'The unit price usd of the order line record in the order domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this order line record in the data platform. Supports change data capture (CDC), audit trail, and incremental processing in the Databricks Lakehouse Silver Layer.',
    `wafer_start_authorization` BOOLEAN COMMENT 'Indicates whether a wafer start authorization (WSA) has been issued to the fabrication facility (FAB) to initiate production of wafers for fulfilling this order line. True = WSA issued; False = pending or not required (e.g., fulfilled from die bank or finished goods inventory).',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line items within a customer sales order, each representing a distinct semiconductor product SKU, quantity, unit price, requested ship date, confirmed ship date, and line-level status. Captures product configuration details such as package type, speed grade, temperature range, and special handling requirements. Supports partial shipments and line-level allocation tracking. Sourced from SAP S/4HANA SD order line items.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each delivery schedule line record in the SAP S/4HANA SD schedule line table (VBEP). Primary key for the delivery_schedule data product in the Silver layer.',
    `account_id` BIGINT COMMENT 'Reference to the sold-to customer for whom this delivery schedule is planned. Supports customer-level delivery performance analytics and blanket order management.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the assigned storage location record within the delivery schedule order entity.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: In semiconductor blanket order and call-off scenarios, individual delivery schedule lines can ship to different customer addresses than the master order. A role-prefixed delivery_ship_to_address_id FK',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header from which this delivery schedule line originates. Links the schedule line back to the order-to-cash transaction header.',
    `origin_storage_location_id` BIGINT COMMENT 'Reference to the originating ship-from location for this delivery schedule line. May be a wafer fabrication facility (FAB), OSAT (Outsourced Semiconductor Assembly and Test) site, or finished goods warehouse.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: delivery_schedule.packaging_type is a plain-text denormalization of the package_type entity. A proper FK enables delivery scheduling to enforce package-specific lead times, OSAT capacity constraints, ',
    `order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item (order item) for which this delivery schedule line is created. A single order line may have multiple schedule lines representing different delivery windows.',
    `to_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Delivery schedules define delivery windows per order line. delivery_schedule.order_line_id → order_line.order_line_id.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Maintenance-Driven Delivery Reschedule Reporting: delivery_schedule.last_reschedule_reason captures push-outs caused by tool downtime. Linking to the causative maintenance_event enables on-time delive',
    `actual_delivery_date` DATE COMMENT 'The date on which the shipment was confirmed as received at the customers ship-to location. Used for on-time delivery (OTD) KPI calculation and customer satisfaction reporting.',
    `actual_ship_date` DATE COMMENT 'The actual date on which the shipment physically departed the ship-from location. Populated upon goods issue posting in SAP. Used for on-time shipment performance measurement.',
    `allocation_priority` STRING COMMENT 'Numeric priority rank assigned to this delivery schedule line during constrained supply allocation. Lower values indicate higher priority. Used by supply chain planners to allocate limited wafer or die inventory across competing customer orders.',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is currently in backlog status (confirmed delivery date is past due or confirmed quantity is less than ordered quantity). Used for backlog management reporting and customer escalation tracking.',
    `blanket_order_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is part of a blanket (framework) order with periodic call-offs. Blanket orders are common for high-volume semiconductor customers with rolling delivery schedules.',
    `call_off_number` STRING COMMENT 'The specific call-off or release number issued by the customer against a blanket order for this delivery schedule line. Identifies the periodic release instruction within the blanket order framework.',
    `committed_date` DATE COMMENT 'The committed date associated with the delivery schedule order record.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the semiconductor manufacturer to the customer after availability check (ATP) and capacity validation. May differ from the requested date due to wafer fab cycle time or OSAT capacity constraints.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity confirmed by the manufacturer for delivery on this schedule line after ATP (Available-to-Promise) check. May be less than ordered quantity due to allocation constraints or yield limitations.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the semiconductor product was manufactured (wafer fab or final assembly location). Required for customs declarations, tariff classification, and export control compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule line record was first created in the source SAP S/4HANA SD system. Supports audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction value fields on this delivery schedule line (e.g., USD, EUR, JPY). Supports multi-currency semiconductor sales operations.. Valid values are `^[A-Z]{3}$`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units shipped and delivered against this schedule line. Populated from goods issue and proof-of-delivery confirmation. Used to compute open backlog.',
    `delivery_document_number` STRING COMMENT 'SAP outbound delivery document number (SD delivery order) created against this schedule line. Links the schedule line to the physical goods issue and shipping execution documents.',
    `delivery_priority` STRING COMMENT 'The delivery priority of the delivery schedule record in the order domain.',
    `die_bank_order_number` STRING COMMENT 'Reference number for a die bank order when delivery is fulfilled from pre-tested Known Good Die (KGD) inventory rather than a new wafer start. Supports die bank fulfillment tracking in the order-to-cash lifecycle.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned to the semiconductor product on this schedule line per the US Commerce Control List (CCL). Determines applicable export license requirements. Examples: 3A001 (electronic components), 3E001 (technology for IC design).',
    `export_control_status` STRING COMMENT 'Export control compliance status for this delivery schedule line. Semiconductor shipments may be subject to EAR (Export Administration Regulations), ITAR (International Traffic in Arms Regulations), or CHIPS Act restrictions. blocked prevents shipment until clearance is obtained.. Valid values are `approved|pending_review|blocked|not_required`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment for this delivery schedule line contains hazardous materials (e.g., certain chemical compounds in semiconductor packaging). Triggers special handling, labeling, and documentation requirements per RoHS and REACH regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk and responsibility between the semiconductor manufacturer and the customer for this delivery. Governs freight cost allocation and insurance obligations. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code for this delivery schedule line (e.g., FOB Shanghai, DAP Austin TX). Required by ICC Incoterms 2020 to complete the delivery terms specification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the delivery schedule record in the order domain.',
    `last_reschedule_reason` STRING COMMENT 'Free-text or coded reason for the most recent rescheduling of this delivery schedule line (e.g., wafer yield shortfall, OSAT capacity constraint, customer push-out request, export hold). Supports root cause analysis for delivery performance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this delivery schedule line record in the source SAP S/4HANA SD system. Used for incremental data pipeline processing and change detection in the Silver layer.',
    `lot_number` STRING COMMENT 'Semiconductor production lot number (wafer lot or assembly lot) assigned to the units being delivered on this schedule line. Enables full traceability from customer delivery back to wafer fabrication and process parameters. Sourced from Camstar MES lot tracking.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the delivery schedule record in the order domain.',
    `mpw_order_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is associated with a Multi-Project Wafer (MPW) order, where multiple customer designs share a single wafer run. MPW orders have distinct lead times and delivery constraints.',
    `net_value` DECIMAL(18,2) COMMENT 'Net monetary value of the confirmed quantity on this delivery schedule line in the transaction currency. Calculated as confirmed quantity multiplied by the agreed unit price. Used for revenue recognition, backlog valuation, and SOX financial reporting.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units (dies, packaged ICs, wafers) originally ordered by the customer on this schedule line. Expressed in the sales unit of measure (e.g., pieces, wafers).',
    `quantity_unit` STRING COMMENT 'Unit of measure for all quantity fields on this schedule line. Common semiconductor units include PC (pieces/individual ICs), WF (wafers), KGD (Known Good Die), LOT (production lot), REEL (tape-and-reel packaging), TRAY (tray packaging).. Valid values are `PC|WF|KGD|LOT|REEL|TRAY`',
    `requested_delivery_date` DATE COMMENT 'The delivery date originally requested by the customer for this schedule line. Represents the customers desired receipt date and is the baseline for on-time delivery (OTD) measurement.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the semiconductor product being delivered on this schedule line is compliant with the EU Restriction of Hazardous Substances (RoHS) Directive. Required for shipments to EU customers and increasingly mandated globally.',
    `sap_schedule_line_category` STRING COMMENT 'SAP SD schedule line category code controlling the delivery and goods movement behavior of this schedule line (e.g., CP = standard delivery with transfer of requirements, CN = no goods movement). Sourced from SAP VBEP-ETTYP.. Valid values are `CP|CN|CS|BN|BP|BS`',
    `schedule_line_number` STRING COMMENT 'Sequential line number of this delivery schedule entry within the parent order line item. Used to order multiple delivery windows for the same order line (e.g., line 1 = 500 units on date A, line 2 = 500 units on date B).',
    `schedule_line_revision` STRING COMMENT 'Revision counter tracking how many times this delivery schedule line has been modified (date changes, quantity adjustments, rescheduling). Supports audit trail requirements and customer change notification (PCN) tracking.',
    `schedule_line_status` STRING COMMENT 'Current fulfillment lifecycle status of this delivery schedule line. Drives backlog management, delivery performance reporting, and customer communication. blocked indicates an export control or credit hold.. Valid values are `open|confirmed|partially_delivered|fully_delivered|cancelled|blocked`',
    `schedule_status` STRING COMMENT 'The schedule status of the delivery schedule record in the order domain.',
    `scheduled_delivery_date` DATE COMMENT 'The scheduled delivery date associated with the delivery schedule order record.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'The scheduled quantity of the delivery schedule record in the order domain.',
    `scheduled_ship_date` DATE COMMENT 'The planned date on which the shipment is expected to leave the ship-from location (fab, OSAT, or warehouse). Calculated by subtracting transit lead time from the confirmed delivery date.',
    `shipment_tracking_number` STRING COMMENT 'External carrier-assigned tracking number (AWB, BOL, or parcel tracking ID) for the shipment associated with this delivery schedule line. Enables real-time shipment visibility and proof-of-delivery confirmation.',
    `wafer_start_authorization_number` STRING COMMENT 'Wafer Start Authorization number linking this delivery schedule line to the authorized wafer fab start that will produce the units for this delivery. Critical for semiconductor order-to-cash lifecycle management and fab capacity planning.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Planned and confirmed delivery schedule for customer orders, capturing multiple delivery windows per order line. Records scheduled delivery date, confirmed quantity, ship-from location (fab, OSAT, warehouse), ship-to customer location, carrier, incoterms, and schedule line status. Supports rolling delivery schedules for high-volume customers with blanket orders and periodic call-offs. Sourced from SAP S/4HANA SD schedule lines.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique system-generated identifier for the shipment record. Primary key for the shipment data product in the order domain.',
    `account_id` BIGINT COMMENT 'Reference to the customer receiving this shipment. Used for delivery confirmation, revenue recognition, and customer service tracking.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Outgoing quality inspection clearance process: every semiconductor shipment must reference the inspection lot that passed final quality inspection before release. Quality engineers and shipping teams ',
    `order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Shipments fulfill order lines. After merging shipment_line into shipment, the shipment entity needs direct linkage to order lines for fulfillment tracking.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: shipment.package_type is a plain-text denormalization of the package_type entity. Normalizing to a FK enables carrier selection rules, hazmat/moisture sensitivity handling requirements, and shipment-l',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order that initiated this shipment. Links the shipment back to the order-to-cash lifecycle.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Semiconductor shipments require a designated customer receiving contact for delivery confirmation, proof-of-delivery sign-off, and shortage/damage claims. shipment has pod_signoff_reference as plain t',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Shipments originate from a specific warehouse storage location. Inventory depletion tracking, FIFO/FEFO compliance, and warehouse management require a direct FK to the originating storage location. or',
    `address_id` BIGINT COMMENT 'Unique identifier for the ship from address record within the shipment order entity.',
    `shipment_ship_to_address_id` BIGINT COMMENT 'Unique identifier for the ship to address record within the shipment order entity.',
    `to_order_id` BIGINT COMMENT 'FK to order.order.order_id — Shipments fulfill customer orders. shipment.sales_order_id → order.sales_order_id. Critical for order-to-cash traceability.',
    `actual_arrival_date` DATE COMMENT 'Confirmed date the shipment physically arrived at the customer receiving location. Populated from carrier proof of delivery (POD) or customer EDI 856 acknowledgement.',
    `asn_number` STRING COMMENT 'Advance Shipment Notice (ASN) number transmitted to the customer via EDI 856 prior to physical delivery. Enables customer warehouse receiving preparation and automated goods receipt.',
    `carrier_tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment. Enables real-time shipment visibility and customer self-service tracking via carrier portals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary values in this shipment record (e.g., USD, EUR, JPY). Supports multi-currency operations across global semiconductor supply chains.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number referenced on the shipment and delivery documentation. Required for customer receiving, invoice matching, and accounts payable processing.',
    `damaged_goods_flag` BOOLEAN COMMENT 'Indicates whether the customer reported damaged goods upon delivery. Triggers carrier claims process, RMA initiation, and DPPM (Defective Parts Per Million) quality reporting.',
    `declared_value_usd` DECIMAL(18,2) COMMENT 'Declared value of the shipment contents in US dollars for customs and insurance purposes. Required for import duty calculation and export documentation under EAR/ITAR.',
    `delivery_date` DATE COMMENT 'The delivery date associated with the shipment order record.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the customer delivery destination. Required for export compliance screening under EAR and ITAR regulations.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_date` DATE COMMENT 'Carrier-provided estimated date of arrival at the customer destination. Used for delivery scheduling, customer communication, and on-time delivery (OTD) performance tracking.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) assigned to the semiconductor products in this shipment per the Commerce Control List (CCL). Determines applicable export license requirements.',
    `freight_cost_usd` DECIMAL(18,2) COMMENT 'Total freight and logistics cost for this shipment in US dollars. Used for cost allocation, customer billing (if freight is charged), and supply chain cost analytics.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including packaging. Required for carrier freight billing, customs declarations, and dangerous goods compliance.',
    `hs_tariff_code` STRING COMMENT 'Harmonized System (HS) tariff classification code for the semiconductor products in this shipment. Required for customs declarations, import duties, and cross-border trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk and responsibility between seller and buyer. Governs freight cost allocation and title transfer point. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `inspection_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate (Certificate of Conformance or Certificate of Analysis) accompanying the shipment. Required for automotive (IATF 16949) and aerospace customers.',
    `is_multi_leg` BOOLEAN COMMENT 'Indicates whether this shipment involves multiple transportation legs (e.g., fab to OSAT to customer, or cross-border transshipment). Enables multi-leg shipment tracking and compliance documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the shipment record in the order domain.',
    `lot_numbers` STRING COMMENT 'Comma-separated list of manufacturing lot numbers (wafer lot IDs) included in this shipment. Enables full traceability from customer delivery back to wafer fabrication and process engineering records in Camstar MES.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the shipment record in the order domain.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or customer-specific delivery requirements associated with this shipment (e.g., ESD handling, temperature-controlled transport).',
    `number` STRING COMMENT 'Externally visible, human-readable shipment identifier used in carrier communications, customer EDI 856 ASN, and logistics documentation. Sourced from SAP S/4HANA SD outbound delivery number.. Valid values are `^SHP-[0-9]{10}$`',
    `package_count` STRING COMMENT 'Total number of physical packages (boxes, reels, trays, tubes) included in this shipment. Used for carrier manifest, customs declaration, and receiving verification.',
    `pod_confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed as received by the customer at the delivery location per the proof of delivery (POD). Compared against shipped_quantity to identify shortages or overages.',
    `pod_receipt_date` DATE COMMENT 'Date the customer confirmed receipt of the shipment as captured in the proof of delivery (POD). Triggers downstream invoice release and revenue recognition in SAP S/4HANA FI.',
    `pod_signoff_reference` STRING COMMENT 'Customer signoff reference or electronic signature identifier from the proof of delivery document. Serves as legal evidence of delivery completion for dispute resolution and revenue recognition.',
    `quantity_shortage_flag` BOOLEAN COMMENT 'Indicates whether the customer reported a quantity shortage at delivery (POD confirmed quantity less than shipped quantity). Triggers discrepancy investigation and potential credit memo.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the shipment contents comply with EU REACH regulation requirements for chemical substance registration and restriction. Required for EU market access.',
    `receiving_location_code` STRING COMMENT 'Code identifying the specific customer receiving dock, warehouse, or facility where the shipment was delivered. Used for multi-site customer delivery routing and POD reconciliation.',
    `rma_reference_number` STRING COMMENT 'Return Merchandise Authorization (RMA) number associated with this shipment if a return or dispute has been initiated. Links shipment to the RMA and reverse logistics process.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether all semiconductor products in this shipment comply with the EU Restriction of Hazardous Substances (RoHS) Directive. Required for EU market access and customer compliance declarations.',
    `service_level` STRING COMMENT 'Carrier service tier selected for this shipment (e.g., overnight, express, standard ground). Determines transit time commitment and freight cost.. Valid values are `standard|express|overnight|economy|priority`',
    `ship_date` DATE COMMENT 'Actual date the shipment physically departed the origin facility (fab, OSAT, or distribution center). Principal business event date for the shipment transaction.',
    `shipment_status` STRING COMMENT 'Current lifecycle state of the shipment. Drives downstream processes including invoice release and revenue recognition upon delivery confirmation.. Valid values are `draft|confirmed|in_transit|delivered|cancelled|on_hold`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Total quantity of semiconductor units (dies, packaged ICs, wafers) physically shipped in this shipment. Expressed in the base unit of measure (UOM) for the product.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total weight kg of the shipment record in the order domain.',
    `tracking_number` STRING COMMENT 'The tracking number of the shipment record in the order domain.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the shipped quantity. EA = each (packaged IC), WFR = wafer, DIE = individual die, REEL = tape-and-reel, TRAY = JEDEC tray, TUBE = IC tube.. Valid values are `EA|WFR|DIE|REEL|TRAY|TUBE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the shipment record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wrong_part_flag` BOOLEAN COMMENT 'Indicates whether the customer reported receipt of an incorrect part number or product. Triggers RMA process, root cause analysis, and corrective action in the quality management system.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Physical shipment record tracking the outbound movement of semiconductor products from origin (fab, OSAT, distribution center) to customer destination. Header captures shipment number, carrier, tracking number, ship date, estimated and actual arrival dates, package count, gross weight, HS tariff codes, export license reference, and shipment status. Line-level detail captures shipped quantity per order line, lot numbers, wafer lot IDs, package types, serial numbers, unit of measure, and inspection certificate references. Delivery confirmation section captures proof of delivery (POD) including confirmed receipt date, receiving location, confirmed quantity, customer PO reference, discrepancy flags (quantity shortage, wrong part, damaged goods), and customer signoff reference. POD receipt triggers downstream invoice release and revenue recognition. Supports multi-leg shipments, cross-border trade compliance (EAR, ITAR), RMA dispute resolution, and full traceability from order line through physical delivery. Sourced from SAP S/4HANA SD outbound delivery, carrier POD data, and customer EDI 856 ASN acknowledgements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` (
    `shipment_line_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment line record in the Silver Layer lakehouse. Primary key for the shipment_line data product.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Shipment line traceability to assembly lot is mandatory for quality recalls, DPPM reporting, and customer complaint resolution. Semiconductor customers require lot-level traceability on shipped units;',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Finished good lot traceability at shipment line level is required for Certificate of Conformance (CoC), DPPM tracking, and RoHS/REACH regulatory compliance. Each shipment line ships a specific finishe',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Lot-level quality clearance per shipment line: semiconductor shipment lines map to specific inspected lots. Direct FK enables shipment-line quality traceability reports and certificate-of-conformance ',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: shipment_line.package_type is a plain-text denormalization of the package_type entity. A proper FK enforces referential integrity, enables package-level shipment analytics (e.g., units shipped by pack',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the primary order line record within the shipment line order entity.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment header record. Links this line to the physical shipment event (HEADER_REFERENCE per TRANSACTION_LINE role).',
    `primary_shipment_order_line_id` BIGINT COMMENT 'Reference to the customer order line that this shipment line fulfills. Enables traceability from physical shipment back to the originating sales order line in the order-to-cash lifecycle.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, etc.) being shipped on this line. RESOURCE_REFERENCE per TRANSACTION_LINE role.',
    `to_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Critical fulfillment traceability link. Each shipment line fulfills a specific order line. Required for order fulfillment tracking, partial shipment management, and revenue recognition.',
    `to_shipment_id` BIGINT COMMENT 'FK to order.shipment.shipment_id — Fundamental header-to-line relationship. Every shipment line must belong to exactly one shipment.',
    `actual_ship_date` DATE COMMENT 'Date on which the product was physically handed over to the carrier or freight forwarder. Used for on-time shipment performance, revenue recognition trigger, and export documentation.',
    `advance_ship_notice_number` STRING COMMENT 'EDI Advance Ship Notice (ASN/856) document number transmitted to the customer prior to shipment. Enables customer receiving automation and inventory planning.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether this shipment line represents a partial fulfillment of a backordered quantity, where the full ordered quantity could not be shipped due to inventory allocation constraints.',
    `certificate_of_conformance_number` STRING COMMENT 'Document number of the Certificate of Conformance issued by quality assurance, attesting that the shipped product meets all specified requirements. Required for automotive (IATF 16949) and aerospace customers.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the semiconductor product was manufactured or substantially transformed. Required for customs declarations, export control (EAR/ITAR), and RoHS/REACH compliance documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment line record was first created in the system. Used for audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit selling price and line value (e.g., USD, EUR, JPY). Required for multi-currency order management.. Valid values are `^[A-Z]{3}$`',
    `customer_part_number` STRING COMMENT 'Customer-assigned part number or device designation for the shipped product. Required for customer-facing shipping documents, ASN (Advance Ship Notice), and design-in traceability.',
    `date_code` STRING COMMENT 'Manufacturing date code in YYWW format (year + work week) indicating when the product was fabricated or assembled. Required for shelf-life management, FIFO inventory rotation, and customer quality audits.. Valid values are `^[0-9]{4}[0-9]{2}$`',
    `delivery_document_number` STRING COMMENT 'Externally-visible SAP outbound delivery document number associated with this shipment line, used for customer communication and logistics coordination.',
    `die_bank_order_number` STRING COMMENT 'Reference to the die bank order from which known good dies (KGD) were drawn for this shipment. Applicable when shipping bare dies or KGD from die bank inventory rather than packaged product.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned to this product line item per the US Commerce Control List (CCL). Required for EAR compliance screening and export license determination for semiconductor products.',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when goods issue was posted in SAP, marking the transfer of ownership and triggering revenue recognition and inventory reduction. BUSINESS_EVENT_TIMESTAMP for this transaction line.',
    `inspection_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate (Certificate of Conformance or Certificate of Analysis) issued for this shipment line. Links to quality records from KLA ICOS inspection systems and QM module.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this shipment line item is subject to ITAR controls as a defense article or defense service. When true, requires State Department export license and end-use certificate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the shipment line record in the order domain.',
    `line_net_value` DECIMAL(18,2) COMMENT 'Total net value of this shipment line (shipped_quantity × unit_selling_price after applicable discounts). Used for revenue recognition, invoice generation, and SOX financial reporting.',
    `line_number` STRING COMMENT 'Sequential line number within the parent shipment, used to order and reference individual line items. LINE_SEQUENCE per TRANSACTION_LINE role.',
    `line_status` STRING COMMENT 'Current fulfillment lifecycle status of this shipment line. Tracks progression from open through picking, packing, shipment, and delivery confirmation or cancellation.. Valid values are `open|picking|packed|shipped|delivered|cancelled`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the shipment line record in the order domain.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC moisture sensitivity level classification for the shipped packaged IC. Determines floor life, storage, and baking requirements at the customers SMT assembly facility.. Valid values are `MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Original quantity requested on the customer order line for this product. Enables calculation of fulfillment rate and identification of short-ships or over-ships.',
    `packaging_configuration` STRING COMMENT 'Physical packaging configuration used for the shipped semiconductor units. Determines handling requirements, moisture sensitivity level (MSL), and customer SMT assembly compatibility.. Valid values are `tape_and_reel|tray|tube|bulk|waffle_pack|dry_pack`',
    `part_number` STRING COMMENT 'Manufacturer part number (MPN) for the shipped semiconductor product as listed in the product catalog and on the shipping documentation. Used for customer identification and BOM matching.',
    `partial_shipment_flag` BOOLEAN COMMENT 'Indicates whether this line represents a partial shipment against the order line quantity. When true, additional shipment lines are expected to fulfill the remaining ordered quantity.',
    `promised_delivery_date` DATE COMMENT 'Committed delivery date for this shipment line as agreed with the customer at order entry. Used for on-time delivery (OTD) performance measurement and customer SLA tracking.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the shipped product complies with EU REACH regulation requirements for chemical substance registration and restriction. Required for EU market access and supply chain transparency.',
    `revision_level` STRING COMMENT 'Hardware or mask revision level of the shipped IC (e.g., A0, B1, C2). Critical for customer compatibility verification, PCN (Product Change Notification) compliance, and field failure analysis.',
    `rma_reference_number` STRING COMMENT 'RMA number associated with this shipment line if it is a replacement shipment for a previously returned or disputed lot. Enables linkage between original shipment, quality dispute, and replacement fulfillment.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the shipped product complies with EU RoHS Directive restrictions on hazardous substances (lead, mercury, cadmium, etc.). Required for EU market access and customer compliance declarations.',
    `serial_number` STRING COMMENT 'The serial number of the shipment line record in the order domain.',
    `serial_number_range_end` STRING COMMENT 'Ending serial number of the serialized unit range included in this shipment line. Used with serial_number_range_start to define the complete set of serialized units shipped.',
    `serial_number_range_start` STRING COMMENT 'Starting serial number of the serialized unit range included in this shipment line. Applicable for high-value or security-sensitive ICs requiring individual unit traceability (e.g., automotive, military-grade).',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of semiconductor units (dies, packaged ICs, wafers, etc.) physically shipped on this line. LINE_QUANTITY per TRANSACTION_LINE role. May differ from ordered quantity due to partial shipments or allocation constraints.',
    `temperature_grade` STRING COMMENT 'Operating temperature range grade of the shipped IC (commercial: 0–70°C, industrial: -40–85°C, automotive: -40–125°C, military: -55–125°C). Critical for customer application qualification and IATF 16949 automotive compliance.. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the shipped quantity. Common semiconductor UoMs include EA (each/die), WFR (wafer), LOT (production lot), REEL (tape-and-reel packaging), TRAY (IC tray), BOX (carton). Aligned with SAP base UoM.. Valid values are `EA|WFR|LOT|REEL|TRAY|BOX`',
    `unit_selling_price` DECIMAL(18,2) COMMENT 'Agreed selling price per unit for this shipment line as invoiced to the customer. LINE_VALUE_OR_RESULT per TRANSACTION_LINE role. Sensitive commercial pricing data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this shipment line record. Supports change data capture (CDC), audit compliance, and Silver Layer delta processing.',
    `wafer_start_authorization_number` STRING COMMENT 'Wafer Start Authorization number that triggered the production lot associated with this shipment line. Links shipment fulfillment back to the original fab capacity commitment in the order-to-cash lifecycle.',
    `yield_grade` STRING COMMENT 'Quality or speed grade assigned to the shipped product based on wafer test (probe) results and final test binning. Indicates performance tier (e.g., commercial, industrial, automotive, military grade) for the shipped units.',
    CONSTRAINT pk_shipment_line PRIMARY KEY(`shipment_line_id`)
) COMMENT 'Line-level detail of a shipment record, linking specific order lines and quantities to a physical shipment. Captures shipped quantity, unit of measure, lot number, wafer lot ID, package type, serial numbers (where applicable), and inspection certificate references. Enables traceability from customer order line to physical shipment and supports RMA and quality dispute resolution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` (
    `backlog_position_id` BIGINT COMMENT 'Unique surrogate identifier for each backlog position snapshot record in the order-to-cash lifecycle. Primary key for the backlog_position data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this backlog position. Used for customer-level backlog aggregation, escalation prioritization, and revenue forecasting.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Backlog positions tied to design wins receive priority allocation in constrained semiconductor supply. backlog_position has design_win_flag (boolean) but no FK to the actual design win record. This FK',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Backlog positions for KGD (Known Good Die) products require direct reference to die bank inventory for supply commitment analysis. Semiconductor die backlog management explicitly tracks available die ',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: backlog_position.wafer_lot_number is a denormalized string referencing the wafer lot supplying the backlog. Semiconductor supply-demand matching and backlog management require tracing which specific w',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the backlog position order entity.',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this backlog position belongs. Links the backlog snapshot to the originating customer order.',
    `order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Backlog positions track unshipped quantities for specific order lines. Without this FK, backlog cannot be reconciled to orders.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Semiconductor supply/demand backlog reports are always segmented by process node for fab capacity planning and constrained-supply prioritization. backlog_position.process_node is a plain-text denormal',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Quality-impacted backlog management: backlog_position already tracks hold_code, indicating quality holds affect backlog. Direct FK to quality_hold enables supply planners to identify and resolve quali',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or discrete device) associated with this backlog position. Enables product-level backlog analysis and demand planning.',
    `stock_balance_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_balance. Business justification: Semiconductor backlog management requires daily reconciliation of open backlog quantity against available stock balance to determine fulfillment risk, push-out decisions, and revenue forecasting. Back',
    `aging_days` STRING COMMENT 'The aging days of the backlog position record in the order domain.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity from available inventory or in-process production lots that has been formally allocated to fulfill this backlog position. May be less than committed_quantity in constrained supply scenarios.',
    `allocation_status` STRING COMMENT 'Indicates the degree to which available inventory or production capacity has been allocated to fulfill this backlog position. Critical for backlog management and supply-demand balancing in constrained semiconductor supply environments.. Valid values are `unallocated|partially_allocated|fully_allocated|over_allocated`',
    `backlog_aging_days` STRING COMMENT 'Number of calendar days this order line has been in open backlog as of the snapshot date, calculated from order_entry_date. Used for customer escalation prioritization and aged backlog reporting.',
    `backlog_quantity` DECIMAL(18,2) COMMENT 'The backlog quantity of the backlog position record in the order domain.',
    `backlog_status` STRING COMMENT 'Current workflow state of this backlog position. open = unshipped committed order; committed = confirmed with delivery date; at_risk = delivery commitment in jeopardy; pushed_out = delivery date deferred; cancelled = order line cancelled; fulfilled = shipped and closed.. Valid values are `open|committed|at_risk|pushed_out|cancelled|fulfilled`',
    `backlog_value` DECIMAL(18,2) COMMENT 'The monetary value of the unshipped committed backlog quantity, calculated as committed_quantity multiplied by the net selling price. Used for revenue forecasting, quarterly guidance, and book-to-bill ratio reporting.',
    `backlog_value_usd` DECIMAL(18,2) COMMENT 'The backlog value usd of the backlog position record in the order domain.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'Quantity cancelled from the original order line. Tracks cancellation impact on backlog coverage and book-to-bill ratio reporting.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The unshipped quantity (in units) that remains committed in backlog for this order line as of the snapshot date. Core metric for backlog management and production planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this backlog position record was first created in the data platform. Used for audit trail, data lineage, and record lifecycle management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the backlog value and selling price are denominated (e.g., USD, EUR, JPY, KRW, TWD). Required for multi-currency backlog reporting and FX exposure analysis.. Valid values are `^[A-Z]{3}$`',
    `current_commit_date` DATE COMMENT 'The most recent confirmed delivery date committed to the customer, reflecting any push-outs or pull-ins from the original promise date. Used for revenue forecasting and quarterly close planning.',
    `customer_part_number` STRING COMMENT 'The customers own part number or reference code for the ordered product. Required for customer-facing order confirmations and cross-referencing customer purchase orders with internal part numbers.',
    `customer_po_number` STRING COMMENT 'The customers purchase order number referencing this backlog position. Required for customer reconciliation, invoice matching, and accounts receivable processing.',
    `design_win_flag` BOOLEAN COMMENT 'Indicates whether this backlog position is associated with a strategic design-win account tracked in Salesforce CRM. Design-win orders receive elevated fulfillment priority to protect long-term revenue relationships.',
    `end_market_segment` STRING COMMENT 'The end-market application segment for which the ordered semiconductor product is destined. Used for segment-level backlog analysis, demand forecasting, and investor guidance on market exposure. [ENUM-REF-CANDIDATE: computing|mobile|automotive|industrial|iot|communications|consumer|ai_datacenter — promote to reference product]',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this order line is subject to export control regulations (EAR/ITAR). When true, shipment requires validated export license or license exception before fulfillment.',
    `export_license_number` STRING COMMENT 'The export license number issued by the Bureau of Industry and Security (BIS) or State Department authorizing shipment of controlled semiconductor products. Required when export_control_flag is true.',
    `hold_code` STRING COMMENT 'Code indicating the reason this backlog position is on hold and cannot be shipped. Examples include credit hold, export license pending, quality hold, or customer-requested hold. Null when no hold is active. [ENUM-REF-CANDIDATE: credit_hold|export_hold|quality_hold|customer_hold|compliance_hold|capacity_hold — promote to reference product]',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between seller and buyer for this order line. Impacts revenue recognition timing. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the backlog position record in the order domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this backlog position record was most recently modified, reflecting the latest change to any field such as commit date revision, quantity adjustment, or status change.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the backlog position record in the order domain.',
    `net_selling_price` DECIMAL(18,2) COMMENT 'The agreed net unit selling price for this order line after all applicable discounts and price adjustments. Used to compute backlog value and support revenue recognition under ASC 606.',
    `order_entry_date` DATE COMMENT 'The date on which the customer order was originally entered into the order management system. Used to calculate backlog aging and time-in-backlog metrics.',
    `order_type` STRING COMMENT 'Classification of the order type driving this backlog position. Distinguishes standard production orders from Multi-Project Wafer (MPW) orders, die bank orders, wafer start authorizations, sample orders, Return Material Authorizations (RMA), and consignment orders. [ENUM-REF-CANDIDATE: standard|mpw|die_bank|wafer_start|sample|rma|consignment — promote to reference product]',
    `original_order_quantity` DECIMAL(18,2) COMMENT 'The total quantity originally ordered by the customer on this order line. Used to calculate fulfillment percentage and track cancellation or reduction impacts on backlog.',
    `original_promise_date` DATE COMMENT 'The initial delivery date committed to the customer at the time of order entry. Baseline for measuring push-outs and delivery performance against original commitment.',
    `part_number` STRING COMMENT 'The manufacturers part number (MPN) of the semiconductor product ordered. Used for product identification, cross-referencing with PLM and ERP systems, and customer-facing order documentation.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking assigned to this backlog position for allocation and fulfillment sequencing. Lower values indicate higher priority. Used during supply-constrained periods to prioritize strategic customers and design-win accounts.',
    `promised_date` DATE COMMENT 'The promised date associated with the backlog position order record.',
    `push_out_days` STRING COMMENT 'Number of calendar days the current_commit_date has been deferred beyond the original_promise_date. Positive value indicates a push-out (delay); negative value indicates a pull-in (acceleration). Key metric for delivery performance and customer satisfaction.',
    `push_out_reason_code` STRING COMMENT 'Standardized reason code explaining why the delivery commitment was pushed out or pulled in. Examples include wafer yield issue, capacity constraint, material shortage, customer request, or logistics delay. [ENUM-REF-CANDIDATE: yield_issue|capacity_constraint|material_shortage|customer_request|logistics_delay|design_change|export_hold — promote to reference product]',
    `requested_date` DATE COMMENT 'The requested date associated with the backlog position order record.',
    `requested_delivery_date` DATE COMMENT 'The delivery date originally requested by the customer on the purchase order. May differ from the original promise date if the committed date was negotiated.',
    `revenue_recognition_flag` BOOLEAN COMMENT 'Indicates whether this backlog position meets the criteria for revenue recognition upon shipment under ASC 606 / IFRS 15. False indicates revenue deferral conditions apply (e.g., consignment, bill-and-hold arrangements).',
    `sales_region` STRING COMMENT 'Geographic sales region associated with this backlog position (e.g., Americas, EMEA, Japan, Greater China, Rest of APAC). Used for regional backlog reporting and revenue forecasting.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for shipment. Used for export control screening, logistics routing, and regional revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity already shipped against this order line as of the snapshot date. Together with committed_quantity, reconciles to the original order quantity.',
    `snapshot_date` DATE COMMENT 'The calendar date on which this point-in-time backlog position snapshot was captured. Enables time-series backlog trending, quarterly close reporting, and book-to-bill ratio calculation.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed for this backlog position. EA = each (individual units), KU = thousands of units, WAFER = full wafer, DIE = individual die, REEL = tape-and-reel packaging unit, TRAY = tray packaging unit.. Valid values are `EA|KU|WAFER|DIE|REEL|TRAY`',
    CONSTRAINT pk_backlog_position PRIMARY KEY(`backlog_position_id`)
) COMMENT 'Point-in-time snapshot of open order backlog for a specific order line, capturing unshipped committed quantity, backlog value, original promise date, current commit date, and backlog aging in days. Used for backlog management, revenue forecasting, customer escalation prioritization, and quarterly book-to-bill ratio reporting. Tracks push-outs, pull-ins, and cancellations affecting committed backlog. Critical for semiconductor revenue recognition, quarterly close processes, and investor guidance on backlog coverage.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` (
    `allocation_record_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a single inventory, capacity, or lot allocation record within the order fulfillment process.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom inventory or capacity is being allocated. Used for constrained supply allocation prioritization across competing customers.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Inventory allocation in semiconductors is performed at the assembly lot level — specific packaged units from a specific lot are committed to a customer order. This FK enables allocation planners to id',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Semiconductor allocation decisions during supply constraints prioritize customers with active design wins. Linking allocation_record to customer_design_win enables design-win-priority allocation polic',
    `die_bank_id` BIGINT COMMENT 'Unique identifier for the die bank record within the allocation record order entity.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: allocation_record.lot_number is a denormalized string referencing the wafer lot being allocated. Semiconductor supply allocation requires a direct FK to the wafer lot to support constrained supply man',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Allocation of packaged IC finished good lots to order lines is a core semiconductor fulfillment process. allocation_record already references die_bank and inventory_wafer_lot but lacks a direct FK to ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Quality-gated allocation: allocation_record already tracks quality_disposition and quality_disposition_notes, indicating quality status drives allocation decisions. Direct FK to inspection_lot formali',
    `order_id` BIGINT COMMENT 'Unique identifier for the allocation order record within the allocation record order entity.',
    `order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Allocations reserve inventory against specific order lines. This is the core link for constrained supply management.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Semiconductor allocation decisions are node-constrained — constrained_supply_flag and allocation prioritization are driven by process node capacity. allocation_record.process_node is a plain-text deno',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Quality-constrained allocation: allocation_record has constrained_supply_flag and quality_disposition attributes indicating quality holds constrain allocations. Direct FK to quality_hold formalizes th',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, packaged die, or wafer) being allocated to the customer order line.',
    `stock_balance_id` BIGINT COMMENT 'Unique identifier for the stock balance record within the allocation record order entity.',
    `actual_ship_date` DATE COMMENT 'The actual date on which the allocated goods were shipped to the customer. Used for on-time delivery measurement and order fulfillment confirmation.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of units (dies, wafers, or packaged devices) reserved against the customer order line. Expressed in the unit of measure applicable to the lot type.',
    `allocation_date` DATE COMMENT 'The business date on which the allocation was created and the inventory or capacity was reserved against the order line. Principal business event date for this transaction.',
    `allocation_number` STRING COMMENT 'Externally visible, human-readable business identifier for this allocation record. Used in customer communications, ERP transactions, and supply chain coordination.. Valid values are `^ALLOC-[0-9]{10}$`',
    `allocation_priority` STRING COMMENT 'The allocation priority of the allocation record record in the order domain.',
    `allocation_source` STRING COMMENT 'Identifies the inventory or capacity pool from which this allocation is drawn: finished_goods (packaged inventory), die_bank (singulated die inventory), wafer_lot (in-process wafer inventory), fab_capacity (reserved fab production capacity), mpw_pool (Multi-Project Wafer shared pool).. Valid values are `finished_goods|die_bank|wafer_lot|fab_capacity|mpw_pool`',
    `allocation_status` STRING COMMENT 'The allocation status of the allocation record record in the order domain.',
    `allocation_type` STRING COMMENT 'Categorizes the nature of the allocation: hard (firm reservation of physical inventory), soft (provisional hold pending confirmation), tentative (preliminary planning hold), capacity (fab capacity reservation), die_bank (allocation from die bank inventory), mpw (Multi-Project Wafer run allocation). [ENUM-REF-CANDIDATE: hard|soft|tentative|capacity|die_bank|mpw — promote to reference product]. Valid values are `hard|soft|tentative|capacity|die_bank|mpw`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the allocation assignment: tentative (preliminary hold), confirmed (firm allocation committed to order), shipped (goods dispatched against this allocation), cancelled (allocation voided), expired (allocation lapsed past expiry date), on_hold (allocation suspended pending resolution). [ENUM-REF-CANDIDATE: tentative|confirmed|shipped|cancelled|expired|on_hold — promote to reference product]. Valid values are `tentative|confirmed|shipped|cancelled|expired|on_hold`',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this allocation record is part of the open order backlog (i.e., not yet shipped). Used for backlog management reporting and supply-demand balancing.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why this allocation was cancelled. Populated when assignment_status transitions to cancelled. Supports root cause analysis and supply planning.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this allocation is associated with production eligible for US CHIPS and Science Act incentives or reporting requirements. Supports CHIPS Act compliance tracking.',
    `confirmation_date` DATE COMMENT 'The date on which the allocation was formally confirmed, transitioning from tentative or soft to confirmed status. Triggers downstream shipment scheduling.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity formally confirmed for shipment after quality disposition and availability verification. May differ from allocated_quantity due to yield loss, quality holds, or partial confirmations.',
    `constrained_supply_flag` BOOLEAN COMMENT 'Indicates whether this allocation was made under constrained supply conditions, where demand exceeded available inventory or fab capacity. Triggers priority-based allocation logic.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this allocation record was first created in the order fulfillment system. Supports audit trail and data lineage requirements.',
    `end_market_segment` STRING COMMENT 'Target end-market segment for the allocated product: automotive, mobile, computing, iot, aerospace, industrial, consumer. Drives allocation priority rules and regulatory traceability requirements (e.g., IATF 16949 for automotive). [ENUM-REF-CANDIDATE: automotive|mobile|computing|iot|aerospace|industrial|consumer — promote to reference product]',
    `expiry_date` DATE COMMENT 'The date after which this allocation record is no longer valid and reserved inventory or capacity is released back to available supply. Critical for managing soft allocations and tentative holds.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) applicable to the allocated product lot. Required for export compliance screening and license determination.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where the allocated wafer lot or die lot was manufactured. Supports supply chain traceability and export control compliance.',
    `hold_reason` STRING COMMENT 'Reason code or description explaining why this allocation is placed on hold. Populated when assignment_status is on_hold. May relate to quality holds, export control review, or customer credit issues.',
    `inventory_batch_code` STRING COMMENT 'SAP batch management identifier for the specific inventory batch being allocated. Enables batch-level traceability and quality disposition linkage within SAP S/4HANA MM.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the allocated lot is subject to International Traffic in Arms Regulations (ITAR) controls. When true, additional export licensing and handling restrictions apply.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the allocation record record in the order domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this allocation record. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `lot_type` STRING COMMENT 'Classifies the type of manufacturing lot being allocated: wafer_lot (silicon wafer lot at fab), die_lot (singulated die inventory), packaged_goods_lot (finished packaged semiconductor units), mpw_lot (Multi-Project Wafer shared lot).. Valid values are `wafer_lot|die_lot|packaged_goods_lot|mpw_lot`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the allocation record record in the order domain.',
    `osat_site_code` STRING COMMENT 'Code identifying the Outsourced Semiconductor Assembly and Test (OSAT) facility responsible for packaging and testing the allocated lot. Relevant for packaged goods lot allocations.',
    `priority` STRING COMMENT 'The priority of the allocation record record in the order domain.',
    `priority_rank` STRING COMMENT 'Numeric priority rank assigned to this allocation record for constrained supply allocation decisions. Lower values indicate higher priority. Used during supply shortages to sequence allocation across competing customer orders.',
    `quality_disposition` STRING COMMENT 'Quality disposition status of the allocated lot or inventory batch: accepted (meets all quality specifications), rejected (fails quality criteria), conditionally_accepted (accepted with documented deviations), under_review (quality evaluation in progress), scrapped (lot destroyed). Supports IATF 16949 lot-level quality traceability.. Valid values are `accepted|rejected|conditionally_accepted|under_review|scrapped`',
    `quality_disposition_notes` STRING COMMENT 'Free-text notes documenting lot-specific quality disposition findings, deviations, or conditions associated with this allocation. Supports automotive and aerospace traceability requirements.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the allocated quantity: EA (each, for packaged units), WFR (wafers), DIE (individual die), KPC (thousand pieces). Aligns with SAP base unit of measure.. Valid values are `EA|WFR|DIE|KPC`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the allocated lot complies with EU REACH regulation requirements for chemical safety. Required for EU market shipments and supply chain due diligence.',
    `requested_ship_date` DATE COMMENT 'Customer-requested shipment date for the allocated quantity. Used for delivery schedule management and on-time delivery performance tracking.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the allocated lot meets EU RoHS Directive requirements for restriction of hazardous substances. Required for EU market shipments and customer compliance documentation.',
    `scheduled_ship_date` DATE COMMENT 'Internally confirmed shipment date scheduled by supply chain planning for this allocation. May differ from requested_ship_date due to capacity or inventory constraints.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped against this allocation record. Populated upon delivery confirmation. Used for order fulfillment reconciliation and backlog management.',
    `wafer_start_authorization_number` STRING COMMENT 'Wafer Start Authorization number associated with this allocation, linking the allocation to the authorized fab production run. Relevant for capacity allocations and wafer lot allocations in the order-to-cash lifecycle.',
    CONSTRAINT pk_allocation_record PRIMARY KEY(`allocation_record_id`)
) COMMENT 'Inventory, capacity, and lot allocation record that reserves specific wafer lots, die bank inventory, finished goods, or fab capacity against a customer order line. Captures allocated quantity, allocation type (hard/soft), allocated lot or inventory batch, lot number, lot type (wafer lot, die lot, packaged goods lot), assignment status (tentative, confirmed, shipped), assignment date, lot-specific quality disposition notes, allocation expiry date, and priority rank. SSOT for all allocation and lot-to-order assignment decisions in the order fulfillment process. Manages constrained supply allocation across competing customer orders during supply shortages. Supports automotive (IATF 16949) and aerospace lot-level traceability requirements from order through shipment.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Primary key for rma',
    `account_id` BIGINT COMMENT 'Reference to the customer initiating the return. Links RMA to the customer master record.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: RMA root cause analysis requires tracing returned parts to their originating assembly lot to identify systemic packaging defects, calculate DPPM impact, and trigger CAPA. This is a standard quality tr',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: RMA processing in semiconductors generates credit memos (ar_invoice with is_credit_memo=true). Credit memo issuance and credit reconciliation reports require tracing each RMA to its resulting credit m',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: RMA processing in semiconductors requires checking the governing customer contract for warranty terms, return eligibility windows, credit memo authorization limits, and EOL/LTB clauses. Contract-drive',
    `failure_analysis_report_id` BIGINT COMMENT 'Reference to the failure analysis record if FA was performed. Links RMA to detailed root cause investigation and corrective action.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: RMA failure analysis and test escape investigation require tracing returned units to their final test run. Corrective action reports and DPPM analysis depend on knowing whether the failure was a test ',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the rma order entity.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Customer returns process: semiconductor RMAs formally generate or reference a nonconformance report (NCR) documenting the defect. Quality and customer service teams require this link for regulatory co',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line record within the rma order entity.',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — RMAs reference the original sales order for the returned product. rma.sales_order_id → order.sales_order_id.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: RMA returns are received into a specific quarantine or inspection storage location. Tracking the receiving storage location is essential for quarantine management, quality inspection routing, and inve',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: RMA logistics require tracking the customer address from which defective semiconductor parts are returned for export control compliance, return freight management, and receiving facility routing. rma ',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: RMA root cause analysis in semiconductors frequently traces field failures to a specific design revision (e.g., a known bug fixed in a later rev). Corrective action and DPPM reporting require linking ',
    `rma_order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — RMAs reference the original sales order for the returned product. Required for credit processing and quality traceability.',
    `tertiary_rma_sales_order_id` BIGINT COMMENT 'Reference to the original sales order from which the returned product was shipped. Links RMA to the originating order transaction.',
    `unit_test_result_id` BIGINT COMMENT 'Foreign key linking to test.unit_test_result. Business justification: For serialized RMA returns, root cause analysis requires linking the specific returned unit to its individual unit test result to determine if it passed test (field failure) or was a test escape. This',
    `approval_date` DATE COMMENT 'Date when the RMA was approved by the quality or customer service team. Nullable if RMA is rejected or still pending.',
    `approved_date` DATE COMMENT 'The approved date associated with the rma order record.',
    `closed_date` DATE COMMENT 'Date when the RMA was fully closed after disposition action completed (credit issued, replacement shipped, or material scrapped).',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action (CAPA) is required based on the RMA findings. True triggers CAPA workflow per ISO 9001 and IATF 16949.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA record was first created in the system. Audit trail for record lifecycle tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the credit issued to the customer in the transaction currency. Nullable if no credit is issued.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, JPY, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_contact_email` STRING COMMENT 'Email address of the customer contact for RMA correspondence, status updates, and resolution communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_name` STRING COMMENT 'Name of the customer representative who initiated or is managing the RMA on the customer side. Used for communication and escalation.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact for urgent RMA inquiries or escalation.',
    `defect_description` STRING COMMENT 'Free-text description of the defect or issue reported by the customer. Captures detailed failure symptoms, visual observations, or functional anomalies.',
    `disposition` STRING COMMENT 'The disposition of the rma record in the order domain.',
    `disposition_instruction` STRING COMMENT 'Action to be taken with the returned material. Determines downstream workflow (credit memo, replacement order, FA request, or scrap authorization).. Valid values are `scrap|rework|credit|replacement|return_to_vendor|failure_analysis`',
    `dppm_impact_flag` BOOLEAN COMMENT 'Indicates whether this RMA should be counted in DPPM calculations. True if the defect is attributable to manufacturing or design (excludes customer-induced damage).',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether the returned product is subject to export control regulations (ITAR, EAR). True requires special handling and documentation.',
    `failure_analysis_requested` BOOLEAN COMMENT 'Indicates whether a formal failure analysis (FA) has been requested for the returned units. True triggers FA workflow and lab assignment.',
    `inspection_result` STRING COMMENT 'Outcome of the incoming inspection. Determines whether the return claim is valid and informs disposition and credit decisions.. Valid values are `defect_confirmed|no_defect_found|customer_induced|shipping_damage|inconclusive`',
    `internal_notes` STRING COMMENT 'Internal notes and comments for cross-functional coordination (quality, engineering, customer service). Not shared with customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA record was last updated. Audit trail for change tracking and data lineage.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the rma record in the order domain.',
    `number` STRING COMMENT 'Externally-visible unique business identifier for the RMA. Used in customer communications, shipping labels, and cross-system tracking.. Valid values are `^RMA-[0-9]{8,12}$`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is REACH compliant. Affects material handling, disposal, and rework procedures.',
    `reason_code` STRING COMMENT 'Coded value representing the reason code of the rma order record.',
    `received_date` DATE COMMENT 'Date when the returned material was physically received at the receiving facility or OSAT partner. Nullable until material arrives.',
    `request_date` DATE COMMENT 'Date when the customer initiated the RMA request. Principal business event timestamp for the RMA lifecycle.',
    `return_reason_code` STRING COMMENT 'Standardized code categorizing the reason for the return. Used for root cause analysis, DPPM tracking, and warranty claim classification.. Valid values are `quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory`',
    `return_shipping_carrier` STRING COMMENT 'Name of the logistics carrier used to ship the returned material (e.g., FedEx, UPS, DHL, regional freight forwarder).',
    `return_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment. Used for shipment visibility and proof of receipt.',
    `returned_quantity` STRING COMMENT 'Number of units (dies, packaged chips, or wafers) returned under this RMA. Used for DPPM calculation and inventory adjustment.',
    `rma_date` DATE COMMENT 'The date associated with the rma order record.',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA. Tracks progression from customer request through receipt, inspection, and final disposition. [ENUM-REF-CANDIDATE: requested|approved|rejected|in_transit|received|inspected|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is RoHS compliant. Affects disposition options (scrap vs. rework) and environmental handling requirements.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause identified during inspection or FA. Used for DPPM trending and corrective action prioritization.. Valid values are `design|process|material|handling|test_escape|customer_misuse`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity. EA=each (individual die/chip), WFR=wafer, LOT=production lot, KIT=assembly kit.. Valid values are `EA|WFR|LOT|KIT`',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this RMA is being processed as a warranty claim. True if the return is within warranty period and defect is covered.',
    `warranty_expiration_date` DATE COMMENT 'Date when the warranty coverage for the returned product expires. Used to validate warranty claim eligibility.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'RMA (Return Material Authorization) record managing customer returns of semiconductor products for quality issues, shipping damage, or end-of-life returns. Captures RMA number, return reason code, defect description, returned product and quantity, original order reference, disposition instruction (scrap, rework, credit, replacement), credit memo reference, and failure analysis request flag. SSOT for customer return workflows and DPPM tracking inputs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order_hold` (
    `order_hold_id` BIGINT COMMENT 'Unique surrogate identifier for each hold record placed on a sales order or order line within the SAP S/4HANA SD order block management module. Primary key for the order.hold data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Credit holds in semiconductor order management are placed at the account level. order_hold carries credit_exposure_amount and credit_limit_amount — account-level metrics. A direct account_id FK enable',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Order holds are frequently placed due to quality issues with a specific assembly lot (e.g., assembly defect, failed inspection). Linking order_hold to assembly_lot enables quality teams to identify al',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Credit holds are triggered by credit profile threshold breaches (credit_limit_amount, credit_exposure_amount on order_hold mirror credit_profile fields). Linking order_hold directly to the credit_prof',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Equipment-Triggered Order Hold Management: when a fab tool fails qualification or goes down, all affected order holds must be queried for SLA breach analysis and customer communication. The order_hold',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the quality lot or wafer lot under disposition that triggered a QUALITY hold on the order. Links to the quality domain for full traceability between order holds and quality management workflows. Null for non-quality holds.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: NCR-triggered order holds: semiconductor order holds are frequently initiated by nonconformance reports on the underlying material. order_hold already has quality_disposition_status; direct FK to NCR ',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item on which this hold is placed. Null if the hold applies to the entire sales order header rather than a specific line. Enables line-level hold granularity for partial shipment scenarios.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the order hold order entity.',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Quality hold to order hold linkage: when a quality hold is placed on a lot, it triggers an order hold. This direct FK enables order management teams to trace which quality hold is blocking an order an',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Maintenance-Driven Order Hold Traceability: a specific maintenance event (unplanned downtime, requalification) triggers wafer start holds. Linking order_hold to the causative maintenance_event enables',
    `chips_act_review_required` BOOLEAN COMMENT 'Indicates whether this hold requires a CHIPS Act compliance review, particularly for orders involving customers or end-uses that may conflict with CHIPS Act guardrail provisions restricting expansion of semiconductor manufacturing capacity in countries of concern.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hold record was first created in the data platform. Represents the audit trail creation timestamp for the Silver layer record, distinct from the hold_date which captures the business event time.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'The customer credit exposure amount in the order currency at the time the credit hold was placed. Applicable only for CREDIT hold type. Represents the outstanding accounts receivable balance plus open order value that triggered the credit block in SAP S/4HANA FI-AR.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The approved credit limit for the customer at the time the credit hold was placed. Applicable only for CREDIT hold type. Sourced from SAP S/4HANA FI-AR credit management. Used to calculate credit utilization and assess hold severity.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the credit exposure and credit limit amounts (e.g., USD, EUR, JPY). Ensures consistent financial reporting across multi-currency semiconductor customer accounts.. Valid values are `^[A-Z]{3}$`',
    `customer_request_reference` STRING COMMENT 'Customer-provided reference number, purchase order amendment number, or communication reference that authorized or requested the hold. Applicable for CUSTOMER_REQUEST hold type. Enables traceability between the hold and the customers formal request documentation in Salesforce CRM.',
    `die_bank_impacted` BOOLEAN COMMENT 'Indicates whether this hold has blocked shipment from the die bank inventory associated with the sales order. True = die bank order is impacted; False = die bank order is not affected. Used for die bank inventory management and allocation planning.',
    `dppm_threshold` STRING COMMENT 'The Defective Parts Per Million (DPPM) threshold that was exceeded and triggered the quality hold. Captures the specific quality metric breach driving the hold for QUALITY hold types. Used for quality performance analysis and customer quality reporting.',
    `escalation_date` TIMESTAMP COMMENT 'Date and time when the hold was escalated to senior management or a compliance officer. Null if the hold has not been escalated. Used to measure escalation response time and management intervention frequency.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this hold has been escalated to senior management or a compliance officer due to complexity, duration, or business impact. True = escalated; False = not escalated. Triggers escalation workflow notifications in SAP S/4HANA.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or USML category of the product on the held order that triggered the export compliance review. Captures the specific classification driving the hold for EXPORT_COMPLIANCE hold types. Aligns with EAR/BIS and ITAR regulatory requirements.',
    `export_license_number` STRING COMMENT 'The export license or authorization number being verified or awaited when the hold type is EXPORT_COMPLIANCE. References the specific BIS/EAR license, ITAR authorization, or equivalent export control document required before shipment can proceed. Null for non-export-compliance holds.',
    `hold_code` STRING COMMENT 'Coded value representing the hold code of the order hold order record.',
    `hold_date` TIMESTAMP COMMENT 'Date and time when the hold was placed on the sales order or order line. Represents the principal business event timestamp for the hold lifecycle. Sourced from SAP S/4HANA SD order block creation timestamp.',
    `hold_number` STRING COMMENT 'Externally visible, human-readable business identifier for the hold record as assigned by SAP S/4HANA SD order block management. Used in customer communications, credit team workflows, and export compliance tracking.. Valid values are `^HLD-[0-9]{8,12}$`',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold record. ACTIVE = hold is in effect and order processing is blocked; RELEASED = hold has been resolved and order processing may resume; ESCALATED = hold has been escalated to senior management or compliance officer; CANCELLED = hold was voided without formal release (e.g., duplicate entry).. Valid values are `ACTIVE|RELEASED|ESCALATED|CANCELLED`',
    `hold_type` STRING COMMENT 'Classification of the hold category that determines the workflow and approval path required for release. CREDIT = credit limit exceeded or payment overdue; EXPORT_COMPLIANCE = pending export license or ITAR/EAR review; QUALITY = quality disposition pending; CUSTOMER_REQUEST = customer-initiated pause; ALLOCATION = insufficient die bank or wafer inventory; REGULATORY = RoHS/REACH/CHIPS Act compliance verification pending.. Valid values are `CREDIT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_REQUEST|ALLOCATION|REGULATORY`',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the hold is related to International Traffic in Arms Regulations (ITAR) controlled technology or products. True = ITAR-controlled item requiring State Department authorization; False = not ITAR-controlled. Drives export compliance workflow routing and documentation requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the order hold record in the order domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the order hold record in the order domain.',
    `order_value_at_risk` DECIMAL(18,2) COMMENT 'Net value of the sales order or order line blocked by this hold, expressed in the order currency. Represents the revenue at risk due to the hold and is used for business impact assessment, management reporting, and prioritization of hold resolution efforts.',
    `owner_department` STRING COMMENT 'Business department responsible for resolving the hold. Drives workflow routing and SLA assignment. CREDIT_MGMT = credit and collections team; EXPORT_COMPLIANCE = trade compliance and ITAR/EAR team; QUALITY = quality assurance and reliability team; CUSTOMER_SERVICE = order management team; SUPPLY_CHAIN = allocation and inventory team; FINANCE = accounts receivable.. Valid values are `CREDIT_MGMT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_SERVICE|SUPPLY_CHAIN|FINANCE`',
    `owner_name` STRING COMMENT 'Full name of the employee or team responsible for managing and resolving this hold at the time it was placed. Denormalized for operational reporting and audit trail purposes without requiring a join to the workforce domain.',
    `placed_timestamp` TIMESTAMP COMMENT 'The hold placed timestamp of the order hold record in the order domain.',
    `quality_disposition_status` STRING COMMENT 'Current disposition decision status for the quality lot associated with a QUALITY hold. PENDING = disposition not yet determined; USE_AS_IS = lot approved for shipment as-is; REWORK = lot requires rework before shipment; SCRAP = lot scrapped, order must be re-sourced; RETURN_TO_SUPPLIER = material returned to supplier. Null for non-quality holds.. Valid values are `PENDING|USE_AS_IS|REWORK|SCRAP|RETURN_TO_SUPPLIER`',
    `reason` STRING COMMENT 'Detailed narrative explanation of why the hold was placed on the order. Captures the specific business condition triggering the block, such as credit limit exceeded amount, export license number pending, quality lot disposition reference, or customer-requested delivery pause reason. Free-text field sourced from SAP S/4HANA SD order block reason text.',
    `reason_code` STRING COMMENT 'Standardized SAP S/4HANA SD order block reason code (e.g., 01 = Credit Block, 02 = Export Block, 03 = Quality Block) used for systematic reporting and workflow routing. Complements the free-text hold_reason field with a machine-readable classification. [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|08|09|10 — promote to reference product]',
    `release_approver_name` STRING COMMENT 'Full name of the employee who approved the release of the hold at the time of release. Denormalized for audit trail and compliance reporting without requiring a join to the workforce domain.',
    `release_date` TIMESTAMP COMMENT 'Date and time when the hold was formally released and order processing was authorized to resume. Null if the hold is still active. Used to calculate hold duration and measure order management cycle time performance.',
    `release_reason` STRING COMMENT 'Narrative explanation of the resolution that enabled the hold to be released. Captures the specific action taken, such as credit limit increase approved, export license number obtained, quality lot disposition completed, or customer confirmation received. Free-text field for audit and compliance documentation.',
    `release_timestamp` TIMESTAMP COMMENT 'The hold release timestamp of the order hold record in the order domain.',
    `released_timestamp` TIMESTAMP COMMENT 'The hold released timestamp of the order hold record in the order domain.',
    `requested_release_date` DATE COMMENT 'The date by which the hold is expected or requested to be released, as agreed with the customer or set by the hold owner. Used for proactive hold management, customer commitment tracking, and delivery schedule impact assessment.',
    `resolution_notes` STRING COMMENT 'Extended free-text notes documenting the full resolution process, including any corrective actions taken, approvals obtained, reference documents reviewed, and follow-up actions required. Supports post-hold analysis and process improvement initiatives.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the hold resolution exceeded the defined SLA target hours. True = SLA was breached; False = resolved within SLA. Used for order management performance reporting and customer escalation management.',
    `sla_target_hours` STRING COMMENT 'Target number of business hours within which the hold must be resolved per the order management SLA policy. Varies by hold type: credit holds typically 24 hours, export compliance holds 72 hours, quality holds 48 hours. Used for SLA compliance monitoring and customer commitment management.',
    `source_system_hold_reference` STRING COMMENT 'The native hold or order block identifier as recorded in the originating operational system (e.g., SAP S/4HANA SD order block number). Enables reconciliation between the Silver layer data product and the source system of record for data lineage and audit purposes.',
    `start_timestamp` TIMESTAMP COMMENT 'The hold start timestamp of the order hold record in the order domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this hold record was last modified in the data platform. Tracks the most recent update to any hold attribute, supporting change data capture, audit trail requirements, and incremental data pipeline processing.',
    `wafer_start_impacted` BOOLEAN COMMENT 'Indicates whether this hold has blocked or delayed a wafer start authorization (WSA) associated with the sales order. True = wafer start is impacted; False = wafer start is not affected. Critical for fab capacity planning and WIP management in semiconductor manufacturing.',
    CONSTRAINT pk_order_hold PRIMARY KEY(`order_hold_id`)
) COMMENT 'Record of holds placed on a sales order or order line that prevent further processing or shipment. Captures hold type (credit hold, export compliance hold, quality hold, customer request hold), hold reason, hold date, hold owner, release date, release approver, and resolution notes. Supports order management workflows where orders must be paused pending credit approval, export license verification, or quality disposition. Sourced from SAP S/4HANA SD order block management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_to_order_id` FOREIGN KEY (`to_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_primary_shipment_order_line_id` FOREIGN KEY (`primary_shipment_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_shipment_id` FOREIGN KEY (`to_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_order_id` FOREIGN KEY (`rma_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_tertiary_rma_sales_order_id` FOREIGN KEY (`tertiary_rma_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` SET TAGS ('dbx_subdomain' = 'sales_processing');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'UNALLOCATED|PARTIALLY_ALLOCATED|FULLY_ALLOCATED|OVER_ALLOCATED');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'DIRECT|DISTRIBUTOR|REPRESENTATIVE|ONLINE|OEM');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `gross_order_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `gross_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `nre_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|STANDARD|LOW');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'EDI|PORTAL|EMAIL|PHONE|SALESFORCE|MANUAL');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `wafer_start_authorization` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'sales_processing');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|priority|strategic|spot|buffer');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `date_entered` SET TAGS ('dbx_business_glossary_term' = 'Order Line Entry Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `die_bank_order` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `extended_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Extended Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Order Line Item Category');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Order Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Order Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|allocated|shipped|invoiced|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `mpw_order` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Order Line Net Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `partial_shipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `product_revision` SET TAGS ('dbx_business_glossary_term' = 'Product Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales Order Line Item Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|REEL|TRAY|TUBE');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `wafer_start_authorization` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Ship To Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `origin_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-From Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Item ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `to_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'To Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `blanket_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `call_off_number` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `committed_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `die_bank_order_number` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|blocked|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `last_reschedule_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Reschedule Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `mpw_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Schedule Line Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'PC|WF|KGD|LOT|REEL|TRAY');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `sap_schedule_line_category` SET TAGS ('dbx_business_glossary_term' = 'SAP Schedule Line Category');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `sap_schedule_line_category` SET TAGS ('dbx_value_regex' = 'CP|CN|CS|BN|BP|BS');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_revision` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_delivered|fully_delivered|cancelled|blocked');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Address Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_ship_to_address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_ship_to_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_ship_to_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `to_order_id` SET TAGS ('dbx_business_glossary_term' = 'To Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `damaged_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Damaged Goods Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Declared Customs Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `is_multi_leg` SET TAGS ('dbx_business_glossary_term' = 'Multi-Leg Shipment Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Lot Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^SHP-[0-9]{10}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `pod_confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Confirmed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `pod_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `pod_signoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signoff Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `quantity_shortage_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shortage Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `receiving_location_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Receiving Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `rma_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|economy|priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_transit|delivered|cancelled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|REEL|TRAY|TUBE');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `wrong_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Wrong Part Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `primary_shipment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `to_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'To Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `to_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'To Shipment Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `advance_ship_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `certificate_of_conformance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (CoC) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code (YYWW)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `date_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9]{2}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `die_bank_order_number` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `line_net_value` SET TAGS ('dbx_business_glossary_term' = 'Line Net Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `line_net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|picking|packed|shipped|delivered|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_value_regex' = 'tape_and_reel|tray|tube|bulk|waffle_pack|dry_pack');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `partial_shipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `rma_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `serial_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range End');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `serial_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range Start');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|LOT|REEL|TRAY|BOX');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `yield_grade` SET TAGS ('dbx_business_glossary_term' = 'Yield Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` SET TAGS ('dbx_subdomain' = 'commitment_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_position_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'unallocated|partially_allocated|fully_allocated|over_allocated');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_aging_days` SET TAGS ('dbx_business_glossary_term' = 'Backlog Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backlog Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_status` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_status` SET TAGS ('dbx_value_regex' = 'open|committed|at_risk|pushed_out|cancelled|fulfilled');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_value` SET TAGS ('dbx_business_glossary_term' = 'Backlog Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Backlog Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Backlog Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `current_commit_date` SET TAGS ('dbx_business_glossary_term' = 'Current Commit Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `design_win_flag` SET TAGS ('dbx_business_glossary_term' = 'Design-Win Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `net_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Net Selling Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `net_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Order Entry Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `original_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `original_promise_date` SET TAGS ('dbx_business_glossary_term' = 'Original Promise Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Backlog Priority Rank');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `promised_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `push_out_days` SET TAGS ('dbx_business_glossary_term' = 'Push-Out Days');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `push_out_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Push-Out Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `revenue_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Backlog Snapshot Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KU|WAFER|DIE|REEL|TRAY');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` SET TAGS ('dbx_subdomain' = 'commitment_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{10}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'finished_goods|die_bank|wafer_lot|fab_capacity|mpw_pool');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'hard|soft|tentative|capacity|die_bank|mpw');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|shipped|cancelled|expired|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `constrained_supply_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `inventory_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Batch ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_lot|packaged_goods_lot|mpw_lot');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `osat_site_code` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditionally_accepted|under_review|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quality_disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|KPC');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'sales_processing');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis (FA) ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Return From Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_order_id` SET TAGS ('dbx_business_glossary_term' = 'To Original Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `tertiary_rma_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Closed Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_value_regex' = 'scrap|rework|credit|replacement|return_to_vendor|failure_analysis');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `dppm_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `failure_analysis_requested` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis (FA) Requested Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'defect_confirmed|no_defect_found|customer_induced|shipping_damage|inconclusive');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^RMA-[0-9]{8,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Material Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Request Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Carrier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_date` SET TAGS ('dbx_business_glossary_term' = 'Rma Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|test_escape|customer_misuse');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|LOT|KIT');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` SET TAGS ('dbx_subdomain' = 'sales_processing');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Order Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `chips_act_review_required` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Compliance Review Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Limit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `customer_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Request Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `die_bank_impacted` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Impacted Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `dppm_threshold` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Escalation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `export_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_value_regex' = '^HLD-[0-9]{8,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|RELEASED|ESCALATED|CANCELLED');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'CREDIT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_REQUEST|ALLOCATION|REGULATORY');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_value_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Order Value at Risk');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_value_at_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Hold Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_department` SET TAGS ('dbx_value_regex' = 'CREDIT_MGMT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_SERVICE|SUPPLY_CHAIN|FINANCE');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Hold Owner Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `owner_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `quality_disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `quality_disposition_status` SET TAGS ('dbx_value_regex' = 'PENDING|USE_AS_IS|REWORK|SCRAP|RETURN_TO_SUPPLIER');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Release Approver Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `requested_release_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Hold Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold SLA Breach Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `source_system_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Hold Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `wafer_start_impacted` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Impacted Flag');
