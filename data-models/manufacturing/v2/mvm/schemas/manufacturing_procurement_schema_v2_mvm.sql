-- Schema for Domain: procurement | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`procurement` COMMENT 'Purchasing and sourcing domain managing purchase requisitions, RFQs, RFPs, purchase orders, vendor selection, contract management, supplier performance evaluation, sourcing strategy, spend analysis, and procurement compliance for direct materials, indirect materials, MRO supplies, and capital equipment via SAP Ariba.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Primary key for purchase_requisition',
    `asset_work_order_id` BIGINT COMMENT 'Foreign key linking to asset.asset_work_order. Business justification: Maintenance work orders drive material purchase requisitions for spare parts and services. Linking PR to the originating work order enables maintenance cost tracking, work order budget vs. actual repo',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Engineering Change Request triggers a purchase requisition for the affected component; linking enables traceability of component‑driven procurement.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Procurement requisitions are generated from Engineering Change Orders; linking provides audit of ECO‑driven spend.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: CAPITAL ACQUISITION: Requisition must reference the equipment record for traceability of requested capital assets.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Requisition approval checks material compliance against applicable regulatory requirements (e.g., hazardous substance rules).',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Field Service Order Parts Requisition: each requisition references the field service order it supports.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or item being requested. Links to the material master data in SAP MM or inventory management system. Null for service or non-stock requisitions.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP run creates purchase requisitions; the MRP run ID is required for the MRP Run to Requisition traceability report.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: In make-to-order manufacturing, a confirmed sales order intake directly triggers purchase requisitions for required materials. The existing PR→opportunity link covers pre-sales; this distinct link to ',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: In make-to-order manufacturing, a sales order line directly triggers a purchase requisition for materials/components (individual customer requirement). This link enables order-specific procurement tra',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Supply plan execution tracking: PRs are generated from supply plan requirements. Linking PR to supply_plan enables supply plan execution reporting — which supply plan requirements have been converted ',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Planned orders are converted to purchase requisitions; linking them enables the Planned Order Conversion audit.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.asset_pm_schedule. Business justification: Preventive maintenance schedules trigger advance purchase requisitions for required spare parts and materials. Linking PR to the PM schedule enables maintenance-driven procurement planning, schedule a',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the existing contract or blanket purchase order against which this requisition should be fulfilled. Null for non-contract purchases.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Service Management Parts Requisition process records the originating service request ID on each purchase requisition for traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for the Component Procurement Planning report linking requisitions to the final product SKU they support, enabling traceability from requisition to product.',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Source determination audit: PR source determination uses sourcing rules to identify the correct supplier/source. The PR has a source_determination_indicator column confirming this process exists. Link',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Requisition planning specifies target storage location for incoming material; needed for inbound logistics allocation and warehouse capacity reports.',
    `approval_level_required` STRING COMMENT 'Number of approval levels required for this requisition based on value thresholds and organizational policy. Higher values require more senior approvals.',
    `approved_date` DATE COMMENT 'Date when the purchase requisition received final approval and became ready for sourcing. Null if not yet approved.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this requisition requires special compliance review (e.g., environmental, safety, export control). True if compliance review is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP). Used for multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition (quantity × estimated unit price). Used for budget control and approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service. Used for budget estimation and approval thresholds. Actual price is determined during sourcing and PO creation.',
    `justification_notes` STRING COMMENT 'Business justification or rationale provided by the requestor for the purchase. Required for high-value or non-standard requisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated. Tracks changes throughout the approval and sourcing lifecycle.',
    `mrp_controller` STRING COMMENT 'MRP controller responsible for material planning and requisition generation for production materials. Used for MRP-driven procurement.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where the material or service is required. Used for delivery planning and inventory allocation in SAP PP.. Valid values are `^PLT-[0-9]{4}$`',
    `pr_date` DATE COMMENT 'Date when the purchase requisition was created or submitted. Represents the principal business event timestamp for the requisition initiation.',
    `pr_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Typically system-generated in SAP Ariba or SAP MM.. Valid values are `^PR-[0-9]{10}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the procure-to-pay workflow. Tracks progression from draft through approval, sourcing, and conversion to purchase order. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|sourcing_assigned|po_created|cancelled|closed — 9 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the purchase requisition based on the nature of the procurement: direct materials for production, indirect materials for operations, MRO (Maintenance, Repair, and Operations) supplies, capital equipment (CapEx), services, or subcontracting work.. Valid values are `direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting`',
    `priority_code` STRING COMMENT 'Priority level of the purchase requisition. Urgent and emergency priorities expedite approval and sourcing processes.. Valid values are `low|normal|high|urgent|emergency`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for sourcing this requisition. Used for workload distribution and supplier relationship management.. Valid values are `^PG-[0-9]{3}$`',
    `purchasing_organization_code` STRING COMMENT 'Code identifying the purchasing organization responsible for procurement activities. Defines the organizational unit for supplier contracts and purchase orders.. Valid values are `^PO-[0-9]{4}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the material or service being requested. Expressed in the unit of measure specified in the UOM field.',
    `rejected_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition. Used for audit trail and process improvement.',
    `requestor_department` STRING COMMENT 'Department or organizational unit of the requestor. Used for spend analysis and budget allocation tracking.',
    `requestor_name` STRING COMMENT 'Full name of the employee who created the purchase requisition. Captured for audit trail and approval workflow visibility.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, supplies, or services must be delivered to meet operational or production requirements. Used for MRP (Material Requirements Planning) scheduling and supplier lead time calculation.',
    `source_determination_indicator` STRING COMMENT 'Indicates how the supplier source should be determined: automatic sourcing via system rules, manual buyer selection, contract-based assignment, or preferred supplier list.. Valid values are `automatic|manual|contract_based|preferred_supplier`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity. Standard units include EA (each), KG (kilogram), L (liter), M (meter), HR (hour), etc. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|HR|SET|BOX|ROLL|SHEET — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Master record for internal purchase requisition (PR) initiated by a department or MRP run. Captures the request for direct materials, indirect materials, MRO supplies, or capital equipment before a purchase order is raised. Tracks requestor, cost center, required delivery date, material/service description, estimated value, approval status, and sourcing assignment. Serves as the originating document in the procure-to-pay cycle.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: REQUIRED: PO delivery planning tracks which customer site receives purchased goods; used in site‑level inventory and cost reports.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: REQUIRED: Drop‑ship to customer needs PO delivery address for logistics and billing reports.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where goods will be delivered.',
    `asset_work_order_id` BIGINT COMMENT 'Foreign key linking to asset.asset_work_order. Business justification: Purchase orders for maintenance parts and services are directly linked to the work order that triggered them. This supports maintenance cost accounting, CAPEX/OPEX classification, and work order closu',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Purchase orders are raised against a specific BOM for a production run; linking supports BOM‑to‑PO cost tracking.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Purchase orders are issued to satisfy material requirements; the link supports the Material Requirement Fulfilment KPI.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP-to-PO traceability: procurement planners and supply chain auditors must trace which MRP run generated the demand that resulted in a purchase order. Standard manufacturing audit and exception manag',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Purchase orders are frequently issued as release orders against a master procurement contract or blanket purchase agreement. This FK links each PO to the governing contract, enabling contract consumpt',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ or RFP that preceded this purchase order in the sourcing process.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Needed for Order‑Driven Procurement process where purchase orders are tied to the specific product SKU being manufactured, supporting make‑to‑order execution.',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Sourcing compliance audit: sourcing rules govern which supplier and terms apply when a PO is created. Linking PO to sourcing_rule enables compliance reporting (was the correct sourcing rule applied?) ',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific delivery address or warehouse location for goods receipt.',
    `acknowledgement_date` DATE COMMENT 'Date when the supplier acknowledged the purchase order.',
    `acknowledgement_status` STRING COMMENT 'Status indicating whether the supplier has acknowledged receipt and acceptance of the purchase order.. Valid values are `not_sent|sent|acknowledged|rejected|partially_acknowledged`',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the purchase order.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received and invoices processed.',
    `company_code` STRING COMMENT 'Financial accounting organizational unit representing the legal entity for this purchase order.. Valid values are `^[A-Z0-9]{4}$`',
    `compliance_status` STRING COMMENT 'Status indicating whether the purchase order meets all applicable procurement compliance policies and regulatory requirements.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery of goods or completion of services.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_status` STRING COMMENT 'Status indicating the extent to which ordered goods have been received against this purchase order.. Valid values are `not_received|partially_received|fully_received|over_received`',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where risk and cost transfer occurs.',
    `invoice_receipt_status` STRING COMMENT 'Status indicating the extent to which supplier invoices have been received and matched against this purchase order.. Valid values are `not_received|partially_invoiced|fully_invoiced|over_invoiced`',
    `material_category` STRING COMMENT 'High-level classification of the type of materials or services being procured. Direct materials are used in production, indirect materials support operations, MRO is maintenance/repair/operations supplies.. Valid values are `direct_material|indirect_material|mro|capital_equipment|services|subcontracting`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was last modified.',
    `net_po_value` DECIMAL(18,2) COMMENT 'Net total value of the purchase order after taxes and all adjustments.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or comments related to the purchase order.',
    `payment_terms` STRING COMMENT 'Code representing the agreed payment terms with the supplier (e.g., Net 30, Net 60, 2/10 Net 30).. Valid values are `^[A-Z0-9]{4,10}$`',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for the transaction.',
    `po_number` STRING COMMENT 'Externally-known unique business identifier for the purchase order. Used in supplier communications and invoice matching.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|in_progress|partially_received|fully_received|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type. Standard for one-time orders, blanket for recurring orders with release schedules, framework for long-term agreements, subcontracting for external processing, consignment for supplier-owned inventory.. Valid values are `standard|blanket|framework|contract|subcontracting|consignment`',
    `priority` STRING COMMENT 'Business priority level assigned to the purchase order affecting processing and delivery urgency.. Valid values are `low|normal|high|urgent|critical`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this purchase order.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement activities. Represents the legal entity negotiating with suppliers.. Valid values are `^[A-Z0-9]{4,10}$`',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services.',
    `shipping_method` STRING COMMENT 'Mode of transportation specified for delivery of goods.. Valid values are `air|ocean|rail|truck|courier|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order including all line items before taxes and charges.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-based purchase orders, enabling cost tracking at the project task level.. Valid values are `^[A-Z0-9-.]{8,24}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional document representing a legally binding purchase order (PO) issued to a supplier. Captures PO number, supplier, plant/delivery location, payment terms, incoterms, total PO value, currency, PO type (standard, blanket, framework, subcontracting), approval status, and confirmation status. Central document in the procure-to-pay process linking requisitions to goods receipts and supplier invoices.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line_item product.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: In multi-line drop-ship or direct-delivery POs, individual line items ship to different customer addresses. The PO header already has a default address_id, but line-level ship-to address override is a',
    `engineering_bom_line_id` BIGINT COMMENT 'Foreign key linking to engineering.bom_line. Business justification: Order line items are derived from BOM lines during material planning; linking enables line‑level reconciliation.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being procured. Links to the specific product, component, or service being ordered.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Line-level MRP coverage: each PO line fulfills a specific material requirement from MRP. Line-level linkage enables precise MRP coverage reporting and partial fulfillment tracking. purchase_order link',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Line-level MRP pegging: individual PO line items trace to specific planned orders for demand-to-supply traceability at the line level. Standard MRP pegging report in manufacturing — which planned orde',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: PO line items have quality_inspection_required but no FK to the specification governing that inspection. Manufacturing receiving inspection checks incoming parts against the product specification. T',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Each PO line item traces back to the originating purchase requisition for procurement traceability and audit. In SAP, each PO line item carries a reference to the PR item that triggered it. This FK en',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: PO line items must specify the exact engineering revision being ordered — standard in aerospace/automotive manufacturing (AS9100, PPAP). po_line_item.manufacturer_part_number exists but cannot disting',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Line‑item costs must be allocated to a WBS element for earned‑value and cost‑control reporting; the existing wbs_element string is replaced by a FK.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: PO line items procure specific spare parts from the asset spare part catalog. This link enables spare parts procurement history, last purchase price updates, replenishment lead time validation, and AB',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Line item defines where received material will be stored; required for put‑away execution and inventory valuation per location.',
    `account_assignment_category` STRING COMMENT 'Classification determining how procurement costs are allocated in financial accounting (e.g., to cost center, asset, WBS element, or sales order).. Valid values are `cost_center|asset|project|sales_order|network|unknown`',
    `buyer_name` STRING COMMENT 'Name of the procurement professional responsible for sourcing and managing this purchase order line item.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price and line item value (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating this line item has been marked for deletion or cancellation. Prevents further goods receipt and invoice posting.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Used for MRP planning, production scheduling, and supplier performance tracking.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating the final invoice has been received and no further invoices are expected for this line item.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt is required for this line item. Determines three-way match requirements for invoice verification.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer (e.g., EXW, FOB, CIF, DDP).',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line item. Controls accounts payable processing workflow.',
    `item_category` STRING COMMENT 'Classification of the procurement item type. Determines procurement processing rules, inventory treatment, and account assignment requirements.. Valid values are `standard|consignment|subcontracting|service|stock_transfer|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was last updated or modified.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from open through receipt to closure.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer part number for the material. Used for quality assurance and technical specification verification.',
    `material_number` STRING COMMENT 'Business identifier for the material being procured. The externally-known SKU or part number used in procurement documents and supplier communication.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total value of this line item calculated as (quantity_ordered / price_unit) * net_price. Excludes taxes and freight charges.',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure before taxes and additional charges. Used to calculate line item total value.',
    `open_quantity` DECIMAL(18,2) COMMENT 'Outstanding quantity still to be delivered, calculated as quantity_ordered minus quantity_received. Used for supplier follow-up and expediting.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may over-deliver beyond the ordered quantity without requiring approval.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility where the material will be received and consumed. Determines receiving location and inventory posting.',
    `price_unit` STRING COMMENT 'The quantity for which the net price is valid (e.g., price per 1, per 100, per 1000 units). Used in unit price calculation.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming quality inspection is mandatory before goods receipt posting for this line item.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the supplier against this line item to date. Used for invoice verification and payment processing.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units being procured on this line item. Used for goods receipt matching and invoice verification.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Used for partial delivery tracking and open quantity calculation.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this line item.',
    `shipping_instruction` STRING COMMENT 'Special instructions for packaging, labeling, or delivery requirements specific to this line item.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item.',
    `source_of_supply` STRING COMMENT 'Classification of the procurement source type. Determines procurement processing logic and inventory valuation method.. Valid values are `external|internal|subcontract|consignment`',
    `supplier_material_number` STRING COMMENT 'The suppliers own part number or SKU for the material being procured. Used for supplier communication and catalog matching.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on tax code and net order value.',
    `tax_code` STRING COMMENT 'Tax classification code determining applicable tax rates and tax jurisdiction for this procurement line item.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may under-deliver below the ordered quantity without penalty or rejection.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is expressed (e.g., EA, KG, M, L, HR). Must align with material master and supplier agreement.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material, service, or SKU being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, storage location, account assignment (cost center, WBS element, asset), and goods receipt indicator. Enables granular spend tracking, partial delivery management, and three-way match at the item level.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: RFQs in manufacturing are issued against specific engineering specifications so suppliers quote to exact technical requirements. Procurement teams attach the spec to the RFQ during the sourcing event.',
    `location_id` BIGINT COMMENT 'Identifier of the originating purchase requisition that triggered this RFQ. Links sourcing activity back to internal demand.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: An RFQ is typically initiated to fulfill a purchase requisition that cannot be sourced from an existing contract or approved supplier list. Linking rfq.purchase_requisition_id → purchase_requisition e',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: RFQs in manufacturing are issued for specific purchased SKUs. Sourcing teams need to identify which SKU is being sourced to evaluate supplier quotes, compare lead times, and feed supplier selection de',
    `approval_date` DATE COMMENT 'Date when the RFQ was approved for issuance by the authorized approver. Part of procurement governance audit trail.',
    `approval_status` STRING COMMENT 'Status of internal approval workflow for issuing this RFQ. Ensures procurement governance and authorization controls are met before publication.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or procurement authority who approved the issuance of this RFQ. Supports audit trail and compliance reporting.',
    `award_date` DATE COMMENT 'Date when the RFQ was awarded to one or more suppliers and purchase orders or contracts were issued. Null if not yet awarded.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond or financial guarantee required from suppliers, if applicable. Null if no bid bond is required.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether suppliers are required to submit a bid bond or financial guarantee as part of their quotation. Common for high-value capital equipment or construction projects.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the RFQ was cancelled, if applicable. Supports root cause analysis and process improvement.',
    `commodity_code` STRING COMMENT 'Standardized commodity or material group code identifying the category of goods or services being sourced. May align with UNSPSC or internal taxonomy.. Valid values are `^[A-Z0-9]{6,12}$`',
    `commodity_description` STRING COMMENT 'Human-readable description of the commodity or material group associated with this RFQ.',
    `confidentiality_agreement_required` BOOLEAN COMMENT 'Indicates whether suppliers must sign a non-disclosure agreement (NDA) or confidentiality agreement before accessing RFQ details.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ record was first created in the system. Part of audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value and supplier quotations. Ensures consistent financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Destination site, plant, warehouse, or facility where materials or equipment are to be delivered. May reference a specific location code or address.',
    `delivery_terms` STRING COMMENT 'International Commercial Terms (Incoterms) specifying delivery responsibilities, risk transfer, and cost allocation between buyer and supplier.. Valid values are `EXW|FOB|CIF|DDP|DAP|FCA`',
    `rfq_description` STRING COMMENT 'Detailed description of the materials, services, or capital equipment being sourced, including specifications, scope of work, and any special requirements.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the procurement covered by this RFQ. Used for spend analysis and sourcing strategy planning.',
    `evaluation_criteria` STRING COMMENT 'Documented criteria and weighting factors used to evaluate and score supplier responses. May include price, quality, delivery, technical capability, and sustainability factors.',
    `invited_supplier_count` STRING COMMENT 'Number of suppliers invited to participate in this RFQ. Supports competitive sourcing analysis and supplier engagement metrics.',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued and published to invited suppliers. Marks the start of the supplier response period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ record was last updated. Supports change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or internal notes related to this RFQ. Not typically shared with suppliers.',
    `payment_terms` STRING COMMENT 'Standard payment terms communicated to suppliers in the RFQ, such as Net 30, Net 60, or early payment discount terms.',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement spend category. Aligns with organizational spend taxonomy and sourcing strategy.. Valid values are `direct_materials|indirect_materials|mro_supplies|capital_equipment|services|logistics`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or procurement team responsible for managing this RFQ. Aligns with SAP MM purchasing organization structure.. Valid values are `^[A-Z0-9]{3,6}$`',
    `quality_certification_required` STRING COMMENT 'List of quality certifications or standards that suppliers must hold or materials must meet, such as ISO 9001, ISO 14001, UL, CE marking, or industry-specific certifications.',
    `requested_delivery_date` DATE COMMENT 'Target date by which the buyer requires delivery of the materials or completion of services. Used to assess supplier lead time capability.',
    `response_opening_date` TIMESTAMP COMMENT 'Date and time when submitted supplier responses will be opened and made available for evaluation. Used in sealed-bid scenarios.',
    `response_received_count` STRING COMMENT 'Number of valid quotations received from suppliers by the submission deadline. Used to assess competitive response rate.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ document, externally visible to suppliers and internal stakeholders. Typically follows organizational numbering convention.. Valid values are `^RFQ-[0-9]{8,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Tracks progression from creation through supplier response collection to award or cancellation. [ENUM-REF-CANDIDATE: draft|published|open|closed|awarded|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `sourcing_event_type` STRING COMMENT 'Classification of the sourcing mechanism used for this RFQ. Determines bidding rules, evaluation process, and supplier interaction model.. Valid values are `standard_rfq|reverse_auction|sealed_bid|two_stage|framework_agreement|spot_buy`',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their quotations. No late submissions are typically accepted after this timestamp.',
    `sustainability_criteria` STRING COMMENT 'Environmental, social, and governance (ESG) criteria or sustainability requirements that suppliers must address in their quotations, such as carbon footprint, ethical sourcing, or circular economy practices.',
    `technical_specification_required` BOOLEAN COMMENT 'Indicates whether suppliers must provide detailed technical specifications, certifications, or compliance documentation as part of their response.',
    `title` STRING COMMENT 'Descriptive title or subject line of the RFQ, summarizing the procurement need or sourcing event.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation document issued to one or more suppliers to solicit competitive pricing for materials, services, or capital equipment. Captures RFQ number, sourcing event type, commodity category, submission deadline, evaluation criteria, invited supplier list, bid bond requirements, and status. Supports competitive sourcing and strategic procurement decisions for direct and indirect categories.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` (
    `supplier_quotation_id` BIGINT COMMENT 'Unique identifier for the supplier quotation record. Primary key.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Supplier quotations must demonstrate technical compliance against the engineering specification. Procurement engineers validate quoted items against the spec during bid evaluation. supplier_quotation.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or service being quoted. Links to the material master record.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: An awarded supplier quotation (award_flag = true) results in a procurement contract or framework agreement. Linking the winning quotation to the resulting contract enables contract origin traceability',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order created as a result of awarding this quotation.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: A supplier quotation is formally submitted in response to an RFQ. This is the foundational procurement relationship linking the solicitation event to the suppliers response. Without this FK, supplier',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Quotation evaluation includes verifying that quoted items have required product certifications per regulatory standards.',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Sourcing compliance analysis: supplier quotations are evaluated against sourcing rules (preferred supplier, allocation %, MOQ). Linking quotation to sourcing_rule enables sourcing compliance analysis ',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Supplier quotations are obtained for specific spare parts during sourcing events. Linking quotation to spare_part enables price benchmarking against standard_cost and last_purchase_price, preferred ve',
    `award_date` DATE COMMENT 'Date when the quotation was officially awarded and the supplier was notified of the purchase order.',
    `award_flag` BOOLEAN COMMENT 'Indicates whether this quotation was selected and awarded a purchase order (True) or not (False).',
    `bid_rank` STRING COMMENT 'Numerical ranking of this quotation relative to other quotations received for the same sourcing event, based on evaluation criteria (1 = best).',
    `commercial_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quotation meets all commercial terms and conditions defined in the sourcing event (True) or has deviations (False).',
    `commercial_compliance_notes` STRING COMMENT 'Detailed notes explaining any commercial deviations, exceptions, or clarifications regarding payment terms, delivery terms, or other commercial conditions.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the material or product will be manufactured or sourced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quotation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted price (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Destination location or plant code where the supplier will deliver the goods.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by the supplier off the list price or baseline price.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quotation meets environmental and sustainability requirements (e.g., RoHS, REACH, conflict minerals).',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Weighted evaluation score assigned to the quotation based on predefined criteria (price, quality, delivery, service). Scale typically 0-100.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Shipping and freight charges quoted by the supplier for delivery to the specified location.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the quotation record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Number of calendar days from purchase order placement to delivery, as committed by the supplier.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials for procurement and reporting purposes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered for the supplier to honor the quoted price and terms.',
    `payment_terms` STRING COMMENT 'Payment terms offered by the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due and any early payment discounts.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the material will be delivered and consumed.. Valid values are `^[A-Z0-9]{4,10}$`',
    `purchasing_group` STRING COMMENT 'Buyer group or commodity team responsible for the specific material category being quoted.. Valid values are `^[A-Z0-9]{3,10}$`',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities and supplier negotiations for this quotation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_certification` STRING COMMENT 'Quality certifications or standards compliance declared by the supplier (e.g., ISO 9001, AS9100, IATF 16949).',
    `quotation_number` STRING COMMENT 'Business identifier for the supplier quotation, typically assigned by the supplier or sourcing system. Externally visible reference number used in communications and documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the supplier quotation in the sourcing workflow.. Valid values are `draft|submitted|under_review|awarded|rejected|withdrawn`',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure quoted by the supplier for the material or service.',
    `rejection_reason` STRING COMMENT 'Explanation for why the quotation was rejected, if applicable. Used for supplier feedback and continuous improvement.',
    `remarks` STRING COMMENT 'Additional comments, clarifications, or special conditions provided by the supplier or procurement team regarding the quotation.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted the quotation to the sourcing event.',
    `supplier_reference_number` STRING COMMENT 'Suppliers internal reference or quotation number for tracking and correspondence purposes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in or added to the quoted price, based on applicable tax jurisdiction.',
    `technical_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quotation meets all technical specifications and requirements defined in the sourcing event (True) or has deviations (False).',
    `technical_compliance_notes` STRING COMMENT 'Detailed notes explaining any technical deviations, exceptions, or clarifications regarding compliance with specifications.',
    `total_cost_of_ownership` DECIMAL(18,2) COMMENT 'Comprehensive cost evaluation including quoted price, freight, taxes, quality costs, and other factors used for supplier comparison.',
    `total_quoted_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the quotation, calculated as quoted unit price multiplied by requested quantity.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,6}$`',
    `valid_from_date` DATE COMMENT 'Start date of the quotation validity period. The date from which the quoted prices and terms become effective.',
    `valid_to_date` DATE COMMENT 'End date of the quotation validity period. The date after which the quoted prices and terms expire.',
    `warranty_period_months` STRING COMMENT 'Duration of warranty coverage in months offered by the supplier for the quoted material or service.',
    CONSTRAINT pk_supplier_quotation PRIMARY KEY(`supplier_quotation_id`)
) COMMENT 'Formal price quotation submitted by a supplier in response to an RFQ or RFP sourcing event. Captures quotation number, supplier reference, validity period, quoted unit price, lead time, minimum order quantity, payment terms, incoterms, technical compliance notes, and bid ranking. Enables side-by-side supplier comparison and award decision documentation. Links to the originating sourcing event and the awarded purchase order.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.asset_plant. Business justification: Procurement contracts in manufacturing are scoped to specific plants (purchasing organization/plant hierarchy). Plant-level contract management, spend analytics, and contract compliance reporting all ',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: CONTRACT MANAGEMENT: Contracts for control system supply/maintenance must reference the specific control system asset.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Long-term procurement contracts bind suppliers to deliver components conforming to a specific engineering specification. procurement_contract.quality_requirements references spec compliance; the FK an',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supports Family‑Level Supply Contract Management allowing contracts to be associated with product families for volume‑discount negotiations.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Procurement contracts in manufacturing are frequently negotiated for specific purchased component SKUs (not just product families). Contract pricing, minimum order quantities, and lead times are SKU-s',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Contract-to-sourcing-strategy alignment: procurement contracts formalize sourcing rules. Linking contract to sourcing_rule enables sourcing strategy compliance reporting and contract-vs-rule alignment',
    `amendment_count` STRING COMMENT 'Total number of amendments or change orders issued against this contract since its original approval.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiration if not explicitly terminated. True for auto-renewing contracts, False otherwise.',
    `compliance_status` STRING COMMENT 'Current compliance state of the contract with internal procurement policies, regulatory requirements, and governance standards. Compliant indicates full adherence, non-compliant flags violations, under review indicates active audit, waived indicates approved exception.. Valid values are `compliant|non_compliant|under_review|waived`',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes confidentiality or non-disclosure provisions protecting proprietary information. True if confidentiality terms are present, False otherwise.',
    `contract_description` STRING COMMENT 'Detailed narrative description of the scope, purpose, and key terms of the procurement contract.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the procurement contract for easy identification and reference.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, typically assigned by SAP Ariba or ERP system.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates initial creation, pending approval awaits authorization, active is in force, suspended is temporarily halted, expired has passed end date, terminated is cancelled before expiration, closed is completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Blanket PO for recurring purchases with predefined terms, scheduling agreement for delivery schedules, value contract for spend-based limits, quantity contract for volume-based commitments, framework agreement for multi-supplier arrangements, or master agreement for overarching terms.. Valid values are `blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Primary delivery destination or plant location for materials or services procured under this contract.',
    `effective_date` DATE COMMENT 'Date when the procurement contract becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the procurement contract term ends and is no longer in force. Nullable for open-ended contracts.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and supplier per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order release to delivery, as committed by the supplier in the contract.',
    `material_category` STRING COMMENT 'High-level classification of materials or services covered by this contract. Direct materials are production inputs, indirect materials are non-production consumables, MRO supplies are maintenance/repair/operations items, capital equipment are fixed assets, services are labor or professional services.. Valid values are `direct_materials|indirect_materials|mro_supplies|capital_equipment|services`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity per release or purchase order required by the supplier under this contract. Nullable if no MOQ is specified.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated in the contract (e.g., Net 30, Net 60, 2/10 Net 30 for early payment discounts).',
    `penalty_clause` STRING COMMENT 'Description of financial penalties or liquidated damages applicable for supplier non-compliance with contract terms, SLA breaches, or quality failures.',
    `price_deescalation_mechanism` STRING COMMENT 'Formula or methodology for reducing contract prices based on volume commitments, market conditions, or continuous improvement targets.',
    `price_escalation_mechanism` STRING COMMENT 'Formula or methodology for adjusting contract prices over time based on indices (e.g., CPI, commodity indices), exchange rates, or negotiated percentage increases.',
    `purchasing_group` STRING COMMENT 'Buyer group or category team within the purchasing organization responsible for this contract, typically aligned to commodity or material category.',
    `purchasing_organization` STRING COMMENT 'Organizational unit or division responsible for negotiating and executing this procurement contract within the ERP system.',
    `quality_requirements` STRING COMMENT 'Specific quality standards, certifications, inspection criteria, and acceptance testing requirements mandated in the contract (e.g., ISO 9001, PPAP, APQP, specific Cpk targets).',
    `quantity_unit` STRING COMMENT 'Unit of measure for target quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours).',
    `release_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity already released or called off against this contract through purchase orders or delivery schedules.',
    `release_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value already released or spent against this contract through purchase orders.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity still available for release under this contract, calculated as target quantity minus release quantity.',
    `remaining_value` DECIMAL(18,2) COMMENT 'Monetary value still available for release under this contract, calculated as total contract value minus release value.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto renewal is enabled. Nullable if auto renewal is not applicable.',
    `sla_terms` STRING COMMENT 'Service level commitments and performance targets defined in the contract, such as lead time, on-time delivery rate, quality standards, and response times.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned or committed quantity of materials or services to be procured under this contract for quantity-based agreements. Nullable for value-based contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract before expiration.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this procurement contract for value-based contracts, or estimated total spend for quantity-based contracts.',
    `warranty_terms` STRING COMMENT 'Warranty coverage and duration provided by the supplier for materials or services under this contract, including defect remediation and replacement terms.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master procurement contract or framework agreement established with a supplier for recurring supply of materials or services over a defined term. Captures contract number, contract type (blanket PO, scheduling agreement, value contract, quantity contract), effective/expiration dates, total contract value, target/release quantities, auto-renewal flag, SLA terms, penalty clauses, price escalation/de-escalation mechanisms, compliance status, and contract owner. Distinct from sales contracts owned by the sales domain. Supports contract coverage KPI tracking and maverick spend identification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt document. Primary key for the procurement goods receipt entity.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In make-to-order and drop-ship manufacturing, goods are received at or dispatched directly to a specific customer account site. Linking goods receipt to account_site enables site-level delivery confir',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: GOODS RECEIPT: Receiving equipment updates the equipment register for inventory, commissioning, and warranty start dates.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or service received. Links to the material master for product specifications and inventory management.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP receipt confirmation: goods receipts close out planned orders in MRP (scheduled receipts). Linking GR to planned_order enables MRP receipt confirmation reporting — confirming planned supply has be',
    `po_line_item_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level three-way matching.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the GR to the originating procurement document.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Goods receipts must record which engineering revision was physically received — essential for manufacturing traceability, PPAP compliance, and ECO change management. If a component revision changes mi',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Goods receipts for spare parts must update the spare part catalog (last_received_date, stock levels, last_purchase_price). Linking GR to spare_part enables automatic spare parts inventory replenishmen',
    `stock_location_id` BIGINT COMMENT 'Identifier of the specific storage location within the warehouse where the received goods are placed. Enables precise inventory tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or receiving facility where the goods were physically received.',
    `accounting_document_number` STRING COMMENT 'The financial accounting document number generated when the goods receipt value is posted to the General Ledger (GL). Links the GR to financial transactions.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the goods receipt value is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether the received goods were damaged during transit or delivery. True if damage was observed; false otherwise. Triggers quality hold and supplier notification.',
    `delivery_date` DATE COMMENT 'The actual date on which the goods were physically delivered to the receiving location. Used for supplier performance evaluation and lead time analysis.',
    `delivery_note_number` STRING COMMENT 'The delivery note or packing slip number provided by the supplier. Used to match physical delivery documentation with the goods receipt record.',
    `document_date` DATE COMMENT 'The date printed on the goods receipt document. May differ from the posting date for backdated or forward-dated transactions.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for tracking, auditing, and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `expiration_date` DATE COMMENT 'The date on which the received material expires or becomes unusable. Critical for perishable goods, chemicals, and materials with shelf-life constraints.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the GR is in draft, posted to inventory, blocked for quality issues, cancelled, or reversed.. Valid values are `draft|posted|blocked|cancelled|reversed`',
    `gr_ir_clearing_status` STRING COMMENT 'Indicates the clearing status of the GR/IR account in accounts payable. Open means no invoice received; partially cleared means partial invoice match; fully cleared means invoice fully matched and cleared.. Valid values are `open|partially_cleared|fully_cleared`',
    `invoice_verification_flag` BOOLEAN COMMENT 'Indicates whether an invoice has been received and verified against this goods receipt as part of the three-way match process (PO-GR-Invoice). True if invoice verified; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated. Used for change tracking and audit trail purposes.',
    `manufacturing_date` DATE COMMENT 'The date on which the received material was manufactured by the supplier. Used for shelf-life calculation and quality tracking.',
    `material_document_number` STRING COMMENT 'The SAP material document number generated when the goods receipt is posted. Links the GR to inventory movements and financial postings in the ERP system.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'The fiscal year in which the material document was created. Used in combination with material document number for unique identification in SAP.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction (e.g., 101 for GR against PO, 501 for GR without PO). Drives inventory and financial posting logic.. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the receiving personnel regarding the condition of the goods, packaging issues, or any discrepancies observed during receipt.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity originally ordered on the purchase order line. Used to calculate over-delivery or under-delivery variances.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to the inventory and financial systems. This is the accounting date for inventory valuation and General Ledger (GL) posting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released to unrestricted inventory. True if inspection is required; false otherwise.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for the received goods. Determines whether goods can be moved to unrestricted stock or must remain in quality hold.. Valid values are `not_required|pending|in_progress|passed|failed|waived`',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between the received quantity and the ordered quantity. Positive values indicate over-delivery; negative values indicate under-delivery.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units physically received and recorded in this goods receipt. Used for inventory update and three-way match validation.',
    `receiving_person_name` STRING COMMENT 'The name of the individual who physically received and inspected the goods. Used for accountability and audit trail purposes.',
    `return_authorization_flag` BOOLEAN COMMENT 'Indicates whether a Return Material Authorization (RMA) has been initiated for the received goods due to quality issues, damage, or incorrect delivery. True if RMA initiated; false otherwise.',
    `reversal_date` DATE COMMENT 'The date on which this goods receipt was reversed. Used for audit trail and financial period reconciliation.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt has been reversed. Links to the cancelling document for audit trail.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed; false otherwise. Reversed GRs do not contribute to inventory or financial balances.',
    `serial_number` STRING COMMENT 'The unique serial number of the received item, applicable for serialized inventory such as equipment, tools, or high-value components.',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Unrestricted stock is available for use; quality inspection and blocked stock are not.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilogram, L for liter). Must align with the purchase order and material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods received, calculated as received quantity multiplied by the purchase order unit price. Posted to inventory and General Ledger (GL) accounts.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt (GR) document recorded when materials or services are physically received from a supplier against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, unit of measure, storage location, batch number, quality inspection flag, and GR/IR clearing status. Triggers inventory update and initiates the three-way match process (PO–GR–Invoice) for accounts payable.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `asset_work_order_id` BIGINT COMMENT 'Foreign key linking to asset.asset_work_order. Business justification: Supplier invoices for maintenance services and parts are matched to work orders for cost capture and CAPEX/OPEX classification. This three-way match (PO–GR–Invoice) extended to work order is required ',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched in the three-way match process (PO–GR–Invoice).',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated, typically the invoice date or goods receipt date.',
    `blocking_reason` STRING COMMENT 'The reason why the invoice is blocked for payment, such as price variance, quantity variance, or quality issues.',
    `company_code` STRING COMMENT 'The company code in the ERP system to which this invoice is assigned.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied to the invoice, such as early payment discounts or volume discounts.',
    `document_date` DATE COMMENT 'The date recorded on the invoice document, which may differ from the invoice date or posting date.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied for currency conversion if the invoice currency differs from the company currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice is posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice is posted for accounting purposes.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charges included in the invoice.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and adjustments.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the supplier. This is the principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the supplier. This is the externally-known business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: parked|posted|blocked|cleared|cancelled|rejected|pending_approval — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type or category of the invoice document.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment|final`',
    `material_category` STRING COMMENT 'The category of materials or services covered by this invoice.. Valid values are `direct_material|indirect_material|mro_supplies|capital_equipment|services`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total invoice amount after all taxes, discounts, and adjustments. This is the amount payable to the supplier.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the invoice is blocked for payment.',
    `payment_date` DATE COMMENT 'The actual date the payment was made to the supplier.',
    `payment_due_date` DATE COMMENT 'The date by which payment must be made to the supplier according to the payment terms.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the supplier.. Valid values are `wire_transfer|ach|check|credit_card|electronic_payment|letter_of_credit`',
    `payment_reference_number` STRING COMMENT 'The reference number assigned to the payment transaction when the invoice is paid.',
    `payment_status` STRING COMMENT 'Current payment status indicating whether the invoice has been paid.. Valid values are `unpaid|partially_paid|fully_paid|overdue|on_hold`',
    `payment_terms` STRING COMMENT 'The agreed payment terms between the buyer and supplier, such as Net 30, Net 60, or 2/10 Net 30.',
    `plant_code` STRING COMMENT 'The plant or facility code where the goods or services were received.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial accounting system.',
    `purchasing_group` STRING COMMENT 'The purchasing group or buyer responsible for the procurement transaction.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities related to this invoice.',
    `reference` STRING COMMENT 'Additional reference number or code provided by the supplier on the invoice document for their internal tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice, including VAT, sales tax, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax code applied to the invoice for tax calculation purposes.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or authority under which the invoice tax is calculated.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match verification process comparing purchase order, goods receipt, and invoice.. Valid values are `matched|not_matched|partially_matched|override`',
    `tolerance_check_status` STRING COMMENT 'Result of the tolerance check comparing invoice amounts against purchase order and goods receipt amounts.. Valid values are `passed|failed|warning|not_checked`',
    `tolerance_variance_amount` DECIMAL(18,2) COMMENT 'The amount by which the invoice differs from the expected amount based on the purchase order and goods receipt.',
    `tolerance_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between the invoice amount and the expected amount.',
    `wbs_element` STRING COMMENT 'The WBS element for project-related invoices, linking the invoice to a specific project phase or deliverable.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the invoice payment.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier invoice document received from a vendor and processed for three-way match verification (PO–GR–Invoice). Captures invoice number, supplier invoice reference, invoice date, posting date, gross amount, tax amount, currency, payment due date, payment terms, invoice status (parked, posted, blocked, cleared), and tolerance check results. Serves as the SSOT for procurement-side payables within the procure-to-pay cycle.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'sourcing_requests');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_level_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Level Required');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Justification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^PLT-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^PG-[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Rejected Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_business_glossary_term' = 'Source Determination Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_value_regex' = 'automatic|manual|contract_based|preferred_supplier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|partially_acknowledged');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_received|fully_received|over_received');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_invoiced|fully_invoiced|over_invoiced');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro|capital_equipment|services|subcontracting');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `net_po_value` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Order (PO) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|contract|subcontracting|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{8,24}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|asset|project|sales_order|network|unknown');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|stock_transfer|third_party');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `shipping_instruction` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instruction');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'external|internal|subcontract|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_requests');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `confidentiality_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|DAP|FCA');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `invited_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Supplier Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'direct_materials|indirect_materials|mro_supplies|capital_equipment|services|logistics');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `response_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Response Opening Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `response_received_count` SET TAGS ('dbx_business_glossary_term' = 'Response Received Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_type` SET TAGS ('dbx_value_regex' = 'standard_rfq|reverse_auction|sealed_bid|two_stage|framework_agreement|spot_buy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `sustainability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `technical_specification_required` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` SET TAGS ('dbx_subdomain' = 'sourcing_requests');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `supplier_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quotation ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `award_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `bid_rank` SET TAGS ('dbx_business_glossary_term' = 'Bid Rank');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `commercial_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `commercial_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Commercial Compliance Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|awarded|rejected|withdrawn');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `supplier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `technical_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `technical_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `total_cost_of_ownership` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Ownership (TCO)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `total_quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'sourcing_requests');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|waived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_materials|indirect_materials|mro_supplies|capital_equipment|services');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price De-escalation Mechanism');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Mechanism');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_business_glossary_term' = 'Release Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|blocked|cancelled|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt / Invoice Receipt (GR/IR) Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `return_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment|final');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro_supplies|capital_equipment|services');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_payment|letter_of_credit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|fully_paid|overdue|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Reference');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|not_matched|partially_matched|override');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_checked');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
