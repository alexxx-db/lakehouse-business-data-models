-- Schema for Domain: reservation | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`reservation` COMMENT 'Core transactional domain managing the full booking lifecycle from inquiry through confirmation, modification, cancellation, and no-show management. Handles individual reservations, group blocks, and corporate bookings across all channels (direct, OTA, GDS, CRS). Tracks booking status, arrival/departure dates, room types, rate codes, special requests, and guarantee methods. Integrates with Oracle OPERA PMS and Sabre SynXis CRS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` (
    `reservation_booking_id` BIGINT COMMENT 'Unique identifier for the reservation booking record. Primary key for the reservation_booking product. System-generated surrogate key used across all downstream systems and analytics.',
    `booking_source_id` BIGINT COMMENT 'Foreign key reference to the booking source channel through which this reservation was created (direct website, OTA, GDS, phone, walk-in, corporate portal, etc.). Used for channel attribution and commission calculation.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key reference to the corporate account if this reservation is booked under a negotiated corporate rate agreement. Used for corporate billing and rate compliance auditing.',
    `market_segment_id` BIGINT COMMENT 'Foreign key reference to the market segment classification for this reservation (transient, group, corporate, leisure, government, etc.). Used for revenue management segmentation and forecasting.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the guest master record who is the primary guest on this reservation. Links to guest profile containing contact information, preferences, and loyalty status.',
    `property_id` BIGINT COMMENT 'Foreign key reference to the property where this reservation is booked. Links to property master containing location, brand, segment, and operational details.',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key reference to the group block if this reservation is part of a group booking (conference, wedding, corporate event, etc.). Null for individual FIT reservations.',
    `reservation_room_type_id` BIGINT COMMENT 'FK to inventory.room_type (replaces free-text room_type_requested)',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key reference to the rate plan applied to this reservation (BAR, LRA, NRR, corporate negotiated rate, promotional rate, package rate, etc.). Determines pricing rules and cancellation policies.',
    `room_type_id` BIGINT COMMENT 'Code representing the room type requested by the guest at time of booking (e.g., KING, QUEEN, SUITE, DELUXE). May differ from actual room type assigned at check-in. Normalized via inventory.room_type_id surrogate FK.',
    `travel_agent_id` BIGINT COMMENT 'Foreign key linking to reservation.travel_agent. Business justification: Reservation_booking currently references travel agent via travel_agent_iata_number (string business key). Normalizing to FK using travel_agent_id allows joining to get full agent details (agency_name,',
    `accessibility_required_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested an ADA-compliant accessible room. Used for room assignment and compliance with Americans with Disabilities Act requirements.',
    `arrival_date` DATE COMMENT 'Scheduled date the guest is expected to check in to the property. Used for occupancy forecasting, revenue projections, and operational planning (housekeeping, staffing).',
    `average_daily_rate` DECIMAL(18,2) COMMENT 'Average nightly room rate for this reservation, calculated as total_room_revenue divided by (length_of_stay * number_of_rooms). Core KPI for revenue management and competitive benchmarking.',
    `booking_date` DATE COMMENT 'Date the reservation was originally created in the system. Used to calculate booking lead time, pickup analysis, and demand forecasting accuracy.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the reservation. Tracks progression from initial booking through completion or cancellation. Updated by PMS based on guest actions and property operations. [ENUM-REF-CANDIDATE: confirmed|tentative|waitlisted|cancelled|no_show|checked_in|checked_out — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'Precise date and time the reservation was created, including timezone. Principal business event timestamp for this transaction. Used for channel performance analysis and real-time availability updates.',
    `cancellation_policy_code` STRING COMMENT 'Code representing the cancellation policy applicable to this reservation (e.g., 24HR, 72HR, NRR for non-refundable). Defines penalties and deadlines for cancellation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time the reservation was cancelled, if applicable. Null for active reservations. Used to calculate cancellation rates and revenue displacement analysis.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission payable to the booking channel or travel agent for this reservation. Calculated based on commission schedule and total room revenue.',
    `confirmation_number` STRING COMMENT 'Externally-facing alphanumeric confirmation code provided to the guest at time of booking. Used by guests to retrieve, modify, or cancel their reservation. Unique across all properties and channels.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was first created in the data warehouse. Used for data lineage and audit trail. Distinct from booking_timestamp which represents the business event time.',
    `crs_confirmation_number` STRING COMMENT 'Confirmation number generated by Sabre SynXis CRS for reservations originating through the central reservation system. Used for cross-system reconciliation and channel attribution.. Valid values are `^[A-Z0-9]{8,16}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this reservation (e.g., USD, EUR, GBP). Used for multi-currency reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `departure_date` DATE COMMENT 'Scheduled date the guest is expected to check out from the property. Used to calculate length of stay and room availability for subsequent bookings.',
    `early_checkin_requested_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested early check-in (before standard check-in time). Used for operational planning and guest service recovery.',
    `guarantee_method` STRING COMMENT 'Method by which the reservation is guaranteed against no-show. Determines cancellation policy enforcement and revenue recognition timing.. Valid values are `credit_card|deposit|corporate_account|travel_agent_voucher|prepaid|none`',
    `late_checkout_requested_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested late check-out (after standard check-out time). Used for housekeeping scheduling and room availability management.',
    `length_of_stay` STRING COMMENT 'Number of nights the guest is booked to stay, calculated as departure_date minus arrival_date. Key metric for revenue management, ALOS calculation, and yield optimization.',
    `loyalty_member_number` STRING COMMENT 'Loyalty program member number of the guest, if enrolled. Used for points accrual, tier benefits, and personalized guest recognition. Personally identifiable information.. Valid values are `^[A-Z0-9]{8,16}$`',
    `modification_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this reservation (date change, rate change, guest change, etc.). Used for audit trail and change tracking.',
    `number_of_adults` STRING COMMENT 'Count of adult guests (typically age 18+) included in this reservation. Used for occupancy reporting, F&B forecasting, and compliance with fire safety regulations.',
    `number_of_children` STRING COMMENT 'Count of child guests (typically under age 18) included in this reservation. Used for amenity planning, F&B forecasting, and family-friendly service delivery.',
    `number_of_rooms` STRING COMMENT 'Count of rooms reserved under this booking. Typically 1 for individual reservations; may be greater than 1 for multi-room bookings or small groups.',
    `package_code` STRING COMMENT 'Code representing a bundled package offering if this reservation includes additional services beyond room only (e.g., breakfast included, spa credit, parking, resort fee). Null for room-only bookings.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_method` STRING COMMENT 'Primary payment instrument used to guarantee or settle this reservation. Distinct from payment channel (web, mobile, front desk). [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|bank_transfer|mobile_payment|loyalty_points|corporate_billing — 7 candidates stripped; promote to reference product]',
    `pms_reservation_code` STRING COMMENT 'Native reservation identifier from Oracle OPERA PMS. Used for operational lookups and integration with front desk, housekeeping, and cashiering modules.. Valid values are `^[A-Z0-9]{8,20}$`',
    `points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this reservation. Calculated based on room revenue, member tier, and promotional multipliers.',
    `special_requests` STRING COMMENT 'Free-text field capturing guest special requests at time of booking (e.g., high floor, near elevator, extra pillows, early check-in). Used by operations to enhance guest experience.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Total room revenue for this reservation across all nights, before taxes and fees. Calculated as nightly rate multiplied by length of stay and number of rooms. Key component of RevPAR and ADR calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was last updated in the data warehouse. Used for incremental ETL processing and change data capture.',
    `vip_status_flag` BOOLEAN COMMENT 'Indicates whether this reservation is flagged for VIP treatment (high-value guest, loyalty elite member, celebrity, executive, etc.). Triggers enhanced service protocols and amenities.',
    CONSTRAINT pk_reservation_booking PRIMARY KEY(`reservation_booking_id`)
) COMMENT 'Core master record for an individual guest reservation across all booking channels (direct, OTA, GDS, CRS via Sabre SynXis). Captures the full booking lifecycle from inquiry through confirmation, modification, cancellation, and no-show. Stores arrival/departure dates, LOS (Length of Stay), room type requested, rate code, BAR/LRA/NRR rate plan, guarantee method, booking status, source channel, CRS confirmation number, OPERA PMS reservation ID, number of adults/children, and special request flags. SSOT for reservation identity across the enterprise. [SSOT_OWNER] [SSOT MASTER for group reservation.reservation_booking]channel_booking. [SSOT:booking] Domain-specific specialization of the booking concept; canonical SSOT owner is channel.channel_booking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` (
    `booking_status_history_id` BIGINT COMMENT 'Primary key for booking_status_history',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or system user who triggered this event. Null for system-automated events.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key reference to the parent reservation record. Links this status history event to the specific booking being tracked.',
    `agent_name` STRING COMMENT 'The name of the agent or system user who performed the action. Denormalized for audit trail completeness and reporting convenience.',
    `booking_source_code` STRING COMMENT 'The specific source within the channel (e.g., EXPEDIA, BOOKING_COM, BRAND_WEBSITE, CALL_CENTER). Provides granular attribution for the event.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `cancellation_reason_code` STRING COMMENT 'For cancellation events, the specific reason code (e.g., GUEST_CANCEL, WEATHER, EMERGENCY, DUPLICATE_BOOKING, RATE_ISSUE). Null for non-cancellation events.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_code` STRING COMMENT 'The distribution channel through which this event was initiated (e.g., DIRECT, OTA, GDS, CRS, VOICE, WALK_IN, MOBILE_APP). Denormalized for audit completeness.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `confirmation_number` STRING COMMENT 'The externally-known unique confirmation number for the reservation. Denormalized from parent reservation for audit trail completeness and query performance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this history record was created in the data warehouse. This is the ETL load time, distinct from event_timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this event is associated with a guest dispute or service recovery case. True if disputed, False otherwise.',
    `event_date` DATE COMMENT 'The calendar date of the event, extracted from event_timestamp for simplified date-based reporting and partitioning.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when this lifecycle event occurred in the source system. This is the business event time, not the ETL load time.',
    `event_type` STRING COMMENT 'Discriminator indicating the category of lifecycle event: status_change (status transition only), modification (booking amendment), cancellation (booking cancelled), no_show (guest did not arrive), check_in (guest arrived), check_out (guest departed).. Valid values are `status_change|modification|cancellation|no_show|check_in|check_out`',
    `guest_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification (email, SMS, push) was sent to the guest for this event. True if sent, False otherwise.',
    `guest_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the guest notification was sent. Null if no notification was sent.',
    `ip_address` STRING COMMENT 'The IP address from which the event was initiated. Captured for security audit, fraud detection, and compliance purposes. May be considered PII in some jurisdictions.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `modification_field_name` STRING COMMENT 'For modification events, the specific field or attribute that was changed (e.g., arrival_date, room_type_code, rate_code, number_of_adults). Enables granular change tracking.',
    `modification_type` STRING COMMENT 'For modification events, specifies the category of amendment: date_change (arrival/departure dates), room_type_change (upgrade/downgrade), rate_plan_change (rate code switch), occupancy_change (number of guests), special_request_update (preferences), guest_name_change (name correction), payment_method_change (guarantee method), package_change (package modification), add_on_change (ancillary services). Null for non-modification events. [ENUM-REF-CANDIDATE: date_change|room_type_change|rate_plan_change|occupancy_change|special_request_update|guest_name_change|payment_method_change|package_change|add_on_change — 9 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The reservation status after this event. Represents the current state of the booking at the time of this history record. [ENUM-REF-CANDIDATE: inquiry|tentative|waitlisted|confirmed|guaranteed|modified|cancelled|no_show|checked_in|checked_out|due_in|due_out — 12 candidates stripped; promote to reference product]',
    `new_value` DECIMAL(18,2) COMMENT 'For modification events, the value of the field after the change. Stored as string to accommodate various data types. Null for non-modification events.',
    `no_show_reason_code` STRING COMMENT 'For no-show events, the reason code (e.g., NO_CONTACT, FLIGHT_DELAY, GUEST_FORGOT, DUPLICATE_BOOKING). Null for non-no-show events.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `original_value` DECIMAL(18,2) COMMENT 'For modification events, the value of the field before the change. Stored as string to accommodate various data types. Null for non-modification events.',
    `penalty_fee_amount` DECIMAL(18,2) COMMENT 'For cancellation or modification events, any penalty or change fee assessed per the rate plan rules. Zero if no penalty applies.',
    `previous_status` STRING COMMENT 'The reservation status immediately before this event. Null for the initial status record. Values align with Oracle OPERA PMS reservation status codes. [ENUM-REF-CANDIDATE: inquiry|tentative|waitlisted|confirmed|guaranteed|modified|cancelled|no_show|checked_in|checked_out|due_in|due_out — 12 candidates stripped; promote to reference product]',
    `property_code` STRING COMMENT 'The unique code identifying the hotel or resort property where this reservation event occurred. Denormalized for partition key and audit completeness.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rate_difference_amount` DECIMAL(18,2) COMMENT 'For modification events, the monetary difference between the original and new rate (positive for increase, negative for decrease). Null for non-rate-change events.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the status change or modification (e.g., GUEST_REQUEST, RATE_CHANGE, OVERBOOKING, NO_SHOW, EARLY_DEPARTURE, SYSTEM_AUTO). Aligns with property-defined reason code tables.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `reason_description` STRING COMMENT 'Free-text explanation or additional context for the status change or modification. Captures agent notes or system-generated descriptions.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The estimated revenue impact of this event (positive for revenue gain, negative for revenue loss). Calculated based on rate changes, cancellations, and penalties.',
    `sla_actual_minutes` STRING COMMENT 'The actual processing time in minutes from event initiation to completion. Used to measure SLA performance.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this event met the defined Service Level Agreement (SLA) for processing time. True if compliant, False if SLA was breached.',
    `sla_target_minutes` STRING COMMENT 'The target processing time in minutes defined by the SLA for this event type. Used to calculate SLA compliance.',
    `system_source` STRING COMMENT 'The source system or interface that generated this event (e.g., OPERA_PMS for front desk, SYNXIS_CRS for central reservations, MOBILE_APP for guest self-service).. Valid values are `OPERA_PMS|SYNXIS_CRS|MOBILE_APP|KIOSK|INTERFACE|BATCH`',
    `transaction_reference` STRING COMMENT 'The unique transaction or session identifier from the source system. Enables correlation with source system logs for troubleshooting and dispute resolution.. Valid values are `^[A-Z0-9-]{10,50}$`',
    `user_agent` STRING COMMENT 'The browser or application user agent string for web/mobile-initiated events. Supports device analytics and troubleshooting.',
    CONSTRAINT pk_booking_status_history PRIMARY KEY(`booking_status_history_id`)
) COMMENT 'Immutable audit trail of all reservation lifecycle events including status transitions (Inquiry → Tentative → Confirmed → Modified → Cancelled → No-Show → Checked-In → Checked-Out) and all booking modifications. For status changes, captures previous status, new status, transition timestamp, triggering agent/system, and reason code. For modifications (the SSOT for all amendment records), captures amendment type (date change, room type upgrade/downgrade, rate plan switch, occupancy change, special request update), original values, new values, modification channel, modification timestamp, agent ID, and any associated rate difference or penalty fee. Enables lifecycle analytics, SLA compliance tracking, revenue impact analysis, dispute resolution, and guest service recovery workflows. Sourced from Oracle OPERA PMS status change and modification events.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'Unique identifier for the cancellation or no-show event. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Cancellations trigger revenue reversals, refund processing, and penalty charges that must link to the original AR invoice for accurate revenue recognition, refund authorization, and financial reportin',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Cancellations require booking source attribution for channel-specific cancellation policy enforcement, commission reversal calculations, and OTA penalty assessment. Currently only links to ota_partner',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Cancellation currently references policy via cancellation_policy_code (string). Normalizing to FK allows joining to get full policy details (policy_name, policy_description, penalty_type, penalty_amou',
    `employee_id` BIGINT COMMENT 'Identifier of the agent or system user who processed the cancellation or no-show event.',
    `ota_partner_id` BIGINT COMMENT 'Reference to the OTA partner if the cancellation was initiated by or processed through an OTA channel.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who held the cancelled or no-show reservation.',
    `property_id` BIGINT COMMENT 'Reference to the property where the cancellation or no-show occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation that was cancelled or resulted in a no-show.',
    `confirmation_number` STRING COMMENT 'The externally-known reservation confirmation number associated with the cancelled or no-show reservation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was first created in the system.',
    `dispute_date` DATE COMMENT 'Date when the guest initiated a dispute of the cancellation penalty or no-show fee.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the guest has disputed the cancellation penalty or no-show fee charge.',
    `dispute_resolution_status` STRING COMMENT 'Current status of the dispute resolution process (open, resolved in guest favor, resolved in property favor, or withdrawn by guest).. Valid values are `open|resolved_guest_favor|resolved_property_favor|withdrawn`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation or no-show event occurred. For cancellations: when the cancellation was processed. For no-shows: the date/time the guest failed to arrive.',
    `event_type` STRING COMMENT 'Type of non-fulfillment event: guest-initiated cancellation, property-initiated cancellation, OTA-initiated cancellation, or no-show (non-arrival).. Valid values are `guest_cancellation|property_cancellation|ota_cancellation|no_show`',
    `guarantee_charge_processed_flag` BOOLEAN COMMENT 'Indicates whether the guarantee charge (penalty or no-show fee) was successfully processed against the guarantee method.',
    `guarantee_method` STRING COMMENT 'Method used to guarantee the reservation (credit card, deposit, corporate guarantee, travel agent guarantee, or none). Critical for no-show charge processing.. Valid values are `credit_card|deposit|corporate_guarantee|travel_agent_guarantee|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was last updated.',
    `original_arrival_date` DATE COMMENT 'The scheduled arrival date of the cancelled or no-show reservation.',
    `original_departure_date` DATE COMMENT 'The scheduled departure date of the cancelled or no-show reservation.',
    `ota_chargeback_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged back to the OTA for commission recovery on this cancellation or no-show.',
    `ota_chargeback_eligible_flag` BOOLEAN COMMENT 'Indicates whether the property is eligible to charge back the commission to the OTA for this cancellation or no-show per the OTA contract terms.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fee charged for the cancellation or no-show, in the propertys base currency.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a cancellation penalty or no-show fee is applicable based on the policy and timing of the event.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `posting_status` STRING COMMENT 'Status of the penalty charge posting to the guest folio or account (posted, pending, reversed, or failed).. Valid values are `posted|pending|reversed|failed`',
    `processing_channel` STRING COMMENT 'Channel through which the cancellation or no-show was processed (PMS - Property Management System, CRS - Central Reservation System, OTA - Online Travel Agency, GDS - Global Distribution System, call center, mobile app, web). [ENUM-REF-CANDIDATE: pms|crs|ota|gds|call_center|mobile_app|web — 7 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation (e.g., CHANGE_PLANS, DUPLICATE_BOOKING, PRICE_ISSUE, EMERGENCY, OTHER). Null for no-show events.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `reason_description` STRING COMMENT 'Free-text description or additional details about the cancellation reason provided by the guest or agent.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the guest after applicable penalties, in the propertys base currency.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether the guest is eligible for a refund of any prepaid amounts after penalty deduction.',
    `revenue_lost_amount` DECIMAL(18,2) COMMENT 'Total room revenue lost due to the cancellation or no-show, calculated from the original reservation rate and length of stay.',
    `reversal_date` DATE COMMENT 'Date when the penalty charge was reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether the cancellation penalty or no-show fee charge was subsequently reversed.',
    `reversal_reason` STRING COMMENT 'Explanation or reason for reversing the cancellation penalty or no-show fee charge.',
    `room_nights_lost` STRING COMMENT 'Number of room nights lost due to the cancellation or no-show, calculated as the difference between arrival and departure dates.',
    `waiver_authorized_by` STRING COMMENT 'Name or identifier of the manager or agent who authorized the penalty waiver.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the cancellation penalty or no-show fee was waived by the property.',
    `waiver_reason_code` STRING COMMENT 'Standardized code indicating the reason for waiving the penalty (e.g., LOYALTY_STATUS, EMERGENCY, SERVICE_RECOVERY, MANAGER_DISCRETION).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `window_hours` STRING COMMENT 'Number of hours before arrival that the cancellation occurred, used to evaluate penalty applicability per the cancellation policy.',
    CONSTRAINT pk_cancellation PRIMARY KEY(`cancellation_id`)
) COMMENT 'Transactional record capturing all reservation non-fulfillment events including guest cancellations, property-initiated cancellations, OTA-initiated cancellations, and no-show (non-arrival) events. For cancellations: records event date/time, reason code, applicable cancellation policy, penalty/fee amount, cancellation window evaluation, refund eligibility, and processing channel. For no-shows: records no-show date, no-show fee charged, guarantee method used for charge, automatic guarantee charge processing, and OTA chargeback eligibility. Common fields: waiver flag, waiver reason, posting status to guest folio, processing agent/channel, and any subsequent dispute or reversal. Critical for revenue leakage analysis, NRR policy enforcement, revenue recovery operations, OTA chargeback management, and CPOR (Cost Per Occupied Room) reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` (
    `reservation_group_block_id` BIGINT COMMENT 'Unique identifier for the group room block record. Primary key.',
    `booking_source_id` BIGINT COMMENT 'Reference to the channel or booking source through which the group block was created.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account or travel agency associated with this group block, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the sales or reservations staff member responsible for managing this group block.',
    `event_booking_id` BIGINT COMMENT 'Reference to the associated event or meeting record if this group block is linked to a MICE event managed in the event domain.',
    `guest_group_block_id` BIGINT COMMENT 'add column guest_group_block_id (BIGINT) with FK to guest.guest_group_block.guest_group_block_id - reservation group blocks must link to guest group block SSOT.',
    `property_id` BIGINT COMMENT 'Reference to the property where the group block is held.',
    `arrival_date` DATE COMMENT 'The first date of the group block period when guests are expected to check in.',
    `attrition_clause_flag` BOOLEAN COMMENT 'Indicates whether the group block contract includes an attrition clause requiring minimum room pickup or penalties.',
    `attrition_threshold_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage of contracted rooms that must be picked up to avoid attrition penalties, if applicable.',
    `available_room_count` STRING COMMENT 'The number of rooms remaining available in the block for booking, calculated as contracted minus pickup.',
    `billing_instruction` STRING COMMENT 'Instructions for billing and invoicing the group, including payment terms and responsible party details.',
    `block_code` STRING COMMENT 'Externally-known unique code or identifier for the group block, used for booking and reference purposes across systems.',
    `block_name` STRING COMMENT 'Human-readable name or title of the group block, typically reflecting the event, corporate account, or travel agency name.',
    `block_status` STRING COMMENT 'Current lifecycle status of the group block indicating its booking stage and commitment level.. Valid values are `tentative|definite|cancelled|waitlist|inquiry|contracted`',
    `block_type` STRING COMMENT 'Classification of the group block by business segment or purpose, such as corporate meeting, MICE (Meetings Incentives Conferences Exhibitions), tour operator, or wedding. [ENUM-REF-CANDIDATE: corporate|leisure_group|mice|tour_operator|wholesale|airline_crew|wedding — 7 candidates stripped; promote to reference product]',
    `cancellation_policy` STRING COMMENT 'Description of the cancellation terms and conditions applicable to the group block.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation or code describing the reason for group block cancellation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the group block was cancelled, if applicable.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'The commission rate percentage payable to the booking agent or intermediary for this group block.',
    `contact_email` STRING COMMENT 'The email address of the primary contact person for the group block.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'The full name of the primary contact person for the group block.',
    `contact_phone` STRING COMMENT 'The phone number of the primary contact person for the group block.',
    `contract_signed_date` DATE COMMENT 'The date on which the group block contract was signed by both parties.',
    `contracted_room_count` STRING COMMENT 'The total number of rooms contracted or committed in the group block agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the group block record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the group rate amount.. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'The deadline date by which the group must pick up rooms from the block before unbooked rooms are released back to general inventory.',
    `departure_date` DATE COMMENT 'The last date of the group block period when guests are expected to check out.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The monetary deposit amount required for the group block, if applicable.',
    `deposit_due_date` DATE COMMENT 'The date by which the deposit payment must be received.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a deposit is required to secure the group block.',
    `group_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated nightly room rate amount for the group block, typically in the propertys base currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the group block record was last updated or modified.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether the group block has Last Room Availability (LRA) status, meaning rooms are available at the group rate even when the property is sold out.',
    `notes` STRING COMMENT 'General free-text notes or comments related to the group block for internal reference.',
    `pickup_room_count` STRING COMMENT 'The number of rooms from the block that have been booked or picked up by the group as of the current date.',
    `rate_code` STRING COMMENT 'The rate code or rate plan identifier associated with the group block pricing.',
    `revenue_forecast_amount` DECIMAL(18,2) COMMENT 'The forecasted total revenue expected from this group block based on contracted rooms and rates.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or requirements from the group, such as room setup, amenities, or services.',
    `wash_schedule_date` DATE COMMENT 'The date on which the group block inventory is scheduled to be washed or adjusted based on pickup performance.',
    CONSTRAINT pk_reservation_group_block PRIMARY KEY(`reservation_group_block_id`)
) COMMENT 'Master record for a group room block associated with a corporate account, travel agency, or event. Manages the contracted room block size, pickup count, cutoff date, group rate code, block status (tentative/definite/cancelled), attrition clause, and wash schedule. Links to the event domain for MICE group blocks and to the channel domain for wholesale/tour operator blocks. Sourced from Oracle OPERA PMS Group Block module and Delphi by Amadeus for event-linked groups. [SSOT_OWNER] [SSOT MASTER for group reservation.reservation_group_block]event_group_block. [SSOT:group_block] Domain-specific specialization of the group_block concept; canonical SSOT owner is event.event_group_block.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` (
    `group_block_pickup_id` BIGINT COMMENT 'Unique identifier for the group block pickup transaction. Primary key for this entity.',
    `property_id` BIGINT COMMENT 'Reference to the property where the group block pickup occurred. Enables property-level group performance analysis.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the individual reservation that consumed inventory from the group block. Links to the transactional reservation record.',
    `reservation_group_block_id` BIGINT COMMENT 'Reference to the parent group block from which this pickup was made. Links to the master group block allocation.',
    `arrival_date` DATE COMMENT 'Scheduled check-in date for the pickup reservation. Used for occupancy forecasting and group block utilization analysis.',
    `block_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total group block consumed at the time of this pickup. Calculated as (total_block_rooms - remaining_block_rooms) / total_block_rooms * 100.',
    `booking_channel_code` STRING COMMENT 'Code identifying the channel through which the pickup was made (e.g., DIRECT, GDS, OTA, CRS). Enables channel attribution analysis for group blocks.',
    `booking_source` STRING COMMENT 'Specific source system or platform that originated the pickup (e.g., OPERA, SynXis, Delphi). Used for system integration tracking.',
    `cancellation_date` DATE COMMENT 'Date when this pickup reservation was cancelled, if applicable. Used for attrition analysis and wash factor calculation.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation. Supports root cause analysis of group block attrition.',
    `company_name` STRING COMMENT 'Name of the company or organization associated with this pickup. Links individual reservations to corporate accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pickup record was first created in the data platform. Supports data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount (e.g., USD, EUR, GBP). Essential for multi-currency group block management.. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'Date by which the group block inventory must be picked up or released back to general inventory. Critical for attrition management.',
    `departure_date` DATE COMMENT 'Scheduled check-out date for the pickup reservation. Used to calculate Length of Stay (LOS) and room night consumption.',
    `group_attendee_type` STRING COMMENT 'Classification of the attendee role within the group event. Supports rooming list segmentation and billing allocation. [ENUM-REF-CANDIDATE: attendee|speaker|organizer|exhibitor|sponsor|staff|guest — 7 candidates stripped; promote to reference product]',
    `guarantee_type` STRING COMMENT 'Method used to guarantee the pickup reservation. Critical for no-show risk assessment and revenue assurance.. Valid values are `credit_card|deposit|corporate|travel_agent|none`',
    `guest_email` STRING COMMENT 'Primary email address for the guest on this pickup reservation. Used for confirmation and pre-arrival communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `guest_name` STRING COMMENT 'Full name of the guest associated with this pickup reservation. Used for rooming list management and guest communication.',
    `guest_phone` STRING COMMENT 'Primary contact phone number for the guest. Critical for day-of-arrival communication and service recovery.',
    `loyalty_member_number` STRING COMMENT 'Loyalty program membership identifier for the guest. Enables points accrual and tier benefit application for group pickups.',
    `market_segment_code` STRING COMMENT 'Market segment classification for this pickup (e.g., CORPORATE, LEISURE, GOVERNMENT). Supports segmentation analysis within group blocks.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this pickup record was last updated. Enables change tracking and data quality monitoring.',
    `nights` STRING COMMENT 'Total number of room nights consumed by this pickup. Calculated as departure_date minus arrival_date. Key metric for group block utilization.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the guest failed to arrive for this pickup reservation. Critical for no-show rate tracking and revenue recovery.',
    `pickup_before_cutoff_flag` BOOLEAN COMMENT 'Indicates whether this pickup occurred before the group block cutoff date. Used to assess on-time pickup performance.',
    `pickup_number` STRING COMMENT 'Business-readable identifier for the pickup transaction, typically generated by the Property Management System (PMS) or Central Reservation System (CRS).',
    `pickup_status` STRING COMMENT 'Current lifecycle status of the pickup reservation. Tracks progression from initial booking through completion or cancellation. [ENUM-REF-CANDIDATE: confirmed|tentative|cancelled|no_show|checked_in|checked_out|waitlisted — 7 candidates stripped; promote to reference product]',
    `pickup_timestamp` TIMESTAMP COMMENT 'Date and time when the individual reservation was booked against the group block inventory. Critical for tracking pickup velocity and cutoff date management.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Nightly room rate applied to this pickup reservation. Used to calculate total room revenue and compare against Best Available Rate (BAR).',
    `rate_code` STRING COMMENT 'Rate plan code applied to this pickup reservation. Typically the negotiated group rate code from the master group block contract.',
    `remaining_block_rooms` STRING COMMENT 'Number of rooms remaining in the group block after this pickup. Snapshot metric for real-time utilization monitoring.',
    `room_type_code` STRING COMMENT 'Code identifying the specific room type consumed from the group block inventory (e.g., KING, QUEEN, SUITE). Enables room type mix analysis.',
    `room_type_name` STRING COMMENT 'Human-readable description of the room type consumed (e.g., Deluxe King, Executive Suite). Supports reporting and guest communication.',
    `source_system_code` STRING COMMENT 'Unique identifier for this pickup record in the source operational system. Enables cross-system reconciliation and data traceability.',
    `special_requests` STRING COMMENT 'Free-text field capturing guest special requests for this pickup (e.g., high floor, accessible room, early check-in). Supports service delivery.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Total room revenue generated by this pickup, calculated as rate_amount multiplied by nights. Excludes taxes and fees.',
    `vip_indicator` BOOLEAN COMMENT 'Flag indicating whether this pickup is for a VIP guest requiring special handling. Drives service prioritization and amenity allocation.',
    CONSTRAINT pk_group_block_pickup PRIMARY KEY(`group_block_pickup_id`)
) COMMENT 'Transactional record tracking individual reservation pickups against a group block, capturing the booking reference, pickup date, room type consumed, rate applied, and remaining block inventory. Enables real-time group block utilization monitoring, attrition risk assessment, and cutoff date management. Supports revenue management decisions on releasing unsold group inventory back to transient availability.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` (
    `reservation_rate_plan_id` BIGINT COMMENT 'Unique identifier for the reservation rate plan record. Primary key for this entity.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Reservation_rate_plan currently references policy via cancellation_policy_code (string). Normalizing to FK allows joining to get full policy details. Rate plans are defined with specific cancellation ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit trail for rate plan authorship is critical revenue management and compliance requirement. Tracks which revenue manager created rate plans for pricing accountability and regulatory audit. No exis',
    `revenue_rate_plan_id` BIGINT COMMENT 'add column revenue_rate_plan_id (BIGINT) with FK to revenue.revenue_rate_plan.revenue_rate_plan_id - reservation rate plans must reference the revenue master rate plan to resolve SSOT duplicate.',
    `channel_rate_plan_id` BIGINT COMMENT '',
    `advance_purchase_days` STRING COMMENT 'Number of days in advance that a booking must be made to qualify for this rate plan. Common for promotional and non-refundable rates (e.g., 7-day, 14-day, 21-day advance purchase). Null or 0 indicates no advance purchase requirement.',
    `booking_window_end_days` STRING COMMENT 'Number of days before arrival when this rate plan is no longer available for booking. Used to close last-minute bookings for certain rate plans. Null indicates no end restriction.',
    `booking_window_start_days` STRING COMMENT 'Number of days before arrival when this rate plan becomes available for booking. Used to control early booking windows for promotional rates. Null indicates no start restriction.',
    `channel_corporate_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through corporate direct billing channels. Requires corporate account setup and negotiated rate agreement.',
    `channel_direct_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through direct channels (property website, call center, front desk). True for most rate plans; false for channel-exclusive rates.',
    `channel_gds_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through GDS channels (Sabre, Amadeus, Galileo, Worldspan). Typically used for corporate and travel agent bookings.',
    `channel_group_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for group block bookings through MICE and event sales channels. Managed via Delphi by Amadeus for group inventory allocation.',
    `channel_ota_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through OTA channels (Expedia, Booking.com, etc.). Subject to rate parity agreements and channel management rules.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'The percentage of the room rate paid as commission to the booking channel or agent. Typically 10-25% for OTAs, 10% for travel agents. Null if commissionable_flag is false.',
    `commissionable_flag` BOOLEAN COMMENT 'Indicates whether bookings under this rate plan are eligible for travel agent or OTA commission. True for most OTA and GDS rates; false for net rates and direct promotional rates.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rate plan record was first created in the system. Used for audit trail and lifecycle tracking.',
    `display_sequence` STRING COMMENT 'The order in which this rate plan should be displayed to guests and agents in the booking interface. Lower numbers appear first. Used to prioritize high-value or strategic rate plans.',
    `effective_end_date` DATE COMMENT 'The date after which this rate plan is no longer available for booking or stay dates. Nullable for evergreen rate plans like BAR. Used for promotional and seasonal rate plan expiration.',
    `effective_start_date` DATE COMMENT 'The date from which this rate plan becomes available for booking and stay dates. Aligns with revenue management strategy and seasonal pricing windows.',
    `guarantee_method` STRING COMMENT 'The method by which the reservation must be guaranteed. Credit card: hold on card; Deposit: partial payment required; Prepayment: full payment required; Direct bill: corporate account billing; None: no guarantee required.. Valid values are `credit_card|deposit|prepayment|direct_bill|none`',
    `guarantee_required_flag` BOOLEAN COMMENT 'Indicates whether a payment guarantee (credit card, deposit, or prepayment) is required at the time of booking for this rate plan. True for most rate plans; false for select corporate or group rates with direct billing arrangements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rate plan record was last updated. Used for change tracking and synchronization across systems.',
    `loyalty_eligible_flag` BOOLEAN COMMENT 'Indicates whether stays booked under this rate plan are eligible for loyalty program points accrual and elite benefits. True for most direct and qualified rates; false for opaque and deeply discounted rates.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to base loyalty points earned for stays under this rate plan. Standard rates typically have 1.0x; promotional rates may have 0.5x or 2.0x multipliers. Null if loyalty_eligible_flag is false.',
    `market_segment_code` STRING COMMENT 'Reference code to the market segment this rate plan targets. Examples: TRAN (transient), CORP (corporate), GROUP (group), LEISURE (leisure). Used for revenue reporting and STR benchmarking.. Valid values are `^[A-Z]{3,6}$`',
    `maximum_length_of_stay` STRING COMMENT 'Maximum number of nights allowed for a booking under this rate plan. Used to prevent long-stay bookings from blocking high-value short-stay demand. Null indicates no maximum restriction.',
    `member_only_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is exclusively available to loyalty program members. True for member-exclusive rates; false for public rates.',
    `minimum_length_of_stay` STRING COMMENT 'Minimum number of nights required for a booking under this rate plan. Used for revenue optimization during high-demand periods. Null or 1 indicates no minimum restriction.',
    `package_description` STRING COMMENT 'Detailed description of the amenities, services, or F&B components included in the package rate. Examples: Daily breakfast for two, $50 spa credit, complimentary parking, welcome amenity. Null for non-package rates.',
    `package_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this rate plan includes bundled amenities, services, or F&B components (e.g., breakfast included, spa credit, parking). True for package rates; false for room-only rates.',
    `rate_plan_category` STRING COMMENT 'High-level classification of the rate plan type for segmentation and reporting. Standard includes BAR and rack rates; corporate includes negotiated business rates; promotional includes limited-time offers; package includes bundled F&B or amenities; group includes MICE block rates; wholesale includes tour operator allotments; opaque includes non-branded OTA rates; member includes loyalty program rates; government includes public sector rates. [ENUM-REF-CANDIDATE: standard|corporate|promotional|package|group|wholesale|opaque|member|government — 9 candidates stripped; promote to reference product]',
    `rate_plan_code` STRING COMMENT 'Unique business identifier for the rate plan as configured in the CRS and PMS. Examples: BAR, CORP, AAA, PKG, NRF. This is the externally-known code used across all distribution channels.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rate_plan_description` STRING COMMENT 'Detailed business description of the rate plan, including terms, conditions, restrictions, and benefits. Used for guest communication and agent training.',
    `rate_plan_name` STRING COMMENT 'Human-readable name of the rate plan displayed to guests and agents. Examples: Best Available Rate, Corporate Negotiated Rate, AAA Member Rate, Romance Package, Non-Refundable Rate.',
    `rate_plan_status` STRING COMMENT 'Current lifecycle status of the rate plan. Active: available for booking; Inactive: not available for new bookings; Suspended: temporarily disabled; Pending: awaiting approval or activation; Expired: past effective end date.. Valid values are `active|inactive|suspended|pending|expired`',
    `source_system_code` STRING COMMENT 'Identifies the system of record where this rate plan was originally configured. SYNXIS: Sabre SynXis CRS; OPERA: Oracle OPERA PMS; IDEAS: IDeaS G3 RMS strategy output; MANUAL: manually configured rate plan.. Valid values are `SYNXIS|OPERA|IDEAS|MANUAL`',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the rate plan, including cancellation penalties, modification rules, no-show charges, and guest obligations. Must comply with consumer protection regulations.',
    CONSTRAINT pk_reservation_rate_plan PRIMARY KEY(`reservation_rate_plan_id`)
) COMMENT 'Single source of truth is revenue.revenue_rate_plan. Reservation-scoped reference master for the bookable rate plan catalog presented to guests and agents via CRS and PMS. Includes BAR (Best Available Rate), LRA (Last Room Availability), NRR (Non-Refundable Rate), corporate negotiated rates, package rates, and promotional rates. Stores rate plan code, rate plan name, rate category, cancellation policy reference, guarantee requirements, minimum LOS restrictions, advance purchase requirements, and channel eligibility flags. SSOT BOUNDARY: This domain owns the bookable rate plan catalog (what can be sold and under what terms). The revenue domain owns rate strategy, pricing optimization, yield management, and dynamic rate amounts. Rate plan records here are synchronized from Sabre SynXis CRS rate configuration and reflect IDeaS G3 RMS rate strategy outputs as read-only pricing inputs. SSOT: defers to revenue.revenue_rate_plan (MVM).revenue_rate_plan as single source of truth]channel_rate_plan. [SSOT:rate_plan] Domain-specific specialization of the rate_plan concept; canonical SSOT owner is channel.channel_rate_plan. SSOT: defers to canonical revenue.revenue_rate_plan (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` (
    `cancellation_policy_id` BIGINT COMMENT 'Unique identifier for the cancellation policy. Primary key.',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `allows_modification` BOOLEAN COMMENT 'Indicates whether reservations under this policy allow date or room type modifications without cancellation. False for most non-refundable policies.',
    `applies_to_corporate_bookings` BOOLEAN COMMENT 'Indicates whether this policy can be applied to corporate negotiated rate bookings. Corporate accounts may have special cancellation terms.',
    `applies_to_group_bookings` BOOLEAN COMMENT 'Indicates whether this policy can be applied to group block reservations. Group policies often have different terms than individual FIT (Free Independent Traveler) bookings.',
    `channel_restrictions` STRING COMMENT 'Comma-separated list of booking channels where this policy applies or is restricted. Examples: direct_only, ota_excluded, gds_only. Null indicates no channel restrictions.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this cancellation policy. Part of audit trail for policy governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cancellation policy record was first created in the system. Part of audit trail for policy lifecycle management.',
    `deposit_due_days_before_arrival` STRING COMMENT 'Number of days before arrival date by which the deposit must be received. Null indicates deposit due at time of booking.',
    `deposit_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value required as deposit when deposit_required is true. Value stored as decimal (e.g., 100.00 for full prepayment).',
    `deposit_required` BOOLEAN COMMENT 'Indicates whether an advance deposit payment is required at time of booking under this policy. Common for non-refundable and group bookings.',
    `display_order` STRING COMMENT 'Numeric sequence for ordering policies in user interfaces and booking engines. Lower numbers appear first. Used for presenting policies from most to least flexible.',
    `effective_end_date` DATE COMMENT 'Date after which this cancellation policy is no longer active for new reservations. Null indicates policy is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this cancellation policy becomes active and can be applied to new reservations. Part of policy lifecycle management.',
    `free_cancellation_window_days` STRING COMMENT 'Number of days before scheduled arrival date during which a guest can cancel without penalty. Alternative to hours-based window for longer lead-time policies.',
    `free_cancellation_window_hours` STRING COMMENT 'Number of hours before scheduled arrival time during which a guest can cancel without penalty. Null indicates no free cancellation window.',
    `guarantee_required` BOOLEAN COMMENT 'Indicates whether a payment guarantee (credit card, deposit, or prepayment) is required to book under this cancellation policy. Typically true for stricter policies.',
    `guest_facing_summary` STRING COMMENT 'Concise, guest-friendly summary of the cancellation policy displayed during booking process. Typically 1-2 sentences highlighting key terms.',
    `internal_notes` STRING COMMENT 'Internal staff notes and operational guidance for applying this cancellation policy. Not visible to guests. Used for training and exception handling.',
    `is_non_refundable` BOOLEAN COMMENT 'Indicates whether this policy represents a non-refundable rate where no refund is provided under any circumstances. True for NRR (Non-Refundable Rate) policies.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this cancellation policy. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cancellation policy record was last updated. Tracks policy changes for revenue management analysis and compliance audit.',
    `legal_terms_text` STRING COMMENT 'Full legal terms and conditions text for the cancellation policy, including jurisdiction-specific consumer protection disclosures required by GDPR, CCPA, and local regulations.',
    `modification_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged for modifying a reservation when allows_modification is true. Null if no modification fee applies. Currency is property base currency.',
    `no_show_penalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary penalty charged for no-show when no_show_penalty_type is flat_fee. Currency is property base currency per USALI standards.',
    `no_show_penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value charged as penalty for no-show when no_show_penalty_type is percentage_of_stay. Value stored as decimal.',
    `no_show_penalty_type` STRING COMMENT 'Type of penalty applied when a guest fails to arrive (no-show). May differ from standard cancellation penalty to account for lost revenue opportunity.. Valid values are `first_night|full_stay|flat_fee|percentage_of_stay|same_as_cancellation`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary penalty amount charged for cancellation when penalty_type is flat_fee. Currency is property base currency per USALI standards.',
    `penalty_nights_count` STRING COMMENT 'Number of nights charged as penalty when penalty_type is first_night or nights_based. Typically 1 for first night penalty, can be higher for stricter policies.',
    `penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value charged as penalty when penalty_type is percentage_of_stay. Value stored as decimal (e.g., 50.00 for 50%).',
    `penalty_type` STRING COMMENT 'Type of penalty applied when cancellation occurs outside the free cancellation window. Determines how the cancellation charge is calculated.. Valid values are `first_night|percentage_of_stay|flat_fee|full_stay|no_penalty|nights_based`',
    `policy_code` STRING COMMENT 'Unique business identifier code for the cancellation policy used in PMS (Property Management System) and CRS (Central Reservation System) systems. Examples: FLEX, MOD, STRICT, NRF.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `policy_description` STRING COMMENT 'Detailed description of the cancellation policy terms and conditions, including guest-facing language explaining cancellation rules, deadlines, and penalties.',
    `policy_name` STRING COMMENT 'Human-readable name of the cancellation policy displayed to guests and staff. Examples: Flexible Cancellation, Moderate Cancellation, Strict Cancellation, Non-Refundable.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the cancellation policy. Only active policies can be assigned to rate plans and reservations.. Valid values are `active|inactive|draft|archived|suspended`',
    `policy_tier` STRING COMMENT 'Classification tier of the cancellation policy indicating the level of flexibility offered to guests. Aligned with revenue management strategy and rate plan positioning.. Valid values are `flexible|moderate|strict|non_refundable|super_flexible|custom`',
    `seasonal_override_allowed` BOOLEAN COMMENT 'Indicates whether this policy can be overridden by seasonal or event-specific cancellation rules during high-demand periods.',
    `source_system_code` STRING COMMENT 'Unique identifier of this cancellation policy in the source operational system. Used for data lineage and reconciliation with PMS (Property Management System) or CRS (Central Reservation System).',
    CONSTRAINT pk_cancellation_policy PRIMARY KEY(`cancellation_policy_id`)
) COMMENT 'Reference master defining the terms and conditions for reservation cancellation, including the policy code, policy name, free cancellation window (hours/days before arrival), penalty structure (first night, percentage of stay, flat fee), non-refundable flag, and applicable rate plan associations. Manages multiple policy tiers (flexible, moderate, strict, non-refundable) aligned with revenue management strategy. Sourced from Oracle OPERA PMS policy configuration.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` (
    `reservation_special_request_id` BIGINT COMMENT 'Unique identifier for the special request record. Primary key for the reservation special request entity.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member assigned to fulfill the special request. Enables accountability tracking and performance measurement.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who made the special request. Enables tracking of guest preferences across multiple stays.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the special request is to be fulfilled. Supports multi-property operations and reporting.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the parent reservation to which this special request is attached. Links the request to the booking record in Oracle OPERA PMS.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was acknowledged by the assigned department or staff member. Tracks response time for Service Level Agreement (SLA) compliance.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred by the property to fulfill the special request. Supports Cost Per Occupied Room (CPOR) analysis and operational efficiency measurement.',
    `assigned_department` STRING COMMENT 'Operational department responsible for fulfilling the special request. Routes the request to the appropriate team for action. [ENUM-REF-CANDIDATE: front_desk|housekeeping|food_beverage|concierge|maintenance|guest_services|spa|transportation|events|other — 10 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged to the guest for fulfilling the special request. Posted to the guest folio in the Property Management System (PMS).',
    `charge_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Supports multi-currency operations for international properties.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the special request record was first created in the database. Used for audit trail and data lineage tracking.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Internal estimated cost to the property for fulfilling the special request. Used for operational expense tracking and profitability analysis.',
    `failure_category` STRING COMMENT 'Classification of the reason for request non-fulfillment. Enables root cause analysis and operational improvement initiatives. [ENUM-REF-CANDIDATE: unavailable|capacity_constraint|policy_restriction|cost_prohibitive|timing_conflict|guest_cancelled|system_error|other — 8 candidates stripped; promote to reference product]',
    `failure_reason` STRING COMMENT 'Explanation of why the special request could not be fulfilled or was only partially fulfilled. Supports service recovery and guest communication.',
    `fulfillment_status` STRING COMMENT 'Current state of the special request in the fulfillment workflow. Tracks progress from initial submission through completion or cancellation. [ENUM-REF-CANDIDATE: pending|acknowledged|in_progress|fulfilled|partially_fulfilled|unable_to_fulfill|cancelled — 7 candidates stripped; promote to reference product]',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was completed or fulfilled. Used for cycle time analysis and guest experience measurement.',
    `guest_feedback_text` STRING COMMENT 'Free-form guest comments or feedback regarding the special request fulfillment. Captured through post-stay surveys or direct communication.',
    `guest_notified_flag` BOOLEAN COMMENT 'Indicates whether the guest has been notified of the fulfillment status or any issues with the special request. Tracks communication completion.',
    `guest_satisfaction_rating` STRING COMMENT 'Guest-provided satisfaction rating for how the special request was handled, typically on a scale of 1-5 or 1-10. Feeds into Guest Satisfaction Score (GSS) and Net Promoter Score (NPS) calculations.',
    `impacts_loyalty_points` BOOLEAN COMMENT 'Indicates whether fulfillment or non-fulfillment of this special request affects the guest loyalty program points or status. Used for loyalty program integration.',
    `internal_notes` STRING COMMENT 'Staff-only notes and comments regarding the special request fulfillment process. Not visible to guests; used for operational coordination.',
    `is_pre_arrival` BOOLEAN COMMENT 'Indicates whether the special request was submitted before the guest arrival date. Pre-arrival requests enable proactive preparation and enhanced guest experience.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this is a recurring preference that should be applied to future reservations for the same guest. Supports loyalty program personalization.',
    `is_vip_request` BOOLEAN COMMENT 'Indicates whether the special request is associated with a VIP (Very Important Person) guest requiring elevated attention and priority handling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the special request record was last updated. Supports change tracking and audit compliance.',
    `notification_method` STRING COMMENT 'Communication channel used to notify the guest about the special request status. Supports omnichannel guest communication tracking. [ENUM-REF-CANDIDATE: email|sms|phone_call|mobile_app|in_person|letter|none — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Urgency classification of the special request indicating the importance for guest satisfaction and operational sequencing. Critical requests require immediate attention.. Valid values are `critical|high|medium|low`',
    `request_category` STRING COMMENT 'High-level grouping of the request type for operational planning and resource allocation. Used for departmental workload distribution. [ENUM-REF-CANDIDATE: room_setup|service_timing|accessibility|amenity|food_beverage|transportation|special_event|general — 8 candidates stripped; promote to reference product]',
    `request_code` STRING COMMENT 'Standardized code identifying the type of special request in the Property Management System (PMS). Used for system processing and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `request_source` STRING COMMENT 'Channel or method through which the special request was submitted. Supports channel performance analysis and guest experience tracking. [ENUM-REF-CANDIDATE: guest_direct|reservation_agent|online_booking|mobile_app|call_center|email|walk_in|loyalty_program|group_coordinator|travel_agent|ota|gds|other — 13 candidates stripped; promote to reference product]',
    `request_text` STRING COMMENT 'Free-form text description of the special request as entered by the guest or reservation agent. Captures detailed instructions and context for fulfillment.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was originally submitted by the guest or agent. Represents the business event time for the request creation.',
    `request_type` STRING COMMENT 'Category of the special request indicating the nature of the guest need. Supports operational routing to appropriate departments (housekeeping, front desk, food and beverage, concierge). [ENUM-REF-CANDIDATE: bed_configuration|floor_preference|accessibility_need|early_check_in|late_check_out|amenity_delivery|dietary_requirement|room_location|view_preference|temperature_preference|pillow_preference|transportation|special_occasion|other — 14 candidates stripped; promote to reference product]',
    `requires_charge` BOOLEAN COMMENT 'Indicates whether fulfilling the special request incurs an additional charge to the guest folio. Used for revenue tracking and billing integration.',
    `source_system_code` STRING COMMENT 'Unique identifier of the special request in the source operational system. Enables traceability and reconciliation with upstream systems.',
    `target_fulfillment_date` DATE COMMENT 'Planned date by which the special request should be fulfilled. Often aligned with guest arrival date or specific event timing.',
    CONSTRAINT pk_reservation_special_request PRIMARY KEY(`reservation_special_request_id`)
) COMMENT 'Transactional record capturing guest special requests attached to a reservation, including request type (bed configuration, floor preference, accessibility needs, early check-in, late check-out, amenity delivery, dietary requirement), request text, fulfillment status, assigned department, fulfillment timestamp, and failure reason if unmet. Supports pre-arrival operations, housekeeping coordination, and guest experience personalization. Sourced from Oracle OPERA PMS traces and requests module. [SSOT_OWNER] [SSOT MASTER for group reservation.reservation_special_request]experience_special_request. [SSOT:special_request] Domain-specific specialization of the special_request concept; canonical SSOT owner is experience.experience_special_request.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` (
    `deposit_ledger_id` BIGINT COMMENT 'Unique identifier for the deposit ledger entry. Primary key for the deposit ledger transaction record.',
    `ar_payment_id` BIGINT COMMENT 'Foreign key linking to finance.ar_payment. Business justification: Deposit payments must link to AR payment records for cash application, reconciliation, and refund processing. Essential for front desk operations matching deposits to guest payments and finance reconc',
    `channel_id` BIGINT COMMENT 'Reference to the booking channel through which the reservation and deposit were made. Supports channel performance analysis and commission tracking.',
    `employee_id` BIGINT COMMENT 'System user ID of the staff member who processed the deposit transaction. Supports audit trails and operational accountability.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Deposits post to specific GL accounts (advance deposits liability, forfeited deposits revenue). Required for nightly audit GL reconciliation, balance sheet accuracy, and SOX compliance for cash handli',
    `profile_id` BIGINT COMMENT 'Reference to the guest who made the deposit payment. Links deposit to guest profile for reconciliation and loyalty tracking.',
    `property_id` BIGINT COMMENT 'Reference to the property where the reservation and deposit are recorded. Supports multi-property operations.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation against which this deposit is recorded. Links the deposit to the booking lifecycle.',
    `applied_to_folio_date` DATE COMMENT 'The date when the deposit was applied to the guest folio. Marks the transition from advance deposit liability to revenue or accounts receivable offset.',
    `booking_source` STRING COMMENT 'The originating source of the reservation booking. Used for channel attribution, commission calculation, and marketing ROI analysis. [ENUM-REF-CANDIDATE: direct|ota|gds|crs|corporate|group|travel_agent|wholesaler — 8 candidates stripped; promote to reference product]',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation policy governing deposit refund or forfeiture. Linked to rate plan and booking channel terms.. Valid values are `^[A-Z0-9]{2,10}$`',
    `card_last_four_digits` STRING COMMENT 'Last four digits of the payment card used for the deposit. Stored for guest reference and dispute resolution while maintaining PCI compliance.. Valid values are `^[0-9]{4}$`',
    `confirmation_number` STRING COMMENT 'The externally-known confirmation number for the reservation. Used for guest communication and deposit tracking across channels.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this deposit ledger record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deposit amount. Supports multi-currency operations and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The monetary value of the deposit collected or due. Represents the base deposit amount before any adjustments or fees.',
    `deposit_due_date` DATE COMMENT 'The date by which the deposit payment is required. Used for payment reminders, cancellation policy enforcement, and revenue forecasting.',
    `deposit_policy_code` STRING COMMENT 'Code identifying the deposit policy applied to this reservation. Determines deposit amount, due date, and cancellation terms.. Valid values are `^[A-Z0-9]{2,10}$`',
    `deposit_status` STRING COMMENT 'Current lifecycle status of the deposit. Tracks progression from due through collection, application to folio, or refund/forfeiture.. Valid values are `pending|received|applied|refunded|forfeited|cancelled`',
    `deposit_type` STRING COMMENT 'Classification of the deposit based on its business purpose. Determines handling rules, refund policies, and revenue recognition treatment.. Valid values are `advance_deposit|guarantee_deposit|group_deposit|event_deposit|cancellation_penalty|damage_deposit`',
    `folio_number` STRING COMMENT 'The guest folio number to which this deposit was applied. Links deposit to final billing and checkout reconciliation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `forfeiture_amount` DECIMAL(18,2) COMMENT 'The monetary value of the deposit that was forfeited due to cancellation policy or no-show. Recognized as revenue per cancellation terms.',
    `forfeiture_date` DATE COMMENT 'The date when the deposit was forfeited. Triggers revenue recognition and updates reservation status to cancelled or no-show.',
    `forfeiture_reason` STRING COMMENT 'Business reason for deposit forfeiture. Used for policy compliance tracking, revenue analysis, and guest communication.. Valid values are `no_show|late_cancellation|policy_violation|early_departure|group_attrition`',
    `notes` STRING COMMENT 'Free-text notes regarding the deposit transaction. Captures special circumstances, guest requests, or operational exceptions.',
    `payment_received_date` DATE COMMENT 'The date when the deposit payment was actually received by the property. Critical for cash flow tracking and revenue recognition.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary value refunded to the guest if the deposit was returned. May differ from original deposit amount due to cancellation fees or partial refunds.',
    `refund_date` DATE COMMENT 'The date when the deposit refund was processed. Used for cash flow tracking and guest satisfaction monitoring.',
    `refund_reference_number` STRING COMMENT 'External reference number for the refund transaction from the payment processor. Used for refund reconciliation and audit trails.. Valid values are `^[A-Z0-9-]{6,50}$`',
    `revenue_recognition_date` DATE COMMENT 'The date when the deposit is recognized as revenue per ASC 606 guidelines. May differ from payment received date based on performance obligation fulfillment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this deposit ledger record was last modified. Tracks changes for audit and reconciliation purposes.',
    CONSTRAINT pk_deposit_ledger PRIMARY KEY(`deposit_ledger_id`)
) COMMENT 'Transactional ledger tracking all advance deposits collected, applied, or refunded against a reservation. Records deposit amount, due date, payment method, payment reference, status (pending/received/applied/refunded/forfeited), and posting date. Supports pre-arrival cashiering, revenue recognition compliance (ASC 606), and guest folio reconciliation. Distinct from the finance domains general ledger — this is the reservation-scoped deposit lifecycle record.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` (
    `travel_agent_id` BIGINT COMMENT 'Primary key for travel_agent',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Travel agent commissions generate AP invoices for payment processing. Essential for commission accounting, agent payment reconciliation, and tracking commission expense against booking revenue for pro',
    `ap_payment_id` BIGINT COMMENT 'Foreign key linking to finance.ap_payment. Business justification: Links agent commission payments to travel agent records for payment tracking, dispute resolution, and commission expense reconciliation. Required for agent relationship management and accurate commiss',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Travel agents operate through specific distribution channels (GDS, direct connect, portal) requiring channel assignment for connectivity fee allocation, commission schedule application, and channel-sp',
    `parent_agency_reservation_travel_agent_id` BIGINT COMMENT 'Reference to the parent travel agency if this agent is part of a franchise, consortium, or multi-branch organization. Enables hierarchical reporting of agency performance.',
    `address_line1` STRING COMMENT 'First line of the travel agencys physical or mailing address, typically containing street number and street name.',
    `address_line2` STRING COMMENT 'Second line of the travel agencys address for suite, floor, building, or additional location details.',
    `agency_name` STRING COMMENT 'Legal or trading name of the travel agency or travel management company (TMC). Primary human-readable identifier.',
    `agency_type` STRING COMMENT 'Classification of the travel agency business model. Retail agencies serve individual travelers, corporate TMCs manage business travel programs, OTAs operate online platforms, tour operators package travel products, consortiums are agency networks, and wholesalers distribute bulk inventory.. Valid values are `retail|corporate_tmc|online_travel_agency|tour_operator|consortium|wholesaler`',
    `arc_number` STRING COMMENT 'Seven or eight-digit ARC accreditation number for US-based travel agencies. Used for commission processing and booking attribution in the North American market.. Valid values are `^[0-9]{7,8}$`',
    `booking_volume_tier` STRING COMMENT 'Tiered classification based on the travel agents historical booking volume or revenue contribution. Higher tiers may receive preferential commission rates, priority support, or marketing benefits.. Valid values are `bronze|silver|gold|platinum|diamond`',
    `city` STRING COMMENT 'City or municipality where the travel agency is located.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Default commission percentage paid to the travel agent on qualifying bookings. Expressed as a percentage (e.g., 10.00 for 10%). May be overridden by specific rate plans or negotiated contracts.',
    `contact_email` STRING COMMENT 'Primary email address for the travel agency contact. Used for booking confirmations, commission statements, and operational notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the primary contact person at the travel agency for operational communication, booking inquiries, and relationship management.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the travel agency contact. Used for urgent booking issues, reservation modifications, and relationship management.',
    `contract_end_date` DATE COMMENT 'Date when the travel agent contract expires or was terminated. Null for open-ended relationships. Used to enforce commission eligibility windows.',
    `contract_start_date` DATE COMMENT 'Date when the travel agent relationship or contract became effective. Marks the beginning of the commission-earning period.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the travel agencys location (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this travel agent record was first created in the system. Used for audit trail and data lineage.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the travel agent on direct bill or net remit payment terms. Expressed in the propertys base currency. Used for credit risk management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for commission payments and credit limits (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `gds_identifier` STRING COMMENT 'Unique identifier or pseudo city code (PCC) assigned to the travel agent within the Global Distribution System (Amadeus, Sabre, Galileo, Worldspan). Used to attribute bookings originating from GDS channels.',
    `iata_number` STRING COMMENT 'Eight-digit IATA accreditation number assigned to the travel agency by the International Air Transport Association. Primary industry identifier for accredited travel agencies.. Valid values are `^[0-9]{8}$`',
    `last_booking_date` DATE COMMENT 'Date of the most recent reservation created by this travel agent. Used to identify inactive agents and trigger re-engagement campaigns.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, relationship history, or internal comments about the travel agent. Used by sales and reservations teams.',
    `onboarding_completed_date` DATE COMMENT 'Date when the travel agent completed all onboarding requirements (contract signing, profile setup, training, system access). Marks readiness to begin booking.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the travel agencys address.',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code for the travel agents preferred communication language (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `preferred_payment_method` STRING COMMENT 'Default payment instrument used by the travel agent for booking guarantees and deposits. Credit card for immediate authorization, bank transfer for wire payments, check for paper payments, direct bill for invoiced accounts, virtual card for single-use card numbers, net remit for commission offset against payment.. Valid values are `credit_card|bank_transfer|check|direct_bill|virtual_card|net_remit`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the travel agency is located.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (TIN, EIN, VAT number) for the travel agency. Used for commission payment reporting and tax compliance.',
    `total_bookings_count` STRING COMMENT 'Cumulative count of all reservations created by this travel agent since relationship inception. Used for performance reporting and tier qualification.',
    `total_revenue_generated` DECIMAL(18,2) COMMENT 'Cumulative room revenue generated by all bookings attributed to this travel agent since relationship inception. Expressed in the propertys base currency. Used for tier qualification and ROI analysis.',
    `travel_agent_status` STRING COMMENT 'Current lifecycle status of the travel agent relationship. Active agents can make bookings and earn commissions. Inactive agents are temporarily disabled. Suspended agents are under review. Pending approval agents await onboarding completion. Terminated agents have ended their relationship. Blacklisted agents are permanently banned.. Valid values are `active|inactive|suspended|pending_approval|terminated|blacklisted`',
    `updated_by` STRING COMMENT 'Username or system identifier of the user or process that last modified this travel agent record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this travel agent record was last modified. Used for audit trail and change tracking.',
    `website_url` STRING COMMENT 'Primary website URL for the travel agency. Used for agency verification and marketing partnership opportunities.',
    `created_by` STRING COMMENT 'Username or system identifier of the user or process that created this travel agent record. Used for audit trail and accountability.',
    CONSTRAINT pk_travel_agent PRIMARY KEY(`travel_agent_id`)
) COMMENT 'Master record for travel agencies and travel management companies (TMCs) authorized to book on behalf of guests, including IATA/ARC number, agency name, agency type, commission rate, preferred payment method, GDS identifier, and active status. Manages the agency relationship for commission processing, booking attribution, and channel performance reporting. Sourced from Oracle OPERA PMS travel agent profile module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` (
    `waitlist_id` BIGINT COMMENT 'Unique identifier for the waitlist entry. Primary key.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Waitlist entries need channel tracking for conversion rate analysis by channel, automated notification routing through originating channel, and channel-specific rate/availability offers when rooms bec',
    `corporate_account_id` BIGINT COMMENT 'Identifier of the corporate account associated with this waitlist entry, if applicable. Used for priority handling of corporate bookings.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest profile requesting the waitlist entry.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that converted the waitlist entry to a reservation. Null if not yet converted.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the waitlist entry was created.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation that was converted from this waitlist entry, if applicable. Null if not yet converted.',
    `tertiary_waitlist_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified the waitlist entry.',
    `auto_convert_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the system should automatically convert this waitlist entry to a confirmed reservation when inventory becomes available (True) or require manual confirmation (False).',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason the waitlist entry was cancelled. Null if not cancelled.. Valid values are `guest_request|no_availability|duplicate|expired|other`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Timestamp when the waitlist entry was cancelled by the guest or system. Null if not cancelled.',
    `channel_code` STRING COMMENT 'Code identifying the booking channel through which the waitlist request was received (e.g., DIRECT, OTA, GDS, CRS).',
    `contact_email` STRING COMMENT 'Email address provided by the guest for waitlist status notifications and conversion opportunities.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number provided by the guest for waitlist status notifications and conversion opportunities.',
    `converted_timestamp` TIMESTAMP COMMENT 'Timestamp when the waitlist entry was converted to a confirmed reservation. Null if not yet converted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waitlist entry was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted rate amount.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Date when the waitlist entry will automatically expire if not converted. Typically set to the requested arrival date or a configured number of days after creation.',
    `external_reference_code` STRING COMMENT 'External identifier from the originating system or channel, used for cross-system reconciliation and tracking.',
    `guarantee_type_code` STRING COMMENT 'Code indicating the guarantee method provided by the guest for the waitlisted reservation.. Valid values are `credit_card|deposit|corporate|none`',
    `guest_priority_tier` STRING COMMENT 'Loyalty tier or priority classification of the guest, used to determine waitlist position and conversion priority.. Valid values are `platinum|gold|silver|member|non_member`',
    `market_segment_code` STRING COMMENT 'Code identifying the market segment classification for this waitlist entry (e.g., LEISURE, CORPORATE, GROUP).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the waitlist entry was last modified.',
    `notes` STRING COMMENT 'Free-text field for internal staff notes regarding the waitlist entry, conversion attempts, or guest communication history.',
    `notification_preference` STRING COMMENT 'Guests preferred method for receiving waitlist status updates and conversion notifications.. Valid values are `email|phone|sms|none`',
    `position` STRING COMMENT 'Numeric position of this entry in the waitlist queue for the requested room type and dates. Lower numbers indicate higher priority.',
    `quoted_rate_amount` DECIMAL(18,2) COMMENT 'The room rate amount quoted to the guest at the time of waitlist creation, in the propertys base currency.',
    `rate_plan_code` STRING COMMENT 'Code identifying the rate plan the guest requested for the waitlisted reservation (e.g., BAR, CORP, AAA).',
    `reason_code` STRING COMMENT 'Code indicating the reason the guest was placed on the waitlist rather than confirmed immediately.. Valid values are `sold_out|room_type_unavailable|rate_unavailable|group_block_full|maintenance|other`',
    `requested_arrival_date` DATE COMMENT 'The arrival date requested by the guest for the waitlisted reservation.',
    `requested_departure_date` DATE COMMENT 'The departure date requested by the guest for the waitlisted reservation.',
    `requested_nights` STRING COMMENT 'Number of nights requested by the guest, calculated as departure date minus arrival date.',
    `requested_room_count` STRING COMMENT 'Number of rooms requested by the guest on the waitlist.',
    `requested_room_type_code` STRING COMMENT 'Code identifying the room type requested by the guest (e.g., KING, SUITE, DELUXE).',
    `source_system_code` STRING COMMENT 'Code identifying the source system that originated this waitlist entry.. Valid values are `OPERA|SYNXIS|SALESFORCE|MANUAL|API`',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or preferences noted by the guest at the time of waitlist creation (e.g., high floor, near elevator, accessible room).',
    `waitlist_number` STRING COMMENT 'Human-readable business identifier for the waitlist entry, typically formatted as WL followed by numeric sequence.. Valid values are `^WL[0-9]{8,12}$`',
    `waitlist_status` STRING COMMENT 'Current lifecycle status of the waitlist entry. Active indicates the guest is still waiting; converted means a reservation was created; expired means the requested dates have passed; cancelled means the guest withdrew; fulfilled means inventory was allocated.. Valid values are `active|converted|expired|cancelled|fulfilled`',
    CONSTRAINT pk_waitlist PRIMARY KEY(`waitlist_id`)
) COMMENT 'Transactional record managing reservation waitlist entries when requested room types or dates are unavailable. Captures waitlist position, requested arrival/departure dates, requested room type, rate plan, guest priority (loyalty tier, corporate account), waitlist status (active, converted, expired, cancelled), and conversion timestamp if fulfilled. Supports inventory optimization and guest recovery when rooms become available through cancellations.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` (
    `room_assignment_id` BIGINT COMMENT 'Primary key for room_assignment',
    `connected_room_assignment_id` BIGINT COMMENT 'Reference to the room assignment ID of the connecting room, if applicable. Null if not part of a connecting room arrangement.',
    `employee_id` BIGINT COMMENT 'User identifier of the staff member who performed the room assignment. Null for automated assignments.',
    `property_id` BIGINT COMMENT 'Reference to the property where the room is located. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'FK to reservation.booking.booking_id — MUST-HAVE: Room assignment must link to the reservation it fulfills. Core operational join for check-in, room move, and folio management workflows.',
    `room_id` BIGINT COMMENT 'Reference to the specific physical room assigned to this reservation. Links to the room inventory master data.',
    `room_reservation_booking_id` BIGINT COMMENT 'Reference to the confirmed reservation that this room assignment belongs to. Links to the parent reservation record in Oracle OPERA PMS.',
    `tertiary_room_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the staff member who last modified this room assignment record. Used for accountability and audit trail.',
    `assignment_date` DATE COMMENT 'Business date on which the room assignment was made. Used for operational reporting and day-level analytics.',
    `assignment_method` STRING COMMENT 'Method by which the room was assigned. Indicates whether assignment was automated, manual, or driven by guest preference.. Valid values are `auto_assigned|manually_assigned|guest_requested|loyalty_preference|group_block|pre_arrival_selection`',
    `assignment_source_system` STRING COMMENT 'Name of the system or channel through which the room assignment was made (e.g., OPERA PMS, Mobile Check-In, Kiosk, Front Desk Terminal).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the room assignment. Tracks progression from initial assignment through guest departure.. Valid values are `assigned|confirmed|checked_in|checked_out|cancelled|reassigned`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the room was assigned to the reservation. Represents the moment the assignment was committed in the PMS.',
    `bed_configuration` STRING COMMENT 'Bed type and configuration in the assigned room. Critical for matching guest preferences and group requirements. [ENUM-REF-CANDIDATE: king|queen|double_queen|twin|double_twin|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `building_code` STRING COMMENT 'Code identifying the building or tower within a multi-building property (e.g., MAIN, TOWER-A, VILLA). Null for single-building properties.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this room assignment record was first created in the system. Used for audit trail and data lineage.',
    `early_checkin_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment was made to accommodate an early check-in request (arrival before standard check-in time).',
    `floor_number` STRING COMMENT 'The floor level where the assigned room is located. Used for guest preferences and operational logistics.',
    `guest_preference_match_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) indicating how well this room assignment matches the guests stated preferences (floor, view, location, amenities). Used for service quality measurement.',
    `is_accessible_room` BOOLEAN COMMENT 'Boolean flag indicating whether the assigned room meets ADA accessibility requirements. Used for compliance reporting and guest matching.',
    `is_connecting_room` BOOLEAN COMMENT 'Boolean flag indicating whether this room is part of a connecting room pair or group. Used for family and group bookings.',
    `is_guest_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the guest specifically requested this room or room type during pre-arrival or at check-in.',
    `is_upgrade` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment represents an upgrade from the originally booked room type.',
    `key_created_timestamp` TIMESTAMP COMMENT 'Date and time when the room key (physical or digital) was created for this assignment. Indicates actual guest check-in readiness.',
    `key_type` STRING COMMENT 'Type of room key issued to the guest for this assignment. Used for technology adoption tracking and guest preference analysis.. Valid values are `physical|mobile|rfid|magnetic_stripe`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this room assignment record was last updated. Used for change tracking and audit purposes.',
    `late_checkout_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment includes a late check-out accommodation (departure after standard check-out time).',
    `lock_status` STRING COMMENT 'Status indicating whether the room assignment is locked (cannot be changed) or unlocked (can be reassigned). Used to prevent accidental changes during check-in.. Valid values are `unlocked|locked|pending_release`',
    `locked_timestamp` TIMESTAMP COMMENT 'Date and time when the room assignment was locked. Null if assignment is not locked.',
    `original_room_type_code` STRING COMMENT 'The room type code that was originally booked by the guest. Used to calculate upgrade value and track displacement.',
    `previous_room_number` STRING COMMENT 'The room number from which the guest was reassigned, if applicable. Null for initial assignments. Used for reassignment tracking.',
    `reassignment_count` STRING COMMENT 'Number of times this reservation has been reassigned to a different room. Used to track operational disruptions and guest experience impact.',
    `reassignment_reason_code` STRING COMMENT 'Code indicating the reason for room reassignment. Null if no reassignment has occurred. Used for root cause analysis.. Valid values are `maintenance_issue|guest_complaint|overbooking|upgrade|operational|guest_request`',
    `reassignment_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent room reassignment. Null if no reassignment has occurred.',
    `room_condition_at_assignment` STRING COMMENT 'Housekeeping status of the room at the time of assignment. Ensures only ready rooms are assigned to arriving guests.. Valid values are `clean|inspected|ready|maintenance_required|out_of_order`',
    `room_type_code` STRING COMMENT 'Code representing the room type assigned (e.g., KING, DBLQ, STE, PTHS). Used for inventory management and rate application.',
    `smoking_preference` STRING COMMENT 'Smoking designation of the assigned room. Used to match guest preferences and comply with local regulations.. Valid values are `non_smoking|smoking`',
    `special_request_notes` STRING COMMENT 'Free-text notes capturing any special requests related to the room assignment (e.g., high floor, away from elevator, connecting rooms, accessible features).',
    `upgrade_category` STRING COMMENT 'High-level category of the upgrade indicating whether it was complimentary, paid, loyalty-driven, or operationally necessary.. Valid values are `complimentary|paid|loyalty|operational`',
    `upgrade_reason_code` STRING COMMENT 'Code indicating the reason for the room upgrade. Null if is_upgrade is false. Used for revenue management and guest satisfaction analysis. [ENUM-REF-CANDIDATE: loyalty_status|operational|paid_upgrade|service_recovery|availability|overbooking|vip|group_courtesy — 8 candidates stripped; promote to reference product]',
    `view_type` STRING COMMENT 'Type of view available from the assigned room. Used for guest preference matching and upsell opportunities. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|partial_ocean|no_view — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_room_assignment PRIMARY KEY(`room_assignment_id`)
) COMMENT 'Transactional record linking a confirmed reservation to a specific physical room at the property, capturing the assigned room number, room type, floor, assignment timestamp, assignment method (auto-assigned, manually assigned, guest-requested), upgrade flag, upgrade reason, and assignment status. Tracks room reassignments and upgrades throughout the pre-arrival and check-in process. Sourced from Oracle OPERA PMS room assignment module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` (
    `booking_package_id` BIGINT COMMENT 'Unique identifier for the booking package record. Primary key.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Booking_package currently has cancellation_policy (string) field. Normalizing to FK allows joining to get full policy details (penalty terms, free cancellation windows, etc.). Packages have specific c',
    `property_id` BIGINT COMMENT 'Reference to the property where the package is offered and fulfilled. Used for multi-property reporting and revenue allocation.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the parent reservation to which this package is attached.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Reference to the rate plan under which this package is offered. Links package to pricing strategy and market segment.',
    `cancellation_deadline` TIMESTAMP COMMENT 'Date and time by which the package can be cancelled without penalty. Used for revenue management and guest communication.',
    `cancellation_reason` STRING COMMENT 'Reason code or free-text explanation for package cancellation. Used for service recovery and trend analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the package was cancelled. Null if package is still active.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the package revenue is eligible for commission payment to Online Travel Agency (OTA), Global Distribution System (GDS), or other intermediaries.',
    `component_list` STRING COMMENT 'Comma-separated or structured list of individual components included in the package (e.g., breakfast for 2, spa credit $100, parking, airport transfer). Used for operational fulfillment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the package record was first created in the system. Used for audit trail and booking velocity analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for package pricing. Examples: USD, EUR, GBP, JPY.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Date when the package expires or is no longer available for consumption. Typically aligns with check-out date.',
    `fb_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of package revenue allocated to the Food and Beverage (F&B) department for departmental profit analysis.',
    `fulfillment_instructions` STRING COMMENT 'Operational instructions for property staff on how to deliver and track package components. May include Point of Sale (POS) codes, voucher numbers, or service delivery notes.',
    `is_inclusive` BOOLEAN COMMENT 'Indicates whether the package rate is included in the room rate (true) or charged separately (false). Affects Average Daily Rate (ADR) calculation.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the package is mandatory for the reservation (e.g., resort fee, breakfast inclusion) or optional add-on.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the package charges are refundable upon cancellation or modification of the reservation.',
    `market_segment_code` STRING COMMENT 'Market segment classification for the package (e.g., leisure, corporate, group, Meetings Incentives Conferences Exhibitions (MICE)). Used for revenue management and segmentation analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `modified_by` STRING COMMENT 'User ID or name of the staff member or system that last modified the package record. Used for audit and quality control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the package record was last modified. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text operational notes or comments about the package. Used for internal communication and service delivery coordination.',
    `other_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of package revenue allocated to other departments (spa, golf, activities, parking, etc.) for Total Revenue Per Available Room (TRevPAR) calculation.',
    `package_category` STRING COMMENT 'Classification of the package type for reporting and revenue allocation purposes.. Valid values are `meal_plan|amenity|experience|transportation|promotional|corporate`',
    `package_code` STRING COMMENT 'Unique alphanumeric code identifying the package type in the Property Management System (PMS). Examples: BRKFST, ROMANCE, GOLF, SPA.. Valid values are `^[A-Z0-9]{3,10}$`',
    `package_cost_amount` DECIMAL(18,2) COMMENT 'Total cost to the property for delivering the package components. Used for Gross Operating Profit (GOP) calculation.',
    `package_description` STRING COMMENT 'Detailed description of the package contents, inclusions, terms, and conditions. Used for guest communication and operational fulfillment.',
    `package_name` STRING COMMENT 'Human-readable name of the package. Examples: Bed and Breakfast, Romance Package, Golf Getaway, Spa Retreat.',
    `package_rate_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the package charged to the guest. Represents the package price component of the reservation.',
    `package_status` STRING COMMENT 'Current lifecycle status of the package within the reservation. Tracks from reservation through fulfillment or cancellation. [ENUM-REF-CANDIDATE: active|reserved|confirmed|consumed|cancelled|expired|no_show — 7 candidates stripped; promote to reference product]',
    `posting_rhythm` STRING COMMENT 'Frequency and timing rule for posting package charges to the guest folio. Determines revenue recognition timing.. Valid values are `once|daily|per_night|per_person|on_departure`',
    `quantity` STRING COMMENT 'Number of package units included in the reservation. Typically 1 per guest or per room depending on package type.',
    `redemption_date` DATE COMMENT 'Date when the package was fully redeemed or consumed by the guest. Null if not yet redeemed.',
    `redemption_status` STRING COMMENT 'Tracks whether the guest has consumed or redeemed the package components. Used for fulfillment tracking and service recovery.. Valid values are `not_redeemed|partially_redeemed|fully_redeemed|expired|waived`',
    `revenue_allocation_method` STRING COMMENT 'Method for allocating package revenue across departments (rooms, Food and Beverage (F&B), spa, etc.) per Uniform System of Accounts for the Lodging Industry (USALI) standards.. Valid values are `rooms_only|split_allocation|component_based|departmental`',
    `rooms_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of package revenue allocated to the Rooms department for Revenue Per Available Room (RevPAR) and departmental reporting.',
    `special_requests` STRING COMMENT 'Guest-specific requests or modifications to the standard package (e.g., dietary restrictions for breakfast, preferred spa treatment time).',
    `start_date` DATE COMMENT 'Date when the package becomes active and available for guest consumption. Typically aligns with check-in date.',
    `tax_inclusive` BOOLEAN COMMENT 'Indicates whether the package rate amount includes applicable taxes (true) or taxes are calculated separately (false).',
    `created_by` STRING COMMENT 'User ID or name of the staff member or system that added the package to the reservation. Used for audit and training purposes.',
    CONSTRAINT pk_booking_package PRIMARY KEY(`booking_package_id`)
) COMMENT 'Transactional record capturing package components bundled with a reservation, such as breakfast inclusion, spa credits, parking, airport transfers, romance packages, and F&B vouchers. Stores package code, package description, included components, package rate, component value, posting instructions, and redemption status. Supports revenue allocation across departments (rooms vs. F&B vs. spa) and package fulfillment tracking. Sourced from Oracle OPERA PMS package module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` (
    `walk_record_id` BIGINT COMMENT 'Unique identifier for the walk record transaction. Primary key.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Walk events require originating channel tracking for OTA penalty calculations, service recovery cost allocation by channel, and channel-specific SLA compliance reporting. Currently only links to ota_p',
    `property_id` BIGINT COMMENT 'Reference to the alternative property where the guest was relocated. The property that accommodated the walked guest.',
    `ota_partner_id` BIGINT COMMENT 'Reference to the OTA partner if the original reservation was booked through an online travel agency. Critical for managing OTA penalties and chargebacks.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who processed the walk transaction. Used for training, quality assurance, and accountability tracking.',
    `primary_walk_property_id` BIGINT COMMENT 'Reference to the property where the original reservation was made but could not be honored due to overbooking or other operational constraints.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who was walked. Links to the guest profile who experienced the relocation.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the original reservation that was walked. Links to the reservation that could not be honored at the original property.',
    `brand_standard_compliance_flag` BOOLEAN COMMENT 'Indicates whether the walk was handled in compliance with brand standards for guest relocation and service recovery. Used for quality assurance and brand audit purposes.',
    `cash_compensation_amount` DECIMAL(18,2) COMMENT 'Monetary cash compensation provided to the guest for the walk inconvenience. Tracked separately from other compensation types for financial reporting.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary compensation amounts. Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'The primary type of compensation provided to the guest for the walk inconvenience. May include complimentary nights, transportation, loyalty points, cash, vouchers, room upgrades, or a combination. [ENUM-REF-CANDIDATE: complimentary_night|transportation|loyalty_points|cash|voucher|room_upgrade|multiple — 7 candidates stripped; promote to reference product]',
    `complaint_filed_flag` BOOLEAN COMMENT 'Indicates whether the guest filed a formal complaint regarding the walk event. Used for tracking service recovery effectiveness and brand reputation management.',
    `complaint_resolution_status` STRING COMMENT 'Current status of any complaint filed by the guest. Tracks the complaint lifecycle from initial filing through final resolution.. Valid values are `open|in_progress|resolved|escalated|closed`',
    `complimentary_nights_count` STRING COMMENT 'Number of complimentary room nights provided as compensation for the walk. Typically one night but may vary based on brand standards and guest status.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the walk record was first created in the system. Used for audit trail and data lineage tracking.',
    `guest_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether explicit consent was obtained from the guest before the walk. Critical for compliance with brand standards and guest rights policies.',
    `guest_consent_timestamp` TIMESTAMP COMMENT 'Date and time when guest consent was obtained. Used for audit trail and compliance documentation.',
    `guest_satisfaction_score` STRING COMMENT 'Post-walk guest satisfaction score collected through follow-up survey. Used to measure effectiveness of service recovery and track Guest Recovery Rate (GRR).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the walk record was last updated. Used for audit trail and change tracking.',
    `loyalty_points_awarded` STRING COMMENT 'Number of loyalty program points awarded to the guest as compensation for the walk. Used for guest retention and satisfaction recovery.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special circumstances, or contextual information about the walk event. Used for operational documentation and future reference.',
    `nps_score` STRING COMMENT 'Net Promoter Score collected from the guest after the walk event. Measures likelihood of guest to recommend the brand despite the walk experience.',
    `original_arrival_date` DATE COMMENT 'The scheduled arrival date from the original reservation that was walked. Used for tracking the intended stay period.',
    `original_departure_date` DATE COMMENT 'The scheduled departure date from the original reservation that was walked. Used for calculating the total nights impacted by the walk.',
    `original_room_type_code` STRING COMMENT 'The room type code that was originally reserved at the source property. Used to ensure comparable or upgraded accommodation at the destination property.',
    `ota_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the OTA partner was notified of the walk event as required by contractual obligations.',
    `ota_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the OTA partner was notified of the walk event. Used for compliance verification and audit trail.',
    `ota_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount charged by the OTA partner for the walk event. Tracked for financial reporting and channel cost analysis.',
    `ota_penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether the walk event triggers a contractual penalty with the OTA partner. Used for financial accrual and channel relationship management.',
    `provided_room_type_code` STRING COMMENT 'The room type code that was provided at the destination property. Used to track whether the guest received a comparable, upgraded, or downgraded room.',
    `revenue_lost_amount` DECIMAL(18,2) COMMENT 'Estimated revenue lost from the original reservation that was walked. Used for revenue management analysis and overbooking strategy optimization.',
    `room_nights_lost` STRING COMMENT 'Number of room nights lost from the original reservation due to the walk. Used for occupancy impact analysis and revenue management reporting.',
    `service_recovery_action_taken` STRING COMMENT 'Detailed description of all service recovery actions taken beyond standard compensation. May include manager apology calls, welcome amenities, special requests honored, or other personalized gestures.',
    `total_compensation_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all compensation provided to the guest, including complimentary nights, transportation, cash, and estimated value of loyalty points and vouchers.',
    `transportation_cost_amount` DECIMAL(18,2) COMMENT 'The monetary cost of transportation provided to the guest. Used for cost tracking and operational expense analysis.',
    `transportation_provided_flag` BOOLEAN COMMENT 'Indicates whether transportation was arranged and provided to relocate the guest to the destination property.',
    `walk_date` DATE COMMENT 'The date on which the walk event occurred. Typically corresponds to the original scheduled arrival date when the guest was informed of the relocation.',
    `walk_reason_code` STRING COMMENT 'Standardized code indicating the reason for the walk event. Common reasons include overbooking, maintenance issues, operational constraints, VIP displacement, group block conflicts, or system errors.. Valid values are `overbooking|maintenance|operational|vip_displacement|group_block|system_error`',
    `walk_reason_description` STRING COMMENT 'Detailed narrative explanation of why the guest was walked. Provides context beyond the standardized reason code for service recovery and operational analysis.',
    `walk_timestamp` TIMESTAMP COMMENT 'Precise date and time when the walk event was recorded in the system. Captures the exact moment the guest was notified and the walk transaction was initiated.',
    CONSTRAINT pk_walk_record PRIMARY KEY(`walk_record_id`)
) COMMENT 'Transactional record documenting guest walk events where a confirmed guest is relocated to an alternative property due to overbooking. Captures walk date, original booking reference, destination property, room type provided, compensation (complimentary night, transportation, loyalty points), guest consent, and service recovery actions. Supports Guest Recovery Rate (GRR) tracking, brand standard compliance, and OTA penalty management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'Unique identifier for this wellness program enrollment record. Primary key.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to the guest reservation booking record',
    `wellness_program_id` BIGINT COMMENT 'Foreign key linking to the wellness program master record',
    `cancellation_date` DATE COMMENT 'Date when the guest cancelled their wellness program enrollment. Null for active enrollments.',
    `cancellation_reason` STRING COMMENT 'Reason code or free-text explanation for program cancellation. Used for program improvement and refund processing.',
    `completion_status` STRING COMMENT 'Current status of the guests participation in the wellness program. Tracks progression from enrollment through completion or cancellation.',
    `confirmed_date` DATE COMMENT 'Date when the enrollment was confirmed (moved from waitlist or initial enrollment confirmed). Used for operational planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the enrollment price.',
    `customization_notes` STRING COMMENT 'Free-text notes capturing guest-specific customizations to the standard wellness program (e.g., treatment substitutions, schedule adjustments, intensity modifications).',
    `dietary_preferences` STRING COMMENT 'Guests dietary preferences and restrictions specific to this wellness program enrollment (e.g., vegan, gluten-free, allergies). Used to coordinate F&B for program meals.',
    `enrollment_date` DATE COMMENT 'Date when the guest enrolled in this wellness program. Used for enrollment tracking and reporting.',
    `enrollment_price` DECIMAL(18,2) COMMENT 'Actual price paid for this wellness program enrollment. May differ from program_price due to discounts, packages, or seasonal pricing.',
    `medical_clearance_date` DATE COMMENT 'Date when medical clearance was obtained for programs requiring physician approval or health screening. Required for programs with medical_supervision_required_flag = true.',
    `medical_clearance_status` STRING COMMENT 'Status of medical clearance for this enrollment. Controls whether guest can proceed with program participation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this enrollment record.',
    `program_end_date` DATE COMMENT 'Actual end date of the wellness program for this guest. Used to calculate program duration and completion.',
    `program_start_date` DATE COMMENT 'Actual start date of the wellness program for this guest. May differ from reservation arrival date if program begins mid-stay.',
    `progress_notes` STRING COMMENT 'Wellness coordinator notes tracking guest progress through the program (e.g., treatment attendance, fitness session participation, goal achievement).',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to guest upon cancellation, based on cancellation policy. Null if no refund issued.',
    `satisfaction_score` STRING COMMENT 'Guest satisfaction rating for the wellness program experience (1-5 scale). Collected post-program for quality tracking.',
    `waitlist_flag` BOOLEAN COMMENT 'Indicates whether this enrollment was initially placed on a waitlist due to program capacity constraints.',
    `waitlist_position` STRING COMMENT 'Position in the waitlist queue if waitlist_flag is true. Null if not waitlisted.',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between a guest reservation and a wellness program. It captures the guests participation in structured multi-day wellness programs, including medical clearances, dietary customizations, program scheduling, and completion tracking. Each record links one reservation to one wellness program with enrollment-specific attributes that exist only in the context of this participation relationship.. Existence Justification: In resort and destination spa operations, guests frequently enroll in multiple wellness programs during a single stay (e.g., a 7-night stay might include a 3-day detox program followed by a 2-day fitness bootcamp), and each wellness program cohort has multiple concurrent participants each with their own reservation. The enrollment itself is an actively managed business entity with program-specific data including medical clearances, dietary customizations, progress tracking, waitlist management, and completion status that belongs to neither the reservation nor the program master record alone.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` (
    `group_spa_package_contract_id` BIGINT COMMENT 'Unique identifier for this group spa package contract record. Primary key.',
    `package_id` BIGINT COMMENT 'Foreign key linking to the spa package included in the group block contract',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key linking to the group room block that has contracted this spa package offering',
    `advance_booking_deadline` DATE COMMENT 'Deadline date by which group members must book their spa package appointments to receive the contracted group rate and guarantee availability.',
    `billing_arrangement` STRING COMMENT 'Defines how spa package charges are billed for this group. Values: master_account (all charges to group master account), individual_folio (each guest pays separately), split_billing (partial group subsidy), prepaid (included in group package price).',
    `contract_status` STRING COMMENT 'Current status of this spa package contract within the group block lifecycle. Tracks progression from tentative offer through fulfillment.',
    `contracted_date` DATE COMMENT 'Date when this spa package was added to the group block contract and terms were agreed upon.',
    `contracted_package_count` STRING COMMENT 'Number of spa package instances contracted or committed as part of the group block agreement. Represents the minimum guaranteed bookings.',
    `coordinator_contact` STRING COMMENT 'Name and contact information for the group coordinator or event planner responsible for managing spa package bookings for this group block.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this group spa package contract record was first created.',
    `customization_notes` STRING COMMENT 'Free-text field capturing any special customizations, modifications, or requirements for this spa package as contracted for this specific group block (e.g., extended duration, treatment substitutions, VIP amenities).',
    `group_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the spa package rack rate negotiated for this group block. Applied to all bookings of this package by group members.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this group spa package contract record was last modified.',
    CONSTRAINT pk_group_spa_package_contract PRIMARY KEY(`group_spa_package_contract_id`)
) COMMENT 'This association product represents the Contract between reservation_group_block and spa_package. It captures the negotiated spa package offerings included in group room blocks for events, corporate retreats, weddings, and conferences. Each record links one group block to one spa package with contracted pricing, advance booking requirements, billing arrangements, and coordinator details that exist only in the context of this group-specific spa offering.. Existence Justification: In travel hospitality operations, group blocks for weddings, corporate retreats, and conferences routinely contract multiple spa packages as part of their amenity offerings (bride/groom packages, team wellness sessions, VIP treatments). Simultaneously, popular spa packages are offered across multiple concurrent group blocks with different negotiated terms. The relationship represents an operational contract that sales coordinators actively create and manage, with group-specific pricing, booking deadlines, billing arrangements, and customization requirements that belong to neither the block definition nor the package catalog alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_travel_agent_id` FOREIGN KEY (`travel_agent_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`travel_agent`(`travel_agent_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_parent_agency_reservation_travel_agent_id` FOREIGN KEY (`parent_agency_reservation_travel_agent_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`travel_agent`(`travel_agent_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_connected_room_assignment_id` FOREIGN KEY (`connected_room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_reservation_booking_id` FOREIGN KEY (`room_reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ADD CONSTRAINT `fk_reservation_program_enrollment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ADD CONSTRAINT `fk_reservation_group_spa_package_contract_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`reservation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`reservation` SET TAGS ('dbx_domain' = 'reservation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_concept' = 'booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_group' = 'booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_canonical' = 'reservation.reservation_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_room_type_id` SET TAGS ('dbx_normalized_natural_key_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Requested');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `room_type_id` SET TAGS ('dbx_denormalized' = 'resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `accessibility_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `crs_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Central Reservation System (CRS) Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `crs_confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `early_checkin_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Check-In Requested Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate_account|travel_agent_voucher|prepaid|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `late_checkout_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Check-Out Requested Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `modification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_adults` SET TAGS ('dbx_business_glossary_term' = 'Number of Adults');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_rooms` SET TAGS ('dbx_business_glossary_term' = 'Number of Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `pms_reservation_code` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `pms_reservation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ALTER COLUMN `vip_status_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Status Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `booking_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Status History Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `agent_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|modification|cancellation|no_show|check_in|check_out');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `guest_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Sent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `guest_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `modification_field_name` SET TAGS ('dbx_business_glossary_term' = 'Modification Field Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `no_show_reason_code` SET TAGS ('dbx_business_glossary_term' = 'No-Show Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `no_show_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `penalty_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `rate_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Difference Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `system_source` SET TAGS ('dbx_value_regex' = 'OPERA_PMS|SYNXIS_CRS|MOBILE_APP|KIOSK|INTERFACE|BATCH');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,50}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Partner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'open|resolved_guest_favor|resolved_property_favor|withdrawn');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'guest_cancellation|property_cancellation|ota_cancellation|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `guarantee_charge_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Charge Processed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate_guarantee|travel_agent_guarantee|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `original_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `ota_chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Chargeback Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `ota_chargeback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Chargeback Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `revenue_lost_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Lost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `room_nights_lost` SET TAGS ('dbx_business_glossary_term' = 'Room Nights Lost');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `waiver_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authorized By');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ALTER COLUMN `window_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Window Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_subdomain' = 'group_blocks');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_concept' = 'group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_group' = 'group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_canonical' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_ssot_owner' = 'guest.guest_group_block.guest_group_block_id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Group Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `attrition_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Attrition Clause Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `attrition_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Threshold Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `attrition_threshold_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `available_room_count` SET TAGS ('dbx_business_glossary_term' = 'Available Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `billing_instruction` SET TAGS ('dbx_business_glossary_term' = 'Billing Instruction');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Group Block Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Group Block Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Group Block Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|cancelled|waitlist|inquiry|contracted');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Group Block Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `contracted_room_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Group Block Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Group Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `group_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Group Block Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `pickup_room_count` SET TAGS ('dbx_business_glossary_term' = 'Pickup Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Group Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ALTER COLUMN `wash_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Wash Schedule Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` SET TAGS ('dbx_subdomain' = 'group_blocks');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `group_block_pickup_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Pickup Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `block_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Block Utilization Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `block_utilization_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `group_attendee_type` SET TAGS ('dbx_business_glossary_term' = 'Group Attendee Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate|travel_agent|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `nights` SET TAGS ('dbx_business_glossary_term' = 'Number of Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_before_cutoff_flag` SET TAGS ('dbx_business_glossary_term' = 'Pickup Before Cutoff Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_number` SET TAGS ('dbx_business_glossary_term' = 'Pickup Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_status` SET TAGS ('dbx_business_glossary_term' = 'Pickup Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `remaining_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Remaining Block Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `room_type_name` SET TAGS ('dbx_business_glossary_term' = 'Room Type Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ALTER COLUMN `vip_indicator` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_subdomain' = 'rate_policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_reference' = 'revenue.revenue_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_concept' = 'rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_references' = 'revenue.revenue_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot' = 'alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_authority_defer_to' = 'revenue.revenue_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_ref' = 'revenue.revenue_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_group' = 'rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_canonical' = 'revenue.revenue_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_rate_plan_id` SET TAGS ('dbx_ssot_owner' = 'channel.channel_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_rate_plan_id` SET TAGS ('dbx_ssot_stem' = 'rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `booking_window_end_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `booking_window_start_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_corporate_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Corporate Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_direct_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Direct Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_gds_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Global Distribution System (GDS) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Group Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_ota_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Online Travel Agency (OTA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `commissionable_flag` SET TAGS ('dbx_business_glossary_term' = 'Commissionable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|prepayment|direct_bill|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `loyalty_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `maximum_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `member_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Only Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `minimum_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_description` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Inclusion Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_inclusion_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SYNXIS|OPERA|IDEAS|MANUAL');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Terms and Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` SET TAGS ('dbx_subdomain' = 'rate_policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `allows_modification` SET TAGS ('dbx_business_glossary_term' = 'Allows Modification Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `applies_to_corporate_bookings` SET TAGS ('dbx_business_glossary_term' = 'Applies to Corporate Bookings Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `applies_to_group_bookings` SET TAGS ('dbx_business_glossary_term' = 'Applies to Group Bookings Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Channel Restrictions');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_due_days_before_arrival` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Days Before Arrival');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deposit Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_required` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `free_cancellation_window_days` SET TAGS ('dbx_business_glossary_term' = 'Free Cancellation Window Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `free_cancellation_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Free Cancellation Window Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `guest_facing_summary` SET TAGS ('dbx_business_glossary_term' = 'Guest-Facing Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `is_non_refundable` SET TAGS ('dbx_business_glossary_term' = 'Non-Refundable Flag (NRR - Non-Refundable Rate)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `legal_terms_text` SET TAGS ('dbx_business_glossary_term' = 'Legal Terms Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `modification_fee` SET TAGS ('dbx_business_glossary_term' = 'Modification Fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_type` SET TAGS ('dbx_value_regex' = 'first_night|full_stay|flat_fee|percentage_of_stay|same_as_cancellation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_nights_count` SET TAGS ('dbx_business_glossary_term' = 'Penalty Nights Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'first_night|percentage_of_stay|flat_fee|full_stay|no_penalty|nights_based');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_tier` SET TAGS ('dbx_business_glossary_term' = 'Policy Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_tier` SET TAGS ('dbx_value_regex' = 'flexible|moderate|strict|non_refundable|super_flexible|custom');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `seasonal_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Override Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_subdomain' = 'guest_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_concept' = 'special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_group' = 'special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_canonical' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `reservation_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Special Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `failure_category` SET TAGS ('dbx_business_glossary_term' = 'Failure Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_feedback_text` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction (GSAT) Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `impacts_loyalty_points` SET TAGS ('dbx_business_glossary_term' = 'Impacts Loyalty Points');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `is_pre_arrival` SET TAGS ('dbx_business_glossary_term' = 'Is Pre-Arrival Request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `is_vip_request` SET TAGS ('dbx_business_glossary_term' = 'Is VIP (Very Important Person) Request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_category` SET TAGS ('dbx_business_glossary_term' = 'Request Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_code` SET TAGS ('dbx_business_glossary_term' = 'Request Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_text` SET TAGS ('dbx_business_glossary_term' = 'Request Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `requires_charge` SET TAGS ('dbx_business_glossary_term' = 'Requires Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ALTER COLUMN `target_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fulfillment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` SET TAGS ('dbx_subdomain' = 'guest_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Ledger ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Payment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `applied_to_folio_date` SET TAGS ('dbx_business_glossary_term' = 'Applied to Folio Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Deposit Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'pending|received|applied|refunded|forfeited|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Deposit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'advance_deposit|guarantee_deposit|group_deposit|event_deposit|cancellation_penalty|damage_deposit');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `folio_number` SET TAGS ('dbx_business_glossary_term' = 'Folio Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `folio_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `forfeiture_amount` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `forfeiture_date` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `forfeiture_reason` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `forfeiture_reason` SET TAGS ('dbx_value_regex' = 'no_show|late_cancellation|policy_violation|early_departure|group_attrition');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deposit Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `refund_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `refund_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,50}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` SET TAGS ('dbx_subdomain' = 'guest_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `parent_agency_reservation_travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Travel Agency ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `parent_agency_reservation_travel_agent_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'retail|corporate_tmc|online_travel_agency|tour_operator|consortium|wholesaler');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `agency_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `arc_number` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `arc_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `booking_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Booking Volume Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `booking_volume_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `gds_identifier` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `iata_number` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `iata_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `last_booking_date` SET TAGS ('dbx_business_glossary_term' = 'Last Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|direct_bill|virtual_card|net_remit');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `total_bookings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Bookings Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Generated Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_status` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|blacklisted');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` SET TAGS ('dbx_subdomain' = 'guest_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `waitlist_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Converted By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `tertiary_waitlist_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `tertiary_waitlist_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `tertiary_waitlist_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `auto_convert_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Convert Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'guest_request|no_availability|duplicate|expired|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Converted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `guarantee_type_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `guarantee_type_code` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `guest_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Guest Priority Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `guest_priority_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|member|non_member');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|phone|sms|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `quoted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'sold_out|room_type_unavailable|rate_unavailable|group_block_full|maintenance|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `requested_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `requested_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `requested_nights` SET TAGS ('dbx_business_glossary_term' = 'Requested Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `requested_room_count` SET TAGS ('dbx_business_glossary_term' = 'Requested Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `requested_room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'OPERA|SYNXIS|SALESFORCE|MANUAL|API');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `waitlist_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `waitlist_number` SET TAGS ('dbx_value_regex' = '^WL[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_value_regex' = 'active|converted|expired|cancelled|fulfilled');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` SET TAGS ('dbx_subdomain' = 'room_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `connected_room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Room Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `tertiary_room_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `tertiary_room_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `tertiary_room_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'auto_assigned|manually_assigned|guest_requested|loyalty_preference|group_block|pre_arrival_selection');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|confirmed|checked_in|checked_out|cancelled|reassigned');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `bed_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bed Configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `early_checkin_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Check-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `guest_preference_match_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference Match Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `is_accessible_room` SET TAGS ('dbx_business_glossary_term' = 'Is Accessible Room Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `is_connecting_room` SET TAGS ('dbx_business_glossary_term' = 'Is Connecting Room Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `is_guest_requested` SET TAGS ('dbx_business_glossary_term' = 'Is Guest Requested Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `is_upgrade` SET TAGS ('dbx_business_glossary_term' = 'Is Upgrade Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `key_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `key_type` SET TAGS ('dbx_business_glossary_term' = 'Key Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `key_type` SET TAGS ('dbx_value_regex' = 'physical|mobile|rfid|magnetic_stripe');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `late_checkout_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Check-Out Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Lock Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `lock_status` SET TAGS ('dbx_value_regex' = 'unlocked|locked|pending_release');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Locked Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `original_room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Original Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `previous_room_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_reason_code` SET TAGS ('dbx_value_regex' = 'maintenance_issue|guest_complaint|overbooking|upgrade|operational|guest_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_condition_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Room Condition at Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_condition_at_assignment` SET TAGS ('dbx_value_regex' = 'clean|inspected|ready|maintenance_required|out_of_order');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_business_glossary_term' = 'Smoking Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `special_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Request Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_category` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_category` SET TAGS ('dbx_value_regex' = 'complimentary|paid|loyalty|operational');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ALTER COLUMN `view_type` SET TAGS ('dbx_business_glossary_term' = 'View Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` SET TAGS ('dbx_subdomain' = 'room_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `booking_package_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `booking_package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Package Cancellation Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Package Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Package Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `component_list` SET TAGS ('dbx_business_glossary_term' = 'Package Component List');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Package End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `fb_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `fulfillment_instructions` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `is_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Inclusive Package');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Package');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Package');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `other_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'meal_plan|amenity|experience|transportation|promotional|corporate');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_category` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Package Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_cost_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_description` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Package Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_rate_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `package_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `posting_rhythm` SET TAGS ('dbx_business_glossary_term' = 'Posting Rhythm');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `posting_rhythm` SET TAGS ('dbx_value_regex' = 'once|daily|per_night|per_person|on_departure');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Package Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'not_redeemed|partially_redeemed|fully_redeemed|expired|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_value_regex' = 'rooms_only|split_allocation|component_based|departmental');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `rooms_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Rooms Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Package Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Package Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` SET TAGS ('dbx_subdomain' = 'room_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_record_id` SET TAGS ('dbx_business_glossary_term' = 'Walk Record Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Partner Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `primary_walk_property_id` SET TAGS ('dbx_business_glossary_term' = 'Original Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `brand_standard_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Compensation Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `complaint_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Filed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `complaint_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Resolution Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `complaint_resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|escalated|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `complimentary_nights_count` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Nights Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `guest_consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Consent Obtained Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `guest_consent_obtained_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `guest_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Consent Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `guest_consent_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `guest_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `loyalty_points_awarded` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Awarded');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Walk Record Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `original_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `original_room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Original Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `ota_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Notification Sent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `ota_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Notification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `ota_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `ota_penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Penalty Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `provided_room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Provided Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `revenue_lost_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Lost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `room_nights_lost` SET TAGS ('dbx_business_glossary_term' = 'Room Nights Lost');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `service_recovery_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `total_compensation_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Value Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `total_compensation_value_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `total_compensation_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `transportation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `transportation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Provided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_date` SET TAGS ('dbx_business_glossary_term' = 'Walk Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Walk Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_reason_code` SET TAGS ('dbx_value_regex' = 'overbooking|maintenance|operational|vip_displacement|group_block|system_error');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Walk Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ALTER COLUMN `walk_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Walk Event Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_subdomain' = 'room_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_association_edges' = 'reservation.reservation_booking,spa.wellness_program');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Reservation Booking Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Wellness Program Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `customization_notes` SET TAGS ('dbx_business_glossary_term' = 'Customization Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `dietary_preferences` SET TAGS ('dbx_business_glossary_term' = 'Dietary Preferences');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `dietary_preferences` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `enrollment_price` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `progress_notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `waitlist_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_subdomain' = 'group_blocks');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_association_edges' = 'reservation.reservation_group_block,spa.spa_package');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_required_structure' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `group_spa_package_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Group Spa Package Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `group_spa_package_contract_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Group Spa Package Contract - Spa Package Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Spa Package Contract - Reservation Group Block Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `advance_booking_deadline` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `billing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `contracted_date` SET TAGS ('dbx_business_glossary_term' = 'Contracted Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `contracted_package_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Package Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `contracted_package_count` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `coordinator_contact` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `coordinator_contact` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `customization_notes` SET TAGS ('dbx_business_glossary_term' = 'Customization Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `group_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Group Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `group_discount_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
