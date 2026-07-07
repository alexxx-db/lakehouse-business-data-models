-- Schema for Domain: spa | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`spa` COMMENT 'Spa, wellness, and recreation operations management including treatment catalogs, therapist scheduling, guest appointments, retail product sales, facility management, and revenue tracking for spa, fitness, golf, and pool amenities across luxury and resort properties.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` (
    `treatment_id` BIGINT COMMENT 'Unique identifier for the spa treatment. Primary key for the treatment master catalog.',
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
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Treatment menus define booking terms including cancellation windows. Linking to the canonical cancellation_policy ensures spa menu-level cancellation rules are governed by the same policy framework us',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: treatment_menu.target_guest_segment is a denormalized representation of market_segment. Spa revenue managers analyze menu performance by guest segment for pricing strategy and menu design decisions. N',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where this treatment menu is offered.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: Spa menus are published and targeted at specific guest segments (e.g., corporate, leisure, loyalty elite) for revenue management and personalized marketing. treatment_menu.target_guest_segment is a pl',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A treatment menu is published for a specific spa facility within a property. A property may have multiple spa facilities (main spa, fitness center, pool spa, golf clubhouse spa), each with its own tre',
    `superseded_treatment_menu_id` BIGINT COMMENT 'Self-referencing FK on treatment_menu (superseded_treatment_menu_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu was approved for publication and operational use.',
    `booking_channel_availability` STRING COMMENT 'Comma-separated list of channels where this menu is available for booking (e.g., web,mobile,front_desk,concierge,spa_reception).',
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
    CONSTRAINT pk_treatment_menu PRIMARY KEY(`treatment_menu_id`)
) COMMENT 'Property-level spa treatment menu defining which treatments from the master catalog are offered at a specific property during a defined period. Captures property reference, menu name, menu version, effective date range, season (peak, off-peak, holiday), menu type (signature, express, seasonal, couples), published status, and pricing overrides at the property level. Enables property-specific menu curation while maintaining a global treatment catalog.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` (
    `therapist_id` BIGINT COMMENT 'Unique identifier for the spa therapist. Primary key for the therapist master record.',
    `property_id` BIGINT COMMENT 'Home property where the therapist is primarily assigned. Links to the property master for location-based scheduling and revenue allocation.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A therapist is operationally assigned to a specific spa facility within a property (e.g., main spa vs. fitness center vs. pool spa). While therapist already has property_id for the property-level asso',
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
    `specializations` STRING COMMENT 'Comma-separated list of treatment modalities and techniques the therapist is certified to perform (e.g., Swedish massage, deep tissue, hot stone, Ayurvedic, reflexology, aromatherapy, prenatal, sports massage, esthetics, body wraps). Used for service matching and guest preference fulfillment.',
    `termination_date` DATE COMMENT 'Date the therapists employment or contract ended. Null for active therapists. Used for historical reporting and rehire eligibility assessment.',
    `therapist_status` STRING COMMENT 'Current operational status of the therapist. Active therapists are available for scheduling; inactive, on-leave, suspended, or terminated therapists are excluded from guest-facing booking systems.. Valid values are `active|inactive|on-leave|suspended|terminated`',
    `tip_eligible_flag` BOOLEAN COMMENT 'Indicates whether the therapist is eligible to receive gratuities from guests. Varies by employment type and local labor regulations.',
    `total_appointments_completed` STRING COMMENT 'Cumulative count of all spa appointments completed by the therapist since hire date. Used for productivity tracking, milestone recognition, and experience validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapist record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional experience as a spa therapist, including prior employment at other properties or spas. Used for skill-based pricing, guest matching, and training program placement.',
    CONSTRAINT pk_therapist PRIMARY KEY(`therapist_id`)
) COMMENT 'Spa and wellness therapist master record representing individual practitioners employed or contracted at a property. Captures therapist name, employee reference, therapist code, specializations (Swedish, deep tissue, hot stone, Ayurvedic, esthetics), certification levels, license numbers, license expiry dates, years of experience, languages spoken, gender preference availability, employment type (full-time, part-time, contractor), home property, and active status. Distinct from workforce.employee as it captures spa-specific professional credentials and treatment competencies.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` (
    `spa_facility_id` BIGINT COMMENT 'Unique identifier for the spa, wellness, or recreation facility. Primary key. Role: MASTER_RESOURCE.',
    `parent_spa_facility_id` BIGINT COMMENT 'Self-referencing FK on spa_facility (parent_spa_facility_id)',
    `property_facility_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this facility is located.',
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
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Facilities management: some properties physically convert or co-locate hotel rooms as spa treatment rooms. This FK enables room inventory accounting (removing converted rooms from sellable inventory),',
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
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa appointments booked through OTA, GDS, or direct channels require channel attribution for commission accrual, revenue reconciliation, and channel ROI analysis. Essential for finance to calculate ch',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Group/incentive event bookings generate bulk spa appointments for attendees. The spa operations team needs this FK to coordinate group scheduling, bill spa charges to the event master folio, and repor',
    `group_block_id` BIGINT COMMENT 'Reference to a group booking record if this appointment is part of a group spa event (e.g., bridal party, corporate wellness). Nullable for individual bookings.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa appointments for loyalty members should link to loyalty.member for proper points accrual tracking and member benefit validation. This FK enables real-time points calculation and member tier benefi',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: USALI spa revenue reporting requires segment attribution (transient, group, contract) on spa appointments. Revenue managers track spa revenue contribution by market segment in performance_actuals and ',
    `package_id` BIGINT COMMENT 'Reference to a spa package or bundle if this appointment is part of a multi-treatment package booking. Nullable for standalone appointments.',
    `profile_id` BIGINT COMMENT 'FK to guest.profile.profile_id — MUST-HAVE: Spa appointments must link to guest profile for intake form pre-population, allergy alerts, preference recall, and folio posting. Core guest experience continuity requirement.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Spa appointments booked under a loyalty promotion (e.g., Spa Month — earn 3x points) must reference the promotion for bonus points calculation and promotion attribution reporting. No existing column',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the spa appointment is scheduled. Links to property master data.',
    `rescheduled_appointment_id` BIGINT COMMENT 'Self-referencing FK on appointment (rescheduled_appointment_id)',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: In-room spa service delivery: luxury hotels offer therapist visits to guest rooms. Operations need this FK for housekeeping coordination (room access, linen prep), front desk authorization, and servic',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Spa ancillary revenue attribution to a completed stay drives post-stay loyalty points calculation, GSS/NPS scoring, and stay-level revenue reporting. Appointment has reservation_booking_id but not sta',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist assigned to perform the treatment. Links to workforce/therapist master data. Nullable if therapist not yet assigned.',
    `therapist_schedule_id` BIGINT COMMENT 'Foreign key linking to spa.therapist_schedule. Business justification: An appointment consumes a specific therapist schedule slot. Linking appointment to therapist_schedule enables real-time utilization tracking — when an appointment is booked, it references the schedule',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service being booked (e.g., Swedish massage, facial, body wrap). Links to treatment catalog.',
    `treatment_menu_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_menu. Business justification: An appointment is booked from a specific treatment menu version active at the time of booking. Capturing treatment_menu_id on the appointment provides an audit trail of which menu version (pricing, po',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the spa package. Primary key.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Spa package cancellation penalty calculation and waiver authorization require referencing the propertys canonical cancellation policy framework. Revenue and ops managers use this link to enforce cons',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Spa packages including dining credits must specify which F&B outlet the credit applies to, enabling outlet-level revenue allocation, package fulfillment tracking, and F&B capacity planning for package',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: Spa packages bundling F&B dining (e.g., Spa & Lunch Package) require a structured FK to the specific F&B menu for package configuration, revenue allocation between spa and F&B cost centers, and pack',
    `parent_package_id` BIGINT COMMENT 'Self-referencing FK on package (parent_package_id)',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where this spa package is available. Links to property master data.',
    `age_restriction_minimum` STRING COMMENT 'Minimum age in years required for guests to book or participate in this package. Null if no age restriction applies.',
    `amenities_included` STRING COMMENT 'Description of facility amenities included with the package such as pool access, fitness center, relaxation lounge, or refreshments.',
    `cancellation_hours_notice` STRING COMMENT 'Number of hours notice required for cancellation without penalty. Industry standard ranges from 24 to 72 hours for spa packages.',
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
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: therapist_schedule currently stores room_assignment as a STRING (denormalized text). Replacing this with a treatment_room_id FK normalizes the room assignment to the treatment_room master record. This',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for the spa charge transaction. Primary key for the spa charge record.',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment associated with this charge. Links the charge to the scheduled service.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Spa charge posting and multi-currency financial reconciliation require a validated FK to the currency catalog. Hospitality finance audits and GL posting rules depend on a structured currency reference',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa charges require direct loyalty member link for points accrual on spa spend, tier-based spa pricing discounts, and member-only spa promotions. Critical for revenue attribution and loyalty program l',
    `membership_id` BIGINT COMMENT 'Foreign key linking to spa.membership. Business justification: A spa charge can be applied against a guest membership — for example, when a member uses included treatment credits, receives a membership discount, or when the charge is posted to a membership accoun',
    `package_id` BIGINT COMMENT 'Reference to the spa package or bundle if this charge is part of a multi-service offering. Links to spa package catalog.',
    `primary_original_charge_id` BIGINT COMMENT 'Reference to the original spa charge record if this is an adjustment or reversal. Links corrected charges to their source transactions.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who received the spa service or purchased the product. Links to the guest master record.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Spa charges (including retail purchases and membership fees without appointments) may qualify for loyalty promotion discounts or bonus points. Distinct from appointment-level promotion as standalone c',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific spa facility, treatment room, or amenity area where the service was provided. Supports facility utilization analytics.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa charge was incurred. Enables multi-property revenue tracking and reporting.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this spa charge, if applicable. Used for folio posting and guest stay tracking.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa charges are posted directly to guest room folios. Revenue accounting, folio management, and PMS integration require room linkage for charge routing, a fundamental billing process in hotel spa oper',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist or service provider who delivered the treatment. Used for commission tracking and performance reporting.',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service provided, if charge_type is treatment. Links to the spa treatment catalog.',
    `adjustment_reason` STRING COMMENT 'Reason for charge adjustment if posting_status is adjusted. Captures service recovery, pricing corrections, or billing disputes.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if charge_type is cancellation_fee. Captures guest no-show, late cancellation, or policy violation details.',
    `charge_date` DATE COMMENT 'Business date when the spa charge was incurred. Used for revenue recognition and daily operations reporting.',
    `charge_number` STRING COMMENT 'Externally-known unique reference number for the spa charge transaction, used for guest communication and reconciliation.',
    `charge_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spa charge transaction was posted to the system. Principal business event timestamp for the transaction.',
    `charge_type` STRING COMMENT 'Classification of the spa charge indicating the nature of the transaction: treatment (spa service), retail (product sale), membership (club fee), day_pass (facility access), gratuity (tip), or cancellation_fee (no-show penalty).. Valid values are `treatment|retail|membership|day_pass|gratuity|cancellation_fee`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spa charge record was first created in the system. Record audit trail for data lineage.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` (
    `membership_id` BIGINT COMMENT 'Unique identifier for the spa and wellness membership record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account sponsoring this membership. Populated only for corporate membership types where an employer or organization pays for employee memberships. Null for individual memberships.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa memberships are often bundled with hotel loyalty elite status, offering integrated benefits and cross-program recognition. Supports combined membership management, loyalty elite spa privileges, an',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Spa memberships are marketed to specific segments (local residents, hotel guests, corporate accounts). Business process: membership revenue forecasting, segment performance analysis, and strategic pla',
    `profile_id` BIGINT COMMENT 'Reference to the guest enrolled in this spa membership. Links to the guest master record.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Spa memberships enrolled via loyalty promotions (e.g., Join Spa Membership and earn 5000 bonus points) must reference the originating promotion. The plain promotional_code column is a denormalized',
    `property_id` BIGINT COMMENT 'Reference to the property where this spa membership is valid. Spa memberships are typically property-specific rather than chain-wide.',
    `renewed_membership_id` BIGINT COMMENT 'Self-referencing FK on membership (renewed_membership_id)',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A spa membership is typically scoped to a specific facility (e.g., fitness center membership, main spa membership, pool access membership) within a property. While membership already has property_id, ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Spa memberships are aligned to loyalty tiers for cross-program benefit delivery (e.g., Spa Gold membership maps to Loyalty Gold tier). The plain tier column on loyalty.membership is a denormalized refer',
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
    `referral_source` STRING COMMENT 'Channel or source through which the guest learned about and enrolled in the spa membership program. Direct indicates walk-in enrollment. Member referral indicates existing member recommendation. Hotel guest indicates enrollment during property stay. Marketing campaign indicates response to promotional offer. Corporate program indicates employer wellness initiative. Online indicates website or app enrollment. Concierge indicates recommendation by hotel staff. [ENUM-REF-CANDIDATE: direct|member_referral|hotel_guest|marketing_campaign|corporate_program|online|concierge — 7 candidates stripped; promote to reference product]',
    `suspension_end_date` DATE COMMENT 'Date when the membership suspension is scheduled to end and membership will return to active status. Null if not currently suspended or if suspension is indefinite pending member action.',
    `suspension_start_date` DATE COMMENT 'Date when the membership was suspended. Null if membership has never been suspended or is not currently suspended. Used to track suspension periods for billing adjustments and benefit calculations.',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT 'Spa and wellness membership master record for guests enrolled in property-level spa membership programs. Captures membership number, guest reference, property reference, membership tier (basic, premium, elite, unlimited), membership type (monthly, annual, corporate), enrollment date, expiry date, monthly fee, annual fee, included treatment credits, included fitness access, included guest passes, auto-renewal flag, payment method on file, membership status (active, suspended, cancelled, expired), and cancellation reason. Distinct from loyalty.member which manages the hotel-wide loyalty program.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` (
    `treatment_menu_item_id` BIGINT COMMENT 'Primary key for the treatment_menu_item association',
    `treatment_id` BIGINT COMMENT 'Foreign key linking this menu item record to the master catalog treatment being offered on the menu.',
    `treatment_menu_id` BIGINT COMMENT 'Foreign key linking this menu item record to the property-level spa treatment menu it belongs to.',
    `availability_flag` BOOLEAN COMMENT 'Indicates whether this treatment is currently available for guest booking from this specific menu. Allows a treatment to be temporarily suspended on one menu without affecting its availability on other menus or in the master catalog.',
    `display_sequence` STRING COMMENT 'Numeric ordering value controlling the presentation position of this treatment within the menu. Belongs to the menu-treatment pairing because the same treatment may appear at different positions on different menus.',
    `duration_override_minutes` STRING COMMENT 'Property-level override of the standard treatment duration in minutes. Allows a property to offer a shorter express version or extended luxury version of a treatment on a specific menu without altering the master catalog duration_minutes.',
    `effective_end_date` DATE COMMENT 'Date after which this treatment is no longer available on this specific menu. Null indicates the treatment remains on the menu until the menu itself expires. Belongs to the pairing, not to either entity alone.',
    `effective_start_date` DATE COMMENT 'Date from which this treatment is active and bookable on this specific menu. May differ from the treatments master catalog effective_start_date or the menus own effective_start_date, enabling phased rollouts of individual treatments within a menu.',
    `menu_price` DECIMAL(18,2) COMMENT 'Property-specific retail price for this treatment as listed on this menu. Overrides the recommended_retail_price on the master treatment record when pricing_override_flag is set. Belongs to the menu-treatment pairing, not to either entity alone.',
    CONSTRAINT pk_treatment_menu_item PRIMARY KEY(`treatment_menu_item_id`)
) COMMENT 'This association product represents the Treatment Menu Item — the operational record of a specific treatment being offered on a specific property-level spa menu. It captures the curated inclusion of a master-catalog treatment within a published menu, along with property-specific pricing, display ordering, availability control, and duration overrides. Each record links one treatment_menu to one treatment with attributes that exist only in the context of this menu-treatment pairing, enabling property spa managers to build, publish, and revise menus independently of the master treatment catalog.. Existence Justification: A spa treatment menu is explicitly a curated selection of treatments drawn from the master catalog — a single menu contains many treatments, and a single treatment (e.g., Swedish Massage) appears on many property menus across the portfolio. This is a textbook operational M:N: spa managers actively build, publish, and revise menus by selecting treatments, setting property-specific prices, controlling display order, and toggling availability — none of which can be captured on either the menu or the treatment record alone. The relationship is a recognized business concept (menu item or treatment offering) that carries its own data.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` (
    `package_treatment_inclusion_id` BIGINT COMMENT 'Primary key for the package_treatment_inclusion association',
    `package_id` BIGINT COMMENT 'Foreign key linking this inclusion record to the parent spa package.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking this inclusion record to the specific treatment included in the package.',
    `duration_override_minutes` STRING COMMENT 'Override duration in minutes for this treatment when delivered as part of this package, which may differ from the treatments standalone duration_minutes. Null if the standard duration applies.',
    `effective_end_date` DATE COMMENT 'Date after which this treatment is no longer included in the package. Null if the inclusion is open-ended. Supports package composition versioning.',
    `effective_start_date` DATE COMMENT 'Date from which this treatment is included in the package. Supports package composition versioning and seasonal menu changes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this treatment inclusion is currently active within the package. Allows treatments to be retired from a package without deleting the historical composition record.',
    `is_optional_upgrade` BOOLEAN COMMENT 'Indicates whether this treatment is a mandatory component of the package (false) or an optional upgrade that guests may elect to include (true). Drives package fulfillment and upsell logic.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this treatment can be included in spa packages or bundled offerings. Used for package configuration and revenue management. [Moved from treatment: This boolean flag on the treatment master was a workaround to signal that a treatment can participate in packages. With the package_treatment_inclusion association table in place, eligibility is implicitly established by the existence of an active inclusion record. The flag becomes redundant and its meaning is better expressed through the association itself. It may be retained on the treatment master as a catalog-level eligibility indicator (to filter treatments in the package composition UI), but its operational meaning is now captured by the association.]',
    `price_contribution` DECIMAL(18,2) COMMENT 'The portion of the package rack rate allocated to this specific treatment for per-treatment revenue recognition and reporting. Belongs to the composition, not to the package or treatment master.',
    `quantity` STRING COMMENT 'Number of sessions of this treatment included in the package. For example, a wellness program may include three massage sessions. Defaults to 1 for single-session inclusions.',
    `sequence_number` STRING COMMENT 'The order in which this treatment is delivered within the package itinerary. Drives scheduling and fulfillment sequencing for the package appointment.',
    CONSTRAINT pk_package_treatment_inclusion PRIMARY KEY(`package_treatment_inclusion_id`)
) COMMENT 'This association product represents the Composition relationship between a spa package and its constituent treatments. It captures which treatments are included in each package, the sequence in which they are delivered, each treatments contribution to the package price, any duration overrides specific to the package context, quantity of sessions, and whether the treatment is a mandatory or optional upgrade component. Each record links one package to one treatment and carries attributes that exist only in the context of that specific package-treatment composition. This is the normalization of the denormalized included_treatments list on the package master.. Existence Justification: In the spa industry, packages are composite products that bundle multiple treatments together (e.g., a Couples Retreat package includes a couples massage, a facial, and a body wrap). Conversely, a single treatment like a Swedish Massage can appear in many different packages (Day Spa, Half-Day, Wellness Program, etc.). This is a genuine operational M:N: spa operations staff actively compose packages by selecting treatments, assigning sequence order, setting per-treatment duration overrides, and pricing contributions — all of which are attributes of the composition relationship itself, not of the package or treatment alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_parent_treatment_id` FOREIGN KEY (`parent_treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_superseded_treatment_menu_id` FOREIGN KEY (`superseded_treatment_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_supervisor_therapist_id` FOREIGN KEY (`supervisor_therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_parent_spa_facility_id` FOREIGN KEY (`parent_spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_adjoining_treatment_room_id` FOREIGN KEY (`adjoining_treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_rescheduled_appointment_id` FOREIGN KEY (`rescheduled_appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_therapist_schedule_id` FOREIGN KEY (`therapist_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`(`therapist_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_menu_id` FOREIGN KEY (`treatment_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_parent_package_id` FOREIGN KEY (`parent_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_original_therapist_schedule_id` FOREIGN KEY (`original_therapist_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`(`therapist_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership`(`membership_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_primary_original_charge_id` FOREIGN KEY (`primary_original_charge_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`charge`(`charge_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_renewed_membership_id` FOREIGN KEY (`renewed_membership_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`membership`(`membership_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ADD CONSTRAINT `fk_spa_treatment_menu_item_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ADD CONSTRAINT `fk_spa_treatment_menu_item_treatment_menu_id` FOREIGN KEY (`treatment_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ADD CONSTRAINT `fk_spa_package_treatment_inclusion_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ADD CONSTRAINT `fk_spa_package_treatment_inclusion_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`spa` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`spa` SET TAGS ('dbx_domain' = 'spa');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Treatment Menu Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ALTER COLUMN `booking_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Availability');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `specializations` SET TAGS ('dbx_business_glossary_term' = 'Therapist Specializations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Therapist Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_business_glossary_term' = 'Therapist Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on-leave|suspended|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `tip_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tip Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `total_appointments_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Appointments Completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `parent_spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Spa Facility Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `parent_spa_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_ssot_owner' = 'property.property_facility');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_ssot_entity' = 'facility');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Adjoining Treatment Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Hotel Room Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` SET TAGS ('dbx_subdomain' = 'guest_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Guest Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `rescheduled_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Appointment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `rescheduled_appointment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Service Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `parent_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `parent_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `amenities_included` SET TAGS ('dbx_business_glossary_term' = 'Amenities Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ALTER COLUMN `cancellation_hours_notice` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Hours Notice');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Schedule ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `original_therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Original Therapist Schedule Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `original_therapist_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` SET TAGS ('dbx_subdomain' = 'guest_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Charge ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `primary_original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` SET TAGS ('dbx_subdomain' = 'guest_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `renewed_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Membership Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `renewed_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` SET TAGS ('dbx_association_edges' = 'spa.treatment_menu,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Menu Item Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Menu Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Availability Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `duration_override_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Override (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `menu_price` SET TAGS ('dbx_business_glossary_term' = 'Menu Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu_item` ALTER COLUMN `menu_price` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` SET TAGS ('dbx_association_edges' = 'spa.package,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `package_treatment_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment Inclusion - Package Treatment Inclusion Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `package_treatment_inclusion_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `package_treatment_inclusion_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment Inclusion - Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Package Treatment Inclusion - Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `duration_override_minutes` SET TAGS ('dbx_business_glossary_term' = 'Package Duration Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `is_optional_upgrade` SET TAGS ('dbx_business_glossary_term' = 'Optional Upgrade Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `price_contribution` SET TAGS ('dbx_business_glossary_term' = 'Treatment Price Contribution');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Included Session Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package_treatment_inclusion` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Sequence');
