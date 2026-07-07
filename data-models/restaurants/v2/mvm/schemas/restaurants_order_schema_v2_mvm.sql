-- Schema for Domain: order | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`order` COMMENT 'Core transactional domain managing order capture, fulfillment, and delivery across all service channels including POS (Oracle MICROS), drive-thru (DT), online ordering (OLO), third-party delivery (3PD), and catering. Tracks order lifecycle, KDS routing, ticket time, speed of service (SOS), average transaction count (ATC), and average check value (ACV).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`guest_order` (
    `guest_order_id` BIGINT COMMENT 'Primary key for the guest order.',
    `channel_id` BIGINT COMMENT 'FK to the order channel.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: guest_order.daypart is a denormalized STRING code referencing the daypart dimension. Adding daypart_id FK normalizes this relationship and resolves the daypart tables silo (no in-domain inbound FKs).',
    `member_id` BIGINT COMMENT 'FK to loyalty member.',
    `program_id` BIGINT COMMENT 'FK to loyalty program.',
    `menu_id` BIGINT COMMENT 'FK to menu active at time of order.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Each dine-in or counter order is initiated at a specific POS terminal. Terminal-level throughput reporting, shift reconciliation, and PCI audit trails require order-to-terminal linkage. Payment captur',
    `profile_id` BIGINT COMMENT 'FK to guest profile.',
    `employee_id` BIGINT COMMENT 'FK to employee who served the order.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level sales reporting and labor-to-sales ratio analysis are core restaurant operations reports. Associating each order with the active shift enables end-of-shift reconciliation and productivity ',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `cancelled_at` TIMESTAMP COMMENT 'Timestamp when order was cancelled.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when order record was created.',
    `currency_code` STRING COMMENT 'ISO currency code for the order.',
    `delivery_address_line1` STRING COMMENT 'First line of delivery address.',
    `delivery_postal_code` STRING COMMENT 'Postal code for delivery.',
    `delivery_provider` STRING COMMENT 'Third-party delivery provider name.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order.',
    `fulfilled_at` TIMESTAMP COMMENT 'Timestamp when order was fulfilled.',
    `is_lto` BOOLEAN COMMENT 'Whether order contains LTO items.',
    `is_voided` BOOLEAN COMMENT 'Whether the order has been voided.',
    `item_count` STRING COMMENT 'Number of items in the order.',
    `kds_routed_at` TIMESTAMP COMMENT 'Timestamp when order was routed to KDS.',
    `loyalty_points_earned` STRING COMMENT 'Points earned from this order.',
    `loyalty_points_redeemed` STRING COMMENT 'Points redeemed on this order.',
    `olo_order_ref` STRING COMMENT 'Online ordering platform reference.',
    `order_status` STRING COMMENT 'Current status of the order.',
    `order_type` STRING COMMENT 'Type of order (dine-in, takeout, delivery, etc.).',
    `party_size` STRING COMMENT 'Number of guests in the party.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current payment status of the order.',
    `placed_at` TIMESTAMP COMMENT 'Timestamp when order was placed.',
    `pos_transaction_ref` STRING COMMENT 'POS system transaction reference.',
    `ready_at` TIMESTAMP COMMENT 'Timestamp when order was ready.',
    `sos_seconds` STRING COMMENT 'Speed of service in seconds.',
    `special_instructions` STRING COMMENT 'Guest special instructions for the order.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Order subtotal before tax and tip.',
    `table_number` STRING COMMENT 'Table number for dine-in orders.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount on the order.',
    `tender_type` STRING COMMENT 'Primary tender type used.',
    `ticket_number` STRING COMMENT 'POS ticket number.',
    `ticket_time_seconds` STRING COMMENT 'Total ticket time in seconds.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Tip amount on the order.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total order amount including tax and tip.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of last update.',
    `void_reason` STRING COMMENT 'Reason for voiding the order.',
    CONSTRAINT pk_guest_order PRIMARY KEY(`guest_order_id`)
) COMMENT 'Core order transaction capturing a guest purchase at a restaurant unit.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`order_item` (
    `order_item_id` BIGINT COMMENT 'Primary key for the order item.',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Item-level accrual rule attribution: accrual rules are scoped to menu items and categories. Linking order_item to the governing accrual_rule enables loyalty audit trails, member dispute resolution, an',
    `allergen_declaration_id` DECIMAL(18,2) COMMENT 'Foreign key linking to menu.allergen_declaration. Business justification: FDA and EU FIC regulatory requirements mandate allergen traceability at the point of sale. When a guest allergen incident occurs, operators must identify which allergen_declaration was in effect at or',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: order_item.daypart_code is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes product mix (pmix) analysis by daypart. The daypart_code STRING column becomes redun',
    `discount_id` BIGINT COMMENT 'FK to discount applied.',
    `guest_order_id` BIGINT COMMENT 'FK to parent guest order.',
    `item_cost_id` BIGINT COMMENT 'Foreign key linking to menu.item_cost. Business justification: Theoretical vs actual COGS variance reporting — a core restaurant P&L management process — requires linking each order line to the item_cost record active at order time. This enables food cost varianc',
    `item_price_id` BIGINT COMMENT 'Foreign key linking to menu.item_price. Business justification: Revenue assurance and price audit reporting require knowing which item_price record governed the unit_price at order time. Finance and internal audit teams use this to detect price overrides, validate',
    `kitchen_station_id` BIGINT COMMENT 'FK to kitchen station.',
    `menu_item_id` BIGINT COMMENT 'FK to menu item ordered.',
    `menu_modifier_id` BIGINT COMMENT 'FK to menu modifier.',
    `nutrition_profile_id` BIGINT COMMENT 'Foreign key linking to menu.nutrition_profile. Business justification: FDA menu labeling compliance (ACA Section 4205) requires restaurants to track which nutrition_profile version supported the calorie disclosure at order time. Nutritional audits and regulatory submissi',
    `combo_meal_id` BIGINT COMMENT 'FK to combo meal.',
    `employee_id` BIGINT COMMENT 'FK to employee who prepared the item.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: HACCP traceability and food cost variance reporting require knowing which recipe version was active at order time. Recipe versions change; the current recipe on menu_item may differ from what was prep',
    `allergen_override_flag` BOOLEAN COMMENT 'Whether allergen warning was overridden.',
    `calorie_count` STRING COMMENT 'Calorie count for the item.',
    `cost` DECIMAL(18,2) COMMENT 'COGS for the item.',
    `created_timestamp` TIMESTAMP COMMENT 'When the item was added to the order.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `is_combo_component` BOOLEAN COMMENT 'Whether item is part of a combo.',
    `is_lto` BOOLEAN COMMENT 'Whether item is a limited time offer.',
    `item_status` STRING COMMENT 'Current status of the order item.',
    `kds_bump_timestamp` TIMESTAMP COMMENT 'When item was bumped on KDS.',
    `kds_sent_timestamp` TIMESTAMP COMMENT 'When item was sent to KDS.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to this line.',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Gross amount before discounts.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net amount after discounts.',
    `line_sequence` STRING COMMENT 'Sequence number of the line item.',
    `loyalty_points_earned` STRING COMMENT 'Points earned from this item.',
    `modifier_price` DECIMAL(18,2) COMMENT 'Price of modifiers on this item.',
    `pmix_category` STRING COMMENT 'Product mix category.',
    `preparation_instructions` DECIMAL(18,2) COMMENT 'Special preparation instructions.',
    `promo_code` STRING COMMENT 'Promotional code applied.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity ordered.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded for this item.',
    `refund_flag` BOOLEAN COMMENT 'Whether item was refunded.',
    `service_channel` STRING COMMENT 'Channel through which item was ordered.',
    `source_system_item_ref` STRING COMMENT 'Source system item reference.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax on this line item.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether item is tax exempt.',
    `ticket_time_seconds` STRING COMMENT 'Time to prepare this item.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `void_reason_code` STRING COMMENT 'Reason code if item was voided.',
    `waste_flag` BOOLEAN COMMENT 'Whether item resulted in waste.',
    `waste_reason_code` STRING COMMENT 'Reason for waste.',
    CONSTRAINT pk_order_item PRIMARY KEY(`order_item_id`)
) COMMENT 'Individual line item within a guest order.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`order_modifier` (
    `order_modifier_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to employee who applied modifier.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: order_modifier.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes modifier usage analytics by time window (e.g., add-on frequency by daypart). The STRI',
    `guest_order_id` BIGINT COMMENT 'FK to parent order.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Restaurant COGS and food waste reporting require ingredient-level cost tracking for modifiers (e.g., extra cheese, add bacon). Without this FK, modifier-driven ingredient consumption cannot be attribu',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Modifier-level KDS routing assigns specific modifiers (e.g., add-ons, substitutions) to kitchen stations for preparation. Station throughput and SOS reporting by modifier type requires this FK. kds_st',
    `modifier_group_id` BIGINT COMMENT 'FK to modifier group.',
    `order_item_id` BIGINT COMMENT 'FK to order item.',
    `menu_modifier_id` BIGINT COMMENT 'FK to primary menu modifier.',
    `allergen_flag` BOOLEAN COMMENT 'Whether modifier introduces allergens.',
    `allergen_notes` STRING COMMENT 'Notes about allergens.',
    `applied_timestamp` TIMESTAMP COMMENT 'When modifier was applied.',
    `calorie_delta` STRING COMMENT 'Change in calories from modifier.',
    `cogs_delta` DECIMAL(18,2) COMMENT 'Change in COGS from modifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `group_name` STRING COMMENT 'Modifier group name.',
    `initiation_source` STRING COMMENT 'How modifier was initiated (guest, employee, system).',
    `is_comped` BOOLEAN COMMENT 'Whether modifier was complimentary.',
    `is_default` BOOLEAN COMMENT 'Whether this is a default modifier.',
    `is_voided` BOOLEAN COMMENT 'Whether modifier was voided.',
    `kds_acknowledged_timestamp` TIMESTAMP COMMENT 'When KDS acknowledged the modifier.',
    `kds_routed` BOOLEAN COMMENT 'Whether modifier was routed to KDS.',
    `loyalty_redemption_flag` BOOLEAN COMMENT 'Whether modifier was a loyalty redemption.',
    `lto_flag` BOOLEAN COMMENT 'Whether modifier is LTO.',
    `modifier_name` STRING COMMENT 'Display name of the modifier.',
    `modifier_status` STRING COMMENT 'Current status.',
    `modifier_type` STRING COMMENT 'Type of modifier (add, remove, substitute).',
    `olo_modifier_code` STRING COMMENT 'Online ordering modifier code.',
    `order_channel` STRING COMMENT 'Channel of the order.',
    `pos_modifier_code` STRING COMMENT 'POS system modifier code.',
    `prep_instruction` STRING COMMENT 'Preparation instruction for modifier.',
    `price_delta` DECIMAL(18,2) COMMENT 'Price change from modifier.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of modifier.',
    `sequence_number` STRING COMMENT 'Order of modifier application.',
    `unit_of_measure` STRING COMMENT 'UOM for modifier quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `voided_timestamp` TIMESTAMP COMMENT 'When modifier was voided.',
    CONSTRAINT pk_order_modifier PRIMARY KEY(`order_modifier_id`)
) COMMENT 'Modifier applied to an order item such as add-ons, substitutions, or removals.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to cashier.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: payment.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes payment analytics by time window (e.g., average check value by daypart, tender type distribu',
    `guest_order_id` BIGINT COMMENT 'FK to guest order.',
    `member_id` BIGINT COMMENT 'FK to loyalty member.',
    `pos_terminal_id` BIGINT COMMENT 'FK to POS terminal.',
    `profile_id` BIGINT COMMENT 'FK to guest profile.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Loyalty-tender payment reconciliation: when a loyalty reward is applied as a payment tender (free item, discount at checkout), the payment record must reference the redemption event for financial reco',
    `refund_id` BIGINT COMMENT 'FK to refund if applicable.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level cash and tender reconciliation is a mandatory daily process in restaurant operations. Linking payments to the shift during which they were processed enables shift cash-out reports, tip poo',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `applied_amount` DECIMAL(18,2) COMMENT 'Amount applied to the order.',
    `authorization_code` STRING COMMENT 'Payment authorization code.',
    `captured_timestamp` TIMESTAMP COMMENT 'When payment was captured.',
    `card_entry_method` STRING COMMENT 'How card was entered (swipe, chip, tap).',
    `card_type` STRING COMMENT 'Type of card (Visa, MC, etc.).',
    `change_due_amount` DECIMAL(18,2) COMMENT 'Change due to guest.',
    `channel` STRING COMMENT 'Payment channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied.',
    `gift_card_number_masked` STRING COMMENT 'Masked gift card number.',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'Interchange fee charged.',
    `is_split_tender` BOOLEAN COMMENT 'Whether payment is split tender.',
    `is_voided` BOOLEAN COMMENT 'Whether payment was voided.',
    `loyalty_points_redeemed` STRING COMMENT 'Points redeemed.',
    `masked_card_number` STRING COMMENT 'Masked card number.',
    `offline_authorization_flag` BOOLEAN COMMENT 'Whether authorized offline.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current payment status.',
    `pos_transaction_number` STRING COMMENT 'POS transaction number.',
    `processor_name` STRING COMMENT 'Payment processor name.',
    `processor_reference_code` STRING COMMENT 'Processor reference.',
    `promo_code_applied` STRING COMMENT 'Promo code used.',
    `refund_reason` DECIMAL(18,2) COMMENT 'Reason for refund if applicable.',
    `response_code` STRING COMMENT 'Processor response code.',
    `settlement_batch_code` STRING COMMENT 'Settlement batch identifier.',
    `settlement_date` DATE COMMENT 'Date of settlement.',
    `split_tender_sequence` STRING COMMENT 'Sequence in split tender.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax portion.',
    `tender_type` STRING COMMENT 'Type of tender.',
    `tendered_amount` DECIMAL(18,2) COMMENT 'Amount tendered by guest.',
    `third_party_delivery_partner` STRING COMMENT 'Delivery partner name.',
    `third_party_order_reference` STRING COMMENT 'Third party order ref.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Tip amount.',
    `token` STRING COMMENT 'Payment token.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Payment tendered against a guest order.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Primary key.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: status_event.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes speed-of-service (SOS) analytics by time window — a critical restaurant KPI. The STRING',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `guest_order_id` BIGINT COMMENT 'FK to guest order.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: KDS status events (bump, start, complete) are station-specific. Station-level SOS breach analysis and kitchen throughput reporting require a proper FK to kitchen_station. kds_station_code is a denorma',
    `pos_terminal_id` BIGINT COMMENT 'FK to POS terminal.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level speed-of-service (SOS) and throughput analysis is a core QSR operational report. Linking status events to the active shift enables shift-level SOS breach reporting and staffing adequacy as',
    `source_status_event_id` BIGINT COMMENT 'Self-referencing FK to prior event.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `business_date` DATE COMMENT 'Business date of event.',
    `cumulative_elapsed_seconds` STRING COMMENT 'Total elapsed time since order placed.',
    `current_state` DECIMAL(18,2) COMMENT 'Current order state after this event.',
    `data_quality_flag` BOOLEAN COMMENT 'Whether data quality issue detected.',
    `delivery_zone` STRING COMMENT 'Delivery zone if applicable.',
    `drive_thru_lane` STRING COMMENT 'Drive-thru lane number.',
    `elapsed_seconds_in_prior_state` STRING COMMENT 'Time spent in prior state.',
    `event_date` DATE COMMENT 'Date of event.',
    `event_sequence` STRING COMMENT 'Sequence number of event.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of event.',
    `exception_reason_code` STRING COMMENT 'Code for exception.',
    `exception_reason_description` STRING COMMENT 'Description of exception.',
    `fiscal_period` STRING COMMENT 'Fiscal period.',
    `fulfillment_mode` STRING COMMENT 'Mode of fulfillment.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'When record was ingested.',
    `is_cancellation_event` BOOLEAN COMMENT 'Whether this is a cancellation.',
    `is_sos_breach` BOOLEAN COMMENT 'Whether SOS target was breached.',
    `is_terminal_state` BOOLEAN COMMENT 'Whether this is a terminal state.',
    `is_void_event` BOOLEAN COMMENT 'Whether this is a void event.',
    `manager_override` BOOLEAN COMMENT 'Whether manager override was used.',
    `olo_order_reference` STRING COMMENT 'Online order reference.',
    `order_type` STRING COMMENT 'Type of order.',
    `partition_date` DATE COMMENT 'Partition date for storage.',
    `prior_state` STRING COMMENT 'State before this event.',
    `promise_time_timestamp` TIMESTAMP COMMENT 'Promised delivery/ready time.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Last record update.',
    `scheduled_fulfillment_timestamp` TIMESTAMP COMMENT 'Scheduled fulfillment time.',
    `service_channel` STRING COMMENT 'Service channel.',
    `sos_target_seconds` STRING COMMENT 'SOS target in seconds.',
    `third_party_delivery_provider` STRING COMMENT 'Delivery provider.',
    `third_party_event_reference` STRING COMMENT 'Third party event ref.',
    `triggering_actor` STRING COMMENT 'Who triggered the event.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'State transition event in the order lifecycle.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the channel associated with this channel',
    `brand_id` BIGINT COMMENT 'Foreign key relationship added per relation fix.',
    `activation_date` DATE COMMENT 'The date when the channel was activated',
    `average_ticket_time_seconds` STRING COMMENT 'The average ticket time seconds attribute value for this channel record in the order domain',
    `channel_category` STRING COMMENT 'The channel category attribute value for this channel record in the order domain',
    `channel_type` STRING COMMENT 'The classification type for channel in this channel',
    `channel_code` STRING COMMENT 'A standardized code representing the channel classification for this channel',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'The commission rate percent attribute value for this channel record in the order domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this channel record in the order domain',
    `deactivation_date` DATE COMMENT 'The date and time when the deactivation event occurred for this channel',
    `default_daypart` STRING COMMENT 'The default daypart attribute value for this channel record in the order domain',
    `channel_description` STRING COMMENT 'The channel description attribute value for this channel record in the order domain',
    `display_order` STRING COMMENT 'The display order attribute value for this channel record in the order domain',
    `fulfillment_mode` STRING COMMENT 'The fulfillment mode attribute value for this channel record in the order domain',
    `integration_platform` DECIMAL(18,2) COMMENT 'The integration platform attribute value for this channel record in the order domain',
    `is_active` BOOLEAN COMMENT 'Boolean indicator flag for is active status in this channel',
    `is_digital` BOOLEAN COMMENT 'Boolean indicator flag for is digital status in this channel',
    `kds_routing_enabled` BOOLEAN COMMENT 'The kds routing enabled attribute value for this channel record in the order domain',
    `channel_name` STRING COMMENT 'The display name or label for the channel in this channel',
    `requires_restaurant_assignment` BOOLEAN COMMENT 'The requires restaurant assignment attribute value for this channel record in the order domain',
    `supports_guest_data_capture` BOOLEAN COMMENT 'The supports guest data capture attribute value for this channel record in the order domain',
    `supports_loyalty_integration` DECIMAL(18,2) COMMENT 'The supports loyalty integration attribute value for this channel record in the order domain',
    `supports_payment_at_order` DECIMAL(18,2) COMMENT 'The supports payment at order attribute value for this channel record in the order domain',
    `supports_scheduled_orders` BOOLEAN COMMENT 'The supports scheduled orders attribute value for this channel record in the order domain',
    `target_sos_seconds` STRING COMMENT 'The target sos seconds attribute value for this channel record in the order domain',
    `third_party_provider` STRING COMMENT 'The third party provider attribute value for this channel record in the order domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this channel record in the order domain',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Order channel reference (dine-in, drive-thru, OLO, delivery, etc.).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`daypart` (
    `daypart_id` BIGINT COMMENT 'Primary key.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit (VREQ-032).',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator flag for active flag status in this daypart',
    `daypart_code` STRING COMMENT 'Short code for the daypart.',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this daypart record in the order domain',
    `day_of_week` STRING COMMENT 'Day of week this definition applies to.',
    `daypart_description` STRING COMMENT 'Description of the daypart.',
    `effective_end_date` DATE COMMENT 'Date until which this daypart definition is effective.',
    `effective_start_date` DATE COMMENT 'Date from which this daypart definition is effective.',
    `end_time` TIMESTAMP COMMENT 'End time of the daypart window (HH:MM).',
    `is_active` BOOLEAN COMMENT 'Whether daypart is currently active.',
    `daypart_name` STRING COMMENT 'Name of the daypart (e.g., Breakfast, Lunch).',
    `sequence_no` STRING COMMENT 'The sequence no attribute value for this daypart record in the order domain',
    `sequence_number` STRING COMMENT 'The sequence number attribute value for this daypart record in the order domain',
    `sequence_order` STRING COMMENT 'The sequence order attribute value for this daypart record in the order domain',
    `sort_order` STRING COMMENT 'Display sort order.',
    `start_time` TIMESTAMP COMMENT 'Start time of the daypart window (HH:MM).',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_daypart PRIMARY KEY(`daypart_id`)
) COMMENT 'Time-window definition for restaurant operations (breakfast, lunch, dinner, late-night).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` (
    `kds_ticket_id` BIGINT COMMENT 'Unique identifier for the kds ticket associated with this kds ticket',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: kds_ticket.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes KDS performance analytics by time window (e.g., ticket time by daypart, re-fire rates by ',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this kds ticket record',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this kds ticket',
    `kitchen_station_id` BIGINT COMMENT 'Unique identifier for the kitchen station associated with this kds ticket',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Kitchen performance analytics by menu item — tracking SOS breach rates, re-fire counts, and ticket time by menu item — is a standard restaurant operations KPI. Kitchen managers and ops teams need dire',
    `shift_id` BIGINT COMMENT 'Unique identifier for the shift associated with this kds ticket',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this kds ticket',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this kds ticket record in the order domain',
    `item_count` STRING COMMENT 'The count or quantity of item items in this kds ticket',
    `modifier_count` STRING COMMENT 'The count or quantity of modifier items in this kds ticket',
    `order_channel` STRING COMMENT 'The order channel attribute value for this kds ticket record in the order domain',
    `priority_level` STRING COMMENT 'The priority level attribute value for this kds ticket record in the order domain',
    `re_fire_count` STRING COMMENT 'The count or quantity of re fire items in this kds ticket',
    `re_fire_flag` BOOLEAN COMMENT 'Boolean indicator flag for re fire flag status in this kds ticket',
    `re_fire_reason` STRING COMMENT 'The re fire reason attribute value for this kds ticket record in the order domain',
    `sos_met_flag` BOOLEAN COMMENT 'Boolean indicator flag for sos met flag status in this kds ticket',
    `sos_target_seconds` STRING COMMENT 'The sos target seconds attribute value for this kds ticket record in the order domain',
    `special_instructions` STRING COMMENT 'The special instructions attribute value for this kds ticket record in the order domain',
    `ticket_bumped_timestamp` TIMESTAMP COMMENT 'The ticket bumped timestamp attribute value for this kds ticket record in the order domain',
    `ticket_completed_timestamp` TIMESTAMP COMMENT 'The ticket completed timestamp attribute value for this kds ticket record in the order domain',
    `ticket_created_timestamp` TIMESTAMP COMMENT 'The ticket created timestamp attribute value for this kds ticket record in the order domain',
    `ticket_number` STRING COMMENT 'The ticket number attribute value for this kds ticket record in the order domain',
    `ticket_sequence_number` STRING COMMENT 'The ticket sequence number attribute value for this kds ticket record in the order domain',
    `ticket_started_timestamp` TIMESTAMP COMMENT 'The ticket started timestamp attribute value for this kds ticket record in the order domain',
    `ticket_status` STRING COMMENT 'The current status of the ticket for this kds ticket',
    `ticket_time_seconds` STRING COMMENT 'The ticket time seconds attribute value for this kds ticket record in the order domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this kds ticket record in the order domain',
    `void_flag` BOOLEAN COMMENT 'Boolean indicator flag for void flag status in this kds ticket',
    `void_reason` STRING COMMENT 'The void reason attribute value for this kds ticket record in the order domain',
    CONSTRAINT pk_kds_ticket PRIMARY KEY(`kds_ticket_id`)
) COMMENT 'Kitchen display system ticket tracking preparation of an order.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique identifier for the delivery order associated with this delivery order',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this delivery order record',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this delivery order',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level delivery performance metrics (delivery time, customer ratings, exceptions) are used in restaurant operations to evaluate staffing adequacy per shift. This link enables the named shift del',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this delivery order',
    `actual_delivery_time_minutes` STRING COMMENT 'The actual delivery time minutes attribute value for this delivery order record in the order domain',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual delivery timestamp attribute value for this delivery order record in the order domain',
    `actual_prep_time_minutes` STRING COMMENT 'The actual prep time minutes attribute value for this delivery order record in the order domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this delivery order record in the order domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this delivery order',
    `customer_feedback` DECIMAL(18,2) COMMENT 'The customer feedback attribute value for this delivery order record in the order domain',
    `customer_rating` STRING COMMENT 'The customer rating attribute value for this delivery order record in the order domain',
    `delivery_address_line1` STRING COMMENT 'The delivery address line1 attribute value for this delivery order record in the order domain',
    `delivery_address_line2` STRING COMMENT 'The delivery address line2 attribute value for this delivery order record in the order domain',
    `delivery_city` STRING COMMENT 'The delivery city attribute value for this delivery order record in the order domain',
    `delivery_country_code` STRING COMMENT 'A standardized code representing the delivery country classification for this delivery order',
    `delivery_distance_km` DECIMAL(18,2) COMMENT 'The delivery distance km attribute value for this delivery order record in the order domain',
    `delivery_exception_type` STRING COMMENT 'The classification type for delivery exception in this delivery order',
    `delivery_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for delivery fee in this delivery order',
    `delivery_instructions` STRING COMMENT 'The delivery instructions attribute value for this delivery order record in the order domain',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'The delivery latitude attribute value for this delivery order record in the order domain',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'The delivery longitude attribute value for this delivery order record in the order domain',
    `delivery_postal_code` STRING COMMENT 'A standardized code representing the delivery postal classification for this delivery order',
    `delivery_state_province` STRING COMMENT 'The delivery state province attribute value for this delivery order record in the order domain',
    `delivery_status` STRING COMMENT 'The current status of the delivery for this delivery order',
    `estimated_delivery_time_minutes` STRING COMMENT 'The estimated delivery time minutes attribute value for this delivery order record in the order domain',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'The estimated delivery timestamp attribute value for this delivery order record in the order domain',
    `estimated_prep_time_minutes` STRING COMMENT 'The estimated prep time minutes attribute value for this delivery order record in the order domain',
    `exception_notes` STRING COMMENT 'The exception notes attribute value for this delivery order record in the order domain',
    `is_contactless_delivery` BOOLEAN COMMENT 'Boolean indicator flag for is contactless delivery status in this delivery order',
    `order_confirmed_timestamp` TIMESTAMP COMMENT 'The order confirmed timestamp attribute value for this delivery order record in the order domain',
    `order_placed_timestamp` TIMESTAMP COMMENT 'The order placed timestamp attribute value for this delivery order record in the order domain',
    `picked_up_timestamp` TIMESTAMP COMMENT 'The picked up timestamp attribute value for this delivery order record in the order domain',
    `platform_commission_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for platform commission in this delivery order',
    `platform_commission_rate` DECIMAL(18,2) COMMENT 'The platform commission rate attribute value for this delivery order record in the order domain',
    `platform_order_reference` STRING COMMENT 'The platform order reference attribute value for this delivery order record in the order domain',
    `proof_of_delivery_url` STRING COMMENT 'The URL link to the proof of delivery resource associated with this delivery order',
    `ready_for_pickup_timestamp` TIMESTAMP COMMENT 'The ready for pickup timestamp attribute value for this delivery order record in the order domain',
    `tip_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tip in this delivery order',
    `total_ticket_time_minutes` DECIMAL(18,2) COMMENT 'The total ticket time minutes attribute value for this delivery order record in the order domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this delivery order record in the order domain',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Delivery-specific details for an order fulfilled via delivery.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`discount` (
    `discount_id` BIGINT COMMENT 'Unique identifier for the discount associated with this discount',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the authorization employee associated with this discount record',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this discount',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this discount',
    `offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer. Business justification: Offer-driven discount attribution: discounts applied at POS or digital channels are frequently triggered by loyalty offers. This FK enables offer performance reporting, marketing cost attribution, and',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the pos terminal associated with this discount',
    `profile_id` BIGINT COMMENT 'Unique identifier for the profile associated with this discount',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.guest_segment. Business justification: Segment-targeted promotions (e.g., loyalty gold tier gets 20% off) are a core restaurant marketing operation. Linking applied discounts to the guest segment that qualified the guest enables marketin',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level discount and comp reporting is a named loss-prevention process in restaurant operations. Managers review all discounts applied during their shift; this link enables the shift discount sum',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this discount',
    `amount` DECIMAL(18,2) COMMENT 'The amount attribute value for this discount record in the order domain',
    `applied_at` TIMESTAMP COMMENT 'The date and time when the applied event occurred for this discount',
    `authorization_required` BOOLEAN COMMENT 'The authorization required attribute value for this discount record in the order domain',
    `channel_restriction` STRING COMMENT 'The channel restriction attribute value for this discount record in the order domain',
    `discount_code` DECIMAL(18,2) COMMENT 'A standardized code representing the discount classification for this discount',
    `cogs_impact_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cogs impact in this discount',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this discount',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this discount',
    `daypart_restriction` STRING COMMENT 'The daypart restriction attribute value for this discount record in the order domain',
    `discount_type` DECIMAL(18,2) COMMENT 'The classification type for discount in this discount',
    `final_price` DECIMAL(18,2) COMMENT 'The final price attribute value for this discount record in the order domain',
    `is_pre_approved` BOOLEAN COMMENT 'Boolean indicator flag for is pre approved status in this discount',
    `is_stackable` BOOLEAN COMMENT 'Boolean indicator flag for is stackable status in this discount',
    `is_voided` BOOLEAN COMMENT 'Boolean indicator flag for is voided status in this discount',
    `loyalty_points_redeemed` STRING COMMENT 'The loyalty points redeemed attribute value for this discount record in the order domain',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for max discount in this discount',
    `min_purchase_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for min purchase in this discount',
    `discount_name` DECIMAL(18,2) COMMENT 'The display name or label for the discount in this discount',
    `original_price` DECIMAL(18,2) COMMENT 'The original price attribute value for this discount record in the order domain',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage attribute value for this discount record in the order domain',
    `reason` STRING COMMENT 'The reason attribute value for this discount record in the order domain',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for revenue impact in this discount',
    `scope` DECIMAL(18,2) COMMENT 'The scope attribute value for this discount record in the order domain',
    `tax_treatment` DECIMAL(18,2) COMMENT 'The tax treatment attribute value for this discount record in the order domain',
    `updated_at` TIMESTAMP COMMENT 'The date and time when the updated event occurred for this discount',
    `valid_from_date` DATE COMMENT 'The date and time when the valid from event occurred for this discount',
    `valid_to_date` DATE COMMENT 'The date and time when the valid to event occurred for this discount',
    `void_reason` STRING COMMENT 'The void reason attribute value for this discount record in the order domain',
    `voided_at` TIMESTAMP COMMENT 'The date and time when the voided event occurred for this discount',
    CONSTRAINT pk_discount PRIMARY KEY(`discount_id`)
) COMMENT 'Discount applied to an order or order item.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund associated with this refund',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: refund.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes refund analytics by time window (e.g., refund rates by daypart, fraud patterns by time of day',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this refund',
    `offer_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer_redemption. Business justification: Offer redemption reversal on refund: when a refund is issued on an order where a loyalty offer was redeemed, the refund must reference the offer_redemption to void the offer benefit and restore redemp',
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the pos terminal associated with this refund',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the primary refund employee associated with this refund record',
    `profile_id` BIGINT COMMENT 'Unique identifier for the refund profile associated with this refund',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Redemption reversal on refund: when a refund is issued on an order where loyalty points were redeemed, the refund must reference the original redemption to trigger points restoration. This FK is essen',
    `refund_employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this refund record',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level refund reporting is a standard loss-prevention and manager accountability process in restaurants. Operations managers review refunds issued during their shift; this link enables the named ',
    `tertiary_refund_voided_by_employee_id` BIGINT COMMENT 'Unique identifier referencing the tertiary refund voided by employee associated with this refund record',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this refund',
    `amount` DECIMAL(18,2) COMMENT 'The amount attribute value for this refund record in the order domain',
    `approved_at` TIMESTAMP COMMENT 'The date and time when the approved event occurred for this refund',
    `batch_code` STRING COMMENT 'A standardized code representing the batch classification for this refund',
    `channel` STRING COMMENT 'The channel attribute value for this refund record in the order domain',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this refund',
    `csat_impact_flag` BOOLEAN COMMENT 'Boolean indicator flag for csat impact flag status in this refund',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this refund',
    `fraud_review_notes` STRING COMMENT 'The fraud review notes attribute value for this refund record in the order domain',
    `gl_posting_date` DATE COMMENT 'The date and time when the gl posting event occurred for this refund',
    `guest_contact_method` STRING COMMENT 'The guest contact method attribute value for this refund record in the order domain',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean indicator flag for is fraudulent status in this refund',
    `is_voided` BOOLEAN COMMENT 'Boolean indicator flag for is voided status in this refund',
    `loyalty_points_refunded` DECIMAL(18,2) COMMENT 'The loyalty points refunded attribute value for this refund record in the order domain',
    `method` DECIMAL(18,2) COMMENT 'The method attribute value for this refund record in the order domain',
    `nps_survey_sent` BOOLEAN COMMENT 'The nps survey sent attribute value for this refund record in the order domain',
    `order_channel` STRING COMMENT 'The order channel attribute value for this refund record in the order domain',
    `original_payment_method` DECIMAL(18,2) COMMENT 'The original payment method attribute value for this refund record in the order domain',
    `payment_processor_ref` DECIMAL(18,2) COMMENT 'The payment processor ref attribute value for this refund record in the order domain',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification for this refund',
    `reason_description` STRING COMMENT 'The reason description attribute value for this refund record in the order domain',
    `refund_number` DECIMAL(18,2) COMMENT 'The refund number attribute value for this refund record in the order domain',
    `refund_status` DECIMAL(18,2) COMMENT 'The current status of the refund for this refund',
    `refund_type` DECIMAL(18,2) COMMENT 'The classification type for refund in this refund',
    `refunded_at` TIMESTAMP COMMENT 'The date and time when the refunded event occurred for this refund',
    `requested_at` TIMESTAMP COMMENT 'The date and time when the requested event occurred for this refund',
    `subtotal` DECIMAL(18,2) COMMENT 'The subtotal attribute value for this refund record in the order domain',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this refund',
    `third_party_delivery_provider` STRING COMMENT 'The third party delivery provider attribute value for this refund record in the order domain',
    `updated_at` TIMESTAMP COMMENT 'The date and time when the updated event occurred for this refund',
    `void_reason` STRING COMMENT 'The void reason attribute value for this refund record in the order domain',
    `voided_at` TIMESTAMP COMMENT 'The date and time when the voided event occurred for this refund',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Refund issued against a guest order.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`order`.`tax` (
    `tax_id` BIGINT COMMENT 'Unique identifier for the tax associated with this tax',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax exemption overrides and adjustments in restaurant POS require manager/employee authorization. Compliance audits and tax reconciliation reports require knowing which employee applied a tax exemptio',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to order.daypart. Business justification: tax.daypart is a denormalized STRING referencing the daypart dimension. Adding daypart_id FK normalizes tax line analytics by time window, supporting remittance period analysis and tax reporting by op',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this tax',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this tax',
    `adjusted_timestamp` TIMESTAMP COMMENT 'The adjusted timestamp attribute value for this tax record in the order domain',
    `adjustment_reason` STRING COMMENT 'The adjustment reason attribute value for this tax record in the order domain',
    `amount` DECIMAL(18,2) COMMENT 'The amount attribute value for this tax record in the order domain',
    `applied_timestamp` TIMESTAMP COMMENT 'The applied timestamp attribute value for this tax record in the order domain',
    `authority_code` STRING COMMENT 'A standardized code representing the authority classification for this tax',
    `authority_level` STRING COMMENT 'The authority level attribute value for this tax record in the order domain',
    `authority_name` STRING COMMENT 'The display name or label for the authority in this tax',
    `tax_code` DECIMAL(18,2) COMMENT 'A standardized code representing the tax classification for this tax',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification for this tax',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this tax',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this tax record in the order domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this tax',
    `engine_source` STRING COMMENT 'The engine source attribute value for this tax record in the order domain',
    `exemption_certificate_ref` STRING COMMENT 'The exemption certificate ref attribute value for this tax record in the order domain',
    `exemption_reason` STRING COMMENT 'The exemption reason attribute value for this tax record in the order domain',
    `is_exempt` BOOLEAN COMMENT 'Boolean indicator flag for is exempt status in this tax',
    `is_refunded` BOOLEAN COMMENT 'Boolean indicator flag for is refunded status in this tax',
    `is_tax_inclusive` BOOLEAN COMMENT 'Boolean indicator flag for is tax inclusive status in this tax',
    `line_sequence` STRING COMMENT 'The line sequence attribute value for this tax record in the order domain',
    `tax_name` DECIMAL(18,2) COMMENT 'The display name or label for the tax in this tax',
    `order_channel` STRING COMMENT 'The order channel attribute value for this tax record in the order domain',
    `original_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for original tax in this tax',
    `period_date` DATE COMMENT 'The date and time when the period event occurred for this tax',
    `pos_tax_line_ref` DECIMAL(18,2) COMMENT 'The pos tax line ref attribute value for this tax record in the order domain',
    `rate` DECIMAL(18,2) COMMENT 'The rate attribute value for this tax record in the order domain',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for refund in this tax',
    `remittance_period` STRING COMMENT 'The remittance period attribute value for this tax record in the order domain',
    `remittance_status` STRING COMMENT 'The current status of the remittance for this tax',
    `sap_tax_document_ref` DECIMAL(18,2) COMMENT 'The sap tax document ref attribute value for this tax record in the order domain',
    `state_code` STRING COMMENT 'A standardized code representing the state classification for this tax',
    `tax_status` DECIMAL(18,2) COMMENT 'The current status of the tax for this tax',
    `tax_type` DECIMAL(18,2) COMMENT 'The classification type for tax in this tax',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for taxable in this tax',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this tax record in the order domain',
    `voided_timestamp` TIMESTAMP COMMENT 'The voided timestamp attribute value for this tax record in the order domain',
    CONSTRAINT pk_tax PRIMARY KEY(`tax_id`)
) COMMENT 'Tax line applied to a guest order.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `vibe_restaurants_v1`.`order`.`discount`(`discount_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `vibe_restaurants_v1`.`order`.`refund`(`refund_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_source_status_event_id` FOREIGN KEY (`source_status_event_id`) REFERENCES `vibe_restaurants_v1`.`order`.`status_event`(`status_event_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` SET TAGS ('dbx_subdomain' = 'order_transactions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `cancelled_at` SET TAGS ('dbx_business_glossary_term' = 'Cancelled At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Delivery Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `fulfilled_at` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Is LTO');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `kds_routed_at` SET TAGS ('dbx_business_glossary_term' = 'KDS Routed At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `olo_order_ref` SET TAGS ('dbx_business_glossary_term' = 'OLO Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `party_size` SET TAGS ('dbx_business_glossary_term' = 'Party Size');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `placed_at` SET TAGS ('dbx_business_glossary_term' = 'Placed At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `pos_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ready_at` SET TAGS ('dbx_business_glossary_term' = 'Ready At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `sos_seconds` SET TAGS ('dbx_business_glossary_term' = 'SOS Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` SET TAGS ('dbx_subdomain' = 'order_transactions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `item_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Item Cost Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `item_price_id` SET TAGS ('dbx_business_glossary_term' = 'Item Price Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'KDS Station ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `menu_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `nutrition_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `allergen_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Override Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `calorie_count` SET TAGS ('dbx_business_glossary_term' = 'Calorie Count');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Cost');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `is_combo_component` SET TAGS ('dbx_business_glossary_term' = 'Is Combo Component');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Is LTO');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kds_bump_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KDS Bump Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `kds_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KDS Sent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `modifier_price` SET TAGS ('dbx_business_glossary_term' = 'Modifier Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `pmix_category` SET TAGS ('dbx_business_glossary_term' = 'PMIX Category');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promo Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `source_system_item_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Item Ref');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` SET TAGS ('dbx_subdomain' = 'order_transactions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Order Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_group_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier Group ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `menu_modifier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Menu Modifier ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `allergen_notes` SET TAGS ('dbx_business_glossary_term' = 'Allergen Notes');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `calorie_delta` SET TAGS ('dbx_business_glossary_term' = 'Calorie Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `cogs_delta` SET TAGS ('dbx_business_glossary_term' = 'COGS Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `initiation_source` SET TAGS ('dbx_business_glossary_term' = 'Initiation Source');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_comped` SET TAGS ('dbx_business_glossary_term' = 'Is Comped');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kds_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KDS Acknowledged Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `kds_routed` SET TAGS ('dbx_business_glossary_term' = 'KDS Routed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `loyalty_redemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Redemption Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `lto_flag` SET TAGS ('dbx_business_glossary_term' = 'LTO Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_name` SET TAGS ('dbx_business_glossary_term' = 'Modifier Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_status` SET TAGS ('dbx_business_glossary_term' = 'Modifier Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `modifier_type` SET TAGS ('dbx_business_glossary_term' = 'Modifier Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `olo_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'OLO Modifier Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `pos_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'POS Modifier Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `prep_instruction` SET TAGS ('dbx_business_glossary_term' = 'Prep Instruction');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `price_delta` SET TAGS ('dbx_business_glossary_term' = 'Price Delta');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `captured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Captured Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Method');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `change_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Due Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number Masked');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `gift_card_number_masked` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `is_split_tender` SET TAGS ('dbx_business_glossary_term' = 'Is Split Tender');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Card Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `offline_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Offline Authorization Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `pos_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Number');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Processor Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `processor_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Reference Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `promo_code_applied` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Applied');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `settlement_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `split_tender_sequence` SET TAGS ('dbx_business_glossary_term' = 'Split Tender Sequence');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tendered_amount` SET TAGS ('dbx_business_glossary_term' = 'Tendered Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `third_party_delivery_partner` SET TAGS ('dbx_business_glossary_term' = 'Third Party Delivery Partner');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `third_party_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Third Party Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Token');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` SET TAGS ('dbx_subdomain' = 'order_transactions');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Status Event ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kds Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `source_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Source Event ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `cumulative_elapsed_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Elapsed Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `current_state` SET TAGS ('dbx_business_glossary_term' = 'Current State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `current_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `delivery_zone` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `drive_thru_lane` SET TAGS ('dbx_business_glossary_term' = 'Drive Thru Lane');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `elapsed_seconds_in_prior_state` SET TAGS ('dbx_business_glossary_term' = 'Elapsed Seconds In Prior State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `elapsed_seconds_in_prior_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_sequence` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `fulfillment_mode` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Mode');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_cancellation_event` SET TAGS ('dbx_business_glossary_term' = 'Is Cancellation Event');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_sos_breach` SET TAGS ('dbx_business_glossary_term' = 'Is SOS Breach');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_terminal_state` SET TAGS ('dbx_business_glossary_term' = 'Is Terminal State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_terminal_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `is_void_event` SET TAGS ('dbx_business_glossary_term' = 'Is Void Event');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `manager_override` SET TAGS ('dbx_business_glossary_term' = 'Manager Override');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `olo_order_reference` SET TAGS ('dbx_business_glossary_term' = 'OLO Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `partition_date` SET TAGS ('dbx_business_glossary_term' = 'Partition Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `prior_state` SET TAGS ('dbx_business_glossary_term' = 'Prior State');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `prior_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `promise_time_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promise Time Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `scheduled_fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fulfillment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'SOS Target Seconds');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `third_party_delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Third Party Delivery Provider');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `third_party_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Third Party Event Reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ALTER COLUMN `triggering_actor` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` SET TAGS ('dbx_subdomain' = 'fulfillment_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` SET TAGS ('dbx_subdomain' = 'fulfillment_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_business_glossary_term' = 'Daypart Name');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `daypart_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` SET TAGS ('dbx_subdomain' = 'fulfillment_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` SET TAGS ('dbx_subdomain' = 'fulfillment_reference');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `discount_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `refund_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tertiary_refund_voided_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `tertiary_refund_voided_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `authority_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `tax_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_detected' = 'true');
