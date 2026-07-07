-- Schema for Domain: realestate | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`realestate` COMMENT 'Manages site selection, lease negotiations, property acquisition, facility design and construction, CAM (Common Area Maintenance) charges, landlord relationships, lease administration, NRO development pipeline, facility R&M (Repairs and Maintenance), and CapEx planning for new builds and remodels. Tracks lease obligations for IFRS 16 / ASC 842 compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site` (
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this site',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this site',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this site',
    `trade_area_id` BIGINT COMMENT 'Unique identifier for the trade area associated with this site',
    `accessibility_score` DECIMAL(18,2) COMMENT 'The accessibility score attribute value for this site record in the realestate domain',
    `acquisition_date` DATE COMMENT 'The date and time when the acquisition event occurred for this site',
    `address_line_1` STRING COMMENT 'The address line 1 attribute value for this site record in the realestate domain',
    `address_line_2` STRING COMMENT 'The address line 2 attribute value for this site record in the realestate domain',
    `building_square_footage` STRING COMMENT 'The building square footage attribute value for this site record in the realestate domain',
    `city` STRING COMMENT 'The city attribute value for this site record in the realestate domain',
    `closure_date` DATE COMMENT 'The date and time when the closure event occurred for this site',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this site',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this site record in the realestate domain',
    `daily_traffic_count` STRING COMMENT 'The count or quantity of daily traffic items in this site',
    `drive_thru_capable` BOOLEAN COMMENT 'The drive thru capable attribute value for this site record in the realestate domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp attribute value for this site record in the realestate domain',
    `latitude` DECIMAL(18,2) COMMENT 'The latitude attribute value for this site record in the realestate domain',
    `lease_commencement_date` DATE COMMENT 'The date and time when the lease commencement event occurred for this site',
    `lease_expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the lease expiration event occurred for this site',
    `lifecycle_stage` STRING COMMENT 'The lifecycle stage attribute value for this site record in the realestate domain',
    `longitude` DECIMAL(18,2) COMMENT 'The longitude attribute value for this site record in the realestate domain',
    `lot_square_footage` STRING COMMENT 'The lot square footage attribute value for this site record in the realestate domain',
    `market_classification` STRING COMMENT 'The market classification attribute value for this site record in the realestate domain',
    `monthly_base_rent` DECIMAL(18,2) COMMENT 'The monthly base rent attribute value for this site record in the realestate domain',
    `monthly_cam_charges` DECIMAL(18,2) COMMENT 'The monthly cam charges attribute value for this site record in the realestate domain',
    `site_name` STRING COMMENT 'The display name or label for the site in this site',
    `opening_date` DATE COMMENT 'The date and time when the opening event occurred for this site',
    `ownership_status` STRING COMMENT 'The current status of the ownership for this site',
    `parking_spaces` STRING COMMENT 'The parking spaces attribute value for this site record in the realestate domain',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'The percentage rent rate attribute value for this site record in the realestate domain',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'The percentage rent threshold attribute value for this site record in the realestate domain',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this site',
    `projected_auv` DECIMAL(18,2) COMMENT 'The projected auv attribute value for this site record in the realestate domain',
    `seating_capacity` STRING COMMENT 'The seating capacity attribute value for this site record in the realestate domain',
    `site_number` STRING COMMENT 'The site number attribute value for this site record in the realestate domain',
    `site_type` STRING COMMENT 'The classification type for site in this site',
    `state_province` STRING COMMENT 'The state province attribute value for this site record in the realestate domain',
    `total_capex_investment` DECIMAL(18,2) COMMENT 'The total capex investment attribute value for this site record in the realestate domain',
    `visibility_score` DECIMAL(18,2) COMMENT 'The visibility score attribute value for this site record in the realestate domain',
    `zoning_classification` STRING COMMENT 'The zoning classification attribute value for this site record in the realestate domain',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Physical location or property where a restaurant unit operates or is planned.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`lease` (
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease associated with this lease',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this lease',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this lease',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this lease',
    `accounting_classification` STRING COMMENT 'The accounting classification attribute value for this lease record in the realestate domain',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for base rent in this lease',
    `base_rent_frequency` STRING COMMENT 'The base rent frequency attribute value for this lease record in the realestate domain',
    `cam_charges_annual` DECIMAL(18,2) COMMENT 'The cam charges annual attribute value for this lease record in the realestate domain',
    `co_tenancy_clause_flag` BOOLEAN COMMENT 'Boolean indicator flag for co tenancy clause flag status in this lease',
    `commencement_date` DATE COMMENT 'The date and time when the commencement event occurred for this lease',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this lease record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this lease',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate attribute value for this lease record in the realestate domain',
    `document_url` STRING COMMENT 'The URL link to the document resource associated with this lease',
    `exclusive_use_rights` STRING COMMENT 'The exclusive use rights attribute value for this lease record in the realestate domain',
    `execution_date` DATE COMMENT 'The date and time when the execution event occurred for this lease',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this lease',
    `guarantor_entity` STRING COMMENT 'The guarantor entity attribute value for this lease record in the realestate domain',
    `insurance_annual` DECIMAL(18,2) COMMENT 'The insurance annual attribute value for this lease record in the realestate domain',
    `lease_number` STRING COMMENT 'The lease number attribute value for this lease record in the realestate domain',
    `lease_status` STRING COMMENT 'The current status of the lease for this lease',
    `lease_type` STRING COMMENT 'The classification type for lease in this lease',
    `liability_value` DECIMAL(18,2) COMMENT 'The liability value attribute value for this lease record in the realestate domain',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this lease record in the realestate domain',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'The percentage rent rate attribute value for this lease record in the realestate domain',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'The percentage rent threshold attribute value for this lease record in the realestate domain',
    `permitted_use` STRING COMMENT 'The permitted use attribute value for this lease record in the realestate domain',
    `property_tax_annual` DECIMAL(18,2) COMMENT 'The property tax annual attribute value for this lease record in the realestate domain',
    `remaining_term_months` STRING COMMENT 'The remaining term months attribute value for this lease record in the realestate domain',
    `renewal_notice_days` STRING COMMENT 'The renewal notice days attribute value for this lease record in the realestate domain',
    `renewal_option_count` STRING COMMENT 'The count or quantity of renewal option items in this lease',
    `renewal_option_term_months` STRING COMMENT 'The renewal option term months attribute value for this lease record in the realestate domain',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'The rent escalation rate attribute value for this lease record in the realestate domain',
    `rent_escalation_type` STRING COMMENT 'The classification type for rent escalation in this lease',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'The rou asset value attribute value for this lease record in the realestate domain',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for security deposit in this lease',
    `term_months` STRING COMMENT 'The term months attribute value for this lease record in the realestate domain',
    `termination_clause_flag` BOOLEAN COMMENT 'Boolean indicator flag for termination clause flag status in this lease',
    `termination_notice_days` STRING COMMENT 'The termination notice days attribute value for this lease record in the realestate domain',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for termination penalty in this lease',
    CONSTRAINT pk_lease PRIMARY KEY(`lease_id`)
) COMMENT 'Lease agreement for a restaurant site between the tenant (franchisee or corporate) and the landlord.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`landlord` (
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this landlord',
    `billing_address_line1` STRING COMMENT 'The billing address line1 attribute value for this landlord record in the realestate domain',
    `billing_address_line2` STRING COMMENT 'The billing address line2 attribute value for this landlord record in the realestate domain',
    `billing_city` STRING COMMENT 'The billing city attribute value for this landlord record in the realestate domain',
    `billing_country_code` STRING COMMENT 'A standardized code representing the billing country classification for this landlord',
    `billing_postal_code` STRING COMMENT 'A standardized code representing the billing postal classification for this landlord',
    `billing_state_province` STRING COMMENT 'The billing state province attribute value for this landlord record in the realestate domain',
    `cam_billing_method` STRING COMMENT 'The cam billing method attribute value for this landlord record in the realestate domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this landlord record in the realestate domain',
    `dba_name` STRING COMMENT 'The display name or label for the dba in this landlord',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this landlord',
    `entity_type` STRING COMMENT 'The classification type for entity in this landlord',
    `escalation_history_count` STRING COMMENT 'The count or quantity of escalation history items in this landlord',
    `insurance_certificate_frequency` STRING COMMENT 'The insurance certificate frequency attribute value for this landlord record in the realestate domain',
    `insurance_certificate_required_flag` BOOLEAN COMMENT 'Boolean indicator flag for insurance certificate required flag status in this landlord',
    `landlord_status` STRING COMMENT 'The current status of the landlord for this landlord',
    `last_escalation_date` DATE COMMENT 'The date and time when the last escalation event occurred for this landlord',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp attribute value for this landlord record in the realestate domain',
    `legal_name` STRING COMMENT 'The display name or label for the legal in this landlord',
    `negotiation_posture` STRING COMMENT 'The negotiation posture attribute value for this landlord record in the realestate domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this landlord',
    `payment_terms_days` STRING COMMENT 'The payment terms days attribute value for this landlord record in the realestate domain',
    `portfolio_property_count` STRING COMMENT 'The count or quantity of portfolio property items in this landlord',
    `preferred_communication_channel` STRING COMMENT 'The preferred communication channel attribute value for this landlord record in the realestate domain',
    `primary_contact_email` STRING COMMENT 'The primary contact email attribute value for this landlord record in the realestate domain',
    `primary_contact_name` STRING COMMENT 'The display name or label for the primary contact in this landlord',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone attribute value for this landlord record in the realestate domain',
    `primary_contact_title` STRING COMMENT 'The primary contact title attribute value for this landlord record in the realestate domain',
    `relationship_health_score` DECIMAL(18,2) COMMENT 'The relationship health score attribute value for this landlord record in the realestate domain',
    `relationship_tier` STRING COMMENT 'The relationship tier attribute value for this landlord record in the realestate domain',
    `status_reason` STRING COMMENT 'The status reason attribute value for this landlord record in the realestate domain',
    `tax_number` STRING COMMENT 'The tax number attribute value for this landlord record in the realestate domain',
    `termination_date` DATE COMMENT 'The date and time when the termination event occurred for this landlord',
    `w9_last_updated_date` DATE COMMENT 'The date and time when the w9 last updated event occurred for this landlord',
    `w9_on_file_flag` BOOLEAN COMMENT 'Boolean indicator flag for w9 on file flag status in this landlord',
    `website_url` STRING COMMENT 'The URL link to the website resource associated with this landlord',
    CONSTRAINT pk_landlord PRIMARY KEY(`landlord_id`)
) COMMENT 'Property owner or management company that leases space to the restaurant brand.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` (
    `rent_schedule_id` BIGINT COMMENT 'Unique identifier for the rent schedule associated with this rent schedule',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this rent schedule',
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease associated with this rent schedule',
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit associated with this rent schedule',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for base rent in this rent schedule',
    `billing_period_end_date` DATE COMMENT 'The date and time when the billing period end event occurred for this rent schedule',
    `billing_period_start_date` DATE COMMENT 'The date and time when the billing period start event occurred for this rent schedule',
    `cam_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam in this rent schedule',
    `cam_reconciliation_flag` BOOLEAN COMMENT 'Boolean indicator flag for cam reconciliation flag status in this rent schedule',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this rent schedule',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this rent schedule record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this rent schedule',
    `escalation_rate` DECIMAL(18,2) COMMENT 'The escalation rate attribute value for this rent schedule record in the realestate domain',
    `escalation_type` STRING COMMENT 'The classification type for escalation in this rent schedule',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification for this rent schedule',
    `insurance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for insurance in this rent schedule',
    `interest_expense` DECIMAL(18,2) COMMENT 'The interest expense attribute value for this rent schedule record in the realestate domain',
    `lease_accounting_classification` STRING COMMENT 'The lease accounting classification attribute value for this rent schedule record in the realestate domain',
    `lease_liability_reduction` DECIMAL(18,2) COMMENT 'The lease liability reduction attribute value for this rent schedule record in the realestate domain',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this rent schedule record in the realestate domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this rent schedule',
    `occupancy_cost_percentage` DECIMAL(18,2) COMMENT 'The occupancy cost percentage attribute value for this rent schedule record in the realestate domain',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for other charges in this rent schedule',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this rent schedule',
    `payment_due_date` DATE COMMENT 'The date and time when the payment due event occurred for this rent schedule',
    `payment_reference_number` STRING COMMENT 'The payment reference number attribute value for this rent schedule record in the realestate domain',
    `payment_status` STRING COMMENT 'The current status of the payment for this rent schedule',
    `percentage_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for percentage rent in this rent schedule',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'The percentage rent rate attribute value for this rent schedule record in the realestate domain',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'The percentage rent threshold attribute value for this rent schedule record in the realestate domain',
    `property_address` STRING COMMENT 'The property address attribute value for this rent schedule record in the realestate domain',
    `real_estate_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for real estate tax in this rent schedule',
    `rent_per_square_foot` DECIMAL(18,2) COMMENT 'The rent per square foot attribute value for this rent schedule record in the realestate domain',
    `reported_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for reported sales in this rent schedule',
    `right_of_use_asset_depreciation` DECIMAL(18,2) COMMENT 'The right of use asset depreciation attribute value for this rent schedule record in the realestate domain',
    `sales_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator flag for sales reporting required flag status in this rent schedule',
    `square_footage` DECIMAL(18,2) COMMENT 'The square footage attribute value for this rent schedule record in the realestate domain',
    `tax_reconciliation_flag` BOOLEAN COMMENT 'Boolean indicator flag for tax reconciliation flag status in this rent schedule',
    `total_occupancy_cost` DECIMAL(18,2) COMMENT 'The total occupancy cost attribute value for this rent schedule record in the realestate domain',
    CONSTRAINT pk_rent_schedule PRIMARY KEY(`rent_schedule_id`)
) COMMENT 'Scheduled rent payments and occupancy cost breakdown for a lease period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` (
    `rent_payment_id` BIGINT COMMENT 'Unique identifier for the rent payment associated with this rent payment',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the approved by user employee associated with this rent payment record',
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account associated with this rent payment',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center associated with this rent payment',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this rent payment',
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease associated with this rent payment',
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center associated with this rent payment',
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit associated with this rent payment',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this rent payment',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for base rent in this rent payment',
    `cam_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam in this rent payment',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this rent payment record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this rent payment',
    `days_late` STRING COMMENT 'The days late attribute value for this rent payment record in the realestate domain',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator flag for dispute flag status in this rent payment',
    `dispute_reason` STRING COMMENT 'The dispute reason attribute value for this rent payment record in the realestate domain',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate attribute value for this rent payment record in the realestate domain',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this rent payment record in the realestate domain',
    `gl_posting_date` DATE COMMENT 'The date and time when the gl posting event occurred for this rent payment',
    `insurance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for insurance in this rent payment',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for late fee in this rent payment',
    `late_fee_applied_flag` BOOLEAN COMMENT 'Boolean indicator flag for late fee applied flag status in this rent payment',
    `lease_period_end_date` DATE COMMENT 'The date and time when the lease period end event occurred for this rent payment',
    `lease_period_start_date` DATE COMMENT 'The date and time when the lease period start event occurred for this rent payment',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this rent payment record in the realestate domain',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for other charges in this rent payment',
    `payment_date` DATE COMMENT 'The date and time when the payment event occurred for this rent payment',
    `payment_due_date` DATE COMMENT 'The date and time when the payment due event occurred for this rent payment',
    `payment_method` STRING COMMENT 'The payment method attribute value for this rent payment record in the realestate domain',
    `payment_notes` STRING COMMENT 'The payment notes attribute value for this rent payment record in the realestate domain',
    `payment_reference_number` STRING COMMENT 'The payment reference number attribute value for this rent payment record in the realestate domain',
    `payment_status` STRING COMMENT 'The current status of the payment for this rent payment',
    `payment_variance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for payment variance in this rent payment',
    `property_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for property tax in this rent payment',
    `reconciliation_date` DATE COMMENT 'The date and time when the reconciliation event occurred for this rent payment',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation for this rent payment',
    `scheduled_payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for scheduled payment in this rent payment',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total payment in this rent payment',
    CONSTRAINT pk_rent_payment PRIMARY KEY(`rent_payment_id`)
) COMMENT 'Actual rent payment made to a landlord for a lease period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` (
    `cam_reconciliation_id` BIGINT COMMENT 'Unique identifier for the cam reconciliation associated with this cam reconciliation',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this cam reconciliation',
    `tenant_id` BIGINT COMMENT 'Unique identifier for the tenant associated with this cam reconciliation',
    `audit_user` STRING COMMENT 'The audit user attribute value for this cam reconciliation record in the realestate domain',
    `cam_adjustments_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam adjustments in this cam reconciliation',
    `cam_billed_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam billed in this cam reconciliation',
    `cam_cap_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam cap in this cam reconciliation',
    `cam_estimated_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam estimated in this cam reconciliation',
    `cam_exclusions_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam exclusions in this cam reconciliation',
    `cam_final_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cam final in this cam reconciliation',
    `cam_itemization_flag` BOOLEAN COMMENT 'Boolean indicator flag for cam itemization flag status in this cam reconciliation',
    `cam_reconciliation_status` STRING COMMENT 'The current status of the cam reconciliation for this cam reconciliation',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this cam reconciliation record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this cam reconciliation',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator flag for dispute flag status in this cam reconciliation',
    `dispute_resolution_date` DATE COMMENT 'The date and time when the dispute resolution event occurred for this cam reconciliation',
    `dispute_status` STRING COMMENT 'The current status of the dispute for this cam reconciliation',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this cam reconciliation',
    `overpayment_credit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for overpayment credit in this cam reconciliation',
    `period_end_date` DATE COMMENT 'The date and time when the period end event occurred for this cam reconciliation',
    `period_start_date` DATE COMMENT 'The date and time when the period start event occurred for this cam reconciliation',
    `reconciliation_number` STRING COMMENT 'The reconciliation number attribute value for this cam reconciliation record in the realestate domain',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The reconciliation timestamp attribute value for this cam reconciliation record in the realestate domain',
    `reconciliation_type` STRING COMMENT 'The classification type for reconciliation in this cam reconciliation',
    `underpayment_due_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for underpayment due in this cam reconciliation',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this cam reconciliation record in the realestate domain',
    CONSTRAINT pk_cam_reconciliation PRIMARY KEY(`cam_reconciliation_id`)
) COMMENT 'Common area maintenance reconciliation between estimated and actual charges.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` (
    `site_selection_id` BIGINT COMMENT 'Unique identifier for the site selection associated with this site selection',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the approval authority employee associated with this site selection record',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this site selection',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this site selection',
    `auv_projection` DECIMAL(18,2) COMMENT 'The auv projection attribute value for this site selection record in the realestate domain',
    `cannibalization_risk_score` DECIMAL(18,2) COMMENT 'The cannibalization risk score attribute value for this site selection record in the realestate domain',
    `comments` STRING COMMENT 'Free-text comments field providing additional context for this site selection',
    `competition_score` DECIMAL(18,2) COMMENT 'The competition score attribute value for this site selection record in the realestate domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this site selection record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this site selection',
    `decision_date` DATE COMMENT 'The date and time when the decision event occurred for this site selection',
    `demographic_score` DECIMAL(18,2) COMMENT 'The demographic score attribute value for this site selection record in the realestate domain',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'The environmental impact score attribute value for this site selection record in the realestate domain',
    `evaluation_stage` STRING COMMENT 'The evaluation stage attribute value for this site selection record in the realestate domain',
    `evaluation_start_timestamp` TIMESTAMP COMMENT 'The evaluation start timestamp attribute value for this site selection record in the realestate domain',
    `lease_term_years` STRING COMMENT 'The lease term years attribute value for this site selection record in the realestate domain',
    `lease_type` STRING COMMENT 'The classification type for lease in this site selection',
    `market_share_estimate_percent` DECIMAL(18,2) COMMENT 'The market share estimate percent attribute value for this site selection record in the realestate domain',
    `overall_site_score` DECIMAL(18,2) COMMENT 'The overall site score attribute value for this site selection record in the realestate domain',
    `payback_period_months` STRING COMMENT 'The payback period months attribute value for this site selection record in the realestate domain',
    `projected_annual_sales` DECIMAL(18,2) COMMENT 'The projected annual sales attribute value for this site selection record in the realestate domain',
    `projected_capex_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for projected capex in this site selection',
    `projected_cogs_percent` DECIMAL(18,2) COMMENT 'The projected cogs percent attribute value for this site selection record in the realestate domain',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'The projected labor percent attribute value for this site selection record in the realestate domain',
    `projected_roi_percent` DECIMAL(18,2) COMMENT 'The projected roi percent attribute value for this site selection record in the realestate domain',
    `rejection_reason_code` STRING COMMENT 'A standardized code representing the rejection reason classification for this site selection',
    `risk_level` STRING COMMENT 'The risk level attribute value for this site selection record in the realestate domain',
    `site_area_sqft` DECIMAL(18,2) COMMENT 'The site area sqft attribute value for this site selection record in the realestate domain',
    `site_selection_status` STRING COMMENT 'The current status of the site selection for this site selection',
    `traffic_score` DECIMAL(18,2) COMMENT 'The traffic score attribute value for this site selection record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this site selection record in the realestate domain',
    CONSTRAINT pk_site_selection PRIMARY KEY(`site_selection_id`)
) COMMENT 'Evaluation and scoring of potential sites for new restaurant development.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` (
    `nro_project_id` BIGINT COMMENT 'Unique identifier for the nro project associated with this nro project',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this nro project',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this nro project',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this nro project',
    `actual_opening_date` DATE COMMENT 'The date and time when the actual opening event occurred for this nro project',
    `architect_name` STRING COMMENT 'The display name or label for the architect in this nro project',
    `capex_actual_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for capex actual in this nro project',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for capex budget in this nro project',
    `capex_committed_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for capex committed in this nro project',
    `certificate_of_occupancy_date` DATE COMMENT 'The date and time when the certificate of occupancy event occurred for this nro project',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this nro project',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this nro project record in the realestate domain',
    `nro_project_description` STRING COMMENT 'The nro project description attribute value for this nro project record in the realestate domain',
    `ifr16_lease_asset_flag` BOOLEAN COMMENT 'Boolean indicator flag for ifr16 lease asset flag status in this nro project',
    `ifr16_lease_end_date` DATE COMMENT 'The date and time when the ifr16 lease end event occurred for this nro project',
    `ifr16_lease_start_date` DATE COMMENT 'The date and time when the ifr16 lease start event occurred for this nro project',
    `lease_obligation_end_date` DATE COMMENT 'The date and time when the lease obligation end event occurred for this nro project',
    `lease_obligation_start_date` DATE COMMENT 'The date and time when the lease obligation start event occurred for this nro project',
    `lease_term_years` STRING COMMENT 'The lease term years attribute value for this nro project record in the realestate domain',
    `lease_type` STRING COMMENT 'The classification type for lease in this nro project',
    `nro_project_status` STRING COMMENT 'The current status of the nro project for this nro project',
    `permit_expiry_date` DATE COMMENT 'The date and time when the permit expiry event occurred for this nro project',
    `permit_issue_date` DATE COMMENT 'The date and time when the permit issue event occurred for this nro project',
    `permit_number` STRING COMMENT 'The permit number attribute value for this nro project record in the realestate domain',
    `permitting_approval_date` DATE COMMENT 'The date and time when the permitting approval event occurred for this nro project',
    `permitting_status` STRING COMMENT 'The current status of the permitting for this nro project',
    `project_code` STRING COMMENT 'A standardized code representing the project classification for this nro project',
    `project_manager_name` STRING COMMENT 'The display name or label for the project manager in this nro project',
    `project_name` STRING COMMENT 'The display name or label for the project in this nro project',
    `project_phase` STRING COMMENT 'The project phase attribute value for this nro project record in the realestate domain',
    `project_phase_end_date` DATE COMMENT 'The date and time when the project phase end event occurred for this nro project',
    `project_phase_start_date` DATE COMMENT 'The date and time when the project phase start event occurred for this nro project',
    `project_type` STRING COMMENT 'The classification type for project in this nro project',
    `risk_assessment_date` DATE COMMENT 'The date and time when the risk assessment event occurred for this nro project',
    `risk_level` STRING COMMENT 'The risk level attribute value for this nro project record in the realestate domain',
    `target_opening_date` DATE COMMENT 'The date and time when the target opening event occurred for this nro project',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this nro project record in the realestate domain',
    CONSTRAINT pk_nro_project PRIMARY KEY(`nro_project_id`)
) COMMENT 'New restaurant opening project tracking construction, permitting, and launch milestones.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` (
    `capex_budget_id` BIGINT COMMENT 'Unique identifier for the capex budget associated with this capex budget',
    `capex_project_id` BIGINT COMMENT 'Unique identifier for the capex project associated with this capex budget',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this capex budget',
    `amendment_date` DATE COMMENT 'The date and time when the amendment event occurred for this capex budget',
    `amendment_number` STRING COMMENT 'The amendment number attribute value for this capex budget record in the realestate domain',
    `amendment_reason` STRING COMMENT 'The amendment reason attribute value for this capex budget record in the realestate domain',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this capex budget',
    `approving_authority` STRING COMMENT 'The approving authority attribute value for this capex budget record in the realestate domain',
    `budget_code` STRING COMMENT 'A standardized code representing the budget classification for this capex budget',
    `budget_name` STRING COMMENT 'The display name or label for the budget in this capex budget',
    `budget_phase` STRING COMMENT 'The budget phase attribute value for this capex budget record in the realestate domain',
    `budget_revision_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for budget revision in this capex budget',
    `budget_revision_date` DATE COMMENT 'The date and time when the budget revision event occurred for this capex budget',
    `budget_type` STRING COMMENT 'The classification type for budget in this capex budget',
    `building_shell_cost` DECIMAL(18,2) COMMENT 'The building shell cost attribute value for this capex budget record in the realestate domain',
    `capex_budget_status` STRING COMMENT 'The current status of the capex budget for this capex budget',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this capex budget',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this capex budget record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this capex budget',
    `capex_budget_description` STRING COMMENT 'The capex budget description attribute value for this capex budget record in the realestate domain',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this capex budget',
    `ffe_cost` DECIMAL(18,2) COMMENT 'The ffe cost attribute value for this capex budget record in the realestate domain',
    `funding_source` STRING COMMENT 'The funding source attribute value for this capex budget record in the realestate domain',
    `land_cost` DECIMAL(18,2) COMMENT 'The land cost attribute value for this capex budget record in the realestate domain',
    `leasehold_improvements_cost` DECIMAL(18,2) COMMENT 'The leasehold improvements cost attribute value for this capex budget record in the realestate domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this capex budget',
    `other_costs` DECIMAL(18,2) COMMENT 'The other costs attribute value for this capex budget record in the realestate domain',
    `signage_cost` DECIMAL(18,2) COMMENT 'The signage cost attribute value for this capex budget record in the realestate domain',
    `soft_costs` DECIMAL(18,2) COMMENT 'The soft costs attribute value for this capex budget record in the realestate domain',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this capex budget',
    `technology_cost` DECIMAL(18,2) COMMENT 'The technology cost attribute value for this capex budget record in the realestate domain',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total budget in this capex budget',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this capex budget record in the realestate domain',
    CONSTRAINT pk_capex_budget PRIMARY KEY(`capex_budget_id`)
) COMMENT 'Capital expenditure budget for real estate projects including construction and renovation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility associated with this facility',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this facility',
    `ada_compliance_status` STRING COMMENT 'The current status of the ada compliance for this facility',
    `building_material` STRING COMMENT 'The building material attribute value for this facility record in the realestate domain',
    `cam_charges` DECIMAL(18,2) COMMENT 'The cam charges attribute value for this facility record in the realestate domain',
    `capex_spent` DECIMAL(18,2) COMMENT 'The capex spent attribute value for this facility record in the realestate domain',
    `facility_code` STRING COMMENT 'A standardized code representing the facility classification for this facility',
    `condition_score` DECIMAL(18,2) COMMENT 'The condition score attribute value for this facility record in the realestate domain',
    `construction_status` STRING COMMENT 'The current status of the construction for this facility',
    `energy_rating` STRING COMMENT 'The energy rating attribute value for this facility record in the realestate domain',
    `facility_status` STRING COMMENT 'The current status of the facility for this facility',
    `facility_type` STRING COMMENT 'The classification type for facility in this facility',
    `fire_safety_compliance_status` STRING COMMENT 'The current status of the fire safety compliance for this facility',
    `health_inspection_score` DECIMAL(18,2) COMMENT 'The health inspection score attribute value for this facility record in the realestate domain',
    `hvac_type` STRING COMMENT 'The classification type for hvac in this facility',
    `insurance_expiry_date` DATE COMMENT 'The date and time when the insurance expiry event occurred for this facility',
    `insurance_policy_number` STRING COMMENT 'The insurance policy number attribute value for this facility record in the realestate domain',
    `last_inspection_date` DATE COMMENT 'The date and time when the last inspection event occurred for this facility',
    `lease_end_date` DATE COMMENT 'The date and time when the lease end event occurred for this facility',
    `lease_rate` DECIMAL(18,2) COMMENT 'The lease rate attribute value for this facility record in the realestate domain',
    `lease_start_date` DATE COMMENT 'The date and time when the lease start event occurred for this facility',
    `maintenance_last_date` DATE COMMENT 'The date and time when the maintenance last event occurred for this facility',
    `maintenance_next_due` DATE COMMENT 'The maintenance next due attribute value for this facility record in the realestate domain',
    `facility_name` STRING COMMENT 'The display name or label for the facility in this facility',
    `ownership_type` STRING COMMENT 'The classification type for ownership in this facility',
    `property_tax_rate` DECIMAL(18,2) COMMENT 'The property tax rate attribute value for this facility record in the realestate domain',
    `r_and_m_status` STRING COMMENT 'The current status of the r and m for this facility',
    `remodel_date` DATE COMMENT 'The date and time when the remodel event occurred for this facility',
    `remodel_type` STRING COMMENT 'The classification type for remodel in this facility',
    `roof_type` STRING COMMENT 'The classification type for roof in this facility',
    `seating_capacity` STRING COMMENT 'The seating capacity attribute value for this facility record in the realestate domain',
    `square_footage` DECIMAL(18,2) COMMENT 'The square footage attribute value for this facility record in the realestate domain',
    `tax_assessment_value` DECIMAL(18,2) COMMENT 'The tax assessment value attribute value for this facility record in the realestate domain',
    `waste_percentage` DECIMAL(18,2) COMMENT 'The waste percentage attribute value for this facility record in the realestate domain',
    `year_built` STRING COMMENT 'The year built attribute value for this facility record in the realestate domain',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The yield percentage attribute value for this facility record in the realestate domain',
    `zoning_type` STRING COMMENT 'The classification type for zoning in this facility',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Physical building or structure at a site including condition, compliance, and maintenance details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` (
    `maintenance_work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order associated with this maintenance work order',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this maintenance work order record',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this maintenance work order',
    `maintenance_contract_id` BIGINT COMMENT 'Unique identifier for the maintenance contract associated with this maintenance work order',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this maintenance work order',
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit associated with this maintenance work order',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp attribute value for this maintenance work order record in the realestate domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this maintenance work order record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this maintenance work order',
    `issue_category` STRING COMMENT 'The issue category attribute value for this maintenance work order record in the realestate domain',
    `issue_description` STRING COMMENT 'The issue description attribute value for this maintenance work order record in the realestate domain',
    `labor_cost` DECIMAL(18,2) COMMENT 'The labor cost attribute value for this maintenance work order record in the realestate domain',
    `labor_hours` DECIMAL(18,2) COMMENT 'The labor hours attribute value for this maintenance work order record in the realestate domain',
    `maintenance_work_order_status` STRING COMMENT 'The current status of the maintenance work order for this maintenance work order',
    `parts_cost` DECIMAL(18,2) COMMENT 'The parts cost attribute value for this maintenance work order record in the realestate domain',
    `priority_level` STRING COMMENT 'The priority level attribute value for this maintenance work order record in the realestate domain',
    `reported_timestamp` TIMESTAMP COMMENT 'The reported timestamp attribute value for this maintenance work order record in the realestate domain',
    `resolution_notes` STRING COMMENT 'The resolution notes attribute value for this maintenance work order record in the realestate domain',
    `scheduled_date` DATE COMMENT 'The date and time when the scheduled event occurred for this maintenance work order',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost attribute value for this maintenance work order record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this maintenance work order record in the realestate domain',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean indicator flag for warranty claim flag status in this maintenance work order',
    `work_order_number` STRING COMMENT 'The work order number attribute value for this maintenance work order record in the realestate domain',
    CONSTRAINT pk_maintenance_work_order PRIMARY KEY(`maintenance_work_order_id`)
) COMMENT 'Work order for maintenance or repair activities at a restaurant facility.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` (
    `maintenance_contract_id` BIGINT COMMENT 'Unique identifier for the maintenance contract associated with this maintenance contract',
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility associated with this maintenance contract',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this maintenance contract',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'The annual contract value attribute value for this maintenance contract record in the realestate domain',
    `applicable_restaurant_ids` STRING COMMENT 'The applicable restaurant ids attribute value for this maintenance contract record in the realestate domain',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator flag for auto renewal flag status in this maintenance contract',
    `compliance_requirements` STRING COMMENT 'The compliance requirements attribute value for this maintenance contract record in the realestate domain',
    `contract_document_url` STRING COMMENT 'The URL link to the contract document resource associated with this maintenance contract',
    `contract_manager_email` STRING COMMENT 'The contract manager email attribute value for this maintenance contract record in the realestate domain',
    `contract_manager_name` STRING COMMENT 'The display name or label for the contract manager in this maintenance contract',
    `contract_manager_phone` STRING COMMENT 'The contract manager phone attribute value for this maintenance contract record in the realestate domain',
    `contract_number` STRING COMMENT 'The contract number attribute value for this maintenance contract record in the realestate domain',
    `contract_type` STRING COMMENT 'The classification type for contract in this maintenance contract',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this maintenance contract record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this maintenance contract',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this maintenance contract',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this maintenance contract',
    `equipment_covered` STRING COMMENT 'The equipment covered attribute value for this maintenance contract record in the realestate domain',
    `escalation_contact_email` STRING COMMENT 'The escalation contact email attribute value for this maintenance contract record in the realestate domain',
    `escalation_contact_name` STRING COMMENT 'The display name or label for the escalation contact in this maintenance contract',
    `escalation_contact_phone` STRING COMMENT 'The escalation contact phone attribute value for this maintenance contract record in the realestate domain',
    `insurance_certificate_url` STRING COMMENT 'The URL link to the insurance certificate resource associated with this maintenance contract',
    `insurance_requirements` STRING COMMENT 'The insurance requirements attribute value for this maintenance contract record in the realestate domain',
    `invoice_due_days` STRING COMMENT 'The invoice due days attribute value for this maintenance contract record in the realestate domain',
    `last_review_date` DATE COMMENT 'The date and time when the last review event occurred for this maintenance contract',
    `maintenance_contract_status` STRING COMMENT 'The current status of the maintenance contract for this maintenance contract',
    `next_review_date` DATE COMMENT 'The date and time when the next review event occurred for this maintenance contract',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this maintenance contract',
    `payment_frequency` STRING COMMENT 'The payment frequency attribute value for this maintenance contract record in the realestate domain',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this maintenance contract record in the realestate domain',
    `penalty_clause` STRING COMMENT 'The penalty clause attribute value for this maintenance contract record in the realestate domain',
    `regulatory_certifications` STRING COMMENT 'The regulatory certifications attribute value for this maintenance contract record in the realestate domain',
    `renewal_term_months` STRING COMMENT 'The renewal term months attribute value for this maintenance contract record in the realestate domain',
    `service_area` STRING COMMENT 'The service area attribute value for this maintenance contract record in the realestate domain',
    `service_frequency` STRING COMMENT 'The service frequency attribute value for this maintenance contract record in the realestate domain',
    `service_provider_contact_email` STRING COMMENT 'The service provider contact email attribute value for this maintenance contract record in the realestate domain',
    `service_provider_contact_phone` STRING COMMENT 'The service provider contact phone attribute value for this maintenance contract record in the realestate domain',
    `sla_description` STRING COMMENT 'The sla description attribute value for this maintenance contract record in the realestate domain',
    `sla_response_time_hours` STRING COMMENT 'The sla response time hours attribute value for this maintenance contract record in the realestate domain',
    `termination_notice_days` STRING COMMENT 'The termination notice days attribute value for this maintenance contract record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this maintenance contract record in the realestate domain',
    `warranty_coverage_flag` BOOLEAN COMMENT 'Boolean indicator flag for warranty coverage flag status in this maintenance contract',
    `warranty_expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the warranty expiration event occurred for this maintenance contract',
    CONSTRAINT pk_maintenance_contract PRIMARY KEY(`maintenance_contract_id`)
) COMMENT 'Service contract with a vendor for ongoing maintenance of restaurant facilities.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` (
    `lease_amendment_id` BIGINT COMMENT 'Unique identifier for the lease amendment associated with this lease amendment',
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord associated with this lease amendment',
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease associated with this lease amendment',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity associated with this lease amendment',
    `tenant_id` BIGINT COMMENT 'Unique identifier for the tenant associated with this lease amendment',
    `amendment_document_reference` STRING COMMENT 'The amendment document reference attribute value for this lease amendment record in the realestate domain',
    `amendment_number` STRING COMMENT 'The amendment number attribute value for this lease amendment record in the realestate domain',
    `amendment_reason` STRING COMMENT 'The amendment reason attribute value for this lease amendment record in the realestate domain',
    `amendment_summary` STRING COMMENT 'The amendment summary attribute value for this lease amendment record in the realestate domain',
    `amendment_timestamp` TIMESTAMP COMMENT 'The amendment timestamp attribute value for this lease amendment record in the realestate domain',
    `amendment_type` STRING COMMENT 'The classification type for amendment in this lease amendment',
    `co_tenancy_waiver_flag` BOOLEAN COMMENT 'Boolean indicator flag for co tenancy waiver flag status in this lease amendment',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this lease amendment',
    `execution_date` DATE COMMENT 'The date and time when the execution event occurred for this lease amendment',
    `free_rent_months` STRING COMMENT 'The free rent months attribute value for this lease amendment record in the realestate domain',
    `ifrs16_impact_flag` BOOLEAN COMMENT 'Boolean indicator flag for ifrs16 impact flag status in this lease amendment',
    `lease_amendment_status` STRING COMMENT 'The current status of the lease amendment for this lease amendment',
    `legal_review_status` STRING COMMENT 'The current status of the legal review for this lease amendment',
    `net_impact_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for net impact in this lease amendment',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this lease amendment',
    `permitted_use_change_flag` BOOLEAN COMMENT 'Boolean indicator flag for permitted use change flag status in this lease amendment',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created attribute value for this lease amendment record in the realestate domain',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated attribute value for this lease amendment record in the realestate domain',
    `rent_change_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for rent change in this lease amendment',
    `rent_change_currency` STRING COMMENT 'The rent change currency attribute value for this lease amendment record in the realestate domain',
    `space_change_sqft` DECIMAL(18,2) COMMENT 'The space change sqft attribute value for this lease amendment record in the realestate domain',
    `space_change_type` STRING COMMENT 'The classification type for space change in this lease amendment',
    `ti_allowance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for ti allowance in this lease amendment',
    `ti_allowance_currency` STRING COMMENT 'The ti allowance currency attribute value for this lease amendment record in the realestate domain',
    CONSTRAINT pk_lease_amendment PRIMARY KEY(`lease_amendment_id`)
) COMMENT 'Amendment to an existing lease agreement modifying terms, rent, or space.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` (
    `property_acquisition_id` BIGINT COMMENT 'Unique identifier for the property acquisition associated with this property acquisition',
    `capex_project_id` BIGINT COMMENT 'Unique identifier for the capex project associated with this property acquisition',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the acquiring legal entity associated with this property acquisition',
    `property_legal_entity_id` BIGINT COMMENT 'Unique identifier for the property legal entity associated with this property acquisition',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this property acquisition',
    `acquisition_date` DATE COMMENT 'The date and time when the acquisition event occurred for this property acquisition',
    `acquisition_number` STRING COMMENT 'The acquisition number attribute value for this property acquisition record in the realestate domain',
    `acquisition_price` DECIMAL(18,2) COMMENT 'The acquisition price attribute value for this property acquisition record in the realestate domain',
    `capitalization_rate` DECIMAL(18,2) COMMENT 'The capitalization rate attribute value for this property acquisition record in the realestate domain',
    `closing_costs` DECIMAL(18,2) COMMENT 'The closing costs attribute value for this property acquisition record in the realestate domain',
    `cost_center_code` STRING COMMENT 'A standardized code representing the cost center classification for this property acquisition',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this property acquisition record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this property acquisition',
    `deed_recording_reference` STRING COMMENT 'The deed recording reference attribute value for this property acquisition record in the realestate domain',
    `due_diligence_completion_date` DATE COMMENT 'The date and time when the due diligence completion event occurred for this property acquisition',
    `effective_from` DATE COMMENT 'The effective from attribute value for this property acquisition record in the realestate domain',
    `effective_until` DATE COMMENT 'The effective until attribute value for this property acquisition record in the realestate domain',
    `environmental_assessment_status` STRING COMMENT 'The current status of the environmental assessment for this property acquisition',
    `financing_structure` STRING COMMENT 'The financing structure attribute value for this property acquisition record in the realestate domain',
    `lease_end_date` DATE COMMENT 'The date and time when the lease end event occurred for this property acquisition',
    `lease_obligation_flag` BOOLEAN COMMENT 'Boolean indicator flag for lease obligation flag status in this property acquisition',
    `lease_start_date` DATE COMMENT 'The date and time when the lease start event occurred for this property acquisition',
    `lease_term_years` STRING COMMENT 'The lease term years attribute value for this property acquisition record in the realestate domain',
    `lender_name` STRING COMMENT 'The display name or label for the lender in this property acquisition',
    `loan_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for loan in this property acquisition',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this property acquisition',
    `property_acquisition_status` STRING COMMENT 'The current status of the property acquisition for this property acquisition',
    `property_type` STRING COMMENT 'The classification type for property in this property acquisition',
    `title_company_name` STRING COMMENT 'The display name or label for the title company in this property acquisition',
    `title_insurance_policy_number` STRING COMMENT 'The title insurance policy number attribute value for this property acquisition record in the realestate domain',
    `total_acquisition_cost` DECIMAL(18,2) COMMENT 'The total acquisition cost attribute value for this property acquisition record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this property acquisition record in the realestate domain',
    CONSTRAINT pk_property_acquisition PRIMARY KEY(`property_acquisition_id`)
) COMMENT 'Acquisition of real property for restaurant development or investment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` (
    `site_permit_id` BIGINT COMMENT 'Unique identifier for the site permit associated with this site permit',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee associated with this site permit',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this site permit',
    `application_date` DATE COMMENT 'The date and time when the application event occurred for this site permit',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this site permit',
    `compliance_deadline` DATE COMMENT 'The compliance deadline attribute value for this site permit record in the realestate domain',
    `compliance_notes` STRING COMMENT 'The compliance notes attribute value for this site permit record in the realestate domain',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this site permit',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this site permit record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this site permit',
    `document_url` STRING COMMENT 'The URL link to the document resource associated with this site permit',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this site permit',
    `fee_paid_flag` BOOLEAN COMMENT 'Boolean indicator flag for fee paid flag status in this site permit',
    `fee_payment_date` DATE COMMENT 'The date and time when the fee payment event occurred for this site permit',
    `inspection_date` DATE COMMENT 'The date and time when the inspection event occurred for this site permit',
    `inspection_required_flag` BOOLEAN COMMENT 'Boolean indicator flag for inspection required flag status in this site permit',
    `inspection_result` STRING COMMENT 'The inspection result attribute value for this site permit record in the realestate domain',
    `issuing_authority` STRING COMMENT 'The issuing authority attribute value for this site permit record in the realestate domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this site permit',
    `permit_category` STRING COMMENT 'The permit category attribute value for this site permit record in the realestate domain',
    `permit_fee` DECIMAL(18,2) COMMENT 'The permit fee attribute value for this site permit record in the realestate domain',
    `permit_number` STRING COMMENT 'The permit number attribute value for this site permit record in the realestate domain',
    `permit_status` STRING COMMENT 'The current status of the permit for this site permit',
    `permit_type` STRING COMMENT 'The classification type for permit in this site permit',
    `renewal_date` DATE COMMENT 'The date and time when the renewal event occurred for this site permit',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean indicator flag for renewal required flag status in this site permit',
    `site_permit_status` STRING COMMENT 'The current status of the site permit for this site permit',
    `submission_date` DATE COMMENT 'The date and time when the submission event occurred for this site permit',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this site permit record in the realestate domain',
    CONSTRAINT pk_site_permit PRIMARY KEY(`site_permit_id`)
) COMMENT 'Permits and licenses required for operating a restaurant at a specific site.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` (
    `trade_area_id` BIGINT COMMENT 'Unique identifier for the trade area associated with this trade area',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this trade area',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'The area sq miles attribute value for this trade area record in the realestate domain',
    `average_household_size` DECIMAL(18,2) COMMENT 'The average household size attribute value for this trade area record in the realestate domain',
    `average_income_per_capita` DECIMAL(18,2) COMMENT 'The average income per capita attribute value for this trade area record in the realestate domain',
    `cannibalization_risk_score` DECIMAL(18,2) COMMENT 'The cannibalization risk score attribute value for this trade area record in the realestate domain',
    `city` STRING COMMENT 'The city attribute value for this trade area record in the realestate domain',
    `competition_count` STRING COMMENT 'The count or quantity of competition items in this trade area',
    `competition_names` STRING COMMENT 'The competition names attribute value for this trade area record in the realestate domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this trade area record in the realestate domain',
    `data_vintage_date` DATE COMMENT 'The date and time when the data vintage event occurred for this trade area',
    `daytime_population` STRING COMMENT 'The daytime population attribute value for this trade area record in the realestate domain',
    `effective_from` DATE COMMENT 'The effective from attribute value for this trade area record in the realestate domain',
    `effective_until` DATE COMMENT 'The effective until attribute value for this trade area record in the realestate domain',
    `employment_rate_percent` DECIMAL(18,2) COMMENT 'The employment rate percent attribute value for this trade area record in the realestate domain',
    `geographic_region` STRING COMMENT 'The geographic region attribute value for this trade area record in the realestate domain',
    `latitude` DECIMAL(18,2) COMMENT 'The latitude attribute value for this trade area record in the realestate domain',
    `longitude` DECIMAL(18,2) COMMENT 'The longitude attribute value for this trade area record in the realestate domain',
    `market_share_score` DECIMAL(18,2) COMMENT 'The market share score attribute value for this trade area record in the realestate domain',
    `median_age` STRING COMMENT 'The median age attribute value for this trade area record in the realestate domain',
    `median_household_income` DECIMAL(18,2) COMMENT 'The median household income attribute value for this trade area record in the realestate domain',
    `methodology` STRING COMMENT 'The methodology attribute value for this trade area record in the realestate domain',
    `trade_area_name` STRING COMMENT 'The display name or label for the trade area in this trade area',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this trade area',
    `population_density_per_sq_mile` DECIMAL(18,2) COMMENT 'The population density per sq mile attribute value for this trade area record in the realestate domain',
    `primary_boundary_drive_time_minutes` DECIMAL(18,2) COMMENT 'The primary boundary drive time minutes attribute value for this trade area record in the realestate domain',
    `primary_boundary_geojson` STRING COMMENT 'The primary boundary geojson attribute value for this trade area record in the realestate domain',
    `primary_boundary_radius_miles` DECIMAL(18,2) COMMENT 'The primary boundary radius miles attribute value for this trade area record in the realestate domain',
    `projected_auv` DECIMAL(18,2) COMMENT 'The projected auv attribute value for this trade area record in the realestate domain',
    `projected_cogs_percent` DECIMAL(18,2) COMMENT 'The projected cogs percent attribute value for this trade area record in the realestate domain',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'The projected labor percent attribute value for this trade area record in the realestate domain',
    `residential_population` STRING COMMENT 'The residential population attribute value for this trade area record in the realestate domain',
    `secondary_boundary_drive_time_minutes` DECIMAL(18,2) COMMENT 'The secondary boundary drive time minutes attribute value for this trade area record in the realestate domain',
    `secondary_boundary_geojson` STRING COMMENT 'The secondary boundary geojson attribute value for this trade area record in the realestate domain',
    `secondary_boundary_radius_miles` DECIMAL(18,2) COMMENT 'The secondary boundary radius miles attribute value for this trade area record in the realestate domain',
    `state` STRING COMMENT 'The state attribute value for this trade area record in the realestate domain',
    `trade_area_status` STRING COMMENT 'The current status of the trade area for this trade area',
    `traffic_adt` STRING COMMENT 'The traffic adt attribute value for this trade area record in the realestate domain',
    `traffic_peak_hour` STRING COMMENT 'The traffic peak hour attribute value for this trade area record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this trade area record in the realestate domain',
    `version` STRING COMMENT 'The version attribute value for this trade area record in the realestate domain',
    `zip_code` STRING COMMENT 'A standardized code representing the zip classification for this trade area',
    CONSTRAINT pk_trade_area PRIMARY KEY(`trade_area_id`)
) COMMENT 'Geographic trade area analysis including demographics, competition, and market potential.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` (
    `menu_item_site_offering_id` BIGINT COMMENT 'Unique identifier for the menu item site offering associated with this menu item site offering',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this menu item site offering',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this menu item site offering',
    `availability_channel` STRING COMMENT 'The availability channel attribute value for this menu item site offering record in the realestate domain',
    `availability_reason` STRING COMMENT 'The availability reason attribute value for this menu item site offering record in the realestate domain',
    `availability_status` STRING COMMENT 'The current status of the availability for this menu item site offering',
    `available_from` DATE COMMENT 'The available from attribute value for this menu item site offering record in the realestate domain',
    `available_to` DATE COMMENT 'The available to attribute value for this menu item site offering record in the realestate domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this menu item site offering record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this menu item site offering',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this menu item site offering',
    `discontinue_date` DATE COMMENT 'The date and time when the discontinue event occurred for this menu item site offering',
    `is_available` BOOLEAN COMMENT 'Boolean indicator flag for is available status in this menu item site offering',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this menu item site offering',
    `launch_date` DATE COMMENT 'The date and time when the launch event occurred for this menu item site offering',
    `local_price` DECIMAL(18,2) COMMENT 'The local price attribute value for this menu item site offering record in the realestate domain',
    `lto_end_date` DATE COMMENT 'The date and time when the lto end event occurred for this menu item site offering',
    `lto_start_date` DATE COMMENT 'The date and time when the lto start event occurred for this menu item site offering',
    `offering_end_date` DATE COMMENT 'The date and time when the offering end event occurred for this menu item site offering',
    `offering_start_date` DATE COMMENT 'The date and time when the offering start event occurred for this menu item site offering',
    `offering_status` STRING COMMENT 'The current status of the offering for this menu item site offering',
    `regional_variant_flag` BOOLEAN COMMENT 'Boolean indicator flag for regional variant flag status in this menu item site offering',
    `site_price_override` DECIMAL(18,2) COMMENT 'The site price override attribute value for this menu item site offering record in the realestate domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this menu item site offering record in the realestate domain',
    CONSTRAINT pk_menu_item_site_offering PRIMARY KEY(`menu_item_site_offering_id`)
) COMMENT 'Mapping of menu items available at specific sites with local pricing and availability.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`tenant` (
    `tenant_id` BIGINT COMMENT 'Unique identifier for the tenant associated with this tenant',
    `parent_tenant_id` BIGINT COMMENT 'Unique identifier for the parent tenant associated with this tenant',
    `address_line1` STRING COMMENT 'The address line1 attribute value for this tenant record in the realestate domain',
    `address_line2` STRING COMMENT 'The address line2 attribute value for this tenant record in the realestate domain',
    `annual_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for annual rent in this tenant',
    `city` STRING COMMENT 'The city attribute value for this tenant record in the realestate domain',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this tenant',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this tenant record in the realestate domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this tenant',
    `is_primary_tenant` BOOLEAN COMMENT 'Boolean indicator flag for is primary tenant status in this tenant',
    `lease_end_date` DATE COMMENT 'The date and time when the lease end event occurred for this tenant',
    `lease_start_date` DATE COMMENT 'The date and time when the lease start event occurred for this tenant',
    `legal_name` STRING COMMENT 'The display name or label for the legal in this tenant',
    `tenant_name` STRING COMMENT 'The display name or label for the tenant in this tenant',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this tenant',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this tenant',
    `primary_contact_email` STRING COMMENT 'The primary contact email attribute value for this tenant record in the realestate domain',
    `primary_contact_name` STRING COMMENT 'The display name or label for the primary contact in this tenant',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone attribute value for this tenant record in the realestate domain',
    `square_feet` DECIMAL(18,2) COMMENT 'The square feet attribute value for this tenant record in the realestate domain',
    `state_province` STRING COMMENT 'The state province attribute value for this tenant record in the realestate domain',
    `tenant_status` STRING COMMENT 'The current status of the tenant for this tenant',
    `tenant_type` STRING COMMENT 'The classification type for tenant in this tenant',
    CONSTRAINT pk_tenant PRIMARY KEY(`tenant_id`)
) COMMENT 'Tenant entity representing the occupant of a leased property.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`remodel_project` (
    `remodel_project_id` BIGINT COMMENT '',
    CONSTRAINT pk_remodel_project PRIMARY KEY(`remodel_project_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_trade_area_id` FOREIGN KEY (`trade_area_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`trade_area`(`trade_area_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ADD CONSTRAINT `fk_realestate_cam_reconciliation_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ADD CONSTRAINT `fk_realestate_cam_reconciliation_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`tenant`(`tenant_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ADD CONSTRAINT `fk_realestate_site_selection_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ADD CONSTRAINT `fk_realestate_facility_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`tenant`(`tenant_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ADD CONSTRAINT `fk_realestate_property_acquisition_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ADD CONSTRAINT `fk_realestate_site_permit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ADD CONSTRAINT `fk_realestate_trade_area_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ADD CONSTRAINT `fk_realestate_menu_item_site_offering_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ADD CONSTRAINT `fk_realestate_tenant_parent_tenant_id` FOREIGN KEY (`parent_tenant_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`tenant`(`tenant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`realestate` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`realestate` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `property_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `property_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `architect_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `architect_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lender_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `title_company_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `title_insurance_policy_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `average_income_per_capita` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `median_age` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `median_household_income` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `trade_area_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`remodel_project` SET TAGS ('dbx_data_type' = 'master_data');
