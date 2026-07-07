-- Schema for Domain: inventory | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`inventory` COMMENT 'Real-time room inventory management including room types, physical room attributes, availability, room status, housekeeping status, out-of-order designations, and inventory controls. Manages room blocks, allotments, overbooking limits, and LRA (Last Room Availability). Integrates with PMS (Oracle OPERA) and RMS (IDeaS G3) for dynamic inventory allocation across distribution channels. Tracks OCC and supports LOS-based controls.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` (
    `room_type_id` BIGINT COMMENT 'Primary key for room_type',
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
    `connecting_room_id` BIGINT COMMENT 'Identifier of the adjacent room that connects to this room via connecting door. Null if no connecting room.',
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
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Room status transitions (dirty→clean, vacant→inspected) are driven by hk_assignment completion events. Direct FK enables front-desk room readiness reporting, discrepancy resolution (discrepancy_flag o',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to housekeeping.inspection. Business justification: room_status.is_inspected and last_inspected_timestamp reflect the outcome of a specific inspection record. Direct FK enables traceability from room status to the inspection that certified it clean, su',
    `out_of_order_id` BIGINT COMMENT 'Foreign key linking to inventory.out_of_order. Business justification: room_status currently carries denormalized OOO fields: is_out_of_order (BOOLEAN), out_of_order_start_date, out_of_order_end_date, and out_of_order_reason. The out_of_order table is the authoritative O',
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
    `priority_level` STRING COMMENT 'Housekeeping priority level for servicing this room. Urgent: immediate attention required (e.g., due-in within 1 hour); High: priority cleaning (e.g., VIP guest, early check-in); Normal: standard cleaning schedule; Low: can be deferred.. Valid values are `low|normal|high|urgent`',
    `special_instructions` STRING COMMENT 'Free-text special instructions for housekeeping staff regarding this room (e.g., guest allergies, VIP preferences, extra amenities required).',
    `status_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the room status was last updated in the system. Tracks the most recent status transition.',
    `turndown_service_status` STRING COMMENT 'Status of evening turndown service for the room. Not Requested: no turndown service scheduled; Requested: guest or property standard requires turndown; Completed: turndown service has been performed; Declined: guest declined turndown service.. Valid values are `not_requested|requested|completed|declined`',
    CONSTRAINT pk_room_status PRIMARY KEY(`room_status_id`)
) COMMENT 'Real-time operational status record for each physical room capturing the current housekeeping state (dirty, clean, inspected, pick-up), front-desk status (vacant, occupied, due-out, due-in), and maintenance flags. Tracks status transitions with timestamps, assigned housekeeper, last inspection time, and turndown service status. Integrates with Oracle OPERA PMS housekeeping module for live room status boards.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` (
    `availability_snapshot_id` BIGINT COMMENT 'Unique identifier for the availability snapshot record. Primary key for this entity.',
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
    `budget_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_budget. Business justification: Inventory control decisions (hurdle rates, sell limits, rgi_target) are set in alignment with revenue budget targets. Linking control records to the governing budget period enables budget-vs-actual co',
    `channel_id` BIGINT COMMENT 'Identifier of the distribution channel (OTA, GDS, Direct) to which this control applies. Null indicates control applies to all channels.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Inventory controls (stop-sell, hurdle rates, sell limits) are set based on specific demand forecast runs. Linking control to demand_forecast enables RMS audit trails, forecast-to-control traceability,',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Revenue managers create availability control overrides (stop-sell lifts, overbooking limit changes) specifically triggered by loyalty promotions. This FK enables tracking which promotion drove a contr',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this inventory control applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Identifier of the rate plan to which this control applies. Null indicates control applies to all rate plans for the room type and date.',
    `room_block_id` BIGINT COMMENT 'Identifier of the group block that this control is associated with. Null if control is not tied to a specific group reservation.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type (e.g., Deluxe King, Standard Queen) to which this control applies.',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to event.account. Business justification: Room blocks are contracted by corporate accounts that drive negotiated rates, credit terms, and attrition liability. Account-level room block history, credit exposure, and pickup reporting are standar',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Channel-sourced block management: room blocks originate from specific distribution channels (GDS group desks, OTA allotments, direct). Linking to channel enables commission calculation, channel-level ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate account management requires linking contracted room blocks to the corporate account that negotiated them, enabling attrition tracking, pickup reporting, and contract compliance monitoring. C',
    `event_booking_id` BIGINT COMMENT 'Reference to the associated event or group booking that this room block supports.',
    `event_contract_id` BIGINT COMMENT 'Foreign key linking to event.event_contract. Business justification: Room blocks are governed by event contracts specifying attrition clauses, cutoff dates, and cancellation penalties. Hospitality revenue managers and legal teams must link each room block to its govern',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Room blocks are always classified by market segment (group, corporate, wholesale) for STR benchmarking, USALI segment reporting, and revenue budget variance analysis. Revenue managers cannot produce a',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Group sales process: contracted room blocks for conferences/events are paired with specific meeting space bookings at the same property. Group sales and revenue management teams must associate a room ',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Group blocks are regularly created in conjunction with loyalty promotions (e.g., a bonus-points promotional campaign driving a group booking). This FK links the block to the driving promotion for camp',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the room block is allocated.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Group block pickup reporting and revenue management require linking each room block to its contracted rate plan. Revenue managers track block pickup against rate plan performance for group segment ana',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: A room block reserves a contracted quantity of rooms BY ROOM TYPE — this is a fundamental business relationship in hotel group sales. The room_block record defines contracted_room_nights, negotiated_r',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Group blocks are frequently negotiated for a specific loyalty tier (e.g., a Platinum corporate block with special attrition terms). This FK enables tier-specific group block contract management and re',
    `attrition_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount charged to the group if pickup falls below the attrition threshold. Expressed in property base currency.',
    `attrition_percentage` DECIMAL(18,2) COMMENT 'Contractual percentage threshold below which the group incurs attrition penalties for unmet room night commitments. Expressed as percentage (e.g., 20.00 for 20%).',
    `available_room_nights` STRING COMMENT 'Remaining number of room nights still available for pickup within the block.',
    `block_code` STRING COMMENT 'Unique alphanumeric code identifying the room block, used for reservations and reporting. Externally-known identifier for group bookings.. Valid values are `^[A-Z0-9]{3,20}$`',
    `block_name` STRING COMMENT 'Descriptive name of the room block, typically including the group or event name for easy identification.',
    `block_status` STRING COMMENT 'Current lifecycle status of the room block: tentative (pending confirmation), definite (confirmed and contracted), waitlist (pending availability), cancelled (terminated), released (inventory returned), completed (event concluded).. Valid values are `tentative|definite|waitlist|cancelled|released|completed`',
    `block_type` STRING COMMENT 'Classification of the room block by purpose: group (general group travel), event (MICE events), corporate (business contracts), tour (tour operators), wedding (social events), conference (meeting-focused).. Valid values are `group|event|corporate|tour|wedding|conference`',
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
    `picked_up_room_nights` STRING COMMENT 'Cumulative number of room nights actually reserved and consumed from the block by guests.',
    `pickup_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of contracted room nights that have been picked up (reserved). Expressed as percentage (e.g., 85.50 for 85.5%).',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requirements, preferences, or requests associated with the room block (e.g., room location preferences, amenities, accessibility needs).',
    `start_date` DATE COMMENT 'First date of the room block period when rooms are reserved for the group or event.',
    CONSTRAINT pk_room_block PRIMARY KEY(`room_block_id`)
) COMMENT 'Group or event room block record reserving a contracted quantity of rooms by room type for a defined date range and pickup period. Captures block code, block name, group/event association, contracted room-nights by type and date, cumulative pickup, release/cutoff dates, attrition percentage and penalty terms, wash factor, and block status lifecycle (tentative, definite, cancelled, released). Links to group reservations and event contracts. Supports group inventory management, attrition tracking, and block release decisions in Oracle OPERA PMS and Delphi by Amadeus.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` (
    `out_of_order_id` BIGINT COMMENT 'Primary key for out_of_order',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the room is located.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room that is out-of-order or out-of-service.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` (
    `los_restriction_id` BIGINT COMMENT 'Unique identifier for the length-of-stay restriction record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Channel-specific LOS restriction enforcement: revenue managers apply minimum/maximum stay restrictions selectively by channel (e.g., 2-night minimum on OTAs only). The existing channel_code plain-text',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: LOS restrictions are set based on specific demand forecast runs. Revenue managers need to audit which forecast triggered each min/max LOS restriction for RMS calibration and restriction override gover',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: LOS restrictions are frequently set by market segment (e.g., exempt loyalty tiers, apply only to transient). Revenue managers need this FK for segment-level restriction reporting and to enforce segmen',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Loyalty promotions frequently include LOS restriction exemptions (e.g., a promotion waives the 3-night minimum for qualifying members). This FK links the specific LOS restriction record to the promoti',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this LOS restriction applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Identifier of the rate plan to which this LOS restriction applies. Nullable if restriction applies to all rate plans.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type to which this LOS restriction applies.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: LOS restrictions are routinely waived or modified by tier (platinum members exempt from 3-night minimums during peak demand). Revenue management systems need this to enforce tier-based restriction ove',
    `adr_threshold_amount` DECIMAL(18,2) COMMENT 'ADR threshold amount that triggers or releases this LOS restriction. Used for rate-based restriction logic.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction record was first created in the system.',
    `day_of_week_pattern` STRING COMMENT '7-character binary string indicating which days of the week this restriction applies to (1=applies, 0=does not apply). Format: SMTWTFS (Sunday through Saturday).. Valid values are `^[0-1]{7}$`',
    `distribution_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction was last distributed to external channels via Sabre SynXis CRS or GDS connections.',
    `effective_end_date` DATE COMMENT 'The last date on which this LOS restriction is active. Null indicates an open-ended restriction.',
    `effective_start_date` DATE COMMENT 'The first date on which this LOS restriction becomes active and enforceable.',
    `full_pattern_los` STRING COMMENT 'Comma-separated list of exact LOS values allowed (e.g., 3,7,14 means only 3-night, 7-night, or 14-night stays are permitted). Null if restriction type is not full_pattern.',
    `group_block_exempt_flag` BOOLEAN COMMENT 'Indicates whether group block reservations are exempt from this LOS restriction. True if group blocks bypass this restriction, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LOS restriction record was last modified.',
    `loyalty_tier_exempt_list` STRING COMMENT 'Comma-separated list of loyalty program tier codes that are exempt from this LOS restriction (e.g., PLATINUM,DIAMOND). Null if no loyalty exemptions apply.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether this LOS restriction applies under Last Room Availability (LRA) conditions. True if restriction is enforced even when selling the last available room, false otherwise.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` (
    `room_amenity_id` BIGINT COMMENT 'Unique identifier for the room amenity record. Primary key for the room amenity catalog.',
    `parent_room_amenity_id` BIGINT COMMENT 'Self-referencing FK on room_amenity (parent_room_amenity_id)',
    `property_id` BIGINT COMMENT 'Identifier of the property where this amenity is available. Links to the property master data.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room where this amenity is installed. Null if amenity is defined at room type level only.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: room_amenity product description states amenities are available by room type and individual room. Currently only has FK to room (room_id). Many amenities are defined at room_type level (e.g., all De',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_connecting_room_id` FOREIGN KEY (`connecting_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_out_of_order_id` FOREIGN KEY (`out_of_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`out_of_order`(`out_of_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_parent_room_amenity_id` FOREIGN KEY (`parent_room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Identifier');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ALTER COLUMN `connecting_room_id` SET TAGS ('dbx_business_glossary_term' = 'Connecting Room ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `room_status_id` SET TAGS ('dbx_business_glossary_term' = 'Room Status Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `status_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_value_regex' = 'not_requested|requested|completed|declined');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ALTER COLUMN `availability_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Availability Snapshot ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Budget Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `event_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Event Contract Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `picked_up_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Picked Up Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pickup Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Block Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `los_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Length-of-Stay (LOS) Restriction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `adr_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR) Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_business_glossary_term' = 'Day-of-Week Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `day_of_week_pattern` SET TAGS ('dbx_value_regex' = '^[0-1]{7}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `full_pattern_los` SET TAGS ('dbx_business_glossary_term' = 'Full-Pattern Length-of-Stay (LOS) Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `group_block_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Block Exempt Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `loyalty_tier_exempt_list` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Exempt List');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `parent_room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Room Amenity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `parent_room_amenity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
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
