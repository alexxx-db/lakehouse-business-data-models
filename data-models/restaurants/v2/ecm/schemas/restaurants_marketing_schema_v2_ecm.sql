-- Schema for Domain: marketing | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`marketing` COMMENT 'Manages promotional campaign planning, LTO execution, advertising spend, media channel performance (digital, social, traditional), brand positioning, local store marketing, guest segmentation, and campaign ROI measurement. Drives traffic, average daily transactions (ADT), and comparable store sales (comp sales) lift.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `food_recall_id` BIGINT COMMENT 'FK to food recall event',
    `guest_segment_id` BIGINT COMMENT 'FK to guest segment',
    `ingredient_id` BIGINT COMMENT 'FK to supply ingredient',
    `employee_id` BIGINT COMMENT 'FK to campaign owner employee',
    `supply_supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `territory_id` BIGINT COMMENT 'FK to franchise territory',
    `trade_area_id` BIGINT COMMENT 'FK to real estate trade area',
    `actual_adt_lift_pct` DECIMAL(18,2) COMMENT 'Actual average daily transaction lift percentage',
    `actual_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Actual comparable sales lift percentage',
    `actual_end_date` DATE COMMENT 'Actual campaign end date',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual total spend amount',
    `actual_start_date` DATE COMMENT 'Actual campaign start date',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for campaign',
    `campaign_status` STRING COMMENT 'Current lifecycle status of campaign',
    `campaign_type` STRING COMMENT 'Type classification of campaign',
    `channel_mix` STRING COMMENT 'Channels used in campaign',
    `campaign_code` STRING COMMENT 'Unique business code for campaign',
    `compliance_flag` BOOLEAN COMMENT 'Whether campaign is compliant with brand standards',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `campaign_description` STRING COMMENT 'Detailed description of campaign',
    `expected_adt_lift_pct` DECIMAL(18,2) COMMENT 'Expected average daily transaction lift percentage',
    `expected_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Expected comparable sales lift percentage',
    `is_lto` BOOLEAN COMMENT 'Whether campaign is for a limited time offer',
    `is_test_campaign` BOOLEAN COMMENT 'Whether this is a test campaign',
    `lto_end_date` DATE COMMENT 'LTO end date if applicable',
    `lto_start_date` DATE COMMENT 'LTO start date if applicable',
    `campaign_name` STRING COMMENT 'Name of the marketing campaign',
    `notes` STRING COMMENT 'Free-text notes',
    `objective` STRING COMMENT 'Campaign objective statement',
    `objective_metric` STRING COMMENT 'KPI metric for objective measurement',
    `owning_brand` STRING COMMENT 'Brand that owns the campaign',
    `planned_end_date` DATE COMMENT 'Planned campaign end date',
    `planned_start_date` DATE COMMENT 'Planned campaign start date',
    `target_daypart` STRING COMMENT 'Target daypart for campaign',
    `target_geography` STRING COMMENT 'Target geographic area',
    `target_market` STRING COMMENT 'Target market segment',
    `target_store_count` STRING COMMENT 'Number of stores targeted',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Marketing campaign master record tracking objectives, budgets, timelines, and performance metrics for brand and franchise campaigns.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Primary key',
    `agreement_id` BIGINT COMMENT 'FK to franchise agreement',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee (alternate)',
    `campaign_id` BIGINT COMMENT 'FK to parent campaign',
    `employee_id` BIGINT COMMENT 'FK to execution owner',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'The actual adt lift percent attribute value for this campaign execution record in the marketing domain',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'The actual comp sales lift percent attribute value for this campaign execution record in the marketing domain',
    `actual_end_date` DATE COMMENT 'Actual execution end date',
    `actual_launch_date` DATE COMMENT 'The date and time when the actual launch event occurred for this campaign execution',
    `campaign_execution_status` STRING COMMENT 'Status of execution',
    `channel_spend_amount` DECIMAL(18,2) COMMENT 'Spend amount for channel',
    `clicks` STRING COMMENT 'Number of clicks',
    `conversions` STRING COMMENT 'Number of conversions',
    `cost_per_click` DECIMAL(18,2) COMMENT 'The cost per click attribute value for this campaign execution record in the marketing domain',
    `cost_per_impression` DECIMAL(18,2) COMMENT 'The cost per impression attribute value for this campaign execution record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `creative_version` STRING COMMENT 'Creative version used',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this campaign execution',
    `deviation_reason` STRING COMMENT 'Reason for deviation from plan',
    `execution_channel` STRING COMMENT 'Channel of execution',
    `execution_code` STRING COMMENT 'Unique execution code',
    `execution_owner` STRING COMMENT 'Name of execution owner',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp of execution',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'The expected adt lift percent attribute value for this campaign execution record in the marketing domain',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'The expected comp sales lift percent attribute value for this campaign execution record in the marketing domain',
    `impressions` STRING COMMENT 'Number of impressions',
    `launch_date` DATE COMMENT 'Planned launch date',
    `market_dma` STRING COMMENT 'Designated market area',
    `media_vendor` STRING COMMENT 'Media vendor name',
    `notes` STRING COMMENT 'Free-text notes',
    `planned_end_date` DATE COMMENT 'The date and time when the planned end event occurred for this campaign execution',
    `restaurant_scope` STRING COMMENT 'Scope of restaurants included',
    `roi_percent` DECIMAL(18,2) COMMENT 'ROI percentage',
    `target_audience` STRING COMMENT 'Target audience description',
    `target_segment` STRING COMMENT 'The target segment attribute value for this campaign execution record in the marketing domain',
    `tracking_url` STRING COMMENT 'Tracking URL for digital',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Execution-level detail for a campaign at a specific unit or market, tracking channel performance and deviations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` (
    `marketing_lto_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to parent campaign',
    `actual_units` STRING COMMENT 'Actual units sold',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `marketing_lto_description` STRING COMMENT 'LTO description',
    `end_date` DATE COMMENT 'LTO end date',
    `featured_item` STRING COMMENT 'Primary featured item',
    `featured_items` STRING COMMENT 'Featured menu items',
    `is_active` BOOLEAN COMMENT 'Whether LTO is currently active',
    `lto_code` STRING COMMENT 'Unique LTO code',
    `lto_description` STRING COMMENT 'Detailed LTO description',
    `lto_name` STRING COMMENT 'Name of the LTO',
    `lto_status` STRING COMMENT 'LTO lifecycle status',
    `projected_lift_percent` DECIMAL(18,2) COMMENT 'The projected lift percent attribute value for this marketing lto record in the marketing domain',
    `projected_units` STRING COMMENT 'Projected units to sell',
    `promo_price` DECIMAL(18,2) COMMENT 'Promotional price',
    `promotional_price` DECIMAL(18,2) COMMENT 'Promotional price point',
    `start_date` DATE COMMENT 'LTO start date',
    `marketing_lto_status` STRING COMMENT 'Current status',
    `target_lift_pct` DECIMAL(18,2) COMMENT 'Target lift percentage',
    `target_lift_percent` DECIMAL(18,2) COMMENT 'Target sales lift percent',
    `target_revenue` DECIMAL(18,2) COMMENT 'The target revenue attribute value for this marketing lto record in the marketing domain',
    `target_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for target sales in this marketing lto',
    `target_sales_lift` STRING COMMENT 'Target sales lift description',
    `target_units` STRING COMMENT 'The target units attribute value for this marketing lto record in the marketing domain',
    `target_units_sold` STRING COMMENT 'The target units sold attribute value for this marketing lto record in the marketing domain',
    `updated_at` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_marketing_lto PRIMARY KEY(`marketing_lto_id`)
) COMMENT 'Limited time offer marketing details including pricing, targets, and actual performance metrics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `agency_name` STRING COMMENT 'Media agency name',
    `approval_status` STRING COMMENT 'The current status of the approval for this media plan',
    `brand_name` STRING COMMENT 'The display name or label for the brand in this media plan',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this media plan',
    `daypart_target` STRING COMMENT 'Target daypart',
    `digital_spend` DECIMAL(18,2) COMMENT 'Digital channel spend',
    `effective_from` DATE COMMENT 'Plan effective from date',
    `effective_until` DATE COMMENT 'Plan effective until date',
    `frequency_target` STRING COMMENT 'Target frequency',
    `is_active` BOOLEAN COMMENT 'Whether plan is active',
    `lifecycle_status` STRING COMMENT 'The current status of the lifecycle for this media plan',
    `ooh_spend` DECIMAL(18,2) COMMENT 'Out-of-home spend',
    `plan_code` STRING COMMENT 'Unique plan code',
    `plan_description` STRING COMMENT 'The plan description attribute value for this media plan record in the marketing domain',
    `plan_name` STRING COMMENT 'The display name or label for the plan in this media plan',
    `plan_type` STRING COMMENT 'Type of media plan',
    `print_spend` DECIMAL(18,2) COMMENT 'Print channel spend',
    `radio_spend` DECIMAL(18,2) COMMENT 'Radio channel spend',
    `reach_target` BIGINT COMMENT 'Target reach',
    `social_spend` DECIMAL(18,2) COMMENT 'Social media spend',
    `target_dma` STRING COMMENT 'The target dma attribute value for this media plan record in the marketing domain',
    `total_planned_spend` DECIMAL(18,2) COMMENT 'The total planned spend attribute value for this media plan record in the marketing domain',
    `tv_spend` DECIMAL(18,2) COMMENT 'TV channel spend',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Media planning document detailing channel allocation, spend budgets, reach/frequency targets, and approval workflow.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` (
    `media_buy_id` BIGINT COMMENT 'Primary key',
    `ad_creative_id` BIGINT COMMENT 'FK to ad creative',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `media_channel_id` BIGINT COMMENT 'FK to media channel',
    `media_plan_id` BIGINT COMMENT 'FK to media plan',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier',
    `media_vendor_procurement_supplier_id` BIGINT COMMENT 'FK to vendor supplier',
    `actual_cpm` DECIMAL(18,2) COMMENT 'Actual cost per mille',
    `actual_grps` DECIMAL(18,2) COMMENT 'Actual gross rating points',
    `actual_impressions` BIGINT COMMENT 'Actual impressions delivered',
    `ad_format` STRING COMMENT 'The ad format attribute value for this media buy record in the marketing domain',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for adjustment in this media buy',
    `agency_name` STRING COMMENT 'The display name or label for the agency in this media buy',
    `audience_segment` STRING COMMENT 'Audience segment targeted',
    `budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for budget in this media buy',
    `buy_number` STRING COMMENT 'Buy reference number',
    `buy_timestamp` TIMESTAMP COMMENT 'Timestamp of buy',
    `contract_end_date` DATE COMMENT 'The date and time when the contract end event occurred for this media buy',
    `contract_start_date` DATE COMMENT 'The date and time when the contract start event occurred for this media buy',
    `contracted_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for contracted in this media buy',
    `contracted_grps` DECIMAL(18,2) COMMENT 'The contracted grps attribute value for this media buy record in the marketing domain',
    `contracted_impressions` BIGINT COMMENT 'The contracted impressions attribute value for this media buy record in the marketing domain',
    `cpm_rate` DECIMAL(18,2) COMMENT 'The cpm rate attribute value for this media buy record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this media buy',
    `flight_end_date` DATE COMMENT 'The date and time when the flight end event occurred for this media buy',
    `flight_start_date` DATE COMMENT 'The date and time when the flight start event occurred for this media buy',
    `invoice_number` STRING COMMENT 'The invoice number attribute value for this media buy record in the marketing domain',
    `is_programmatic` BOOLEAN COMMENT 'Whether buy is programmatic',
    `market_dma` STRING COMMENT 'The market dma attribute value for this media buy record in the marketing domain',
    `media_buy_status` STRING COMMENT 'Status of media buy',
    `net_spend` DECIMAL(18,2) COMMENT 'Net spend amount',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status of the payment for this media buy',
    `placement_name` STRING COMMENT 'The display name or label for the placement in this media buy',
    `placement_size` STRING COMMENT 'The placement size attribute value for this media buy record in the marketing domain',
    `publisher_name` STRING COMMENT 'The display name or label for the publisher in this media buy',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this media buy',
    `targeting_criteria` STRING COMMENT 'The targeting criteria attribute value for this media buy record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_media_buy PRIMARY KEY(`media_buy_id`)
) COMMENT 'Individual media purchase record with contracted impressions, spend, flight dates, and reconciliation status.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` (
    `media_channel_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `active_status` STRING COMMENT 'The current status of the active for this media channel',
    `average_cpm` DECIMAL(18,2) COMMENT 'The average cpm attribute value for this media channel record in the marketing domain',
    `media_channel_category` STRING COMMENT 'Channel category',
    `channel_code` STRING COMMENT 'A standardized code representing the channel classification for this media channel',
    `channel_group` STRING COMMENT 'The channel group attribute value for this media channel record in the marketing domain',
    `channel_owner` STRING COMMENT 'The channel owner attribute value for this media channel record in the marketing domain',
    `compliance_notes` STRING COMMENT 'The compliance notes attribute value for this media channel record in the marketing domain',
    `cost_model` DECIMAL(18,2) COMMENT 'Cost model value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this media channel',
    `data_source_system` STRING COMMENT 'The data source system attribute value for this media channel record in the marketing domain',
    `media_channel_description` STRING COMMENT 'Channel description',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this media channel',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this media channel',
    `geographic_scope` STRING COMMENT 'The geographic scope attribute value for this media channel record in the marketing domain',
    `is_programmatic` BOOLEAN COMMENT 'Whether channel supports programmatic',
    `last_audit_date` DATE COMMENT 'The date and time when the last audit event occurred for this media channel',
    `measurement_methodology` STRING COMMENT 'The measurement methodology attribute value for this media channel record in the marketing domain',
    `media_channel_name` STRING COMMENT 'Channel name',
    `platform` STRING COMMENT 'The platform attribute value for this media channel record in the marketing domain',
    `primary_audience` STRING COMMENT 'The primary audience attribute value for this media channel record in the marketing domain',
    `sub_category` STRING COMMENT 'Sub-category',
    `targeting_capabilities` STRING COMMENT 'The targeting capabilities attribute value for this media channel record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_media_channel PRIMARY KEY(`media_channel_id`)
) COMMENT 'Reference table of media channels (TV, radio, digital, OOH, etc.) with cost models and targeting capabilities.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` (
    `ad_creative_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to primary campaign',
    `ad_creative_status` STRING COMMENT 'Creative status',
    `ad_format_specifications` STRING COMMENT 'Format specifications',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `archive_date` DATE COMMENT 'The date and time when the archive event occurred for this ad creative',
    `asset_url` STRING COMMENT 'The URL link to the asset resource associated with this ad creative',
    `brand_compliance_status` STRING COMMENT 'The current status of the brand compliance for this ad creative',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The budget allocated attribute value for this ad creative record in the marketing domain',
    `call_to_action_text` STRING COMMENT 'The call to action text attribute value for this ad creative record in the marketing domain',
    `channel_suitability` STRING COMMENT 'The channel suitability attribute value for this ad creative record in the marketing domain',
    `compliance_review_date` DATE COMMENT 'The date and time when the compliance review event occurred for this ad creative',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `creative_category` STRING COMMENT 'The creative category attribute value for this ad creative record in the marketing domain',
    `creative_code` STRING COMMENT 'Unique creative code',
    `creative_description` STRING COMMENT 'The creative description attribute value for this ad creative record in the marketing domain',
    `creative_name` STRING COMMENT 'The display name or label for the creative in this ad creative',
    `creative_owner` STRING COMMENT 'The creative owner attribute value for this ad creative record in the marketing domain',
    `creative_subcategory` STRING COMMENT 'The creative subcategory attribute value for this ad creative record in the marketing domain',
    `creative_tags` STRING COMMENT 'The creative tags attribute value for this ad creative record in the marketing domain',
    `creative_type` STRING COMMENT 'The classification type for creative in this ad creative',
    `dam_reference_code` STRING COMMENT 'A standardized code representing the dam reference classification for this ad creative',
    `dimensions` STRING COMMENT 'The dimensions attribute value for this ad creative record in the marketing domain',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds',
    `expiry_timestamp` TIMESTAMP COMMENT 'The expiry timestamp attribute value for this ad creative record in the marketing domain',
    `file_format` STRING COMMENT 'The file format attribute value for this ad creative record in the marketing domain',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes',
    `is_archived` BOOLEAN COMMENT 'Whether creative is archived',
    `is_dynamic` BOOLEAN COMMENT 'Whether creative is dynamic',
    `language` STRING COMMENT 'The language attribute value for this ad creative record in the marketing domain',
    `last_used_timestamp` TIMESTAMP COMMENT 'The last used timestamp attribute value for this ad creative record in the marketing domain',
    `legal_approval_status` STRING COMMENT 'The current status of the legal approval for this ad creative',
    `legal_review_date` DATE COMMENT 'The date and time when the legal review event occurred for this ad creative',
    `notes` STRING COMMENT 'Free-text notes',
    `production_cost` DECIMAL(18,2) COMMENT 'The production cost attribute value for this ad creative record in the marketing domain',
    `roi_estimate` DECIMAL(18,2) COMMENT 'The roi estimate attribute value for this ad creative record in the marketing domain',
    `target_audience` STRING COMMENT 'The target audience attribute value for this ad creative record in the marketing domain',
    `target_market` STRING COMMENT 'The target market attribute value for this ad creative record in the marketing domain',
    `tracking_pixel_url` STRING COMMENT 'The URL link to the tracking pixel resource associated with this ad creative',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `usage_rights` STRING COMMENT 'The usage rights attribute value for this ad creative record in the marketing domain',
    `version_number` STRING COMMENT 'The version number attribute value for this ad creative record in the marketing domain',
    CONSTRAINT pk_ad_creative PRIMARY KEY(`ad_creative_id`)
) COMMENT 'Creative asset record for advertisements including format, compliance status, production cost, and digital asset management references.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `food_safety_audit_id` BIGINT COMMENT 'FK to food safety audit',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `item_category_id` BIGINT COMMENT 'FK to item category',
    `site_id` BIGINT COMMENT 'FK to site',
    `supply_supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `applicable_channels` STRING COMMENT 'The applicable channels attribute value for this promotion record in the marketing domain',
    `promotion_code` STRING COMMENT 'Unique promotion code',
    `promotion_description` STRING COMMENT 'The promotion description attribute value for this promotion record in the marketing domain',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this promotion',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The discount percentage attribute value for this promotion record in the marketing domain',
    `eligibility_criteria` STRING COMMENT 'The eligibility criteria attribute value for this promotion record in the marketing domain',
    `eligible_guest_segments` STRING COMMENT 'The eligible guest segments attribute value for this promotion record in the marketing domain',
    `end_date` DATE COMMENT 'Promotion end date',
    `is_exclusive` BOOLEAN COMMENT 'Whether promotion is exclusive',
    `is_stackable` BOOLEAN COMMENT 'Whether promotion is stackable',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for minimum purchase in this promotion',
    `promotion_name` STRING COMMENT 'The display name or label for the promotion in this promotion',
    `promo_category` STRING COMMENT 'Promotion category',
    `promo_source` STRING COMMENT 'Promotion source',
    `promotion_status` STRING COMMENT 'The current status of the promotion for this promotion',
    `promotion_type` STRING COMMENT 'The classification type for promotion in this promotion',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record update timestamp',
    `redemption_count` STRING COMMENT 'Current redemption count',
    `redemption_limit_per_customer` STRING COMMENT 'Per-customer redemption limit',
    `start_date` DATE COMMENT 'Promotion start date',
    `total_redemption_limit` DECIMAL(18,2) COMMENT 'The total redemption limit attribute value for this promotion record in the marketing domain',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Promotion master record with discount mechanics, eligibility criteria, redemption limits, and channel applicability.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` (
    `promotion_redemption_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `profile_id` BIGINT COMMENT 'FK to guest profile',
    `promotion_id` BIGINT COMMENT 'FK to promotion',
    `member_id` BIGINT COMMENT 'FK to loyalty member',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `channel` STRING COMMENT 'Redemption channel',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this promotion redemption',
    `daypart` STRING COMMENT 'Daypart of redemption',
    `device_code` STRING COMMENT 'A standardized code representing the device classification for this promotion redemption',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percent applied',
    `discount_type` DECIMAL(18,2) COMMENT 'The classification type for discount in this promotion redemption',
    `is_test_redemption` BOOLEAN COMMENT 'Whether this is a test redemption',
    `loyalty_member_flag` BOOLEAN COMMENT 'Whether redeemer is loyalty member',
    `order_value_after_discount` DECIMAL(18,2) COMMENT 'The order value after discount attribute value for this promotion redemption record in the marketing domain',
    `order_value_before_discount` DECIMAL(18,2) COMMENT 'The order value before discount attribute value for this promotion redemption record in the marketing domain',
    `promotion_redemption_status` STRING COMMENT 'Redemption status',
    `redemption_number` STRING COMMENT 'Redemption reference number',
    `redemption_timestamp` TIMESTAMP COMMENT 'The redemption timestamp attribute value for this promotion redemption record in the marketing domain',
    `ticket_number` STRING COMMENT 'POS ticket number',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_promotion_redemption PRIMARY KEY(`promotion_redemption_id`)
) COMMENT 'Individual promotion redemption event recording guest, order, discount applied, and channel details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` (
    `marketing_guest_segment_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator flag for active flag status in this marketing guest segment',
    `channel_targeting` STRING COMMENT 'The channel targeting attribute value for this marketing guest segment record in the marketing domain',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp',
    `created_date` DATE COMMENT 'The date and time when the created event occurred for this marketing guest segment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `criteria_definition` STRING COMMENT 'The criteria definition attribute value for this marketing guest segment record in the marketing domain',
    `marketing_guest_segment_description` STRING COMMENT 'The marketing guest segment description attribute value for this marketing guest segment record in the marketing domain',
    `estimated_reach` STRING COMMENT 'The estimated reach attribute value for this marketing guest segment record in the marketing domain',
    `estimated_size` STRING COMMENT 'Estimated segment size',
    `is_active` BOOLEAN COMMENT 'Whether segment is active',
    `member_count` STRING COMMENT 'Current member count',
    `owner` STRING COMMENT 'Segment owner',
    `segment_code` STRING COMMENT 'A standardized code representing the segment classification for this marketing guest segment',
    `segment_criteria` STRING COMMENT 'The segment criteria attribute value for this marketing guest segment record in the marketing domain',
    `segment_description` STRING COMMENT 'The segment description attribute value for this marketing guest segment record in the marketing domain',
    `segment_name` STRING COMMENT 'The display name or label for the segment in this marketing guest segment',
    `segment_status` STRING COMMENT 'The current status of the segment for this marketing guest segment',
    `segment_type` STRING COMMENT 'The classification type for segment in this marketing guest segment',
    `marketing_guest_segment_status` STRING COMMENT 'The current status of the marketing guest segment for this marketing guest segment',
    `targeting_criteria` STRING COMMENT 'The targeting criteria attribute value for this marketing guest segment record in the marketing domain',
    `updated_at` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_marketing_guest_segment PRIMARY KEY(`marketing_guest_segment_id`)
) COMMENT 'Marketing-specific guest segment definition with targeting criteria, estimated reach, and campaign association.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` (
    `local_store_marketing_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `unit_id` BIGINT COMMENT 'FK to sponsor restaurant unit',
    `local_unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'The actual adt lift percent attribute value for this local store marketing record in the marketing domain',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'The actual comp sales lift percent attribute value for this local store marketing record in the marketing domain',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual spend attribute value for this local store marketing record in the marketing domain',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this local store marketing',
    `approval_status` STRING COMMENT 'The current status of the approval for this local store marketing',
    `approved_by` STRING COMMENT 'The approved by attribute value for this local store marketing record in the marketing domain',
    `channel` STRING COMMENT 'Marketing channel',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator flag for compliance flag status in this local store marketing',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this local store marketing',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this local store marketing',
    `execution_end_date` DATE COMMENT 'The date and time when the execution end event occurred for this local store marketing',
    `execution_start_date` DATE COMMENT 'The date and time when the execution start event occurred for this local store marketing',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'The expected adt lift percent attribute value for this local store marketing record in the marketing domain',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'The expected comp sales lift percent attribute value for this local store marketing record in the marketing domain',
    `initiative_code` STRING COMMENT 'A standardized code representing the initiative classification for this local store marketing',
    `initiative_name` STRING COMMENT 'The display name or label for the initiative in this local store marketing',
    `initiative_type` STRING COMMENT 'The classification type for initiative in this local store marketing',
    `lmf_fund_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for lmf fund in this local store marketing',
    `lmf_fund_used` DECIMAL(18,2) COMMENT 'The lmf fund used attribute value for this local store marketing record in the marketing domain',
    `lmf_remaining_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for lmf remaining in this local store marketing',
    `local_store_marketing_status` STRING COMMENT 'LSM status',
    `market_dma` STRING COMMENT 'The market dma attribute value for this local store marketing record in the marketing domain',
    `notes` STRING COMMENT 'Free-text notes',
    `planned_spend` DECIMAL(18,2) COMMENT 'The planned spend attribute value for this local store marketing record in the marketing domain',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this local store marketing',
    `target_audience` STRING COMMENT 'The target audience attribute value for this local store marketing record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_local_store_marketing PRIMARY KEY(`local_store_marketing_id`)
) COMMENT 'Local store marketing initiative tracking spend, compliance, and performance at the unit level.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`fund` (
    `fund_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `balance_amount` DECIMAL(18,2) COMMENT 'Current balance',
    `fund_code` STRING COMMENT 'A standardized code representing the fund classification for this fund',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this fund',
    `contribution_rate_percent` DECIMAL(18,2) COMMENT 'The contribution rate percent attribute value for this fund record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this fund',
    `fund_description` STRING COMMENT 'The fund description attribute value for this fund record in the marketing domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this fund',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this fund',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this fund record in the marketing domain',
    `fund_status` STRING COMMENT 'The current status of the fund for this fund',
    `fund_type` STRING COMMENT 'The classification type for fund in this fund',
    `governing_body` STRING COMMENT 'The governing body attribute value for this fund record in the marketing domain',
    `is_taxable` BOOLEAN COMMENT 'Whether fund is taxable',
    `fund_name` STRING COMMENT 'The display name or label for the fund in this fund',
    `notes` STRING COMMENT 'Free-text notes',
    `reporting_requirements` STRING COMMENT 'The reporting requirements attribute value for this fund record in the marketing domain',
    `total_contributions_amount` DECIMAL(18,2) COMMENT 'Total contributions',
    `total_spend_authorized_amount` DECIMAL(18,2) COMMENT 'Total spend authorized',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Marketing fund (national ad fund, local marketing fund, co-op fund) with balance tracking and legal entity ownership.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` (
    `fund_contribution_id` BIGINT COMMENT 'Primary key',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee',
    `fund_id` BIGINT COMMENT 'FK to fund',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `fund_unit_id` BIGINT COMMENT 'FK to restaurant unit (alternate)',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp attribute value for this fund contribution record in the marketing domain',
    `approved_by` STRING COMMENT 'The approved by attribute value for this fund contribution record in the marketing domain',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for contribution in this fund contribution',
    `contribution_number` DECIMAL(18,2) COMMENT 'The contribution number attribute value for this fund contribution record in the marketing domain',
    `contribution_period_type` DECIMAL(18,2) COMMENT 'The classification type for contribution period in this fund contribution',
    `contribution_rate` DECIMAL(18,2) COMMENT 'The contribution rate attribute value for this fund contribution record in the marketing domain',
    `contribution_timestamp` TIMESTAMP COMMENT 'The contribution timestamp attribute value for this fund contribution record in the marketing domain',
    `contribution_type` DECIMAL(18,2) COMMENT 'The classification type for contribution in this fund contribution',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this fund contribution',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for gross sales in this fund contribution',
    `lifecycle_status` STRING COMMENT 'The current status of the lifecycle for this fund contribution',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this fund contribution',
    `period_end_date` DATE COMMENT 'The date and time when the period end event occurred for this fund contribution',
    `period_start_date` DATE COMMENT 'The date and time when the period start event occurred for this fund contribution',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this fund contribution',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_fund_contribution PRIMARY KEY(`fund_contribution_id`)
) COMMENT 'Individual contribution to a marketing fund from a franchisee or unit, with period and reconciliation details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` (
    `digital_campaign_performance_id` BIGINT COMMENT 'Primary key',
    `ad_creative_id` BIGINT COMMENT 'FK to ad creative',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual spend attribute value for this digital campaign performance record in the marketing domain',
    `ad_format` STRING COMMENT 'The ad format attribute value for this digital campaign performance record in the marketing domain',
    `ad_group_code` BIGINT COMMENT 'A standardized code representing the ad group classification for this digital campaign performance',
    `ad_group_name` STRING COMMENT 'The display name or label for the ad group in this digital campaign performance',
    `attribution_model` STRING COMMENT 'The attribution model attribute value for this digital campaign performance record in the marketing domain',
    `audience_segment` STRING COMMENT 'The audience segment attribute value for this digital campaign performance record in the marketing domain',
    `bidding_strategy` DECIMAL(18,2) COMMENT 'The bidding strategy attribute value for this digital campaign performance record in the marketing domain',
    `budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for budget in this digital campaign performance',
    `campaign_end_date` DATE COMMENT 'The date and time when the campaign end event occurred for this digital campaign performance',
    `campaign_goal` STRING COMMENT 'The campaign goal attribute value for this digital campaign performance record in the marketing domain',
    `campaign_start_date` DATE COMMENT 'The date and time when the campaign start event occurred for this digital campaign performance',
    `channel` STRING COMMENT 'The channel attribute value for this digital campaign performance record in the marketing domain',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Click-through rate',
    `clicks` BIGINT COMMENT 'Number of clicks',
    `conversion_rate` DECIMAL(18,2) COMMENT 'The conversion rate attribute value for this digital campaign performance record in the marketing domain',
    `conversions` BIGINT COMMENT 'Number of conversions',
    `cost_per_acquisition` DECIMAL(18,2) COMMENT 'The cost per acquisition attribute value for this digital campaign performance record in the marketing domain',
    `cost_per_click` DECIMAL(18,2) COMMENT 'The cost per click attribute value for this digital campaign performance record in the marketing domain',
    `cost_per_mille` DECIMAL(18,2) COMMENT 'The cost per mille attribute value for this digital campaign performance record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this digital campaign performance',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this digital campaign performance',
    `device_type` STRING COMMENT 'The classification type for device in this digital campaign performance',
    `digital_campaign_performance_status` STRING COMMENT 'Performance record status',
    `estimated_reach` BIGINT COMMENT 'The estimated reach attribute value for this digital campaign performance record in the marketing domain',
    `event_date` DATE COMMENT 'The date and time when the event event occurred for this digital campaign performance',
    `frequency_average` DECIMAL(18,2) COMMENT 'Average frequency',
    `geographic_region` STRING COMMENT 'The geographic region attribute value for this digital campaign performance record in the marketing domain',
    `impressions` BIGINT COMMENT 'Number of impressions',
    `is_lto` BOOLEAN COMMENT 'Whether related to LTO',
    `notes` STRING COMMENT 'Free-text notes',
    `platform` STRING COMMENT 'The platform attribute value for this digital campaign performance record in the marketing domain',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'The revenue attributed attribute value for this digital campaign performance record in the marketing domain',
    `roi_percent` DECIMAL(18,2) COMMENT 'The roi percent attribute value for this digital campaign performance record in the marketing domain',
    `spend` DECIMAL(18,2) COMMENT 'Spend amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `video_views` BIGINT COMMENT 'The video views attribute value for this digital campaign performance record in the marketing domain',
    `view_through_rate` DECIMAL(18,2) COMMENT 'View-through rate',
    CONSTRAINT pk_digital_campaign_performance PRIMARY KEY(`digital_campaign_performance_id`)
) COMMENT 'Daily/periodic digital campaign performance metrics including impressions, clicks, conversions, spend, and ROI by platform and audience.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` (
    `campaign_spend_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier',
    `campaign_vendor_procurement_supplier_id` BIGINT COMMENT 'FK to vendor supplier',
    `approval_status` STRING COMMENT 'The current status of the approval for this campaign spend',
    `approved_by` STRING COMMENT 'The approved by attribute value for this campaign spend record in the marketing domain',
    `budget_line_item_code` DECIMAL(18,2) COMMENT 'A standardized code representing the budget line item classification for this campaign spend',
    `campaign_phase` STRING COMMENT 'The campaign phase attribute value for this campaign spend record in the marketing domain',
    `campaign_spend_status` DECIMAL(18,2) COMMENT 'Spend status',
    `channel` STRING COMMENT 'The channel attribute value for this campaign spend record in the marketing domain',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification for this campaign spend',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this campaign spend',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this campaign spend',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter attribute value for this campaign spend record in the marketing domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this campaign spend record in the marketing domain',
    `invoice_date` DATE COMMENT 'The date and time when the invoice event occurred for this campaign spend',
    `invoice_number` STRING COMMENT 'The invoice number attribute value for this campaign spend record in the marketing domain',
    `is_estimated` BOOLEAN COMMENT 'Whether spend is estimated',
    `is_recurring` BOOLEAN COMMENT 'Whether spend is recurring',
    `media_type` STRING COMMENT 'The classification type for media in this campaign spend',
    `net_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for net in this campaign spend',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this campaign spend',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute value for this campaign spend record in the marketing domain',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status of the payment for this campaign spend',
    `spend_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for spend in this campaign spend',
    `spend_category` DECIMAL(18,2) COMMENT 'The spend category attribute value for this campaign spend record in the marketing domain',
    `spend_description` DECIMAL(18,2) COMMENT 'The spend description attribute value for this campaign spend record in the marketing domain',
    `spend_reference` DECIMAL(18,2) COMMENT 'The spend reference attribute value for this campaign spend record in the marketing domain',
    `spend_timestamp` TIMESTAMP COMMENT 'The spend timestamp attribute value for this campaign spend record in the marketing domain',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for tax in this campaign spend',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax rate attribute value for this campaign spend record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for variance in this campaign spend',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance percent attribute value for this campaign spend record in the marketing domain',
    `vendor_name` STRING COMMENT 'The display name or label for the vendor in this campaign spend',
    CONSTRAINT pk_campaign_spend PRIMARY KEY(`campaign_spend_id`)
) COMMENT 'Campaign spend line items tracking invoices, payments, vendors, and budget variance by channel and fiscal period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `menu_item_id` BIGINT COMMENT 'FK to menu item',
    `channel_restriction` STRING COMMENT 'The channel restriction attribute value for this coupon record in the marketing domain',
    `coupon_code` STRING COMMENT 'Unique coupon code',
    `coupon_status` STRING COMMENT 'The current status of the coupon for this coupon',
    `coupon_type` STRING COMMENT 'The classification type for coupon in this coupon',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `coupon_description` STRING COMMENT 'The coupon description attribute value for this coupon record in the marketing domain',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this coupon',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The discount percentage attribute value for this coupon record in the marketing domain',
    `discount_type` DECIMAL(18,2) COMMENT 'The classification type for discount in this coupon',
    `eligible_item_category` STRING COMMENT 'The eligible item category attribute value for this coupon record in the marketing domain',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this coupon',
    `fraud_prevention_flag` BOOLEAN COMMENT 'Boolean indicator flag for fraud prevention flag status in this coupon',
    `is_exclusive` BOOLEAN COMMENT 'Whether coupon is exclusive',
    `is_stackable` BOOLEAN COMMENT 'Whether coupon is stackable',
    `issue_date` DATE COMMENT 'The date and time when the issue event occurred for this coupon',
    `max_redemptions` STRING COMMENT 'Maximum redemptions',
    `coupon_name` STRING COMMENT 'The display name or label for the coupon in this coupon',
    `notes` STRING COMMENT 'Free-text notes',
    `per_customer_limit` STRING COMMENT 'Per-customer limit',
    `redemption_count` STRING COMMENT 'Current redemption count',
    `redemption_window_end` DATE COMMENT 'The redemption window end attribute value for this coupon record in the marketing domain',
    `redemption_window_start` DATE COMMENT 'The redemption window start attribute value for this coupon record in the marketing domain',
    `store_scope` STRING COMMENT 'The store scope attribute value for this coupon record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `usage_limit_type` STRING COMMENT 'The classification type for usage limit in this coupon',
    CONSTRAINT pk_coupon PRIMARY KEY(`coupon_id`)
) COMMENT 'Coupon master record with discount mechanics, redemption limits, eligibility, and fraud prevention controls.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `average_comments_per_post` BIGINT COMMENT 'The average comments per post attribute value for this influencer record in the marketing domain',
    `average_likes_per_post` BIGINT COMMENT 'The average likes per post attribute value for this influencer record in the marketing domain',
    `average_views_per_post` BIGINT COMMENT 'The average views per post attribute value for this influencer record in the marketing domain',
    `brand_safety_rating` STRING COMMENT 'The brand safety rating attribute value for this influencer record in the marketing domain',
    `campaigns_participated_count` STRING COMMENT 'The count or quantity of campaigns participated items in this influencer',
    `content_category` STRING COMMENT 'The content category attribute value for this influencer record in the marketing domain',
    `contract_end_date` DATE COMMENT 'The date and time when the contract end event occurred for this influencer',
    `contract_start_date` DATE COMMENT 'The date and time when the contract start event occurred for this influencer',
    `contracted_fee` DECIMAL(18,2) COMMENT 'The contracted fee attribute value for this influencer record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this influencer',
    `email` STRING COMMENT 'Influencer email address',
    `engagement_rate` DECIMAL(18,2) COMMENT 'The engagement rate attribute value for this influencer record in the marketing domain',
    `exclusivity_terms` STRING COMMENT 'The exclusivity terms attribute value for this influencer record in the marketing domain',
    `follower_count` BIGINT COMMENT 'The count or quantity of follower items in this influencer',
    `full_name` STRING COMMENT 'Influencer full name',
    `influencer_status` STRING COMMENT 'The current status of the influencer for this influencer',
    `is_exclusive` BOOLEAN COMMENT 'Whether influencer is exclusive',
    `last_campaign_date` DATE COMMENT 'The date and time when the last campaign event occurred for this influencer',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute value for this influencer record in the marketing domain',
    `phone_number` STRING COMMENT 'Influencer phone number',
    `platform_handle` STRING COMMENT 'The platform handle attribute value for this influencer record in the marketing domain',
    `platform_url` STRING COMMENT 'The URL link to the platform resource associated with this influencer',
    `primary_platform` STRING COMMENT 'The primary platform attribute value for this influencer record in the marketing domain',
    `region` STRING COMMENT 'The region attribute value for this influencer record in the marketing domain',
    `tier` STRING COMMENT 'Influencer tier',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `verified_status` BOOLEAN COMMENT 'The current status of the verified for this influencer',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Influencer profile with platform metrics, contract details, engagement rates, and brand safety ratings.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` (
    `influencer_activation_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `influencer_id` BIGINT COMMENT 'FK to influencer',
    `activation_number` STRING COMMENT 'The activation number attribute value for this influencer activation record in the marketing domain',
    `activation_timestamp` TIMESTAMP COMMENT 'The activation timestamp attribute value for this influencer activation record in the marketing domain',
    `activation_type` STRING COMMENT 'The classification type for activation in this influencer activation',
    `actual_comments` BIGINT COMMENT 'The actual comments attribute value for this influencer activation record in the marketing domain',
    `actual_impressions` BIGINT COMMENT 'The actual impressions attribute value for this influencer activation record in the marketing domain',
    `actual_likes` BIGINT COMMENT 'The actual likes attribute value for this influencer activation record in the marketing domain',
    `actual_shares` BIGINT COMMENT 'The actual shares attribute value for this influencer activation record in the marketing domain',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this influencer activation',
    `content_go_live_date` DATE COMMENT 'Content go-live date',
    `contract_end_date` DATE COMMENT 'The date and time when the contract end event occurred for this influencer activation',
    `contract_start_date` DATE COMMENT 'The date and time when the contract start event occurred for this influencer activation',
    `contract_terms` STRING COMMENT 'The contract terms attribute value for this influencer activation record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deliverables` STRING COMMENT 'The deliverables attribute value for this influencer activation record in the marketing domain',
    `earned_media_value` DECIMAL(18,2) COMMENT 'The earned media value attribute value for this influencer activation record in the marketing domain',
    `ftc_disclosure_flag` BOOLEAN COMMENT 'Boolean indicator flag for ftc disclosure flag status in this influencer activation',
    `influencer_activation_status` STRING COMMENT 'Activation status',
    `influencer_category` STRING COMMENT 'The influencer category attribute value for this influencer activation record in the marketing domain',
    `influencer_engagement_rate` DECIMAL(18,2) COMMENT 'The influencer engagement rate attribute value for this influencer activation record in the marketing domain',
    `influencer_follower_count` BIGINT COMMENT 'The count or quantity of influencer follower items in this influencer activation',
    `influencer_handle` STRING COMMENT 'The influencer handle attribute value for this influencer activation record in the marketing domain',
    `influencer_region` STRING COMMENT 'The influencer region attribute value for this influencer activation record in the marketing domain',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for payment in this influencer activation',
    `payment_currency` DECIMAL(18,2) COMMENT 'The payment currency attribute value for this influencer activation record in the marketing domain',
    `platform` STRING COMMENT 'The platform attribute value for this influencer activation record in the marketing domain',
    `total_engagement` DECIMAL(18,2) COMMENT 'The total engagement attribute value for this influencer activation record in the marketing domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_influencer_activation PRIMARY KEY(`influencer_activation_id`)
) COMMENT 'Individual influencer activation event with deliverables, performance metrics, payment, and FTC compliance tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` (
    `campaign_roi_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'FK to campaign',
    `attribution_methodology` STRING COMMENT 'The attribution methodology attribute value for this campaign roi record in the marketing domain',
    `campaign_roi_status` STRING COMMENT 'ROI record status',
    `channel` STRING COMMENT 'The channel attribute value for this campaign roi record in the marketing domain',
    `cogs_impact_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cogs impact in this campaign roi',
    `confidence_level` STRING COMMENT 'The confidence level attribute value for this campaign roi record in the marketing domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this campaign roi',
    `incremental_revenue` DECIMAL(18,2) COMMENT 'The incremental revenue attribute value for this campaign roi record in the marketing domain',
    `incremental_transactions` STRING COMMENT 'The incremental transactions attribute value for this campaign roi record in the marketing domain',
    `is_test_roi` BOOLEAN COMMENT 'Whether this is a test ROI',
    `market_dma` STRING COMMENT 'The market dma attribute value for this campaign roi record in the marketing domain',
    `measurement_period_end` DATE COMMENT 'The measurement period end attribute value for this campaign roi record in the marketing domain',
    `measurement_period_start` DATE COMMENT 'The measurement period start attribute value for this campaign roi record in the marketing domain',
    `measurement_source` STRING COMMENT 'The measurement source attribute value for this campaign roi record in the marketing domain',
    `measurement_timestamp` TIMESTAMP COMMENT 'The measurement timestamp attribute value for this campaign roi record in the marketing domain',
    `net_incremental_profit` DECIMAL(18,2) COMMENT 'The net incremental profit attribute value for this campaign roi record in the marketing domain',
    `notes` STRING COMMENT 'Free-text notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record update timestamp',
    `roi_code` STRING COMMENT 'A standardized code representing the roi classification for this campaign roi',
    `roi_percent` DECIMAL(18,2) COMMENT 'The roi percent attribute value for this campaign roi record in the marketing domain',
    `spend_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for spend in this campaign roi',
    `version_number` STRING COMMENT 'The version number attribute value for this campaign roi record in the marketing domain',
    CONSTRAINT pk_campaign_roi PRIMARY KEY(`campaign_roi_id`)
) COMMENT 'Campaign ROI measurement record with incremental revenue, profit, spend, and attribution methodology.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`content_template` (
    `content_template_id` BIGINT COMMENT 'Primary key',
    `base_content_template_id` BIGINT COMMENT 'FK to base template (self-ref)',
    `approval_status` STRING COMMENT 'The current status of the approval for this content template',
    `audience_segment` STRING COMMENT 'The audience segment attribute value for this content template record in the marketing domain',
    `channel` STRING COMMENT 'The channel attribute value for this content template record in the marketing domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this content template',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this content template',
    `format` STRING COMMENT 'The format attribute value for this content template record in the marketing domain',
    `gdpr_compliant` BOOLEAN COMMENT 'Whether GDPR compliant',
    `is_default` BOOLEAN COMMENT 'Whether this is the default template',
    `language` STRING COMMENT 'The language attribute value for this content template record in the marketing domain',
    `last_used_timestamp` TIMESTAMP COMMENT 'The last used timestamp attribute value for this content template record in the marketing domain',
    `notes` STRING COMMENT 'Free-text notes',
    `content_template_status` STRING COMMENT 'The current status of the content template for this content template',
    `template_code` STRING COMMENT 'A standardized code representing the template classification for this content template',
    `template_name` STRING COMMENT 'The display name or label for the template in this content template',
    `template_type` STRING COMMENT 'The classification type for template in this content template',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `usage_count` BIGINT COMMENT 'The count or quantity of usage items in this content template',
    `version_number` STRING COMMENT 'The version number attribute value for this content template record in the marketing domain',
    CONSTRAINT pk_content_template PRIMARY KEY(`content_template_id`)
) COMMENT 'Reusable content template for marketing communications with channel, format, language, and compliance attributes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_media_channel_id` FOREIGN KEY (`media_channel_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`media_channel`(`media_channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ADD CONSTRAINT `fk_marketing_media_channel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` ADD CONSTRAINT `fk_marketing_marketing_guest_segment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ADD CONSTRAINT `fk_marketing_local_store_marketing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ADD CONSTRAINT `fk_marketing_fund_contribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`fund`(`fund_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ADD CONSTRAINT `fk_marketing_digital_campaign_performance_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ADD CONSTRAINT `fk_marketing_digital_campaign_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ADD CONSTRAINT `fk_marketing_influencer_activation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ADD CONSTRAINT `fk_marketing_influencer_activation_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ADD CONSTRAINT `fk_marketing_campaign_roi_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ADD CONSTRAINT `fk_marketing_content_template_base_content_template_id` FOREIGN KEY (`base_content_template_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`content_template`(`content_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` ALTER COLUMN `lto_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `brand_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `placement_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `publisher_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `initiative_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_group_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` SET TAGS ('dbx_subdomain' = 'promotional_engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_detected' = 'true');
