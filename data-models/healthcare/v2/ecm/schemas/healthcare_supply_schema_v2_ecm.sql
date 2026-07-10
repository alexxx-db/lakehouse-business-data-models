-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`supply` COMMENT 'Healthcare supply chain and materials management. Owns medical-surgical supplies, implantable device tracking (UDI), prosthetics, procurement, inventory management, requisitions, par-level replenishment, expiration tracking, recall management, vendor management, BOM (Bill of Materials) for surgical procedures, and sterile processing. Integrates with Infor Lawson and SAP MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record.',
    `employee_id` BIGINT COMMENT 'Employee responsible for managing this material category.',
    `compliance_program_id` BIGINT COMMENT 'Compliance program governing this material.',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for expense posting.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for billing and reimbursement.',
    `ndc_drug_id` BIGINT COMMENT 'NDC drug reference for pharmaceutical items.',
    `vendor_id` BIGINT COMMENT 'Preferred vendor for this material.',
    `terminology_mapping_id` BIGINT COMMENT 'Terminology mapping for interoperability.',
    `approved_date` DATE COMMENT 'Date the material was approved for use.',
    `catalog_price` DECIMAL(18,2) COMMENT 'Catalog list price.',
    `cdm_charge_code` STRING COMMENT 'Charge description master code.',
    `commodity_code` STRING COMMENT 'The commodity code value classifying the supply material master record.',
    `contract_price` DECIMAL(18,2) COMMENT 'Contracted price.',
    `cost_center_code` STRING COMMENT 'The cost center code value classifying the supply material master record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dea_schedule` STRING COMMENT 'DEA schedule for controlled substances.',
    `discontinuation_date` DATE COMMENT 'Date the material was discontinued.',
    `fda_device_class` STRING COMMENT 'FDA device classification.',
    `fda_product_code` STRING COMMENT 'The fda product code value classifying the supply material master record.',
    `formulary_status` STRING COMMENT 'The formulary status value classifying the supply material master record.',
    `gl_account_code` STRING COMMENT 'General ledger account code.',
    `gtin` STRING COMMENT 'Global Trade Item Number.',
    `hcpcs_code` STRING COMMENT 'The hcpcs code value classifying the supply material master record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply material master record.',
    `is_controlled_substance` BOOLEAN COMMENT 'Flag indicating controlled substance.',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating hazardous material.',
    `is_implantable` BOOLEAN COMMENT 'Flag indicating implantable device.',
    `is_latex` BOOLEAN COMMENT 'Boolean flag indicating the is latex status of the supply material master record.',
    `is_latex_free` BOOLEAN COMMENT 'Flag indicating latex-free material.',
    `is_sterile` BOOLEAN COMMENT 'Flag indicating sterile material.',
    `item_category_code` STRING COMMENT 'The item category code value classifying the supply material master record.',
    `item_category_name` STRING COMMENT 'The item category name of the supply material master record.',
    `item_description` STRING COMMENT 'The item description of the supply material master record.',
    `item_number` STRING COMMENT 'The item number of the supply material master record.',
    `item_status` STRING COMMENT 'The item status value classifying the supply material master record.',
    `item_type` STRING COMMENT 'The item type value classifying the supply material master record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `lot_tracking_required` BOOLEAN COMMENT 'Flag indicating lot tracking required.',
    `manufacturer_catalog_number` STRING COMMENT 'The manufacturer catalog number of the supply material master record.',
    `manufacturer_item_number` STRING COMMENT 'The manufacturer item number of the supply material master record.',
    `manufacturer_name` STRING COMMENT 'The manufacturer name of the supply material master record.',
    `material_category` STRING COMMENT 'The material category of the supply material master record.',
    `material_description` STRING COMMENT 'The material description of the supply material master record.',
    `material_number` STRING COMMENT 'The material number of the supply material master record.',
    `ndc_code` STRING COMMENT 'National Drug Code.',
    `order_unit_of_measure` STRING COMMENT 'The order unit of measure of the supply material master record.',
    `par_level` DECIMAL(18,2) COMMENT 'The par level of the supply material master record.',
    `preferred_vendor_item_number` STRING COMMENT 'The preferred vendor item number of the supply material master record.',
    `recall_status` STRING COMMENT 'The recall status value classifying the supply material master record.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the supply material master record.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'The reorder quantity of the supply material master record.',
    `serial_tracking_required` BOOLEAN COMMENT 'Flag indicating serial tracking required.',
    `shelf_life_days` STRING COMMENT 'Shelf life in days.',
    `storage_location_type` STRING COMMENT 'The storage location type value classifying the supply material master record.',
    `storage_requirements` STRING COMMENT 'The storage requirements of the supply material master record.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in Celsius.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in Celsius.',
    `udi` STRING COMMENT 'Unique Device Identifier.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the supply material master record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply material master record.',
    `unspsc_code` STRING COMMENT 'The unspsc code value classifying the supply material master record.',
    `uom_conversion_factor` DECIMAL(18,2) COMMENT 'Unit of measure conversion factor.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply material master record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply material master record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply material master record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Master data for all materials, supplies, devices, and pharmaceuticals managed in the supply chain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor.',
    `employee_id` BIGINT COMMENT 'Account manager employee.',
    `compliance_program_id` BIGINT COMMENT 'Compliance program.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner for EDI.',
    `address_line1` STRING COMMENT 'The address line1 of the supply vendor record.',
    `address_line2` STRING COMMENT 'The address line2 of the supply vendor record.',
    `approved_date` DATE COMMENT 'Vendor approval date.',
    `bank_account_number` STRING COMMENT 'The bank account number of the supply vendor record.',
    `bank_routing_number` STRING COMMENT 'The bank routing number of the supply vendor record.',
    `city` STRING COMMENT 'The city of the supply vendor record.',
    `contact_email` STRING COMMENT 'The contact email of the supply vendor record.',
    `contact_name` STRING COMMENT 'The contact name of the supply vendor record.',
    `contact_phone` STRING COMMENT 'The contact phone of the supply vendor record.',
    `contract_end_date` DATE COMMENT 'Timestamp capturing the contract end date associated with the supply vendor record.',
    `contract_start_date` DATE COMMENT 'Timestamp capturing the contract start date associated with the supply vendor record.',
    `contract_tier` STRING COMMENT 'The contract tier of the supply vendor record.',
    `country_code` STRING COMMENT 'The country code value classifying the supply vendor record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply vendor record.',
    `dea_registration_number` STRING COMMENT 'The dea registration number of the supply vendor record.',
    `diversity_certification_expiration_date` DATE COMMENT 'Timestamp capturing the diversity certification expiration date associated with the supply vendor record.',
    `diversity_certification_number` STRING COMMENT 'The diversity certification number of the supply vendor record.',
    `diversity_classification` STRING COMMENT 'The diversity classification of the supply vendor record.',
    `doing_business_as_name` STRING COMMENT 'The doing business as name of the supply vendor record.',
    `duns_number` STRING COMMENT 'The duns number of the supply vendor record.',
    `edi_capable_flag` BOOLEAN COMMENT 'The edi capable flag of the supply vendor record.',
    `fda_establishment_number` STRING COMMENT 'The fda establishment number of the supply vendor record.',
    `fill_rate` DOUBLE COMMENT 'Fill rate percentage.',
    `gpo_affiliation` STRING COMMENT 'The gpo affiliation of the supply vendor record.',
    `gpo_contract_number` STRING COMMENT 'The gpo contract number of the supply vendor record.',
    `insurance_certificate_number` STRING COMMENT 'The insurance certificate number of the supply vendor record.',
    `insurance_expiration_date` DATE COMMENT 'Timestamp capturing the insurance expiration date associated with the supply vendor record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply vendor record.',
    `is_gpo_contracted` BOOLEAN COMMENT 'Boolean flag indicating the is gpo contracted status of the supply vendor record.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'The minimum order amount of the supply vendor record.',
    `vendor_name` STRING COMMENT 'The vendor name of the supply vendor record.',
    `npi` STRING COMMENT 'National Provider Identifier.',
    `oig_excluded_flag` BOOLEAN COMMENT 'OIG exclusion flag.',
    `oig_exclusion_checked_date` DATE COMMENT 'OIG exclusion check date.',
    `on_time_delivery_rate` DOUBLE COMMENT 'The on time delivery rate of the supply vendor record.',
    `payment_method` STRING COMMENT 'The payment method of the supply vendor record.',
    `payment_terms` STRING COMMENT 'The payment terms of the supply vendor record.',
    `performance_rating` DECIMAL(18,2) COMMENT 'The performance rating of the supply vendor record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the supply vendor record.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'The preferred vendor flag of the supply vendor record.',
    `primary_contact_email` STRING COMMENT 'The primary contact email of the supply vendor record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the supply vendor record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the supply vendor record.',
    `punchout_catalog_url` STRING COMMENT 'The punchout catalog url of the supply vendor record.',
    `recall_notification_flag` BOOLEAN COMMENT 'The recall notification flag of the supply vendor record.',
    `remittance_email` STRING COMMENT 'The remittance email of the supply vendor record.',
    `state_code` STRING COMMENT 'The state code value classifying the supply vendor record.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the supply vendor record.',
    `tax_number` STRING COMMENT 'Tax identification number.',
    `udi_capable_flag` BOOLEAN COMMENT 'The udi capable flag of the supply vendor record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_number` STRING COMMENT 'The vendor number of the supply vendor record.',
    `vendor_status` STRING COMMENT 'The vendor status value classifying the supply vendor record.',
    `vendor_type` STRING COMMENT 'The vendor type value classifying the supply vendor record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply vendor record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply vendor record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Vendor master data for all suppliers of materials, services, and equipment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order.',
    `employee_id` BIGINT COMMENT 'Buyer employee.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `chart_of_accounts_id` BIGINT COMMENT 'Chart of accounts.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the supply purchase order record.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period.',
    `inventory_location_id` BIGINT COMMENT 'Inventory location.',
    `payer_id` BIGINT COMMENT 'Reimbursement payer.',
    `requisition_id` BIGINT COMMENT 'Unique identifier for the requisition within the supply purchase order record.',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply purchase order record.',
    `actual_delivery_date` DATE COMMENT 'Timestamp capturing the actual delivery date associated with the supply purchase order record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the supply purchase order record.',
    `approved_date` DATE COMMENT 'Timestamp capturing the approved date associated with the supply purchase order record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `budget_year` STRING COMMENT 'The budget year of the supply purchase order record.',
    `buyer_name` STRING COMMENT 'The buyer name of the supply purchase order record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the supply purchase order record.',
    `confirmed_delivery_date` DATE COMMENT 'Timestamp capturing the confirmed delivery date associated with the supply purchase order record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply purchase order record.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount of the supply purchase order record.',
    `expected_delivery_date` DATE COMMENT 'Timestamp capturing the expected delivery date associated with the supply purchase order record.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight amount of the supply purchase order record.',
    `freight_terms_code` STRING COMMENT 'The freight terms code value classifying the supply purchase order record.',
    `fulfillment_status` STRING COMMENT 'The fulfillment status value classifying the supply purchase order record.',
    `gl_account_code` STRING COMMENT 'The gl account code value classifying the supply purchase order record.',
    `gpo_contract_number` STRING COMMENT 'The gpo contract number of the supply purchase order record.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The gross amount of the supply purchase order record.',
    `invoice_status` STRING COMMENT 'The invoice status value classifying the supply purchase order record.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Capital expenditure flag.',
    `is_contract_compliant` BOOLEAN COMMENT 'Contract compliant flag.',
    `is_emergency_order` BOOLEAN COMMENT 'Emergency order flag.',
    `line_item_count` STRING COMMENT 'The line item count of the supply purchase order record.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount of the supply purchase order record.',
    `notes` STRING COMMENT 'The notes of the supply purchase order record.',
    `order_date` DATE COMMENT 'Timestamp capturing the order date associated with the supply purchase order record.',
    `payment_terms_code` STRING COMMENT 'The payment terms code value classifying the supply purchase order record.',
    `po_number` STRING COMMENT 'The po number of the supply purchase order record.',
    `po_status` STRING COMMENT 'The po status value classifying the supply purchase order record.',
    `po_type` STRING COMMENT 'The po type value classifying the supply purchase order record.',
    `purchasing_group_code` STRING COMMENT 'The purchasing group code value classifying the supply purchase order record.',
    `purchasing_org_code` STRING COMMENT 'The purchasing org code value classifying the supply purchase order record.',
    `requested_delivery_date` DATE COMMENT 'Timestamp capturing the requested delivery date associated with the supply purchase order record.',
    `ship_to_location` STRING COMMENT 'The ship to location of the supply purchase order record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply purchase order record.',
    `source_system_po_key` STRING COMMENT 'The source system po key of the supply purchase order record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount of the supply purchase order record.',
    `three_way_match_status` STRING COMMENT 'The three way match status value classifying the supply purchase order record.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the supply purchase order record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_quote_number` STRING COMMENT 'The vendor quote number of the supply purchase order record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply purchase order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply purchase order record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase orders issued to vendors for materials and services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `chart_of_accounts_id` BIGINT COMMENT 'Chart of accounts.',
    `fund_id` BIGINT COMMENT 'Unique identifier for the fund within the supply purchase order line record.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `material_master_id` BIGINT COMMENT 'Material master.',
    `requisition_id` BIGINT COMMENT 'Requisition.',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply purchase order line record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the supply purchase order line record.',
    `approved_by` STRING COMMENT 'The approved by of the supply purchase order line record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The backorder quantity of the supply purchase order line record.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'The cancelled quantity of the supply purchase order line record.',
    `cost_center_code` STRING COMMENT 'The cost center code value classifying the supply purchase order line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply purchase order line record.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percent of the supply purchase order line record.',
    `expected_delivery_date` DATE COMMENT 'Timestamp capturing the expected delivery date associated with the supply purchase order line record.',
    `expense_type` STRING COMMENT 'The expense type value classifying the supply purchase order line record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply purchase order line record.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The extended amount of the supply purchase order line record.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight amount of the supply purchase order line record.',
    `gl_account_code` STRING COMMENT 'The gl account code value classifying the supply purchase order line record.',
    `gpo_contract_number` STRING COMMENT 'The gpo contract number of the supply purchase order line record.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The invoiced quantity of the supply purchase order line record.',
    `is_contract_item` BOOLEAN COMMENT 'Contract item flag.',
    `is_formulary_item` BOOLEAN COMMENT 'Formulary item flag.',
    `is_recall_active` BOOLEAN COMMENT 'Recall active flag.',
    `item_category` STRING COMMENT 'The item category of the supply purchase order line record.',
    `item_description` STRING COMMENT 'The item description of the supply purchase order line record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supply purchase order line record.',
    `line_number` STRING COMMENT 'The line number of the supply purchase order line record.',
    `line_status` STRING COMMENT 'The line status value classifying the supply purchase order line record.',
    `line_type` STRING COMMENT 'The line type value classifying the supply purchase order line record.',
    `lot_number` STRING COMMENT 'The lot number of the supply purchase order line record.',
    `material_description` STRING COMMENT 'The material description of the supply purchase order line record.',
    `ndc_code` STRING COMMENT 'The ndc code value classifying the supply purchase order line record.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The ordered quantity of the supply purchase order line record.',
    `promised_delivery_date` DATE COMMENT 'Timestamp capturing the promised delivery date associated with the supply purchase order line record.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity ordered of the supply purchase order line record.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The quantity received of the supply purchase order line record.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the supply purchase order line record.',
    `requested_delivery_date` DATE COMMENT 'Timestamp capturing the requested delivery date associated with the supply purchase order line record.',
    `ship_to_location_code` STRING COMMENT 'The ship to location code value classifying the supply purchase order line record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply purchase order line record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount of the supply purchase order line record.',
    `udi` STRING COMMENT 'The udi of the supply purchase order line record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply purchase order line record.',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the supply purchase order line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply purchase order line record.',
    `vendor_item_number` STRING COMMENT 'The vendor item number of the supply purchase order line record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply purchase order line record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply purchase order line record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line items on purchase orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `chart_of_accounts_id` BIGINT COMMENT 'Chart of accounts.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period.',
    `inventory_location_id` BIGINT COMMENT 'Inventory location.',
    `material_master_id` BIGINT COMMENT 'Material master.',
    `employee_id` BIGINT COMMENT 'Goods received by employee.',
    `purchase_order_line_id` BIGINT COMMENT 'Purchase order line.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply goods receipt record.',
    `condition_on_receipt` STRING COMMENT 'The condition on receipt of the supply goods receipt record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply goods receipt record.',
    `delivery_note_number` STRING COMMENT 'The delivery note number of the supply goods receipt record.',
    `discrepancy_flag` BOOLEAN COMMENT 'The discrepancy flag of the supply goods receipt record.',
    `discrepancy_notes` STRING COMMENT 'The discrepancy notes of the supply goods receipt record.',
    `discrepancy_type` STRING COMMENT 'The discrepancy type value classifying the supply goods receipt record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply goods receipt record.',
    `implantable_device_flag` BOOLEAN COMMENT 'The implantable device flag of the supply goods receipt record.',
    `inspection_status` STRING COMMENT 'The inspection status value classifying the supply goods receipt record.',
    `inventory_update_flag` BOOLEAN COMMENT 'The inventory update flag of the supply goods receipt record.',
    `lot_number` STRING COMMENT 'The lot number of the supply goods receipt record.',
    `manufacture_date` DATE COMMENT 'Timestamp capturing the manufacture date associated with the supply goods receipt record.',
    `movement_type` STRING COMMENT 'The movement type value classifying the supply goods receipt record.',
    `packing_slip_number` STRING COMMENT 'The packing slip number of the supply goods receipt record.',
    `plant_code` STRING COMMENT 'The plant code value classifying the supply goods receipt record.',
    `posting_timestamp` TIMESTAMP COMMENT 'The posting timestamp of the supply goods receipt record.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity accepted of the supply goods receipt record.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity ordered of the supply goods receipt record.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The quantity received of the supply goods receipt record.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity rejected of the supply goods receipt record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply goods receipt record.',
    `recall_reference_number` STRING COMMENT 'The recall reference number of the supply goods receipt record.',
    `receipt_date` DATE COMMENT 'Timestamp capturing the receipt date associated with the supply goods receipt record.',
    `receipt_number` STRING COMMENT 'The receipt number of the supply goods receipt record.',
    `receipt_status` STRING COMMENT 'The receipt status value classifying the supply goods receipt record.',
    `received_by` STRING COMMENT 'The received by of the supply goods receipt record.',
    `serial_number` STRING COMMENT 'The serial number of the supply goods receipt record.',
    `source_document_number` STRING COMMENT 'The source document number of the supply goods receipt record.',
    `sterile_processing_required` BOOLEAN COMMENT 'The sterile processing required of the supply goods receipt record.',
    `storage_condition` STRING COMMENT 'The storage condition of the supply goods receipt record.',
    `temperature_excursion_flag` BOOLEAN COMMENT 'The temperature excursion flag of the supply goods receipt record.',
    `three_way_match_status` STRING COMMENT 'The three way match status value classifying the supply goods receipt record.',
    `total_receipt_value` DECIMAL(18,2) COMMENT 'The total receipt value of the supply goods receipt record.',
    `udi_device_identifier` STRING COMMENT 'The udi device identifier of the supply goods receipt record.',
    `udi_production_identifier` STRING COMMENT 'The udi production identifier of the supply goods receipt record.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the supply goods receipt record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply goods receipt record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_invoice_number` STRING COMMENT 'The vendor invoice number of the supply goods receipt record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply goods receipt record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply goods receipt record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt records for materials received from vendors.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` (
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location.',
    `building_id` BIGINT COMMENT 'Unique identifier for the building within the supply inventory location record.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `equipment_asset_id` BIGINT COMMENT 'Equipment asset.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the supply inventory location record.',
    `parent_location_inventory_location_id` BIGINT COMMENT 'Parent location.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the supply inventory location record.',
    `access_restriction_level` STRING COMMENT 'The access restriction level of the supply inventory location record.',
    `adc_manufacturer` STRING COMMENT 'The adc manufacturer of the supply inventory location record.',
    `bin_aisle` STRING COMMENT 'The bin aisle of the supply inventory location record.',
    `bin_shelf` STRING COMMENT 'The bin shelf of the supply inventory location record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cycle_count_frequency` STRING COMMENT 'The cycle count frequency of the supply inventory location record.',
    `deactivation_date` DATE COMMENT 'Timestamp capturing the deactivation date associated with the supply inventory location record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the supply inventory location record.',
    `expiration_tracking_enabled` BOOLEAN COMMENT 'The expiration tracking enabled of the supply inventory location record.',
    `floor_number` STRING COMMENT 'The floor number of the supply inventory location record.',
    `gl_account_code` STRING COMMENT 'The gl account code value classifying the supply inventory location record.',
    `hazardous_material_storage` BOOLEAN COMMENT 'The hazardous material storage of the supply inventory location record.',
    `humidity_controlled` BOOLEAN COMMENT 'The humidity controlled of the supply inventory location record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply inventory location record.',
    `is_par_location` BOOLEAN COMMENT 'Boolean flag indicating the is par location status of the supply inventory location record.',
    `last_cycle_count_date` DATE COMMENT 'Timestamp capturing the last cycle count date associated with the supply inventory location record.',
    `lawson_location_code` STRING COMMENT 'The lawson location code value classifying the supply inventory location record.',
    `location_code` STRING COMMENT 'The location code value classifying the supply inventory location record.',
    `location_name` STRING COMMENT 'The location name of the supply inventory location record.',
    `location_notes` STRING COMMENT 'The location notes of the supply inventory location record.',
    `location_status` STRING COMMENT 'The location status value classifying the supply inventory location record.',
    `location_type` STRING COMMENT 'The location type value classifying the supply inventory location record.',
    `managing_department` STRING COMMENT 'The managing department of the supply inventory location record.',
    `next_cycle_count_date` DATE COMMENT 'Timestamp capturing the next cycle count date associated with the supply inventory location record.',
    `par_level_managed` BOOLEAN COMMENT 'The par level managed of the supply inventory location record.',
    `par_replenishment_method` STRING COMMENT 'The par replenishment method of the supply inventory location record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the supply inventory location record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the supply inventory location record.',
    `recall_management_enabled` BOOLEAN COMMENT 'The recall management enabled of the supply inventory location record.',
    `replenishment_frequency` STRING COMMENT 'The replenishment frequency of the supply inventory location record.',
    `sap_storage_location_code` STRING COMMENT 'The sap storage location code value classifying the supply inventory location record.',
    `secure_controlled_substance` BOOLEAN COMMENT 'The secure controlled substance of the supply inventory location record.',
    `sterile_processing_staging` BOOLEAN COMMENT 'The sterile processing staging of the supply inventory location record.',
    `storage_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'The storage capacity cubic ft of the supply inventory location record.',
    `storage_capacity_units` STRING COMMENT 'The storage capacity units of the supply inventory location record.',
    `storage_type` STRING COMMENT 'The storage type value classifying the supply inventory location record.',
    `temperature_controlled` BOOLEAN COMMENT 'The temperature controlled of the supply inventory location record.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'The temperature max celsius of the supply inventory location record.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'The temperature min celsius of the supply inventory location record.',
    `temperature_requirement` STRING COMMENT 'The temperature requirement of the supply inventory location record.',
    `udi_tracking_enabled` BOOLEAN COMMENT 'The udi tracking enabled of the supply inventory location record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply inventory location record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply inventory location record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_inventory_location PRIMARY KEY(`inventory_location_id`)
) COMMENT 'Physical locations where inventory is stored.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique identifier for the inventory balance.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `inventory_location_id` BIGINT COMMENT 'Inventory location.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the inventory material master within the supply inventory balance record.',
    `primary_inventory_material_master_id` BIGINT COMMENT 'Primary inventory material master.',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply inventory balance record.',
    `abc_classification` STRING COMMENT 'The abc classification of the supply inventory balance record.',
    `balance_snapshot_timestamp` TIMESTAMP COMMENT 'The balance snapshot timestamp of the supply inventory balance record.',
    `below_reorder_flag` BOOLEAN COMMENT 'The below reorder flag of the supply inventory balance record.',
    `consignment_vendor_number` STRING COMMENT 'The consignment vendor number of the supply inventory balance record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the supply inventory balance record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply inventory balance record.',
    `days_to_expiration` STRING COMMENT 'The days to expiration of the supply inventory balance record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply inventory balance record.',
    `formulary_flag` BOOLEAN COMMENT 'The formulary flag of the supply inventory balance record.',
    `inventory_status` STRING COMMENT 'The inventory status value classifying the supply inventory balance record.',
    `item_category` STRING COMMENT 'The item category of the supply inventory balance record.',
    `last_count_date` DATE COMMENT 'Timestamp capturing the last count date associated with the supply inventory balance record.',
    `last_movement_date` DATE COMMENT 'Timestamp capturing the last movement date associated with the supply inventory balance record.',
    `last_physical_count_date` DATE COMMENT 'Timestamp capturing the last physical count date associated with the supply inventory balance record.',
    `last_physical_count_qty` DECIMAL(18,2) COMMENT 'The last physical count qty of the supply inventory balance record.',
    `last_receipt_date` DATE COMMENT 'Timestamp capturing the last receipt date associated with the supply inventory balance record.',
    `lot_number` STRING COMMENT 'The lot number of the supply inventory balance record.',
    `lot_tracking_enabled` BOOLEAN COMMENT 'The lot tracking enabled of the supply inventory balance record.',
    `max_level` DECIMAL(18,2) COMMENT 'The max level of the supply inventory balance record.',
    `ndc_code` STRING COMMENT 'The ndc code value classifying the supply inventory balance record.',
    `ownership_type` STRING COMMENT 'The ownership type value classifying the supply inventory balance record.',
    `par_level` DECIMAL(18,2) COMMENT 'The par level of the supply inventory balance record.',
    `qty_in_transit` DECIMAL(18,2) COMMENT 'The qty in transit of the supply inventory balance record.',
    `qty_on_hand` DECIMAL(18,2) COMMENT 'The qty on hand of the supply inventory balance record.',
    `qty_on_order` DECIMAL(18,2) COMMENT 'The qty on order of the supply inventory balance record.',
    `qty_quarantine` DECIMAL(18,2) COMMENT 'The qty quarantine of the supply inventory balance record.',
    `qty_reserved` DECIMAL(18,2) COMMENT 'The qty reserved of the supply inventory balance record.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity allocated of the supply inventory balance record.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The quantity available of the supply inventory balance record.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the supply inventory balance record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply inventory balance record.',
    `recall_number` STRING COMMENT 'The recall number of the supply inventory balance record.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the supply inventory balance record.',
    `replenishment_method` STRING COMMENT 'The replenishment method of the supply inventory balance record.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'The safety stock qty of the supply inventory balance record.',
    `serial_tracking_enabled` BOOLEAN COMMENT 'The serial tracking enabled of the supply inventory balance record.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The snapshot timestamp of the supply inventory balance record.',
    `source_record_key` STRING COMMENT 'The source record key of the supply inventory balance record.',
    `stockout_flag` BOOLEAN COMMENT 'The stockout flag of the supply inventory balance record.',
    `storage_bin` STRING COMMENT 'The storage bin of the supply inventory balance record.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the supply inventory balance record.',
    `udi_code` STRING COMMENT 'The udi code value classifying the supply inventory balance record.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the supply inventory balance record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply inventory balance record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply inventory balance record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply inventory balance record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply inventory balance record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Current inventory balances by location and material.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` (
    `inventory_transaction_id` BIGINT COMMENT 'Unique identifier for the inventory transaction.',
    `case_cart_id` BIGINT COMMENT 'Case cart.',
    `chart_of_accounts_id` BIGINT COMMENT 'Chart of accounts.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the supply inventory transaction record.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period.',
    `goods_receipt_id` BIGINT COMMENT 'Goods receipt.',
    `inventory_location_id` BIGINT COMMENT 'Inventory location.',
    `material_master_id` BIGINT COMMENT 'Material master.',
    `employee_id` BIGINT COMMENT 'Performed by employee.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order.',
    `recall_notice_id` BIGINT COMMENT 'Recall notice.',
    `requisition_id` BIGINT COMMENT 'Requisition.',
    `source_inventory_transaction_id` BIGINT COMMENT 'Source transaction.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply inventory transaction record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the supply inventory transaction record.',
    `count_variance_quantity` DECIMAL(18,2) COMMENT 'The count variance quantity of the supply inventory transaction record.',
    `count_variance_value` DECIMAL(18,2) COMMENT 'The count variance value of the supply inventory transaction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply inventory transaction record.',
    `destination_storage_location` STRING COMMENT 'The destination storage location of the supply inventory transaction record.',
    `document_date` DATE COMMENT 'Timestamp capturing the document date associated with the supply inventory transaction record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply inventory transaction record.',
    `extended_cost` DECIMAL(18,2) COMMENT 'The extended cost of the supply inventory transaction record.',
    `gl_account_code` STRING COMMENT 'The gl account code value classifying the supply inventory transaction record.',
    `is_reversal` BOOLEAN COMMENT 'Boolean flag indicating the is reversal status of the supply inventory transaction record.',
    `issuing_department_code` STRING COMMENT 'The issuing department code value classifying the supply inventory transaction record.',
    `lot_number` STRING COMMENT 'The lot number of the supply inventory transaction record.',
    `material_document_number` STRING COMMENT 'The material document number of the supply inventory transaction record.',
    `material_document_year` STRING COMMENT 'The material document year of the supply inventory transaction record.',
    `movement_category` STRING COMMENT 'The movement category of the supply inventory transaction record.',
    `movement_type_code` STRING COMMENT 'The movement type code value classifying the supply inventory transaction record.',
    `movement_type_description` STRING COMMENT 'The movement type description of the supply inventory transaction record.',
    `par_location_code` STRING COMMENT 'The par location code value classifying the supply inventory transaction record.',
    `performed_by` STRING COMMENT 'The performed by of the supply inventory transaction record.',
    `plant_code` STRING COMMENT 'The plant code value classifying the supply inventory transaction record.',
    `posting_date` DATE COMMENT 'Timestamp capturing the posting date associated with the supply inventory transaction record.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supply inventory transaction record.',
    `reason_code` STRING COMMENT 'The reason code value classifying the supply inventory transaction record.',
    `reason_description` STRING COMMENT 'The reason description of the supply inventory transaction record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply inventory transaction record.',
    `reversed_document_number` STRING COMMENT 'The reversed document number of the supply inventory transaction record.',
    `serial_number` STRING COMMENT 'The serial number of the supply inventory transaction record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply inventory transaction record.',
    `sterile_processing_indicator` BOOLEAN COMMENT 'The sterile processing indicator of the supply inventory transaction record.',
    `transaction_number` STRING COMMENT 'The transaction number of the supply inventory transaction record.',
    `transaction_status` STRING COMMENT 'The transaction status value classifying the supply inventory transaction record.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The transaction timestamp of the supply inventory transaction record.',
    `transaction_type` STRING COMMENT 'The transaction type value classifying the supply inventory transaction record.',
    `udi_code` STRING COMMENT 'The udi code value classifying the supply inventory transaction record.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the supply inventory transaction record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply inventory transaction record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply inventory transaction record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply inventory transaction record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_inventory_transaction PRIMARY KEY(`inventory_transaction_id`)
) COMMENT 'All inventory movements and transactions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the requisition.',
    `employee_id` BIGINT COMMENT 'Approver employee.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location within the supply requisition record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the supply requisition record.',
    `recall_notice_id` BIGINT COMMENT 'Recall notice.',
    `requester_employee_id` BIGINT COMMENT 'Requester employee.',
    `surgical_bom_id` BIGINT COMMENT 'Surgical BOM.',
    `clinical_order_id` BIGINT COMMENT 'Triggering clinical order.',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the supply requisition record.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'The actual total cost of the supply requisition record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the supply requisition record.',
    `approved_by` STRING COMMENT 'The approved by of the supply requisition record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `budget_period` STRING COMMENT 'The budget period of the supply requisition record.',
    `clinical_justification` STRING COMMENT 'The clinical justification of the supply requisition record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply requisition record.',
    `delivery_location` STRING COMMENT 'The delivery location of the supply requisition record.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'The estimated total cost of the supply requisition record.',
    `expiration_tracking_required` BOOLEAN COMMENT 'The expiration tracking required of the supply requisition record.',
    `fulfilled_date` DATE COMMENT 'Timestamp capturing the fulfilled date associated with the supply requisition record.',
    `fulfillment_method` STRING COMMENT 'The fulfillment method of the supply requisition record.',
    `gl_account_code` STRING COMMENT 'The gl account code value classifying the supply requisition record.',
    `hazmat_flag` BOOLEAN COMMENT 'The hazmat flag of the supply requisition record.',
    `is_capital_expense` BOOLEAN COMMENT 'Boolean flag indicating the is capital expense status of the supply requisition record.',
    `is_par_triggered` BOOLEAN COMMENT 'Boolean flag indicating the is par triggered status of the supply requisition record.',
    `is_recall_related` BOOLEAN COMMENT 'Boolean flag indicating the is recall related status of the supply requisition record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the supply requisition record.',
    `needed_by_date` DATE COMMENT 'Timestamp capturing the needed by date associated with the supply requisition record.',
    `notes` STRING COMMENT 'The notes of the supply requisition record.',
    `priority` STRING COMMENT 'The priority of the supply requisition record.',
    `rejection_reason` STRING COMMENT 'The rejection reason of the supply requisition record.',
    `requested_by` STRING COMMENT 'The requested by of the supply requisition record.',
    `requested_date` DATE COMMENT 'Timestamp capturing the requested date associated with the supply requisition record.',
    `requester_name` STRING COMMENT 'The requester name of the supply requisition record.',
    `requesting_department_name` STRING COMMENT 'The requesting department name of the supply requisition record.',
    `requisition_number` STRING COMMENT 'The requisition number of the supply requisition record.',
    `requisition_status` STRING COMMENT 'The requisition status value classifying the supply requisition record.',
    `requisition_type` STRING COMMENT 'The requisition type value classifying the supply requisition record.',
    `source_system_key` STRING COMMENT 'The source system key of the supply requisition record.',
    `sterile_processing_required` BOOLEAN COMMENT 'The sterile processing required of the supply requisition record.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The submitted timestamp of the supply requisition record.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the supply requisition record.',
    `total_line_count` STRING COMMENT 'The total line count of the supply requisition record.',
    `udi_required` BOOLEAN COMMENT 'The udi required of the supply requisition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply requisition record.',
    `urgency_level` STRING COMMENT 'The urgency level of the supply requisition record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply requisition record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply requisition record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal requisitions for materials and supplies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`udi_record` (
    `udi_record_id` BIGINT COMMENT 'Unique identifier for the UDI record.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order.',
    `clinician_id` BIGINT COMMENT 'Clinician.',
    `demographics_id` BIGINT COMMENT 'Demographics.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `material_master_id` BIGINT COMMENT 'Material master.',
    `vendor_id` BIGINT COMMENT 'Primary UDI vendor.',
    `procedure_event_id` BIGINT COMMENT 'Procedure event.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the supply udi record record.',
    `brand_name` STRING COMMENT 'The brand name of the supply udi record record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `device_identifier` STRING COMMENT 'The device identifier of the supply udi record record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply udi record record.',
    `explant_date` DATE COMMENT 'Timestamp capturing the explant date associated with the supply udi record record.',
    `explant_reason` STRING COMMENT 'The explant reason of the supply udi record record.',
    `full_udi` STRING COMMENT 'The full udi of the supply udi record record.',
    `gmdn_code` STRING COMMENT 'The gmdn code value classifying the supply udi record record.',
    `gudid_public_version` STRING COMMENT 'The gudid public version of the supply udi record record.',
    `implant_date` DATE COMMENT 'Timestamp capturing the implant date associated with the supply udi record record.',
    `implant_site` STRING COMMENT 'The implant site of the supply udi record record.',
    `implant_status` STRING COMMENT 'The implant status value classifying the supply udi record record.',
    `implantable_flag` BOOLEAN COMMENT 'The implantable flag of the supply udi record record.',
    `is_implantable` BOOLEAN COMMENT 'Boolean flag indicating the is implantable status of the supply udi record record.',
    `issuing_agency` STRING COMMENT 'The issuing agency of the supply udi record record.',
    `laterality` STRING COMMENT 'The laterality of the supply udi record record.',
    `location_code` STRING COMMENT 'The location code value classifying the supply udi record record.',
    `lot_number` STRING COMMENT 'The lot number of the supply udi record record.',
    `manufacture_date` DATE COMMENT 'Timestamp capturing the manufacture date associated with the supply udi record record.',
    `manufacturing_date` DATE COMMENT 'Timestamp capturing the manufacturing date associated with the supply udi record record.',
    `mdr_reportable_flag` BOOLEAN COMMENT 'The mdr reportable flag of the supply udi record record.',
    `production_identifier` STRING COMMENT 'The production identifier of the supply udi record record.',
    `recall_class` STRING COMMENT 'The recall class of the supply udi record record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply udi record record.',
    `recall_number` STRING COMMENT 'The recall number of the supply udi record record.',
    `recall_remediation_status` STRING COMMENT 'The recall remediation status value classifying the supply udi record record.',
    `receiving_date` DATE COMMENT 'Timestamp capturing the receiving date associated with the supply udi record record.',
    `serial_number` STRING COMMENT 'The serial number of the supply udi record record.',
    `single_use_flag` BOOLEAN COMMENT 'The single use flag of the supply udi record record.',
    `source_system_record_code` STRING COMMENT 'The source system record code value classifying the supply udi record record.',
    `sterile_flag` BOOLEAN COMMENT 'The sterile flag of the supply udi record record.',
    `storage_condition` STRING COMMENT 'The storage condition of the supply udi record record.',
    `udi_carrier_aidc` STRING COMMENT 'The udi carrier aidc of the supply udi record record.',
    `udi_carrier_hrf` STRING COMMENT 'The udi carrier hrf of the supply udi record record.',
    `udi_device_identifier` STRING COMMENT 'The udi device identifier of the supply udi record record.',
    `udi_production_identifier` STRING COMMENT 'The udi production identifier of the supply udi record record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply udi record record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply udi record record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_udi_record PRIMARY KEY(`udi_record_id`)
) COMMENT 'Unique Device Identifier records for implantable and trackable devices.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` (
    `surgical_bom_id` BIGINT COMMENT 'Unique identifier for the surgical BOM.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `compliance_policy_id` BIGINT COMMENT 'Compliance policy.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the supply surgical bom record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the supply surgical bom record.',
    `preference_card_id` BIGINT COMMENT 'Preference card.',
    `employee_id` BIGINT COMMENT 'Primary surgical approved by employee.',
    `service_id` BIGINT COMMENT 'Unique identifier for the service within the supply surgical bom record.',
    `set_id` BIGINT COMMENT 'Standardized order set.',
    `tertiary_surgical_supply_chain_owner_employee_id` BIGINT COMMENT 'Tertiary surgical supply chain owner employee.',
    `anesthesia_type` STRING COMMENT 'The anesthesia type value classifying the supply surgical bom record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the supply surgical bom record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the supply surgical bom record.',
    `bom_name` STRING COMMENT 'The bom name of the supply surgical bom record.',
    `bom_number` STRING COMMENT 'The bom number of the supply surgical bom record.',
    `bom_status` STRING COMMENT 'The bom status value classifying the supply surgical bom record.',
    `bom_version` STRING COMMENT 'The bom version of the supply surgical bom record.',
    `case_cart_template_flag` BOOLEAN COMMENT 'The case cart template flag of the supply surgical bom record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply surgical bom record.',
    `drg_code` STRING COMMENT 'The drg code value classifying the supply surgical bom record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the supply surgical bom record.',
    `estimated_case_duration_min` STRING COMMENT 'The estimated case duration min of the supply surgical bom record.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated cost of the supply surgical bom record.',
    `estimated_implant_cost` DECIMAL(18,2) COMMENT 'The estimated implant cost of the supply surgical bom record.',
    `estimated_supply_cost` DECIMAL(18,2) COMMENT 'The estimated supply cost of the supply surgical bom record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply surgical bom record.',
    `implant_required_flag` BOOLEAN COMMENT 'The implant required flag of the supply surgical bom record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply surgical bom record.',
    `is_disposable` BOOLEAN COMMENT 'Boolean flag indicating the is disposable status of the supply surgical bom record.',
    `item_count` STRING COMMENT 'The item count of the supply surgical bom record.',
    `last_reviewed_date` DATE COMMENT 'Timestamp capturing the last reviewed date associated with the supply surgical bom record.',
    `notes` STRING COMMENT 'The notes of the supply surgical bom record.',
    `or_room_type` STRING COMMENT 'The or room type value classifying the supply surgical bom record.',
    `patient_position` STRING COMMENT 'The patient position of the supply surgical bom record.',
    `procedure_category` STRING COMMENT 'The procedure category of the supply surgical bom record.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the supply surgical bom record.',
    `procedure_name` STRING COMMENT 'The procedure name of the supply surgical bom record.',
    `quantity_required` DECIMAL(18,2) COMMENT 'The quantity required of the supply surgical bom record.',
    `recall_review_required_flag` BOOLEAN COMMENT 'The recall review required flag of the supply surgical bom record.',
    `review_frequency_days` STRING COMMENT 'The review frequency days of the supply surgical bom record.',
    `source_system_bom_code` STRING COMMENT 'The source system bom code value classifying the supply surgical bom record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply surgical bom record.',
    `sterile_processing_required_flag` BOOLEAN COMMENT 'The sterile processing required flag of the supply surgical bom record.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'The substitution allowed flag of the supply surgical bom record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply surgical bom record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply surgical bom record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply surgical bom record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_surgical_bom PRIMARY KEY(`surgical_bom_id`)
) COMMENT 'Bill of materials for surgical procedures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`case_cart` (
    `case_cart_id` BIGINT COMMENT 'Unique identifier for the case cart.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `clinician_id` BIGINT COMMENT 'Clinician.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the supply case cart record.',
    `clinical_order_id` BIGINT COMMENT 'Fulfilling clinical order.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the supply case cart record.',
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the or suite within the supply case cart record.',
    `employee_id` BIGINT COMMENT 'Primary case assembled by employee.',
    `recall_notice_id` BIGINT COMMENT 'Recall notice.',
    `surgical_bom_id` BIGINT COMMENT 'Surgical BOM.',
    `tertiary_case_delivered_by_employee_id` BIGINT COMMENT 'Tertiary case delivered by employee.',
    `assembly_complete_timestamp` TIMESTAMP COMMENT 'The assembly complete timestamp of the supply case cart record.',
    `assembly_location` STRING COMMENT 'The assembly location of the supply case cart record.',
    `assembly_start_timestamp` TIMESTAMP COMMENT 'The assembly start timestamp of the supply case cart record.',
    `assembly_status` STRING COMMENT 'The assembly status value classifying the supply case cart record.',
    `cart_number` STRING COMMENT 'The cart number of the supply case cart record.',
    `cart_status` STRING COMMENT 'The cart status value classifying the supply case cart record.',
    `case_cart_type` STRING COMMENT 'The case cart type value classifying the supply case cart record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply case cart record.',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'The delivery confirmation flag of the supply case cart record.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the supply case cart record.',
    `expiration_check_flag` BOOLEAN COMMENT 'The expiration check flag of the supply case cart record.',
    `implant_flag` BOOLEAN COMMENT 'The implant flag of the supply case cart record.',
    `items_picked_count` STRING COMMENT 'The items picked count of the supply case cart record.',
    `items_requested_count` STRING COMMENT 'The items requested count of the supply case cart record.',
    `items_returned_count` STRING COMMENT 'The items returned count of the supply case cart record.',
    `items_wasted_count` STRING COMMENT 'The items wasted count of the supply case cart record.',
    `missing_item_count` STRING COMMENT 'The missing item count of the supply case cart record.',
    `missing_item_flag` BOOLEAN COMMENT 'The missing item flag of the supply case cart record.',
    `notes` STRING COMMENT 'The notes of the supply case cart record.',
    `or_room_name` STRING COMMENT 'The or room name of the supply case cart record.',
    `picked_by` STRING COMMENT 'The picked by of the supply case cart record.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The picked quantity of the supply case cart record.',
    `picked_timestamp` TIMESTAMP COMMENT 'The picked timestamp of the supply case cart record.',
    `priority_level` STRING COMMENT 'The priority level of the supply case cart record.',
    `procedure_type` STRING COMMENT 'The procedure type value classifying the supply case cart record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply case cart record.',
    `return_timestamp` TIMESTAMP COMMENT 'The return timestamp of the supply case cart record.',
    `returned_quantity` DECIMAL(18,2) COMMENT 'The returned quantity of the supply case cart record.',
    `scheduled_case_date` DATE COMMENT 'Timestamp capturing the scheduled case date associated with the supply case cart record.',
    `scheduled_procedure_date` DATE COMMENT 'Timestamp capturing the scheduled procedure date associated with the supply case cart record.',
    `scheduled_procedure_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled procedure time associated with the supply case cart record.',
    `sterility_verified_flag` BOOLEAN COMMENT 'The sterility verified flag of the supply case cart record.',
    `substitution_count` STRING COMMENT 'The substitution count of the supply case cart record.',
    `substitution_flag` BOOLEAN COMMENT 'The substitution flag of the supply case cart record.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the supply case cart record.',
    `total_supply_cost` DECIMAL(18,2) COMMENT 'The total supply cost of the supply case cart record.',
    `udi_required_flag` BOOLEAN COMMENT 'The udi required flag of the supply case cart record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `used_quantity` DECIMAL(18,2) COMMENT 'The used quantity of the supply case cart record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply case cart record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply case cart record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `waste_cost` DECIMAL(18,2) COMMENT 'The waste cost of the supply case cart record.',
    CONSTRAINT pk_case_cart PRIMARY KEY(`case_cart_id`)
) COMMENT 'Case carts assembled for surgical procedures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` (
    `sterile_processing_record_id` BIGINT COMMENT 'Unique identifier for the sterile processing record.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `case_cart_id` BIGINT COMMENT 'Case cart.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order.',
    `equipment_asset_id` BIGINT COMMENT 'Equipment asset.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the supply sterile processing record record.',
    `employee_id` BIGINT COMMENT 'Primary sterile technician employee.',
    `recall_notice_id` BIGINT COMMENT 'Recall notice.',
    `sterilizer_equipment_asset_id` BIGINT COMMENT 'Unique identifier for the sterilizer equipment asset within the supply sterile processing record record.',
    `surgical_case_id` BIGINT COMMENT 'Surgical case.',
    `assembly_timestamp` TIMESTAMP COMMENT 'The assembly timestamp of the supply sterile processing record record.',
    `biological_indicator_lot` STRING COMMENT 'The biological indicator lot of the supply sterile processing record record.',
    `biological_indicator_result` STRING COMMENT 'The biological indicator result of the supply sterile processing record record.',
    `bowie_dick_result` STRING COMMENT 'The bowie dick result of the supply sterile processing record record.',
    `chemical_indicator_result` STRING COMMENT 'The chemical indicator result of the supply sterile processing record record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cycle_number` STRING COMMENT 'The cycle number of the supply sterile processing record record.',
    `cycle_timestamp` TIMESTAMP COMMENT 'The cycle timestamp of the supply sterile processing record record.',
    `cycle_type` STRING COMMENT 'The cycle type value classifying the supply sterile processing record record.',
    `decontamination_method` STRING COMMENT 'The decontamination method of the supply sterile processing record record.',
    `decontamination_timestamp` TIMESTAMP COMMENT 'The decontamination timestamp of the supply sterile processing record record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply sterile processing record record.',
    `exposure_temperature_c` DECIMAL(18,2) COMMENT 'The exposure temperature c of the supply sterile processing record record.',
    `exposure_time_minutes` DECIMAL(18,2) COMMENT 'The exposure time minutes of the supply sterile processing record record.',
    `immediate_use_flag` BOOLEAN COMMENT 'The immediate use flag of the supply sterile processing record record.',
    `inspection_notes` STRING COMMENT 'The inspection notes of the supply sterile processing record record.',
    `inspection_result` STRING COMMENT 'The inspection result of the supply sterile processing record record.',
    `instrument_count` STRING COMMENT 'The instrument count of the supply sterile processing record record.',
    `iuss_justification` STRING COMMENT 'The iuss justification of the supply sterile processing record record.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status value classifying the supply sterile processing record record.',
    `load_number` STRING COMMENT 'The load number of the supply sterile processing record record.',
    `packaging_type` STRING COMMENT 'The packaging type value classifying the supply sterile processing record record.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'The pressure psi of the supply sterile processing record record.',
    `processed_by` STRING COMMENT 'The processed by of the supply sterile processing record record.',
    `processing_status` STRING COMMENT 'The processing status value classifying the supply sterile processing record record.',
    `quality_assurance_reviewed_flag` BOOLEAN COMMENT 'The quality assurance reviewed flag of the supply sterile processing record record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the supply sterile processing record record.',
    `release_status` STRING COMMENT 'The release status value classifying the supply sterile processing record record.',
    `reprocessing_cycle_count` STRING COMMENT 'The reprocessing cycle count of the supply sterile processing record record.',
    `set_code` STRING COMMENT 'The set code value classifying the supply sterile processing record record.',
    `set_name` STRING COMMENT 'The set name of the supply sterile processing record record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply sterile processing record record.',
    `sterilization_method` STRING COMMENT 'The sterilization method of the supply sterile processing record record.',
    `sterilization_timestamp` TIMESTAMP COMMENT 'The sterilization timestamp of the supply sterile processing record record.',
    `storage_location` STRING COMMENT 'The storage location of the supply sterile processing record record.',
    `tray_identifier` STRING COMMENT 'The tray identifier of the supply sterile processing record record.',
    `tray_weight_kg` DECIMAL(18,2) COMMENT 'The tray weight kg of the supply sterile processing record record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the supply sterile processing record record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply sterile processing record record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `washer_lot_number` STRING COMMENT 'The washer lot number of the supply sterile processing record record.',
    CONSTRAINT pk_sterile_processing_record PRIMARY KEY(`sterile_processing_record_id`)
) COMMENT 'Sterile processing and sterilization records for surgical instruments and devices.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` (
    `recall_notice_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee assigned',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `corrective_action_plan_id` BIGINT COMMENT 'FK to corrective action plan',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `message_log_id` BIGINT COMMENT 'FK to message log',
    `public_health_report_id` BIGINT COMMENT 'FK to public health report',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `affected_lot_number_range` STRING COMMENT 'The affected lot number range of the supply recall notice record.',
    `affected_lot_numbers` STRING COMMENT 'The affected lot numbers of the supply recall notice record.',
    `affected_quantity` STRING COMMENT 'The affected quantity of the supply recall notice record.',
    `affected_serial_number_range` STRING COMMENT 'The affected serial number range of the supply recall notice record.',
    `affected_udi_range` STRING COMMENT 'The affected udi range of the supply recall notice record.',
    `assigned_to_name` STRING COMMENT 'The assigned to name of the supply recall notice record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_amount` DECIMAL(18,2) COMMENT 'Credit amount expected',
    `disposition_action` STRING COMMENT 'The disposition action of the supply recall notice record.',
    `disposition_status` STRING COMMENT 'The disposition status value classifying the supply recall notice record.',
    `expiration_date_range_end` DATE COMMENT 'End of expiration date range',
    `expiration_date_range_start` DATE COMMENT 'Start of expiration date range',
    `fda_notice_date` DATE COMMENT 'Timestamp capturing the fda notice date associated with the supply recall notice record.',
    `fda_recall_event_number` BIGINT COMMENT 'FK to FDA recall event',
    `fda_recall_number` STRING COMMENT 'The fda recall number of the supply recall notice record.',
    `financial_credit_expected` BOOLEAN COMMENT 'Whether financial credit is expected',
    `hazard_description` STRING COMMENT 'The hazard description of the supply recall notice record.',
    `health_hazard_assessment` STRING COMMENT 'The health hazard assessment of the supply recall notice record.',
    `implantable_device_flag` BOOLEAN COMMENT 'Whether device is implantable',
    `internal_notes` STRING COMMENT 'The internal notes of the supply recall notice record.',
    `internal_receipt_date` DATE COMMENT 'Timestamp capturing the internal receipt date associated with the supply recall notice record.',
    `is_resolved` BOOLEAN COMMENT 'Boolean flag indicating the is resolved status of the supply recall notice record.',
    `manufacture_date_range_end` DATE COMMENT 'End of manufacture date range',
    `manufacture_date_range_start` DATE COMMENT 'Start of manufacture date range',
    `mutator_added_flag` BOOLEAN COMMENT 'Flag added by mutator to ensure model change',
    `notes` STRING COMMENT 'The notes of the supply recall notice record.',
    `notification_date` DATE COMMENT 'Timestamp capturing the notification date associated with the supply recall notice record.',
    `notification_received_date` DATE COMMENT 'Timestamp capturing the notification received date associated with the supply recall notice record.',
    `patient_impact_assessment_status` STRING COMMENT 'The patient impact assessment status value classifying the supply recall notice record.',
    `patient_impact_flag` BOOLEAN COMMENT 'The patient impact flag of the supply recall notice record.',
    `patient_notification_date` DATE COMMENT 'Timestamp capturing the patient notification date associated with the supply recall notice record.',
    `patient_notification_required` BOOLEAN COMMENT 'Whether patient notification is required',
    `patient_notification_required_flag` BOOLEAN COMMENT 'The patient notification required flag of the supply recall notice record.',
    `patients_affected_count` STRING COMMENT 'Count of patients affected',
    `product_code` STRING COMMENT 'The product code value classifying the supply recall notice record.',
    `product_name` STRING COMMENT 'The product name of the supply recall notice record.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'The quantity affected of the supply recall notice record.',
    `quantity_destroyed` STRING COMMENT 'The quantity destroyed of the supply recall notice record.',
    `quantity_in_use` DECIMAL(18,2) COMMENT 'The quantity in use of the supply recall notice record.',
    `quantity_on_hand_affected` STRING COMMENT 'The quantity on hand affected of the supply recall notice record.',
    `quantity_quarantined` STRING COMMENT 'The quantity quarantined of the supply recall notice record.',
    `quantity_recovered` DECIMAL(18,2) COMMENT 'The quantity recovered of the supply recall notice record.',
    `quantity_returned_to_vendor` STRING COMMENT 'The quantity returned to vendor of the supply recall notice record.',
    `recall_class` STRING COMMENT 'Recall class (I, II, III)',
    `recall_initiated_date` DATE COMMENT 'Timestamp capturing the recall initiated date associated with the supply recall notice record.',
    `recall_initiation_date` DATE COMMENT 'Timestamp capturing the recall initiation date associated with the supply recall notice record.',
    `recall_initiation_source` STRING COMMENT 'Source of recall initiation',
    `recall_number` STRING COMMENT 'The recall number of the supply recall notice record.',
    `recall_reason` STRING COMMENT 'The recall reason of the supply recall notice record.',
    `recall_reason_code` STRING COMMENT 'The recall reason code value classifying the supply recall notice record.',
    `recall_reason_description` STRING COMMENT 'The recall reason description of the supply recall notice record.',
    `recall_source` STRING COMMENT 'The recall source of the supply recall notice record.',
    `recall_status` STRING COMMENT 'The recall status value classifying the supply recall notice record.',
    `recall_type` STRING COMMENT 'The recall type value classifying the supply recall notice record.',
    `regulatory_report_date` DATE COMMENT 'Timestamp capturing the regulatory report date associated with the supply recall notice record.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Whether regulatory report submitted',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'The regulatory reportable flag of the supply recall notice record.',
    `remediation_action` STRING COMMENT 'Remediation action taken',
    `remediation_completed_date` DATE COMMENT 'Timestamp capturing the remediation completed date associated with the supply recall notice record.',
    `remediation_completion_date` DATE COMMENT 'Timestamp capturing the remediation completion date associated with the supply recall notice record.',
    `remediation_due_date` DATE COMMENT 'Timestamp capturing the remediation due date associated with the supply recall notice record.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the supply recall notice record.',
    `resolution_status` STRING COMMENT 'The resolution status value classifying the supply recall notice record.',
    `response_due_date` DATE COMMENT 'Timestamp capturing the response due date associated with the supply recall notice record.',
    `source_document` STRING COMMENT 'Source document reference',
    `udi_device_identifier` STRING COMMENT 'The udi device identifier of the supply recall notice record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the supply recall notice record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `vendor_notification_date` DATE COMMENT 'Timestamp capturing the vendor notification date associated with the supply recall notice record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_recall_notice PRIMARY KEY(`recall_notice_id`)
) COMMENT 'Product recall notices and remediation tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Primary key',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the supply vendor contract record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the supply vendor contract record.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the supply vendor contract record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the supply vendor contract record.',
    `employee_id` BIGINT COMMENT 'FK to primary vendor employee',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the vendor chart of accounts within the supply vendor contract record.',
    `vendor_contract_manager_employee_id` BIGINT COMMENT 'Unique identifier for the vendor contract manager employee within the supply vendor contract record.',
    `vendor_default_chart_of_accounts_id` BIGINT COMMENT 'FK to chart of accounts',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual spend amount of the supply vendor contract record.',
    `administrative_fee_pct` DECIMAL(18,2) COMMENT 'Administrative fee percentage',
    `annual_commitment_amount` DECIMAL(18,2) COMMENT 'The annual commitment amount of the supply vendor contract record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the supply vendor contract record.',
    `auto_renew` BOOLEAN COMMENT 'The auto renew of the supply vendor contract record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the supply vendor contract record.',
    `base_unit_price` DECIMAL(18,2) COMMENT 'The base unit price of the supply vendor contract record.',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'The committed spend amount of the supply vendor contract record.',
    `compliance_threshold_pct` DECIMAL(18,2) COMMENT 'Compliance threshold percentage',
    `contract_document_url` STRING COMMENT 'The contract document url of the supply vendor contract record.',
    `contract_end_date` DATE COMMENT 'Timestamp capturing the contract end date associated with the supply vendor contract record.',
    `contract_name` STRING COMMENT 'The contract name of the supply vendor contract record.',
    `contract_number` STRING COMMENT 'The contract number of the supply vendor contract record.',
    `contract_start_date` DATE COMMENT 'Timestamp capturing the contract start date associated with the supply vendor contract record.',
    `contract_status` STRING COMMENT 'The contract status value classifying the supply vendor contract record.',
    `contract_tier` STRING COMMENT 'The contract tier of the supply vendor contract record.',
    `contract_type` STRING COMMENT 'The contract type value classifying the supply vendor contract record.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total contract value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply vendor contract record.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percent of the supply vendor contract record.',
    `diversity_classification` STRING COMMENT 'The diversity classification of the supply vendor contract record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the supply vendor contract record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply vendor contract record.',
    `freight_terms_code` STRING COMMENT 'The freight terms code value classifying the supply vendor contract record.',
    `gpo_affiliation` STRING COMMENT 'The gpo affiliation of the supply vendor contract record.',
    `gpo_contract_number` STRING COMMENT 'The gpo contract number of the supply vendor contract record.',
    `gpo_name` STRING COMMENT 'The gpo name of the supply vendor contract record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply vendor contract record.',
    `is_compliant` BOOLEAN COMMENT 'Boolean flag indicating the is compliant status of the supply vendor contract record.',
    `is_diversity_spend` BOOLEAN COMMENT 'Whether diversity spend',
    `is_member_pricing` BOOLEAN COMMENT 'Whether member pricing',
    `is_sole_source_justified` BOOLEAN COMMENT 'Whether sole source justified',
    `notes` STRING COMMENT 'The notes of the supply vendor contract record.',
    `notice_period_days` STRING COMMENT 'The notice period days of the supply vendor contract record.',
    `payment_terms` STRING COMMENT 'The payment terms of the supply vendor contract record.',
    `payment_terms_code` STRING COMMENT 'The payment terms code value classifying the supply vendor contract record.',
    `price_escalation_cap_pct` DECIMAL(18,2) COMMENT 'Price escalation cap percentage',
    `pricing_tier` STRING COMMENT 'The pricing tier of the supply vendor contract record.',
    `pricing_tier_structure` STRING COMMENT 'The pricing tier structure of the supply vendor contract record.',
    `product_category` STRING COMMENT 'The product category of the supply vendor contract record.',
    `rebate_pct` DECIMAL(18,2) COMMENT 'Rebate percentage',
    `rebate_percent` DECIMAL(18,2) COMMENT 'The rebate percent of the supply vendor contract record.',
    `rebate_terms` STRING COMMENT 'The rebate terms of the supply vendor contract record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the supply vendor contract record.',
    `renewal_notice_days` STRING COMMENT 'The renewal notice days of the supply vendor contract record.',
    `renewal_term_months` STRING COMMENT 'The renewal term months of the supply vendor contract record.',
    `renewal_type` STRING COMMENT 'The renewal type value classifying the supply vendor contract record.',
    `sap_contract_number` STRING COMMENT 'The sap contract number of the supply vendor contract record.',
    `signed_date` DATE COMMENT 'Timestamp capturing the signed date associated with the supply vendor contract record.',
    `sole_source_justification` STRING COMMENT 'The sole source justification of the supply vendor contract record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the supply vendor contract record.',
    `termination_reason` STRING COMMENT 'The termination reason of the supply vendor contract record.',
    `terms_and_conditions` STRING COMMENT 'The terms and conditions of the supply vendor contract record.',
    `tier_pricing` STRING COMMENT 'The tier pricing of the supply vendor contract record.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total contract value of the supply vendor contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `vendor_account_number` STRING COMMENT 'The vendor account number of the supply vendor contract record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Contracts with vendors for supply and services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`location_audit` (
    `location_audit_id` BIGINT COMMENT 'Unique identifier for the location audit within the supply location audit record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the supply location audit record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the auditor employee within the supply location audit record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the supply location audit record.',
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for the inventory location within the supply location audit record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the location corrective action plan within the supply location audit record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the supply location audit record.',
    `reviewer_employee_id` BIGINT COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `accuracy_rate` DECIMAL(18,2) COMMENT 'Inventory accuracy rate as percentage',
    `actual_count` STRING COMMENT 'Added to expand thin product supply.location_audit',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `approval_date` DATE COMMENT 'Added to expand thin product supply.location_audit',
    `approved_by` STRING COMMENT 'Added to expand thin product supply.location_audit',
    `audit_cycle_type` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `audit_date` DATE COMMENT 'Timestamp capturing the audit date associated with the supply location audit record.',
    `audit_duration_minutes` STRING COMMENT 'Duration of audit in minutes',
    `audit_end_at` TIMESTAMP COMMENT 'Added to expand thin product supply.location_audit',
    `audit_notes` STRING COMMENT 'The audit notes of the supply location audit record.',
    `audit_result` STRING COMMENT 'The audit result of the supply location audit record.',
    `audit_scope` STRING COMMENT 'Scope of audit (full inventory, sample, high-value items, controlled substances)',
    `audit_start_at` TIMESTAMP COMMENT 'Added to expand thin product supply.location_audit',
    `audit_status` STRING COMMENT 'The audit status value classifying the supply location audit record.',
    `audit_type` STRING COMMENT 'The audit type value classifying the supply location audit record.',
    `auditor_notes` STRING COMMENT 'The auditor notes of the supply location audit record.',
    `completed_date` DATE COMMENT 'Timestamp capturing the completed date associated with the supply location audit record.',
    `compliance_pass_flag` BOOLEAN COMMENT 'The compliance pass flag of the supply location audit record.',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score of the supply location audit record.',
    `corrective_action` STRING COMMENT 'The corrective action of the supply location audit record.',
    `corrective_action_completed_date` DATE COMMENT 'Timestamp capturing the corrective action completed date associated with the supply location audit record.',
    `corrective_action_due_date` DATE COMMENT 'Timestamp capturing the corrective action due date associated with the supply location audit record.',
    `corrective_action_notes` STRING COMMENT 'Notes describing corrective actions taken as a result of audit findings.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required',
    `corrective_action_required_flag` BOOLEAN COMMENT 'The corrective action required flag of the supply location audit record.',
    `count_accuracy_rate` DECIMAL(18,2) COMMENT 'The count accuracy rate of the supply location audit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the supply location audit record.',
    `critical_findings_count` STRING COMMENT 'The critical findings count of the supply location audit record.',
    `discrepancy_count` STRING COMMENT 'Number of discrepancies found',
    `discrepancy_value` DECIMAL(18,2) COMMENT 'Total value of discrepancies',
    `expected_count` STRING COMMENT 'Added to expand thin product supply.location_audit',
    `expired_item_count` STRING COMMENT 'The expired item count of the supply location audit record.',
    `expired_item_found_flag` BOOLEAN COMMENT 'The expired item found flag of the supply location audit record.',
    `expired_items_count` STRING COMMENT 'Number of expired items found',
    `expired_items_value` DECIMAL(18,2) COMMENT 'Total value of expired items',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the supply location audit record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the supply location audit record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the supply location audit record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the supply location audit record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the supply location audit record.',
    `findings_count` STRING COMMENT 'The findings count of the supply location audit record.',
    `findings_notes` STRING COMMENT 'The findings notes of the supply location audit record.',
    `findings_summary` STRING COMMENT 'The findings summary of the supply location audit record.',
    `follow_up_required` BOOLEAN COMMENT 'The follow up required of the supply location audit record.',
    `items_audited_count` STRING COMMENT 'Number of items audited',
    `items_counted` STRING COMMENT 'The items counted of the supply location audit record.',
    `items_discrepant` STRING COMMENT 'The items discrepant of the supply location audit record.',
    `items_expected` STRING COMMENT 'The items expected of the supply location audit record.',
    `location_status_at_audit` STRING COMMENT 'The location status at audit of the supply location audit record.',
    `next_audit_date` DATE COMMENT 'Timestamp capturing the next audit date associated with the supply location audit record.',
    `overage_count` STRING COMMENT 'Number of items with overage',
    `recalled_item_count` STRING COMMENT 'The recalled item count of the supply location audit record.',
    `recalled_item_found_flag` BOOLEAN COMMENT 'The recalled item found flag of the supply location audit record.',
    `reconciliation_completed_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `regulatory_requirement` STRING COMMENT 'Regulatory requirement driving audit (Joint Commission, FDA, state)',
    `resolution_status` STRING COMMENT 'Status of discrepancy resolution',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the supply location audit record.',
    `shortage_count` STRING COMMENT 'Number of items with shortage',
    `location_audit_status` STRING COMMENT 'Added to expand thin product supply.location_audit',
    `total_items_counted` STRING COMMENT 'Total number of items counted during the audit.',
    `total_variance_value` DECIMAL(18,2) COMMENT 'The total variance value of the supply location audit record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply location audit record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Dollar value of inventory variance found during the audit.',
    `variance_count` STRING COMMENT 'Number of variance items found',
    `variance_item_count` STRING COMMENT 'Number of items with discrepancies found during the audit.',
    `variance_quantity` STRING COMMENT 'Quantity variance found during audit',
    `variance_reason` STRING COMMENT 'Added to expand thin product supply.location_audit',
    `variance_units` STRING COMMENT 'Unit variance found',
    `variance_value` DECIMAL(18,2) COMMENT 'The variance value of the supply location audit record.',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply location audit record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_location_audit PRIMARY KEY(`location_audit_id`)
) COMMENT 'Audit records for inventory locations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` (
    `material_policy_governance_id` BIGINT COMMENT 'Unique identifier for the material policy governance within the supply material policy governance record.',
    `approver_employee_id` BIGINT COMMENT 'Added to expand thin product workforce.material_policy_governance',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the supply material policy governance record.',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the supply material policy governance record.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the supply material policy governance record.',
    `employee_id` BIGINT COMMENT 'Added to expand thin product workforce.material_policy_governance',
    `material_approved_by_employee_id` BIGINT COMMENT 'Unique identifier for the material approved by employee within the supply material policy governance record.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee within the supply material policy governance record.',
    `policy_version_id` BIGINT COMMENT 'Added to expand thin product compliance.material_policy_governance',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the primary material master within the supply material policy governance record.',
    `reviewer_employee_id` BIGINT COMMENT 'Employee who reviewed compliance',
    `committee_id` BIGINT COMMENT 'Value analysis committee that reviewed material',
    `approval_authority` STRING COMMENT 'Authority that approved material (committee, director, board)',
    `approval_date` DATE COMMENT 'Date when the governance decision was approved.',
    `approval_status` STRING COMMENT 'The approval status value classifying the supply material policy governance record.',
    `approval_workflow_status` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `approved_date` DATE COMMENT 'Date of approval',
    `clinical_evidence_level` STRING COMMENT 'Level of clinical evidence supporting material use',
    `compliance_status` STRING COMMENT 'The compliance status value classifying the supply material policy governance record.',
    `cost_effectiveness_score` DECIMAL(18,2) COMMENT 'Cost-effectiveness score from value analysis',
    `cost_savings_amount` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the supply material policy governance record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the supply material policy governance record.',
    `effective_review_cycle_days` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `exception_approved_date` DATE COMMENT 'Timestamp capturing the exception approved date associated with the supply material policy governance record.',
    `exception_flag` BOOLEAN COMMENT 'The exception flag of the supply material policy governance record.',
    `exception_justification` STRING COMMENT 'The exception justification of the supply material policy governance record.',
    `exception_reason` STRING COMMENT 'Added to expand thin product supply.material_policy_governance',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply material policy governance record.',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the supply material policy governance record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the supply material policy governance record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the supply material policy governance record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the supply material policy governance record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the supply material policy governance record.',
    `governance_category` STRING COMMENT 'The governance category of the supply material policy governance record.',
    `governance_notes` STRING COMMENT 'The governance notes of the supply material policy governance record.',
    `governance_status` STRING COMMENT 'Added to expand thin product supply.material_policy_governance',
    `governance_type` STRING COMMENT 'The governance type value classifying the supply material policy governance record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply material policy governance record.',
    `last_review_date` DATE COMMENT 'Timestamp capturing the last review date associated with the supply material policy governance record.',
    `last_reviewed_date` DATE COMMENT 'Timestamp capturing the last reviewed date associated with the supply material policy governance record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the supply material policy governance record.',
    `notes` STRING COMMENT 'The notes of the supply material policy governance record.',
    `owner_name` STRING COMMENT 'The owner name of the supply material policy governance record.',
    `policy_category` STRING COMMENT 'Category of the governance policy (e.g., safety, quality, cost, sustainability).',
    `policy_description` STRING COMMENT 'The policy description of the supply material policy governance record.',
    `policy_name` STRING COMMENT 'The policy name of the supply material policy governance record.',
    `policy_number` STRING COMMENT 'The policy number of the supply material policy governance record.',
    `policy_requirement` STRING COMMENT 'Specific policy requirement being governed',
    `policy_status` STRING COMMENT 'The policy status value classifying the supply material policy governance record.',
    `policy_type` STRING COMMENT 'The policy type value classifying the supply material policy governance record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the supply material policy governance record.',
    `regulatory_requirement` STRING COMMENT 'Applicable regulatory requirement',
    `requires_attestation_flag` BOOLEAN COMMENT 'The requires attestation flag of the supply material policy governance record.',
    `restriction_type` STRING COMMENT 'Type of restriction (formulary, prior auth, quantity limit, specialty only)',
    `review_committee_notes` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the supply material policy governance record.',
    `review_frequency` STRING COMMENT 'The review frequency of the supply material policy governance record.',
    `review_frequency_days` STRING COMMENT 'The review frequency days of the supply material policy governance record.',
    `reviewer_role` STRING COMMENT 'The reviewer role of the supply material policy governance record.',
    `risk_classification` STRING COMMENT 'Risk classification of the material under this policy (e.g., high, medium, low).',
    `risk_level` STRING COMMENT 'The risk level of the supply material policy governance record.',
    `risk_rating` STRING COMMENT 'Added to expand thin product supply.material_policy_governance',
    `source_system_code` STRING COMMENT 'The source system code value classifying the supply material policy governance record.',
    `stewardship_scope` STRING COMMENT 'The stewardship scope of the supply material policy governance record.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'The substitution allowed flag of the supply material policy governance record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply material policy governance record.',
    `utilization_target_count` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the supply material policy governance record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_material_policy_governance PRIMARY KEY(`material_policy_governance_id`)
) COMMENT 'Governance and policy compliance for materials.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` (
    `vendor_site_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the supply vendor site record.',
    `geographic_region_id` BIGINT COMMENT 'Unique identifier for the geographic region within the supply vendor site record.',
    `parent_vendor_site_id` BIGINT COMMENT 'Self-referential FK to parent vendor site',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `address_line1` STRING COMMENT 'The address line1 of the supply vendor site record.',
    `address_line2` STRING COMMENT 'The address line2 of the supply vendor site record.',
    `address_line_1` STRING COMMENT 'The address line 1 of the supply vendor site record.',
    `address_line_2` STRING COMMENT 'The address line 2 of the supply vendor site record.',
    `city` STRING COMMENT 'The city of the supply vendor site record.',
    `contact_email` STRING COMMENT 'The contact email of the supply vendor site record.',
    `contact_name` STRING COMMENT 'The contact name of the supply vendor site record.',
    `contact_phone` STRING COMMENT 'The contact phone of the supply vendor site record.',
    `country_code` STRING COMMENT 'The country code value classifying the supply vendor site record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the supply vendor site record.',
    `currency_code` STRING COMMENT 'The currency code value classifying the supply vendor site record.',
    `duns_number` STRING COMMENT 'The duns number of the supply vendor site record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the supply vendor site record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the supply vendor site record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the supply vendor site record.',
    `email_address` STRING COMMENT 'The email address of the supply vendor site record.',
    `erp_site_code` STRING COMMENT 'The erp site code value classifying the supply vendor site record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the supply vendor site record.',
    `fax_number` STRING COMMENT 'The fax number of the supply vendor site record.',
    `fda_establishment_number` STRING COMMENT 'The fda establishment number of the supply vendor site record.',
    `gln_number` STRING COMMENT 'The gln number of the supply vendor site record.',
    `incoterms` STRING COMMENT 'The incoterms of the supply vendor site record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the supply vendor site record.',
    `is_approved_for_medical_devices` BOOLEAN COMMENT 'Approved for medical devices',
    `is_approved_for_pharmaceuticals` BOOLEAN COMMENT 'Approved for pharmaceuticals',
    `is_preferred_site` BOOLEAN COMMENT 'Whether preferred site',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating the is primary status of the supply vendor site record.',
    `is_primary_site` BOOLEAN COMMENT 'Boolean flag indicating the is primary site status of the supply vendor site record.',
    `is_remit_to` BOOLEAN COMMENT 'Boolean flag indicating the is remit to status of the supply vendor site record.',
    `is_ship_from` BOOLEAN COMMENT 'Boolean flag indicating the is ship from status of the supply vendor site record.',
    `last_audit_date` DATE COMMENT 'Timestamp capturing the last audit date associated with the supply vendor site record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supply vendor site record.',
    `lead_time_days` STRING COMMENT 'Lead time in days',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'The minimum order amount of the supply vendor site record.',
    `modified_by_user` STRING COMMENT 'The modified by user of the supply vendor site record.',
    `next_audit_due_date` DATE COMMENT 'Timestamp capturing the next audit due date associated with the supply vendor site record.',
    `notes` STRING COMMENT 'The notes of the supply vendor site record.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'The on time delivery percentage of the supply vendor site record.',
    `payment_terms` STRING COMMENT 'The payment terms of the supply vendor site record.',
    `performance_rating` STRING COMMENT 'The performance rating of the supply vendor site record.',
    `phone_number` STRING COMMENT 'The phone number of the supply vendor site record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the supply vendor site record.',
    `primary_contact_email` STRING COMMENT 'The primary contact email of the supply vendor site record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the supply vendor site record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the supply vendor site record.',
    `primary_contact_title` STRING COMMENT 'The primary contact title of the supply vendor site record.',
    `quality_certification` STRING COMMENT 'The quality certification of the supply vendor site record.',
    `quality_defect_rate_percentage` DECIMAL(18,2) COMMENT 'The quality defect rate percentage of the supply vendor site record.',
    `remit_to_flag` BOOLEAN COMMENT 'The remit to flag of the supply vendor site record.',
    `ship_from_flag` BOOLEAN COMMENT 'The ship from flag of the supply vendor site record.',
    `shipping_method` STRING COMMENT 'The shipping method of the supply vendor site record.',
    `site_code` STRING COMMENT 'The site code value classifying the supply vendor site record.',
    `site_name` STRING COMMENT 'The site name of the supply vendor site record.',
    `site_number` STRING COMMENT 'The site number of the supply vendor site record.',
    `site_status` STRING COMMENT 'The site status value classifying the supply vendor site record.',
    `site_type` STRING COMMENT 'The site type value classifying the supply vendor site record.',
    `state_code` STRING COMMENT 'The state code value classifying the supply vendor site record.',
    `state_province` STRING COMMENT 'State or province',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the supply vendor site record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply vendor site record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_vendor_site PRIMARY KEY(`vendor_site_id`)
) COMMENT 'Physical sites and locations for vendors.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_parent_location_inventory_location_id` FOREIGN KEY (`parent_location_inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_primary_inventory_material_master_id` FOREIGN KEY (`primary_inventory_material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_source_inventory_transaction_id` FOREIGN KEY (`source_inventory_transaction_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_parent_vendor_site_id` FOREIGN KEY (`parent_vendor_site_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('pii_domain' = 'supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_vendor_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_purchasing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_purchasing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_receiving' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_warehouse' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_stock' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_transactions' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_requisition' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_udi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_device_tracking' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `brand_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_surgical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_bom' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_perioperative' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `preference_card_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `tertiary_surgical_supply_chain_owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `tertiary_surgical_supply_chain_owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_surgical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_perioperative' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_case_cart' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `tertiary_case_delivered_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `tertiary_case_delivered_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_sterile_processing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_perioperative' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_recall' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_patient_safety' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `mutator_added_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_contract_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_contract_manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_contract_manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `terms_and_conditions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_association_edges' = 'supply.inventory_location,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `corrective_action_notes` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `total_items_counted` SET TAGS ('pii_business_glossary_term' = 'Total Items Counted');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_item_count` SET TAGS ('pii_business_glossary_term' = 'Variance Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_association_edges' = 'supply.material_master,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_level` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_classification` SET TAGS ('pii_business_glossary_term' = 'Risk Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_subdomain' = 'supply_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_supply_chain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_vendor_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_supply_domain_ensured' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_medical_devices` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_medical_devices` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_person' = 'true');
