-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`inventory` COMMENT 'Real-time room inventory management including room types, physical room attributes, availability, room status, housekeeping status, out-of-order designations, and inventory controls. Manages room blocks, allotments, overbooking limits, and LRA (Last Room Availability). Integrates with PMS (Oracle OPERA) and RMS (IDeaS G3) for dynamic inventory allocation across distribution channels. Tracks OCC and supports LOS-based controls.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` (
    `room_type_id` BIGINT COMMENT 'Primary key for room_type',
    `ada_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_assessment. Business justification: ADA assessments evaluate room type categories for accessibility standards (suite vs. standard room requirements). Links room type to assessment for compliance certification and accessible room invento',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing campaigns routinely target specific room types for promotions (suite sales, standard room flash deals). Campaign planning, offer eligibility rules, and performance attribution by room catego',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Offers frequently restrict eligibility to specific room types (suites only, exclude standard rooms). While campaign_offer has eligible_room_types text field, proper FK enables booking validation, inve',
    `property_id` BIGINT COMMENT 'Reference to the property where this room type is defined. Room types are property-specific configurations.',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility features available in this room type. Examples: roll-in shower, grab bars, visual alarm, hearing kit, lowered fixtures. Used for guest matching and compliance tracking.',
    `active_status` STRING COMMENT 'Current operational status of the room type. Inactive types are not available for new reservations. Seasonal types are active only during specific periods. Renovation types are temporarily unavailable.. Valid values are `active|inactive|seasonal|renovation`',
    `bathroom_configuration` STRING COMMENT 'Description of bathroom setup. Examples: single full bath, 1.5 bath, dual vanity, separate tub and shower. Used for guest expectations and competitive positioning.',
    `bed_count` STRING COMMENT 'Number of beds in the room type. Used for occupancy calculations and guest preference matching.',
    `bed_type` STRING COMMENT 'Primary bed configuration for the room type. Critical for guest preference matching and inventory allocation. [ENUM-REF-CANDIDATE: king|queen|double|twin|california_king|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `room_type_code` STRING COMMENT 'Short alphanumeric code used to identify the room type in PMS and RMS systems. Examples: KING, QQDBL, JSUITE, PRES. This is the operational identifier used across reservations, inventory, and revenue management.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this room type record was first created in the system. Used for audit trail and data lineage.',
    `room_type_description` STRING COMMENT 'Detailed marketing description of the room type including amenities, features, and guest experience highlights. Used for guest-facing channels and OTA distribution.',
    `effective_end_date` DATE COMMENT 'Date when this room type configuration expires or is replaced. Null for currently active configurations. Used for historical tracking and renovation planning.',
    `effective_start_date` DATE COMMENT 'Date when this room type configuration becomes effective. Used for managing room type changes, renovations, and new inventory rollouts.',
    `floor_level_range` STRING COMMENT 'Typical floor range where this room type is located. Examples: 1-5, 6-10, 15-20. Used for guest preference and accessibility planning.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether this room type meets ADA accessibility requirements including mobility, hearing, and visual accommodations. Required for compliance reporting and guest accessibility requests.',
    `is_connecting_eligible` BOOLEAN COMMENT 'Indicates whether this room type can be configured as a connecting room. Used for family and group booking allocation.',
    `is_suite` BOOLEAN COMMENT 'Indicates whether this room type is classified as a suite with separate living and sleeping areas. Used for inventory segmentation and revenue reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this room type record was last updated. Used for change tracking and data synchronization across PMS, RMS, and CRS systems.',
    `lra_eligible` BOOLEAN COMMENT 'Indicates whether this room type participates in Last Room Availability agreements with OTA partners. Critical for channel distribution and rate parity management.',
    `max_occupancy` STRING COMMENT 'Maximum number of guests allowed in this room type per fire code and property standards. Used for reservation validation and yield optimization.',
    `room_type_name` STRING COMMENT 'Full descriptive name of the room type as displayed to guests and staff. Examples: Deluxe King, Queen Queen Double, Junior Suite, Presidential Suite.',
    `overbooking_allowed` BOOLEAN COMMENT 'Indicates whether this room type can be overbooked as part of revenue management strategy. Used by RMS for yield optimization.',
    `pseudo_room_flag` BOOLEAN COMMENT 'Indicates whether this is a pseudo room type used for inventory management purposes (e.g., house use, out of order, complimentary) rather than a sellable room type. Used for inventory controls and reporting exclusions.',
    `rate_category` STRING COMMENT 'Rate category classification used for revenue management and pricing strategy. Examples: BAR, Corporate, Government, Group, Promotional. Links to rate plan structures.',
    `room_class` STRING COMMENT 'High-level classification of the room type by service tier. Used for segmentation in revenue management and guest experience programs.. Valid values are `standard|deluxe|premium|suite|executive|luxury`',
    `room_features` STRING COMMENT 'Comma-separated list of key room features and amenities. Examples: balcony, kitchenette, fireplace, whirlpool, separate shower, walk-in closet. Used for guest communication and OTA distribution.',
    `segment_code` STRING COMMENT 'Property segment classification for this room type. Aligns with brand standards and service level expectations.. Valid values are `luxury|premium|select_service|extended_stay|resort`',
    `sellable_flag` BOOLEAN COMMENT 'Indicates whether this room type is available for sale to guests. Non-sellable types include staff rooms, maintenance rooms, and owner units.',
    `smoking_policy` STRING COMMENT 'Smoking policy for this room type. Most properties are non-smoking; some maintain designated smoking inventory.. Valid values are `non_smoking|smoking|both`',
    `sort_order` STRING COMMENT 'Display sequence for this room type in PMS screens, reports, and guest-facing channels. Lower numbers appear first.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the room type in square feet. Used for guest communication, competitive positioning, and property planning.',
    `standard_occupancy` STRING COMMENT 'Standard number of guests for this room type used for base rate calculations. Additional guests may incur extra person charges.',
    `view_category` STRING COMMENT 'Classification of the view from the room. Impacts pricing strategy and guest satisfaction. Used in revenue management for rate differentiation. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|no_view|partial — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_room_type PRIMARY KEY(`room_type_id`)
) COMMENT 'Master catalog of room types defined per property, including physical configuration (bed type, bed count, view category, square footage), maximum occupancy, accessibility features, ADA compliance status, connecting room eligibility, and suite classification. Serves as the foundational classification entity for all inventory management — availability, controls, blocks, allotments, channel distribution, and demand forecasting all reference room type as their primary dimension. Defined and maintained in Oracle OPERA PMS across luxury, premium, and select-service segments.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the physical room. Primary key. Authoritative SSOT for physical room identity in Oracle OPERA PMS.',
    `ada_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_assessment. Business justification: ADA assessments evaluate individual rooms for accessibility compliance (barrier identification, remediation tracking). Links room to its most recent assessment for compliance status reporting and reme',
    `connecting_room_id` BIGINT COMMENT 'Identifier of the adjacent room that connects to this room via connecting door. Null if no connecting room.',
    `fire_safety_record_id` BIGINT COMMENT 'Foreign key linking to compliance.fire_safety_record. Business justification: Fire safety inspections evaluate individual rooms for suppression systems, alarms, extinguishers, evacuation routes. Links room to fire safety record for compliance certification, insurance requiremen',
    `property_id` BIGINT COMMENT 'Identifier of the property (hotel, resort, or vacation property) where this room is located.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type classification (e.g., Standard King, Deluxe Suite, Executive Double) assigned to this room. Determines rate category and inventory grouping.',
    `ada_accessible` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility standards including wheelchair access, grab bars, visual alarms, and accessible bathroom fixtures.',
    `balcony_available` BOOLEAN COMMENT 'Indicates whether the room has a private balcony or terrace. Premium feature used for rate differentiation.',
    `bed_count` STRING COMMENT 'Total number of beds in the room. Used for occupancy capacity and guest preferences.',
    `bed_type` STRING COMMENT 'Primary bed configuration in the room. Critical for guest preferences and room assignment. [ENUM-REF-CANDIDATE: king|queen|double|twin|california_king|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `building_code` STRING COMMENT 'Code identifying the building or tower within a multi-building property. Null for single-building properties.',
    `connecting_room_available` BOOLEAN COMMENT 'Indicates whether this room has a connecting door to an adjacent room. Used for family bookings and group assignments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this room record was first created in the system. Audit trail field.',
    `features` STRING COMMENT 'Comma-separated list of additional room features and amenities (e.g., minibar, safe, coffee maker, smart TV, work desk). Used for guest preference matching and marketing.',
    `ffe_condition_score` DECIMAL(18,2) COMMENT 'Condition assessment score for room furniture, fixtures, and equipment on a scale of 0.00 to 5.00. Used for CapEx planning and PIP prioritization.',
    `floor_number` STRING COMMENT 'The floor level where the room is located within the building. Used for housekeeping routing and guest preferences.',
    `front_office_status` STRING COMMENT 'Current front office occupancy state. Indicates whether the room is vacant, occupied by a guest, reserved for arrival, or blocked.. Valid values are `vacant|occupied|reserved|blocked`',
    `housekeeping_status` STRING COMMENT 'Current housekeeping state of the room. Updated by housekeeping staff and used for room assignment and availability.. Valid values are `clean|dirty|inspected|pickup|do_not_disturb`',
    `kitchenette_available` BOOLEAN COMMENT 'Indicates whether the room includes a kitchenette with cooking facilities. Common in extended-stay properties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this room record was last updated. Used for change tracking and data synchronization.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent renovation or major refurbishment. Used for PIP (Property Improvement Plan) tracking and FF&E (Furniture Fixtures and Equipment) lifecycle management.',
    `lra_eligible` BOOLEAN COMMENT 'Indicates whether this room is eligible for Last Room Availability distribution to OTA partners. Used for channel distribution controls.',
    `max_occupancy` STRING COMMENT 'Maximum number of guests allowed in the room per fire code and property policy. Used for reservation validation.',
    `operational_status` STRING COMMENT 'Current operational state of the room. Determines whether the room is available for sale and occupancy. Lifecycle status field.. Valid values are `in_service|out_of_order|out_of_inventory|under_renovation`',
    `out_of_order_end_date` DATE COMMENT 'Expected date when the room will return to service. Used for inventory forecasting and revenue management.',
    `out_of_order_reason` STRING COMMENT 'Reason code or description for why the room is out of order. Null when room is in service. Used for maintenance tracking and OCC impact analysis.',
    `out_of_order_start_date` DATE COMMENT 'Date when the room was taken out of order. Used for revenue impact analysis and maintenance duration tracking.',
    `overbooking_eligible` BOOLEAN COMMENT 'Indicates whether this room can be included in overbooking calculations. Used by RMS for yield optimization.',
    `room_number` STRING COMMENT 'The externally-known room number displayed on the door and used for guest communication. Business identifier for the room.',
    `smoking_allowed` BOOLEAN COMMENT 'Indicates whether smoking is permitted in the room. Used for guest preference matching and inventory segmentation.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total interior square footage of the room. Used for marketing, rate positioning, and guest selection criteria.',
    `view_type` STRING COMMENT 'Type of view from the room windows. Impacts rate positioning and guest satisfaction. Used for upsell opportunities. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|no_view — 7 candidates stripped; promote to reference product]',
    `wing_code` STRING COMMENT 'Code identifying the wing or section within a building. Used for operational routing and guest location preferences.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Physical room master record representing each individual guestroom or suite at a property. Captures room number, floor, wing, building, room type assignment, physical attributes (square footage, bed configuration, connecting rooms), ADA accessibility status, smoking designation, view type, and current operational status. The authoritative SSOT for physical room identity in Oracle OPERA PMS.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` (
    `room_status_id` BIGINT COMMENT 'Primary key for room_status',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping staff member currently assigned to clean or service this room.',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Group room block management requires tracking which rooms are assigned to which blocks for rooming list fulfillment, pickup tracking, and block-specific housekeeping instructions. Front desk and house',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping supervisor or inspector who performed the quality inspection of the room.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest currently occupying the room. Null if room is vacant.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the room is located. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the active reservation currently occupying the room. Null if room is vacant.',
    `room_id` BIGINT COMMENT 'Identifier of the physical room. Links to the room inventory master data.',
    `blocked_reason` STRING COMMENT 'Explanation of why the room is administratively blocked from sale (e.g., VIP hold, renovation, inventory control, group block).',
    `cleaning_type` STRING COMMENT 'Type of cleaning service required or last performed. Checkout: full cleaning after guest departure; Stayover: daily service for occupied room; Deep Clean: comprehensive periodic cleaning; Turndown: evening service; Refresh: light touch-up.. Valid values are `checkout|stayover|deep_clean|turndown|refresh`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this room status record was first created in the system.',
    `discrepancy_flag` BOOLEAN COMMENT 'Boolean flag indicating a mismatch between front desk status and housekeeping status (e.g., front desk shows vacant but housekeeping shows occupied). Requires investigation.',
    `discrepancy_notes` STRING COMMENT 'Free-text notes describing the nature of any status discrepancy and actions taken to resolve it.',
    `do_not_disturb_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest has activated the do not disturb indicator, preventing housekeeping and other staff from entering.',
    `expected_checkin_date` DATE COMMENT 'The scheduled check-in date for the next arriving guest. Used for due-in planning and housekeeping prioritization.',
    `expected_checkout_date` DATE COMMENT 'The scheduled checkout date for the current guest occupying the room. Used for due-out planning.',
    `front_desk_status` STRING COMMENT 'Current operational status from the front desk perspective. Vacant: unoccupied and available; Occupied: guest currently in residence; Reserved: booked for future arrival; Due Out: guest scheduled to check out today; Due In: guest scheduled to check in today; Out of Order: room unavailable for sale.. Valid values are `vacant|occupied|reserved|due_out|due_in|out_of_order`',
    `housekeeping_status` STRING COMMENT 'Current housekeeping state of the room indicating cleanliness and readiness. Dirty: needs full cleaning; Clean: cleaned but not inspected; Inspected: cleaned and quality-checked; Pickup: minor refresh needed; Out of Service: maintenance required; Do Not Disturb: guest requested no service.. Valid values are `dirty|clean|inspected|pickup|out_of_service|do_not_disturb`',
    `is_blocked` BOOLEAN COMMENT 'Boolean flag indicating whether the room is administratively blocked from sale (e.g., for renovation, VIP hold, or inventory control).',
    `is_clean` BOOLEAN COMMENT 'Boolean flag indicating whether the room has been cleaned and is ready for occupancy. True if housekeeping status is clean or inspected.',
    `is_inspected` BOOLEAN COMMENT 'Boolean flag indicating whether the room has passed housekeeping quality inspection after cleaning.',
    `is_out_of_order` BOOLEAN COMMENT 'Boolean flag indicating whether the room is out of order and unavailable for sale due to maintenance or other operational issues.',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last cleaned by housekeeping staff.',
    `last_inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the room last passed housekeeping quality inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this room status record was last modified in the system.',
    `last_occupied_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last occupied by a guest (most recent check-in or last known occupancy).',
    `last_vacated_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last vacated by a guest (most recent check-out).',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the room. Available: no maintenance issues; Minor Repair: small issues not blocking occupancy; Major Repair: significant issues requiring attention; Out of Order: room cannot be occupied; Scheduled Maintenance: planned preventive maintenance.. Valid values are `available|minor_repair|major_repair|out_of_order|scheduled_maintenance`',
    `occupancy_status` STRING COMMENT 'Simple binary occupancy indicator. Vacant: no guest assigned; Occupied: guest currently checked in; Reserved: future reservation exists.. Valid values are `vacant|occupied|reserved`',
    `out_of_order_end_date` DATE COMMENT 'The expected or actual date when the room will be or was returned to service after being out of order.',
    `out_of_order_reason` STRING COMMENT 'Detailed explanation of why the room is out of order (e.g., plumbing issue, HVAC failure, renovation, pest control, water damage).',
    `out_of_order_start_date` DATE COMMENT 'The date when the room was first designated as out of order.',
    `priority_level` STRING COMMENT 'Housekeeping priority level for servicing this room. Urgent: immediate attention required (e.g., due-in within 1 hour); High: priority cleaning (e.g., VIP guest, early check-in); Normal: standard cleaning schedule; Low: can be deferred.. Valid values are `low|normal|high|urgent`',
    `special_instructions` STRING COMMENT 'Free-text special instructions for housekeeping staff regarding this room (e.g., guest allergies, VIP preferences, extra amenities required).',
    `status_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the room status was last updated in the system. Tracks the most recent status transition.',
    `turndown_service_status` STRING COMMENT 'Status of evening turndown service for the room. Not Requested: no turndown service scheduled; Requested: guest or property standard requires turndown; Completed: turndown service has been performed; Declined: guest declined turndown service.. Valid values are `not_requested|requested|completed|declined`',
    CONSTRAINT pk_room_status PRIMARY KEY(`room_status_id`)
) COMMENT 'Real-time operational status record for each physical room capturing the current housekeeping state (dirty, clean, inspected, pick-up), front-desk status (vacant, occupied, due-out, due-in), and maintenance flags. Tracks status transitions with timestamps, assigned housekeeper, last inspection time, and turndown service status. Integrates with Oracle OPERA PMS housekeeping module for live room status boards.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` (
    `availability_snapshot_id` BIGINT COMMENT 'Unique identifier for the availability snapshot record. Primary key for this entity.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Availability snapshots capture actual rooms sold/available; demand forecasts predict future demand. Linking actuals to forecasts enables forecast accuracy measurement (MAPE calculation), model perform',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property for which this availability snapshot is recorded.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type (e.g., Standard King, Deluxe Suite) for which availability is tracked.',
    `closed_to_arrival_flag` BOOLEAN COMMENT 'Indicates whether new reservations are allowed to check in on this date. When true, no new arrivals are accepted, but existing multi-night stays can continue.',
    `closed_to_departure_flag` BOOLEAN COMMENT 'Indicates whether guests are allowed to check out on this date. When true, reservations must extend beyond this date to capture higher-value multi-night stays.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability snapshot record was first created in the data warehouse.',
    `discrepancy_notes` STRING COMMENT 'Free-text notes documenting any discrepancies found during reconciliation, including root cause and resolution actions.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether Last Room Availability is enabled for this room type on this date. When true, the property commits to selling rooms at contracted rates even if only one room remains.',
    `max_los_restriction` STRING COMMENT 'Maximum number of nights allowed for a reservation starting on this date. Used to prevent long stays during high-demand periods.',
    `min_los_restriction` STRING COMMENT 'Minimum number of nights required for a reservation starting on this date. Used for demand management and revenue optimization.',
    `net_available_rooms` STRING COMMENT 'Net number of rooms available to sell after accounting for all deductions (OOO, OOS, house use, blocks). Calculated as total physical rooms minus all unavailable and blocked rooms.',
    `occ_rate` DECIMAL(18,2) COMMENT 'Occupancy rate percentage for this room type on this date, calculated as (rooms sold + complimentary rooms) / net available rooms * 100. Key performance metric for revenue management.',
    `overbooking_limit` STRING COMMENT 'Maximum number of rooms that can be overbooked for this room type on this date, based on historical no-show and cancellation patterns. Used for yield optimization.',
    `reconciliation_status` STRING COMMENT 'Status of the nightly reconciliation process for this snapshot. Indicates whether the snapshot has been validated against PMS folios and room status.. Valid values are `reconciled|pending|discrepancy|manual_override`',
    `rooms_blocked_allotment` STRING COMMENT 'Number of rooms allocated to contracted allotments (OTA, wholesaler, corporate contracts) that are held but not yet sold.',
    `rooms_blocked_group` STRING COMMENT 'Number of rooms blocked for group reservations (MICE, corporate blocks) that are not yet sold but are held off general inventory.',
    `rooms_complimentary` STRING COMMENT 'Number of rooms occupied by complimentary guests (e.g., loyalty rewards, service recovery, VIP comps). Counted in occupancy but not in revenue.',
    `rooms_day_use` STRING COMMENT 'Number of rooms sold for day-use only (check-in and check-out on the same day), typically for meetings or short stays.',
    `rooms_house_use` STRING COMMENT 'Number of rooms occupied by hotel staff, contractors, or used for operational purposes (e.g., training, storage). Not available for sale.',
    `rooms_out_of_order` STRING COMMENT 'Number of rooms temporarily unavailable due to maintenance, repair, or refurbishment. These rooms are not available for sale.',
    `rooms_out_of_service` STRING COMMENT 'Number of rooms permanently or long-term unavailable due to major renovation, structural issues, or strategic decisions. Not available for sale.',
    `rooms_overbooked` STRING COMMENT 'Actual number of rooms overbooked (sold beyond physical capacity) for this room type on this date.',
    `rooms_sold` STRING COMMENT 'Number of rooms sold (occupied by paying guests) for this room type on this date. Used in OCC (Occupancy Rate) calculation.',
    `snapshot_date` DATE COMMENT 'The business date for which this availability snapshot is recorded. Represents the stay date, not the snapshot creation date.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The exact date and time when this availability snapshot was captured. Typically recorded during the nightly audit process.',
    `stop_sell_flag` BOOLEAN COMMENT 'Indicates whether this room type is completely closed for sale on this date across all channels. When true, no new reservations are accepted.',
    `total_physical_rooms` STRING COMMENT 'Total number of physical rooms of this room type at the property, representing the maximum inventory capacity.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability snapshot record was last updated in the data warehouse.',
    CONSTRAINT pk_availability_snapshot PRIMARY KEY(`availability_snapshot_id`)
) COMMENT 'Date-level inventory availability record per room type per property capturing total physical rooms, rooms sold, rooms blocked (group and allotment), out-of-order rooms, out-of-service rooms, complimentary rooms, house-use rooms, day-use rooms, and net available rooms. The authoritative SSOT for real-time occupancy (OCC) calculation and available-to-sell inventory. Feeds IDeaS G3 RMS for yield optimization and supports LRA (Last Room Availability) flag tracking. Reconciled nightly during night audit against PMS folios and room status. Serves as the foundation for RevPAR, occupancy trending, and inventory reconciliation reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` (
    `control_id` BIGINT COMMENT 'Primary key for control',
    `inventory_control_id` BIGINT COMMENT 'Unique identifier for the inventory control record. Primary key for the control entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Inventory control decisions (stop-sell, CTA/CTD, overbooking limits, LRA) are audited for brand standards compliance, revenue management policy adherence, and regulatory requirements. Links control to',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Inventory controls (stop-sell, CTA/CTD, LOS restrictions) are often campaign-driven (flash sale requires 2-night minimum, member-exclusive rates with specific restrictions). Required for promotional r',
    `channel_id` BIGINT COMMENT 'Identifier of the distribution channel (OTA, GDS, Direct) to which this control applies. Null indicates control applies to all channels.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who manually overrode RMS-generated controls. Null if control was not manually overridden.',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this inventory control applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Identifier of the rate plan to which this control applies. Null indicates control applies to all rate plans for the room type and date.',
    `room_block_id` BIGINT COMMENT 'Identifier of the group block that this control is associated with. Null if control is not tied to a specific group reservation.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type (e.g., Deluxe King, Standard Queen) to which this control applies.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Inventory controls (sell limits, hurdles, stop-sell flags) are tier-differentiated in luxury hospitality. Properties set different availability rules for base vs platinum members. Revenue strategy req',
    `advance_booking_limit_days` STRING COMMENT 'Maximum number of days in advance that bookings can be made for this stay date. Null indicates no advance booking restriction.',
    `channel_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of total sell limit allocated to this specific channel. Used for channel-level inventory gating. Sum across all channels for a date should not exceed 100%.',
    `competitive_set_adr` DECIMAL(18,2) COMMENT 'Average Daily Rate of the competitive set (STR comp set) for comparable room types on this stay date. Used for competitive benchmarking.',
    `control_status` STRING COMMENT 'Current lifecycle status of this inventory control record. Active controls are enforced by PMS and CRS; inactive controls are ignored.. Valid values are `active|inactive|override|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory control record was first created in the system.',
    `cta_flag` BOOLEAN COMMENT 'Indicates whether new arrivals are prohibited on this date. True means guests cannot check in on this date, but existing reservations spanning this date are allowed.',
    `ctd_flag` BOOLEAN COMMENT 'Indicates whether departures are prohibited on this date. True means guests cannot check out on this date; used to enforce minimum stay through high-demand periods.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this record (hurdle_rate, forecast_adr, competitive_set_adr). Typically matches property base currency.. Valid values are `^[A-Z]{3}$`',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when this control becomes effective. Controls are typically pushed to distribution channels in advance of the stay date.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when this control expires and is no longer enforced. Null indicates control remains effective until explicitly superseded.',
    `forecast_adr` DECIMAL(18,2) COMMENT 'RMS-forecasted Average Daily Rate for this room type on this stay date. Expressed in property currency.',
    `forecast_demand` STRING COMMENT 'RMS-forecasted demand (number of rooms) for this room type on this stay date. Used to inform control decisions and diagnostic analysis.',
    `forecast_occ_pct` DECIMAL(18,2) COMMENT 'RMS-forecasted occupancy percentage for this room type on this stay date. Expressed as a percentage (e.g., 85.50 means 85.5% occupancy).',
    `hurdle_rate` DECIMAL(18,2) COMMENT 'Minimum acceptable rate (ADR) below which the room type should not be sold for this date. Used by revenue management to protect yield. Expressed in property currency.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether this room type participates in Last Room Availability programs with OTAs. True means OTAs can sell even when inventory is constrained, ensuring rate parity.',
    `max_los` STRING COMMENT 'Maximum number of consecutive nights a guest can book when this date is the arrival date. Null indicates no maximum stay restriction.',
    `min_advance_booking_days` STRING COMMENT 'Minimum number of days in advance that bookings must be made for this stay date. Used to prevent last-minute bookings during high-demand periods.',
    `min_los` STRING COMMENT 'Minimum number of consecutive nights a guest must book when this date is the arrival date. Null or 1 indicates no minimum stay restriction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory control record was last modified. Updated whenever any control parameter changes.',
    `overbooking_limit_absolute` STRING COMMENT 'Absolute number of rooms above physical inventory that can be sold. Alternative to percentage-based overbooking. Null if percentage method is used.',
    `overbooking_limit_pct` DECIMAL(18,2) COMMENT 'Percentage above physical inventory that can be sold to account for expected cancellations and no-shows. For example, 10.00 means allow 110% of physical rooms to be sold.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by the user when manually overriding RMS-generated controls. Required when override_user_id is populated.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this control was last published to distribution channels (OTA, GDS, CRS). Null if control has not yet been distributed.',
    `reason_code` STRING COMMENT 'Business reason code explaining why this control was applied (e.g., HIGH_DEMAND, RENOVATION, GROUP_BLOCK, SEASONAL_CLOSURE). Used for diagnostic and reporting purposes.',
    `rgi_target` DECIMAL(18,2) COMMENT 'Target Revenue Generation Index for this stay date. RGI measures property performance relative to competitive set. Value of 100 means at-market performance.',
    `sell_limit` STRING COMMENT 'Maximum number of rooms of this type that can be sold for the stay date. Null indicates no limit. This is the primary inventory cap enforced by the PMS and CRS.',
    `source` STRING COMMENT 'Origin of this control record. RMS indicates generated by IDeaS G3 RMS; manual indicates user override; API indicates external system integration.. Valid values are `rms|manual|api|bulk_upload`',
    `stay_date` DATE COMMENT 'The specific date for which this inventory control is effective. Controls are date-specific and define sell constraints for a single night of stay.',
    `stop_sell_flag` BOOLEAN COMMENT 'Indicates whether all sales are stopped for this room type on this date. True means no new bookings are accepted regardless of availability. Overrides all other controls.',
    `walk_risk_tolerance` STRING COMMENT 'Revenue management tolerance for walking guests (relocating to another property due to overbooking). Higher tolerance allows more aggressive overbooking.. Valid values are `none|low|medium|high`',
    CONSTRAINT pk_control PRIMARY KEY(`control_id`)
) COMMENT 'Unified inventory control and restriction record defining all sell constraints per room type per stay date: sell limits, hurdle rates, minimum length-of-stay (MinLOS), maximum length-of-stay (MaxLOS), closed-to-arrival (CTA), closed-to-departure (CTD), stop-sell flags, overbooking limits (percentage and absolute), walk risk tolerance, and channel-level inventory gating rules. Generated by IDeaS G3 RMS and enforced in Oracle OPERA PMS and Sabre SynXis CRS. The single diagnostic target for answering why cant this room type be sold on this date? — consolidates all restriction types into one queryable entity. Supports HTNG inventory control message standards and dynamic allocation across OTA, GDS, and direct channels.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` (
    `room_block_id` BIGINT COMMENT 'Unique identifier for the room block record. Primary key.',
    `event_booking_id` BIGINT COMMENT 'Reference to the associated event or group booking that this room block supports.',
    `group_evaluation_id` BIGINT COMMENT 'Foreign key linking to revenue.group_evaluation. Business justification: Group evaluations assess displacement and revenue impact before accepting blocks. Linking blocks to originating evaluations enables post-booking performance review, wash factor validation, and revenue',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Room blocks represent inventory allocation for group bookings. Linking to guest_group_block enables pickup reconciliation, attrition calculation, billing reconciliation, and group contract compliance ',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Group blocks generate revenue recognition entries, attrition penalty postings, and deposit liability tracking that must post to specific GL accounts per USALI chart of accounts. Revenue managers need ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Group blocks for loyalty events, tier-specific promotions, and member appreciation weekends require tracking the owning member. Revenue management needs this for commission tracking, tier credit alloc',
    `employee_id` BIGINT COMMENT 'Reference to the hotel sales manager responsible for managing and servicing this room block.',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the room block is allocated.',
    `tertiary_room_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last modified the room block record.',
    `attrition_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount charged to the group if pickup falls below the attrition threshold. Expressed in property base currency.',
    `attrition_percentage` DECIMAL(18,2) COMMENT 'Contractual percentage threshold below which the group incurs attrition penalties for unmet room night commitments. Expressed as percentage (e.g., 20.00 for 20%).',
    `available_room_nights` STRING COMMENT 'Remaining number of room nights still available for pickup within the block.',
    `block_code` STRING COMMENT 'Unique alphanumeric code identifying the room block, used for reservations and reporting. Externally-known identifier for group bookings.. Valid values are `^[A-Z0-9]{3,20}$`',
    `block_name` STRING COMMENT 'Descriptive name of the room block, typically including the group or event name for easy identification.',
    `block_status` STRING COMMENT 'Current lifecycle status of the room block: tentative (pending confirmation), definite (confirmed and contracted), waitlist (pending availability), cancelled (terminated), released (inventory returned), completed (event concluded).. Valid values are `tentative|definite|waitlist|cancelled|released|completed`',
    `block_type` STRING COMMENT 'Classification of the room block by purpose: group (general group travel), event (MICE events), corporate (business contracts), tour (tour operators), wedding (social events), conference (meeting-focused).. Valid values are `group|event|corporate|tour|wedding|conference`',
    `booking_source` STRING COMMENT 'Channel or method through which the room block was originally booked: direct (property direct), GDS (Global Distribution System), OTA (Online Travel Agency), CRS (Central Reservation System), sales_team (hotel sales), third_party (intermediary).. Valid values are `direct|gds|ota|crs|sales_team|third_party`',
    `cancellation_policy` STRING COMMENT 'Text description of the cancellation terms and penalties applicable to the room block.',
    `cancellation_reason` STRING COMMENT 'Text description explaining the reason for room block cancellation, used for lost business analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the room block was cancelled, if applicable.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Commission rate percentage payable to intermediaries or group organizers for the block. Expressed as percentage (e.g., 10.00 for 10%).',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the room block status changed from tentative to definite (confirmed).',
    `contracted_room_nights` STRING COMMENT 'Total number of room nights contracted across all room types and dates in the block agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the room block record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the block (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'Date by which the group must pick up reserved rooms or release them back to general inventory. Also known as release date.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Monetary deposit amount required to secure the block, expressed in property base currency.',
    `deposit_due_date` DATE COMMENT 'Date by which the deposit payment must be received to maintain the block reservation.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a deposit is required to secure the room block.',
    `end_date` DATE COMMENT 'Last date of the room block period when rooms are reserved for the group or event.',
    `internal_notes` STRING COMMENT 'Confidential internal notes and comments for hotel staff regarding the room block management and service delivery.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether the block has Last Room Availability commitment, meaning the group rate applies even if only one room remains available.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the room block record was last modified.',
    `negotiated_rate_amount` DECIMAL(18,2) COMMENT 'Contracted room rate amount per night for the block, expressed in property base currency.',
    `overbooking_allowed_flag` BOOLEAN COMMENT 'Indicates whether the block allows overbooking beyond contracted room nights.',
    `owner_email` STRING COMMENT 'Primary email address of the block owner for communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Full name of the primary contact or decision-maker responsible for the room block on the client side.',
    `owner_phone` STRING COMMENT 'Primary contact phone number of the block owner.',
    `picked_up_room_nights` STRING COMMENT 'Cumulative number of room nights actually reserved and consumed from the block by guests.',
    `pickup_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of contracted room nights that have been picked up (reserved). Expressed as percentage (e.g., 85.50 for 85.5%).',
    `rate_code` STRING COMMENT 'Special rate code assigned to the room block for pricing and revenue tracking purposes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requirements, preferences, or requests associated with the room block (e.g., room location preferences, amenities, accessibility needs).',
    `start_date` DATE COMMENT 'First date of the room block period when rooms are reserved for the group or event.',
    CONSTRAINT pk_room_block PRIMARY KEY(`room_block_id`)
) COMMENT 'Group or event room block record reserving a contracted quantity of rooms by room type for a defined date range and pickup period. Captures block code, block name, group/event association, contracted room-nights by type and date, cumulative pickup, release/cutoff dates, attrition percentage and penalty terms, wash factor, and block status lifecycle (tentative, definite, cancelled, released). Links to group reservations and event contracts. Supports group inventory management, attrition tracking, and block release decisions in Oracle OPERA PMS and Delphi by Amadeus.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` (
    `block_pickup_id` BIGINT COMMENT 'Unique identifier for the daily block pickup tracking record.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate or event account that owns this group block contract.',
    `group_evaluation_id` BIGINT COMMENT 'Foreign key linking to revenue.group_evaluation. Business justification: Block pickup tracking measures actual performance against group evaluation forecasts. Linking enables wash factor accuracy measurement, displacement cost validation, and RMS model tuning—essential for',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the block pickup occurred.',
    `room_block_id` BIGINT COMMENT 'Reference to the parent group room block contract for which pickup is being tracked.',
    `room_type_id` BIGINT COMMENT 'Reference to the specific room type (e.g., King Deluxe, Double Queen) for which pickup is tracked.',
    `block_status` STRING COMMENT 'The current lifecycle status of the group block for this stay date and room type.. Valid values are `active|tentative|definite|released|cancelled|completed`',
    `booking_channel_code` STRING COMMENT 'The distribution channel through which the group block was booked (e.g., Direct, GDS, Sales Team).',
    `contracted_rooms` STRING COMMENT 'The total number of rooms committed in the original group block contract for this room type and stay date.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this block pickup record was first created in the system.',
    `cumulative_pickup` STRING COMMENT 'The total cumulative number of rooms picked up from the block from contract inception through the current pickup date.',
    `cutoff_date` DATE COMMENT 'The contractual date by which the group must pick up rooms or release unused inventory back to general availability.',
    `days_to_arrival` STRING COMMENT 'The number of days remaining from the pickup date until the stay date, used to assess booking window and release timing.',
    `displacement_cost` DECIMAL(18,2) COMMENT 'The estimated revenue opportunity cost of accepting this group block instead of selling rooms to higher-rated transient guests.',
    `forecasted_pickup` STRING COMMENT 'The revenue management systems forecasted number of rooms expected to be picked up from this block by arrival date.',
    `group_code` STRING COMMENT 'The unique alphanumeric code assigned to the group block in the PMS for identification and reservation linking.',
    `is_lra_eligible` BOOLEAN COMMENT 'Indicates whether this block is eligible for Last Room Availability, meaning the group can book rooms even when the hotel is sold out.',
    `market_segment_code` STRING COMMENT 'The market segment classification for this group block (e.g., Corporate, Association, SMERF, Government).',
    `net_pickup` STRING COMMENT 'The adjusted pickup count after applying wash factor, representing the expected actual occupied rooms from the block.',
    `pickup_date` DATE COMMENT 'The date on which this pickup measurement was captured or calculated, representing the snapshot date for reporting.',
    `pickup_notes` STRING COMMENT 'Free-text notes or comments regarding pickup performance, release decisions, or special circumstances for this block and stay date.',
    `pickup_pace_variance` STRING COMMENT 'The difference between current year pickup and prior year pickup at the same point in time, indicating booking pace trend.',
    `pickup_percentage` DECIMAL(18,2) COMMENT 'The percentage of contracted rooms that have been picked up, calculated as (rooms_picked_up / contracted_rooms) * 100.',
    `pickup_rate` DECIMAL(18,2) COMMENT 'The negotiated room rate (ADR) for rooms picked up from this block, used for revenue calculation and forecasting.',
    `pickup_revenue` DECIMAL(18,2) COMMENT 'The total room revenue generated from picked-up rooms, calculated as rooms_picked_up multiplied by pickup_rate.',
    `pickup_variance` STRING COMMENT 'The difference between actual rooms picked up and contracted rooms (rooms_picked_up minus contracted_rooms), indicating over or under performance.',
    `prior_year_pickup` STRING COMMENT 'The number of rooms picked up for the same group or comparable group at the same point in time last year, used for pace analysis.',
    `rate_plan_code` STRING COMMENT 'The rate plan code associated with the group block pricing structure.',
    `released_rooms` STRING COMMENT 'The number of rooms from the block that have been released back to general inventory due to non-pickup or cutoff date passage.',
    `remaining_block_rooms` STRING COMMENT 'The number of rooms still available in the block that have not yet been picked up (contracted minus picked up).',
    `rooms_picked_up` STRING COMMENT 'The number of rooms from the block that have been reserved or booked by group attendees as of the pickup date.',
    `stay_date` DATE COMMENT 'The specific calendar date for which block pickup is being measured. This is the guest arrival or occupancy date.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this block pickup record was last modified or refreshed.',
    `wash_factor` DECIMAL(18,2) COMMENT 'The percentage of block rooms expected to cancel or no-show, used to adjust net pickup forecasts and overbooking strategies.',
    CONSTRAINT pk_block_pickup PRIMARY KEY(`block_pickup_id`)
) COMMENT 'Daily pickup tracking record for group room blocks capturing rooms picked up per room type per stay date against the contracted block. Tracks cumulative pickup, remaining block availability, pickup pace versus prior year, and variance to contracted rooms. Supports group revenue management decisions and block release timing in Oracle OPERA PMS and IDeaS G3.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` (
    `out_of_order_id` BIGINT COMMENT 'Primary key for out_of_order',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Rooms go out of order due to safety incidents (guest injury, hazardous condition, equipment failure). Links OOO record to triggering incident for root cause tracking, remediation workflow, and lost re',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who reported or logged the out-of-order condition (typically housekeeping, front desk, or maintenance staff).',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the room is located.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room that is out-of-order or out-of-service.',
    `tertiary_out_closed_by_user_employee_id` BIGINT COMMENT 'Identifier of the staff member who closed the out-of-order record and returned the room to service (typically housekeeping or maintenance supervisor).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: When rooms go out-of-order for repairs (HVAC, plumbing, electrical, furniture replacement), hotels engage external vendors. Tracking which vendor performed the work is essential for cost allocation, w',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for repairs, maintenance, or renovation work. Captured upon work order completion for financial reconciliation and FF&E tracking.',
    `actual_return_date` DATE COMMENT 'Actual date when the room was returned to sellable inventory and made available for guest occupancy. Null if still out-of-order.',
    `actual_return_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the room was returned to sellable inventory, including time of day for accurate inventory restoration tracking.',
    `ada_compliance_flag` BOOLEAN COMMENT 'Indicates whether the out-of-order condition affects an ADA-compliant accessible room, requiring special handling for guest accommodation and compliance tracking.',
    `approved_by_name` STRING COMMENT 'Name of the manager or supervisor who approved the out-of-order designation for audit trail and accountability.',
    `closed_by_name` STRING COMMENT 'Name of the staff member who closed the out-of-order record and verified the room is ready for guest occupancy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this out-of-order record was first created in the system. Used for audit trail and operational reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_days` STRING COMMENT 'Total number of days the room was out-of-order or out-of-service, calculated from start date to actual return date. Used for RevPAR and occupancy impact analysis.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in local currency for repairs, maintenance, or renovation work required to return the room to service. Used for CapEx and OpEx planning.',
    `expected_return_date` DATE COMMENT 'Planned or estimated date when the room is expected to be returned to sellable inventory after repairs or maintenance are completed.',
    `guest_impacted_flag` BOOLEAN COMMENT 'Indicates whether a guest reservation was impacted by this out-of-order designation (True if guest had to be relocated or reservation cancelled).',
    `impact_on_occ` DECIMAL(18,2) COMMENT 'Percentage point impact on property occupancy rate due to this room being out-of-order. Used for STR reporting and competitive benchmarking.',
    `impact_on_revpar` DECIMAL(18,2) COMMENT 'Calculated impact on property RevPAR due to this room being out-of-order. Critical metric for revenue management and performance analysis.',
    `lost_revenue_estimate` DECIMAL(18,2) COMMENT 'Estimated revenue loss due to the room being unavailable for sale during the out-of-order period. Calculated using ADR and occupancy forecasts for RevPAR impact analysis.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the out-of-order condition and repair work.',
    `ooo_code` STRING COMMENT 'Standardized code representing the reason category for the room being out-of-order or out-of-service (e.g., MAINT, REPAIR, RENO, DAMAGE, INSPECT).',
    `ooo_reason` STRING COMMENT 'Detailed textual description of the specific reason the room is out-of-order or out-of-service (e.g., plumbing leak, HVAC failure, carpet replacement, pest control treatment).',
    `ooo_status` STRING COMMENT 'Designation type: OOO (Out-of-Order - not counted in available inventory) or OOS (Out-of-Service - counted in inventory but not sold). Follows USALI standards for inventory accounting.. Valid values are `OOO|OOS`',
    `priority_level` STRING COMMENT 'Urgency level assigned to the repair or maintenance work (Critical, High, Medium, Low). Critical priority indicates immediate revenue impact or safety concern.. Valid values are `Critical|High|Medium|Low`',
    `record_status` STRING COMMENT 'Current lifecycle status of the out-of-order record (Open - newly reported, In Progress - work underway, Completed - room returned to service, Cancelled - designation reversed).. Valid values are `Open|In Progress|Completed|Cancelled`',
    `relocation_required_flag` BOOLEAN COMMENT 'Indicates whether guest relocation to another room or property was required due to this out-of-order condition. Used for service recovery tracking.',
    `reported_by_name` STRING COMMENT 'Name of the staff member who reported the out-of-order condition for operational tracking and accountability.',
    `responsible_department` STRING COMMENT 'Department responsible for addressing the issue and returning the room to service (e.g., Housekeeping, Maintenance, Engineering, Facilities, Renovation). [ENUM-REF-CANDIDATE: Housekeeping|Maintenance|Engineering|Facilities|Renovation|Pest Control|Safety|Quality Assurance — 8 candidates stripped; promote to reference product]',
    `safety_concern_flag` BOOLEAN COMMENT 'Indicates whether the out-of-order condition involves a safety or health hazard requiring immediate attention per OSHA or local safety regulations.',
    `start_date` DATE COMMENT 'Date when the room was first designated as out-of-order or out-of-service and removed from sellable inventory.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the room was designated as out-of-order or out-of-service, including time of day for accurate inventory impact tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this out-of-order record was last modified. Used for audit trail and change tracking.',
    `work_order_number` STRING COMMENT 'Reference number of the maintenance or repair work order associated with this out-of-order designation. Links to work order management system.',
    CONSTRAINT pk_out_of_order PRIMARY KEY(`out_of_order_id`)
) COMMENT 'Out-of-Order (OOO) and Out-of-Service (OOS) designation record for individual rooms removed from sellable inventory. Captures OOO/OOS reason code, start date, expected return-to-service date, actual return date, responsible department, work order reference, and impact on RevPAR. Distinguishes between OOO (not counted in available inventory) and OOS (counted but not sold) per USALI standards. Managed in Oracle OPERA PMS.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` (
    `allotment_id` BIGINT COMMENT 'Unique identifier for the channel or partner allotment record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Channel allotments are frequently tied to co-marketing campaigns with OTAs or wholesalers (Expedia exclusive inventory for joint promotions). Essential for tracking channel partnership performance, re',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel, Online Travel Agency (OTA), Global Distribution System (GDS), tour operator, wholesale partner, or corporate account to which this allotment is allocated.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Travel agency and corporate allotments are contracted with specific accounts. Revenue management needs this link for contract compliance monitoring, allotment utilization reporting, commission calcula',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Channel allotments are managed by sales/distribution departments with dedicated cost center budgets for channel management labor, technology costs, and commission expenses. Essential for departmental ',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this allotment applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Reference to the rate plan associated with this allotment, defining the pricing structure and rate rules for bookings made through this channel or partner. Nullable if rate is managed separately.',
    `room_type_id` BIGINT COMMENT 'Reference to the room type (e.g., Standard King, Deluxe Suite) for which this allotment is defined.',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment was activated and made available for bookings. Nullable if not yet activated.',
    `adjustment_trigger_enabled` BOOLEAN COMMENT 'Indicates whether performance-based automatic adjustment of the allotment quantity is enabled (True) or disabled (False). When enabled, the allotment quantity may be increased or decreased based on sell-through performance.',
    `allocated_quantity` STRING COMMENT 'The total number of rooms pre-allocated to the channel or partner for the specified room type and date range.',
    `allotment_status` STRING COMMENT 'Current lifecycle status of the allotment: active (currently in use), inactive (not currently active), suspended (temporarily halted), expired (past end date), or pending (awaiting activation).. Valid values are `active|inactive|suspended|expired|pending`',
    `allotment_type` STRING COMMENT 'Classification of the allotment by partner type: channel (generic distribution channel), OTA (Online Travel Agency), GDS (Global Distribution System), wholesale (wholesale partner), corporate (corporate account), group (group booking block), or tour_operator (tour operator allocation). [ENUM-REF-CANDIDATE: channel|ota|gds|wholesale|corporate|group|tour_operator — 7 candidates stripped; promote to reference product]',
    `auto_release_enabled` BOOLEAN COMMENT 'Indicates whether unsold allotment inventory is automatically released back to general inventory when the release period is reached (True) or requires manual release (False).',
    `available_quantity` STRING COMMENT 'The number of rooms remaining available in this allotment (calculated as allocated_quantity minus sold_quantity).',
    `booking_window_end_days` STRING COMMENT 'The maximum number of days before arrival that bookings can be made from this allotment. For example, 365 means bookings can be made up to 365 days in advance. Nullable if no maximum booking window applies.',
    `booking_window_start_days` STRING COMMENT 'The minimum number of days before arrival that bookings can be made from this allotment. For example, 1 means bookings can be made starting 1 day before arrival. Nullable if no minimum booking window applies.',
    `allotment_code` STRING COMMENT 'Unique business identifier or code for the allotment, used for tracking and reporting purposes in the Central Reservation System (CRS) and Property Management System (PMS).. Valid values are `^[A-Z0-9]{3,20}$`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'The commission percentage paid to the channel or partner for bookings made through this allotment. For example, 15.00 represents a 15% commission.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the legal contract or agreement governing this allotment arrangement with the channel or partner.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment record was first created in the Central Reservation System (CRS).',
    `end_date` DATE COMMENT 'The last date on which this allotment is effective. Nullable for open-ended allotments.',
    `expired_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment expired and was no longer available for bookings. Nullable if not yet expired.',
    `freesale_enabled` BOOLEAN COMMENT 'Indicates whether the channel or partner can sell beyond the allocated quantity by accessing general inventory (True) or is restricted to the allocated quantity only (False). Freesale allows partners to sell from the hotels available inventory without a fixed allotment limit.',
    `freesale_threshold_quantity` STRING COMMENT 'The minimum number of rooms that must remain available in general inventory before freesale access is restricted or disabled for this allotment. Nullable if freesale is not enabled.',
    `lra_enabled` BOOLEAN COMMENT 'Indicates whether Last Room Availability (LRA) is enabled for this allotment, allowing the channel or partner to sell the last available room at the property (True) or restricting access when inventory is low (False).',
    `max_los` STRING COMMENT 'The maximum number of nights a guest can book when reserving from this allotment. Nullable if no maximum Length of Stay (LOS) restriction applies.',
    `min_los` STRING COMMENT 'The minimum number of nights a guest must book when reserving from this allotment. Nullable if no minimum Length of Stay (LOS) restriction applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment record was last modified or updated.',
    `allotment_name` STRING COMMENT 'Descriptive name for the allotment (e.g., Expedia Summer Block, Corporate XYZ Annual Contract).',
    `notes` STRING COMMENT 'Free-text notes or comments about this allotment, including special terms, conditions, or operational instructions.',
    `overbooking_limit` STRING COMMENT 'The maximum number of rooms that can be overbooked for this allotment beyond the allocated quantity, used for yield optimization and revenue management. Nullable if overbooking is not permitted.',
    `performance_threshold_percent` DECIMAL(18,2) COMMENT 'The minimum sell-through percentage required to maintain or increase the allotment quantity. For example, 80.00 means the partner must sell at least 80% of the allocated rooms to avoid reduction. Nullable if no performance threshold applies.',
    `priority_rank` STRING COMMENT 'The priority ranking of this allotment relative to other allotments for the same room type and date range. Lower numbers indicate higher priority for inventory allocation. Used by Revenue Management System (RMS) for dynamic allocation.',
    `release_period_days` STRING COMMENT 'The number of days before the arrival date by which unsold allotment inventory must be released back to general inventory. For example, a 7-day release period means unsold rooms are returned to the hotel 7 days before arrival.',
    `sold_quantity` STRING COMMENT 'The number of rooms from this allotment that have been sold or reserved by the channel or partner.',
    `start_date` DATE COMMENT 'The first date on which this allotment becomes effective and inventory is allocated to the channel or partner.',
    `suspended_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment was suspended or temporarily halted. Nullable if never suspended.',
    CONSTRAINT pk_allotment PRIMARY KEY(`allotment_id`)
) COMMENT 'Channel or partner allotment record defining a pre-allocated inventory quota for a specific distribution channel, OTA, tour operator, wholesale partner, or corporate account. Captures allotment quantity by room type and date range, release period (days before arrival), auto-release rules, sell-through/freesale thresholds, performance-based adjustment triggers, and channel-specific rate linkage. Managed in Sabre SynXis CRS for real-time channel distribution and inventory allocation across OTA, GDS, and wholesale partners.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` (
    `inventory_overbooking_policy_id` BIGINT COMMENT 'Unique identifier for the overbooking policy configuration record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this overbooking policy for activation.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property to which this overbooking policy applies.',
    `room_type_id` BIGINT COMMENT 'Reference to the specific room type (e.g., King Suite, Double Queen) governed by this overbooking policy.',
    `tertiary_inventory_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this overbooking policy record.',
    `revenue_overbooking_policy_id` BIGINT COMMENT '',
    `approval_authority` STRING COMMENT 'The role or position authorized to approve and activate this overbooking policy, ensuring accountability for revenue and guest satisfaction impact.. Valid values are `revenue_manager|director_of_revenue|general_manager|regional_director|automated`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this overbooking policy was formally approved for use.',
    `cancellation_forecast_rate` DECIMAL(18,2) COMMENT 'The expected cancellation rate (as a percentage) for this room type during the policy period, used to justify overbooking limits.',
    `channel_applicability` STRING COMMENT 'Defines which distribution channels (direct, OTA, GDS) are subject to this overbooking policy, enabling channel-specific inventory control.. Valid values are `all_channels|direct_only|ota_only|gds_only|selective`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this overbooking policy record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this overbooking policy expires or is no longer enforced. Null indicates an open-ended policy.',
    `effective_start_date` DATE COMMENT 'The date from which this overbooking policy becomes active and begins to govern inventory allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this overbooking policy record was most recently updated.',
    `los_restriction_max` STRING COMMENT 'Maximum length of stay (in nights) allowed for reservations subject to this overbooking policy. Null indicates no maximum restriction.',
    `los_restriction_min` STRING COMMENT 'Minimum length of stay (in nights) required for reservations subject to this overbooking policy. Null indicates no minimum restriction.',
    `lra_enabled` BOOLEAN COMMENT 'Indicates whether Last Room Availability is enabled for this overbooking policy, allowing distribution partners to sell inventory up to the overbooking limit.',
    `maximum_overbooking_rooms` STRING COMMENT 'The absolute maximum number of rooms that can be overbooked above physical capacity, calculated or manually set based on the overbooking limit configuration.',
    `no_show_forecast_rate` DECIMAL(18,2) COMMENT 'The expected no-show rate (as a percentage) for this room type during the policy period, factored into overbooking calculations.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special instructions related to this overbooking policy.',
    `overbooking_limit_type` STRING COMMENT 'Defines whether the overbooking limit is expressed as a percentage of physical capacity, an absolute room count, or dynamically calculated by the RMS.. Valid values are `percentage|absolute_count|dynamic`',
    `overbooking_limit_value` DECIMAL(18,2) COMMENT 'The numeric value representing the maximum overbooking threshold. Interpretation depends on overbooking_limit_type (e.g., 10.00 for 10% or 5.00 for 5 rooms).',
    `physical_room_capacity` STRING COMMENT 'The actual number of physical rooms of this room type available at the property, used as the baseline for calculating overbooking limits.',
    `policy_code` STRING COMMENT 'Business identifier code for the overbooking policy, used for reference in revenue management and distribution systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_name` STRING COMMENT 'Human-readable name describing the overbooking policy (e.g., High Season King Suite Overbooking, Standard Double Overbooking).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the overbooking policy indicating whether it is actively enforced in reservation systems.. Valid values are `active|inactive|suspended|pending_approval|expired`',
    `priority_level` STRING COMMENT 'The priority level of this overbooking policy relative to other policies, used to resolve conflicts when multiple policies apply to the same inventory.. Valid values are `low|medium|high|critical`',
    `upgrade_buffer_rooms` STRING COMMENT 'Number of higher-category rooms reserved as a buffer to accommodate overbooked guests through complimentary upgrades, reducing walk risk.',
    `walk_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the walk cost estimate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `walk_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated average cost per walked guest (including relocation, compensation, and goodwill), used in revenue optimization calculations.',
    `walk_risk_tolerance` STRING COMMENT 'The acceptable level of risk for walking guests (relocating to another property) due to overbooking, influencing the aggressiveness of the overbooking strategy.. Valid values are `low|medium|high|very_high`',
    CONSTRAINT pk_inventory_overbooking_policy PRIMARY KEY(`inventory_overbooking_policy_id`)
) COMMENT 'Property and room-type level overbooking policy configuration defining maximum overbooking limits (as percentage or absolute count above physical capacity) per room type per stay date or date range. Captures overbooking threshold, walk risk tolerance, upgrade buffer, and approval authority. Managed by revenue management team in IDeaS G3 RMS and enforced in Oracle OPERA PMS and Sabre SynXis CRS.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` (
    `los_restriction_id` BIGINT COMMENT 'Unique identifier for the length-of-stay restriction record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system account that created this LOS restriction record.',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this LOS restriction applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Identifier of the rate plan to which this LOS restriction applies. Nullable if restriction applies to all rate plans.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type to which this LOS restriction applies.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: LOS restrictions are routinely waived or modified by tier (platinum members exempt from 3-night minimums during peak demand). Revenue management systems need this to enforce tier-based restriction ove',
    `adr_threshold_amount` DECIMAL(18,2) COMMENT 'ADR threshold amount that triggers or releases this LOS restriction. Used for rate-based restriction logic.',
    `channel_code` STRING COMMENT 'Code identifying the distribution channel to which this restriction applies (e.g., GDS, OTA, Direct). Null if restriction applies to all channels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction record was first created in the system.',
    `day_of_week_pattern` STRING COMMENT '7-character binary string indicating which days of the week this restriction applies to (1=applies, 0=does not apply). Format: SMTWTFS (Sunday through Saturday).. Valid values are `^[0-1]{7}$`',
    `distribution_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction was last distributed to external channels via Sabre SynXis CRS or GDS connections.',
    `effective_end_date` DATE COMMENT 'The last date on which this LOS restriction is active. Null indicates an open-ended restriction.',
    `effective_start_date` DATE COMMENT 'The first date on which this LOS restriction becomes active and enforceable.',
    `forecast_demand_level` STRING COMMENT 'Forecasted demand level that triggered this LOS restriction: low, medium, high, or very high. Used for revenue optimization analytics.. Valid values are `low|medium|high|very_high`',
    `full_pattern_los` STRING COMMENT 'Comma-separated list of exact LOS values allowed (e.g., 3,7,14 means only 3-night, 7-night, or 14-night stays are permitted). Null if restriction type is not full_pattern.',
    `group_block_exempt_flag` BOOLEAN COMMENT 'Indicates whether group block reservations are exempt from this LOS restriction. True if group blocks bypass this restriction, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction record was last modified.',
    `loyalty_tier_exempt_list` STRING COMMENT 'Comma-separated list of loyalty program tier codes that are exempt from this LOS restriction (e.g., PLATINUM,DIAMOND). Null if no loyalty exemptions apply.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether this LOS restriction applies under Last Room Availability (LRA) conditions. True if restriction is enforced even when selling the last available room, false otherwise.',
    `market_segment_code` STRING COMMENT 'Code identifying the market segment to which this restriction applies (e.g., CORP, LEISURE, GROUP). Null if restriction applies to all segments.. Valid values are `^[A-Z]{2,10}$`',
    `max_los` STRING COMMENT 'Maximum number of nights a guest may stay when this restriction is active. Null if restriction type is not max_los.',
    `min_los` STRING COMMENT 'Minimum number of nights a guest must stay when this restriction is active. Null if restriction type is not min_los.',
    `occ_threshold_percent` DECIMAL(18,2) COMMENT 'Occupancy percentage threshold that triggers or releases this LOS restriction. Expressed as a percentage (e.g., 85.00 for 85%).',
    `override_authority_level` STRING COMMENT 'Minimum authority level required to override this LOS restriction during the reservation process: none (no override allowed), supervisor, manager, director, or general manager (GM).. Valid values are `none|supervisor|manager|director|gm`',
    `override_reason_required_flag` BOOLEAN COMMENT 'Indicates whether a documented reason is required when this LOS restriction is overridden. True if reason is mandatory, false otherwise.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the priority of this restriction when multiple LOS restrictions apply to the same stay date and room type. Lower numbers indicate higher priority.',
    `restriction_code` STRING COMMENT 'Business code identifying this LOS restriction rule for operational reference and reporting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `restriction_notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special instructions for this LOS restriction. Used for operational communication and audit purposes.',
    `restriction_status` STRING COMMENT 'Current operational status of this LOS restriction: active (enforced), inactive (not enforced), suspended (temporarily disabled), or pending (scheduled for future activation).. Valid values are `active|inactive|suspended|pending`',
    `restriction_type` STRING COMMENT 'Type of LOS restriction: minimum LOS (MinLOS), maximum LOS (MaxLOS), full-pattern LOS requirement, closed to arrival (CTA), or closed to departure (CTD).. Valid values are `min_los|max_los|full_pattern|closed_to_arrival|closed_to_departure`',
    `revenue_strategy_code` STRING COMMENT 'Code identifying the revenue management strategy or campaign that generated this LOS restriction (e.g., PEAK_DEMAND, SHOULDER_SEASON, EVENT_DRIVEN).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `revpar_threshold_amount` DECIMAL(18,2) COMMENT 'RevPAR threshold amount that triggers or releases this LOS restriction. Used for dynamic restriction management based on revenue performance.',
    `source_system_code` STRING COMMENT 'Code identifying the system that created or last modified this LOS restriction: OPERA (Oracle OPERA PMS), IDEAS (IDeaS G3 RMS), SYNXIS (Sabre SynXis CRS), EZRMS (Infor EzRMS), or MANUAL (manual entry).. Valid values are `OPERA|IDEAS|SYNXIS|EZRMS|MANUAL`',
    `stay_date` DATE COMMENT 'The specific date for which this LOS restriction applies. Represents the arrival or stay-through date depending on restriction logic.',
    CONSTRAINT pk_los_restriction PRIMARY KEY(`los_restriction_id`)
) COMMENT 'Length-of-Stay (LOS) restriction record defining minimum LOS (MinLOS), maximum LOS (MaxLOS), and full-pattern LOS requirements per room type per stay date and rate plan. Supports LOS-based revenue optimization strategies managed in IDeaS G3 RMS and distributed via Sabre SynXis CRS. Captures restriction type, effective date range, applicable channels, and override authority.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` (
    `channel_inventory_map_id` BIGINT COMMENT 'Unique identifier for the channel inventory mapping record. Primary key.',
    `channel_contract_id` BIGINT COMMENT 'Identifier of the channel contract or agreement under which this inventory mapping is governed. Links to channel contract master data.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system account that created this channel inventory mapping record.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property for which this channel inventory mapping applies.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: channel_inventory_map defines which room types are available to each distribution channel. Currently uses denormalized room_type_code (STRING). Adding FK to room_type.inventory_room_type_id normalizes',
    `advance_booking_days_max` STRING COMMENT 'Maximum number of days in advance that a reservation can be made through this channel for this room type. Null indicates no maximum booking window restriction.',
    `advance_booking_days_min` STRING COMMENT 'Minimum number of days in advance that a reservation must be made through this channel for this room type. Used for channel-specific booking window controls.',
    `allocation_type` STRING COMMENT 'Method by which inventory is allocated to this channel: free_sell (real-time availability), allotment (fixed block), block (group block), or dynamic (RMS-driven allocation).. Valid values are `free_sell|allotment|block|dynamic`',
    `booking_source_code` STRING COMMENT 'Code identifying the specific booking source within the channel (e.g., sub-channel, affiliate, or partner identifier). Provides granular attribution for channel performance analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_code` STRING COMMENT 'Unique code identifying the distribution channel (e.g., EXPEDIA, BOOKING_COM, DIRECT_WEB, GDS_SABRE, VOICE, MOBILE_APP). Standardized channel identifier used across CRS and PMS systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_priority_rank` STRING COMMENT 'Numeric ranking indicating the priority of this channel for inventory allocation (lower number = higher priority). Used when multiple channels compete for limited inventory.',
    `channel_sell_limit` STRING COMMENT 'Maximum number of rooms of this type that can be sold through this specific channel on any given date. Used for channel-level inventory allocation and overbooking controls.',
    `channel_visibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether this room type is visible and bookable through this channel. False indicates the mapping exists but the room type is hidden from the channel.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether bookings made through this channel for this room type are eligible for commission payments to the channel partner.',
    `connectivity_method` STRING COMMENT 'Technical method used to connect and synchronize inventory with this channel: API (Application Programming Interface), GDS (Global Distribution System), XML feed, manual update, or channel manager platform.. Valid values are `api|gds|xml|manual|channel_manager`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel inventory mapping record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this channel inventory mapping expires or is no longer active. Null indicates open-ended availability.',
    `effective_start_date` DATE COMMENT 'The date from which this channel inventory mapping becomes active and the room type is available for sale through the specified channel.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful inventory synchronization with this channel for this room type mapping.',
    `lra_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether Last Room Availability is enabled for this channel-room type combination, allowing the channel to sell inventory down to the last available room.',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the channel inventory mapping indicating whether the room type is currently being distributed through this channel.. Valid values are `active|inactive|suspended|pending`',
    `market_segment_code` STRING COMMENT 'Code identifying the market segment targeted by this channel distribution (e.g., LEISURE, CORPORATE, GROUP, GOVERNMENT). Used for revenue management segmentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `maximum_los_override` STRING COMMENT 'Channel-specific override for maximum length of stay restriction in nights. Null indicates no channel-specific override; property-level LOS rules apply.',
    `minimum_los_override` STRING COMMENT 'Channel-specific override for minimum length of stay requirement in nights. Null indicates no channel-specific override; property-level LOS rules apply.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel inventory mapping record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this channel inventory mapping configuration.',
    `overbooking_limit_pct` DECIMAL(18,2) COMMENT 'Channel-specific overbooking limit expressed as a percentage of physical inventory. Allows controlled overbooking to optimize occupancy while managing walk risk.',
    `rate_parity_enforcement_flag` BOOLEAN COMMENT 'Boolean indicator of whether rate parity rules are enforced for this channel-room type mapping, ensuring consistent pricing across distribution channels.',
    `rate_plan_code` STRING COMMENT 'Code identifying the rate plan associated with this channel inventory mapping. Defines pricing strategy and restrictions for this channel-room type combination.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `stop_sell_override_flag` BOOLEAN COMMENT 'Boolean indicator of whether a manual stop-sell override is in effect for this channel-room type combination, preventing new bookings regardless of availability.',
    `sync_frequency_minutes` STRING COMMENT 'Frequency in minutes at which inventory availability is synchronized with this channel. Lower values indicate more real-time synchronization.',
    CONSTRAINT pk_channel_inventory_map PRIMARY KEY(`channel_inventory_map_id`)
) COMMENT 'Mapping record defining which room types and inventory quantities are made available to each distribution channel (OTA, GDS, direct web, voice, mobile) for a given property and date range. Captures channel code, room type eligibility, sell limit per channel, channel priority ranking, and parity enforcement flag. Managed in Sabre SynXis CRS and synchronized with Oracle OPERA PMS for real-time channel inventory distribution.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` (
    `change_audit_id` BIGINT COMMENT 'Primary key for change_audit',
    `employee_id` BIGINT COMMENT 'System identifier of the user who authorized or executed the change.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the inventory change occurred.',
    `reversed_audit_log_change_audit_id` BIGINT COMMENT 'Reference to the original audit log entry that this entry reverses, if this is a reversal transaction.',
    `approval_authority_level` STRING COMMENT 'Level of authority that approved the change: system (automated), property manager, revenue manager, regional director, or corporate level.. Valid values are `system|property_manager|revenue_manager|regional_director|corporate`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this type of change required explicit management approval per SOX internal control policies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the change was formally approved by the authorizing authority, if approval was required.',
    `authorizing_user_name` STRING COMMENT 'Full name of the user who authorized or executed the change, for audit trail readability.',
    `business_date` DATE COMMENT 'The hotel business date (night audit date) for which this inventory change is effective, distinct from the change timestamp.',
    `change_impact_type` STRING COMMENT 'Category of impact this change has on inventory: availability (room count changes), control (CTA/CTD/LOS/stop-sell), status (OOO/OOS), allocation (block/allotment), or pricing (rate-related).. Valid values are `availability|control|status|allocation|pricing`',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the change (e.g., REVENUE_OPTIMIZATION, MAINTENANCE, GROUP_BLOCK, SYSTEM_CORRECTION, NIGHT_AUDIT_ADJUSTMENT, EMERGENCY_OOO).',
    `change_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the change, supporting dispute resolution and audit review.',
    `change_timestamp` TIMESTAMP COMMENT 'Exact date and time when the inventory change was committed to the system. Primary business event timestamp for this audit log entry.',
    `changed_entity_reference` STRING COMMENT 'Unique identifier of the specific entity that was changed (e.g., room number, block ID, allotment ID, control rule ID).',
    `changed_entity_type` STRING COMMENT 'Type of inventory entity that was modified: room inventory, room block, allotment, control (CTA/CTD/LOS/stop-sell/overbooking limit), availability override, out-of-order/out-of-service designation, or channel inventory mapping.. Valid values are `room_inventory|room_block|allotment|control|availability_override|channel_mapping`',
    `channel_code` STRING COMMENT 'Distribution channel code affected by the change (e.g., OTA, GDS, DIRECT), if applicable to channel-specific inventory modifications.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this change was made to satisfy regulatory compliance requirements (USALI, SOX, or other).',
    `cta_ctd_change_flag` BOOLEAN COMMENT 'Indicates whether this change modified CTA (Close to Arrival) or CTD (Close to Departure) restrictions, which control bookings based on arrival or departure dates.',
    `effective_end_date` DATE COMMENT 'Last date on which the inventory change remains effective, supporting date-range controls and LOS restrictions.',
    `effective_start_date` DATE COMMENT 'First date on which the inventory change becomes effective, supporting date-range controls and LOS (Length of Stay) restrictions.',
    `field_name` STRING COMMENT 'Name of the specific field or attribute that was modified (e.g., availability_count, overbooking_limit, room_status, CTA_days, stop_sell_flag).',
    `los_restriction_change_flag` BOOLEAN COMMENT 'Indicates whether this change modified LOS (Length of Stay) restrictions, including minimum or maximum stay requirements.',
    `lra_change_flag` BOOLEAN COMMENT 'Indicates whether this change affected Last Room Availability (LRA) settings, which control whether the last available room can be sold at all rate levels.',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the field after the change was applied. Stored as string to accommodate various data types.',
    `night_audit_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this change was made as part of the night audit process to reconcile inventory discrepancies.',
    `overbooking_limit_change_flag` BOOLEAN COMMENT 'Indicates whether this change modified overbooking limits, a critical control for revenue management and guest satisfaction.',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the field before the change was applied. Stored as string to accommodate various data types.',
    `rate_plan_code` STRING COMMENT 'Code identifying the rate plan affected by the change (e.g., BAR, CORP, GOV), if applicable to the changed entity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit log record was first created in the data warehouse, distinct from the business change timestamp.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this audit log entry represents a reversal or correction of a previous change.',
    `room_type_code` STRING COMMENT 'Code identifying the room type affected by the change (e.g., KING, SUITE, DBL), if applicable to the changed entity.',
    `source_system_transaction_code` STRING COMMENT 'Unique transaction or batch identifier from the source system that generated this change, enabling cross-system traceability.',
    `stop_sell_change_flag` BOOLEAN COMMENT 'Indicates whether this change involved stop-sell controls, which prevent bookings for specific room types, rate plans, or channels.',
    CONSTRAINT pk_change_audit PRIMARY KEY(`change_audit_id`)
) COMMENT 'Business audit trail capturing all material changes to inventory state: control modifications (CTA/CTD/LOS/stop-sell/overbooking limit changes), availability overrides, OOO/OOS designations, block modifications, allotment adjustments, and channel inventory map changes. Records changed entity type, entity ID, field name, previous value, new value, change reason code, authorizing user, approval authority level, change timestamp, and source system (OPERA, IDeaS, SynXis). Supports revenue management governance, night audit dispute resolution, USALI compliance reporting, and SOX controls for publicly traded hospitality companies.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` (
    `room_amenity_id` BIGINT COMMENT 'Unique identifier for the room amenity record. Primary key for the room amenity catalog.',
    `fire_safety_record_id` BIGINT COMMENT 'Foreign key linking to compliance.fire_safety_record. Business justification: Fire safety inspections evaluate amenities (smoke detectors, sprinklers, fire extinguishers) installed in rooms. Links amenity to fire safety record for inspection tracking, compliance certification, ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Premium room amenities (TVs, furniture, artwork) meeting capitalization thresholds are tracked as fixed assets requiring depreciation schedules, useful life tracking, and CapEx budget management. Esse',
    `parent_room_amenity_id` BIGINT COMMENT 'Self-referencing FK on room_amenity (parent_room_amenity_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this amenity record. Supports accountability and audit compliance.',
    `property_id` BIGINT COMMENT 'Identifier of the property where this amenity is available. Links to the property master data.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room where this amenity is installed. Null if amenity is defined at room type level only.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: room_amenity product description states amenities are available by room type and individual room. Currently only has FK to room (room_id). Many amenities are defined at room_type level (e.g., all De',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier who provided the amenity. Links to procurement and vendor management systems.',
    `amenity_category` STRING COMMENT 'High-level classification of the amenity type for inventory management and guest preference tracking. [ENUM-REF-CANDIDATE: technology|bathroom|bedding|minibar|furniture|climate_control|entertainment|connectivity — 8 candidates stripped; promote to reference product]',
    `amenity_code` STRING COMMENT 'Standardized code identifying the amenity type. Used for system integration and reporting consistency across properties.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `amenity_description` STRING COMMENT 'Detailed description of the amenity including brand, model, features, and guest-facing benefits. Used for marketing and guest communication.',
    `amenity_name` STRING COMMENT 'Business-friendly name of the amenity as displayed to guests and staff. Examples: Smart TV, Minibar, Espresso Machine, Premium Bedding.',
    `brand_name` STRING COMMENT 'Manufacturer or brand name of the amenity. Important for luxury properties where brand recognition drives guest satisfaction.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Price charged to guest if amenity is consumed or used. Null for complimentary amenities. Used for minibar items and premium services.',
    `condition_status` STRING COMMENT 'Current physical condition of the amenity as assessed during last inspection. Drives maintenance and replacement decisions.. Valid values are `excellent|good|fair|poor|needs_replacement`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Required when unit_cost is populated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this amenity record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Required when charge_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `display_sequence` STRING COMMENT 'Sort order for displaying amenities in guest-facing interfaces and reports. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date after which this amenity configuration is no longer active. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this amenity configuration becomes active and available for guest use or booking display.',
    `guest_visible_flag` BOOLEAN COMMENT 'Indicates whether this amenity is displayed in guest-facing channels such as booking engines, mobile apps, and property websites. Used for marketing and distribution.',
    `installation_date` DATE COMMENT 'Date when the amenity was installed or placed in the room. Used for tracking asset age and planning replacement cycles.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the amenity meets ADA accessibility requirements. Critical for compliance and guest accommodation matching.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the amenity is provided at no additional charge to the guest. False indicates a chargeable amenity such as minibar items.',
    `is_eco_friendly` BOOLEAN COMMENT 'Indicates whether the amenity meets environmental sustainability standards. Used for green certification programs and guest preference matching.',
    `is_premium_amenity` BOOLEAN COMMENT 'Indicates whether this amenity is considered a premium or luxury feature that differentiates the room type and justifies higher ADR (Average Daily Rate).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or condition assessment of the amenity. Critical for quality assurance and guest satisfaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this amenity record was most recently updated. Used for change tracking and synchronization.',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between scheduled maintenance or inspection cycles for this amenity. Used for preventive maintenance scheduling.',
    `model_number` STRING COMMENT 'Manufacturer model number or SKU for the amenity. Used for procurement, warranty tracking, and replacement ordering.',
    `next_scheduled_replacement_date` DATE COMMENT 'Planned date for replacing or refreshing the amenity based on lifecycle policy. Supports proactive FF&E capital planning.',
    `operational_status` STRING COMMENT 'Current operational availability of the amenity. Inactive or out_of_service amenities are not available to guests.. Valid values are `active|inactive|out_of_service|pending_installation|removed`',
    `purchase_order_number` STRING COMMENT 'Purchase order reference number for the amenity acquisition. Used for financial reconciliation and audit trails.',
    `quantity` STRING COMMENT 'Number of units of this amenity present in the room or room type. Example: 2 for pillows, 1 for minibar.',
    `special_instructions` STRING COMMENT 'Free-text field for operational notes, handling instructions, or guest communication guidelines related to the amenity.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Acquisition cost per unit of the amenity. Used for CapEx (Capital Expenditure) tracking and ROI (Return on Investment) analysis.',
    `unit_of_measure` STRING COMMENT 'Unit in which the amenity quantity is measured. Used for inventory tracking and replenishment.. Valid values are `each|set|pair|bottle|package`',
    `warranty_expiration_date` DATE COMMENT 'Date when manufacturer warranty coverage expires. Important for cost planning and vendor relationship management.',
    CONSTRAINT pk_room_amenity PRIMARY KEY(`room_amenity_id`)
) COMMENT 'Master catalog of in-room amenities and features available by room type and individual room, including minibar contents, technology amenities (smart TV, Bluetooth speaker), bathroom fixtures, and premium bedding configurations. Tracks amenity installation date, condition, and replacement schedule.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` (
    `rate_plan_room_type_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each rate plan room type assignment record. Primary key for the association.',
    `channel_rate_plan_id` BIGINT COMMENT 'Foreign key linking to the channel rate plan configuration. Identifies which rate plan this room type is being sold under.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to the room type master catalog. Identifies which room type this rate plan assignment applies to.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate plan room type assignment was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this room type is no longer available under this rate plan. Null indicates ongoing availability. Used to manage promotional periods and seasonal configurations.',
    `effective_start_date` DATE COMMENT 'Date when this room type becomes available under this rate plan. Used for seasonal rate plan configurations and promotional periods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate plan room type assignment was last updated. Tracks when revenue managers made changes to rates, restrictions, or sell limits.',
    `max_los` STRING COMMENT 'Maximum number of nights allowed for this specific room type under this rate plan. Room-type-specific override of the base rate plan max_los restriction.',
    `min_los` STRING COMMENT 'Minimum number of nights required for this specific room type under this rate plan. Can differ from the base rate plan min_los to implement room-type-specific restrictions (e.g., suites require 3-night minimum while standard rooms require 2).',
    `modified_by_user` STRING COMMENT 'User ID or username of the revenue manager who last modified this assignment configuration.',
    `priority_rank` STRING COMMENT 'Ranking used to determine which rate plan to display or apply when multiple rate plans are available for the same room type. Lower numbers indicate higher priority. Used in rate shopping and channel distribution logic.',
    `rate_adjustment_value` DECIMAL(18,2) COMMENT 'The room-type-specific rate adjustment applied to this rate plan. Can be a percentage markup/markdown or flat amount depending on adjustment type. Revenue managers set different adjustments per room type to reflect demand and value differences.',
    `restriction_status` STRING COMMENT 'Current availability status for this room type under this rate plan. OPEN = available for sale, CLOSED = not bookable, CLOSED_TO_ARRIVAL = no check-ins allowed, CLOSED_TO_DEPARTURE = no check-outs allowed. Revenue managers adjust this based on demand forecasts.',
    `sell_limit` STRING COMMENT 'Maximum number of rooms of this type that can be sold under this rate plan. Used for inventory allocation and yield management to control how many rooms are available at promotional rates versus BAR.',
    CONSTRAINT pk_rate_plan_room_type_assignment PRIMARY KEY(`rate_plan_room_type_assignment_id`)
) COMMENT 'This association product represents the assignment between room types and channel rate plans in the revenue management system. It captures room-type-specific rate adjustments, length-of-stay restrictions, sell limits, and availability controls that exist only in the context of a specific room type being sold under a specific channel rate plan. Each record links one room type to one channel rate plan with pricing and inventory control attributes that revenue managers actively configure and adjust based on demand forecasts and channel strategy.. Existence Justification: In hotel revenue management operations, each room type can be sold under multiple channel rate plans (BAR, corporate, package, OTA-specific plans), and each channel rate plan applies to multiple room types within a property. Revenue managers actively configure and manage room-type-specific rate adjustments, length-of-stay restrictions, sell limits, and availability controls for each room-type-rate-plan combination. This is a core operational entity in PMS/RMS systems where humans create, update, and delete these assignments as part of daily yield management and channel distribution strategy.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` (
    `room_type_vendor_supply_id` BIGINT COMMENT 'Unique identifier for this room type vendor supply relationship. Primary key.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to the room type that this vendor supplies goods and services for',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing goods and services for this room type',
    `active_status` STRING COMMENT 'Current status of this supply relationship. Inactive relationships are retained for historical spend analysis but not available for new procurement.',
    `contract_effective_date` DATE COMMENT 'Date when the supply contract for this room type-vendor combination becomes effective. Used for contract lifecycle management.',
    `contract_expiry_date` DATE COMMENT 'Date when the supply contract for this room type-vendor combination expires. Triggers renewal workflows and vendor re-evaluation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this supply relationship was established in the system.',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor for this room type category. Used for vendor activity tracking and relationship health monitoring.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this supply relationship record.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days for this vendor to deliver goods for this room type category. Critical for inventory planning and renovation scheduling.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity required by this vendor for this room type category. Used for procurement planning and order consolidation.',
    `negotiated_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount negotiated with this vendor for supplies related to this room type category. Applied at invoice time.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred supplier for this room type category. Used for procurement routing and approval workflows.',
    `supply_category` STRING COMMENT 'Category of goods or services this vendor provides for this room type. Examples: FF&E (furniture, fixtures, equipment), Amenities, Housekeeping Supplies, Linens, Technology.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative spend amount with this vendor for this room type category. Used for vendor tier classification, negotiation leverage, and spend analytics.',
    CONSTRAINT pk_room_type_vendor_supply PRIMARY KEY(`room_type_vendor_supply_id`)
) COMMENT 'This association product represents the supply contract between room_type and vendor. It captures the procurement relationship where vendors supply FF&E (furniture, fixtures, and equipment), amenities, and housekeeping supplies for specific room type categories. Each record links one room type to one vendor with negotiated terms, pricing, lead times, and performance metrics that exist only in the context of this supply relationship.. Existence Justification: In hotel procurement operations, room types are supplied by multiple vendors (e.g., luxury suites may have different vendors for FF&E, linens, amenities, and technology), and each vendor supplies goods for multiple room type categories across properties. Procurement teams actively manage these supply relationships with negotiated contracts, pricing terms, lead times, and performance tracking specific to each room-type-vendor combination.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` (
    `room_material_installation_id` BIGINT COMMENT 'Unique identifier for this specific installation record. Primary key.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master record for the installed item',
    `room_id` BIGINT COMMENT 'Foreign key linking to the physical room where the material is installed',
    `condition_status` STRING COMMENT 'Current condition assessment of the installed material. Updated by housekeeping inspections and engineering assessments. Drives maintenance and replacement prioritization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this installation record was created in the system. Audit trail field.',
    `installation_date` DATE COMMENT 'Date when the material was installed in the room. Used for age calculation, warranty tracking, and depreciation schedules.',
    `installation_notes` STRING COMMENT 'Free-text notes about the installation including installer, special configuration, or issues encountered. Audit trail for property management.',
    `last_maintenance_date` DATE COMMENT 'Date when preventive maintenance was last performed on this material. Used to calculate next maintenance due date.',
    `last_replacement_date` DATE COMMENT 'Date when this material was last replaced in the room. Tracks replacement history for lifecycle analysis and budgeting.',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between scheduled preventive maintenance activities for this material in this room. Varies by material type and room usage intensity.',
    `next_scheduled_replacement_date` DATE COMMENT 'Planned date for next replacement based on lifecycle policy, condition assessments, and capital planning cycles. Drives CapEx budgeting and procurement forecasting.',
    `quantity_installed` DECIMAL(18,2) COMMENT 'Number of units of this material installed in the room (e.g., 2 nightstands, 1 desk, 4 pillows). Critical for inventory valuation and replacement planning.',
    `unit_cost_at_installation` DECIMAL(18,2) COMMENT 'Actual cost per unit paid at time of installation. Captured for asset valuation, depreciation calculation, and ROI analysis. May differ from current material_master.standard_price.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this installation record was last updated. Audit trail field.',
    `warranty_expiry_date` DATE COMMENT 'Date when manufacturer or vendor warranty expires for this installation. Used to determine repair vs. replacement decisions and vendor claim eligibility.',
    CONSTRAINT pk_room_material_installation PRIMARY KEY(`room_material_installation_id`)
) COMMENT 'This association product represents the installation and lifecycle management of procured materials (furniture, fixtures, equipment) within individual guestrooms. It captures the operational reality that each room contains multiple FF&E items, and each material type is installed across multiple rooms. Each record tracks installation dates, warranty periods, replacement schedules, condition assessments, and maintenance frequencies for capital planning, asset lifecycle management, and preventive maintenance scheduling.. Existence Justification: In hotel operations, each guestroom contains multiple procured materials (furniture, fixtures, equipment - FF&E items such as beds, desks, TVs, carpets, drapes, minibars), and each material type is installed across multiple rooms throughout the property portfolio. Hotels actively manage these installations as operational assets, tracking installation dates, warranty periods, condition status, replacement schedules, and maintenance frequencies for each material in each room. This is a core operational process for capital planning, preventive maintenance scheduling, and asset lifecycle management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` (
    `block_wash_factor_application_id` BIGINT COMMENT 'Primary key for the block_wash_factor_application association',
    `room_block_id` BIGINT COMMENT 'Foreign key linking to the group room block to which the wash factor was applied',
    `wash_factor_id` BIGINT COMMENT 'Foreign key linking to the wash factor configuration that was applied to the block',
    `actual_wash_pct` DECIMAL(18,2) COMMENT 'The actual attrition percentage observed after the block concluded, calculated as (contracted_room_nights - picked_up_room_nights) / contracted_room_nights. Used for post-event analysis.',
    `application_reason` STRING COMMENT 'Free-text explanation of why this specific wash factor was selected for this block (e.g., Corporate group, 90-day lead time, 50-room block matches historical profile).',
    `application_status` STRING COMMENT 'Lifecycle status of this application record. active = currently used for forecasting; superseded = replaced by a newer application; final = block concluded, actual wash recorded.',
    `applied_by` STRING COMMENT 'Name or user identifier of the revenue manager who applied or approved this wash factor application, or SYSTEM if automatically applied by RMS.',
    `applied_wash_pct` DECIMAL(18,2) COMMENT 'The wash factor percentage that was applied to this specific block during forecasting. This is the predicted attrition rate used by the RMS.',
    `block_size_tier_match` STRING COMMENT 'Indicates whether the block size matched the wash factors block_size_tier exactly, required interpolation between tiers, or used a default factor. Supports wash factor selection audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this application record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this wash factor was applied to the block for forecasting purposes. Supports tracking of multiple factor applications over the block lifecycle (e.g., initial forecast, revised forecast).',
    `forecast_run_code` STRING COMMENT 'Identifier of the RMS forecast run during which this wash factor was applied. Links to the specific forecast cycle for audit and reproducibility.',
    `lead_time_bucket_match` STRING COMMENT 'Indicates whether the booking lead time matched the wash factors booking_lead_time_bucket exactly, required interpolation, or used a default factor. Supports wash factor selection audit trail.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this application record was last updated (e.g., when actual wash was recorded post-event).',
    `variance_pct` DECIMAL(18,2) COMMENT 'The difference between applied wash percentage and actual wash percentage (actual_wash_pct - applied_wash_pct). Positive variance indicates the block washed more than predicted; negative indicates better pickup than predicted.',
    `wash_factor_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of block rooms that will not be picked up, used for revenue forecasting and inventory planning. Expressed as percentage (e.g., 15.00 for 15%). [Moved from room_block: This attribute in room_block represents a specific wash factor percentage applied to the block. However, a block may have multiple wash factors applied over time (initial forecast, revised forecast, post-event analysis) or may be evaluated against multiple factor configurations. This attribute should move to the association to support tracking of multiple applications with their effective dates and contexts.]',
    CONSTRAINT pk_block_wash_factor_application PRIMARY KEY(`block_wash_factor_application_id`)
) COMMENT 'This association product represents the application of a specific wash factor configuration to a group room block for forecasting and post-event performance analysis. It captures which wash factor was applied to which block, the predicted and actual wash percentages, variance analysis, and the business context (lead time bucket, block size tier) that determined factor selection. Each record links one room block to one wash factor with attributes that exist only in the context of this application event.. Existence Justification: In revenue management operations, a single group room block is evaluated against multiple wash factor configurations during its lifecycle—initial forecasting may apply one factor based on lead time and block size, revised forecasts may apply updated factors as the block matures, and post-event analysis compares actual performance against multiple factor models to refine future predictions. Conversely, a single wash factor configuration (e.g., Corporate groups, 60-90 day lead time, 25-50 rooms) is applied to many different room blocks that match its criteria. Revenue managers actively track each block×wash_factor application as a distinct performance measurement record with predicted vs. actual wash variance.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` (
    `room_type_promotion_id` BIGINT COMMENT 'Unique identifier for this room type promotion configuration record. Primary key.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to the room type participating in this promotion',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the loyalty promotion offering special terms for this room type',
    `active_status` STRING COMMENT 'Current operational status of this room type promotion configuration. Values: active (available for booking), paused (temporarily disabled by revenue management), sold_out (inventory cap reached), expired (booking window closed).',
    `blackout_dates` STRING COMMENT 'Comma-separated list of date ranges (YYYY-MM-DD to YYYY-MM-DD) when this room type is excluded from the promotion due to high demand periods, holidays, or inventory constraints. Example: 2024-12-20 to 2024-12-31, 2024-07-04 to 2024-07-04.',
    `bonus_points_multiplier` DECIMAL(18,2) COMMENT 'Points earning multiplier specific to this room type and promotion combination. Example: 2.0 means double points, 3.0 means triple points. Overrides the promotion-level multiplier when room-type-specific earning rules apply.',
    `booking_window_end_date` DATE COMMENT 'Last date when members can book this room type under this promotion. May differ from promotion end_date to manage inventory availability or phase out specific room types from the offer.',
    `booking_window_start_date` DATE COMMENT 'First date when members can book this room type under this promotion. Used for early-access offers or phased promotional launches by room category.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this room type promotion configuration was created by the loyalty or revenue management team.',
    `inventory_allocation_cap` STRING COMMENT 'Maximum number of rooms of this type allocated to this promotion. Used by revenue management to control promotional inventory and protect higher-rated business. Null if no cap applies.',
    `minimum_los_override` STRING COMMENT 'Minimum number of nights required to book this room type under this promotion. Overrides property-level or promotion-level minimum LOS when room-type-specific restrictions apply. Null if no override.',
    `promotional_rate_amount` DECIMAL(18,2) COMMENT 'Special promotional rate (in property currency) offered for this room type under this promotion. Overrides standard BAR or member rates. Null if promotion does not include rate discount.',
    `rooms_booked_count` STRING COMMENT 'Cumulative count of rooms of this type booked under this promotion to date. Updated in real-time by reservation system. Used to enforce inventory_allocation_cap.',
    `created_by` STRING COMMENT 'Username or employee ID of the loyalty or revenue management team member who configured this room type for this promotion.',
    CONSTRAINT pk_room_type_promotion PRIMARY KEY(`room_type_promotion_id`)
) COMMENT 'This association product represents the promotional configuration between room types and loyalty promotions. It captures the specific promotional rates, bonus earning rules, and booking restrictions that apply when a member books a specific room type under a specific promotion. Each record links one room type to one promotion with attributes that define the promotional offer mechanics, rate overrides, and eligibility windows that exist only in the context of this specific room-promotion combination.. Existence Justification: In travel hospitality loyalty programs, promotions (e.g., Book 3 Nights, Earn 5000 Bonus Points or Suite Upgrade Promotion) apply to multiple room types with type-specific promotional rates, bonus earning multipliers, and booking restrictions. Conversely, each room type participates in multiple concurrent promotions throughout the year (seasonal offers, tier-specific promotions, flash sales). Revenue management and loyalty teams actively configure and manage these room-type-promotion combinations, setting promotional rates, blackout dates, inventory caps, and booking windows for each pairing.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` (
    `room_type_competitive_benchmark_id` BIGINT COMMENT 'Primary key for room_type_competitive_benchmark',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to the room type being benchmarked against the competitive set',
    `competitive_set_id` BIGINT COMMENT 'Foreign key linking to the competitive set used for benchmarking this room type',
    `advance_purchase_window_days` STRING COMMENT 'The booking lead time window in days used for rate shopping comparisons for this specific room type and competitive set pairing. Allows different lead time analysis for different room type segments (e.g., suites may use 30-day window, standard rooms 7-day window).',
    `benchmark_room_type_category` STRING COMMENT 'The STR room type category classification used for this specific room type when benchmarking against this competitive set. Maps property-specific room types to standardized STR categories for apples-to-apples comparison. Examples: STANDARD, DELUXE, SUITE, PREMIUM.',
    `benchmark_weight` DECIMAL(18,2) COMMENT 'The weighting percentage applied to this competitive set when calculating blended benchmark metrics for this room type. Used when a room type is benchmarked against multiple competitive sets with different importance levels. Sum of weights across all comp sets for a room type should equal 100.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this benchmark configuration record was created.',
    `effective_date` DATE COMMENT 'The date from which this room type to competitive set benchmark configuration becomes active. Allows revenue managers to schedule future changes to benchmark mappings aligned with property renovations, rebranding, or competitive strategy shifts.',
    `expiry_date` DATE COMMENT 'The date on which this benchmark configuration expires and is no longer used for rate shopping or STR reporting. Null indicates an active, ongoing configuration.',
    `is_primary_comp_category` BOOLEAN COMMENT 'Indicates whether this is the primary competitive set used for benchmarking this room type. A room type may be mapped to multiple competitive sets (primary luxury set, secondary airport set), but only one is designated as primary for executive reporting and KPI dashboards.',
    `last_modified_by` STRING COMMENT 'User ID or username of the revenue manager who last modified this benchmark configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this benchmark configuration record was last modified.',
    `los_benchmark_nights` STRING COMMENT 'The standard length of stay in nights used for rate shopping and benchmarking comparisons for this room type and competitive set combination. Different room types may use different LOS windows (e.g., suites benchmarked at 3-night stays, standard rooms at 1-night stays).',
    `rate_shop_frequency` STRING COMMENT 'Override frequency for automated rate shopping for this specific room type and competitive set pairing. Allows revenue managers to configure more frequent rate checks for high-value room types or key competitive sets. Overrides the default rate_shop_frequency from the competitive_set master.',
    `room_type_competitive_benchmark_status` STRING COMMENT 'Current operational status of this benchmark configuration. ACTIVE configurations are used in live rate shopping and STR reporting. INACTIVE configurations are historical. SUSPENDED configurations are temporarily disabled but may be reactivated.',
    `created_by` STRING COMMENT 'User ID or username of the revenue manager who created this benchmark configuration mapping.',
    CONSTRAINT pk_room_type_competitive_benchmark PRIMARY KEY(`room_type_competitive_benchmark_id`)
) COMMENT 'This association product represents the configuration relationship between room types and competitive sets for STR benchmarking and rate shopping. It captures the specific mapping rules that revenue managers define to determine which room type categories are compared against which competitive set segments. Each record links one room type to one competitive set with relationship-specific attributes including benchmark category mapping, rate shopping frequency overrides, length-of-stay parameters, and effective date ranges that exist only in the context of this specific room-type-to-comp-set pairing.. Existence Justification: Revenue managers actively configure many-to-many mappings between room types and competitive sets for STR benchmarking and rate shopping. A single room type (e.g., Deluxe King) can be benchmarked against multiple competitive sets simultaneously (luxury downtown set, airport premium set, corporate traveler set), and each competitive set is used to benchmark multiple room types across the property. Each pairing requires relationship-specific configuration including STR category mapping, rate shopping frequency overrides, LOS parameters, and effective date ranges that cannot reside on either the room type or competitive set entity alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_connecting_room_id` FOREIGN KEY (`connecting_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ADD CONSTRAINT `fk_inventory_inventory_overbooking_policy_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ADD CONSTRAINT `fk_inventory_channel_inventory_map_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ADD CONSTRAINT `fk_inventory_change_audit_reversed_audit_log_change_audit_id` FOREIGN KEY (`reversed_audit_log_change_audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`change_audit`(`change_audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_parent_room_amenity_id` FOREIGN KEY (`parent_room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ADD CONSTRAINT `fk_inventory_rate_plan_room_type_assignment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ADD CONSTRAINT `fk_inventory_room_type_vendor_supply_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ADD CONSTRAINT `fk_inventory_room_material_installation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ADD CONSTRAINT `fk_inventory_block_wash_factor_application_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ADD CONSTRAINT `fk_inventory_room_type_promotion_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ADD CONSTRAINT `fk_inventory_room_type_competitive_benchmark_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Assessment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|renovation');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `bathroom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_description` SET TAGS ('dbx_business_glossary_term' = 'Room Type Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `floor_level_range` SET TAGS ('dbx_business_glossary_term' = 'Floor Level Range');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Compliant');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `is_connecting_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Connecting Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `is_suite` SET TAGS ('dbx_business_glossary_term' = 'Is Suite');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'LRA (Last Room Availability) Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_name` SET TAGS ('dbx_business_glossary_term' = 'Room Type Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `overbooking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `pseudo_room_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudo Room Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_class` SET TAGS ('dbx_business_glossary_term' = 'Room Class');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_class` SET TAGS ('dbx_value_regex' = 'standard|deluxe|premium|suite|executive|luxury');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_features` SET TAGS ('dbx_business_glossary_term' = 'Room Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `sellable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sellable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_business_glossary_term' = 'Smoking Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking|both');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `standard_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupancy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `view_category` SET TAGS ('dbx_business_glossary_term' = 'View Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Assessment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `connecting_room_id` SET TAGS ('dbx_business_glossary_term' = 'Connecting Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `fire_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Record Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `ada_accessible` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accessible');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `balcony_available` SET TAGS ('dbx_business_glossary_term' = 'Balcony Available');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `connecting_room_available` SET TAGS ('dbx_business_glossary_term' = 'Connecting Room Available');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `features` SET TAGS ('dbx_business_glossary_term' = 'Room Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `ffe_condition_score` SET TAGS ('dbx_business_glossary_term' = 'FF&E (Furniture Fixtures and Equipment) Condition Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `front_office_status` SET TAGS ('dbx_business_glossary_term' = 'Front Office Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `front_office_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved|blocked');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_value_regex' = 'clean|dirty|inspected|pickup|do_not_disturb');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `kitchenette_available` SET TAGS ('dbx_business_glossary_term' = 'Kitchenette Available');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'LRA (Last Room Availability) Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_order|out_of_inventory|under_renovation');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `out_of_order_end_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `out_of_order_reason` SET TAGS ('dbx_business_glossary_term' = 'Out of Order Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `out_of_order_start_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `overbooking_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `smoking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Smoking Allowed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `view_type` SET TAGS ('dbx_business_glossary_term' = 'View Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `wing_code` SET TAGS ('dbx_business_glossary_term' = 'Wing Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `room_status_id` SET TAGS ('dbx_business_glossary_term' = 'Room Status Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Current Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Current Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_value_regex' = 'checkout|stayover|deep_clean|turndown|refresh');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `do_not_disturb_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `expected_checkin_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Check-In Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `expected_checkout_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Checkout Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `front_desk_status` SET TAGS ('dbx_business_glossary_term' = 'Front Desk Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `front_desk_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved|due_out|due_in|out_of_order');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_service|do_not_disturb');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `is_clean` SET TAGS ('dbx_business_glossary_term' = 'Is Clean Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `is_inspected` SET TAGS ('dbx_business_glossary_term' = 'Is Inspected Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `is_out_of_order` SET TAGS ('dbx_business_glossary_term' = 'Is Out of Order (OOO) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `last_inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspected Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `last_occupied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Occupied Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `last_vacated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Vacated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'available|minor_repair|major_repair|out_of_order|scheduled_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `out_of_order_end_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order (OOO) End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `out_of_order_reason` SET TAGS ('dbx_business_glossary_term' = 'Out of Order (OOO) Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `out_of_order_start_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order (OOO) Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `status_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_value_regex' = 'not_requested|requested|completed|declined');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `availability_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Availability Snapshot ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `closed_to_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Arrival (CTA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `closed_to_departure_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Departure (CTD) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `max_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS) Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `min_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS) Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `net_available_rooms` SET TAGS ('dbx_business_glossary_term' = 'Net Available Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `occ_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate (OCC)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|manual_override');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_blocked_allotment` SET TAGS ('dbx_business_glossary_term' = 'Rooms Blocked for Allotment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_blocked_group` SET TAGS ('dbx_business_glossary_term' = 'Rooms Blocked for Groups');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_day_use` SET TAGS ('dbx_business_glossary_term' = 'Day Use Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_house_use` SET TAGS ('dbx_business_glossary_term' = 'House Use Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_out_of_order` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Order (OOO)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_out_of_service` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Service (OOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_overbooked` SET TAGS ('dbx_business_glossary_term' = 'Rooms Overbooked');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_sold` SET TAGS ('dbx_business_glossary_term' = 'Rooms Sold');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `stop_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `total_physical_rooms` SET TAGS ('dbx_business_glossary_term' = 'Total Physical Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `inventory_control_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Control ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `advance_booking_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Limit Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `channel_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Channel Allocation Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `competitive_set_adr` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|override|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `cta_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Arrival (CTA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `ctd_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Departure (CTD) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `forecast_adr` SET TAGS ('dbx_business_glossary_term' = 'Forecast Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `forecast_demand` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `forecast_occ_pct` SET TAGS ('dbx_business_glossary_term' = 'Forecast Occupancy Percentage (OCC)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (MaxLOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `min_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (MinLOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `overbooking_limit_absolute` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Absolute');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `overbooking_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Control Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `rgi_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generation Index (RGI) Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `sell_limit` SET TAGS ('dbx_business_glossary_term' = 'Sell Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Control Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'rms|manual|api|bulk_upload');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `stop_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Walk Risk Tolerance');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `group_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Group Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Group Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Manager ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `tertiary_room_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `tertiary_room_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `tertiary_room_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `attrition_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Attrition Penalty Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `attrition_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `attrition_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `available_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Available Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Block Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|waitlist|cancelled|released|completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'group|event|corporate|tour|wedding|conference');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `booking_source` SET TAGS ('dbx_value_regex' = 'direct|gds|ota|crs|sales_team|third_party');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `contracted_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Contracted Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Block End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `negotiated_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `picked_up_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Picked Up Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pickup Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Block Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `block_pickup_id` SET TAGS ('dbx_business_glossary_term' = 'Block Pickup ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `group_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Group Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|tentative|definite|released|cancelled|completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `contracted_rooms` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `cumulative_pickup` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Pickup');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `days_to_arrival` SET TAGS ('dbx_business_glossary_term' = 'Days to Arrival (DTA)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `displacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Displacement Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `forecasted_pickup` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Pickup');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `is_lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `net_pickup` SET TAGS ('dbx_business_glossary_term' = 'Net Pickup');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Pickup Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_notes` SET TAGS ('dbx_business_glossary_term' = 'Pickup Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_pace_variance` SET TAGS ('dbx_business_glossary_term' = 'Pickup Pace Variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pickup Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_rate` SET TAGS ('dbx_business_glossary_term' = 'Pickup Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_revenue` SET TAGS ('dbx_business_glossary_term' = 'Pickup Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `pickup_variance` SET TAGS ('dbx_business_glossary_term' = 'Pickup Variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `prior_year_pickup` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Pickup');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `released_rooms` SET TAGS ('dbx_business_glossary_term' = 'Released Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `remaining_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Remaining Block Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `rooms_picked_up` SET TAGS ('dbx_business_glossary_term' = 'Rooms Picked Up');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ALTER COLUMN `wash_factor` SET TAGS ('dbx_business_glossary_term' = 'Wash Factor');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `tertiary_out_closed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `tertiary_out_closed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `tertiary_out_closed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Service Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `actual_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Service Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `ada_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `closed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closed By Staff Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Duration in Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return-to-Service Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `guest_impacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impacted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `impact_on_occ` SET TAGS ('dbx_business_glossary_term' = 'Impact on Occupancy (OCC) Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `impact_on_revpar` SET TAGS ('dbx_business_glossary_term' = 'Impact on Revenue Per Available Room (RevPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `lost_revenue_estimate` SET TAGS ('dbx_business_glossary_term' = 'Lost Revenue Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `lost_revenue_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `ooo_code` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `ooo_reason` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `ooo_status` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Status Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `ooo_status` SET TAGS ('dbx_value_regex' = 'OOO|OOS');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Completed|Cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `relocation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Relocation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Staff Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `safety_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Concern Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `adjustment_trigger_enabled` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Trigger Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_business_glossary_term' = 'Allotment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_type` SET TAGS ('dbx_business_glossary_term' = 'Allotment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `auto_release_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Release Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `booking_window_end_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `booking_window_start_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_code` SET TAGS ('dbx_business_glossary_term' = 'Allotment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (Percent)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allotment End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `expired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expired Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `freesale_enabled` SET TAGS ('dbx_business_glossary_term' = 'Freesale Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `freesale_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Freesale Threshold Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `lra_enabled` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `allotment_name` SET TAGS ('dbx_business_glossary_term' = 'Allotment Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allotment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `performance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold (Percent)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `release_period_days` SET TAGS ('dbx_business_glossary_term' = 'Release Period (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `sold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sold Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allotment Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ALTER COLUMN `suspended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Suspended Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `inventory_overbooking_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Overbooking Policy ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `revenue_overbooking_policy_id` SET TAGS ('dbx_ssot_owner' = 'revenue.revenue_overbooking_policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `revenue_overbooking_policy_id` SET TAGS ('dbx_ssot_entity' = 'overbooking_policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'revenue_manager|director_of_revenue|general_manager|regional_director|automated');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `cancellation_forecast_rate` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Forecast Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'all_channels|direct_only|ota_only|gds_only|selective');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `los_restriction_max` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Restriction Maximum');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `los_restriction_min` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Restriction Minimum');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `lra_enabled` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Enabled');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `maximum_overbooking_rooms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Overbooking Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `no_show_forecast_rate` SET TAGS ('dbx_business_glossary_term' = 'No-Show Forecast Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `overbooking_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `overbooking_limit_type` SET TAGS ('dbx_value_regex' = 'percentage|absolute_count|dynamic');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `overbooking_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `physical_room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Physical Room Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `physical_room_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Policy Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Policy Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `upgrade_buffer_rooms` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Buffer Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Walk Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Walk Cost Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Walk Risk Tolerance');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `los_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `adr_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR) Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_business_glossary_term' = 'Day-of-Week Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_value_regex' = '^[0-1]{7}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `forecast_demand_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `forecast_demand_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `full_pattern_los` SET TAGS ('dbx_business_glossary_term' = 'Full-Pattern Length-of-Stay (LOS) Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `group_block_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Block Exempt Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `loyalty_tier_exempt_list` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Exempt List');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length-of-Stay (MaxLOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length-of-Stay (MinLOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `occ_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Occupancy (OCC) Threshold Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Override Authority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|gm');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `override_reason_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'min_los|max_los|full_pattern|closed_to_arrival|closed_to_departure');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `revenue_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Strategy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `revenue_strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `revpar_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Available Room (RevPAR) Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'OPERA|IDEAS|SYNXIS|EZRMS|MANUAL');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_inventory_map_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Inventory Map ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `advance_booking_days_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `advance_booking_days_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'free_sell|allotment|block|dynamic');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Channel Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_sell_limit` SET TAGS ('dbx_business_glossary_term' = 'Channel Sell Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `channel_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Visibility Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `connectivity_method` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `connectivity_method` SET TAGS ('dbx_value_regex' = 'api|gds|xml|manual|channel_manager');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `lra_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `mapping_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `maximum_los_override` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS) Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `minimum_los_override` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS) Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `overbooking_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `rate_parity_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Parity Enforcement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `stop_sell_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Override Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ALTER COLUMN `sync_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Frequency Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Change Audit Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `reversed_audit_log_change_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Audit Log ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'system|property_manager|revenue_manager|regional_director|corporate');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `authorizing_user_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing User Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `authorizing_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `authorizing_user_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_impact_type` SET TAGS ('dbx_value_regex' = 'availability|control|status|allocation|pricing');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `changed_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Changed Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `changed_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Changed Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `changed_entity_type` SET TAGS ('dbx_value_regex' = 'room_inventory|room_block|allotment|control|availability_override|channel_mapping');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `cta_ctd_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Close to Arrival (CTA) / Close to Departure (CTD) Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `los_restriction_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Restriction Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `lra_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `night_audit_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Night Audit Adjustment Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `overbooking_limit_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `source_system_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ALTER COLUMN `stop_sell_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `fire_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Record Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `parent_room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Room Amenity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `parent_room_amenity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `amenity_category` SET TAGS ('dbx_business_glossary_term' = 'Amenity Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `amenity_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `amenity_name` SET TAGS ('dbx_business_glossary_term' = 'Amenity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|needs_replacement');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `guest_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Visible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Compliant');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `is_eco_friendly` SET TAGS ('dbx_business_glossary_term' = 'Is Eco-Friendly');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `is_premium_amenity` SET TAGS ('dbx_business_glossary_term' = 'Is Premium Amenity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `next_scheduled_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Replacement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|out_of_service|pending_installation|removed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|set|pair|bottle|package');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` SET TAGS ('dbx_subdomain' = 'rate_assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` SET TAGS ('dbx_association_edges' = 'inventory.room_type,channel.channel_rate_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `rate_plan_room_type_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Room Type Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `channel_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Room Type Assignment - Channel Rate Plan Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Room Type Assignment - Inventory Room Type Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `rate_adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Room Type Rate Adjustment Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ALTER COLUMN `sell_limit` SET TAGS ('dbx_business_glossary_term' = 'Sell Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` SET TAGS ('dbx_association_edges' = 'inventory.room_type,procurement.vendor');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `room_type_vendor_supply_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Vendor Supply ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Vendor Supply - Inventory Room Type Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Vendor Supply - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `negotiated_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `supply_category` SET TAGS ('dbx_business_glossary_term' = 'Supply Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` SET TAGS ('dbx_association_edges' = 'inventory.room,procurement.material_master');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `room_material_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Room Material Installation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Room Material Installation - Material Master Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Material Installation - Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `installation_notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `last_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replacement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `next_scheduled_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Replacement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `quantity_installed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Installed');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `unit_cost_at_installation` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost at Installation');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` SET TAGS ('dbx_association_edges' = 'inventory.room_block,revenue.wash_factor');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `block_wash_factor_application_id` SET TAGS ('dbx_business_glossary_term' = 'Block Wash Factor Application - Block Wash Factor Application Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Wash Factor Application - Room Block Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `wash_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Block Wash Factor Application - Wash Factor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `actual_wash_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Wash Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `application_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `applied_by` SET TAGS ('dbx_business_glossary_term' = 'Applied By');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `applied_wash_pct` SET TAGS ('dbx_business_glossary_term' = 'Applied Wash Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `block_size_tier_match` SET TAGS ('dbx_business_glossary_term' = 'Block Size Tier Match Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Application Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `forecast_run_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `lead_time_bucket_match` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Bucket Match Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `wash_factor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Wash Factor Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ALTER COLUMN `wash_factor_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` SET TAGS ('dbx_subdomain' = 'rate_assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` SET TAGS ('dbx_association_edges' = 'inventory.room_type,loyalty.promotion');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `room_type_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Promotion Configuration ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Promotion - Inventory Room Type Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Promotion - Promotion Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Active Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `bonus_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Multiplier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `booking_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `booking_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `inventory_allocation_cap` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation Cap');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `minimum_los_override` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `promotional_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `rooms_booked_count` SET TAGS ('dbx_business_glossary_term' = 'Rooms Booked Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` SET TAGS ('dbx_subdomain' = 'rate_assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` SET TAGS ('dbx_association_edges' = 'inventory.room_type,revenue.competitive_set');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `room_type_competitive_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'room_type_competitive_benchmark Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Competitive Benchmark - Inventory Room Type Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `competitive_set_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Competitive Benchmark - Revenue Competitive Set Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `advance_purchase_window_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Window Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `benchmark_room_type_category` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Room Type Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `benchmark_weight` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Weight Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Configuration Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Configuration Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `is_primary_comp_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitive Category Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `los_benchmark_nights` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay Benchmark Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `rate_shop_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Shopping Frequency Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `room_type_competitive_benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Configuration Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created By User');
