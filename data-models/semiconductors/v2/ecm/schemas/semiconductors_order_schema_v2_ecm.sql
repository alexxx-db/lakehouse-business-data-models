-- Schema for Domain: order | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`order` COMMENT 'Customer orders, order fulfillment, delivery schedules, and shipment tracking. SSOT for order-to-cash lifecycle including order entry, wafer start authorizations, die bank orders, allocation, backlog management, and delivery confirmation. Manages MPW orders and production lot assignments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order` (
    `order_id` BIGINT COMMENT 'Primary key for order',
    `account_id` BIGINT COMMENT 'Reference to the customer who placed the sales order. Links to the customer master data product.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: An order may be covered by a blanket purchase agreement; adding FK from order to blanket_order captures this relationship without creating a cycle.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to sales.channel_partner. Business justification: Orders may be placed via channel partners; the FK enables partner‑attributed revenue and commission reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order Management requires a primary sales contact for each order; the Order Confirmation Report pulls contact details, making this link essential.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Orders are charged to a cost center for expense tracking and budgeting in the finance system.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export compliance reporting requires linking each order to its ECCN classification for customs documentation.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for managing this order and the customer relationship.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export License Management: each sales order must reference the approved export license, replacing the free‑text export_license_number.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer (MPW) run associated with this order. Applicable only for MPW order types where multiple customer designs share a single wafer to reduce Non-Recurring Engineering (NRE) costs.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order creation originates from a closed‑won opportunity; linking enables opportunity‑to‑order conversion reporting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the SAP sales organization responsible for this order, defining the selling entity, pricing, and legal entity context.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: Required for order processing: each order references a centrally defined payment term for financial reporting and compliance with contract terms.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Pricing Governance applies a specific price agreement to an order; the Pricing Audit Report and revenue recognition rely on this relationship.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center reporting requires each sales order to be linked to the responsible profit center.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Orders are generated from accepted quotes; the link supports quote‑to‑order tracking and pricing audit.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Program‑driven volume orders must be associated with the research program for financial tracking, budget compliance, and KPI dashboards.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Custom design order fulfillment tracks the originating research project for cost allocation and project KPI reporting.',
    `restricted_party_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_party_screening. Business justification: Trade compliance hold process records the screening result for the customer/account on the order.',
    `sales_design_win_id` BIGINT COMMENT 'Reference to the Salesforce CRM design-win opportunity that originated this sales order. Links the order to the customer design-in engagement, enabling design-win to revenue conversion tracking.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping Execution process stores the exact customer address for each order; the Shipping Manifest and compliance checks depend on this link.',
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
    `order_date` DATE COMMENT 'The calendar date on which the customer placed the sales order. Represents the principal business event date for the order-to-cash lifecycle. Corresponds to SAP VBAK.AUDAT.',
    `order_number` STRING COMMENT 'The number of the order record in the order domain.',
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
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Line‑item tracking of experimental lot IDs ties shipped quantities to specific research lots for detailed yield analysis.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: PRODUCTION_SCHEDULING: Assign primary fab tool to each order line for capacity planning and tool utilization reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the order line order entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: REQUIRED: Order fulfillment report needs to know which wafer lot supplies each order line; linking enables traceability from line to physical wafer lot.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Needed for Packaging Planning; order line specifies requested package type, linking to package_type enables yield, cost, and compliance analysis per packaging family.',
    `price_agreement_id` BIGINT COMMENT 'Unique identifier for the price agreement record within the order line order entity.',
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record within the order line order entity.',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this line item belongs. Establishes the header-to-line relationship in the order-to-cash lifecycle. Corresponds to SAP S/4HANA SD VBELN (Sales Document Number).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Manufacturing assigns a process engineer to each order line for fab planning and yield optimization.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Each order line is derived from a quote line; needed for line‑level margin and fulfillment analysis.',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.reach_svhc_declaration. Business justification: REACH SVHC Declaration is required per SKU on an order line to certify hazardous substance compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or discrete device) being ordered on this line. Links to the product master for SKU-level configuration details including package type, speed grade, and temperature range.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Primary supplier for the SKU on each order line, used in procurement planning and supplier performance reporting.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Required for Test Program Assignment per SKU during order fulfillment; ensures each order line selects the correct test program for quality validation.',
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
    `to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Fundamental header-to-line relationship. Every order line must belong to exactly one sales order. This is the most critical FK in the domain — without it, order lines are orphaned.',
    `unit_of_measure` STRING COMMENT 'Sales unit of measure for the ordered semiconductor product. EA = Each (individual packaged IC), WFR = Wafer, REEL = Tape-and-reel packaging, TRAY = JEDEC tray, TUBE = Tube packaging. Corresponds to SAP S/4HANA SD VRKME (Sales Unit).. Valid values are `EA|WFR|REEL|TRAY|TUBE`',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed net unit selling price for the semiconductor product on this order line, expressed in the transaction currency. Reflects negotiated pricing, volume discounts, and design-win pricing agreements. Corresponds to SAP S/4HANA SD NETPR (Net Price).',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'The unit price usd of the order line record in the order domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this order line record in the data platform. Supports change data capture (CDC), audit trail, and incremental processing in the Databricks Lakehouse Silver Layer.',
    `wafer_start_authorization` BOOLEAN COMMENT 'Indicates whether a wafer start authorization (WSA) has been issued to the fabrication facility (FAB) to initiate production of wafers for fulfilling this order line. True = WSA issued; False = pending or not required (e.g., fulfilled from die bank or finished goods inventory).',
    `ssot_owner_invoice_line_id` BIGINT COMMENT 'Unique identifier for the ssot owner invoice line record within the order line order entity.',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line items within a customer sales order, each representing a distinct semiconductor product SKU, quantity, unit price, requested ship date, confirmed ship date, and line-level status. Captures product configuration details such as package type, speed grade, temperature range, and special handling requirements. Supports partial shipments and line-level allocation tracking. Sourced from SAP S/4HANA SD order line items.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Primary key for status_history',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with the sales order at the time of this status event. Supports customer-level backlog and escalation analytics.',
    `allocation_record_id` BIGINT COMMENT 'Reference to the die bank or wafer allocation record when the status transitions to allocated. Captures which inventory allocation was committed to fulfill this order.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer fabrication lot associated with this order status event. Populated when the status transition is triggered by a fab event such as wafer_started or in_fab. Links order lifecycle to WIP (Work in Process) tracking.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the status history order entity.',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line record within the status history order entity.',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the OSAT (Outsourced Semiconductor Assembly and Test) partner responsible for packaging and final test of the order. Populated when the order transitions to packaging or test phases. Supports OSAT-level delivery tracking.',
    `primary_status_order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Status history records track transitions for a specific order. Must reference the parent order.',
    `shipment_id` BIGINT COMMENT 'Reference to the outbound shipment record when the status transitions to shipped. Links the order status history to the physical delivery event for shipment tracking and delivery confirmation.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the status changed by employee record within the status history order entity.',
    `status_employee_id` BIGINT COMMENT 'The user login ID or system service account that initiated the status transition. Supports accountability tracking and audit compliance. May be a human user (SAP logon ID) or an automated system process (e.g., MES_AUTO, ERP_BATCH).',
    `cancellation_type` STRING COMMENT 'Classifies the reason for order cancellation when new_status is cancelled. Values: customer_request (customer-initiated), eol (End of Life product discontinuation), capacity (fab capacity unavailable), yield_fail (unacceptable yield), export_block (export compliance hold), duplicate (duplicate order entry). Null for non-cancellation transitions.. Valid values are `customer_request|eol|capacity|yield_fail|export_block|duplicate`',
    `change_reason` STRING COMMENT 'The change reason of the status history record in the order domain.',
    `change_sequence_number` STRING COMMENT 'Sequential integer representing the ordinal position of this status transition within the complete history of the sales order line. Sequence 1 is the initial entry event. Enables ordered reconstruction of the full order lifecycle.',
    `confirmed_delivery_date` DATE COMMENT 'The internally confirmed delivery date at the time of this status transition. May differ from requested_delivery_date due to fab capacity, yield, or supply chain constraints. Tracks delivery commitment evolution across the order lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this status history record was first written to the data platform (Silver layer ingestion time). Distinct from transition_timestamp which records the business event time. Supports data lineage and audit trail completeness.',
    `die_bank_order_flag` BOOLEAN COMMENT 'Indicates whether this order line is fulfilled from die bank inventory (pre-fabricated, unpackaged dies held in inventory) rather than a new wafer start. Die bank orders have a compressed status lifecycle bypassing wafer_started and in_fab states.',
    `duration_in_prior_status_hours` DECIMAL(18,2) COMMENT 'The number of hours the order line spent in the prior_status before transitioning to new_status. Calculated at ingestion time from the difference between this transition_timestamp and the previous records transition_timestamp. Supports cycle time and SLA analytics.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this status transition was associated with a customer escalation event. When True, the order was under active escalation management at the time of the transition. Supports escalation tracking and priority queue analytics.',
    `escalation_priority` STRING COMMENT 'Priority level of the customer escalation active at the time of this status transition. P1 is highest urgency (e.g., automotive line-down risk), P4 is lowest. Populated only when escalation_flag is True.. Valid values are `P1|P2|P3|P4`',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this status transition triggered or was subject to an export control review under EAR or ITAR regulations. When True, the order required compliance screening before proceeding to the next status.',
    `hold_code` STRING COMMENT 'Standardized hold code applied to the order at the time of this status transition (e.g., CREDIT_HOLD, EXPORT_REVIEW, YIELD_HOLD, CAPACITY_HOLD). Null when no hold is active. Critical for backlog management and compliance review workflows. [ENUM-REF-CANDIDATE: promote to reference product]',
    `is_current_status` BOOLEAN COMMENT 'Indicates whether this record represents the most recent (current) status of the order line. True for the latest status transition record; False for all historical records. Enables efficient current-state queries without window functions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the status history record in the order domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the status history record in the order domain.',
    `mpw_flag` BOOLEAN COMMENT 'Indicates whether the order line is associated with a Multi-Project Wafer (MPW) run. MPW orders share wafer capacity across multiple customers and have distinct status transition rules compared to dedicated production orders.',
    `new_status` STRING COMMENT 'The order status assigned as a result of this transition event. Represents the current state after the change. [ENUM-REF-CANDIDATE: entered|confirmed|allocated|wafer_started|in_fab|shipped|invoiced|cancelled — promote to reference product]',
    `notes` STRING COMMENT 'The notes of the status history record in the order domain.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of units (dies, wafers, or packaged devices) on the order line at the time of this status transition. Captured as a snapshot to support backlog quantity analytics across status states.',
    `part_number` STRING COMMENT 'The semiconductor part number (IC, SoC, ASIC, or FPGA) associated with the order line at the time of this status event. Denormalized for audit trail completeness and historical accuracy even if the part number changes later.',
    `pcn_reference_number` STRING COMMENT 'Reference to a Product Change Notification (PCN) that triggered or is associated with this status transition. Relevant when an order status changes due to a product or process change notification issued to the customer.',
    `previous_status` STRING COMMENT 'The previous status of the status history record in the order domain.',
    `prior_status` STRING COMMENT 'The order status immediately before this transition event. Together with new_status, defines the state transition vector for lifecycle analytics and backlog management. [ENUM-REF-CANDIDATE: entered|confirmed|allocated|wafer_started|in_fab|shipped|invoiced|cancelled — promote to reference product]',
    `process_node` STRING COMMENT 'The semiconductor process technology node (e.g., 5nm, 7nm, 28nm, 65nm) used to fabricate the product on this order line. Captured as a snapshot at the time of the status event for process-level backlog analytics.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity: EA (each/packaged unit), WFR (wafer), DIE (individual die), or LOT (production lot). Aligns with SAP base unit of measure configuration for semiconductor products.. Valid values are `EA|WFR|DIE|LOT`',
    `reason_code` STRING COMMENT 'Standardized reason code explaining why the status transition occurred (e.g., CUST_REQUEST, CAPACITY_HOLD, YIELD_FAIL, ALLOC_RELEASE, SHIP_CONFIRM, CANCEL_EOL). Sourced from SAP SD reason code configuration. [ENUM-REF-CANDIDATE: promote to reference product for full enumeration]',
    `reason_description` STRING COMMENT 'Free-text narrative providing additional context for the status transition beyond the structured reason code. Captures escalation notes, customer communication references, or fab hold explanations entered by the user or system.',
    `requested_delivery_date` DATE COMMENT 'The customer-requested delivery date on the order line at the time of this status event. Snapshot preserved in the history record to track whether delivery commitments changed across status transitions.',
    `sla_breached_flag` BOOLEAN COMMENT 'Indicates whether the duration in the prior status exceeded the SLA target hours, constituting an SLA breach. True when duration_in_prior_status_hours > sla_target_hours. Supports escalation triggering and customer reporting.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'The contracted or internally defined SLA target duration (in hours) for the order to remain in the prior_status before transitioning. Used to assess whether the transition was on-time or breached the SLA threshold.',
    `source_document_number` STRING COMMENT 'The reference number of the source business document that triggered this status transition (e.g., a purchase order number, a delivery note number, an invoice number, or a MES lot release number). Provides cross-system traceability.',
    `source_system_event_reference` STRING COMMENT 'The unique event or change document identifier from the originating operational system (e.g., SAP Change Document number CDHDR.CHANGENR, Camstar transaction ID, or Salesforce case event ID). Enables end-to-end traceability from the Silver layer back to the system of record.',
    `status_change_timestamp` TIMESTAMP COMMENT 'The status change timestamp of the status history record in the order domain.',
    `to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Status history records belong to a specific sales order. Required for audit trail integrity.',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the status transition occurred. This is the principal business event time for this EVENT_LOG record, distinct from record audit timestamps.',
    `transition_type` STRING COMMENT 'Classifies the nature of the status transition: forward progression through the order lifecycle, backward reversal (e.g., re-open), cancellation, or data correction. Supports lifecycle analytics and anomaly detection.. Valid values are `forward|backward|cancellation|correction`',
    `triggered_by_system` STRING COMMENT 'The operational system of record that originated the status change event. Distinguishes between manual user-driven changes and automated system-driven transitions (e.g., MES wafer start confirmation triggering wafer_started status). [ENUM-REF-CANDIDATE: SAP_SD|MES_CAMSTAR|MES_SMARTFACTORY|SALESFORCE_CRM|AGILE_PLM|MANUAL|API_INTEGRATION — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this status history record was last modified in the data platform. In an ideal append-only event log this should rarely change; populated to support correction workflows and data quality monitoring.',
    `wafer_start_authorization_number` STRING COMMENT 'The wafer start authorization number issued by the fab planning system when the order transitions to wafer_started status. Ties the commercial order to the physical manufacturing release in the MES.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Chronological audit trail of all status transitions for a sales order throughout the order-to-cash lifecycle. Records each status change event including prior status, new status, timestamp, reason code, and the user or system that triggered the change. Supports backlog management, escalation tracking, and order lifecycle analytics. Covers statuses such as: entered, confirmed, allocated, wafer_started, in_fab, shipped, invoiced, cancelled.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` (
    `wafer_start_authorization_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a wafer start authorization record. Primary key for this entity in the Silver Layer lakehouse.',
    `account_id` BIGINT COMMENT 'Reference to the customer account on whose behalf the wafer start is authorized. Supports order-to-cash traceability and customer-level fab demand reporting. Fulfills the PARTY_REFERENCE minimum category for TRANSACTION_HEADER.',
    `fab_site_id` BIGINT COMMENT 'Reference to the fabrication facility (FAB) where the authorized wafer starts are to be executed. Determines routing of the demand signal to the correct MES instance.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the fabrication wafer lot record within the wafer start authorization order entity.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW run record that groups multiple customer designs sharing this wafer start. Populated only when is_mpw is True. Enables allocation of wafer cost and die yield across participating customers.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the wafer start authorization order entity.',
    `primary_wafer_order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Wafer start authorizations are triggered by customer orders. The WSA must reference the originating sales order for demand traceability.',
    `reticle_set_id` BIGINT COMMENT 'Identifier of the photolithography reticle (mask) set to be used for this wafer start. Critical for EUV/DUV lithography scheduling and mask inventory management. Ensures the correct GDSII-derived mask set is reserved for the lot.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, etc.) for which wafers are being authorized to start fabrication. Links to the product master in PLM.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the wafer approved by employee record within the wafer start authorization order entity.',
    `wafer_authorized_by_employee_id` BIGINT COMMENT 'Unique identifier for the wafer authorized by employee record within the wafer start authorization order entity.',
    `actual_start_date` DATE COMMENT 'Actual calendar date on which wafer fabrication commenced at the fab site, as recorded by the MES. Compared against planned_start_date to measure schedule adherence and on-time start performance.',
    `approval_level` STRING COMMENT 'Organizational approval tier required and applied for this wafer start authorization. Higher-value or hot-lot authorizations may require director or VP approval. Supports SOX internal controls and delegation-of-authority compliance.. Valid values are `auto_approved|manager|director|vp`',
    `authorization_date` DATE COMMENT 'The authorization date associated with the wafer start authorization order record.',
    `authorization_number` STRING COMMENT 'Externally-known, human-readable business identifier for the wafer start authorization, used across order management, MES, and fab planning systems. Typically formatted as WSA-{SITE}-{SEQUENCE}. This is the BUSINESS_IDENTIFIER category field for this TRANSACTION_HEADER entity.. Valid values are `^WSA-[A-Z0-9]{4,10}-[0-9]{6}$`',
    `authorization_status` STRING COMMENT 'Current lifecycle state of the wafer start authorization record, tracking progression from initial creation through fab release and completion. Fulfills the LIFECYCLE_STATUS minimum category for TRANSACTION_HEADER. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released_to_fab|in_progress|completed|cancelled|on_hold — promote to reference product]',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start authorization was formally approved and issued. This is the principal BUSINESS_EVENT_TIMESTAMP for this TRANSACTION_HEADER — the moment the authorization became binding and the demand signal was created.',
    `authorized_by` STRING COMMENT 'Name or employee identifier of the person who formally approved and issued the wafer start authorization. Required for SOX compliance and audit trail. Typically a fab planning manager or order management lead.',
    `authorized_wafer_qty` STRING COMMENT 'Number of wafers authorized to start fabrication under this authorization record. This is the primary quantitative demand signal passed from order management to the MES. Fulfills the QUANTITATIVE_RESULT minimum category for this non-monetary TRANSACTION_HEADER.',
    `authorized_wafer_quantity` STRING COMMENT 'The authorized wafer quantity of the wafer start authorization record in the order domain.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why the wafer start authorization was cancelled, when authorization_status is cancelled. Used for backlog management analysis, demand forecasting accuracy improvement, and fab capacity recovery planning. [ENUM-REF-CANDIDATE: customer_request|forecast_revision|capacity_constraint|design_change|yield_risk|export_hold|other — 7 candidates stripped; promote to reference product]',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this wafer start authorization qualifies for US CHIPS and Science Act incentives or domestic production reporting requirements. Relevant for fab sites receiving CHIPS Act funding and for regulatory compliance reporting to the US Department of Commerce.',
    `cost_center_code` STRING COMMENT 'SAP cost center to which the wafer fabrication costs for this authorization are allocated. Used for internal cost accounting, NRE cost recovery, and fab P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the wafer start authorization record was first created in the source system. Fulfills the RECORD_AUDIT_CREATED minimum category for TRANSACTION_HEADER. Used for data lineage and audit trail.',
    `cycle_time_target_days` STRING COMMENT 'Target number of calendar days from wafer start to wafer out (completion of all fab processing steps). Defined by process node and priority class. Hot lots have compressed cycle time targets. Used for delivery commit date calculation and fab performance measurement.',
    `design_revision` STRING COMMENT 'Version or revision identifier of the IC design (GDS/GDSII tapeout revision) being fabricated in this wafer start. Ensures the correct design revision is linked to the physical lot for traceability from design to silicon.',
    `die_bank_replenishment_code` BIGINT COMMENT 'Reference to the die bank replenishment plan that triggered this authorization when the wafer start is driven by inventory replenishment rather than a direct customer sales order. Nullable when authorization originates from a sales order.',
    `die_per_wafer` STRING COMMENT 'Number of individual die sites on each wafer for the specified product and process node. Determined by die size and wafer diameter. Used in conjunction with yield_target_pct to compute expected_good_die_qty.',
    `expected_good_die_qty` STRING COMMENT 'Projected number of Known Good Dies (KGD) expected from this wafer start, calculated from authorized_wafer_qty, die per wafer count, and yield_target_pct. Used for order fulfillment planning and die bank replenishment forecasting.',
    `export_control_classification` STRING COMMENT 'Export control classification applicable to the product being fabricated under this authorization, per US EAR (Export Administration Regulations) and ITAR (International Traffic in Arms Regulations). Determines whether export licenses are required before releasing wafers to certain fab sites or customers.. Valid values are `EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR|no_restriction`',
    `fab_facility_code` STRING COMMENT 'Coded value representing the fab facility code of the wafer start authorization order record.',
    `fab_work_order_number` STRING COMMENT 'SAP PP production order or work order number generated in ERP when the wafer start authorization is released to manufacturing. Bridges the order management domain to the ERP manufacturing execution module for cost collection and WIP tracking.',
    `is_mpw` BOOLEAN COMMENT 'Indicates whether this authorization is for a Multi-Project Wafer (MPW) run, where multiple customer designs share a single wafer to reduce NRE cost. MPW lots require special reticle set management and die allocation tracking.',
    `is_nre` BOOLEAN COMMENT 'Indicates whether this wafer start authorization is for a Non-Recurring Engineering (NRE) run, such as a first-time tapeout, process qualification, or engineering lot, as opposed to a production volume order. NRE lots have distinct cost accounting and yield expectations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the wafer start authorization record in the order domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the wafer start authorization record. Fulfills the RECORD_AUDIT_UPDATED minimum category for TRANSACTION_HEADER. Used for incremental data pipeline processing and change tracking.',
    `lot_number` STRING COMMENT 'MES-assigned lot identifier for the wafer batch initiated under this authorization. Populated after the authorization is released to the fab and a lot is created in the MES (Camstar or SmartFactory). Links the authorization to the physical WIP lot in the fab.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the wafer start authorization record in the order domain.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions associated with this wafer start authorization. May include hot-lot justification, customer escalation notes, or fab-specific handling instructions.',
    `nre_charge_usd` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering fee in US dollars associated with this wafer start authorization, applicable for first-time tapeouts, mask set fabrication, and engineering qualification lots. Populated when is_nre is True. Used for customer invoicing and cost recovery tracking.',
    `planned_completion_date` DATE COMMENT 'Expected date by which wafer fabrication (FEOL through BEOL) is planned to be completed and wafers released for wafer test and probing. Drives downstream packaging and delivery commit date calculations.',
    `planned_start_date` DATE COMMENT 'Scheduled calendar date on which wafer fabrication is planned to begin at the fab site. Used for fab capacity planning, WIP (Work in Process) scheduling, and order commit date calculations.',
    `priority_class` STRING COMMENT 'Fabrication priority classification assigned to this wafer start authorization. Hot lots receive highest fab priority and cycle time targets; MPW (Multi-Project Wafer) lots share wafer capacity across multiple designs; NRE pilot lots are for non-recurring engineering qualification runs.. Valid values are `hot_lot|expedite|standard|mpw|nre_pilot`',
    `process_node` STRING COMMENT 'Target semiconductor process technology node for the wafer start (e.g., 5nm, 7nm, 14nm, 28nm, 65nm). Determines the process design kit (PDK) and fab line assignment. Critical for capacity planning and yield forecasting.',
    `process_node_nm` STRING COMMENT 'The process node nm of the wafer start authorization record in the order domain.',
    `process_technology_code` STRING COMMENT 'Internal fab process technology identifier (e.g., N5P, N7FF+, HVM28LP) that maps to a specific process flow within the fabrication facility. More granular than process_node; used for exact MES routing and recipe assignment.',
    `required_ship_date` DATE COMMENT 'Customer-committed or order-driven date by which finished product must ship. Used to back-calculate the wafer start date and validate that the planned_start_date supports on-time delivery. Key input to TTM (Time to Market) and delivery performance metrics.',
    `risk_acceptance_flag` BOOLEAN COMMENT 'The risk acceptance flag of the wafer start authorization record in the order domain.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record from which this wafer start authorization record originated (e.g., SAP S/4HANA PP, Camstar MES, Applied Materials SmartFactory, Salesforce CRM design-win). Supports data lineage and Silver Layer reconciliation.. Valid values are `SAP_S4|CAMSTAR|SMARTFACTORY|SFDC|AGILE_PLM|MANUAL`',
    `source_system_reference` STRING COMMENT 'Native record identifier from the originating source system (e.g., SAP production order number, Camstar lot ID, Salesforce opportunity ID). Enables cross-system traceability and reconciliation between the lakehouse Silver Layer and operational systems.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafer substrate in millimeters (e.g., 200mm, 300mm, 450mm). Determines equipment compatibility and fab line routing at the fabrication facility.',
    `wafer_unit_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost per wafer in US dollars for the specified process node and fab site at the time of authorization. Used for cost of goods sold (COGS) estimation, margin analysis, and financial planning.',
    `wsa_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Wafer start authorizations are triggered by sales orders. This link is essential for demand-to-supply traceability and is explicitly mentioned in the WSA description.',
    `yield_target_pct` DECIMAL(18,2) COMMENT 'Expected die yield percentage (good dies per wafer as a percentage of total die sites) for this wafer start, based on process node maturity and historical SPC data. Used to calculate expected good die output and validate order fulfillment feasibility.',
    CONSTRAINT pk_wafer_start_authorization PRIMARY KEY(`wafer_start_authorization_id`)
) COMMENT 'Formal authorization record that triggers wafer fabrication starts in the FAB for a specific customer order or forecast commit. Captures authorized wafer quantity, target process node, fab site, planned start date, priority class (hot lot, standard, MPW), NRE flag, and linkage to the originating sales order or die bank replenishment plan. SSOT for wafer start demand signals passed from order management to manufacturing execution (MES). Bridges order domain to fabrication domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` (
    `mpw_order_id` BIGINT COMMENT 'Unique system-generated identifier for the MPW order record. Primary key for the mpw_order data product within the order domain.',
    `account_id` BIGINT COMMENT 'Reference to the fabless customer or design house placing this MPW order. Links to the customer master record for billing, contract terms, and design-win tracking in Salesforce CRM.',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the billing invoice generated for this MPW order in SAP S/4HANA FI. Links the order to the accounts receivable and revenue recognition records for financial close and SOX compliance.',
    `customer_contract_id` BIGINT COMMENT 'Reference to the master agreement or NRE contract governing this MPW order, including pricing, IP ownership, and delivery terms. Links to the contract master in SAP S/4HANA or Oracle Agile PLM.',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager responsible for this MPW order. Used for commission tracking, design-win attribution, and customer relationship management in Salesforce CRM.',
    `ic_design_project_id` BIGINT COMMENT 'Unique identifier for the ic design project record within the mpw order order entity.',
    `mpw_shuttle_id` BIGINT COMMENT 'Externally-known identifier for the shared wafer shuttle run in which this MPW order participates. Used to group all customer designs co-fabricated on the same wafer lot. Sourced from the fab or MPW program operator (e.g., TSMC shuttle run code, GlobalFoundries MPW run number).',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — MPW orders are a specialized order type linked to the master order record for customer and commercial terms.',
    `primary_mpw_order_sales_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: MPW order belongs to a specific sales order; adding child-to-parent FK enables order‑level reporting and removes duplicate order_number.',
    `tapeout_id` BIGINT COMMENT 'Reference to the tapeout record (final GDSII design submission) associated with this MPW order. Links the order to the design domain tapeout product for design-to-manufacturing traceability.',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the ordered dies were delivered to the customer. Used to measure on-time delivery performance, close the order-to-cash cycle, and trigger final revenue recognition.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the MPW order record was first created in the source system. Used for audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order value and NRE charges (e.g., USD, EUR, JPY). Supports multi-currency billing for international fabless customers.. Valid values are `^[A-Z]{3}$`',
    `design_name` STRING COMMENT 'Name or code of the customers IC design (chip project) being fabricated in this MPW slot. Used for design-to-order traceability, customer communication, and design-win reporting in Salesforce CRM.',
    `design_revision` STRING COMMENT 'Version or revision identifier of the customers IC design submitted for this MPW run (e.g., v1.0, Rev-B, tapeout_2). Ensures the correct GDSII version is linked to the order for traceability and re-spin management.',
    `die_count` STRING COMMENT 'The die count of the mpw order record in the order domain.',
    `die_quantity` STRING COMMENT 'The die quantity of the mpw order record in the order domain.',
    `die_quantity_delivered` STRING COMMENT 'Actual number of known-good dies (KGD) delivered to the customer from this MPW order. May differ from die_quantity_ordered due to yield loss. Used for fulfillment reconciliation and yield-adjusted billing.',
    `die_quantity_ordered` STRING COMMENT 'Number of known-good dies (KGD) ordered by the customer from this MPW shuttle run. Used for delivery planning, yield-adjusted fulfillment, and revenue recognition.',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'The die size mm2 of the mpw order record in the order domain.',
    `expected_delivery_date` DATE COMMENT 'The expected delivery date associated with the mpw order order record.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) applicable to the IC design in this MPW order. Required for export license determination and BIS/EAR compliance reporting. Example values: EAR99, 3E001, 3A001.',
    `fab_site_code` STRING COMMENT 'Identifier for the wafer fabrication facility (FAB) where this MPW shuttle run is manufactured (e.g., internal fab or OSAT partner site code). Used for capacity planning, yield tracking, and export compliance (ITAR/EAR).',
    `itar_flag` BOOLEAN COMMENT 'Indicates whether this MPW order involves ITAR-controlled technology requiring State Department licensing and restricted handling. True = ITAR-controlled; False = not ITAR-controlled. Drives access controls and shipment documentation requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the mpw order record in the order domain.',
    `lot_number` STRING COMMENT 'Fab-assigned wafer lot number for the MPW shuttle run associated with this order. Used for WIP tracking in Camstar MES, yield analysis, and defect traceability through the fabrication process.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the mpw order record in the order domain.',
    `mpw_order_number` STRING COMMENT 'The number of the mpw order record in the order domain.',
    `mpw_order_status` STRING COMMENT 'The status of the mpw order record in the order domain.',
    `mpw_program_type` STRING COMMENT 'Classification of the MPW shuttle program under which this order is placed. Determines pricing tiers, slot priority, NRE subsidies, and export control applicability (e.g., government programs may require ITAR review).. Valid values are `standard|expedited|academic|government|internal`',
    `mpw_to_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — MPW orders may be linked to a parent sales order for billing and customer relationship tracking.',
    `mpw_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — MPW orders are a specialized order type that should link back to the parent sales order for billing and customer relationship tracking.',
    `nre_amount` DECIMAL(18,2) COMMENT 'The nre amount of the mpw order record in the order domain.',
    `nre_amount_usd` DECIMAL(18,2) COMMENT 'The nre amount usd of the mpw order record in the order domain.',
    `nre_charge_usd` DECIMAL(18,2) COMMENT 'One-time Non-Recurring Engineering charge billed to the customer for mask set preparation, reticle slot allocation, and design-in support for this MPW order. Expressed in US dollars. Shared proportionally among shuttle participants based on reticle slot area.',
    `order_date` DATE COMMENT 'The calendar date on which the customer formally placed the MPW order. Represents the principal business event date for order-to-cash lifecycle tracking and backlog reporting.',
    `order_notes` STRING COMMENT 'Free-text field for capturing special instructions, customer-specific requirements, design constraints, or internal processing notes associated with this MPW order. Not used for structured data.',
    `order_status` STRING COMMENT 'Current lifecycle state of the MPW order from initial entry through fabrication completion. Drives backlog management, revenue recognition, and customer communication workflows. [ENUM-REF-CANDIDATE: draft|confirmed|tapeout_received|wafer_started|in_fab|completed|cancelled — promote to reference product]',
    `order_value_usd` DECIMAL(18,2) COMMENT 'Total monetary value of this MPW order in US dollars, comprising NRE charges plus die unit price multiplied by ordered quantity. Used for backlog reporting, revenue forecasting, and SAP FI billing.',
    `package_type` STRING COMMENT 'Semiconductor package type requested for the delivered dies (e.g., bare die/KGD, WLCSP, BGA, QFN, flip-chip). Determines OSAT engagement, packaging cost, and delivery lead time. [ENUM-REF-CANDIDATE: bare_die|WLCSP|BGA|QFN|flip_chip|CSP — promote to reference product]',
    `planned_delivery_date` DATE COMMENT 'Committed date by which the ordered dies are planned to be delivered to the customer after wafer fabrication, dicing, and optional packaging. Used for customer delivery scheduling and order-to-cash SLA tracking.',
    `po_number` STRING COMMENT 'Customer-issued purchase order number referencing this MPW order. Required for invoice matching, accounts receivable, and customer procurement compliance. Sourced from SAP S/4HANA SD order entry.',
    `priority_level` STRING COMMENT 'Business priority assigned to this MPW order for slot allocation, fab scheduling, and customer support escalation. Critical orders receive expedited processing and dedicated account management.. Valid values are `standard|high|critical`',
    `process_node` STRING COMMENT 'Semiconductor fabrication process technology node used for this MPW shuttle run (e.g., 5nm, 7nm, 28nm, 65nm). Determines the PDK, design rules, and fab site eligibility. Critical for yield modeling and NRE pricing.',
    `reserved_area_mm2` DECIMAL(18,2) COMMENT 'The reserved area mm2 of the mpw order record in the order domain.',
    `reticle_area_mm2` DECIMAL(18,2) COMMENT 'The reticle area mm2 of the mpw order record in the order domain.',
    `reticle_slot_area_mm2` DECIMAL(18,2) COMMENT 'Physical area in square millimeters allocated to this customers design within the shared MPW reticle. Determines die size, die-per-wafer count, and proportional NRE cost allocation among shuttle participants.',
    `reticle_slot_number` STRING COMMENT 'The specific slot number assigned to this customers design on the shared MPW reticle. Each slot represents a distinct die area on the shared mask set. Slot allocation drives NRE cost sharing and die quantity calculations.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the materials and processes used in this MPW order comply with the EU RoHS Directive restricting hazardous substances in electronic equipment. Required for EU market access and customer compliance declarations.',
    `sales_region_code` STRING COMMENT 'Geographic sales region code associated with this MPW order (e.g., AMER, EMEA, APAC, JAPAN). Used for regional revenue reporting, quota management, and export control jurisdiction determination.. Valid values are `^[A-Z]{2,6}$`',
    `shuttle_run_date` DATE COMMENT 'The shuttle run date associated with the mpw order order record.',
    `tapeout_date` DATE COMMENT 'The tapeout date associated with the mpw order order record.',
    `tapeout_deadline` DATE COMMENT 'Contractual deadline by which the customer must submit the final GDSII design data (tapeout) to secure their reticle slot in the MPW shuttle run. Missing this date results in slot forfeiture and potential NRE penalty.',
    `tapeout_received_date` DATE COMMENT 'Actual date on which the customers final GDSII tapeout data was received and accepted by the fab or design services team. Used to confirm slot lock and trigger wafer start authorization.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'Per-die price charged to the customer for the ordered die quantity from this MPW run. Expressed in US dollars. Used for revenue recognition, invoice generation, and margin analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the MPW order record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_quantity` STRING COMMENT 'Number of wafers allocated to this customers design within the MPW shuttle run. Determines the maximum achievable die yield and is used for fab capacity reservation and WIP tracking.',
    `wafer_start_date_actual` DATE COMMENT 'Actual date on which wafer fabrication was initiated for this MPW shuttle run. Compared against planned wafer start date to measure schedule adherence and TTM performance.',
    `wafer_start_date_planned` DATE COMMENT 'Planned date for initiating wafer fabrication (wafer start) for this MPW shuttle run at the fab site. Used for fab capacity scheduling, WIP planning, and customer delivery commitment.',
    `yield_pct` DECIMAL(18,2) COMMENT 'Percentage of good dies produced relative to the total possible dies from the allocated wafer area in this MPW run. Expressed as a percentage (0.00–100.00). Used for quality reporting, customer communication, and yield improvement programs.',
    CONSTRAINT pk_mpw_order PRIMARY KEY(`mpw_order_id`)
) COMMENT 'Multi-Project Wafer (MPW) order record managing shared wafer shuttle runs where multiple customer designs are co-fabricated on a single wafer. Captures shuttle run ID, process node, fab site, reticle slot assignments per customer, die quantity per design, NRE charges, tapeout deadline, planned wafer start date, and delivery schedule. Supports fabless customers and design houses participating in MPW programs. Distinct from standard production orders due to shared-reticle economics and slot-based allocation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` (
    `die_bank_order_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the die bank order record. Primary key for this entity in the Silver Layer lakehouse.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that placed the die bank order. Links to the customer master for account-level reporting, design-win tracking, and allocation priority management.',
    `die_bank_id` BIGINT COMMENT 'Reference to the specific die bank (customer-specific or generic KGD inventory pool) from which this order draws down inventory. Identifies the source die bank record in the inventory management system.',
    `order_id` BIGINT COMMENT 'Unique identifier for the die order record within the die bank order order entity.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the die bank order order entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Reference to the specific wafer fabrication lot from which the die bank inventory was sourced. Enables full traceability from die bank order back to the originating fab lot for quality and yield analysis.',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the OSAT (Outsourced Semiconductor Assembly and Test) vendor designated to perform the packaging and assembly conversion for this die bank order. Drives OSAT purchase order creation and work order dispatch.',
    `primary_die_order_id` BIGINT COMMENT 'FK to order.order.order_id — Die bank orders draw from pre-built inventory against a customer order for commercial and delivery tracking.',
    `test_program_id` BIGINT COMMENT 'Reference to the Automatic Test Equipment (ATE) test program used to qualify the die bank inventory as Known Good Die. Ensures the correct test coverage was applied before die bank entry.',
    `actual_ship_date` DATE COMMENT 'Date on which the packaged dies or bare die shipment was physically dispatched from the OSAT or warehouse facility. Used for on-time delivery measurement and revenue recognition triggering.',
    `allocated_die_quantity` STRING COMMENT 'Number of dies formally allocated from the die bank inventory against this order. May differ from requested quantity due to partial allocation, inventory constraints, or backlog management decisions.',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this die bank order is currently in backlog status due to insufficient die bank inventory or OSAT capacity constraints. Used for backlog management reporting and customer communication.',
    `cancellation_reason` STRING COMMENT 'Reason code for order cancellation when order_status is cancelled. Supports root cause analysis of order cancellations and customer satisfaction reporting.. Valid values are `customer_request|inventory_shortage|quality_hold|export_hold|duplicate_order|end_of_life`',
    `confirmed_delivery_date` DATE COMMENT 'Internally confirmed delivery date committed to the customer after OSAT capacity and die bank inventory checks. May differ from requested delivery date due to packaging lead time or inventory availability.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the die bank order record was first created in the source system. Used for audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order value and unit price (e.g., USD, EUR, JPY). Required for multi-currency financial reporting and SAP FI/CO currency translation.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number associated with this die bank order. Required for invoice matching, accounts receivable reconciliation, and customer audit trail.',
    `die_bank_order_number` STRING COMMENT 'The number of the die bank order record in the order domain.',
    `die_bank_order_status` STRING COMMENT 'The status of the die bank order record in the order domain.',
    `die_bank_to_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Die bank drawdown orders are typically linked to a customer sales order that triggers the packaging/assembly run.',
    `die_bank_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Die bank drawdown orders link to the customer sales order that triggered the drawdown request.',
    `die_form` STRING COMMENT 'Physical form in which the die inventory is held in the die bank and will be delivered. Determines whether OSAT packaging conversion is required before shipment.. Valid values are `bare_die|wafer|singulated_kgd|tape_and_reel`',
    `die_part_number` STRING COMMENT 'Internal part number identifying the specific die type (IC design revision, process node, and configuration) being ordered from the die bank. Aligns with Oracle Agile PLM and SAP MM material master.',
    `die_revision` STRING COMMENT 'Design revision or stepping identifier of the die (e.g., A0, B1, C2) as tracked in the PLM system. Critical for ensuring the correct silicon revision is pulled from the die bank, especially when multiple steppings coexist.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) assigned to the die product. Required for BIS/EAR export license determination and ITAR compliance screening before shipment authorization.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether a US government export license is required for this shipment based on the ECCN, destination country, and end-use screening. True triggers export compliance hold before shipment release.',
    `fulfillment_date` DATE COMMENT 'The fulfillment date associated with the die bank order order record.',
    `incoterms` STRING COMMENT 'ICC Incoterms rule governing delivery obligations, risk transfer, and cost responsibility between seller and buyer for this die bank order shipment. Captured in SAP SD delivery terms. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `kgd_grade` STRING COMMENT 'Quality grade of the Known Good Die (KGD) inventory being drawn from the die bank. Grade A represents fully tested, production-qualified die; Grade B may have minor parametric deviations; Engineering grade is for internal use only.. Valid values are `grade_a|grade_b|grade_c|engineering`',
    `kgd_required_flag` BOOLEAN COMMENT 'The kgd required flag of the die bank order record in the order domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the die bank order record in the order domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the die bank order record in the order domain.',
    `order_status` STRING COMMENT 'The order status of the die bank order record in the order domain.',
    `order_value` DECIMAL(18,2) COMMENT 'Total commercial value of the die bank order (unit price × allocated die quantity), in the transaction currency. Used for revenue backlog reporting, order-to-cash financial tracking, and SOX-compliant revenue recognition.',
    `osat_work_order_number` STRING COMMENT 'Work order or job number issued to the OSAT vendor for the packaging run triggered by this die bank order. Used for tracking assembly progress, yield, and delivery confirmation from the OSAT facility.',
    `package_type` STRING COMMENT 'Target package type for die conversion at OSAT (e.g., WLCSP, BGA, QFN, Flip-Chip, InFO, CoWoS). Specifies the packaging assembly instructions triggered by this die bank order. Null if order is for bare die or wafer delivery. [ENUM-REF-CANDIDATE: WLCSP|BGA|QFN|flip_chip|InFO|CoWoS|CSP|LGA — promote to reference product]',
    `packaging_instruction_code` BIGINT COMMENT 'Reference to the specific package conversion instruction document that defines the assembly process, substrate, wire bond or flip-chip specifications, and test requirements for the OSAT packaging run triggered by this order.',
    `priority_level` STRING COMMENT 'Business priority assigned to the die bank order for allocation and OSAT scheduling purposes. Critical and high priority orders receive preferential die bank drawdown and packaging slot assignment.. Valid values are `critical|high|normal|low`',
    `process_node` STRING COMMENT 'Semiconductor fabrication process node (technology node) of the die being ordered (e.g., 5nm, 7nm, 16nm FinFET, 28nm). Critical for die bank segregation, quality traceability, and export control classification.',
    `requested_date` DATE COMMENT 'The requested date associated with the die bank order order record.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested date by which the packaged or bare die shipment must be delivered. Used for OSAT scheduling, just-in-time packaging workflow planning, and on-time delivery KPI measurement.',
    `requested_die_quantity` STRING COMMENT 'Number of individual dies (Known Good Die units) requested by the customer or internal order for drawdown from the die bank. Drives OSAT packaging run sizing and inventory reservation.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the die and its packaging materials comply with the EU RoHS Directive restricting hazardous substances. Required for shipments to EU customers and for customer compliance declarations.',
    `ship_to_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for the shipment. Critical for export control screening (ITAR/EAR), RoHS/REACH compliance declarations, and customs documentation.. Valid values are `^[A-Z]{3}$`',
    `shipment_tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the outbound shipment of packaged dies. Enables end-to-end shipment visibility and proof-of-delivery confirmation for order fulfillment closure.',
    `shipped_die_quantity` STRING COMMENT 'Actual number of dies (post-packaging or in bare die form) confirmed as shipped to the customer. Used for fulfillment confirmation, revenue recognition, and DPPM tracking.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed commercial price per die unit for this order, as captured in the SAP SD pricing condition. Used for revenue recognition, margin analysis, and customer invoice generation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the die bank order record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_fab_site` STRING COMMENT 'Identifier of the wafer fabrication facility (FAB) where the source lot was manufactured. Relevant for quality traceability, site-specific yield analysis, and regulatory compliance (ITAR/EAR site-of-manufacture declarations).',
    CONSTRAINT pk_die_bank_order PRIMARY KEY(`die_bank_order_id`)
) COMMENT 'Order record for drawing down inventory from a customer-specific or generic die bank (KGD inventory held in wafer or singulated die form). Captures die bank source lot, requested die quantity, die type, package conversion instructions, requested delivery date, and fulfillment status. Supports just-in-time packaging and assembly workflows where die inventory is pre-built and orders trigger OSAT packaging runs. Distinct from wafer start orders as no new fab starts are required.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each delivery schedule line record in the SAP S/4HANA SD schedule line table (VBEP). Primary key for the delivery_schedule data product in the Silver layer.',
    `account_id` BIGINT COMMENT 'Reference to the sold-to customer for whom this delivery schedule is planned. Supports customer-level delivery performance analytics and blanket order management.',
    `carrier_id` BIGINT COMMENT 'Reference to the freight carrier or logistics service provider assigned to transport this shipment. Used for carrier performance tracking and freight cost allocation.',
    `order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Delivery schedules are defined per order line (SAP schedule lines). This is a mandatory parent-child relationship for delivery date management.',
    `delivery_ship_to_location_id` BIGINT COMMENT 'Reference to the customers destination ship-to location (customer site, distribution center, or consignment hub) for this delivery schedule line.',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header from which this delivery schedule line originates. Links the schedule line back to the order-to-cash transaction header.',
    `primary_delivery_order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item (order item) for which this delivery schedule line is created. A single order line may have multiple schedule lines representing different delivery windows.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Delivery schedule ownership is recorded for accountability in on‑time delivery performance reports.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or packaged die) being scheduled for delivery on this schedule line.',
    `storage_location_id` BIGINT COMMENT 'Reference to the originating ship-from location for this delivery schedule line. May be a wafer fabrication facility (FAB), OSAT (Outsourced Semiconductor Assembly and Test) site, or finished goods warehouse.',
    `to_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Delivery schedules define delivery windows per order line. delivery_schedule.order_line_id → order_line.order_line_id.',
    `assigned_storage_location_id` BIGINT COMMENT 'Unique identifier for the assigned storage location record within the delivery schedule order entity.',
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
    `packaging_type` STRING COMMENT 'The physical packaging format for the semiconductor units being delivered on this schedule line. Packaging type affects handling, storage, and customer assembly line compatibility. Common formats include tape-and-reel (for SMT), tray, tube, bulk, waffle pack, and bare wafer.. Valid values are `tape_and_reel|tray|tube|bulk|waffle_pack|wafer`',
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
    `carrier_id` BIGINT COMMENT 'Unique identifier for the carrier record within the shipment order entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shipment coordination role is tracked to ensure logistics responsibility and KPI reporting.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Each shipment must reference the export license authorizing the goods, replacing the free‑text field.',
    `finished_good_id` BIGINT COMMENT 'add column finished_good_id (BIGINT) with FK to inventory.finished_good.finished_good_id - shipments contain finished goods',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the shipment order entity.',
    `order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Shipments fulfill order lines. After merging shipment_line into shipment, the shipment entity needs direct linkage to order lines for fulfillment tracking.',
    `primary_shipment_order_id` BIGINT COMMENT 'Reference to the parent sales order that initiated this shipment. Links the shipment back to the order-to-cash lifecycle.',
    `location_id` BIGINT COMMENT 'Unique identifier for the ship from location record within the shipment order entity.',
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
    `origin_facility_code` STRING COMMENT 'Code identifying the origin facility from which the shipment departed — fab, OSAT, or distribution center. Used for multi-leg shipment traceability and supply chain analytics.',
    `package_count` STRING COMMENT 'Total number of physical packages (boxes, reels, trays, tubes) included in this shipment. Used for carrier manifest, customs declaration, and receiving verification.',
    `package_type` STRING COMMENT 'Physical packaging format used for the semiconductor products in this shipment. Determines handling requirements, ESD protection, and customer assembly line compatibility.. Valid values are `tape_and_reel|jedec_tray|tube|waffle_pack|bulk|wafer_carrier`',
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
    `shipment_number` STRING COMMENT 'Externally visible, human-readable shipment identifier used in carrier communications, customer EDI 856 ASN, and logistics documentation. Sourced from SAP S/4HANA SD outbound delivery number.. Valid values are `^SHP-[0-9]{10}$`',
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
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot from which the shipped dies or packaged ICs originated. Enables fab-level traceability from customer shipment back to wafer fabrication run in the MES.',
    `mpw_shuttle_id` BIGINT COMMENT 'Identifier for the Multi-Project Wafer run from which this shipment lines product originated. Enables traceability for MPW orders where multiple customer designs share a single wafer fabrication run.',
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
    `lot_number` STRING COMMENT 'Manufacturing lot number assigned during wafer fabrication or assembly. Critical for traceability, quality dispute resolution, and RMA processing. Sourced from Camstar MES lot management.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the shipment line record in the order domain.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC moisture sensitivity level classification for the shipped packaged IC. Determines floor life, storage, and baking requirements at the customers SMT assembly facility.. Valid values are `MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Original quantity requested on the customer order line for this product. Enables calculation of fulfillment rate and identification of short-ships or over-ships.',
    `package_type` STRING COMMENT 'Semiconductor package type for the shipped product (e.g., BGA, QFN, WLCSP, InFO, CoWoS, TSOP, DIP, SOP). Determines handling, inspection, and customer board assembly requirements. [ENUM-REF-CANDIDATE: BGA|QFN|WLCSP|InFO|CoWoS|TSOP|DIP|SOP|LGA|CSP — promote to reference product]',
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
    `order_line_id` BIGINT COMMENT 'Unique identifier for the backlog order line record within the backlog position order entity.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the backlog position order entity.',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this backlog position belongs. Links the backlog snapshot to the originating customer order.',
    `primary_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Backlog positions track unshipped quantities for specific order lines. Without this FK, backlog cannot be reconciled to orders.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or discrete device) associated with this backlog position. Enables product-level backlog analysis and demand planning.',
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
    `wafer_lot_number` STRING COMMENT 'The fabrication lot number of the wafer batch assigned to fulfill this backlog position. Links the backlog to the specific Work in Process (WIP) lot in the fab for production tracking and yield impact analysis.',
    CONSTRAINT pk_backlog_position PRIMARY KEY(`backlog_position_id`)
) COMMENT 'Point-in-time snapshot of open order backlog for a specific order line, capturing unshipped committed quantity, backlog value, original promise date, current commit date, and backlog aging in days. Used for backlog management, revenue forecasting, customer escalation prioritization, and quarterly book-to-bill ratio reporting. Tracks push-outs, pull-ins, and cancellations affecting committed backlog. Critical for semiconductor revenue recognition, quarterly close processes, and investor guidance on backlog coverage.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` (
    `allocation_record_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a single inventory, capacity, or lot allocation record within the order fulfillment process.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom inventory or capacity is being allocated. Used for constrained supply allocation prioritization across competing customers.',
    `order_id` BIGINT COMMENT 'Unique identifier for the allocation order record within the allocation record order entity.',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the allocation order line record within the allocation record order entity.',
    `allocation_sales_order_id` BIGINT COMMENT 'Reference to the parent sales order header under which this allocation record is created. Supports backlog management and order-to-cash reporting.',
    `die_bank_id` BIGINT COMMENT 'Unique identifier for the die bank record within the allocation record order entity.',
    `employee_id` BIGINT COMMENT 'System user identifier of the supply chain planner or system process that created this allocation record. Supports audit trail and accountability for allocation decisions.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the inventory wafer lot record within the allocation record order entity.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer run associated with this allocation, applicable when the lot type is mpw_lot. Supports MPW order and production lot assignment management.',
    `primary_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Allocations reserve inventory against specific order lines. This is the core link for constrained supply management.',
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
    `lot_number` STRING COMMENT 'Manufacturing lot number of the wafer lot, die lot, or packaged goods lot being allocated. Critical for automotive (IATF 16949) and aerospace lot-level traceability from order through shipment. Sourced from Camstar MES lot tracking.',
    `lot_type` STRING COMMENT 'Classifies the type of manufacturing lot being allocated: wafer_lot (silicon wafer lot at fab), die_lot (singulated die inventory), packaged_goods_lot (finished packaged semiconductor units), mpw_lot (Multi-Project Wafer shared lot).. Valid values are `wafer_lot|die_lot|packaged_goods_lot|mpw_lot`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the allocation record record in the order domain.',
    `osat_site_code` STRING COMMENT 'Code identifying the Outsourced Semiconductor Assembly and Test (OSAT) facility responsible for packaging and testing the allocated lot. Relevant for packaged goods lot allocations.',
    `priority` STRING COMMENT 'The priority of the allocation record record in the order domain.',
    `priority_rank` STRING COMMENT 'Numeric priority rank assigned to this allocation record for constrained supply allocation decisions. Lower values indicate higher priority. Used during supply shortages to sequence allocation across competing customer orders.',
    `process_node` STRING COMMENT 'Semiconductor manufacturing process node (e.g., 5nm, 7nm, 28nm) of the allocated lot. Used for product traceability, yield analysis, and supply planning by technology generation.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Primary key for amendment',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with the parent sales order. Included on the amendment for direct customer-level reporting, dispute resolution, and revenue recognition without requiring a join to the order header.',
    `order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Amendments modify existing orders. Each amendment must reference the order it modifies for audit trail integrity.',
    `amendment_amended_sales_order_id` BIGINT COMMENT 'Reference to the parent sales order that this amendment modifies. Links the amendment to the original order header in the order-to-cash lifecycle.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer (MPW) run affected by this amendment, if applicable. Populated when the amended order is associated with an MPW shuttle run, where quantity or cancellation changes affect shared wafer slot allocations.',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line record within the amendment order entity.',
    `parent_order_id` BIGINT COMMENT 'Unique identifier for the parent order record within the amendment order entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the requested by employee record within the amendment order entity.',
    `allocation_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment triggers a reallocation of constrained wafer or die inventory across customer orders. True when the quantity or delivery date change affects the allocation pool managed in SAP SD or the MES.',
    `amended_field_name` STRING COMMENT 'The name of the specific order field that was changed (e.g., requested_delivery_date, quantity, unit_price, product_code). Together with original_value and revised_value, provides a complete field-level audit trail for each amendment.',
    `amendment_date` DATE COMMENT 'The business date on which the amendment was formally raised and submitted by the requester. Used as the effective date for revenue recognition adjustments and backlog recalculation.',
    `amendment_number` STRING COMMENT 'Externally visible, human-readable change order reference number assigned by SAP SD at the time the amendment is raised. Used in customer-facing communications and dispute resolution. Format: AMD-{YYYY}-{SEQUENCE}.. Valid values are `^AMD-[0-9]{4}-[0-9]{6}$`',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment record within the change order management workflow. Transitions from draft through approval to applied or rejected. Drives revenue recognition timing and backlog reporting.. Valid values are `draft|pending_approval|approved|rejected|applied|withdrawn`',
    `amendment_type` STRING COMMENT 'Classifies the nature of the change applied to the sales order. Drives downstream workflow routing, revenue recognition treatment, and audit reporting. Allowed values: quantity_change, date_push_out, date_pull_in, cancellation, price_revision, product_substitution.. Valid values are `quantity_change|date_push_out|date_pull_in|cancellation|price_revision|product_substitution`',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the approved amendment was actually applied to the sales order in the system of record (SAP SD). Marks the point at which the order reflects the revised terms for fulfillment and revenue recognition.',
    `approval_level` STRING COMMENT 'The authorization tier required and applied for this amendment based on the revenue impact and amendment type. Higher-value or cancellation amendments require escalated approval levels per the delegation of authority matrix.. Valid values are `L1_sales_rep|L2_sales_manager|L3_vp_sales|L4_finance|L5_executive`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the amendment was approved or rejected by the authorized approver. Distinct from amendment_date (submission) and applied_timestamp (system application). Critical for SLA measurement and audit compliance.',
    `approved_by` STRING COMMENT 'Name or user identifier of the authorized approver who accepted or rejected the amendment. Required for SOX-compliant change order audit trails and revenue recognition documentation.',
    `approved_date` DATE COMMENT 'The approved date associated with the amendment order record.',
    `business_justification` STRING COMMENT 'Free-text explanation provided by the requester describing the business reason for the amendment (e.g., customer demand change, fab capacity constraint, end-market shift, design-win revision). Required for SOX audit trail and customer dispute resolution.',
    `cancellation_reason_code` STRING COMMENT 'Standardized reason code for order cancellations, populated only when amendment_type is cancellation. Examples include: CUST_REQUEST, CAPACITY_CONSTRAINT, EOL_PRODUCT, DESIGN_WIN_LOST, DUPLICATE_ORDER. [ENUM-REF-CANDIDATE: CUST_REQUEST|CAPACITY_CONSTRAINT|EOL_PRODUCT|DESIGN_WIN_LOST|DUPLICATE_ORDER|PRICE_DISPUTE|EXPORT_HOLD — promote to reference product]',
    `chips_act_order_flag` BOOLEAN COMMENT 'Indicates whether the parent sales order is associated with a CHIPS Act-eligible program. Amendments to CHIPS Act orders may require additional compliance review and reporting under US CHIPS and Science Act requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the amendment record was first created in the data platform. Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to price fields on this amendment (e.g., USD, EUR, JPY, TWD). Required for multi-currency revenue recognition and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `customer_requested_flag` BOOLEAN COMMENT 'Indicates whether the amendment was initiated by the customer (True) or internally by the semiconductor company (False). Distinguishes customer-driven changes from internal supply chain or capacity-driven adjustments for analytics and dispute resolution.',
    `delivery_date_original` DATE COMMENT 'The confirmed delivery date on the sales order line before the amendment. Populated for date_push_out and date_pull_in amendment types. Used to measure schedule change impact and customer on-time delivery performance.',
    `delivery_date_revised` DATE COMMENT 'The new confirmed delivery date after the amendment is applied. Populated for date_push_out and date_pull_in amendment types. Drives updated production scheduling, wafer start authorization, and customer delivery commitments.',
    `dispute_reference_number` STRING COMMENT 'Reference number of any associated customer dispute or claim raised in Salesforce CRM that prompted or resulted from this amendment. Links the amendment to the customer dispute resolution workflow for escalation tracking.',
    `export_control_review_required` BOOLEAN COMMENT 'Indicates whether the amendment (particularly product substitution or destination change) requires re-review under export control regulations (EAR/ITAR). Ensures compliance with BIS/EAR and ITAR before the revised order is fulfilled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the amendment record in the order domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the amendment record in the order domain.',
    `new_value` DECIMAL(18,2) COMMENT 'The new value of the amendment record in the order domain.',
    `old_value` DECIMAL(18,2) COMMENT 'The old value of the amendment record in the order domain.',
    `original_value` DECIMAL(18,2) COMMENT 'The value of the amended field before the change was applied. Stored as STRING to accommodate heterogeneous amendment types (quantity, date, price, product code). Paired with revised_value and amended_field_name to form a complete before/after audit record.',
    `pcn_reference` STRING COMMENT 'Reference number of the Product Change Notification (PCN) that triggered this amendment, if applicable. Links the order amendment to a formal PCN issued under JEDEC JESD46 for product or process changes affecting customer orders.',
    `quantity_original` DECIMAL(18,2) COMMENT 'The ordered quantity on the sales order line before the amendment was applied. Populated specifically for quantity_change amendment types. Enables direct numeric comparison and delta calculation for backlog management and wafer start authorization adjustments.',
    `quantity_revised` DECIMAL(18,2) COMMENT 'The ordered quantity on the sales order line after the amendment is applied. Populated for quantity_change amendment types. Used for backlog recalculation, wafer start authorization updates, and allocation management.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity fields on this amendment. Common semiconductor units include EA (each), KU (thousands of units), WAFER, DIE, and REEL for tape-and-reel packaged devices.. Valid values are `EA|KU|WAFER|DIE|REEL`',
    `reason` STRING COMMENT 'The reason of the amendment record in the order domain.',
    `requested_by` STRING COMMENT 'Name or user identifier of the individual (internal sales representative, customer service agent, or customer contact) who initiated the amendment request. Supports audit trail and dispute resolution.',
    `requested_date` DATE COMMENT 'The requested date associated with the amendment order record.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The net change in order value resulting from this amendment, expressed in the order currency. Positive for upward revisions (pull-in, price increase), negative for reductions (push-out, cancellation, price decrease). Used directly in revenue recognition and backlog reporting.',
    `revenue_recognition_period` STRING COMMENT 'The accounting period (YYYY-MM) in which the revenue impact of this amendment is recognized under ASC 606 / IFRS 15. Assigned by the finance team during amendment approval and used for period-close revenue reporting.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `revised_value` DECIMAL(18,2) COMMENT 'The new value of the amended field after the change is applied. Stored as STRING to accommodate heterogeneous amendment types. Paired with original_value and amended_field_name to form a complete before/after audit record.',
    `so_line_item_number` STRING COMMENT 'The specific line item number within the parent sales order that this amendment affects. An amendment may target a single line (e.g., quantity change on one SKU) or the entire order header (e.g., cancellation). Null if the amendment applies to the full order.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this amendment record originated. Supports data lineage, reconciliation, and Silver layer provenance tracking across SAP SD, Oracle Agile PLM, Salesforce CRM, and manual entry channels.. Valid values are `SAP_SD|AGILE_PLM|SFDC|MANUAL`',
    `substitute_product_code` STRING COMMENT 'The product part number or material code of the replacement product, populated only when amendment_type is product_substitution. Captures the new IC, SoC, or packaged device being substituted in place of the original ordered product.',
    `to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Amendments modify a specific sales order. Required for change management audit trail.',
    `unit_price_original` DECIMAL(18,2) COMMENT 'The unit selling price on the sales order line before the price revision amendment. Populated for price_revision amendment types. Supports revenue recognition delta calculation and customer dispute resolution.',
    `unit_price_revised` DECIMAL(18,2) COMMENT 'The new unit selling price after the price revision amendment is applied. Populated for price_revision amendment types. Used for revenue recognition recalculation and updated order value reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this amendment record in the data platform. Supports incremental load detection and change data capture in the Databricks Silver layer.',
    `version_number` STRING COMMENT 'Sequential version counter for amendments on the same sales order line, starting at 1. Enables tracking of iterative changes (e.g., multiple date push-outs on the same line) and supports optimistic concurrency control in the Silver layer.',
    `wafer_start_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires a corresponding update to the Wafer Start Authorization (WSA) in the fab. True when quantity changes or cancellations affect in-flight WIP lots in the fabrication facility.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Record of all changes made to a sales order after initial entry, capturing the amendment type (quantity change, date push-out, pull-in, cancellation, price revision, product substitution), original value, revised value, amendment date, requester, approver, and business justification. Supports change order management workflows and provides a complete audit trail of order modifications for revenue recognition and customer dispute resolution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`nre_order` (
    `nre_order_id` BIGINT COMMENT 'Unique identifier for the NRE order record. Primary key for the NRE order entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer who contracted this NRE engagement. The party responsible for NRE payment and acceptance.',
    `photomask_id` BIGINT COMMENT 'Identifier for the photomask set fabricated as part of this NRE engagement. Links NRE to specific mask tooling costs.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project that this NRE order funds. Links NRE charges to specific design engineering work.',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — NRE orders are linked to associated production orders for the same customer engagement.',
    `org_unit_id` BIGINT COMMENT 'Reference to the internal engineering team assigned to execute this NRE project. Used for resource allocation and capacity planning.',
    `employee_id` BIGINT COMMENT 'Reference to the project manager responsible for NRE execution and customer communication. Primary point of contact for project status.',
    `primary_nre_sales_order_id` BIGINT COMMENT 'Reference to the associated production sales order that this NRE order supports. Links NRE charges to the recurring product order.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_nre_agreement. Business justification: NRE orders are executed under an NRE agreement; linking is required for compliance and revenue recognition.',
    `acceptance_criteria` STRING COMMENT 'Contractually defined criteria that must be met for customer acceptance of NRE deliverables. Used for milestone signoff and dispute resolution.',
    `actual_completion_date` DATE COMMENT 'Actual date when all NRE deliverables were completed and accepted. Triggers final milestone billing and project closure.',
    `actual_start_date` DATE COMMENT 'Actual date when engineering work began. Used to track schedule adherence and project performance.',
    `cancellation_clause` STRING COMMENT 'Contractual terms governing NRE order cancellation, including notice periods, cancellation fees, and work-in-progress settlement.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this NRE project qualifies for CHIPS Act funding or incentives. Used for government reporting and subsidy tracking.',
    `completed_milestone_count` STRING COMMENT 'Number of milestones that have been completed and accepted by the customer. Used to calculate project completion percentage.',
    `confidentiality_level` STRING COMMENT 'Classification of confidentiality requirements for NRE deliverables and design information. Determines access controls and disclosure restrictions.. Valid values are `standard|proprietary|highly_confidential`',
    `contract_date` DATE COMMENT 'Date when the NRE contract was signed and became legally binding. Establishes the start of contractual obligations.',
    `contract_type` STRING COMMENT 'Commercial structure of the NRE contract. Determines billing method and risk allocation between customer and supplier.. Valid values are `fixed_price|time_and_materials|milestone_based|cost_plus`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NRE order record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for NRE amounts. Defines the monetary unit for all financial values in this order.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customers purchase order number authorizing the NRE engagement. Used for invoice reconciliation and payment tracking.',
    `deliverable_list` STRING COMMENT 'Comprehensive list of engineering deliverables committed in the NRE contract. Includes design files, documentation, test reports, and IP cores.',
    `design_complexity_score` DECIMAL(18,2) COMMENT 'Quantitative measure of IC design complexity based on gate count, IP blocks, and verification requirements. Used for NRE pricing and resource estimation.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations classification for NRE deliverables. Determines export licensing requirements and destination restrictions.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced to date across all completed milestones. Used to track billing progress and outstanding receivables.',
    `ip_core_list` STRING COMMENT 'List of third-party or internal IP cores integrated as part of this NRE engagement. Tracks IP licensing and royalty obligations.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this NRE engagement involves ITAR-controlled defense articles or technical data. Triggers strict export and access controls.',
    `kickoff_date` DATE COMMENT 'The kickoff date associated with the nre order order record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this NRE order record. Used for change tracking and data synchronization.',
    `milestone_count` STRING COMMENT 'Total number of engineering milestones defined in this NRE contract. Used for progress tracking and billing schedule management.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the nre order record in the order domain.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the NRE engagement. Used for knowledge capture and handoff.',
    `nre_order_number` STRING COMMENT 'Human-readable business identifier for the NRE order. Externally communicated reference number used in contracts and invoices.. Valid values are `^NRE-[0-9]{8}$`',
    `nre_order_status` STRING COMMENT 'The status of the nre order record in the order domain.',
    `nre_status` STRING COMMENT 'Current lifecycle status of the NRE order. Tracks progression from contract approval through engineering completion and invoicing. [ENUM-REF-CANDIDATE: draft|approved|in_progress|milestone_review|completed|invoiced|cancelled — 7 candidates stripped; promote to reference product]',
    `nre_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — NRE orders are associated with a customer engagement that typically has a parent sales order or contract reference.',
    `nre_type` STRING COMMENT 'Classification of the NRE engagement by engineering deliverable category. Determines the type of one-time engineering work being performed.. Valid values are `mask_nre|design_nre|qualification_nre|tapeout_nre|ip_integration_nre|dft_nre`',
    `order_date` DATE COMMENT 'The order date associated with the nre order order record.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received from customer to date. Used to track payment status and outstanding balances.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining milestone payment schedule and due dates. References master payment terms configuration.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit used for this NRE design work. Ensures design-manufacturing compatibility.',
    `penalty_clause` STRING COMMENT 'Contractual penalties for late delivery or non-conformance to acceptance criteria. Defines financial consequences of schedule or quality failures.',
    `planned_completion_date` DATE COMMENT 'Contractually committed date for completion of all NRE deliverables. Used for customer expectation management and penalty clauses.',
    `planned_start_date` DATE COMMENT 'Scheduled date for engineering work to commence. Used for resource planning and project scheduling.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used to recognize NRE revenue. Determines timing of revenue booking based on contract structure and completion criteria.. Valid values are `milestone|percentage_of_completion|completed_contract`',
    `technology_node` STRING COMMENT 'Semiconductor process technology node for this NRE engagement (e.g., 7nm, 5nm, 3nm). Determines design rules and manufacturing process.',
    `total_nre_amount` DECIMAL(18,2) COMMENT 'Total contracted value of the NRE engagement across all milestones. Represents the full one-time engineering charge.',
    `total_nre_amount_usd` DECIMAL(18,2) COMMENT 'The total nre amount usd of the nre order record in the order domain.',
    `total_nre_value` DECIMAL(18,2) COMMENT 'The total nre value of the nre order record in the order domain.',
    CONSTRAINT pk_nre_order PRIMARY KEY(`nre_order_id`)
) COMMENT 'Non-Recurring Engineering (NRE) order record capturing one-time engineering charges associated with custom IC design, mask set fabrication, or process qualification for a specific customer. Captures NRE type (mask NRE, design NRE, qualification NRE), total NRE amount, deliverable list, acceptance criteria, and linkage to the associated production order or design project. Includes milestone records defining specific engineering deliverables and payment triggers: milestone name, description, planned completion date, actual completion date, milestone amount, billing status, customer acceptance date, and acceptance signoff reference. Supports milestone-based revenue recognition for NRE contracts and tracks engineering project progress against contractual commitments. Distinct from recurring product orders due to milestone-based billing and engineering deliverable tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` (
    `order_nre_milestone_id` BIGINT COMMENT 'Unique identifier for the NRE milestone record. Primary key for the order_nre_milestone product.',
    `employee_id` BIGINT COMMENT 'Reference to the project manager or technical lead responsible for coordinating and delivering this milestone.',
    `nre_order_id` BIGINT COMMENT 'Unique identifier for the nre order record within the order nre milestone order entity.',
    `order_id` BIGINT COMMENT 'Reference to the parent NRE order under which this milestone is defined. Links milestone to the contractual order.',
    `org_unit_id` BIGINT COMMENT 'Reference to the engineering team or organizational unit responsible for delivering this milestone.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Unique identifier for the sales nre agreement record within the order nre milestone order entity.',
    `authoritative_finance_nre_milestone_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `acceptance_signoff_by` STRING COMMENT 'Name or identifier of the customer representative who provided formal acceptance signoff for the milestone.',
    `acceptance_signoff_reference` STRING COMMENT 'Reference to the formal customer acceptance document, email, or system record confirming milestone approval.',
    `actual_completion_date` DATE COMMENT 'Actual date when the milestone deliverable was completed and submitted for customer review.',
    `actual_date` DATE COMMENT 'The actual date associated with the order nre milestone order record.',
    `actual_start_date` DATE COMMENT 'Actual date when engineering work on this milestone commenced.',
    `billing_status` STRING COMMENT 'Current billing and payment status of the milestone, tracking progression from acceptance through payment receipt.. Valid values are `not_billable|ready_to_bill|billed|paid|disputed`',
    `billing_trigger_flag` BOOLEAN COMMENT 'The billing trigger flag of the order nre milestone record in the order domain.',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this milestone has been modified from the original contract terms through a formal change order or amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the milestone amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_acceptance_date` DATE COMMENT 'Date when the customer formally accepted the milestone deliverable, triggering payment and revenue recognition.',
    `deliverable_location` STRING COMMENT 'File path, document management system reference, or repository location where the milestone deliverable artifacts are stored.',
    `dependency_milestones` STRING COMMENT 'Comma-separated list of prerequisite milestone numbers or identifiers that must be completed before this milestone can begin.',
    `effort_hours_actual` DECIMAL(18,2) COMMENT 'Actual engineering effort in hours expended to complete this milestone, tracked for cost accounting and future estimation.',
    `effort_hours_planned` DECIMAL(18,2) COMMENT 'Estimated engineering effort in hours required to complete this milestone, used for resource planning and cost estimation.',
    `finance_nre_milestone_id` BIGINT COMMENT 'SSOT reference to authoritative owner finance.finance_nre_milestone for concept nre_milestone',
    `invoice_date` DATE COMMENT 'Date when the invoice for this milestone was issued to the customer.',
    `invoice_number` STRING COMMENT 'Reference to the invoice document generated for this milestone billing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the order nre milestone record in the order domain.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Contractual payment amount associated with this milestone in the order currency. Represents the revenue to be recognized upon milestone acceptance.',
    `milestone_amount_usd` DECIMAL(18,2) COMMENT 'The milestone amount usd of the order nre milestone record in the order domain.',
    `milestone_description` STRING COMMENT 'Detailed description of the engineering deliverable, acceptance criteria, and scope of work associated with this milestone.',
    `milestone_name` STRING COMMENT 'Short descriptive name of the milestone deliverable (e.g., RTL Design Completion, Tapeout Readiness, First Silicon Validation).',
    `milestone_number` STRING COMMENT 'Business identifier for the milestone within the NRE contract. Typically sequential or hierarchical (e.g., M1, M2.1, MS-001).',
    `milestone_sequence` STRING COMMENT 'The milestone sequence of the order nre milestone record in the order domain.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating progress and acceptance state. [ENUM-REF-CANDIDATE: not_started|in_progress|completed|accepted|rejected|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `milestone_type` STRING COMMENT 'Classification of the milestone by engineering phase or deliverable category.. Valid values are `design|verification|tapeout|silicon_validation|documentation|customer_acceptance`',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `modification_reference` STRING COMMENT 'Reference to the contract change order or amendment document that modified this milestone terms, scope, or payment.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, clarifications, or context regarding milestone execution, issues, or customer interactions.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this milestone is contractually due from the customer.',
    `payment_received_date` DATE COMMENT 'Actual date when payment for this milestone was received from the customer.',
    `planned_completion_date` DATE COMMENT 'Contractually committed or planned date by which the milestone deliverable is expected to be completed.',
    `planned_date` DATE COMMENT 'The planned date associated with the order nre milestone order record.',
    `planned_start_date` DATE COMMENT 'Scheduled date when engineering work on this milestone is planned to begin.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the customer if the milestone deliverable was rejected, including specific deficiencies or gaps.',
    `revenue_recognition_amount` DECIMAL(18,2) COMMENT 'Actual amount of revenue recognized for this milestone, which may differ from milestone_amount due to contract modifications or adjustments.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue for this milestone was recognized in the financial system, typically aligned with customer acceptance date per ASC 606.',
    `rework_required_flag` BOOLEAN COMMENT 'Indicates whether engineering rework is required to address customer feedback or rejection reasons.',
    `risk_level` STRING COMMENT 'Assessment of technical or schedule risk associated with achieving this milestone on time and meeting acceptance criteria.. Valid values are `low|medium|high|critical`',
    `sequence_number` STRING COMMENT 'Ordinal position of this milestone within the NRE order, defining the execution sequence and dependencies.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the nre_milestone concept (finance.finance_nre_milestone)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified, supporting audit trail and change tracking.',
    CONSTRAINT pk_order_nre_milestone PRIMARY KEY(`order_nre_milestone_id`)
) COMMENT 'Individual milestone record within an NRE order, defining specific engineering deliverables and associated payment triggers. Captures milestone name, description, planned completion date, actual completion date, milestone amount, billing status, customer acceptance date, and acceptance signoff reference. Supports milestone-based revenue recognition for NRE contracts and tracks engineering project progress against contractual commitments.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Primary key for rma',
    `account_id` BIGINT COMMENT 'Reference to the customer initiating the return. Links RMA to the customer master record.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the manufacturing lot from which the returned units originated. Critical for traceability and yield impact analysis.',
    `failure_analysis_report_id` BIGINT COMMENT 'Reference to the failure analysis record if FA was performed. Links RMA to detailed root cause investigation and corrective action.',
    `finished_good_id` BIGINT COMMENT 'add column finished_good_id (BIGINT) with FK to inventory.finished_good.finished_good_id - RMAs reference returned finished goods',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the rma order entity.',
    `employee_id` BIGINT COMMENT 'Reference to the quality inspector or technician who performed the incoming inspection of the returned material.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the rma order entity.',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line record within the rma order entity.',
    `primary_rma_order_id` BIGINT COMMENT 'FK to order.order.order_id — RMAs reference the original sales order for the returned product. rma.sales_order_id → order.sales_order_id.',
    `sku_id` BIGINT COMMENT 'Reference to the product master record for the returned semiconductor product (IC, SoC, ASIC, FPGA, or packaged die).',
    `tertiary_rma_sales_order_id` BIGINT COMMENT 'Reference to the original sales order from which the returned product was shipped. Links RMA to the originating order transaction.',
    `approval_date` DATE COMMENT 'Date when the RMA was approved by the quality or customer service team. Nullable if RMA is rejected or still pending.',
    `approved_date` DATE COMMENT 'The approved date associated with the rma order record.',
    `closed_date` DATE COMMENT 'Date when the RMA was fully closed after disposition action completed (credit issued, replacement shipped, or material scrapped).',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action (CAPA) is required based on the RMA findings. True triggers CAPA workflow per ISO 9001 and IATF 16949.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA record was first created in the system. Audit trail for record lifecycle tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the credit issued to the customer in the transaction currency. Nullable if no credit is issued.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued to the customer for the returned material. Nullable if no credit is issued (e.g., customer error returns).. Valid values are `^CM-[0-9]{8,12}$`',
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
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is REACH compliant. Affects material handling, disposal, and rework procedures.',
    `reason_code` STRING COMMENT 'Coded value representing the reason code of the rma order record.',
    `received_date` DATE COMMENT 'Date when the returned material was physically received at the receiving facility or OSAT partner. Nullable until material arrives.',
    `receiving_facility_code` STRING COMMENT 'Code identifying the facility (FAB, OSAT, warehouse, or service center) where the returned material is received and inspected.',
    `request_date` DATE COMMENT 'Date when the customer initiated the RMA request. Principal business event timestamp for the RMA lifecycle.',
    `return_reason_code` STRING COMMENT 'Standardized code categorizing the reason for the return. Used for root cause analysis, DPPM tracking, and warranty claim classification.. Valid values are `quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory`',
    `return_shipping_carrier` STRING COMMENT 'Name of the logistics carrier used to ship the returned material (e.g., FedEx, UPS, DHL, regional freight forwarder).',
    `return_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment. Used for shipment visibility and proof of receipt.',
    `returned_quantity` STRING COMMENT 'Number of units (dies, packaged chips, or wafers) returned under this RMA. Used for DPPM calculation and inventory adjustment.',
    `rma_date` DATE COMMENT 'The date associated with the rma order record.',
    `rma_number` STRING COMMENT 'Externally-visible unique business identifier for the RMA. Used in customer communications, shipping labels, and cross-system tracking.. Valid values are `^RMA-[0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA. Tracks progression from customer request through receipt, inspection, and final disposition. [ENUM-REF-CANDIDATE: requested|approved|rejected|in_transit|received|inspected|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is RoHS compliant. Affects disposition options (scrap vs. rework) and environmental handling requirements.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause identified during inspection or FA. Used for DPPM trending and corrective action prioritization.. Valid values are `design|process|material|handling|test_escape|customer_misuse`',
    `to_original_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — RMAs reference the original sales order for the returned product. Required for credit processing and quality traceability.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity. EA=each (individual die/chip), WFR=wafer, LOT=production lot, KIT=assembly kit.. Valid values are `EA|WFR|LOT|KIT`',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this RMA is being processed as a warranty claim. True if the return is within warranty period and defect is covered.',
    `warranty_expiration_date` DATE COMMENT 'Date when the warranty coverage for the returned product expires. Used to validate warranty claim eligibility.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'RMA (Return Material Authorization) record managing customer returns of semiconductor products for quality issues, shipping damage, or end-of-life returns. Captures RMA number, return reason code, defect description, returned product and quantity, original order reference, disposition instruction (scrap, rework, credit, replacement), credit memo reference, and failure analysis request flag. SSOT for customer return workflows and DPPM tracking inputs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'Unique surrogate identifier for the blanket purchase agreement record in the Databricks Silver layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer (OEM, automotive Tier-1, or distributor) who has entered into this blanket purchase agreement.',
    `customer_contract_id` BIGINT COMMENT 'Unique identifier for the customer contract record within the blanket order order entity.',
    `customer_design_win_id` BIGINT COMMENT 'Reference to the design win record in Salesforce CRM that originated this blanket order. Links the long-term supply commitment back to the customer design-in event and program qualification milestone.',
    `employee_id` BIGINT COMMENT 'Reference to the account manager or field sales representative who owns the customer relationship and negotiated this blanket agreement.',
    `org_unit_id` BIGINT COMMENT 'Reference to the SAP sales organization responsible for managing and fulfilling this blanket order agreement.',
    `price_agreement_id` BIGINT COMMENT 'Unique identifier for the price agreement record within the blanket order order entity.',
    `agreed_unit_price` DECIMAL(18,2) COMMENT 'The contractually agreed price per unit for the product under this blanket order. May be a single fixed price or the base tier price when pricing tiers are defined. Expressed in the contract currency.',
    `agreement_type` STRING COMMENT 'Classification of the blanket order agreement type. Scheduling agreements define delivery cadence; quantity contracts commit to total volume; value contracts commit to total spend; MPW (Multi-Project Wafer) blankets cover shuttle run commitments; distributor frame agreements govern stocking distributor relationships.. Valid values are `scheduling_agreement|quantity_contract|value_contract|mpw_blanket|distributor_frame`',
    `allocation_priority` STRING COMMENT 'Numeric priority ranking (lower value = higher priority) used during constrained supply allocation to determine which blanket orders receive preferential wafer starts and finished goods inventory. Automotive and safety-critical programs typically receive highest priority.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the blanket order agreement was formally approved by the authorized signatory (e.g., VP of Sales or Finance Controller) and transitioned from draft to active status. Required for SOX revenue recognition controls.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this blanket order agreement is configured to automatically renew for an additional contract period upon expiry if neither party issues a termination notice within the agreed notice window.',
    `blanket_order_number` STRING COMMENT 'Externally visible alphanumeric identifier for the blanket purchase agreement, used in customer-facing communications, SAP SD scheduling agreements, and ERP cross-references. Follows the BO- prefix convention.. Valid values are `^BO-[A-Z0-9]{6,20}$`',
    `blanket_order_status` STRING COMMENT 'The status of the blanket order record in the order domain.',
    `calloff_frequency` STRING COMMENT 'The agreed cadence at which the customer issues individual release orders (call-offs) against this blanket agreement. Drives wafer start planning, fab scheduling, and inventory build strategy.. Valid values are `weekly|biweekly|monthly|quarterly|on_demand`',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether the product or program covered by this blanket order qualifies for US CHIPS and Science Act incentives or domestic content requirements. Relevant for US government-funded programs and domestic semiconductor supply chain initiatives.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The total quantity of units (dies, packaged ICs, or wafers) the customer has committed to purchase over the full contract period. This is the binding volume commitment underpinning the blanket agreement.',
    `contract_duration_months` STRING COMMENT 'Total duration of the blanket order agreement expressed in calendar months. Standard semiconductor blanket agreements run 12 or 24 months; automotive long-term supply agreements may extend to 36 months.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this blanket order record was first created in the source system (SAP S/4HANA SD). Represents the business event of agreement entry, not the ETL load time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this blanket order (e.g., USD, EUR, JPY, KRW, TWD). Semiconductor contracts are predominantly denominated in USD.. Valid values are `^[A-Z]{3}$`',
    `customer_part_number` STRING COMMENT 'The customers own part number or device designation for the product covered by this blanket agreement. Required for cross-reference on customer purchase orders and shipping documents.',
    `distribution_channel` STRING COMMENT 'The sales channel through which this blanket order is fulfilled. Direct: sold directly to end customer; Distributor: fulfilled via authorized stocking distributor; Rep Firm: managed through manufacturers representative; OEM: original equipment manufacturer direct program; EMS: electronics manufacturing services partner.. Valid values are `direct|distributor|rep_firm|oem|ems`',
    `effective_date` DATE COMMENT 'The date on which the blanket order agreement becomes legally binding and call-off releases may begin. Marks the start of the contract period, typically aligned with the customers fiscal year or program start.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the blanket order order record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the blanket order order record.',
    `end_market_segment` STRING COMMENT 'The primary end-market application segment for the product covered by this blanket order. Used for revenue segmentation, demand planning, and strategic reporting. [ENUM-REF-CANDIDATE: automotive|mobile|computing|industrial|iot|ai_datacenter|aerospace_defense|consumer|networking|medical — promote to reference product]',
    `expiry_date` DATE COMMENT 'The date on which the blanket order agreement expires and no further call-off releases may be issued. Typically 12 to 24 months from the effective date for semiconductor OEM and automotive Tier-1 agreements.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) for the product covered by this blanket order. Determines whether an export license is required for shipment to the customers country. Critical for semiconductor products subject to BIS/EAR controls.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required to ship product under this blanket order to the customers destination country based on the ECCN and end-use classification. Triggers compliance review workflow when True.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between Semiconductors and the customer for shipments under this blanket agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the product or technology covered by this blanket order is subject to International Traffic in Arms Regulations (ITAR) controls. When True, additional compliance approvals and end-use certificates are required before shipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this blanket order record in the source system. Tracks amendments to pricing, quantities, dates, or terms. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_release_date` DATE COMMENT 'The date of the most recent call-off release order issued against this blanket agreement. Used to monitor customer ordering activity, identify dormant blankets, and trigger account management follow-up.',
    `lead_time_weeks` STRING COMMENT 'The agreed manufacturing and delivery lead time in weeks from call-off release order placement to customer delivery. Encompasses wafer fab cycle time, assembly and test (OSAT), and logistics. Critical for wafer start authorization scheduling.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity per individual call-off release order as agreed in the blanket contract. Enforces production lot efficiency and wafer start economics. Expressed in the same unit of measure as committed_quantity.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the blanket order record in the order domain.',
    `ncnr_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of the committed quantity or blanket value that is subject to NCNR terms. A value of 100 means the entire commitment is NCNR; partial NCNR coverage is common in distributor agreements.',
    `ncnr_flag` BOOLEAN COMMENT 'Indicates whether the blanket order is subject to Non-Cancellable Non-Returnable (NCNR) terms. When True, the customer cannot cancel or return product once a release order is issued. Standard for automotive and high-volume OEM semiconductor supply agreements.',
    `order_status` STRING COMMENT 'Current lifecycle state of the blanket order agreement. Draft: under negotiation; Active: binding and open for call-offs; On Hold: temporarily suspended; Partially Released: some call-off orders issued; Fully Released: all committed quantity has been called off; Closed: contract period ended; Cancelled: terminated before expiry. [ENUM-REF-CANDIDATE: draft|active|on_hold|partially_released|fully_released|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `payment_terms_code` STRING COMMENT 'SAP payment terms code defining the invoice due date, early payment discount conditions, and payment schedule applicable to release orders issued under this blanket agreement (e.g., NET30, NET60, 2/10NET30).',
    `pricing_tier_structure` STRING COMMENT 'Defines the pricing model applied to this blanket order. Fixed: single price for all quantities; Volume Tiered: unit price decreases at defined quantity thresholds; Time Tiered: price adjusts at defined calendar intervals; Milestone Tiered: price adjusts upon reaching program milestones such as design-in or production ramp.. Valid values are `fixed|volume_tiered|time_tiered|milestone_tiered`',
    `product_part_number` STRING COMMENT 'The Semiconductors internal part number (device identifier) for the IC, SoC, ASIC, or FPGA product covered by this blanket order. Aligns with the product master in SAP MM and Oracle Agile PLM.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the committed and released quantities. EA = each (packaged unit); WFR = wafer; DIE = bare die; REEL = tape-and-reel packaging unit; TRAY = tray packaging unit. Aligns with SAP MM unit of measure configuration.. Valid values are `EA|WFR|DIE|REEL|TRAY`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product and its packaging materials comply with EU REACH Regulation (EC No 1907/2006) requirements for chemical substance registration and restriction. Required for EU market access.',
    `release_order_to_blanket` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Individual sales orders (release orders) are created against blanket orders. The sales order must reference its parent blanket for volume tracking.',
    `released_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity that has been called off against this blanket order through individual release orders to date. Used to track consumption of the committed volume and compute remaining open quantity.',
    `renewal_notice_days` STRING COMMENT 'The number of calendar days prior to the expiry date by which either party must provide written notice to prevent automatic renewal or to initiate renegotiation of the blanket agreement terms.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product shipped under this blanket order is compliant with the EU RoHS Directive (2011/65/EU) restricting hazardous substances in electronic equipment. Mandatory for EU market shipments.',
    `sales_order_to_blanket` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Individual sales orders are call-offs against blanket orders. This link is critical for blanket quantity consumption tracking and volume commitment management.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary customer delivery destination under this blanket agreement. Used for export control classification, logistics routing, and trade compliance screening.. Valid values are `^[A-Z]{3}$`',
    `total_blanket_value` DECIMAL(18,2) COMMENT 'The total monetary value of the blanket order agreement, calculated as committed_quantity multiplied by agreed_unit_price (or sum of tier values). Represents the maximum revenue commitment from this customer for the contract period. Used for revenue forecasting and SOX financial reporting.',
    `total_committed_quantity` DECIMAL(18,2) COMMENT 'The total committed quantity of the blanket order record in the order domain.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'The total committed value of the blanket order record in the order domain.',
    `total_committed_value_usd` DECIMAL(18,2) COMMENT 'The total committed value usd of the blanket order record in the order domain.',
    `validity_end_date` DATE COMMENT 'The validity end date associated with the blanket order order record.',
    `validity_start_date` DATE COMMENT 'The validity start date associated with the blanket order order record.',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term blanket purchase agreement with a customer defining total committed quantity, pricing tiers, and delivery cadence over a contract period (typically 12-24 months). Captures blanket order value, product mix, agreed unit prices, minimum order quantities, call-off frequency, remaining open quantity, and NCNR (non-cancellable non-returnable) terms. Supports high-volume OEM, automotive Tier-1, and distributor relationships where customers commit to annual volumes with periodic release orders against the blanket.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`order_hold` (
    `order_hold_id` BIGINT COMMENT 'Unique surrogate identifier for each hold record placed on a sales order or order line within the SAP S/4HANA SD order block management module. Primary key for the order.hold data product.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the quality lot or wafer lot under disposition that triggered a QUALITY hold on the order. Links to the quality domain for full traceability between order holds and quality management workflows. Null for non-quality holds.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer (MPW) run associated with the held order, if applicable. Enables traceability between order holds and MPW shuttle schedules, which have fixed tapeout and delivery dates that may be impacted by hold duration.',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item on which this hold is placed. Null if the hold applies to the entire sales order header rather than a specific line. Enables line-level hold granularity for partial shipment scenarios.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the order placed by employee record within the order hold order entity.',
    `primary_order_employee_id` BIGINT COMMENT 'Reference to the employee or team responsible for managing and resolving this hold. Typically the credit analyst, export compliance officer, quality engineer, or customer service representative who initiated or owns the hold. Links to the workforce domain for accountability tracking.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the order hold order entity.',
    `tertiary_order_escalation_owner_employee_id` BIGINT COMMENT 'Reference to the senior manager or compliance officer to whom the hold has been escalated. Null if not escalated. Enables accountability tracking for escalated holds and management reporting.',
    `trade_compliance_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_hold. Business justification: Order holds can be triggered by a trade compliance hold; linking enables root‑cause analysis.',
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
    `hold_placed_timestamp` TIMESTAMP COMMENT 'The hold placed timestamp of the order hold record in the order domain.',
    `hold_reason` STRING COMMENT 'The hold reason of the order hold record in the order domain.',
    `hold_reason_code` STRING COMMENT 'Coded value representing the hold reason code of the order hold order record.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'The hold release timestamp of the order hold record in the order domain.',
    `hold_released_timestamp` TIMESTAMP COMMENT 'The hold released timestamp of the order hold record in the order domain.',
    `hold_start_timestamp` TIMESTAMP COMMENT 'The hold start timestamp of the order hold record in the order domain.',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold record. ACTIVE = hold is in effect and order processing is blocked; RELEASED = hold has been resolved and order processing may resume; ESCALATED = hold has been escalated to senior management or compliance officer; CANCELLED = hold was voided without formal release (e.g., duplicate entry).. Valid values are `ACTIVE|RELEASED|ESCALATED|CANCELLED`',
    `hold_type` STRING COMMENT 'Classification of the hold category that determines the workflow and approval path required for release. CREDIT = credit limit exceeded or payment overdue; EXPORT_COMPLIANCE = pending export license or ITAR/EAR review; QUALITY = quality disposition pending; CUSTOMER_REQUEST = customer-initiated pause; ALLOCATION = insufficient die bank or wafer inventory; REGULATORY = RoHS/REACH/CHIPS Act compliance verification pending.. Valid values are `CREDIT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_REQUEST|ALLOCATION|REGULATORY`',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the hold is related to International Traffic in Arms Regulations (ITAR) controlled technology or products. True = ITAR-controlled item requiring State Department authorization; False = not ITAR-controlled. Drives export compliance workflow routing and documentation requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the order hold record in the order domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the order hold record in the order domain.',
    `order_value_at_risk` DECIMAL(18,2) COMMENT 'Net value of the sales order or order line blocked by this hold, expressed in the order currency. Represents the revenue at risk due to the hold and is used for business impact assessment, management reporting, and prioritization of hold resolution efforts.',
    `owner_department` STRING COMMENT 'Business department responsible for resolving the hold. Drives workflow routing and SLA assignment. CREDIT_MGMT = credit and collections team; EXPORT_COMPLIANCE = trade compliance and ITAR/EAR team; QUALITY = quality assurance and reliability team; CUSTOMER_SERVICE = order management team; SUPPLY_CHAIN = allocation and inventory team; FINANCE = accounts receivable.. Valid values are `CREDIT_MGMT|EXPORT_COMPLIANCE|QUALITY|CUSTOMER_SERVICE|SUPPLY_CHAIN|FINANCE`',
    `owner_name` STRING COMMENT 'Full name of the employee or team responsible for managing and resolving this hold at the time it was placed. Denormalized for operational reporting and audit trail purposes without requiring a join to the workforce domain.',
    `placed_timestamp` TIMESTAMP COMMENT 'The placed timestamp of the order hold record in the order domain.',
    `quality_disposition_status` STRING COMMENT 'Current disposition decision status for the quality lot associated with a QUALITY hold. PENDING = disposition not yet determined; USE_AS_IS = lot approved for shipment as-is; REWORK = lot requires rework before shipment; SCRAP = lot scrapped, order must be re-sourced; RETURN_TO_SUPPLIER = material returned to supplier. Null for non-quality holds.. Valid values are `PENDING|USE_AS_IS|REWORK|SCRAP|RETURN_TO_SUPPLIER`',
    `reason` STRING COMMENT 'Detailed narrative explanation of why the hold was placed on the order. Captures the specific business condition triggering the block, such as credit limit exceeded amount, export license number pending, quality lot disposition reference, or customer-requested delivery pause reason. Free-text field sourced from SAP S/4HANA SD order block reason text.',
    `reason_code` STRING COMMENT 'Standardized SAP S/4HANA SD order block reason code (e.g., 01 = Credit Block, 02 = Export Block, 03 = Quality Block) used for systematic reporting and workflow routing. Complements the free-text hold_reason field with a machine-readable classification. [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|08|09|10 — promote to reference product]',
    `release_approver_name` STRING COMMENT 'Full name of the employee who approved the release of the hold at the time of release. Denormalized for audit trail and compliance reporting without requiring a join to the workforce domain.',
    `release_date` TIMESTAMP COMMENT 'Date and time when the hold was formally released and order processing was authorized to resume. Null if the hold is still active. Used to calculate hold duration and measure order management cycle time performance.',
    `release_reason` STRING COMMENT 'Narrative explanation of the resolution that enabled the hold to be released. Captures the specific action taken, such as credit limit increase approved, export license number obtained, quality lot disposition completed, or customer confirmation received. Free-text field for audit and compliance documentation.',
    `released_timestamp` TIMESTAMP COMMENT 'The released timestamp of the order hold record in the order domain.',
    `requested_release_date` DATE COMMENT 'The date by which the hold is expected or requested to be released, as agreed with the customer or set by the hold owner. Used for proactive hold management, customer commitment tracking, and delivery schedule impact assessment.',
    `resolution_notes` STRING COMMENT 'Extended free-text notes documenting the full resolution process, including any corrective actions taken, approvals obtained, reference documents reviewed, and follow-up actions required. Supports post-hold analysis and process improvement initiatives.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the hold resolution exceeded the defined SLA target hours. True = SLA was breached; False = resolved within SLA. Used for order management performance reporting and customer escalation management.',
    `sla_target_hours` STRING COMMENT 'Target number of business hours within which the hold must be resolved per the order management SLA policy. Varies by hold type: credit holds typically 24 hours, export compliance holds 72 hours, quality holds 48 hours. Used for SLA compliance monitoring and customer commitment management.',
    `source_system_hold_reference` STRING COMMENT 'The native hold or order block identifier as recorded in the originating operational system (e.g., SAP S/4HANA SD order block number). Enables reconciliation between the Silver layer data product and the source system of record for data lineage and audit purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this hold record was last modified in the data platform. Tracks the most recent update to any hold attribute, supporting change data capture, audit trail requirements, and incremental data pipeline processing.',
    `wafer_start_impacted` BOOLEAN COMMENT 'Indicates whether this hold has blocked or delayed a wafer start authorization (WSA) associated with the sales order. True = wafer start is impacted; False = wafer start is not affected. Critical for fab capacity planning and WIP management in semiconductor manufacturing.',
    CONSTRAINT pk_order_hold PRIMARY KEY(`order_hold_id`)
) COMMENT 'Record of holds placed on a sales order or order line that prevent further processing or shipment. Captures hold type (credit hold, export compliance hold, quality hold, customer request hold), hold reason, hold date, hold owner, release date, release approver, and resolution notes. Supports order management workflows where orders must be paused pending credit approval, export license verification, or quality disposition. Sourced from SAP S/4HANA SD order block management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` (
    `delivery_confirmation_id` BIGINT COMMENT 'Unique surrogate identifier for the delivery confirmation record in the Databricks Silver Layer. Primary key for the delivery_confirmation data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer who received and confirmed the semiconductor shipment. Used for downstream invoice release and revenue recognition attribution.',
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule record within the delivery confirmation order entity.',
    `order_id` BIGINT COMMENT 'Reference to the sales order associated with this delivery confirmation. Enables traceability from proof of delivery back to the originating customer order in the order-to-cash lifecycle.',
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line record within the delivery confirmation order entity.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment record for which this delivery confirmation is being captured. Links the proof of delivery (POD) event back to the originating shipment.',
    `asn_number` STRING COMMENT 'The Advance Shipment Notice number from the customers EDI 856 ASN acknowledgement message. Used to correlate the delivery confirmation with the inbound EDI transaction from the customers warehouse management or ERP system.',
    `carrier_pod_reference` STRING COMMENT 'The carriers own proof-of-delivery document reference number as provided in the carrier POD data feed. Used to reconcile the internal delivery confirmation with the carriers logistics records and resolve freight disputes.',
    `carrier_tracking_number` STRING COMMENT 'The carriers shipment tracking number associated with this delivery confirmation. Enables direct lookup in carrier portals for POD document retrieval and dispute resolution.',
    `confirmation_channel` STRING COMMENT 'The communication channel through which the delivery confirmation was received from the customer or carrier. edi = Electronic Data Interchange (EDI 856/861); portal = customer self-service portal; api = direct API integration; email = email-based confirmation; manual = manually entered by customer service representative.. Valid values are `edi|portal|api|email|manual`',
    `confirmation_number` STRING COMMENT 'Externally visible, human-readable business identifier for this delivery confirmation record. Communicated to customers and logistics partners as the official proof-of-delivery (POD) reference number. Format: DC- followed by 10 digits.. Valid values are `^DC-[0-9]{10}$`',
    `confirmation_status` STRING COMMENT 'Current workflow state of the delivery confirmation record. pending indicates awaiting customer acknowledgement; confirmed indicates full receipt acknowledged; disputed indicates customer raised a discrepancy; partially_confirmed indicates partial quantity acknowledged; cancelled indicates confirmation voided.. Valid values are `pending|confirmed|disputed|partially_confirmed|cancelled`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units (dies, packaged ICs, wafers, or reels) confirmed as received by the customer at the destination facility. May differ from shipped quantity in cases of shortage, overage, or partial delivery. Used as the basis for invoice quantity and revenue recognition.',
    `confirmed_receipt_date` DATE COMMENT 'The actual calendar date on which the customer confirmed physical receipt of the semiconductor shipment at the destination facility. This is the principal business event date for the delivery confirmation and serves as the trigger date for invoice release and revenue recognition per ASC 606 / IFRS 15.',
    `confirmed_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the customer confirmed receipt of the shipment, including timezone offset. Used for SLA measurement, carrier performance analytics, and precise revenue recognition event logging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery confirmation record was first created in the system, either via carrier POD data feed or customer EDI 856 ASN acknowledgement ingestion. Audit trail field for data lineage.',
    `customer_acceptance_status` STRING COMMENT 'The customers formal acceptance decision for the delivered semiconductor product. accepted = unconditional acceptance; rejected = full rejection, return initiated; conditionally_accepted = accepted with noted discrepancy pending resolution; pending_inspection = customer incoming quality inspection in progress.. Valid values are `accepted|rejected|conditionally_accepted|pending_inspection`',
    `customer_po_number` STRING COMMENT 'The customers purchase order number as referenced on the delivery confirmation. Cross-references the customers procurement system to the semiconductor manufacturers order-to-cash records. Critical for invoice matching and accounts receivable reconciliation.',
    `customer_signoff_name` STRING COMMENT 'Name of the customer representative who signed off on the delivery confirmation at the receiving facility. Captured from carrier POD document or EDI 856 acknowledgement. Classified as confidential PII as it identifies an individual at the customer organization.',
    `customer_signoff_reference` STRING COMMENT 'The reference identifier of the customers authorized signoff on the delivery confirmation, such as a digital signature ID, customer dock receipt number, or customer ERP goods receipt document number. Required for invoice release authorization and revenue recognition event triggering.',
    `days_late` STRING COMMENT 'Number of calendar days by which the confirmed receipt date exceeded the committed delivery date on the sales order. Negative values indicate early delivery. Zero indicates on-time delivery. Used for carrier performance scorecards and customer SLA compliance reporting.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The delivered quantity of the delivery confirmation record in the order domain.',
    `delivery_date` DATE COMMENT 'The delivery date associated with the delivery confirmation order record.',
    `delivery_performance_code` STRING COMMENT 'Classification of delivery performance relative to the confirmed delivery date on the sales order. on_time = delivered within the committed window; early = delivered before committed date; late = delivered after committed date; partial = partial quantity delivered; failed = delivery not completed. Used for OTIF (On-Time In-Full) KPI reporting.. Valid values are `on_time|early|late|partial|failed`',
    `delivery_status` STRING COMMENT 'The delivery status of the delivery confirmation record in the order domain.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the delivery confirmation record in the order domain.',
    `device_revision` STRING COMMENT 'The silicon revision or stepping of the delivered semiconductor device (e.g., A0, B1, C2). Captured at delivery confirmation to ensure the customer received the correct device revision as specified in the purchase order and product change notification (PCN).',
    `discrepancy_description` STRING COMMENT 'Free-text narrative description of the discrepancy reported by the customer. Captures details not covered by the discrepancy_type enumeration, such as specific damage descriptions, lot number mismatches, or partial damage to a reel. Used in quality notification and RMA processing.',
    `discrepancy_flag` BOOLEAN COMMENT 'Boolean indicator set to TRUE when the customer has reported any discrepancy between the shipment contents and the delivery confirmation. Triggers downstream discrepancy resolution workflow, quality notification in SAP QM, and potential RMA initiation.',
    `discrepancy_type` STRING COMMENT 'Classification of the discrepancy reported by the customer. quantity_shortage = fewer units received than shipped; wrong_part = incorrect part number or device type received; damaged_goods = physical damage to ICs, packaging, or wafers; wrong_lot = incorrect lot number or traceability mismatch; labeling_error = incorrect label or marking; none = no discrepancy.. Valid values are `quantity_shortage|wrong_part|damaged_goods|wrong_lot|labeling_error|none`',
    `export_control_verified_flag` BOOLEAN COMMENT 'Boolean indicator set to TRUE when export control compliance has been verified for this delivery, confirming the shipment reached the authorized end-destination and end-user as specified in the export license. Required for BIS/EAR and ITAR compliance audit trails.',
    `goods_receipt_document_number` STRING COMMENT 'The customers ERP goods receipt document number (e.g., SAP MIGO GR document) confirming the semiconductor shipment has been posted into the customers inventory. Provides the strongest form of delivery confirmation for invoice matching and dispute resolution.',
    `incoterms_code` STRING COMMENT 'The International Commercial Terms (Incoterms 2020) code governing the transfer of risk and title for this shipment. Determines the point at which delivery is legally confirmed and revenue recognition is triggered. Critical for export compliance and financial reporting. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_release_flag` BOOLEAN COMMENT 'Boolean indicator set to TRUE when this delivery confirmation has triggered the downstream invoice release event in SAP S/4HANA FI/SD. Enables monitoring of the order-to-cash cycle and identification of confirmed deliveries pending invoice generation.',
    `invoice_release_timestamp` TIMESTAMP COMMENT 'The date and time at which the invoice release event was triggered in SAP S/4HANA FI following delivery confirmation. Used for order-to-cash cycle time analytics and revenue recognition timing compliance under ASC 606 / IFRS 15.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean indicator set to TRUE when the delivered semiconductor product is subject to ITAR controls. Triggers mandatory end-use verification and delivery confirmation audit requirements under ITAR Part 123.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the delivery confirmation record in the order domain.',
    `lot_number` STRING COMMENT 'The semiconductor wafer lot number associated with the delivered product. Enables full traceability from delivery confirmation back to the fabrication lot in the MES (Camstar/Applied Materials SmartFactory). Critical for quality escapes, field failure analysis, and DPPM tracking.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the delivery confirmation record in the order domain.',
    `package_count_confirmed` STRING COMMENT 'The number of physical packages (boxes, reels, trays, tubes) confirmed as received by the customer. Compared against the shipped package count to identify missing packages in transit. Used for carrier claims and freight audit.',
    `part_number` STRING COMMENT 'The manufacturers part number (MPN) of the semiconductor product delivered. Used to verify correct part delivery against the customer PO and to cross-reference with the product master in Oracle Agile PLM and SAP MM.',
    `pod_source` STRING COMMENT 'The originating data source from which this delivery confirmation was captured. carrier_pod = carrier electronic POD feed; edi_856 = customer EDI 856 ASN acknowledgement; customer_portal = customer self-service portal submission; manual = manually entered by customer service; email_confirmation = email-based confirmation.. Valid values are `carrier_pod|edi_856|customer_portal|manual|email_confirmation`',
    `proof_of_delivery_reference` STRING COMMENT 'The proof of delivery reference of the delivery confirmation record in the order domain.',
    `proof_of_delivery_url` STRING COMMENT 'The proof of delivery url of the delivery confirmation record in the order domain.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The arithmetic difference between shipped_quantity and confirmed_quantity (shipped minus confirmed). A positive value indicates a shortage; a negative value indicates an overage. Used to trigger discrepancy workflows and credit/debit memo processing in SAP S/4HANA FI.',
    `received_by` STRING COMMENT 'The received by of the delivery confirmation record in the order domain.',
    `receiving_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country where the semiconductor shipment was received. Used for export control compliance verification, trade compliance reporting, and geographic revenue analytics.. Valid values are `^[A-Z]{3}$`',
    `receiving_location_code` STRING COMMENT 'The customers facility or dock location code where the semiconductor shipment was physically received. Sourced from the customer EDI 856 ASN or carrier POD data. Used for logistics analytics and customer facility mapping.',
    `revenue_recognition_flag` BOOLEAN COMMENT 'Boolean indicator set to TRUE when this delivery confirmation has satisfied the performance obligation criteria and triggered a revenue recognition event in the financial system. Critical for SOX-compliant revenue reporting.',
    `rma_reference_number` STRING COMMENT 'The Return Merchandise Authorization number issued when a discrepancy results in a product return. Populated only when discrepancy_flag is TRUE and a return has been authorized. Links the delivery confirmation to the downstream RMA and reverse logistics process.',
    `rohs_compliant` BOOLEAN COMMENT 'Boolean indicator confirming that the delivered semiconductor product complies with the EU RoHS Directive (2011/65/EU) restricting hazardous substances. Captured at delivery confirmation for regulatory compliance documentation.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units originally shipped as recorded on the shipment record. Compared against confirmed_quantity to identify shortages or overages at delivery confirmation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the confirmed delivery quantity. EA = each (individual packaged IC or die); REEL = tape-and-reel packaging; WAFER = bare or processed wafer; TRAY = JEDEC tray; TUBE = IC tube packaging; LOT = wafer lot.. Valid values are `EA|REEL|WAFER|TRAY|TUBE|LOT`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this delivery confirmation record, such as discrepancy updates, status changes, or customer signoff amendments. Supports audit trail and change tracking.',
    CONSTRAINT pk_delivery_confirmation PRIMARY KEY(`delivery_confirmation_id`)
) COMMENT 'Customer delivery confirmation record capturing proof of delivery (POD) for semiconductor shipments. Records confirmed receipt date, confirmed quantity, receiving location, customer PO reference, discrepancy flag, discrepancy type (quantity shortage, wrong part, damaged goods), and customer signoff reference. Triggers downstream invoice release and revenue recognition events. Sourced from carrier POD data and customer EDI 856 ASN acknowledgements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` (
    `lot_assignment_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a specific lot-to-order-line assignment record within the order-to-cash fulfillment process.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this lot assignment is made. Supports customer-level lot traceability reporting required by automotive and aerospace customers.',
    `assembly_lot_id` BIGINT COMMENT 'Unique identifier for the assembly lot record within the lot assignment order entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lot assignment ownership links a responsible employee to each wafer lot for traceability and quality audits.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the fabrication wafer lot record within the lot assignment order entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: REQUIRED: Lot assignment process records which wafer lot is assigned to a specific order/line; FK provides direct lookup for assignment audits.',
    `order_id` BIGINT COMMENT 'Unique identifier for the lot order record within the lot assignment order entity.',
    `lot_sales_order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this lot assignment belongs. Links the lot assignment back to the customer order for order-to-cash traceability.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW (Multi-Project Wafer) shuttle run from which this lot originates, applicable for MPW lot types. Links the assignment back to the specific MPW shuttle for design-to-delivery traceability.',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item within the sales order for which this lot is being assigned. Enables line-level lot traceability for multi-line orders.',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the OSAT (Outsourced Semiconductor Assembly and Test) vendor responsible for packaging and assembly of the lot, if applicable. Relevant for packaged goods lots and KGD lots sourced from external assembly houses.',
    `shipment_id` BIGINT COMMENT 'Reference to the outbound shipment record under which this lot assignment was physically dispatched. Links the lot assignment forward to the shipment for end-to-end order-to-cash traceability.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the lot assignment order entity.',
    `test_program_id` BIGINT COMMENT 'Reference to the ATE (Automatic Test Equipment) test program used to qualify the lot prior to assignment. Enables traceability from the customer order back to the specific test program version used for lot qualification.',
    `actual_ship_date` DATE COMMENT 'The actual calendar date on which the assigned lot was physically shipped to the customer. Populated upon shipment confirmation from the MES or SAP SD goods issue posting. Used for on-time delivery (OTD) performance measurement.',
    `allocation_priority` STRING COMMENT 'Numeric priority rank governing the order in which this lot assignment is fulfilled when supply is constrained. Lower values indicate higher priority. Used by supply chain planners for backlog management and allocation decisions.',
    `assigned_quantity` DECIMAL(18,2) COMMENT 'The quantity of units from this lot assigned to the order line. For wafer lots this represents wafer count; for die lots this represents die count; for packaged goods lots this represents unit count. Must not exceed the available lot quantity.',
    `assignment_date` DATE COMMENT 'The calendar date on which the lot was formally assigned to the customer order line. Used for backlog management, delivery schedule tracking, and IATF 16949 lot traceability audit trails.',
    `assignment_number` STRING COMMENT 'The assignment number of the lot assignment record in the order domain.',
    `assignment_source` STRING COMMENT 'Indicates how the lot assignment was created. Manual indicates a planner manually assigned the lot; atp_auto indicates the SAP ATP (Available-to-Promise) engine automatically assigned it; allocation_run indicates it was created by a batch allocation run; planner_override indicates a planner overrode an automatic assignment; system_transfer indicates the assignment was transferred from another order.. Valid values are `manual|atp_auto|allocation_run|planner_override|system_transfer`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the lot-to-order assignment. Tentative indicates a preliminary reservation pending confirmation; confirmed indicates a firm allocation; allocated indicates inventory has been committed; shipped indicates the lot has been dispatched; cancelled indicates the assignment was voided; on_hold indicates the assignment is suspended pending quality disposition or export review.. Valid values are `tentative|confirmed|allocated|shipped|cancelled|on_hold`',
    `assignment_type` STRING COMMENT 'The assignment type of the lot assignment record in the order domain.',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this lot assignment is part of the open order backlog, meaning the order has not yet been fully shipped and revenue has not been recognized. Used for backlog reporting and revenue forecasting.',
    `cancellation_reason` STRING COMMENT 'The reason code or description explaining why a lot assignment was cancelled. Populated only when assignment_status is cancelled. Used for root cause analysis and supply chain performance reporting.',
    `certificate_of_conformance_number` STRING COMMENT 'The certificate of conformance document number issued for this lot assignment, confirming the lot meets all specified quality and regulatory requirements. Required by automotive (IATF 16949) and aerospace customers.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether the lot assignment is associated with production eligible for US CHIPS and Science Act incentives or reporting requirements. Relevant for domestic semiconductor manufacturing compliance and subsidy tracking.',
    `confirmed_ship_date` DATE COMMENT 'The confirmed date on which the assigned lot is scheduled to ship to the customer. Drives delivery commitment and ATP (Available-to-Promise) calculations in SAP SD.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code identifying the country where the lot was manufactured. Required for customs declarations, tariff classification, and CHIPS Act domestic content reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lot assignment record was first created in the system. Provides the audit trail creation timestamp required for SOX compliance and IATF 16949 traceability records.',
    `customer_po_number` STRING COMMENT 'The customer-provided purchase order number associated with this lot assignment. Required for invoice matching, customer receiving, and lot traceability documentation provided to the customer.',
    `date_code` STRING COMMENT 'The manufacturing date code of the lot in YYYYWW format (year and work week), indicating when the lot was fabricated. Required for component traceability, shelf-life management, and customer receiving inspection.. Valid values are `^[0-9]{4}[0-5][0-9]$`',
    `dppm` DECIMAL(18,2) COMMENT 'The defective parts per million rate measured for the assigned lot. Key quality metric reported to automotive customers under IATF 16949 and AIAG quality reporting requirements.',
    `export_control_classification` STRING COMMENT 'The Export Control Classification Number (ECCN) applicable to the lot being assigned, as required under EAR (Export Administration Regulations). Determines whether an export license is required for shipment to the customer destination country.',
    `export_license_number` STRING COMMENT 'The export license number issued by BIS or DDTC authorizing shipment of this lot to the customer, where required. Must be documented on shipping documentation for EAR/ITAR compliance.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required for shipment of this lot to the customer destination country based on the ECCN and destination. Drives export compliance workflow in SAP GTS.',
    `inspection_lot_number` STRING COMMENT 'The SAP QM inspection lot number associated with the quality inspection results for this manufacturing lot. Links the lot assignment to the formal quality inspection record for audit traceability.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the lot being assigned is subject to ITAR (International Traffic in Arms Regulations) controls. ITAR-controlled lots require additional compliance review and documentation before shipment.',
    `kgd_grade` STRING COMMENT 'The KGD (Known Good Die) quality grade assigned to the lot, applicable for die lots and advanced packaging orders. Grade A represents highest quality fully tested die; Grade B represents die meeting relaxed specifications; engineering sample and qualification grades apply to pre-production lots.. Valid values are `grade_a|grade_b|grade_c|engineering_sample|qualification`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the lot assignment record in the order domain.',
    `lot_number` STRING COMMENT 'The manufacturing lot identifier assigned by the Camstar MES or SAP PP module. Uniquely identifies the wafer lot, die lot, or packaged goods lot being assigned to the order line. This is the primary traceability key linking customer orders back to wafer fabrication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lot_type` STRING COMMENT 'Classification of the lot being assigned to the order line. Distinguishes between wafer lots (silicon substrates in fabrication), die lots (singulated Known Good Die), packaged goods lots (finished assembled units), KGD (Known Good Die) lots for advanced packaging, and MPW (Multi-Project Wafer) shuttle lots.. Valid values are `wafer_lot|die_lot|packaged_goods_lot|kgd_lot|mpw_lot`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the lot assignment record in the order domain.',
    `part_number` STRING COMMENT 'The finished goods or intermediate part number (SAP material number) associated with the lot being assigned. Identifies the specific IC, die, or wafer product being fulfilled against the order line.',
    `part_revision` STRING COMMENT 'The revision level of the part number associated with the assigned lot. Critical for automotive and aerospace customers who require revision-level traceability per IATF 16949 and AS9100 requirements.. Valid values are `^[A-Z0-9]{1,5}$`',
    `process_node` STRING COMMENT 'The semiconductor fabrication process node (technology node) used to manufacture the lot, expressed in nanometers (e.g., 7nm, 5nm, 28nm, 65nm). Identifies the manufacturing technology generation for the assigned lot.',
    `quality_disposition` STRING COMMENT 'The quality disposition status of the lot at the time of assignment. Accepted indicates the lot passed all quality gates; conditionally accepted indicates the lot is approved with documented deviations; rejected indicates the lot failed quality inspection; under review indicates quality evaluation is in progress; quarantined indicates the lot is isolated pending investigation.. Valid values are `accepted|conditionally_accepted|rejected|under_review|quarantined`',
    `quality_disposition_notes` STRING COMMENT 'Free-text notes documenting any lot-specific quality disposition details, deviations, waivers, or special handling instructions associated with this assignment. Required for automotive customers under IATF 16949 non-conforming product management.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the assigned lot is compliant with EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals). Required for EU market shipments and chemical substance reporting.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the assigned lot is compliant with the EU RoHS Directive (Restriction of Hazardous Substances), restricting the use of specific hazardous materials in electronic equipment. Required for EU market shipments.',
    `unit_of_measure` STRING COMMENT 'The unit of measure applicable to the assigned quantity. Wafers for wafer lots, dies for die lots, units for packaged goods, reels or trays for tape-and-reel or tray-packaged finished goods.. Valid values are `wafers|dies|units|reels|trays`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this lot assignment record was last modified. Tracks the most recent change to the assignment for audit trail and data lineage purposes in the Silver Layer lakehouse.',
    `wafer_fab_site` STRING COMMENT 'The fabrication facility site code where the wafer lot was manufactured. Identifies the specific FAB (Fabrication Facility) for supply chain traceability, export control compliance, and CHIPS Act reporting.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The die yield percentage of the assigned lot, representing the proportion of good dies per wafer that passed all test and inspection criteria. Critical quality metric for automotive and aerospace customers requiring lot-level quality data.',
    CONSTRAINT pk_lot_assignment PRIMARY KEY(`lot_assignment_id`)
) COMMENT 'Association record linking a specific wafer lot or finished goods lot to a customer order line for fulfillment traceability. Captures assigned lot number, lot type (wafer lot, die lot, packaged goods lot), assigned quantity, assignment date, assignment status (tentative, confirmed, shipped), and any lot-specific quality disposition notes. Enables full lot traceability from customer order back to wafer fabrication and forward to shipment. Critical for automotive (IATF 16949) and aerospace customers requiring lot-level traceability.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_allocation_record_id` FOREIGN KEY (`allocation_record_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`allocation_record`(`allocation_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_primary_status_order_id` FOREIGN KEY (`primary_status_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_primary_wafer_order_id` FOREIGN KEY (`primary_wafer_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_primary_mpw_order_sales_order_id` FOREIGN KEY (`primary_mpw_order_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_primary_die_order_id` FOREIGN KEY (`primary_die_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_primary_delivery_order_line_id` FOREIGN KEY (`primary_delivery_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_primary_shipment_order_id` FOREIGN KEY (`primary_shipment_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_to_order_id` FOREIGN KEY (`to_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_primary_shipment_order_line_id` FOREIGN KEY (`primary_shipment_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_shipment_id` FOREIGN KEY (`to_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_primary_order_line_id` FOREIGN KEY (`primary_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_allocation_sales_order_id` FOREIGN KEY (`allocation_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_primary_order_line_id` FOREIGN KEY (`primary_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_amendment_amended_sales_order_id` FOREIGN KEY (`amendment_amended_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_parent_order_id` FOREIGN KEY (`parent_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_primary_nre_sales_order_id` FOREIGN KEY (`primary_nre_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_nre_order_id` FOREIGN KEY (`nre_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`nre_order`(`nre_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_primary_rma_order_id` FOREIGN KEY (`primary_rma_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_tertiary_rma_sales_order_id` FOREIGN KEY (`tertiary_rma_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_lot_sales_order_id` FOREIGN KEY (`lot_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` SET TAGS ('dbx_ssot_owner' = 'invoice_line_vs_order_line');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Declaration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|REEL|TRAY|TUBE');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ALTER COLUMN `wafer_start_authorization` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Status History Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `allocation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Production Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `primary_status_order_id` SET TAGS ('dbx_business_glossary_term' = 'Status Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `status_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `status_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `status_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_value_regex' = 'customer_request|eol|capacity|yield_fail|export_block|duplicate');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `change_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Status Change Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `die_bank_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `duration_in_prior_status_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Prior Status (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `escalation_priority` SET TAGS ('dbx_business_glossary_term' = 'Escalation Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `escalation_priority` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `is_current_status` SET TAGS ('dbx_business_glossary_term' = 'Is Current Status Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `mpw_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `pcn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|LOT');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `sla_breached_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'forward|backward|cancellation|correction');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `triggered_by_system` SET TAGS ('dbx_business_glossary_term' = 'Triggered By System');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `primary_wafer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `reticle_set_id` SET TAGS ('dbx_business_glossary_term' = 'Reticle Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_authorized_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_authorized_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_authorized_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'auto_approved|manager|director|vp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_value_regex' = '^WSA-[A-Z0-9]{4,10}-[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Authorized By');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorized_wafer_qty` SET TAGS ('dbx_business_glossary_term' = 'Authorized Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `authorized_wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'US CHIPS Act Eligibility Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `cycle_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Target (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `design_revision` SET TAGS ('dbx_business_glossary_term' = 'Design Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `die_bank_replenishment_code` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Replenishment Plan ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `die_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Die Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `expected_good_die_qty` SET TAGS ('dbx_business_glossary_term' = 'Expected Good Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR|no_restriction');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `fab_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Work Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `is_mpw` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `is_nre` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charge (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Fabrication Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot_lot|expedite|standard|mpw|nre_pilot');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `process_technology_code` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `required_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Required Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `risk_acceptance_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4|CAMSTAR|SMARTFACTORY|SFDC|AGILE_PLM|MANUAL');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Wafer Unit Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `wsa_to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'Wsa To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ALTER COLUMN `yield_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_order_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'MPW Shuttle Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `primary_mpw_order_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Die Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `design_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `design_revision` SET TAGS ('dbx_business_glossary_term' = 'Design Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `die_count` SET TAGS ('dbx_business_glossary_term' = 'Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `die_quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity Delivered');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `die_quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity Ordered');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `itar_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_order_number` SET TAGS ('dbx_business_glossary_term' = 'Mpw Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_order_status` SET TAGS ('dbx_business_glossary_term' = 'Mpw Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_program_type` SET TAGS ('dbx_business_glossary_term' = 'MPW Program Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_program_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|academic|government|internal');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_to_order` SET TAGS ('dbx_business_glossary_term' = 'Mpw To Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `mpw_to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'Mpw To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Nre Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `nre_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charge (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Placement Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_value_usd` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `order_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Die Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `reserved_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Reserved Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `reticle_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Reticle Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `reticle_slot_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Reticle Slot Area (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `reticle_slot_number` SET TAGS ('dbx_business_glossary_term' = 'Reticle Slot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `shuttle_run_date` SET TAGS ('dbx_business_glossary_term' = 'Shuttle Run Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `tapeout_deadline` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Deadline Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `tapeout_received_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Die Unit Price (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `wafer_start_date_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `wafer_start_date_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ALTER COLUMN `yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_order_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `primary_die_order_id` SET TAGS ('dbx_business_glossary_term' = 'Die Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `allocated_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|inventory_shortage|quality_hold|export_hold|duplicate_order|end_of_life');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_order_number` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_order_status` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_to_order` SET TAGS ('dbx_business_glossary_term' = 'Die Bank To Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_bank_to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'Die Bank To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_form` SET TAGS ('dbx_business_glossary_term' = 'Die Form');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_form` SET TAGS ('dbx_value_regex' = 'bare_die|wafer|singulated_kgd|tape_and_reel');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_part_number` SET TAGS ('dbx_business_glossary_term' = 'Die Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `die_revision` SET TAGS ('dbx_business_glossary_term' = 'Die Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|engineering');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `kgd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Kgd Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Order Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `osat_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Work Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `packaging_instruction_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Instruction ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `requested_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `shipped_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ALTER COLUMN `wafer_fab_site` SET TAGS ('dbx_business_glossary_term' = 'Wafer Fabrication (FAB) Site');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `delivery_ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `primary_delivery_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Item ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-From Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `to_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'To Order Line Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'tape_and_reel|tray|tube|bulk|waffle_pack|wafer');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `primary_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Location Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'tape_and_reel|jedec_tray|tube|waffle_pack|bulk|wafer_carrier');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP-[0-9]{10}$');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `backlog_position_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `primary_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ALTER COLUMN `wafer_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `allocation_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `primary_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Line Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_lot|packaged_goods_lot|mpw_lot');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `osat_site_code` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_amended_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `parent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `allocation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocation Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amended_field_name` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^AMD-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|applied|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'quantity_change|date_push_out|date_pull_in|cancellation|price_revision|product_substitution');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'L1_sales_rep|L2_sales_manager|L3_vp_sales|L4_finance|L5_executive');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `chips_act_order_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Order Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `customer_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `delivery_date_original` SET TAGS ('dbx_business_glossary_term' = 'Original Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `delivery_date_revised` SET TAGS ('dbx_business_glossary_term' = 'Revised Confirmed Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Dispute Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `export_control_review_required` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `old_value` SET TAGS ('dbx_business_glossary_term' = 'Old Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `pcn_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `quantity_original` SET TAGS ('dbx_business_glossary_term' = 'Original Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `quantity_revised` SET TAGS ('dbx_business_glossary_term' = 'Revised Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'EA|KU|WAFER|DIE|REEL');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `revised_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `so_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) Line Item Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_SD|AGILE_PLM|SFDC|MANUAL');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `substitute_product_code` SET TAGS ('dbx_business_glossary_term' = 'Substitute Product Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `unit_price_original` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `unit_price_original` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `unit_price_revised` SET TAGS ('dbx_business_glossary_term' = 'Revised Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `unit_price_revised` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ALTER COLUMN `wafer_start_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` SET TAGS ('dbx_subdomain' = 'engineering_services');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_order_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `primary_nre_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engineering Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engineering Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `cancellation_clause` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Clause Terms');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'Creating Helpful Incentives to Produce Semiconductors (CHIPS) Act Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `completed_milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestone Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|proprietary|highly_confidential');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Contract Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Contract Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_price|time_and_materials|milestone_based|cost_plus');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `deliverable_list` SET TAGS ('dbx_business_glossary_term' = 'Engineering Deliverable List');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `design_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Score');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `ip_core_list` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core List');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `kickoff_date` SET TAGS ('dbx_business_glossary_term' = 'Kickoff Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_order_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_order_number` SET TAGS ('dbx_value_regex' = '^NRE-[0-9]{8}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_order_status` SET TAGS ('dbx_business_glossary_term' = 'Nre Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_to_sales_order` SET TAGS ('dbx_business_glossary_term' = 'Nre To Sales Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `nre_type` SET TAGS ('dbx_value_regex' = 'mask_nre|design_nre|qualification_nre|tapeout_nre|ip_integration_nre|dft_nre');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Terms');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engineering Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engineering Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'milestone|percentage_of_completion|completed_contract');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `total_nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `total_nre_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Nre Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ALTER COLUMN `total_nre_value` SET TAGS ('dbx_business_glossary_term' = 'Total Nre Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` SET TAGS ('dbx_subdomain' = 'engineering_services');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` SET TAGS ('dbx_ssot_owner' = 'finance.finance_nre_milestone');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `order_nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Order Non-Recurring Engineering (NRE) Milestone Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `nre_order_id` SET TAGS ('dbx_business_glossary_term' = 'Nre Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `authoritative_finance_nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Finance Nre Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `acceptance_signoff_by` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Signoff By');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `acceptance_signoff_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `acceptance_signoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Signoff Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'not_billable|ready_to_bill|billed|paid|disputed');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `billing_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Trigger Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `customer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `deliverable_location` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Location');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `dependency_milestones` SET TAGS ('dbx_business_glossary_term' = 'Dependency Milestones');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `effort_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Effort Hours Actual');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `effort_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Effort Hours Planned');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `finance_nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Nre Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `finance_nre_milestone_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'design|verification|tapeout|silicon_validation|documentation|customer_acceptance');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `modification_reference` SET TAGS ('dbx_business_glossary_term' = 'Modification Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `revenue_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `rework_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'engineering_services');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis (FA) ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `primary_rma_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `tertiary_rma_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Closed Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[0-9]{8,12}$');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Material Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `receiving_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Request Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Carrier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_date` SET TAGS ('dbx_business_glossary_term' = 'Rma Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[0-9]{8,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|test_escape|customer_misuse');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `to_original_order` SET TAGS ('dbx_business_glossary_term' = 'To Original Order');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|LOT|KIT');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Blanket Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'scheduling_agreement|quantity_contract|value_contract|mpw_blanket|distributor_frame');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Approved Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_number` SET TAGS ('dbx_value_regex' = '^BO-[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `calloff_frequency` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Release Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `calloff_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|on_demand');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|rep_firm|oem|ems');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Weeks)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `ncnr_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Cancellable Non-Returnable (NCNR) Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `ncnr_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Cancellable Non-Returnable (NCNR) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Structure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_value_regex' = 'fixed|volume_tiered|time_tiered|milestone_tiered');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `product_part_number` SET TAGS ('dbx_business_glossary_term' = 'Product Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|REEL|TRAY');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `release_order_to_blanket` SET TAGS ('dbx_business_glossary_term' = 'Release Order To Blanket');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `sales_order_to_blanket` SET TAGS ('dbx_business_glossary_term' = 'Sales Order To Blanket');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `total_blanket_value` SET TAGS ('dbx_business_glossary_term' = 'Total Blanket Order Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `total_blanket_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `total_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `total_committed_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Order Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Owner ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `tertiary_order_escalation_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Owner ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `tertiary_order_escalation_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `tertiary_order_escalation_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `trade_compliance_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Hold Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `hold_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
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
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `quality_disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `quality_disposition_status` SET TAGS ('dbx_value_regex' = 'PENDING|USE_AS_IS|REWORK|SCRAP|RETURN_TO_SUPPLIER');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Release Approver Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `requested_release_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Hold Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold SLA Breach Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `source_system_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Hold Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ALTER COLUMN `wafer_start_impacted` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Impacted Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `carrier_pod_reference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Proof of Delivery (POD) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_channel` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Channel');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_channel` SET TAGS ('dbx_value_regex' = 'edi|portal|api|email|manual');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^DC-[0-9]{10}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|partially_confirmed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmed_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `confirmed_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Receipt Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditionally_accepted|pending_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_signoff_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Signoff Name');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_signoff_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_signoff_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `customer_signoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Signoff Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_performance_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_performance_code` SET TAGS ('dbx_value_regex' = 'on_time|early|late|partial|failed');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `device_revision` SET TAGS ('dbx_business_glossary_term' = 'Device Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity_shortage|wrong_part|damaged_goods|wrong_lot|labeling_error|none');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `export_control_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Verified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `goods_receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `invoice_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Release Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `invoice_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `package_count_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Package Count');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'carrier_pod|edi_856|customer_portal|manual|email_confirmation');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `proof_of_delivery_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Reference');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `proof_of_delivery_url` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Url');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `receiving_country_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `receiving_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `receiving_location_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `revenue_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `rma_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|REEL|WAFER|TRAY|TUBE|LOT');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Assignment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program ID');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assigned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Assigned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'manual|atp_auto|allocation_run|planner_override|system_transfer');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|allocated|shipped|cancelled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `certificate_of_conformance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (CoC) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `date_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-5][0-9]$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Grade');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|engineering_sample|qualification');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_lot|packaged_goods_lot|kgd_lot|mpw_lot');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `part_revision` SET TAGS ('dbx_business_glossary_term' = 'Part Revision');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `part_revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_value_regex' = 'accepted|conditionally_accepted|rejected|under_review|quarantined');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `quality_disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition Notes');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafers|dies|units|reels|trays');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `wafer_fab_site` SET TAGS ('dbx_business_glossary_term' = 'Wafer Fabrication (FAB) Site');
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
