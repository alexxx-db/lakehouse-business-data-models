-- Schema for Domain: spa | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`spa` COMMENT 'Spa, wellness, and recreation operations management including treatment catalogs, therapist scheduling, guest appointments, retail product sales, facility management, and revenue tracking for spa, fitness, golf, and pool amenities across luxury and resort properties.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` (
    `treatment_id` BIGINT COMMENT 'Unique identifier for the spa treatment. Primary key for the treatment master catalog.',
    `content_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.content_asset. Business justification: Individual treatments are promoted through content assets (treatment videos, photos, descriptions, brochures). Links treatment inventory to marketing content, enables content performance tracking, and',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Treatments may be brand-signature offerings (Ritz-Carlton signature treatments, Mandarin Oriental therapies). Links treatment inventory to brand identity, supports brand differentiation, and enables b',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Spa treatments consume retail products (massage oils, lotions, linens) tracked in material master. Essential for COGS calculation, inventory planning, and treatment profitability analysis in spa opera',
    `parent_treatment_id` BIGINT COMMENT 'Self-referencing FK on treatment (parent_treatment_id)',
    `advance_booking_required_hours` STRING COMMENT 'Minimum number of hours advance notice required to book this treatment. Used for scheduling rules and guest communication.',
    `age_restriction` STRING COMMENT 'Minimum age requirement or age-related restrictions for this treatment (e.g., 18+, 16+ with parental consent). Used for compliance and liability management.',
    `cancellation_policy_hours` STRING COMMENT 'Number of hours before the appointment that a guest can cancel without penalty. Used for revenue protection and scheduling optimization.',
    `treatment_category` STRING COMMENT 'Primary classification of the spa treatment type. Used for menu organization, revenue reporting, and therapist skill matching.. Valid values are `massage|facial|body_treatment|hydrotherapy|nail_service|beauty_service`',
    `treatment_code` STRING COMMENT 'Unique alphanumeric business identifier for the treatment used across all properties and systems. This is the externally-known catalog code used in PMS, POS, and booking systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether therapists or spa staff earn commission on sales of this treatment. Used for payroll and incentive compensation calculations.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to therapists or staff on sales of this treatment. Used for payroll processing and labor cost analysis.',
    `contraindications` STRING COMMENT 'Medical conditions, allergies, or circumstances under which the treatment should not be performed or requires physician approval. Critical for guest safety and liability management.',
    `cost_of_goods` DECIMAL(18,2) COMMENT 'Standard cost of consumable products, oils, lotions, and supplies used in delivering this treatment. Used for margin analysis and profitability reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment record was first created in the master catalog system. Used for audit trail and data lineage.',
    `treatment_description` STRING COMMENT 'Detailed narrative description of the treatment including techniques, benefits, and guest experience. Used in spa menus, websites, and booking confirmations.',
    `duration_minutes` STRING COMMENT 'Standard duration of the treatment in minutes, used for scheduling, therapist allocation, and capacity planning.',
    `effective_end_date` DATE COMMENT 'Date when this treatment is no longer available for new bookings. Null indicates no planned end date. Supports seasonal offerings and menu rotation.',
    `effective_start_date` DATE COMMENT 'Date when this treatment becomes available for booking and display in guest-facing systems. Supports seasonal launches and menu updates.',
    `gender_preference` STRING COMMENT 'Indicates whether the treatment is designed for specific gender or can be offered to any guest. Used for marketing segmentation and therapist assignment.. Valid values are `any|male_only|female_only|couples`',
    `gratuity_included_flag` BOOLEAN COMMENT 'Indicates whether gratuity is included in the treatment price or added separately. Used for pricing transparency and billing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment record was last updated. Used for change tracking and data synchronization across systems.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points a guest earns when purchasing this treatment. Used for loyalty program integration and guest engagement.',
    `minimum_certification` STRING COMMENT 'Minimum professional certification, license, or credential required to perform this treatment (e.g., Licensed Massage Therapist, Esthetician License, Cosmetology License).',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this treatment record. Used for audit trail and accountability.',
    `treatment_name` STRING COMMENT 'Full marketing name of the spa treatment as displayed to guests in menus, booking systems, and promotional materials.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this treatment can be included in spa packages or bundled offerings. Used for package configuration and revenue management.',
    `pregnancy_safe_flag` BOOLEAN COMMENT 'Indicates whether this treatment is safe for pregnant guests. Critical for guest safety screening and liability management.',
    `recommended_retail_price` DECIMAL(18,2) COMMENT 'Corporate-recommended retail price for this treatment in the base currency. Individual properties may adjust based on local market conditions and positioning.',
    `required_equipment` STRING COMMENT 'List of specialized equipment, tools, or facilities required to deliver this treatment (e.g., hydrotherapy tub, vichy shower, hot stone warmer, facial steamer).',
    `retail_products_used` STRING COMMENT 'List of retail product SKUs or product lines used during the treatment. Supports cross-sell opportunities and inventory planning.',
    `revenue_center` STRING COMMENT 'Revenue center to which this treatment is assigned for financial reporting and GOP (Gross Operating Profit) analysis per USALI standards.. Valid values are `spa|wellness|fitness|salon|recreation`',
    `room_type_required` STRING COMMENT 'Type of treatment room or facility required to deliver this service (e.g., single room, couples suite, wet room, outdoor cabana). Used for facility scheduling and capacity planning.',
    `seasonal_availability` STRING COMMENT 'Indicates specific seasons or months when this treatment is available (e.g., summer only for outdoor treatments, winter for specific wellness programs).',
    `skill_level_required` STRING COMMENT 'Minimum skill level classification required for a therapist to perform this treatment. Used for therapist assignment and training planning.. Valid values are `entry|intermediate|advanced|master`',
    `subcategory` STRING COMMENT 'Secondary classification providing more granular segmentation within the primary category (e.g., Swedish Massage, Deep Tissue, Hot Stone within Massage category).',
    `treatment_status` STRING COMMENT 'Current lifecycle status of the treatment in the master catalog. Controls availability for booking and display in guest-facing systems.. Valid values are `active|inactive|seasonal|discontinued`',
    `upsell_treatments` STRING COMMENT 'List of complementary treatment codes that can be recommended as add-ons or follow-up services. Supports revenue optimization and guest experience enhancement.',
    CONSTRAINT pk_treatment PRIMARY KEY(`treatment_id`)
) COMMENT 'Master catalog of all spa and wellness treatments offered across properties, including massages, facials, body wraps, hydrotherapy, and beauty services. Captures treatment name, treatment code, category (massage, facial, body, nail, fitness), duration in minutes, treatment description, contraindications, required equipment, skill level required, minimum therapist certification, recommended retail price, cost of goods, revenue center classification, and active status. This is the SSOT for spa treatment definitions across the portfolio.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` (
    `treatment_menu_id` BIGINT COMMENT 'Unique identifier for the property-level spa treatment menu. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Treatment menus are often launched or promoted through specific marketing campaigns (new menu launches, seasonal menu promotions). Tracks which campaigns drive menu awareness and bookings, essential f',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Treatment menus are brand-specific (Ritz-Carlton Spa vs. Westin Heavenly Spa vs. Six Senses Spa). Essential for brand-specific menu management, brand standards enforcement, and supporting brand differ',
    `employee_id` BIGINT COMMENT 'Reference to the user (spa manager, revenue manager, or property director) who approved this treatment menu for publication.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where this treatment menu is offered.',
    `superseded_treatment_menu_id` BIGINT COMMENT 'Self-referencing FK on treatment_menu (superseded_treatment_menu_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu was approved for publication and operational use.',
    `booking_channel_availability` STRING COMMENT 'Comma-separated list of channels where this menu is available for booking (e.g., web,mobile,front_desk,concierge,spa_reception).',
    `cancellation_policy_code` STRING COMMENT 'Reference code to the cancellation policy applicable to treatments booked from this menu (e.g., hours notice required, penalty fees).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing on this treatment menu (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `display_sequence` STRING COMMENT 'Numeric ordering value controlling the presentation sequence of this menu in guest-facing channels and staff systems.',
    `effective_end_date` DATE COMMENT 'Date when this treatment menu expires or is no longer available for guest bookings. Null indicates an open-ended menu.',
    `effective_start_date` DATE COMMENT 'Date when this treatment menu becomes active and available for guest bookings at the property.',
    `gift_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu can be purchased or redeemed using spa gift certificates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu record was last updated.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu are eligible for loyalty program points accrual or redemption.',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that guests can book treatments from this menu to manage inventory and demand.',
    `menu_brochure_url` STRING COMMENT 'URL to the downloadable PDF brochure or detailed menu document for guest reference and marketing distribution.. Valid values are `^https?://.*.pdf$`',
    `menu_code` STRING COMMENT 'Business identifier code for the treatment menu, used for operational reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `menu_description` STRING COMMENT 'Detailed narrative description of the treatment menu, its theme, philosophy, and guest experience positioning for marketing and operational use.',
    `menu_image_url` STRING COMMENT 'URL to the primary marketing image or hero image representing this treatment menu in digital channels.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `menu_name` STRING COMMENT 'Display name of the treatment menu as presented to guests and staff (e.g., Summer Wellness Collection, Signature Spa Experience).',
    `menu_type` STRING COMMENT 'Classification of the treatment menu by its thematic focus or service model (signature, express, seasonal, couples, wellness, therapeutic, luxury). [ENUM-REF-CANDIDATE: signature|express|seasonal|couples|wellness|therapeutic|luxury — 7 candidates stripped; promote to reference product]',
    `menu_version` STRING COMMENT 'Version number of the treatment menu to track revisions and updates over time (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `minimum_advance_booking_hours` STRING COMMENT 'Minimum number of hours in advance that guests must book treatments from this menu to allow for preparation and scheduling.',
    `notes` STRING COMMENT 'Free-form operational notes or comments about this treatment menu for internal staff reference (e.g., special instructions, seasonal considerations, marketing campaigns).',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book treatments from this menu through online self-service channels (web, mobile app).',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu can be bundled into spa packages or multi-treatment offerings.',
    `pricing_override_flag` BOOLEAN COMMENT 'Indicates whether this property-level menu applies custom pricing that overrides the master catalog treatment prices.',
    `published_date` DATE COMMENT 'Date when the treatment menu was officially published and made available to guests.',
    `published_status` STRING COMMENT 'Current publication state of the treatment menu indicating whether it is visible to guests and available for booking.. Valid values are `draft|published|archived|suspended|under_review`',
    `season_type` STRING COMMENT 'Seasonal classification indicating when this menu is active (peak, off-peak, shoulder, holiday, year-round) to support dynamic pricing and availability.. Valid values are `peak|off_peak|shoulder|holiday|year_round`',
    `target_guest_segment` STRING COMMENT 'Primary guest demographic or psychographic segment this menu is designed for (e.g., wellness seekers, luxury travelers, couples, business travelers).',
    CONSTRAINT pk_treatment_menu PRIMARY KEY(`treatment_menu_id`)
) COMMENT 'Property-level spa treatment menu defining which treatments from the master catalog are offered at a specific property during a defined period. Captures property reference, menu name, menu version, effective date range, season (peak, off-peak, holiday), menu type (signature, express, seasonal, couples), published status, and pricing overrides at the property level. Enables property-specific menu curation while maintaining a global treatment catalog.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` (
    `therapist_id` BIGINT COMMENT 'Unique identifier for the spa therapist. Primary key for the therapist master record.',
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Therapists must complete mandatory training (CPR, massage therapy renewals, safety protocols, sanitation) tracked for regulatory compliance, licensing audits, and insurance requirements. Direct link t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Therapists are assigned to cost centers for labor cost tracking, payroll allocation, and departmental budgeting. Required for spa labor cost analysis, productivity metrics (revenue per therapist hour)',
    `employee_id` BIGINT COMMENT 'Reference to the employee master record in the workforce domain. Links therapist to their employment record for payroll, benefits, and HR management.',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Therapists may be involved in workplace injuries (repetitive strain, slip/fall) or guest incidents. Operations track therapist-incident relationship for workers compensation, safety training needs, an',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Therapists belong to organizational units (spa department/team) for cost center allocation, labor reporting, scheduling pool management, and management hierarchy. Required for USALI labor cost reporti',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Therapists occupy formal positions with job codes, pay grades, FLSA classification, and USALI department codes. Critical for labor budgeting, headcount planning, compensation administration, union eli',
    `property_id` BIGINT COMMENT 'Home property where the therapist is primarily assigned. Links to the property master for location-based scheduling and revenue allocation.',
    `supervisor_therapist_id` BIGINT COMMENT 'Self-referencing FK on therapist (supervisor_therapist_id)',
    `availability_schedule` STRING COMMENT 'Standard weekly availability pattern for the therapist (e.g., days of week, shift preferences). Used for automated scheduling and shift planning.',
    `certification_level` STRING COMMENT 'Professional certification or skill level of the therapist within the spas internal competency framework. Determines service eligibility, pricing tier, and training pathway.. Valid values are `entry|intermediate|advanced|master|director`',
    `therapist_code` STRING COMMENT 'Unique alphanumeric code assigned to the therapist for scheduling, Point of Sale (POS) transactions, and operational reporting. Used in spa management systems and guest-facing booking interfaces.. Valid values are `^[A-Z0-9]{4,12}$`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of service revenue paid to the therapist as commission. Used for incentive compensation calculations and revenue sharing models.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapist record was first created in the system. Used for audit trail and data lineage tracking.',
    `email_address` STRING COMMENT 'Primary email address for the therapist. Used for schedule notifications, training communications, and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Classification of the therapists employment relationship with the property. Determines scheduling rules, benefit eligibility, and commission structures.. Valid values are `full-time|part-time|contractor|seasonal|on-call`',
    `first_name` STRING COMMENT 'Legal first name of the therapist as recorded in employment records. Used for guest communication, scheduling displays, and service attribution.',
    `gender` STRING COMMENT 'Gender identity of the therapist. Used to honor guest preferences for therapist gender during booking and to ensure compliance with cultural and religious accommodation requirements.. Valid values are `male|female|non-binary|prefer not to say`',
    `guest_rating_average` DECIMAL(18,2) COMMENT 'Average guest satisfaction rating for the therapist across all completed appointments, typically on a 1-5 scale. Used for performance management, guest matching, and service quality monitoring.',
    `hire_date` DATE COMMENT 'Date the therapist was hired or contracted by the property. Used for seniority calculations, anniversary recognition, and tenure-based benefits.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Base hourly compensation rate for the therapist. Used for payroll calculations, labor cost analysis, and service pricing models. Excludes commissions and tips.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the therapist can communicate in fluently. Used to match therapists with international guests and enhance guest experience through native-language service.',
    `last_name` STRING COMMENT 'Legal last name of the therapist as recorded in employment records. Used for guest communication, scheduling displays, and service attribution.',
    `last_training_date` DATE COMMENT 'Date of the most recent training or continuing education session completed by the therapist. Used to track compliance with professional development requirements and certification renewal.',
    `max_appointments_per_day` STRING COMMENT 'Maximum number of treatment appointments the therapist can perform in a single day. Used for scheduling optimization and therapist wellness management to prevent burnout.',
    `next_certification_due_date` DATE COMMENT 'Date by which the therapist must complete their next certification renewal or continuing education requirement. Used for proactive compliance management and training scheduling.',
    `notes` STRING COMMENT 'Free-text field for operational notes about the therapist, including special accommodations, scheduling preferences, performance observations, or guest feedback themes. Used by spa management for personalized workforce management.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the therapist. Used for emergency contact, shift change notifications, and operational communication.',
    `preferred_name` STRING COMMENT 'Name the therapist prefers to use in guest-facing interactions and on spa schedules. May differ from legal name for cultural, personal, or professional branding reasons.',
    `primary_license_expiry_date` DATE COMMENT 'Expiration date of the therapists primary professional license. Monitored for compliance; therapists cannot perform services after expiry without renewal.',
    `primary_license_number` STRING COMMENT 'State or national professional license number for massage therapy, esthetics, or other regulated spa services. Required for regulatory compliance and insurance coverage.',
    `primary_license_state` STRING COMMENT 'Two-letter state code where the primary professional license was issued. Used to verify jurisdiction-specific compliance and reciprocity eligibility.. Valid values are `^[A-Z]{2}$`',
    `secondary_license_expiry_date` DATE COMMENT 'Expiration date of the therapists secondary professional license. Monitored for compliance in multi-license scenarios.',
    `secondary_license_number` STRING COMMENT 'Additional professional license number for therapists certified in multiple disciplines (e.g., both massage therapy and esthetics) or holding licenses in multiple states.',
    `secondary_license_state` STRING COMMENT 'Two-letter state code where the secondary professional license was issued. Supports multi-state operations and cross-property assignments.. Valid values are `^[A-Z]{2}$`',
    `specializations` STRING COMMENT 'Comma-separated list of treatment modalities and techniques the therapist is certified to perform (e.g., Swedish massage, deep tissue, hot stone, Ayurvedic, reflexology, aromatherapy, prenatal, sports massage, esthetics, body wraps). Used for service matching and guest preference fulfillment.',
    `termination_date` DATE COMMENT 'Date the therapists employment or contract ended. Null for active therapists. Used for historical reporting and rehire eligibility assessment.',
    `therapist_status` STRING COMMENT 'Current operational status of the therapist. Active therapists are available for scheduling; inactive, on-leave, suspended, or terminated therapists are excluded from guest-facing booking systems.. Valid values are `active|inactive|on-leave|suspended|terminated`',
    `tip_eligible_flag` BOOLEAN COMMENT 'Indicates whether the therapist is eligible to receive gratuities from guests. Varies by employment type and local labor regulations.',
    `total_appointments_completed` STRING COMMENT 'Cumulative count of all spa appointments completed by the therapist since hire date. Used for productivity tracking, milestone recognition, and experience validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapist record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional experience as a spa therapist, including prior employment at other properties or spas. Used for skill-based pricing, guest matching, and training program placement.',
    CONSTRAINT pk_therapist PRIMARY KEY(`therapist_id`)
) COMMENT 'Spa and wellness therapist master record representing individual practitioners employed or contracted at a property. Captures therapist name, employee reference, therapist code, specializations (Swedish, deep tissue, hot stone, Ayurvedic, esthetics), certification levels, license numbers, license expiry dates, years of experience, languages spoken, gender preference availability, employment type (full-time, part-time, contractor), home property, and active status. Distinct from workforce.employee as it captures spa-specific professional credentials and treatment competencies.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` (
    `spa_therapist_certification_id` BIGINT COMMENT 'Unique identifier for the therapist certification record. Primary key.',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - therapist certifications are tracked at property level for licensing audits.',
    `renewed_spa_therapist_certification_id` BIGINT COMMENT 'Self-referencing FK on spa_therapist_certification (renewed_spa_therapist_certification_id)',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist who holds this certification. Links to the therapist master record.',
    `certification_document_url` STRING COMMENT 'The storage location or URL of the scanned certification document or digital credential. Enables audit trail and verification support.',
    `certification_level` STRING COMMENT 'The proficiency level or tier of the certification. Used to match therapist expertise to guest service expectations and premium treatment offerings.. Valid values are `entry|intermediate|advanced|master|instructor`',
    `certification_name` STRING COMMENT 'The full name or title of the certification as issued by the certifying body (e.g., Licensed Massage Therapist, Certified Esthetician, Brand Signature Massage Specialist).',
    `certification_number` STRING COMMENT 'The unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_type` STRING COMMENT 'The category of certification held by the therapist. Distinguishes between state-mandated licenses, brand-specific training certifications, and safety certifications required for spa operations. [ENUM-REF-CANDIDATE: state_massage_license|esthetics_license|cosmetology_license|brand_certification|specialty_certification|cpr_certification|first_aid_certification — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'The number of continuing education hours the therapist has completed toward the current renewal cycle. Enables proactive management of renewal readiness.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'The number of continuing education hours required for renewal of this certification. Used to track therapist compliance with professional development requirements.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred to obtain or renew this certification, including exam fees, training fees, and application fees. Used for workforce development budgeting and ROI analysis.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the certification cost. Supports multi-currency operations for global property portfolios.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Audit trail field.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and the therapist is authorized to perform services under this credential. May differ from issue date for pre-dated certifications.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Null for certifications with no expiration. Critical for compliance tracking and renewal scheduling.',
    `instructor_name` STRING COMMENT 'The name of the instructor or trainer who conducted the certification training. Relevant for brand certifications and internal training programs.',
    `is_brand_required` BOOLEAN COMMENT 'Indicates whether this certification is mandated by brand service standards for therapists to perform certain treatments. Used to enforce brand compliance.',
    `is_primary_certification` BOOLEAN COMMENT 'Indicates whether this is the therapists primary professional certification. Used to identify the main credential under which the therapist practices.',
    `is_state_required` BOOLEAN COMMENT 'Indicates whether this certification is required by state or local regulatory authorities for the therapist to legally practice. Critical for compliance and risk management.',
    `issue_date` DATE COMMENT 'The date the certification was originally issued to the therapist. Used to calculate tenure and experience levels.',
    `issuing_body` STRING COMMENT 'The name of the organization, state board, or institution that issued the certification (e.g., California Board of Barbering and Cosmetology, American Red Cross, Brand Training Academy).',
    `issuing_jurisdiction` STRING COMMENT 'The state, province, or country where the certification was issued. Critical for multi-property operations to ensure therapists hold valid licenses for the jurisdictions where they practice.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the certification, such as special conditions, restrictions, or verification details. Supports operational context and audit trails.',
    `reimbursement_status` STRING COMMENT 'Indicates whether the certification cost was reimbursed by the employer. Used to track workforce development investments and employee benefit utilization.. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `renewal_date` DATE COMMENT 'The date the certification was last renewed. Tracks compliance with continuing education and renewal requirements.',
    `renewal_status` STRING COMMENT 'The current renewal state of the certification. Indicates whether the credential is active, approaching renewal, or has lapsed. Used to trigger renewal workflows and prevent scheduling of non-compliant therapists.. Valid values are `current|pending_renewal|expired|suspended|revoked|not_applicable`',
    `specialty_area` STRING COMMENT 'The specific treatment specialty or modality covered by this certification (e.g., Deep Tissue Massage, Hot Stone Therapy, Aromatherapy, Facial Treatments, Body Wraps). Enables matching therapist qualifications to guest service requests.',
    `training_completion_date` DATE COMMENT 'The date the therapist completed the training program associated with this certification. Relevant for brand certifications and specialty training.',
    `training_hours` DECIMAL(18,2) COMMENT 'The total number of training hours completed to earn this certification. Used to assess depth of qualification and compare against brand standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was last modified. Audit trail field for tracking changes to certification status, renewal, or verification.',
    `verification_date` DATE COMMENT 'The date the certification was last verified with the issuing authority. Used to track verification currency and schedule re-verification.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity of the certification with the issuing body.. Valid values are `online_registry|phone_verification|document_review|third_party_service|not_verified`',
    `verification_status` STRING COMMENT 'Indicates whether the certification has been independently verified with the issuing body. Critical for regulatory compliance and risk management.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    CONSTRAINT pk_spa_therapist_certification PRIMARY KEY(`spa_therapist_certification_id`)
) COMMENT 'Certification and qualification records for spa therapists tracking professional licenses, brand-mandated training completions, and specialty certifications. Captures therapist reference, certification type (state massage license, esthetics license, brand certification, CPR, first aid), issuing body, certification number, issue date, expiry date, renewal status, and verification status. Supports compliance with state licensing requirements and brand service standards.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` (
    `spa_facility_id` BIGINT COMMENT 'Unique identifier for the spa, wellness, or recreation facility. Primary key. Role: MASTER_RESOURCE.',
    `ada_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_assessment. Business justification: Spa facilities must comply with ADA accessibility requirements (treatment rooms, pools, locker rooms, entrances). Operations track current assessment for legal compliance, remediation planning, and gu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each spa facility operates as a cost center for expense allocation, budget management, and departmental P&L reporting. Essential for multi-facility spa operations, cost allocation, and USALI-compliant',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Major spa facility renovations and FF&E investments are capitalized as fixed assets for depreciation. Required for PIP (Property Improvement Plan) tracking, capital expenditure reporting, FF&E reserve',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Spa facilities require operational manager assignment for P&L accountability, labor scheduling oversight, vendor management, and guest escalation handling. Current facility_manager_name is denormalize',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Spa facilities are associated with specific brands (brand-specific spa concepts, branded wellness experiences). Critical for brand-level spa operations, brand standards compliance, and supporting bran',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Spa facilities are organizational units with cost centers, budgeted headcount, labor productivity standards, and USALI department classification. Required for financial consolidation, labor cost alloc',
    `parent_spa_facility_id` BIGINT COMMENT 'Self-referencing FK on spa_facility (parent_spa_facility_id)',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Spas require operating permits (health department, pool operation, massage establishment license). Operations track current permit for regulatory compliance, renewal management, and inspection schedul',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each spa facility may operate as a distinct profit center for owner reporting and segment performance analysis. Essential for multi-facility spa portfolio management, facility-level GOP reporting, and',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this facility is located.',
    `property_facility_id` BIGINT COMMENT '',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility accommodations available at the facility (e.g., wheelchair_accessible, hearing_loop, braille_signage, accessible_treatment_tables). Supports ADA compliance tracking.',
    `average_daily_visitors` STRING COMMENT 'Average number of unique guests visiting the facility per day, calculated over a rolling 90-day period. Used for capacity planning and staffing optimization.',
    `certification_accreditation` STRING COMMENT 'Comma-separated list of industry certifications, accreditations, or awards held by the facility (e.g., Forbes Five Star Spa, LEED Gold Certified, International Spa Association Member). Supports marketing and quality assurance.',
    `contact_email` STRING COMMENT 'Primary email address for facility reservations, guest inquiries, and operational communication. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for guest inquiries, reservations, and facility operations. Organizational contact data classified as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system. Supports audit trail and data lineage tracking.',
    `facility_code` STRING COMMENT 'Unique alphanumeric code identifying the facility within the property management system. Used for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `facility_name` STRING COMMENT 'Full business name of the spa, wellness, or recreation facility as presented to guests (e.g., Serenity Spa & Wellness Center, Championship Golf Course).',
    `facility_status` STRING COMMENT 'Current operational lifecycle status of the facility: active (open and operational), inactive (permanently closed), under_renovation (closed for Property Improvement Plan execution), temporarily_closed (short-term closure), seasonal (operates only during specific seasons).. Valid values are `active|inactive|under_renovation|temporarily_closed|seasonal`',
    `facility_type` STRING COMMENT 'Classification of the facility by primary service offering: spa (full-service spa with treatments), fitness_center (gym and exercise equipment), golf_course (golf amenity), pool (swimming pool and aquatic facilities), tennis_court (tennis and racquet sports), salon (hair and beauty salon).. Valid values are `spa|fitness_center|golf_course|pool|tennis_court|salon`',
    `fire_safety_compliance_date` DATE COMMENT 'Date of the most recent fire safety inspection and compliance certification. Required for local fire code adherence and insurance purposes.',
    `gender_designation` STRING COMMENT 'Gender access policy for the facility: co_ed (open to all genders), female_only (restricted to female guests), male_only (restricted to male guests), gender_neutral (inclusive non-binary policy).. Valid values are `co_ed|female_only|male_only|gender_neutral`',
    `guest_access_policy` STRING COMMENT 'Policy governing who may access the facility: hotel_guests_only (restricted to registered guests), members_only (membership or loyalty program required), public_access (open to general public), day_pass_available (non-guests may purchase day access).. Valid values are `hotel_guests_only|members_only|public_access|day_pass_available`',
    `health_safety_compliance_date` DATE COMMENT 'Date of the most recent health and safety inspection or compliance audit. Supports regulatory reporting and operational risk management.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or Property Improvement Plan (PIP) completion for the facility. Used for Furniture Fixtures and Equipment (FF&E) lifecycle tracking and capital expenditure (CapEx) planning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this facility record. Supports change tracking and data quality monitoring.',
    `locker_room_capacity` STRING COMMENT 'Total number of lockers available in changing and locker room facilities. Indicates maximum concurrent guest capacity for facility usage.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases and services at this facility are eligible for loyalty program points accrual. True if loyalty integration is active.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years required for guest access to the facility. Common values: 16 for spa facilities, 18 for adult-only wellness centers, 0 for family-friendly pools.',
    `next_scheduled_renovation_date` DATE COMMENT 'Planned date for the next major renovation or facility upgrade. Supports long-term capital planning and guest communication regarding temporary closures.',
    `operating_hours_friday` STRING COMMENT 'Facility operating hours on Friday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_monday` STRING COMMENT 'Facility operating hours on Monday in 24-hour format (HH:MM-HH:MM) or closed if not operational. Example: 06:00-22:00.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_saturday` STRING COMMENT 'Facility operating hours on Saturday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_sunday` STRING COMMENT 'Facility operating hours on Sunday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_thursday` STRING COMMENT 'Facility operating hours on Thursday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_tuesday` STRING COMMENT 'Facility operating hours on Tuesday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_wednesday` STRING COMMENT 'Facility operating hours on Wednesday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `outdoor_space_flag` BOOLEAN COMMENT 'Indicates whether the facility includes outdoor amenities or treatment areas (e.g., outdoor pools, rooftop yoga decks, garden relaxation areas). True if outdoor space exists.',
    `peak_season_months` STRING COMMENT 'Comma-separated list of month names or numbers representing peak demand periods for the facility (e.g., June,July,August or 6,7,8). Supports revenue management and staffing planning.',
    `relaxation_lounge_capacity` STRING COMMENT 'Maximum seating capacity in relaxation lounges and quiet areas where guests rest before or after treatments. Measured in number of seats.',
    `reservation_required_flag` BOOLEAN COMMENT 'Indicates whether advance reservations are required for facility access or services. True if reservations are mandatory, false if walk-ins are accepted.',
    `retail_area_flag` BOOLEAN COMMENT 'Indicates whether the facility includes a retail area for selling spa products, wellness merchandise, or branded goods. True if retail space exists.',
    `seasonal_close_date` DATE COMMENT 'Annual date when seasonal facility closes for the off-season. Null if facility operates year-round.',
    `seasonal_open_date` DATE COMMENT 'Annual date when seasonal facility opens for the operating season. Null if facility operates year-round.',
    `seasonal_operation_flag` BOOLEAN COMMENT 'Indicates whether the facility operates on a seasonal schedule (e.g., outdoor pools open only in summer, golf courses closed in winter). True if seasonal.',
    `square_footage` STRING COMMENT 'Total interior square footage of the facility. Used for space utilization analysis, renovation planning, and benchmarking against industry standards.',
    `total_treatment_rooms` STRING COMMENT 'Total number of individual treatment rooms available for spa services, massages, facials, and body treatments. Used for capacity planning and scheduling.',
    `wet_area_capacity` STRING COMMENT 'Maximum guest capacity for wet amenities including steam rooms, saunas, whirlpools, and hydrotherapy pools. Measured in number of guests.',
    CONSTRAINT pk_spa_facility PRIMARY KEY(`spa_facility_id`)
) COMMENT 'Master record for spa, fitness, golf, and pool facility assets at each property. Captures facility name, facility code, facility type (spa, fitness center, golf course, pool, tennis court, salon), property reference, total treatment rooms, wet area capacity, locker room capacity, relaxation lounge capacity, operating hours by day of week, gender designation (co-ed, female-only, male-only), accessibility features, renovation status, and active status. Complements property.facility with spa-specific operational attributes.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` (
    `treatment_room_id` BIGINT COMMENT 'Unique identifier for the treatment room. Primary key for the treatment room entity.',
    `adjoining_treatment_room_id` BIGINT COMMENT 'Self-referencing FK on treatment_room (adjoining_treatment_room_id)',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Spa treatment rooms follow specific cleaning protocols defined in hotel cleaning standards (sanitation requirements, turnaround time, chemical specifications, quality thresholds) for health code compl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Treatment rooms may function as sub-cost centers for detailed expense tracking and room-level profitability analysis. Required for spa space utilization analysis, room-level revenue per available hour',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Treatment room build-outs and specialized equipment installations are capitalized as fixed assets. Essential for leasehold improvement tracking, room-level asset depreciation, capital investment ROI a',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Incidents occur in specific treatment rooms (equipment malfunction, sanitation issue, structural hazard). Operations track room-incident relationship for maintenance prioritization, safety audits, and',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this treatment room operates. Enables property-level spa performance analysis and cross-property benchmarking.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the parent spa facility where this treatment room is located. Links room to its operating facility for capacity planning and revenue attribution.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the treatment room meets accessibility standards for guests with disabilities (wheelchair access, grab bars, adjustable equipment). Required for ADA compliance reporting.',
    `ambiance_features` STRING COMMENT 'Descriptive text listing special ambiance and sensory features of the treatment room (e.g., ocean view, fireplace, aromatherapy diffuser, Himalayan salt wall). Used for marketing and guest preference matching.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment room record was first created in the system. Used for data lineage and audit trail purposes.',
    `equipment_list` STRING COMMENT 'Comma-separated list of major equipment and fixtures installed in the treatment room (e.g., massage table, hydrotherapy tub, steam generator, chromotherapy system). Used for treatment compatibility verification and maintenance planning.',
    `ffe_value` DECIMAL(18,2) COMMENT 'Total capitalized value of furniture, fixtures, and equipment installed in the treatment room. Used for asset management, depreciation calculations, and insurance purposes.',
    `floor_number` STRING COMMENT 'Floor level where the treatment room is located within the spa facility. Used for guest navigation and accessibility planning.',
    `gender_designation` STRING COMMENT 'Gender access policy for the treatment room. Determines booking eligibility and guest assignment rules for culturally sensitive spa operations.. Valid values are `male|female|unisex|private`',
    `has_chromotherapy` BOOLEAN COMMENT 'Indicates whether the treatment room is equipped with chromotherapy (color therapy) lighting system. Premium feature for holistic wellness treatments.',
    `has_heated_table` BOOLEAN COMMENT 'Indicates whether the treatment room is equipped with a heated massage table. Premium amenity that affects treatment offerings and guest experience.',
    `has_music_system` BOOLEAN COMMENT 'Indicates whether the treatment room has an integrated audio system for ambient music and guided meditation. Enhances guest relaxation experience.',
    `has_outdoor_access` BOOLEAN COMMENT 'Indicates whether the treatment room has direct access to outdoor space (terrace, garden, or private patio). Premium feature for resort spa properties.',
    `has_private_shower` BOOLEAN COMMENT 'Indicates whether the treatment room includes an en-suite shower facility. Premium amenity that enables extended treatment packages and hydrotherapy services.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly rental or utilization rate for the treatment room used in internal cost allocation and revenue management calculations. Business-confidential pricing data.',
    `last_maintenance_date` DATE COMMENT 'Date when the treatment room last underwent scheduled maintenance or deep cleaning. Used for preventive maintenance scheduling and quality assurance.',
    `last_renovation_date` DATE COMMENT 'Date when the treatment room last underwent major renovation or refurbishment. Used for capital expenditure tracking and property improvement planning.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the treatment room. Determines availability for scheduling and triggers maintenance workflow processes.. Valid values are `operational|maintenance|repair|renovation|inspection`',
    `max_occupancy` STRING COMMENT 'Maximum number of guests that can be accommodated simultaneously in the treatment room. Critical for scheduling and safety compliance.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or inspection of the treatment room. Used for capacity planning and maintenance workflow management.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or unique characteristics of the treatment room not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational availability status of the treatment room. Controls whether the room appears in booking systems and capacity calculations.. Valid values are `active|inactive|seasonal|temporarily_closed`',
    `room_code` STRING COMMENT 'Short standardized code for the treatment room used in scheduling systems and operational reports (e.g., TR01, VIP-A, WET-3).',
    `room_name` STRING COMMENT 'Human-readable name of the treatment room used for guest communication and staff scheduling (e.g., Serenity Suite, Ocean View Room, Couples Retreat).',
    `room_number` STRING COMMENT 'Alphanumeric room number or code used for operational identification and wayfinding within the spa facility.',
    `room_type` STRING COMMENT 'Classification of the treatment room based on its design and intended use. Determines applicable treatments, pricing tier, and scheduling rules. [ENUM-REF-CANDIDATE: single|couples|vip_suite|wet_room|hydrotherapy|sauna|steam|relaxation_lounge — 8 candidates stripped; promote to reference product]',
    `sanitation_protocol` STRING COMMENT 'Level of sanitation and hygiene protocol applied to the treatment room. Determines cleaning frequency, products used, and turnaround time between appointments.. Valid values are `standard|enhanced|medical_grade`',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the treatment room measured in square feet. Used for capacity planning, pricing strategy, and facility benchmarking.',
    `temperature_control_type` STRING COMMENT 'Type of climate control system available in the treatment room. Affects guest comfort customization and energy management.. Valid values are `central_hvac|individual_thermostat|radiant_floor|none`',
    `turnaround_time_minutes` STRING COMMENT 'Standard time in minutes required to clean, sanitize, and prepare the treatment room between guest appointments. Critical for accurate scheduling and capacity optimization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment room record was last modified. Used for change tracking and data quality monitoring.',
    CONSTRAINT pk_treatment_room PRIMARY KEY(`treatment_room_id`)
) COMMENT 'Master record for individual treatment rooms and spaces within a spa facility. Captures room name, room number, room code, facility reference, room type (single, couples, VIP suite, wet room, hydrotherapy, sauna, steam), floor, square footage, equipment list, ambiance features (music system, chromotherapy, heated table), maximum occupancy, gender designation, maintenance status, and active status. Enables granular room-level scheduling and capacity management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Unique identifier for the spa appointment booking. Primary key for the appointment entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa appointments for corporate direct-bill accounts or group bookings generate AR invoices separate from individual guest folios. Essential for corporate billing, credit management, and revenue recogn',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Spa appointments are frequently driven by marketing campaigns (seasonal promotions, email offers, package campaigns). Essential for campaign ROI tracking, attribution analysis, and measuring marketing',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Appointments are frequently booked using specific offer codes from marketing campaigns (discount codes, promotional offers, package deals). Essential for offer redemption tracking, validation, discoun',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Treatment appointments generate revenue allocated to spa treatment cost centers for departmental reporting. Essential for USALI spa department schedules, treatment revenue analysis, and cost center bu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa appointments booked through OTA, GDS, or direct channels require channel attribution for commission accrual, revenue reconciliation, and channel ROI analysis. Essential for finance to calculate ch',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or staff member who created the appointment booking. Used for accountability and performance tracking. May be guest self-service identifier for online bookings.',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Post-spa-service satisfaction surveys are standard hospitality practice. Guest feedback systems track which specific appointment was rated to analyze service quality by treatment type, therapist, and ',
    `guest_interaction_id` BIGINT COMMENT 'Foreign key linking to experience.guest_interaction. Business justification: Pre-appointment consultations (treatment selection, health screening) and post-service follow-ups are logged guest interactions. Guest journey tracking systems link interactions to appointments for to',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Spa appointments should be analyzed by guest segment for personalization and targeting (wellness seekers, luxury travelers, local residents). Critical for segment performance analysis, treatment recom',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Spa treatments can result in guest injuries (burns, allergic reactions, slips) requiring formal incident reporting for liability, insurance claims, and regulatory compliance. Operations track which ap',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Treatment revenue posts to service revenue GL accounts for financial reporting and revenue recognition. Required for spa service revenue accounting, GL reconciliation, and ASC 606 revenue recognition ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa appointments for loyalty members should link to loyalty.member for proper points accrual tracking and member benefit validation. This FK enables real-time points calculation and member tier benefi',
    `package_id` BIGINT COMMENT 'Reference to a spa package or bundle if this appointment is part of a multi-treatment package booking. Nullable for standalone appointments.',
    `profile_id` BIGINT COMMENT 'FK to guest.profile.profile_id — MUST-HAVE: Spa appointments must link to guest profile for intake form pre-population, allergy alerts, preference recall, and folio posting. Core guest experience continuity requirement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Treatment revenue flows to spa profit center for GOP, EBITDA, and segment profitability reporting. Required for spa profit center performance measurement, management fee basis calculation, and owner f',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the spa appointment is scheduled. Links to property master data.',
    `rescheduled_appointment_id` BIGINT COMMENT 'Self-referencing FK on appointment (rescheduled_appointment_id)',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this spa appointment. Nullable for local guests or day spa visitors without hotel stays.',
    `reservation_group_block_id` BIGINT COMMENT 'Reference to a group booking record if this appointment is part of a group spa event (e.g., bridal party, corporate wellness). Nullable for individual bookings.',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist assigned to perform the treatment. Links to workforce/therapist master data. Nullable if therapist not yet assigned.',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service being booked (e.g., Swedish massage, facial, body wrap). Links to treatment catalog.',
    `treatment_room_id` BIGINT COMMENT 'Reference to the specific treatment room or facility space where the appointment will take place. Links to room inventory.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the spa treatment was completed. Captured at treatment conclusion. Nullable if appointment not yet completed.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the spa treatment began. Captured at check-in or treatment commencement. Nullable if appointment not yet started.',
    `appointment_date` DATE COMMENT 'The calendar date on which the spa appointment is scheduled to occur. Used for day-level scheduling and reporting.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the spa appointment. Tracks progression from initial booking through completion or cancellation. Critical for operational workflow and revenue recognition. [ENUM-REF-CANDIDATE: booked|confirmed|checked-in|in-progress|completed|cancelled|no-show — 7 candidates stripped; promote to reference product]',
    `arrival_time` TIMESTAMP COMMENT 'The actual date and time when the guest arrived at the spa facility for their appointment. Nullable if guest has not yet arrived. Used for punctuality tracking and operational efficiency.',
    `booking_channel` STRING COMMENT 'The channel or interface through which the guest made the spa appointment booking. Used for channel performance analysis and guest behavior insights. [ENUM-REF-CANDIDATE: front-desk|online|concierge|mobile-app|phone|in-room|walk-in — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was originally created in the system. Immutable audit field for booking lead time analysis and demand forecasting.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded explanation for why the appointment was cancelled. Nullable if appointment not cancelled. Used for operational analysis and service recovery.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was cancelled. Nullable if appointment not cancelled. Used for cancellation policy enforcement and revenue impact analysis.',
    `cancelled_by` STRING COMMENT 'Indicates which party initiated the cancellation: guest, property staff, automated system, or marked as no-show. Used for accountability and policy application.. Valid values are `guest|property|system|no-show`',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the guest was formally checked in for their spa appointment by front desk or spa reception. Nullable if not yet checked in. Distinct from arrival_time.',
    `confirmation_number` STRING COMMENT 'Externally-facing unique confirmation code provided to the guest for appointment reference and verification. Generated at booking time and used for guest communication.. Valid values are `^[A-Z0-9]{8,12}$`',
    `duration_minutes` STRING COMMENT 'The scheduled duration of the spa treatment in minutes. Derived from treatment catalog but stored for historical accuracy and schedule optimization.',
    `external_booking_reference` STRING COMMENT 'External reference number from third-party booking platforms or partner systems. Nullable for direct bookings. Used for reconciliation and partner integration.',
    `guest_gender_preference` STRING COMMENT 'The guests preference for therapist gender. Used for therapist assignment and guest satisfaction optimization.. Valid values are `male|female|no-preference`',
    `guest_notes` STRING COMMENT 'Internal staff notes about the guest or appointment. May include service preferences, behavioral observations, or operational notes. Confidential and not shared with guest.',
    `intake_form_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the guest has completed the required health and wellness intake form prior to treatment. Required for compliance and risk management.',
    `intake_form_completed_timestamp` TIMESTAMP COMMENT 'The date and time when the guest completed the intake form. Nullable if form not yet completed. Used for compliance tracking and operational readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment record was last updated. Used for change tracking and audit trail. Updated on any modification to appointment details.',
    `no_show_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest failed to appear for the scheduled appointment without prior cancellation. Used for no-show fee application and guest behavior tracking.',
    `prepayment_amount` DECIMAL(18,2) COMMENT 'The monetary amount prepaid by the guest at the time of booking, typically as a deposit or full payment. Used for revenue tracking and cancellation policy enforcement. Nullable if no prepayment required.',
    `prepayment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the prepayment amount. Required when prepayment_amount is populated. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `pressure_preference` STRING COMMENT 'The guests preferred massage pressure level for treatments involving massage. Captured during booking or intake to personalize treatment delivery.. Valid values are `light|medium|firm|extra-firm|no-preference`',
    `scheduled_end_time` TIMESTAMP COMMENT 'The planned date and time when the spa appointment is scheduled to end. Calculated based on treatment duration.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned date and time when the spa appointment is scheduled to begin. Includes time zone information for multi-property operations.',
    `special_health_notes` STRING COMMENT 'Free-text field capturing any health conditions, allergies, injuries, or medical considerations the guest disclosed that may affect treatment delivery. Critical for guest safety and liability management.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or preferences the guest communicated at booking time (e.g., room temperature, music preference, aromatherapy oils). Used to personalize guest experience.',
    `therapist_gender_preference` STRING COMMENT 'The guests stated preference for the gender of the therapist performing the treatment. Supports personalized service delivery.. Valid values are `male|female|no-preference`',
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'Core transactional record for a guest spa appointment booking. Captures appointment confirmation number, guest reference, reservation reference, property reference, treatment reference, therapist reference, treatment room reference, appointment date, scheduled start time, scheduled end time, actual start time, actual end time, appointment status (booked, confirmed, checked-in, in-progress, completed, cancelled, no-show), booking channel (front desk, online, concierge, mobile app), guest gender preference, therapist gender preference, pressure preference, special health notes, intake form completion status, pre-payment amount, and cancellation reason. This is the SSOT for spa appointment lifecycle management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` (
    `appointment_package_id` BIGINT COMMENT 'Unique identifier for the spa appointment package booking record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Reference to the parent spa appointment under which this package is booked.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Package bookings often result from targeted marketing campaigns. Critical for measuring campaign effectiveness on high-value spa packages, calculating campaign ROI, and understanding which promotional',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Package bookings often use promotional offer codes (package discounts, bundle offers, early booking discounts). Critical for tracking offer performance on high-value packages, measuring promotional ef',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa packages sold via distribution channels need channel tracking for commission calculation, rate parity monitoring, and package performance analysis. Critical for revenue management to assess channe',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who created this spa package booking on behalf of the guest. Null if guest self-booked.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa package bookings earn loyalty points and qualify for elite member package discounts. Essential for points accrual on package revenue, tier-based package pricing, and points redemption for spa pack',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.spa_package. Business justification: appointment_package represents a transactional booking of a spa package. Currently it stores denormalized package_code, package_name, and package_type strings. Adding spa_package_id FK to spa_package ',
    `parent_appointment_package_id` BIGINT COMMENT 'Self-referencing FK on appointment_package (parent_appointment_package_id)',
    `profile_id` BIGINT COMMENT 'Reference to the guest who booked this spa package.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa package is offered and redeemed.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Spa package bookings reference rate plans for pricing structure, restrictions (min LOS, advance purchase), and channel applicability. Business process: spa package pricing follows hotel rate plan meth',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Package bookings by hotel guests are posted to room folios. Finance and guest services require room linkage for charge posting, billing reconciliation, and checkout settlement in integrated resort ope',
    `addon_services_amount` DECIMAL(18,2) COMMENT 'Total amount charged for additional services added to the base package.',
    `booking_channel` STRING COMMENT 'Channel through which the spa package booking was made.. Valid values are `web|mobile app|phone|front desk|concierge|in-room tablet`',
    `booking_date` DATE COMMENT 'Date when the guest booked this spa package.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the spa package booking.. Valid values are `pending|confirmed|in-progress|completed|cancelled|no-show`',
    `booking_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spa package booking was created in the system.',
    `cancellation_deadline` TIMESTAMP COMMENT 'Date and time by which the guest must cancel to avoid penalties per the cancellation policy.',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation policy applicable to this spa package booking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancelling the spa package booking.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the spa package booking was cancelled. Null if not cancelled.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the spa package experience was fully completed.',
    `complimentary_amenities` STRING COMMENT 'Comma-separated list of complimentary amenities included with the package (e.g., robe, slippers, refreshments, locker access).',
    `confirmation_number` STRING COMMENT 'Guest-facing confirmation number for the spa package booking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this appointment package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this package booking.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the package booking (promotional, loyalty, or negotiated).',
    `guest_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the guest arrived at the spa facility to begin the package experience.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this spa package booking.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the guest to pay for or discount this spa package.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this appointment package record was last modified.',
    `package_duration_minutes` STRING COMMENT 'Total duration of the spa package in minutes, including all treatments and amenities.',
    `package_notes` STRING COMMENT 'Internal operational notes about the spa package booking for staff reference.',
    `package_price` DECIMAL(18,2) COMMENT 'Base price of the spa package before any add-ons, discounts, or taxes.',
    `payment_method` STRING COMMENT 'Payment instrument used to pay for the spa package. [ENUM-REF-CANDIDATE: credit card|debit card|room charge|loyalty points|gift certificate|cash|bank transfer — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current payment status of the spa package booking.. Valid values are `pending|authorized|paid|refunded|partially refunded|failed`',
    `redemption_status` STRING COMMENT 'Indicates whether the guest has started or completed using the treatments included in the package.. Valid values are `not started|partially redeemed|fully redeemed|expired`',
    `scheduled_end_date` DATE COMMENT 'Date when the spa package experience is scheduled to conclude. Nullable for single-day packages.',
    `scheduled_start_date` DATE COMMENT 'Date when the spa package experience is scheduled to begin.',
    `special_requests` STRING COMMENT 'Guest-provided special requests or preferences for the spa package experience (e.g., allergies, temperature preferences, therapist gender).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the spa package booking.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount charged for the spa package including base price, add-ons, discounts, and taxes.',
    `treatment_count` STRING COMMENT 'Number of individual spa treatments included in this package.',
    CONSTRAINT pk_appointment_package PRIMARY KEY(`appointment_package_id`)
) COMMENT 'Transactional record capturing spa package bookings where multiple treatments are bundled for a single guest visit or multi-day program. Captures package reference, appointment reference, guest reference, package name, package type (day spa, half-day, couples retreat, wellness journey, golf and spa), total package price, package duration, number of treatments included, add-on services, complimentary amenities (robe, slippers, refreshments), booking date, and redemption status. Supports spa package revenue tracking and guest experience management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the spa package. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Spa packages are frequently created as part of marketing campaigns (Valentines Day packages, summer wellness promotions, holiday specials). Links package inventory to promotional strategy, enabling c',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Spa packages are often brand-specific offerings (signature brand packages, brand-exclusive experiences). Links package inventory to brand positioning, supports brand differentiation, and enables brand',
    `parent_package_id` BIGINT COMMENT 'Self-referencing FK on package (parent_package_id)',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where this spa package is available. Links to property master data.',
    `age_restriction_minimum` STRING COMMENT 'Minimum age in years required for guests to book or participate in this package. Null if no age restriction applies.',
    `amenities_included` STRING COMMENT 'Description of facility amenities included with the package such as pool access, fitness center, relaxation lounge, or refreshments.',
    `cancellation_hours_notice` STRING COMMENT 'Number of hours notice required for cancellation without penalty. Industry standard ranges from 24 to 72 hours for spa packages.',
    `cancellation_policy_code` STRING COMMENT 'Code referencing the cancellation and modification policy applicable to this package. Defines refund rules and penalty structure.. Valid values are `^[A-Z0-9]{3,10}$`',
    `package_category` STRING COMMENT 'Thematic category of the spa package used for menu organization and guest preference matching.. Valid values are `relaxation|therapeutic|beauty|fitness|wellness|specialty`',
    `package_code` STRING COMMENT 'Unique business identifier code for the spa package used across systems and guest-facing materials. Typically alphanumeric format used in PMS and booking systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether bookings of this package through third-party channels are eligible for commission payments.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of package price paid as commission to booking agents or channels. Null if not commission-eligible.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spa package record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for package pricing. Supports multi-currency operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Fixed deposit amount required at booking if requires_deposit is true. Null if deposit is percentage-based or not required.',
    `deposit_percentage` DECIMAL(18,2) COMMENT 'Percentage of package price required as deposit at booking. Null if deposit is fixed amount or not required.',
    `package_description` STRING COMMENT 'Detailed description of the spa package including benefits, experience highlights, and guest expectations. Used in marketing collateral and booking confirmations.',
    `gender_restriction` STRING COMMENT 'Gender-based restriction for package booking. Used for gender-specific facilities or cultural requirements.. Valid values are `none|male_only|female_only|couples_only`',
    `guest_type_eligibility` STRING COMMENT 'Defines which guest segments are eligible to book this package. Supports targeted offerings and loyalty program benefits.. Valid values are `all|hotel_guest|day_guest|member|loyalty_tier`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the package is currently active and available for booking. Inactive packages are hidden from guest-facing channels.',
    `loyalty_points_eligible` BOOLEAN COMMENT 'Indicates whether this package purchase is eligible for loyalty program points accrual.',
    `loyalty_points_value` STRING COMMENT 'Number of loyalty points awarded for purchasing this package. Null if not eligible for points.',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that the package can be booked. Controls inventory release and revenue management.',
    `maximum_party_size` STRING COMMENT 'Maximum number of guests allowed in a single booking of this package. Constrained by facility capacity and therapist availability.',
    `minimum_advance_booking_hours` STRING COMMENT 'Minimum number of hours required between booking time and appointment time. Ensures adequate preparation and therapist scheduling.',
    `minimum_party_size` STRING COMMENT 'Minimum number of guests required to book this package. Typically used for couples or group packages.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the spa package record. Supports accountability and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the spa package record was last modified. Used for change tracking and data synchronization.',
    `package_name` STRING COMMENT 'Marketing name of the spa package displayed to guests and used in promotional materials.',
    `package_status` STRING COMMENT 'Current lifecycle status of the spa package. Controls visibility, bookability, and operational workflow.. Valid values are `active|inactive|seasonal|discontinued|pending_approval|archived`',
    `package_type` STRING COMMENT 'Classification of the spa package by format and target guest segment. Determines bundling rules and booking requirements.. Valid values are `day_spa|half_day|couples|wellness_program|golf_and_spa|resort_credit`',
    `promotional_rate` DECIMAL(18,2) COMMENT 'Discounted or promotional price for the spa package during specific campaigns or seasons. Null when no promotion is active.',
    `property_availability` STRING COMMENT 'Comma-separated list of property codes where this package is available. Supports multi-property package offerings.',
    `rack_rate` DECIMAL(18,2) COMMENT 'Standard published price for the spa package before any discounts or promotions. Equivalent to Best Available Rate (BAR) for spa services.',
    `requires_deposit` BOOLEAN COMMENT 'Indicates whether a deposit is required at time of booking to secure the package reservation.',
    `retail_products_included` STRING COMMENT 'List of retail product codes or descriptions included as part of the package. Supports spa retail integration and inventory management.',
    `service_charge_included` BOOLEAN COMMENT 'Indicates whether gratuity or service charge is included in the package price. Important for guest communication and revenue allocation.',
    `special_instructions` STRING COMMENT 'Operational notes and special instructions for spa staff regarding package delivery, setup requirements, or guest experience protocols.',
    `tax_inclusive` BOOLEAN COMMENT 'Indicates whether the package price includes applicable taxes or if taxes are added at checkout. Varies by jurisdiction.',
    `total_duration_minutes` STRING COMMENT 'Total duration of all included treatments and transitions in minutes. Used for scheduling and capacity planning.',
    `valid_from_date` DATE COMMENT 'Start date of the packages availability period. Package cannot be booked for dates before this.',
    `valid_to_date` DATE COMMENT 'End date of the packages availability period. Package cannot be booked for dates after this. Null indicates open-ended availability.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the spa package record. Supports accountability and audit requirements.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Master catalog of spa packages and wellness programs available for guest booking. Captures package name, package code, package type (day spa, half-day, couples, wellness program, golf and spa, resort credit), included treatments list, total duration, rack rate, promotional rate, validity period, property availability, minimum advance booking requirement, cancellation policy, and active status. Distinct from appointment_package which is the transactional instance of a package booking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` (
    `therapist_schedule_id` BIGINT COMMENT 'Unique identifier for the therapist schedule record. Primary key for the therapist schedule entity.',
    `original_therapist_schedule_id` BIGINT COMMENT 'Self-referencing FK on therapist_schedule (original_therapist_schedule_id)',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa facility is located. Links to the property master record.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the spa facility where the therapist is scheduled to work. Links to the spa facility master record.',
    `therapist_id` BIGINT COMMENT 'Reference to the therapist assigned to this schedule. Links to the therapist master record.',
    `actual_clock_in_time` TIMESTAMP COMMENT 'The actual timestamp when the therapist clocked in or checked in for their shift. Used for payroll processing, attendance tracking, and variance analysis against scheduled start time.',
    `actual_clock_out_time` TIMESTAMP COMMENT 'The actual timestamp when the therapist clocked out or checked out from their shift. Used for payroll processing, attendance tracking, and variance analysis against scheduled end time.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours the therapist worked during this shift, calculated from clock-in and clock-out times. Used for payroll processing and labor cost analysis.',
    `break_duration_minutes` STRING COMMENT 'The total duration of break periods in minutes during this shift. Used for labor compliance reporting and accurate calculation of available treatment hours.',
    `break_end_time` TIMESTAMP COMMENT 'The timestamp when the therapists scheduled break period ends. Used to resume appointment availability after the break period.',
    `break_start_time` TIMESTAMP COMMENT 'The timestamp when the therapists scheduled break period begins. Used to block out time when the therapist is not available for appointments and to ensure compliance with labor regulations.',
    `cancellation_reason` STRING COMMENT 'The reason why this schedule was cancelled, if applicable. May include illness, personal emergency, facility closure, or other operational reasons. Used for workforce analytics and schedule reliability improvement.',
    `cancelled_by` STRING COMMENT 'The user ID or system identifier of the person who cancelled this schedule. Used for audit trail and accountability in schedule changes.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule was cancelled. Used for audit trail and analysis of schedule change patterns.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'The timestamp when the therapist acknowledged and confirmed their availability for this scheduled shift. Used for attendance tracking and schedule reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this schedule record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule record was last modified. Used for audit trail, change tracking, and data freshness assessment.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether this shift qualifies for overtime compensation based on labor regulations and the therapists employment classification. True if overtime rules apply, false otherwise.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The number of hours worked during this shift that qualify as overtime. Used for payroll processing and labor cost management.',
    `primary_treatment_specialty` STRING COMMENT 'The primary type of spa treatment the therapist is scheduled to provide during this shift (e.g., massage, facial, body treatment, nail services). Used for matching therapist skills with guest appointment requests.',
    `published_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule was published and made visible to the therapist and spa operations team. Used for schedule communication tracking and labor compliance.',
    `room_assignment` STRING COMMENT 'The specific treatment room or station assigned to the therapist for this shift. Used for facility management and guest wayfinding.',
    `schedule_date` DATE COMMENT 'The calendar date for which this therapist schedule is defined. Used for daily scheduling and capacity planning.',
    `schedule_notes` STRING COMMENT 'Free-text notes or special instructions related to this schedule entry. May include information about special events, training sessions, equipment needs, or other operational details.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the therapist schedule. Draft schedules are being planned, published schedules are visible to staff, confirmed schedules are acknowledged by the therapist, cancelled schedules are voided, completed schedules have been worked, and no-show indicates the therapist did not report for the shift.. Valid values are `draft|published|confirmed|cancelled|completed|no_show`',
    `schedule_variance_minutes` STRING COMMENT 'The difference in minutes between scheduled hours and actual hours worked. Positive values indicate overtime, negative values indicate undertime. Used for schedule accuracy analysis and labor forecasting.',
    `scheduled_treatment_slots` STRING COMMENT 'The number of discrete treatment appointment slots scheduled during this shift. Used for capacity planning and appointment availability management.',
    `shift_end_time` TIMESTAMP COMMENT 'The timestamp when the therapists shift ends. Defines the end of the therapists availability window for appointments.',
    `shift_start_time` TIMESTAMP COMMENT 'The timestamp when the therapists shift begins. Defines the start of the therapists availability window for appointments.',
    `shift_type` STRING COMMENT 'Classification of the shift based on timing and operational role. Opening shifts cover early morning hours, mid shifts cover peak daytime hours, closing shifts cover evening hours, on-call shifts are for backup coverage, split shifts have a break in the middle, and double shifts cover extended hours.. Valid values are `opening|mid|closing|on_call|split|double`',
    `total_available_hours` DECIMAL(18,2) COMMENT 'The total number of hours the therapist is available for treatment appointments, excluding break periods and administrative time. Used for capacity planning and appointment scheduling.',
    `total_booked_hours` DECIMAL(18,2) COMMENT 'The total number of hours that have been booked with guest appointments during this shift. Used to calculate therapist utilization and identify available capacity.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'The total number of hours the therapist is scheduled to work during this shift, calculated as the difference between shift end time and shift start time minus break periods. Used for labor cost planning and compliance with labor regulations.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of available hours that have been booked with appointments, calculated as (total_booked_hours / total_available_hours) * 100. Key performance indicator (KPI) for spa productivity and revenue optimization.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this schedule record. Used for audit trail and accountability.',
    CONSTRAINT pk_therapist_schedule PRIMARY KEY(`therapist_schedule_id`)
) COMMENT 'Operational scheduling record defining therapist availability and shift assignments within the spa. Captures therapist reference, facility reference, schedule date, shift start time, shift end time, shift type (opening, mid, closing, on-call), scheduled treatment slots, break periods, total available hours, total booked hours, utilization percentage, schedule status (draft, published, confirmed), and last modified timestamp. Enables spa management to optimize therapist utilization and appointment capacity.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` (
    `intake_form_id` BIGINT COMMENT 'Unique identifier for the spa guest health intake and consultation form. Primary key.',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment for which this intake form was completed. Links to the spa appointment booking record.',
    `guest_interaction_id` BIGINT COMMENT 'Foreign key linking to experience.guest_interaction. Business justification: Intake form completion is a documented pre-service consultation touchpoint. Guest experience systems track intake as an interaction for journey mapping, guest effort scoring, and touchpoint optimizati',
    `prior_intake_form_id` BIGINT COMMENT 'Self-referencing FK on intake_form (prior_intake_form_id)',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Intake forms contain sensitive health data (medical conditions, medications, allergies). Data breaches require tracking for GDPR/HIPAA compliance, breach notification, and regulatory reporting. Operat',
    `profile_id` BIGINT COMMENT 'Reference to the guest completing this intake form. Links to the guest master record in the property management system.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa treatment will be provided. Links to the property master record.',
    `therapist_id` BIGINT COMMENT 'Reference to the therapist who reviewed and approved the intake form. Links to the therapist employee record.',
    `allergy_details` STRING COMMENT 'Free-text description of specific allergies disclosed by the guest, including product ingredients, essential oils, nuts, latex, or other substances. Essential for safe treatment delivery.',
    `areas_to_avoid` STRING COMMENT 'Free-text description of specific body areas the guest requests to avoid during treatment due to injury, sensitivity, discomfort, or personal preference.',
    `aromatherapy_preference` STRING COMMENT 'Guest preference for aromatherapy scent during treatment. Enhances personalized spa experience and guest satisfaction. [ENUM-REF-CANDIDATE: lavender|eucalyptus|peppermint|citrus|rose|sandalwood|unscented|no_preference — 8 candidates stripped; promote to reference product]',
    `cardiovascular_condition_details` STRING COMMENT 'Free-text description of specific cardiovascular conditions disclosed by the guest. Provides therapist with detailed health context for treatment planning.',
    `completion_date` DATE COMMENT 'Date when the guest completed and submitted the intake form. Critical for determining form validity and compliance with pre-treatment requirements.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the guest submitted the completed intake form. Used for audit trail and form expiration calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the intake form record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_medications` STRING COMMENT 'Free-text list of medications currently being taken by the guest. Important for identifying potential interactions with spa treatments or products.',
    `data_privacy_acknowledgment` BOOLEAN COMMENT 'Indicates whether the guest has acknowledged the spa data privacy policy and understands how their personal and health information will be used and protected.',
    `data_privacy_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the guest acknowledged the data privacy policy. Required for GDPR and CCPA compliance documentation.',
    `form_expiration_date` DATE COMMENT 'Date when the intake form expires and must be renewed. Typically 6-12 months from completion date to ensure health information remains current.',
    `form_number` STRING COMMENT 'Human-readable business identifier for the intake form, typically formatted as IF- followed by numeric sequence. Used for guest communication and record retrieval.. Valid values are `^IF-[0-9]{8,12}$`',
    `form_status` STRING COMMENT 'Current lifecycle status of the intake form. Tracks progression from guest completion through therapist review and approval.. Valid values are `draft|submitted|reviewed|approved|rejected|expired`',
    `has_allergies` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any allergies to products, ingredients, or environmental factors. Critical for preventing allergic reactions during treatment.',
    `has_cardiovascular_condition` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any cardiovascular conditions such as hypertension, heart disease, or circulatory disorders. Critical for treatment safety assessment.',
    `has_previous_spa_experience` BOOLEAN COMMENT 'Indicates whether the guest has received spa treatments before. Helps therapist adjust communication and service delivery approach.',
    `has_recent_surgery` BOOLEAN COMMENT 'Indicates whether the guest has undergone surgery within the past 6-12 months. Important for identifying treatment contraindications and areas to avoid.',
    `has_skin_condition` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any skin conditions such as eczema, psoriasis, rashes, or sensitivities. Important for product selection and treatment modifications.',
    `is_pregnant` BOOLEAN COMMENT 'Indicates whether the guest is currently pregnant. Critical for treatment contraindications and liability management.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the intake form was completed. Supports multilingual guest experience.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the intake form record was last modified. Supports change tracking and audit compliance.',
    `photography_consent_given` BOOLEAN COMMENT 'Indicates whether the guest has consented to photography or videography during their spa visit for marketing or promotional purposes.',
    `pregnancy_trimester` STRING COMMENT 'Current trimester of pregnancy if guest is pregnant. Used to determine appropriate treatment modifications and contraindications.. Valid values are `first|second|third|not_applicable`',
    `pressure_preference` STRING COMMENT 'Guest preference for massage pressure intensity. Guides therapist in delivering personalized treatment experience.. Valid values are `light|medium|firm|very_firm|no_preference`',
    `previous_spa_experience_notes` STRING COMMENT 'Free-text description of guest previous spa experiences, preferences, or concerns based on past treatments. Supports personalized service delivery.',
    `skin_condition_details` STRING COMMENT 'Free-text description of specific skin conditions disclosed by the guest. Guides therapist in selecting appropriate products and techniques.',
    `submission_channel` STRING COMMENT 'Channel through which the guest submitted the intake form. Used for channel analytics and process improvement.. Valid values are `web_portal|mobile_app|in_person_tablet|paper_form|email`',
    `surgery_details` STRING COMMENT 'Free-text description of recent surgeries including type, date, and location on body. Helps therapist identify areas requiring special care or avoidance.',
    `therapist_review_timestamp` TIMESTAMP COMMENT 'Date and time when the therapist completed their review of the intake form. Creates audit trail for quality assurance and compliance.',
    `therapist_reviewed` BOOLEAN COMMENT 'Indicates whether a licensed therapist has reviewed and approved the intake form prior to treatment. Required workflow step for quality assurance and liability management.',
    `treatment_consent_given` BOOLEAN COMMENT 'Indicates whether the guest has provided informed consent to receive the spa treatment. Required for legal liability protection and regulatory compliance.',
    `treatment_consent_timestamp` TIMESTAMP COMMENT 'Date and time when the guest provided treatment consent. Creates audit trail for legal and compliance purposes.',
    CONSTRAINT pk_intake_form PRIMARY KEY(`intake_form_id`)
) COMMENT 'Guest health intake and consultation form completed prior to spa treatments. Captures guest reference, appointment reference, form completion date, health conditions disclosed (pregnancy, cardiovascular, skin conditions, allergies, recent surgeries), medications listed, pressure preference, areas to avoid, aromatherapy preferences, previous spa experience, consent to treatment, consent to photography, data privacy acknowledgment, therapist review status, and therapist notes. Required for liability management and personalized treatment delivery.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for the spa charge transaction. Primary key for the spa charge record.',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment associated with this charge. Links the charge to the scheduled service.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa charges posted to guest folios or billed to external accounts need to link to AR invoices for consolidated billing and receivables management. This FK enables integration between spa POS and finan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spa charges must be allocated to departmental cost centers for USALI-compliant financial reporting and departmental P&L analysis. Essential for spa department performance measurement, budget variance ',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Spa charges bundle with F&B purchases in integrated resort POS. Guest charges spa treatment and restaurant meal to room on same transaction. Enables cross-department revenue analysis and unified guest',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Spa charges post to specific GL accounts in the ledger for financial statement preparation and audit trail. Required for revenue recognition, GL reconciliation, and SOX-compliant financial reporting i',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa charges require direct loyalty member link for points accrual on spa spend, tier-based spa pricing discounts, and member-only spa promotions. Critical for revenue attribution and loyalty program l',
    `package_id` BIGINT COMMENT 'Reference to the spa package or bundle if this charge is part of a multi-service offering. Links to spa package catalog.',
    `employee_id` BIGINT COMMENT 'System user ID of the staff member who posted the charge transaction. Used for audit trail and accountability.',
    `primary_original_charge_id` BIGINT COMMENT 'Reference to the original spa charge record if this is an adjustment or reversal. Links corrected charges to their source transactions.',
    `product_id` BIGINT COMMENT 'Reference to the retail product sold, if charge_type is retail. Links to the spa retail product catalog.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who received the spa service or purchased the product. Links to the guest master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Spa charges contribute to profit center P&L for segment reporting, management fee calculations, and owner distributions. Required for spa profit center GOP, EBITDA reporting, and incentive management ',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific spa facility, treatment room, or amenity area where the service was provided. Supports facility utilization analytics.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa charge was incurred. Enables multi-property revenue tracking and reporting.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this spa charge, if applicable. Used for folio posting and guest stay tracking.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Spa charges reference rate plans when posted with negotiated rates, package inclusions, or loyalty discounts. Business process: spa charge posting with rate plan discounts ensures accurate revenue rec',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa charges are posted directly to guest room folios. Revenue accounting, folio management, and PMS integration require room linkage for charge routing, a fundamental billing process in hotel spa oper',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Service recovery often involves spa charge adjustments, waivers, or complimentary treatments. Finance systems must link recovery actions to specific charge records for GL reconciliation, cost center a',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist or service provider who delivered the treatment. Used for commission tracking and performance reporting.',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service provided, if charge_type is treatment. Links to the spa treatment catalog.',
    `adjustment_reason` STRING COMMENT 'Reason for charge adjustment if posting_status is adjusted. Captures service recovery, pricing corrections, or billing disputes.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if charge_type is cancellation_fee. Captures guest no-show, late cancellation, or policy violation details.',
    `charge_date` DATE COMMENT 'Business date when the spa charge was incurred. Used for revenue recognition and daily operations reporting.',
    `charge_number` STRING COMMENT 'Externally-known unique reference number for the spa charge transaction, used for guest communication and reconciliation.',
    `charge_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spa charge transaction was posted to the system. Principal business event timestamp for the transaction.',
    `charge_type` STRING COMMENT 'Classification of the spa charge indicating the nature of the transaction: treatment (spa service), retail (product sale), membership (club fee), day_pass (facility access), gratuity (tip), or cancellation_fee (no-show penalty).. Valid values are `treatment|retail|membership|day_pass|gratuity|cancellation_fee`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spa charge record was first created in the system. Record audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Supports multi-currency operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this charge, including promotional discounts, loyalty rewards, or package inclusions. Reduces the gross charge amount.',
    `discount_code` STRING COMMENT 'Promotional or loyalty discount code applied to this charge. Used for marketing campaign tracking and discount reconciliation.',
    `folio_reference` STRING COMMENT 'Reference number of the guest folio in the PMS where this charge was posted. Links spa revenue to guest account for billing and settlement.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition. Maps spa charges to the appropriate GL account per USALI chart of accounts.',
    `gratuity_included_flag` BOOLEAN COMMENT 'Indicates whether gratuity is included in the total charge amount. True if gratuity is pre-included, false if gratuity is separate or not applied.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the spa charge record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the spa charge. May include special instructions, adjustments, or guest requests.',
    `payment_method` STRING COMMENT 'Method of payment for the spa charge: room_charge (posted to folio), credit_card (direct payment), cash, gift_card, loyalty_points (redemption), or comp (complimentary).. Valid values are `room_charge|credit_card|cash|gift_card|loyalty_points|comp`',
    `posting_status` STRING COMMENT 'Current lifecycle status of the charge transaction: posted (successfully recorded), voided (cancelled before settlement), adjusted (modified after posting), pending (awaiting approval), or reversed (corrected after settlement).. Valid values are `posted|voided|adjusted|pending|reversed`',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or services included in this charge line. Typically 1 for treatments, may be greater than 1 for retail products.',
    `revenue_center_code` STRING COMMENT 'USALI revenue center code for the spa department or facility where the charge was incurred. Used for departmental P&L reporting.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Mandatory service charge or facility fee applied to the spa charge, separate from gratuity. Common in resort and luxury properties.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to this charge, including sales tax, VAT, or other applicable taxes based on jurisdiction.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Final total amount of the spa charge including all adjustments, taxes, and fees. Net amount posted to guest folio or POS transaction.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit or service before discounts and taxes. Base rate for the treatment or product.',
    `voided_timestamp` TIMESTAMP COMMENT 'Date and time when the charge was voided, if applicable. Supports audit trail and financial reconciliation.',
    CONSTRAINT pk_charge PRIMARY KEY(`charge_id`)
) COMMENT 'Transactional record of all spa revenue charges posted to guest folios or point-of-sale systems. Captures charge reference number, appointment reference, guest reference, reservation reference, property reference, charge date, charge type (treatment, retail, membership, day pass, gratuity, cancellation fee), treatment or product reference, quantity, unit price, discount amount, tax amount, total charge amount, currency, revenue center, posting status (posted, voided, adjusted), PMS folio reference, and POS transaction reference. SSOT for spa revenue recognition and USALI departmental reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` (
    `retail_transaction_id` BIGINT COMMENT 'Unique identifier for the spa retail transaction record. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa retail sales to non-resident guests or corporate accounts generate standalone AR invoices for billing and collection. Required for accounts receivable aging, revenue recognition, and guest billing',
    `attribution_event_id` BIGINT COMMENT 'Foreign key linking to marketing.attribution_event. Business justification: Retail purchases are conversion events that may be influenced by marketing touchpoints. Tracks attribution for retail revenue, measures marketing impact on retail sales, and enables retail marketing R',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Retail purchases can be influenced by marketing campaigns (product promotions, loyalty offers, seasonal retail campaigns). Tracks campaign impact on retail revenue, measures promotional effectiveness,',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Retail purchases may use promotional offer codes (product discounts, bundle offers, loyalty promotions). Tracks offer impact on retail revenue, measures promotional effectiveness, and enables retail o',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate spa retail purchases (bulk wellness products, gift sets for employee programs, MICE amenity packages) require direct billing to corporate accounts. Essential for corporate wellness program i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail sales revenue must be tracked by cost center for departmental performance reporting and USALI schedule preparation. Required for spa retail department P&L, inventory cost allocation, and retail',
    `employee_id` BIGINT COMMENT 'Reference to the employee who processed the retail transaction.',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Spa retail purchases (skincare products, wellness items) frequently combine with F&B transactions in unified guest billing sessions. Resort POS systems track cross-department purchases for total guest',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Retail sales post to inventory and revenue GL accounts for financial statement preparation. Essential for retail COGS calculation, inventory valuation, revenue recognition, and GL account reconciliati',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Retail purchases at spa boutiques earn loyalty points and qualify for member pricing. Essential for points accrual calculation, member purchase history analysis, and personalized spa retail offers bas',
    `primary_original_transaction_retail_transaction_id` BIGINT COMMENT 'Reference to the original retail transaction ID if this transaction is a refund or exchange.',
    `profile_id` BIGINT COMMENT 'Reference to the guest or member who made the purchase.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Retail revenue contributes to spa profit center performance metrics for segment reporting and management evaluation. Essential for spa retail profitability analysis, profit center GOP contribution, an',
    `property_id` BIGINT COMMENT 'Reference to the property where the retail transaction occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the guest reservation if the retail purchase was charged to a room or associated with a stay.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Retail purchases at spa by hotel guests are posted to room folios. Point-of-sale systems and guest accounting require room linkage for charge-to-room transactions, standard practice in resort retail o',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Complimentary spa retail products (skincare, aromatherapy) are common service recovery gestures. Retail systems must link recovery transactions to originating service case for inventory cost allocatio',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: retail_transaction.outlet_id represents the spa retail outlet where the transaction occurred. In the spa domain context, retail outlets are part of spa facilities (spa_facility has retail_area_flag at',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the transaction, including promotional discounts, employee discounts, and member discounts.',
    `discount_code` STRING COMMENT 'Promotional or discount code applied to the transaction, if any.',
    `guest_email` STRING COMMENT 'Email address of the guest for digital receipt delivery and marketing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `guest_phone` STRING COMMENT 'Contact phone number of the guest who made the purchase.',
    `item_count` STRING COMMENT 'Total number of distinct line items or products included in this retail transaction.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this retail purchase.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the guest as payment or partial payment for this transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail transaction record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the cashier or system regarding the transaction.',
    `payment_method` STRING COMMENT 'Primary payment instrument used for the transaction (e.g., credit card, cash, room charge, gift card, loyalty points redemption). [ENUM-REF-CANDIDATE: cash|credit_card|debit_card|room_charge|gift_card|loyalty_points|mobile_payment|bank_transfer — 8 candidates stripped; promote to reference product]',
    `payment_reference` STRING COMMENT 'Reference number or authorization code from the payment processor for credit card or electronic payments. Masked or tokenized for security.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the Point of Sale (POS) terminal or workstation where the transaction was processed.',
    `receipt_number` STRING COMMENT 'Printed receipt number provided to the guest as proof of purchase.',
    `refund_reason` STRING COMMENT 'Reason code or description for refunded or voided transactions, if applicable.',
    `sales_channel` STRING COMMENT 'Channel through which the retail transaction was initiated (e.g., in-person at spa shop, online store, mobile app, phone order).. Valid values are `in_person|online|mobile_app|phone|concierge`',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Service charge or gratuity amount added to the transaction, if applicable.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before discounts, taxes, and fees are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the transaction, including sales tax, value-added tax, and other applicable taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount of the transaction after all discounts, taxes, and service charges have been applied. Net amount due from guest.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of all products sold in this transaction, summed across all line items.',
    `transaction_date` DATE COMMENT 'The date when the retail transaction occurred. Business event date for revenue recognition and reporting.',
    `transaction_number` STRING COMMENT 'Business identifier for the retail transaction, typically generated by the Point of Sale (POS) system. Externally visible transaction reference.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the retail transaction indicating whether it was successfully completed, voided, refunded, or cancelled.. Valid values are `completed|voided|refunded|pending|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the retail transaction was completed at the Point of Sale (POS) terminal.',
    CONSTRAINT pk_retail_transaction PRIMARY KEY(`retail_transaction_id`)
) COMMENT 'Transactional record of spa retail product sales to guests and members. Captures transaction number, transaction date, guest reference, property reference, outlet reference, cashier reference, items sold, quantities, unit prices, discounts applied, subtotal, tax amount, total amount, payment method, loyalty points earned, POS terminal reference, and transaction status (completed, voided, refunded). Supports spa retail revenue tracking, inventory depletion, and guest purchase history.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` (
    `retail_inventory_id` BIGINT COMMENT 'Unique identifier for the retail inventory record. Primary key for the retail inventory product.',
    `adjustment_retail_inventory_id` BIGINT COMMENT 'Self-referencing FK on retail_inventory (adjustment_retail_inventory_id)',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Retail spa products (skincare, aromatherapy oils) should reference material master for standardized product data, vendor sourcing, pricing, and procurement specifications. Eliminates data duplication ',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa facility is located. Enables property-level inventory aggregation and reporting.',
    `retail_product_id` BIGINT COMMENT 'Reference to the retail product master record. Identifies the specific spa retail product (skincare, wellness items, accessories) being tracked in inventory.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the spa facility or outlet where this retail inventory is maintained. Links to the spa facility master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier or vendor for this retail product. Used for procurement planning and supplier performance tracking.',
    `available_quantity` DECIMAL(18,2) COMMENT 'The quantity of product available for immediate sale. Calculated as current stock quantity minus reserved quantity.',
    `batch_number` STRING COMMENT 'The manufacturer batch or lot number for product traceability. Used for quality control, recalls, and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was first created in the system. Used for audit trails and inventory history analysis.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for unit cost and retail price. Enables multi-currency inventory management for international properties.. Valid values are `^[A-Z]{3}$`',
    `current_stock_quantity` DECIMAL(18,2) COMMENT 'The current on-hand quantity of the retail product at this facility. Represents the total physical inventory available including reserved items.',
    `expiration_date` DATE COMMENT 'The date when the product expires or should no longer be sold. Critical for skincare, wellness supplements, and perishable spa products. Null for non-perishable items.',
    `inventory_status` STRING COMMENT 'The current lifecycle status of the inventory record. Indicates whether the product is actively sold, discontinued, held for quality review, or subject to recall.. Valid values are `active|discontinued|seasonal|on_hold|expired|recalled`',
    `inventory_value` DECIMAL(18,2) COMMENT 'The total value of current stock at unit cost. Calculated as current stock quantity multiplied by unit cost. Used for financial reporting and asset valuation.',
    `last_physical_count_date` DATE COMMENT 'The date when the last physical inventory count was performed for this product at this facility. Used to track inventory audit compliance and accuracy.',
    `last_physical_count_quantity` DECIMAL(18,2) COMMENT 'The actual quantity counted during the last physical inventory audit. Used to calculate variance and adjust system inventory records.',
    `last_replenishment_date` DATE COMMENT 'The date when the most recent inventory replenishment was received for this product. Used to track replenishment frequency and supplier performance.',
    `last_replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity received in the most recent replenishment delivery. Used for replenishment pattern analysis and order optimization.',
    `last_sale_date` DATE COMMENT 'The date when this product was last sold at this facility. Used to identify slow-moving inventory and optimize product mix.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was last modified. Used for data synchronization, audit trails, and change tracking.',
    `lead_time_days` STRING COMMENT 'The number of days between placing a replenishment order and receiving the product. Used to calculate reorder points and safety stock levels.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The maximum inventory quantity that should be maintained for this product at this facility. Used to prevent overstocking and optimize storage space.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The minimum stock level threshold that triggers a replenishment order. When available quantity falls below this level, procurement is initiated.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'The standard quantity to order when replenishing this product. Based on lead time, demand forecast, and optimal order economics.',
    `reorder_triggered_flag` BOOLEAN COMMENT 'Indicates whether the reorder point has been reached and a replenishment request should be generated. True when available quantity is at or below reorder point.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'The quantity of product reserved for pending guest purchases or spa treatment packages but not yet fulfilled. Reduces available quantity for new sales.',
    `storage_location` STRING COMMENT 'The physical storage location within the spa facility where this inventory is kept. Examples include retail display area, back room storage, or secure cabinet.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the retail product. Used for inventory valuation, Cost of Goods Sold (COGS) calculation, and margin analysis.',
    `unit_of_measure` STRING COMMENT 'The standard unit in which the retail product is counted and sold. Used for inventory tracking and Point of Sale (POS) transactions.. Valid values are `each|bottle|jar|tube|box|set`',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'The current selling price per unit of the retail product. Used for Point of Sale (POS) transactions and revenue calculation.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between system inventory quantity and physical count quantity. Positive values indicate overage, negative values indicate shortage. Used for shrinkage analysis and inventory accuracy metrics.',
    CONSTRAINT pk_retail_inventory PRIMARY KEY(`retail_inventory_id`)
) COMMENT 'Operational inventory record tracking spa retail product stock levels at each property outlet. Captures product reference, facility reference, current stock quantity, reserved quantity, available quantity, last physical count date, last physical count quantity, variance quantity, reorder triggered flag, reorder quantity, and last replenishment date. Enables spa managers to maintain optimal retail stock levels and trigger procurement requests.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` (
    `membership_id` BIGINT COMMENT 'Unique identifier for the spa and wellness membership record. Primary key.',
    `attribution_event_id` BIGINT COMMENT 'Foreign key linking to marketing.attribution_event. Business justification: Membership enrollments are key conversion events requiring attribution to marketing touchpoints. Essential for understanding membership acquisition journey, calculating acquisition costs by channel, a',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Membership enrollments are frequently the result of acquisition campaigns (membership drives, enrollment promotions, referral campaigns). Critical for measuring membership marketing ROI, tracking acqu',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Membership enrollments often use promotional offers (waived enrollment fees, discounted rates, first-month-free promotions). Essential for offer performance tracking, measuring membership acquisition ',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account sponsoring this membership. Populated only for corporate membership types where an employer or organization pays for employee memberships. Null for individual memberships.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa memberships sold through distribution partners (OTA wellness packages, corporate channels, travel agent networks) require channel attribution for commission calculation and membership acquisition ',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Memberships are often targeted to specific guest segments (local residents, frequent travelers, wellness enthusiasts). Essential for segment-based membership strategies, acquisition targeting, and mea',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Membership fees post to deferred/recurring revenue GL accounts for subscription revenue recognition. Essential for deferred revenue liability tracking, recurring revenue amortization, and ASC 606 comp',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa memberships are often bundled with hotel loyalty elite status, offering integrated benefits and cross-program recognition. Supports combined membership management, loyalty elite spa privileges, an',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Spa memberships are marketed to specific segments (local residents, hotel guests, corporate accounts). Business process: membership revenue forecasting, segment performance analysis, and strategic pla',
    `profile_id` BIGINT COMMENT 'Reference to the guest enrolled in this spa membership. Links to the guest master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Membership revenue is allocated to spa profit center for recurring revenue tracking and segment profitability. Required for membership program ROI analysis, profit center recurring revenue metrics, an',
    `property_id` BIGINT COMMENT 'Reference to the property where this spa membership is valid. Spa memberships are typically property-specific rather than chain-wide.',
    `renewed_membership_id` BIGINT COMMENT 'Self-referencing FK on membership (renewed_membership_id)',
    `annual_fee` DECIMAL(18,2) COMMENT 'Total annual membership fee. For annual memberships this is the upfront payment amount. For monthly memberships this represents the total annual cost (monthly fee times 12). Zero for complimentary memberships.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the membership is set to automatically renew at the end of the current term. True if auto-renewal is enabled and payment will be processed automatically, False if the membership will expire without manual renewal.',
    `cancellation_date` DATE COMMENT 'Date when the membership was cancelled. Null if membership has never been cancelled. Marks the effective end of the membership relationship.',
    `cancellation_notes` STRING COMMENT 'Free-text notes capturing additional details about the membership cancellation. May include guest feedback, retention offers made, or special circumstances. Used for qualitative analysis of member churn.',
    `cancellation_reason` STRING COMMENT 'Primary reason for membership cancellation. Member request indicates voluntary cancellation by the guest. Payment failure indicates cancellation due to non-payment. Relocation indicates member moved away from property area. Dissatisfaction indicates service quality issues. Health reasons indicates medical inability to use facilities. Cost concerns indicates financial reasons. Used for retention analysis and program improvement.. Valid values are `member_request|payment_failure|relocation|dissatisfaction|health_reasons|cost_concerns`',
    `contract_term_months` STRING COMMENT 'Length of the membership contract commitment in months. Common values are 1 for month-to-month, 12 for annual contracts, 24 or 36 for multi-year commitments. Null for lifetime or indefinite memberships.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for membership fees. Typically matches the propertys local currency.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to standard membership fees. Typically associated with promotional codes, corporate programs, or loyalty rewards. Zero indicates no discount. Maximum value 100.00 for fully complimentary memberships.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the member cancels before the end of the contract term. Zero for month-to-month memberships with no commitment. Used to enforce contract terms and recover acquisition costs.',
    `effective_start_date` DATE COMMENT 'Date when the membership benefits become active and the guest can begin using spa facilities and services. May differ from enrollment date if there is a waiting period or future-dated activation.',
    `enrollment_date` DATE COMMENT 'Date when the guest enrolled in the spa membership program. Marks the start of the membership relationship.',
    `expiry_date` DATE COMMENT 'Date when the current membership term expires. For monthly memberships this is typically one month from start date, for annual memberships one year. Null for lifetime or indefinite memberships.',
    `included_fitness_access` BOOLEAN COMMENT 'Indicates whether the membership includes unlimited access to fitness center facilities including gym equipment, group fitness classes, and personal training consultations. True if fitness access is included, False if not included or requires additional fees.',
    `included_guest_passes` STRING COMMENT 'Number of complimentary guest passes included with the membership per billing period. Guest passes allow the member to bring non-member guests to use spa and fitness facilities. Zero indicates no guest passes included.',
    `included_treatment_credits` STRING COMMENT 'Number of complimentary spa treatment credits included with the membership per billing period. Credits can typically be redeemed for massages, facials, body treatments, and other spa services. Zero indicates no included treatments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `last_payment_date` DATE COMMENT 'Date when the most recent membership fee payment was successfully processed. Used to track payment history and identify delinquent accounts.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to receive marketing communications about spa promotions, new services, and special events. True if opted in, False if opted out. Must be respected per GDPR and CCPA requirements.',
    `membership_number` STRING COMMENT 'Externally visible unique membership number issued to the guest. Used for identification at spa facilities and on membership cards.. Valid values are `^[A-Z0-9]{8,20}$`',
    `membership_status` STRING COMMENT 'Current lifecycle status of the spa membership. Active memberships have full benefits and access. Suspended memberships are temporarily on hold (e.g., medical leave, payment issue). Cancelled memberships have been terminated by member or property. Expired memberships have reached their end date without renewal. Pending memberships are awaiting activation or payment confirmation.. Valid values are `active|suspended|cancelled|expired|pending`',
    `membership_type` STRING COMMENT 'Type of membership based on billing frequency and enrollment channel. Monthly memberships renew each month, Annual memberships are paid yearly, Corporate memberships are sponsored by employer organizations, Complimentary memberships are granted as loyalty rewards or promotional offers.. Valid values are `monthly|annual|corporate|complimentary`',
    `monthly_fee` DECIMAL(18,2) COMMENT 'Recurring monthly membership fee charged to the guest. Applicable for monthly and annual memberships (annual divided by 12). Zero for complimentary memberships.',
    `next_billing_date` DATE COMMENT 'Date when the next membership fee payment is scheduled to be processed. Null for cancelled or expired memberships. Used for billing cycle management and revenue forecasting.',
    `payment_method_token` STRING COMMENT 'Tokenized reference to the payment method on file for recurring membership charges. Token is stored securely in PCI-compliant payment gateway and used for auto-renewal billing. Does not contain actual card numbers.. Valid values are `^[A-Za-z0-9_-]{16,64}$`',
    `payment_method_type` STRING COMMENT 'Type of payment method used for membership billing. Credit card and debit card are most common for individual memberships, bank account for direct debit, corporate billing for employer-sponsored memberships, room charge for in-house guests who want membership fees added to their folio.. Valid values are `credit_card|debit_card|bank_account|corporate_billing|room_charge`',
    `preferred_contact_method` STRING COMMENT 'Members preferred channel for receiving membership communications including billing notifications, appointment reminders, and promotional offers. Used to personalize communication strategy and improve member engagement.. Valid values are `email|phone|sms|mobile_app|postal_mail`',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied at enrollment. Used to track marketing campaign effectiveness and apply special pricing or benefits. Null if no promotion was used.. Valid values are `^[A-Z0-9]{4,20}$`',
    `referral_source` STRING COMMENT 'Channel or source through which the guest learned about and enrolled in the spa membership program. Direct indicates walk-in enrollment. Member referral indicates existing member recommendation. Hotel guest indicates enrollment during property stay. Marketing campaign indicates response to promotional offer. Corporate program indicates employer wellness initiative. Online indicates website or app enrollment. Concierge indicates recommendation by hotel staff. [ENUM-REF-CANDIDATE: direct|member_referral|hotel_guest|marketing_campaign|corporate_program|online|concierge — 7 candidates stripped; promote to reference product]',
    `suspension_end_date` DATE COMMENT 'Date when the membership suspension is scheduled to end and membership will return to active status. Null if not currently suspended or if suspension is indefinite pending member action.',
    `suspension_start_date` DATE COMMENT 'Date when the membership was suspended. Null if membership has never been suspended or is not currently suspended. Used to track suspension periods for billing adjustments and benefit calculations.',
    `tier` STRING COMMENT 'Tier level of the spa membership indicating the level of benefits and access. Basic provides limited access, Premium includes enhanced benefits, Elite offers priority booking and exclusive treatments, Unlimited provides unrestricted access to all spa facilities and services.. Valid values are `basic|premium|elite|unlimited`',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT 'Spa and wellness membership master record for guests enrolled in property-level spa membership programs. Captures membership number, guest reference, property reference, membership tier (basic, premium, elite, unlimited), membership type (monthly, annual, corporate), enrollment date, expiry date, monthly fee, annual fee, included treatment credits, included fitness access, included guest passes, auto-renewal flag, payment method on file, membership status (active, suspended, cancelled, expired), and cancellation reason. Distinct from loyalty.member which manages the hotel-wide loyalty program.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` (
    `membership_visit_id` BIGINT COMMENT 'Unique identifier for the spa membership visit transaction. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Reference to the spa reception or front desk staff member who processed the check-in and credit redemption for this visit.',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Spa members purchase F&B during facility visits (smoothie bar, wellness café, poolside dining). Tracking combined spend per visit is standard membership analytics for calculating total member value an',
    `membership_id` BIGINT COMMENT 'Reference to the spa membership contract under which this visit occurred. Links to the membership agreement that governs credit allocation and benefits.',
    `prior_membership_visit_id` BIGINT COMMENT 'Self-referencing FK on membership_visit (prior_membership_visit_id)',
    `profile_id` BIGINT COMMENT 'Reference to the guest who made this spa facility visit. Links to the guest profile in the Property Management System (PMS).',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific spa facility accessed during this visit (spa treatment area, fitness center, pool, golf course, wellness studio).',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the spa facility visit occurred.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa members staying as hotel guests may charge visit-related services to their room. Billing flexibility and guest convenience require room linkage for members who are also in-house guests at the prop',
    `survey_response_id` BIGINT COMMENT 'Foreign key linking to marketing.survey_response. Business justification: Membership visits may trigger satisfaction surveys (visit feedback, facility ratings, service quality). Links member feedback to specific visits, tracks member satisfaction trends, and supports member',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist or wellness professional who provided the treatment service. Null for facility-only visits without treatment.',
    `treatment_id` BIGINT COMMENT 'Reference to the specific spa treatment or service redeemed during this visit. Null if the visit was for facility access only (fitness, pool) without a treatment.',
    `additional_service_charge` DECIMAL(18,2) COMMENT 'Monetary charge for services beyond membership benefits (upgrades, extended time, premium products). Separate from credit redemption.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the visit was cancelled. Null for completed visits. Used for service recovery and operational improvement analysis.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the visit was cancelled. Null for non-cancelled visits. Used for cancellation policy enforcement and late-cancellation fee assessment.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the member checked in at the spa facility reception. Marks the start of the visit for duration tracking and capacity management.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the member checked out from the spa facility. Marks the end of the visit for duration calculation and facility turnover.',
    `complimentary_flag` BOOLEAN COMMENT 'Indicator whether this visit was provided as a complimentary benefit or service recovery gesture without credit consumption or charge.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this visit record was first created in the source system. Audit trail for data lineage and compliance.',
    `credits_consumed` DECIMAL(18,2) COMMENT 'Number of membership credits deducted from the members balance for this visit. Zero for included benefits or complimentary access.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this visit record. Supports multi-currency operations for international resort properties.. Valid values are `^[A-Z]{3}$`',
    `feedback_comments` STRING COMMENT 'Free-text guest feedback or comments about the visit experience. Captured for service quality improvement and issue resolution.',
    `gratuity_amount` DECIMAL(18,2) COMMENT 'Tip or gratuity amount provided by the guest for therapist or service staff. Tracked separately for staff compensation and service quality correlation.',
    `guest_count` STRING COMMENT 'Number of guests included in this visit (member plus any authorized guests under guest pass privileges). Used for capacity planning and revenue allocation.',
    `guest_satisfaction_score` STRING COMMENT 'Post-visit satisfaction rating provided by the guest, typically on a scale of 1-10. Captured via post-service survey or feedback kiosk. Used for quality monitoring and therapist performance evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this visit record was last updated in the source system. Audit trail for change tracking and data quality monitoring.',
    `no_show_flag` BOOLEAN COMMENT 'Indicator whether the member failed to appear for a scheduled visit without prior cancellation. Used for no-show policy enforcement and credit forfeiture rules.',
    `remaining_credit_balance` DECIMAL(18,2) COMMENT 'Snapshot of the membership credit balance remaining after this visit transaction. Enables point-in-time balance tracking and reconciliation.',
    `retail_purchase_amount` DECIMAL(18,2) COMMENT 'Total monetary value of spa retail products purchased during this visit. Separate from membership credits. Tracked for cross-sell revenue analysis.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Originally scheduled end date and time for the visit or treatment. Used for resource planning and schedule optimization.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Originally scheduled date and time for the visit or treatment appointment. Used for no-show detection and schedule adherence analysis.',
    `special_request` STRING COMMENT 'Guest-provided special requests or preferences for this visit (room temperature, music preference, pressure level, accessibility needs). Used for personalized service delivery.',
    `visit_date` DATE COMMENT 'Calendar date on which the spa facility visit occurred. Primary business event date for utilization tracking and reporting.',
    `visit_number` STRING COMMENT 'Business identifier for the visit transaction. Externally visible reference number used for guest communication and service tracking.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the membership visit. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|checked_in|in_progress|completed|cancelled|no_show`',
    `visit_type` STRING COMMENT 'Classification of the type of spa facility visit or membership benefit utilized. Determines credit consumption rules and access privileges. [ENUM-REF-CANDIDATE: fitness_access|pool_access|treatment_redemption|guest_pass|wellness_class|golf_access|spa_day_pass — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_membership_visit PRIMARY KEY(`membership_visit_id`)
) COMMENT 'Transactional record of each spa facility visit or treatment credit redemption by a spa member. Captures visit date, membership reference, guest reference, facility reference, visit type (fitness access, pool access, treatment redemption, guest pass), treatment reference if applicable, check-in time, check-out time, credits consumed, remaining credit balance, and staff who processed the visit. Enables membership utilization tracking and credit balance management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` (
    `day_pass_id` BIGINT COMMENT 'Unique identifier for the day pass transaction. Primary key for the day pass record.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Day pass purchases by local residents or corporate groups generate AR invoices for non-guest billing. Essential for local market revenue tracking, corporate account management, and facility access rev',
    `attribution_event_id` BIGINT COMMENT 'Foreign key linking to marketing.attribution_event. Business justification: Day pass purchases are conversion events needing attribution to marketing touchpoints. Tracks marketing touchpoints leading to day pass sales, enables attribution modeling for local market campaigns, ',
    `channel_id` BIGINT COMMENT 'Reference to the channel through which the day pass was booked (web, mobile app, front desk, phone, OTA).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Day pass sales are commonly driven by marketing campaigns (local resident promotions, seasonal offers, staycation packages). Essential for campaign attribution, measuring promotional effectiveness on ',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Day passes are commonly sold with promotional offer codes (local resident discounts, seasonal promotions, group discounts). Tracks offer redemption, discount attribution, and measures promotional effe',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate day pass programs for employee wellness benefits require direct corporate account linkage. Enables bulk day pass billing, corporate wellness program administration, usage tracking against co',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Day pass revenue posts to facility access revenue GL accounts for financial reporting. Required for spa facility revenue recognition, GL reconciliation, and non-treatment revenue tracking in wellness ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Day pass purchases earn loyalty points and qualify for member-exclusive rates. Required for points accrual on day pass revenue, tier-based pricing application, and targeted marketing to loyalty member',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Day passes target specific segments (hotel guests, local visitors, group events). Business process: day pass revenue attribution to market segments enables segment profitability analysis, pricing stra',
    `profile_id` BIGINT COMMENT 'Reference to the guest who purchased the day pass. Links to guest profile in the guest domain.',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific facility (spa, pool, fitness center, golf course) for which the day pass is valid.',
    `property_id` BIGINT COMMENT 'Reference to the property where the day pass is valid. Links to the property master data.',
    `renewed_day_pass_id` BIGINT COMMENT 'Self-referencing FK on day_pass (renewed_day_pass_id)',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Hotel guests frequently purchase spa day passes as add-ons to their room reservation. This link enables: (1) bundled package pricing at booking, (2) posting day pass charges to guest folio, (3) tracki',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Hotel guests purchasing spa day passes charge them to room folios. Guest services and revenue management require room linkage for charge-to-room transactions and consolidated billing at checkout.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Day pass issues (facility access problems, overcrowding, amenity unavailability) trigger service cases. Guest services teams must link cases to day pass records for refund processing, facility capacit',
    `adult_count` STRING COMMENT 'Number of adults included in the day pass. Used for capacity planning and pricing calculation.',
    `booking_source` STRING COMMENT 'The specific source or interface through which the day pass was purchased. Used for channel performance analysis. [ENUM-REF-CANDIDATE: direct_web|mobile_app|front_desk|phone|ota|walk_in|concierge — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the day pass was booked or purchased by the guest.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the day pass was cancelled. Used for service recovery and operational improvement.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the day pass was cancelled by the guest or property. Null if not cancelled.',
    `check_in_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the guest checked in and began using the facility. Used for operational tracking and capacity management.',
    `check_out_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the guest checked out and vacated the facility. Used for operational tracking and capacity management.',
    `child_count` STRING COMMENT 'Number of children included in the day pass. Used for capacity planning and pricing calculation.',
    `confirmation_number` STRING COMMENT 'Booking confirmation number provided to the guest. Used for guest communication and reservation lookup.. Valid values are `^[A-Z0-9]{6,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this day pass record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transaction.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the day pass. Includes promotional discounts, loyalty discounts, and group discounts.',
    `group_booking_flag` BOOLEAN COMMENT 'Indicates whether this day pass is part of a group booking. Used for group sales analytics and capacity planning.',
    `guest_type` STRING COMMENT 'Classification of the guest purchasing the day pass. Used for market segmentation and targeted marketing.. Valid values are `local_resident|tourist|business_traveler|group_member|loyalty_member|non_member`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this day pass record was last updated. Used for audit trail and change tracking.',
    `loyalty_member_flag` BOOLEAN COMMENT 'Indicates whether the guest is a member of the property loyalty program. Used for loyalty analytics and benefits application.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned from this day pass purchase. Used for loyalty program administration.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the day pass transaction. Used for operational context and issue tracking.',
    `package_flag` BOOLEAN COMMENT 'Indicates whether this day pass is part of a larger package or bundle (e.g., spa day package with treatments).',
    `pass_date` DATE COMMENT 'The calendar date for which the day pass is valid. Represents the business event date for the pass usage.',
    `pass_number` STRING COMMENT 'Externally visible unique alphanumeric identifier for the day pass. Used for guest reference, check-in, and operational tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `pass_status` STRING COMMENT 'Current lifecycle status of the day pass. Tracks the pass from sale through expiration or refund.. Valid values are `sold|active|expired|refunded|cancelled|no_show`',
    `pass_type` STRING COMMENT 'Classification of the day pass by facility type. Determines which amenities the pass grants access to.. Valid values are `spa_day_pass|pool_day_pass|fitness_day_pass|golf_day_pass|resort_amenity_pass|wellness_day_pass`',
    `payment_method` STRING COMMENT 'The payment instrument used to purchase the day pass. Used for financial reconciliation and payment analytics. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|mobile_payment|gift_certificate|loyalty_points|bank_transfer — 7 candidates stripped; promote to reference product]',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount refunded to the guest if the day pass was cancelled or refunded. Null if no refund issued.',
    `refund_timestamp` TIMESTAMP COMMENT 'The date and time when the refund was processed. Null if no refund issued.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Service charge or facility fee applied to the day pass. Common in resort and spa operations.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or preferences from the guest (e.g., locker preference, dietary restrictions for spa refreshments).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The subtotal amount before taxes and fees. Calculated as unit price multiplied by guest count.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the day pass transaction. Includes sales tax, occupancy tax, and other applicable taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount charged for the day pass including all taxes, fees, and discounts. Net amount paid by guest.',
    `unit_price` DECIMAL(18,2) COMMENT 'The base price per person or per pass unit before any adjustments or taxes.',
    `valid_from_time` TIMESTAMP COMMENT 'The timestamp when the day pass becomes valid and the guest may begin using the facility.',
    `valid_to_time` TIMESTAMP COMMENT 'The timestamp when the day pass expires and the guest must vacate the facility.',
    CONSTRAINT pk_day_pass PRIMARY KEY(`day_pass_id`)
) COMMENT 'Transactional record for non-resident and non-member day access passes sold for spa, pool, fitness, and golf amenities. Captures pass number, guest reference, property reference, facility reference, pass type (spa day pass, pool day pass, fitness day pass, golf day pass, resort amenity pass), pass date, valid from time, valid to time, adult count, child count, unit price, total amount, booking channel, check-in time, check-out time, and pass status (sold, active, expired, refunded). Supports ancillary revenue from local and day-use guests.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` (
    `fitness_class_id` BIGINT COMMENT 'Unique identifier for the fitness class. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the primary instructor or therapist who leads this fitness class.',
    `fitness_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last modified this fitness class record.',
    `parent_fitness_class_id` BIGINT COMMENT 'Self-referencing FK on fitness_class (parent_fitness_class_id)',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific fitness facility, gym, or wellness center where the class is conducted.',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this fitness class is offered.',
    `advance_booking_required_hours` STRING COMMENT 'The minimum number of hours in advance that guests must book to reserve a spot in this class.',
    `age_restriction_maximum` STRING COMMENT 'The maximum age in years allowed for participation, if applicable (nullable for classes with no upper age limit).',
    `age_restriction_minimum` STRING COMMENT 'The minimum age in years required for a guest to participate in this fitness class.',
    `cancellation_policy_hours` STRING COMMENT 'The number of hours before the class start time by which guests must cancel to avoid charges or penalties.',
    `class_benefits` STRING COMMENT 'Summary of the health, wellness, and fitness benefits guests will gain from participating in this class.',
    `class_code` STRING COMMENT 'Unique business identifier code for the fitness class used in scheduling and booking systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `class_description` STRING COMMENT 'Detailed narrative description of the class content, benefits, and what guests can expect during the session.',
    `class_image_url` STRING COMMENT 'URL link to the promotional image or photo representing this fitness class in marketing materials and booking systems.',
    `class_name` STRING COMMENT 'The marketing and display name of the fitness class as presented to guests.',
    `class_status` STRING COMMENT 'Current lifecycle status of the fitness class in the catalog (active, inactive, seasonal, suspended, discontinued).. Valid values are `active|inactive|seasonal|suspended|discontinued`',
    `class_subcategory` STRING COMMENT 'More granular classification within the class type (e.g., Vinyasa Yoga, Hot Yoga, Power Pilates, Indoor Cycling).',
    `class_type` STRING COMMENT 'The category or discipline of the fitness class (e.g., yoga, pilates, spin, HIIT, aqua aerobics, meditation, stretching, strength training, barre, zumba, kickboxing). [ENUM-REF-CANDIDATE: yoga|pilates|spin|hiit|aqua_aerobics|meditation|stretching|strength_training|barre|zumba|kickboxing — 11 candidates stripped; promote to reference product]',
    `complimentary_flag` BOOLEAN COMMENT 'Indicates whether this class is offered as a complimentary amenity to guests at no charge.',
    `contraindications` STRING COMMENT 'Medical conditions, injuries, or circumstances under which guests should not participate in this class (e.g., pregnancy, heart conditions, recent surgery).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fitness class record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` STRING COMMENT 'The scheduled length of the fitness class in minutes.',
    `effective_end_date` DATE COMMENT 'The date when this fitness class is no longer available for booking; nullable for classes with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date when this fitness class becomes available for booking and scheduling.',
    `equipment_provided_flag` BOOLEAN COMMENT 'Indicates whether the facility provides all necessary equipment (True) or if guests must bring their own (False).',
    `equipment_required` STRING COMMENT 'List of equipment or props needed for the class (e.g., yoga mat, dumbbells, resistance bands, spin bike, pool access).',
    `fitness_level` STRING COMMENT 'The recommended fitness or experience level for participants (beginner, intermediate, advanced, all levels).. Valid values are `beginner|intermediate|advanced|all_levels`',
    `instructor_certification_required` STRING COMMENT 'The professional certifications or qualifications required for an instructor to teach this class (e.g., RYT-200, ACE Certified, CPR/AED).',
    `intensity_level` STRING COMMENT 'The physical intensity or exertion level of the class (low, moderate, high, variable).. Valid values are `low|moderate|high|variable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fitness class record was most recently updated.',
    `loyalty_points_earned` STRING COMMENT 'The number of loyalty program points a guest earns by attending this fitness class.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether participation in this class earns loyalty program points for the guest.',
    `maximum_participants` STRING COMMENT 'The maximum number of guests allowed to register for this class based on facility capacity and safety requirements.',
    `member_price` DECIMAL(18,2) COMMENT 'The discounted price offered to loyalty program members or spa membership holders.',
    `minimum_participants` STRING COMMENT 'The minimum number of registered guests required for the class to proceed; classes below this threshold may be cancelled.',
    `notes` STRING COMMENT 'Additional free-form notes or special instructions related to this fitness class for operational or guest communication purposes.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book this class through online channels (website, mobile app) or if it requires phone or in-person booking.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this class can be included in spa or wellness packages offered to guests.',
    `pregnancy_safe_flag` BOOLEAN COMMENT 'Indicates whether the class is safe for pregnant guests to participate in.',
    `seasonal_availability` STRING COMMENT 'Indicates whether the class is offered year-round or only during specific seasons.. Valid values are `year_round|summer_only|winter_only|spring_fall|peak_season|off_season`',
    `standard_price` DECIMAL(18,2) COMMENT 'The standard retail price charged to guests for participating in this fitness class.',
    `target_guest_segment` STRING COMMENT 'The primary guest demographic or market segment this class is designed for (e.g., wellness travelers, active seniors, families, corporate groups).',
    CONSTRAINT pk_fitness_class PRIMARY KEY(`fitness_class_id`)
) COMMENT 'Master catalog of fitness and wellness classes offered at resort and hotel fitness facilities. Captures class name, class code, class type (yoga, pilates, spin, HIIT, aqua aerobics, meditation, stretching), instructor reference, facility reference, duration in minutes, maximum participants, minimum participants, equipment required, fitness level (beginner, intermediate, advanced), class description, and active status.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` (
    `fitness_class_session_id` BIGINT COMMENT 'Unique identifier for the fitness class session instance. Primary key for the fitness class session entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fitness class revenue and instructor costs are allocated to wellness cost centers for departmental reporting. Essential for fitness program profitability analysis, instructor cost tracking, and wellne',
    `fitness_class_id` BIGINT COMMENT 'Reference to the master fitness class definition. Links this session to the class catalog entry that defines the class type, description, and standard attributes.',
    `employee_id` BIGINT COMMENT 'Reference to the fitness instructor or therapist leading this session. Enables instructor utilization tracking, performance analysis, and guest preference matching.',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific facility or room where the class session takes place (e.g., yoga studio, spin room, outdoor pavilion). Enables facility utilization tracking and scheduling conflict management.',
    `property_id` BIGINT COMMENT 'Reference to the property where this fitness class session is held. Enables property-level reporting and multi-property operations management.',
    `rescheduled_fitness_class_session_id` BIGINT COMMENT 'Self-referencing FK on fitness_class_session (rescheduled_fitness_class_session_id)',
    `actual_attendance_count` STRING COMMENT 'The number of guests who actually attended the session, recorded after session completion. Used for no-show analysis, instructor performance tracking, and revenue reconciliation.',
    `advance_booking_required_hours` STRING COMMENT 'The minimum number of hours in advance that a guest must book before the session start time. Ensures adequate preparation time and prevents last-minute bookings that disrupt operations.',
    `age_restriction` STRING COMMENT 'Age requirements or restrictions for participation (e.g., 18+, 16-65, Adults Only, Family Friendly). Ensures compliance with safety regulations and program design.',
    `booking_status` STRING COMMENT 'Current booking availability status. Not Open: bookings not yet accepted. Open: accepting bookings with available capacity. Limited: few spots remaining. Closed: no longer accepting bookings. Waitlist Only: capacity full but waitlist available.. Valid values are `not_open|open|limited|closed|waitlist_only`',
    `cancellation_notes` STRING COMMENT 'Free-text notes providing additional context about the cancellation. May include details about guest notifications, refund processing, or rescheduling arrangements.',
    `cancellation_policy_hours` STRING COMMENT 'The number of hours before session start time by which a guest must cancel to avoid penalties or charges. Supports revenue protection and capacity management.',
    `cancellation_reason` STRING COMMENT 'The reason why the session was cancelled, if applicable. Used for operational analysis, guest communication, and process improvement. Null if session was not cancelled. [ENUM-REF-CANDIDATE: instructor_unavailable|low_enrollment|facility_issue|weather|equipment_failure|guest_request|operational_decision|other — 8 candidates stripped; promote to reference product]',
    `class_format` STRING COMMENT 'The delivery format of the session. In Person: traditional on-site class. Virtual: online streaming or video conference. Hybrid: simultaneous in-person and virtual. Outdoor: held in outdoor spaces. Poolside: aquatic or pool-adjacent class.. Valid values are `in_person|virtual|hybrid|outdoor|poolside`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this session record was first created in the system. Supports audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the session price (e.g., USD, EUR, GBP). Supports multi-currency operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `difficulty_level` STRING COMMENT 'The skill or fitness level required for this session. Helps guests select appropriate classes and ensures safety. All Levels: suitable for any fitness level. Adaptive: modified for special needs or limitations.. Valid values are `beginner|intermediate|advanced|all_levels|adaptive`',
    `duration_minutes` STRING COMMENT 'The planned duration of the session in minutes. Supports scheduling, pricing, and guest expectation management. May differ from calculated end_time minus start_time if session includes setup or cleanup time.',
    `end_time` TIMESTAMP COMMENT 'The scheduled end date and time of the fitness class session. Used for facility turnover planning, back-to-back session scheduling, and duration calculation.',
    `enrolled_count` STRING COMMENT 'The current number of guests enrolled in this session. Updated in real-time as bookings are made or cancelled. Used to determine session availability and trigger waitlist processing.',
    `equipment_required` STRING COMMENT 'List or description of equipment needed for the session (e.g., yoga mat, blocks, strap or spin bike, towel, water bottle). Informs guests what to bring or expect to be provided.',
    `guest_segment` STRING COMMENT 'The primary guest segment this session is designed for or marketed to. Influences pricing, availability, and promotional strategies.. Valid values are `resort_guest|spa_member|day_pass|local_resident|loyalty_member|corporate_group`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this session record was last updated. Tracks the most recent change to any session attribute, supporting change management and audit requirements.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether participation in this session qualifies for loyalty program points accrual. True: points can be earned. False: no points awarded.',
    `loyalty_points_value` STRING COMMENT 'The number of loyalty program points awarded to guests who attend this session. Null if loyalty_points_eligible_flag is false.',
    `maximum_capacity` STRING COMMENT 'The maximum number of guests that can be enrolled in this session, determined by facility size, equipment availability, and safety regulations. Used for booking controls and waitlist management.',
    `minimum_age` STRING COMMENT 'The minimum age in years required to participate in this session. Used for booking validation and liability management. Null if no minimum age applies.',
    `notes` STRING COMMENT 'Free-text operational notes about the session. May include special setup instructions, guest requests, instructor preferences, or other contextual information for staff.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book this session through online channels (website, mobile app). True: online booking available. False: must book via phone or in-person.',
    `published_flag` BOOLEAN COMMENT 'Indicates whether this session is published and visible to guests in schedules and booking systems. True: visible to guests. False: internal or draft session not yet released.',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when this session was published and made available for guest booking. Used for schedule release tracking and marketing campaign coordination.',
    `revenue_center` STRING COMMENT 'The revenue center or department code to which session revenue is allocated. Aligns with property accounting structure and USALI reporting requirements.',
    `session_code` STRING COMMENT 'Business identifier for the session, typically used in guest-facing communications, booking confirmations, and operational schedules. May follow property-specific naming conventions.',
    `session_date` DATE COMMENT 'The calendar date on which the fitness class session is scheduled. Used for daily scheduling, capacity planning, and historical analysis.',
    `session_name` STRING COMMENT 'Display name for the session, often including class name and time (e.g., Morning Yoga Flow - 7am). Used in guest-facing schedules and marketing materials.',
    `session_price` DECIMAL(18,2) COMMENT 'The standard price charged per guest for this session. May be zero for complimentary classes included in resort amenities. Actual guest charges may vary based on packages, memberships, or promotions.',
    `session_status` STRING COMMENT 'Current lifecycle status of the session. Scheduled: session created but not yet open for booking. Open: accepting enrollments. Full: at maximum capacity. Cancelled: session will not occur. In Progress: session currently underway. Completed: session finished. No Show: session scheduled but no attendees. [ENUM-REF-CANDIDATE: scheduled|open|full|cancelled|in_progress|completed|no_show — 7 candidates stripped; promote to reference product]',
    `session_type` STRING COMMENT 'Classification of the session based on delivery model and pricing structure. Group: standard multi-guest class. Private: one-on-one instruction. Semi-Private: small group with personalized attention. Complimentary: included in resort amenities. Premium: upcharge class. Special Event: one-time or themed session.. Valid values are `group|private|semi_private|complimentary|premium|special_event`',
    `special_requirements` STRING COMMENT 'Any special requirements, prerequisites, or conditions for participation (e.g., must be able to swim, physician clearance required, no recent injuries). Ensures guest safety and appropriate class placement.',
    `start_time` TIMESTAMP COMMENT 'The scheduled start date and time of the fitness class session. Precise timestamp enables conflict detection, instructor scheduling, and guest notification.',
    `waitlist_count` STRING COMMENT 'The number of guests on the waitlist for this session. Indicates demand exceeding capacity and informs decisions about adding additional sessions or larger facilities.',
    CONSTRAINT pk_fitness_class_session PRIMARY KEY(`fitness_class_session_id`)
) COMMENT 'Scheduled instance of a fitness or wellness class at a specific date, time, and facility. Captures class reference, facility reference, instructor reference, session date, start time, end time, maximum capacity, enrolled count, waitlist count, session status (scheduled, open, full, cancelled, completed), cancellation reason, and actual attendance count. Enables class scheduling, capacity management, and instructor utilization tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` (
    `spa_class_enrollment_id` BIGINT COMMENT 'Unique identifier for the class enrollment record. Primary key.',
    `fitness_class_session_id` BIGINT COMMENT 'Reference to the scheduled fitness or wellness class session. Links to the class session schedule.',
    `guest_communication_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_communication. Business justification: Fitness class enrollments trigger communications (confirmations, reminders, cancellation notices, class updates). Critical for class communication tracking, guest experience management, and supporting',
    `membership_id` BIGINT COMMENT 'Reference to the guests spa or fitness membership if applicable. Null for non-member enrollments.',
    `employee_id` BIGINT COMMENT 'Reference to the system user who processed the cancellation. Null for guest self-service cancellations or non-cancelled enrollments.',
    `profile_id` BIGINT COMMENT 'Reference to the guest or member who enrolled in the class session. Links to the guest master record.',
    `property_id` BIGINT COMMENT 'Reference to the property where the class enrollment occurred. Links to the property master record.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Fitness class enrollments by hotel guests are charged to room folios. Billing systems and guest accounting require room linkage for charge-to-room transactions when participants are in-house guests.',
    `survey_response_id` BIGINT COMMENT 'Foreign key linking to marketing.survey_response. Business justification: Fitness class attendance may trigger feedback surveys (class satisfaction, instructor ratings, facility feedback). Tracks class satisfaction, instructor performance, and supports fitness program quali',
    `transferred_spa_class_enrollment_id` BIGINT COMMENT 'Self-referencing FK on spa_class_enrollment (transferred_spa_class_enrollment_id)',
    `attendance_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the guests attendance was confirmed by the instructor or system. True if attended, False if no-show or not yet determined.',
    `cancellation_notes` STRING COMMENT 'Free-text notes providing additional context about the cancellation. Null for non-cancelled enrollments.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation. Null for non-cancelled enrollments. Used for cancellation root cause analysis. [ENUM-REF-CANDIDATE: guest_request|schedule_conflict|illness|weather|facility_closure|class_cancelled|no_show_conversion — 7 candidates stripped; promote to reference product]',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was cancelled. Null for active enrollments. Used for cancellation pattern analysis.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Total amount charged to the guest for the class enrollment. May be zero for complimentary or member-included classes. Expressed in the propertys local currency.',
    `check_in_method` STRING COMMENT 'Method used by the guest to check in for the class. Null if not checked in. Used for check-in process optimization.. Valid values are `mobile_app|kiosk|staff_desk|instructor|automatic`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the guest checked in for the class session. Null if not yet checked in. Used to determine attended vs no-show status.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was confirmed by the guest or system. Null if not yet confirmed. Used for no-show prediction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this enrollment record. Typically matches the propertys local currency.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the enrollment charge. Includes member discounts, promotional offers, and loyalty redemptions. Null if no discount applied.',
    `enrollment_channel` STRING COMMENT 'Channel through which the guest enrolled in the class. Used for channel performance analysis and guest preference tracking. [ENUM-REF-CANDIDATE: mobile_app|web_portal|front_desk|phone|concierge|spa_desk|in_room — 7 candidates stripped; promote to reference product]',
    `enrollment_number` STRING COMMENT 'Unique business identifier for the enrollment transaction. Used for guest communication and service desk reference.. Valid values are `^ENR-[0-9]{8,12}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the class enrollment. Tracks progression from initial enrollment through attendance or cancellation.. Valid values are `enrolled|waitlisted|cancelled|attended|no-show|confirmed`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Date and time when the guest enrolled in the class session. Primary business event timestamp for this transaction.',
    `folio_reference_number` STRING COMMENT 'Reference number of the guest folio where charges were posted. Null for non-room-charge payment methods. Links to OPERA PMS folio.',
    `guest_feedback_comments` STRING COMMENT 'Free-text comments provided by the guest about their class experience. Null if no feedback provided. Used for service improvement.',
    `guest_rating` STRING COMMENT 'Rating provided by the guest for the class experience on a scale of 1-5. Null if guest has not provided feedback. Used for class quality tracking.',
    `instructor_notes` STRING COMMENT 'Notes added by the class instructor regarding the guests participation, performance, or any incidents. Null if no notes recorded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last updated. Used for audit trail and change tracking.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this enrollment. Null or zero if not eligible for points.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the guest to pay for or discount this enrollment. Null or zero if no points used.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount charged after discounts and including taxes. Represents the final amount posted to the guest folio or payment method.',
    `no_show_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the guest for failing to attend or cancel within the policy window. Null if no fee applies. Expressed in the propertys local currency.',
    `no_show_fee_waived_flag` BOOLEAN COMMENT 'Indicates whether the no-show fee was waived by management. True if waived, False if charged. Used for service recovery tracking.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the guest failed to attend without cancelling. True if no-show, False otherwise. Used for no-show fee enforcement and guest behavior tracking.',
    `notes` STRING COMMENT 'General free-text notes field for any additional information about the enrollment that does not fit other structured fields. Null if no notes.',
    `payment_method` STRING COMMENT 'Method used to pay for the class enrollment. Room charge posts to guest folio, membership indicates included in membership benefits. [ENUM-REF-CANDIDATE: room_charge|credit_card|cash|membership|complimentary|loyalty_points|gift_certificate — 7 candidates stripped; promote to reference product]',
    `source_record_reference` STRING COMMENT 'Unique identifier of this enrollment record in the source operational system. Used for data reconciliation and audit trails.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or accommodations needed by the guest for the class. Null if no special requests.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the enrollment charge. Null if tax-exempt or zero-rated. Expressed in the propertys local currency.',
    `waitlist_position` STRING COMMENT 'Position in the waitlist queue if enrollment status is waitlisted. Null for non-waitlisted enrollments. Used for automated promotion when spots become available.',
    `waitlist_timestamp` TIMESTAMP COMMENT 'Date and time when the guest was placed on the waitlist. Null if never waitlisted. Used for waitlist duration analysis.',
    CONSTRAINT pk_spa_class_enrollment PRIMARY KEY(`spa_class_enrollment_id`)
) COMMENT 'Transactional record of a guest or member enrolling in a scheduled fitness or wellness class session. Captures enrollment date, guest reference, session reference, membership reference if applicable, enrollment channel, enrollment status (enrolled, waitlisted, cancelled, attended, no-show), cancellation date, cancellation reason, charge amount, and check-in timestamp. Supports class attendance management, waitlist processing, and no-show fee enforcement. [SSOT_OWNER] [SSOT MASTER for group spa.spa_class_enrollment]event_class_enrollment. [SSOT:class_enrollment] Domain-specific specialization of the class_enrollment concept; canonical SSOT owner is event.event_class_enrollment.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` (
    `golf_tee_time_id` BIGINT COMMENT 'Unique identifier for the golf tee time booking record. Primary key for the golf tee time transaction.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Golf bookings for corporate outings, tournaments, or non-resident play generate AR invoices for direct billing. Required for golf revenue recognition, corporate account receivables, and event billing ',
    `booking_source_id` BIGINT COMMENT 'Reference to the specific booking source or partner through which the tee time was reserved. Links to booking source master data.',
    `employee_id` BIGINT COMMENT 'Reference to the system user or staff member who created the tee time booking. Links to user master data.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Golf revenue posts to recreation revenue GL accounts for financial statement preparation. Essential for golf operations revenue recognition, GL account reconciliation, and recreation department financ',
    `profile_id` BIGINT COMMENT 'Reference to the guest who booked the tee time. Links to the guest master record.',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific golf course where the tee time is scheduled. A property may have multiple courses.',
    `property_id` BIGINT COMMENT 'Reference to the resort property where the golf course is located.',
    `rescheduled_golf_tee_time_id` BIGINT COMMENT 'Self-referencing FK on golf_tee_time (rescheduled_golf_tee_time_id)',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this tee time booking. May be null for non-guest bookings or local players.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Golf tee times booked by hotel guests are charged to room folios. Resort billing and folio management require room linkage for golf charges, a standard practice in integrated resort operations.',
    `booking_channel` STRING COMMENT 'The channel through which the tee time was booked. Values: direct (walk-in), phone, web (property website), mobile_app, concierge (hotel concierge), ota (online travel agency), gds (global distribution system). [ENUM-REF-CANDIDATE: direct|phone|web|mobile_app|concierge|ota|gds — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the tee time booking was created. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `caddie_fee_per_caddie` DECIMAL(18,2) COMMENT 'The service fee charged per caddie. Does not include gratuity.',
    `caddie_requested_flag` BOOLEAN COMMENT 'Indicates whether caddie service was requested for this tee time. True if caddie is requested, False otherwise.',
    `cancellation_reason` STRING COMMENT 'The reason for tee time cancellation. Values: guest_request, weather, course_maintenance, overbooking, no_show, other.. Valid values are `guest_request|weather|course_maintenance|overbooking|no_show|other`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the tee time booking was cancelled. Null if not cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cart_fee_per_cart` DECIMAL(18,2) COMMENT 'The rental fee charged per golf cart.',
    `cart_rental_flag` BOOLEAN COMMENT 'Indicates whether golf cart rental is included in this tee time booking. True if cart is rented, False otherwise.',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the guest checked in at the pro shop for their tee time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `club_rental_fee_per_set` DECIMAL(18,2) COMMENT 'The rental fee charged per set of golf clubs.',
    `club_rental_flag` BOOLEAN COMMENT 'Indicates whether golf club rental is included in this tee time booking. True if clubs are rented, False otherwise.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when the round of golf was completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `confirmation_number` STRING COMMENT 'Externally-facing unique confirmation number provided to the guest for the tee time booking. Used for guest communication and check-in.. Valid values are `^[A-Z0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tee time record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tee time record.. Valid values are `^[A-Z]{3}$`',
    `green_fee_per_player` DECIMAL(18,2) COMMENT 'The green fee charged per player for this tee time. Does not include cart, club rental, or caddie fees.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tee time record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loyalty_member_number` STRING COMMENT 'The guests loyalty program member number if applicable. Used for points accrual and member benefits.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this tee time booking.',
    `notes` STRING COMMENT 'Internal operational notes or comments about the tee time booking. Used by golf operations staff for coordination and service delivery.',
    `number_of_caddies` STRING COMMENT 'Number of caddies assigned to this tee time. May be one per player or one per group depending on service level.',
    `number_of_carts` STRING COMMENT 'Number of golf carts rented for this tee time. Typically one cart per two players.',
    `number_of_club_sets` STRING COMMENT 'Number of golf club sets rented for this tee time.',
    `number_of_holes` STRING COMMENT 'Number of holes booked for this tee time. Common values are 9 or 18 holes.',
    `number_of_players` STRING COMMENT 'Total number of players in the tee time booking. Typically ranges from 1 to 4 players per tee time slot.',
    `payment_method` STRING COMMENT 'The payment method used for the tee time booking. Values: room_charge (charged to hotel room), credit_card, cash, comp (complimentary), voucher (gift certificate or prepaid voucher), member_account (club member account).. Valid values are `room_charge|credit_card|cash|comp|voucher|member_account`',
    `rate_type` STRING COMMENT 'The pricing category applied to this tee time. Values: rack (standard public rate), guest (hotel guest rate), member (club member rate), twilight (discounted late-day rate), promotional (special offer rate), tournament (group event rate).. Valid values are `rack|guest|member|twilight|promotional|tournament`',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or notes from the guest regarding the tee time booking (e.g., preferred cart location, accessibility needs, group preferences).',
    `tee_time` TIMESTAMP COMMENT 'The exact date and time when the players are scheduled to tee off. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `tee_time_date` DATE COMMENT 'The date on which the tee time is scheduled. Format: yyyy-MM-dd.',
    `tee_time_status` STRING COMMENT 'Current lifecycle status of the tee time booking. Values: booked (initial reservation), confirmed (guest confirmed attendance), checked_in (guest arrived at pro shop), completed (round finished), cancelled (booking cancelled), no_show (guest did not arrive).. Valid values are `booked|confirmed|checked_in|completed|cancelled|no_show`',
    `total_charge` DECIMAL(18,2) COMMENT 'Total charge for the tee time booking including green fees, cart rental, club rental, caddie fees, and any applicable taxes or surcharges.',
    `weather_cancellation_flag` BOOLEAN COMMENT 'Indicates whether the tee time was cancelled due to weather conditions. True if weather-related cancellation, False otherwise.',
    CONSTRAINT pk_golf_tee_time PRIMARY KEY(`golf_tee_time_id`)
) COMMENT 'Transactional record for golf tee time bookings at resort golf courses. Captures tee time confirmation number, guest reference, reservation reference, property reference, course reference, tee time date, tee time, number of players, cart rental flag, club rental flag, caddie requested flag, green fee per player, cart fee, total charge, booking channel, booking date, tee time status (booked, confirmed, checked-in, completed, cancelled, no-show), and weather cancellation flag. Supports golf revenue management and tee sheet operations.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` (
    `amenity_pricing_id` BIGINT COMMENT 'Unique identifier for the amenity pricing rule record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this pricing rule for operational use.',
    `product_id` BIGINT COMMENT 'Reference to the retail product being priced. Null if pricing applies to treatments or services.',
    `property_id` BIGINT COMMENT 'Reference to the property where this pricing rule applies.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the specific spa, fitness, golf, or recreation facility where this pricing applies.',
    `superseded_amenity_pricing_id` BIGINT COMMENT 'Self-referencing FK on amenity_pricing (superseded_amenity_pricing_id)',
    `tertiary_amenity_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this pricing rule record.',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment, fitness class, or service being priced. Null if pricing applies to retail products or day passes.',
    `active_status` STRING COMMENT 'Current operational status of the pricing rule: active (in use), inactive (not in use), suspended (temporarily disabled), pending (awaiting approval).. Valid values are `active|inactive|suspended|pending`',
    `approval_status` STRING COMMENT 'Approval workflow status for the pricing rule: draft (being created), pending_approval (submitted for review), approved (authorized for use), rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing rule was approved for operational use.',
    `cancellation_policy_code` STRING COMMENT 'Reference code to the cancellation policy applicable to bookings made under this pricing rule.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether sales at this pricing tier are eligible for therapist or sales agent commission.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission percentage paid to therapist or sales agent for sales at this pricing tier.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `day_of_week_applicability` STRING COMMENT 'Days of the week when this pricing rule applies (e.g., MON-FRI, SAT-SUN, ALL). Enables weekday vs weekend pricing differentiation.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied from rack rate for this pricing rule. Used for member, promotional, and group pricing.',
    `effective_end_date` DATE COMMENT 'Date when this pricing rule expires and is no longer applicable. Null indicates open-ended pricing.',
    `effective_start_date` DATE COMMENT 'Date when this pricing rule becomes active and applicable for bookings and sales.',
    `gift_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether this pricing can be purchased using gift certificates or vouchers.',
    `gratuity_included_flag` BOOLEAN COMMENT 'Indicates whether gratuity is included in the pricing or added separately at point of sale.',
    `guest_segment` STRING COMMENT 'Target guest segment for this pricing rule (e.g., leisure, business, VIP, local resident, group). Enables segment-based dynamic pricing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing rule record was last updated in the system.',
    `loyalty_tier_code` STRING COMMENT 'Loyalty program tier required to qualify for this pricing (e.g., GOLD, PLATINUM, ELITE). Null if no tier restriction.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that a booking can be made under this pricing rule.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap for this pricing rule. Used to limit pricing for promotional or group rates.',
    `minimum_advance_booking_hours` STRING COMMENT 'Minimum number of hours in advance that a booking must be made to qualify for this pricing rule.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that must be applied regardless of quantity or duration. Used for group bookings or minimum service fees.',
    `notes` STRING COMMENT 'Free-form notes and comments about the pricing rule for operational reference and business context.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this pricing is available for online booking through digital channels.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this pricing can be included in package offerings and bundled deals.',
    `price_type` STRING COMMENT 'Classification of the pricing tier: rack (standard published rate), member (loyalty member rate), resort_guest (in-house guest rate), day_use (non-guest rate), group (group booking rate), promotional (special offer rate), package (bundled rate), corporate (corporate account rate). [ENUM-REF-CANDIDATE: rack|member|resort_guest|day_use|group|promotional|package|corporate — 8 candidates stripped; promote to reference product]',
    `pricing_rule_code` STRING COMMENT 'Unique business identifier for the pricing rule, used for operational reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `pricing_rule_name` STRING COMMENT 'Descriptive name of the pricing rule for business user identification and reporting.',
    `pricing_unit` STRING COMMENT 'Unit of measure for pricing: per_treatment (single service), per_hour (hourly rate), per_session (class or session), per_day (day pass), per_person (per guest), per_item (retail product), per_round (golf). [ENUM-REF-CANDIDATE: per_treatment|per_hour|per_session|per_day|per_person|per_item|per_round — 7 candidates stripped; promote to reference product]',
    `priority_rank` STRING COMMENT 'Priority ranking for pricing rule application when multiple rules could apply. Lower numbers indicate higher priority.',
    `season_code` STRING COMMENT 'Seasonal pricing period identifier (e.g., PEAK, SHOULDER, LOW, HOLIDAY) enabling seasonal rate variations.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the unit price includes applicable taxes or if taxes are added separately.',
    `time_of_day_end` STRING COMMENT 'End time for time-based pricing rules. Format HH:MM in 24-hour notation.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `time_of_day_start` STRING COMMENT 'Start time for time-based pricing rules (e.g., morning rates, evening rates). Format HH:MM in 24-hour notation.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit for the amenity, treatment, or product under this pricing rule.',
    CONSTRAINT pk_amenity_pricing PRIMARY KEY(`amenity_pricing_id`)
) COMMENT 'Reference master defining pricing rules for spa treatments, fitness classes, day passes, golf tee times, and retail products by property, season, and guest segment. Captures pricing rule name, facility reference, treatment or product reference, price type (rack, member, resort guest, day use, group, promotional), guest segment, season code, effective date, expiry date, currency, unit price, minimum charge, and active status. Enables dynamic pricing across spa and recreation amenities.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` (
    `cancellation_log_id` BIGINT COMMENT 'Unique identifier for the cancellation log record. Primary key for the cancellation audit trail.',
    `original_cancellation_log_id` BIGINT COMMENT 'Self-referencing FK on cancellation_log (original_cancellation_log_id)',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment or class session that was cancelled. Links to the original booking record.',
    `employee_id` BIGINT COMMENT 'Reference to the staff user who processed the cancellation if cancelled by staff. Null for guest-initiated or system cancellations.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who had the cancelled appointment. Enables guest-level cancellation pattern analysis.',
    `property_id` BIGINT COMMENT 'Reference to the property where the cancelled appointment was scheduled. Enables property-level cancellation analytics.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the specific spa facility where the cancelled appointment was scheduled.',
    `advance_notice_hours` DECIMAL(18,2) COMMENT 'Number of hours between cancellation timestamp and scheduled appointment start time. Used to determine policy compliance.',
    `appointment_scheduled_date` DATE COMMENT 'Original scheduled date of the cancelled appointment. Used to calculate advance notice period.',
    `cancellation_channel` STRING COMMENT 'Channel or interface through which the cancellation was submitted. Enables channel-specific cancellation analysis. [ENUM-REF-CANDIDATE: PHONE|EMAIL|MOBILE_APP|WEBSITE|IN_PERSON|PMS|SYSTEM_AUTO — 7 candidates stripped; promote to reference product]',
    `cancellation_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the cancellation fee charged to the guest. Null if no fee was applied.',
    `cancellation_fee_applicable_flag` BOOLEAN COMMENT 'Indicates whether a cancellation fee was applicable based on policy rules and cancellation timing.',
    `cancellation_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cancellation fee amount.. Valid values are `^[A-Z]{3}$`',
    `cancellation_fee_waived_flag` BOOLEAN COMMENT 'Indicates whether an applicable cancellation fee was waived by staff or management as a service recovery gesture.',
    `cancellation_notes` STRING COMMENT 'Additional free-text notes or comments recorded by staff regarding the cancellation circumstances or guest interaction.',
    `cancellation_number` STRING COMMENT 'Business-facing unique cancellation reference number used for tracking and guest communication.',
    `cancellation_policy_code` STRING COMMENT 'Reference code for the cancellation policy that was in effect for this appointment at time of booking.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code representing the primary reason for cancellation. Enables categorization and trend analysis. [ENUM-REF-CANDIDATE: GUEST_REQUEST|NO_SHOW|LATE_ARRIVAL|THERAPIST_UNAVAILABLE|FACILITY_ISSUE|WEATHER|MEDICAL|SCHEDULE_CONFLICT|DUPLICATE_BOOKING|SYSTEM_ERROR|POLICY_VIOLATION|OTHER — 12 candidates stripped; promote to reference product]',
    `cancellation_reason_description` STRING COMMENT 'Detailed free-text explanation of the cancellation reason provided by the cancelling party.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Exact date and time when the cancellation was recorded in the system. Primary business event timestamp for this transaction.',
    `cancellation_type` STRING COMMENT 'Classification of the cancellation event: standard cancellation with notice, no-show without notice, or late cancellation within policy window.. Valid values are `CANCELLATION|NO_SHOW|LATE_CANCELLATION`',
    `cancelled_by_party` STRING COMMENT 'Indicates which party initiated the cancellation: guest, staff member, automated system, or property management.. Valid values are `GUEST|STAFF|SYSTEM|PROPERTY`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation log record was first created in the data warehouse. Audit trail for data lineage.',
    `fee_waiver_reason_code` STRING COMMENT 'Standardized code indicating the reason why a cancellation fee was waived. Null if fee was not waived. [ENUM-REF-CANDIDATE: LOYALTY_STATUS|MEDICAL_EMERGENCY|PROPERTY_ERROR|SERVICE_RECOVERY|MANAGER_DISCRETION|FIRST_OFFENSE|WEATHER_EVENT|OTHER — 8 candidates stripped; promote to reference product]',
    `fee_waiver_reason_description` STRING COMMENT 'Detailed explanation of why the cancellation fee was waived. Null if fee was not waived.',
    `guest_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a cancellation confirmation notification was sent to the guest via email or SMS.',
    `guest_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation confirmation notification was sent to the guest. Null if no notification was sent.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation log record was last updated in the data warehouse. Supports change tracking and audit compliance.',
    `late_cancellation_flag` BOOLEAN COMMENT 'Indicates whether the cancellation occurred within the late cancellation policy window defined by the spa facility.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the guest failed to appear for the appointment without prior cancellation notice.',
    `original_appointment_value` DECIMAL(18,2) COMMENT 'Total monetary value of the cancelled appointment including all treatments and services. Represents lost revenue opportunity.',
    `rebooking_completed_flag` BOOLEAN COMMENT 'Indicates whether the guest successfully rebooked a new appointment following this cancellation.',
    `rebooking_offer_extended_flag` BOOLEAN COMMENT 'Indicates whether the guest was offered an opportunity to rebook the cancelled appointment at time of cancellation.',
    `revenue_recovery_amount` DECIMAL(18,2) COMMENT 'Total amount recovered through cancellation fees and rebooking. Used to calculate net revenue impact of cancellation.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this cancellation record in the source operational system. Enables traceability and reconciliation.',
    `therapist_notified_flag` BOOLEAN COMMENT 'Indicates whether the assigned therapist was notified of the appointment cancellation to enable schedule adjustment.',
    CONSTRAINT pk_cancellation_log PRIMARY KEY(`cancellation_log_id`)
) COMMENT 'Transactional audit record of all spa appointment and class cancellation events including guest-initiated cancellations, no-shows, and property-initiated cancellations. Captures appointment or session reference, cancellation timestamp, cancellation reason code, cancellation reason description, cancelled by (guest, staff, system), cancellation channel, late cancellation flag, cancellation fee applied, fee amount, fee waiver flag, waiver reason, and rebooking offer extended flag. Supports cancellation policy enforcement and revenue recovery tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Unique identifier for the spa and fitness equipment asset. Primary key.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Spa equipment (massage tables, saunas, hydrotherapy systems) are capitalized fixed assets requiring depreciation tracking. Essential for FF&E reserve calculations, capital expenditure tracking, asset ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Spa equipment requires ongoing maintenance from specialized service vendors (separate from original supplier). Critical for service contract management, preventive maintenance scheduling, and vendor p',
    `pip_item_id` BIGINT COMMENT 'Foreign key linking to property.pip_item. Business justification: Spa equipment purchases, installations, and major renovations are tracked as capital expenditure line items in Property Improvement Plans for budget approval, brand compliance verification, and asset ',
    `property_id` BIGINT COMMENT 'Reference to the property where this equipment is located.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Spa equipment (massage tables, saunas, hydrotherapy tubs) is capital expenditure procured via purchase orders. Links equipment asset records to original procurement transaction for warranty tracking a',
    `replaced_equipment_id` BIGINT COMMENT 'Self-referencing FK on equipment (replaced_equipment_id)',
    `spa_facility_id` BIGINT COMMENT 'Reference to the spa or fitness facility housing this equipment.',
    `treatment_room_id` BIGINT COMMENT 'Reference to the specific treatment room where this equipment is assigned, if applicable.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded against this equipment asset to date.',
    `capacity_rating` STRING COMMENT 'Maximum capacity or load rating of the equipment (e.g., weight limit, occupancy, volume).',
    `equipment_category` STRING COMMENT 'High-level grouping of equipment by operational use (spa treatment, hydrotherapy, thermal experience, cardio, strength, wellness technology, recovery). [ENUM-REF-CANDIDATE: spa treatment|hydrotherapy|thermal experience|cardio|strength|wellness technology|recovery — 7 candidates stripped; promote to reference product]',
    `equipment_code` STRING COMMENT 'Unique business identifier or asset tag code for the equipment used for tracking and inventory management.',
    `condition_rating` STRING COMMENT 'Assessment of the physical condition and functionality of the equipment (excellent, good, fair, poor, critical).. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for purchase cost and replacement cost.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the equipment asset (straight line, declining balance, units of production, not applicable).. Valid values are `straight line|declining balance|units of production|not applicable`',
    `dimensions` STRING COMMENT 'Physical dimensions of the equipment (length x width x height) with units.',
    `disposal_date` DATE COMMENT 'Date when the equipment was disposed of, sold, or removed from service.',
    `disposal_method` STRING COMMENT 'Method by which the equipment was disposed of (sold, donated, recycled, scrapped, transferred).. Valid values are `sold|donated|recycled|scrapped|transferred`',
    `equipment_type` STRING COMMENT 'Classification of the equipment by functional category (e.g., massage table, hydrotherapy tub, sauna, steam room, treadmill, weight machine, infrared pod, elliptical, stationary bike, rowing machine). [ENUM-REF-CANDIDATE: massage table|hydrotherapy tub|sauna|steam room|treadmill|weight machine|infrared pod|elliptical|stationary bike|rowing machine — 10 candidates stripped; promote to reference product]',
    `expected_useful_life_years` STRING COMMENT 'Anticipated lifespan of the equipment in years from installation date.',
    `installation_date` DATE COMMENT 'Date when the equipment was installed and made operational at the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment record was last updated or modified.',
    `last_safety_inspection_date` DATE COMMENT 'Date of the most recent safety inspection or certification.',
    `last_service_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the equipment.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the equipment.',
    `model_number` STRING COMMENT 'Manufacturers model number or designation for this equipment type.',
    `equipment_name` STRING COMMENT 'Human-readable name or title of the equipment asset.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current book value of the equipment calculated as purchase cost minus accumulated depreciation.',
    `next_safety_inspection_date` DATE COMMENT 'Scheduled date for the next required safety inspection or certification.',
    `next_service_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or service inspection.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the equipment, maintenance history, or special considerations.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment (active, under maintenance, out of service, decommissioned, pending installation, retired).. Valid values are `active|under maintenance|out of service|decommissioned|pending installation|retired`',
    `power_requirements` STRING COMMENT 'Electrical power specifications required to operate the equipment (voltage, amperage, phase).',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the equipment.',
    `purchase_date` DATE COMMENT 'Date when the equipment was purchased or acquired by the property.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Estimated current cost to replace the equipment with a comparable new unit.',
    `safety_certification_required` BOOLEAN COMMENT 'Indicates whether this equipment requires periodic safety certification or inspection.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific equipment unit.',
    `service_contract_number` STRING COMMENT 'Reference number for the maintenance service contract covering this equipment.',
    `service_interval_days` STRING COMMENT 'Number of days between scheduled preventive maintenance services.',
    `usage_hours_total` STRING COMMENT 'Cumulative total hours the equipment has been in operational use.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the equipment in kilograms.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master record for spa and fitness equipment assets including treatment tables, hydrotherapy units, fitness machines, and specialized wellness devices. Captures equipment name, equipment code, equipment type (massage table, hydrotherapy tub, sauna, steam room, treadmill, weight machine, infrared pod), facility reference, treatment room reference, manufacturer, model number, serial number, purchase date, warranty expiry, last service date, next service due date, operational status (active, under maintenance, decommissioned), and replacement cost. Supports preventive maintenance scheduling and capital planning.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` (
    `wellness_program_id` BIGINT COMMENT 'Unique identifier for the wellness program. Primary key for the wellness program entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Wellness programs are typically launched with dedicated marketing campaigns (program launches, seasonal wellness promotions). Links program inventory to promotional efforts, enabling campaign-specific',
    `content_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.content_asset. Business justification: Wellness programs require content assets for promotion (program videos, testimonials, brochures, success stories). Links program to marketing materials, enables content performance tracking, and suppo',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: Wellness programs include prescribed meal plans (detox menus, anti-inflammatory diets, nutrition programs). Programs reference specific F&B menus designed for dietary components. Essential for program',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Multi-day wellness programs booked via channels need channel tracking for commission accrual, package rate management, and channel performance analysis. Revenue management uses this to optimize wellne',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Wellness programs are designed for specific guest segments (detox seekers, fitness enthusiasts, stress management seekers). Links program design to target audience, enables segment-specific program ma',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Wellness programs target specific segments (wellness travelers, corporate retreats, luxury leisure). Business process: program revenue planning by market segment supports strategic positioning, pricin',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Wellness programs are brand-specific (Six Senses wellness programs, Canyon Ranch programs, Miraval experiences). Essential for brand differentiation, brand-specific program management, and supporting ',
    `prerequisite_wellness_program_id` BIGINT COMMENT 'Self-referencing FK on wellness_program (prerequisite_wellness_program_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user (spa director, revenue manager, or general manager) who approved this wellness program for operational deployment and guest booking.',
    `property_id` BIGINT COMMENT 'Identifier of the resort or destination spa property where this wellness program is offered.',
    `tertiary_wellness_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this wellness program record. Enables change tracking and accountability for program updates.',
    `active_status` STRING COMMENT 'Current operational status of the wellness program. Controls visibility in booking channels and availability for new reservations.. Valid values are `active|inactive|suspended|pending_approval|discontinued`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the wellness program was approved for operational use. Critical for audit trails and compliance with internal controls.',
    `booking_channel_availability` STRING COMMENT 'Comma-separated list of distribution channels where this wellness program can be booked (e.g., direct, GDS, OTA, call center, property website). Supports channel management and rate parity strategies.',
    `cancellation_policy_code` STRING COMMENT 'Code referencing the cancellation and modification policy applicable to this wellness program. Defines penalties, refund terms, and modification windows.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this wellness program record was first created in the system. Foundational audit field for data lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program price (e.g., USD, EUR, GBP). Supports multi-currency properties and international guest bookings.. Valid values are `^[A-Z]{3}$`',
    `dietary_component_flag` BOOLEAN COMMENT 'Indicates whether the wellness program includes a specialized dietary or nutrition component such as meal plans, nutritional counseling, or detox menus.',
    `duration_days` STRING COMMENT 'Total number of days the wellness program spans from check-in to check-out. Used for minimum stay requirements and pricing calculations.',
    `effective_end_date` DATE COMMENT 'Date when the wellness program is discontinued or expires. Null indicates an ongoing program with no planned end date. Supports program versioning and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when the wellness program becomes available for booking and delivery. Used for program lifecycle management and historical tracking.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting wellness program revenue. Supports financial reporting, budgeting, and compliance with accounting standards.. Valid values are `^[0-9]{4,10}$`',
    `included_fitness_sessions` STRING COMMENT 'Number of fitness or exercise sessions included in the wellness program (e.g., yoga classes, personal training, group fitness). Zero indicates no fitness component.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this wellness program record. Critical for version control and change auditing.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points or miles earned per program purchase. Used for loyalty rewards fulfillment and member value calculations.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases of this wellness program earn loyalty program points or miles. Supports loyalty program administration and member engagement strategies.',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that bookings are accepted for this wellness program. Controls inventory release and demand forecasting accuracy.',
    `maximum_participants` STRING COMMENT 'Maximum number of guests that can be enrolled in a single program session. Constrained by facility capacity, therapist availability, and service quality standards.',
    `medical_supervision_required_flag` BOOLEAN COMMENT 'Indicates whether the wellness program requires medical supervision, physician consultation, or health screening prior to participation. Critical for liability and guest safety.',
    `minimum_advance_booking_days` STRING COMMENT 'Minimum number of days in advance that a guest must book before the program start date. Ensures adequate preparation time for therapist scheduling, dietary planning, and facility readiness.',
    `minimum_participants` STRING COMMENT 'Minimum number of enrolled guests required for the program to proceed. Used for group-based programs where economies of scale or group dynamics are essential.',
    `minimum_stay_nights` STRING COMMENT 'Minimum number of nights a guest must book to participate in this wellness program. Enforced at reservation time to ensure program completion.',
    `notes` STRING COMMENT 'Free-text field for internal operational notes, special instructions, or contextual information about the wellness program. Not visible to guests.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book this wellness program directly through online channels (website, mobile app) or if it requires call center or concierge assistance.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this wellness program can be bundled with accommodation packages, event bookings, or other property services for promotional pricing.',
    `program_brochure_url` STRING COMMENT 'URL to the downloadable PDF brochure or detailed program guide. Provides comprehensive information for guest decision-making and pre-arrival preparation.',
    `program_code` STRING COMMENT 'Unique business code for the wellness program used in reservations, marketing materials, and operational systems. Typically alphanumeric identifier following property naming conventions.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the wellness program including objectives, daily schedule overview, expected outcomes, and unique features. Used in marketing collateral and guest communications.',
    `program_image_url` STRING COMMENT 'URL to the primary marketing image or hero photo for the wellness program. Used in digital marketing, website display, and booking confirmation materials.',
    `program_name` STRING COMMENT 'Marketing name of the wellness program as displayed to guests in brochures, websites, and booking channels.',
    `program_price` DECIMAL(18,2) COMMENT 'Base price for the complete wellness program package per guest. Excludes taxes, gratuities, and optional add-on services. Used for revenue forecasting and yield management.',
    `program_type` STRING COMMENT 'Classification of the wellness program by its primary therapeutic or wellness focus. Determines the program structure, included services, and target guest segment.. Valid values are `detox|weight_management|stress_relief|sleep_optimization|fitness_bootcamp|mindfulness_retreat`',
    `revenue_center_code` STRING COMMENT 'Code identifying the revenue center or department to which wellness program revenue is allocated. Aligns with Uniform System of Accounts for the Lodging Industry (USALI) chart of accounts.. Valid values are `^[A-Z0-9]{2,6}$`',
    `season_type` STRING COMMENT 'Indicates the seasonal availability pattern of the wellness program. Aligns with property occupancy patterns and demand forecasting.. Valid values are `year_round|peak_season|shoulder_season|off_season|summer_only|winter_only`',
    `target_guest_segment` STRING COMMENT 'Primary guest demographic or psychographic segment this wellness program is designed for (e.g., corporate executives, wellness enthusiasts, couples, solo travelers). Guides marketing and distribution strategies.',
    CONSTRAINT pk_wellness_program PRIMARY KEY(`wellness_program_id`)
) COMMENT 'Master record for multi-day or recurring structured wellness programs offered at resort and destination spa properties. Captures program name, program code, program type (detox, weight management, stress relief, sleep optimization, fitness bootcamp, mindfulness retreat), duration in days, minimum stay requirement, included treatments list, included fitness sessions, dietary component flag, medical supervision required flag, minimum participants, maximum participants, program price, property availability, and active status. Supports destination spa and wellness retreat revenue streams.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` (
    `program_treatment_id` BIGINT COMMENT 'Unique identifier for this program-treatment inclusion record. Primary key.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to the specific spa treatment included in the program',
    `wellness_program_id` BIGINT COMMENT 'Foreign key linking to the wellness program that includes this treatment',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-treatment inclusion was created in the system',
    `day_number` STRING COMMENT 'The day within the multi-day wellness program when this treatment is scheduled (e.g., Day 1, Day 3). Used for program sequencing and guest itinerary generation.',
    `frequency_per_week` STRING COMMENT 'Number of times this treatment is delivered per week within the program for programs spanning multiple weeks. Used for recurring wellness programs.',
    `included_treatments_list` STRING COMMENT 'Comma-separated list of treatment codes or names included in the wellness program package. References spa treatment catalog for detailed service descriptions. [Moved from wellness_program: This STRING field currently stores a comma-separated list of treatments in wellness_program. This denormalized representation should be replaced by the structured program_treatment association, which allows proper relational querying, scheduling, and therapeutic sequencing with granular attributes per treatment inclusion.]',
    `optional_flag` BOOLEAN COMMENT 'Indicates whether this treatment is mandatory or optional within the program. Optional treatments allow guest customization while maintaining program integrity.',
    `pre_treatment_requirements` STRING COMMENT 'Specific preparation or prerequisites required before this treatment within the program context (e.g., fasting 2 hours, hydration protocol, prior consultation). Used for guest communication and compliance.',
    `sequence_within_day` STRING COMMENT 'The order in which this treatment occurs within the specified day when multiple treatments are scheduled (e.g., 1=morning, 2=afternoon). Used for scheduling and therapist allocation.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the guest can substitute this treatment with an alternative of similar therapeutic value and duration. Used for personalization and contraindication management.',
    `therapeutic_goal` STRING COMMENT 'The specific therapeutic objective this treatment serves within the overall program (e.g., deep tissue release, stress reduction, detoxification support). Used for outcome tracking and medical supervision.',
    `treatment_duration_minutes` STRING COMMENT 'Duration in minutes for this treatment within the program context. May differ from the standard treatment duration to accommodate program pacing and therapeutic goals.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-treatment inclusion was last modified',
    CONSTRAINT pk_program_treatment PRIMARY KEY(`program_treatment_id`)
) COMMENT 'This association product represents the structured inclusion of spa treatments within multi-day wellness programs at destination spa and resort properties. It captures the therapeutic sequencing, scheduling, and delivery specifications for each treatment within a program. Each record links one wellness program to one treatment with attributes that define when, how often, and under what therapeutic context the treatment is delivered as part of the structured wellness experience.. Existence Justification: In destination spa and wellness resort operations, wellness programs are structured multi-day therapeutic experiences that include multiple carefully sequenced treatments, and individual treatments are reused across different wellness programs with varying therapeutic contexts. The business actively manages the inclusion, sequencing, and delivery specifications of treatments within programs - this is not a simple reference but a core operational entity managed by wellness directors and medical supervisors for program design, guest scheduling, and therapeutic outcome tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` (
    `package_treatment_id` BIGINT COMMENT 'Unique identifier for this package-treatment association record. Primary key.',
    `primary_package_id` BIGINT COMMENT 'Foreign key linking to the spa package that contains this treatment component',
    `treatment_id` BIGINT COMMENT 'Foreign key to treatment. Part of the many-to-many relationship.',
    `day_number` STRING COMMENT 'For multi-day packages, indicates which day this treatment is scheduled. Null for single-day packages. Explicitly identified in detection phase.',
    `effective_end_date` DATE COMMENT 'Date when this treatment was removed from the package composition. Null if currently active. Supports historical tracking of package evolution.',
    `effective_start_date` DATE COMMENT 'Date when this treatment was added to the package composition. Supports historical tracking of package evolution.',
    `included_treatments` STRING COMMENT 'Comma-separated or structured list of treatment codes or names included in the package. Defines the service bundle composition. [Moved from spa_package: This STRING field currently stores a comma-separated list of treatments, which is a denormalized representation of the many-to-many relationship. Moving to the association table enables structured querying, proper referential integrity, and relationship-specific attributes like sequence and duration overrides.]',
    `is_active` BOOLEAN COMMENT 'Indicates whether this treatment is currently active in the package composition. Supports package evolution without losing historical composition data.',
    `optional_flag` BOOLEAN COMMENT 'Indicates whether this treatment is optional (guest can choose from alternatives) or mandatory in the package. Supports customizable package offerings. Explicitly identified in detection phase.',
    `quantity` STRING COMMENT 'Number of times this treatment is included in the package (e.g., 2 massages in a day spa package). Explicitly identified in detection phase.',
    `sequence_number` STRING COMMENT 'Order in which this treatment is performed within the package. Used for scheduling, guest communication, and therapist workflow. Explicitly identified in detection phase.',
    `time_of_day_preference` STRING COMMENT 'Recommended or required time of day for this treatment within the package (morning, afternoon, evening, flexible). Used for scheduling optimization and guest experience design. Explicitly identified in detection phase.',
    `treatment_duration_minutes` STRING COMMENT 'Duration override for this treatment when delivered as part of this package. May differ from the standard treatment duration due to package-specific modifications or time constraints. Explicitly identified in detection phase.',
    `upgrade_available_flag` BOOLEAN COMMENT 'Indicates whether the guest can upgrade this treatment to a premium version for an additional fee. Supports upsell opportunities. Explicitly identified in detection phase.',
    `package_id` BIGINT COMMENT '',
    `spa_package_id` BIGINT COMMENT '',
    CONSTRAINT pk_package_treatment PRIMARY KEY(`package_treatment_id`)
) COMMENT 'This association product represents the composition relationship between spa packages and their constituent treatments. It captures the operational design of spa packages by defining which treatments are included, their sequence, duration overrides, quantity, and optionality. Each record links one spa_package to one treatment with attributes that exist only in the context of this package composition. This is actively managed by spa operations teams during package design, pricing, and menu management.. Existence Justification: Spa packages are composed of multiple treatments (e.g., a Day Spa Retreat includes massage, facial, body wrap), and each treatment can be included in multiple different packages (e.g., Swedish Massage appears in couples packages, wellness programs, and day spa offerings). Spa operations teams actively design and manage these package compositions, defining treatment sequences, duration overrides, quantities, and optionality as part of package design and pricing workflows.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`product` (
    `product_id` BIGINT COMMENT 'Primary key for product',
    `brand_id` BIGINT COMMENT 'FK to marketing.brand',
    `material_master_id` BIGINT COMMENT 'add column material_master_id (BIGINT) with FK to procurement.material_master.material_master_id - spa products need linkage to material master for inventory and procurement reconciliation.',
    `parent_product_id` BIGINT COMMENT 'Self-referencing FK on product (parent_product_id)',
    `product_line_id` BIGINT COMMENT 'Identifier linking the product to a broader product line or collection (e.g., signature wellness collection, luxury skincare line).',
    `property_id` BIGINT COMMENT 'Identifier of the hotel, resort, or property where this spa product is offered.',
    `vendor_id` BIGINT COMMENT 'FK to procurement.vendor',
    `base_price` DECIMAL(18,2) COMMENT 'Standard retail or service price for the product in the propertys base currency before discounts, taxes, or gratuities.',
    `booking_lead_time_hours` STRING COMMENT 'Minimum advance notice required for booking this treatment, in hours.',
    `cancellation_policy_hours` STRING COMMENT 'Number of hours before the appointment that a guest must cancel to avoid cancellation fees.',
    `product_category` STRING COMMENT 'High-level classification of the product type within spa operations.',
    `product_code` STRING COMMENT 'Unique business identifier code for the spa product used in catalogs, point-of-sale systems, and inventory management.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to therapists or sales staff for this product, expressed as a decimal (e.g., 15.00 for 15%).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price.',
    `product_description` STRING COMMENT 'Detailed description of the spa product, treatment, or service including benefits, techniques, and guest experience details.',
    `duration_minutes` STRING COMMENT 'Standard duration of the treatment or service in minutes. Null for retail products.',
    `effective_end_date` DATE COMMENT 'Date when the product is no longer available for booking or sale. Null for products with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when the product becomes available for booking or sale.',
    `equipment_required` STRING COMMENT 'Specialized equipment or apparatus required to deliver the treatment (e.g., vichy shower, infrared sauna, cryotherapy chamber).',
    `gender_restriction` STRING COMMENT 'Gender-specific restriction for treatments or facility access, if applicable.',
    `gift_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether the product can be purchased as or redeemed with a gift certificate.',
    `gratuity_eligible_flag` BOOLEAN COMMENT 'Indicates whether the product is eligible for automatic or suggested gratuity calculations.',
    `inventory_tracked_flag` BOOLEAN COMMENT 'Indicates whether the product requires inventory tracking (typically true for retail products, false for services).',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest when purchasing or booking this product.',
    `member_price` DECIMAL(18,2) COMMENT 'Discounted price available to loyalty program members or spa membership holders.',
    `minimum_age_requirement` STRING COMMENT 'Minimum guest age required to receive the treatment or purchase the product, for safety and regulatory compliance.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the product record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was last modified.',
    `product_name` STRING COMMENT 'Full name of the spa product, treatment, or retail item as displayed to guests and staff.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether the product can be booked through online channels (website, mobile app).',
    `product_status` STRING COMMENT 'Current lifecycle status of the product indicating availability for booking or sale.',
    `product_type` STRING COMMENT 'Detailed classification of the product within its category (e.g., massage, facial, body treatment, skincare, wellness supplement).',
    `room_type_required` STRING COMMENT 'Type of treatment room or facility required to deliver the service (e.g., massage room, facial suite, hydrotherapy room, couples suite).',
    `seasonal_availability` STRING COMMENT 'Specific seasons or months when the product is available (e.g., summer only, winter wellness package).',
    `short_description` STRING COMMENT 'Brief summary of the product for use in menus, mobile applications, and point-of-sale displays.',
    `stock_keeping_unit` STRING COMMENT 'Unique inventory identifier for retail products used in warehouse and inventory management systems.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether the product is subject to sales tax or value-added tax (VAT).',
    `therapist_certification_required` STRING COMMENT 'Specific professional certification or training required for therapists to perform this treatment (e.g., licensed massage therapist, esthetician, aromatherapist).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for retail product inventory and sales tracking.',
    CONSTRAINT pk_product PRIMARY KEY(`product_id`)
) COMMENT 'Master reference table for product. Referenced by product_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` (
    `group_booking_id` BIGINT COMMENT 'Primary key for group_booking',
    `employee_id` BIGINT COMMENT 'Reference to the sales manager or group coordinator responsible for managing this booking.',
    `program_config_id` BIGINT COMMENT 'Reference to the loyalty program associated with the lead guest or organization for points accrual and benefits.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where the group booking is scheduled.',
    `rebooked_group_booking_id` BIGINT COMMENT 'Self-referencing FK on group_booking (rebooked_group_booking_id)',
    `arrival_date` DATE COMMENT 'Scheduled date when the group is expected to arrive at the property.',
    `billing_address` STRING COMMENT 'Full billing address for invoicing and payment processing for the group booking.',
    `booking_date` DATE COMMENT 'Date when the group booking was initially created or placed in the system.',
    `booking_name` STRING COMMENT 'Descriptive name or title for the group booking, typically reflecting the event, organization, or purpose of the group visit.',
    `booking_number` STRING COMMENT 'Externally-visible unique booking reference number assigned to the group reservation for tracking and communication purposes.',
    `booking_source` STRING COMMENT 'Channel or origin through which the group booking was received.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the group booking indicating its progression through the reservation workflow.',
    `booking_type` STRING COMMENT 'Classification of the group booking based on the nature and purpose of the group visit.',
    `cancellation_policy` STRING COMMENT 'Description of the cancellation terms and conditions applicable to this group booking.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason provided for the cancellation of the group booking.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the group booking was cancelled, if applicable.',
    `catering_required` BOOLEAN COMMENT 'Indicates whether the group booking includes catering or food and beverage services.',
    `confirmation_date` DATE COMMENT 'Date when the group booking was officially confirmed by the property or booking coordinator.',
    `contract_document_url` STRING COMMENT 'Reference link or storage location for the signed group booking contract document.',
    `contract_signed_date` DATE COMMENT 'Date when the group booking contract was signed by both parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this group booking record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this booking.',
    `cutoff_date` DATE COMMENT 'Date by which individual room reservations within the group block must be finalized or released back to general inventory.',
    `departure_date` DATE COMMENT 'Scheduled date when the group is expected to depart from the property.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Amount of deposit paid or required to secure the group booking.',
    `deposit_due_date` DATE COMMENT 'Date by which the deposit payment is required to maintain the booking.',
    `event_space_required` BOOLEAN COMMENT 'Indicates whether the group booking includes requirements for meeting rooms, ballrooms, or event spaces.',
    `lead_guest_email` STRING COMMENT 'Primary email address of the lead guest for booking correspondence and confirmations.',
    `lead_guest_name` STRING COMMENT 'Full name of the primary contact or lead guest responsible for the group booking.',
    `lead_guest_phone` STRING COMMENT 'Primary contact phone number for the lead guest or group coordinator.',
    `market_segment` STRING COMMENT 'Market segment classification for revenue management and reporting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this group booking record was last updated or modified.',
    `notes` STRING COMMENT 'Internal operational notes and comments related to the group booking for staff reference.',
    `number_of_guests` STRING COMMENT 'Total count of individual guests included in the group booking.',
    `number_of_rooms` STRING COMMENT 'Total count of guest rooms allocated or reserved for the group booking.',
    `organization_name` STRING COMMENT 'Name of the company, institution, or organization associated with the group booking.',
    `payment_terms` STRING COMMENT 'Description of payment terms and schedule agreed upon for the group booking.',
    `rate_code` STRING COMMENT 'Pricing rate code or plan applied to the group booking for room and service pricing.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requirements, preferences, or requests from the group organizer.',
    `total_ancillary_revenue` DECIMAL(18,2) COMMENT 'Total anticipated or actual revenue from ancillary services such as spa, dining, events, and activities associated with the group booking.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Total anticipated or actual revenue from room accommodations for the group booking.',
    `transportation_required` BOOLEAN COMMENT 'Indicates whether the group requires transportation services such as airport transfers or shuttle services.',
    CONSTRAINT pk_group_booking PRIMARY KEY(`group_booking_id`)
) COMMENT 'Master reference table for group_booking. Referenced by group_booking_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` (
    `retail_product_id` BIGINT COMMENT 'Primary key for retail_product',
    `parent_retail_product_id` BIGINT COMMENT 'Self-referencing FK on retail_product (parent_retail_product_id)',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - retail products are stocked at property level.',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier or vendor providing this retail product.',
    `allergen_information` STRING COMMENT 'Known allergens or sensitivity warnings associated with the product ingredients.',
    `barcode` STRING COMMENT 'Universal Product Code (UPC), European Article Number (EAN), or other barcode identifier for point-of-sale scanning.',
    `brand_name` STRING COMMENT 'Manufacturer or brand name of the retail product (e.g., luxury skincare brands, wellness product lines).',
    `retail_product_category` STRING COMMENT 'Primary classification of the retail product by type of spa or wellness merchandise.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether sales of this product qualify for therapist or staff sales commission.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to staff on sales of this product, if commission eligible.',
    `cost_price` DECIMAL(18,2) COMMENT 'Wholesale or acquisition cost per unit paid to the supplier or manufacturer.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the product is manufactured or sourced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail product record was first created in the system.',
    `cruelty_free` BOOLEAN COMMENT 'Indicates whether the product is certified as not tested on animals.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing (e.g., USD, EUR, GBP).',
    `retail_product_description` STRING COMMENT 'Detailed description of the retail product including benefits, ingredients, usage instructions, and guest-facing marketing content.',
    `discontinuation_date` DATE COMMENT 'Date when the product was or will be removed from active sales, if applicable.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the product package in centimeters.',
    `image_url` STRING COMMENT 'Web address or file path to the primary product image for display in digital channels and point-of-sale systems.',
    `ingredients` STRING COMMENT 'List of ingredients or components contained in the product, particularly important for skincare and wellness items for allergy and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail product record was most recently updated.',
    `launch_date` DATE COMMENT 'Date when the product was first introduced into the spa retail catalog.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the product package in centimeters.',
    `loyalty_points` STRING COMMENT 'Number of loyalty program points awarded to guests upon purchase of this product.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures or produces the retail product.',
    `minimum_stock_level` STRING COMMENT 'Minimum inventory quantity threshold that triggers reorder alerts for the product.',
    `organic_certified` BOOLEAN COMMENT 'Indicates whether the product has organic certification from a recognized certifying body.',
    `package_size` STRING COMMENT 'Size or volume of the product package (e.g., 50ml, 8oz, 100g) including the unit.',
    `product_code` STRING COMMENT 'Unique business identifier or SKU (Stock Keeping Unit) for the retail product used in inventory and point-of-sale systems.',
    `product_name` STRING COMMENT 'Full commercial name of the retail product as displayed to guests and in sales systems.',
    `product_type` STRING COMMENT 'Classification indicating the merchandising purpose or sales channel designation of the product.',
    `reorder_quantity` STRING COMMENT 'Standard quantity to order when restocking the product.',
    `retail_product_status` STRING COMMENT 'Current lifecycle status of the retail product in the spa retail catalog.',
    `seasonal_product` BOOLEAN COMMENT 'Indicates whether the product is available only during specific seasons or holiday periods.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains usable and saleable from the manufacturing or receipt date.',
    `short_description` STRING COMMENT 'Abbreviated description of the product for use in point-of-sale displays, receipts, and mobile applications.',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for the product (e.g., refrigeration, temperature range, humidity control).',
    `subcategory` STRING COMMENT 'Secondary classification providing more granular segmentation within the primary category (e.g., facial moisturizer, body lotion, essential oils).',
    `tax_category` STRING COMMENT 'Tax classification determining applicable sales tax or VAT (Value Added Tax) rate for the product.',
    `unit_of_measure` STRING COMMENT 'Standard unit by which the product is sold and inventoried (e.g., each, milliliters, ounces).',
    `unit_price` DECIMAL(18,2) COMMENT 'Standard retail selling price per unit of the product before any discounts or promotions.',
    `vegan` BOOLEAN COMMENT 'Indicates whether the product contains no animal-derived ingredients or by-products.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the product in kilograms, used for shipping and logistics calculations.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the product package in centimeters.',
    CONSTRAINT pk_retail_product PRIMARY KEY(`retail_product_id`)
) COMMENT 'Master reference table for retail_product. Referenced by retail_product_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` (
    `product_line_id` BIGINT COMMENT 'Primary key for product_line',
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to marketing.brand.brand_id - product lines are tied to brands for retail merchandising.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this product line record. Used for audit and accountability purposes.',
    `parent_product_line_id` BIGINT COMMENT 'Self-referencing FK on product_line (parent_product_line_id)',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - product lines need property scope for property-level merchandising.',
    `vendor_id` BIGINT COMMENT 'Reference to the primary vendor or supplier providing products or services within this product line.',
    `advance_booking_days_maximum` STRING COMMENT 'Maximum number of days in advance that bookings can be made for this product line. Controls booking window for capacity management.',
    `advance_booking_days_minimum` STRING COMMENT 'Minimum number of days in advance that bookings can be made for this product line. Used for operational planning and staffing.',
    `base_price_amount` DECIMAL(18,2) COMMENT 'Standard base price for products or services in this line before property-specific adjustments, discounts, or member pricing. Used as reference for revenue management and pricing strategy.',
    `cancellation_policy_hours` STRING COMMENT 'Number of hours advance notice required for cancellation without penalty. Used for booking management and revenue protection policies.',
    `product_line_category` STRING COMMENT 'Primary category classification for the product line within spa and wellness operations. Determines operational workflows, staffing requirements, and revenue reporting segments.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether sales of this product line are eligible for therapist, spa attendant, or sales associate commission calculations.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate percentage applied to sales within this product line when commission_eligible_flag is true. Used for staff compensation calculations.',
    `cost_center_code` STRING COMMENT 'Accounting cost center code to which expenses and revenues for this product line are allocated. Used for departmental P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product line record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price amount. Supports multi-currency operations across global properties.',
    `effective_end_date` DATE COMMENT 'Date when the product line is no longer available for new bookings or purchases. Nullable for ongoing product lines.',
    `effective_start_date` DATE COMMENT 'Date when the product line becomes available for guest bookings and purchases. Used for seasonal offerings and new product launches.',
    `equipment_requirements` STRING COMMENT 'Specialized equipment or supplies required to deliver services or products in this line. Used for facility planning and operational readiness assessments.',
    `facility_type_required` STRING COMMENT 'Type of facility or treatment room required to deliver services in this product line. Examples: private treatment room, couples suite, hydrotherapy room, fitness studio, outdoor pavilion.',
    `gender_restriction` STRING COMMENT 'Gender-based access restrictions for this product line, if any. Used for facilities with gender-separated areas or culturally-specific service offerings.',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code for revenue recognition from this product line. Supports financial consolidation and compliance reporting.',
    `gift_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether products or services in this line can be purchased as gift certificates or included in spa packages.',
    `inventory_managed_flag` BOOLEAN COMMENT 'Indicates whether products in this line require inventory tracking and stock management. True for retail products, false for services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product line record was most recently updated. Supports change tracking and data governance processes.',
    `line_code` STRING COMMENT 'Unique business code identifying the product line across spa operations. Used for catalog references, inventory management, and point-of-sale systems.',
    `line_description` STRING COMMENT 'Detailed description of the product line, including its purpose, target guest segments, and key differentiators. Used for marketing and staff training materials.',
    `line_name` STRING COMMENT 'Full business name of the product line as displayed in catalogs, menus, and guest-facing materials.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base loyalty points earned for purchases or bookings within this product line. Supports promotional campaigns and member engagement strategies.',
    `minimum_age_requirement` STRING COMMENT 'Minimum guest age in years required to book or purchase products in this line. Used for compliance with health regulations and facility policies.',
    `notes` STRING COMMENT 'Free-form notes field for additional operational information, special instructions, or internal comments about the product line.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book services in this product line through online channels. Controls digital booking system availability.',
    `package_component_eligible_flag` BOOLEAN COMMENT 'Indicates whether this product line can be included as a component in bundled spa packages or wellness programs.',
    `product_line_status` STRING COMMENT 'Current lifecycle status of the product line. Controls availability for booking, purchasing, and operational planning.',
    `requires_medical_clearance_flag` BOOLEAN COMMENT 'Indicates whether guests must provide medical clearance or complete health questionnaires before booking services in this product line. Critical for liability management.',
    `revenue_category` STRING COMMENT 'Financial reporting category for revenue generated by this product line. Aligns with property-level and corporate financial reporting structures.',
    `seasonal_availability` STRING COMMENT 'Seasonal availability pattern for this product line. Examples: year-round, summer only, winter only, holiday season. Used for menu planning and marketing campaigns.',
    `service_duration_minutes` STRING COMMENT 'Standard duration in minutes for services within this product line. Used for therapist scheduling, appointment booking, and capacity planning. Null for retail product lines.',
    `subcategory` STRING COMMENT 'Secondary classification providing granular segmentation within the primary category. Examples: massage therapy, facial treatments, body treatments, aromatherapy products, fitness equipment.',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether products in this line carry recognized sustainability or eco-friendly certifications. Used for ESG reporting and green marketing initiatives.',
    `target_guest_segment` STRING COMMENT 'Primary guest demographic or psychographic segment targeted by this product line. Examples: luxury travelers, wellness enthusiasts, families, corporate groups, spa members.',
    `tax_category` STRING COMMENT 'Tax classification category for products or services in this line. Determines applicable sales tax, VAT, or service charge calculations based on jurisdiction.',
    `therapist_certification_required` STRING COMMENT 'Specific professional certifications or licenses required for staff to deliver services in this product line. Examples: licensed massage therapist, certified yoga instructor, personal trainer certification.',
    CONSTRAINT pk_product_line PRIMARY KEY(`product_line_id`)
) COMMENT 'Master reference table for product_line. Referenced by product_line_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_parent_treatment_id` FOREIGN KEY (`parent_treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_superseded_treatment_menu_id` FOREIGN KEY (`superseded_treatment_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_supervisor_therapist_id` FOREIGN KEY (`supervisor_therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ADD CONSTRAINT `fk_spa_spa_therapist_certification_renewed_spa_therapist_certification_id` FOREIGN KEY (`renewed_spa_therapist_certification_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification`(`spa_therapist_certification_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ADD CONSTRAINT `fk_spa_spa_therapist_certification_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_parent_spa_facility_id` FOREIGN KEY (`parent_spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_adjoining_treatment_room_id` FOREIGN KEY (`adjoining_treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_rescheduled_appointment_id` FOREIGN KEY (`rescheduled_appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_parent_appointment_package_id` FOREIGN KEY (`parent_appointment_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment_package`(`appointment_package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_parent_package_id` FOREIGN KEY (`parent_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_original_therapist_schedule_id` FOREIGN KEY (`original_therapist_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`(`therapist_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_prior_intake_form_id` FOREIGN KEY (`prior_intake_form_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`intake_form`(`intake_form_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_primary_original_charge_id` FOREIGN KEY (`primary_original_charge_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`charge`(`charge_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_product_id` FOREIGN KEY (`product_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`product`(`product_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_primary_original_transaction_retail_transaction_id` FOREIGN KEY (`primary_original_transaction_retail_transaction_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`retail_transaction`(`retail_transaction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_adjustment_retail_inventory_id` FOREIGN KEY (`adjustment_retail_inventory_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`retail_inventory`(`retail_inventory_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_retail_product_id` FOREIGN KEY (`retail_product_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`retail_product`(`retail_product_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_renewed_membership_id` FOREIGN KEY (`renewed_membership_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership`(`membership_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership`(`membership_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_prior_membership_visit_id` FOREIGN KEY (`prior_membership_visit_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership_visit`(`membership_visit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_renewed_day_pass_id` FOREIGN KEY (`renewed_day_pass_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`day_pass`(`day_pass_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_parent_fitness_class_id` FOREIGN KEY (`parent_fitness_class_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_rescheduled_fitness_class_session_id` FOREIGN KEY (`rescheduled_fitness_class_session_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`(`fitness_class_session_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_fitness_class_session_id` FOREIGN KEY (`fitness_class_session_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`(`fitness_class_session_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership`(`membership_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_transferred_spa_class_enrollment_id` FOREIGN KEY (`transferred_spa_class_enrollment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment`(`spa_class_enrollment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_rescheduled_golf_tee_time_id` FOREIGN KEY (`rescheduled_golf_tee_time_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time`(`golf_tee_time_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_product_id` FOREIGN KEY (`product_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`product`(`product_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_superseded_amenity_pricing_id` FOREIGN KEY (`superseded_amenity_pricing_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing`(`amenity_pricing_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_original_cancellation_log_id` FOREIGN KEY (`original_cancellation_log_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`cancellation_log`(`cancellation_log_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_replaced_equipment_id` FOREIGN KEY (`replaced_equipment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_prerequisite_wellness_program_id` FOREIGN KEY (`prerequisite_wellness_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ADD CONSTRAINT `fk_spa_program_treatment_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ADD CONSTRAINT `fk_spa_program_treatment_wellness_program_id` FOREIGN KEY (`wellness_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ADD CONSTRAINT `fk_spa_package_treatment_primary_package_id` FOREIGN KEY (`primary_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ADD CONSTRAINT `fk_spa_package_treatment_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_parent_product_id` FOREIGN KEY (`parent_product_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`product`(`product_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_product_line_id` FOREIGN KEY (`product_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`product_line`(`product_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ADD CONSTRAINT `fk_spa_group_booking_rebooked_group_booking_id` FOREIGN KEY (`rebooked_group_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`group_booking`(`group_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ADD CONSTRAINT `fk_spa_retail_product_parent_retail_product_id` FOREIGN KEY (`parent_retail_product_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`retail_product`(`retail_product_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ADD CONSTRAINT `fk_spa_product_line_parent_product_line_id` FOREIGN KEY (`parent_product_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`product_line`(`product_line_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`spa` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`spa` SET TAGS ('dbx_domain' = 'spa');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `advance_booking_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_business_glossary_term' = 'Treatment Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_value_regex' = 'massage|facial|body_treatment|hydrotherapy|nail_service|beauty_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (Percent)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `contraindications` SET TAGS ('dbx_business_glossary_term' = 'Treatment Contraindications');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `cost_of_goods` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods (COGS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `cost_of_goods` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Gender Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_value_regex' = 'any|male_only|female_only|couples');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `gratuity_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Included Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `minimum_certification` SET TAGS ('dbx_business_glossary_term' = 'Minimum Therapist Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `pregnancy_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Safe Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `recommended_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Retail Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `retail_products_used` SET TAGS ('dbx_business_glossary_term' = 'Retail Products Used');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `revenue_center` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `revenue_center` SET TAGS ('dbx_value_regex' = 'spa|wellness|fitness|salon|recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `room_type_required` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Type Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_business_glossary_term' = 'Therapist Skill Level Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Treatment Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `upsell_treatments` SET TAGS ('dbx_business_glossary_term' = 'Recommended Upsell Treatments');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Treatment Menu Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `booking_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `gift_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Certificate Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_brochure_url` SET TAGS ('dbx_business_glossary_term' = 'Menu Brochure URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_brochure_url` SET TAGS ('dbx_value_regex' = '^https?://.*.pdf$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_business_glossary_term' = 'Menu Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_description` SET TAGS ('dbx_business_glossary_term' = 'Menu Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_image_url` SET TAGS ('dbx_business_glossary_term' = 'Menu Image URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_business_glossary_term' = 'Menu Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_type` SET TAGS ('dbx_business_glossary_term' = 'Menu Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_version` SET TAGS ('dbx_business_glossary_term' = 'Menu Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `menu_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `minimum_advance_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `pricing_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Override Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `published_status` SET TAGS ('dbx_business_glossary_term' = 'Published Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `published_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|suspended|under_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Season Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'peak|off_peak|shoulder|holiday|year_round');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `supervisor_therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Therapist Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `supervisor_therapist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `availability_schedule` SET TAGS ('dbx_business_glossary_term' = 'Availability Schedule');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master|director');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_code` SET TAGS ('dbx_business_glossary_term' = 'Therapist Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Therapist Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|contractor|seasonal|on-call');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist First Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Therapist Gender');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `guest_rating_average` SET TAGS ('dbx_business_glossary_term' = 'Guest Rating Average');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Therapist Hire Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist Last Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `max_appointments_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointments Per Day');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `next_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Therapist Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Therapist Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist Preferred Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Primary License Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_business_glossary_term' = 'Primary License Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_business_glossary_term' = 'Primary License State');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Secondary License Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_number` SET TAGS ('dbx_business_glossary_term' = 'Secondary License Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_state` SET TAGS ('dbx_business_glossary_term' = 'Secondary License State');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `secondary_license_state` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `specializations` SET TAGS ('dbx_business_glossary_term' = 'Therapist Specializations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Therapist Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_business_glossary_term' = 'Therapist Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on-leave|suspended|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `tip_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tip Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `total_appointments_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Appointments Completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `spa_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `renewed_spa_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Spa Therapist Certification Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `renewed_spa_therapist_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master|instructor');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `is_brand_required` SET TAGS ('dbx_business_glossary_term' = 'Is Brand Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `is_primary_certification` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Certification Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `is_state_required` SET TAGS ('dbx_business_glossary_term' = 'Is State Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'current|pending_renewal|expired|suspended|revoked|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'online_registry|phone_verification|document_review|third_party_service|not_verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Assessment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `parent_spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Spa Facility Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `parent_spa_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_ssot_owner' = 'property.property_facility');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_ssot_entity' = 'facility');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `average_daily_visitors` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Visitors');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `certification_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Certification and Accreditation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_renovation|temporarily_closed|seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'spa|fitness_center|golf_course|pool|tennis_court|salon');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `fire_safety_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Compliance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'co_ed|female_only|male_only|gender_neutral');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `guest_access_policy` SET TAGS ('dbx_business_glossary_term' = 'Guest Access Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `guest_access_policy` SET TAGS ('dbx_value_regex' = 'hotel_guests_only|members_only|public_access|day_pass_available');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Compliance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `locker_room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Locker Room Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `next_scheduled_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_friday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Friday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_friday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_monday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Monday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_monday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Saturday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Sunday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_thursday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Thursday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_thursday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_tuesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Tuesday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_tuesday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_wednesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Wednesday');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_wednesday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `outdoor_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Space Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `peak_season_months` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `relaxation_lounge_capacity` SET TAGS ('dbx_business_glossary_term' = 'Relaxation Lounge Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `reservation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reservation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `retail_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Retail Area Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Close Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Open Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `seasonal_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Operation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_business_glossary_term' = 'Total Treatment Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `wet_area_capacity` SET TAGS ('dbx_business_glossary_term' = 'Wet Area Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Adjoining Treatment Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `ambiance_features` SET TAGS ('dbx_business_glossary_term' = 'Ambiance Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Equipment List');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `ffe_value` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `ffe_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'male|female|unisex|private');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `has_chromotherapy` SET TAGS ('dbx_business_glossary_term' = 'Has Chromotherapy');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `has_heated_table` SET TAGS ('dbx_business_glossary_term' = 'Has Heated Table');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `has_music_system` SET TAGS ('dbx_business_glossary_term' = 'Has Music System');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `has_outdoor_access` SET TAGS ('dbx_business_glossary_term' = 'Has Outdoor Access');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `has_private_shower` SET TAGS ('dbx_business_glossary_term' = 'Has Private Shower');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|repair|renovation|inspection');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|temporarily_closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `room_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `room_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `sanitation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Protocol');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `sanitation_protocol` SET TAGS ('dbx_value_regex' = 'standard|enhanced|medical_grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `temperature_control_type` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `temperature_control_type` SET TAGS ('dbx_value_regex' = 'central_hvac|individual_thermostat|radiant_floor|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Booked By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Guest Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `rescheduled_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Appointment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `rescheduled_appointment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Party');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_value_regex' = 'guest|property|system|no-show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration in Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `external_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'External Booking Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_value_regex' = 'male|female|no-preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_notes` SET TAGS ('dbx_business_glossary_term' = 'Guest Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `guest_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `intake_form_completed` SET TAGS ('dbx_business_glossary_term' = 'Intake Form Completed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `intake_form_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intake Form Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `prepayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `prepayment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `prepayment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_business_glossary_term' = 'Pressure Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_value_regex' = 'light|medium|firm|extra-firm|no-preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Health Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Therapist Gender Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_value_regex' = 'male|female|no-preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `appointment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Booked By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `parent_appointment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Appointment Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `parent_appointment_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `addon_services_amount` SET TAGS ('dbx_business_glossary_term' = 'Add-On Services Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'web|mobile app|phone|front desk|concierge|in-room tablet');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|in-progress|completed|cancelled|no-show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `complimentary_amenities` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Amenities');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `guest_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `package_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Package Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `package_notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `package_price` SET TAGS ('dbx_business_glossary_term' = 'Package Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|paid|refunded|partially refunded|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'not started|partially redeemed|fully redeemed|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `parent_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `parent_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `amenities_included` SET TAGS ('dbx_business_glossary_term' = 'Amenities Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `cancellation_hours_notice` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Hours Notice');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'relaxation|therapeutic|beauty|fitness|wellness|specialty');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `deposit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deposit Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'none|male_only|female_only|couples_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `guest_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Guest Type Eligibility');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `guest_type_eligibility` SET TAGS ('dbx_value_regex' = 'all|hotel_guest|day_guest|member|loyalty_tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `loyalty_points_eligible` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `loyalty_points_value` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `maximum_party_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Party Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `minimum_advance_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `minimum_party_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Party Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued|pending_approval|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'day_spa|half_day|couples|wellness_program|golf_and_spa|resort_credit');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `promotional_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `property_availability` SET TAGS ('dbx_business_glossary_term' = 'Property Availability List');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `rack_rate` SET TAGS ('dbx_business_glossary_term' = 'Rack Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `requires_deposit` SET TAGS ('dbx_business_glossary_term' = 'Requires Deposit Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `retail_products_included` SET TAGS ('dbx_business_glossary_term' = 'Retail Products Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `service_charge_included` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Included Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `total_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Schedule ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `original_therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Original Therapist Schedule Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `original_therapist_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `actual_clock_in_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock In Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `actual_clock_out_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock Out Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `break_end_time` SET TAGS ('dbx_business_glossary_term' = 'Break End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `break_start_time` SET TAGS ('dbx_business_glossary_term' = 'Break Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Treatment Specialty');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `room_assignment` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|confirmed|cancelled|completed|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Treatment Slots');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'opening|mid|closing|on_call|split|double');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `total_available_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Available Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `total_booked_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Booked Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `intake_form_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Form ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `prior_intake_form_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Intake Form Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `prior_intake_form_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_business_glossary_term' = 'Allergy Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_business_glossary_term' = 'Areas to Avoid');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `aromatherapy_preference` SET TAGS ('dbx_business_glossary_term' = 'Aromatherapy Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_business_glossary_term' = 'Cardiovascular Condition Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_business_glossary_term' = 'Current Medications');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Acknowledgment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Acknowledgment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment_timestamp` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `form_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Form Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `form_number` SET TAGS ('dbx_value_regex' = '^IF-[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `form_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|rejected|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_business_glossary_term' = 'Allergies Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_business_glossary_term' = 'Cardiovascular Condition Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_previous_spa_experience` SET TAGS ('dbx_business_glossary_term' = 'Previous Spa Experience Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_business_glossary_term' = 'Recent Surgery Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_business_glossary_term' = 'Skin Condition Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `photography_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Photography Consent Given');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `photography_consent_given` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Trimester');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_value_regex' = 'first|second|third|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_business_glossary_term' = 'Pressure Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_value_regex' = 'light|medium|firm|very_firm|no_preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `previous_spa_experience_notes` SET TAGS ('dbx_business_glossary_term' = 'Previous Spa Experience Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_business_glossary_term' = 'Skin Condition Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|in_person_tablet|paper_form|email');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_business_glossary_term' = 'Surgery Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `therapist_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Therapist Review Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `therapist_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Therapist Reviewed Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Given');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Charge ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `primary_original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_date` SET TAGS ('dbx_business_glossary_term' = 'Charge Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_business_glossary_term' = 'Charge Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Charge Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'treatment|retail|membership|day_pass|gratuity|cancellation_fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `folio_reference` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Folio Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `gratuity_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Included Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Charge Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'room_charge|credit_card|cash|gift_card|loyalty_points|comp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|voided|adjusted|pending|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `retail_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `primary_original_transaction_retail_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `payment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'in_person|online|mobile_app|phone|concierge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|voided|refunded|pending|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `retail_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Inventory ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `adjustment_retail_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Retail Inventory Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `adjustment_retail_inventory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `retail_product_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Product ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `current_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|seasonal|on_hold|expired|recalled');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_physical_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sale Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `reorder_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Reorder Triggered Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|bottle|jar|tube|box|set');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Retail Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `renewed_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Membership Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `renewed_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `annual_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'member_request|payment_failure|relocation|dissatisfaction|health_reasons|cost_concerns');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `included_fitness_access` SET TAGS ('dbx_business_glossary_term' = 'Included Fitness Access');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `included_guest_passes` SET TAGS ('dbx_business_glossary_term' = 'Included Guest Passes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_business_glossary_term' = 'Included Treatment Credits');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'monthly|annual|corporate|complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `monthly_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{16,64}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_account|corporate_billing|room_charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mobile_app|postal_mail');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `promotional_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'basic|premium|elite|unlimited');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `membership_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Visit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `prior_membership_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Membership Visit Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `prior_membership_visit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Nps Response Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `additional_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Additional Service Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `credits_consumed` SET TAGS ('dbx_business_glossary_term' = 'Credits Consumed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `gratuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `guest_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `remaining_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Credit Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `retail_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Purchase Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `special_request` SET TAGS ('dbx_business_glossary_term' = 'Special Request');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|checked_in|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `day_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Day Pass ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `renewed_day_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Day Pass Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `renewed_day_pass_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `adult_count` SET TAGS ('dbx_business_glossary_term' = 'Adult Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `child_count` SET TAGS ('dbx_business_glossary_term' = 'Child Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `group_booking_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'local_resident|tourist|business_traveler|group_member|loyalty_member|non_member');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `package_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_date` SET TAGS ('dbx_business_glossary_term' = 'Day Pass Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_number` SET TAGS ('dbx_business_glossary_term' = 'Day Pass Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_status` SET TAGS ('dbx_business_glossary_term' = 'Day Pass Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_status` SET TAGS ('dbx_value_regex' = 'sold|active|expired|refunded|cancelled|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_type` SET TAGS ('dbx_business_glossary_term' = 'Day Pass Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `pass_type` SET TAGS ('dbx_value_regex' = 'spa_day_pass|pool_day_pass|fitness_day_pass|golf_day_pass|resort_amenity_pass|wellness_day_pass');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `valid_from_time` SET TAGS ('dbx_business_glossary_term' = 'Valid From Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ALTER COLUMN `valid_to_time` SET TAGS ('dbx_business_glossary_term' = 'Valid To Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `parent_fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fitness Class Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `parent_fitness_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `advance_booking_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `age_restriction_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_benefits` SET TAGS ('dbx_business_glossary_term' = 'Class Benefits');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Class Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Class Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_image_url` SET TAGS ('dbx_business_glossary_term' = 'Class Image URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Class Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Class Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|suspended|discontinued');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Class Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `class_type` SET TAGS ('dbx_business_glossary_term' = 'Class Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `contraindications` SET TAGS ('dbx_business_glossary_term' = 'Contraindications');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `equipment_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_level` SET TAGS ('dbx_business_glossary_term' = 'Fitness Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `fitness_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|all_levels');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `instructor_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Instructor Certification Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `intensity_level` SET TAGS ('dbx_business_glossary_term' = 'Intensity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `intensity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|variable');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `member_price` SET TAGS ('dbx_business_glossary_term' = 'Member Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `minimum_participants` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participants');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `pregnancy_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Safe Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_value_regex' = 'year_round|summer_only|winter_only|spring_fall|peak_season|off_season');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `fitness_class_session_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class Session ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `rescheduled_fitness_class_session_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Fitness Class Session Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `rescheduled_fitness_class_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `actual_attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `advance_booking_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'not_open|open|limited|closed|waitlist_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `class_format` SET TAGS ('dbx_business_glossary_term' = 'Class Format');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `class_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid|outdoor|poolside');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_business_glossary_term' = 'Difficulty Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|all_levels|adaptive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `enrolled_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `guest_segment` SET TAGS ('dbx_value_regex' = 'resort_guest|spa_member|day_pass|local_resident|loyalty_member|corporate_group');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `loyalty_points_value` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `revenue_center` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Session Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_name` SET TAGS ('dbx_business_glossary_term' = 'Session Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_price` SET TAGS ('dbx_business_glossary_term' = 'Session Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'group|private|semi_private|complimentary|premium|special_event');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ALTER COLUMN `waitlist_count` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_concept' = 'class_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_group' = 'class_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_canonical' = 'spa.spa_class_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `spa_class_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Class Enrollment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `fitness_class_session_id` SET TAGS ('dbx_business_glossary_term' = 'Class Session ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `guest_communication_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Communication Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Nps Response Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `transferred_spa_class_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Transferred Spa Class Enrollment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `transferred_spa_class_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `attendance_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Attendance Confirmed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `check_in_method` SET TAGS ('dbx_business_glossary_term' = 'Check-In Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `check_in_method` SET TAGS ('dbx_value_regex' = 'mobile_app|kiosk|staff_desk|instructor|automatic');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|waitlisted|cancelled|attended|no-show|confirmed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `folio_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Folio Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `guest_feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `guest_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `instructor_notes` SET TAGS ('dbx_business_glossary_term' = 'Instructor Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `no_show_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'No-Show Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `no_show_fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Fee Waived Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ALTER COLUMN `waitlist_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `golf_tee_time_id` SET TAGS ('dbx_business_glossary_term' = 'Golf Tee Time ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Booked By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Golf Course ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `rescheduled_golf_tee_time_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Golf Tee Time Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `rescheduled_golf_tee_time_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `caddie_fee_per_caddie` SET TAGS ('dbx_business_glossary_term' = 'Caddie Fee Per Caddie');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `caddie_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Caddie Requested Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'guest_request|weather|course_maintenance|overbooking|no_show|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `cart_fee_per_cart` SET TAGS ('dbx_business_glossary_term' = 'Cart Fee Per Cart');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `cart_rental_flag` SET TAGS ('dbx_business_glossary_term' = 'Cart Rental Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `club_rental_fee_per_set` SET TAGS ('dbx_business_glossary_term' = 'Club Rental Fee Per Set');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `club_rental_flag` SET TAGS ('dbx_business_glossary_term' = 'Club Rental Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Tee Time Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `green_fee_per_player` SET TAGS ('dbx_business_glossary_term' = 'Green Fee Per Player');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `number_of_caddies` SET TAGS ('dbx_business_glossary_term' = 'Number of Caddies');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `number_of_carts` SET TAGS ('dbx_business_glossary_term' = 'Number of Carts');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `number_of_club_sets` SET TAGS ('dbx_business_glossary_term' = 'Number of Club Sets');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `number_of_holes` SET TAGS ('dbx_business_glossary_term' = 'Number of Holes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `number_of_players` SET TAGS ('dbx_business_glossary_term' = 'Number of Players');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'room_charge|credit_card|cash|comp|voucher|member_account');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'rack|guest|member|twilight|promotional|tournament');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `tee_time` SET TAGS ('dbx_business_glossary_term' = 'Tee Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `tee_time_date` SET TAGS ('dbx_business_glossary_term' = 'Tee Time Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `tee_time_status` SET TAGS ('dbx_business_glossary_term' = 'Tee Time Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `tee_time_status` SET TAGS ('dbx_value_regex' = 'booked|confirmed|checked_in|completed|cancelled|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `total_charge` SET TAGS ('dbx_business_glossary_term' = 'Total Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ALTER COLUMN `weather_cancellation_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Cancellation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `amenity_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Pricing ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `superseded_amenity_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Amenity Pricing Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `superseded_amenity_pricing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `tertiary_amenity_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `tertiary_amenity_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `tertiary_amenity_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `day_of_week_applicability` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Applicability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `gift_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Certificate Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `gratuity_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Included Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `loyalty_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `loyalty_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `minimum_advance_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `pricing_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Rule Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `pricing_rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `pricing_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Rule Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `pricing_unit` SET TAGS ('dbx_business_glossary_term' = 'Pricing Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `time_of_day_end` SET TAGS ('dbx_business_glossary_term' = 'Time of Day End');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `time_of_day_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `time_of_day_start` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Start');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `time_of_day_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` SET TAGS ('dbx_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_log_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Log ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `original_cancellation_log_id` SET TAGS ('dbx_business_glossary_term' = 'Original Cancellation Log Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `original_cancellation_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `advance_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `appointment_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_channel` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_fee_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Waived Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_number` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_value_regex' = 'CANCELLATION|NO_SHOW|LATE_CANCELLATION');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancelled_by_party` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Party');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `cancelled_by_party` SET TAGS ('dbx_value_regex' = 'GUEST|STAFF|SYSTEM|PROPERTY');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `fee_waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `fee_waiver_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `guest_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Sent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `guest_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `late_cancellation_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Cancellation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `original_appointment_value` SET TAGS ('dbx_business_glossary_term' = 'Original Appointment Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `rebooking_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebooking Completed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `rebooking_offer_extended_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebooking Offer Extended Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `revenue_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recovery Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ALTER COLUMN `therapist_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Therapist Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` SET TAGS ('dbx_subdomain' = 'fitness_recreation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `pip_item_id` SET TAGS ('dbx_business_glossary_term' = 'Pip Item Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `replaced_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Equipment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `replaced_equipment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight line|declining balance|units of production|not applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|donated|recycled|scrapped|transferred');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `last_safety_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `next_safety_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Safety Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `next_service_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Service Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|under maintenance|out of service|decommissioned|pending installation|retired');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `power_requirements` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Purchase Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `safety_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `service_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Service Interval Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `usage_hours_total` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Dietary Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `prerequisite_wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Wellness Program Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `prerequisite_wellness_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `tertiary_wellness_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `tertiary_wellness_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `tertiary_wellness_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Program Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|discontinued');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Program Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `booking_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `dietary_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Dietary Component Included Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Program Duration in Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `included_fitness_sessions` SET TAGS ('dbx_business_glossary_term' = 'Included Fitness Sessions Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `medical_supervision_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Supervision Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `medical_supervision_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `medical_supervision_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `minimum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `minimum_participants` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participants Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `minimum_stay_nights` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement in Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Operational Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Bundling Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_brochure_url` SET TAGS ('dbx_business_glossary_term' = 'Program Brochure Document URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_image_url` SET TAGS ('dbx_business_glossary_term' = 'Program Marketing Image URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_price` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'detox|weight_management|stress_relief|sleep_optimization|fitness_bootcamp|mindfulness_retreat');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'year_round|peak_season|shoulder_season|off_season|summer_only|winter_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` SET TAGS ('dbx_association_edges' = 'spa.wellness_program,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `program_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Treatment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `program_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `program_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Treatment - Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Treatment - Wellness Program Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `day_number` SET TAGS ('dbx_business_glossary_term' = 'Program Day Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `frequency_per_week` SET TAGS ('dbx_business_glossary_term' = 'Weekly Treatment Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `included_treatments_list` SET TAGS ('dbx_business_glossary_term' = 'Included Treatments List');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Optional Treatment Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `pre_treatment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Pre-Treatment Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `pre_treatment_requirements` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `pre_treatment_requirements` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `sequence_within_day` SET TAGS ('dbx_business_glossary_term' = 'Daily Treatment Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Treatment Substitution Allowed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `therapeutic_goal` SET TAGS ('dbx_business_glossary_term' = 'Treatment Therapeutic Goal');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`program_treatment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` SET TAGS ('dbx_subdomain' = 'treatment_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` SET TAGS ('dbx_association_edges' = 'spa.spa_package,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `package_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment Component Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `package_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `package_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `primary_package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment - Spa Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `day_number` SET TAGS ('dbx_business_glossary_term' = 'Package Day Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `included_treatments` SET TAGS ('dbx_business_glossary_term' = 'Included Treatments List');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Optional Treatment Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Treatment Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Sequence Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `time_of_day_preference` SET TAGS ('dbx_business_glossary_term' = 'Treatment Time Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment Duration');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `treatment_duration_minutes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment` ALTER COLUMN `upgrade_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Available Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` SET TAGS ('dbx_numeric_type_normalized' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `parent_product_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `parent_product_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `booking_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Lead Time Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `gift_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Certificate Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `gratuity_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `inventory_tracked_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Tracked Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `member_price` SET TAGS ('dbx_business_glossary_term' = 'Member Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `room_type_required` SET TAGS ('dbx_business_glossary_term' = 'Room Type Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `stock_keeping_unit` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `therapist_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `group_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Config Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `rebooked_group_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Rebooked Group Booking Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `rebooked_group_booking_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `billing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_name` SET TAGS ('dbx_business_glossary_term' = 'Booking Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `booking_type` SET TAGS ('dbx_business_glossary_term' = 'Booking Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `catering_required` SET TAGS ('dbx_business_glossary_term' = 'Catering Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Url');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `event_space_required` SET TAGS ('dbx_business_glossary_term' = 'Event Space Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_email` SET TAGS ('dbx_business_glossary_term' = 'Lead Guest Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Guest Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_phone` SET TAGS ('dbx_business_glossary_term' = 'Lead Guest Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `lead_guest_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `number_of_guests` SET TAGS ('dbx_business_glossary_term' = 'Number Of Guests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `number_of_rooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `total_ancillary_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Ancillary Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `total_ancillary_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ALTER COLUMN `transportation_required` SET TAGS ('dbx_business_glossary_term' = 'Transportation Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `retail_product_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Product Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `parent_retail_product_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Retail Product Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `parent_retail_product_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `retail_product_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `cruelty_free` SET TAGS ('dbx_business_glossary_term' = 'Cruelty Free');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `retail_product_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height Cm');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Url');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `ingredients` SET TAGS ('dbx_business_glossary_term' = 'Ingredients');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length Cm');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `loyalty_points` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `retail_product_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `seasonal_product` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Product');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width Cm');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` SET TAGS ('dbx_subdomain' = 'retail_membership');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `parent_product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Line Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `parent_product_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `advance_booking_days_maximum` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days Maximum');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `advance_booking_days_minimum` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days Minimum');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `product_line_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `facility_type_required` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `gift_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Certificate Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Managed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Line Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Line Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `package_component_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Component Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `product_line_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `requires_medical_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Medical Clearance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `requires_medical_clearance_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `requires_medical_clearance_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ALTER COLUMN `therapist_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification Required');
