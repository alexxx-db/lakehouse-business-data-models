-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`procurement` COMMENT 'Procurement and supply chain domain managing the full source-to-contract lifecycle including RFQ/RFP issuance, vendor evaluation, PO (Purchase Order) creation, MTO (Material Take-Off) data, supplier qualification records, and procurement lead times. Coordinates material delivery schedules with project timelines and manages vendor master data via SAP MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key for the vendor master data product. System-generated surrogate key used across all procurement and supply chain transactions.',
    `account_number` STRING COMMENT 'SAP vendor account number assigned in SAP MM Vendor Master. External business identifier used in purchase orders, invoices, and payment processing. Unique across the ERP system.. Valid values are `^[A-Z0-9]{6,10}$`',
    `address_line_1` STRING COMMENT 'First line of the vendors registered business address. Typically contains street number and street name. Used for correspondence, legal notices, and payment remittance.',
    `address_line_2` STRING COMMENT 'Second line of the vendors business address. Contains suite, floor, building, or other secondary address information. Nullable if not applicable.',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'Vendors reported annual revenue in the vendors default currency. Used for vendor size classification, capacity assessment, and financial stability evaluation. Typically self-reported or obtained from financial statements.',
    `approval_date` DATE COMMENT 'Date when the vendor was approved for procurement transactions following successful completion of prequalification, due diligence, and compliance checks. Nullable for prospective vendors not yet approved.',
    `audit_result` STRING COMMENT 'Outcome of the most recent vendor audit. Passed indicates full compliance; passed with conditions indicates minor findings requiring corrective action; failed indicates major non-conformances; not audited indicates no audit has been conducted.. Valid values are `passed|passed_with_conditions|failed|not_audited`',
    `bank_account_number` STRING COMMENT 'Vendors bank account number for electronic payment receipt. Highly sensitive financial information used for ACH and wire transfer processing. Encrypted at rest and in transit.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendor maintains their primary business account for payment receipt. Used for electronic payment processing and wire transfers.',
    `bank_routing_number` STRING COMMENT 'Bank routing number, SWIFT code, or IBAN for the vendors bank account. Used to route electronic payments to the correct financial institution. Format varies by country and payment network.',
    `bonding_capacity_amount` DECIMAL(18,2) COMMENT 'Maximum bonding capacity available to the vendor in the vendors default currency. Represents the total value of performance bonds and payment bonds the vendor can secure from their surety. Critical for subcontractor prequalification and large contract awards.',
    `city` STRING COMMENT 'City or municipality where the vendors registered business address is located. Used for geographic analysis, local sourcing initiatives, and logistics planning.',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on the type of goods or services provided. Determines procurement workflows, approval hierarchies, and contract templates. Material suppliers provide construction materials; equipment rental provides machinery; specialist subcontractors perform MEP, civil, or structural work; general contractors manage construction execution; professional services include design, engineering, and consulting; utility providers supply power, water, and telecommunications.. Valid values are `material_supplier|equipment_rental|specialist_subcontractor|general_contractor|professional_services|utility_provider`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendors registered business location. Used for international trade compliance, currency determination, and cross-border procurement regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor record was first created in the system. Used for data lineage, audit trails, and vendor relationship tenure analysis. System-generated and immutable.',
    `credit_rating` STRING COMMENT 'Credit rating assigned by credit rating agencies (Dun & Bradstreet, Moodys, S&P) reflecting the vendors financial stability and creditworthiness. Used for vendor risk assessment and payment term determination. NR indicates not rated. [ENUM-REF-CANDIDATE: aaa|aa|a|bbb|bb|b|ccc|cc|c|d|nr — 11 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the vendors default transaction currency. Determines the currency used for purchase orders, invoices, and payments. Used for foreign exchange exposure analysis.. Valid values are `^[A-Z]{3}$`',
    `diversity_classification` STRING COMMENT 'Diversity certification status for the vendor. MBE (Minority Business Enterprise), WBE (Women Business Enterprise), DBE (Disadvantaged Business Enterprise), SDVOSB (Service-Disabled Veteran-Owned Small Business), HUBZone (Historically Underutilized Business Zone). Used for diversity spend reporting and compliance with client diversity requirements.. Valid values are `mbe|wbe|dbe|sdvosb|hubzone|none`',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number issued by Dun & Bradstreet for unique identification of business entities. Used for credit checks, vendor risk assessment, and compliance with government contracting requirements.. Valid values are `^[0-9]{9}$`',
    `employee_count` STRING COMMENT 'Total number of employees working for the vendor organization. Used for vendor capacity assessment, small business classification, and resource availability evaluation.',
    `geographic_coverage` STRING COMMENT 'Geographic regions or markets where the vendor operates and can provide services. Free-text field listing countries, states, or regions. Used for project-specific vendor selection and logistics planning.',
    `insurance_certificate_number` STRING COMMENT 'Certificate number for the vendors current general liability and professional indemnity insurance policy. Used to verify insurance coverage before contract execution and during vendor compliance audits.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the vendors current insurance certificate. Monitored to ensure continuous insurance coverage throughout the contract period. Triggers renewal reminders and compliance alerts.',
    `last_audit_date` DATE COMMENT 'Date of the most recent vendor audit or compliance review. Audits assess quality systems, safety practices, financial controls, and contract compliance. Used to schedule periodic re-audits and maintain vendor qualification status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor record was last updated. Tracks the most recent change to any field in the vendor master record. Used for change tracking, data quality monitoring, and synchronization with downstream systems.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with tax authorities. Used on contracts, purchase orders, and payment documents. Must match legal registration documents.',
    `payment_method` STRING COMMENT 'Preferred payment method for remitting payment to the vendor. ACH for automated clearing house electronic transfer; wire transfer for same-day international payments; check for traditional paper payments; credit card for small purchases; letter of credit for international trade.. Valid values are `ach|wire_transfer|check|credit_card|letter_of_credit`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the payment schedule and discount structure for this vendor. Examples include NET30 (net 30 days), NET60, 2/10NET30 (2% discount if paid within 10 days, otherwise net 30). Drives accounts payable processing and cash flow planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendors business address. Used for mail delivery, logistics planning, and geographic segmentation. Format varies by country.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this vendor has preferred vendor status. Preferred vendors receive priority consideration for bid invitations, expedited approval processes, and favorable payment terms based on proven performance and strategic relationship.',
    `prequalification_score` DECIMAL(18,2) COMMENT 'Composite score from the vendor prequalification process evaluating financial stability, technical capability, safety record, quality performance, and past project experience. Scale typically 0-100. Used for vendor ranking and bid invitation decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact. Used for purchase order transmission, RFQ distribution, invoice queries, and general procurement communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor organization. This individual serves as the main point of contact for procurement, contract administration, and operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact. Used for urgent procurement matters, delivery coordination, and issue resolution. Includes country code and extension where applicable.',
    `quality_certification` STRING COMMENT 'Quality management system certifications held by the vendor. Common certifications include ISO 9001 (Quality Management), ISO 14001 (Environmental Management), ISO 45001 (Occupational Health and Safety). Multiple certifications separated by semicolons.',
    `registration_date` DATE COMMENT 'Date when the vendor was first registered in the vendor master system. Marks the beginning of the vendor relationship and is used for vendor tenure analysis and anniversary tracking.',
    `state_province` STRING COMMENT 'State, province, or region where the vendor is located. Used for tax jurisdiction determination, regional sourcing analysis, and compliance with local content requirements.',
    `suspension_end_date` DATE COMMENT 'Planned or actual date when vendor suspension will be or was lifted. Nullable for indefinite suspensions or vendors that have never been suspended. Used for reinstatement planning and compliance tracking.',
    `suspension_reason` STRING COMMENT 'Reason for vendor suspension or blocking if vendor_status is suspended or blocked. Examples include quality issues, safety violations, contract breaches, financial instability, or ethical violations. Nullable for active vendors.',
    `suspension_start_date` DATE COMMENT 'Date when vendor suspension or blocking became effective. Used to track suspension duration and trigger review processes. Nullable for vendors that have never been suspended.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the vendor. Used for tax reporting, 1099 processing, and compliance with tax regulations. Format varies by jurisdiction (EIN in USA, VAT number in EU, GST number in other regions).',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the vendor master. Approved vendors can receive purchase orders; prospective vendors are under evaluation; suspended vendors have temporary restrictions; blocked vendors cannot receive new orders; inactive vendors are no longer used; under_review vendors are being re-qualified.. Valid values are `approved|prospective|suspended|blocked|inactive|under_review`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all approved and prospective suppliers, subcontractors, and material vendors managed via SAP MM Vendor Master. Captures vendor identity, classification (material supplier, equipment rental, specialist subcontractor), registration status, tax identifiers, payment terms, currency, bank details, geographic coverage, diversity classification (MBE/WBE/DBE), bonding capacity, insurance certificates, and SAP vendor account number. SSOT for vendor identity across the procurement domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification entity.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the procurement or QA/QC (Quality Assurance/Quality Control) employee who conducted the qualification assessment.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record being qualified. Links to the vendor entity in the procurement domain.',
    `approval_date` DATE COMMENT 'Date when the vendor qualification was formally approved and the vendor was added to the AVL (Approved Vendor List).',
    `approved_material_categories` STRING COMMENT 'Comma-separated list of material categories the vendor is qualified to supply. Examples include concrete, steel, MEP (Mechanical Electrical and Plumbing) equipment, formwork, aggregates. Aligns with MTO (Material Take-Off) classification.',
    `approved_service_types` STRING COMMENT 'Comma-separated list of service types the vendor is qualified to provide. Examples include earthworks, structural steel erection, electrical installation, HVAC installation, concrete placement, surveying.',
    `bonding_capacity_currency` STRING COMMENT 'ISO 4217 three-letter currency code for bonding capacity limit. Typically USD for US-based projects.. Valid values are `^[A-Z]{3}$`',
    `bonding_capacity_limit` DECIMAL(18,2) COMMENT 'Maximum bonding capacity available from the vendors surety company. Determines the maximum contract value the vendor can undertake. Critical for GC (General Contractor) and major subcontractor qualifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was first created in the system. Part of audit trail for compliance and governance.',
    `financial_health_score` DECIMAL(18,2) COMMENT 'Composite financial health assessment score ranging from 0.00 to 100.00. Based on credit rating, liquidity ratios, debt-to-equity, and financial statement analysis. Minimum threshold typically 60.00 for approval.',
    `geographic_coverage` STRING COMMENT 'Geographic regions or countries where the vendor is qualified to operate. Comma-separated list of ISO 3166 country codes or region names. Important for multi-site and international projects.',
    `hse_performance_rating` STRING COMMENT 'HSE (Health Safety and Environment) performance rating based on TRIR (Total Recordable Incident Rate), LTI (Lost Time Injury) frequency, safety audit results, and compliance with OSHA (Occupational Safety and Health Administration) standards. Critical factor for vendor approval.. Valid values are `excellent|good|satisfactory|needs_improvement|unacceptable`',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiry date of the vendors insurance certificate. Procurement tracks this to ensure continuous coverage throughout contract execution.',
    `insurance_general_liability_limit` DECIMAL(18,2) COMMENT 'General liability insurance coverage limit. Minimum requirements typically range from $1M to $10M depending on project size and risk profile.',
    `insurance_workers_comp_verified` BOOLEAN COMMENT 'Indicates whether valid workers compensation insurance has been verified. Mandatory for all vendors providing on-site labor per OSHA (Occupational Safety and Health Administration) requirements.',
    `iso_14001_certificate_number` STRING COMMENT 'Certificate number for ISO 14001 Environmental Management System certification.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 14001 Environmental Management System certification. Increasingly required for LEED (Leadership in Energy and Environmental Design) projects and environmentally sensitive sites.',
    `iso_14001_expiry_date` DATE COMMENT 'Expiry date of ISO 14001 certification. Critical for projects with EPA (Environmental Protection Agency) compliance requirements.',
    `iso_45001_certificate_number` STRING COMMENT 'Certificate number for ISO 45001 Occupational Health and Safety Management System certification.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 45001 Occupational Health and Safety Management System certification. Demonstrates commitment to worker safety and HSE (Health Safety and Environment) excellence.',
    `iso_45001_expiry_date` DATE COMMENT 'Expiry date of ISO 45001 certification. Monitored to ensure ongoing HSE (Health Safety and Environment) compliance.',
    `iso_9001_certificate_number` STRING COMMENT 'Certificate number for ISO 9001 Quality Management System certification. Used for verification with certification body.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 9001 Quality Management System certification. Often mandatory for critical material suppliers and major subcontractors.',
    `iso_9001_expiry_date` DATE COMMENT 'Expiry date of ISO 9001 certification. Procurement monitors this to ensure vendors maintain valid certification throughout contract execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was last updated. Tracks changes to qualification status, scores, certifications, or other attributes.',
    `lti_frequency_rate` DECIMAL(18,2) COMMENT 'LTI (Lost Time Injury) frequency rate calculated as (number of LTIs × 1,000,000) / total hours worked. Measures severity of safety incidents. Target is typically below 1.0 for qualified vendors.',
    `notes` STRING COMMENT 'Free-text notes capturing additional qualification details, special conditions, limitations, or observations from the assessment process. Used by procurement team for decision support.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of past deliveries completed on or before scheduled date. Critical metric for CPM (Critical Path Method) schedule-sensitive projects. Target is typically above 90.00%.',
    `past_performance_score` DECIMAL(18,2) COMMENT 'Composite past performance score ranging from 0.00 to 100.00. Based on historical project delivery, quality, schedule adherence, cost control, and client satisfaction. Derived from completed project evaluations and NCR (Non-Conformance Report) history.',
    `qualification_assessment_date` DATE COMMENT 'Date when the qualification assessment was conducted. Includes site visits, document reviews, financial analysis, and technical capability evaluation.',
    `qualification_category` STRING COMMENT 'Primary category of goods or services the vendor is qualified to supply. MEP (Mechanical Electrical and Plumbing) is a specialized category for building systems contractors.. Valid values are `materials|equipment|services|subcontractor|mep|specialty`',
    `qualification_expiry_date` DATE COMMENT 'Date on which the vendor qualification expires and requires renewal. Typically set 1-3 years from start date depending on vendor category and risk profile.',
    `qualification_number` STRING COMMENT 'Business identifier for the vendor qualification record. Externally visible unique reference number used in procurement communications and AVL (Approved Vendor List) documentation.. Valid values are `^VQ-[0-9]{8}$`',
    `qualification_start_date` DATE COMMENT 'Effective date from which the vendor qualification becomes valid. Vendors can only receive PO (Purchase Order) assignments on or after this date.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification. Approved vendors are eligible for PO (Purchase Order) issuance. Suspended vendors require re-qualification. Expired qualifications require renewal.. Valid values are `draft|under_review|approved|rejected|suspended|expired`',
    `qualification_type` STRING COMMENT 'Type of qualification process being conducted. Initial for new vendors, renewal for periodic re-assessment, re-qualification for vendors returning after suspension, conditional for limited-scope approval, emergency for urgent project needs.. Valid values are `initial|renewal|re_qualification|conditional|emergency`',
    `quality_defect_rate` DECIMAL(18,2) COMMENT 'Historical quality defect rate expressed as percentage of deliverables requiring rework or NCR (Non-Conformance Report) issuance. Lower values indicate better quality performance. Target is typically below 5.00%.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the vendor qualification was rejected. Includes specific deficiencies in financial health, technical capability, HSE (Health Safety and Environment) performance, or documentation.',
    `suspension_date` DATE COMMENT 'Date when the vendor qualification was suspended. Suspended vendors cannot receive new PO (Purchase Order) assignments until re-qualified.',
    `suspension_reason` STRING COMMENT 'Reason for suspending an approved vendor qualification. Common causes include safety incidents, quality failures, financial distress, contract breaches, or regulatory violations.',
    `technical_capability_score` DECIMAL(18,2) COMMENT 'Assessment score of vendor technical capabilities ranging from 0.00 to 100.00. Evaluates equipment, workforce skills, past project complexity, and technical certifications. Minimum threshold typically 70.00 for complex EPC (Engineering Procurement and Construction) projects.',
    `trir_rate` DECIMAL(18,2) COMMENT 'TRIR (Total Recordable Incident Rate) calculated as (number of recordable incidents × 200,000) / total hours worked. Industry benchmark for construction is typically below 3.0. Lower values indicate better safety performance.',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Supplier pre-qualification and approved vendor list (AVL) records capturing qualification status, financial health assessments, technical capability evaluations, HSE performance ratings, quality certifications (ISO 9001, ISO 14001, ISO 45001), bonding limits, insurance coverage verification, past performance scores, and qualification expiry dates. Tracks the full vendor onboarding and re-qualification lifecycle required before a vendor can receive a PO.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`material_catalog` (
    `material_catalog_id` BIGINT COMMENT 'Primary key for material_catalog',
    `master_id` BIGINT COMMENT 'Unique identifier for the material master record in the procurement catalog. Primary key for the material catalog product.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Sustainability compliance mandates associating each cataloged material with its certified sustainable material record for ESG reporting and material selection.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and consumption frequency. A=High value/critical items requiring tight control, B=Moderate value, C=Low value/high volume items. Drives inventory policy and cycle counting frequency.. Valid values are `A|B|C`',
    `alternative_unit_of_measure` STRING COMMENT 'Secondary unit of measure for materials that can be ordered or issued in multiple units (e.g., cement ordered in bags but tracked in tons). Supports conversion factor calculations.',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for material quantity tracking, ordering, and inventory management. Aligns with industry standards for construction materials (EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Metric Ton). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|GAL|FT|YD|LB|BAG|BOX|ROLL — 14 candidates stripped; promote to reference product]',
    `bim_object_reference` STRING COMMENT 'Unique identifier linking the material to its corresponding 3D object in BIM 360 or other BIM platforms. Enables digital twin integration and clash detection during design and construction phases.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for standard cost (e.g., USD, EUR, GBP). Supports multi-currency procurement and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the material is manufactured or sourced. Required for customs compliance, trade regulations, and local content reporting.. Valid values are `^[A-Z]{3}$`',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for audit trail and master data governance.',
    `customs_tariff_number` STRING COMMENT 'Harmonized System (HS) code for international trade classification. Used for customs clearance, duty calculation, and import/export documentation for cross-border procurement.. Valid values are `^[0-9]{6,10}$`',
    `dimension_unit` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Typically meters (M) for construction industry standards.. Valid values are `M|CM|MM|FT|IN`',
    `environmental_certification` STRING COMMENT 'Environmental sustainability certification held by the material (e.g., LEED certified, FSC certified, Energy Star). Supports green building requirements and sustainability reporting.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging, measured in kilograms. Used for logistics planning, transportation cost calculation, and site delivery scheduling.',
    `hazard_class` STRING COMMENT 'UN hazard classification code for hazardous materials (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Required for transportation, storage, and safety data sheet (SDS) compliance.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous per OSHA and EPA regulations. Triggers special handling, storage, and HSE (Health Safety and Environment) compliance requirements.',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the material in meters. Essential for volume calculations and warehouse stacking constraints.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated the material master record. Tracks data ownership and change responsibility.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Tracks data currency and supports change management processes.',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the material in meters. Critical for structural materials (beams, pipes, cables) and storage space planning.',
    `manufacturer_name` STRING COMMENT 'Name of the primary manufacturer or brand for the material. Used for quality assurance, warranty tracking, and approved vendor list (AVL) compliance.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number or model code for the material. Critical for exact specification matching, warranty claims, and spare parts procurement.',
    `material_description` STRING COMMENT 'Full textual description of the material, equipment component, or consumable item. Provides detailed specification and identification information for procurement and inventory purposes.',
    `material_group` STRING COMMENT 'Classification code grouping materials by procurement category (e.g., concrete, steel, MEP equipment, PPE). Used for procurement strategy, vendor assignment, and spend analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Unique business identifier for the material as defined in SAP MM Material Master. This is the externally-known code used across MTO (Material Take-Off), PO (Purchase Order), and goods receipt processes.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Controls procurement eligibility and inventory transactions. Blocked materials cannot be ordered; obsolete materials are phased out.. Valid values are `active|inactive|blocked|obsolete|pending_approval|restricted`',
    `material_type` STRING COMMENT 'SAP material type classification defining procurement and inventory control behavior. RAW=Raw Material, SEMI=Semi-Finished, FERT=Finished Product, HAWA=Trading Goods, NLAG=Non-Stock Material, UNBW=Non-Valuated Material, DIEN=Services, VERP=Packaging, HIBE=Operating Supplies. [ENUM-REF-CANDIDATE: RAW|SEMI|FERT|HAWA|NLAG|UNBW|DIEN|VERP|HIBE — 9 candidates stripped; promote to reference product]',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from suppliers in base unit of measure. Drives procurement batch sizing and inventory optimization.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging, measured in kilograms. Used for material quantity verification and yield calculations in construction processes.',
    `procurement_lead_time_days` STRING COMMENT 'Standard number of days from PO (Purchase Order) issuance to material delivery on site. Used for project scheduling, MRP (Material Requirements Planning), and critical path analysis.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming goods receipt requires quality inspection per ITP (Inspection and Test Plan) before acceptance. Triggers QA/QC workflow in goods receipt process.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration or quality degradation. Critical for perishable materials (adhesives, sealants, chemicals) and inventory rotation (FIFO/FEFO).',
    `short_description` STRING COMMENT 'Abbreviated description of the material for display in transaction screens, reports, and mobile applications. Limited to 40 characters for operational efficiency.',
    `specification_reference` STRING COMMENT 'Reference to technical specification document, industry standard, or project specification section (e.g., ASTM A615 for rebar, ACI 318 for concrete). Ensures compliance with design requirements and QA/QC (Quality Assurance/Quality Control) standards.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Baseline unit cost of the material used for project budgeting, cost estimation, and variance analysis. Updated periodically based on procurement history and market conditions.',
    `storage_condition` STRING COMMENT 'Required environmental conditions for material storage to maintain quality and safety. Drives warehouse zone assignment and inventory handling procedures. [ENUM-REF-CANDIDATE: ambient|climate_controlled|refrigerated|dry|ventilated|hazmat_certified|outdoor_covered|outdoor_uncovered — 8 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'SAP valuation class code linking material to general ledger (GL) accounts for inventory valuation and cost of goods sold (COGS) posting. Drives financial accounting integration.. Valid values are `^[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Volumetric measurement of the material in cubic meters. Used for bulk materials (concrete, aggregates) and transportation capacity planning.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume field. Typically cubic meters (M3) for construction bulk materials.. Valid values are `M3|L|GAL|FT3`',
    `weight_unit` STRING COMMENT 'Unit of measure for gross and net weight fields. Typically kilograms (KG) or metric tons (TON) for construction materials.. Valid values are `KG|TON|LB|G`',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the material in meters. Used for area calculations and storage layout planning.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the material master record. Supports audit trail and data stewardship accountability.',
    CONSTRAINT pk_material_catalog PRIMARY KEY(`material_catalog_id`)
) COMMENT 'Authoritative catalog of all procurable materials, equipment components, and consumables managed in SAP MM Material Master. Captures material number, description, material group, base unit of measure, weight, dimensions, hazardous material classification, storage conditions, lead time, minimum order quantity, standard cost, and BIM object reference. SSOT for material identity used across MTO, PO, and goods receipt processes.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the Request for Quotation record. Primary key for the RFQ entity.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom the contract or purchase order was awarded following RFQ evaluation. Null if RFQ is not yet awarded or was cancelled.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Links RFQ issuance to the procurement buyer employee, required for responsibility reporting and cost allocation.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which this RFQ is issued. Links the RFQ to the specific project requiring materials, equipment, or services.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: RFQ includes design drawing to define item scope; procurement uses drawing for accurate material specification.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: RFQ references technical specification that defines material requirements; linking ensures traceability from procurement to design spec.',
    `award_date` DATE COMMENT 'Date on which the contract or purchase order was awarded to the selected vendor. Null if RFQ is not yet awarded.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract or purchase order awarded to the winning vendor. Null if RFQ is not yet awarded.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond required from vendors, if applicable. Typically a percentage of the estimated contract value.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether vendors must submit a bid bond or financial guarantee with their quotation to demonstrate commitment and financial capacity.',
    `bim_reference` STRING COMMENT 'Reference to BIM model elements or clash detection reports that vendors should review to ensure dimensional and spatial compatibility of materials or equipment.',
    `boq_reference` STRING COMMENT 'Reference to the Bill of Quantities document or section that this RFQ is based on. Links the RFQ to the project cost estimation and material take-off data.',
    `buyer_contact_email` STRING COMMENT 'Email address of the buyer or procurement contact for vendor inquiries and quotation submissions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_contact_name` STRING COMMENT 'Name of the procurement professional or buyer responsible for managing this RFQ and serving as the primary point of contact for vendors.',
    `buyer_contact_phone` STRING COMMENT 'Phone number of the buyer or procurement contact for urgent vendor communications.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled or withdrawn, if applicable. May include project scope changes, budget constraints, or inadequate vendor response.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ was officially closed, either through award, cancellation, or withdrawal. Marks the end of the vendor response period.',
    `contract_type` STRING COMMENT 'Type of contract structure anticipated for the awarded work: lump sum, unit price, cost plus fee, Guaranteed Maximum Price (GMP), or time and materials.. Valid values are `lump_sum|unit_price|cost_plus|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which vendor quotations must be submitted (e.g., USD, EUR, GBP). Ensures consistent pricing comparison.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical site address or location code where the materials or equipment must be delivered. May reference a specific construction site, warehouse, or laydown area.',
    `evaluation_criteria` STRING COMMENT 'Description of the criteria and weighting used to evaluate vendor quotations. May include price, delivery time, quality certifications, past performance, and technical compliance.',
    `hse_requirements` STRING COMMENT 'Health, safety, and environmental requirements that vendors must meet, including OSHA compliance, PPE standards, SWMS, and environmental permits.',
    `incoterms` STRING COMMENT 'Incoterms code defining the responsibilities of buyer and seller for transportation, insurance, and risk transfer. Critical for international procurement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invited_vendor_count` STRING COMMENT 'Number of vendors invited to submit quotations for this RFQ. Used to track competitive bidding and ensure adequate market coverage.',
    `issue_date` DATE COMMENT 'Date on which the RFQ was officially issued to vendors. Marks the start of the vendor response period.',
    `issuing_department` STRING COMMENT 'Name or code of the department or business unit that issued the RFQ, such as Procurement, Project Management, or Engineering.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was last updated. Tracks changes to scope, dates, or status throughout the RFQ lifecycle.',
    `mto_reference` STRING COMMENT 'Reference to the Material Take-Off document or identifier that quantifies the materials required. Used to ensure RFQ quantities align with engineering estimates.',
    `payment_terms` STRING COMMENT 'Standard payment terms specified in the RFQ, such as net 30, net 60, progress payments, or milestone-based payments. Defines when and how vendors will be paid.',
    `procurement_lead_time_days` STRING COMMENT 'Estimated or actual number of days from RFQ issuance to material delivery or service commencement. Used for project scheduling and critical path analysis.',
    `quality_requirements` STRING COMMENT 'Description of quality assurance and quality control requirements, including certifications (ISO 9001), testing protocols (FAT, SAT), and inspection plans (ITP) that vendors must comply with.',
    `required_delivery_date` DATE COMMENT 'Target date by which the materials, equipment, or services must be delivered to the project site. Critical for project scheduling alignment using CPM.',
    `response_count` STRING COMMENT 'Number of vendor quotations received in response to this RFQ. Indicates level of vendor interest and competitive response.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment that will be retained until project completion or defects liability period ends. Standard risk mitigation practice in construction contracts.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ, externally visible and used in vendor communications and procurement workflows. Typically follows organizational numbering conventions.. Valid values are `^RFQ-[A-Z0-9]{6,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Tracks progression from draft creation through vendor response collection to final award or cancellation. [ENUM-REF-CANDIDATE: draft|issued|open|closed|awarded|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on the category of procurement: materials (concrete, steel), equipment (cranes, generators), services (engineering, testing), or subcontract work packages.. Valid values are `materials|equipment|services|subcontract|design_build`',
    `scope_description` STRING COMMENT 'Detailed narrative description of the materials, equipment, or services being requested. Includes technical requirements, quality standards, and any special conditions or constraints.',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which vendors must submit their quotations. Late submissions may be rejected per procurement policy.',
    `title` STRING COMMENT 'Short descriptive title summarizing the scope of the RFQ, such as Structural Steel for Bridge Phase 2 or MEP Equipment for Terminal Building.',
    `vendor_prequalification_required` BOOLEAN COMMENT 'Indicates whether vendors must be prequalified or approved before they can submit quotations. Ensures only qualified vendors participate in the bidding process.',
    `warranty_period_months` STRING COMMENT 'Duration in months for which the vendor must provide warranty coverage for materials or equipment. Also known as Defects Liability Period (DLP) in some jurisdictions.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation records issued to vendors for pricing and availability of materials, equipment, or services, including header-level metadata and granular line-item detail. Captures RFQ number, issuing project, scope description, BOQ reference, submission deadline, bid bond requirement, evaluation criteria, invited vendor list, currency, RFQ status (draft, issued, closed, awarded, cancelled), and individual line items (line number, material/service description, quantity, UoM, required delivery date, site delivery location, technical specification reference, drawing/BIM reference). Sourced from SAP MM RFQ process and Procore bid management workflows. Enables granular vendor pricing comparison at the line-item level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`rfq_line` (
    `rfq_line_id` BIGINT COMMENT 'Unique identifier for the RFQ line item. Primary key for this entity.',
    `boq_id` BIGINT COMMENT 'Reference to the specific BOQ line item or position that this RFQ line corresponds to, linking procurement to the project estimate.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link RFQ line material to master catalog for normalization and remove redundant material_id column.',
    `vendor_id` BIGINT COMMENT 'Reference to a preferred or pre-qualified vendor for this item, if applicable.',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: RFQ line may be issued to address an RFI clarification; linking tracks which RFI prompted the procurement request.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this material or service is being procured.',
    `rfq_id` BIGINT COMMENT 'Reference to the parent RFQ header document under which this line item is issued.',
    `rfq_site_construction_project_id` BIGINT COMMENT 'Reference to the construction site or project location where the material or service will be utilized.',
    `service_id` BIGINT COMMENT 'Reference to the service master record when the line item represents a service rather than a material (e.g., engineering, labor, consulting).',
    `bim_model_reference` STRING COMMENT 'Reference to the BIM model element or object ID that corresponds to this procurement item, enabling 3D model integration.',
    `cost_code` STRING COMMENT 'The cost code or cost account to which this line item expenditure will be allocated for job costing and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amounts and vendor quotations (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'The site, warehouse, or facility address where the material or service is to be delivered.',
    `drawing_reference` STRING COMMENT 'Reference to the engineering drawing, CAD file, or design document number that illustrates or specifies this item.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'The total estimated cost for this line item (quantity × estimated unit price), used for internal budget tracking.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'The internal estimated or budgeted unit price for this item, used for cost comparison and budget control. Not shared with vendors.',
    `incoterm` STRING COMMENT 'The Incoterm defining the delivery terms and transfer of risk between buyer and seller (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this item requires formal inspection or testing upon delivery before acceptance (True/False).',
    `item_description` STRING COMMENT 'Detailed textual description of the material or service being requested, including specifications, grade, and any special requirements.',
    `lead_time_days` STRING COMMENT 'The expected or required procurement lead time in days from purchase order issuance to delivery.',
    `line_number` STRING COMMENT 'Sequential line number within the RFQ document for ordering and reference purposes.',
    `line_status` STRING COMMENT 'Current lifecycle status of this RFQ line item: draft (being prepared), issued (sent to vendors), quoted (responses received), evaluated (under review), awarded (vendor selected), or cancelled.. Valid values are `draft|issued|quoted|evaluated|awarded|cancelled`',
    `material_group` STRING COMMENT 'Classification or category code for the material or service type (e.g., concrete, steel, electrical, mechanical) used for grouping and reporting.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this RFQ line item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ line item record was last updated.',
    `notes` STRING COMMENT 'Additional free-text notes, instructions, or clarifications for vendors regarding this line item.',
    `priority` STRING COMMENT 'The urgency or priority level of this procurement line item relative to project schedule and critical path.. Valid values are `critical|high|medium|low`',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement type: direct material (project-specific), indirect material (general supplies), subcontract service, equipment rental, professional service, or consumable.. Valid values are `direct_material|indirect_material|subcontract_service|equipment_rental|professional_service|consumable`',
    `quality_requirement` STRING COMMENT 'Description of quality standards, certifications, or inspection requirements that the material or service must meet (e.g., ISO 9001, ASTM standards, factory acceptance test).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units being requested from vendors in this RFQ line.',
    `required_delivery_date` DATE COMMENT 'The date by which the material or service must be delivered to the site or designated location to meet project schedule requirements.',
    `short_text` STRING COMMENT 'Brief summary or short description of the line item for quick reference and display purposes.',
    `source_of_supply` STRING COMMENT 'Indicates the preferred or required sourcing strategy for this item: local, regional, international, preferred vendor, or open market.. Valid values are `local|regional|international|preferred_vendor|open_market`',
    `tax_code` STRING COMMENT 'The tax classification code applicable to this line item, determining VAT, GST, or other tax treatment.',
    `technical_specification_reference` STRING COMMENT 'Reference number or code pointing to the technical specification document that defines the quality, performance, and compliance requirements for this item.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured (e.g., EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Metric Ton, L=Liter, HR=Hour, DAY=Day, LOT=Lot, SET=Set, CUM=Cubic Meter, SQM=Square Meter, LM=Linear Meter, MT=Metric Ton). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|LOT|SET|CUM|SQM|LM|MT — 15 candidates stripped; promote to reference product]',
    `vendor_evaluation_criteria` STRING COMMENT 'Specific criteria or weighting factors to be used when evaluating vendor quotations for this line item (e.g., price 60%, delivery 20%, quality 20%).',
    `wbs_element` STRING COMMENT 'The WBS code or element that this procurement line item is charged to, enabling project cost tracking and control.',
    `created_by` STRING COMMENT 'User ID or name of the procurement professional who created this RFQ line item.',
    CONSTRAINT pk_rfq_line PRIMARY KEY(`rfq_line_id`)
) COMMENT 'Individual line items within an RFQ corresponding to specific materials, services, or BOQ positions. Captures line number, material or service description, quantity, unit of measure, required delivery date, site delivery location, technical specification reference, and any applicable drawing or BIM model reference. Enables granular vendor pricing comparison at the line-item level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` (
    `vendor_quotation_id` BIGINT COMMENT 'Unique identifier for the vendor quotation record. Primary key for this entity.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the procurement or engineering professional who evaluated this quotation. Supports audit trail and accountability.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Vendor quotations submitted by subcontractors require association with subcontractor firm for evaluation, audit, and bonding verification.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link vendor quotation material to master catalog for normalization and remove redundant material_id column.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ document that this quotation responds to. Links the vendor response back to the procurement request.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record submitting this quotation. Identifies the supplier providing the quote.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the quotation (technical datasheets, certifications, test reports, etc.).',
    `award_recommendation` STRING COMMENT 'Procurement team recommendation on whether to award the PO to this vendor based on evaluation results.. Valid values are `recommended|not_recommended|conditional|pending`',
    `commercial_exceptions` STRING COMMENT 'Vendor-declared exceptions or deviations from RFQ commercial terms (payment, delivery, penalties, etc.). Must be evaluated during bid tabulation.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the material is manufactured or sourced. Relevant for customs, duties, and local content requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the quotation record was first created in the procurement system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the quoted prices (e.g., USD, EUR, GBP, AED). Critical for multi-currency bid comparison.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Number of calendar days from PO issuance to material delivery at site. Critical for project scheduling and CPM integration.',
    `delivery_terms` STRING COMMENT 'Incoterms delivery terms defining responsibility transfer point (e.g., EXW, FOB, CIF, DDP). Impacts freight cost allocation and risk.',
    `deviations_from_specification` STRING COMMENT 'Vendor-declared exceptions, deviations, or clarifications to the RFQ technical specifications. Critical for commercial evaluation and risk assessment.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by vendor from list price or previous quotation. Used for price negotiation and historical benchmarking.',
    `evaluation_date` DATE COMMENT 'Date when the quotation evaluation was completed and recommendation finalized.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluation team regarding technical compliance, commercial terms, or vendor performance considerations.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Composite evaluation score assigned during bid tabulation based on price, technical compliance, delivery, and vendor performance. Used for award recommendation.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Quoted freight or transportation cost if not included in unit price. Depends on delivery terms (Incoterms).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the quotation record was last updated. Tracks changes during evaluation and negotiation cycles.',
    `material_description` STRING COMMENT 'Vendor-provided description of the material or service being quoted. May include brand, model, or specification details.',
    `payment_terms` STRING COMMENT 'Vendor-offered payment terms (e.g., Net 30, Net 60, 50% advance + 50% on delivery, LC at sight). Impacts cash flow and working capital.',
    `quotation_number` STRING COMMENT 'Vendor-assigned unique reference number for this quotation. External business identifier used for correspondence and tracking.',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the vendor quotation in the evaluation and award process.. Valid values are `submitted|under_review|accepted|rejected|withdrawn|expired`',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service the vendor is quoting for. Must align with RFQ requested quantity.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor submitted the quotation response. Critical for evaluating timeliness and compliance with RFQ deadlines.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax amount (VAT, GST, sales tax) on the quoted price. May vary by jurisdiction and project location.',
    `technical_compliance_status` STRING COMMENT 'Assessment of whether the quoted material meets the technical specifications defined in the RFQ. Evaluated by engineering team.. Valid values are `compliant|non_compliant|partial|under_review`',
    `total_price` DECIMAL(18,2) COMMENT 'Total quoted price for the full quantity (unit price × quantity). May include or exclude taxes and freight depending on quotation terms.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity (e.g., EA, M, KG, TON, M3, HR). Must match material master UOM or include conversion factor.',
    `unit_price` DECIMAL(18,2) COMMENT 'Vendor-quoted price per unit of measure. Base price before taxes, freight, or other charges.',
    `validity_end_date` DATE COMMENT 'Date until which the vendor commits to honor the quoted price and terms. Critical for award decision timing.',
    `validity_start_date` DATE COMMENT 'Date from which the quoted price and terms become valid. Typically the quotation submission date.',
    `warranty_period_months` STRING COMMENT 'Duration of warranty coverage offered by the vendor in months. Aligns with DLP (Defects Liability Period) requirements.',
    `warranty_terms` STRING COMMENT 'Detailed warranty terms and conditions including coverage scope, exclusions, and claim procedures.',
    CONSTRAINT pk_vendor_quotation PRIMARY KEY(`vendor_quotation_id`)
) COMMENT 'Vendor-submitted quotation responses to RFQs capturing quoted unit price, total price, delivery lead time, validity period, payment terms offered, country of origin, warranty terms, exceptions or deviations from specification, quotation submission timestamp, and compliance with technical specifications. Supports commercial bid tabulation, vendor price comparison analysis, and historical lead time benchmarking for award decisions. Links to RFQ and vendor master.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Required for PO issuance under a specific contract agreement to enable contract‑based payment validation and compliance reporting.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Capital equipment PO must be linked to the asset record for depreciation, warranty, and maintenance scheduling.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Required for PO creation audit; links PO buyer to employee responsible for issuance, used in spend analysis and compliance reports.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which materials, equipment, or services are being procured. Links to project master data.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this procurement expenditure. Used for financial reporting and budget tracking.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Subcontractor Labor PO Allocation – labor purchase orders are assigned to a specific crew to track labor costs against crew productivity.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Purchase Order references the drawing for fabricated components, ensuring delivery matches design intent.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Purchase orders for subcontractor services need to link to the subcontractor firm for contract compliance, insurance, and payment processing.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting purchase order accruals to the general ledger; finance GL account needed for expense recognition.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Add link from purchase order to its originating purchase requisition to capture parent-child relationship.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or subcontractor to whom this purchase order is issued. Links to vendor master data.',
    `acknowledgment_date` DATE COMMENT 'Date on which the vendor formally acknowledged receipt and acceptance of the purchase order terms.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or change orders issued against this purchase order. Used for contract change management reporting.',
    `approval_date` DATE COMMENT 'Date on which final approval was granted for this purchase order.',
    `approval_status` STRING COMMENT 'Current approval state of the purchase order in the authorization workflow. Tracks whether PO has received required management and financial approvals.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this purchase order for issuance.',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer responsible for managing this purchase order and vendor relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this purchase order record was first created in the procurement system.',
    `cumulative_amendment_value` DECIMAL(18,2) COMMENT 'Net change in purchase order value resulting from all amendments and change orders (positive or negative delta from original value).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary values in this purchase order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_revision_number` STRING COMMENT 'Revision number tracking minor corrections or clarifications within the current version. Used for document control and audit trail.',
    `current_version_number` STRING COMMENT 'Version number of the purchase order reflecting amendments and change orders. Increments with each approved modification.',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for material or equipment delivery to construction site or warehouse.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line for delivery location (building, floor, gate number, or site-specific instructions).',
    `delivery_city` STRING COMMENT 'City or municipality for delivery destination.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for delivery destination (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for delivery destination.',
    `delivery_state_province` STRING COMMENT 'State, province, or region for delivery destination.',
    `gmp_amount` DECIMAL(18,2) COMMENT 'The contractual ceiling amount for this purchase order when GMP terms apply. Vendor cannot exceed this amount without approved change orders.',
    `gmp_flag` BOOLEAN COMMENT 'Indicates whether this purchase order is subject to a Guaranteed Maximum Price contract, capping the total cost exposure.',
    `incoterms` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller (e.g., DDP, FOB, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issued_date` DATE COMMENT 'Date on which the purchase order was formally issued to the vendor. Marks the start of the contractual commitment.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or change order applied to this purchase order.',
    `last_amendment_type` STRING COMMENT 'Classification of the most recent amendment: scope change, quantity adjustment, price revision, delivery reschedule, formal change order, or terms modification.. Valid values are `scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this purchase order record, including amendments, status changes, or data corrections.',
    `ntp_date` DATE COMMENT 'Official date on which the vendor is authorized to commence work or delivery. Critical milestone for schedule tracking and contract start.',
    `original_po_value` DECIMAL(18,2) COMMENT 'Initial total value of the purchase order at time of first issuance, before any amendments or change orders. Used for cost variance analysis.',
    `payment_terms` STRING COMMENT 'Contractual payment terms specifying due date calculation (e.g., Net 30, Net 60, 2/10 Net 30, progress payment schedule, milestone-based).',
    `po_number` STRING COMMENT 'Externally-known unique purchase order number issued to vendor. Business identifier used in all procurement correspondence and invoicing.. Valid values are `^PO-[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from draft through approval, issuance, receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|in_progress|partially_received|fully_received|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of purchase order by procurement pattern: standard (one-time material/equipment), blanket (recurring supply agreement), framework (multi-project master agreement), subcontract (labor/construction services), service (professional services), rental (equipment lease).. Valid values are `standard|blanket|framework|subcontract|service|rental`',
    `promised_delivery_date` DATE COMMENT 'Vendor-committed delivery date as confirmed in purchase order acknowledgment. Used for schedule risk assessment and expediting.',
    `requested_delivery_date` DATE COMMENT 'Target date by which materials, equipment, or services are required on site. Used for procurement lead time planning and CPM schedule integration.',
    `requisition_number` STRING COMMENT 'Reference to the originating purchase requisition that triggered this purchase order. Links procurement request to fulfillment.. Valid values are `^PR-[0-9]{8,12}$`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Absolute monetary value withheld as retention, calculated from total PO value and retention percentage.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of payment withheld until contract completion or defects liability period expires. Common in construction subcontracts (typically 5-10%).',
    `sap_document_number` STRING COMMENT 'SAP MM system-generated unique document number for this purchase order. Used for ERP integration and cross-system reconciliation.. Valid values are `^[0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order (VAT, GST, sales tax) as calculated per jurisdiction and tax code.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, taxes, and charges. Expressed in the currency specified by currency_code.',
    `wbs_element` STRING COMMENT 'Hierarchical WBS code identifying the specific project phase, deliverable, or cost element to which this PO is charged. Used for project cost control and EVM tracking.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,8}(.[0-9]{1,4})*$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Legally binding purchase order issued to a vendor for supply of materials, equipment, or services, including full amendment and change order history as versioned records. Captures PO number, vendor, project and WBS element, delivery address, incoterms, payment terms, currency, total PO value, GMP flag, retention percentage, PO type (standard, blanket, framework, subcontract), approval status, NTP date, SAP document number, current version/revision number, and complete amendment audit trail (amendment number, amendment type — scope change, quantity change, price adjustment, delivery date change, CO, original value, amended value, value delta, reason, approval status, amendment date). Core transactional anchor of the procurement domain sourced from SAP MM. SSOT for all PO commercial state including historical changes and amendments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the PO line entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: PO line items that procure equipment need a direct reference to the specific asset for cost allocation and later maintenance work orders.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Detailed Labor Cost Allocation – PO line for labor services references the crew performing the work, enabling line‑level labor cost reporting.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link PO line material to master catalog for normalization and remove redundant material_id column.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header under which this line item is grouped. Links line-level detail to the overall PO document.',
    `account_assignment_category` STRING COMMENT 'SAP account assignment category indicating how costs are allocated: K=Cost Center, A=Asset, F=Order, P=Project, N=Network, U=Unknown. Determines financial posting logic.. Valid values are `K|A|F|P|N|U`',
    `buyer_name` STRING COMMENT 'Name of the procurement professional responsible for sourcing and purchasing this line item. Used for vendor communication and procurement accountability.',
    `cost_code` STRING COMMENT 'The detailed cost code used for job costing and financial tracking, enabling granular cost control and reporting at the activity or trade level.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was first created in the system. Used for audit trail and process timing analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the line item is priced and will be paid. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD — 7 candidates stripped; promote to reference product]',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item has been marked for deletion. True if the line is logically deleted but retained for audit purposes.',
    `delivery_date` DATE COMMENT 'The scheduled or requested delivery date for the material or completion date for the service on this line item. Critical for project scheduling and material planning.',
    `free_text_note` STRING COMMENT 'Additional free-form notes or special instructions related to this line item, such as quality requirements, packaging instructions, or delivery constraints.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this line item expenditure will be posted for financial reporting and compliance.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a goods receipt is required for this line item. True if GR is mandatory before invoice processing.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods received to date against this line item. Used to track delivery progress and outstanding quantities.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for delivery, insurance, and risk transfer per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The specific named place or port associated with the Incoterms designation, defining the point of delivery or risk transfer.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether invoice verification is required for this line item. True if IR is mandatory for payment processing.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced to date against this line item. Used for three-way matching and payment reconciliation.',
    `item_category` STRING COMMENT 'Classification of the line item type indicating the procurement scenario: standard purchase, service procurement, consignment, subcontracting, or stock transfer.. Valid values are `standard|service|consignment|subcontracting|stock_transfer`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was most recently updated. Used for change tracking and audit purposes.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order, used for ordering and referencing specific line items in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item indicating its fulfillment state: open (not yet received), partially received, fully received, closed (completed), or cancelled.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material, used for quality assurance and warranty tracking.',
    `material_description` STRING COMMENT 'Detailed textual description of the material or service being procured on this line, including specifications, grade, and any special requirements.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials together for procurement analysis, vendor management, and spend reporting.',
    `net_value` DECIMAL(18,2) COMMENT 'The total net value of this line item calculated as ordered quantity multiplied by unit price, before taxes and discounts.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service ordered on this line item, expressed in the unit of measure specified.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity yet to be delivered, calculated as ordered quantity minus goods receipt quantity. Critical for expediting and delivery monitoring.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Used for goods receipt tolerance checking.',
    `plant_code` STRING COMMENT 'The plant or site location code where the material will be delivered or the service will be performed. Used for multi-site inventory and logistics management.',
    `price_unit` STRING COMMENT 'The quantity of units to which the unit price applies (e.g., price per 1, per 10, per 100 units). Used for bulk pricing scenarios.',
    `requisitioner_name` STRING COMMENT 'Name of the person or department who requested this material or service, used for accountability and follow-up communication.',
    `short_text` STRING COMMENT 'Brief descriptive text for the line item, typically used for quick identification and reporting purposes.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where the material will be received and stored.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount applicable to this line item based on the tax code and net value.',
    `tax_code` STRING COMMENT 'Tax classification code that determines the applicable tax rate and tax jurisdiction for this line item.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Used for goods receipt tolerance checking.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is measured (e.g., each, meter, square meter, cubic meter, kilogram, ton, liter, hour, day, set, lot, box, roll, bag). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|SET|LOT|BOX|ROLL|BAG — 14 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the material or service on this line item, excluding taxes and additional charges.',
    `vendor_material_number` STRING COMMENT 'The suppliers own material or part number for the item being procured. Used for cross-referencing and supplier communication.',
    `wbs_element` STRING COMMENT 'The WBS element code to which this line item cost is assigned, enabling project-level cost tracking and allocation per CPM methodology.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order capturing material or service description, ordered quantity, unit of measure, unit price, line total, delivery schedule date, WBS element, cost code, account assignment category, goods receipt indicator, invoice receipt indicator, and cumulative goods receipt quantity to date. Enables granular cost tracking and delivery monitoring at the PO line level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which the materials were received. Enables project-level cost tracking and material allocation.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee who performed the physical receipt inspection and verified the delivery. Used for accountability and quality audit trail.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link goods receipt material to master catalog for normalization and remove redundant material_id column.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the physical delivery to the procurement contract.',
    `site_location_id` BIGINT COMMENT 'Reference to the construction site or warehouse location where the materials were physically received and stored.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the materials. Used for supplier performance tracking and three-way match verification.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the received materials. Critical for traceability, quality control, and recall management.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or logistics provider who delivered the materials. Used for carrier performance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the goods receipt value (e.g., USD, EUR, GBP). Used for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_completed_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt completes the delivery for the purchase order line item (True=complete, False=partial delivery expected).',
    `delivery_note_number` STRING COMMENT 'External delivery note or packing slip number provided by the vendor. Used for cross-referencing vendor shipment documentation.',
    `gr_document_number` STRING COMMENT 'Unique business document number assigned to this goods receipt transaction. Used for audit trail and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `inspection_status` STRING COMMENT 'Quality inspection status for the received materials. Determines whether materials can be released to inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|waived`',
    `invoice_verification_status` STRING COMMENT 'Status of three-way match process comparing PO, goods receipt, and vendor invoice. Determines whether invoice can be paid.. Valid values are `not_started|pending|matched|variance|blocked|completed`',
    `material_document_number` STRING COMMENT 'SAP material document number generated upon goods receipt posting. Used for inventory movement tracking and financial integration.. Valid values are `^[0-9]{10}$`',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the type of inventory transaction (e.g., 101=GR for PO, 122=Return Delivery). Determines financial and inventory impact.. Valid values are `^[0-9]{3}$`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material originally ordered on the purchase order line item. Used for variance analysis against received quantity.',
    `po_line_item_number` STRING COMMENT 'Line item number on the purchase order to which this goods receipt applies. Enables line-level three-way match.',
    `posting_date` DATE COMMENT 'Financial posting date for the goods receipt transaction. Used for period-end closing and financial reporting alignment.',
    `receipt_condition` STRING COMMENT 'Condition status of the received materials upon inspection (accepted=fully accepted, rejected=fully rejected, partial=partially accepted, damaged=damaged on arrival, on_hold=pending inspection, quarantine=quality hold).. Valid values are `accepted|rejected|partial|damaged|on_hold|quarantine`',
    `receipt_date` DATE COMMENT 'Date on which the materials were physically received at the site or warehouse. Used for lead time analysis and schedule compliance tracking.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods receipt was recorded in the system. Used for audit trail and real-time inventory updates.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material physically received and accepted. This is the quantity that updates inventory and triggers invoice verification.',
    `receiving_inspector_name` STRING COMMENT 'Full name of the receiving inspector who verified and accepted the delivery. Provides human-readable reference for audit and accountability.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of material rejected due to quality issues, damage, or non-conformance. Triggers vendor return or credit memo process.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal transaction if this goods receipt was cancelled. Used for audit trail and reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled (True=reversed, False=active). Reversed receipts do not update inventory.',
    `reversal_reason` STRING COMMENT 'Reason code or description explaining why the goods receipt was reversed (e.g., incorrect posting, return to vendor, data entry error).',
    `serial_number` STRING COMMENT 'Unique serial number for serialized equipment or high-value items. Enables individual asset tracking and warranty management.',
    `special_handling_instructions` STRING COMMENT 'Any special handling requirements or instructions for the received materials (e.g., temperature control, hazardous material protocols, fragile handling).',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location, warehouse bin, or laydown area where the materials are stored after receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applied to the goods receipt for sales tax, VAT, or GST calculation. Determines tax treatment in financial posting.',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the goods receipt (received quantity × unit price). Updates inventory value and triggers accounts payable accrual.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier. Enables real-time delivery status monitoring and proof of delivery.',
    `transportation_mode` STRING COMMENT 'Method of transportation used to deliver the materials (truck, rail, air, sea, courier, pickup). Used for logistics analysis and lead time optimization.. Valid values are `truck|rail|air|sea|courier|pickup`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the received quantity (e.g., EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Ton, L=Liter). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|BOX|PALLET|SET — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for the received material as per the purchase order. Used for inventory valuation and three-way match with invoice.',
    `unloading_point` STRING COMMENT 'Specific unloading dock, gate, or receiving area where the materials were delivered at the construction site.',
    `valuation_type` STRING COMMENT 'Material valuation category used for inventory accounting (e.g., standard cost, moving average price). Determines how the receipt is valued financially.',
    `variance_notes` STRING COMMENT 'Free-text notes explaining any discrepancies, damages, or special conditions observed during goods receipt. Used for dispute resolution and vendor performance tracking.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any variance between ordered and received quantities (e.g., short shipment, over delivery, damaged goods).',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Material goods receipt records capturing physical delivery of materials or equipment to site or warehouse against a PO. Records GR document number, delivery date, received quantity, unit of measure, storage location, batch number, delivery note reference, condition on receipt (accepted, rejected, partial), receiving inspector, and SAP material document number. Triggers inventory update and three-way match for invoice verification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` (
    `sourcing_plan_id` BIGINT COMMENT 'Primary key for sourcing_plan',
    `pursuit_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Procurement planning aligns with a specific bid opportunity; the link supports schedule and budget integration.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project for which this sourcing plan is created. Links procurement planning to the project execution context.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the procurement manager or buyer responsible for executing this sourcing plan.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Link sourcing plan to purchase requisition to tie planning to actual requisitions.',
    `approval_authority_level` STRING COMMENT 'Required approval authority level for this sourcing plan based on estimated value and risk classification.. Valid values are `buyer|procurement_manager|project_manager|director|executive`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this sourcing plan version.',
    `approved_date` DATE COMMENT 'Date when this sourcing plan version was formally approved for execution.',
    `budget_code` STRING COMMENT 'Project budget code or cost center against which this procurement will be charged. Links to project financial control structure.',
    `contract_type` STRING COMMENT 'Type of contract to be used for this procurement (e.g., lump sum, unit rate, cost-plus, GMP).. Valid values are `lump_sum|unit_rate|cost_plus|time_and_material|gmp`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated procurement value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Site address or warehouse location where materials are to be delivered. May reference a site operations location.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total value of the procurement covered by this sourcing plan. Used for budget allocation and approval authority determination.',
    `expediting_frequency` STRING COMMENT 'Frequency of expediting reviews and supplier progress checks (e.g., weekly, monthly, milestone-based).. Valid values are `daily|weekly|biweekly|monthly|milestone_based|not_required`',
    `expediting_method` STRING COMMENT 'Primary method used for expediting and progress monitoring (e.g., site visits to vendor facility, video conference, third-party inspection).. Valid values are `site_visit|video_conference|email_report|third_party_inspection|vendor_portal`',
    `expediting_required` BOOLEAN COMMENT 'Indicates whether active expediting and progress monitoring of the supplier is required due to schedule criticality or complexity.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the delivery point and risk transfer between buyer and seller (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_requirements` STRING COMMENT 'Description of quality inspection and testing requirements for the procured materials or equipment (e.g., FAT, SAT, third-party certification, mill test certificates).',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether the materials or services covered by this plan are on the project critical path and require expedited procurement to avoid schedule delays.',
    `is_long_lead_item` BOOLEAN COMMENT 'Indicates whether this sourcing plan covers long-lead items requiring early procurement action due to extended manufacturing or delivery lead times.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing plan record was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, assumptions, constraints, or special instructions related to this sourcing plan.',
    `packaging_strategy` STRING COMMENT 'Description of how procurement scope is bundled or split into packages for tendering (e.g., single package, split by trade, split by project phase, geographic split).',
    `payment_terms` STRING COMMENT 'Standard payment terms to be applied for this procurement (e.g., Net 30, progress payments, milestone-based, letter of credit).',
    `plan_number` STRING COMMENT 'Business identifier for the sourcing plan. Externally visible reference number used in procurement documentation and communications.. Valid values are `^SP-[A-Z0-9]{6,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the sourcing plan indicating its approval state and execution readiness.. Valid values are `draft|approved|active|on_hold|completed|cancelled`',
    `plan_version` STRING COMMENT 'Version number of the sourcing plan. Incremented when the plan is revised to track changes over the project lifecycle.',
    `planned_award_date` DATE COMMENT 'Target date for awarding the purchase order or contract to the selected supplier. Critical milestone for procurement lead time calculation.',
    `planned_bid_closing_date` DATE COMMENT 'Target date by which vendor bids or proposals are due for evaluation.',
    `planned_delivery_date` DATE COMMENT 'Target date for material or equipment delivery to site. Must align with construction schedule requirements and site readiness.',
    `planned_installation_date` DATE COMMENT 'Target date for installation or commissioning of the procured materials or equipment. Drives backward scheduling of procurement activities.',
    `planned_rfq_date` DATE COMMENT 'Target date for issuing the RFQ or RFP to potential suppliers. Aligns with project procurement schedule milestones.',
    `preferred_supplier_list` STRING COMMENT 'Comma-separated list of preferred or prequalified supplier names or codes to be invited for this procurement.',
    `procurement_category` STRING COMMENT 'Classification of the procurement scope covered by this plan (e.g., Structural Steel, MEP Equipment, Concrete Materials, Construction Services). Aligns with project WBS and material classification hierarchy.',
    `procurement_lead_time_days` STRING COMMENT 'Total lead time in days from purchase order award to site delivery, including manufacturing, inspection, and logistics time.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of payment to be retained until completion or end of defects liability period. Typical range 5-10%.',
    `risk_classification` STRING COMMENT 'Risk level associated with this procurement based on factors such as value, complexity, lead time, supplier market, and schedule impact.. Valid values are `low|medium|high|critical`',
    `sourcing_method` STRING COMMENT 'Procurement strategy and method to be used for acquiring the materials or services (e.g., competitive bidding, sole source negotiation, call-off from framework agreement).. Valid values are `competitive_bid|sole_source|framework_agreement|preferred_vendor|two_stage_tender|design_build`',
    `special_requirements` STRING COMMENT 'Any special procurement requirements such as local content mandates, sustainability certifications (LEED), HSE requirements, or regulatory compliance needs.',
    `supplier_prequalification_required` BOOLEAN COMMENT 'Indicates whether suppliers must be prequalified before being invited to bid for this procurement.',
    `warranty_period_months` STRING COMMENT 'Required warranty or defects liability period in months for the procured materials or equipment.',
    `wbs_element` STRING COMMENT 'WBS element code that this sourcing plan supports. Links procurement to project work packages and schedule activities.',
    CONSTRAINT pk_sourcing_plan PRIMARY KEY(`sourcing_plan_id`)
) COMMENT 'Project-level procurement execution plan defining the sourcing strategy, procurement milestones, long-lead item identification, packaging strategy, expediting requirements, and planned award dates for all major material and service categories. Captures plan version, project reference, procurement category, sourcing method (competitive bid, sole source, framework agreement), planned RFQ date, planned award date, planned delivery date, expediting frequency and method, responsible procurement manager, and critical path material flags. Integrates with Primavera P6 schedule milestones to ensure procurement activities align with construction sequencing.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule record. Primary key for the delivery schedule entity.',
    `activity_id` BIGINT COMMENT 'Primavera P6 activity identifier that requires this material delivery. Links delivery schedule to construction activity on the critical path.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Delivery schedule lines need to reference the material master to validate delivery quantities against approved specifications and to support logistics planning.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Link delivery schedule to purchase order for schedule alignment; po_number becomes redundant.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the material was delivered to the site. Populated upon goods receipt confirmation. Null if delivery has not yet occurred.',
    `actual_delivery_time` TIMESTAMP COMMENT 'Actual timestamp when the material delivery was received at the site gate or delivery point. Captured from site daily logs or gate entry system.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier or freight forwarder responsible for transporting the material from vendor to site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule record was first created in the system. Part of audit trail for data lineage.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether the associated activity is on the project critical path per CPM (Critical Path Method) analysis. True if on critical path, False otherwise. Drives prioritization of delivery tracking.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the reason for delivery delay (e.g., vendor production delay, logistics issue, customs clearance, weather, site access restriction). Null if no delay.. Valid values are `^[A-Z0-9]{2,6}$`',
    `delay_reason_description` STRING COMMENT 'Detailed explanation of the delay reason, including root cause analysis and corrective actions taken.',
    `delivery_note_number` STRING COMMENT 'Vendor-issued delivery note or packing slip number accompanying the shipment. Used for cross-referencing physical delivery with schedule record.',
    `delivery_point_code` STRING COMMENT 'Code identifying the specific delivery location on site (e.g., site gate, laydown area, warehouse, tower crane zone). References site location master data.. Valid values are `^[A-Z0-9-]{4,12}$`',
    `delivery_point_description` STRING COMMENT 'Detailed description of the delivery point location, including access instructions and unloading requirements.',
    `delivery_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scheduled for delivery in this schedule line. Must align with PO line item quantity and unit of measure.',
    `delivery_status` STRING COMMENT 'Current status of the delivery schedule indicating whether the delivery is progressing as planned or experiencing issues. Updated based on vendor updates and schedule variance analysis.. Valid values are `on-track|at-risk|delayed|delivered|cancelled|rescheduled`',
    `expedite_flag` BOOLEAN COMMENT 'Indicates whether this delivery has been flagged for expedited processing due to critical path impact or schedule risk. True if expedited, False otherwise.',
    `goods_receipt_number` STRING COMMENT 'SAP MM goods receipt document number generated upon physical receipt and acceptance of the material. Null if goods receipt has not been posted.. Valid values are `^[A-Z0-9]{10,15}$`',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received and accepted during goods receipt. May differ from delivery quantity due to shortages, damages, or over-delivery.',
    `incoterm` STRING COMMENT 'International Commercial Terms code defining the delivery terms and transfer of risk between vendor and buyer (e.g., EXW, FOB, CIF, DDP).. Valid values are `^[A-Z]{3}$`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the material requires QA/QC (Quality Assurance/Quality Control) inspection upon delivery before acceptance. True if inspection required, False otherwise.',
    `last_updated_by` STRING COMMENT 'User ID or name of the person who last updated this delivery schedule record. Supports accountability and audit trail requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule record was last modified. Tracks the most recent change for audit and synchronization purposes.',
    `lead_time_days` STRING COMMENT 'Total number of days from PO issuance to required on-site date. Used for procurement planning and schedule risk analysis.',
    `planned_delivery_time` TIMESTAMP COMMENT 'Specific time window planned for material delivery, including hour and minute. Critical for coordinating site logistics and crane availability.',
    `project_code` STRING COMMENT 'Unique identifier for the construction project to which this material delivery is assigned. Links delivery to project schedule and WBS (Work Breakdown Structure).. Valid values are `^[A-Z0-9-]{6,15}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the delivery schedule. Captures ad-hoc information not covered by structured fields.',
    `required_on_site_date` DATE COMMENT 'Date by which the material must be available on the construction site to support the project schedule. Derived from Primavera P6 activity start dates and material lead times.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the purchase order identifying this specific delivery schedule. Allows multiple delivery schedules per PO line item.',
    `schedule_variance_days` STRING COMMENT 'Number of days variance between vendor committed date and required on-site date. Positive values indicate early delivery, negative values indicate delay. Used for SPI (Schedule Performance Index) calculation.',
    `shipment_tracking_number` STRING COMMENT 'Carrier tracking number or bill of lading number for the shipment. Used for real-time logistics tracking and delivery confirmation.',
    `site_contact_name` STRING COMMENT 'Name of the site personnel responsible for coordinating and accepting the delivery. Typically site engineer or materials coordinator.',
    `site_contact_phone` STRING COMMENT 'Phone number of the site contact person for delivery coordination and issue resolution.',
    `special_handling_instructions` STRING COMMENT 'Specific instructions for handling, unloading, or storing the material upon delivery (e.g., crane required, temperature-sensitive, hazardous material, fragile).',
    `storage_location_code` STRING COMMENT 'Code identifying the warehouse or laydown area where the material will be stored after delivery until required for installation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for the delivery (road, rail, sea, air, or multimodal combination).. Valid values are `road|rail|sea|air|multimodal`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the delivery quantity (e.g., EA for each, TON for tons, M3 for cubic meters, KG for kilograms).. Valid values are `^[A-Z]{2,4}$`',
    `vendor_code` STRING COMMENT 'Unique identifier for the supplier or vendor responsible for delivering the material. References vendor master data.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vendor_committed_date` DATE COMMENT 'Date on which the vendor has committed to deliver the material to the designated delivery point. Captured from PO acknowledgment or vendor confirmation.',
    `wbs_element` STRING COMMENT 'Specific WBS element within the project structure where the material will be consumed. Enables cost allocation and progress tracking at granular level.. Valid values are `^[A-Z0-9.-]{8,20}$`',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Planned and actual material delivery schedule records coordinating vendor delivery commitments with project construction milestones. Captures schedule line, PO reference, material, required-on-site date, vendor committed delivery date, actual delivery date, delivery point (site gate, laydown area, warehouse), delivery status (on-track, at-risk, delayed), delay reason code, and schedule variance in days. Integrates with Primavera P6 project schedule.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` (
    `vendor_evaluation_id` BIGINT COMMENT 'Primary key for vendor_evaluation',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the senior manager or procurement director who approved the evaluation outcome.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project for which this vendor evaluation was conducted. Applicable for project-specific evaluations tied to bid eligibility.',
    `primary_vendor_evaluator_employee_id` BIGINT COMMENT 'Identifier of the procurement manager or project manager who conducted the vendor evaluation.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being evaluated. Links to the vendor master record in the procurement system.',
    `avl_entry_date` DATE COMMENT 'Date when the vendor was added to the AVL (Approved Vendor List) following successful pre-qualification. Null for vendors not yet approved.',
    `bid_invitation_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) determining whether the vendor is currently eligible to receive bid invitations for RFP (Request for Proposal) and RFQ (Request for Quotation) based on evaluation outcome and qualification status.',
    `bonding_limit_amount` DECIMAL(18,2) COMMENT 'Maximum contract value (in USD) for which the vendor can provide performance and payment bonds. Critical for pre-qualification and determines eligibility for large-scale EPC (Engineering Procurement and Construction) projects.',
    `commercial_compliance_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) evaluating the vendors adherence to contract terms, invoicing accuracy, payment terms compliance, and commercial documentation completeness.',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions required from the vendor to address performance gaps, quality issues, HSE violations, or compliance deficiencies identified during evaluation.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the vendor must complete and demonstrate closure of required corrective actions. Failure to meet this date may result in suspension or disqualification.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) signaling that the vendor must implement corrective actions to address identified deficiencies before qualification can be maintained or upgraded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor evaluation record was first created in the system. Audit trail for record lifecycle tracking.',
    `evaluation_date` DATE COMMENT 'Date when the evaluation was formally completed and scored. Represents the business event timestamp for the assessment.',
    `evaluation_notes` STRING COMMENT 'Free-text field capturing additional observations, strengths, weaknesses, and contextual information from the evaluator that supplements the quantitative scores.',
    `evaluation_number` STRING COMMENT 'Business identifier for the vendor evaluation record. Format: VE-YYYYMMDD followed by sequence number.. Valid values are `^VE-[0-9]{8}$`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. For periodic reviews, defines the close of the assessment window.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. For periodic reviews, defines the beginning of the assessment window. For pre-qualification, represents the date evaluation commenced.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the vendor evaluation. Tracks progression from draft through approval or rejection.. Valid values are `draft|in_progress|under_review|approved|rejected|on_hold`',
    `evaluation_type` STRING COMMENT 'Type of vendor evaluation being conducted. Pre-qualification for new vendors entering AVL (Approved Vendor List), periodic review for ongoing performance assessment, project-specific for bid eligibility, re-qualification for expired certifications, or incident-triggered for corrective action follow-up.. Valid values are `pre_qualification|periodic_review|project_specific|re_qualification|incident_triggered`',
    `financial_health_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) assessing the vendors financial stability based on credit rating, liquidity ratios, debt-to-equity, and financial statement analysis. Critical for pre-qualification and bonding capacity assessment.',
    `hse_incident_count` STRING COMMENT 'Total number of HSE (Health Safety and Environment) incidents (including LTI, near-misses, and safety violations) involving the vendor during the evaluation period.',
    `hse_rating_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) assessing the vendors HSE (Health Safety and Environment) performance including TRIR (Total Recordable Incident Rate), LTI (Lost Time Injury) frequency, safety certifications (ISO 45001), and HSE management system maturity.',
    `insurance_verified_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that the vendors general liability, professional indemnity, and workers compensation insurance policies have been verified and meet project requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor evaluation record was last updated. Audit trail for change tracking and data freshness monitoring.',
    `ncr_count` STRING COMMENT 'Total number of NCR (Non-Conformance Report) incidents raised against the vendor during the evaluation period. Lower counts indicate better quality performance.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage (0-100) of deliveries completed on or before the scheduled delivery date during the evaluation period. Key KPI for schedule performance and reliability.',
    `overall_kpi_rating` DECIMAL(18,2) COMMENT 'Composite numerical score (0-100) representing the weighted average of all evaluation dimensions (financial, technical, HSE, quality, delivery, responsiveness, commercial). Determines overall vendor performance grade.',
    `performance_grade` STRING COMMENT 'Letter grade (A through F) assigned based on overall KPI rating. A=Excellent (90-100), B=Good (80-89), C=Satisfactory (70-79), D=Marginal (60-69), F=Unsatisfactory (<60). Drives vendor tier classification and bid invitation priority.. Valid values are `A|B|C|D|F`',
    `qualification_expiry_date` DATE COMMENT 'Date when the vendors qualification status expires and requires renewal through re-evaluation. Typically set 12-24 months from evaluation date for qualified vendors.',
    `qualification_status` STRING COMMENT 'Resulting qualification status of the vendor based on evaluation outcome. Determines vendor eligibility for bid invitations and PO (Purchase Order) issuance.. Valid values are `qualified|conditionally_qualified|disqualified|suspended|expired`',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage (0-100) of delivered materials or services that passed quality inspection on first submission without NCR (Non-Conformance Report) during the evaluation period.',
    `quality_certification_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) evaluating the vendors quality management certifications (ISO 9001), QA/QC (Quality Assurance/Quality Control) processes, inspection capabilities, and adherence to ITP (Inspection and Test Plan) requirements.',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) assessing the vendors responsiveness to RFI (Request for Information), RFQ (Request for Quotation), change orders, and issue resolution. Measures communication effectiveness and turnaround time.',
    `technical_capability_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) evaluating the vendors technical competence, equipment availability, workforce skills, past project experience, and ability to meet technical specifications.',
    CONSTRAINT pk_vendor_evaluation PRIMARY KEY(`vendor_evaluation_id`)
) COMMENT 'Unified vendor assessment records covering both pre-qualification (AVL entry, financial health, technical capability, HSE ratings, quality certifications, bonding limits, insurance verification) and ongoing periodic performance evaluation (on-time delivery rate, quality acceptance rate, NCR count, HSE incident count, responsiveness score, commercial compliance score, overall KPI rating). Captures qualification status, evaluation type (pre-qualification, periodic review, project-specific), evaluation period, evaluating manager, corrective action flags, and qualification expiry dates. Feeds vendor approval decisions, bid invitation eligibility, and continuous improvement programs. Sourced from Procore, SAP MM, and Intelex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key for the purchase requisition entity.',
    `approval_workflow_id` BIGINT COMMENT 'Identifier of the approval workflow instance assigned to this purchase requisition based on value thresholds, project authority matrix, and organizational approval rules.',
    `pursuit_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Requisitions generated to support a bid opportunity need the opportunity reference for cost tracking and approval workflow.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Requisition originates from a client account; FK allows allocation of requisition spend to the correct client entity.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which this purchase requisition is raised. Links the requisition to the project master data for cost tracking and budget control.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Purchase requisitions are created for specific materials; linking to material master enables accurate budgeting, inventory checks, and compliance with approved material lists.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Identifies the employee who raised the PR; needed for requisition approval workflow and spend accountability.',
    `sustainability_plan_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_plan. Business justification: Procurement requisitions are evaluated against the project’s sustainability plan to ensure purchases meet carbon‑reduction and waste‑diversion targets.',
    `approval_date` DATE COMMENT 'Date when the purchase requisition received final approval and became eligible for conversion to RFQ or PO.',
    `budget_available_flag` BOOLEAN COMMENT 'Indicates whether sufficient budget is available in the assigned WBS element or cost center to cover the estimated cost of this requisition. True if budget is available, False if insufficient.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between available budget and the estimated total cost. Positive value indicates surplus budget, negative indicates deficit requiring approval override.',
    `closed_date` DATE COMMENT 'Date when the purchase requisition was administratively closed after full conversion to procurement documents or cancellation, marking the end of its active lifecycle.',
    `conversion_date` DATE COMMENT 'Date when the purchase requisition was converted to an RFQ or PO document.',
    `conversion_status` STRING COMMENT 'Indicates whether and how the approved purchase requisition has been converted into downstream procurement documents (RFQ for competitive bidding or direct PO for known vendors).. Valid values are `not_converted|converted_to_rfq|converted_to_po|partially_converted`',
    `converted_document_number` STRING COMMENT 'Document number of the RFQ or PO that was created from this purchase requisition, establishing traceability through the procurement lifecycle.',
    `cost_center_code` STRING COMMENT 'Cost center to which the requisition cost is allocated, used when the requisition is not project-specific or for indirect procurement.. Valid values are `^CC-[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase requisition record was first created in the ERP system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amounts (e.g., USD, EUR, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `current_approver_name` STRING COMMENT 'Name of the individual currently responsible for reviewing and approving the purchase requisition in the workflow sequence.',
    `delivery_location` STRING COMMENT 'Site address, warehouse, or specific location where the materials or equipment should be delivered. Critical for logistics planning and site coordination.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for the requisition line, calculated as quantity multiplied by estimated unit cost. Used for budget availability verification.',
    `estimated_unit_cost` DECIMAL(18,2) COMMENT 'Estimated cost per unit of the requested material or service, used for budget checking and preliminary cost estimation.',
    `justification_notes` STRING COMMENT 'Business justification and rationale for the purchase requisition, including project need, schedule impact, and any special circumstances requiring expedited processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase requisition record was last updated, capturing any changes to status, approvals, or requisition details.',
    `material_description` STRING COMMENT 'Detailed textual description of the material, equipment, or service being requested. Includes specifications, grade, dimensions, and any special requirements.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials or services for procurement strategy, vendor assignment, and reporting (e.g., concrete, steel, electrical, MEP services).',
    `mto_reference` STRING COMMENT 'Reference to the Material Take-Off document or line item from which this requisition was derived, linking procurement to engineering quantity estimates.',
    `pr_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows and communications.. Valid values are `^PR-[0-9]{8}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and conversion workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|converted|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the purchase requisition based on procurement category: standard materials, subcontract services, general services, stock transfers between sites, consignment arrangements, or equipment rental.. Valid values are `standard|subcontract|service|stock_transfer|consignment|rental`',
    `preferred_vendor_code` STRING COMMENT 'Vendor code of the preferred or suggested supplier for this requisition, if the requester has a specific vendor recommendation based on prior performance or technical requirements.',
    `procurement_strategy` STRING COMMENT 'Sourcing approach to be used for fulfilling this requisition based on value, complexity, vendor availability, and time constraints.. Valid values are `direct_po|competitive_rfq|framework_agreement|spot_buy|emergency_procurement`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service being requested, expressed in the unit of measure specified.',
    `rejection_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver in the workflow, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition, including corrective actions required for resubmission.',
    `requester_email` STRING COMMENT 'Email address of the requester for communication regarding the purchase requisition status, clarifications, and approvals.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the individual who created and submitted the purchase requisition.',
    `requesting_department` STRING COMMENT 'Name or code of the department or functional unit that originated the purchase requisition (e.g., Site Operations, Engineering, Procurement, MEP).',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, equipment, or services must be delivered to the project site or requesting location to meet project schedule requirements.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created and submitted by the requesting party. Principal business event timestamp for the requisition.',
    `technical_specification_attached` BOOLEAN COMMENT 'Indicates whether detailed technical specifications, drawings, or engineering documents are attached to support the requisition evaluation and vendor quotation process.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the requested quantity is measured (e.g., EA for each, M for meter, M3 for cubic meter, KG for kilogram, HR for hour). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|SET|LOT — 11 candidates stripped; promote to reference product]',
    `urgency_classification` STRING COMMENT 'Priority level of the purchase requisition based on project schedule impact and delivery timeline requirements. Emergency requisitions bypass standard approval workflows.. Valid values are `routine|urgent|critical|emergency`',
    `wbs_element` STRING COMMENT 'Specific WBS element within the project structure to which this requisition is charged. Enables granular cost control and tracking at the work package level.. Valid values are `^[A-Z0-9]{2}-[0-9]{4}-[0-9]{2}-[0-9]{3}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisition raised by project or site teams to initiate procurement of materials, equipment, or services. Captures requisition number, requesting department, project and WBS element, material or service description, required quantity, unit of measure, required delivery date, estimated cost, budget availability flag, approval workflow status (pending, approved, rejected), approver, urgency classification, and conversion status (converted to RFQ or PO). Sourced from SAP MM PR process. Entry point for all formal procurement activity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`po_amendment` (
    `po_amendment_id` BIGINT COMMENT 'Unique identifier for the purchase order amendment record. Primary key for the po_amendment product.',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract or framework agreement under which this purchase order and amendment are governed. Links to contractual terms and conditions.',
    `approval_workflow_id` BIGINT COMMENT 'Identifier of the approval workflow instance used to process this amendment. Tracks the routing and authorization path.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this purchase order amendment applies. Links procurement changes to project context.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order being amended. Links this amendment to the original PO document.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor associated with the purchase order being amended. Tracks vendor-specific amendment history.',
    `amended_delivery_date` DATE COMMENT 'The revised delivery or completion date after this amendment. New scheduled milestone post-change.',
    `amended_po_value` DECIMAL(18,2) COMMENT 'The revised total monetary value of the purchase order after this amendment is applied. New committed amount post-change.',
    `amended_quantity` DECIMAL(18,2) COMMENT 'The revised quantity of materials or services after this amendment. New committed quantity post-change.',
    `amendment_description` STRING COMMENT 'Comprehensive description of the changes being made in this amendment. Details the specific modifications to scope, quantity, price, delivery, or terms.',
    `amendment_number` STRING COMMENT 'Sequential amendment identifier for the purchase order (e.g., AMD-001, AMD-002). Tracks the version history of PO changes.',
    `amendment_reason` STRING COMMENT 'Detailed business justification for the purchase order amendment. Explains why the change was necessary (e.g., design change, site condition variation, client request, material unavailability, schedule acceleration).',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment: draft (being prepared), pending_approval (submitted for review), approved (authorized for implementation), rejected (not approved), cancelled (withdrawn), or implemented (executed in system).. Valid values are `draft|pending_approval|approved|rejected|cancelled|implemented`',
    `amendment_type` STRING COMMENT 'Classification of the amendment nature: scope change (work scope modification), quantity change (material quantity adjustment), price adjustment (unit price or total value change), delivery date change (schedule modification), change order (CO - formal change request), or terms modification (payment or contract terms update).. Valid values are `scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification`',
    `approval_date` DATE COMMENT 'Date when the amendment was formally approved by authorized personnel. Marks the point of contractual commitment.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this amendment. Establishes approval authority and accountability.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to this amendment (e.g., revised drawings, technical specifications, cost breakdowns, correspondence). Tracks documentation completeness.',
    `budget_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires budget reallocation or additional funding approval. True if budget impact exceeds threshold, false otherwise.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved this amendment. Applicable only when client_approval_required is true.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether this amendment requires formal approval from the project client or owner. True if client sign-off is contractually required, false otherwise.',
    `co_reference_number` STRING COMMENT 'Reference number of the associated Change Order (CO) document if this amendment originated from a formal change order process. Links PO amendment to project change management.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the amendment value delta is charged. Enables financial tracking and budget impact analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was first created in the database. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this amendment (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the amendment becomes legally effective and binding. May differ from approval date based on contract terms.',
    `impact_on_schedule` STRING COMMENT 'Assessment of how this amendment affects the project schedule: no_impact (no schedule change), acceleration (schedule shortened), delay (schedule extended), or critical_path_affected (impacts critical path activities).. Valid values are `no_impact|acceleration|delay|critical_path_affected`',
    `implementation_date` DATE COMMENT 'Date when the amendment was executed and reflected in operational systems (ERP, procurement, scheduling). Tracks system update completion.',
    `initiated_by` STRING COMMENT 'Name or identifier of the person or role who initiated this amendment request. Tracks accountability for change origination.',
    `initiated_date` DATE COMMENT 'Date when the amendment request was formally initiated or submitted for processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was last updated. Audit trail for record modification tracking.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this amendment. Captures supplementary information not covered by structured fields.',
    `original_delivery_date` DATE COMMENT 'The originally scheduled delivery date for materials or completion date for services before this amendment.',
    `original_po_value` DECIMAL(18,2) COMMENT 'The total monetary value of the purchase order before this amendment. Baseline amount for calculating value delta.',
    `original_quantity` DECIMAL(18,2) COMMENT 'The original quantity of materials or services specified in the purchase order before amendment. Used for quantity change tracking.',
    `quantity_uom` STRING COMMENT 'Unit of measure for quantity fields (e.g., EA for each, TON for tons, M3 for cubic meters, KG for kilograms). Standardizes quantity interpretation.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the delivery or completion schedule is impacted. Positive values indicate delay, negative values indicate acceleration.',
    `value_delta` DECIMAL(18,2) COMMENT 'The net change in purchase order value resulting from this amendment (amended_po_value minus original_po_value). Positive indicates increase, negative indicates decrease.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure (WBS) element code identifying the specific project work package affected by this amendment. Enables project cost control and EVM tracking.',
    CONSTRAINT pk_po_amendment PRIMARY KEY(`po_amendment_id`)
) COMMENT 'Change order and amendment records against issued purchase orders capturing amendment number, amendment type (scope change, quantity change, price adjustment, delivery date change, CO — Change Order), original value, amended value, value delta, reason for amendment, approval status, and amendment date. Maintains full audit trail of PO commercial changes throughout the procurement lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Ensures invoice verification against contract terms, supporting audit of payments versus agreed contract values.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Invoices for equipment purchases/rentals must link to the asset to close the financial‑asset loop for accounting and warranty tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this invoice is allocated. Used for project cost tracking and job costing.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this invoice is charged for financial accounting and cost control purposes.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this invoice for payment.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Vendor invoices need a cost‑code reference to map spend to project cost structures and support earned‑value analysis.',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account to which this invoice is posted in the financial accounting system.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice was received. Used for three-way match validation (PO-GR-Invoice).',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice. Links to vendor master data.',
    `approval_date` DATE COMMENT 'The date on which the invoice was approved for payment by the authorized approver.',
    `blocked_reason` STRING COMMENT 'Reason why the invoice is blocked from payment, such as pending approval, missing documentation, price variance, or quality hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts, volume discounts, or negotiated rebates.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this invoice is currently under dispute due to discrepancies in quantity, quality, pricing, or terms.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for the invoice dispute, such as quantity mismatch, pricing error, quality issues, or missing documentation.',
    `fi_document_number` STRING COMMENT 'The SAP FI document number generated when the invoice is posted to the financial accounting system. This is the system-generated accounting document reference.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which this invoice is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this invoice is recorded for financial reporting purposes.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming that materials or services were received. Used in three-way match validation.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice transaction.',
    `invoice_description` STRING COMMENT 'Textual description of the goods or services covered by this invoice, providing context for the transaction.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments. Represents the base value of goods or services invoiced.',
    `invoice_net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after applying taxes, discounts, and adjustments. This is the final amount due to the vendor.',
    `invoice_number` STRING COMMENT 'The externally-issued invoice number provided by the vendor. This is the vendors unique identifier for the invoice document.',
    `invoice_received_date` DATE COMMENT 'The date the invoice was received by the procurement or accounts payable department.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the vendor invoice in the verification and payment workflow. [ENUM-REF-CANDIDATE: draft|received|under_review|blocked|approved|posted|paid|disputed|cancelled — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type indicating the nature of the transaction (standard invoice, credit memo for returns, debit memo for additional charges, etc.). [ENUM-REF-CANDIDATE: standard|credit_memo|debit_memo|prepayment|final|progress|retention_release — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this invoice, such as special instructions, clarifications, or internal remarks.',
    `payment_date` DATE COMMENT 'The actual date on which payment was made to the vendor for this invoice.',
    `payment_due_date` DATE COMMENT 'The date by which payment must be made to the vendor to comply with payment terms and avoid late payment penalties.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the vendor for this invoice.. Valid values are `wire_transfer|check|ach|credit_card|letter_of_credit|cash`',
    `payment_reference_number` STRING COMMENT 'Reference number of the payment transaction when the invoice is paid, linking the invoice to the payment record.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this invoice, such as Net 30, Net 60, or 2/10 Net 30, defining the payment schedule and any early payment discount conditions.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the invoice payment as retention per contract terms, typically released upon project completion or after the Defects Liability Period (DLP).',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the invoice amount withheld as retention, typically ranging from 5% to 10% per construction contract terms.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax code applied to this invoice, defining the tax rate and tax type (VAT, GST, sales tax) per jurisdiction.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing purchase order, goods receipt (GR), and invoice. Indicates whether quantities, prices, and terms align across all three documents.. Valid values are `matched|quantity_variance|price_variance|not_matched|bypassed`',
    `verification_status` STRING COMMENT 'Status of the invoice verification process indicating whether the invoice has been validated against the purchase order and goods receipt.. Valid values are `pending|verified|rejected|on_hold`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per tax regulations, to be remitted to tax authorities.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoices received against purchase orders capturing invoice number, vendor, PO reference, invoice date, invoice amount, tax amount, currency, payment due date, three-way match status (PO-GR-Invoice), invoice verification status (blocked, approved, posted), SAP FI document number, and dispute flag. Distinct from client billing invoices owned by the finance domain — this is the SSOT for vendor payable documents in procurement.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` (
    `procurement_framework_agreement_id` BIGINT COMMENT 'Unique identifier for the procurement framework agreement record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Framework agreements bind a client account to a vendor; FK captures the client side of the contract for compliance and spend analysis.',
    `agreement_id` BIGINT COMMENT 'SSOT reference to canonical contract.client_framework_agreement (single source of truth).',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Framework agreement links a vendor to a specific project; needed for spend tracking, legal obligations, and performance monitoring.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the procurement professional or buyer responsible for managing this framework agreement.',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred vendor or supplier party with whom this framework agreement is established.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the framework agreement for easy identification and reference (e.g., Concrete Supply Framework 2024-2026).',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the framework agreement, typically following organizational numbering convention (e.g., FA-2024-001234).. Valid values are `^FA-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the framework agreement indicating its operational state and validity. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the framework agreement structure indicating the procurement mechanism (blanket order, call-off contract, master agreement, preferred supplier arrangement, rate contract, or volume-based agreement).. Valid values are `blanket_order|call_off_contract|master_agreement|preferred_supplier|rate_contract|volume_agreement`',
    `approval_date` DATE COMMENT 'Date when the framework agreement was formally approved and authorized for execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this framework agreement automatically renews upon expiration unless explicitly terminated (True) or requires explicit renewal action (False).',
    `call_off_mechanism` STRING COMMENT 'Method by which individual purchase orders or material releases are issued against this framework agreement (PO against agreement, release order, direct call-off, scheduled delivery, or project allocation).. Valid values are `po_against_agreement|release_order|direct_call_off|scheduled_delivery|project_allocation`',
    `commodity_category_code` STRING COMMENT 'Classification code identifying the procurement category or commodity group covered by this framework agreement (e.g., concrete, formwork, scaffolding, PPE, steel reinforcement).. Valid values are `^[A-Z0-9]{3,10}$`',
    `commodity_category_description` STRING COMMENT 'Detailed description of the commodity or material category covered under this framework agreement.',
    `compliance_certifications_required` STRING COMMENT 'List of mandatory compliance certifications, standards, or regulatory approvals required for materials or services procured under this framework agreement (e.g., ISO certifications, LEED compliance, OSHA standards).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this framework agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this framework agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard delivery lead time in days from order placement to material delivery as agreed in the framework agreement.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising from this framework agreement (arbitration, mediation, litigation, or adjudication).. Valid values are `arbitration|mediation|litigation|adjudication`',
    `effective_end_date` DATE COMMENT 'Date when the framework agreement expires or terminates, marking the end of the validity period. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the framework agreement becomes binding and operational, marking the beginning of the validity period.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law applicable to this framework agreement (e.g., Laws of the State of California, English Law).',
    `insurance_requirements` STRING COMMENT 'Insurance coverage types and minimum limits required from the vendor under this framework agreement (e.g., general liability, professional indemnity, product liability).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this framework agreement record was last updated or modified in the system.',
    `maximum_commitment_value` DECIMAL(18,2) COMMENT 'Maximum financial commitment or ceiling amount that can be procured under this framework agreement over its entire validity period.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered in a single call-off or purchase order under this framework agreement.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered in each call-off or purchase order under this framework agreement.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this framework agreement for internal reference.',
    `payment_terms` STRING COMMENT 'Standard payment terms and conditions applicable to all purchase orders issued under this framework agreement (e.g., Net 30, Net 60, 2/10 Net 30).',
    `performance_bond_percentage` DECIMAL(18,2) COMMENT 'Percentage of the maximum commitment value required as performance bond or guarantee, if applicable.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether the vendor is required to provide a performance bond or guarantee for this framework agreement (True) or not (False).',
    `pricing_schedule_reference` STRING COMMENT 'Reference identifier or document number for the detailed pricing schedule, rate card, or price list associated with this framework agreement.',
    `procurement_organization_code` STRING COMMENT 'Code identifying the procurement organization or business unit that owns and manages this framework agreement.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_requirements` STRING COMMENT 'Quality assurance and quality control standards, specifications, and requirements that materials or services under this framework agreement must meet.',
    `renewal_terms` STRING COMMENT 'Terms and conditions governing the renewal or extension of this framework agreement, including notice periods, renewal options, and conditions.',
    `sustainability_criteria` STRING COMMENT 'Environmental and sustainability requirements or preferences specified in the framework agreement, such as recycled content, carbon footprint limits, or LEED material requirements.',
    `termination_date` DATE COMMENT 'Actual date when the framework agreement was terminated early, if applicable. Null if agreement ran to natural expiration or is still active.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate this framework agreement before its natural expiration.',
    `termination_reason` STRING COMMENT 'Business reason or justification for early termination of the framework agreement, if applicable.',
    `total_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all purchase orders and call-offs issued against this framework agreement since its effective start date.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantities in this framework agreement (e.g., M3 for cubic meters, TON for metric tons, EA for each, M for meters).. Valid values are `^[A-Z]{2,5}$`',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the maximum commitment value that has been utilized through purchase orders and call-offs to date.',
    CONSTRAINT pk_procurement_framework_agreement PRIMARY KEY(`procurement_framework_agreement_id`)
) COMMENT 'Long-term framework agreements and blanket contracts with preferred vendors establishing pre-agreed pricing, terms, and conditions for recurring procurement categories (e.g., concrete supply, formwork rental, scaffolding, PPE). Captures agreement number, vendor, commodity category, validity period, maximum commitment value, call-off mechanism, pricing schedule reference, and renewal terms. Enables faster PO issuance without repeated tendering. [SSOT: distinct source of truth for procurement domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`inspection_release` (
    `inspection_release_id` BIGINT COMMENT 'Unique identifier for the inspection release record. Primary key for vendor quality compliance and documentation tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this inspection is being performed. Links inspection to project context.',
    `embodied_carbon_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.embodied_carbon_assessment. Business justification: Inspection releases must reference the embodied carbon assessment of the inspected material to verify compliance with carbon‑intensity specifications.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Associates inspection release with the inspector employee; required for HSE compliance and inspection traceability.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link inspection release material to master catalog for normalization and remove redundant material_id column.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this inspection is performed. Links inspection to procurement contract.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor whose materials or equipment are being inspected. Links to vendor master data.',
    `aconex_transmittal_reference` STRING COMMENT 'Reference number for the Aconex document transmittal through which the inspection documents were formally submitted and distributed.. Valid values are `^TRN-[0-9]{8,12}$`',
    `as_built_drawing_document_number` STRING COMMENT 'Document control number for as-built drawings submitted by vendor showing final fabricated dimensions and configurations.. Valid values are `^ABD-[0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection release record was first created in the system. Audit trail for record creation.',
    `document_review_date` DATE COMMENT 'Date when the document review was completed and approval status was assigned.',
    `document_review_status` STRING COMMENT 'Current review status of the vendor-submitted inspection and technical documents. Tracks document approval workflow.. Valid values are `under_review|approved|approved_with_comments|rejected|resubmit_required`',
    `document_reviewer_name` STRING COMMENT 'Name of the engineer or QA/QC specialist who reviewed and approved the inspection documentation.',
    `document_revision_number` STRING COMMENT 'Revision identifier for the inspection documentation package. Tracks version control for resubmissions and updates.. Valid values are `^[A-Z0-9]{1,3}$`',
    `document_submission_date` DATE COMMENT 'Date when the vendor submitted the inspection documentation package for review.',
    `equipment_tag_number` STRING COMMENT 'Unique tag identifier for the specific equipment unit being inspected. Used for traceability in MEP and major equipment installations.. Valid values are `^[A-Z0-9]{2,4}-[A-Z0-9]{3,6}-[0-9]{3,5}$`',
    `inspection_date` DATE COMMENT 'Date when the physical inspection or test was conducted. Principal business event timestamp for the inspection activity.',
    `inspection_location` STRING COMMENT 'Physical location where the inspection was performed (e.g., vendor factory, fabrication yard, construction site, third-party testing facility).',
    `inspection_order_number` STRING COMMENT 'Business identifier for the inspection order issued to vendor or third-party inspector. Format: IO-YYYYNNNN.. Valid values are `^IO-[0-9]{8}$`',
    `inspection_remarks` STRING COMMENT 'Free-text field for inspector comments, observations, special conditions, or additional notes regarding the inspection findings.',
    `inspection_report_document_number` STRING COMMENT 'Document control number for the formal inspection report. Links to document management system for full report retrieval.. Valid values are `^DOC-[0-9]{8,12}$`',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection. Pass indicates full compliance, conditional pass indicates minor non-conformances with agreed remediation, fail indicates rejection, pending retest indicates awaiting re-inspection.. Valid values are `pass|conditional_pass|fail|pending_retest`',
    `inspection_scope` STRING COMMENT 'Detailed description of the inspection scope, including specific tests performed, standards applied, and acceptance criteria used.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection order. Tracks progression from scheduling through completion and release.. Valid values are `scheduled|in_progress|completed|released|on_hold|cancelled`',
    `inspection_type` STRING COMMENT 'Category of inspection performed. FAT (Factory Acceptance Test), SAT (Site Acceptance Test), pre-shipment inspection, third-party inspection, dimensional check, witness test, mill inspection, hydrostatic test, or non-destructive test (NDT). [ENUM-REF-CANDIDATE: FAT|SAT|pre_shipment|third_party|dimensional_check|witness_test|mill_inspection|hydrostatic_test|non_destructive_test — 9 candidates stripped; promote to reference product]',
    `inspection_witness_required` BOOLEAN COMMENT 'Flag indicating whether client or third-party witness is contractually required to be present during inspection. True if witness hold point is specified in ITP.',
    `inspector_name` STRING COMMENT 'Full name of the inspector or inspection agency representative who performed the inspection. May be internal QA/QC staff, third-party inspector, or client representative.',
    `inspector_organization` STRING COMMENT 'Name of the organization or agency that performed the inspection (e.g., internal QA/QC team, third-party inspection agency, client representative).',
    `itp_reference_number` STRING COMMENT 'Reference to the approved Inspection and Test Plan document that defines the inspection requirements and hold points for this material or equipment.. Valid values are `^ITP-[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection release record was last updated. Audit trail for record modifications.',
    `material_data_sheet_document_number` STRING COMMENT 'Document control number for the vendor-submitted material data sheet. Contains material properties, composition, and technical characteristics.. Valid values are `^MDS-[0-9]{8,12}$`',
    `mill_certificate_document_number` STRING COMMENT 'Document control number for the mill test certificate (MTC) or material test report (MTR) provided by the manufacturer. Critical for material traceability.. Valid values are `^MC-[0-9]{8,12}$`',
    `ncr_count` STRING COMMENT 'Number of Non-Conformance Reports raised during this inspection. Zero indicates full compliance with specifications.',
    `om_manual_document_number` STRING COMMENT 'Document control number for the vendor-submitted Operations and Maintenance manual. Required for equipment handover and commissioning.. Valid values are `^OM-[0-9]{8,12}$`',
    `punch_list_items` STRING COMMENT 'Comma-separated list or detailed description of outstanding punch list items, deficiencies, or minor non-conformances identified during inspection that require remediation before final release.',
    `release_certificate_number` STRING COMMENT 'Unique certificate number issued upon successful inspection, authorizing shipment or installation. Format: RC-YYYYNNNN. Required before goods can be shipped to site.. Valid values are `^RC-[0-9]{8}$`',
    `release_date` DATE COMMENT 'Date when the inspection release certificate was issued and materials were authorized for shipment or installation.',
    `shipment_authorization_date` DATE COMMENT 'Date when the vendor was formally authorized to ship the inspected materials to the construction site following successful inspection release.',
    `technical_specification_reference` STRING COMMENT 'Reference to the technical specification document or drawing number against which the inspection was performed.',
    `test_report_document_number` STRING COMMENT 'Document control number for laboratory or field test reports (e.g., NDT reports, hydrostatic test reports, performance test reports).. Valid values are `^TR-[0-9]{8,12}$`',
    `witness_organization` STRING COMMENT 'Name of the client organization or third-party entity that witnessed the inspection, if witness was required.',
    `witness_representative_name` STRING COMMENT 'Name of the individual representative from the witness organization who attended the inspection.',
    CONSTRAINT pk_inspection_release PRIMARY KEY(`inspection_release_id`)
) COMMENT 'Vendor quality compliance and documentation records encompassing Factory Acceptance Tests (FAT), pre-shipment inspections, and all vendor-submitted technical documents/submittals required under a PO or framework agreement. Captures inspection order number, vendor, material/equipment tag, inspection type (FAT, SAT, third-party inspection, dimensional check), inspection date, inspector name, inspection result (pass, conditional pass, fail), punch list items, release certificate number, and associated vendor documents (material data sheets, mill certificates, test reports, ITP submissions, O&M manuals, as-built drawings) with document number, revision, submission date, review status (under review, approved, approved with comments, rejected), document type, and Aconex transmittal reference. Required before goods are shipped to site. SSOT for vendor quality evidence and technical submittals in procurement.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_document` (
    `vendor_document_id` BIGINT COMMENT 'Unique identifier for the vendor-submitted document record. Primary key for the vendor document entity.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract or framework agreement under which this document submission is required. Links to the contract master data.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or asset to which this document relates. Links to the equipment master data. Applicable for O&M manuals, test reports, and as-built drawings.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this vendor document is associated. Links to the project master data.',
    `document_register_id` BIGINT COMMENT 'Foreign key linking to design.document_register. Business justification: Vendor‑supplied documents are stored in the document register; linking provides audit trail of vendor documentation.',
    `master_id` BIGINT COMMENT 'Identifier of the material or product to which this document relates. Links to the material master data. Applicable for material data sheets, mill certificates, and test reports.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order under which this document was submitted. Links to the PO that governs the document submission requirement.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Links vendor document submission to the responsible employee; supports document control and accountability.',
    `superseded_by_document_vendor_document_id` BIGINT COMMENT 'Identifier of the newer vendor document that supersedes this document. Used to maintain document version history and ensure users reference the latest approved version.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier who submitted this document. Links to the vendor master data.',
    `approval_date` DATE COMMENT 'Date on which the document was formally approved for use in the project. Applicable when review_status is approved or approved_with_comments.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who granted final approval of this document.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the document meets all contractual, technical, and regulatory compliance requirements. True if compliant, False if non-compliant or deviations exist.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document content, indicating the sensitivity and access restrictions. Aligns with organizational data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor document record was first created in the system. Used for audit trail and data lineage.',
    `document_category` STRING COMMENT 'High-level categorization of the document by business function: technical, quality, compliance, commercial, safety, or environmental.. Valid values are `technical|quality|compliance|commercial|safety|environmental`',
    `document_format` STRING COMMENT 'File format or media type of the submitted document. Common formats include PDF, DWG (AutoCAD), DXF, DOCX, XLSX, JPG, PNG, ZIP, or native CAD formats. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|docx|xlsx|jpg|png|zip|native_cad — 9 candidates stripped; promote to reference product]',
    `document_number` STRING COMMENT 'Unique business identifier or reference number assigned to this vendor document by the vendor or the document management system. Used for tracking and correspondence.',
    `document_title` STRING COMMENT 'Descriptive title or name of the vendor document, summarizing its content and purpose.',
    `document_type` STRING COMMENT 'Classification of the vendor document by its purpose and content. Common types include material data sheets, mill certificates, test reports, ITP (Inspection and Test Plan) submissions, O&M (Operations and Maintenance) manuals, and as-built drawings. [ENUM-REF-CANDIDATE: material_data_sheet|mill_certificate|test_report|itp_submission|o&m_manual|as_built_drawing|warranty_certificate|compliance_certificate|technical_specification|quality_plan — 10 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which this document becomes invalid or superseded. Applicable for time-limited certificates, warranties, or test reports with validity periods.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes. Used for storage management and system performance monitoring.',
    `itp_reference` STRING COMMENT 'Reference number of the Inspection and Test Plan to which this document submission is linked. Used to track ITP compliance and hold point releases.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the document content. Examples: EN (English), FR (French), ES (Spanish), AR (Arabic).',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this vendor document record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor document record was last updated. Used for audit trail and change tracking.',
    `linked_drawing_number` STRING COMMENT 'Reference number of the engineering drawing or BIM model to which this document is related. Used to establish traceability between vendor documents and design deliverables.',
    `ncr_reference` STRING COMMENT 'Reference number of any Non-Conformance Report raised against this document or the materials/equipment it describes. Links to the NCR record for quality tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context related to this vendor document. Used for internal communication and audit trail.',
    `page_count` STRING COMMENT 'Number of pages in the document. Applicable for PDF and printed document formats.',
    `rejection_reason` STRING COMMENT 'Explanation or justification for why the document was rejected. Applicable when review_status is rejected or resubmit_required.',
    `required_submission_date` DATE COMMENT 'Contractual or planned date by which the vendor was required to submit this document. Used to track compliance with submission schedules.',
    `retention_period_years` STRING COMMENT 'Number of years this document must be retained per contractual, regulatory, or organizational policy requirements. Used for records management and archival planning.',
    `review_comments` STRING COMMENT 'Detailed comments, feedback, or observations provided by the reviewer during the document review process. May include technical corrections, clarifications, or conditions of approval.',
    `review_date` DATE COMMENT 'Date on which the document review was completed and a decision (approved, rejected, etc.) was made.',
    `review_due_date` DATE COMMENT 'Target date by which the internal review and approval of this document should be completed. Used to manage review cycle times and SLA compliance.',
    `review_status` STRING COMMENT 'Current status of the document in the review and approval workflow. Tracks whether the document is pending review, under review, approved, approved with comments, rejected, or requires resubmission. [ENUM-REF-CANDIDATE: pending_review|under_review|approved|approved_with_comments|rejected|resubmit_required|superseded|withdrawn — 8 candidates stripped; promote to reference product]',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person or team who conducted the technical or quality review of this document.',
    `revision_number` STRING COMMENT 'Version or revision identifier of the document. Tracks changes and updates to the document over time. Common formats include numeric (1, 2, 3) or alphanumeric (A, B, C, Rev01).',
    `submission_date` DATE COMMENT 'Date on which the vendor submitted this document to the project team or document management system.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vendor document was submitted into the document management system. Used for audit trail and compliance tracking.',
    `transmittal_number` STRING COMMENT 'Reference number of the Aconex or document management system transmittal under which this document was formally submitted. Links to the transmittal record for audit trail.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element or code to which this document is assigned. Used for project cost control and document organization.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this vendor document record in the system.',
    CONSTRAINT pk_vendor_document PRIMARY KEY(`vendor_document_id`)
) COMMENT 'Vendor-submitted technical documents and submittals required under a PO or framework agreement, including material data sheets, mill certificates, test reports, ITP (Inspection and Test Plan) submissions, O&M manuals, and as-built drawings. Captures document number, vendor, PO reference, document type, revision, submission date, review status (under review, approved, approved with comments, rejected), and Aconex transmittal reference.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` (
    `procurement_bid_id` BIGINT COMMENT 'Primary key for the Bid association',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - procurement bids are project-scoped',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to the subcontractor firm',
    `hr_employee_id` BIGINT COMMENT 'add column hr_employee_id (BIGINT) with FK to hr.hr.employee_id - bids have an evaluator/buyer of record',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to the purchase requisition',
    `rfq_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount offered by the subcontractor for the requisition',
    `award_recommendation` STRING COMMENT '',
    `bid_amount` DECIMAL(18,2) COMMENT '',
    `bid_date` DATE COMMENT '',
    `bid_number` STRING COMMENT '',
    `bid_rank` STRING COMMENT 'Ranking of the bid in evaluation.',
    `bid_reference` STRING COMMENT '',
    `bid_status` STRING COMMENT '',
    `commercial_compliance` STRING COMMENT '',
    `commercial_score` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency` STRING COMMENT '',
    `currency_code` STRING COMMENT '',
    `evaluation_notes` STRING COMMENT '',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Score assigned by the evaluation team to the bid',
    `is_awarded` BOOLEAN COMMENT 'Whether bid was awarded.',
    `is_compliant` BOOLEAN COMMENT 'Whether the bid is technically compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `overall_rank` STRING COMMENT '',
    `rank` STRING COMMENT 'Rank among bids.',
    `ranking` STRING COMMENT 'Ranking of the bid in evaluation.',
    `remarks` STRING COMMENT 'Additional remarks.',
    `submission_date` DATE COMMENT '',
    `submission_method` STRING COMMENT '',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the bid was submitted',
    `submitted_by` STRING COMMENT '',
    `technical_compliance` STRING COMMENT '',
    `technical_score` DECIMAL(18,2) COMMENT '',
    `total_bid_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `validity_date` DATE COMMENT 'Bid validity end date.',
    `validity_end_date` DATE COMMENT '',
    `validity_period` STRING COMMENT '',
    `validity_period_days` STRING COMMENT 'Bid validity period in days.',
    CONSTRAINT pk_procurement_bid PRIMARY KEY(`procurement_bid_id`)
) COMMENT 'Represents a bid submitted by a subcontractor firm in response to a purchase requisition. Each record links one purchase_requisition to one subcontractor firm and captures bid-specific data.. Existence Justification: A purchase requisition is issued by a project team and multiple subcontractor firms can submit bids for that requisition. Each subcontractor can bid on many different purchase requisitions. The bid itself carries data such as the bid amount, evaluation score, and submission timestamp, which are managed as a distinct business entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` (
    `approval_workflow_id` BIGINT COMMENT 'Primary key for approval_workflow',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - approval workflows are project-scoped',
    `parent_approval_workflow_id` BIGINT COMMENT 'Self-referencing FK on approval_workflow (parent_approval_workflow_id)',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary amount that triggers the workflows approval process.',
    `approval_time_target_hours` STRING COMMENT 'Target number of hours to complete the approval process.',
    `approval_workflow_status` STRING COMMENT 'Current lifecycle status of the workflow.',
    `approval_workflow_type` STRING COMMENT 'Classification of the workflow (e.g., standard, custom, ad‑hoc).',
    `auto_approval` BOOLEAN COMMENT 'True if the workflow can be auto‑approved under defined conditions.',
    `auto_approval_condition` STRING COMMENT 'Condition expression that enables automatic approval.',
    `approval_workflow_code` STRING COMMENT 'Business code used to reference the workflow in procurement systems.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance rules applicable to the workflow.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the workflow for budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the threshold amount.',
    `default_approver_role` STRING COMMENT 'Organizational role that is the default approver for this workflow.',
    `department_responsible` STRING COMMENT 'Business department that owns the workflow.',
    `approval_workflow_description` STRING COMMENT 'Detailed description of the workflow purpose and scope.',
    `documentation_type` STRING COMMENT 'Allowed format of required documentation.',
    `effective_end_date` DATE COMMENT 'Date when the workflow is retired; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the workflow becomes active for use.',
    `escalation_policy` STRING COMMENT 'Policy that defines how approvals are escalated when thresholds are not met.',
    `is_archived` BOOLEAN COMMENT 'True if the workflow is archived and no longer active.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the workflow must be used for the associated procurement process.',
    `is_parallel_approval` BOOLEAN COMMENT 'True if multiple approvers can act concurrently.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the workflow record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the workflow record.',
    `max_approval_level` STRING COMMENT 'Highest hierarchical level required to approve a request.',
    `approval_workflow_name` STRING COMMENT 'Human‑readable name of the workflow.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the workflow.',
    `requires_documentation` BOOLEAN COMMENT 'True if supporting documentation is required for approval.',
    `risk_level` STRING COMMENT 'Risk classification of the workflow.',
    `step_count` STRING COMMENT 'Total number of approval steps defined in the workflow.',
    `version_number` STRING COMMENT 'Version of the workflow definition for change management.',
    `created_by` STRING COMMENT 'User identifier who created the workflow record.',
    CONSTRAINT pk_approval_workflow PRIMARY KEY(`approval_workflow_id`)
) COMMENT 'Master reference table for approval_workflow. Referenced by approval_workflow_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`service` (
    `service_id` BIGINT COMMENT 'Primary key for service',
    `material_catalog_id` BIGINT COMMENT 'add column material_catalog_id (BIGINT) with FK to procurement.material_catalog.material_catalog_id - services should link to the catalog they belong to',
    `parent_service_id` BIGINT COMMENT 'Self-referencing FK on service (parent_service_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary supplier providing the service.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Target availability percentage for the service.',
    `service_code` STRING COMMENT 'Unique business code used to reference the service.',
    `compliance_requirements` STRING COMMENT 'Regulatory or industry compliance requirements applicable to the service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the service price.',
    `effective_end_date` DATE COMMENT 'Date when the service expires or is discontinued (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the service becomes effective.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems to reference this service.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates if the service is exempt from tax.',
    `lead_time_days` STRING COMMENT 'Average number of days from order to service start.',
    `level_agreement` STRING COMMENT 'Defined SLA terms for the service.',
    `service_name` STRING COMMENT 'Human readable name of the service offering.',
    `notes` STRING COMMENT 'Additional free-text notes about the service.',
    `price_amount` DECIMAL(18,2) COMMENT 'Standard price of the service before taxes.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the service.',
    `service_status` STRING COMMENT 'Current lifecycle status of the service.',
    `service_type` STRING COMMENT 'Category of service provided.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate for the service.',
    `unit_of_measure` STRING COMMENT 'Unit in which the service is measured or billed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service record.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period provided with the service.',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Master reference table for service. Referenced by service_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_construction_v1`.`procurement`.`service`(`service_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `vibe_construction_v1`.`procurement`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `vibe_construction_v1`.`procurement`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_superseded_by_document_vendor_document_id` FOREIGN KEY (`superseded_by_document_vendor_document_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_parent_approval_workflow_id` FOREIGN KEY (`parent_approval_workflow_id`) REFERENCES `vibe_construction_v1`.`procurement`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_parent_service_id` FOREIGN KEY (`parent_service_id`) REFERENCES `vibe_construction_v1`.`procurement`.`service`(`service_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`procurement` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`procurement` SET TAGS ('pii_domain' = 'procurement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `annual_revenue_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Revenue Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `annual_revenue_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Vendor Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `audit_result` SET TAGS ('pii_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `audit_result` SET TAGS ('pii_value_regex' = 'passed|passed_with_conditions|failed|not_audited');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Bank Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bonding_capacity_amount` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Vendor City');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('pii_value_regex' = 'material_supplier|equipment_rental|specialist_subcontractor|general_contractor|professional_services|utility_provider');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `credit_rating` SET TAGS ('pii_business_glossary_term' = 'Vendor Credit Rating');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('pii_business_glossary_term' = 'Diversity Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('pii_value_regex' = 'mbe|wbe|dbe|sdvosb|hubzone|none');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `employee_count` SET TAGS ('pii_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'ach|wire_transfer|check|credit_card|letter_of_credit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('pii_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `prequalification_score` SET TAGS ('pii_business_glossary_term' = 'Prequalification Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `quality_certification` SET TAGS ('pii_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Vendor Registration Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_end_date` SET TAGS ('pii_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_start_date` SET TAGS ('pii_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_business_glossary_term' = 'Vendor Registration Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_value_regex' = 'approved|prospective|suspended|blocked|inactive|under_review');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Qualification ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assessed By Employee ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_material_categories` SET TAGS ('pii_business_glossary_term' = 'Approved Material Categories');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_service_types` SET TAGS ('pii_business_glossary_term' = 'Approved Service Types');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_currency` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Currency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_limit` SET TAGS ('pii_business_glossary_term' = 'Bonding Capacity Limit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('pii_business_glossary_term' = 'Financial Health Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hse_performance_rating` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Performance Rating');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hse_performance_rating` SET TAGS ('pii_value_regex' = 'excellent|good|satisfactory|needs_improvement|unacceptable');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_general_liability_limit` SET TAGS ('pii_business_glossary_term' = 'General Liability Insurance Limit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_workers_comp_verified` SET TAGS ('pii_business_glossary_term' = 'Workers Compensation Insurance Verified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_certificate_number` SET TAGS ('pii_business_glossary_term' = 'ISO 14001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_certified` SET TAGS ('pii_business_glossary_term' = 'ISO 14001 Environmental Management Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_expiry_date` SET TAGS ('pii_business_glossary_term' = 'ISO 14001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_certificate_number` SET TAGS ('pii_business_glossary_term' = 'ISO 45001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_certified` SET TAGS ('pii_business_glossary_term' = 'ISO 45001 Occupational Health and Safety Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_expiry_date` SET TAGS ('pii_business_glossary_term' = 'ISO 45001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_certificate_number` SET TAGS ('pii_business_glossary_term' = 'ISO 9001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_certified` SET TAGS ('pii_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_expiry_date` SET TAGS ('pii_business_glossary_term' = 'ISO 9001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `lti_frequency_rate` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Frequency Rate');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('pii_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `past_performance_score` SET TAGS ('pii_business_glossary_term' = 'Past Performance Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Assessment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_category` SET TAGS ('pii_business_glossary_term' = 'Qualification Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_category` SET TAGS ('pii_value_regex' = 'materials|equipment|services|subcontractor|mep|specialty');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Qualification Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('pii_value_regex' = '^VQ-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('pii_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|rejected|suspended|expired');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('pii_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('pii_value_regex' = 'initial|renewal|re_qualification|conditional|emergency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `quality_defect_rate` SET TAGS ('pii_business_glossary_term' = 'Quality Defect Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Qualification Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Suspension Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Qualification Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `technical_capability_score` SET TAGS ('pii_business_glossary_term' = 'Technical Capability Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `trir_rate` SET TAGS ('pii_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Material Catalog Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `abc_classification` SET TAGS ('pii_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `abc_classification` SET TAGS ('pii_value_regex' = 'A|B|C');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `alternative_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Alternative Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `base_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `bim_object_reference` SET TAGS ('pii_business_glossary_term' = 'BIM (Building Information Modeling) Object Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `cost_currency` SET TAGS ('pii_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `cost_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('pii_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `customs_tariff_number` SET TAGS ('pii_business_glossary_term' = 'Customs Tariff Number (HS Code)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `customs_tariff_number` SET TAGS ('pii_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `dimension_unit` SET TAGS ('pii_business_glossary_term' = 'Dimension Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `dimension_unit` SET TAGS ('pii_value_regex' = 'M|CM|MM|FT|IN');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `environmental_certification` SET TAGS ('pii_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `gross_weight` SET TAGS ('pii_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `hazard_class` SET TAGS ('pii_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `height` SET TAGS ('pii_business_glossary_term' = 'Height Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `length` SET TAGS ('pii_business_glossary_term' = 'Length Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `manufacturer_part_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_group` SET TAGS ('pii_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_group` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_number` SET TAGS ('pii_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_status` SET TAGS ('pii_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_status` SET TAGS ('pii_value_regex' = 'active|inactive|blocked|obsolete|pending_approval|restricted');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `net_weight` SET TAGS ('pii_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `quality_inspection_required` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `shelf_life_days` SET TAGS ('pii_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `short_description` SET TAGS ('pii_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `specification_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `standard_cost` SET TAGS ('pii_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `standard_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `storage_condition` SET TAGS ('pii_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `valuation_class` SET TAGS ('pii_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `valuation_class` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume` SET TAGS ('pii_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume_unit` SET TAGS ('pii_business_glossary_term' = 'Volume Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume_unit` SET TAGS ('pii_value_regex' = 'M3|L|GAL|FT3');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `weight_unit` SET TAGS ('pii_business_glossary_term' = 'Weight Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `weight_unit` SET TAGS ('pii_value_regex' = 'KG|TON|LB|G');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `width` SET TAGS ('pii_business_glossary_term' = 'Width Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('pii_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_required` SET TAGS ('pii_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bim_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `boq_reference` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities (BOQ) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_email` SET TAGS ('pii_business_glossary_term' = 'Buyer Contact Email');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_name` SET TAGS ('pii_business_glossary_term' = 'Buyer Contact Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Buyer Contact Phone');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `buyer_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'lump_sum|unit_price|cost_plus|gmp|time_and_materials');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('pii_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `hse_requirements` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `invited_vendor_count` SET TAGS ('pii_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `issuing_department` SET TAGS ('pii_business_glossary_term' = 'Issuing Department');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `mto_reference` SET TAGS ('pii_business_glossary_term' = 'Material Take-Off (MTO) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `quality_requirements` SET TAGS ('pii_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `response_count` SET TAGS ('pii_business_glossary_term' = 'Response Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('pii_value_regex' = '^RFQ-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('pii_value_regex' = 'materials|equipment|services|subcontract|design_build');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `vendor_prequalification_required` SET TAGS ('pii_business_glossary_term' = 'Vendor Prequalification Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfq_line_id` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Line Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `boq_id` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities (BOQ) Item Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfi_id` SET TAGS ('pii_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfq_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `service_id` SET TAGS ('pii_business_glossary_term' = 'Service Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `drawing_reference` SET TAGS ('pii_business_glossary_term' = 'Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_total_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_total_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('pii_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `inspection_required_flag` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'draft|issued|quoted|evaluated|awarded|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `material_group` SET TAGS ('pii_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `procurement_category` SET TAGS ('pii_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `procurement_category` SET TAGS ('pii_value_regex' = 'direct_material|indirect_material|subcontract_service|equipment_rental|professional_service|consumable');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `quality_requirement` SET TAGS ('pii_business_glossary_term' = 'Quality Requirement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `required_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `short_text` SET TAGS ('pii_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `source_of_supply` SET TAGS ('pii_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `source_of_supply` SET TAGS ('pii_value_regex' = 'local|regional|international|preferred_vendor|open_market');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `technical_specification_reference` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `vendor_evaluation_criteria` SET TAGS ('pii_business_glossary_term' = 'Vendor Evaluation Criteria');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_quotation_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Quotation ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `award_recommendation` SET TAGS ('pii_business_glossary_term' = 'Award Recommendation');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `award_recommendation` SET TAGS ('pii_value_regex' = 'recommended|not_recommended|conditional|pending');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `commercial_exceptions` SET TAGS ('pii_business_glossary_term' = 'Commercial Exceptions');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `country_of_origin` SET TAGS ('pii_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `country_of_origin` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_terms` SET TAGS ('pii_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `deviations_from_specification` SET TAGS ('pii_business_glossary_term' = 'Deviations from Specification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluation_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluation_notes` SET TAGS ('pii_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluation_score` SET TAGS ('pii_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `freight_cost` SET TAGS ('pii_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_number` SET TAGS ('pii_business_glossary_term' = 'Quotation Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('pii_business_glossary_term' = 'Quotation Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('pii_value_regex' = 'submitted|under_review|accepted|rejected|withdrawn|expired');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_quantity` SET TAGS ('pii_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `technical_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Technical Compliance Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `technical_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial|under_review');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `total_price` SET TAGS ('pii_business_glossary_term' = 'Total Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `validity_end_date` SET TAGS ('pii_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `validity_start_date` SET TAGS ('pii_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `warranty_terms` SET TAGS ('pii_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('pii_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cumulative_amendment_value` SET TAGS ('pii_business_glossary_term' = 'Cumulative Amendment Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cumulative_amendment_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `current_revision_number` SET TAGS ('pii_business_glossary_term' = 'Current Revision Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `current_version_number` SET TAGS ('pii_business_glossary_term' = 'Current Version Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('pii_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('pii_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('pii_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('pii_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('pii_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('pii_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_amount` SET TAGS ('pii_business_glossary_term' = 'Guaranteed Maximum Price (GMP) Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_flag` SET TAGS ('pii_business_glossary_term' = 'Guaranteed Maximum Price (GMP) Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `issued_date` SET TAGS ('pii_business_glossary_term' = 'Issued Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_type` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_type` SET TAGS ('pii_value_regex' = 'scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `ntp_date` SET TAGS ('pii_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `original_po_value` SET TAGS ('pii_business_glossary_term' = 'Original Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `original_po_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_value_regex' = 'standard|blanket|framework|subcontract|service|rental');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('pii_value_regex' = '^PR-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `sap_document_number` SET TAGS ('pii_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `sap_document_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('pii_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,8}(.[0-9]{1,4})*$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('pii_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('pii_value_regex' = 'K|A|F|P|N|U');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `buyer_name` SET TAGS ('pii_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('pii_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `free_text_note` SET TAGS ('pii_business_glossary_term' = 'Free Text Note');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('pii_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `incoterms_location` SET TAGS ('pii_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('pii_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('pii_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('pii_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('pii_value_regex' = 'standard|service|consignment|subcontracting|stock_transfer');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_group` SET TAGS ('pii_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `net_value` SET TAGS ('pii_business_glossary_term' = 'Net Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('pii_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('pii_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('pii_business_glossary_term' = 'Over Delivery Tolerance Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('pii_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('pii_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('pii_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('pii_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('pii_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_subdomain' = 'delivery_inspection');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Inspector ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `site_location_id` SET TAGS ('pii_business_glossary_term' = 'Site Location ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Delivery Completed Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('pii_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_verification_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Verification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_verification_status` SET TAGS ('pii_value_regex' = 'not_started|pending|matched|variance|blocked|completed');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('pii_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('pii_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('pii_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('pii_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_item_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Line Item Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('pii_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('pii_value_regex' = 'accepted|rejected|partial|damaged|on_hold|quarantine');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('pii_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_inspector_name` SET TAGS ('pii_business_glossary_term' = 'Receiving Inspector Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('pii_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('pii_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('pii_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('pii_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `tracking_number` SET TAGS ('pii_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('pii_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('pii_value_regex' = 'truck|rail|air|sea|courier|pickup');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('pii_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('pii_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_notes` SET TAGS ('pii_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('pii_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `sourcing_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sourcing Plan Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `pursuit_id` SET TAGS ('pii_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Procurement Manager ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `purchase_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `approval_authority_level` SET TAGS ('pii_value_regex' = 'buyer|procurement_manager|project_manager|director|executive');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `budget_code` SET TAGS ('pii_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'lump_sum|unit_rate|cost_plus|time_and_material|gmp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `estimated_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Procurement Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `estimated_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `expediting_frequency` SET TAGS ('pii_business_glossary_term' = 'Expediting Frequency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `expediting_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|biweekly|monthly|milestone_based|not_required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `expediting_method` SET TAGS ('pii_business_glossary_term' = 'Expediting Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `expediting_method` SET TAGS ('pii_value_regex' = 'site_visit|video_conference|email_report|third_party_inspection|vendor_portal');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `expediting_required` SET TAGS ('pii_business_glossary_term' = 'Expediting Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `incoterms` SET TAGS ('pii_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `inspection_requirements` SET TAGS ('pii_business_glossary_term' = 'Inspection Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Material Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `is_long_lead_item` SET TAGS ('pii_business_glossary_term' = 'Long-Lead Item Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Sourcing Plan Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `packaging_strategy` SET TAGS ('pii_business_glossary_term' = 'Packaging Strategy');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Sourcing Plan Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_value_regex' = '^SP-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Sourcing Plan Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `planned_award_date` SET TAGS ('pii_business_glossary_term' = 'Planned Purchase Order (PO) Award Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `planned_bid_closing_date` SET TAGS ('pii_business_glossary_term' = 'Planned Bid Closing Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `planned_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Planned Material Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `planned_installation_date` SET TAGS ('pii_business_glossary_term' = 'Planned Installation Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `planned_rfq_date` SET TAGS ('pii_business_glossary_term' = 'Planned Request for Quotation (RFQ) Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `preferred_supplier_list` SET TAGS ('pii_business_glossary_term' = 'Preferred Supplier List');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `procurement_category` SET TAGS ('pii_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `risk_classification` SET TAGS ('pii_business_glossary_term' = 'Procurement Risk Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `risk_classification` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `sourcing_method` SET TAGS ('pii_business_glossary_term' = 'Sourcing Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `sourcing_method` SET TAGS ('pii_value_regex' = 'competitive_bid|sole_source|framework_agreement|preferred_vendor|two_stage_tender|design_build');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `special_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `supplier_prequalification_required` SET TAGS ('pii_business_glossary_term' = 'Supplier Prequalification Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_subdomain' = 'delivery_inspection');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `actual_delivery_time` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Time');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delay_reason_code` SET TAGS ('pii_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delay_reason_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delay_reason_description` SET TAGS ('pii_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_point_code` SET TAGS ('pii_business_glossary_term' = 'Delivery Point Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_point_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_point_description` SET TAGS ('pii_business_glossary_term' = 'Delivery Point Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_quantity` SET TAGS ('pii_business_glossary_term' = 'Delivery Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'on-track|at-risk|delayed|delivered|cancelled|rescheduled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `expedite_flag` SET TAGS ('pii_business_glossary_term' = 'Expedite Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{10,15}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterm` SET TAGS ('pii_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterm` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `inspection_required_flag` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `planned_delivery_time` SET TAGS ('pii_business_glossary_term' = 'Planned Delivery Time');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `project_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,15}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Delivery Remarks');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `required_on_site_date` SET TAGS ('pii_business_glossary_term' = 'Required On-Site Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('pii_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_variance_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `shipment_tracking_number` SET TAGS ('pii_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_name` SET TAGS ('pii_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `site_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('pii_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'road|rail|sea|air|multimodal');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `vendor_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `vendor_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `vendor_committed_date` SET TAGS ('pii_business_glossary_term' = 'Vendor Committed Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `wbs_element` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{8,20}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `vendor_evaluation_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Evaluation Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `primary_vendor_evaluator_employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `primary_vendor_evaluator_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `primary_vendor_evaluator_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `avl_entry_date` SET TAGS ('pii_business_glossary_term' = 'Approved Vendor List (AVL) Entry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `bid_invitation_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Bid Invitation Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `bonding_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Bonding Limit Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `commercial_compliance_score` SET TAGS ('pii_business_glossary_term' = 'Commercial Compliance Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_notes` SET TAGS ('pii_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('pii_business_glossary_term' = 'Evaluation Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('pii_value_regex' = '^VE-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('pii_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('pii_value_regex' = 'draft|in_progress|under_review|approved|rejected|on_hold');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('pii_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('pii_value_regex' = 'pre_qualification|periodic_review|project_specific|re_qualification|incident_triggered');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `financial_health_score` SET TAGS ('pii_business_glossary_term' = 'Financial Health Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `financial_health_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `financial_health_score` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `hse_incident_count` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `hse_rating_score` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Rating Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `insurance_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `ncr_count` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('pii_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `overall_kpi_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Key Performance Indicator (KPI) Rating');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `performance_grade` SET TAGS ('pii_business_glossary_term' = 'Performance Grade');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `performance_grade` SET TAGS ('pii_value_regex' = 'A|B|C|D|F');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `qualification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `qualification_status` SET TAGS ('pii_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `qualification_status` SET TAGS ('pii_value_regex' = 'qualified|conditionally_qualified|disqualified|suspended|expired');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('pii_business_glossary_term' = 'Quality Acceptance Rate');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `quality_certification_score` SET TAGS ('pii_business_glossary_term' = 'Quality Certification Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `responsiveness_score` SET TAGS ('pii_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ALTER COLUMN `technical_capability_score` SET TAGS ('pii_business_glossary_term' = 'Technical Capability Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_id` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pursuit_id` SET TAGS ('pii_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requestor Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_available_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Available Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_date` SET TAGS ('pii_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_status` SET TAGS ('pii_business_glossary_term' = 'Conversion Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_status` SET TAGS ('pii_value_regex' = 'not_converted|converted_to_rfq|converted_to_po|partially_converted');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `converted_document_number` SET TAGS ('pii_business_glossary_term' = 'Converted Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('pii_value_regex' = '^CC-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `current_approver_name` SET TAGS ('pii_business_glossary_term' = 'Current Approver Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Unit Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_notes` SET TAGS ('pii_business_glossary_term' = 'Justification Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material or Service Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group` SET TAGS ('pii_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mto_reference` SET TAGS ('pii_business_glossary_term' = 'Material Take-Off (MTO) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('pii_value_regex' = '^PR-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('pii_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('pii_value_regex' = 'standard|subcontract|service|stock_transfer|consignment|rental');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `preferred_vendor_code` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_strategy` SET TAGS ('pii_business_glossary_term' = 'Procurement Strategy');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_strategy` SET TAGS ('pii_value_regex' = 'direct_po|competitive_rfq|framework_agreement|spot_buy|emergency_procurement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('pii_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('pii_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department` SET TAGS ('pii_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('pii_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `technical_specification_attached` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Attached Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `urgency_classification` SET TAGS ('pii_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `urgency_classification` SET TAGS ('pii_value_regex' = 'routine|urgent|critical|emergency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}-[0-9]{4}-[0-9]{2}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `po_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Amendment ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `approval_workflow_id` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amended_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Amended Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amended_po_value` SET TAGS ('pii_business_glossary_term' = 'Amended Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amended_quantity` SET TAGS ('pii_business_glossary_term' = 'Amended Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|rejected|cancelled|implemented');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `budget_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Budget Impact Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `client_approval_date` SET TAGS ('pii_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `client_approval_required` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `co_reference_number` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Reference Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `impact_on_schedule` SET TAGS ('pii_business_glossary_term' = 'Impact on Schedule');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `impact_on_schedule` SET TAGS ('pii_value_regex' = 'no_impact|acceleration|delay|critical_path_affected');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `implementation_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `initiated_by` SET TAGS ('pii_business_glossary_term' = 'Initiated By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `initiated_date` SET TAGS ('pii_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `original_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Original Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `original_po_value` SET TAGS ('pii_business_glossary_term' = 'Original Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `original_quantity` SET TAGS ('pii_business_glossary_term' = 'Original Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `quantity_uom` SET TAGS ('pii_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `value_delta` SET TAGS ('pii_business_glossary_term' = 'Value Delta');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `blocked_reason` SET TAGS ('pii_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `fi_document_number` SET TAGS ('pii_business_glossary_term' = 'Financial (FI) Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_net_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_received_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'wire_transfer|check|ach|credit_card|letter_of_credit|cash');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `retention_percentage` SET TAGS ('pii_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_value_regex' = 'matched|quantity_variance|price_variance|not_matched|bypassed');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'pending|verified|rejected|on_hold');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_master' = 'client.client_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot' = 'procurement.procurement_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_scope' = 'procurement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_counterpart' = 'client.client_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `procurement_framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Framework Agreement ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Client Framework Agreement Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_id` SET TAGS ('pii_ssot' = 'client.client_framework_agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Buyer ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_value_regex' = '^FA-[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Framework Agreement Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'blanket_order|call_off_contract|master_agreement|preferred_supplier|rate_contract|volume_agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `call_off_mechanism` SET TAGS ('pii_business_glossary_term' = 'Call-Off Mechanism');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `call_off_mechanism` SET TAGS ('pii_value_regex' = 'po_against_agreement|release_order|direct_call_off|scheduled_delivery|project_allocation');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `commodity_category_code` SET TAGS ('pii_business_glossary_term' = 'Commodity Category Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `commodity_category_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `commodity_category_description` SET TAGS ('pii_business_glossary_term' = 'Commodity Category Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `compliance_certifications_required` SET TAGS ('pii_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('pii_value_regex' = 'arbitration|mediation|litigation|adjudication');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `governing_law` SET TAGS ('pii_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('pii_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `maximum_commitment_value` SET TAGS ('pii_business_glossary_term' = 'Maximum Commitment Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `maximum_commitment_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `maximum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `performance_bond_percentage` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `performance_bond_required` SET TAGS ('pii_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `pricing_schedule_reference` SET TAGS ('pii_business_glossary_term' = 'Pricing Schedule Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `pricing_schedule_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `procurement_organization_code` SET TAGS ('pii_business_glossary_term' = 'Procurement Organization Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `procurement_organization_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `quality_requirements` SET TAGS ('pii_business_glossary_term' = 'Quality Requirements (QA/QC)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('pii_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `sustainability_criteria` SET TAGS ('pii_business_glossary_term' = 'Sustainability Criteria');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `total_spend_to_date` SET TAGS ('pii_business_glossary_term' = 'Total Spend to Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `total_spend_to_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ALTER COLUMN `utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_subdomain' = 'delivery_inspection');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_release_id` SET TAGS ('pii_business_glossary_term' = 'Inspection Release ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `embodied_carbon_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Embodied Carbon Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `material_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `aconex_transmittal_reference` SET TAGS ('pii_business_glossary_term' = 'Aconex Transmittal Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `aconex_transmittal_reference` SET TAGS ('pii_value_regex' = '^TRN-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `as_built_drawing_document_number` SET TAGS ('pii_business_glossary_term' = 'As-Built Drawing Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `as_built_drawing_document_number` SET TAGS ('pii_value_regex' = '^ABD-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_review_date` SET TAGS ('pii_business_glossary_term' = 'Document Review Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_review_status` SET TAGS ('pii_business_glossary_term' = 'Document Review Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_review_status` SET TAGS ('pii_value_regex' = 'under_review|approved|approved_with_comments|rejected|resubmit_required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Document Reviewer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_revision_number` SET TAGS ('pii_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `document_submission_date` SET TAGS ('pii_business_glossary_term' = 'Document Submission Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `equipment_tag_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `equipment_tag_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,4}-[A-Z0-9]{3,6}-[0-9]{3,5}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_location` SET TAGS ('pii_business_glossary_term' = 'Inspection Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_order_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Order Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_order_number` SET TAGS ('pii_value_regex' = '^IO-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_remarks` SET TAGS ('pii_business_glossary_term' = 'Inspection Remarks');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_report_document_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Report Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_report_document_number` SET TAGS ('pii_value_regex' = '^DOC-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_result` SET TAGS ('pii_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_result` SET TAGS ('pii_value_regex' = 'pass|conditional_pass|fail|pending_retest');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_scope` SET TAGS ('pii_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|released|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspection_witness_required` SET TAGS ('pii_business_glossary_term' = 'Inspection Witness Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspector_name` SET TAGS ('pii_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `inspector_organization` SET TAGS ('pii_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `itp_reference_number` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `itp_reference_number` SET TAGS ('pii_value_regex' = '^ITP-[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `material_data_sheet_document_number` SET TAGS ('pii_business_glossary_term' = 'Material Data Sheet Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `material_data_sheet_document_number` SET TAGS ('pii_value_regex' = '^MDS-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `mill_certificate_document_number` SET TAGS ('pii_business_glossary_term' = 'Mill Certificate Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `mill_certificate_document_number` SET TAGS ('pii_value_regex' = '^MC-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `ncr_count` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `om_manual_document_number` SET TAGS ('pii_business_glossary_term' = 'Operations and Maintenance (O&M) Manual Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `om_manual_document_number` SET TAGS ('pii_value_regex' = '^OM-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `punch_list_items` SET TAGS ('pii_business_glossary_term' = 'Punch List Items');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `release_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Release Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `release_certificate_number` SET TAGS ('pii_value_regex' = '^RC-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `release_date` SET TAGS ('pii_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `shipment_authorization_date` SET TAGS ('pii_business_glossary_term' = 'Shipment Authorization Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `technical_specification_reference` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `test_report_document_number` SET TAGS ('pii_business_glossary_term' = 'Test Report Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `test_report_document_number` SET TAGS ('pii_value_regex' = '^TR-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `witness_organization` SET TAGS ('pii_business_glossary_term' = 'Witness Organization');
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ALTER COLUMN `witness_representative_name` SET TAGS ('pii_business_glossary_term' = 'Witness Representative Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_subdomain' = 'supplier_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `vendor_document_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Document ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Document Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `superseded_by_document_vendor_document_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_category` SET TAGS ('pii_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_category` SET TAGS ('pii_value_regex' = 'technical|quality|compliance|commercial|safety|environmental');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_format` SET TAGS ('pii_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `file_size_mb` SET TAGS ('pii_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `itp_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `linked_drawing_number` SET TAGS ('pii_business_glossary_term' = 'Linked Drawing Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `required_submission_date` SET TAGS ('pii_business_glossary_term' = 'Required Submission Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `retention_period_years` SET TAGS ('pii_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `review_comments` SET TAGS ('pii_business_glossary_term' = 'Review Comments');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `transmittal_number` SET TAGS ('pii_business_glossary_term' = 'Transmittal Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `wbs_element` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_association_edges' = 'procurement.purchase_requisition,subcontractor.firm_profile');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `procurement_bid_id` SET TAGS ('pii_business_glossary_term' = 'Bid - Bid Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Bid - Sub Firm Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `purchase_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Bid - Purchase Requisition Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `rfq_id` SET TAGS ('pii_business_glossary_term' = 'Rfq Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Bid Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `award_recommendation` SET TAGS ('pii_business_glossary_term' = 'Award Recommendation');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_amount` SET TAGS ('pii_business_glossary_term' = 'Bid Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_date` SET TAGS ('pii_business_glossary_term' = 'Bid Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_number` SET TAGS ('pii_business_glossary_term' = 'Bid Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_rank` SET TAGS ('pii_business_glossary_term' = 'Bid Rank');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_reference` SET TAGS ('pii_business_glossary_term' = 'Bid Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `bid_status` SET TAGS ('pii_business_glossary_term' = 'Bid Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `commercial_compliance` SET TAGS ('pii_business_glossary_term' = 'Commercial Compliance');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `commercial_score` SET TAGS ('pii_business_glossary_term' = 'Commercial Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `evaluation_notes` SET TAGS ('pii_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `evaluation_score` SET TAGS ('pii_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `is_awarded` SET TAGS ('pii_business_glossary_term' = 'Is Awarded');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `is_compliant` SET TAGS ('pii_business_glossary_term' = 'Is Compliant');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `overall_rank` SET TAGS ('pii_business_glossary_term' = 'Overall Rank');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `rank` SET TAGS ('pii_business_glossary_term' = 'Rank');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `ranking` SET TAGS ('pii_business_glossary_term' = 'Ranking');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Time');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `submitted_by` SET TAGS ('pii_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `technical_compliance` SET TAGS ('pii_business_glossary_term' = 'Technical Compliance');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `technical_score` SET TAGS ('pii_business_glossary_term' = 'Technical Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `total_bid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Bid Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `validity_date` SET TAGS ('pii_business_glossary_term' = 'Validity Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `validity_end_date` SET TAGS ('pii_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `validity_period` SET TAGS ('pii_business_glossary_term' = 'Validity Period');
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ALTER COLUMN `validity_period_days` SET TAGS ('pii_business_glossary_term' = 'Validity Period Days');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_id` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `parent_approval_workflow_id` SET TAGS ('pii_business_glossary_term' = 'Parent Approval Workflow Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `parent_approval_workflow_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_time_target_hours` SET TAGS ('pii_business_glossary_term' = 'Approval Time Target Hours');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `auto_approval` SET TAGS ('pii_business_glossary_term' = 'Auto Approval');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `auto_approval_condition` SET TAGS ('pii_business_glossary_term' = 'Auto Approval Condition');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `default_approver_role` SET TAGS ('pii_business_glossary_term' = 'Default Approver Role');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `department_responsible` SET TAGS ('pii_business_glossary_term' = 'Department Responsible');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `documentation_type` SET TAGS ('pii_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `escalation_policy` SET TAGS ('pii_business_glossary_term' = 'Escalation Policy');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `is_archived` SET TAGS ('pii_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `is_parallel_approval` SET TAGS ('pii_business_glossary_term' = 'Is Parallel Approval');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `max_approval_level` SET TAGS ('pii_business_glossary_term' = 'Max Approval Level');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `requires_documentation` SET TAGS ('pii_business_glossary_term' = 'Requires Documentation');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `step_count` SET TAGS ('pii_business_glossary_term' = 'Step Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_subdomain' = 'catalog_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `service_id` SET TAGS ('pii_business_glossary_term' = 'Service Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `parent_service_id` SET TAGS ('pii_business_glossary_term' = 'Parent Service Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `parent_service_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `availability_percentage` SET TAGS ('pii_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `is_tax_exempt` SET TAGS ('pii_business_glossary_term' = 'Is Tax Exempt');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `level_agreement` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `price_amount` SET TAGS ('pii_business_glossary_term' = 'Price Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `service_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `service_type` SET TAGS ('pii_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`service` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period Months');
