-- Schema for Domain: supplier | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`supplier` COMMENT 'Supplier relationship and performance management domain tracking supplier profiles, qualification status, scorecards, audit results, certifications, risk ratings, and long-term relationship data. Distinct from procurement transactions — this domain owns the supplier identity and master data used across procurement, quality, and supply chain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Primary key for supplier',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PROCUREMENT: Assigns an internal account manager to each supplier for relationship management; required for supplier performance dashboards and contract negotiations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating supplier spend to internal cost centers (Procurement Cost Allocation Report).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Default GL account for posting supplier invoices (AP posting rules).',
    `business_type` STRING COMMENT 'Classification of the supplier based on the type of goods or services provided. OEM (Original Equipment Manufacturer) supplies finished components, distributor resells products, raw_material provides base materials, MRO (Maintenance Repair Operations) supplies consumables, subcontractor provides manufacturing services, service_provider delivers non-manufacturing services.. Valid values are `OEM|distributor|raw_material|MRO|subcontractor|service_provider`',
    `supplier_category` STRING COMMENT 'Strategic classification indicating the suppliers relationship tier and procurement priority. Strategic suppliers are critical long-term partners, preferred suppliers have favorable terms, approved suppliers meet minimum standards, conditional suppliers are under review, blocked suppliers are prohibited from new business.. Valid values are `strategic|preferred|approved|conditional|blocked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier master record was first created in the system. Used for data lineage, audit trails, and master data governance.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for supplier credit checks, risk assessment, and compliance verification.. Valid values are `^[0-9]{9}$`',
    `headquarters_address_line1` STRING COMMENT 'Primary street address line for the suppliers corporate headquarters. Used for legal correspondence, audit notices, and official communications.',
    `headquarters_address_line2` STRING COMMENT 'Secondary address line for suite, building, or floor information at the suppliers headquarters location.',
    `headquarters_city` STRING COMMENT 'City or municipality where the suppliers headquarters is located.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO country code for the suppliers headquarters location. May differ from incorporation country for multinational organizations.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the suppliers headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region for the suppliers headquarters address.',
    `incorporation_country` STRING COMMENT 'Three-letter ISO country code representing the country where the supplier is legally incorporated and registered. Used for trade compliance, tax jurisdiction, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `incoterms` STRING COMMENT 'Standard three-letter Incoterms code defining the division of costs, risks, and responsibilities between buyer and seller in international trade (e.g., FOB, CIF, DDP). Published by International Chamber of Commerce. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso14001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 14001 Environmental Management System certification. True if certified, False if not certified or certification expired.',
    `iso45001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 45001 Occupational Health and Safety Management System certification. True if certified, False if not certified or certification expired.',
    `iso9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 9001 Quality Management System certification. True if certified, False if not certified or certification expired.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted by Manufacturings quality or procurement team. Used to track audit frequency and schedule next audit per supplier management policy.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this supplier master record. Used for change accountability, audit trails, and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier master record was last updated. Used for change tracking, data synchronization, and audit compliance.',
    `last_scorecard_date` DATE COMMENT 'Date of the most recent supplier scorecard evaluation. Scorecards typically assess quality, delivery, cost, and responsiveness on a quarterly or annual basis.',
    `minority_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a minority-owned business enterprise. Used for diversity supplier programs and regulatory reporting.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit based on risk rating, performance, and audit frequency policy. Used for audit planning and compliance tracking.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the requested delivery date over the evaluation period. Key performance indicator (KPI) for supplier scorecard and performance management. Expressed as percentage (0.00 to 100.00).',
    `overall_scorecard_rating` DECIMAL(18,2) COMMENT 'Composite supplier performance score from the most recent scorecard evaluation, typically on a scale of 0.0 to 10.0 or 0.0 to 100.0. Aggregates quality, delivery, cost, and service metrics into a single performance indicator.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment due date and any early payment discounts available.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the suppliers preferred currency for invoicing and payment transactions (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact for business communications, purchase orders, and quality notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization for procurement, quality, and supply chain coordination.',
    `primary_contact_phone` STRING COMMENT 'Business phone number for the primary supplier contact including country code and extension if applicable.',
    `qualification_status` STRING COMMENT 'Quality and compliance qualification status indicating whether the supplier has passed required audits, certifications, and capability assessments. Qualified suppliers meet all requirements, conditional suppliers have minor gaps, not_qualified suppliers failed assessment, under_review suppliers are being evaluated.. Valid values are `qualified|conditional|not_qualified|under_review`',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of received materials that passed incoming quality inspection without rejection or rework over the evaluation period. Key performance indicator (KPI) for supplier quality performance. Expressed as percentage (0.00 to 100.00).',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this supplier was terminated or the vendor record was deactivated. Null for active suppliers. Used for supplier lifecycle tracking and historical analysis.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this supplier was established and the vendor record was first activated. Used for relationship tenure analysis and supplier lifecycle reporting.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the supplier based on financial stability, geopolitical factors, quality performance, delivery reliability, and compliance history. Used for supply chain risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `sap_vendor_number` STRING COMMENT 'Vendor master number from SAP S/4HANA MM (Materials Management) or SAP Ariba. This is the authoritative supplier identifier in the ERP system used for procurement transactions.',
    `small_business` BOOLEAN COMMENT 'Indicates whether the supplier qualifies as a small business based on revenue, employee count, or regulatory definitions. Used for small business procurement programs and compliance reporting.',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship. Active suppliers are approved for procurement, inactive suppliers are no longer used, suspended suppliers are temporarily restricted, pending_approval suppliers are under qualification review, blocked suppliers are prohibited from new transactions.. Valid values are `active|inactive|suspended|pending_approval|blocked`',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the supplier (e.g., EIN in USA, VAT number in EU, GST number in India). Used for tax reporting, invoice validation, and compliance.',
    `vendor_code` STRING COMMENT 'Internal alphanumeric code assigned to the supplier for identification across procurement, quality, and supply chain systems. Often synchronized with SAP vendor master number.',
    `vendor_name` STRING COMMENT 'Full legal name of the supplier organization as registered with incorporation authorities. Used for contracts, purchase orders, and legal documentation.',
    `woman_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a woman-owned business enterprise. Used for diversity supplier programs and regulatory reporting.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this supplier master record. Used for accountability, audit trails, and data governance.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Core master entity representing the authoritative supplier identity record (SSOT) for all vendors, sub-contractors, and raw material suppliers engaged by Manufacturing. Captures legal entity name, DUNS number, tax ID, SAP vendor master number (from SAP Ariba/S4HANA MM), business type (OEM, distributor, raw material, MRO), incorporation country, headquarters address, primary contact, preferred currency, payment terms, incoterms, and active status. This is the golden record used across procurement, quality, supply chain, and logistics domains.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Site‑specific cost allocation for production capacity spend (Site Cost Allocation process).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SITE PERFORMANCE: Links a responsible procurement employee to each supplier site; used in site audit scheduling and capacity monitoring reports.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent vendor legal entity that owns this site. Links to the vendor master record.',
    `active_from_date` DATE COMMENT 'Date when the vendor site became active and eligible for procurement transactions.',
    `active_to_date` DATE COMMENT 'Date when the vendor site was deactivated or disqualified. Null for currently active sites.',
    `address_line_1` STRING COMMENT 'Primary street address of the vendor site facility. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, suite, or floor number. Organizational contact data classified as confidential.',
    `approved_for_new_business` BOOLEAN COMMENT 'Indicates whether the vendor site is approved to receive new purchase orders and sourcing awards.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the production capacity metric such as units, tons, liters, or square meters.',
    `certification_expiry_date` DATE COMMENT 'Date when the primary quality management certification expires. Used to trigger recertification workflows.',
    `city` STRING COMMENT 'City or municipality where the vendor site is located. Organizational contact data classified as confidential.',
    `site_code` STRING COMMENT 'Unique alphanumeric code identifying the vendor site. Used for procurement routing and supplier qualification tracking.. Valid values are `^[A-Z0-9]{4,20}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendor site location. Used for trade compliance, tariff calculation, and regional risk assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for transactions with this vendor site.. Valid values are `^[A-Z]{3}$`',
    `delivery_performance_score` DECIMAL(18,2) COMMENT 'On-time delivery performance score for the vendor site. Scale 0-100.',
    `duns_number` STRING COMMENT 'Dun and Bradstreet Universal Numbering System identifier for the vendor site. Used for credit assessment and supplier verification.. Valid values are `^[0-9]{9}$`',
    `geographic_region` STRING COMMENT 'Macro-geographic region classification for supply chain planning and regional sourcing strategy.. Valid values are `north_america|south_america|europe|asia_pacific|middle_east|africa`',
    `iatf_16949_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds IATF 16949 automotive quality management certification. Required for automotive supply chain participation.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 14001 Environmental Management System certification.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 45001 Occupational Health and Safety Management System certification.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 9001 Quality Management System certification. Critical for supplier qualification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the vendor site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the vendor site. Used for logistics optimization and distance calculations.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to delivery for this vendor site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the vendor site. Used for logistics optimization and distance calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor site for purchase orders.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity such as pieces, kilograms, or pallets.',
    `site_name` STRING COMMENT 'Business name or designation of the vendor site facility.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at the vendor site.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or site-specific considerations relevant to procurement and quality teams.',
    `payment_terms` STRING COMMENT 'Standard payment terms applicable to this vendor site such as Net 30, Net 60, or 2/10 Net 30.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendor site address. Organizational contact data classified as confidential.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this vendor site has preferred supplier status for strategic sourcing decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary site contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor site for procurement and quality coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor site contact. Organizational contact data classified as confidential.',
    `production_capacity_annual` DECIMAL(18,2) COMMENT 'Annual production capacity of the site in units relevant to the site type. Used for capacity planning and sourcing allocation decisions.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score for the vendor site based on defect rates, audit results, and corrective action responsiveness. Scale 0-100.',
    `risk_rating` STRING COMMENT 'Overall risk classification of the vendor site based on quality performance, financial stability, geopolitical factors, and compliance history.. Valid values are `low|medium|high|critical`',
    `site_status` STRING COMMENT 'Current lifecycle status of the vendor site. Controls whether the site is eligible for new purchase orders and sourcing decisions.. Valid values are `active|inactive|suspended|pending_qualification|disqualified`',
    `site_type` STRING COMMENT 'Classification of the vendor site by primary function. Determines sourcing eligibility and capability matching.. Valid values are `manufacturing|distribution|warehouse|service_center|r_and_d|office`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the vendor site. Organizational contact data classified as confidential.',
    `tax_registration_number` STRING COMMENT 'Tax identification or VAT registration number for the vendor site. Used for tax compliance and invoice validation.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Represents a specific physical manufacturing, warehouse, or service site belonging to a vendor. A single vendor legal entity may operate multiple sites with distinct capabilities, certifications, and risk profiles. Captures site address, site type (manufacturing, distribution, R&D), production capacity, geographic region, ISO certification scope, and site-level contact. Used by procurement and quality to route sourcing decisions to the correct facility.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` (
    `supplier_contact_id` BIGINT COMMENT 'Primary key for contact',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Supplier contacts serve as project points of contact; linking allows communication and escalation tracking per project.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent vendor organization this contact belongs to. Links to the supplier master record.',
    `certification_held` STRING COMMENT 'Professional certifications or qualifications held by the contact relevant to their role (e.g., Six Sigma Black Belt, PMP, ISO Lead Auditor, APICS CPIM). Multiple certifications separated by semicolon.',
    `communication_preference` STRING COMMENT 'Preferred method of communication for reaching this contact for routine supplier relationship activities.. Valid values are `email|phone|mobile|portal|fax`',
    `contact_role` STRING COMMENT 'Primary functional role of the contact in the supplier relationship. Determines routing of communications and escalations.. Valid values are `commercial|technical|quality|logistics|executive|after_sales`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact. Inactive or terminated contacts should not receive communications.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'Classification of the contact based on their priority and purpose in the supplier relationship hierarchy.. Valid values are `primary|secondary|escalation|technical_support|billing`',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this vendor contact record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was first created in the system. Used for audit trail and data lineage.',
    `department` STRING COMMENT 'Department or functional area within the vendor organization where the contact works (e.g., Sales, Quality Assurance, Logistics, Engineering, Customer Service).',
    `effective_end_date` DATE COMMENT 'Date when this contact ceased to be active or left the vendor organization. Null for currently active contacts.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and available for supplier relationship management activities.',
    `email_address` STRING COMMENT 'Primary email address for the vendor contact. Used for procurement communications, quality notifications, and supply chain coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_level` STRING COMMENT 'Numeric escalation tier for this contact in the supplier relationship hierarchy. Level 1 is first point of contact, higher numbers represent management escalation paths.',
    `first_name` STRING COMMENT 'First name or given name of the vendor contact person.',
    `full_name` STRING COMMENT 'Complete name of the vendor contact person, typically concatenation of first and last name.',
    `interaction_frequency_days` STRING COMMENT 'Target frequency in days for regular business interactions with this contact. Used for relationship management planning and alerts.',
    `is_decision_maker` BOOLEAN COMMENT 'Flag indicating whether this contact has decision-making authority for commercial negotiations, contract approvals, or strategic supplier relationship matters.',
    `is_primary_contact` BOOLEAN COMMENT 'Flag indicating whether this contact is the primary point of contact for the vendor organization. Only one primary contact should exist per vendor.',
    `job_title` STRING COMMENT 'Official job title or position of the vendor contact within their organization (e.g., Account Manager, Quality Engineer, Logistics Coordinator, Sales Director).',
    `last_interaction_date` DATE COMMENT 'Date of the most recent business interaction or communication with this contact. Used for relationship health monitoring.',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person who most recently modified this vendor contact record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was most recently updated. Used for audit trail and change tracking.',
    `last_name` STRING COMMENT 'Last name or family name of the vendor contact person.',
    `linkedin_profile_url` STRING COMMENT 'URL to the contacts LinkedIn professional profile. Used for relationship intelligence and network mapping.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the vendor contact. Used for urgent supply chain escalations and on-call support.',
    `notes` STRING COMMENT 'Free-text notes and observations about the contact, including communication preferences, relationship history, special considerations, or other relevant context for supplier relationship management.',
    `office_location` STRING COMMENT 'Physical office location or site where the contact is based (e.g., headquarters, regional office, manufacturing plant).',
    `phone_number` STRING COMMENT 'Primary telephone number for the vendor contact. Includes country code and extension where applicable.',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the contacts preferred language for business communications (e.g., ENG, DEU, FRA, SPA, CHI, JPN).. Valid values are `^[A-Z]{3}$`',
    `relationship_strength_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the strength and quality of the business relationship with this contact. Based on interaction frequency, responsiveness, collaboration quality, and business outcomes.',
    `specialization_area` STRING COMMENT 'Specific area of expertise or specialization for the contact (e.g., electrification products, automation systems, quality management, supply chain logistics, contract negotiation).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts primary work location (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used for scheduling meetings and coordinating real-time communications.',
    `years_of_experience` STRING COMMENT 'Total years of professional experience the contact has in their field or industry. Used for relationship quality assessment.',
    CONSTRAINT pk_supplier_contact PRIMARY KEY(`supplier_contact_id`)
) COMMENT 'Tracks individual contacts associated with a vendor organization, including account managers, quality engineers, logistics coordinators, and executive sponsors. Captures full name, job title, department, email, phone, preferred language, contact role (commercial, technical, quality, logistics), and active status. Supports multi-threaded supplier relationship management across procurement, quality, and after-sales functions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key.',
    `commodity_category_id` BIGINT COMMENT 'add column commodity_category_id (BIGINT) with FK to procurement.commodity_category.commodity_category_id - supplier qualifications are scoped to specific commodity categories',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being qualified. Links to the supplier master data entity.',
    `tertiary_qualification_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the qualification record, captured for audit trail purposes.',
    `affected_commodities` STRING COMMENT 'Comma-separated list or description of commodity categories affected by a disqualification event. Null if not disqualified or if disqualification is global.',
    `approval_date` DATE COMMENT 'Date when the supplier was formally approved for the specified scope. Null if not yet approved or if disqualified.',
    `audit_date` DATE COMMENT 'Date when the on-site or remote supplier audit was conducted as part of the qualification process. Null if no audit was performed.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score from the supplier qualification audit, typically expressed as a percentage (0.00 to 100.00). Null if no audit was conducted.',
    `basis` STRING COMMENT 'Primary method or standard used to qualify the supplier: PPAP (Production Part Approval Process), APQP (Advanced Product Quality Planning), on-site audit, sample approval, document review, third-party certification (ISO, UL, etc.), or legacy performance history. [ENUM-REF-CANDIDATE: ppap|apqp|on_site_audit|sample_approval|document_review|third_party_certification|legacy_performance — 7 candidates stripped; promote to reference product]',
    `certification_required` STRING COMMENT 'Comma-separated list of certifications or standards the supplier must hold to maintain qualification (e.g., ISO 9001, ISO 14001, ISO 45001, IATF 16949, UL, CE). Null if no specific certifications are required.',
    `commodity_category` STRING COMMENT 'Primary commodity or part family for which the supplier is being qualified (e.g., electrical components, machined parts, castings, electronics, packaging materials). May reference a commodity taxonomy.',
    `conditional_approval_expiry_date` DATE COMMENT 'Date by which the supplier must satisfy conditional approval requirements to achieve full approval status. Null if not conditionally approved.',
    `conditional_approval_reason` STRING COMMENT 'Explanation of why the supplier was granted conditional approval rather than full approval, including specific restrictions or pending actions. Null if not conditionally approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `disqualification_date` DATE COMMENT 'Date when the supplier was formally disqualified or approval was revoked. Null if not disqualified.',
    `disqualification_reason` STRING COMMENT 'Detailed explanation of why the supplier was disqualified or rejected, including specific quality, delivery, compliance, or financial issues. Null if not disqualified.',
    `document_reference` STRING COMMENT 'Reference identifier or link to the formal qualification documentation package, including audit reports, PPAP submissions, certificates, and approval memos.',
    `evaluation_end_date` DATE COMMENT 'Date when the qualification evaluation was completed and a decision was rendered.',
    `evaluation_notes` STRING COMMENT 'Free-text field capturing additional observations, findings, or context from the qualification evaluation process.',
    `evaluation_start_date` DATE COMMENT 'Date when the formal supplier qualification evaluation process was initiated.',
    `evaluation_team` STRING COMMENT 'Comma-separated list or description of the cross-functional team members who participated in the supplier qualification evaluation (e.g., quality, engineering, procurement, operations).',
    `expiry_date` DATE COMMENT 'Date when the qualification approval expires and re-qualification is required. Null for indefinite approvals or disqualified suppliers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was last updated, reflecting the most recent change to status, scope, or other attributes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification assessment of the supplier. Null if no review is scheduled or if disqualified.',
    `part_family` STRING COMMENT 'Specific part family or product line within the commodity category that the qualification covers. Allows for granular scope definition.',
    `ppap_level` STRING COMMENT 'PPAP submission level required or achieved (Level 1 through Level 5), or not applicable if PPAP was not the qualification basis. Higher levels require more comprehensive documentation.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_applicable`',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification record, typically system-generated and used in external communications and audit trails.. Valid values are `^QF-[0-9]{8}$`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the supplier qualification: prospective (initial inquiry), under evaluation (assessment in progress), approved (fully qualified), conditional (approved with restrictions or pending actions), disqualified (rejected or revoked), expired (approval period lapsed).. Valid values are `prospective|under_evaluation|approved|conditional|disqualified|expired`',
    `qualification_type` STRING COMMENT 'Type of qualification event: new supplier onboarding, periodic re-qualification, extension to new commodity categories, disqualification action, or conditional approval pending corrective action.. Valid values are `new_supplier|re_qualification|commodity_extension|disqualification|conditional_approval`',
    `re_qualification_conditions` STRING COMMENT 'Specific conditions or corrective actions the supplier must complete before being eligible for re-qualification. Null if not applicable or if permanently disqualified.',
    `re_qualification_eligible` BOOLEAN COMMENT 'Indicates whether a disqualified supplier is eligible to apply for re-qualification in the future. True if eligible, False if permanently disqualified.',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the supplier at the time of qualification: low (minimal risk), medium (manageable risk), high (significant risk requiring mitigation), critical (unacceptable risk without immediate action).. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed textual description of the qualification scope, including specific materials, processes, or services the supplier is approved to provide.',
    `transition_plan_reference` STRING COMMENT 'Reference identifier or document number for the supplier transition or phase-out plan in the event of disqualification. Null if not applicable.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Records the formal supplier qualification lifecycle for each vendor, tracking whether a vendor has been approved or disqualified for specific commodity categories or part families. Captures qualification status (prospective, under evaluation, approved, conditional, disqualified), qualification type (new supplier, re-qualification, commodity extension, disqualification), evaluation start/end dates, approving engineer, qualification basis (PPAP, APQP, audit, sample approval), expiry date, and for disqualification events: disqualification reason, affected commodities, transition plan reference, and re-qualification eligibility. Managed in SAP Ariba and aligned with PPAP/APQP standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` (
    `scorecard_id` BIGINT COMMENT 'Unique identifier for the supplier performance scorecard record.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or director who approved and authorized the publication of this scorecard.',
    `primary_scorecard_employee_id` BIGINT COMMENT 'Reference to the buyer, procurement specialist, or quality engineer who conducted the scorecard evaluation.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being evaluated in this scorecard.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard was officially approved by the designated approver.',
    `capa_count` STRING COMMENT 'Total number of corrective and preventive action requests issued to this supplier during the evaluation period.',
    `comments` STRING COMMENT 'Additional comments, notes, or contextual information about the scorecard evaluation and results.',
    `cost_score` DECIMAL(18,2) COMMENT 'Performance score for the cost pillar, measuring price competitiveness, cost variance, and total cost of ownership, expressed as a percentage (0-100).',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual costs and target or budgeted costs during the evaluation period, where negative values indicate cost savings.',
    `cost_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the cost pillar in the overall score calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary values in this scorecard.. Valid values are `^[A-Z]{3}$`',
    `delivery_score` DECIMAL(18,2) COMMENT 'Performance score for the delivery pillar, measuring on-time delivery performance and schedule adherence, expressed as a percentage (0-100).',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the delivery pillar in the overall score calculation.',
    `evaluation_methodology` STRING COMMENT 'Description of the scoring methodology, weighting scheme, and calculation approach used for this scorecard evaluation.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period covered by this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period covered by this scorecard.',
    `improvement_actions_required` STRING COMMENT 'Summary of required improvement actions or corrective measures the supplier must implement based on scorecard results.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was last modified or updated.',
    `ncr_count` STRING COMMENT 'Total number of non-conformance reports issued against this supplier during the evaluation period.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next performance review or scorecard evaluation for this supplier.',
    `otd_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries received on or before the scheduled delivery date during the evaluation period, a key delivery performance indicator.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite overall performance score for the supplier, typically calculated as a weighted average of individual pillar scores, expressed as a percentage (0-100).',
    `period_type` STRING COMMENT 'The frequency or type of evaluation period for this scorecard (monthly, quarterly, annual, or ad-hoc).. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `ppm_defect_rate` DECIMAL(18,2) COMMENT 'Number of defective parts per million parts received during the evaluation period, a key quality performance indicator.',
    `previous_rating_tier` STRING COMMENT 'The rating tier assigned to the supplier in the previous evaluation period, used for trend analysis and tier movement tracking.. Valid values are `preferred|approved|conditional|development|probation|disqualified`',
    `published_date` DATE COMMENT 'The date when the scorecard was officially published and communicated to the supplier.',
    `quality_score` DECIMAL(18,2) COMMENT 'Performance score for the quality pillar, measuring defect rates, non-conformances, and quality compliance, expressed as a percentage (0-100).',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the quality pillar in the overall score calculation.',
    `rating_tier` STRING COMMENT 'Strategic classification tier assigned to the supplier based on scorecard performance, driving sourcing decisions and supplier development programs.. Valid values are `preferred|approved|conditional|development|probation|disqualified`',
    `responsiveness_index` DECIMAL(18,2) COMMENT 'Composite index measuring supplier responsiveness across communication, issue resolution, and collaboration dimensions, expressed as a percentage (0-100).',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Performance score for the responsiveness pillar, measuring communication effectiveness, issue resolution speed, and collaboration quality, expressed as a percentage (0-100).',
    `responsiveness_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the responsiveness pillar in the overall score calculation.',
    `rma_count` STRING COMMENT 'Total number of return material authorizations processed for defective or non-conforming materials from this supplier during the evaluation period.',
    `scorecard_number` STRING COMMENT 'Business identifier for the scorecard, typically formatted as a human-readable code used in reports and communications.',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard indicating its approval and publication state.. Valid values are `draft|in-review|approved|published|archived`',
    `strengths_summary` STRING COMMENT 'Summary of the suppliers key strengths and positive performance areas identified during the evaluation period.',
    `total_line_items_evaluated` STRING COMMENT 'Total number of purchase order line items included in the evaluation period for this scorecard.',
    `total_orders_evaluated` STRING COMMENT 'Total number of purchase orders included in the evaluation period for this scorecard.',
    `total_purchase_value` DECIMAL(18,2) COMMENT 'Total monetary value of purchases from this supplier during the evaluation period, used for spend-weighted performance analysis.',
    `total_receipts_evaluated` STRING COMMENT 'Total number of goods receipts or deliveries included in the evaluation period for this scorecard.',
    `weaknesses_summary` STRING COMMENT 'Summary of the suppliers key weaknesses and performance gaps identified during the evaluation period.',
    CONSTRAINT pk_scorecard PRIMARY KEY(`scorecard_id`)
) COMMENT 'Periodic supplier performance scorecard capturing aggregated KPI results across quality, delivery, cost, and responsiveness dimensions for a defined evaluation period (monthly, quarterly, annual). Stores overall score, individual pillar scores (OTD — On-Time Delivery, PPM — Parts Per Million defect rate, cost variance, responsiveness index), scorecard period, rating tier (preferred, approved, conditional, development), and issuing buyer. Drives strategic sourcing decisions and supplier development programs.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` (
    `supplier_audit_id` BIGINT COMMENT 'Unique identifier for the supplier audit record. Primary key.',
    `controlled_document_id` BIGINT COMMENT 'Reference identifier or document management system link to the formal audit report document.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or auditor record for the lead auditor conducting the audit.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Supplier audits are often scoped to a particular project; linking audit findings to the project ensures traceability and corrective‑action alignment.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Audits are performed to verify supplier adherence to specific regulations; linking enables audit‑to‑regulation traceability.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being audited. Links to the supplier master data.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Site‑specific audit information; each audit occurs at a particular supplier site, enabling site‑level risk tracking and reporting.',
    `approved_by` STRING COMMENT 'Name of the quality manager or procurement director who approved the final audit report and findings.',
    `approved_date` DATE COMMENT 'Date when the audit report was formally approved by the quality or procurement management.',
    `audit_date` DATE COMMENT 'The date when the supplier audit was conducted at the vendor site. This is the principal business event timestamp for the audit.',
    `audit_method` STRING COMMENT 'Method used to conduct the audit: on-site visit, remote audit via video conference, hybrid approach, or document review only.. Valid values are `on_site|remote|hybrid|document_review`',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the quality or procurement team for tracking and documentation purposes.',
    `audit_result` STRING COMMENT 'Overall outcome of the supplier audit: pass (no critical or major findings), conditional pass (findings require corrective action within timeframe), fail (critical findings or inability to meet standards), or pending (awaiting final determination).. Valid values are `pass|conditional_pass|fail|pending`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including specific processes, departments, product lines, or standards being evaluated during the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in progress (fieldwork underway), completed (audit finished and report issued), cancelled (audit did not proceed), or report pending (fieldwork complete, awaiting final report).. Valid values are `scheduled|in_progress|completed|cancelled|report_pending`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its focus area: quality system audits (ISO 9001, IATF 16949), process audits, environmental audits (ISO 14001), cybersecurity audits (IEC 62443), social compliance audits, financial audits, or product audits. [ENUM-REF-CANDIDATE: quality_system|process|environmental|cybersecurity|social_compliance|financial|product — 7 candidates stripped; promote to reference product]',
    `auditor_comments` STRING COMMENT 'Free-text comments and observations from the lead auditor summarizing key findings, strengths, and areas for improvement.',
    `capa_completion_date` DATE COMMENT 'Actual date when all required corrective and preventive actions were verified as complete and closed.',
    `capa_due_date` DATE COMMENT 'Target date by which the supplier must complete and submit corrective and preventive actions to address audit findings.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator whether corrective and preventive action (CAPA) is required from the supplier to address audit findings.',
    `certification_standard` STRING COMMENT 'The specific certification standard or framework being audited against, such as ISO 9001, IATF 16949, ISO 14001, ISO 45001, IEC 62443, or other industry-specific standards.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and administrative costs.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances or findings identified during the audit that pose immediate risk to quality, safety, or compliance and require urgent corrective action.',
    `end_date` DATE COMMENT 'The date when the audit fieldwork was completed, applicable for multi-day audits.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled or actual date of the follow-up audit conducted to verify corrective action effectiveness.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a follow-up audit is required to verify implementation and effectiveness of corrective actions.',
    `frequency_months` STRING COMMENT 'Standard audit frequency interval in months for this supplier based on risk classification and business requirements (e.g., 12, 24, 36 months).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier audit record was last updated or modified in the system.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and overseeing the supplier audit.',
    `location` STRING COMMENT 'Physical location or site where the audit was conducted, typically the supplier facility address or site name.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances or findings identified during the audit that represent significant deviations from standards or requirements.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or findings identified during the audit that represent isolated or low-impact deviations from standards.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit based on audit frequency policy, risk rating, and previous audit results.',
    `observation_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit that do not constitute non-conformances but warrant attention.',
    `report_date` DATE COMMENT 'Date when the formal audit report was issued to the supplier and internal stakeholders.',
    `risk_rating_post_audit` STRING COMMENT 'Updated supplier risk rating assigned after the audit based on audit findings and overall performance evaluation.. Valid values are `low|medium|high|critical`',
    `risk_rating_pre_audit` STRING COMMENT 'Supplier risk rating assigned before the audit based on historical performance, criticality, and risk assessment criteria.. Valid values are `low|medium|high|critical`',
    `score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the audit based on evaluation criteria, typically expressed as a percentage or weighted score reflecting overall supplier performance.',
    `start_date` DATE COMMENT 'The date when the audit fieldwork commenced, applicable for multi-day audits.',
    `supplier_response` STRING COMMENT 'Free-text response or feedback from the supplier regarding the audit findings and proposed corrective actions.',
    `team_members` STRING COMMENT 'Comma-separated list of additional auditor names who participated in the audit as team members.',
    `total_findings_count` STRING COMMENT 'Total number of all findings (critical, major, minor) identified during the audit, excluding observations.',
    CONSTRAINT pk_supplier_audit PRIMARY KEY(`supplier_audit_id`)
) COMMENT 'Records formal supplier audits conducted at vendor sites, including quality system audits (ISO 9001, IATF 16949), process audits, environmental audits (ISO 14001), cybersecurity audits (IEC 62443), and social compliance audits. Captures audit type, audit date, lead auditor, audit scope, findings count by severity (critical, major, minor), overall audit result (pass, conditional pass, fail), and next scheduled audit date. Linked to CAPA records for finding remediation tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` (
    `supplier_audit_finding_id` BIGINT COMMENT 'Unique identifier for the supplier audit finding record. Primary key.',
    `capa_id` BIGINT COMMENT 'Reference to the formal CAPA record created to address this finding, if applicable.',
    `previous_finding_supplier_audit_finding_id` BIGINT COMMENT 'Reference to the previous finding record if this is identified as a repeat finding.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Audit findings often cite the exact regulatory clause violated; FK provides direct reference for corrective‑action tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FINDING REMEDIATION: Assigns a responsible employee for each audit finding; needed for corrective‑action tracking and closure reporting.',
    `supplier_audit_id` BIGINT COMMENT 'Reference to the parent supplier audit event during which this finding was identified.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier against whom this finding was raised.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor who identified and documented this finding during the supplier audit.',
    `clause_reference` STRING COMMENT 'Reference to the specific standard clause, requirement, or specification section that was not met (e.g., ISO 9001:2015 Clause 8.5.1, customer specification section 4.2).',
    `closure_date` DATE COMMENT 'Actual date when the finding was formally closed after successful verification of corrective action effectiveness.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or clarifications related to the finding, its resolution, or verification.',
    `containment_action` STRING COMMENT 'Immediate containment or interim action taken to prevent further impact while root cause analysis and permanent corrective action are developed.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action(s) required to address the finding and prevent recurrence. Links to Corrective and Preventive Action (CAPA) process.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this finding record was first created in the system.',
    `due_date` DATE COMMENT 'Target date by which the corrective action must be completed and evidence submitted for verification.',
    `escalation_date` DATE COMMENT 'Date when the finding was escalated to higher management levels.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this finding has been escalated to senior management or supplier development team due to severity, repeat occurrence, or lack of timely response.',
    `evidence_reference` STRING COMMENT 'Reference to supporting evidence, documentation, photographs, or records that substantiate the finding (e.g., document IDs, photo file names, sample numbers).',
    `finding_description` STRING COMMENT 'Detailed narrative description of the non-conformance or observation, including objective evidence and specific details of what was found during the audit.',
    `finding_number` STRING COMMENT 'Externally visible unique reference number assigned to this finding for tracking and communication purposes.',
    `finding_status` STRING COMMENT 'Current state of the finding in its resolution lifecycle from identification through closure.. Valid values are `open|in_progress|pending_verification|closed|overdue`',
    `finding_type` STRING COMMENT 'Classification of the finding based on its nature and severity impact. Non-conformance indicates a deviation from requirements; observation is a potential issue; opportunity for improvement suggests enhancement areas; positive finding highlights best practices.. Valid values are `non_conformance|observation|opportunity_for_improvement|positive_finding`',
    `identified_date` DATE COMMENT 'Date when the finding was first identified during the audit activity.',
    `impact_assessment` STRING COMMENT 'Assessment of the potential or actual impact of this finding on product quality, delivery, cost, safety, or compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this finding record was last updated or modified.',
    `process_area` STRING COMMENT 'The business process or functional area where the finding was identified (e.g., Incoming Inspection, Production Control, Document Management, Calibration).',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat of a previously identified issue from a prior audit, suggesting ineffective corrective action or systemic problem.',
    `responsible_party` STRING COMMENT 'Name or identifier of the supplier personnel or department responsible for implementing the corrective action.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this finding based on likelihood and impact assessment, used for prioritization and escalation decisions.. Valid values are `high|medium|low`',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) of the finding, typically using structured problem-solving methods such as 5 Whys, Fishbone Diagram, or Failure Mode and Effects Analysis (FMEA).',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause (e.g., Training Gap, Process Inadequacy, Resource Constraint, Documentation Error, Equipment Failure, Communication Breakdown). [ENUM-REF-CANDIDATE: training_gap|process_inadequacy|resource_constraint|documentation_error|equipment_failure|communication_breakdown|supplier_error|design_flaw — promote to reference product]',
    `severity` STRING COMMENT 'Severity classification of the finding. Critical indicates immediate risk to product safety or compliance; major indicates significant system breakdown; minor indicates isolated or low-impact deviation.. Valid values are `critical|major|minor`',
    `supplier_response` STRING COMMENT 'Formal response provided by the supplier acknowledging the finding and outlining their proposed corrective action plan.',
    `supplier_response_date` DATE COMMENT 'Date when the supplier submitted their formal response to the finding.',
    `verification_date` DATE COMMENT 'Date when the corrective action effectiveness was verified.',
    `verification_method` STRING COMMENT 'Method used to verify corrective action effectiveness (e.g., Follow-up Audit, Document Review, On-site Inspection, Performance Data Analysis).',
    `verification_status` STRING COMMENT 'Status of the verification activity to confirm that the corrective action has been implemented and is effective in preventing recurrence.. Valid values are `not_verified|verification_scheduled|verified_effective|verified_ineffective|verification_pending`',
    `verified_by` STRING COMMENT 'Name or identifier of the auditor or quality personnel who verified the corrective action effectiveness.',
    CONSTRAINT pk_supplier_audit_finding PRIMARY KEY(`supplier_audit_finding_id`)
) COMMENT 'Individual non-conformance or observation identified during a supplier audit. Each finding has its own lifecycle from identification through closure. Captures finding reference number, finding type (non-conformance, observation, opportunity for improvement), severity (critical, major, minor), process area affected, finding description, root cause category, required corrective action, due date, closure date, and verification status. Supports CAPA tracking and repeat-finding analysis.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` (
    `supplier_certification_id` BIGINT COMMENT 'Unique identifier for the supplier certification record. Primary key for the supplier certification entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CERTIFICATION OVERSIGHT: Tracks which internal employee manages each supplier certification; required for compliance audit traceability.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Projects require specific supplier certifications; linking enables per‑project certification compliance reporting and risk assessment.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Required for tracking which regulatory requirement each supplier certification satisfies; essential for compliance reporting and audit readiness.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who holds this certification. Links to the supplier master data entity.',
    `site_id` BIGINT COMMENT 'Reference to the specific supplier site or facility where this certification applies. Nullable if certification applies to the entire supplier organization rather than a specific site.',
    `accreditation_body` STRING COMMENT 'The name of the accreditation body that accredits the issuing certification body. Examples include ANAB (ANSI National Accreditation Board), UKAS (United Kingdom Accreditation Service), DAkkS (German Accreditation Body), or other national accreditation authorities.',
    `alert_threshold_days` STRING COMMENT 'The number of days before expiry at which automated alerts should be triggered to notify stakeholders of the upcoming certification expiration. Typical values range from 30 to 180 days.',
    `audit_report_url` STRING COMMENT 'The URL or file path to the most recent audit report document stored in the document management system or cloud storage.',
    `audit_result` STRING COMMENT 'The outcome of the most recent audit. Passed indicates full compliance. Passed with observations indicates minor non-conformances that do not affect certification. Failed indicates major non-conformances. Conditional indicates certification granted pending corrective actions. Deferred indicates the audit decision is postponed.. Valid values are `passed|passed_with_observations|failed|conditional|deferred`',
    `audit_type` STRING COMMENT 'The type of audit that resulted in this certification or its most recent validation. Initial audit is the first certification audit. Surveillance audits are periodic checks. Recertification audits occur at the end of the certification cycle. Special audits address specific issues. Transfer audits occur when changing certification bodies.. Valid values are `initial|surveillance|recertification|special|transfer`',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automatic renewal workflows and alerts are enabled for this certification. True if the system should automatically trigger renewal processes and notifications. False if renewal is managed manually.',
    `business_criticality` STRING COMMENT 'The importance of this certification to the business relationship with the supplier. Critical certifications are mandatory for continued business. High criticality certifications are strongly preferred. Medium and low criticality certifications are informational or nice-to-have.. Valid values are `low|medium|high|critical`',
    `certificate_document_url` STRING COMMENT 'The URL or file path to the digital copy of the certification certificate document stored in the document management system or cloud storage.',
    `certification_level` STRING COMMENT 'The tier, grade, or level of certification achieved, if the standard defines multiple levels. Examples include Level 1, Level 2, Level 3 for IEC 62443, or Gold, Silver, Bronze for tiered certification programs.',
    `certification_number` STRING COMMENT 'The unique certificate number or registration number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'The current lifecycle status of the certification. Active indicates the certification is valid and in good standing. Expired indicates the certification has passed its expiry date. Suspended indicates temporary suspension by the issuing body. Revoked indicates permanent withdrawal. Pending renewal indicates the certification is in the renewal process. Under review indicates the certification is being audited or reassessed.. Valid values are `active|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'The category or domain of the certification. Classifies certifications into quality management, environmental management, health and safety, energy management, cybersecurity, product safety, industry-specific standards, or regulatory compliance. [ENUM-REF-CANDIDATE: quality|environmental|health_safety|energy|cybersecurity|product_safety|industry_specific|regulatory_compliance — 8 candidates stripped; promote to reference product]',
    `certified_processes` STRING COMMENT 'A comma-separated or structured list of specific manufacturing processes, production lines, or operational activities that are covered under this certification. Examples include welding, machining, assembly, testing, or packaging.',
    `certified_products` STRING COMMENT 'A comma-separated or structured list of specific product categories, product families, or SKUs (Stock Keeping Units) that are covered under this certification. Used to gate procurement decisions for regulated commodity categories.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about this certification. May include information about special conditions, limitations, or historical context.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which all required corrective actions must be completed and verified. Failure to meet this date may result in certification suspension or revocation.',
    `corrective_actions_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to address audit findings. True if corrective actions are pending or in progress. False if no corrective actions are needed or all have been completed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Audit trail field for data lineage and compliance tracking.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes effective and valid for business use. May differ from issue date if there is a grace period or transition period.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Critical for triggering renewal workflows and procurement gating decisions.',
    `gated_commodity_categories` STRING COMMENT 'A comma-separated list of commodity categories or material groups for which this certification is mandatory. Procurement of these commodities from this supplier is blocked if the certification is not active and valid.',
    `geographic_scope` STRING COMMENT 'The geographic regions, countries, or markets where this certification is recognized and valid. Examples include USA, EU, China, or Global. Uses 3-letter ISO country codes where applicable.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued by the certifying body. Represents the start of the certification validity period.',
    `issuing_body` STRING COMMENT 'The name of the certification body, registrar, or regulatory authority that issued the certification. Examples include TUV, BSI, DNV, SGS, UL, Intertek, Bureau Veritas, LRQA, or government agencies.',
    `last_audit_date` DATE COMMENT 'The date of the most recent surveillance audit or recertification audit conducted by the certifying body to verify ongoing compliance with the certification standard.',
    `last_updated_by` STRING COMMENT 'The user identifier or system account that most recently modified this certification record. Audit trail field for accountability and data lineage.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was most recently modified. Audit trail field for data lineage and compliance tracking.',
    `major_nonconformance_count` STRING COMMENT 'The number of major non-conformances identified during the most recent audit. Major non-conformances are serious violations that can lead to certification suspension or revocation.',
    `minor_nonconformance_count` STRING COMMENT 'The number of minor non-conformances identified during the most recent audit. Minor non-conformances are less serious violations that require corrective action but do not immediately threaten certification status.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next surveillance audit or recertification audit. Used for planning and ensuring continuous compliance.',
    `nonconformance_count` STRING COMMENT 'The total number of non-conformances (major and minor) identified during the most recent audit. Used to assess the suppliers compliance maturity and risk level.',
    `procurement_gate_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is used to gate procurement decisions. True if suppliers without valid certification in this standard cannot be selected for certain commodity categories. False if the certification is informational only.',
    `renewal_date` DATE COMMENT 'The target date by which the certification renewal process must be completed to avoid expiration. Typically occurs before the expiry date to allow for processing time.',
    `renewal_status` STRING COMMENT 'The current status of the certification renewal process. Not due indicates renewal is not yet required. Renewal initiated indicates the renewal process has started. Renewal in progress indicates active renewal activities. Renewal completed indicates successful renewal. Renewal overdue indicates the renewal deadline has passed.. Valid values are `not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_overdue`',
    `risk_rating` STRING COMMENT 'The risk level associated with this certification based on its status, expiry proximity, audit findings, and business criticality. Low indicates minimal risk. Medium indicates moderate risk requiring monitoring. High indicates significant risk requiring action. Critical indicates immediate risk requiring urgent intervention.. Valid values are `low|medium|high|critical`',
    `scope_of_certification` STRING COMMENT 'A detailed description of the scope, activities, products, services, or processes covered by this certification. Defines the boundaries and applicability of the certification within the suppliers operations.',
    `standard` STRING COMMENT 'The regulatory, quality, or industry standard that this certification represents. Examples include ISO 9001 (Quality Management), ISO 14001 (Environmental Management), ISO 45001 (Occupational Health and Safety), ISO 50001 (Energy Management), IEC 62443 (Industrial Cybersecurity), IATF 16949 (Automotive Quality), AS9100 (Aerospace Quality), UL (Product Safety), CE Marking (European Conformity), RoHS (Restriction of Hazardous Substances), and REACH (Chemical Safety). [ENUM-REF-CANDIDATE: ISO 9001|ISO 14001|ISO 45001|ISO 50001|IEC 62443|IATF 16949|AS9100|UL|CE Marking|RoHS|REACH|ISO 27001|ISO 13485|OHSAS 18001 — 14 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by internal quality assurance or procurement teams. Verification includes confirming the certificate is authentic, current, and matches the suppliers claims.',
    `verification_method` STRING COMMENT 'The method used to verify the certification. Document review indicates verification by examining the certificate document. Certifying body confirmation indicates direct verification with the issuing body. On-site inspection indicates physical verification during a supplier visit. Third-party verification indicates verification by an external auditor. Supplier declaration indicates acceptance of supplier-provided documentation without independent verification.. Valid values are `document_review|certifying_body_confirmation|on_site_inspection|third_party_verification|supplier_declaration`',
    `verified_by` STRING COMMENT 'The name or identifier of the internal employee or quality assurance team member who verified the authenticity and validity of this certification with the issuing body.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this certification record. Audit trail field for accountability and data lineage.',
    CONSTRAINT pk_supplier_certification PRIMARY KEY(`supplier_certification_id`)
) COMMENT 'Tracks all regulatory, quality, and industry certifications held by a vendor or vendor site, including ISO 9001, ISO 14001, ISO 45001, ISO 50001, IEC 62443, UL, CE Marking, IATF 16949, AS9100, and RoHS compliance. Captures certification standard, issuing body, certificate number, issue date, expiry date, scope of certification, and renewal status. Drives automated alerts for expiring certifications and gates procurement decisions for regulated commodity categories.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` (
    `risk_rating_id` BIGINT COMMENT 'Unique identifier for the supplier risk rating assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved and authorized the risk rating for publication.',
    `primary_risk_employee_id` BIGINT COMMENT 'Identifier of the employee or team member who conducted the risk assessment.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being assessed for risk exposure.',
    `approved_date` DATE COMMENT 'Date when the risk assessment was formally approved by the designated authority.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was performed and finalized.',
    `assessment_methodology` STRING COMMENT 'Methodology used to conduct the risk assessment, indicating whether it was quantitative model-based, qualitative expert review, third-party data feed, or hybrid approach.. Valid values are `quantitative_model|qualitative_review|third_party_feed|hybrid`',
    `assessment_number` STRING COMMENT 'Business identifier for the risk assessment record, typically following format RA-YYYYMMDD or similar organizational convention.. Valid values are `^RA-[0-9]{8}$`',
    `assessment_period_end_date` DATE COMMENT 'End date of the observation period used for risk data collection and analysis.',
    `assessment_period_start_date` DATE COMMENT 'Start date of the observation period used for risk data collection and analysis.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record indicating workflow state.. Valid values are `draft|in_review|approved|published|expired|superseded`',
    `audit_findings_count` STRING COMMENT 'Total number of audit findings (critical, major, minor) identified during the assessment period, indicating quality and compliance risk.',
    `capacity_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the suppliers production capacity currently utilized, indicating headroom for demand increases or risk of over-commitment.',
    `certification_gap_count` STRING COMMENT 'Number of required certifications or standards that the supplier does not currently hold, representing compliance risk.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or qualitative observations about the risk assessment that do not fit structured fields.',
    `conflict_minerals_flag` BOOLEAN COMMENT 'Boolean indicator whether the supplier sources conflict minerals from high-risk regions, representing ESG and regulatory compliance risk.',
    `country_risk_rating` STRING COMMENT 'Risk rating for the suppliers primary operating country reflecting political stability, economic conditions, and regulatory environment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk rating record was first created in the system.',
    `credit_score` STRING COMMENT 'Numerical credit score from financial rating agencies indicating the suppliers creditworthiness and payment reliability.',
    `cybersecurity_incident_count` STRING COMMENT 'Number of reported cybersecurity incidents or breaches at the supplier during the assessment period.',
    `cybersecurity_risk_score` DECIMAL(18,2) COMMENT 'Risk score for cybersecurity maturity dimension evaluating IEC 62443 compliance level, incident history, vulnerability management, and data protection practices.',
    `data_sources` STRING COMMENT 'Comma-separated list of data sources used for the risk assessment, such as Dun & Bradstreet, RapidRatings, EcoVadis, internal scorecards, audit reports, or supplier self-declarations.',
    `dnb_rating` STRING COMMENT 'Dun & Bradstreet credit rating or risk indicator for the supplier, providing third-party financial risk assessment.',
    `ecovadis_score` STRING COMMENT 'EcoVadis sustainability rating score (0-100) assessing the suppliers ESG performance across environment, labor practices, ethics, and sustainable procurement.',
    `environmental_compliance_status` STRING COMMENT 'Status of the suppliers compliance with environmental regulations and ISO 14001 standards.. Valid values are `compliant|non_compliant|under_review|not_assessed`',
    `esg_risk_score` DECIMAL(18,2) COMMENT 'Risk score for ESG (Environmental, Social, and Governance) dimension covering environmental compliance, labor practices, conflict minerals sourcing, and sustainability performance.',
    `financial_risk_score` DECIMAL(18,2) COMMENT 'Risk score for financial stability dimension based on credit rating, liquidity ratios, debt levels, and financial health indicators from sources like Dun & Bradstreet or RapidRatings.',
    `geopolitical_risk_score` DECIMAL(18,2) COMMENT 'Risk score for geopolitical exposure dimension covering country risk, sanctions lists, trade restrictions, political stability, and regulatory environment.',
    `iec_62443_maturity_level` STRING COMMENT 'Industrial cybersecurity maturity level per IEC 62443 standard, indicating the suppliers capability to protect industrial control systems and operational technology.. Valid values are `level_0|level_1|level_2|level_3|level_4|not_assessed`',
    `key_risk_drivers` STRING COMMENT 'Narrative summary of the primary risk factors and drivers contributing to the overall risk rating, highlighting specific concerns or vulnerabilities.',
    `lead_time_volatility_index` DECIMAL(18,2) COMMENT 'Statistical measure of lead time variability and unpredictability, calculated as coefficient of variation or standard deviation of delivery lead times.',
    `mitigation_actions` STRING COMMENT 'Description of risk mitigation actions currently in place or planned, such as dual sourcing, increased inventory buffers, supplier development programs, or contractual safeguards.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk rating record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic risk assessment review, typically based on risk tier and organizational policy.',
    `operational_risk_score` DECIMAL(18,2) COMMENT 'Risk score for operational continuity dimension assessing single-source dependency, capacity utilization, lead time volatility, and business continuity preparedness.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite numerical risk score calculated from weighted dimension scores, typically on a 0-100 scale where higher values indicate greater risk.',
    `overall_risk_tier` STRING COMMENT 'Aggregated risk classification tier representing the suppliers overall risk exposure level across all dimensions.. Valid values are `critical|high|medium|low`',
    `ppm_defect_rate` DECIMAL(18,2) COMMENT 'Quality metric representing defective parts per million units received, used to assess quality risk exposure.',
    `published_date` DATE COMMENT 'Date when the risk rating was published and made available to stakeholders for supply chain risk management and sourcing decisions.',
    `quality_risk_score` DECIMAL(18,2) COMMENT 'Risk score for quality performance dimension based on PPM (Parts Per Million) defect trends, audit history, certification gaps, and NCR (Non-Conformance Report) frequency.',
    `residual_risk_level` STRING COMMENT 'Risk level remaining after mitigation actions have been applied, representing the net risk exposure the organization accepts.. Valid values are `critical|high|medium|low`',
    `review_frequency_months` STRING COMMENT 'Standard review frequency in months for this risk rating, typically shorter for higher-risk suppliers (e.g., 3 months for critical, 12 months for low).',
    `sanctions_flag` BOOLEAN COMMENT 'Boolean indicator whether the supplier or its country of operation is subject to international trade sanctions or restricted party lists.',
    `single_source_flag` BOOLEAN COMMENT 'Boolean indicator whether this supplier is the sole source for critical materials or components, representing supply chain concentration risk.',
    CONSTRAINT pk_risk_rating PRIMARY KEY(`risk_rating_id`)
) COMMENT 'Periodic supplier risk assessment record capturing multi-dimensional risk exposure for a vendor across financial (D&B rating, credit score, liquidity), geopolitical (country risk, sanctions, trade restrictions), operational (single-source dependency, capacity utilization, lead time volatility), quality (PPM trends, audit history, certification gaps), cybersecurity (IEC 62443 maturity, incident history), and ESG (environmental compliance, labor practices, conflict minerals) dimensions. Stores overall risk tier (critical, high, medium, low), individual dimension scores, risk assessment date, assessment methodology (quantitative model, qualitative review, third-party feed), data sources (Dun & Bradstreet, RapidRatings, EcoVadis, internal), key risk drivers, mitigation actions in place, residual risk level, and next review date. Feeds supply chain risk management, business continuity planning, and dual-sourcing trigger decisions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for the approved vendor list entry. Primary key for the AVL record linking a qualified supplier to authorized commodity categories.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the authorized approver who approved this AVL entry.',
    `material_master_id` BIGINT COMMENT 'add column inventory_material_master_id (BIGINT) with FK to inventory.material_master.material_master_id - AVL entries specify which materials a supplier is approved to provide',
    `supplier_id` BIGINT COMMENT 'Reference to the qualified supplier authorized to supply materials or services for the specified commodity category.',
    `annual_spend_target` DECIMAL(18,2) COMMENT 'Target annual procurement spend with this supplier for the specified commodity category, used for volume commitment tracking and supplier relationship management.',
    `approval_date` DATE COMMENT 'Date when the supplier was officially approved for the specified commodity category following qualification audits and assessments.',
    `approved_by_name` STRING COMMENT 'Name of the procurement manager, quality manager, or authorized approver who approved this AVL entry.',
    `avl_number` STRING COMMENT 'Business identifier for the AVL entry used in procurement documents and Material Requirements Planning (MRP) source selection.. Valid values are `^AVL-[A-Z0-9]{8,12}$`',
    `avl_status` STRING COMMENT 'Current lifecycle status of the AVL entry determining whether the supplier can be selected during purchase order creation in Material Requirements Planning (MRP) and procurement processes.. Valid values are `active|suspended|phased_out|pending_approval|expired|blocked`',
    `capacity_rating` STRING COMMENT 'Assessment of the suppliers production capacity and ability to scale volume for this commodity category.. Valid values are `high|medium|low|limited|unlimited`',
    `certification_list` STRING COMMENT 'Comma-separated list of required certifications such as ISO 9001, ISO 14001, IATF 16949, AS9100, or industry-specific quality standards.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether specific certifications (ISO, industry-specific, regulatory) are required for the supplier to maintain AVL status for this commodity.',
    `comments` STRING COMMENT 'Free-text comments providing additional context about the AVL entry, special conditions, restrictions, or notes for procurement teams.',
    `commodity_code` STRING COMMENT 'Standardized code identifying the commodity category, material group, or part family for which the supplier is authorized to supply.. Valid values are `^[A-Z0-9]{4,10}$`',
    `commodity_description` STRING COMMENT 'Detailed description of the commodity category, material group, or part family covered by this AVL entry.',
    `contract_reference_number` STRING COMMENT 'Reference number of the master supply agreement or contract governing pricing, terms, and conditions for this commodity category.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `cost_competitiveness_rating` DECIMAL(18,2) COMMENT 'Cost competitiveness rating comparing the suppliers pricing for this commodity against market benchmarks and other approved suppliers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AVL record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and invoicing transactions with this supplier for the specified commodity.. Valid values are `^[A-Z]{3}$`',
    `delivery_rating` DECIMAL(18,2) COMMENT 'Current on-time delivery performance rating for the supplier in this commodity category, used in Material Requirements Planning (MRP) source selection.',
    `effective_end_date` DATE COMMENT 'Date when the AVL entry expires or is phased out. Null indicates an open-ended approval with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date from which the AVL entry becomes active and the supplier can be selected for purchase orders in the specified commodity category.',
    `expedited_lead_time_days` STRING COMMENT 'Expedited lead time in days available for urgent orders, typically shorter than standard lead time but may incur additional costs.',
    `geographic_supply_region` STRING COMMENT 'Three-letter ISO country code or region code indicating the primary geographic region from which the supplier will ship materials for this commodity.. Valid values are `^[A-Z]{3}$`',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the division of costs and risks between buyer and supplier for shipments under this AVL entry. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted for this commodity category, supporting ongoing qualification status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this AVL record, supporting change tracking and audit requirements.',
    `material_group` STRING COMMENT 'Material group classification code used in Enterprise Resource Planning (ERP) systems to categorize materials and link to approved suppliers.. Valid values are `^[A-Z0-9]{4,8}$`',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by the supplier for this commodity category. Used by Material Requirements Planning (MRP) to ensure order quantities meet supplier constraints.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the Minimum Order Quantity (MOQ) such as EA (each), KG (kilogram), M (meter), L (liter).. Valid values are `^[A-Z]{2,3}$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this AVL entry to assess continued supplier qualification and performance.',
    `part_family` STRING COMMENT 'Part family or product line grouping for which the supplier is qualified to provide components or assemblies.',
    `payment_terms` STRING COMMENT 'Standard payment terms applicable to purchase orders for this supplier and commodity combination, such as Net 30, Net 60, or 2/10 Net 30.',
    `ppap_level` STRING COMMENT 'Production Part Approval Process (PPAP) level required for parts supplied under this AVL entry, ranging from Level 1 (warrant only) to Level 5 (full submission with samples).. Valid values are `level_1|level_2|level_3|level_4|level_5|not_required`',
    `price_validity_end_date` DATE COMMENT 'End date for the current pricing agreement, after which prices must be renegotiated or updated.',
    `price_validity_start_date` DATE COMMENT 'Start date for the current pricing agreement applicable to this AVL entry.',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer team responsible for managing the supplier relationship and executing purchase orders for this commodity.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Purchasing organization code responsible for managing this AVL entry and executing procurement transactions with the supplier.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_rating` DECIMAL(18,2) COMMENT 'Current quality performance rating for the supplier in this commodity category, typically expressed as a percentage or score used in supplier selection decisions.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this AVL entry must be reviewed and revalidated to ensure continued supplier qualification.',
    `risk_rating` STRING COMMENT 'Overall supply risk rating for this supplier and commodity combination considering financial stability, geopolitical factors, single-source dependency, and business continuity.. Valid values are `low|medium|high|critical`',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the only approved source for the commodity category, representing a supply chain risk requiring mitigation strategies.',
    `standard_lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to delivery for this supplier and commodity combination. Used by Material Requirements Planning (MRP) for scheduling.',
    `supplier_designation` STRING COMMENT 'Designation indicating the suppliers priority level for sourcing decisions. Preferred suppliers are selected first by Material Requirements Planning (MRP), backup suppliers are used when preferred suppliers cannot fulfill demand.. Valid values are `preferred|approved|backup|conditional|strategic`',
    `supply_plant_code` STRING COMMENT 'Supplier plant or facility code from which materials will be shipped for this commodity category.. Valid values are `^[A-Z0-9]{4,6}$`',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'The Approved Vendor List (AVL) entry linking a qualified vendor to a specific commodity category, material group, or part family for which they are authorized to supply. Captures AVL status (active, suspended, phased-out), commodity code, material group, preferred/backup designation, MOQ (Minimum Order Quantity), lead time, geographic supply region, and approval date. The AVL is the operational gate used by MRP and procurement to select valid sources during purchase order creation in SAP S/4HANA MM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` (
    `development_plan_id` BIGINT COMMENT 'Unique identifier for the supplier development plan or Supplier Corrective Action Request (SCAR). Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or quality director who approved the closure of this development plan.',
    `primary_assigned_development_engineer_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `supplier_audit_id` BIGINT COMMENT 'Identifier of the supplier audit that identified findings leading to this plan, if applicable. Null if triggered by other sources.',
    `supplier_contact_id` BIGINT COMMENT 'Identifier of the primary supplier contact responsible for executing the actions in this plan.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier subject to this development plan or corrective action request.',
    `ncr_id` BIGINT COMMENT 'Identifier of the Non-Conformance Report (NCR) that triggered this corrective action plan, if applicable. Null if triggered by other sources.',
    `scorecard_id` BIGINT COMMENT 'Identifier of the supplier scorecard evaluation that triggered this development plan, if applicable. Null if triggered by other sources.',
    `action_type` STRING COMMENT 'Classification of the supplier-facing improvement intervention: performance improvement plan, capability development, quality remediation, SCAR (Supplier Corrective Action Request), preventive action, or cost reduction initiative.. Valid values are `performance_improvement_plan|capability_development|quality_remediation|scar|preventive_action|cost_reduction_initiative`',
    `actual_completion_date` DATE COMMENT 'Actual date when the plan was closed (effective or ineffective). Null if still open or in progress.',
    `actual_kpi_value` DECIMAL(18,2) COMMENT 'The actual KPI value achieved after plan completion, used to determine effectiveness.',
    `approval_date` DATE COMMENT 'Date when the plan closure was formally approved by management.',
    `baseline_kpi_value` DECIMAL(18,2) COMMENT 'The baseline value of the target KPI before the development plan was initiated.',
    `closure_outcome` STRING COMMENT 'Final outcome when the plan is closed: successful (issue resolved and verified), unsuccessful (actions failed to resolve issue), cancelled (plan terminated before completion), or escalated (issue elevated to higher management or alternative resolution path).. Valid values are `successful|unsuccessful|cancelled|escalated`',
    `comments` STRING COMMENT 'Free-text field for additional notes, lessons learned, or contextual information about the development plan.',
    `containment_action` STRING COMMENT 'Immediate short-term action taken to contain the issue and prevent further impact while permanent corrective action is developed (e.g., 100% inspection, quarantine, expedited sorting).',
    `containment_completion_date` DATE COMMENT 'Date when the containment action was fully implemented and verified.',
    `corrective_action_completion_date` DATE COMMENT 'Date when the permanent corrective action was fully implemented.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this development plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this plan (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the issue that triggered this plan (e.g., cost of quality escapes, rework, expedited freight, lost production). Negative value indicates cost to the business.',
    `estimated_savings` DECIMAL(18,2) COMMENT 'Estimated financial savings or cost avoidance expected from successful completion of this plan (e.g., reduced defects, improved efficiency, lower scrap rates).',
    `issue_type` STRING COMMENT 'Category of the deficiency or opportunity that triggered this plan: quality escape (defect reached customer), delivery failure (late or incomplete shipment), audit finding (compliance gap), process non-conformance, cost overrun, or capability gap.. Valid values are `quality_escape|delivery_failure|audit_finding|process_non_conformance|cost_overrun|capability_gap`',
    `kpi_unit_of_measure` STRING COMMENT 'Unit of measure for the KPI values (e.g., percentage, PPM, days, USD, count).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this development plan record was last updated.',
    `milestone_schedule` STRING COMMENT 'Structured schedule of key milestones and target dates for the development plan (e.g., root cause analysis complete by date X, corrective action implemented by date Y, verification by date Z). May be stored as JSON or delimited text.',
    `permanent_corrective_action` STRING COMMENT 'Long-term corrective action implemented to eliminate the root cause and prevent recurrence (e.g., process redesign, equipment upgrade, training program, supplier change).',
    `plan_end_date` DATE COMMENT 'Target completion date for all actions in the development plan. May be extended if verification fails.',
    `plan_number` STRING COMMENT 'Business-facing unique reference number for the development plan or SCAR (e.g., DP-2024-001, SCAR-2024-042).',
    `plan_start_date` DATE COMMENT 'Date when the development plan or corrective action was officially initiated.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the development plan: open (initiated), in-progress (actions underway), verification pending (awaiting validation), closed effective (successfully completed), closed ineffective (failed to resolve issue), or cancelled.. Valid values are `open|in_progress|verification_pending|closed_effective|closed_ineffective|cancelled`',
    `preventive_action` STRING COMMENT 'Proactive measures taken to prevent similar issues from occurring in other areas or processes (e.g., standardization, poka-yoke, design changes).',
    `preventive_action_completion_date` DATE COMMENT 'Date when the preventive action was fully implemented.',
    `priority` STRING COMMENT 'Business priority for resolution: urgent (immediate action required), high (expedited resolution), medium (standard timeline), or low (routine improvement).. Valid values are `urgent|high|medium|low`',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used to identify the root cause of the issue: 8D (Eight Disciplines), 5-Why, Ishikawa (fishbone diagram), fault tree analysis, FMEA (Failure Mode and Effects Analysis), Pareto analysis, or other. [ENUM-REF-CANDIDATE: 8d|5_why|ishikawa|fault_tree|fmea|pareto|other — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative describing the identified root cause(s) of the issue or deficiency.',
    `scar_reference_number` STRING COMMENT 'External SCAR reference number if this plan originated from a formal SCAR process. May be null for proactive development plans.',
    `severity_level` STRING COMMENT 'Severity classification of the issue triggering this plan: critical (immediate business impact), high (significant impact), medium (moderate impact), or low (minor impact).. Valid values are `critical|high|medium|low`',
    `target_kpi_metric` STRING COMMENT 'The specific KPI or performance metric that this plan aims to improve (e.g., PPM defect rate, OTD percentage, cost variance, lead time).',
    `target_kpi_value` DECIMAL(18,2) COMMENT 'The target value for the KPI that the plan aims to achieve upon successful completion.',
    `verification_date` DATE COMMENT 'Date when the verification activity was conducted to assess plan effectiveness.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective and preventive actions: on-site audit, document review, performance data analysis, sample inspection, process observation, or supplier self-assessment.. Valid values are `on_site_audit|document_review|performance_data_analysis|sample_inspection|process_observation|supplier_self_assessment`',
    `verification_result` STRING COMMENT 'Outcome of the verification activity: effective (actions resolved the issue), ineffective (issue persists), partially effective (some improvement but target not met), or pending (verification not yet complete).. Valid values are `effective|ineffective|partially_effective|pending`',
    CONSTRAINT pk_development_plan PRIMARY KEY(`development_plan_id`)
) COMMENT 'Formal supplier improvement action record serving as the single source of truth for ALL supplier-facing improvement interventions — both proactive development plans and reactive Supplier Corrective Action Requests (SCARs/8D). Captures action type (performance improvement plan, capability development, quality remediation, SCAR, preventive action, cost reduction initiative), severity/priority, plan start/end dates, target KPIs, root cause analysis method (8D, 5-Why, Ishikawa, fault tree), containment action, permanent corrective action, preventive action, SCAR reference number, issue type (quality escape, delivery failure, audit finding, process non-conformance), assigned development engineer, milestone schedule, verification method, current status (open, in-progress, verification pending, closed effective, closed ineffective), and closure outcome. Linked to scorecard deficiencies, audit findings, and quality escapes that triggered the action. Provides unified tracking replacing separate SCAR and development plan workflows — all supplier-facing corrective actions are managed here.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the supplier corrective action request record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the closure of the corrective action request.',
    `primary_corrective_employee_id` BIGINT COMMENT 'Identifier of the user who issued the corrective action request to the supplier.',
    `purchase_order_id` BIGINT COMMENT 'add column procurement_purchase_order_id (BIGINT) with FK to procurement.purchase_order.purchase_order_id - corrective actions often reference the PO with the quality issue',
    `ncr_id` BIGINT COMMENT 'add column quality_ncr_id (BIGINT) with FK to quality.ncr.ncr_id - supplier corrective actions are triggered by non-conformance reports',
    `supplier_contact_id` BIGINT COMMENT 'Identifier of the primary supplier contact responsible for responding to this corrective action request.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier to whom this corrective action request is issued.',
    `affected_lot_batch_number` STRING COMMENT 'Lot or batch number of the affected material or product.',
    `affected_material_code` STRING COMMENT 'Material or part number affected by the issue requiring corrective action.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or units affected by the issue.',
    `approval_date` DATE COMMENT 'Date when the corrective action closure was approved.',
    `attachment_document_ids` STRING COMMENT 'Comma-separated list of document identifiers for supporting evidence, photos, test reports, or supplier response documents.',
    `closure_date` DATE COMMENT 'Date when the corrective action request was formally closed after successful verification.',
    `completion_date` DATE COMMENT 'Actual date when the permanent corrective action was completed by the supplier.',
    `containment_action` STRING COMMENT 'Immediate containment action taken by the supplier to prevent further impact while permanent corrective action is developed.',
    `containment_action_date` DATE COMMENT 'Date when the containment action was implemented.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action request workflow.. Valid values are `open|in_progress|pending_verification|verified|closed|rejected`',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the issue including scrap, rework, downtime, and expediting costs.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system.',
    `due_date` DATE COMMENT 'Target date by which the permanent corrective action must be completed.',
    `escalation_date` DATE COMMENT 'Date when the corrective action was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this corrective action has been escalated to senior management due to severity or lack of supplier response.',
    `issue_date` DATE COMMENT 'Date when the corrective action request was issued to the supplier.',
    `issue_description` STRING COMMENT 'Detailed description of the quality escape, delivery failure, audit finding, or process non-conformance that triggered the corrective action.',
    `issue_type` STRING COMMENT 'Classification of the issue that triggered the corrective action request.. Valid values are `quality_escape|delivery_failure|audit_finding|process_nonconformance|material_defect|documentation_issue`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was last modified.',
    `permanent_corrective_action` STRING COMMENT 'Permanent corrective action implemented by the supplier to address the root cause and prevent recurrence.',
    `preventive_action` STRING COMMENT 'Preventive action taken by the supplier to eliminate potential causes of similar issues in the future.',
    `preventive_action_completion_date` DATE COMMENT 'Actual date when the preventive action was completed by the supplier.',
    `preventive_action_due_date` DATE COMMENT 'Target date by which the preventive action must be completed.',
    `previous_scar_number` STRING COMMENT 'Reference to a previous SCAR number if this is a recurrence of a prior issue.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this issue is a recurrence of a previously identified problem with the same supplier.',
    `related_ncr_number` STRING COMMENT 'Reference number of the related internal non-conformance report that triggered this supplier corrective action.',
    `related_purchase_order_number` STRING COMMENT 'Purchase order number associated with the affected material or delivery.',
    `related_rma_number` STRING COMMENT 'RMA number if the issue resulted in material being returned to the supplier.',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used for root cause analysis such as 8D, 5-Why, Ishikawa fishbone diagram, or FMEA.. Valid values are `8D|5_why|ishikawa|fmea|other`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause of the issue.',
    `scar_number` STRING COMMENT 'Externally-known unique business identifier for the supplier corrective action request.. Valid values are `^SCAR-[0-9]{6,10}$`',
    `severity_level` STRING COMMENT 'Severity classification of the issue requiring corrective action.. Valid values are `critical|major|minor|observation`',
    `supplier_response_comments` STRING COMMENT 'Comments or explanation provided by the supplier in response to the corrective action request.',
    `supplier_response_date` DATE COMMENT 'Date when the supplier formally responded to the corrective action request.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the affected quantity.',
    `verification_comments` STRING COMMENT 'Additional comments or observations from the verification activity.',
    `verification_date` DATE COMMENT 'Date when the corrective action effectiveness was verified.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective and preventive actions.. Valid values are `on_site_audit|document_review|sample_inspection|process_validation|performance_monitoring|other`',
    `verification_result` STRING COMMENT 'Result of the verification activity indicating whether the corrective action was effective.. Valid values are `effective|ineffective|partially_effective|pending`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Supplier Corrective Action Request (SCAR) issued to a vendor in response to a quality escape, delivery failure, audit finding, or process non-conformance. Captures SCAR number, issue type, severity, root cause analysis method (8D, 5-Why, Ishikawa), root cause description, containment action, permanent corrective action, preventive action, due dates, verification method, and closure status. Distinct from internal CAPA — this is the supplier-facing corrective action workflow.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` (
    `supplier_onboarding_id` BIGINT COMMENT 'Unique identifier for the supplier onboarding record. Primary key for tracking the end-to-end onboarding workflow from initial registration through final approval.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Onboarding includes compliance checks against specific regulations; linking records which regulation is being evaluated for each new supplier.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being onboarded. Links to the supplier master record once created or updated during the onboarding process.',
    `actual_completion_date` DATE COMMENT 'Actual date when the onboarding process was completed (approved or rejected). Used to calculate actual cycle time.',
    `approver_name` STRING COMMENT 'Full name of the authorized person who granted final approval for the supplier onboarding.',
    `approver_role` STRING COMMENT 'Job title or role of the final approver. Approval authority varies by estimated spend and risk level.',
    `blocking_issue_description` STRING COMMENT 'Detailed description of any blocking issues, missing documents, compliance gaps, or other obstacles preventing onboarding completion.',
    `blocking_issue_flag` BOOLEAN COMMENT 'Indicates whether there are currently blocking issues preventing onboarding progress. True if issues exist, false otherwise.',
    `blocking_issue_owner` STRING COMMENT 'Name or role of the person or team responsible for resolving the current blocking issue.',
    `business_justification` STRING COMMENT 'Detailed explanation of the business need for onboarding this supplier. Includes strategic rationale, sourcing requirements, and expected benefits.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or context relevant to the onboarding process.',
    `commodity_category` STRING COMMENT 'Primary commodity or product category for which the supplier is being onboarded. Aligns with procurement category taxonomy.',
    `company_code` STRING COMMENT 'SAP company code for which the supplier is being set up. Determines financial accounting and payment processing entity.',
    `compliance_check_status` STRING COMMENT 'Status of regulatory and policy compliance verification including sanctions screening, anti-corruption checks, and environmental/social compliance.. Valid values are `not_started|in_progress|passed|failed|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the onboarding record was first created in the data platform. Used for audit trail and data lineage.',
    `cycle_time_days` STRING COMMENT 'Total number of calendar days from request date to actual completion date. Key performance indicator (KPI) for onboarding efficiency.',
    `document_collection_completed_date` DATE COMMENT 'Date when all required documents (certificates, insurance, tax forms, bank details) were received and validated.',
    `estimated_annual_spend` DECIMAL(18,2) COMMENT 'Projected annual purchase value with this supplier. Used to prioritize onboarding resources and determine approval authority levels.',
    `final_approval_date` DATE COMMENT 'Date when the supplier onboarding was granted final approval and the supplier became active for purchasing.',
    `financial_review_completed_date` DATE COMMENT 'Date when finance department completed credit assessment, payment terms setup, and financial risk evaluation.',
    `incoterms` STRING COMMENT 'Three-letter Incoterms code defining delivery terms, risk transfer point, and cost responsibilities. Examples: EXW, FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `it_setup_completed_date` DATE COMMENT 'Date when IT department completed system configuration, vendor master creation in ERP (Enterprise Resource Planning), and EDI (Electronic Data Interchange) or portal access setup.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the onboarding record was last updated. Tracks the most recent change to any field in the record.',
    `legal_review_completed_date` DATE COMMENT 'Date when legal department completed contract review, terms negotiation, and compliance verification.',
    `onboarding_status` STRING COMMENT 'Current overall status of the onboarding workflow. Reflects the aggregate state across all stages from registration through final approval. [ENUM-REF-CANDIDATE: draft|submitted|in_progress|on_hold|approved|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding request: new vendor (first-time supplier), new site (existing supplier adding location), new commodity (existing supplier expanding product categories), vendor reactivation (previously inactive supplier), or vendor update (major profile changes requiring re-approval).. Valid values are `new_vendor|new_site|new_commodity|vendor_reactivation|vendor_update`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code negotiated during onboarding. Defines payment due dates, early payment discounts, and late payment penalties.',
    `priority_level` STRING COMMENT 'Business priority assigned to this onboarding request. Critical for production-critical suppliers, high for strategic suppliers, medium for standard suppliers, low for non-urgent requests.. Valid values are `critical|high|medium|low`',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization code for which the supplier is being onboarded. Determines procurement scope and approval workflows.',
    `qualification_review_completed_date` DATE COMMENT 'Date when procurement and quality teams completed technical and operational qualification assessment.',
    `quality_audit_completed_date` DATE COMMENT 'Date when the required quality audit was completed. Null if no audit is required or if audit is pending.',
    `quality_audit_required_flag` BOOLEAN COMMENT 'Indicates whether an on-site or remote quality audit is required before final approval. True for high-risk or critical suppliers.',
    `quality_audit_result` STRING COMMENT 'Outcome of the quality audit. Passed allows immediate approval, passed with conditions requires corrective actions, failed blocks onboarding.. Valid values are `passed|passed_with_conditions|failed|not_applicable`',
    `registration_completed_date` DATE COMMENT 'Date when the supplier completed initial registration and profile setup in the supplier portal.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the onboarding request was rejected. Includes compliance failures, financial concerns, or strategic misalignment.',
    `request_date` DATE COMMENT 'Date when the onboarding request was initiated. Marks the start of the onboarding cycle time measurement.',
    `request_number` STRING COMMENT 'Business identifier for the onboarding request. Externally visible tracking number used across procurement, legal, and finance teams.',
    `requestor_department` STRING COMMENT 'Department or business unit of the requestor. Provides context for the business need driving the onboarding.',
    `requestor_email` STRING COMMENT 'Email address of the employee who initiated the onboarding request. Used for workflow notifications and status updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the employee who initiated the supplier onboarding request. Typically a procurement specialist, category manager, or plant buyer.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for this supplier based on financial stability, geographic location, commodity criticality, and compliance factors.. Valid values are `low|medium|high|critical`',
    `spend_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated annual spend amount.. Valid values are `^[A-Z]{3}$`',
    `target_completion_date` DATE COMMENT 'Planned date for completing the entire onboarding process. Used to track onboarding cycle time performance against targets.',
    `vendor_master_number` STRING COMMENT 'Unique vendor identifier assigned in SAP S/4HANA upon successful onboarding. Links the onboarding record to the operational vendor master.',
    `workflow_stage` STRING COMMENT 'Current stage in the onboarding workflow sequence: registration, document collection, qualification review, legal review, financial review, IT system setup, or final approval. Provides granular visibility into onboarding progress.',
    CONSTRAINT pk_supplier_onboarding PRIMARY KEY(`supplier_onboarding_id`)
) COMMENT 'Tracks the end-to-end supplier onboarding workflow from initial registration through final approval in SAP Ariba and SAP S/4HANA. Captures onboarding request date, requestor, onboarding type (new vendor, new site, new commodity), workflow stage (registration, document collection, qualification, legal review, financial review, IT setup, final approval), stage completion dates, blocking issues, and overall onboarding status. Provides visibility into onboarding cycle time and bottlenecks.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` (
    `tooling_asset_id` BIGINT COMMENT 'Unique identifier for the tooling asset record. Primary key for the tooling asset entity.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Tool ownership tracking ties each tooling asset to the owning customer account for warranty, service, and cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the manufacturing engineer responsible for managing and tracking the tooling asset.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier at whose site the tooling asset is physically located.',
    `site_id` BIGINT COMMENT 'Identifier of the specific supplier site location where the tooling asset is physically located.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the tooling asset at the time of procurement.',
    `acquisition_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'Date when the tooling asset was originally acquired or purchased by the manufacturing organization.',
    `asset_category` STRING COMMENT 'Financial or operational classification category for the tooling asset used for reporting and analysis purposes. [ENUM-REF-CANDIDATE: production_tooling|quality_tooling|prototype_tooling|maintenance_tooling|special_tooling|standard_tooling|custom_tooling — promote to reference product]',
    `asset_tag_number` STRING COMMENT 'Physical identification tag or barcode number affixed to the tooling asset for tracking and inventory purposes.',
    `book_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the current book value amount.. Valid values are `^[A-Z]{3}$`',
    `condition_status` STRING COMMENT 'Physical condition assessment of the tooling asset based on inspection and usage history.. Valid values are `good|fair|worn|requires_repair|requires_maintenance|scrapped`',
    `cost_center` STRING COMMENT 'Financial cost center code to which the tooling asset expenses and depreciation are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the tooling asset record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business criticality assessment of the tooling asset based on its impact to production continuity and revenue.. Valid values are `critical|high|medium|low`',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current accounting book value of the tooling asset after depreciation and impairment adjustments.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation expense for the tooling asset over its useful life.. Valid values are `straight_line|declining_balance|units_of_production|none`',
    `expected_return_date` DATE COMMENT 'Planned or scheduled date for the tooling asset to be returned from the supplier site to manufacturing ownership.',
    `inspection_frequency_months` STRING COMMENT 'Required frequency in months between scheduled inspections of the tooling asset.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage protecting the tooling asset against loss or damage.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicator whether the tooling asset requires insurance coverage due to its value or criticality.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or condition assessment of the tooling asset.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or repair activity performed on the tooling asset.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who most recently modified the tooling asset record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the tooling asset record was most recently updated or modified.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured or fabricated the tooling asset.',
    `material_number` STRING COMMENT 'Identifier of the specific part or material produced using this tooling asset.',
    `model_number` STRING COMMENT 'Manufacturer model or part number designation for the tooling asset.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection or condition assessment of the tooling asset.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or historical information about the tooling asset.',
    `ownership_confirmation_flag` BOOLEAN COMMENT 'Indicator whether ownership of the tooling asset has been formally confirmed and documented with the supplier.',
    `ownership_status` STRING COMMENT 'Legal ownership classification of the tooling asset indicating which party holds title and responsibility.. Valid values are `manufacturing_owned|supplier_owned|consignment|leased|disputed`',
    `placement_date` DATE COMMENT 'Date when the tooling asset was physically placed at the current supplier site location.',
    `rated_cycle_capacity` BIGINT COMMENT 'Maximum number of production cycles or shots the tooling asset is designed to perform before requiring major refurbishment or replacement.',
    `recovery_priority` STRING COMMENT 'Priority level assigned for recovery or retrieval of the tooling asset during supplier transitions or disqualifications.. Valid values are `immediate|high|medium|low|deferred`',
    `remaining_cycle_capacity` BIGINT COMMENT 'Estimated number of production cycles remaining before the tooling asset reaches its rated capacity limit.',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag attached to the tooling asset for automated tracking and location monitoring.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying the physical tooling asset unit.',
    `tool_description` STRING COMMENT 'Detailed textual description of the tooling asset including specifications, dimensions, and functional characteristics.',
    `tool_location_description` STRING COMMENT 'Detailed description of the physical location of the tooling asset within the supplier site including building, area, or cell designation.',
    `tool_number` STRING COMMENT 'Unique business identifier assigned to the tooling asset for tracking and reference purposes.',
    `tool_status` STRING COMMENT 'Current lifecycle status of the tooling asset indicating its availability and operational state.. Valid values are `active|inactive|retired|scrapped|in_transit`',
    `tool_type` STRING COMMENT 'Classification of the tooling asset by its functional purpose in the manufacturing process. [ENUM-REF-CANDIDATE: die|fixture|gauge|mold|jig|cutting_tool|forming_tool|inspection_tool — 8 candidates stripped; promote to reference product]',
    `total_production_cycles` BIGINT COMMENT 'Cumulative count of production cycles or shots the tooling asset has completed since acquisition.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the tooling asset in years for depreciation calculation purposes.',
    CONSTRAINT pk_tooling_asset PRIMARY KEY(`tooling_asset_id`)
) COMMENT 'Tracks Manufacturing-owned tooling, dies, fixtures, and gauges that are physically located at a suppliers site and used for production of Manufacturing-specific parts. Captures tool number, tool type (die, fixture, gauge, mold), description, material number produced, tool location (vendor site), acquisition cost, book value, condition (good, worn, requires repair, scrapped), last inspection date, and ownership confirmation status. Critical for asset recovery during supplier transitions and disqualifications.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` (
    `change_notification_id` BIGINT COMMENT 'Unique identifier for the supplier change notification record. Primary key.',
    `component_id` BIGINT COMMENT 'add column engineering_component_id (BIGINT) with FK to engineering.component.component_id - supplier change notifications affect specific components in the BOM',
    `material_master_id` BIGINT COMMENT 'add column inventory_material_master_id (BIGINT) with FK to inventory.material_master.material_master_id - supplier PCNs reference specific materials being changed',
    `employee_id` BIGINT COMMENT 'Employee identifier of the Manufacturing approver.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory‑driven change notifications must reference the governing regulation to assess impact on supplier contracts.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier initiating the change notification.',
    `affected_part_count` STRING COMMENT 'Number of distinct Manufacturing part numbers affected by this change notification.',
    `affected_part_numbers` STRING COMMENT 'Comma-separated or structured list of Manufacturing part numbers (SKUs) impacted by this change.',
    `approval_date` DATE COMMENT 'Date when Manufacturing made the final approval or rejection decision on the change notification.',
    `approval_decision` STRING COMMENT 'Manufacturings final decision on the supplier change notification: approved (change accepted), rejected (change denied), conditional (approved with requirements), pending (decision not yet made).. Valid values are `approved|rejected|conditional|pending`',
    `approver_name` STRING COMMENT 'Name of the Manufacturing employee or manager who approved or rejected the change notification.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether an on-site supplier audit is required to verify the change implementation.',
    `change_description` STRING COMMENT 'Detailed description of the change being notified, including what is changing, why, and the scope of impact.',
    `change_reason` STRING COMMENT 'Business justification or rationale provided by the supplier for the change (e.g., cost reduction, obsolescence, quality improvement, regulatory compliance).',
    `comments` STRING COMMENT 'Additional notes, comments, or observations related to this change notification from Manufacturing or supplier.',
    `commodity_category` STRING COMMENT 'Commodity or material category affected by this change (e.g., electronics, mechanical components, raw materials, packaging).',
    `conditional_approval_requirements` STRING COMMENT 'Specific conditions or requirements that must be met for a conditionally approved change (e.g., re-qualification testing, PPAP re-submission, phased implementation).',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether the change has potential impact on product cost or pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notification record was first created in the system.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether Manufacturing must notify its customers about this supplier change due to contractual obligations or regulatory requirements.',
    `document_reference` STRING COMMENT 'Reference to supporting documentation provided by the supplier (e.g., technical drawings, test reports, certificates, PPAP package).',
    `effective_date` DATE COMMENT 'Planned or actual date when the supplier intends to implement the change in production.',
    `impact_assessment_date` DATE COMMENT 'Date when Manufacturing completed the impact assessment for this change notification.',
    `impact_assessment_status` STRING COMMENT 'Status of Manufacturings internal impact assessment process to evaluate the effect of the supplier change on products, quality, cost, and supply chain.. Valid values are `not_started|in_progress|completed|not_required`',
    `impact_level` STRING COMMENT 'Assessed severity of impact on Manufacturings products, operations, or customers: critical (major impact requiring immediate action), high (significant impact), medium (moderate impact), low (minor impact), none (no material impact).. Valid values are `critical|high|medium|low|none`',
    `implementation_date` DATE COMMENT 'Actual date when the supplier implemented the change in production.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this change notification record was last updated.',
    `manufacturing_contact_name` STRING COMMENT 'Name of the Manufacturing employee responsible for managing this change notification (e.g., commodity manager, quality engineer).',
    `notification_date` DATE COMMENT 'Date when the supplier formally submitted the change notification to Manufacturing.',
    `notification_number` STRING COMMENT 'Business identifier for the supplier change notification, typically assigned by the supplier or Manufacturings change management system.',
    `notification_status` STRING COMMENT 'Current lifecycle status of the change notification: submitted (received from supplier), under_review (Manufacturing reviewing), impact_assessment (evaluating impact), approved (change accepted), rejected (change denied), conditionally_approved (approved with conditions), implemented (change executed). [ENUM-REF-CANDIDATE: submitted|under_review|impact_assessment|approved|rejected|conditionally_approved|implemented — 7 candidates stripped; promote to reference product]',
    `notification_type` STRING COMMENT 'Category of change being notified: material change (raw material or component substitution), process change (manufacturing process modification), sub-supplier change (tier-2 supplier change), site relocation (manufacturing location move), end-of-life (product discontinuation), specification_change (product spec update), design_change (engineering design modification), tooling_change (tooling or equipment change). [ENUM-REF-CANDIDATE: material_change|process_change|sub_supplier_change|site_relocation|end_of_life|specification_change|design_change|tooling_change — 8 candidates stripped; promote to reference product]',
    `ppap_level_required` STRING COMMENT 'PPAP submission level required for re-qualification (1-5), where higher levels require more comprehensive documentation.',
    `ppap_resubmission_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier must re-submit PPAP documentation due to this change.',
    `priority` STRING COMMENT 'Priority level for reviewing and responding to this change notification based on urgency and business impact.. Valid values are `urgent|high|normal|low`',
    `quality_impact_flag` BOOLEAN COMMENT 'Indicates whether the change has potential impact on product quality, performance, or reliability.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the change affects regulatory compliance, certifications, or safety approvals (e.g., UL, CE, ISO).',
    `rejection_reason` STRING COMMENT 'Explanation provided by Manufacturing for rejecting the supplier change notification.',
    `related_eco_number` STRING COMMENT 'Reference to Manufacturings internal ECO or ECN number if this supplier change triggers an internal engineering change.',
    `related_ncr_number` STRING COMMENT 'Reference to any NCR that prompted or is related to this supplier change notification.',
    `requalification_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier must undergo re-qualification or re-approval process due to this change.',
    `requested_effective_date` DATE COMMENT 'Original effective date requested by the supplier, may differ from final approved effective date.',
    `response_due_date` DATE COMMENT 'Date by which Manufacturing must provide a response or decision to the supplier on the change notification.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this change based on impact assessment, supplier history, and change complexity.. Valid values are `critical|high|medium|low`',
    `schedule_impact_flag` BOOLEAN COMMENT 'Indicates whether the change has potential impact on delivery schedules or lead times.',
    `supplier_contact_email` STRING COMMENT 'Email address of the supplier contact for this change notification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `supplier_contact_name` STRING COMMENT 'Name of the supplier representative who submitted or is responsible for this change notification.',
    `testing_required_flag` BOOLEAN COMMENT 'Indicates whether Manufacturing requires additional testing or validation of parts produced after the change.',
    `verification_date` DATE COMMENT 'Date when Manufacturing verified that the supplier change was implemented correctly and meets requirements.',
    CONSTRAINT pk_change_notification PRIMARY KEY(`change_notification_id`)
) COMMENT 'Tracks supplier-initiated change notifications (SCNs) where a vendor formally notifies Manufacturing of planned changes to materials, processes, sub-suppliers, manufacturing locations, or product specifications. Captures notification type (material change, process change, sub-supplier change, site relocation, end-of-life), notification date, effective date, affected part numbers, impact assessment status, Manufacturing approval decision, and required re-qualification actions. Aligned with ECN/ECO processes and PPAP re-submission requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the supplier agreement record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Agreement linked to cost center for budgeting of contracted spend (Supplier Agreement Cost Tracking).',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Supplier agreements are signed per customer account; needed for contract compliance, billing, and KPI reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the agreement for activation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Agreement defines GL account for expense posting (Contractual GL mapping).',
    `master_agreement_id` BIGINT COMMENT 'Self-referencing FK on agreement (master_agreement_id)',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Supplier agreements embed clauses tied to specific regulations; FK enables contract‑compliance mapping for legal review.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) that is party to the agreement.',
    `agreement_number` STRING COMMENT 'External business identifier or contract number assigned to the agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|active|expired|terminated|pending|suspended`',
    `agreement_type` STRING COMMENT 'Classification of the agreement (e.g., framework, quality, NDA, long‑term agreement, consignment, tooling loan).. Valid values are `framework|quality|nda|lta|consignment|tooling_loan`',
    `amendment_date` DATE COMMENT 'Date on which the amendment became effective.',
    `amendment_description` STRING COMMENT 'Narrative description of changes introduced by the amendment.',
    `amendment_number` STRING COMMENT 'Identifier of the specific amendment applied to the base agreement.',
    `approval_date` DATE COMMENT 'Date on which the agreement received formal approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry.',
    `auto_renewal_term_months` STRING COMMENT 'Length of each renewal period in months when auto‑renewal is enabled.',
    `commodity_scope` STRING COMMENT 'List or description of product categories, parts, or services covered by the agreement.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is included in the agreement.',
    `contractual_term_months` STRING COMMENT 'Original length of the agreement in months, excluding renewals.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary terms.. Valid values are `^[A-Z]{3}$`',
    `discount_terms` STRING COMMENT 'Conditions under which discounts apply (e.g., volume rebates, early‑pay discounts).',
    `effective_end_date` DATE COMMENT 'Date on which the agreement expires or terminates (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the agreement becomes legally binding.',
    `esg_compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes ESG (environmental, social, governance) compliance requirements.',
    `governing_law` STRING COMMENT 'Jurisdiction whose law governs the agreement.',
    `ip_protection_clause_flag` BOOLEAN COMMENT 'Indicates whether intellectual‑property protection terms are present.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction applicable to the agreement.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the agreement terms.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled review of the agreement.',
    `payment_terms` STRING COMMENT 'Standard payment conditions (e.g., net 30, milestone‑based) defined in the agreement.',
    `performance_kpi_summary` STRING COMMENT 'Key performance indicators and targets defined in the agreement (e.g., OEE, delivery reliability).',
    `price_index` STRING COMMENT 'Reference to any price index or formula used to adjust pricing over time.',
    `quality_expectations_summary` STRING COMMENT 'High‑level description of quality standards and metrics required from the supplier.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that a renewal notice must be issued.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the agreement.',
    `total_value` DECIMAL(18,2) COMMENT 'Maximum monetary value covered by the agreement, expressed in the specified currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the agreement record.',
    `version_number` STRING COMMENT 'Sequential version of the agreement document (incremented on each amendment).',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for supplier-level framework agreements, quality agreements, NDAs, long-term supply agreements (LTAs), and consignment agreements that govern the overall commercial and quality relationship between Manufacturing and a vendor. Distinct from individual purchase orders (owned by procurement) — this captures the umbrella contractual instruments that set terms, pricing frameworks, IP protections, and quality expectations across multiple POs. Captures agreement type (framework, quality, NDA, LTA, consignment, tooling loan), effective date, expiry date, auto-renewal terms, governing law, key commercial terms summary, associated commodity scope, and agreement status (draft, active, expired, terminated).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ADD CONSTRAINT `fk_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ADD CONSTRAINT `fk_supplier_supplier_contact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_previous_finding_supplier_audit_finding_id` FOREIGN KEY (`previous_finding_supplier_audit_finding_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding`(`supplier_audit_finding_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ADD CONSTRAINT `fk_supplier_risk_rating_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_supplier_contact_id` FOREIGN KEY (`supplier_contact_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_contact`(`supplier_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_scorecard_id` FOREIGN KEY (`scorecard_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`scorecard`(`scorecard_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_supplier_contact_id` FOREIGN KEY (`supplier_contact_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_contact`(`supplier_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ADD CONSTRAINT `fk_supplier_supplier_onboarding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ADD CONSTRAINT `fk_supplier_tooling_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ADD CONSTRAINT `fk_supplier_tooling_asset_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ADD CONSTRAINT `fk_supplier_change_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`supplier` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`supplier` SET TAGS ('dbx_domain' = 'supplier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'OEM|distributor|raw_material|MRO|subcontractor|service_provider');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS (Data Universal Numbering System) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `iso14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `iso45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `last_scorecard_date` SET TAGS ('dbx_business_glossary_term' = 'Last Scorecard Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Business');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `overall_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Scorecard Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|not_qualified|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Master Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `small_business` SET TAGS ('dbx_business_glossary_term' = 'Small Business');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Business');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `approved_for_new_business` SET TAGS ('dbx_business_glossary_term' = 'Approved for New Business');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `delivery_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|asia_pacific|middle_east|africa');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `iatf_16949_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `production_capacity_annual` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity Annual');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_qualification|disqualified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing|distribution|warehouse|service_center|r_and_d|office');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `certification_held` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications Held');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|portal|fax');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'commercial|technical|quality|logistics|executive|after_sales');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|escalation|technical_support|billing');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `interaction_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Interaction Frequency in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Location');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `relationship_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `specialization_area` SET TAGS ('dbx_business_glossary_term' = 'Contact Specialization Area');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approving Engineer Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `tertiary_qualification_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `tertiary_qualification_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `tertiary_qualification_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `affected_commodities` SET TAGS ('dbx_business_glossary_term' = 'Affected Commodities');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Qualification Basis');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `conditional_approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `conditional_approval_reason` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `evaluation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `evaluation_team` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Team');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `part_family` SET TAGS ('dbx_business_glossary_term' = 'Part Family');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `ppap_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^QF-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'prospective|under_evaluation|approved|conditional|disqualified|expired');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_supplier|re_qualification|commodity_extension|disqualification|conditional_approval');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `re_qualification_conditions` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `re_qualification_eligible` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ALTER COLUMN `transition_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Transition Plan Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `primary_scorecard_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `primary_scorecard_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `primary_scorecard_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `capa_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `cost_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `improvement_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Improvement Actions Required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `ppm_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Parts Per Million (PPM) Defect Rate');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `previous_rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Rating Tier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `previous_rating_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|development|probation|disqualified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Rating Tier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `rating_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|development|probation|disqualified');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_index` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Index');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Weight Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `rma_count` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|in-review|approved|published|archived');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `total_line_items_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Line Items Evaluated');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `total_receipts_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Receipts Evaluated');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ALTER COLUMN `weaknesses_summary` SET TAGS ('dbx_business_glossary_term' = 'Weaknesses Summary');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|document_review');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|report_pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `auditor_comments` SET TAGS ('dbx_business_glossary_term' = 'Auditor Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_post_audit` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Post-Audit');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_post_audit` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_pre_audit` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Pre-Audit');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_pre_audit` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_response` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Finding ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `previous_finding_supplier_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Clause Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Objective Evidence Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|overdue');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'non_conformance|observation|opportunity_for_improvement|positive_finding');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area Affected');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_response` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_response_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verification_scheduled|verified_effective|verified_ineffective|verification_pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `alert_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Days');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_observations|failed|conditional|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|surveillance|recertification|special|transfer');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Business Criticality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certified_processes` SET TAGS ('dbx_business_glossary_term' = 'Certified Processes');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `certified_products` SET TAGS ('dbx_business_glossary_term' = 'Certified Products');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `gated_commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Gated Commodity Categories');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `major_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Major Non-Conformance Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `minor_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Non-Conformance Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `procurement_gate_enabled` SET TAGS ('dbx_business_glossary_term' = 'Procurement Gate Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_overdue');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `scope_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Scope of Certification');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|certifying_body_confirmation|on_site_inspection|third_party_verification|supplier_declaration');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'quantitative_model|qualitative_review|third_party_feed|hybrid');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|expired|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `capacity_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `certification_gap_count` SET TAGS ('dbx_business_glossary_term' = 'Certification Gap Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `conflict_minerals_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `country_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Country Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `cybersecurity_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `cybersecurity_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `dnb_rating` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (D&B) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `ecovadis_score` SET TAGS ('dbx_business_glossary_term' = 'EcoVadis Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_assessed');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `esg_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `financial_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `geopolitical_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Geopolitical Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `iec_62443_maturity_level` SET TAGS ('dbx_business_glossary_term' = 'IEC 62443 Maturity Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `iec_62443_maturity_level` SET TAGS ('dbx_value_regex' = 'level_0|level_1|level_2|level_3|level_4|not_assessed');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `key_risk_drivers` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Drivers');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `lead_time_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Volatility Index');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `operational_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `overall_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Tier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `overall_risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `ppm_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Parts Per Million (PPM) Defect Rate');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `quality_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `sanctions_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `annual_spend_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Target');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `annual_spend_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_value_regex' = '^AVL-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'active|suspended|phased_out|pending_approval|expired|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|limited|unlimited');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `certification_list` SET TAGS ('dbx_business_glossary_term' = 'Certification List');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `cost_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `expedited_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expedited Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `geographic_supply_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Supply Region');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `geographic_supply_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `part_family` SET TAGS ('dbx_business_glossary_term' = 'Part Family');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `ppap_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_designation` SET TAGS ('dbx_business_glossary_term' = 'Supplier Designation');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_designation` SET TAGS ('dbx_value_regex' = 'preferred|approved|backup|conditional|strategic');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `supply_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ALTER COLUMN `supply_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` SET TAGS ('dbx_subdomain' = 'corrective_development');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `primary_assigned_development_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assigned Development Engineer Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `primary_assigned_development_engineer_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Audit ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Scorecard ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'performance_improvement_plan|capability_development|quality_remediation|scar|preventive_action|cost_reduction_initiative');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `actual_kpi_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Key Performance Indicator (KPI) Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `baseline_kpi_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Key Performance Indicator (KPI) Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `closure_outcome` SET TAGS ('dbx_business_glossary_term' = 'Closure Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `closure_outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|cancelled|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `containment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `estimated_savings` SET TAGS ('dbx_business_glossary_term' = 'Estimated Savings');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `estimated_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'quality_escape|delivery_failure|audit_finding|process_non_conformance|cost_overrun|capability_gap');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `kpi_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `permanent_corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Permanent Corrective Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|verification_pending|closed_effective|closed_ineffective|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `preventive_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `scar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Corrective Action Request (SCAR) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `target_kpi_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Key Performance Indicator (KPI) Metric');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `target_kpi_value` SET TAGS ('dbx_business_glossary_term' = 'Target Key Performance Indicator (KPI) Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'on_site_audit|document_review|performance_data_analysis|sample_inspection|process_observation|supplier_self_assessment');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` SET TAGS ('dbx_subdomain' = 'corrective_development');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `primary_corrective_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `primary_corrective_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `primary_corrective_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `affected_lot_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot or Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `affected_material_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `attachment_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Attachment Document IDs');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `containment_action_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'quality_escape|delivery_failure|audit_finding|process_nonconformance|material_defect|documentation_issue');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `permanent_corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Permanent Corrective Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `preventive_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `preventive_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `previous_scar_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Supplier Corrective Action Request (SCAR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `related_ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `related_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Related Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `related_rma_number` SET TAGS ('dbx_business_glossary_term' = 'Related Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '8D|5_why|ishikawa|fmea|other');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `scar_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Corrective Action Request (SCAR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `scar_number` SET TAGS ('dbx_value_regex' = '^SCAR-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `supplier_response_comments` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `supplier_response_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_comments` SET TAGS ('dbx_business_glossary_term' = 'Verification Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'on_site_audit|document_review|sample_inspection|process_validation|performance_monitoring|other');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` SET TAGS ('dbx_subdomain' = 'corrective_development');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `supplier_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `blocking_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `blocking_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `blocking_issue_owner` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Owner');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `document_collection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Document Collection Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `estimated_annual_spend` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Spend');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `estimated_annual_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `financial_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `it_setup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Setup Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_vendor|new_site|new_commodity|vendor_reactivation|vendor_update');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `qualification_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Review Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `quality_audit_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `quality_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `quality_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Result');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `quality_audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_conditions|failed|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `registration_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `requestor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `vendor_master_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Master Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tooling_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Tooling Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `book_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Book Value Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `book_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'good|fair|worn|requires_repair|requires_maintenance|scrapped');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Months');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `ownership_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Ownership Confirmation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'manufacturing_owned|supplier_owned|consignment|leased|disputed');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `placement_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `rated_cycle_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Cycle Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `recovery_priority` SET TAGS ('dbx_business_glossary_term' = 'Recovery Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `recovery_priority` SET TAGS ('dbx_value_regex' = 'immediate|high|medium|low|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `remaining_cycle_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Cycle Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_description` SET TAGS ('dbx_business_glossary_term' = 'Tool Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_location_description` SET TAGS ('dbx_business_glossary_term' = 'Tool Location Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_status` SET TAGS ('dbx_business_glossary_term' = 'Tool Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|scrapped|in_transit');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `tool_type` SET TAGS ('dbx_business_glossary_term' = 'Tool Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `total_production_cycles` SET TAGS ('dbx_business_glossary_term' = 'Total Production Cycles');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` SET TAGS ('dbx_subdomain' = 'corrective_development');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Change Notification (SCN) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `affected_part_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Part Count');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `affected_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Part Numbers');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Approval Decision');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional|pending');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `conditional_approval_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Change Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `impact_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `impact_level` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Level');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Change Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `manufacturing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `manufacturing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `manufacturing_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Change Notification (SCN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `ppap_level_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level Required');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `ppap_resubmission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Re-Submission Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `quality_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `related_eco_number` SET TAGS ('dbx_business_glossary_term' = 'Related Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `related_ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `requested_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Change Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Testing Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Change Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Agreement Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `master_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Id');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `master_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|pending|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'framework|quality|nda|lta|consignment|tooling_loan');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `auto_renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Term (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Commodity Scope');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `contractual_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contractual Term (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `discount_terms` SET TAGS ('dbx_business_glossary_term' = 'Discount Terms');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `esg_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `ip_protection_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'IP Protection Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `performance_kpi_summary` SET TAGS ('dbx_business_glossary_term' = 'Performance KPI Summary');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `price_index` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `quality_expectations_summary` SET TAGS ('dbx_business_glossary_term' = 'Quality Expectations Summary');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Agreement Value');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
