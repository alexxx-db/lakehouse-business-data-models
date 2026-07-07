-- Schema for Domain: event | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`event` COMMENT 'MICE (Meetings, Incentives, Conferences, Exhibitions) sales and operations lifecycle including event inquiries, proposals, contracts, BEO (Banquet Event Order) management, group room blocks, function space allocation, catering orders, and post-event billing. Integrates with Delphi by Amadeus. Tracks event revenue, function space utilization, group pace, and group ADR contribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the event account. Primary key for the B2B client entity that books MICE (Meetings, Incentives, Conferences, Exhibitions) events.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Corporate accounts are classified by market segment (Corporate Transient, Group, Association) to determine rate eligibility, commission structures, and demand forecasting inputs. Revenue managers use ',
    `parent_account_id` BIGINT COMMENT 'Identifier of the parent event account if this account is part of a corporate hierarchy or national account structure. Enables roll-up reporting and consolidated billing.',
    `property_id` BIGINT COMMENT 'Identifier of the primary or preferred property where the event account typically books events. Used for account assignment and relationship management.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Corporate event accounts are assigned loyalty tier equivalents governing pricing, concessions, and service levels (e.g., Platinum accounts get priority space allocation). Normalizes the existing denor',
    `account_number` STRING COMMENT 'Externally-known unique business identifier for the event account. Used in contracts, proposals, and invoicing. Typically assigned by the CRS (Central Reservation System) or Delphi system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the event account. Active accounts can book new events; suspended accounts require approval; closed accounts are archived.. Valid values are `active|inactive|suspended|pending|closed`',
    `account_type` STRING COMMENT 'Classification of the event account based on the nature of the client organization. Determines pricing strategies, contract terms, and service offerings.. Valid values are `corporate|association|government|social|wedding|other`',
    `average_event_spend_amount` DECIMAL(18,2) COMMENT 'Average revenue per event for this account. Calculated as lifetime event spend divided by total events booked. Used for forecasting and opportunity sizing.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the event account, including street number and name.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for additional address details such as suite, floor, or building number.',
    `billing_city` STRING COMMENT 'City name for the billing address of the event account.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the billing address of the event account.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address of the event account.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address of the event account.',
    `closed_date` DATE COMMENT 'Date when the event account was closed or deactivated. Null for active accounts. Used for account lifecycle reporting and reactivation analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the event account record was first created in the system. Used for account age analysis and audit trails.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the event account. Used to control exposure and manage accounts receivable risk.',
    `credit_status` STRING COMMENT 'Current credit approval status for the event account. Determines whether the account can book events on credit terms or requires prepayment.. Valid values are `approved|pending|declined|review_required|suspended`',
    `external_account_reference` STRING COMMENT 'Account identifier from the source system (e.g., Delphi Account ID, Salesforce Account ID). Used for system integration and data lineage tracking.',
    `industry_vertical` STRING COMMENT 'Primary industry sector or vertical market of the client organization (e.g., Technology, Healthcare, Finance, Education, Manufacturing). Used for market segmentation and targeted sales strategies.',
    `is_national_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is a national or account with negotiated rates and terms across multiple properties.',
    `is_vip_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is a VIP or strategic account requiring special handling, executive attention, or premium service levels.',
    `last_event_date` DATE COMMENT 'Date of the most recent event held by this account. Used for recency analysis and account reactivation campaigns.',
    `lifetime_event_spend_amount` DECIMAL(18,2) COMMENT 'Total cumulative revenue generated from all events booked by this account since inception. Key metric for account tier classification and relationship value assessment.',
    `account_name` STRING COMMENT 'Legal or operating name of the corporate, association, or group client organization that books MICE events.',
    `notes` STRING COMMENT 'Free-text notes capturing special requirements, preferences, historical context, or relationship management information for the event account.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date (e.g., Net 30, Net 60). Defines the credit period for the event account.',
    `preferred_event_type` STRING COMMENT 'Most frequently booked event type by this account (e.g., Conference, Training, Board Meeting, Product Launch). Used for targeted marketing and service customization.',
    `primary_contact_email` STRING COMMENT 'Primary email address of the main contact person for event inquiries, proposals, and communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the client organization responsible for event planning and booking decisions.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number of the main contact person for event coordination and urgent communications.',
    `sales_territory_code` STRING COMMENT 'Geographic or market-based sales territory code to which this event account is assigned for sales planning and performance tracking.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record where this event account was originally created (e.g., Delphi by Amadeus, Salesforce CRM).. Valid values are `DELPHI|OPERA|SALESFORCE|SYNXIS|OTHER`',
    `tax_id_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) of the client organization for tax reporting and compliance.',
    `total_events_booked_count` STRING COMMENT 'Total number of events booked by this account since inception. Used for relationship depth analysis and loyalty assessment.',
    `typical_attendee_count` STRING COMMENT 'Average number of attendees for events booked by this account. Used for capacity planning and function space allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the event account record was last modified. Used for data freshness tracking and change audit.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for the corporate, association, or group client account that books MICE events. Captures organization name, industry vertical, account tier, primary and secondary contacts, credit terms, preferred properties, historical event spend, and assigned account/sales manager. Serves as the B2B client identity anchor for the event domain — distinct from the guest domains individual traveler profile and from the finance domains AR customer record. All inquiries, proposals, bookings, and revenue link to this entity for relationship management, account-level performance reporting, and sales territory assignment.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` (
    `inquiry_id` BIGINT COMMENT 'Unique identifier for the MICE inquiry or RFP. Primary key for the inquiry record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to event.account. Business justification: An inquiry in the MICE lifecycle is frequently submitted by a known corporate or association account. Linking inquiry.account_id → event.account.account_id enables account-level inquiry tracking, pipe',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Group inquiries arrive via specific distribution channels (direct website inquiry forms, OTA group inquiry platforms, GDS shopping requests). Critical for lead source tracking, channel effectiveness a',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Event inquiries frequently originate from loyalty members leveraging their status for group bookings. Sales teams reference member tier for pricing and concessions; loyalty members expect tier recogni',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Inquiries carry a plain-text market_segment field that should be a proper FK for lead scoring, conversion rate analysis by segment, and routing to the correct sales team. Replacing the denormalized te',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Lead-to-stay conversion reporting and 360-degree guest CRM require linking event inquiries to guest profiles. Enables hospitality sales teams to track which guest profiles generate MICE pipeline, supp',
    `property_id` BIGINT COMMENT 'Identifier of the property or hotel where the inquiry was received and is being managed.',
    `alternate_dates_flag` BOOLEAN COMMENT 'Indicates whether the client is flexible and willing to consider alternate dates for the event.',
    `av_equipment_required_flag` BOOLEAN COMMENT 'Indicates whether audio-visual equipment is required for the event.',
    `av_equipment_requirements` STRING COMMENT 'Detailed description of audio-visual equipment needs including projectors, screens, microphones, sound systems, and technical support.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_range_max` DECIMAL(18,2) COMMENT 'Maximum budget amount indicated by the prospective client for the entire event including rooms, function space, and catering.',
    `budget_range_min` DECIMAL(18,2) COMMENT 'Minimum budget amount indicated by the prospective client for the entire event including rooms, function space, and catering.',
    `catering_required_flag` BOOLEAN COMMENT 'Indicates whether catering services (F&B) are required as part of the event.',
    `catering_requirements` STRING COMMENT 'Detailed description of catering needs including meal types, service styles, dietary restrictions, and beverage requirements.',
    `client_organization_name` STRING COMMENT 'Name of the organization or company submitting the MICE inquiry.',
    `competitor_name` STRING COMMENT 'Name of the competitor property or venue that won the business if the inquiry was lost to competition.',
    `converted_timestamp` TIMESTAMP COMMENT 'Timestamp when the inquiry was converted to a definite booking or contract. Null if not yet converted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inquiry record was first created in the Delphi by Amadeus system.',
    `decision_timeline` DATE COMMENT 'Expected date by which the prospective client will make a booking decision.',
    `estimated_attendance` STRING COMMENT 'Estimated number of attendees or participants for the event as indicated in the inquiry.',
    `event_name` STRING COMMENT 'Name or title of the proposed event as provided by the prospective client.',
    `event_type` STRING COMMENT 'Type of MICE event requested (meeting, conference, incentive, exhibition, wedding, social event, or other). Aligns with MICE classification standards. [ENUM-REF-CANDIDATE: meeting|conference|incentive|exhibition|wedding|social|other — 7 candidates stripped; promote to reference product]',
    `function_space_requirements` STRING COMMENT 'Description of function space requirements including room types, capacities, setup styles, and special configurations needed for the event.',
    `group_room_block_estimate` STRING COMMENT 'Estimated number of guest rooms required for the group block to accommodate event attendees.',
    `inquiry_date` DATE COMMENT 'Date when the MICE inquiry or RFP was received by the property or sales team.',
    `inquiry_number` STRING COMMENT 'Business-facing unique inquiry reference number generated by Delphi by Amadeus for tracking and communication with prospective clients.. Valid values are `^[A-Z0-9]{8,20}$`',
    `inquiry_status` STRING COMMENT 'Current lifecycle status of the MICE inquiry in the sales pipeline. Tracks progression from initial lead through conversion or closure. [ENUM-REF-CANDIDATE: new|qualified|proposal_sent|negotiation|converted|lost|cancelled — 7 candidates stripped; promote to reference product]',
    `lead_owner_email` STRING COMMENT 'Email address of the sales manager or event coordinator assigned as the owner of this inquiry.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `lead_owner_name` STRING COMMENT 'Name of the sales manager or event coordinator assigned as the owner of this inquiry.',
    `lead_score` STRING COMMENT 'Numeric score assigned to the inquiry based on qualification criteria such as budget fit, date flexibility, and conversion probability. Used for prioritization.',
    `lost_reason` STRING COMMENT 'Reason why the inquiry was lost or not converted (e.g., budget constraints, dates unavailable, competitor selected). Populated when inquiry_status is lost.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inquiry record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes capturing additional details, special requests, or context provided by the prospective client or recorded by the sales team.',
    `preferred_end_date` DATE COMMENT 'Preferred or requested end date for the event as specified by the prospective client.',
    `preferred_start_date` DATE COMMENT 'Preferred or requested start date for the event as specified by the prospective client.',
    `qualification_status` STRING COMMENT 'Indicates whether the inquiry has been qualified as a viable sales opportunity based on budget, dates, and requirements alignment.. Valid values are `unqualified|qualified|disqualified`',
    `referral_source` STRING COMMENT 'Name or description of the referral source if the inquiry came through a referral (e.g., past client, partner organization, industry association).',
    `room_nights_estimate` STRING COMMENT 'Estimated total room nights (rooms × nights) for the group block.',
    `source_channel` STRING COMMENT 'Channel through which the MICE inquiry was received (e.g., direct contact, OTA, GDS, referral, website form, email, phone call, walk-in). [ENUM-REF-CANDIDATE: direct|ota|gds|referral|website|email|phone|walk_in — 8 candidates stripped; promote to reference product]',
    `special_requirements` STRING COMMENT 'Any special requirements or requests from the client including accessibility needs, branding, security, or unique setup configurations.',
    CONSTRAINT pk_inquiry PRIMARY KEY(`inquiry_id`)
) COMMENT 'Initial MICE lead or request for proposal (RFP) received from a prospective event client. Captures the inquiry source channel (OTA, direct, GDS, referral), event type (meeting, conference, incentive, exhibition), estimated attendance, preferred dates, function space requirements, catering needs, group room block estimate, budget range, decision timeline, and lead owner. Represents the top-of-funnel stage in the Delphi by Amadeus event sales pipeline.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the MICE event proposal record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the corporate account or client organization receiving this proposal.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Sales proposals communicate cancellation terms to prospective clients. Referencing the formal cancellation_policy object ensures proposals display accurate, current penalty schedules and deposit requi',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Proposals are addressed to specific loyalty member decision-makers. Sales teams reference member tier when crafting proposals and pricing; loyalty status influences concessions and upgrade offers in g',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: When a proposal is accepted, an event_booking is created. The proposal should directly reference which booking it generated. Currently, proposal links to event_contract, and event_contract links to ev',
    `event_contract_id` BIGINT COMMENT 'Reference to the formal event contract generated upon proposal acceptance.',
    `inquiry_id` BIGINT COMMENT 'Reference to the originating event inquiry or RFP (Request for Proposal) that triggered this proposal.',
    `negotiated_rate_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_negotiated_rate. Business justification: Proposals for corporate/group events are built using pre-negotiated rates. Linking proposal to the governing negotiated rate enables rate compliance validation, commission calculation, and ensures the',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.spa_package. Business justification: Event proposals include spa packages as value-adds for wellness conferences, incentive trips, executive retreats. Sales process requires linking proposed spa packages to calculate total event value an',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Proposals include loyalty bonus offers to incentivize contract signing (e.g., bonus points for signing by a deadline). Linking proposal to the specific promotion enables budget consumption tracking ag',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the proposed event will be hosted.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Event proposals include a room block at a specific rate plan. Linking to the governing rate plan enables rate parity checks, GDS/OTA eligibility validation, commission calculation, and ensures the pro',
    `approval_status` STRING COMMENT 'Internal approval status indicating whether the proposal terms have been reviewed and authorized by revenue management or senior leadership.. Valid values are `pending|approved|rejected|conditional`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the proposal was internally approved for submission to the client.',
    `attrition_clause` STRING COMMENT 'Terms and conditions regarding penalties or fees if the client fails to meet minimum room block or F&B commitments.',
    `av_package_amount` DECIMAL(18,2) COMMENT 'Total estimated cost for audio-visual equipment and services proposed.',
    `av_package_description` STRING COMMENT 'Description of proposed audio-visual equipment, technology packages, and production services included in the proposal.',
    `client_feedback` STRING COMMENT 'Client comments, objections, or feedback received during proposal review and negotiation.',
    `client_response_date` DATE COMMENT 'Date when the client formally responded to the proposal with acceptance, decline, or request for revision.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage commission rate offered to third-party planners, travel agents, or intermediaries if applicable.',
    `competitive_positioning_notes` STRING COMMENT 'Internal notes capturing competitive intelligence, alternative venues being considered by the client, and strategic positioning rationale.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the proposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the proposal.. Valid values are `^[A-Z]{3}$`',
    `decision_date` DATE COMMENT 'Date by which the client is expected to make a decision on accepting or declining the proposal.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Initial deposit or advance payment required to secure the proposed event dates and services.',
    `deposit_due_date` DATE COMMENT 'Deadline by which the initial deposit must be received to hold the proposed event space and services.',
    `event_end_date` DATE COMMENT 'Proposed end date of the event or meeting.',
    `event_start_date` DATE COMMENT 'Proposed start date of the event or meeting.',
    `event_type` STRING COMMENT 'Classification of the proposed event within MICE (Meetings, Incentives, Conferences, Exhibitions) taxonomy. [ENUM-REF-CANDIDATE: meeting|incentive|conference|exhibition|wedding|social|corporate|association — 8 candidates stripped; promote to reference product]',
    `expected_attendance` STRING COMMENT 'Anticipated number of attendees or participants for the proposed event.',
    `fb_minimum_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed spend commitment for catering and food and beverage services as part of the proposal terms.',
    `function_space_requirements` STRING COMMENT 'Detailed description of meeting rooms, ballrooms, and function spaces proposed for the event, including setup styles and capacities.',
    `issued_date` DATE COMMENT 'Date when the proposal was formally issued and sent to the prospective client.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the proposal record was last updated or revised.',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the proposal, typically reflecting the event name and client organization.',
    `proposal_number` STRING COMMENT 'Externally-visible unique business identifier for the proposal, used in client communications and contract references.. Valid values are `^[A-Z0-9]{6,20}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal in the negotiation and approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|revised|accepted|declined|expired|withdrawn — 8 candidates stripped; promote to reference product]',
    `room_block_quantity` STRING COMMENT 'Total number of guest rooms proposed to be blocked for event attendees.',
    `room_block_rate` DECIMAL(18,2) COMMENT 'Proposed negotiated nightly rate for the group room block, typically below BAR (Best Available Rate).',
    `source_channel` STRING COMMENT 'Channel or source through which the proposal inquiry originated.. Valid values are `direct|third_party_planner|corporate_direct|association|referral|online_rfp`',
    `special_requirements` STRING COMMENT 'Client-specific requests, accessibility needs, dietary restrictions, or unique event requirements captured in the proposal.',
    `total_estimated_revenue` DECIMAL(18,2) COMMENT 'Total estimated event value including rooms, F&B, AV, and ancillary services, representing the full revenue opportunity.',
    `valid_until_date` DATE COMMENT 'Expiration date after which the proposal terms, rates, and availability are no longer guaranteed.',
    `version` STRING COMMENT 'Version number tracking revisions and iterations of the proposal during negotiation lifecycle.',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Formal event proposal issued to a prospective MICE client in response to an inquiry or RFP. Captures proposed function spaces, room block rates, F&B minimums, AV packages, total estimated event value, validity period, proposal version, competitive positioning notes, and approval status. Tracks the negotiation lifecycle from initial proposal through revision and acceptance. Sourced from Delphi by Amadeus proposal management module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` (
    `event_booking_id` BIGINT COMMENT 'Unique identifier for the event booking. Primary key for the event booking entity representing a confirmed or tentative MICE engagement.',
    `account_id` BIGINT COMMENT 'Reference to the corporate account or organization booking the event.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Event booking cancellation penalty calculations and deposit forfeiture decisions require the formal cancellation policy object. Revenue managers and contract teams reference the same centrally-managed',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Group event bookings frequently bill to corporate travel accounts managed in guest domain. Sales managers need consolidated view of corporate accounts total business (transient + MICE) for pricing ne',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Group bookings originate from specific distribution channels (OTA group platforms, direct corporate channels, GDS group segments). Essential for channel attribution reporting, commission calculation o',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Group/MICE event bookings must be segment-coded (Corporate, Association, SMERF, Social) for demand forecasting, RevPAR contribution analysis, and USALI segment reporting. Revenue managers require this',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Event bookings have a primary loyalty member contact who earns points on group spend. Critical for loyalty point accrual rules, tier qualification from group revenue, and member lifetime value trackin',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: 360-degree guest view (stay history + event bookings), VIP recognition at event check-in, and loyalty points attribution require linking event bookings to guest profiles. member_id covers loyalty memb',
    `property_id` BIGINT COMMENT 'Reference to the property where the event is being held.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Group event bookings frequently include spa access as package amenity (wellness retreats, corporate incentive programs). Event coordinators negotiate spa facility access/credits for attendees. Critica',
    `actual_attendance_count` STRING COMMENT 'Actual number of attendees who participated in the event. Populated post-event.',
    `attrition_clause_percentage` DECIMAL(18,2) COMMENT 'Percentage threshold below guaranteed attendance that triggers attrition penalties.',
    `attrition_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount if attendance falls below the attrition threshold.',
    `billing_instruction` STRING COMMENT 'Special billing instructions or payment terms for this event booking.',
    `booking_number` STRING COMMENT 'Externally visible unique booking reference number for the event. Used in client communications and contracts.. Valid values are `^[A-Z0-9]{8,20}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the event booking. Tracks progression from inquiry through completion or cancellation. [ENUM-REF-CANDIDATE: inquiry|tentative|definite|contracted|cancelled|completed|lost — 7 candidates stripped; promote to reference product]',
    `cancellation_deadline_date` DATE COMMENT 'Last date the event can be cancelled without incurring full penalties per the cancellation policy.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission amount payable for this booking.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of booking value payable as commission to intermediaries or sales agents.',
    `concession_amount` DECIMAL(18,2) COMMENT 'Total value of concessions, discounts, or complimentary services granted for this booking.',
    `concession_reason` STRING COMMENT 'Business justification for concessions granted on this booking.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or storage location for the signed contract document.',
    `contract_signed_date` DATE COMMENT 'Date when the event contract was executed by both parties.',
    `contracted_value_amount` DECIMAL(18,2) COMMENT 'Total contracted revenue amount for the entire event including room blocks, function space, catering, and ancillary services.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event booking record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this booking.. Valid values are `^[A-Z]{3}$`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Total deposit amount required to secure the event booking.',
    `deposit_due_date` DATE COMMENT 'Date by which the deposit payment must be received to maintain the booking.',
    `deposit_received_flag` BOOLEAN COMMENT 'Indicates whether the required deposit has been received.',
    `event_end_date` DATE COMMENT 'The date when the event is scheduled to conclude.',
    `event_name` STRING COMMENT 'The official name or title of the event as provided by the client.',
    `event_start_date` DATE COMMENT 'The date when the event is scheduled to begin.',
    `expected_attendance_count` STRING COMMENT 'Anticipated number of attendees for the event as provided by the client.',
    `guaranteed_attendance_count` STRING COMMENT 'Contractually guaranteed minimum number of attendees for billing purposes.',
    `inquiry_date` DATE COMMENT 'Date when the initial event inquiry was received.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this event booking record was last updated.',
    `mice_category` STRING COMMENT 'Classification of the event type within the MICE framework. [ENUM-REF-CANDIDATE: meeting|incentive|conference|exhibition|wedding|social|corporate — 7 candidates stripped; promote to reference product]',
    `proposal_sent_date` DATE COMMENT 'Date when the event proposal was sent to the client.',
    `room_block_count` STRING COMMENT 'Total number of guest rooms blocked for the event group.',
    `room_block_cutoff_date` DATE COMMENT 'Date by which attendees must book rooms from the group block before unreserved rooms are released back to general inventory.',
    `room_block_pickup_count` STRING COMMENT 'Number of rooms from the block that have been reserved by attendees.',
    `special_requirements` STRING COMMENT 'Any special requests, accommodations, or requirements for the event such as ADA accessibility, dietary restrictions, or technical needs.',
    `status_changed_timestamp` TIMESTAMP COMMENT 'Timestamp when the booking status was last changed. Critical for tracking booking lifecycle progression.',
    CONSTRAINT pk_event_booking PRIMARY KEY(`event_booking_id`)
) COMMENT 'Single source of truth is reservation.reservation_booking. Confirmed or tentative event booking representing a MICE engagement at a specific property. Acts as the master transactional record tying together all sub-components: group room blocks, function space allocations, BEOs, contracts, invoices, revenue, and attendee registrations. Captures event name, MICE category, contracted dates, total contracted value, deposit schedule, cancellation terms, attrition clauses, cutoff dates, booking status lifecycle (tentative, definite, cancelled, completed, lost) with status change history, owning sales manager, event coordinator, concession tracking, and commission details. Absorbs status audit trail, concession management, and commission tracking as embedded attributes rather than separate entities. The central hub entity for all event operations, reporting, and cross-domain integration with workforce (staffing assignments) and finance (AR posting). SSOT: defers to reservation.reservation_booking (MVM).reservation_booking as single source of truth]channel_booking. [SSOT:booking] Domain-specific specialization of the booking concept; canonical SSOT owner is channel.channel_booking. SSOT: defers to canonical reservation.reservation_booking (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` (
    `function_space_id` BIGINT COMMENT 'Unique identifier for the function space. Primary key.',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Space utilization and capacity reconciliation reporting requires joining event-domain bookable function spaces to the property-domain physical meeting room master record. Revenue managers and faciliti',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Facilities maintenance scheduling vs. event booking conflict detection requires linking the event-domain bookable space to the property-domain physical asset record. ADA compliance audits and inspecti',
    `property_id` BIGINT COMMENT 'Reference to the property where this function space is located.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the function space meets ADA (Americans with Disabilities Act) accessibility requirements including wheelchair access, ramps, and accessible restrooms.',
    `av_infrastructure` STRING COMMENT 'Description of built-in AV equipment and infrastructure including screens, projectors, sound systems, lighting rigs, and control systems.',
    `capacity_banquet` STRING COMMENT 'Maximum guest capacity when the space is configured for banquet-style seating (round tables with chairs).',
    `capacity_cabaret` STRING COMMENT 'Maximum guest capacity when the space is configured in cabaret-style seating (round tables with chairs on three sides only).',
    `capacity_classroom` STRING COMMENT 'Maximum guest capacity when the space is configured in classroom-style seating (rows of tables and chairs).',
    `capacity_hollow_square` STRING COMMENT 'Maximum guest capacity when the space is configured in hollow square seating (tables arranged in square formation).',
    `capacity_reception` STRING COMMENT 'Maximum guest capacity when the space is configured for reception-style standing events (cocktail, networking).',
    `capacity_theater` STRING COMMENT 'Maximum guest capacity when the space is configured in theater-style seating (rows of chairs facing front).',
    `capacity_u_shape` STRING COMMENT 'Maximum guest capacity when the space is configured in U-shape seating (tables arranged in U formation).',
    `catering_kitchen_access` BOOLEAN COMMENT 'Indicates whether the function space has direct access to a catering kitchen or prep area for Food and Beverage (F&B) service.',
    `ceiling_height_feet` DECIMAL(18,2) COMMENT 'Height of the ceiling in feet, critical for AV setup, lighting design, and event feasibility assessment.',
    `climate_control` STRING COMMENT 'Type of climate control system available in the function space for temperature and air quality management.. Valid values are `hvac|air_conditioning|heating|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this function space record was first created in the system.',
    `divisible` BOOLEAN COMMENT 'Indicates whether the function space can be divided into smaller sub-spaces using partitions or airwalls.',
    `effective_date` DATE COMMENT 'Date when this function space record became active and available for booking in the event management system.',
    `expiration_date` DATE COMMENT 'Date when this function space record expires or is no longer available for booking, nullable for spaces with indefinite availability.',
    `floor_level` STRING COMMENT 'Physical floor or level where the function space is located within the property (e.g., Ground Floor, Mezzanine, 2nd Floor, Rooftop).',
    `internet_connectivity` STRING COMMENT 'Type of internet connectivity available in the function space for event attendees and organizers.. Valid values are `wired|wireless|both|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this function space record was last updated or modified in the system.',
    `natural_light_available` BOOLEAN COMMENT 'Indicates whether the function space has natural daylight through windows, skylights, or outdoor exposure.',
    `notes` STRING COMMENT 'Additional operational notes, special features, restrictions, or important information about the function space for event planners and sales teams.',
    `operational_status` STRING COMMENT 'Current operational availability status of the function space for booking and event allocation.. Valid values are `available|unavailable|under_renovation|temporarily_closed|permanently_closed|seasonal`',
    `outdoor_space` BOOLEAN COMMENT 'Indicates whether the function space is an outdoor venue or has outdoor components (terrace, garden, rooftop).',
    `partition_configuration` STRING COMMENT 'Description of how the space can be divided, including the number of sub-spaces and their names (e.g., Ballroom A, B, C).',
    `rental_rate_full_day` DECIMAL(18,2) COMMENT 'Standard rental rate for booking the function space for a full day (typically 8-12 hours), in property base currency.',
    `rental_rate_half_day` DECIMAL(18,2) COMMENT 'Standard rental rate for booking the function space for a half day (typically 4-6 hours), in property base currency.',
    `rental_rate_hourly` DECIMAL(18,2) COMMENT 'Standard rental rate for booking the function space on an hourly basis, in property base currency.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'Standard time required in hours for event setup including furniture arrangement, AV installation, and decoration before the event start.',
    `space_code` STRING COMMENT 'Unique business identifier code for the function space within the property, used in PMS and event management systems.. Valid values are `^[A-Z0-9]{2,20}$`',
    `space_name` STRING COMMENT 'Full business name of the function space (e.g., Grand Ballroom, Executive Boardroom, Terrace Garden).',
    `space_type` STRING COMMENT 'Classification of the function space by its primary use and configuration characteristics.. Valid values are `ballroom|boardroom|breakout_room|exhibit_hall|pre_function_area|outdoor_terrace`',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the function space measured in square feet, used for capacity planning and space utilization reporting.',
    `teardown_time_hours` DECIMAL(18,2) COMMENT 'Standard time required in hours for event teardown including furniture removal, AV breakdown, and space restoration after the event end.',
    CONSTRAINT pk_function_space PRIMARY KEY(`function_space_id`)
) COMMENT 'Master record for each bookable function space (ballroom, boardroom, breakout room, exhibit hall, pre-function area, outdoor terrace, rooftop venue) at a property. Captures the space name, space type, maximum capacity by setup style (theater, classroom, banquet, reception, U-shape, hollow square, cabaret), square footage, ceiling height, natural light availability, AV infrastructure (built-in screens, sound systems, lighting rigs), divisibility into sub-spaces with partition configurations, rental rate by daypart, and operational status. Serves as the inventory catalog for event space allocation and function space utilization reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT 'Unique identifier for the function space allocation record. Primary key.',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: space_allocation currently has beo_number (STRING) as a denormalized reference to the BEO. This should be normalized to a proper FK. The BEO is the operational execution document for the space allocat',
    `event_booking_id` BIGINT COMMENT 'Reference to the parent event booking for which this space is allocated. Links to the event booking entity.',
    `function_space_id` BIGINT COMMENT 'Reference to the specific function space (meeting room, ballroom, conference room) being allocated. Links to the meeting space entity.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Event space allocations frequently use property facilities (pools, fitness centers, outdoor terraces) for breakout sessions, receptions, team-building activities. Essential for facility scheduling con',
    `property_id` BIGINT COMMENT 'Reference to the property where the function space is located. Links to the property entity.',
    `actual_attendance` STRING COMMENT 'The actual number of attendees who participated in the event. Captured post-event for reconciliation and future forecasting accuracy.',
    `allocated_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation record was created in the system. Represents the initial booking or hold timestamp.',
    `allocation_date` DATE COMMENT 'The calendar date on which the function space is allocated for the event. Used for space utilization tracking and conflict prevention.',
    `allocation_number` STRING COMMENT 'Business identifier for the space allocation, typically generated by the event management system (Delphi). Used for operational reference and tracking.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the space allocation. Tentative indicates provisional hold, definite indicates confirmed booking, released indicates space returned to inventory, cancelled indicates booking cancelled, waitlisted indicates pending availability.. Valid values are `tentative|definite|released|cancelled|waitlisted`',
    `booking_segment` STRING COMMENT 'Market segment classification for the event booking. Used for revenue analysis and market mix reporting aligned with MICE segmentation.. Valid values are `corporate|association|government|social|wedding|other`',
    `complimentary_reason` STRING COMMENT 'Business justification for providing complimentary space rental (e.g., minimum F&B spend met, VIP client, promotional package, contract terms). Populated when is_complimentary is true.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation status changed from tentative to definite. Represents the point at which the booking became contractually binding.',
    `end_time` TIMESTAMP COMMENT 'The scheduled end date and time when the event concludes in the allocated space. Represents the actual event end, not teardown end.',
    `event_type` STRING COMMENT 'Classification of the event purpose (e.g., meeting, conference, wedding, banquet, training, exhibition, social). Used for space utilization analysis and market segmentation. [ENUM-REF-CANDIDATE: meeting|conference|wedding|banquet|training|exhibition|social|corporate|association|government — promote to reference product]',
    `expected_attendance` STRING COMMENT 'The anticipated number of attendees for the event as communicated by the client during booking. Used for capacity planning and setup configuration.',
    `external_reference_code` STRING COMMENT 'External system identifier or client reference number for cross-system reconciliation and client communication. May contain third-party booking platform IDs or client internal event codes.',
    `guaranteed_attendance` STRING COMMENT 'The contractually guaranteed minimum number of attendees for billing purposes. Typically finalized closer to the event date per contract terms.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the space rental is provided at no charge as part of a promotional offer, loyalty benefit, or contractual agreement. True if complimentary, false if charged.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to any field in this space allocation record. Used for change tracking and audit trail.',
    `priority_level` STRING COMMENT 'Business priority assigned to this space allocation for conflict resolution and resource allocation decisions. High priority typically assigned to definite bookings with high revenue or strategic importance.. Valid values are `high|medium|low`',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation was released back to inventory. Populated when status changes to released or cancelled.',
    `rental_charge_amount` DECIMAL(18,2) COMMENT 'The monetary charge for renting the function space for the specified time period. May be zero if complimentary or included in package pricing.',
    `rental_charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the rental charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `setup_start_time` TIMESTAMP COMMENT 'The date and time when setup activities begin for the event. Used to calculate total space occupancy time including pre-event preparation.',
    `setup_style` STRING COMMENT 'The physical arrangement configuration of the function space (e.g., theater, classroom, banquet rounds, U-shape, hollow square, boardroom, reception). Determines capacity and operational requirements. [ENUM-REF-CANDIDATE: theater|classroom|banquet_rounds|u_shape|hollow_square|boardroom|reception|cocktail|conference|chevron|herringbone — promote to reference product]',
    `space_block_type` STRING COMMENT 'Indicates whether the space allocation is exclusive to this event or shared with other concurrent activities. Exclusive means sole use, shared means multiple events may use portions, concurrent means back-to-back scheduling, overflow means secondary space for capacity overflow.. Valid values are `exclusive|shared|concurrent|overflow`',
    `special_requirements` STRING COMMENT 'Free-text field capturing specific client requests or operational notes for the space allocation (e.g., AV equipment, accessibility needs, temperature preferences, security requirements).',
    `start_time` TIMESTAMP COMMENT 'The scheduled start date and time when the event begins in the allocated space. Represents the actual event start, not setup start.',
    `teardown_end_time` TIMESTAMP COMMENT 'The date and time when teardown activities are completed and the space is released. Used to calculate total space occupancy time including post-event breakdown.',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Transactional record of a specific function space being allocated to an event booking for a defined date and time period. Captures the setup style, expected attendance, actual attendance, setup start time, teardown end time, rental charge, complimentary status, and allocation status (tentative, definite, released). Enables function space utilization tracking, double-booking prevention, and space revenue reporting. Sourced from Delphi by Amadeus space diary. SSOT: defers to property.property_space_allocation (MVM). [SSOT_OWNER] [SSOT:space_allocation] Canonical single-source-of-truth for the space_allocation concept; other domain variants are domain-specific specializations referencing this owner. SSOT: defers to canonical property.property_space_allocation (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`beo` (
    `beo_id` BIGINT COMMENT 'Unique identifier for the Banquet Event Order. Primary key for the BEO product.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: BEOs reference the loyalty member contact for service preferences and special requests. Event coordinators leverage member preference data from loyalty profiles to personalize event execution and enha',
    `event_booking_id` BIGINT COMMENT 'Reference to the parent event booking or group block that this BEO supports. Links the operational BEO to the sales event record.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: A BEO is dispatched to the responsible F&B outlet (banquet kitchen or catering outlet) for production execution. This link drives kitchen production scheduling, staffing, and outlet-level revenue repo',
    `meeting_space_id` BIGINT COMMENT 'Reference to the function space or room where this event will be held (e.g., Grand Ballroom, Boardroom A).',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this BEO will be executed.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: BEOs can include spa services as event components (pre-conference spa sessions for VIPs, spa breaks during multi-day events). Operations teams coordinate spa facility availability alongside meeting sp',
    `actual_revenue` DECIMAL(18,2) COMMENT 'The actual revenue billed for this BEO after the event is completed. Captured during post-event reconciliation.',
    `av_requirements` STRING COMMENT 'Detailed list of audio-visual equipment and technical requirements (e.g., projector, microphones, screens, lighting, video conferencing). Used by AV operations team.',
    `beo_number` STRING COMMENT 'The externally-known business identifier for this BEO, typically printed on the document and shared with operations teams. May follow property-specific numbering conventions.',
    `beo_status` STRING COMMENT 'Current lifecycle status of the BEO document. Tracks progression from draft through execution to completion.. Valid values are `draft|issued|confirmed|revised|completed|cancelled`',
    `beverage_package` STRING COMMENT 'Description of the beverage service package (e.g., Premium Open Bar, Wine Service, Coffee and Tea Station). Includes service style and duration.',
    `billing_instructions` STRING COMMENT 'Instructions for how charges should be billed (e.g., direct bill to master account, split billing, payment method). Used by accounting and front office.',
    `completed_date` DATE COMMENT 'The date when the function was successfully executed and the BEO was marked complete. Triggers post-event billing and reconciliation.',
    `confirmed_date` DATE COMMENT 'The date when the client confirmed all details in this BEO. After confirmation, changes typically require formal revision.',
    `contact_email` STRING COMMENT 'Email address of the primary client contact for BEO distribution and event communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary client contact or meeting planner for this function. Used for communication and coordination.',
    `contact_phone` STRING COMMENT 'Phone number of the primary client contact for day-of-event coordination and emergency communication.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this BEO record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this BEO (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `decor_notes` STRING COMMENT 'Special instructions for room décor, floral arrangements, linens, centerpieces, and ambiance elements. Guides banquet setup team.',
    `dietary_restrictions` STRING COMMENT 'Documentation of attendee dietary restrictions, allergies, and special meal requirements (e.g., vegetarian, vegan, gluten-free, kosher, halal). Critical for food safety and guest satisfaction.',
    `end_time` TIMESTAMP COMMENT 'The scheduled end date and time for this function. Used for teardown planning and space turnover scheduling.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'The estimated total revenue for this BEO, including food, beverage, AV, and other charges. Used for forecasting and revenue management.',
    `event_date` DATE COMMENT 'The calendar date on which this function will take place. Primary business event date for scheduling and operations.',
    `expected_attendance` STRING COMMENT 'The estimated or expected number of attendees for planning purposes. May differ from guaranteed count and is used for operational preparation.',
    `external_beo_reference` STRING COMMENT 'The unique identifier for this BEO in the source system (e.g., Delphi). Used for cross-system reconciliation and integration.',
    `function_name` STRING COMMENT 'The name or title of the specific function or session covered by this BEO (e.g., Opening Keynote, Awards Gala Dinner, Board Meeting).',
    `function_type` STRING COMMENT 'Classification of the function type for operational planning and resource allocation. [ENUM-REF-CANDIDATE: meeting|breakfast|lunch|dinner|reception|break|ceremony|other — 8 candidates stripped; promote to reference product]',
    `guaranteed_attendance` STRING COMMENT 'The number of attendees guaranteed by the client for billing purposes. This is the minimum count for which the client will be charged, regardless of actual attendance.',
    `issued_date` DATE COMMENT 'The date when this BEO was officially issued to operations teams. Marks the transition from draft to active operational document.',
    `menu_selection` STRING COMMENT 'Detailed description of the food menu selected for this function, including courses, entrees, sides, and dietary accommodations. Critical for kitchen preparation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this BEO record was last updated. Tracks the most recent change to any field in the record.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'The percentage service charge applied to food and beverage charges for this function. Typically ranges from 18% to 24%.',
    `setup_style` STRING COMMENT 'The room configuration and seating arrangement style for this function. Determines furniture requirements and capacity. [ENUM-REF-CANDIDATE: theater|classroom|banquet|hollow_square|u_shape|boardroom|reception|cocktail|other — 9 candidates stripped; promote to reference product]',
    `setup_time` TIMESTAMP COMMENT 'The time when setup crew should begin preparing the function space. Critical for housekeeping and banquet operations scheduling.',
    `special_instructions` STRING COMMENT 'Additional operational notes, client preferences, VIP requirements, security needs, or any other special considerations for executing this function.',
    `start_time` TIMESTAMP COMMENT 'The scheduled start date and time for this function, including timezone context. Used for setup scheduling and guest communication.',
    `tax_percentage` DECIMAL(18,2) COMMENT 'The applicable tax rate percentage for this function based on jurisdiction and tax regulations.',
    `version` STRING COMMENT 'Version number of this BEO document. Increments with each revision to track changes and ensure operations teams work from the latest version.',
    CONSTRAINT pk_beo PRIMARY KEY(`beo_id`)
) COMMENT 'Banquet Event Order (BEO) — the operational master document for executing a specific event function. Captures the function name, event date, start and end times, guaranteed attendance count, setup style, menu selections, beverage package, AV requirements, décor notes, special instructions, billing instructions, and BEO status (draft, issued, confirmed, completed). The BEO is the primary communication document between event sales, catering, kitchen, and operations teams. Sourced from Delphi by Amadeus BEO module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` (
    `beo_item_id` BIGINT COMMENT 'Unique identifier for the BEO line item. Primary key.',
    `beo_id` BIGINT COMMENT 'Reference to the parent BEO header document. Links this line item to the overall event order.',
    `catering_menu_id` BIGINT COMMENT 'Foreign key linking to event.catering_menu. Business justification: beo_item currently has menu_item_code (STRING) and package_code (STRING) as denormalized references to catering menu items. This should be normalized to a FK to catering_menu. The catering_menu is the',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to fnb.menu_item. Business justification: Banquet event order line items frequently reference standard outlet menu items (breakfast buffets, plated dinners, bar packages) for costing, kitchen preparation, recipe execution, and inventory plann',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity served or delivered at the event. Captured post-event for reconciliation, billing adjustments, and variance analysis.',
    `allergen_information` STRING COMMENT 'Free-text field documenting known allergens present in this item. Critical for food safety compliance and guest health protection.',
    `billing_status` STRING COMMENT 'Current billing status of this line item. Tracks progression from event execution through invoicing, payment, and dispute resolution.. Valid values are `unbilled|billed|paid|disputed|waived`',
    `cost_center` STRING COMMENT 'Accounting cost center responsible for fulfilling this item. Used for departmental P&L allocation and operational cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BEO line item was first created in the system. Audit trail for event planning timeline.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing. Supports multi-currency properties and international group business.. Valid values are `^[A-Z]{3}$`',
    `dietary_restriction_flag` BOOLEAN COMMENT 'Indicates whether this item accommodates special dietary requirements. Triggers kitchen alerts and special handling procedures.',
    `dietary_restriction_type` STRING COMMENT 'Specific dietary accommodation provided by this item. Critical for food safety, allergen management, and guest satisfaction. [ENUM-REF-CANDIDATE: vegetarian|vegan|gluten_free|dairy_free|nut_free|kosher|halal|other — 8 candidates stripped; promote to reference product]',
    `extended_amount` DECIMAL(18,2) COMMENT 'Total line item amount calculated as quantity multiplied by unit price. Subtotal before taxes and service charges.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue or charge posting. Ensures proper financial classification and USALI-compliant reporting.',
    `guaranteed_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity the client has committed to pay for regardless of actual attendance. Used for billing and production planning. Typically finalized 48-72 hours before the event.',
    `item_category` STRING COMMENT 'High-level classification of the BEO item. Determines which operational department handles fulfillment (kitchen, bar, AV team, etc.). [ENUM-REF-CANDIDATE: food|beverage|audio_visual|decor|labor|rental|miscellaneous — 7 candidates stripped; promote to reference product]',
    `item_description` STRING COMMENT 'Detailed description of the item or service. Appears on the BEO, kitchen prep sheets, and guest-facing documents. May include preparation instructions, presentation notes, or service requirements.',
    `item_status` STRING COMMENT 'Current status of this line item within the BEO lifecycle. Tracks changes, cancellations, and substitutions during event planning and execution.. Valid values are `confirmed|tentative|cancelled|substituted`',
    `item_type` STRING COMMENT 'Specific type of line item. Distinguishes between menu selections, bundled packages, equipment rentals, labor services, additional charges, and credit adjustments.. Valid values are `menu_item|package|equipment|service|charge|credit`',
    `line_number` STRING COMMENT 'Sequential line number within the BEO document. Determines the order of items on the BEO and production sheets.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this line item. Audit trail for change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this line item. Tracks BEO revisions and change history.',
    `overage_percentage` DECIMAL(18,2) COMMENT 'Percentage above guaranteed quantity that the kitchen prepares as buffer. Standard practice to ensure sufficient food availability. Typically 3-5% for plated meals, higher for buffets.',
    `package_code` STRING COMMENT 'Reference to a bundled catering package (e.g., breakfast buffet, coffee break, AV package). Links to package master for component breakdown and pricing.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units ordered for this line item. May represent guest count, number of pieces, hours of service, or equipment units depending on the item type and unit of measure.',
    `revenue_category` STRING COMMENT 'Revenue classification for financial reporting and USALI compliance. Determines which revenue account this item posts to in the general ledger.. Valid values are `food|beverage|audio_visual|room_rental|labor|other`',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Calculated service charge amount for this line item. Derived from extended amount and service charge rate.',
    `service_charge_applicable` BOOLEAN COMMENT 'Indicates whether a service charge or gratuity applies to this line item. Common for food, beverage, and labor items.',
    `service_charge_rate` DECIMAL(18,2) COMMENT 'Service charge percentage applied to this line item. Stored as decimal (e.g., 0.22 for 22%). May be mandatory or discretionary depending on property policy.',
    `service_time` TIMESTAMP COMMENT 'Scheduled time when this item should be served or delivered to the event. Drives kitchen timing, service staff deployment, and guest experience.',
    `setup_time` TIMESTAMP COMMENT 'Scheduled time when this item should be set up or prepared. Critical for kitchen production scheduling, AV setup coordination, and labor planning.',
    `special_instructions` STRING COMMENT 'Free-text field for additional instructions, presentation requirements, or service notes. Communicated to kitchen, service staff, and AV technicians.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount for this line item. Derived from extended amount and tax rate.',
    `tax_applicable` BOOLEAN COMMENT 'Indicates whether this line item is subject to sales tax or VAT. Determines tax calculation during billing.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this line item. Stored as decimal (e.g., 0.0825 for 8.25%). May vary by jurisdiction, item category, or tax exemption status.',
    `total_amount` DECIMAL(18,2) COMMENT 'Grand total for this line item including extended amount, taxes, and service charges. Used for event billing and revenue recognition.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured. Critical for accurate kitchen production planning, inventory consumption, and billing. [ENUM-REF-CANDIDATE: person|piece|hour|day|each|dozen|gallon|bottle|case|pound — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure. Base price before taxes, service charges, or gratuities. Used to calculate extended amount.',
    `vendor_source` STRING COMMENT 'Indicates whether the item is provided by the property, an external vendor, or supplied by the client. Affects procurement, liability, and cost allocation.. Valid values are `internal|external_vendor|client_provided`',
    `created_by` STRING COMMENT 'User ID or name of the catering sales manager or event coordinator who created this line item. Audit trail for accountability.',
    CONSTRAINT pk_beo_item PRIMARY KEY(`beo_item_id`)
) COMMENT 'Line-item detail within a Banquet Event Order capturing each individual service, menu selection, equipment item, or charge. Captures item category (food, beverage, AV, décor, labor, rental, miscellaneous), item description, menu/package reference, quantity, unit of measure, unit price, extended amount, tax applicability, service charge rate, dietary flags, and vendor source. Enables granular event cost tracking, catering production planning, kitchen prep sheets, and post-event billing reconciliation. Also serves as the transactional record linking catalog offerings (menus, AV packages) to actual event consumption.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` (
    `catering_menu_id` BIGINT COMMENT 'Unique identifier for the catering menu item. Primary key for the catering menu catalog.',
    `property_id` BIGINT COMMENT 'Identifier of the property where this catering menu is available. Links to the property master data.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Catering menus are fulfilled by specific property outlets (restaurants, banquet kitchens, poolside bars). Critical for kitchen capacity planning, outlet revenue attribution, health permit compliance t',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: Hotel banquet catering menus are typically derived from or adapted from standard F&B restaurant menus. Role-prefix source_ used because catering_menu has its own menu identity. This link supports me',
    `active_status` STRING COMMENT 'Current lifecycle status of the catering menu. Only active menus are available for new BEO (Banquet Event Order) bookings. Seasonal menus activate/deactivate based on availability windows.. Valid values are `active|inactive|seasonal|archived`',
    `allergen_declarations` STRING COMMENT 'Comma-separated list of major food allergens present in the menu (e.g., peanuts, tree nuts, dairy, eggs, soy, wheat, fish, shellfish). Required for guest safety and regulatory compliance.',
    `contains_alcohol` BOOLEAN COMMENT 'Indicates whether the menu includes alcoholic beverages or alcohol-infused dishes. Impacts licensing requirements, service protocols, and pricing.',
    `contribution_margin_percent` DECIMAL(18,2) COMMENT 'Percentage contribution margin for the menu calculated as (price - cost) / price. Key metric for menu engineering and profitability optimization. Confidential business data.',
    `cost_per_person` DECIMAL(18,2) COMMENT 'Internal food and beverage cost per person for this menu. Used for GOP (Gross Operating Profit) analysis, menu engineering, and contribution margin calculations. Confidential business data.',
    `created_by_user` STRING COMMENT 'Username or identifier of the catering director or system user who created this menu record. Audit trail for accountability and menu curation governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catering menu record was first created in the system. Audit trail for menu catalog lifecycle tracking.',
    `cuisine_style` STRING COMMENT 'Culinary theme or regional cuisine classification of the menu (e.g., Italian, Asian Fusion, Mediterranean, Contemporary American). Used for menu curation and guest preference matching.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for menu pricing (e.g., USD, EUR, GBP). Required for multi-currency property operations and international group bookings.. Valid values are `^[A-Z]{3}$`',
    `catering_menu_description` STRING COMMENT 'Detailed description of the catering menu package including courses, signature items, presentation style, and service inclusions. Used in proposals and BEO (Banquet Event Order) documentation.',
    `dietary_accommodations` STRING COMMENT 'Comma-separated list of dietary restrictions and preferences this menu can accommodate (e.g., vegetarian, vegan, gluten-free, kosher, halal, dairy-free). Critical for inclusive event planning and guest satisfaction.',
    `effective_end_date` DATE COMMENT 'Date when this menu version is no longer available for new bookings. Nullable for open-ended menus. Existing BEO (Banquet Event Order) commitments honor the booked menu version.',
    `effective_start_date` DATE COMMENT 'Date when this menu version becomes available for booking. Used for seasonal menu transitions and pricing change management.',
    `labor_intensity_rating` STRING COMMENT 'Classification of the labor effort required to prepare and serve this menu. Impacts staffing requirements, CPOR (Cost Per Occupied Room) calculations, and operational feasibility for concurrent events.. Valid values are `low|medium|high|very_high`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last updated this menu record. Audit trail for change management and version control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this catering menu record. Used for change tracking and data synchronization between Delphi and MICROS POS systems.',
    `maximum_capacity` STRING COMMENT 'Maximum number of guests that can be served with this menu given kitchen production capacity and service constraints. Used for function space allocation and operational feasibility checks.',
    `menu_category` STRING COMMENT 'Tier classification of the menu based on ingredient quality, presentation complexity, and price point. Used for market segmentation and group sales targeting.. Valid values are `standard|premium|luxury|executive|budget`',
    `menu_code` STRING COMMENT 'Business identifier code for the catering menu used in Delphi and MICROS POS systems for quick lookup and BEO (Banquet Event Order) item selection.. Valid values are `^[A-Z0-9]{4,20}$`',
    `menu_name` STRING COMMENT 'Descriptive name of the catering menu package displayed to event planners and clients during MICE (Meetings, Incentives, Conferences, Exhibitions) booking process.',
    `menu_type` STRING COMMENT 'Classification of the catering menu by meal period or service style. Determines function space setup requirements and service staffing levels. [ENUM-REF-CANDIDATE: breakfast|lunch|dinner|reception|coffee_break|buffet|plated|cocktail|hors_doeuvres — 9 candidates stripped; promote to reference product]',
    `minimum_guarantee` STRING COMMENT 'Minimum number of guests required to book this catering menu. Used for kitchen production planning and revenue yield management. Client is charged for minimum even if actual attendance is lower.',
    `notes` STRING COMMENT 'Free-text field for internal operational notes, special preparation instructions, or catering director comments. Not visible to clients but used by banquet operations and kitchen staff.',
    `preparation_lead_time_hours` STRING COMMENT 'Minimum advance notice required in hours for kitchen to prepare this menu. Critical for BEO (Banquet Event Order) cutoff times and last-minute booking feasibility.',
    `presentation_image_url` STRING COMMENT 'URL to professional photograph of the menu presentation. Used in digital proposals, event planning portals, and marketing materials to enhance visual appeal and booking conversion.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `price_per_person` DECIMAL(18,2) COMMENT 'Standard per-person pricing for the catering menu package. Base rate before service charges, gratuities, and taxes. Used for group pricing calculations and revenue forecasting.',
    `requires_specialty_equipment` BOOLEAN COMMENT 'Indicates whether this menu requires specialty kitchen or service equipment beyond standard banquet capabilities (e.g., carving stations, flambé equipment, liquid nitrogen). Impacts feasibility and rental costs.',
    `seasonal_availability` STRING COMMENT 'Seasonal availability window for the menu based on ingredient sourcing, culinary calendar, and demand patterns. Menus may be versioned seasonally by the catering director.. Valid values are `year_round|spring|summer|fall|winter|holiday`',
    `service_duration_minutes` STRING COMMENT 'Typical duration in minutes for service of this menu from start to completion. Used for event timeline planning and function space utilization optimization.',
    `service_style` STRING COMMENT 'Method of food service delivery for the catering menu. Impacts labor costs, function space layout, and guest experience.. Valid values are `buffet|plated|family_style|stations|passed|display`',
    `setup_time_minutes` STRING COMMENT 'Estimated time in minutes required to set up the function space for this menu service style. Used for event scheduling, function space turnover planning, and labor allocation.',
    `sustainability_certified` BOOLEAN COMMENT 'Indicates whether the menu meets sustainability certification standards (e.g., organic ingredients, local sourcing, sustainable seafood). Increasingly important for corporate MICE (Meetings, Incentives, Conferences, Exhibitions) clients with ESG requirements.',
    `version_number` STRING COMMENT 'Version identifier for the menu catalog (e.g., 2024-Q2, 2024-DEC). Menus are versioned seasonally by the catering director to reflect ingredient availability, pricing updates, and culinary trends.. Valid values are `^[0-9]{4}-(Q[1-4]|[A-Z]{3})$`',
    CONSTRAINT pk_catering_menu PRIMARY KEY(`catering_menu_id`)
) COMMENT 'Master catalog of catering menus and packages available for MICE event bookings at a property. Captures the menu name, menu type (breakfast, lunch, dinner, reception, coffee break, buffet, plated), cuisine style, minimum guarantee, price per person, seasonal availability, dietary accommodation options, allergen declarations, and active status. Referenced by BEO items when food and beverage selections are made for a specific event function. Managed within Delphi by Amadeus and Oracle Hospitality MICROS POS. Distinct from the foodandbeverage domains operational outlet menu management — this catalog is curated specifically for MICE event packages, group pricing tiers, and banquet-style service, and is versioned seasonally by the catering director.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` (
    `event_contract_id` BIGINT COMMENT 'Unique identifier for the event contract. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to event.account. Business justification: A legally executed event contract is entered into with a specific corporate or association account. Direct account_id on event_contract enables contract management queries, credit limit enforcement, a',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Event contracts legally bind clients to cancellation terms. The same cancellation_policy objects governing room reservations define penalty schedules, deposit requirements, and legal text for event co',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Master account billing and direct billing setup for event contracts require linking to the corporate account for credit limit checks, billing instruction inheritance, and contract compliance reporting',
    `event_booking_id` BIGINT COMMENT 'Reference to the parent event booking that this contract governs.',
    `amendment_history` STRING COMMENT 'Chronological record of all contract amendments, addendums, and modifications.',
    `attrition_clause` STRING COMMENT 'Terms governing penalties if the client fails to meet minimum room block or revenue commitments.',
    `attrition_threshold_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of contracted room block or revenue that must be achieved to avoid attrition penalties.',
    `av_equipment_revenue` DECIMAL(18,2) COMMENT 'Contracted revenue from audio-visual equipment and technical services.',
    `cancellation_penalty_schedule` STRING COMMENT 'Tiered schedule of financial penalties based on cancellation timing relative to event date.',
    `client_signatory_name` STRING COMMENT 'Full name of the authorized signatory representing the client organization.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client signatory.',
    `contract_number` STRING COMMENT 'Externally-known unique contract identifier used for legal and business reference.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `draft|pending_signature|executed|amended|cancelled|expired`',
    `contract_type` STRING COMMENT 'Classification of the contract based on scope and commitment level.. Valid values are `master_agreement|single_event|multi_event|tentative|definite`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `credit_approval_flag` BOOLEAN COMMENT 'Indicates whether the client has been approved for credit terms rather than advance payment.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the contract.. Valid values are `^[A-Z]{3}$`',
    `deposit_schedule` STRING COMMENT 'Structured schedule of deposit payment milestones and due dates.',
    `effective_end_date` DATE COMMENT 'Date when the contract terms expire or are fulfilled.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become legally binding and enforceable.',
    `execution_date` DATE COMMENT 'Date when the contract was legally executed and signed by all parties.',
    `fb_revenue` DECIMAL(18,2) COMMENT 'Contracted revenue from food and beverage services including catering and banquets.',
    `final_payment_due_date` DATE COMMENT 'Date by which all remaining contracted amounts must be paid in full.',
    `force_majeure_clause` STRING COMMENT 'Legal provisions addressing contract obligations in the event of unforeseeable circumstances beyond parties control.',
    `initial_deposit_amount` DECIMAL(18,2) COMMENT 'Amount of the first deposit required to secure the event booking.',
    `initial_deposit_due_date` DATE COMMENT 'Date by which the initial deposit must be received.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment or modification.',
    `legal_review_flag` BOOLEAN COMMENT 'Indicates whether the contract has undergone formal legal review and approval.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal counsel or attorney who reviewed the contract.',
    `master_account_billing_flag` BOOLEAN COMMENT 'Indicates whether all charges should be consolidated to a single master account for billing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was last modified.',
    `notes` STRING COMMENT 'Free-form notes capturing special terms, conditions, or considerations specific to this contract.',
    `payment_terms` STRING COMMENT 'Detailed terms governing payment methods, schedules, and conditions.',
    `property_signatory_name` STRING COMMENT 'Full name of the authorized signatory representing the property or hotel.',
    `property_signatory_title` STRING COMMENT 'Job title or role of the property signatory.',
    `room_revenue` DECIMAL(18,2) COMMENT 'Contracted revenue from guest room accommodations.',
    `space_rental_revenue` DECIMAL(18,2) COMMENT 'Contracted revenue from meeting and event space rental fees.',
    `total_contracted_revenue` DECIMAL(18,2) COMMENT 'Total revenue amount committed across all categories in the contract.',
    `version` STRING COMMENT 'Version number of the contract to track amendments and revisions.',
    CONSTRAINT pk_event_contract PRIMARY KEY(`event_contract_id`)
) COMMENT 'Single source of truth is procurement.procurement_contract. Legally executed contract governing the terms and conditions of a confirmed event booking. Captures the contract execution date, signatory details, total contracted revenue by category (rooms, F&B, space rental, AV, other), deposit schedule and amounts, cancellation penalty schedule, attrition clause terms, force majeure provisions, master account billing authorization, and contract amendment history. Distinct from the event_booking operational record — this is the legal instrument. Sourced from Delphi by Amadeus contract management. SSOT: defers to procurement.procurement_contract (MVM).procurement_contract as single source of truth]channel_contract. [SSOT:contract] Domain-specific specialization of the contract concept; canonical SSOT owner is channel.channel_contract. SSOT: defers to canonical procurement.procurement_contract (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` (
    `event_revenue_id` BIGINT COMMENT 'Unique identifier for the event revenue record. Primary key for this transactional revenue fact.',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: event_revenue currently has beo_reference_number (STRING) as a denormalized reference. Revenue is often recognized based on BEO execution (actual services delivered per the BEO). This should be normal',
    `event_booking_id` BIGINT COMMENT 'Reference to the parent event booking for which this revenue was recognized. Links to the event booking master record.',
    `event_contract_id` BIGINT COMMENT 'Foreign key linking to event.event_contract. Business justification: Revenue recognized from an event booking is governed by the terms of the executed event contract (attrition clauses, payment schedules, contracted revenue amounts). Linking event_revenue.event_contrac',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: event_revenue carries a function_space_code string that denormalized references the function space generating space rental revenue. Normalizing this to a FK event_revenue.function_space_id → event.fun',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: USALI-compliant revenue reporting requires event revenue to be classified by market segment. This link enables segment-level TRevPAR contribution analysis, budget vs. actual variance by segment, and f',
    `property_id` BIGINT COMMENT 'Reference to the property where the event took place and revenue was generated.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Outlet-level P&L reporting on event F&B revenue requires linking event revenue postings directly to the property outlet that generated them. Hotel controllers and F&B directors run outlet-level revenu',
    `room_block_id` BIGINT COMMENT 'Foreign key linking to inventory.room_block. Business justification: Event revenue records group room night revenue (group_room_nights, group_adr attributes exist). Linking to the specific room_block enables precise attrition penalty calculation, pickup-vs-contracted r',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual revenue amount recognized for this category on this date, in the propertys base currency.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The amount of any revenue adjustment applied (positive for additions, negative for reductions).',
    `adjustment_reason` STRING COMMENT 'Reason for any revenue adjustment or correction applied to this line (e.g., discount, refund, billing correction, service recovery).',
    `attendee_count` STRING COMMENT 'Number of attendees at the event, used to calculate per-person revenue metrics and analyze event profitability.',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The budgeted or forecasted revenue amount for this category on this date, used for variance analysis.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount payable to third-party agents or intermediaries for this revenue (e.g., meeting planner commission, OTA commission).',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate percentage applied to this revenue line, expressed as a decimal (e.g., 10.00 for 10%).',
    `cost_center_code` STRING COMMENT 'The cost center or department code responsible for this revenue (e.g., catering department, banquet operations).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `event_type` STRING COMMENT 'The type of MICE event that generated this revenue (meeting, conference, wedding, banquet, exhibition, incentive trip, etc.).',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this revenue was posted in the financial system.',
    `group_adr` DECIMAL(18,2) COMMENT 'Average Daily Rate for group room nights associated with this event. Calculated as group room revenue divided by group room nights.',
    `group_room_nights` STRING COMMENT 'Number of group room nights associated with this event revenue, used to calculate group ADR (Average Daily Rate) contribution.',
    `is_voided` BOOLEAN COMMENT 'Boolean flag indicating whether this revenue line has been voided or reversed. True if voided, False if active.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue record was last modified. Part of the audit trail for tracking changes.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this revenue record. Part of the audit trail.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after deducting taxes and service charges from the actual amount. This is the revenue recognized for GOP (Gross Operating Profit) calculation.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this revenue line, used for clarification, special instructions, or audit trail documentation.',
    `payment_received_date` DATE COMMENT 'The date payment was received for this revenue line. Null if payment is still pending.',
    `payment_status` STRING COMMENT 'Current payment status of this revenue line. Tracks whether the revenue has been collected.. Valid values are `pending|paid|partially_paid|overdue|written_off`',
    `per_attendee` DECIMAL(18,2) COMMENT 'Average revenue generated per event attendee. Calculated as total event revenue divided by attendee count.',
    `posting_date` DATE COMMENT 'The date this revenue was posted to the general ledger in the financial system.',
    `recognition_method` STRING COMMENT 'The accounting method used to recognize this revenue (accrual basis, cash basis, or deferred revenue).. Valid values are `accrual|cash|deferred`',
    `revenue_category` STRING COMMENT 'The USALI-aligned revenue category for this line item. Categorizes event revenue into standard hospitality revenue streams.. Valid values are `rooms|food|beverage|space_rental|av_equipment|other`',
    `revenue_date` DATE COMMENT 'The business date on which this revenue was recognized per USALI revenue recognition standards. This is the principal business event timestamp for this transaction.',
    `revenue_source` STRING COMMENT 'The channel or source through which this event revenue was generated (direct booking, OTA, GDS, corporate account, group sales).. Valid values are `direct|ota|gds|corporate|group`',
    `revpar_contribution` DECIMAL(18,2) COMMENT 'The contribution of this events group room revenue to the propertys overall RevPAR (Revenue Per Available Room) metric.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Service charge or gratuity amount included in this revenue line, typically for Food and Beverage (F&B) or banquet services.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the revenue category for granular revenue analysis (e.g., breakfast, lunch, dinner under food; beer, wine, spirits under beverage).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount collected on this revenue line (sales tax, VAT, service charges, etc.).',
    `trevpar_contribution` DECIMAL(18,2) COMMENT 'The contribution of this events total revenue (rooms plus F&B plus other) to the propertys TRevPAR (Total Revenue Per Available Room) metric.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between actual and budgeted revenue (actual minus budgeted). Positive indicates revenue overperformance.',
    `void_reason` STRING COMMENT 'Reason provided for voiding this revenue line (e.g., billing error, event cancellation, duplicate entry).',
    `void_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue line was voided. Null if the line has not been voided.',
    CONSTRAINT pk_event_revenue PRIMARY KEY(`event_revenue_id`)
) COMMENT 'Transactional record of actual revenue recognized from an event booking, broken down by revenue category per USALI standards (rooms, food, beverage, space rental, AV, other). Captures the revenue date, revenue category, actual amount, budgeted amount, variance, RevPAR contribution from group rooms, and posting reference to the general ledger. This is the event-domain revenue fact — the authoritative GL journal entries and period-close revenue recognition are owned by the finance domain. Enables event revenue performance tracking, group ADR contribution analysis, and TRevPAR impact assessment. Sourced from Oracle OPERA PMS and SAP S/4HANA GL.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_contract`(`event_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`inquiry`(`inquiry_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_catering_menu_id` FOREIGN KEY (`catering_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`catering_menu`(`catering_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_contract`(`event_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`event` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`event` SET TAGS ('dbx_domain' = 'event');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Event Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Event Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Event Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Event Account Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Event Account Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'corporate|association|government|social|wedding|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `average_event_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Event Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `average_event_spend_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|declined|review_required|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_business_glossary_term' = 'External Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `is_national_account` SET TAGS ('dbx_business_glossary_term' = 'National Account Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `is_national_account` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `is_vip_account` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Account Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `last_event_date` SET TAGS ('dbx_business_glossary_term' = 'Last Event Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `lifetime_event_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Event Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Event Account Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Account Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `preferred_event_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `sales_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'DELPHI|OPERA|SALESFORCE|SYNXIS|OTHER');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `total_events_booked_count` SET TAGS ('dbx_business_glossary_term' = 'Total Events Booked Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `typical_attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Typical Attendee Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Inquiring Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `alternate_dates_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternate Dates Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `av_equipment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `av_equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `budget_range_max` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Maximum');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `budget_range_min` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Minimum');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `catering_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Catering Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `catering_requirements` SET TAGS ('dbx_business_glossary_term' = 'Catering Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `client_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Client Organization Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Converted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `decision_timeline` SET TAGS ('dbx_business_glossary_term' = 'Decision Timeline');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `estimated_attendance` SET TAGS ('dbx_business_glossary_term' = 'Estimated Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `function_space_requirements` SET TAGS ('dbx_business_glossary_term' = 'Function Space Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `group_room_block_estimate` SET TAGS ('dbx_business_glossary_term' = 'Group Room Block Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `inquiry_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `inquiry_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Lead Owner Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Owner Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lead_score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `lost_reason` SET TAGS ('dbx_business_glossary_term' = 'Lost Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `preferred_end_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `preferred_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|disqualified');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `room_nights_estimate` SET TAGS ('dbx_business_glossary_term' = 'Room Nights Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Source Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `event_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Inquiry ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `negotiated_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Negotiated Rate Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `attrition_clause` SET TAGS ('dbx_business_glossary_term' = 'Attrition Clause');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `av_package_amount` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Package Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `av_package_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `av_package_description` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Package Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `av_package_description` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `client_response_date` SET TAGS ('dbx_business_glossary_term' = 'Client Response Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `competitive_positioning_notes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `event_end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `event_start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `fb_minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Minimum Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `function_space_requirements` SET TAGS ('dbx_business_glossary_term' = 'Function Space Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Issued Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `room_block_quantity` SET TAGS ('dbx_business_glossary_term' = 'Room Block Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `room_block_rate` SET TAGS ('dbx_business_glossary_term' = 'Room Block Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'direct|third_party_planner|corporate_direct|association|referral|online_rfp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `total_estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Valid Until Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `actual_attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `attrition_clause_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Clause Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `attrition_clause_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `attrition_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Attrition Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `billing_instruction` SET TAGS ('dbx_business_glossary_term' = 'Billing Instruction');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `cancellation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `concession_amount` SET TAGS ('dbx_business_glossary_term' = 'Concession Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `concession_reason` SET TAGS ('dbx_business_glossary_term' = 'Concession Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `contracted_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Value Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `deposit_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Received Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `event_end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `event_start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `expected_attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `guaranteed_attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `mice_category` SET TAGS ('dbx_business_glossary_term' = 'Meetings Incentives Conferences Exhibitions (MICE) Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `proposal_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Sent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `room_block_count` SET TAGS ('dbx_business_glossary_term' = 'Group Room Block Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `room_block_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Room Block Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `room_block_pickup_count` SET TAGS ('dbx_business_glossary_term' = 'Room Block Pickup Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ALTER COLUMN `status_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Status Changed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `av_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Infrastructure');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_banquet` SET TAGS ('dbx_business_glossary_term' = 'Capacity Banquet Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_banquet` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_cabaret` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cabaret Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_cabaret` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_classroom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Classroom Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_classroom` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_hollow_square` SET TAGS ('dbx_business_glossary_term' = 'Capacity Hollow Square Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_hollow_square` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_reception` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reception Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_reception` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_theater` SET TAGS ('dbx_business_glossary_term' = 'Capacity Theater Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_theater` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_u_shape` SET TAGS ('dbx_business_glossary_term' = 'Capacity U-Shape Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `capacity_u_shape` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `catering_kitchen_access` SET TAGS ('dbx_business_glossary_term' = 'Catering Kitchen Access');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `ceiling_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height (Feet)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `climate_control` SET TAGS ('dbx_business_glossary_term' = 'Climate Control');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `climate_control` SET TAGS ('dbx_value_regex' = 'hvac|air_conditioning|heating|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `divisible` SET TAGS ('dbx_business_glossary_term' = 'Divisible Space');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Internet Connectivity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_value_regex' = 'wired|wireless|both|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `natural_light_available` SET TAGS ('dbx_business_glossary_term' = 'Natural Light Available');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Function Space Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|under_renovation|temporarily_closed|permanently_closed|seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `outdoor_space` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Space');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `partition_configuration` SET TAGS ('dbx_business_glossary_term' = 'Partition Configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_full_day` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Full Day');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_full_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_half_day` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Half Day');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_half_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_hourly` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Hourly');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `rental_rate_hourly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `space_code` SET TAGS ('dbx_business_glossary_term' = 'Function Space Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `space_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `space_name` SET TAGS ('dbx_business_glossary_term' = 'Function Space Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `space_type` SET TAGS ('dbx_business_glossary_term' = 'Function Space Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `space_type` SET TAGS ('dbx_value_regex' = 'ballroom|boardroom|breakout_room|exhibit_hall|pre_function_area|outdoor_terrace');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ALTER COLUMN `teardown_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|released|cancelled|waitlisted');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `booking_segment` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `booking_segment` SET TAGS ('dbx_value_regex' = 'corporate|association|government|social|wedding|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `complimentary_reason` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `guaranteed_attendance` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `rental_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `rental_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Rental Charge Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `rental_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `setup_start_time` SET TAGS ('dbx_business_glossary_term' = 'Setup Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `setup_style` SET TAGS ('dbx_business_glossary_term' = 'Setup Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `space_block_type` SET TAGS ('dbx_business_glossary_term' = 'Space Block Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `space_block_type` SET TAGS ('dbx_value_regex' = 'exclusive|shared|concurrent|overflow');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ALTER COLUMN `teardown_end_time` SET TAGS ('dbx_business_glossary_term' = 'Teardown End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `actual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `actual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `av_requirements` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beo_number` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beo_status` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beo_status` SET TAGS ('dbx_value_regex' = 'draft|issued|confirmed|revised|completed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beverage_package` SET TAGS ('dbx_business_glossary_term' = 'Beverage Package');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `beverage_package` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Billing Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'BEO Completed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'BEO Confirmed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `decor_notes` SET TAGS ('dbx_business_glossary_term' = 'Décor and Ambiance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `dietary_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restrictions and Allergies');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Function End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `external_beo_reference` SET TAGS ('dbx_business_glossary_term' = 'External Banquet Event Order (BEO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `function_name` SET TAGS ('dbx_business_glossary_term' = 'Function Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `function_type` SET TAGS ('dbx_business_glossary_term' = 'Function Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `guaranteed_attendance` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Attendance Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'BEO Issued Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `menu_selection` SET TAGS ('dbx_business_glossary_term' = 'Menu Selection');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `setup_style` SET TAGS ('dbx_business_glossary_term' = 'Setup Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `setup_time` SET TAGS ('dbx_business_glossary_term' = 'Setup Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Function Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `tax_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `tax_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `beo_item_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `catering_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'unbilled|billed|paid|disputed|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `dietary_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `dietary_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `guaranteed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'confirmed|tentative|cancelled|substituted');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `item_type` SET TAGS ('dbx_value_regex' = 'menu_item|package|equipment|service|charge|credit');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `overage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overage Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `overage_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'food|beverage|audio_visual|room_rental|labor|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `service_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `service_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `service_time` SET TAGS ('dbx_business_glossary_term' = 'Service Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `setup_time` SET TAGS ('dbx_business_glossary_term' = 'Setup Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `vendor_source` SET TAGS ('dbx_business_glossary_term' = 'Vendor Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `vendor_source` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|client_provided');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `catering_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Menu ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Source Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `allergen_declarations` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declarations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `contains_alcohol` SET TAGS ('dbx_business_glossary_term' = 'Contains Alcohol');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `contribution_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Margin Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `contribution_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `cost_per_person` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Person');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `cost_per_person` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `cuisine_style` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `catering_menu_description` SET TAGS ('dbx_business_glossary_term' = 'Menu Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `dietary_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Dietary Accommodations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `labor_intensity_rating` SET TAGS ('dbx_business_glossary_term' = 'Labor Intensity Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `labor_intensity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_category` SET TAGS ('dbx_business_glossary_term' = 'Menu Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_category` SET TAGS ('dbx_value_regex' = 'standard|premium|luxury|executive|budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_business_glossary_term' = 'Menu Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_business_glossary_term' = 'Menu Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `menu_type` SET TAGS ('dbx_business_glossary_term' = 'Menu Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `minimum_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `preparation_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Preparation Lead Time Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `presentation_image_url` SET TAGS ('dbx_business_glossary_term' = 'Presentation Image URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `presentation_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `presentation_image_url` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `price_per_person` SET TAGS ('dbx_business_glossary_term' = 'Price Per Person');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `requires_specialty_equipment` SET TAGS ('dbx_business_glossary_term' = 'Requires Specialty Equipment');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_value_regex' = 'year_round|spring|summer|fall|winter|holiday');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `service_style` SET TAGS ('dbx_business_glossary_term' = 'Service Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `service_style` SET TAGS ('dbx_value_regex' = 'buffet|plated|family_style|stations|passed|display');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `sustainability_certified` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[A-Z]{3})$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `event_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Event Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `amendment_history` SET TAGS ('dbx_business_glossary_term' = 'Amendment History');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `attrition_clause` SET TAGS ('dbx_business_glossary_term' = 'Attrition Clause');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `attrition_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `attrition_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Threshold Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `attrition_threshold_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `av_equipment_revenue` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `av_equipment_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `cancellation_penalty_schedule` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Penalty Schedule');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `cancellation_penalty_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_signature|executed|amended|cancelled|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_agreement|single_event|multi_event|tentative|definite');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `credit_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `deposit_schedule` SET TAGS ('dbx_business_glossary_term' = 'Deposit Schedule');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `deposit_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `fb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `fb_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `final_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `initial_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `initial_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `initial_deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `legal_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `master_account_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Account Billing Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `property_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Property Signatory Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `property_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `property_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Property Signatory Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `room_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `space_rental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Function Space Rental Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `space_rental_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `total_contracted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `total_contracted_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `event_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Event Revenue ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `event_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Event Contract Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Event Attendee Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Meetings Incentives Conferences Exhibitions (MICE) Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `group_adr` SET TAGS ('dbx_business_glossary_term' = 'Group Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `group_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Group Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partially_paid|overdue|written_off');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `per_attendee` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Attendee');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'accrual|cash|deferred');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'rooms|food|beverage|space_rental|av_equipment|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revenue_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revenue_source` SET TAGS ('dbx_business_glossary_term' = 'Revenue Source Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revenue_source` SET TAGS ('dbx_value_regex' = 'direct|ota|gds|corporate|group');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `revpar_contribution` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Available Room (RevPAR) Contribution');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Revenue Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `trevpar_contribution` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Per Available Room (TRevPAR) Contribution');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Variance Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
