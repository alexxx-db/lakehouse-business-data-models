-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`procurement` COMMENT 'Purchasing and sourcing domain managing purchase requisitions, RFQs, RFPs, purchase orders, vendor selection, contract management, supplier performance evaluation, sourcing strategy, spend analysis, and procurement compliance for direct materials, indirect materials, MRO supplies, and capital equipment via SAP Ariba.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Primary key for purchase_requisition',
    `approval_workflow_id` BIGINT COMMENT 'Identifier of the approval workflow instance assigned to this requisition. Tracks the multi-level approval process based on value thresholds and organizational hierarchy.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Engineering Change Request triggers a purchase requisition for the affected component; linking enables traceability of component‑driven procurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Requisition budgeting and approval allocate planned spend to a cost center, essential for budget control.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supply.demand_forecast. Business justification: Demand forecasts drive requisitions; the relationship is needed for the Forecast‑Driven Requisition analysis.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Procurement requisitions are generated from Engineering Change Orders; linking provides audit of ECO‑driven spend.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: CAPITAL ACQUISITION: Requisition must reference the equipment record for traceability of requested capital assets.',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Field Service Order Parts Requisition: each requisition references the field service order it supports.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Requisition may be tied to a GL account for expense planning and forecast alignment.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or item being requested. Links to the material master data in SAP MM or inventory management system. Null for service or non-stock requisitions.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP run creates purchase requisitions; the MRP run ID is required for the MRP Run to Requisition traceability report.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Procurement creates a requisition based on a sales opportunity to ensure material availability for the promised delivery.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Planned orders are converted to purchase requisitions; linking them enables the Planned Order Conversion audit.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who initiated the purchase requisition. Links to the workforce or employee master data.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the existing contract or blanket purchase order against which this requisition should be fulfilled. Null for non-contract purchases.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project budgeting & cost tracking require each requisition to be tied to its project header; the project_code field is denormalized and replaced by a proper FK.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Requisition approval checks material compliance against applicable regulatory requirements (e.g., hazardous substance rules).',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Service Management Parts Requisition process records the originating service request ID on each purchase requisition for traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for the Component Procurement Planning report linking requisitions to the final product SKU they support, enabling traceability from requisition to product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Requisition planning specifies target storage location for incoming material; needed for inbound logistics allocation and warehouse capacity reports.',
    `supplier_contact_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_contact. Business justification: Needed for Supplier Relationship Management process: requisition records the primary supplier contact for communication and escalation.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or suggested supplier for this requisition. Links to the supplier master data. Null if no preference specified.',
    `tertiary_purchase_employee_id` BIGINT COMMENT 'User ID of the person who last modified the purchase requisition. Used for audit trail and change tracking.',
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
    `po_created_date` DATE COMMENT 'Date when the purchase order was created from this requisition. Marks the transition from requisition to order in the procure-to-pay cycle.',
    `po_number` STRING COMMENT 'Purchase order number generated from this requisition after sourcing and supplier selection. Null if PO not yet created.',
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
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Purchase orders are raised against a specific BOM for a production run; linking supports BOM‑to‑PO cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PO posting requires cost center for internal accounting; mandatory for cost allocation reports.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: CAPITAL EQUIPMENT PROC: PO for automation hardware must link to device registry for warranty, maintenance, and asset tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each PO expense is posted to a GL account for financial statements; required by accounting standards.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Purchase orders are issued to satisfy material requirements; the link supports the Material Requirement Fulfilment KPI.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Required for Make‑to‑Order production planning; links each purchase order to the sales order it fulfills, enabling the Order‑to‑Procure fulfillment report.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where goods will be delivered.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who created and is responsible for this purchase order.',
    `project_header_id` BIGINT COMMENT 'Reference to the project or capital investment program to which this purchase order is allocated.',
    `requester_employee_id` BIGINT COMMENT 'Reference to the employee who originated the purchase requisition leading to this purchase order.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ or RFP that preceded this purchase order in the sourcing process.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Each purchase order fulfills a specific sales order intake; linking enables end‑to‑end order‑to‑procurement tracking.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Purchase orders for service work are issued under a specific service contract, enabling contract‑based billing and compliance reporting.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Needed for Order‑Driven Procurement process where purchase orders are tied to the specific product SKU being manufactured, supporting make‑to‑order execution.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific delivery address or warehouse location for goods receipt.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor to whom this purchase order is issued.',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Supply plans dictate purchase order creation; linking PO to supply_plan enables the Supply Plan Execution report.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Required for Logistics Planning Report: PO must reference the exact supplier site delivering goods, enabling site‑specific lead‑time and cost calculations.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑item expense allocation to cost center enables detailed cost reporting and variance analysis.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: EQUIPMENT LINE ITEM: Each PO line for a device (PLC, sensor) maps to a specific device registry entry for configuration management.',
    `engineering_bom_line_id` BIGINT COMMENT 'Foreign key linking to engineering.bom_line. Business justification: Order line items are derived from BOM lines during material planning; linking enables line‑level reconciliation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Line‑item posting to GL account is required for accurate expense classification in the general ledger.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being procured. Links to the specific product, component, or service being ordered.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Line item defines where received material will be stored; required for put‑away execution and inventory valuation per location.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Line‑item costs must be allocated to a WBS element for earned‑value and cost‑control reporting; the existing wbs_element string is replaced by a FK.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RFQ process assigns a buyer employee responsible for the event; tracking this employee is required for RFQ ownership reports and compliance.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the internal business unit, plant, or legal entity issuing the RFQ. Links to organizational hierarchy for spend analysis and compliance reporting.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: RFQs are often issued for specific projects; linking to project_header enables RFQ‑to‑project reporting and compliance checks.',
    `requisition_id` BIGINT COMMENT 'Identifier of the originating purchase requisition that triggered this RFQ. Links sourcing activity back to internal demand.',
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
    `compliance_product_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.product_certification. Business justification: Quotation evaluation includes verifying that quoted items have required product certifications per regulatory standards.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement buyer or sourcing specialist responsible for evaluating and managing this quotation.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or service being quoted. Links to the material master record.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order created as a result of awarding this quotation.',
    `sourcing_event_id` BIGINT COMMENT 'Reference to the originating sourcing event (RFQ or RFP) for which this quotation was submitted.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this quotation.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Unique identifier for the sourcing event. Primary key.',
    `commodity_category_id` BIGINT COMMENT 'add column commodity_category_id (BIGINT) with FK to procurement.commodity_category.commodity_category_id - sourcing events target specific commodity categories',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sourcing events are owned by a specific employee; the owner ID is needed for event‑ownership dashboards and audit trails.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sourcing events must align with regulatory requirements governing commodity categories, ensuring sourced materials meet compliance.',
    `supplier_id` BIGINT COMMENT 'add column supplier_id (BIGINT) with FK to supplier.supplier.supplier_id - sourcing events involve specific suppliers being evaluated',
    `actual_savings_amount` DECIMAL(18,2) COMMENT 'Actual cost savings amount achieved through the sourcing event, calculated as the difference between baseline and awarded pricing.',
    `actual_savings_percentage` DECIMAL(18,2) COMMENT 'Actual cost savings percentage achieved through the sourcing event, calculated as the percentage reduction from baseline to awarded pricing.',
    `award_date` DATE COMMENT 'Date when the sourcing event was awarded to selected suppliers.',
    `award_strategy` STRING COMMENT 'Strategy used to determine award allocation. Lowest price awards to the supplier with the lowest bid, best value considers multiple factors beyond price, weighted score uses a scoring model with multiple criteria, multi-supplier splits award across multiple suppliers, single supplier awards entire volume to one supplier.. Valid values are `lowest_price|best_value|weighted_score|multi_supplier|single_supplier`',
    `awarded_spend_amount` DECIMAL(18,2) COMMENT 'Total spend amount awarded to suppliers as a result of this sourcing event, representing the contracted value.',
    `awarded_supplier_count` STRING COMMENT 'Number of suppliers who received awards or contracts as a result of this sourcing event.',
    `baseline_spend_amount` DECIMAL(18,2) COMMENT 'Baseline or incumbent spend amount used as the reference point for calculating savings. Typically represents current or historical pricing.',
    `business_unit` STRING COMMENT 'Business unit or division that initiated and owns this sourcing event.',
    `commodity_category` STRING COMMENT 'Commodity or category being sourced in this event, such as raw materials, components, MRO (Maintenance, Repair, and Operations) supplies, indirect materials, or capital equipment.',
    `commodity_code` STRING COMMENT 'Standardized classification code for the commodity or category, typically aligned with UNSPSC (United Nations Standard Products and Services Code) or internal taxonomy.',
    `compliance_requirements` STRING COMMENT 'Regulatory, quality, or certification requirements that suppliers must meet to participate in this sourcing event, such as ISO certifications, environmental standards, or industry-specific compliance.',
    `contract_duration_months` STRING COMMENT 'Planned duration of the resulting contract in months.',
    `contract_type` STRING COMMENT 'Type of contract that will result from this sourcing event, such as blanket purchase agreement, framework agreement, spot buy, or long-term contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this sourcing event.. Valid values are `^[A-Z]{3}$`',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to delivery and lead time criteria in the overall evaluation scoring model.',
    `estimated_spend_amount` DECIMAL(18,2) COMMENT 'Total estimated spend value for the sourcing event, representing the anticipated contract value or purchase volume across all awarded suppliers.',
    `evaluation_criteria` STRING COMMENT 'Detailed description of the criteria used to evaluate supplier bids, such as price, quality, delivery time, technical capability, sustainability, and past performance.',
    `evaluation_end_date` DATE COMMENT 'Date when the evaluation of supplier bids was completed.',
    `evaluation_start_date` DATE COMMENT 'Date when the evaluation of supplier bids commenced.',
    `event_name` STRING COMMENT 'Descriptive name of the sourcing event, typically including commodity or category reference for easy identification.',
    `event_number` STRING COMMENT 'Business identifier for the sourcing event, typically system-generated or manually assigned for external reference and tracking.',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event. Draft indicates event is being prepared, published means event is visible to suppliers but not yet accepting bids, open indicates active bidding period, closed means bidding has ended and evaluation is underway, awarded indicates suppliers have been selected, cancelled means event was terminated without award.. Valid values are `draft|published|open|closed|awarded|cancelled`',
    `event_type` STRING COMMENT 'Type of competitive sourcing event. RFQ (Request for Quotation) for price-focused procurement, RFP (Request for Proposal) for complex requirements, reverse auction for dynamic bidding, e-auction for electronic competitive bidding, multi-round negotiation for iterative supplier engagement, sealed bid for confidential single-round submissions.. Valid values are `rfq|rfp|reverse_auction|e_auction|multi_round_negotiation|sealed_bid`',
    `invited_supplier_count` STRING COMMENT 'Number of suppliers invited to participate in the sourcing event.',
    `is_multi_round` BOOLEAN COMMENT 'Indicates whether the sourcing event includes multiple rounds of bidding or negotiation. True for multi-round events, false for single-round events.',
    `is_sealed_bid` BOOLEAN COMMENT 'Indicates whether supplier bids are sealed and confidential until the submission deadline. True for sealed bid events, false for transparent or visible bidding.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the sourcing event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the sourcing event.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code for which materials or services are being sourced in this event.',
    `price_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to price in the overall evaluation scoring model. Typically ranges from 0 to 100.',
    `publish_date` DATE COMMENT 'Date when the sourcing event was published and made visible to invited suppliers.',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer team responsible for this sourcing event, typically specialized by commodity or category.',
    `purchasing_organization` STRING COMMENT 'Purchasing organization responsible for executing this sourcing event, typically aligned with SAP organizational structure.',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to quality criteria in the overall evaluation scoring model.',
    `responding_supplier_count` STRING COMMENT 'Number of suppliers who submitted bids or responses to the sourcing event.',
    `round_count` STRING COMMENT 'Number of bidding or negotiation rounds conducted in this sourcing event.',
    `savings_target_amount` DECIMAL(18,2) COMMENT 'Target cost savings amount that the sourcing event aims to achieve compared to baseline or incumbent pricing.',
    `savings_target_percentage` DECIMAL(18,2) COMMENT 'Target cost savings percentage that the sourcing event aims to achieve compared to baseline or incumbent pricing.',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their bids or proposals. No submissions are accepted after this timestamp.',
    `technical_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to technical capability and compliance criteria in the overall evaluation scoring model.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the sourcing event record.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Strategic sourcing event record representing any competitive procurement event including RFQs, RFPs, reverse auctions, e-auctions, and multi-round negotiations for a commodity or category. Captures event name, event type, commodity category, total estimated spend, invited supplier count, submission deadline, evaluation criteria and weightings, award strategy (lowest price, best value, weighted score), savings target, actual savings achieved, event owner, supplier bid responses, bid rankings, and final award status. Serves as the SSOT for all competitive sourcing activity including quotation management. Supports category management governance, sourcing pipeline tracking, and procurement value reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Contracts are tied to specific compliance obligations they fulfill, linking contract management to obligation tracking.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: CONTRACT MANAGEMENT: Contracts for control system supply/maintenance must reference the specific control system asset.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or procurement manager responsible for managing and administering this contract.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supports Family‑Level Supply Contract Management allowing contracts to be associated with product families for volume‑discount negotiations.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Contracts are awarded for specific projects; linking contracts to project headers supports contract‑to‑project compliance and financial reporting.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contract compliance review requires linking each contract to the regulatory requirement it must satisfy, ensuring legal and safety adherence.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this procurement contract is established.',
    `tertiary_procurement_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or employee who last modified this contract record.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` (
    `contract_release_order_id` BIGINT COMMENT 'Unique identifier for the contract release order record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which the release order value will be charged for financial accounting.',
    `address_id` BIGINT COMMENT 'Reference to the delivery address for this release, may differ from the default plant address for direct shipments.',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account for posting the release order expense.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or service being released under this order.',
    `plant_data_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the released materials will be delivered.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who requested this release order.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the scheduling agreement if this release is drawn against a scheduling agreement rather than a blanket PO.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent blanket purchase order or framework agreement against which this release is issued.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse within the plant where materials will be received.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor fulfilling this release order, inherited from the parent contract.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element if this release is charged to a specific project.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the materials or services were delivered and received, used for supplier performance evaluation.',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this release order for submission to the supplier.',
    `approved_timestamp` TIMESTAMP COMMENT 'System timestamp when this release order was approved.',
    `closed_timestamp` TIMESTAMP COMMENT 'System timestamp when this release order was closed after successful delivery and receipt.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery of the released materials or services, may differ from requested date.',
    `contract_remaining_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity available under the parent contract after this release is issued, used for tracking contract consumption.',
    `contract_remaining_value` DECIMAL(18,2) COMMENT 'Remaining monetary value available under the parent contract after this release is issued.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this release order record was first created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the release value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_number` STRING COMMENT 'Reference number of the goods receipt document created when materials from this release are received.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk (e.g., EXW, FOB, CIF, DDP) as per ICC standards.',
    `inspection_lot_number` STRING COMMENT 'Quality inspection lot number assigned when materials from this release undergo quality inspection.',
    `invoice_number` STRING COMMENT 'Supplier invoice number associated with this release order for payment processing.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this release order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this release order record was last modified.',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this release order, inherited from the parent contract (e.g., Net 30, Net 60, 2/10 Net 30).',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming materials from this release require quality inspection before acceptance (True) or can be received directly (False).',
    `release_date` DATE COMMENT 'Date when the release order was created and issued to the supplier.',
    `release_notes` STRING COMMENT 'Free-text notes or special instructions related to this release order, such as delivery instructions, quality requirements, or packaging specifications.',
    `release_number` STRING COMMENT 'Business identifier for the release order, typically a sequential number or alphanumeric code assigned by the procurement system.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units being called off in this release order.',
    `release_sequence` STRING COMMENT 'Sequential ordering of this release within the parent contract or scheduling agreement, used for tracking call-off progression.',
    `release_status` STRING COMMENT 'Current lifecycle status of the release order: draft (being prepared), submitted (sent to supplier), approved (confirmed by supplier), in_transit (goods shipped), received (goods delivered), closed (completed), or cancelled. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_transit|received|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `release_type` STRING COMMENT 'Classification of the release order indicating the nature of the call-off: standard scheduled release, urgent expedited release, partial delivery, final release closing the contract, blanket call-off, or scheduled delivery.. Valid values are `standard|urgent|partial|final|blanket_calloff|scheduled_delivery`',
    `release_value` DECIMAL(18,2) COMMENT 'Total monetary value of this release order, calculated as release quantity multiplied by unit price.',
    `requested_delivery_date` DATE COMMENT 'Date by which the released materials or services are requested to be delivered to the receiving location.',
    `shipping_method` STRING COMMENT 'Mode of transportation for delivering the released materials: air freight, sea freight, road transport, rail, courier service, or customer pickup.. Valid values are `air|sea|road|rail|courier|pickup`',
    `tracking_number` STRING COMMENT 'Carrier tracking number for monitoring the shipment status of this release order.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the release quantity, such as pieces (EA), kilograms (KG), liters (L), hours (HR), or other standard units.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit for the material or service as defined in the parent contract, applied to this release.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this release order record in the system.',
    CONSTRAINT pk_contract_release_order PRIMARY KEY(`contract_release_order_id`)
) COMMENT 'Release order or call-off issued against a blanket purchase order or scheduling agreement to draw down committed contract quantities. Captures release number, parent contract reference, release quantity, release value, delivery schedule date, plant, and release status. Enables tracking of contract consumption, remaining balance, and delivery schedule adherence against framework agreements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` (
    `procurement_goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt document. Primary key for the procurement goods receipt entity.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: GOODS RECEIPT: Received automation equipment is recorded against the device registry to confirm installation and start warranty.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: GOODS RECEIPT: Receiving equipment updates the equipment register for inventory, commissioning, and warranty start dates.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or service received. Links to the material master for product specifications and inventory management.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level three-way matching.',
    `employee_id` BIGINT COMMENT 'The employee or user identifier of the person who received the goods. Links to human resources or user management systems.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the GR to the originating procurement document.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Goods receipt must be tied to the originating sales order intake to close the fulfillment loop and recognize revenue.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the specific storage location within the warehouse where the received goods are placed. Enables precise inventory tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier from whom the goods or services were received. Key counterparty in the procurement transaction.',
    `tertiary_procurement_last_modified_by_user_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this goods receipt record. Used for change tracking and audit trail.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or receiving facility where the goods were physically received.',
    `accounting_document_number` STRING COMMENT 'The financial accounting document number generated when the goods receipt value is posted to the General Ledger (GL). Links the GR to financial transactions.. Valid values are `^[0-9]{10}$`',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received material. Critical for traceability, quality control, and recall management in regulated industries.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the goods receipt value is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether the received goods were damaged during transit or delivery. True if damage was observed; false otherwise. Triggers quality hold and supplier notification.',
    `delivery_date` DATE COMMENT 'The actual date on which the goods were physically delivered to the receiving location. Used for supplier performance evaluation and lead time analysis.',
    `delivery_note_number` STRING COMMENT 'The delivery note or packing slip number provided by the supplier. Used to match physical delivery documentation with the goods receipt record.',
    `document_date` DATE COMMENT 'The date printed on the goods receipt document. May differ from the posting date for backdated or forward-dated transactions.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for tracking, auditing, and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `expiration_date` DATE COMMENT 'The date on which the received material expires or becomes unusable. Critical for perishable goods, chemicals, and materials with shelf-life constraints.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the GR is in draft, posted to inventory, blocked for quality issues, cancelled, or reversed.. Valid values are `draft|posted|blocked|cancelled|reversed`',
    `goods_receipt_value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods received, calculated as received quantity multiplied by the purchase order unit price. Posted to inventory and General Ledger (GL) accounts.',
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
    `receiving_plant_code` STRING COMMENT 'The code of the manufacturing plant or facility that received the goods. Used for multi-plant inventory and cost center allocation.. Valid values are `^[A-Z0-9]{4}$`',
    `return_authorization_flag` BOOLEAN COMMENT 'Indicates whether a Return Material Authorization (RMA) has been initiated for the received goods due to quality issues, damage, or incorrect delivery. True if RMA initiated; false otherwise.',
    `reversal_date` DATE COMMENT 'The date on which this goods receipt was reversed. Used for audit trail and financial period reconciliation.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt has been reversed. Links to the cancelling document for audit trail.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed; false otherwise. Reversed GRs do not contribute to inventory or financial balances.',
    `serial_number` STRING COMMENT 'The unique serial number of the received item, applicable for serialized inventory such as equipment, tools, or high-value components.',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Unrestricted stock is available for use; quality inspection and blocked stock are not.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilogram, L for liter). Must align with the purchase order and material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number assigned by the supplier to the delivered goods. Used for supplier traceability and quality issue root cause analysis.',
    CONSTRAINT pk_procurement_goods_receipt PRIMARY KEY(`procurement_goods_receipt_id`)
) COMMENT 'Goods receipt (GR) document recorded when materials or services are physically received from a supplier against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, unit of measure, storage location, batch number, quality inspection flag, and GR/IR clearing status. Triggers inventory update and initiates the three-way match process (PO–GR–Invoice) for accounts payable.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice approval workflow must record which employee approved the supplier invoice to satisfy internal controls and audit requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice posting requires cost center to allocate vendor expenses to the correct internal unit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor invoices are posted to GL accounts for expense recognition per accounting policy.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched in the three-way match process (PO–GR–Invoice).',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) who issued this invoice.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑level cost allocation to cost center supports detailed profitability and variance reporting.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: INVOICE ALLOCATION: Invoice line items for equipment need a FK to the equipment register for accurate asset cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each invoice line must map to a GL account for correct posting in the general ledger.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent supplier invoice header. Links this line item to the overall invoice document.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the product or material being invoiced. Links to the material catalog for direct materials, indirect materials, or MRO supplies.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the purchase order line item that this invoice line corresponds to. Used for three-way matching between PO, goods receipt, and invoice.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis requires linking invoice lines to profit centers for revenue/expense attribution.',
    `service_entry_sheet_id` BIGINT COMMENT 'Reference to the service entry sheet if this line item corresponds to a service rather than a material. Used for service procurement verification.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line‑item verification is performed by an employee; capturing the verifier supports three‑way match audit and compliance reporting.',
    `baseline_date` DATE COMMENT 'The baseline date from which payment terms are calculated for this line item. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `batch_number` STRING COMMENT 'The batch or lot number for the material being invoiced. Critical for traceability, quality management, and recall management in regulated industries.',
    `blocking_reason` STRING COMMENT 'The reason code or description explaining why this invoice line is blocked from payment. Examples include price variance exceeds tolerance, quantity mismatch, missing goods receipt, or quality hold.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount and unit price (e.g., USD, EUR, GBP, CNY). Must match the invoice header currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The supplier delivery note or packing slip number referenced on this invoice line. Used for traceability and shipment reconciliation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied at the line level. Reduces the line amount before tax calculation. May represent early payment discounts, volume discounts, or promotional discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percentage applied to this line item. Expressed as a percentage (e.g., 5.00 for 5% discount).',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number that this invoice line is matched against. Critical for three-way matching in logistics invoice verification.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded on the goods receipt document. Used to compare against invoiced quantity for quantity variance detection.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units being invoiced on this line. Used for three-way match verification against PO quantity and goods receipt quantity.',
    `line_amount` DECIMAL(18,2) COMMENT 'The total amount for this invoice line before taxes. Typically calculated as invoiced quantity multiplied by unit price, adjusted for any line-level discounts or surcharges.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and position of this line item on the invoice document.',
    `line_type` STRING COMMENT 'Classification of the invoice line item type. Distinguishes between material purchases, services, freight charges, handling fees, taxes, discounts, surcharges, and other cost elements. [ENUM-REF-CANDIDATE: material|service|freight|handling|tax|discount|surcharge|other — 8 candidates stripped; promote to reference product]',
    `match_status` STRING COMMENT 'The three-way match status of this invoice line. Indicates whether the line passed matching validation or has variances requiring resolution. Blocked status prevents payment until resolved.. Valid values are `matched|quantity_variance|price_variance|blocked|unmatched|pending`',
    `material_description` STRING COMMENT 'Textual description of the material, service, or item being invoiced. Provides human-readable detail about what was purchased.',
    `material_number` STRING COMMENT 'The material number or SKU (Stock Keeping Unit) as specified on the invoice line. May differ from internal material master number in case of supplier-specific identifiers.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount for this invoice line after applying discounts and adding taxes. Represents the final cost impact of this line item.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice line. May contain variance explanations, special handling instructions, or resolution details.',
    `payment_terms` STRING COMMENT 'The payment terms applicable to this invoice line if different from header-level terms. May specify early payment discounts or extended payment periods.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the material or service is consumed or delivered. Used for multi-site cost allocation.',
    `po_quantity` DECIMAL(18,2) COMMENT 'The quantity specified on the original purchase order line. Used as the baseline for three-way match verification.',
    `po_unit_price` DECIMAL(18,2) COMMENT 'The unit price specified on the original purchase order line. Used as the baseline for price variance detection during invoice verification.',
    `price_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced unit price and PO unit price, multiplied by invoiced quantity. Indicates pricing discrepancies requiring review.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced quantity and goods receipt quantity. Positive values indicate over-invoicing, negative values indicate under-invoicing.',
    `serial_number` STRING COMMENT 'The serial number for serialized materials or equipment. Enables individual unit tracking for warranty, maintenance, and asset management.',
    `storage_location` STRING COMMENT 'The storage location within the plant where the material is received or stored. Used for inventory management and warehouse assignment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this invoice line based on the tax code and line amount. Added to line amount to determine total line cost.',
    `tax_code` STRING COMMENT 'The tax code applied to this invoice line. Determines the tax rate and tax jurisdiction for calculating line-level tax amounts.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to this line item. Expressed as a percentage (e.g., 7.50 for 7.5% tax rate).',
    `tolerance_group` STRING COMMENT 'The tolerance group that defines acceptable variance thresholds for this line item. Different tolerance groups may apply to different material categories or supplier relationships.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the invoiced quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours). Must align with PO and material master UOM for proper matching.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure as stated on the invoice line. Used to calculate line amount and compared against PO price for variance detection.',
    `valuation_type` STRING COMMENT 'The valuation type for split valuation scenarios where the same material is valued differently based on procurement source, quality grade, or other criteria.',
    `verification_date` DATE COMMENT 'The date when this invoice line was verified and approved for payment. Critical for tracking invoice processing cycle time and SLA compliance.',
    `verification_status` STRING COMMENT 'The current verification status of this invoice line in the approval workflow. Tracks progress through invoice verification and approval process.. Valid values are `pending|verified|rejected|on_hold|approved`',
    `wbs_element` STRING COMMENT 'The WBS element for project-related procurement. Links invoice line to specific project phases or deliverables for project cost tracking.',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Individual line item on a supplier invoice corresponding to a specific PO line, service entry sheet, or unplanned delivery cost. Captures line number, material or service description, invoiced quantity, unit price, line amount, tax code, account assignment, and three-way match status (matched, quantity variance, price variance, blocked). Enables granular invoice verification and exception management in logistics invoice verification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` (
    `spend_record_id` BIGINT COMMENT 'Unique identifier for the spend transaction record. Primary key for the spend_record data product.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the purchase order. Used for approval audit trail and delegation of authority compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spend records are aggregated by cost center for budgeting and spend analysis reports.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Associating spend records with GL accounts supports financial statement reconciliation and audit.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material or service procured. Links to material master data in SAP S/4HANA MM or Siemens Teamcenter PLM.',
    `primary_spend_employee_id` BIGINT COMMENT 'Identifier of the employee who initiated the purchase requisition. Used for spend accountability and approval workflow tracking.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the procurement contract under which this spend was executed. Links to contract master data for compliance tracking and savings validation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Linking spend to profit centers enables profitability tracking of procurement spend.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this spend transaction. Links to the purchase order master record in SAP Ariba or SAP S/4HANA MM module.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Spend analysis reports track expenditures against regulatory requirements for spend compliance and audit trails.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Provides product‑level spend analysis, required for the Product Spend Reporting dashboard used by finance and supply chain.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier who provided the goods or services. Links to supplier master data in SAP Ariba or SAP S/4HANA MM.',
    `commodity_code_l1` STRING COMMENT 'Top-level commodity classification code from the United Nations Standard Products and Services Code (UNSPSC) taxonomy. Enables high-level category spend aggregation.',
    `commodity_code_l2` STRING COMMENT 'Second-level commodity classification code from UNSPSC taxonomy. Provides family-level categorization for spend cube analytics.',
    `commodity_code_l3` STRING COMMENT 'Third-level commodity classification code from UNSPSC taxonomy. Provides class-level categorization for detailed spend analysis.',
    `commodity_code_l4` STRING COMMENT 'Fourth-level commodity classification code from UNSPSC taxonomy. Provides commodity-level categorization for granular spend analysis and category management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend transaction. Used for multi-currency spend analysis and currency conversion.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Date the goods or services were delivered. Used for supplier on-time delivery performance measurement and lead time analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate used to convert transaction currency to USD. Captured for audit trail and variance analysis.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the spend was posted. Supports monthly spend tracking and period-over-period analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the spend transaction was posted. Enables year-over-year spend trend analysis and budget variance reporting.',
    `gl_account` STRING COMMENT 'General ledger account code to which the spend is posted. Used for financial reporting and chart of accounts reconciliation.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., FOB, CIF, DDP).',
    `invoice_date` DATE COMMENT 'Date the supplier invoice was issued. Used for payment terms calculation and aging analysis.',
    `invoice_number` STRING COMMENT 'Supplier invoice number associated with this spend transaction. Used for payment reconciliation and audit trail.',
    `material_description` STRING COMMENT 'Short text description of the material or service procured. Denormalized for reporting and spend analysis.',
    `maverick_spend_flag` BOOLEAN COMMENT 'Indicates whether this spend transaction was executed outside of established contracts or preferred suppliers. True indicates non-compliant spend requiring corrective action.',
    `payment_date` DATE COMMENT 'Date the payment was made to the supplier. Used for cash flow analysis and Days Payable Outstanding (DPO) calculation.',
    `payment_method` STRING COMMENT 'Method used to pay the supplier. Used for payment channel analysis and transaction cost optimization.. Valid values are `wire_transfer|check|ach|credit_card|pcard|eft`',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Used for cash flow forecasting and early payment discount analysis.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the material or service is consumed. Used for site-level spend analysis and supply chain optimization.',
    `po_line_item_number` STRING COMMENT 'Line item number within the purchase order that corresponds to this spend transaction. Enables drill-down to specific material or service line.',
    `posting_date` DATE COMMENT 'Date the spend transaction was posted to the financial ledger. Determines the fiscal period for spend recognition and accrual accounting.',
    `procurement_channel` STRING COMMENT 'Channel through which the procurement was executed. Used for maverick spend detection and procurement compliance monitoring.. Valid values are `po_based|non_po|pcard|blanket_release|contract_release`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for this purchase. Used for buyer performance evaluation and workload distribution analysis.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Used for procurement performance tracking and organizational spend analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units procured in this transaction. Used for unit price calculation and volume-based spend analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend record was first created in the data lakehouse. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend record was last updated in the data lakehouse. Used for change tracking and data freshness monitoring.',
    `savings_amount` DECIMAL(18,2) COMMENT 'Documented cost savings achieved on this transaction compared to baseline or previous pricing. Used for procurement performance measurement and ROI calculation.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the spend transaction in the transaction currency. Represents the actual expenditure at line-item level before currency conversion.',
    `spend_amount_usd` DECIMAL(18,2) COMMENT 'Spend amount converted to US Dollars using the exchange rate at posting date. Enables consolidated spend reporting across global operations.',
    `spend_category` STRING COMMENT 'High-level classification of spend type: direct materials (production inputs), indirect materials (non-production goods), MRO (Maintenance, Repair, Operations supplies), or CapEx (Capital Expenditure for fixed assets).. Valid values are `direct|indirect|mro|capex`',
    `supplier_segment` STRING COMMENT 'Strategic classification of the supplier based on spend volume, criticality, and performance. Used for supplier relationship management and sourcing strategy.. Valid values are `strategic|preferred|approved|conditional|blocked`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the spend transaction. Used for tax reporting and compliance with local tax regulations.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code or tax type applied to this transaction. Used for tax compliance reporting and audit trail.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., EA for each, KG for kilogram, M for meter). Follows ISO 80000 or industry-specific UOM standards.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure in the transaction currency. Calculated as spend_amount divided by quantity. Used for price variance analysis and benchmarking.',
    CONSTRAINT pk_spend_record PRIMARY KEY(`spend_record_id`)
) COMMENT 'Normalized spend transaction record representing actual procurement expenditure at the line-item level, enriched with commodity classification (UNSPSC L1-L4), supplier segmentation, and cost object allocation. Captures spend amount, currency, spend category (direct, indirect, MRO, CapEx), cost center, profit center, plant, fiscal period, payment date, and PO/invoice reference. Serves as the foundational fact table for spend cube analytics, category management dashboards, maverick spend detection, and savings validation across all procurement channels including P-card, PO-based, and non-PO spend.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` (
    `approval_workflow_id` BIGINT COMMENT 'Primary key for approval_workflow',
    `employee_id` BIGINT COMMENT 'Unique identifier of the individual who performed the approval action. Links to employee or user master data.',
    `project_document_id` BIGINT COMMENT 'Reference to the document being approved (purchase requisition, purchase order, or sourcing event). Links to the source document requiring approval.',
    `requester_employee_id` BIGINT COMMENT 'Unique identifier of the employee who initiated the procurement request. Links to employee or user master data.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier or vendor associated with the procurement document being approved. Links to supplier master data.',
    `approval_action` STRING COMMENT 'Action taken by the approver on the document. Approved indicates authorization granted, rejected indicates denial, escalated indicates forwarding to higher authority, delegated indicates reassignment to another approver, returned indicates sent back for revision.. Valid values are `approved|rejected|escalated|delegated|returned|pending`',
    `approval_comments` STRING COMMENT 'Free-text comments or notes entered by the approver explaining the approval decision, conditions, or reasons for rejection. Supports audit trail and communication.',
    `approval_document_type` STRING COMMENT 'Type of procurement document being approved. Indicates whether the approval is for a purchase requisition, purchase order, RFQ (Request for Quotation), RFP (Request for Proposal), contract, or other sourcing event.. Valid values are `purchase_requisition|purchase_order|rfq|rfp|contract|sourcing_event`',
    `approval_due_date` DATE COMMENT 'Target date by which the approval action should be completed. Used for SLA (Service Level Agreement) tracking and escalation triggers.',
    `approval_duration_hours` DECIMAL(18,2) COMMENT 'Time elapsed in hours between approval request and approval action completion. Used for cycle time analysis and process optimization.',
    `approval_level` STRING COMMENT 'Sequential level in the multi-tier approval hierarchy. Level 1 represents first-line approval, with higher numbers indicating escalation through management layers.',
    `approval_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the approval request notification was successfully sent to the approver. True indicates notification sent, false indicates pending or failed.',
    `approval_reminder_count` STRING COMMENT 'Number of reminder notifications sent to the approver for this pending approval. Used to track follow-up communications and escalation triggers.',
    `approval_request_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request was submitted to this approver. Marks the start of the approval cycle for this level.',
    `approval_sequence_number` STRING COMMENT 'Sequential order number of this approval step within the overall workflow for the document. Used to track the progression through the approval chain.',
    `approval_source_system` STRING COMMENT 'Name of the source system or application from which the approval workflow originated. Examples include SAP Ariba, SAP S/4HANA, custom procurement portal.',
    `approval_status` STRING COMMENT 'Current lifecycle status of this approval step. Pending indicates awaiting action, in progress indicates under review, approved indicates completed successfully, rejected indicates denied, cancelled indicates workflow terminated, expired indicates approval deadline passed.. Valid values are `pending|in_progress|approved|rejected|cancelled|expired`',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold amount that defines the approval authority limit for this approver role at this level. Part of Delegation of Authority (DoA) matrix.',
    `approval_threshold_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval threshold amount. Defines the currency in which the approval authority is denominated.. Valid values are `^[A-Z]{3}$`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval action was performed by the approver. Represents the business event time of the authorization decision.',
    `approver_email` STRING COMMENT 'Email address of the approver. Used for notification and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the individual who performed the approval action. Captured for audit trail and reporting purposes.',
    `approver_role` STRING COMMENT 'Functional role or job title of the approver responsible for this approval level. Examples include Purchasing Manager, Plant Manager, Finance Director, VP Procurement, CFO.',
    `company_code` STRING COMMENT 'Legal entity or company code within the enterprise structure. Represents the financial accounting entity for which the procurement is being executed.',
    `compliance_check_status` STRING COMMENT 'Status of automated compliance checks performed during the approval process. Indicates whether the document passed policy validation, supplier screening, budget checks, and regulatory compliance rules.. Valid values are `passed|failed|not_applicable|pending`',
    `cost_center` STRING COMMENT 'Cost center to which the procurement expense will be charged. Used for internal cost allocation and management accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was first created in the system. Represents the audit trail start point for this approval step.',
    `delegation_reason` STRING COMMENT 'Reason for delegating the approval to another approver. Examples include out of office, conflict of interest, workload balancing, temporary reassignment.',
    `document_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document total amount. Indicates the currency in which the procurement document is denominated.. Valid values are `^[A-Z]{3}$`',
    `document_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the document being approved. Used to determine routing through approval hierarchy based on DoA (Delegation of Authority) thresholds.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the approval to a higher authority level. Examples include exceeds_authority, requires_executive_review, policy_exception, risk_assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was last updated. Used for audit trail and change tracking purposes.',
    `mandatory_approval_flag` BOOLEAN COMMENT 'Indicates whether this approval step is mandatory or optional in the workflow. True indicates required approval, false indicates advisory or optional review.',
    `material_category` STRING COMMENT 'Classification of the materials or services being procured. Examples include direct materials, indirect materials, MRO (Maintenance, Repair, and Operations) supplies, capital equipment, services.',
    `parallel_approval_flag` BOOLEAN COMMENT 'Indicates whether this approval step is part of a parallel approval process where multiple approvers at the same level must approve simultaneously. True indicates parallel, false indicates sequential.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the procured materials or services will be delivered or consumed. Represents the physical location in the supply chain.',
    `policy_violation_description` STRING COMMENT 'Description of the specific procurement policy or business rule that was violated. Populated when policy violation flag is true.',
    `policy_violation_flag` BOOLEAN COMMENT 'Indicates whether the procurement document violates any procurement policies or business rules. True indicates policy violation detected, false indicates compliant.',
    `purchasing_group` STRING COMMENT 'Buyer group or team responsible for specific categories of materials or suppliers. Represents the operational procurement team handling the transaction.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Represents the procurement entity within the enterprise structure (e.g., regional purchasing office, plant purchasing group).',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for rejection if the approval action was rejected. Examples include budget_exceeded, supplier_not_approved, specification_incomplete, pricing_issue.',
    CONSTRAINT pk_approval_workflow PRIMARY KEY(`approval_workflow_id`)
) COMMENT 'Approval workflow record tracking the multi-level authorization process for purchase requisitions, purchase orders, and sourcing events. Captures approval document reference, approval level, approver role, approver identity, approval action (approved, rejected, escalated, delegated), approval timestamp, approval threshold amount, and comments. Supports procurement governance, delegation of authority (DoA) compliance, and audit trail requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Unique identifier for the service entry sheet record. Primary key.',
    `approval_workflow_id` BIGINT COMMENT 'Identifier of the approval workflow instance used to review and approve this service entry sheet.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who accepted and confirmed the services in this service entry sheet.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: SERVICE ENTRY: Service records must link to the equipment register to track maintenance history and warranty compliance.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the service purchase order against which services were rendered and accepted.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who rendered the services being accepted in this service entry sheet.',
    `acceptance_date` DATE COMMENT 'Date on which the services were formally accepted by the receiving organization.',
    `acceptance_notes` STRING COMMENT 'Free-text notes or comments entered by the acceptor regarding the service acceptance, quality observations, or deviations.',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Quantity of service units accepted and confirmed through this service entry sheet.',
    `acceptor_name` STRING COMMENT 'Full name of the individual who accepted the services for business reference and audit trail.',
    `approval_date` DATE COMMENT 'Date on which the service entry sheet received final approval through the workflow process.',
    `company_code` STRING COMMENT 'Company code of the legal entity receiving and accepting the services.',
    `cost_center` STRING COMMENT 'Cost center to which the accepted service costs are allocated for financial accounting and controlling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the service entry sheet monetary values.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year in which the service entry sheet was posted.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the service entry sheet was posted for financial reporting and period closing.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the service entry sheet value is posted for financial reporting.',
    `gross_value` DECIMAL(18,2) COMMENT 'Total gross monetary value of the accepted services including taxes and all adjustments.',
    `invoice_verification_flag` BOOLEAN COMMENT 'Indicator whether this service entry sheet has been used for invoice verification and payment processing.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the service entry sheet record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet record was last modified or updated.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net monetary value of the accepted services before taxes and adjustments.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Original quantity of service units ordered on the purchase order line item for comparison with accepted quantity.',
    `plant_code` STRING COMMENT 'Plant or facility code where the services were rendered or consumed.',
    `po_line_number` STRING COMMENT 'Line item number on the purchase order to which this service entry sheet applies.',
    `posting_date` DATE COMMENT 'Date on which the service entry sheet was posted to financial accounting for cost recognition.',
    `purchasing_group` STRING COMMENT 'Buyer group or team within the purchasing organization responsible for managing this service procurement.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for the procurement of the services covered by this service entry sheet.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the accepted service quantity such as hours, days, pieces, or service-specific units.',
    `rejection_reason` STRING COMMENT 'Reason code or description explaining why the service entry sheet was rejected, if applicable.',
    `service_category` STRING COMMENT 'Classification category of the service type for spend analysis and procurement reporting.',
    `service_description` STRING COMMENT 'Detailed textual description of the services rendered by the supplier and accepted through this service entry sheet.',
    `service_end_date` DATE COMMENT 'Date on which the supplier completed rendering the services covered by this service entry sheet.',
    `service_start_date` DATE COMMENT 'Date on which the supplier began rendering the services covered by this service entry sheet.',
    `ses_number` STRING COMMENT 'Business document number assigned to the service entry sheet. Externally visible identifier used for tracking and reference in procurement workflows.',
    `ses_status` STRING COMMENT 'Current lifecycle status of the service entry sheet indicating its approval and posting state.. Valid values are `created|submitted|accepted|rejected|cancelled|posted`',
    `ses_type` STRING COMMENT 'Classification of the service entry sheet based on the procurement scenario and service delivery model.. Valid values are `standard|blanket|subcontracting|consignment`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the accepted services based on tax jurisdiction and service category.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing service entry sheet, purchase order, and supplier invoice for payment approval.. Valid values are `pending|matched|variance|blocked`',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for project-related service procurement cost allocation.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the service entry sheet record.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Service entry sheet (SES) document created to confirm the acceptance of services rendered by a supplier against a service purchase order. Captures SES number, service PO reference, service line descriptions, accepted service quantity, acceptance date, acceptor identity, and SES status (created, accepted, rejected). Triggers invoice verification for service-based procurement and is mandatory for service PO three-way match.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` (
    `commodity_category_id` BIGINT COMMENT 'Primary key for commodity_category',
    `parent_category_commodity_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchy. Null for top-level (L1) categories.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or procurement specialist responsible for managing this commodity category and its sourcing strategy.',
    `tertiary_commodity_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this commodity category record.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the commodity category. May align with UNSPSC (United Nations Standard Products and Services Code) or internal taxonomy.. Valid values are `^[A-Z0-9]{2,20}$`',
    `category_description` STRING COMMENT 'Detailed description of the commodity category scope, including typical materials, services, or products classified under this category.',
    `category_level` STRING COMMENT 'Hierarchical level of the category within the taxonomy structure. L1 represents top-level, L2 sub-category, L3 detailed category, etc.. Valid values are `L1|L2|L3|L4|L5`',
    `category_manager_name` STRING COMMENT 'Full name of the category manager responsible for strategic sourcing and supplier relationships within this category.',
    `category_name` STRING COMMENT 'Full descriptive name of the commodity category (e.g., Electrical Components, Raw Steel, MRO Supplies).',
    `category_status` STRING COMMENT 'Current lifecycle status of the commodity category within the procurement taxonomy.. Valid values are `active|inactive|under_review|deprecated`',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this category has specific regulatory compliance requirements (e.g., RoHS, REACH, conflict minerals, ISO certifications).',
    `contract_coverage_flag` BOOLEAN COMMENT 'Indicates whether this category is covered by active procurement contracts or framework agreements.',
    `cost_reduction_target_pct` DECIMAL(18,2) COMMENT 'Annual cost reduction target percentage for this category as part of strategic sourcing initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity category record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this commodity category classification became effective in the procurement taxonomy.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this category requires environmental compliance certifications such as ISO 14001, RoHS, REACH, or conflict minerals reporting.',
    `expiration_date` DATE COMMENT 'Date when this commodity category classification expires or is scheduled for review. Null for active categories without planned expiration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity category record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this category was last reviewed for accuracy, relevance, and alignment with business needs.',
    `lead_time_days_avg` STRING COMMENT 'Average procurement lead time in days for materials and services within this category, from requisition to delivery.',
    `moq_applicable_flag` BOOLEAN COMMENT 'Indicates whether suppliers in this category typically enforce minimum order quantity requirements.',
    `negotiation_frequency` STRING COMMENT 'Typical frequency of contract negotiations and RFx events for this commodity category.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this commodity category classification and sourcing strategy.',
    `preferred_supplier_count` STRING COMMENT 'Number of preferred suppliers currently approved and active for this commodity category.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this category has designated preferred suppliers with negotiated contracts or framework agreements.',
    `price_volatility_index` STRING COMMENT 'Classification of price volatility for commodities in this category based on historical price fluctuations and market dynamics.. Valid values are `high|medium|low|stable`',
    `purchasing_group` STRING COMMENT 'Code identifying the purchasing group (buyer team) responsible for operational procurement within this category.. Valid values are `^[A-Z0-9]{3,10}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the purchasing organization responsible for procurement activities within this category. Aligns with SAP organizational structure.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_certification_required` STRING COMMENT 'Comma-separated list of required quality certifications for suppliers in this category (e.g., ISO 9001, IATF 16949, AS9100).',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this commodity category.',
    `risk_classification` STRING COMMENT 'Risk classification based on supply chain vulnerability, supplier concentration, geopolitical factors, and material criticality.. Valid values are `high_risk|medium_risk|low_risk`',
    `sourcing_strategy` STRING COMMENT 'Defined sourcing strategy for this category: single-source, dual-source, multi-source, global sourcing, or local sourcing approach.. Valid values are `single_source|dual_source|multi_source|global_sourcing|local_sourcing`',
    `spend_type` STRING COMMENT 'Classification of spend type: direct materials (production inputs), indirect materials (non-production), MRO (Maintenance, Repair, Operations), CapEx (Capital Expenditure), or services.. Valid values are `direct|indirect|MRO|CapEx|services`',
    `strategic_sourcing_priority` STRING COMMENT 'Priority level assigned to this category for strategic sourcing initiatives based on spend volume, supply risk, and business impact.. Valid values are `critical|high|medium|low`',
    `unspsc_class` STRING COMMENT 'Third-level UNSPSC class name within the family (e.g., Cutting and Forming Machines).',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC classification code for global commodity standardization and cross-industry spend analysis.. Valid values are `^[0-9]{8}$`',
    `unspsc_commodity` STRING COMMENT 'Fourth-level UNSPSC commodity name, the most granular classification level (e.g., CNC Milling Machines).',
    `unspsc_family` STRING COMMENT 'Second-level UNSPSC family name within the segment (e.g., Metalworking Machinery and Equipment).',
    `unspsc_segment` STRING COMMENT 'Top-level UNSPSC segment name (e.g., Industrial Manufacturing and Processing Machinery and Accessories).',
    CONSTRAINT pk_commodity_category PRIMARY KEY(`commodity_category_id`)
) COMMENT 'Commodity and spend category taxonomy used to classify all purchased materials and services into a hierarchical structure aligned with UNSPSC or internal category codes. Captures category code, category name, category level (L1/L2/L3), parent category, spend type (direct/indirect/MRO/CapEx), category owner, preferred supplier flag, and strategic sourcing priority. Enables category management, spend cube construction, and sourcing strategy alignment.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` (
    `sourcing_strategy_id` BIGINT COMMENT 'System-generated unique identifier for the sourcing strategy record.',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to procurement.commodity_category. Business justification: Sourcing strategy must be linked to the commodity category it governs; adding procurement_category_id creates this essential relationship and eliminates the silo.',
    `supplier_id` BIGINT COMMENT 'add column supplier_id (BIGINT) with FK to supplier.supplier.supplier_id - sourcing strategies define preferred suppliers',
    `approval_date` DATE COMMENT 'Date when the strategy was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the strategy.. Valid values are `pending|approved|rejected`',
    `sourcing_strategy_category` STRING COMMENT 'Spend category or commodity to which the strategy applies.',
    `compliance_status` STRING COMMENT 'Current compliance status of the strategy with internal policies and external regulations.. Valid values are `compliant|non_compliant|pending`',
    `contract_coverage_target_amount` DECIMAL(18,2) COMMENT 'Monetary amount representing the desired contract coverage for the category.',
    `contract_coverage_target_percent` DECIMAL(18,2) COMMENT 'Desired percentage of spend covered by contracts under this strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing strategy record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.',
    `effective_from` DATE COMMENT 'Date when the sourcing strategy becomes effective.',
    `effective_until` DATE COMMENT 'Date when the sourcing strategy expires or is superseded (nullable for open‑ended).',
    `expected_lead_time_days` STRING COMMENT 'Anticipated lead time for sourcing items under this strategy.',
    `is_global_strategy` BOOLEAN COMMENT 'Indicates whether the strategy applies globally across all sites.',
    `last_review_date` DATE COMMENT 'Date of the most recent strategic review.',
    `last_reviewed_by` STRING COMMENT 'Name of the person who performed the most recent review.',
    `make_vs_buy` STRING COMMENT 'Decision whether the organization will make the item internally or buy it from external suppliers.. Valid values are `make|buy|co_source`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the strategy.',
    `preferred_supplier_ids` STRING COMMENT 'Comma‑separated list of internal supplier identifiers preferred for this strategy.',
    `review_cycle_months` STRING COMMENT 'Number of months between formal reviews of the sourcing strategy.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score quantifying the risk level of the strategy (0‑100 scale).',
    `risk_mitigation_plan` STRING COMMENT 'Brief description of actions to mitigate identified risks.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the sourcing strategy.. Valid values are `low|medium|high`',
    `savings_target_amount` DECIMAL(18,2) COMMENT 'Monetary amount of cost savings the strategy aims to achieve.',
    `savings_target_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the savings target amount.',
    `sourcing_strategy_status` STRING COMMENT 'Current lifecycle status of the sourcing strategy.. Valid values are `draft|active|inactive|archived`',
    `strategic_owner` STRING COMMENT 'Internal stakeholder responsible for the strategys execution.',
    `strategy_code` STRING COMMENT 'External code used to reference the sourcing strategy in procurement systems.',
    `strategy_name` STRING COMMENT 'Descriptive name of the sourcing strategy.',
    `strategy_type` STRING COMMENT 'Approach used for sourcing the category (e.g., single source, dual source, multi‑source, global, local).. Valid values are `single_source|dual_source|multi_source|global|local`',
    `target_savings_percent` DECIMAL(18,2) COMMENT 'Target savings expressed as a percentage of total spend.',
    `total_spend_last_year` DECIMAL(18,2) COMMENT 'Aggregate spend for the category in the most recent fiscal year.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sourcing strategy record.',
    `version_number` STRING COMMENT 'Incremental version of the sourcing strategy document.',
    `created_by` STRING COMMENT 'Identifier of the user who created the sourcing strategy record.',
    CONSTRAINT pk_sourcing_strategy PRIMARY KEY(`sourcing_strategy_id`)
) COMMENT 'Category-level sourcing strategy document defining the procurement approach for a commodity or spend category over a planning horizon. Captures strategy name, target category, strategy type (single source, dual source, multi-source, global sourcing, local sourcing), make-vs-buy decision, risk rating, savings target, preferred supplier list, contract coverage target, and review cycle. Supports strategic procurement planning and category management governance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` (
    `purchase_info_record_id` BIGINT COMMENT 'System-generated unique identifier for the purchase info record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Creating a purchase info record is an employee action; storing the creator ID enables accountability and change‑log reporting.',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material or service for which this info record is maintained.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier linked to this info record.',
    `approved_source_flag` BOOLEAN COMMENT 'Indicates whether the supplier is an approved source for the material (true = approved).',
    `contract_reference` STRING COMMENT 'Reference to an outline agreement or contract that governs this price.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the info record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the net price is expressed.. Valid values are `^[A-Z]{3}$`',
    `fixed_source_flag` BOOLEAN COMMENT 'True if procurement must always source from this supplier for the material.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities; limited to six most common values.. Valid values are `EXW|FCA|FOB|CFR|CIF|DAP`',
    `info_record_number` STRING COMMENT 'Business identifier assigned to the purchase info record, used for reference in procurement processes.',
    `info_record_type` STRING COMMENT 'Classification of the info record indicating the sourcing strategy (e.g., standard, subcontracting, pipeline, consignment).. Valid values are `standard|subcontracting|pipeline|consignment`',
    `last_price_update_timestamp` TIMESTAMP COMMENT 'Date‑time when the price information was last updated in the system.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from the approved source.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'True if the info record should be considered during MRP runs.',
    `net_price` DECIMAL(18,2) COMMENT 'Negotiated net price for the material/service from the approved supplier.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `order_quantity_multiple` DECIMAL(18,2) COMMENT 'Quantity increment that must be respected when ordering (e.g., multiples of 10).',
    `planned_delivery_time_days` STRING COMMENT 'Expected number of days from order creation to delivery for this source.',
    `plant_code` STRING COMMENT 'Code of the plant where the approved source is valid.',
    `price_change_date` DATE COMMENT 'Date on which the most recent price change became effective.',
    `price_change_indicator` STRING COMMENT 'Indicates whether the price has increased, decreased, or remained unchanged since the previous version.. Valid values are `increase|decrease|no_change`',
    `price_change_reason` STRING COMMENT 'Business justification for the latest price adjustment.',
    `price_unit` STRING COMMENT 'Unit of measure for the net price (e.g., per piece, per kilogram).',
    `purchase_info_record_status` STRING COMMENT 'Current lifecycle status of the info record.. Valid values are `active|inactive|blocked|pending|expired`',
    `purchasing_group` STRING COMMENT 'Group of buyers assigned to handle transactions for this info record.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities for this info record.',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the planned delivery date when a reminder is generated.',
    `source_of_supply_category` STRING COMMENT 'Broad classification of the source (e.g., internal, external, third‑party).',
    `source_priority` STRING COMMENT 'Numeric rank indicating preference order among multiple approved sources for the same material.',
    `tax_code` STRING COMMENT 'Tax classification applicable to the purchase price.',
    `tolerance_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowed deviation (percentage) from the negotiated price before a tolerance check is triggered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the info record.',
    `validity_end_date` DATE COMMENT 'Date after which the info record is no longer valid (nullable for open‑ended).',
    `validity_start_date` DATE COMMENT 'Date from which the info record becomes effective.',
    `vendor_material_number` STRING COMMENT 'Suppliers own material identifier for the supplied item.',
    `vendor_price_list` STRING COMMENT 'Reference to the suppliers price list or catalogue containing this price.',
    CONSTRAINT pk_purchase_info_record PRIMARY KEY(`purchase_info_record_id`)
) COMMENT 'Approved source master record linking a material or service to a qualified supplier, storing the negotiated price, standard order quantity, planned delivery time, tolerance limits, validity period, and plant-level sourcing assignments. Captures info record type (standard, subcontracting, pipeline, consignment), net price, price unit, minimum order quantity, reminder lead times, approved source indicators, MRP relevance flags, fixed source flags, valid-from/to dates, and outline agreement references. Drives automatic price proposals during PO creation and ensures MRP-driven orders are directed to approved suppliers at the correct plant.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` (
    `source_list_id` BIGINT COMMENT 'System-generated unique identifier for the source list record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Maintaining a source list is performed by a responsible employee; the creator ID is required for governance and audit of sourcing data.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material for which this source list applies.',
    `asset_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant/location associated with the source list.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the underlying procurement contract or agreement governing the source.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables the Component Sourcing per Product view, linking source‑list entries directly to the product SKU that uses the material.',
    `supplier_id` BIGINT COMMENT 'Identifier of the approved supplier for the material at the plant.',
    `compliance_status` STRING COMMENT 'Current compliance status of the source with internal or regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the source list record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price fields.. Valid values are `^[A-Z]{3}$`',
    `source_list_description` STRING COMMENT 'Free‑form description or notes about the source list entry.',
    `fixed_source_flag` BOOLEAN COMMENT 'Indicates whether the supplier is a fixed (mandatory) source for the material.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the source list record.',
    `lead_time_days` STRING COMMENT 'Standard lead time in calendar days for the supplier to deliver the material.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from the supplier for this material.',
    `mrp_source_indicator` STRING COMMENT 'Indicator used by MRP planning to select this source (standard, alternative, or special).. Valid values are `standard|alternative|special`',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price agreed with the supplier for the material.',
    `price_valid_from` DATE COMMENT 'Date from which the quoted unit price is effective.',
    `price_valid_to` DATE COMMENT 'Date until which the quoted unit price remains valid.',
    `priority` STRING COMMENT 'Numeric priority used to rank multiple approved sources for the same material.',
    `procurement_type` STRING COMMENT 'Category of procurement for the source (e.g., direct, indirect, MRO, capital equipment).. Valid values are `direct|indirect|mro|capital`',
    `source_list_status` STRING COMMENT 'Current lifecycle status of the source list record.. Valid values are `active|inactive|pending|expired`',
    `source_name` STRING COMMENT 'Human‑readable name or label for the source list entry.',
    `source_rating` DECIMAL(18,2) COMMENT 'Rating (e.g., 0‑5) reflecting supplier performance for this material.',
    `source_type` STRING COMMENT 'Classification of the source list entry indicating its sourcing strategy.. Valid values are `fixed|preferred|alternative|blocked`',
    `valid_from_date` DATE COMMENT 'Date from which the source list entry becomes effective.',
    `valid_to_date` DATE COMMENT 'Date on which the source list entry expires (null if open‑ended).',
    CONSTRAINT pk_source_list PRIMARY KEY(`source_list_id`)
) COMMENT 'Approved source record defining qualified suppliers for a material at a specific plant, including validity periods, fixed source indicators, and MRP relevance flags. Captures material, plant, supplier, agreement reference, valid-from/to dates, fixed source flag, MRP source indicator, and procurement type. Ensures purchase orders are automatically directed to approved suppliers.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ADD CONSTRAINT `fk_procurement_commodity_category_parent_category_commodity_category_id` FOREIGN KEY (`parent_category_commodity_category_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ADD CONSTRAINT `fk_procurement_sourcing_strategy_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `po_created_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Organization ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `supplier_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quotation ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `compliance_product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `actual_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Savings Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `actual_savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Savings Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_strategy` SET TAGS ('dbx_business_glossary_term' = 'Award Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_strategy` SET TAGS ('dbx_value_regex' = 'lowest_price|best_value|weighted_score|multi_supplier|single_supplier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Spend Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Spend Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration Months');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `estimated_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Spend Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|published|open|closed|awarded|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rfq|rfp|reverse_auction|e_auction|multi_round_negotiation|sealed_bid');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `invited_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Supplier Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_multi_round` SET TAGS ('dbx_business_glossary_term' = 'Is Multi-Round');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_sealed_bid` SET TAGS ('dbx_business_glossary_term' = 'Is Sealed Bid');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `price_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `responding_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Responding Supplier Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `round_count` SET TAGS ('dbx_business_glossary_term' = 'Round Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `savings_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Target Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `savings_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Savings Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `technical_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Technical Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `contract_release_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Release Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `contract_remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Remaining Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `contract_remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Remaining Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `contract_remaining_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Order Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_sequence` SET TAGS ('dbx_business_glossary_term' = 'Release Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'standard|urgent|partial|final|blanket_calloff|scheduled_delivery');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_value` SET TAGS ('dbx_business_glossary_term' = 'Release Order Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `release_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|courier|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `tertiary_procurement_last_modified_by_user_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|blocked|cancelled|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_value` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt / Invoice Receipt (GR/IR) Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `invoice_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `return_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoice_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|blocked|unmatched|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|on_hold|approved');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `spend_record_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `commodity_code_l1` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Level 1 (UNSPSC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `commodity_code_l2` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Level 2 (UNSPSC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `commodity_code_l3` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Level 3 (UNSPSC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `commodity_code_l4` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Level 4 (UNSPSC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `maverick_spend_flag` SET TAGS ('dbx_business_glossary_term' = 'Maverick Spend Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|pcard|eft');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `po_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `procurement_channel` SET TAGS ('dbx_business_glossary_term' = 'Procurement Channel');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `procurement_channel` SET TAGS ('dbx_value_regex' = 'po_based|non_po|pcard|blanket_release|contract_release');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `spend_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount (USD)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|mro|capex');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `supplier_segment` SET TAGS ('dbx_business_glossary_term' = 'Supplier Segment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `supplier_segment` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `project_document_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_value_regex' = 'approved|rejected|escalated|delegated|returned|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_document_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_document_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|purchase_order|rfq|rfp|contract|sourcing_event');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_due_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Approval Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Notification Sent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Approval Reminder Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_source_system` SET TAGS ('dbx_business_glossary_term' = 'Approval Source System');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|cancelled|expired');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `document_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Document Total Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `mandatory_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `parallel_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Parallel Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `policy_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `policy_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Acceptor ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Service Acceptance Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Acceptance Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Service Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptor_name` SET TAGS ('dbx_business_glossary_term' = 'Service Acceptor Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `gross_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Service Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Service Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Service Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_number` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_status` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_status` SET TAGS ('dbx_value_regex' = 'created|submitted|accepted|rejected|cancelled|posted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_type` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|subcontracting|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` SET TAGS ('dbx_subdomain' = 'supplier_master');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `parent_category_commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `tertiary_commodity_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `tertiary_commodity_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `tertiary_commodity_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|L4|L5');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|deprecated');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `contract_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `cost_reduction_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Reduction Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `lead_time_days_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `moq_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Applicable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `negotiation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `negotiation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `preferred_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `price_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Price Volatility Index');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `price_volatility_index` SET TAGS ('dbx_value_regex' = 'high|medium|low|stable');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Classification');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|multi_source|global_sourcing|local_sourcing');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|MRO|CapEx|services');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_class` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Class Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_commodity` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Commodity Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_family` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Family Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ALTER COLUMN `unspsc_segment` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Segment Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `sourcing_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `sourcing_strategy_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category (CAT)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `contract_coverage_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Target Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `contract_coverage_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `expected_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `is_global_strategy` SET TAGS ('dbx_business_glossary_term' = 'Is Global Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `make_vs_buy` SET TAGS ('dbx_business_glossary_term' = 'Make‑vs‑Buy Decision');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `make_vs_buy` SET TAGS ('dbx_value_regex' = 'make|buy|co_source');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Strategy Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `preferred_supplier_ids` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier IDs');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `savings_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Target Amount (STA)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `savings_target_currency` SET TAGS ('dbx_business_glossary_term' = 'Savings Target Currency (STC)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `sourcing_strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Strategy Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `sourcing_strategy_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategic_owner` SET TAGS ('dbx_business_glossary_term' = 'Strategic Owner (SO)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategic_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategic_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Strategy Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|multi_source|global|local');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `target_savings_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Savings Percentage (TSP)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `total_spend_last_year` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Last Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` SET TAGS ('dbx_subdomain' = 'supplier_master');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `approved_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `fixed_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DAP');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_business_glossary_term' = 'Info Record Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|pipeline|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `last_price_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'MRP Relevant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `order_quantity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Multiple');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Change Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_indicator` SET TAGS ('dbx_value_regex' = 'increase|decrease|no_change');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending|expired');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `source_of_supply_category` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `source_priority` SET TAGS ('dbx_business_glossary_term' = 'Source Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `tolerance_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Limit (%)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `vendor_price_list` SET TAGS ('dbx_business_glossary_term' = 'Vendor Price List');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` SET TAGS ('dbx_subdomain' = 'supplier_master');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_list_id` SET TAGS ('dbx_business_glossary_term' = 'Source List ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_list_description` SET TAGS ('dbx_business_glossary_term' = 'Source List Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `fixed_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `mrp_source_indicator` SET TAGS ('dbx_business_glossary_term' = 'MRP Source Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `mrp_source_indicator` SET TAGS ('dbx_value_regex' = 'standard|alternative|special');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `price_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Price Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `price_valid_to` SET TAGS ('dbx_business_glossary_term' = 'Price Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Source Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|mro|capital');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_list_status` SET TAGS ('dbx_business_glossary_term' = 'Source List Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source List Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_rating` SET TAGS ('dbx_business_glossary_term' = 'Source Rating');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'fixed|preferred|alternative|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
